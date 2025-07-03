#!/bin/bash

git clone https://github.com/google/googletest
cd googletest
mkdir build
cd build 
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON ..
make
make install
cd ../..
rm -rf googletest

