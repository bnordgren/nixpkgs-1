{stdenv, fetchsvn, jdk, ant, maven2 }:

stdenv.mkDerivation {
  version = "2.6.4" ;
  name = "geonetwork-2.6.4" ;
  buildInputs = [ jdk ant maven2] ; 
  warfile = "repository/org/geonetwork-opensource/geonetwork-main/2.6.4/geonetwork-main-2.6.4.war" ;
  gastexe = ./gast ;
  badLibs = [ "servlet-api-2.5-6.1.14.jar" "xercesImpl-2.7.1.jar" ] ; 
  ldapPatch = ./ldap.patch ; 

  builder = ./builder.sh ; 

  src = fetchsvn {
    url = "https://geonetwork.svn.sourceforge.net/svnroot/geonetwork/tags/2.6.4" ; 
  };

  setupPhase = ''
    runHook preSetupPhase

    mkdir -p $out/nix-support
    export LANG="en_US.UTF-8"
    export LOCALE_ARCHIVE=$glibcLocales/lib/locale/locale-archive
    export M2_REPO=$TMPDIR/repository

    runHook postSetupPhase
  '';

}
