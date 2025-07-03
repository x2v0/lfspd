## Run Pythia8, Geant4 simulation in <code>lfspd docker container</code>

#### Load <code>lfspd</code> docker image

<code>docker pull <b>xtovo/lfspd</b></code>

#### Run <code>lfspd</code> container

<code>docker run -it -v $HOME/tmp:/root/tmp --user root --workdir /root <b>xtovo/lfspd</b> /bin/bash</code>

#### Clone FCCSW repository

<code>git clone https://github.com/HEP-FCC/FCCSW</code>

#### Goto python examples directory

<code>cd FCCSW/Examples/options</code>

<b>ls</b>
- Pythia_standard.cmd
- export_detector_gdml.py
- geant_fastsim.py
- geant_fastsim_tklayout.py
- geant_fullsim.py
- geant_fullsim_fccee_cld_hepevt.py
- geant_fullsim_fccee_cld_pgun.py
- geant_fullsim_fccee_idea_hepevt.py
- geant_fullsim_fccee_idea_pgun.py
- geant_fullsim_fccee_lar_pgun.py
- geant_fullsim_fcchh_main.py
- geant_fullsim_fcchh_tracker.py
- geant_fullsim_field.py
- geant_fullsim_userlimits.py
- input_example_GuineaPig.hepevt
- k4_workflow_blocks
- material_scan.py
- particle_gun.py
- pythia.py
- read_podio_input.py

#### Try to run each python script. For example:
<code>k4run geant_fullsim.py</code>

After a lot of info messages, the file <code><b>out_geant_fullsim.root</b></code> created.

#### One can run it with <b>gdb</b> debugger (type <code>"continue"</code> and <code>"Ctrl-C"</code> to interrupt)

<code>k4run geant_fullsim.py --gdb</code>

#### Save the file on the <code><b>host system</b></code>

<code>cp out_geant_fullsim.root /root/tmp</code> 

<b>/root/tmp</b> corresponds to <b>$HOME/tmp</b> on the host system

#### Exiting docker prompt will still have the docker container available. One can re-enter the same container by

<code>docker start \`docker ps -q -l\`
docker attach \`docker ps -q -l\`</code>


#### The list of working examples:

- geant_fastsim.py
- geant_fastsim_tklayout.py
- geant_fullsim.py
- geant_fullsim_field.py
- geant_fullsim_userlimits.py
- geant_fullsim_userlimits.py
- material_scan.py
- particle_gun.py

#### All examples of full simulation of FCC-hh, FCC-ee - failed because of missing detectors 

<code>geant_fullsim_fccee_\*.py
geant_fullsim_fcchh_\*.py</code>

#### Some explanation of examples can be found here  https://fccsw.web.cern.ch/fccsw/tutorials/
