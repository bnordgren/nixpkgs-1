source $stdenv/setup

export LANG="en_US.UTF-8"
export LOCALE_ARCHIVE=$glibcLocales/lib/locale/locale-archive
export M2_REPO=$TMPDIR/repository

mkdir -p $TMPDIR
cd $TMPDIR
unzip $src
cd geoserver-2.1.4
mvn -Dmaven.repo.local=$M2_REPO clean install assembly:attached > $TMPDIR/build.log

mkdir -p $out
cp -r $TMPDIR/repository $out
cp -r $TMPDIR/geoserver-2.1.4/target $out

