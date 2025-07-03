#!/bin/bash

# Exit on error
set -e

# Check if the source directory exists
if [ ! -d "src/dbinc" ]; then
    echo "Error: Source directory 'src/dbinc' not found. Please ensure you are in the correct directory."
    exit 1
fi

# Patch atomic.h to avoid conflicts with system headers
if [ -f "src/dbinc/atomic.h" ]; then
    sed -i 's/\(__atomic_compare_exchange\)/\1_db/' src/dbinc/atomic.h
else
    echo "Error: 'src/dbinc/atomic.h' not found. Cannot apply patch."
    exit 1
fi

# Create and enter build directory
mkdir -p build_unix
pushd build_unix

# Check if the configure script exists
if [ ! -f "../dist/configure" ]; then
    echo "Error: Configure script '../dist/configure' not found. Please ensure you are in the correct directory."
    exit 1
fi

# Configure the build
../dist/configure --prefix=/usr/local \
                  --enable-compat185  \
                  --enable-dbm        \
                  --disable-static   \
                  --enable-cxx

# Build and install
make -j$(nproc)
sudo make install

# Clean up
popd
echo "Cleaning up build directory..."
rm -rf build_unix

echo "Berkeley DB installation completed successfully."
