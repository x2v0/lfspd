#!/bin/bash

PKG="popt"
PKG_VERSION="1.19"
#PKG_BUILD="4"
PKG_FULL=${PKG}-${PKG_VERSION}
PKG_FILE="${PKG_FULL}.tar.gz"
URL="http://ftp.rpm.org/${PKG}/releases/${PKG}-1.x/${PKG_FILE}"
MD5="eaa2135fddb6eb03f2c87ee1823e5a78"

./configure --prefix=/usr/local --disable-static
make
make install

