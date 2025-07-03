#!/bin/bash

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr    \
            --disable-static \
            --enable-shared

make
make install
