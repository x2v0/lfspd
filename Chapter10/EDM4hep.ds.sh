#!/bin/bash

# Clone the EDM4hep repository
git clone https://github.com/key4hep/EDM4hep
cd EDM4hep || { echo "Failed to navigate to EDM4hep directory"; exit 1; }

# Configure EDM4hep with CMake
cmake \
    -DCMAKE_BUILD_TYPE="MinSizeRel" \
    -DBUILD_TESTING:BOOL=OFF \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DUSE_EXTERNAL_CATCH2=/usr/lib .

# Source ROOT environment
source /usr/local/bin/thisroot.sh

# Build and install EDM4hep
make || { echo "Build failed"; exit 1; }
make install || { echo "Installation failed"; exit 1; }

# Return to the parent directory
cd ..
