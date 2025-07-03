#!/bin/bash

# This is an autotool- and libtoolized port of the NetBSD Editline library (libedit).                                                                   2 # This Berkeley-style licensed command line editor library provides generic line editing, 
# history, and tokenization functions, similar to those found in GNU Readline.


PKG="libedit"
PKG_VERSION="3.1"
PKG_BUILD="20230828"
PKG_FULL=${PKG}-${PKG_BUILD}-${PKG_VERSION}
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://www.thrysoee.dk/${PKG_FILE}"
#MD5="6c7fe9dbb80c89c3579bedad9722e559"   

./configure --prefix=/usr --disable-static
make
make install

