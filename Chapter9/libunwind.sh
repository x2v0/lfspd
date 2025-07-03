#!/bin/bash

# The libunwind package contains a portable and efficient                                                                                               2 # C programming interface (API) to determine the call-chain of a program.

PKG="libunwind"
PKG_VERSION="1.6"
PKG_BUILD="2"
PKG_FULL=${PKG}-${PKG_VERSION}.${PKG_BUILD}
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://download.savannah.nongnu.org/releases/${PKG}/${PKG_FILE}"
MD5="f625b6a98ac1976116c71708a73dc44a" 

./configure --prefix=/usr --disable-static
make
make install

