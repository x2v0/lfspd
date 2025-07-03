#!/bin/bash

# Set MAKEFLAGS to use all available CPU cores for parallel compilation
export MAKEFLAGS=-j$(nproc)

# Configure the build with the specified prefix and disable static libraries
./configure --prefix=/usr --disable-static

# Build the software
make

# Install the software and documentation
make docdir=/usr/share/doc/check-0.15.2 install
