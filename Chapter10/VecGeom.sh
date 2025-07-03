#!/bin/bash

XERCESCROOT=/usr

git clone https://gitlab.cern.ch/VecGeom/VecGeom
cd VecGeom

mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX="/usr" \
    -DBUILD_TESTING="OFF" \
    -DVECGEOM_GDML="ON" \
    -DVECGEOM_BUILTIN_VECCORE="ON" \
    -DBUILD_SHARED_LIBS="ON" \
    -DBUILD_STATIC_LIBS="OFF" \
	-DCMAKE_BUILD_TYPE="MinSizeRel"

make install

cd ../..
