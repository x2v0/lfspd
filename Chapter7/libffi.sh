#!/bin/bash

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr          \
            --disable-static       \
            --with-gcc-arch=native

make && make install
