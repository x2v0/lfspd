#!/bin/bash

#sed -i "s/add_subdirectory(doc)/#add_subdirectory(doc)/" CMakeLists.txt
#sed -i "s/add_subdirectory(tests)/#add_subdirectory(tests)/" CMakeLists.txt
#sed -i "s/add_subdirectory(samples)/#add_subdirectory(samples)/" CMakeLists.txt

# overwrite glibc's xerces-c
 ./configure --prefix=/usr --disable-static --enable-transcoder-iconv --disable-rpath --disable-network
make
make install

