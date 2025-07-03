#!/bin/bash

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr                \
            --disable-debuginfod         \
            --enable-libdebuginfod=dummy

make

make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a
