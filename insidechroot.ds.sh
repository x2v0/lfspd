#!/bin/bash

echo "Now Running Inside CHROOT!"
sleep 3

# Create essential directories
mkdir -pv /{boot,home,mnt,opt,srv}

# Create directories under /etc
mkdir -pv /etc/{opt,sysconfig}
mkdir -pv /lib/firmware

# Create media directories
mkdir -pv /media/{floppy,cdrom}

# Create directories under /usr
mkdir -pv /usr/{,local/}{include,src}
mkdir -pv /usr/local/{bin,lib,sbin}
mkdir -pv 
/usr/{,local/}share/{color,dict,doc,info,locale,ma
n}
mkdir -pv 
/usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}

# Create directories under /var
mkdir -pv /var/{cache,local,log,mail,opt,spool}
mkdir -pv /var/lib/{color,misc,locate}

# Create symbolic links
ln -sfv /run /var/run
ln -sfv /run/lock /var/lock

# Create /root and /tmp directories with specific 
permissions
install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp

# Create a symbolic link for /etc/mtab
ln -sv /proc/self/mounts /etc/mtab

# Create /etc/hosts file
cat > /etc/hosts << EOF
127.0.0.1 localhost $(hostname)
::1 localhost
EOF

# Create /etc/passwd file
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/usr/bin/false
daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
messagebus:x:18:18:D-Bus Message Daemon 
User:/run/dbus:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon 
User:/dev/null:/usr/bin/false
nobody:x:65534:65534:Unprivileged 
User:/dev/null:/usr/bin/false
EOF

# Create /etc/group file
cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
users:x:999:
nogroup:x:65534:
EOF

# Add a tester user to /etc/passwd and /etc/group
TESTERUID=1000  # Define TESTERUID if not already 
defined
echo 
"tester:x:$TESTERUID:101::/home/tester:/bin/bash" 
>> /etc/passwd
echo "tester:x:101:" >> /etc/group

# Create the tester home directory and set 
ownership
install -o tester -d /home/tester

# Set up DNS resolver
echo "nameserver 8.8.8.8" > /etc/resolv.conf

echo "Script completed successfully!"
