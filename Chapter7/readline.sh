#!/bin/bash
set -e

#MAKEFLAGS=-j$(nproc)

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

patch -Np1 -i ../readline-8.2-upstream_fix-1.patch

./configure --prefix=/usr    \
            --disable-static \
            --enable-shared \
            --with-curses

make

make install

