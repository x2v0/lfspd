#!/bin/bash

# Exit on error
set -e

# Clone VecCore repository (latest stable branch)
git clone --branch latest-stable --depth=1 https://github.com/root-project/veccore.git veccore_src

# Create and enter build directory
mkdir -p veccore_build
cd veccore_build

# Configure the build with CMake
cmake -DCMAKE_CXX_STANDARD="11" \
      -DCMAKE_INSTALL_PREFIX="/usr" \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DCUDA="OFF" \
      -DUMESIMD="OFF" \
      -DVC="OFF" \
      -DBUILD_DOCS="OFF" \
      -DBUILD_BENCHMARKS="OFF" \
      -DBUILD_TESTING="OFF" \
      -DBUILD_GOOGLETEST="OFF" \
      -DBUILD_GOOGLEBENCH="OFF" \
      -DBUILD_UMESIMD="OFF" \
      -DBUILD_VC="OFF" \
      ../veccore_src

# Build and install
cmake --build . -- -j$(nproc)
sudo cmake --install .

# Optionally, clean up the veccore_src and veccore_build directories
cd ..
rm -rf veccore_src veccore_build

echo "VecCore installation completed successfully."
