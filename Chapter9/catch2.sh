#!/bin/bash

git clone https://github.com/catchorg/Catch2.git

pushd Catch2
cmake -Bbuild -H. \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DCMAKE_BUILD_TYPE="MinSizeRel" \
  -DBUILD_TESTING=OFF \
  -DCATCH_INSTALL_DOCS=OFF \
  -DCATCH_DEVELOPMENT_BUILD=OFF \
  -DCATCH_INSTALL_EXTRAS=OFF \
  -DCATCH_BUILD_EXAMPLES=OFF \
  -DCATCH_BUILD_EXTRA_TESTS=OFF \
  -DCATCH_BUILD_FUZZERS=OFF

cmake --build build/ --target install

popd
