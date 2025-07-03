#!/bin/bash

# Exit on error
set -e

# Fix ltmain.sh
echo "Fixing ltmain.sh..."
sed '6009s/$add_dir//' -i ltmain.sh

# Create build directory
echo "Creating build directory..."
mkdir -v build
cd build

# Configure the build
echo "Configuring the build..."
../configure \
  --prefix=/usr \
  --build=$(../config.guess) \
  --host=$LFS_TGT \
  --disable-nls \
  --enable-shared \
  --enable-gprofng=no \
  --disable-werror \
  --enable-64-bit-bfd

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make DESTDIR=$LFS install

# Remove unnecessary static libraries and .la files
echo "Removing unnecessary static libraries and .la files..."
rm -v "$LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}"

echo "Installation complete!"
