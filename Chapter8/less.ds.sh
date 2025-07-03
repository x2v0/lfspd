#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Configure the software with specific options
./configure --prefix=/usr \  # Install to /usr
            --sysconfdir=/etc  # Set the configuration directory to /etc

# Build and install the software
# Use `&&` to ensure `make install` only runs if `make` succeeds
make && make install
