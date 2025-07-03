#!/bin/bash

./configure --prefix=/usr \
            --enable-mt   \
            --with-rmt=/usr/libexec/rmt 

make
make install
