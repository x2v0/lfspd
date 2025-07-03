#!/bin/bash

# CLHEP is a C++ Class Library for High Energy Physics.                                                                                                 2

pushd CLHEP
sed -i 's/clhep_ensure/#clhep_ensure/' CMakeLists.txt
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
	-DCMAKE_BUILD_TYPE="MinSizeRel" \
	-DCLHEP_BUILD_DOCS=OFF .

make
make install

popd
