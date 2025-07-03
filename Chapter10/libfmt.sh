#!/bin/bash

git clone https://github.com/fmtlib/fmt
cd fmt
cmake -DCMAKE_INSTALL_PREFIX=/usr \
	  -DCMAKE_BUILD_TYPE="MinSizeRel" \
	  -DFMT_DOC=OFF \
	  -DFMT_TEST=OFF \
	  -DBUILD_STATIC_LIBS=OFF \
	  -DBUILD_SHARED_LIBS=ON .
make
make install

cd ..
 
