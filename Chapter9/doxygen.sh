#!/bin/bash

grep -rl '^#!.*python$' | xargs sed -i '1s/python/&3/'

mkdir -v build
pushd    build

cmake -G "Unix Makefiles"               \
      -DCMAKE_BUILD_TYPE="MinSizeRel"     \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -Dbuild_doc=OFF \
      -Duse_libclang=OFF \
      -Duse_sys_spdlog=OFF \
      -Dbuild_wizard=OFF \
      -Dbuild_app=OFF \
      -Wno-dev .. 

make
make install

popd
