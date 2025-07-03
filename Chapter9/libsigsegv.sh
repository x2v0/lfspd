#!/bin/bash

./configure --prefix=/usr \
  --enable-static=no --enable-shared=yes

make
make install

