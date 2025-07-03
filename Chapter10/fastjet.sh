#!/bin/bash

wget https://fastjet.fr/repo/fastjet-3.4.2.tar.gz
tar -xzf fastjet-3.4.2.tar.gz
cd fastjet-3.4.2
./configure --prefix=/usr/local
make
make install

cd ..
