#!/bin/bash

# Exit on error
set -e

# Configure the build
echo "Configuring Python build..."
./configure \
  --prefix=/usr \
  --enable-shared \
  --disable-test-modules \
  --with-pydebug \
  --with-system-ffi

# Build Python (continue on errors with -k)
echo "Building Python..."
make -k

# Install Python
echo "Installing Python..."
make install

# Copy Python debug headers
echo "Copying Python debug headers..."
cp -rf /usr/include/python3.11d/* /usr/include

# Create symbolic links
echo "Creating symbolic links..."
ln -sv /bin/python3 /bin/python
ln -sv /bin/pip3 /bin/pip

echo "Python installation complete!"
