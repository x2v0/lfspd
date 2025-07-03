## Building LFSPD from Scratch on Ubuntu (18.04 - 22.04) and Debian

### **Disclaimer**
There is no guarantee of a successful build due to potential changes in packages.  
**Note**: The build procedure is checked for consistency **once a week**.

---

### **Overview**
This procedure describes how to build the LFSPD distribution by compiling all packages from source.  

#### **Requirements**
- **Disk Space**: > 30 GB of free space.
- **Permissions**: Run the procedure under the **`root`** account.

---

### **Step 1: Install Required Packages**
Update the system and install necessary tools:
```bash
apt update && apt upgrade -y
apt install wget git python3 binutils bison gawk gcc m4 make patch build-essential -y
```

---

### **Step 2: Clone the LFSPD Repository**
Clone the LFSPD repository:
```bash
git clone https://git.jinr.ru/x2v0/lfspd
```

---

### **Step 3: Set Up the Build Environment**
1. Navigate to the `lfspd` directory:
   ```bash
   cd lfspd
   ```

2. Create the `lfs` user (password: `lfs`):
   ```bash
   ./create_user.sh
   ```

3. Set up the environment:
   ```bash
   sudo ./env_user.sh
   ```

---

### **Step 4: Build the Distribution**
Start the build process:
```bash
./start.sh
```

#### **Monitoring the Build**
- Check the build status by inspecting logs in `$LFS/var/log/`:
  ```bash
  grep "Error" $LFS/var/log/Chapter*/*.log
  ```

---

### **Step 5: Create the LFSPD Distro**

#### **1. Enter the Chroot Environment**
After a successful build, navigate to the `lfs` user directory and enter the chroot environment:
```bash
cd /home/lfs
./chroot.sh $LFS
```

#### **2. Build HSF Packages**
1. Clone the HSF repository:
   ```bash
   cd /root
   git clone https://git.jinr.ru/x2v0/hsf
   ```

2. Build the HSF packages:
   ```bash
   cd hsf
   ./doit.sh
   ```

#### **3. Create the LFSPD Distro Image**
1. Navigate to the `sources` directory:
   ```bash
   cd /sources
   ```

2. Generate the distro image:
   ```bash
   ./create_distro.sh
   ```

3. The resulting tarball `lfspd.10.tar.gz` will be located in:
   ```bash
   $LFS/Distro  # or /mnt/LFS/Distro
   ```

