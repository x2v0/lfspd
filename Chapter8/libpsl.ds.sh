#!/bin/bash

# Exit immediately if any command fails
set -e

# Create and enter the build directory
mkdir -v build &&
cd build

# Configure the build with meson
meson setup --prefix=/usr \  # Install to /usr
            --buildtype=release  # Set the build type to release (optimized)

# Build the software with ninja
ninja

# Install the software with ninja
ninja install
