#!/bin/bash

./configure --prefix=/usr                  \
            --disable-static               \
            --with-openssl                 \
            --enable-threaded-resolver	   \
            --with-ca-path=/etc/ssl/certs

make
make install

