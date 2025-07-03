#!/bin/bash

# Exit immediately if any command fails
set -e

# Optionally enable parallel builds using all available CPU cores
# Uncomment the following line to enable parallel builds
# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# Remove the line that installs static libraries from the Makefile
sed -i '/install -m.*STA/d' libcap/Makefile

# Build the software with specific options
make prefix=/usr lib=lib

# Install the software with specific options
make prefix=/usr lib=lib install
