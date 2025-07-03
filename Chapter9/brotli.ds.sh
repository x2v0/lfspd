#!/bin/bash

# Exit on error
set -e

# Brotli provides a general-purpose lossless compression algorithm
# that compresses data using a combination of a modern variant of the LZ77 algorithm,
# Huffman coding and 2nd order context modeling.

PKG="brotli"
PKG_VERSION="1.0"
PKG_BUILD="9"
PKG_FULL=${PKG}-${PKG_VERSION}.${PKG_BUILD}
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://github.com/google/brotli/archive/v${PKG_VERSION}.${PKG_BUILD}/${PKG_FILE}"
MD5="c2274f0c7af8470ad514637c35bcee7d"

# Download the source code if it doesn't exist
if [ ! -f "${PKG_FILE}" ]; then
    echo "Downloading ${PKG_FILE}..."
    curl -LO "${URL}"
fi

# Verify the MD5 checksum (optional but recommended)
if ! echo "${MD5}  ${PKG_FILE}" | md5sum -c -; then
    echo "Error: MD5 checksum verification failed for ${PKG_FILE}."
    exit 1
fi

# Extract the source code
echo "Extracting ${PKG_FILE}..."
tar -xzf "${PKG_FILE}"

# Create and enter build directory
mkdir -p out
cd out

# Configure the build with CMake
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_BUILD_TYPE="MinSizeRel"   \
      ../${PKG_FULL}

# Build and install
make -j$(nproc)
sudo make install

# Clean up
cd ..
rm -rf out ${PKG_FULL}

echo "Brotli installation completed successfully."
