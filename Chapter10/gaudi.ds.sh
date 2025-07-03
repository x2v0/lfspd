#!/bin/bash

# Exit on error
set -e

# Clone Gaudi repository
git clone https://gitlab.cern.ch/gaudi/Gaudi.git

# Apply patch (if the patch file exists)
if [ -f "/sources/Chapter10/gaudi.patch" ]; then
    echo "Applying patch..."
    patch -p1 -d Gaudi < /sources/Chapter10/gaudi.patch
else
    echo "Patch file '/sources/Chapter10/gaudi.patch' not found. Skipping patch application."
fi

# Enter the Gaudi directory
cd Gaudi

# Fix for GCC missing __has_warning macro
if [ -f "/usr/local/include/gsl/span" ]; then
    sed -i 's/&& __has_warning("-Wunsafe-buffer-usage")//g' /usr/local/include/gsl/span
fi
if [ -f "/usr/local/include/gsl/util" ]; then
    sed -i 's/&& __has_warning("-Wunsafe-buffer-usage")//g' /usr/local/include/gsl/util
fi

# Set up ROOT environment (if thisroot.sh exists)
if [ -f "/usr/local/bin/thisroot.sh" ]; then
    source /usr/local/bin/thisroot.sh
else
    echo "ROOT environment setup script '/usr/local/bin/thisroot.sh' not found. Skipping."
fi

# Create build directory
mkdir -p build

# Configure the build with CMake
cmake \
  -DCMAKE_BUILD_TYPE="MinSizeRel" \
  -DCMAKE_INSTALL_PREFIX=/usr/local \
  -DGAUDI_USE_AIDA:BOOL=OFF \
  -DGAUDI_USE_GPERFTOOLS:BOOL=OFF \
  -DGAUDI_USE_CPPUNIT:BOOL=OFF \
  -DGAUDI_USE_DOXYGEN:BOOL=OFF \
  -DBUILD_TESTING:BOOL=OFF \
  -DGAUDI_USE_XERCESC:BOOL=ON \
  -DGAUDI_ENABLE_GAUDIALG:BOOL=ON \
  -DGAUDI_ENABLE_GAUDIPARTPROP:BOOL=ON \
  -S . -B build

# Build and install
cmake --build build -- -j$(nproc)
sudo cmake --install build

# Optionally, clean up the Gaudi directory
cd ..
rm -rf Gaudi

echo "Gaudi installation completed successfully."
