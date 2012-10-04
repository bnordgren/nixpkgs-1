{stdenv, fetchurl, supportScp ? true, supportSftp ? true, supportRsync ? false,
 openssh ? null, rsync ? null, ...}:

assert (supportScp || supportSftp) -> (openssh != null) ; 
assert (supportRsync) -> (rsync != null) ; 

stdenv.mkDerivation rec {
  name = "rssh-2.3.3";

  patches = [] ++ stdenv.lib.optional supportRsync patchSrcs ;

  src = fetchurl {
    url = "mirror://sourceforge/rssh/rssh/2.3.3/rssh-2.3.3.tar.gz";
    sha256 = "0zyhdzx04468gaxxw1cqm390gipb5ayhdpk18hg57y454hn92h0r";
  };

  #
  # rssh is known to reject rsync protocol 3.0 due to the fact that 
  # protocol 3.0 overloads the -e option, which could allow the execution
  # of arbitrary commands.
  # 
  # This is the minimum set of patches necessary to cleanly apply debian's 
  # solution to this problem. Upstream has declared that rssh is in maintainence
  # mode: only security fixes will make it into releases...and releases will
  # be few and far between.
  #
  patchSrcs = [ 
    (fetchurl {
      url =  http://patch-tracker.debian.org/patch/series/dl/rssh/2.3.3-5/fixes/command-line-checking.diff;
      sha256 = "1bv7dbhspqd3fxljhzp3qfzhmasrwlhyrchx8irvmpqhnjfrldbr";
    })
    (fetchurl{
      url =  http://patch-tracker.debian.org/patch/series/dl/rssh/2.3.3-5/fixes/rsync-protocol.diff;
      sha256 = "0v37v66pszkkviaarr7n6h2x4k69a45gpsl1dmcq3p8lc3xs5mb8";
    })
  ];



  configureFlags = [
    (stdenv.lib.optionalString supportScp "--with-scp=${openssh}/bin/scp")
    (stdenv.lib.optionalString supportSftp "--with-sftp-server=${openssh}/libexec/sftp-server")
    (stdenv.lib.optionalString supportRsync "--with-rsync=${rsync}/bin/rsync")
  ];
  
  postInstall = ''
    rm $out/etc/rssh.conf
    echo "logfacility=LOG_USER" > $out/etc/rssh.conf
    echo "umask=022" >> $out/etc/rssh.conf
    ${stdenv.lib.optionalString supportScp ''echo "allowscp" >> $out/etc/rssh.conf''}
    ${stdenv.lib.optionalString supportSftp ''echo "allowsftp" >> $out/etc/rssh.conf''}
    ${stdenv.lib.optionalString supportRsync ''echo "allowrsync" >> $out/etc/rssh.conf''}
  '';

  meta = {
    homepage = http://www.pizzashack.org/rssh/ ;
    description = "A restricted shell for use with OpenSSH, allowing only scp and/or sftp.";
  };
}
