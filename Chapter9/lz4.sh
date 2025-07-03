#!/bin/bash

PKG="lz4"
PKG_VERSION="1.9"
PKG_BUILD="5"
URL="https://github.com/${PKG}/${PKG}"

git clone ${URL}
pushd ${PKG}
      
make
make install

popd
