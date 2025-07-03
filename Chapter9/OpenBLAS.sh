#!/bin/bash

# OpenBLAS is an optimized BLAS library based on GotoBLAS2 1.13 BSD version.                                                                            2

PKG="OpenBLAS"
PKG_VERSION="0.3"
PKG_BUILD="25"
#PKG_FULL="${PKG}-${PKG_VERSION}.${PKG_BUILD}"
#PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://github.com/OpenMathLib/${PKG}"
#MD5=""

git clone ${URL}
pushd ${PKG}
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DBUILD_STATIC_LIBS=OFF -DBUILD_SHARED_LIBS=ON .

make
make install

popd
