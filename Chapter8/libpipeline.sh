#!/bin/bash

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr

make && make install
