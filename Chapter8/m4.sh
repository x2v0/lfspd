#!/bin/bash

set -e

#MAKEFLAGS=-j$(nproc)

CFLAGS=-Wno-error ./configure --prefix=/usr

make
make install
