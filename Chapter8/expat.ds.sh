#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Configure the software with specific options
./configure --prefix=/usr    \  # Install to /usr
            --disable-static \  # Disable building static libraries
            --enable-shared     # Enable building shared libraries

# Build the software
make

# Install the software
make install
