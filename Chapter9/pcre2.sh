#!/bin/bash

./configure --prefix=/usr                       \
            --docdir=/usr/share/doc/pcre2-10.42 \
            --enable-unicode                    \
            --enable-jit                        \
            --enable-pcre2-16                   \
            --enable-pcre2-32                   \
            --enable-pcre2grep-libz             \
            --enable-pcre2grep-libbz2           \
            --disable-static \
            --enable-shared

make
make install
