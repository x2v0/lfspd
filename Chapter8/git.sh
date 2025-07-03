#!/bin/bash

./configure --prefix=/usr                   \
            --with-gitconfig=/etc/gitconfig \
            --with-python=python3
make
make install

