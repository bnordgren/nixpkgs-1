{stdenv, php}:

stdenv.mkDerivation {
  version = "7.16" ;
  name = "rxdrupal-7.16" ;
  description = "A preconfigured Drupal 7.16 website set up for the RxCadre project." ;

  settings= ./settings.php-template ;
  htaccess= ./htaccess-template;
  builder = ./builder.sh ; 
  tarfile = ./BlankSite.tar.gz ;

}
