#!/bin/bash

git clone --branch latest-stable --depth=1 https://github.com/root-project/veccore.git veccore_src
mkdir veccore_build && cd veccore_build

cmake -DCMAKE_CXX_STANDARD="11" -DCMAKE_INSTALL_PREFIX="/usr" \
  -DCMAKE_BUILD_TYPE="MinSizeRel" \
  -DCUDA="OFF" \
  -DUMESIMD="OFF" \
  -DVC="OFF" \
  -DBUILD_DOCS="OFF" \
  -DBUILD_BENCHMARKS="OFF" \
  -DBUILD_TESTING="OFF" \
  -DBUILD_GOOGLETEST="OFF" \
  -DBUILD_GOOGLEBENCH="OFF" \
  -DBUILD_UMESIMD="OFF" \
  -DBUILD_VC="OFF" \
  ../veccore_src

cmake --build . -- install

cd ..
