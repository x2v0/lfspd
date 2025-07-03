#!/bin/bash

# GDB, the GNU Project debugger, allows you to see what is going on ?inside? another program  
# while it executes -- or what another program was doing at the moment it crashed.

PKG="gdb"
PKG_VERSION="13.2"
#PKG_BUILD="1"
PKG_FULL=${PKG}-${PKG_VERSION}
PKG_FILE="${PKG_FULL}.tar.xz"
URL="https://ftp.gnu.org/gnu/${PKG}/${PKG_FILE}"
MD5="fbd3cdae16c581e8a742cb766ba35076"


mkdir build
pushd build

ARGS=" --prefix=/usr/local "
#RGS=$ARGS" --enable-targets=$TARGETS
ARGS=$ARGS" --disable-shared"
ARGS=$ARGS" --disable-werror"
ARGS=$ARGS" --disable-nls"
ARGS=$ARGS" --disable-docs"
ARGS=$ARGS" --with-expat"
ARGS=$ARGS" --without-mpc"
ARGS=$ARGS" --without-mpfr"
ARGS=$ARGS" --without-gmp"
ARGS=$ARGS" --without-cloog"
ARGS=$ARGS" --without-isl"
ARGS=$ARGS" --disable-sim"
ARGS=$ARGS" --enable-gdbserver=no"
      
../configure --with-python=/usr/bin/python3 $ARGS

make
make install

popd
