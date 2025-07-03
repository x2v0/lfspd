#!/bin/bash

# The Little Color Management System is a small-footprint                                                                                               2 # color management engine, with special focus on accuracy and performance.                                                                              3 # It uses the International Color Consortium standard (ICC),                                                                                            4 # which is the modern standard for color management.                                                                                                    5                                                                                                                                                         6                                                                                                                                                         7 PKG="lcms2"

PKG_VERSION="2.14"
#PKG_BUILD="1"
PKG_FULL="${PKG}-${PKG_VERSION}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://github.com/mm2/Little-CMS/releases/download/lcms${PKG_VERSION}/${PKG_FILE}"
MD5="7f7baa3e605c961b9301135105ee9a34"        

sed '/BufferSize < TagSize/,+1 s/goto Error/TagSize = BufferSize/' \
    -i src/cmsio0.c

./configure --prefix=/usr/local --disable-static
make
make install

