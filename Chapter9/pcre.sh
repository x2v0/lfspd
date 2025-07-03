#!/bin/bash


./configure --prefix=/usr                     \
            --docdir=/usr/share/doc/pcre-8.45 \
            --enable-unicode-properties       \
            --enable-pcre16                   \
            --enable-pcre32                   \
            --enable-pcregrep-libz            \
            --enable-pcregrep-libbz2          \
            --disable-static \
            --enable-shared

make
make install
