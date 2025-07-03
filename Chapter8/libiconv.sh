#!/bin/bash

# This library provides an iconv() implementation,                                                                                                      2 # for use on systems which don't have one,
# or whose implementation cannot convert from/to Unicode.

PKG="libiconv"
PKG_VERSION="1.17"
#PKG_BUILD=""
PKG_FULL="${PKG}-${PKG_VERSION}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL=" https://ftp.gnu.org/pub/gnu/${PKG}/${PKG_FILE}"
#MD5=""

./configure --prefix=/usr
make
make install

