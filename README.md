## Linux From Scratch PD [(russian)](README.ru.md)
DeepSeek processed \*\*\*.ds.\*\*

This is a set of Linux packages and scientific software for docker container. 
Supposed that hundreds of thousands of such dockers/jobs will run on the distributed network cluster.
It also can run locally as linux distro in chroot/proot jail or WSL2.

The main features of the distro:
- all applications will run in docker container in batch mode
   
  Distro does not contain X11, GUIs, mans, locales, tests, tutorials etc.
  
  It doesn't require any OS. This is "fake" Linux, imitates Linux distribution.
- all packages built from sources
- minimized by size (compiled with size optimization flags + stripped & cleaned) 
- set of packages for scientific programming <b>[Readme/packages.md](Readme/packages.md)</b>
- the latest versions of all the packages : glibc, gcc, perl, cmake, python etc.
- packages installed in <code>/usr /usr/local</code>. Greatly simpifies <b>setup scripts</b>
- customizable. Package not needed - comment it out & rebuild.

Based on the Linux From Scratch project https://www.linuxfromscratch.org/

<b>[BuildFromScratch.md](Readme/BuildFromScratch.md)</b> - how to build the distro from scratch

<b>[RunDistro.md](Readme/RunDistro.md)</b> - how to run the distro on a local machine

<b>[RunP8G4.md](Readme/RunP8G4.md)</b> - how to run <code>Pythia8</code> generation with full <code>Geant4</code> simulation in <code><b>lfspd docker container</b></code>

<b>[Readme/packages.md](Readme/packages.md)</b> - packages included in the distro and their descriptions

<b>[Readme](Readme)</b> - directory with detailed info

<b>[TODO](TODO.md)</b>

It contains <b> > 170</b> packages with the size of the distribution <b>~4.2 Gb </b>.</br>
That includes <b>2.2 Gb </b> of Geant4 data located on docker volumes. 
