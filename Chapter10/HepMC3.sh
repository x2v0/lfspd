#!/bin/bash

wget http://hepmc.web.cern.ch/hepmc/releases/HepMC3-3.2.6.tar.gz
tar -xzf HepMC3-3.2.6.tar.gz
mkdir hepmc3-build
cd hepmc3-build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local   		\
      -DHEPMC3_ENABLE_ROOTIO:BOOL=OFF           \
      -DHEPMC3_ENABLE_PROTOBUFIO:BOOL=OFF       \
      -DHEPMC3_ENABLE_TEST:BOOL=OFF             \
      -DHEPMC3_INSTALL_INTERFACES:BOOL=ON       \
      -DHEPMC3_BUILD_STATIC_LIBS:BOOL=OFF       \
      -DHEPMC3_BUILD_DOCS:BOOL=OFF     		 	\
      -DHEPMC3_ENABLE_PYTHON:BOOL=OFF		 	\
	  -DCMAKE_BUILD_TYPE="MinSizeRel" 			\
../HepMC3-3.2.6

make
make install

cd ..
