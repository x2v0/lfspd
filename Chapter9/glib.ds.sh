#!/bin/bash

# Create a build directory and navigate into it
mkdir -p build
cd build

# Set up the build configuration with Meson
meson setup ..            \
      --prefix=/usr       \
      --buildtype=release

# Build the project using Ninja
ninja

# Install the built files (with sudo for necessary permissions)
sudo ninja install

# Navigate back to the original directory
cd ..
