#!/bin/bash

URL="https://github.com/google/re2"

git clone ${URL}

pushd re2
cmake -DCMAKE_INSTALL_PREFIX=/usr \
	  -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DBUILD_SHARED_LIBS:BOOL=ON \
      -DRE2_BUILD_TESTING:BOOL=OFF .
make
make install

popd

