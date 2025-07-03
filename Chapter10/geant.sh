#!/bin/bash

XERCESCROOT=/usr

ver="11.2.0"
mkdir tmp
cd tmp
mkdir build

url="https://github.com/Geant4/geant4/archive/refs/tags/v${ver}.tar.gz"
wget ${url}
file=$(basename ${url})

tar -xzf ${file}
cd build

cmake -DGEANT4_INSTALL_DATA="ON" \
      -DGEANT4_USE_GDML="ON" \
      -DGEANT4_BUILD_TLS_MODEL=global-dynamic \
      -DGEANT4_USE_PYTHON=ON \
      -DGEANT4_BUILD_MULTITHREADED=ON \
      -DCMAKE_INSTALL_PREFIX=/usr/local ../geant4-${ver}

make -j $(nproc)
make install
cd ../..
rm -rf /usr/local/Geant4/examples
rm -rf tmp

chmod -R 0444 /usr/local/share/Geant4
