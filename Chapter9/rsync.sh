
git clone https://github.com/WayneD/rsync

groupadd -g 48 rsyncd
useradd -c "rsyncd Daemon" -m -d /home/rsync -g rsyncd \
    -s /bin/false -u 48 rsyncd

pushd rsync
./configure --prefix=/usr    \
            --disable-lz4    \
            --disable-xxhash \
            --disable-md2man \
            --without-included-zlib

make
make install

popd�
