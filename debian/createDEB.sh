cd ..
debuild clean
debuild --no-tgz-check -uc -us
mv -f ../tracker_* dist/deb/
