## Building from scratch under Ubuntus (18.04 - 22.04) and Debian

#### Disclaimer. There is no guarantee to build it successfully because of changes in packages. 
<code>Once a week I check consistency of build procedure</code>

#### This procedure describes how to build distro by compiling all packages from source  

- You need > 30 Gb of free disk space

- Run it under <code><b>root</b></code> account


#### Install some packages
<code>apt update && apt upgrade -y</code>

<code>apt install wget git python3 binutils bison gawk gcc m4 make patch build-essential -y</code>

#### clone lfspd
<code>git clone https://git.jinr.ru/x2v0/lfspd</code>

### go to lfspd directory
<code>cd lfspd</code>

#### Create <code>lfs</code> user (password: <code>lfs</code>)
<code>./create_user.sh</code>

#### Set an enviroment
<code>sudo ./env_user.sh</code>

#### Build the distribution
<code>./start.sh</code>

#### To check the status of building, look at <code>$LFS/var/log/</code>

<code><b>grep "Error" $LFS/var/log/Chapter*/*.log </b></code>



## Create LFSPD Distro


#### When building is finished with success, run 
<code>cd /home/lfs</code>

#### Enter "chroot jail"
<code>./chroot.sh $LFS</code>


#### Build HSF packages from sources

<code>cd /root</code>

<code>git clone https://git.jinr.ru/x2v0/hsf</code>

<code>cd hsf</code>

<code>./doit.sh</code>

#### Finally build <code>LFSPD Distro</code>
<code>cd /sources</code>

<code>./create_distro.sh</code>

<code>$LFS/Distro</code> (<code>/mnt/LFS/Distro</code>) contains tarball with distro image <code>lfspd.10.tar.gz</code>
