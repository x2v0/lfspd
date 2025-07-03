#!/bin/bash

# Exit on error
set -e

# Clone ACTS repository
git clone https://github.com/acts-project/acts.git

# Apply patch (if the patch file exists)
if [ -f "Chapter10/acts.patch" ]; then
    echo "Applying patch..."
    patch -p1 -d acts < Chapter10/acts.patch
else
    echo "Patch file 'Chapter10/acts.patch' not found. Skipping patch application."
fi

# Create and enter build directory
mkdir -p acts_build
cd acts_build

# Configure the build with CMake
cmake -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DACTS_BUILD_PLUGIN_GEANT4="ON" \
      -DACTS_BUILD_PLUGIN_TGEO="ON" \
      -DACTS_BUILD_PLUGIN_DD4HEP="ON" \
      -B . -S ../acts

# Build and install
cmake --build . -- -j$(nproc)
sudo make install

# Optionally, clean up build directory
cd ..
rm -rf acts_build

echo "ACTS installation completed successfully."
