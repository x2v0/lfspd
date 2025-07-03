#!/bin/bash

sed -i '/^udev/,$ s/^/#/' util/meson.build

mkdir build
cd    build

meson setup --prefix=/usr --buildtype=release .. 
ninja

ninja install
chmod u+s /usr/bin/fusermount3

cd ../..
