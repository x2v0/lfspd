#/bin/bash
set -x

patch -Np1 -i ../unzip-6.0-consolidated_fixes-1.patch
sed -i 's/${LFLAGS1}/ -liconv/' ./unix/configure

make -f unix/Makefile generic

make prefix=/usr MANDIR=/usr/share/man/man1 \
 -f unix/Makefile install
