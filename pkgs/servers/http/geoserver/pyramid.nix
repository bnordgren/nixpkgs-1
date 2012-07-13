{stdenv, fetchurl, unzip }:

stdenv.mkDerivation {
  version = "2.1.4" ;
  name = "geoserver-pyramid-2.1.4" ;
  description = "Image Pyramid plugin for geoserver" ;
  buildInputs = [ unzip ] ; 

  # It is unclear to me why upstream has a different version number on the 
  # jarfile inside the archive, but they do. 
  jarfile = "gt-imagepyramid-2.7.5.jar" ;

  builder = ./builder-unzip.sh ; 


  src = fetchurl {
    url = "mirror://sourceforge/geoserver/GeoServer%20Extensions/2.1.4/geoserver-2.1.4-pyramid-plugin.zip" ; 
    sha256 = "0yk18pgrjlbv1llq75gwc25fpp4qk2cj1ig8g12j3slfwvzdz54j" ;
  };


}
