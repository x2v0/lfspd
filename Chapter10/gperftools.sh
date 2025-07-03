#!/bin/bash

git clone https://github.com/gperftools/gperftools
cd gperftools
cmake .
make
make install
cd ..


