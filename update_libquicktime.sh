git clone git://github.com/sergiomb2/libquicktime.git
version=1.2.4
tag=$version
branch=master
pushd libquicktime
git checkout $branch
git pull
git log $tag..HEAD > ../ChangeLog
newdescrib=$(git describe --tags)
date=$(git log -1 --format=%cd --date=short | tr -d \-)
relversion=$(echo $newdescrib | sed "s/^[^-]*//; s/-/./g; s/^/.$date/")
githash=$(git rev-parse HEAD)
shorthash=$(echo $githash | cut -b -10)
popd
#git checkout libquicktime.spec
sed -i "s|^%define vers_string .*|%define vers_string $newdescrib|" libquicktime.spec
sed -i "s|^%define rel_string .*|%define rel_string $relversion|" libquicktime.spec
sed -i "s|^%define githash .*|%define githash $githash|" libquicktime.spec
rpmdev-bumpspec -c "Update to $newdescrib from branch $branch" libquicktime.spec
spectool -g libquicktime.spec
echo Press enter to run: rfpkg new-sources libquicktime-${version}-${githash}.zip; read dummy;
rfpkg new-sources libquicktime-git-${githash}.zip
echo Press enter to continue; read dummy;
rfpkg ci -c && git show
echo Press enter to continue; read dummy;
rfpkg push && rfpkg build --nowait
echo Press enter to continue; read dummy;
git checkout f27 && git merge master && git push && rfpkg build --nowait; git checkout master
echo Press enter to continue; read dummy;
git checkout f26 && git merge master && git push && rfpkg build --nowait; git checkout master
echo Press enter to continue; read dummy;
git checkout el7 && git merge master && git push && rfpkg build --nowait; git checkout master
