#!/bin/bash

# Enable debugging (uncomment if needed)
# set -x

# Source environment scripts for ROOT and Geant4
source /usr/local/bin/thisroot.sh
source /usr/local/bin/geant4.sh

# Clone the DD4hep repository
git clone https://github.com/AIDASoft/DD4hep

# Apply patches to DD4hep's CMake files
patch DD4hep/CMakeLists.txt Chapter10/DDD.patch
patch DD4hep/DDCore/CMakeLists.txt Chapter10/DD4hep.patch
patch DD4hep/UtilityApps/CMakeLists.txt Chapter10/UtilityApps.patch
patch DD4hep/UtilityApps/CMakeLists.txt Chapter10/UtilityApps2.patch

# Create and navigate to the build directory
mkdir DD4hep_build
cd DD4hep_build

# Configure DD4hep with CMake
cmake \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DDD4HEP_USE_LCIO=OFF \
    -DDD4HEP_USE_XERCESC=ON \
    -DBUILD_TESTING=OFF \
    -DDD4HEP_SET_RPATH=OFF \
    -DROOT_DIR=$ROOTSYS \
    -DDD4HEP_USE_GEANT4=ON \
    -DDD4HEP_USE_EDM4HEP=ON \
    -DDD4HEP_USE_HEPMC3=ON \
    -DCMAKE_INSTALL_PREFIX="/usr/local" \
    -DCMAKE_BUILD_TYPE="MinSizeRel" \
    -B . -S ../DD4hep

# Build DD4hep
make

# Fix a specific issue in the generated cmake_install.cmake file
sed -i 's|G__eve_rdict.pcm||g' UtilityApps/cmake_install.cmake

# Install DD4hep
make install

# Return to the parent directory
cd ..
