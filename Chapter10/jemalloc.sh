#!/bin/bash

git clone https://github.com/jemalloc/jemalloc

cd jemalloc

./autogen.sh
./configure
make
make install

cd ..
