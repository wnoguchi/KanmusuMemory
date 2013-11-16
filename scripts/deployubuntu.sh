#!/bin/bash

APPNAME=KanmusuMemory
TMPPATH=tmp

#clean
rm -rf ${APPNAME}
rm ${APPNAME}-0.0-ubuntu-x86.zip
rm -rf kanmusumemory

#build and deploy
perl scripts/deploy.pl ubuntu64

#rename dir
rm ${APPNAME}
mv ${TMPPATH} ${APPNAME}

#archive
zip -ry ${APPNAME}-0.0-ubuntu-x86.zip ${APPNAME}

#make deb package
mkdir kanmusumemory
cp -a scripts/deb/DEBIAN kanmusumemory/
cp Readme.txt kanmusumemory/
mkdir kanmusumemory/usr
cp -a scripts/deb/share kanmusumemory/usr/
mkdir -p kanmusumemory/usr/local/bin/kanmusumemory
mkdir -p kanmusumemory/usr/local/lib/kanmusumemory
cp -a ${APPNAME}/bin/* kanmusumemory/usr/local/bin/kanmusumemory/
cp -a ${APPNAME}/lib/* kanmusumemory/usr/local/lib/kanmusumemory/
cp -a scripts/deb/KanmusuMemory kanmusumemory/usr/local/bin/
rm kanmusumemory/usr/local/bin/kanmusumemory/KanmusuMemory.sh
cp -a scripts/deb/Desktop_KanmusuMemory.sh kanmusumemory/usr/local/bin/kanmusumemory/
du -s kanmusumemory| cut -f 1| xargs echo Installed-Size: >> kanmusumemory/DEBIAN/control
dpkg-deb -b kanmusumemory


