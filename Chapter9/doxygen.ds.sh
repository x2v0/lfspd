#!/bin/bash

set -e  # Exit immediately if any command fails

# Update Python shebangs to explicitly use Python 3
echo "Updating Python shebangs to use Python 3..."
if files=$(grep -rl '^#!.*python$' 2>/dev/null); then
  echo "$files" | xargs sed -i '1s/python/&3/'
else
  echo "No files with Python shebangs found. Skipping..."
fi

# Create build directory
echo "Creating build directory..."
mkdir -pv build || { echo "Failed to create build directory"; exit 1; }

# Change to build directory
echo "Entering build directory..."
pushd build || { echo "Failed to enter build directory"; exit 1; }

# Configure the project with CMake
echo "Configuring project with CMake..."
cmake -G "Unix Makefiles"               \
      -DCMAKE_BUILD_TYPE="MinSizeRel"   \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -Dbuild_doc=OFF                   \
      -Duse_libclang=OFF                \
      -Duse_sys_spdlog=OFF              \
      -Dbuild_wizard=OFF                \
      -Dbuild_app=OFF                   \
      -Wno-dev .. || { echo "CMake configuration failed"; exit 1; }

# Build the project
echo "Building the project..."
make || { echo "Build failed"; exit 1; }

# Install the project
echo "Installing the project..."
sudo make install || { echo "Installation failed"; exit 1; }

# Return to the original directory
echo "Returning to the original directory..."
popd || { echo "Failed to return to the original directory"; exit 1; }

echo "Script completed successfully!"
