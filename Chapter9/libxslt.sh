#!/bin/bash

./configure --prefix=/usr                         \
            --disable-static                      \
            --docdir=/usr/share/doc/libxslt-1.1.39 \
            PYTHON=/usr/bin/python3
make
make install

