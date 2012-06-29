{stdenv, fetchsvn, jre, ant, maven2 }:

stdenv.mkDerivation {
  version = "2.6.4" ;
  name = "geonetwork-2.6.4" ;
  buildInputs = [ jre ant maven2] ; 
  warfile = "repository/org/geonetwork-opensource/geonetwork-main/2.6.4/geonetwork-main-2.6.4.war" ;
  gastexe = ./gast ;

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
