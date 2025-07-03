## Running LFSPD

### **Running LFSPD in Docker**

1. **Pull the LFSPD Docker Image**  
   Download the LFSPD Docker image from Docker Hub:
   ```bash
   docker pull xtovo/lfspd
   ```

2. **Run the LFSPD Docker Container**  
   Start the container with a volume mount for output data:
   ```bash
   docker run -v /dir/to/output/data:/root/tmp -it xtovo/lfspd /bin/bash
   ```
   - Replace `/dir/to/output/data` with the desired directory on your host machine.

---

## Running LFSPD on a Local Computer

### **Convert Docker Image to Tarball**
To create `./Distros/lfspd.tar` from the `xtovo/lfspd` Docker image:
```bash
./dock2tar.sh
```

---

### **For Linux Users**

#### **Method: Using `chroot` Jail**
This method requires **sudo privileges**.

1. **Grant Sudo Privileges**  
   Add the following line to `/etc/sudoers` to allow passwordless sudo access:
   ```bash
   your_username ALL=(ALL) NOPASSWD:ALL
   ```

2. **Run the Distribution**  
   Execute the script to untar and activate the LFSPD system:
   ```bash
   ./run_distro.sh
   ```
   - The distribution will be extracted to `$HOME/tmp/lfspd` by default.
   - To specify a custom location:
     ```bash
     ./run_distro.sh 'your_preferred_location'
     ```
   - The script automatically calls `chroot` to activate the LFSPD system.

3. **Multiple Sessions**  
   You can run `./run_distro.sh` on different terminals to start multiple LFSPD sessions.

4. **Editing Projects**  
   You can edit C++ or Python projects located in `$HOME/tmp/lfspd` directly from the host system.

---

### **For Windows Users**

#### **Method: Using Windows Subsystem for Linux (WSL2)**

1. **Activate WSL2**  
   Run the following command in PowerShell to install WSL2:
   ```powershell
   .\WSL_Install.ps1
   ```

2. **Import LFSPD Distribution**  
   Import the LFSPD tarball into WSL:
   ```powershell
   wsl --import lfspd 'InstallLocation' 'path_to_lfspd.10.tar'
   ```
   - Example:
     ```powershell
     wsl --import lfspd D:\x2v0 D:\x2v0\wrk\lfspd\Distros\lfspd.10.tar
     ```

3. **Verify the Installation**  
   Check the list of installed WSL distributions:
   ```powershell
   wsl --list
   ```
   - Example Output:
     ```
     Windows Subsystem for Linux Distributions:
     docker-desktop (Default)
     CentOS7
     Ubuntu
     lfspd
     ```

4. **Run LFSPD**  
   Start the LFSPD distribution:
   ```powershell
   wsl -d lfspd
   ```

#### **Advantages of WSL2**
- All Windows programs and disks (e.g., `/mnt/c`, `/mnt/d`) are accessible from within LFSPD.
- You can use Windows-based editors like **VS Code** or **PyCharm** to edit C++ or Python projects while inside the LFSPD system.
