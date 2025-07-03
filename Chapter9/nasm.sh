#!/bin/bash

# NASM (Netwide Assembler) is an 80x86 assembler designed 
# for portability and modularity. It includes a
# disassembler as well. 

PKG="nasm"
PKG_VERSION="2.16.01"
PKG_FILE="${PKG}-${PKG_VERSION}.tar.xz"
URL="http://www.nasm.us/pub/${PKG}/releasebuilds/${PKG_VERSION}/${PKG_FILE}"
MD5="d755ba0d16f94616c2907f8cab7c748b" 

 
./configure --prefix=/usr/local

make
make install

