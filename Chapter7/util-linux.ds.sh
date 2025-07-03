#!/usr/bin/bash

# 创建目录 /var/lib/hwclock
mkdir -pv /var/lib/hwclock

# 运行 configure 脚本，配置编译选项
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
  --libdir=/usr/lib \
  --runstatedir=/run \
  --docdir=/usr/share/doc/util-linux-2.39.1 \
  --disable-chfn-chsh \
  --disable-login \
  --disable-nologin \
  --disable-su \
  --disable-setpriv \
  --disable-runuser \
  --disable-pylibmount \
  --disable-static \
  --without-python \
&& make \
&& make install
