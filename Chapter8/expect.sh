#!/bin/bash

set -e

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include

make
make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib
