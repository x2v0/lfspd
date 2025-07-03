#!/bin/bash

set -e 

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.3.1

make
make install
