#!/bin/bash

if [ $EUID -ne 0 ]; then
  echo "Need to be root"
  exit 1
fi

rm -rf /usr/{share,local,local/share,lib,local/lib}/{locale,info,man,doc,docs,test,tests,examples,tutorials,README}/*
find /usr/{lib,libexec,local/lib} -name \*.la -delete
rm -rf /tools
rm -rf /var/log
rm -rf /root/.*

# save some files, dirs from /sources/ 
mkdir /sav
cd /sources
cp -rf *.sh .bash* md5sums wget-list Chapter* /sav/
cd ..
rm -rf /sources/*
cp -rf /sav/* /sources/
rm -rf /sav

last_fs_inode=
last_file=

{ find /usr/{lib,local/lib}  -type f -name '*.so*' ! -name '*dbg'
  find /usr/lib -type f -name '*.a'
  find /usr/{bin,sbin,libexec,local/bin,local/sbin} -type f
} | xargs stat -c '%m %i %n' | sort | while read fs inode file; do
       if ! readelf -h $file >/dev/null 2>&1; then continue; fi
       if file $file | grep --quiet --invert-match 'not stripped'; then continue; fi

       if [ "$fs $inode" = "$last_fs_inode" ]; then
         ln -f $last_file $file;
         continue;
       fi

       cp --preserve $file    ${file}.tmp
       strip --strip-unneeded ${file}.tmp
       mv ${file}.tmp $file

       last_fs_inode="$fs $inode"
       last_file=$file
done

