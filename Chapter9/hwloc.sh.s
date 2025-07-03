#!/bin/bash

# The Hardware Locality (hwloc) software project. The Portable Hardware                                                                                 2 # Locality (hwloc) software package provides a portable abstraction
# across OS, versions, architectures, ...) of the hierarchical topology
# of modern architectures, including NUMA memory nodes, sockets, shared
# caches, cores and simultaneous multithreading. It also gathers various
# system attributes such as cache and memory information as well as the
# locality of I/O devices such as network interfaces, InfiniBand HCAs or
# GPUs. It primarily aims at helping applications with gathering
# information about modern computing hardware so as to exploit it
# accordingly and efficiently.

PKG="hwloc"
PKG_VERSION="2.9"
PKG_BUILD="1"
PKG_FULL="${PKG}-${PKG_VERSION}.${PKG_BUILD}"
PKG_FILE="${PKG_FULL}.tar.gz"
URL="https://download.open-mpi.org/release/${PKG}/v${PKG_VERSION}/${PKG_FILE}"
#MD5="556576a795bdd2c7d10de6886480065f"

./configure --prefix=/usr/local
make
make install

