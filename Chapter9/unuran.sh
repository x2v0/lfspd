#!/bin/bash

./configure --prefix=/usr/local   \
            --enable-shared=yes   \
            --with-urng-default
make
make install

