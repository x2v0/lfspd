#!/bin/bash

# The libpng package contains libraries used by other programs
# for reading and writing PNG files. The PNG format was designed
# as a replacement for GIF and, to a lesser extent, TIFF,
# with many improvements and extensions and lack of patent problems.

# Download and extract libpng
wget https://sourceforge.net/projects/libpng/files/libpng16/1.6.42/libpng-1.6.42.tar.gz || { echo "Failed to download libpng"; exit 1; }
tar -xf libpng-1.6.42.tar.gz || { echo "Failed to extract libpng"; exit 1; }

# Download the patch file
wget https://example.com/path/to/libpng-1.6.39-apng.patch.gz || { echo "Failed to download patch"; exit 1; }

# Apply the patch
pushd libpng-1.6.42 || { echo "Failed to change directory to libpng-1.6.42"; exit 1; }
gzip -cd ../libpng-1.6.39-apng.patch.gz | patch -p1 || { echo "Failed to apply patch"; exit 1; }

# Configure, build, and install
./configure --prefix=/usr --disable-static || { echo "Failed to configure libpng"; exit 1; }
make || { echo "Failed to build libpng"; exit 1; }
make install || { echo "Failed to install libpng"; exit 1; }

popd
