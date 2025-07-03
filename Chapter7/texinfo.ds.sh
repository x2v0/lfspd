#!/usr/bin/bash

# 运行配置脚本，检查系统环境并生成 Makefile
./configure --prefix=/usr && \
# 编译源代码
make && \
# 安装编译好的文件
make install
