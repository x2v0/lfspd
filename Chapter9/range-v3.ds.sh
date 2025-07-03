#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Check for necessary tools
for cmd in git cmake make gcc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Clone the repository
echo "Cloning range-v3 repository..."
if ! git clone https://github.com/ericniebler/range-v3; then
    echo "Error: Failed to clone range-v3 repository."
    exit 1
fi

# Enter the cloned directory
pushd range-v3 || { echo "Error: Failed to enter directory range-v3."; exit 1; }

# Configure the build
echo "Configuring the build..."
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DBUILD_SHARED_LIBS=ON \
      -DRANGE_V3_DOCS=OFF \
      -DRANGE_V3_EXAMPLES=OFF \
      -DRANGES_BUILD_CALENDAR_EXAMPLE=OFF \
      -DRANGE_V3_TESTS=OFF \
      -DRANGES_DEBUG_INFO=OFF .

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

# Return to the original directory
popd || { echo "Error: Failed to return to the original directory."; exit 1; }

echo "Installation of range-v3 completed successfully."
