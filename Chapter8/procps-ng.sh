#!/bin/bash

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr                           \
            --docdir=/usr/share/doc/procps-ng-4.0.3 \
            --disable-static                        \
            --disable-kill 							\
            --without-ncurses

make
make install
