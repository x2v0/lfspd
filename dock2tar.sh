#!/bin/bash

# Create lfspd.10.tar from lfspd docker image

cd ./Distros
docker pull xtovo/lfspd
docker save -o tmp.tar xtovo/lfspd
tar -xf tmp.tar
tmp_dir=$(find . -mindepth 1 -maxdepth 1 -type d)
mv ${tmp_dir}/layer.tar lfspd.10.tar
rm -f *.json *.md repositories tmp.tar
rm -rf ${tmp_dir}
