#!/bin/bash

git clone https://gitlab.cern.ch/gaudi/Gaudi.git

patch /sources/Gaudi/GaudiCoreSvc/src/MessageSvc/MessageSvcSink.cpp /sources/Chapter10/gaudi.patch

cd Gaudi

# !! fuck gcc doesn't have __has_warbibg macro
sed -i 's/&& __has_warning("-Wunsafe-buffer-usage")//g' /usr/local/include/gsl/span
sed -i 's/&& __has_warning("-Wunsafe-buffer-usage")//g' /usr/local/include/gsl/util
 
source /usr/local/bin/thisroot.sh

mkdir build

cmake \
  -DCMAKE_BUILD_TYPE="MinSizeRel" \
  -DCMAKE_INSTALL_PREFIX=/usr/local \
  -DGAUDI_USE_AIDA:BOOL=OFF \
  -DGAUDI_USE_GPERFTOOLS:BOOL=OFF \
  -DGAUDI_USE_CPPUNIT:BOOL=OFF \
  -DGAUDI_USE_DOXYGEN:BOOL=OFF \
  -DBUILD_TESTING:BOOL=OFF \
  -DGAUDI_USE_XERCESC:BOOL=ON \
  -DGAUDI_ENABLE_GAUDIALG:BOOL=ON \
  -DGAUDI_ENABLE_GAUDIPARTPROP:BOOL=ON \
  -S . -B build

cmake --build build
cmake --install build

cd ..
