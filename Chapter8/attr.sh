#!/bin/bash

set -e

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr     \
            --disable-static  \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/attr-2.5.1

make
make install
