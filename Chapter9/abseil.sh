#!/bin/bash

# Abseil Common Libraries (C++)                                                                                                                         2
PKG="abseil-cpp"
#PKG_VERSION="2021.9"
#PKG_BUILD="0"
#PKG_FULL="${PKG}-${PKG_VERSION}.${PKG_BUILD}"
#PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://github.com/abseil/abseil-cpp"
#MD5="556576a795bdd2c7d10de6886480065f"
 
git clone ${URL}
cd ${PKG}
cmake -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE="MinSizeRel" -DABSL_PROPAGATE_CXX_STD=ON \
      -DBUILD_SHARED_LIBS=ON .
make
make install
cd ..

