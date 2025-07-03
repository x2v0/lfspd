#!/bin/bash

# JSON for Modern C++   

PKG="json"
PKG_VERSION="3.11"
PKG_BUILD="2"
#PKG_FULL="${PKG}-${PKG_VERSION}.${PKG_BUILD}"
#PKG_FILE="${PKG_FULL}.tar.bz2"
URL="https://github.com/nlohmann/${PKG}"
#MD5="b8b89b327732c12191306c3d31cfd4b1"  

git clone ${URL}
pushd ${PKG}
mkdir build
cd build
cmake -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/usr/local ..
make
make install

popd
