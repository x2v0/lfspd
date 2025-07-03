#!/bin/bash

# Exit on error
set -e

# Clean the source tree
echo "Cleaning the source tree..."
make mrproper

# Build headers
echo "Building headers..."
make headers

# Remove non-header files from usr/include
echo "Cleaning up usr/include..."
find usr/include -type f ! -name '*.h' -delete

# Copy headers to $LFS/usr/include
echo "Copying headers to $LFS/usr/include..."
cp -rv usr/include "$LFS/usr"

echo "Headers installation complete!"
