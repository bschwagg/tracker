cd ..
debuild --no-tgz-check -uc -us
mv -f ../tracker_* dist/deb/
