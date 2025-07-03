#!/bin/bash

sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake
sed -i 's/configure_file(.clang-tidy .clang-tidy COPYONLY)//g' CMakeLists.txt

./bootstrap --prefix=/usr        \
            --system-libs        \
            --mandir=/share/man  \
            --no-system-jsoncpp  \
            --no-system-cppdap   \
            --no-system-librhash \
            -- \
            -DCMAKE_INSTALL_DO_STRIP:BOOL=ON \
            -DBUILD_CursesDialog:BOOL=OFF \
            -DCMAKE_USE_SYSTEM_FORM:BOOL=OFF \
            -DSPHINX_MAN:BOOL=OFF \
            -DBUILD_TESTING:BOOL=OFF \
            -DCMAKE_Fortran_COMPILER:FILEPATH=/bin/gfortran

make
make install
