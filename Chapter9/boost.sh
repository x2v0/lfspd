#!/bin/bash

# Boost provides a set of free peer-reviewed portable C++ source libraries.
# It includes libraries for linear algebra, pseudorandom number generation,
# multithreading, image processing, regular expressions and unit testing.

sed -i '/#include.*phoenix.*tuple.hpp.*/d' boost/phoenix/stl.hpp

./bootstrap.sh --prefix=/usr/local --with-python=/usr/bin/python3
./b2 stage threading=multi link=shared variant=release
./b2 install threading=multi link=shared

