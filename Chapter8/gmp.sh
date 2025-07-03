#!/bin/bash

set -e

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.3.0

make
make install
