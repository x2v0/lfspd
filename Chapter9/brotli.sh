#!/bin/bash

# Brotli provides a general-purpose lossless compression algorithm                                                                                      2 # that compresses data using a combination of a modern variant of the LZ77 algorithm,
# Huffman coding and 2nd order context modeling.

PKG="brotli"
PKG_VERSION="1.0"
PKG_BUILD="9"
PKG_FULL=${PKG}-${PKG_VERSION}.${PKG_BUILD}
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://github.com/google/brotli/archive/v${PKG_VERSION}.${PKG_BUILD}/${PKG_FILE}"
MD5="c2274f0c7af8470ad514637c35bcee7d" 

mkdir out
cd    out

cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_BUILD_TYPE="MinSizeRel"   \
      ..
make
make install
cd ..

