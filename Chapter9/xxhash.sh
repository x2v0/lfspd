#!/bin/bash

git clone https://github.com/Cyan4973/xxHash

pushd xxHash
      
make
make install

popd
