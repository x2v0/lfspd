#!/bin/bash

./configure --prefix=/usr \
 --host=$LFS_TGT \
 --build=$(./build-aux/config.guess)

 sed -i -e 's/SUBDIRS = lib src tests doc man po gnulib-tests/SUBDIRS = lib src/g' Makefile
 make
 make DESTDIR=$LFS install
