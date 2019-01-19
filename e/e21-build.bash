#!/bin/bash

#PREFIX=/opt/e18

rm -rf ./efl*
rm -rf ./elementary*
rm -rf ./enlightenment*
rm -rf ./evas*
rm -rf ./emotion*
rm -rf ./terminology*
rm -rf ./enventor*

export PKG_CONFIG_PATH=/usr/lib64/pkgconfig

for file in efl-1.21.1; do

    DIR=`echo $file | awk -F "-" '{ print $1;}'`
    echo "Building $DIR"

    `wget -r --no-parent --reject "index.html" -O $file.tar.xz http://download.enlightenment.org/rel/libs/$DIR/$file.tar.xz`
     tar -xvf $file.tar.xz
   cd $file
   make clean
   ./configure --prefix=/usr --enable-systemd
   make
   sudo make install
   cd ..
done

for file in enlightenment-0.22.4 terminology-1.3.2 rage-0.3.0; do

    DIR=`echo $file | awk -F "-" '{ print $1;}'`
    echo "Building $DIR"

    `wget -r --no-parent --reject "index.html" -O $file.tar.xz http://download.enlightenment.org/rel/apps/$DIR/$file.tar.xz`
     tar -xvf $file.tar.xz
   cd $file
   make clean
   ./configure --prefix=/usr --enable-systemd
   make
   sudo make install
   cd ..
done

echo "Done..."
