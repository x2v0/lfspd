## **Linux for SPD (LFSPD) Overview**

LFSPD is built based on the following foundational books:

1. **[Linux From Scratch (LFS) Book](https://linuxfromscratch.org/lfs/downloads/12.0/LFS-BOOK-12.0-NOCHUNKS.html)**  
   - Provides the core instructions for building a custom Linux system from scratch.

2. **[Beyond Linux From Scratch (BLFS) Book](https://linuxfromscratch.org/blfs/downloads/stable/BLFS-BOOK-12.2-sysv-nochunks.html)**  
   - Extends LFS by adding instructions for installing additional software packages.

---

## **Chapter Structure**

The LFSPD build process is organized into chapters, each corresponding to a stage of the system's development:

### **Core Chapters (LFS-Based)**
- **[Chapter5](../Chapter5)**, **[Chapter6](../Chapter6)**, **[Chapter7](../Chapter7)**  
  - These chapters align with the corresponding chapters in the **[LFS Book](https://linuxfromscratch.org/lfs/downloads/12.0/LFS-BOOK-12.0-NOCHUNKS.html)**.  
  - They cover the initial setup, toolchain building, and basic system construction.

---

### **Extended Chapters (BLFS and Custom Packages)**

1. **[Chapter8](../Chapter8)**  
   - Includes additional packages from the **[BLFS Book](https://www.linuxfromscratch.org/blfs/downloads/stable/BLFS-BOOK-12.2-sysv-nochunks.html)**.  
   - **Output Image**: `lfspd.8.tar.gz`  
     - **Size**: **835 MB**  
     - **Scope**: Chapters 5–8.

2. **[Chapter9](../Chapter9)**  
   - Adds **[scientific software](../Chapter9)** to the system.  
   - **Output Image**: `lfspd.9.tar.gz`  
     - **Size**: **~1.3 GB**  
     - **Scope**: Chapters 5–9.

3. **[Chapter10](../Chapter10)**  
   - Incorporates **[CERN-specific packages](../Chapter10)**.  
   - **Output Image**: `lfspd.10.tar.gz`  
     - **Size**: **~4.2 GB**  
     - **Scope**: Chapters 5–10.

---

## **Summary of Output Images**

| **Chapter** | **Scope**          | **Output Image**       | **Size**   |
|-------------|--------------------|------------------------|------------|
| Chapter8    | Chapters 5–8       | `lfspd.8.tar.gz`       | 835 MB     |
| Chapter9    | Chapters 5–9       | `lfspd.9.tar.gz`       | ~1.3 GB    |
| Chapter10   | Chapters 5–10      | `lfspd.10.tar.gz`      | ~4.2 GB    |
