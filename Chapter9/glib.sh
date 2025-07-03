#!/bin/bash

mkdir build
cd    build

meson setup ..            \
      --prefix=/usr 	  \
      --buildtype=release
ninja
ninja install

cd ..
