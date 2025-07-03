#!/bin/bash

echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr
make install
ln -sv /usr/bin/vim /usr/bin/vi
