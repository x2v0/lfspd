#!/bin/bash

./configure --prefix=/usr/local \
            --sysconfdir=/etc   \
             --with-pcre=/usr/lib \
             --with-pcre2=/usr/lib \
             --disable-nls \
             --enable-vfs-cpio=no \
             --enable-vfs-fish=no \
             --enable-vfs-ftp=no \
             --enable-vfs-sftp=no \
             --disable-doxygen-doc \
             --enable-vfs-tar=no \
             --enable-charset=no \
             --enable-tests=no
make
make install

ln -s /usr/local/bin/mcedit /usr/local/bin/mce
