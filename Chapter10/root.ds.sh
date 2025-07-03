#!/bin/bash

# Exit on error
set -e

# Clone ROOT repository (latest stable branch)
git clone --branch latest-stable --depth=1 https://github.com/root-project/root.git root_src

# Create and enter build directory
mkdir -p root_build
cd root_build

# Set ROOTSYS environment variable
export ROOTSYS="/usr/local"

# Configure the build with CMake
cmake -DCMAKE_CXX_STANDARD="17" \
      -DCMAKE_INSTALL_PREFIX=${ROOTSYS} \
      -DX11:BOOL=OFF \
      -Dmathmore:BOOL=ON \
      -Dfftw3:BOOL=ON \
      -Dpyroot:BOOL=ON \
      -Dgdml:BOOL=ON \
      -Dminimal:BOOL=ON \
      -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DPython3_EXECUTABLE="/bin/python3" \
      ../root_src

# Build and install
cmake --build . -- -j$(nproc)
sudo cmake --install .

# Set up ROOT environment (if thisroot.sh exists)
if [ -f "/usr/local/bin/thisroot.sh" ]; then
    source /usr/local/bin/thisroot.sh
else
    echo "ROOT environment setup script '/usr/local/bin/thisroot.sh' not found. Skipping."
fi

# Create symlinks for root, rootn, and rootnb
sudo ln -sf /usr/local/bin/root.exe /usr/local/bin/root
sudo ln -sf /usr/local/bin/rootn.exe /usr/local/bin/rootn
sudo ln -sf /usr/local/bin/rootnb.exe /usr/local/bin/rootnb

echo "ROOT installation completed successfully."
