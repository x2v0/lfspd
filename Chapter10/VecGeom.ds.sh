#!/bin/bash

# Exit on error
set -e

# Set Xerces-C root (if needed)
XERCESCROOT=/usr

# Clone VecGeom repository
git clone https://gitlab.cern.ch/VecGeom/VecGeom.git
cd VecGeom

# Create and enter build directory
mkdir -p build
cd build

# Configure the build with CMake
cmake .. -DCMAKE_INSTALL_PREFIX="/usr" \
    -DBUILD_TESTING="OFF" \
    -DVECGEOM_GDML="ON" \
    -DVECGEOM_BUILTIN_VECCORE="ON" \
    -DBUILD_SHARED_LIBS="ON" \
    -DBUILD_STATIC_LIBS="OFF" \
    -DCMAKE_BUILD_TYPE="MinSizeRel"

# Build and install
make -j$(nproc) install

# Optionally, clean up build directory
cd ../..
rm -rf VecGeom

echo "VecGeom installation completed successfully."
