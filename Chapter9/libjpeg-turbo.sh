
mkdir build &&
cd    build &&

cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_BUILD_TYPE=RELEASE        \
      -DENABLE_STATIC=FALSE             \
      -DCMAKE_INSTALL_DOCDIR=/usr/local/share/doc/${PKG_FULL} \
      -DCMAKE_INSTALL_DEFAULT_LIBDIR=lib  \
      ..
make
make install

