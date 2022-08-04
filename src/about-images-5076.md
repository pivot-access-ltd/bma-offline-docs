<!-- "About images" -->
MAAS provides supported images for stable Ubuntu releases, and for CentOS 7 and CentOS 8.0 releases.  Other images can be [customised](/t/how-to-create-custom-images/5104) for use with MAAS.

This article will help you learn:

- [What is a MAAS image?](#heading--maas-image-anatomy)
- [About boot sources and why they matter](#heading--boot-sources)
- [How to select and import an image](/t/how-to-import-images/5124)
- [How to set up and use a local image mirror](/t/how-to-mirror-images-locally/5927)
- [How to use and manage VMWare images](/t/how-to-manage-vmware-images/5144)

<a href="#heading--what-is-a-maas-image"><h2 id="heading--what-is-a-maas-image">What is a MAAS image?</h2></a>

MAAS images are more than just the operating system kernel.  In fact, a usable MAAS image consists of at least four things:

- a [bootloader](https://images.maas.io/ephemeral-v3/stable/bootloaders/), which boots the computer to the point that an operating system can be loaded.  MAAS currently uses one of three types of bootloaders: open firmware, PXE, and UEFI.
- a [bootable kernel](https://images.maas.io/ephemeral-v3/stable/jammy/amd64/20220718/ga-22.04/generic/), like the general availability amd64 kernel visible at the link as "boot-kernel".
- an [initial ramdisk](https://images.maas.io/ephemeral-v3/stable/jammy/amd64/20220718/ga-22.04/generic/), the "boot-initrd" file also visible at the given link.
- a [squashfs filesystem](https://images.maas.io/ephemeral-v3/stable/jammy/amd64/20220718), which provides a basic disk image of system components and applications needed to get the system to a usable state.

If you glance at the `squashfs.manifest`, you'll see something like this:

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

This snippet gives you a basic idea of the kinds of things that have to be loaded onto a drive in order for the system to function independently.  Here's a conceptual view of the way that these images get booted into running MAAS machines:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c7ab7d1d6413dfcdf81e02cb901b09d6f784f0f6.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c7ab7d1d6413dfcdf81e02cb901b09d6f784f0f6.png"></a>

Note that the arrows don't imply direct action so much as a rough sequence of how the various pieces get loaded.  There are plenty of Ubuntu images available to load.  If you should choose to create a [custom image](/t/how-to-create-custom-images/5104) based on some other operating system, you will need a suitable template for [packer](https://www.packer.io/) -- in order to create an image that MAAS can deploy and boot.  Canonical informally maintains [quite a few of them](https://github.com/canonical/packer-maas), although it isn't impossible to create your own.

<a href="#heading--boot-sources"><h2 id="heading--boot-sources">About boot sources and why they matter</h2></a>

A region controller downloads its images from a boot source. The main characteristics of a boot source are location (URL) and an associated GPG public keyring.

[note]
A boot resource is another name for an image. So boot resources are found within a boot source.
[/note]

MAAS stores images in the region controller's database, from where the rack controller proxies them to the individual machines.  It's important to note that for ESXi images, network configuration includes only these five parameters:

1.   DHCP
2.   Static/auto IP assignments
3.   Aliases
4.   VLANs
5.   Bonds

Bonds are mapped to NIC teaming in only three ways:

1.   balance-rr -- portid
2.   active-backup -- explicit
3.   802.3ad -- iphash, LACP rate and XMIT hash policy settings ignored

MAAS comes configured with a boot source that should suffice for most users:

[`https://images.maas.io/ephemeral-v3/stable/`](https://images.maas.io/ephemeral-v3/stable/)

The above URL points to the 'stable' stream (for the v3 format). See [Local image mirror](/t/how-to-mirror-images-locally/5927) for some explanation regarding the availability of other streams.

Although the backend supports multiple boot sources, MAAS itself uses a single source. If multiple sources are detected, the web UI will print a warning and will be unable to manage images.