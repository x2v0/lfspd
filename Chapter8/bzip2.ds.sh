#!/bin/bash

# Set MAKEFLAGS to use all available CPU cores for parallel compilation
export MAKEFLAGS=-j$(nproc)

# Apply the patch
patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch

# Fix paths in the Makefile
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

# Build the shared library
make -f Makefile-libbz2_so
make clean

# Build and install the software
make
make PREFIX=/usr install

# Copy the shared library to /usr/lib and create a symbolic link
cp -av libbz2.so.* /usr/lib
ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so

# Copy the shared bzip2 binary to /usr/bin
cp -v bzip2-shared /usr/bin/bzip2

# Create symbolic links for bzcat and bunzip2
for i in /usr/bin/{bzcat,bunzip2}; do
  ln -sfv bzip2 "$i"
done

# Remove the static library
rm -fv /usr/lib/libbz2.a
