#!/bin/bash

set -e 

#MAKEFLAGS=-j$(nproc)

CC=gcc ./configure --prefix=/usr -G -O3 -r

make
make install
