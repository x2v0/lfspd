## Road to the future  

#### Add dpkg, apt package managers.

That will allow to load X11, GUI libs and other apps at runtime

##### <code>Debian Package Manager (dpkg)</code> built, but not working (need to build <code>libselinux.so</code>)

Dependencies:

<code>
        linux-vdso.so.1 (0x00007ffc23be8000)
        libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007fd824095000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fd823e6c000)
        libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007fd823dd5000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fd82439b000)
</code>

##### Failed to build <code>apt</code>

Dependencies:

<code>
        linux-vdso.so.1 (0x00007ffd8f99e000)
        libapt-private.so.0.0 => /lib/x86_64-linux-gnu/libapt-private.so.0.0 (0x00007f7ce7d17000)
        libapt-pkg.so.6.0 => /lib/x86_64-linux-gnu/libapt-pkg.so.6.0 (0x00007f7ce7b50000)
        libstdc++.so.6 => /lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f7ce7924000)
        libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f7ce7904000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f7ce76db000)
        libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f7ce76bd000)
        libbz2.so.1.0 => /lib/x86_64-linux-gnu/libbz2.so.1.0 (0x00007f7ce76aa000)
        liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f7ce767f000)
        liblz4.so.1 => /lib/x86_64-linux-gnu/liblz4.so.1 (0x00007f7ce765f000)
        libzstd.so.1 => /lib/x86_64-linux-gnu/libzstd.so.1 (0x00007f7ce7590000)
        libudev.so.1 => /lib/x86_64-linux-gnu/libudev.so.1 (0x00007f7ce7566000)
        libsystemd.so.0 => /lib/x86_64-linux-gnu/libsystemd.so.0 (0x00007f7ce749f000)
        libgcrypt.so.20 => /lib/x86_64-linux-gnu/libgcrypt.so.20 (0x00007f7ce735f000)
        libxxhash.so.0 => /lib/x86_64-linux-gnu/libxxhash.so.0 (0x00007f7ce734a000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f7ce7263000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f7ce7d8a000)
        libcap.so.2 => /lib/x86_64-linux-gnu/libcap.so.2 (0x00007f7ce7258000)
        libgpg-error.so.0 => /lib/x86_64-linux-gnu/libgpg-error.so.0 (0x00007f7ce7232000)
<code>
