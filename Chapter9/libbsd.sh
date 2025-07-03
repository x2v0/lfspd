#!/bin/bash

# This library provides useful functions commonly found on BSD systems,
# projects with strong BSD origins, without needing to embed the same code
# over and over again on each project.

PKG="libbsd"
PKG_VERSION="0.11"
PKG_BUILD="7"
PKG_FULL="${PKG}-${PKG_VERSION}.${PKG_BUILD}"
PKG_FILE="${PKG_FULL}.tar.xz"
URL="https://libbsd.freedesktop.org/releases/${PKG_FILE}"
MD5="" 

./configure --prefix=/usr \
  --enable-static=no --enable-shared=yes

make
make install

