#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Clone the Vc repository
echo "Cloning Vc repository..."
git clone https://github.com/VcDevel/Vc

# Enter the Vc directory
cd Vc

# Create and enter the build directory
echo "Creating build directory..."
mkdir build
cd build

# Configure the build using CMake
echo "Configuring build with CMake..."
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..

# Build the software
echo "Building software..."
cmake --build .

# Install the software
echo "Installing software..."
cmake --install .

# Return to the parent directory
cd ../..

echo "Vc installation completed successfully!"
