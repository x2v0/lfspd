#!/bin/bash

# Exit on error
set -e

# Apply patch
echo "Applying patch..."
patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch

# Modify Makefile
echo "Modifying Makefile..."
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

# Build shared library
echo "Building shared library..."
make -f Makefile-libbz2_so

# Clean the build
echo "Cleaning the build..."
make clean

# Build the software
echo "Building the software..."
make

# Install the software
echo "Installing the software..."
make PREFIX=/usr install

# Copy shared library files
echo "Copying shared library files..."
cp -av libbz2.so.* /usr/lib
ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so

# Copy bzip2-shared binary
echo "Copying bzip2-shared binary..."
cp -v bzip2-shared /usr/bin/bzip2

# Create symbolic links
echo "Creating symbolic links..."
for i in /usr/bin/{bzcat,bunzip2}; do
  ln -sfv bzip2 "$i"
done

# Remove static library
echo "Removing static library..."
rm -fv /usr/lib/libbz2.a

echo "Installation complete!"
