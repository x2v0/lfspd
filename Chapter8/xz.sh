#!/bin/bash
set -e 

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.4.4

make 
make install
