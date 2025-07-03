#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Configure the software with specific options
./configure --prefix=/usr    \  # Install to /usr
            --enable-cxx     \  # Enable C++ support
            --disable-static \  # Disable building static libraries
            --docdir=/usr/share/doc/gmp-6.3.0  # Set the documentation directory

# Build the software
make

# Install the software
make install
