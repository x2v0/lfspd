#!/bin/bash

# Exit on error
set -e

# Location in which to install
INSTALL_PREFIX="/usr/local"

# EvtGen version or tag number (or branch name). No extra spaces on this line!
VERSION=R02-02-00

# HepMC version numbers - change HEPMCMAJORVERSION to 2 in order to use HepMC2
HEPMCMAJORVERSION="3"
HEPMC2VER="2.06.10"
HEPMC3VER="3.2.6"
HEPMC2PKG="HepMC-"$HEPMC2VER
HEPMC3PKG="HepMC3-"$HEPMC3VER
HEPMC2TAR="hepmc"$HEPMC2VER".tgz"
HEPMC3TAR=$HEPMC3PKG".tar.gz"

# Pythia version number with no decimal points, e.g. 8230 corresponds to version 8.230. This
# follows the naming convention of Pythia install tar files. Again, no extra spaces allowed.
PYTHIAVER=8310
PYTHIAPKG="pythia"$PYTHIAVER
PYTHIATAR=$PYTHIAPKG".tgz"

# Photos++ version number
PHOTOSVER="3.64"
PHOTOSPKG="PHOTOS"
PHOTOSDIR="PHOTOS."$PHOTOSVER
PHOTOSTAR=$PHOTOSDIR".tar.gz"

# Tauola++ version number
TAUOLAVER="1.1.8"
TAUOLAPKG="TAUOLA"
TAUOLADIR="TAUOLA."$TAUOLAVER
TAUOLATAR=$TAUOLADIR".tar.gz"

# Determine OS
osArch=`uname`

#This is for systems with cmake and cmake3
if command -v cmake3; then
    CMAKE=cmake3
else
    CMAKE=cmake
fi

echo Will install EvtGen version $VERSION and its dependencies in $INSTALL_PREFIX

# Make sure that the dependencies are picked up from our local install
delpath()
{
    eval "$1=\$(echo \$$1 | sed -e s%^$2\$%% -e s%^$2\:%% -e s%:$2\:%:%g -e s%:$2\\\$%%)"
}
addpath_front()
{
    delpath $*
    eval "$1=$2:\$$1"
}
addpath_front CMAKE_PREFIX_PATH $INSTALL_PREFIX
export CMAKE_PREFIX_PATH

BUILD_BASE=`mktemp -d` || exit 1

echo Temporary build area is $BUILD_BASE

cd $BUILD_BASE

mkdir -p tarfiles
mkdir -p sources
mkdir -p builds

echo Downloading EvtGen source from GIT

cd sources
git clone https://phab.hepforge.org/source/evtgen.git evtgen
cd evtgen
git checkout $VERSION

echo Downloading sources of external dependencies

cd $BUILD_BASE/tarfiles

if [ "$osArch" == "Darwin" ]
then
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
fi

if [ "$HEPMCMAJORVERSION" -lt "3" ]
then
    curl -O http://hepmc.web.cern.ch/hepmc/releases/$HEPMC2TAR
else
    curl -O http://hepmc.web.cern.ch/hepmc/releases/$HEPMC3TAR
fi
curl -O https://pythia.org/download/pythia${PYTHIAVER:0:2}/$PYTHIATAR
curl -O http://photospp.web.cern.ch/photospp/resources/$PHOTOSDIR/$PHOTOSTAR
curl -O http://tauolapp.web.cern.ch/tauolapp/resources/$TAUOLADIR/$TAUOLATAR

cd $BUILD_BASE/sources

echo Extracting external dependencies
if [ "$HEPMCMAJORVERSION" -lt "3" ]
then
    tar -xzf $BUILD_BASE/tarfiles/$HEPMC2TAR
else
    tar -xzf $BUILD_BASE/tarfiles/$HEPMC3TAR
fi
tar -xzf $BUILD_BASE/tarfiles/$PYTHIATAR
tar -xzf $BUILD_BASE/tarfiles/$PHOTOSTAR
tar -xzf $BUILD_BASE/tarfiles/$TAUOLATAR

# Patch TAUOLA and PHOTOS on Darwin (Mac)
if [ "$osArch" == "Darwin" ]
then
    sed -i '' 's/soname/install_name/g' PHOTOS/Makefile
    sed -i '' 's/soname/install_name/g' TAUOLA/Makefile
    patch -p0 < $BUILD_BASE/sources/evtgen/platform/tauola_Darwin.patch
    patch -p0 < $BUILD_BASE/sources/evtgen/platform/photos_Darwin.patch
    # Uncomment the lines below to force usage of clang
    # export CC=clang
    # export CXX=clang++
    # sed -i '' 's/\-lstdc++/-lc++/g' PHOTOS/platform/make.inc.in
    # sed -i '' 's/\-lstdc++/-lc++/g' TAUOLA/platform/make.inc.in
fi

cd $BUILD_BASE

