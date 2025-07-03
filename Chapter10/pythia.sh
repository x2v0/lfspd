#!/bin/bash

wget https://pythia.org/download/pythia83/pythia8310.tgz
tar -xzf pythia8310.tgz
cd pythia8310
./configure --prefix=/usr/local
make
make install
cd ..
