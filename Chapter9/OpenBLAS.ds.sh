#!/bin/bash

# Exit on error
set -e

# OpenBLAS is an optimized BLAS library based on GotoBLAS2 1.13 BSD version.
PKG="OpenBLAS"
PKG_VERSION="0.3"
PKG_BUILD="25"
URL="https://github.com/OpenMathLib/${PKG}"

# Clone OpenBLAS repository
git clone ${URL}
pushd ${PKG}

# Optionally, checkout a specific version (if needed)
# git checkout v${PKG_VERSION}.${PKG_BUILD}

# Configure the build with CMake
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DBUILD_STATIC_LIBS=OFF \
      -DBUILD_SHARED_LIBS=ON .

# Build and install
make -j$(nproc)
sudo make install

# Clean up
popd
rm -rf ${PKG}

echo "OpenBLAS installation completed successfully."
