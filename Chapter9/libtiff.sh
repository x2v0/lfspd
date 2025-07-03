
mmkdir -p libtiff-build &&
cd        libtiff-build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr/local -G Ninja ..
ninja
ninja install

