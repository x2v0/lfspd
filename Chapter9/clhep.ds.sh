#!/bin/bash

# Exit on error
set -e

# CLHEP is a C++ Class Library for High Energy Physics.

# Enter the CLHEP directory
pushd CLHEP

# Patch CMakeLists.txt to disable clhep_ensure
if [ -f "CMakeLists.txt" ]; then
    sed -i 's/clhep_ensure/#clhep_ensure/' CMakeLists.txt
else
    echo "Error: 'CMakeLists.txt' not found. Cannot apply patch."
    exit 1
fi

# Configure the build with CMake
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DCLHEP_BUILD_DOCS=OFF .

# Build and install
make -j$(nproc)
sudo make install

# Clean up
popd
rm -rf CLHEP

echo "CLHEP installation completed successfully."
