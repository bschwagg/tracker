#This is a total hack
mkdir -p ~/rpmbuild/
cd ~/rpmbuild/
mkdir -p BUILD  BUILDROOT  RPMS  SOURCES  SPECS  SRPMS
cd -
rm ~/rpmbuild/SOURCES/*
mkdir -p ~/rpmbuild/SOURCES/tracker-1
cp * ~/rpmbuild/SOURCES/tracker-1
cd ~/rpmbuild/SOURCES/
tar cvf tracker-1.tar tracker-1
cd -
rpmbuild -ba tracker.spec

cp /home/bschwagg/rpmbuild/RPMS/noarch/tracker-1-1.noarch.rpm ../dist/rpm

echo "done"