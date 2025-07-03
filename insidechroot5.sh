#!/bin/bash

export CFLAGS="-Wno-error -Os"
export LFS=""
cd /sources

#for p in \
#do
source packageinstall.sh 10 HepPDT
#done

mkdir -p /var/log/Chapter10

doit() {
  source Chapter10/${1}.sh 2>&1 | tee /var/log/Chapter10/${1}.log
}

doit "veccore"
doit "VecGeom"
doit "libfmt"
doit "fastjet"
source Chapter10/py-packages.sh
doit "gperftools"
doit "jemalloc"
doit "root"
doit "geant"
doit "gaudi"
doit "HepMC3"
doit "HepMC"
doit "pythia"
doit "evtgen"
doit "podio"
doit "EDM4hep"
doit "DD4hep"
doit "GeoModel"
doit "acts"
doit "Vc"
doit "KFParticle" 
