#!/bin/bash


git clone https://gitlab.cern.ch/evtgen/evtgen

mkdir evtgen_build
cd evtgen_build

cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
          -DCMAKE_BUILD_TYPE="MinSizeRel" \
          -DEVTGEN_BUILD_DOC:BOOL=OFF \
          -DEVTGEN_BUILD_DOXYGEN:BOOL=OFF \
          -DEVTGEN_BUILD_TESTS:BOOL=OFF \
          -DEVTGEN_PYTHIA:BOOL=ON \
          -DEVTGEN_BUILD_VALIDATIONS:BOOL=OFF \
          ../evtgen

cmake --build . -- install

cd ..