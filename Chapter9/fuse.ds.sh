#!/bin/bash

# Comment out lines starting from 'udev' to the end of the file in util/meson.build
sed -i '/^udev/,$ s/^/#/' util/meson.build

# Create a build directory and navigate into it
mkdir -p build
cd build

# Set up the build configuration with Meson
meson setup --prefix=/usr --buildtype=release ..

# Build the project using Ninja
ninja

# Install the built files
sudo ninja install

# Set the setuid bit on fusermount3 for security purposes
sudo chmod u+s /usr/bin/fusermount3

# Navigate back to the original directory
cd ../..
