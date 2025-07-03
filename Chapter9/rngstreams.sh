#!/bin/bash

# Multiple independent streams of pseudo-random numbers.

./configure --prefix=/usr/local \
            --enable-shared=yes \
            --enable-static=no
make
make install

