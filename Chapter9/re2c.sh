#!/bin/bash

URL="https://github.com/skvadrik/re2c"

git clone ${URL}

pushd re2c
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DBUILD_STATIC_LIBS=OFF -DBUILD_SHARED_LIBS=ON .
      
make
make install

popd
