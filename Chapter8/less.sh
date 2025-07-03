#!/bin/bash

#MAKEFLAGS=-j$(nproc)

./configure --prefix=/usr --sysconfdir=/etc

make && make install
