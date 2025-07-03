#!/bin/bash

# The Guidelines Support Library (GSL) contains functions and
# types that are suggested for use by the C++ Core Guidelines maintained
# by the Standard C++ Foundation.

git clone https://github.com/microsoft/GSL
cd GSL
mkdir build
cd build 
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DGSL_TEST=OFF ..
make install
cd ../..
rm -rf GSL

