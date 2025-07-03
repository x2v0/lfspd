#!/bin/bash

# Exit on error
set -e

# Set Xerces-C root (if needed)
XERCESCROOT=/usr

# Define Geant4 version
ver="11.2.0"

# Create temporary directory
mkdir -p tmp
cd tmp
mkdir -p build

# Download Geant4 source tarball
url="https://github.com/Geant4/geant4/archive/refs/tags/v${ver}.tar.gz"
wget ${url}
file=$(basename ${url})

# Extract the tarball
tar -xzf ${file}

# Configure the build with CMake
cd build
cmake -DGEANT4_INSTALL_DATA="ON" \
      -DGEANT4_USE_GDML="ON" \
      -DGEANT4_BUILD_TLS_MODEL="global-dynamic" \
      -DGEANT4_USE_PYTHON="ON" \
      -DGEANT4_BUILD_MULTITHREADED="ON" \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      ../geant4-${ver}

# Build and install
make -j$(nproc)
sudo make install

# Clean up
cd ../..
sudo rm -rf /usr/local/Geant4/examples
rm -rf tmp

# Set read-only permissions for Geant4 shared files
sudo chmod -R 0444 /usr/local/share/Geant4

echo "Geant4 installation completed successfully."
