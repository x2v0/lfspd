#!/bin/bash

./configure --prefix=/usr/local \
  --enable-static=no --enable-shared=yes

make
make install
