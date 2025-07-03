#!/bin/bash

# Exit on error
set -e

# Clone podio repository
git clone https://github.com/AIDASoft/podio.git
cd podio

# Configure the build with CMake
cmake -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DBUILD_TESTING:BOOL=OFF \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DUSE_EXTERNAL_CATCH2=/usr/lib .

# Set up ROOT environment (if thisroot.sh exists)
if [ -f "/usr/local/bin/thisroot.sh" ]; then
    source /usr/local/bin/thisroot.sh
else
    echo "ROOT environment setup script '/usr/local/bin/thisroot.sh' not found. Skipping."
fi

# Build and install
make -j$(nproc)
sudo make install

# Optionally, clean up the podio directory
cd ..
rm -rf podio

echo "podio installation completed successfully."
