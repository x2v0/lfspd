#!/bin/bash

# this script rebuild lfspd distro from scratch on dedicated "machine" (Debian)
# executed every day at 0.0  

start=$(date)
 
clear

# cleanup $LFS
./umount.sh $LFS
rm -rf $LFS/*

# pull the latest 
git pull -p

# rebuild everthing
./start.sh

echo "night building finished !!!"
stop=$(date)

echo "start = ${start}"
echo "stop = ${stop}"


