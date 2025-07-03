#!/bin/bash

# Clone the GeoModel repository
git clone https://gitlab.cern.ch/GeoModelDev/GeoModel || {
    echo "Failed to clone GeoModel repository"; exit 1
}

# Create and navigate to the build directory
mkdir GeoModel_build || {
    echo "Failed to create build directory"; exit 1
}
cd GeoModel_build || {
    echo "Failed to navigate to build directory"; exit 1
}

# Configure GeoModel with CMake
cmake -B . -S ../GeoModel || {
    echo "CMake configuration failed"; exit 1
}

# Build GeoModel
cmake --build . || {
    echo "Build failed"; exit 1
}

# Install GeoModel
make install || {
    echo "Installation failed"; exit 1
}

# Return to the parent directory
cd ..
