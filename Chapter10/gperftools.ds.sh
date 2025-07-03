#!/bin/bash

# Exit on error
set -e

# Clone gperftools repository
git clone https://github.com/gperftools/gperftools.git
cd gperftools

# Configure the build with CMake
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr/local .

# Build and install
make -j$(nproc)
sudo make install

# Optionally, clean up the gperftools directory
cd ..
rm -rf gperftools

echo "gperftools installation completed successfully."
