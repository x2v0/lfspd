#!/bin/bash

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr --disable-static

make
make docdir=/usr/share/doc/check-0.15.2 install
