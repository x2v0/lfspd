#!/bin/bash

git clone https://github.com/HDFGroup/hdf5

pushd hdf5
mkdir build
pushd build

cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_BUILD_TYPE="MinSizeRel" -DBUILD_SHARED_LIBS=ON ..
make
make install

popd
popd
