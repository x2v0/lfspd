#!/bin/bash

# Exit on error
set -e

# Clone Catch2 repository
git clone https://github.com/catchorg/Catch2.git

# Enter the Catch2 directory
pushd Catch2

# Configure the build with CMake
cmake -Bbuild -H. \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DCMAKE_BUILD_TYPE="MinSizeRel" \
  -DBUILD_TESTING=OFF \
  -DCATCH_INSTALL_DOCS=OFF \
  -DCATCH_DEVELOPMENT_BUILD=OFF \
  -DCATCH_INSTALL_EXTRAS=OFF \
  -DCATCH_BUILD_EXAMPLES=OFF \
  -DCATCH_BUILD_EXTRA_TESTS=OFF \
  -DCATCH_BUILD_FUZZERS=OFF

# Build and install
cmake --build build/ --target install -j$(nproc)

# Clean up
popd
rm -rf Catch2

echo "Catch2 installation completed successfully."
