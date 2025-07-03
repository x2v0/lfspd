#!/bin/bash

git clone https://github.com/dpiparo/vdt.git

pushd vdt
cmake -DCMAKE_INSTALL_PREFIX=/usr/local
make
make install

popd
