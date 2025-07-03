#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Return the exit code of the first command in the pipeline that fails
set -o pipefail

# Download the HepMC3 source code
echo "Downloading HepMC3-3.2.6..."
wget http://hepmc.web.cern.ch/hepmc/releases/HepMC3-3.2.6.tar.gz

# Extract the source code
echo "Extracting HepMC3-3.2.6..."
tar -xzf HepMC3-3.2.6.tar.gz

# Create and enter the build directory
echo "Creating build directory..."
mkdir hepmc3-build
pushd hepmc3-build > /dev/null

# Configure the build using CMake
echo "Configuring build with CMake..."
cmake -DCMAKE_INSTALL_PREFIX=/usr/local                 \
      -DHEPMC3_ENABLE_ROOTIO:BOOL=OFF                   \
      -DHEPMC3_ENABLE_PROTOBUFIO:BOOL=OFF               \
      -DHEPMC3_ENABLE_TEST:BOOL=OFF                     \
      -DHEPMC3_INSTALL_INTERFACES:BOOL=ON               \
      -DHEPMC3_BUILD_STATIC_LIBS:BOOL=OFF               \
      -DHEPMC3_BUILD_DOCS:BOOL=OFF                      \
      -DHEPMC3_ENABLE_PYTHON:BOOL=OFF                   \
      -DCMAKE_BUILD_TYPE="MinSizeRel"                   \
      ../HepMC3-3.2.6

# Build and install the software
echo "Building and installing HepMC3..."
make
make install

# Return to the parent directory
popd > /dev/null

# Optional: Clean up downloaded and extracted files
# echo "Cleaning up build files..."
# rm -rf HepMC3-3.2.6.tar.gz HepMC3-3.2.6 hepmc3-build

echo "HepMC3 installation completed successfully!"
