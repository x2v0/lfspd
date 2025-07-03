#!/bin/bash

set -e

#MAKEFLAGS=-j$(nproc)

sed -i '/install -m.*STA/d' libcap/Makefile

make prefix=/usr lib=lib

make prefix=/usr lib=lib install
