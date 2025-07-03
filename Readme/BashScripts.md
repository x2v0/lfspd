## Descriptions of bash scripts

- <code>[chroot.sh](../chroot.sh)</code> - enter <b>"chroot jail"</b>

Usage: <code>./chroot.sh $LFS</code>

- <code>[create_distro.sh](../create_distro.sh)</code>

When building from scratch is finished run <code>/sources/create_distros.sh</code>\
The file <code>lfspd.10.tar.gz</code> with distribution image will bee created in the <code>$LFS/Distro</code> directory.

- <code>[create_docker.sh](../create_docker.sh)</code>

After <code>[create_distro.sh](../create_distro.sh)</code> run <code>/sources/create_docker.sh</code>\
that creates <b>lfspd docker image</b> from <code>$LFS/Distro/lfspd.10.tar.gz</code>

- <code>[dock2tar.sh](../dock2tar.sh)</code>

Creates <code>./Distros/lfspd.10.tar</code> from <b>xtovo/lfspd</b> docker image

- <code>[night_build.sh](../night_build.sh)</code>

This script rebuilds <b>lfspd distro</b> from scratch on dedicated "machine" (Debian)\
This script is automatically executed every day at midnight

- <code>create_user.sh, env_user.sh, insidechroot\*.sh, download.sh, preparechroot.sh, start.sh, packageinstall.sh, strip-all.sh, umount.sh</code>

The set of scripts used to build <b>lfspd distro</b> from scratch.

- <code>[setenv.sh](../setenv.sh)</code>

This script sets env vars in the final chrooted system or in the <b>lfspd docker container</b>