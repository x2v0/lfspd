#!/bin/bash

 # The libmng libraries are used by programs wanting to 
 # read and write Multiple-image Network Graphics (MNG) files
 # which are the animation equivalents to PNG files. 

PKG="libmng"
PKG_VERSION="2.0"
PKG_BUILD="3"
PKG_FULL="${PKG}-${PKG_VERSION}.${PKG_BUILD}"
PKG_FILE="${PKG_FULL}.tar.xz"
URL="https://downloads.sourceforge.net/${PKG}/${PKG_FILE}"
MD5="e9e899adb1b681b17f14d91e261878c5"

./configure --prefix=/usr/local --disable-static
make
make install

