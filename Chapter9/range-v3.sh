#!/bin/bash

git clone https://github.com/ericniebler/range-v3

pushd range-v3
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DBUILD_SHARED_LIBS=ON \
      -DRANGE_V3_DOCS=OFF \
      -DRANGE_V3_EXAMPLES=OFF \
      -DRANGES_BUILD_CALENDAR_EXAMPLE=OFF \
      -DRANGE_V3_TESTS=OFF \
      -DRANGES_DEBUG_INFO=OFF .
make
make install

popd
