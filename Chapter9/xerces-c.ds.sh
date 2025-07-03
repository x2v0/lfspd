#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
# Treat unset variables as an error when substituting
set -u
# Ensure that a pipeline returns the exit status of the last command to exit with a non-zero status
set -o pipefail

# Check for necessary tools
for cmd in make gcc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed."
        exit 1
    fi
done

# Optional: Comment out specific subdirectories in CMakeLists.txt
# Uncomment and modify the following lines if needed:
# echo "Modifying CMakeLists.txt..."
# sed -i "s/add_subdirectory(doc)/#add_subdirectory(doc)/" CMakeLists.txt
# sed -i "s/add_subdirectory(tests)/#add_subdirectory(tests)/" CMakeLists.txt
# sed -i "s/add_subdirectory(samples)/#add_subdirectory(samples)/" CMakeLists.txt

# Configure the build
echo "Configuring the build..."
./configure --prefix=/usr \
            --disable-static \
            --enable-transcoder-iconv \
            --disable-rpath \
            --disable-network

# Build the project
echo "Building the project..."
make

# Install the project
echo "Installing the project..."
make install

echo "Installation completed successfully."
