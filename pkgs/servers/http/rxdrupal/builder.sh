source $stdenv/setup

# make the destination in the nix store and extract.
mkdir -p $out
cd $out
tar zxf $tarfile

# now move everything up a directory
cd blanksite
mv *  ..
mv .htaccess .. 
rm .gitignore
cd ..
rmdir blanksite

# copy in the templates. The "module" will substitute in values later.
cp $htaccess $out
cp $settings $out
