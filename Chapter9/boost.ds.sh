#!/bin/bash

# Exit on error
set -e

# Boost provides a set of free peer-reviewed portable C++ source libraries.
# It includes libraries for linear algebra, pseudorandom number generation,
# multithreading, image processing, regular expressions and unit testing.

# Patch boost/phoenix/stl.hpp to remove problematic include
if [ -f "boost/phoenix/stl.hpp" ]; then
    sed -i '/#include.*phoenix.*tuple.hpp.*/d' boost/phoenix/stl.hpp
else
    echo "Warning: 'boost/phoenix/stl.hpp' not found. Skipping patch."
fi

# Bootstrap the build system
./bootstrap.sh --prefix=/usr/local --with-python=/usr/bin/python3

# Build Boost with multi-threading and shared libraries
./b2 stage threading=multi link=shared variant=release -j$(nproc)

# Install Boost
sudo ./b2 install threading=multi link=shared

echo "Boost installation completed successfully."
