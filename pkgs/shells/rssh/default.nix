{stdenv, fetchurl, supportScp ? true, supportSftp ? true, supportRsync ? false,
 openssh ? null, rsync ? null, ...}:

assert (supportScp || supportSftp) -> (openssh != null) ; 
assert (supportRsync) -> (rsync != null) ; 

stdenv.mkDerivation rec {
  name = "rssh-2.3.3";

  patches = [] ++ stdenv.lib.optional supportRsync patchSrc ;

  src = fetchurl {
    url = "mirror://sourceforge/rssh/rssh/2.3.3/rssh-2.3.3.tar.gz";
    sha256 = "0zyhdzx04468gaxxw1cqm390gipb5ayhdpk18hg57y454hn92h0r";
  };

  patchSrc =  fetchurl {
    url =  http://patch-tracker.debian.org/patch/series/dl/rssh/2.3.3-5/fixes/command-line-checking.diff;
    sha256 = "1bv7dbhspqd3fxljhzp3qfzhmasrwlhyrchx8irvmpqhnjfrldbr";
  };



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
