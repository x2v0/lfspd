#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Fix a syntax issue in the `intltool-update.in` file
# Replace `:\${` with `:\$\{` to ensure proper escaping
sed -i 's:\\\${:\\\$\\{:' intltool-update.in

# Configure the software with specific options
./configure --prefix=/usr  # Install to /usr

# Build and install the software
# Use `&&` to ensure `make install` only runs if `make` succeeds
make && make install
