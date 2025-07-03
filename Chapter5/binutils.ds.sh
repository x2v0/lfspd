#!/bin/bash

# Create a build directory
mkdir -v build || {
    echo "Failed to create build directory"; exit 1
}

# Navigate to the build directory
cd build || {
    echo "Failed to navigate to build directory"; exit 1
}

# Configure the build with specified options
../configure \
    --prefix=$LFS/tools \
    --with-sysroot=$LFS \
    --target=$LFS_TGT \
    --disable-nls \
    --enable-gprofng=no \
    --disable-werror || {
    echo "Configuration failed"; exit 1
}

# Build the project
make || {
    echo "Build failed"; exit 1
}

# Install the project
make install || {
    echo "Installation failed"; exit 1
}
