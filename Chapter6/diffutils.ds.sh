#!/bin/bash

# Exit on error
set -e

# Configure the build
echo "Configuring the build..."
./configure \
  --prefix=/usr \
  --host=$LFS_TGT \
  --build=$(./build-aux/config.guess)

# Modify Makefile to exclude unnecessary directories
echo "Modifying Makefile..."
sed -i -e 's/SUBDIRS = lib src tests doc man po gnulib-tests/SUBDIRS = lib src/g' Makefile

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make DESTDIR=$LFS install

echo "Installation complete!"
