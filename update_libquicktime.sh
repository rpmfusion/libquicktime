git clone https://sergiomb@git.code.sf.net/p/libquicktime/git libquicktime
version=1.2.4
tag=$version
branch=master
pushd libquicktime
git checkout $branch
git pull
#git log $tag..HEAD > ../ChangeLog
newdescrib=$(git describe --tags)
date=$(git log -1 --format=%cd --date=short | tr -d \-)
relversion=$(echo $newdescrib | sed "s/^[^-]*//; s/-/./g; s/\.g/.${date}git/")
githash=$(git rev-parse HEAD)
shorthash=$(echo $githash | cut -b -10)
popd
#git checkout libquicktime.spec
#sed -i "s|^%define vers_string .*|%define vers_string $newdescrib|" libquicktime.spec
sed -i "s|^%define rel_string .*|%define rel_string $relversion|" libquicktime.spec
sed -i "s|^%define githash .*|%define githash $githash|" libquicktime.spec
rpmdev-bumpspec -c "Update to $version$relversion from branch $branch" libquicktime.spec
spectool -g libquicktime.spec
echo Press enter to run: rfpkg new-sources libquicktime-${version}-${githash}.zip; read dummy;
rfpkg new-sources libquicktime-git-${githash}.zip
rfpkg ci -c && git show
echo Press enter to continue; read dummy;
rfpkg push && rfpkg build --nowait
echo Press enter to continue; read dummy;
git checkout f29 && git merge master && git push && rfpkg build --nowait; git checkout master
echo Press enter to continue; read dummy;
git checkout f28 && git merge master && git push && rfpkg build --nowait; git checkout master
echo Press enter to continue; read dummy;
git checkout el7 && git merge master && git push && rfpkg build --nowait; git checkout master
