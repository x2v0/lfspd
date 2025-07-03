#!/bin/bash

git clone https://github.com/key4hep/EDM4hep
cd EDM4hep

cmake -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DBUILD_TESTING:BOOL=OFF \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DUSE_EXTERNAL_CATCH2=/usr/lib .

source /usr/local/bin/thisroot.sh
make
make install

cd ..
