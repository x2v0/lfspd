#!/bin/bash

# Creates lfspd docker image from $LFS/Distro/lfspd.10.tar.gz

file="$LFS/Distro/lfspd.10.tar.gz"
docker=$(command -v docker)

if [ -f ${docker} ]
then
  if [ -f ${file} ]
  then
    ${docker} import ${file} lfspd
  fi 
fi





