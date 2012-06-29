source $stdenv/setup

export LANG="en_US.UTF-8"
export LOCALE_ARCHIVE=$glibcLocales/lib/locale/locale-archive
export M2_REPO=$TMPDIR/repository

mkdir -p $TMPDIR
cp -r $src $TMPDIR/src
chmod -R u+w $TMPDIR/src
cd $TMPDIR/src
mvn -debug -Dmaven.repo.local=$M2_REPO install > $TMPDIR/build.log

mkdir -p $out
cp -r $TMPDIR/repository $out

# Make an executable to run the administrator tool
mkdir -p $out/bin
sed "s#GASTJAR#$out/repository/org/geonetwork-opensource/gast/2.6.4/gast-2.6.4.jar#g" \
   $gastexe > $out/bin/gast
chmod 755 $out/bin/gast
