#!/bin/bash

git clone https://github.com/oneapi-src/oneTBB.git
cd oneTBB
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DTBB_TEST=OFF ..
# Build
cmake --build .
# Install
cmake --install .

cd ../..

