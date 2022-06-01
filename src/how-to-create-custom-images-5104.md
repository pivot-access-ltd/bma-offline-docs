<!-- "How to create custom images" -->
[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages"]
MAAS supports deploying custom OS images.  Canonical provides both [lp:maas-image-builder](https://launchpad.net/maas-image-builder) and [gh:canonical/packer-maas](https://github.com/canonical/packer-maas) to support creating custom images. These custom images can include static Ubuntu images, created with whatever tool you choose, as well as other OS images.

Even so, Canonical suggests [customising machines](/t/how-to-customise-machines/5108) using cloud-init user_data or Curtin preseed data whenever possible.

This article will help you learn:

- [About static Ubuntu images](#heading--about-static-ubuntu-images)
- [About uploading hand-built Ubuntu images](#heading--about-uploading-hand-built-ubuntu-images)
- [About how MAAS handles these images](#heading--about-how-maas-handles-these-images)
- [About how MAAS boots these images](#heading--about-how-maas-boots-these-images)
- [About configuring deployed machine networking](#heading--about-configuring-deployed-machine-networking)
- [About configuring deployed machine storage](#heading--about-configuring-deployed-machine-storage)
- [About static image metrics](#heading--about-static-image-metrics)
- [How to upload a custom Ubuntu image](#heading--how-to-upload-a-custom-ubuntu-image)
- [How to build MAAS images](#heading--how-to-build-maas-images)


<a href="#heading--about-static-ubuntu-images"><h2 id="heading--about-static-ubuntu-images">About static Ubuntu images</h2></a>

MAAS provides the capability for you to build an Ubuntu OS image to deploy with MAAS, using any image-building method you choose.  You can create the image once, with a fixed configuration,and deploy it to many machines.  This fixed configuration can consist of anything that a normal image would contain: users, packages, etc.

<a href="#heading--about-uploading-hand-built-ubuntu-images"><h3 id="heading--about-uploading-hand-built-ubuntu-images">About uploading hand-built Ubuntu images</h3></a>

You can upload hand-built Ubuntu images, containing a kernel, bootloader, and a fixed configuration, for deployment to multiple machines.  The image can be built via a tool, such as [packer](https://github.com/canonical/packer-maas), or build with scripts. You can upload these images to the boot-resources endpoint, where it will then be available for deployment to machines.

At a minimum, this image must contain a kernel, a bootloader, and a `/curtin/curtin-hooks` script that configures the network. A sample can be found in the [packer-maas repos](https://github.com/canonical/packer-maas/tree/master/ubuntu/scripts). The image must be in raw img file format, since that is the format MAAS accepts for upload.  This is the most portable format, and the format most builders support. Upon completing the image build, you will upload this img file to the boot-resources endpoint, specifying the architecture for the image.

<a href="#heading--about-how-maas-handles-these-images"><h3 id="heading--about-how-maas-handles-these-images">About how MAAS handles these images</h3></a>

MAAS will save the image -- in the same way it would save a `tar.gz` file -- in the database.  MAAS can differentiate between custom Ubuntu images and custom non-Ubuntu images, generating appropriate pre-seed configurations for each image type.

MAAS will also recognise the base Ubuntu version, so it can apply the correct ephemeral OS version for installation.  Custom images are always deployed with the ephemeral operating system. The base_image field is used to select the appropriate version of the ephemeral OS to avoid errors. This ensures a smooth deployment later.

<a href="#heading--about-how-maas-boots-these-images"><h3 id="heading--about-how-maas-boots-these-images">About how MAAS boots these images</h3></a>

When you decide to deploy a machine with your uploaded, custom image, MAAS ensures that the machine receives the kernel, bootloader and root file system provided in the image. The initial boot loader takes over, and boots an ephemeral OS of the same Ubuntu version as the custom image, to reduce the chances of incompatibilities.  Curtin then writes your entire custom image to disk.  Once the custom image is written to disk, it is not modified by MAAS.

Note that custom non-Ubuntu images still use a standard Ubuntu ephemeral OS to boot, prior to installing the non-Ubuntu OS.

<a href="#heading--about-configuring-deployed-machine-networking"><h3 id="heading--about-configuring-deployed-machine-networking">About configuring deployed machine networking</h3></a>

If you deploy a machine with a custom Ubuntu image, MAAS allows you to configure the deployed machine's networks just like you would for any other MAAS machine.  If you create an interface and assign it to a subnet or static address, this will be reflected in the deployed machine.

For this reason, MAAS also does some initial diagnostics while installing the custom image.  MAAS will detect when a network configuration is not present and abort the installation with a warning.  Essentially, MAAS checks to be sure that `cloud-init` and `netplan` are present in the images written by `curtin`.  If not, MAAS won't deploy the machine with the image.

<a href="#heading--about-configuring-deployed-machine-storage"><h3 id="heading--about-configuring-deployed-machine-storage">About configuring deployed machine storage</h3></a>

If you deploy a machine with a custom Ubuntu image, you will also want to be able to configure storage, just like you would do with any other machine.  MAAS facilitates changes to the storage configuration.  You can resize the root partition, as well as attaching and formatting any additional block devices you may desire.

<a href="#heading--about-static-image-metrics"><h3 id="heading--about-static-image-metrics">About static image metrics</h3></a>

As a user, you want to keep track of how many static images are being used, and how many deployed machines are using static images.  The standard MAAS dashboard reflects both of these metrics.

<a href="#heading--how-to-upload-a-custom-ubuntu-image"><h2 id="heading--how-to-upload-a-custom-ubuntu-image">How to upload a custom Ubuntu image</h2></a>

Currently, custom Ubuntu images can be uploaded using the MAAS CLI,by creating a boot-resource, with a command similar to this one:

```nohighlight                                                                                                        	 
	maas $PROFILE boot-resources create \
        name='custom/ubuntu-custom'  \
        architecture=amd64/generic \
        title=’custom ubuntu’ \
        base_image=ubuntu/focal \
        filetype=ddraw \
        content@=./custom-ubuntu.img
 ```	 

When uploading a custom image, there is a new required field: `base_image`. This is not required for non-custom images to be uploaded, but any image with the `custom` prefix will require it.
[/tab]
[tab version="v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
MAAS supports deploying custom DD or TGZ images. Canonical provides both [lp:maas-image-builder](https://launchpad.net/maas-image-builder) and [gh:canonical/packer-maas](https://github.com/canonical/packer-maas) to support creating custom images; however, these tools do not currently support Ubuntu. Instead Canonical suggests [customising Ubuntu](/t/5108) using cloud-init user_data or Curtin preseed data.

This article will help you learn:

- [Why customised Ubuntu deployments aren't supported](#heading--why-customised-ubuntu-deployments-arent-supported)
- [Warnings on creating a custom Ubuntu image](#heading--warnings-on-creating-a-custom-ubuntu-image)
- [How to create a custom Ubuntu image for MAAS](#heading--how-to-create-a-custom-ubuntu-image-for-maas)

<a href="#heading--why-customised-ubuntu-deployments-arent-supported"><h3 id="heading--why-customised-ubuntu-deployments-arent-supported">Why customised Ubuntu deployments aren't supported</h3></a>

When the [MAAS stream](https://images.maas.io/ephemeral-v3/stable/) is generated by [lp:maas-images](https://launchpad.net/maas-images) it starts by downloading the base SquashFS rootfs from cloud-images.ubuntu.com that is used for all clouds. The SquashFS does not contain a kernel so [lp:maas-images](https://launchpad.net/maas-images) mounts the SquashFS with an overlay and chroots in. It then  installs a kernel and extra initramfs scripts from the cloud-initramfs-rooturl and cloud-initramfs-copymods packages to allow network booting. Once everything is installed the kernel and newly generated initramfs are pulled out of the overlay and everything is unmounted. [lp:maas-images](https://launchpad.net/maas-images)w provides the unmodified SquashFS, installed kernel, and generated initramfs as separate files on images.maas.io.

MAAS uses the kernel, initramfs, and SquashFS to perform network booting which allows commissioning, testing, and deployments. When deploying Ubuntu MAAS uses the same version of Ubuntu to network boot into and perform the deployment. This ensures there are no compatibility issues. Other operating systems use the Ubuntu version selected for the ephemeral environment for deployment.

Currently MAAS only allows custom images to be loaded as a single TGZ or DD.GZ, there is no way to upload a kernel, `initrd`, and `rootfs` as separate files. Even if MAAS was modified to allow the kernel, `initrd`, and `rootfs` as separate files MAAS requires `cloud-initramfs-copymods` and `cloud-initramfs-rooturl` to be included in the initrd. It is difficult for MAAS to detect if these scripts are missing and even harder for users to debug if they are missing.

<a href="#heading--warnings-on-creating-a-custom-ubuntu-image"><h3 id="heading--warnings-on-creating-a-custom-ubuntu-image">Warnings on creating a custom Ubuntu image</h3></a>

Note that:

- Custom images are always deployed with the ephemeral operating system. This can cause hard to debug errors. For example CentOS 6 can only be deployed by Ubuntu Xenial due to advances in the ext4 filesystem.
- MAAS will still install and configure the GA kernel. If your custom image contains a kernel it most likely won't be used. MAAS will not allow you to select which kernel(GA, HWE, lowlatency, etc) when deploying a custom Ubuntu image.
- All GNU/Linux custom images should be created as a TGZ to enable storage customisation. When a DD.GZ is used MAAS/Curtin simply writes the file to the filesystem.

<a href="#heading--how-to-create-a-custom-ubuntu-image-for-maas"><h3 id="heading--how-to-create-a-custom-ubuntu-image-for-maas">How to create a custom Ubuntu image for MAAS</h3></a>

Note: LXD may prevent device files from being created when extracting the rootfs, it is suggested to do this on metal or on a VM:

- Download the rootfs from images.maas.io
    `wget http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-root.tar.xz`
- Create a work directory
    `mkdir /tmp/work`
- Extract the rootfs
    `cd /tmp/work`
    `sudo tar xf ../focal-server-cloudimg-amd64-root.tar.xz`

    or

   `unsquashfs ../focal-server-cloudimg-amd64-root.squash`
- Setup chroot
   `sudo mount -o bind /proc /tmp/work/proc`
   `sudo mount -o bind /dev /tmp/work/dev`
   `sudo mount -o bind /sys /tmp/work/sys`
   `sudo mv /tmp/work/etc/resolv.conf /tmp/work/etc/resolv.conf.bak`
   `sudo cp /etc/resolv.conf /tmp/work/etc/`
- Chroot in
    `sudo chroot /tmp/work /bin/bash`
- Customise image
    `apt update`
    `apt dist-upgrade`
   `apt install emacs-nox jq tree`
    `apt autoremove`
- Exit chroot and unmount binds
  `exit`
   `sudo umount /tmp/work/proc`
   `sudo umount /tmp/work/dev`
   `sudo umount /tmp/work/sys`
   `sudo mv /tmp/work/etc/resolv.conf.bak /tmp/work/etc/resolv.conf`
- Create TGZ
   `sudo tar -czf ~/focal-custom.tgz -C /tmp/work .`
- Upload it to MAAS
    Note: Ubuntu release names and versions are reserved
    `maas $PROFILE boot-resources create name='custom/focal-custom' title='Ubuntu 20.04 Custom Image' architecture='amd64/generic' filetype='tgz' content@=~/focal-custom.tgz`
- Configure and deploy as normal
[/tab]
[/tabs]

<a href="#heading--how-to-build-maas-images"><h2 id="heading--how-to-build-maas-images">How to build MAAS images</h2></a>

There are two methods for building custom images to be deployed to MAAS machines: MAAS Image Builder, and [packer](https://www.packer.io/).  This section will help you learn:

- [About packer prequisites](#heading--about-packer-prequisites)
- [About packer deployment requirements](#heading--about-packer-deployment-requirements)
- [About customising images](#heading--about-customising-images)
- [About building images via a proxy](#heading--about-building-images-via-a-proxy)
- [How to use packer to build MAAS images](#heading--how-to-use-packer-to-build-maas-images)
- [How to use MAAS Image Builder to build MAAS images](#heading--how-to-use-maas-image-builder-to-build-maas-images)

<a href="#heading--about-packer-prequisites"><h3 id="heading--about-packer-prequisites">About packer prequisites</h3></a>

The following are required to to create a packer MAAS image:

* A machine running Ubuntu 18.04+ with the ability to run KVM virtual machines.
* qemu-utils
* qemu-system
* ovmf
* cloud-image-utils
* [Packer](https://www.packer.io/intro/getting-started/install.html)

<a href="#heading--about-packer-deployment-requirements"><h3 id="heading--about-packer-deployment-requirements">About packer deployment requirements</h3></a>

The following are required to deploy a packer MAAS image:

* [MAAS](https://maas.io) 3.0+
* [Curtin](https://launchpad.net/curtin) 21.0+

<a href="#heading--about-customising-images"><h3 id="heading--about-customising-images">About customising images</h3></a>

It is possible to customize the image either during the Ubuntu installation, or afterwards (before packing the final image). The former is done by providing [autoinstall config](https://ubuntu.com/server/docs/install/autoinstall), editing the _user-data-flat_ and _user-data-lvm_ files. The latter is performed by the _install-custom-packages_ script.

<a href="#heading--about-building-images-via-a-proxy"><h3 id="heading--about-building-images-via-a-proxy">About building images via a proxy</h3></a>

The Packer template downloads the Ubuntu net installer from the Internet. To tell Packer to use a proxy, set the HTTP_PROXY environment variable to your proxy server. Alternatively, you may redefine iso_url to a local file, set iso_checksum_type to none to disable the checksums, and remove iso_checksum_url.

<a href="#heading--how-to-use-packer-to-build-maas-images"><h3 id="heading--how-to-use-packer-to-build-maas-images">How to use packer to build MAAS images</h3></a>

[Packer](https://www.packer.io/) can be used to build images to be deployed by MAAS.  In order to use packer, you must have a [packer template](https://github.com/canonical/packer-maas) for the OS version you intend to build.

Currently, templates are available for:

- CentOS6
- CentOS7
- CentOS8
- RHEL7
- RHEL8
- Ubuntu custom images
- VMWare EXSi

This section will help you learn:

- [How to install packer](#heading--how-to-install-packer)
- [How to obtain templates](#heading--how-to-obtain-templates)
- [How to create and use packer images](#heading--how-to-create-a-packer-image)

Note that additional templates will be made available from time to time.

<a href="#heading--how-to-install-packer"><h4 id="heading--how-to-install-packer">How to install packer</h4></a>

Packer is easily installed from its Debian package:

```nohighlight
sudo apt install packer
```

It should install without additional prompts.

<a href="#heading--how-to-install-qemu-utils"><h5 id="heading--how-to-install-qemu-utils">How to install qemu-utils</h5></a>

You can install `qemu-utils` from Debian packages as follows:

```nohighlight
sudo apt install qemu-utils
```

<a href="#heading--how-to-install-qemu-system"><h5 id="heading--how-to-install-qemu-system">How to install qemu-system</h5></a>

You can install `qemu-system` from Debian packages as follows:

```nohighlight
sudo apt install qemu-system
```

<a href="#heading--how-to-install-ovmf"><h5 id="heading--how-to-install-ovmf">How to install ovmf</h5></a>

You can install `ovmf` from Debian packages as follows:

```nohighlight
sudo apt install ovmf
```

<a href="#heading--how-to-install-cloud-image-utils"><h5 id="heading--how-to-install-cloud-image-utils">How to install cloud-image-utils</h5></a>

You can install `cloud-image-utils` from Debian packages as follows:

```nohighlight
sudo apt install cloud-image-utils
```

<a href="#heading--how-to-obtain-templates"><h4 id="heading--how-to-obtain-templates">How to obtain templates</h4></a>

You can obtain the packer templates by cloning the [packer-maas github repository](https://github.com/canonical/packer-maas.git), like this:

```nohighlight
git clone https://github.com/canonical/packer-maas.git
```

Make sure to pay attention to where the repository is cloned.  The Packer template in this cloned repository creates a Ubuntu AMD64 image for use with MAAS.

<a href="#heading--how-to-create-a-packer-image"><h4 id="heading--how-to-create-a-packer-image">How to create and use packer images</h4></a>

This subsection will help you learn:

- [How to build a packer image](#heading--how-to-build-a-packer-image)
- [How to upload packer images to MAAS](#heading--how-to-upload-packer-images-to-maas)
- [About the default image username](#heading--about-the-default-image-username)


<a href="#heading--how-to-build-a-packer-raw-image"><h5 id="heading--how-to-build-a-packer-raw-image">How to build a packer raw image</h5></a>

To build a packer image, you must change to the template repository directory, then to the subdirectory for the image you want to build.  From that subdirectory, you can easily build a raw image with LVM, using the Makefile:

```nohighlight
$ make custom-ubuntu-lvm.dd.gz
```

This makefile will run for a couple of minutes before attempting to boot the image.  While waiting for the image to boot, packer will attempt to SSH into the machine repeatedly until it succeeds.  You will see terminal messages similar to this one for upwards of three to five minutes:

```nohighlight
2022/05/09 15:50:46 packer-builder-qemu plugin: [DEBUG] handshaking with SSH
2022/05/09 15:50:50 packer-builder-qemu plugin: [DEBUG] SSH handshake err: ssh: handshake failed: ssh: unable to authenticate, attempted methods [none password], no supported methods remain
2022/05/09 15:50:50 packer-builder-qemu plugin: [DEBUG] Detected authentication error. Increasing handshake attempts.
```

Eventually, you should see a successful SSH connection:

```nohighlight
2022/05/09 15:50:57 packer-builder-qemu plugin: [INFO] Attempting SSH connection to 127.0.0.1:2351...
2022/05/09 15:50:57 packer-builder-qemu plugin: [DEBUG] reconnecting to TCP connection for SSH
2022/05/09 15:50:57 packer-builder-qemu plugin: [DEBUG] handshaking with SSH
2022/05/09 15:51:17 packer-builder-qemu plugin: [DEBUG] handshake complete!
```

If the process seems to run for a long time, you can predict whether it's going to work by doing a series of `netstat -a` on the `IP:port` given in the connection attempt.  Attempts may fail repeatedly, but if you repeat the `netstat -a` command frequently, you will see some tentative connections, like this one:

```nohighlight
stormrider@neuromancer:~$ netstat -a | grep 2281
tcp        0      0 0.0.0.0:2281            0.0.0.0:*               LISTEN     
tcp        0      0 localhost:46142         localhost:2281          TIME_WAIT  
tcp        0      0 localhost:46120         localhost:2281          TIME_WAIT  
tcp        0      0 localhost:46138         localhost:2281          TIME_WAIT  
tcp        0      0 localhost:46134         localhost:2281          TIME_WAIT  
tcp        0      0 localhost:46130         localhost:2281          TIME_WAIT  
tcp        0      0 localhost:46124         localhost:2281          TIME_WAIT  
stormrider@neuromancer:~$ netstat -a | grep 2281
tcp        0      0 0.0.0.0:2281            0.0.0.0:*               LISTEN     
tcp        0      0 localhost:46142         localhost:2281          TIME_WAIT  
tcp        0      0 localhost:46146         localhost:2281          ESTABLISHED
tcp        0      0 localhost:2281          localhost:46146         ESTABLISHED
tcp        0      0 localhost:46138         localhost:2281          TIME_WAIT  
tcp        0      0 localhost:46134         localhost:2281          TIME_WAIT  
tcp        0      0 localhost:46130         localhost:2281          TIME_WAIT  
tcp        0      0 localhost:46124         localhost:2281          TIME_WAIT
```

This `ESTABLISHED` connection may not hold the first few times, but eventually, the SSH connection will be made, and the provisioning process will finish.  If you want to walk away and come back, be advised that the Makefile clears the terminal buffer at the end, but echoes one final instruction:

```nohighlight
rm OVMF_VARS.fd
```

You can check the validity of the operation with `ls`, like this:

```nohighlight
stormrider@neuromancer:~/mnt/Dropbox/src/git/packer-maas/ubuntu$ ls
custom-ubuntu-lvm.dd.gz  packages      seeds-lvm.iso     user-data-lvm
http                     packer_cache  ubuntu-flat.json
Makefile                 README.md     ubuntu-lvm.json
meta-data                scripts       user-data-flat
```

You can also manually run packer. Your current working directory must be in the subdirectory where the packer template is located.  In the case of this example, that's `packer-maas/ubuntu`. Once in `packer-maas/ubuntu`, you can generate an image with the following command sequence:

```nohighlight
$ sudo PACKER_LOG=1 packer build ubuntu-lvm.json
```

[note]
ubuntu-lvm.json is configured to run Packer in headless mode. Only Packer output will be seen. If you wish to see the installation output connect to the VNC port given in the Packer output, or change the value of headless to false in the JSON file.
[/note]

This process is non-interactive.

<a href="#heading--how-to-upload-packer-images-to-maas"><h5 id="heading--how-to-upload-packer-images-to-maas">How to upload packer images to MAAS</h5></a>

You can upload a packer image with the following command:

```nohighlight
$ maas admin boot-resources create \
    name='custom/ubuntu-raw' \
    title='Ubuntu Custom RAW' \
    architecture='amd64/generic' \
    filetype='ddgz' \
    content@=custom-ubuntu-lvm.dd.gz
```

Before relying on it in production, you should test your custom image by deploying it to a test (virtual) machine.  It's the machine named `open-gannet` in this listing:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "OS", "DISTRO"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-",
.osystem, .distro_series]) | @tsv' | column -t

HOSTNAME     SYSID   POWER  STATUS    OWNER  OS      DISTRO
--------     -----   -----  ------    -----  --      ------
valued-moth  e86c7h  on     Deployed  admin  ubuntu  focal
open-gannet  nk7x8y  on     Deployed  admin  custom  ubuntu-raw
```

<a href="#heading--about-the-default-image-username"><h5 id="heading--about-the-default-image-username">About the default image username</h5></a>

The default username for packer-created images is `ubuntu`, the same as the default username for other MAAS images.


<a href="#heading--how-to-use-maas-image-builder-to-build-maas-images"><h3 id="heading--how-to-use-maas-image-builder-to-build-maas-images">How to use MAAS Image Builder to build MAAS images</h3></a>

MAAS Image Builder is an older tool, still required to build some images (e.g., Windows images).  Wherever possible, we recommend you use `packer`, as described above.

[note]
In order to use MAAS Image Builder, you must purchase [Ubuntu Advantage for Infrastructure](https://support.canonical.com/ua/s/article/How-to-access-the-MAAS-Image-Builder-tool).
[/note]

This article will help you learn:

- [How to install MAAS Image Builder](#heading--install-mib) via a private Canonical PPA (which you can request)
- [How to create custom CentOS images](#heading--custom-centos-images)
- [How to create custom RHEL images](#heading--custom-rhel-images)
- [How to create Windows images](#heading--custom-windows-images)
- [How to create other kinds of custom images](#heading--other-custom-images)

You can customise most images as much or as little as you wish, then use them to commission machines with MAAS. 

<a href="#heading--install-mib"><h4 id="heading--install-mib">How to install MAAS Image Builder</h4></a>

To get MAAS Image Builder, you must be subscribed to a private PPA provided by Canonical Support to those customers who have purchased [Ubuntu Advantage for Infrastructure](https://support.canonical.com/ua/s/article/How-to-access-the-MAAS-Image-Builder-tool).  Note that the steps below will fail if you have not purchased Ubuntu Advantage and been subscribed to the private PPA by your Canonical support rep.

Once subscribed, you need to obtain your credentials at this external link:

https://launchpad.net/~/+archivesubscriptions

Also, you must add the repository with the <code>add-apt-repository</code> command.  Note: Be sure to substitute your unique URL in the command below:

    $ sudo add-apt-repository \
    “https://LaunchpadID:Password@private-ppa.launchpad.net/maas-image-builder-partners/stable/ubuntu"

Once you have added the private PPA, you can install the Image Builder like this:

    $ sudo apt-get install maas-image-builder

All done? Great!  Now you can build and customise images for MAAS machines, as shown in the sections below.

<a href="#heading--custom-centos-images"><h4 id="heading--custom-centos-images">How to create custom CentOS images</h4></a>

MAAS already provides the latest available CentOS 6, CentOS 7, and CentOS 8 for automatic download. If you need something else, though, MAAS Image Builder supports the ability to create various CentOS images.

<h5 id="heading--centos-nw-rqmts">Network Requirements</h5>

Access to the Internet is required, since you will need to start with one of these sites:

- http://mirror.centos.org - OS, updates, and extra repositories
- https://download.fedoraproject.org - EPEL
- https://copr-be.cloud.fedoraproject.org - Canonical maintained cloud-init repository

<h5 id="heading--images-behind-proxy">Creating images behind a proxy</h5>

MAAS Image Builder can create CentOS images behind a proxy -- just set the ‘http_proxy’ environment variable to _your_ particular proxy. Once deployed, <code>yum</code> will use this MAAS-configured proxy.

<h5 id="heading--centos-create-images">Creating the images</h5>

<code>maas-image-builder</code> is designed to automate the process of generating the images for MAAS and <code>curtin</code>.  Here are some specific examples:

    $ sudo maas-image-builder -o centos6-amd64-root-tgz --arch amd64 centos --edition 6 
    $ sudo maas-image-builder -o centos6-i386-root-tgz --arch i386 centos --edition 6
    $ sudo maas-image-builder -o centos7-amd64-root-tgz --arch amd64 centos --edition 7

<h5 id="heading--centos-customize-images">Customising CentOS images</h5>

Starting from MAAS Image Builder 1.0.4, customisation of CentOS images is now supported.  You can provide a custom kickstart, in _addition_ to the kickstart that MAAS Image Builder uses to create the images. You can customise your image like this:

    $ sudo maas-image-builder -o centos7-amd64-root-tgz --arch amd64 centos --edition 7 --custom-kickstart ./custom.ks

<h5 id="heading--centos-upload-images">Uploading the image into MAAS</h5>

Custom CentOS images can be uploaded to MAAS as shown in the command below.  _Do note_ that the name **must** start with ‘centos’ and **must** be one line:

    maas admin boot-resources create name=centos/centos6-custom architecture=amd64/generic content@=./build-output/centos-amd64-root-tgz

You can use the MAAS WebUI to check that your custom CentOS image is valid and selectable for deployment.

<a href="#heading--custom-rhel-images"><h4 id="heading--custom-rhel-images">How to create custom RHEL images</h4></a>

Currently, MAAS _only_ supports RHEL as a custom image. In future versions of MAAS, RHEL will be natively supported.

<h5 id="heading--rhel-requirements">Some Requirements</h5>

In order to create RHEL images, you will need access to these sites:

- A RHEL DVD ISO - Contains all RHEL archives which are not available without a license
- https://download.fedoraproject.org - Access to the EPEL repository to install required deps
- https://copr-be.cloud.fedoraproject.org - Access to the Canonical maintained cloud-init copr repository

<h5 id="heading--rhel-behind-proxy">Creating images behind a proxy</h5>

MAAS image builder supports creating RHEL images behind a proxy. To use a proxy when building a RHEL image, just set the ‘http_proxy’ environment variable to _your_ local proxy. Once deployed, <code>yum</code> will use the MAAS-configured proxy.

<h5 id="heading--rhel-create-images">Creating the images</h5>

To generate a usable RHEL image, <code>maas-image-builder</code> automates image generation; these images can be used by MAAS and <code>curtin</code>.

     $ sudo maas-image-builder -a amd64 -o rhel7-amd64-root-tgz rhel --rhel-iso blah.iso

<h5 id="heading--rhel-install">Install into MAAS</h5>

The custom RHEL image can be uploaded to MAAS, but note that the name **must** start with ‘rhel’ and **must** be expressed as a single line, like this:

    maas admin boot-resources create name=rhel/7 title="RedHat Enterprise Linux 7" architecture=amd64/generic content@=rhel7-amd64-root-tgz

<a href="#heading--custom-windows-images"><h4 id="heading--custom-windows-images">How to create Windows images</h4></a>

Since Windows is a proprietary operating system, MAAS can't download these images. You need to manually generate images to use with MAAS.  On the upside, the end result will be much simpler, since there are CLI and WebUI tools to upload a Windows ISO -- which _helps_ automate the process.

<b>Hyper-V 2012 R2</b>
In this example, Windows Hyper-V 2012 R2 is used, but rest assured that multiple versions are supported. Download the Hyper-V 2012 R2 ISO from Microsoft, so it can be used in the image generation process.  You can obtain the download at:

http://technet.microsoft.com/en-US/evalcenter/dn205299.aspx

There are several other supported versions (for --windows-edition):

- win2012
- win2012r2
- win2012hv
- win2012hvr2
- win2016
- win2016hv

<h5 id="heading--mib-windows">Image Builder</h5>

MAAS Image builder can automate the process of generating images for MAAS and <code>curtin</code>.  In this instance,  though, you need Windows drivers for your specific hardware.  You can obtain these windows drivers with the following command:

    sudo maas-image-builder -o windows-win2012hvr2-amd64-root-dd  windows \
    --windows-iso ~/Downloads/2012hvr2.ISO \
    --windows-edition win2012hvr2 [--windows-updates] \
    [--windows-drivers <folder/>]  [--windows-language en-US]

As an example, consider:

    sudo maas-image-builder -o windows-win2012hvr2-amd64-root-dd windows \
    --windows-iso win2012hvr2.iso  --windows-edition win2012hvr2 \
    --windows-updates --windows-drivers ~/Win2012hvr2_x64/DRIVERS/  --windows-language en-US

Please note that this will not <em>install</em> any Windows updates. In order to obtain an up-to-date image of Windows, be sure provide the <code>--windows-updates</code> flag. This requires access to a bridged connection with a DHCP server, an interface that can be specified with <code>-i</code>.

Also note that you may be required to have specific Windows drivers for this image to work in your hardware. Be sure you inject those drivers when installing them. Those drivers are the default <code>*.inf</code> files.

<h5 id="heading--mib-debug-windows">Debug</h5>

You can debug the Windows installation process by connecting to <code>localhost:5901</code> using a VNC client.

<h5 id="heading--windows-image-install">Install into MAAS</h5>

The generated images need to be placed into the correct directories so MAAS can deploy them onto a node:

    maas admin boot-resources create name=windows/win2012hvr2 \
    architecture=amd64/generic filetype=ddtgz \ 
    content@=./build-output/windows-win2012hvr2-amd64-root-dd 

Now, using the MAAS WebUI, a node can be selected to use Windows Hyper-V 2012 R2. This selection gets reset when a node is stopped, so make sure to set it _before_ starting nodes. You can also set the default operating system (and release) in the settings menu, which removes the need to set it per-node.

<a href="#heading--other-custom-images"><h4 id="heading--other-custom-images">How to create other kinds of custom images</h4></a>

To install other custom images, use the following command sequence:

    maas <user> boot-resources create name=<custom-image-codename> title="Ubuntu Custom Image" \
    architecture=amd64/generic content@=/location/of/custom/image/ubuntu-custom-root-tgz

As an example:

    maas admin boot-resources create name=custom1 \
    title=”Ubuntu Custom Image” architecture=amd64/generic \
    content@=/home/ubuntu/ubuntu-custom-root-tgz