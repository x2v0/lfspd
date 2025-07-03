#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Enable debugging
set -x

# Check for necessary tools
for cmd in patch sed make; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Apply the patch
echo "Applying patch..."
if ! patch -Np1 -i ../unzip-6.0-consolidated_fixes-1.patch; then
    echo "Error: Failed to apply patch."
    exit 1
fi

# Modify the configure script
echo "Modifying configure script..."
sed -i 's/${LFLAGS1}/ -liconv/' ./unix/configure

# Build the project
echo "Building the project..."
make -f unix/Makefile generic

# Install the project
echo "Installing the project..."
make prefix=/usr MANDIR=/usr/share/man/man1 \
     -f unix/Makefile install

echo "Installation completed successfully."
