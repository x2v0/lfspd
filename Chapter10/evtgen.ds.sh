#!/bin/bash

# Exit on error
set -e

# Clone EVTGEN repository
git clone https://gitlab.cern.ch/evtgen/evtgen.git

# Create and enter build directory
mkdir -p evtgen_build
cd evtgen_build

# Configure the build with CMake
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DEVTGEN_BUILD_DOC:BOOL=OFF \
      -DEVTGEN_BUILD_DOXYGEN:BOOL=OFF \
      -DEVTGEN_BUILD_TESTS:BOOL=OFF \
      -DEVTGEN_PYTHIA:BOOL=ON \
      -DEVTGEN_BUILD_VALIDATIONS:BOOL=OFF \
      ../evtgen

# Build and install
cmake --build . -- -j$(nproc)
sudo cmake --install .

# Optionally, clean up build directory
cd ..
rm -rf evtgen_build

echo "EVTGEN installation completed successfully."
