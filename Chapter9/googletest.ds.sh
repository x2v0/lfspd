#!/bin/bash

# Clone the GoogleTest repository
git clone https://github.com/google/googletest.git

# Navigate into the cloned repository
cd googletest

# Create a build directory and navigate into it
mkdir -p build
cd build

# Configure the build with CMake
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON ..

# Build the project
make -j$(nproc)

# Install the built files (with sudo for necessary permissions)
sudo make install

# Navigate back to the original directory
cd ../..

# Clean up by removing the googletest directory
rm -rf googletest
