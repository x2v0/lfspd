#!/bin/bash

PKG="sqlite"
PKG_VERSION="342"
PKG_BUILD="0000"
PKG_FULL=${PKG}-autoconf-${PKG_VERSION}${PKG_BUILD}
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://sqlite.org/2023/${PKG_FILE}"
MD5="0c5a92bc51cf07cae45b4a1e94653dea" 


./configure --prefix=/usr/local \
            --disable-static    \
            --enable-fts{4,5}   \
            CPPFLAGS="-DSQLITE_ENABLE_COLUMN_METADATA=1 \
                      -DSQLITE_ENABLE_UNLOCK_NOTIFY=1   \
                      -DSQLITE_ENABLE_DBSTAT_VTAB=1     \
                      -DSQLITE_SECURE_DELETE=1          \
                      -DSQLITE_ENABLE_FTS3_TOKENIZER=1"
make
make install

