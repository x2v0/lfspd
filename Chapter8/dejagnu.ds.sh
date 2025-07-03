#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel build (commented out by default)
# MAKEFLAGS=-j$(nproc)

# Create and enter the build directory
mkdir -v build
cd build

# Configure the software with the installation prefix set to /usr
../configure --prefix=/usr

# Generate HTML and plaintext documentation from the Texinfo source
makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi

# Build and install the software
make install

# Create the documentation directory and install the generated documentation
install -v -dm755  /usr/share/doc/dejagnu-1.6.3
install -v -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3
