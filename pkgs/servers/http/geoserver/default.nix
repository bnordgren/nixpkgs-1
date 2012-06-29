{stdenv, fetchurl, unzip, jdk, ant, maven2 }:

stdenv.mkDerivation {
  version = "2.1.4" ;
  name = "geonetwork-2.1.4" ;
  buildInputs = [ unzip jdk ant maven2] ; 
#  warfile = "repository/org/geonetwork-opensource/geonetwork-main/2.6.4/geonetwork-main-2.6.4.war" ;

  builder = ./builder.sh ; 

  src = fetchurl {
    url = "mirror://sourceforge/geoserver/2.1.4/geoserver-2.1.4-src.zip" ; 
    sha256 = "0bh6db1dwsyqxg57wn058jrmi2vpdpk276fyd8ssslk794m22ydy" ; 
  };


}
