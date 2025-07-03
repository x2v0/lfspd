#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Configure the software with specific options
./configure --prefix=/usr                \  # Install to /usr
            --disable-debuginfod         \  # Disable debuginfod support
            --enable-libdebuginfod=dummy    # Enable a dummy libdebuginfod implementation

# Build the software
make

# Install the libelf library
make -C libelf install

# Install the libelf pkg-config file
install -vm644 config/libelf.pc /usr/lib/pkgconfig

# Remove the static library to ensure only shared libraries are used
rm -f /usr/lib/libelf.a
