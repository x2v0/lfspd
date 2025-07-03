## Run LFSPD docker

#### Get lfspd docker image from docker hub
<code>docker pull xtovo/lfspd</code>

#### Run lfspd docker
<code>docker run -v /dir/to/output/data:/root/tmp -it xtovo/lfspd /bin/bash</code>

## Run LFSPD distro on a local computer 

#### Create ./Distros/lfspd.tar from xtovo/lfspd docker image
<code>./dock2tar.sh</code>


### For Linux users


The method is based on [chroot jail](https://en.wikipedia.org/wiki/Chroot)


- one needs to have sudo privelege 

  Add the line <code>"your_username ALL=(ALL) NOPASSWD:ALL" to /etc/sudoers </code>

- run the script:

  <code>[./run_distro.sh](run_distro.sh)</code>

  That will untar distro in the <b>$HOME/tmp/lfspd</b>

  or <code>[./run_distro.sh](run_distro.sh) <b>'your prefered location'</b> </code>

  ... then <code>chroot</code> is automatically called and <code>LFSPD</code> system is activated

You can call <code>[run_distro.sh](run_distro.sh)</code> on different terminals to have several <code>LFSPD</code> sessions 

You can edit your C++, python projects in <code>LFSPD</code> located in <b>$HOME/tmp/lfspd</b> from the "host system"

### For Windows users. Run in PowerShell

- Activate [Windows Subsystem for Linux (WSL2)](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux)  <code>PS>[WSL_Install.ps1](WSL_Install.ps1)</code>

- Import <i>LFSPD</i> distribution <code>PS>wsl --import lfspd 'InstallLocation' 'path to lfspd.10.tar'</code>

In my case:

<code>PS>wsl --import <b>lfspd</b>  D:\x2v0  D:\x2v0\wrk\lfspd\Distros\lfspd.10.tar</code>

<b>lfspd</b> distribution is created

- Check it <code>PS>wsl --list</code>

In my case:

<p>
PS>wsl --list
<code>
Windows Subsystem for Linux Distributions:
docker-desktop (Default)
CentOS7
Ubuntu
<b>lfspd</b>
</code>
</p>

- Run <b>lfspd</b> <i>LFSPD</i> distribution 

<code>PS>wsl -d lfspd </code>

<b>The great advantage</b> of this approach that all Windows programs, disks (<code>/mnt/c, /mnt/d ...</code>) are availabe from inside <i>LFSPD</i>

For example, being inside LFSPD system you can edit C++ projects with <code>VS Code editor</code> or Python projects with <code>PyCharm IDE</code> 
