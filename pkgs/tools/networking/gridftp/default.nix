{ stdenv, fetchurl, openssl, openssh, perl, libtool, zlib }:

stdenv.mkDerivation rec {
  name = "gridftp-5.2.2";
  
  src = fetchurl {
    url = http://www.globus.org/ftppub/gt5/5.2/5.2.2/installers/src/gt5.2.2-all-source-installer.tar.gz ;
    sha256 = "184m8wwr15xh4zx2q06cb47jss9l4ngzrnnnay9fcygdlcvi4z0f";
  };

  buildInputs = [ perl libtool openssl openssh zlib ] ; 


  meta = {
    description = "GridFTP Lite Tools";

    homepage = http://www.globus.org/toolkit/data/gridftp/;
    license = http://www.globus.org/toolkit/docs/5.2/5.2.1/licenses/ ;
  };
}
