#!/bin/bash

###ubuntu
#apt-get install libpthread-stubs0 libpthread-stubs0-dev zlib-bin zlibc libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev libfribidi-dev libpng12-dev libjpeg-dev libtiff5-dev libgif-dev librsvg2-dev libx11-dev libxext-dev libxrender-dev libxcomposite-dev libxdamage-dev libxfixes-dev libxrandr-dev libxinerama-dev libxss-dev libxp-dev libxcursor-dev libxkbfile-dev libxcb1-dev libxcb-keysyms1-dev libxcb-shape0-dev libssl-dev libcurl4-gnutls-dev libudev-dev libdbus-1-dev libasound2-dev alsa-base libpoppler-dev libraw-dev libspectre-dev libgstreamer0.10-dev libxine2-dev libvlc-dev libvlccore-dev lua5.2 libwebp-dev webp libegl1-mesa-drivers libegl1-mesa-dev libegl1-mesa libgl1-mesa-dev libgl1-mesa-dri libgl1-mesa-glx libglapi-mesa liblua5.1-0-dev doxygen libexif-dev 

##could not find
#apt-get install harfbuzz
#apt-get install opengl2.0
#apt-get install libxtest 
#apt-get install libxdpms
#apt-get install libxprint 

##fedora
yum -y erase freetype-infinality
yum -y install zlib zlib-devel freetype freetype-devel fontconfig fontconfig-devel fribidi fribidi-devel
yum -y install harfbuzz harfbuzz-devel libpng libpng-devel libjpeg-turbo libjpeg-turbo-devel
yum -y install libtiff libtiff-devel librsvg2 librsvg2-devel libX11 libX11-devel libXext libXext-devel
yum -y install libXrender libXrender-devel libXcomposite libXcomposite-devel libXdamage libXdamage-devel
yum -y install libXfixes libXfixes-devel libXrandr libXrandr-devel libXinerama libXinerama-devel
yum -y install libXScrnSaver libXScrnSaver-devel libXp libXp-devel libXcursor libXcursor-devel libxkbfile
yum -y install libxkbfile-devel libxcb libxcb-devel xcb-util-keysyms-devel openssl-devel openssl openssl-libs
yum -y install libcurl libcurl-devel libgudev1 libgudev1-devel alsa-lib alsa-lib-devel LibRaw LibRaw-devel
yum -y install libspectre libspectre-devel gstreamer gstreamer-devel gstreamer-plugins-bad-free-devel
yum -y install gstreamer-plugins-bad-free libXinerama libXinerama-devel lua-devel lua libwebp
yum -y install libwebp-devel xcb-util-keysyms mesa-libGL mesa-libGL-devel giflib giflib-devel libexif libexif-devel
yum -y install pulseaudio-libs-devel libsndfile-devel libsndfile libXtst-devel libgudev1
yum -y install libgudev1-devel libmount-devel dbus-devel bullet bullet-devel gstreamer1-devel
yum -y install luajit luajit-devel gstreamer1-plugins-base-devel gstreamer1-devel vlc vlc-core vlc-devel vlc-extras
yum -y install tslib wget poppler-cpp-devel libspectre-devel LibRaw-devel librsvg2-devel
yum -y install bullet-devel xcb-util-keysyms-devel

##new
yum -y install libXau libXau-devel libXdmcp libXdmcp-devel libXp libXp-devel libXi libXi-devel egl-wayland-devel egl-wayland
yum -y install glx-utils libglvnd-glx egl-utils mesa-libEGL mesa-libEGL-devel libwayland-egl libblkid libblkid-devel
yum -y install systemd-udev systemd-devel libgudev poppler poppler-devel LibRaw-devel libunwind libunwind-devel meson
yum -y install lz4 lz4-devel libinput-devel libxkbcommon-devel mesa-libgbm mesa-libgbm-devel 
yum -y install libwayland-egl.x86_64 libwayland-client libwayland-cursor libwayland-server wayland-devel egl-wayland egl-wayland-devel

