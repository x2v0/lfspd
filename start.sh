#!/bin/bash
#set -x

#./version-check.sh

if [ "$?" == "1" ]; then
  exit 1
fi

rm -f a.out

export LFS=/mnt/LFS
export LFS_TGT=x86_64-lfs-linux-gnu

sudo mkdir -pv "$LFS"
sudo mount "$LFS"
sudo chown -v lfs.lfs "$LFS"

mkdir -pv $LFS/sources
chmod -v a+wt $LFS/sources
mkdir -pv $LFS/tools
mkdir -pv $LFS/{etc,var,boot} $LFS/usr/{bin,lib,sbin}

chown -v lfs.lfs $LFS/{usr{,/*},var,etc,tools}

for i in bin lib sbin; do
    sudo ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
 x86_64) mkdir -pv $LFS/lib64 ;;
esac

cp -rf *.sh Dockerfile .bash* md5sums wget-list Chapter* $LFS/sources
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"

source $LFS/sources/download.sh

#CPU Core
#export MAKEFLAGS="-j$(nproc)"


## chmod +x
chmod ugo+x preparechroot.sh
chmod ugo+x insidechroot.sh
chmod ugo+x insidechroot2.sh
chmod ugo+x insidechroot3.sh
chmod ugo+x insidechroot4.sh
chmod ugo+x insidechroot5.sh

list=$(ls Chapter*/*sh | awk '{print  $1}')

for file in ${list}
do
  #echo "${file}"
  chmod ugo+x ${file}
done
##  chmodx

for p in binutils gcc linux glibc; do
    source packageinstall.sh 5 ${p}
done

pushd "$LFS/sources/gcc"
source $LFS/sources/Chapter5/libstc.sh
popd

for p in m4 ncurses bash coreutils help2man diffutils file findutils gawk grep gzip make patch sed tar xz binutils gcc; do
    source packageinstall.sh 6 ${p}
done

## chroot
sudo ./preparechroot.sh "$LFS"
echo "Entering CHROOT Environment..."
sleep 3


for script in \
/sources/insidechroot.sh  \
/sources/insidechroot2.sh \
/sources/insidechroot3.sh \
/sources/insidechroot4.sh \
/sources/insidechroot5.sh
do
    echo "RUNNING $script IN CHROOT!"
    sleep 3
    sudo chroot "$LFS" /usr/bin/env \
        HOME=/root \
        TERM="$TERM" \
        PS1='(lfs chroot) \u:\w\$ ' \
        PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin \
        TESTERUID=$UID \
        /bin/bash --login +h -c "$script"
done
