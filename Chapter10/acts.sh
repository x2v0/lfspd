#!/bin/bash

git clone https://github.com/acts-project/acts

patch acts/Core/include/Acts/Utilities/VectorHelpers.hpp Chapter10/acts.patch

mkdir acts_build
cd acts_build
cmake -DCMAKE_BUILD_TYPE="MinSizeRel" \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DACTS_BUILD_PLUGIN_GEANT4="ON" \
      -DACTS_BUILD_PLUGIN_TGEO="ON" \
      -DACTS_BUILD_PLUGIN_DD4HEP="ON" \
      -B . -S ../acts

cmake --build .
make install
cd ..
