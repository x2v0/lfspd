#!/bin/bash

git clone https://github.com/alisw/hepmc
mkdir hepmc_build

cd hepmc_build

cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -Dmomentum:STRING="MEV" -Dlength:STRING="MM" \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      ../hepmc

make
make install
cd ..