if [ "$HEPMCMAJORVERSION" -lt "3" ]
then
    echo Installing HepMC from $BUILD_BASE/sources/$HEPMC2PKG
    mkdir -p $BUILD_BASE/builds/HepMC2
    cd $BUILD_BASE/builds/HepMC2
    $CMAKE -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_PREFIX $BUILD_BASE/sources/$HEPMC2PKG -Dmomentum:STRING=GEV -Dlength:STRING=MM
    make -j$(nproc)
    sudo make install

    echo Installing pythia8 from $BUILD_BASE/sources/$PYTHIAPKG
    cd $BUILD_BASE/sources/$PYTHIAPKG
    ./configure --enable-shared --prefix=$INSTALL_PREFIX
    make -j$(nproc)
    sudo make install

    echo Installing PHOTOS from $BUILD_BASE/sources/$PHOTOSPKG
    cd $BUILD_BASE/sources/$PHOTOSPKG
    ./configure --with-hepmc3= --with-hepmc=$INSTALL_PREFIX --prefix=$INSTALL_PREFIX
    make -j$(nproc)
    sudo make install

    if [ "$osArch" != "Darwin" ]
    then
        echo Installing TAUOLA from $BUILD_BASE/sources/$TAUOLAPKG
        cd $BUILD_BASE/sources/$TAUOLAPKG
        ./configure --without-hepmc3 --with-hepmc=$INSTALL_PREFIX --prefix=$INSTALL_PREFIX
        make -j$(nproc)
        sudo make install
    fi

else

    echo Installing HepMC3 from $BUILD_BASE/sources/$HEPMC3PKG
    mkdir -p $BUILD_BASE/builds/HepMC3
    cd $BUILD_BASE/builds/HepMC3
    $CMAKE -DHEPMC3_ENABLE_ROOTIO:BOOL=OFF -DHEPMC3_ENABLE_PYTHON:BOOL=OFF -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_PREFIX $BUILD_BASE/sources/$HEPMC3PKG
    make -j$(nproc)
    sudo make install

    echo Installing pythia8 from $BUILD_BASE/sources/$PYTHIAPKG
    cd $BUILD_BASE/sources/$PYTHIAPKG
    ./configure --enable-shared --prefix=$INSTALL_PREFIX
    make -j$(nproc)
    sudo make install

    echo Installing PHOTOS from $BUILD_BASE/sources/$PHOTOSPKG
    cd $BUILD_BASE/sources/$PHOTOSPKG
    ./configure --without-hepmc --with-hepmc3=$INSTALL_PREFIX --prefix=$INSTALL_PREFIX
    make -j$(nproc)
    sudo make install

    if [ "$osArch" != "Darwin" ]
    then
        echo Installing TAUOLA from $BUILD_BASE/sources/$TAUOLAPKG
        cd $BUILD_BASE/sources/$TAUOLAPKG
        ./configure --without-hepmc --with-hepmc3=$INSTALL_PREFIX --prefix=$INSTALL_PREFIX
        make -j$(nproc)
        sudo make install
    fi
fi

echo Installing EvtGen from $BUILD_BASE/sources/evtgen
mkdir -p $BUILD_BASE/builds/evtgen
cd $BUILD_BASE/builds/evtgen
if [ "$osArch" == "Darwin" ]
then
    if [ "$HEPMCMAJORVERSION" -lt "3" ]
    then
        $CMAKE -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_PREFIX $BUILD_BASE/sources/evtgen \
                -DEVTGEN_HEPMC3:BOOL=OFF -DHEPMC2_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_PYTHIA:BOOL=ON  -DPYTHIA8_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_PHOTOS:BOOL=ON  -DPHOTOSPP_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_TAUOLA:BOOL=OFF
    else
        $CMAKE -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_PREFIX $BUILD_BASE/sources/evtgen \
                -DEVTGEN_HEPMC3:BOOL=ON  -DHEPMC3_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_PYTHIA:BOOL=ON  -DPYTHIA8_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_PHOTOS:BOOL=ON  -DPHOTOSPP_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_TAUOLA:BOOL=OFF
    fi
else
    if [ "$HEPMCMAJORVERSION" -lt "3" ]
    then
        $CMAKE -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_PREFIX $BUILD_BASE/sources/evtgen \
                -DEVTGEN_HEPMC3:BOOL=OFF -DHEPMC2_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_PYTHIA:BOOL=ON  -DPYTHIA8_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_PHOTOS:BOOL=ON  -DPHOTOSPP_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_TAUOLA:BOOL=ON  -DTAUOLAPP_ROOT_DIR:PATH=$INSTALL_PREFIX
    else
        $CMAKE -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_PREFIX $BUILD_BASE/sources/evtgen \
                -DEVTGEN_HEPMC3:BOOL=ON  -DHEPMC3_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_PYTHIA:BOOL=ON  -DPYTHIA8_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_PHOTOS:BOOL=ON  -DPHOTOSPP_ROOT_DIR:PATH=$INSTALL_PREFIX \
                -DEVTGEN_TAUOLA:BOOL=ON  -DTAUOLAPP_ROOT_DIR:PATH=$INSTALL_PREFIX
    fi
fi
make -j$(nproc)
sudo make install

echo Setup done.
echo To complete, set the Pythia8 data path:
if [ "$PYTHIAVER" -lt "8200" ]
then
    echo PYTHIA8DATA=$INSTALL_PREFIX/xmldoc
else
    echo PYTHIA8DATA=$INSTALL_PREFIX/share/Pythia8/xmldoc
fi

echo If installation fully successful you can remove the temporary build area $BUILD_BASE
cd $BUILD_BASE
