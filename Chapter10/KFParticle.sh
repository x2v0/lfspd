#!/bin/bash

git clone https://github.com/sPHENIX-Collaboration/KFParticle
cd KFParticle
mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ ..

cmake --build .
cmake --install .

cd ../..
