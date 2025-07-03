## Running Pythia8 and Geant4 Simulations in the LFSPD Docker Container

### **Step 1: Load the LFSPD Docker Image**
Pull the LFSPD Docker image from Docker Hub:
```bash
docker pull xtovo/lfspd
```

---

### **Step 2: Run the LFSPD Container**
Start the container with a volume mount for data exchange and set the working directory:
```bash
docker run -it -v $HOME/tmp:/root/tmp --user root --workdir /root xtovo/lfspd /bin/bash
```
- `-v $HOME/tmp:/root/tmp`: Maps the host's `$HOME/tmp` directory to `/root/tmp` in the container for file sharing.
- `--user root`: Runs the container as the root user.
- `--workdir /root`: Sets the working directory to `/root`.

---

### **Step 3: Clone the FCCSW Repository**
Clone the FCCSW repository to access simulation examples:
```bash
git clone https://github.com/HEP-FCC/FCCSW
```

---

### **Step 4: Navigate to Python Examples**
Change to the directory containing the simulation scripts:
```bash
cd FCCSW/Examples/options
```
List the available scripts:
```bash
ls
```
**Example Scripts**:
- `Pythia_standard.cmd`
- `geant_fastsim.py`
- `geant_fullsim.py`
- `geant_fullsim_fccee_cld_hepevt.py`
- `geant_fullsim_fcchh_main.py`
- `particle_gun.py`
- ... and more.

---

### **Step 5: Run a Simulation Example**
Execute a simulation script, for example:
```bash
k4run geant_fullsim.py
```
- After running, the output file `out_geant_fullsim.root` will be created.

---

### **Step 6: Debugging with GDB**
Run the simulation with the GDB debugger:
```bash
k4run geant_fullsim.py --gdb
```
- Use `continue` to start execution and `Ctrl-C` to interrupt.

---

### **Step 7: Save Output to the Host System**
Copy the output file to the shared directory for access on the host system:
```bash
cp out_geant_fullsim.root /root/tmp
```
- `/root/tmp` in the container corresponds to `$HOME/tmp` on the host system.

---

### **Step 8: Re-enter the Docker Container**
If you exit the container, you can re-enter it using:
```bash
docker start `docker ps -q -l`
docker attach `docker ps -q -l`
```

---

### **List of Working Examples**
The following scripts are confirmed to work:
- `geant_fastsim.py`
- `geant_fastsim_tklayout.py`
- `geant_fullsim.py`
- `geant_fullsim_field.py`
- `geant_fullsim_userlimits.py`
- `material_scan.py`
- `particle_gun.py`

---

### **Known Issues**
- **FCC-hh and FCC-ee Full Simulations**:  
  Scripts like `geant_fullsim_fccee_*.py` and `geant_fullsim_fcchh_*.py` fail due to missing detector configurations.

---

### **Additional Resources**
For more details on the examples, refer to the FCCSW tutorials:  
[https://fccsw.web.cern.ch/fccsw/tutorials/](https://fccsw.web.cern.ch/fccsw/tutorials/)
