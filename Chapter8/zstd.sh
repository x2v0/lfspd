#!/bin/bash
set -e

#MAKEFLAGS=-j$(nproc)

make prefix=/usr
make prefix=/usr install

rm -v /usr/lib/libzstd.a
