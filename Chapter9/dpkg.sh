#!/bin/bash

./configure --prefix=/usr/local \
    --disable-start-stop-daemon \
    --disable-nls \
    --disable-rpath \
    --disable-update-alternatives \
    --disable-dselect

make
make install

