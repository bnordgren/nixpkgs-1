source $stdenv/setup

export LANG="en_US.UTF-8"
export LOCALE_ARCHIVE=$glibcLocales/lib/locale/locale-archive
export M2_REPO=$TMPDIR/repository

#mkdir -p $TMPDIR
#cd $TMPDIR
#unzip $src
#cd geoserver-2.1.4
#mvn -Dmaven.repo.local=$M2_REPO clean install assembly:attached > $TMPDIR/build.log

mkdir -p $TMPDIR
cd $TMPDIR
unzip $src
mkdir $TMPDIR/tmp
cd $TMPDIR/tmp
$jdk/bin/jar xf $TMPDIR/$warfile
for badLib in $badLibs ; do 
  rm WEB-INF/lib/$badLib
done
$jdk/bin/jar cf $TMPDIR/$warfile *

mkdir -p $out
mv $TMPDIR/$warfile $out

#mkdir -p $out
#cd $out
#unzip $src
#cp -r $TMPDIR/repository $out
#cp -r $TMPDIR/geoserver-2.1.4/target $out

