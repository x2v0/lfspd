#!/bin/bash

# This script extracts, compiles, and installs a 
package for LFS.
# Usage: ./script.sh <CHAPTER> <PACKAGE>

# Enable debugging (optional, uncomment if 
needed)
# set -x

# Validate input arguments
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <CHAPTER> <PACKAGE>"
  exit 1
fi

CHAPTER="$1"
PACKAGE="$2"

# Check if md5sums file exists
if [ ! -f "md5sums" ]; then
  echo "Error: md5sums file not found!"
  exit 1
fi

# Extract the filename of the package from 
md5sums
FILENAME=$(grep -i "^$PACKAGE" md5sums | cut -d ' 
' -f 3 | grep -i -v "\.patch")

if [ -z "$FILENAME" ]; then
  echo "Error: Package '$PACKAGE' not found in 
md5sums!"
  exit 1
fi

# Derive the directory name from the package name
DIRNAME=$(echo "$PACKAGE" | sed 
's/\(.*\)\.tar\..*/\1/')

# Clean up existing directory (if any)
if [ -d "$DIRNAME" ]; then
  echo "Removing existing directory: $DIRNAME"
  rm -rf "$DIRNAME" || { echo "Failed to remove 
$DIRNAME"; exit 1; }
fi

# Create the directory for extraction
echo "Creating directory: $DIRNAME"
mkdir -pv "$DIRNAME" || { echo "Failed to create 
$DIRNAME"; exit 1; }

# Extract the package
echo "===> Extracting $PACKAGE..."
if ! tar -xvf "$FILENAME" -C "$DIRNAME"; then
  echo "Failed to extract $FILENAME"
  exit 1
fi

# Move into the extracted directory
pushd "$DIRNAME" || { echo "Failed to enter 
$DIRNAME"; exit 1; }

# If the extracted directory contains only one 
subdirectory, move its contents up
if [ "$(ls -A1 | wc -l)" == "1" ]; then
  SUBDIR=$(ls -A1)
  echo "Moving contents of $SUBDIR to 
$DIRNAME..."
  mv "$SUBDIR"/* ./
  rmdir "$SUBDIR" || { echo "Failed to remove 
$SUBDIR"; exit 1; }
fi

# Compile the package
echo "===> Compiling $PACKAGE..."
sleep 5

# Ensure the log directory exists
mkdir -pv "$LFS/var/log/Chapter$CHAPTER/" || { 
echo "Failed to create log directory"; exit 1; }

# Run the compilation script and log the output
if ! source 
"$LFS/sources/Chapter$CHAPTER/$PACKAGE.sh" 2>&1 | 
tee "$LFS/var/log/Chapter$CHAPTER/$PACKAGE.log"; 
then
  echo "===> Compiling $PACKAGE failed!"
  popd || exit 1
  exit 1
fi

echo "===> Done compiling $PACKAGE!"
sleep 3

# Return to the previous directory
popd || { echo "Failed to return from $DIRNAME"; 
exit 1; }

echo "Script completed successfully!"
