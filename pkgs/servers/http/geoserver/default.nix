{stdenv, fetchurl, unzip }:

stdenv.mkDerivation {
  version = "2.1.4" ;
  name = "geoserver-2.1.4" ;
  description = "GeoServer is a Java-based software server that allows users to view and edit geospatial data" ;
  buildInputs = [ unzip ] ; 
  warfile = "geoserver.war" ;

  builder = ./builder.sh ; 

  src = fetchurl {
    url = "mirror://sourceforge/geoserver/2.1.4/geoserver-2.1.4-war.zip" ; 
    sha256 = "10xb7d6l6w8prl1kf2nbyfn3s267gzr74al2gq3b75165civz22j" ;
  };


}
