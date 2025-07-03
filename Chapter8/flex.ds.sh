#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Configure the software with specific options
./configure --prefix=/usr \  # Install to /usr
            --docdir=/usr/share/doc/flex-2.6.4 \  # Set the documentation directory
            --disable-static  # Disable building static libraries

# Build the software
make

# Install the software
make install

# Create symbolic links for compatibility
ln -svf flex /usr/bin/lex
ln -svf flex.1 /usr/share/man/man1/lex.1
