#!/bin/bash

#Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms.

PKG="eigen"
PKG_VERSION="3.4"
PKG_BUILD="0"
PKG_FULL=${PKG}-${PKG_VERSION}.${PKG_BUILD}
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://gitlab.com/lib${PKG}/${PKG}/-/archive/${PKG_VERSION}.${PKG_BUILD}/${PKG_FILE}"
#MD5="36aee97e67f64dbdab7afae197e3483b" 
 
git clone https://gitlab.com/libeigen/eigen.git
cd eigen
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
make install
mv /usr/local/include/Eigen /usr/local/include/eigen3
cd ../..
rm -rf eigen

