{stdenv, php}:

stdenv.mkDerivation {
  version = "7.15" ;
  name = "rxdrupal-7.15" ;
  description = "A preconfigured Drupal 7.15 website set up for the RxCadre project." ;

  settings= ./settings.php-template ;
  htaccess= ./htaccess-template;
  builder = ./builder.sh ; 
  tarfile = ./BlankSite.tar.gz ;

}
