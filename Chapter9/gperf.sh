#!/bin/bash

# gperf is a perfect hash function generator.                             # For a given list of strings, it produces a hash function and hash table,
# in form of C or C++ code, for looking up a value depending on the input string.
# The hash function is perfect, which means that the hash table has no collisions,
# and the hash table lookup needs a single string comparison only.

PKG="gperf"
PKG_VERSION="3.1"
#PKG_BUILD="5"
PKG_FULL="${PKG}-${PKG_VERSION}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL="http://ftp.gnu.org/pub/gnu/${PKG}/${PKG_FILE}"
MD5=""     

./configure --prefix=/usr/local

make
make install

