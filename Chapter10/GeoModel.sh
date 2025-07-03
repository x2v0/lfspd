#!/bin/bash

 git clone https://gitlab.cern.ch/GeoModelDev/GeoModel
 
 mkdir GeoModel_build
 cd GeoModel_build
 cmake -B . -S ../GeoModel
 cmake --build .
 make install

 cd ..
