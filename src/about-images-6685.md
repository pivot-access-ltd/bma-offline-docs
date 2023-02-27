<a href="#heading--About-images"><h2 id="heading--About-images">About images</h2></a>

MAAS provides supported images for stable Ubuntu releases, and for CentOS 7 and CentOS 8.0 releases.  Other images can be [customised](/t/how-to-build-custom-images/5104) for use with MAAS.

This article will help you learn:

- [What is a MAAS image?](#heading--maas-image-anatomy)
- [How images get deployed onto a machine](#heading--how-images-deploy)
- [About boot sources and why they matter](#heading--boot-sources)

<a href="#heading--what-is-a-maas-image"><h3 id="heading--what-is-a-maas-image">What is a MAAS image?</h3></a>

MAAS images are more than just the operating system kernel.  In fact, a usable MAAS image consists of at least four things:

- a [bootloader](https://images.maas.io/ephemeral-v3/stable/bootloaders/)`↗`, which boots the computer to the point that an operating system can be loaded.  MAAS currently uses one of three types of bootloaders: open firmware, PXE, and UEFI.
- a bootable kernel.
- an initial ramdisk.
- a squashfs filesystem.

If you were to look at the `squashfs.manifest`, you'd see something like this:

```nohighlight
adduser	3.118ubuntu5
apparmor	3.0.4-2ubuntu2.1
apport	2.20.11-0ubuntu82.1
apport-symptoms	0.24
apt	2.4.5
apt-utils	2.4.5
base-files	12ubuntu4.1
base-passwd	3.5.52build1
bash	5.1-6ubuntu1
bash-completion	1:2.11-5ubuntu1
bc	1.07.1-3build1
bcache-tools	1.0.8-4ubuntu3
bind9-dnsutils	1:9.18.1-1ubuntu1.1
bind9-host	1:9.18.1-1ubuntu1.1
bind9-libs:amd64	1:9.18.1-1ubuntu1.1
binutils	2.38-3ubuntu1
binutils-common:amd64	2.38-3ubuntu1
binutils-x86-64-linux-gnu	2.38-3ubuntu1
bolt	0.9.2-1
bsdextrautils	2.37.2-4ubuntu3
bsdutils	1:2.37.2-4ubuntu3
btrfs-progs	5.16.2-1
busybox-initramfs	1:1.30.1-7ubuntu3
busybox-static	1:1.30.1-7ubuntu3
byobu	5.133-1
ca-certificates	20211016
cloud-guest-utils	0.32-22-g45fe84a5-0ubuntu1
cloud-init	22.2-0ubuntu1~22.04.3
cloud-initramfs-copymods	0.47ubuntu1
cloud-initramfs-dyn-netconf	0.47ubuntu1
command-not-found	22.04.0
console-setup	1.205ubuntu3
console-setup-linux	1.205ubuntu3
coreutils	8.32-4.1ubuntu1
cpio	2.13+dfsg-7
cron	3.0pl1-137ubuntu3
```

This snippet gives you a basic idea of the kinds of things that have to be loaded onto a drive in order for the system to function independently.

