#!/bin/bash

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr    \
            --disable-static \
            --enable-shared \
            --enable-libgdbm-compat

make
make install
