#!/bin/bash

# 配置、编译和安装
./configure --prefix=/usr && \
make && \
make install && \
# 删除静态库文件
rm -fv /usr/lib/libz.a
