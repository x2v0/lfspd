#!/bin/bash


# The libpng package contains libraries used by other programs                        
# for reading and writing PNG files. The PNG format was designed               
# as a replacement for GIF and, to a lesser extent, TIFF,                  
# with many improvements and extensions and lack of patent problems. 


wget https://sourceforge.net/projects/libpng/files/libpng16/1.6.42/libpng-1.6.42.tar.gz
tar -xf libpng-1.6.42.tar.gz

pushd ${PKG_FULL}
gzip -cd ../libpng-1.6.39-apng.patch.gz | patch -p1

./configure --prefix=/usr --disable-static

make
make install

popd
