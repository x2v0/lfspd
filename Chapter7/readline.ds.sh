#!/bin/bash

# Exit on error
set -e

# Modify Makefile.in
echo "Modifying Makefile.in..."
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

# Apply patch
echo "Applying patch..."
patch -Np1 -i ../readline-8.2-upstream_fix-1.patch

# Configure the build
echo "Configuring the build..."
./configure \
  --prefix=/usr \
  --disable-static \
  --enable-shared \
  --with-curses

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make install

echo "Installation complete!"
