#!/bin/bash

#testing

export CFLAGS="-O3 -ffast-math -march=native"

#If you wish decently optimized code that is still debuggable (but that optimizations may still make a little hard to debug) you can do:
#export CFLAGS="-O2 -ffast-math -march=native -g -ggdb3"
#If you want a really debuggable piece of code where optimizations mess with little to nothing at all use:
#export CFLAGS="-O -g -ffast-math -march=native -ggdb3"

#PREFIX=/opt/e18

rm -rf ./efl*
rm -rf ./elementary*
rm -rf ./enlightenment*
rm -rf ./evas*
rm -rf ./emotion*
rm -rf ./terminology*
rm -rf ./enventor*

export PKG_CONFIG_PATH=/usr/lib64/pkgconfig

for file in efl-1.22.2; do

    DIR=`echo $file | awk -F "-" '{ print $1;}'`
    echo "Building $DIR"

    `wget -r --no-parent --reject "index.html" -O $file.tar.xz http://download.enlightenment.org/rel/libs/$DIR/$file.tar.xz`
     tar -xvf $file.tar.xz
   cd $file
   ./configure --prefix=/usr --enable-xinput22 --enable-systemd --enable-image-loader-webp --enable-harfbuzz --enable-multisense --enable-liblz4 --enable-fb --disable-tslib --enable-elput --enable-drm
   make
   sudo make install
   cd ..
done

for file in enlightenment-0.22.4; do

    DIR=`echo $file | awk -F "-" '{ print $1;}'`
    echo "Building $DIR"

    `wget -r --no-parent --reject "index.html" -O $file.tar.xz http://download.enlightenment.org/rel/apps/$DIR/$file.tar.xz`
     tar -xvf $file.tar.xz
   cd $file
   ./configure --prefix=/usr --enable-xinput22 --enable-systemd --enable-image-loader-webp --enable-harfbuzz --enable-multisense --enable-liblz4 --enable-fb --disable-tslib --enable-wayland --enable-elput --enable-drm
   make
   sudo make install
   cd ..
done

for file in terminology-1.4.1 rage-0.3.0; do
    DIR=`echo $file | awk -F "-" '{ print $1;}'`
    echo "Building $DIR"

    `wget -r --no-parent --reject "index.html" -O $file.tar.xz http://download.enlightenment.org/rel/apps/$DIR/$file.tar.xz`
     tar -xvf $file.tar.xz
   cd $file
   meson . build
   cd build
   ninja -C build
   sudo ninja -C build install
   cd ..
   cd ..
done

echo "Done..."
