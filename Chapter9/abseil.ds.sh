#!/bin/bash

# Exit on error
set -e

# Abseil Common Libraries (C++)
PKG="abseil-cpp"
URL="https://github.com/abseil/abseil-cpp"

# Clone Abseil repository
git clone ${URL}
cd ${PKG}

# Configure the build with CMake
cmake -DBUILD_TESTING=OFF \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DABSL_PROPAGATE_CXX_STD=ON \
      -DBUILD_SHARED_LIBS=ON .

# Build and install
make -j$(nproc)
sudo make install

# Optionally, clean up the abseil-cpp directory
cd ..
rm -rf ${PKG}

echo "Abseil installation completed successfully."
