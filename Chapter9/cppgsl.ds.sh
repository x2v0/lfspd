#!/bin/bash

# The Guidelines Support Library (GSL) contains functions and
# types that are suggested for use by the C++ Core Guidelines maintained
# by the Standard C++ Foundation.

set -e  # Exit immediately if any command fails

# Clone the GSL repository
echo "Cloning GSL repository..."
git clone https://github.com/microsoft/GSL || { echo "Failed to clone GSL repository"; exit 1; }

# Navigate into the GSL directory
cd GSL || { echo "Failed to enter GSL directory"; exit 1; }

# Create a build directory
echo "Creating build directory..."
mkdir -p build || { echo "Failed to create build directory"; exit 1; }

# Navigate into the build directory
cd build || { echo "Failed to enter build directory"; exit 1; }

# Run CMake to configure the build
echo "Configuring build with CMake..."
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DGSL_TEST=OFF .. || { echo "CMake configuration failed"; exit 1; }

# Build and install the library
echo "Building and installing GSL..."
sudo make install || { echo "Build or installation failed"; exit 1; }

# Clean up by removing the GSL directory
echo "Cleaning up..."
cd ../..
rm -rf GSL || { echo "Failed to clean up GSL directory"; exit 1; }

echo "GSL installation completed successfully!"
