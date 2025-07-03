#!/bin/bash

# Fix the path in GNUInstallDirs.cmake to remove '64' from "lib64"
sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake

# Remove the line that copies .clang-tidy file in CMakeLists.txt
sed -i 's/configure_file(.clang-tidy .clang-tidy COPYONLY)//g' CMakeLists.txt

# Bootstrap the build system with specific options
./bootstrap --prefix=/usr        \  # Install to /usr
            --system-libs        \  # Use system libraries
            --mandir=/share/man  \  # Set manual page directory
            --no-system-jsoncpp  \  # Do not use system jsoncpp
            --no-system-cppdap   \  # Do not use system cppdap
            --no-system-librhash \  # Do not use system librhash
            -- \
            -DCMAKE_INSTALL_DO_STRIP:BOOL=ON \  # Strip binaries during installation
            -DBUILD_CursesDialog:BOOL=OFF \    # Disable CursesDialog build
            -DCMAKE_USE_SYSTEM_FORM:BOOL=OFF \ # Do not use system form library
            -DSPHINX_MAN:BOOL=OFF \             # Disable Sphinx manual generation
            -DBUILD_TESTING:BOOL=OFF \         # Disable testing
            -DCMAKE_Fortran_COMPILER:FILEPATH=/bin/gfortran  # Specify Fortran compiler

# Build the project
make

# Install the project
make install
