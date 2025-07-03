#!/bin/bash

# Exit on error
set -e

# Clone fmt repository
git clone https://github.com/fmtlib/fmt.git
cd fmt

# Configure the build with CMake
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DFMT_DOC=OFF \
      -DFMT_TEST=OFF \
      -DBUILD_STATIC_LIBS=OFF \
      -DBUILD_SHARED_LIBS=ON .

# Build and install
make -j$(nproc)
sudo make install

# Optionally, clean up the fmt directory
cd ..
rm -rf fmt

echo "fmt installation completed successfully."
