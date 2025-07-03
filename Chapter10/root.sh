#!/bin/bash

git clone --branch latest-stable --depth=1 https://github.com/root-project/root.git root_src
mkdir root_build
cd root_build

#pip3 install -r ../root_src/requirements.txt
#set -x
export ROOTSYS="/usr/local"

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

cmake --build . -- install
source /usr/local/bin/thisroot.sh
ln -s  /usr/local/bin/root.exe  /usr/local/bin/root
ln -s  /usr/local/bin/rootn.exe  /usr/local/bin/rootn
ln -s  /usr/local/bin/rootnb.exe  /usr/local/bin/rootnb

cd ..
