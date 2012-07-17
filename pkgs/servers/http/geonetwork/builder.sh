source $stdenv/setup

export LANG="en_US.UTF-8"
export LOCALE_ARCHIVE=$glibcLocales/lib/locale/locale-archive
export M2_REPO=$TMPDIR/repository

# Build using maven.
mkdir -p $TMPDIR
cp -r $src $TMPDIR/src
chmod -R u+w $TMPDIR/src
cd $TMPDIR/src
patch -p0 < $ldapPatch
mvn -debug -Dmaven.repo.local=$M2_REPO install > $TMPDIR/build.log

# Now get rid of bad libs in the lib dir
mkdir -p $TMPDIR/war_edit
cd $TMPDIR/war_edit
jar xf $TMPDIR/$warfile
for badLib in $badLibs ; do 
  rm WEB-INF/lib/$badLib
done
jar cf $TMPDIR/$warfile *

# copy entire repository to $out
mkdir -p $out
cp -r $TMPDIR/repository $out

# Make an executable to run the administrator tool
mkdir -p $out/bin
sed "s#GASTJAR#$out/repository/org/geonetwork-opensource/gast/2.6.4/gast-2.6.4.jar#g" \
   $gastexe > $out/bin/gast
chmod 755 $out/bin/gast
