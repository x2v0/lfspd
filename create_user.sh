#!/bin/bash

[ ! -e /etc/bash.bashrc ] || sudo mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE

exist=$(getent passwd | cut -f1 -d: | grep -w "lfs")

if [ -z "$exist" ]; then
	sudo groupadd lfs
	sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs
	echo -e "lfs\nlfs" | sudo passwd lfs
	echo "lfs ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
fi

cp -rf *.sh .bash* md5sums wget-list Chapter* /home/lfs/

sudo su - lfs
