#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Clone the HepMC repository
echo "Cloning HepMC repository..."
git clone https://github.com/alisw/hepmc

# Create and enter the build directory
echo "Creating build directory..."
mkdir hepmc_build
pushd hepmc_build > /dev/null

# Configure the build using CMake
echo "Configuring build with CMake..."
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -Dmomentum:STRING="MEV" \
      -Dlength:STRING="MM" \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      ../hepmc

# Build and install the software
echo "Building and installing HepMC..."
make
make install

# Return to the parent directory
popd > /dev/null

# Optional: Clean up source and build directories
# echo "Cleaning up build files..."
# rm -rf ../hepmc hepmc_build

echo "HepMC installation completed successfully!"
