#!/bin/bash

git clone https://github.com/VcDevel/Vc

cd Vc
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ ..

cmake --build .
cmake --install .

cd ../..
