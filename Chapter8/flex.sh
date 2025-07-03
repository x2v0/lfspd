#!/bin/bash

set -e

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr \
            --docdir=/usr/share/doc/flex-2.6.4 \
            --disable-static

make
make install

ln -sv flex   /usr/bin/lex
ln -sv flex.1 /usr/share/man/man1/lex.1
