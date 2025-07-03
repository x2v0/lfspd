#!/bin/bash

set -e  # Exit immediately if any command fails

# Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms.

PKG="eigen"
PKG_VERSION="3.4"
PKG_BUILD="0"
PKG_FULL=${PKG}-${PKG_VERSION}.${PKG_BUILD}
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://gitlab.com/lib${PKG}/${PKG}/-/archive/${PKG_VERSION}.${PKG_BUILD}/${PKG_FILE}"

# Clone the Eigen repository
echo "Cloning Eigen repository..."
git clone https://gitlab.com/libeigen/eigen.git || { echo "Failed to clone Eigen repository"; exit 1; }

# Navigate into the Eigen directory
echo "Entering Eigen directory..."
cd eigen || { echo "Failed to enter Eigen directory"; exit 1; }

# Create a build directory
echo "Creating build directory..."
mkdir -pv build || { echo "Failed to create build directory"; exit 1; }

# Navigate into the build directory
echo "Entering build directory..."
cd build || { echo "Failed to enter build directory"; exit 1; }

# Configure the project with CMake
echo "Configuring Eigen with CMake..."
cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. || { echo "CMake configuration failed"; exit 1; }

# Build and install the project
echo "Building and installing Eigen..."
sudo make install || { echo "Build or installation failed"; exit 1; }

# Rename the installed Eigen directory
echo "Renaming Eigen include directory..."
sudo mv /usr/local/include/Eigen /usr/local/include/eigen3 || { echo "Failed to rename Eigen directory"; exit 1; }

# Clean up
echo "Cleaning up..."
cd ../..
rm -rf eigen || { echo "Failed to clean up Eigen directory"; exit 1; }

echo "Eigen installation completed successfully!"
