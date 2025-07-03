#!/bin/bash

./configure --prefix=/usr --disable-static --disable-doc

make
make install
