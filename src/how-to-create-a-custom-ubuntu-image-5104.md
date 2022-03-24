rad-begin /snap/3.1/cli /snap/3.1/ui /deb/3.1/ui /deb/3.1/cli
MAAS supports deploying custom OS images.  Canonical provides both [lp:maas-image-builder](https://launchpad.net/maas-image-builder) and [gh:canonical/packer-maas](https://github.com/canonical/packer-maas) to support creating custom images. These custom images can include static Ubuntu images, created with whatever tool you choose, and deployed as described below. Even so, Canonical suggests [customising Ubuntu](/t/how-to-customise-machines/nnnn) using cloud-init user_data or Curtin preseed data whenever possible.

## About static Ubuntu images

MAAS provides the capability for you to build an Ubuntu OS image to deploy with MAAS, using any image-building method you choose.  You can create the image once, with a fixed configuration,and deploy it to many machines.  This fixed configuration can consist of anything that a normal image would contain: users, packages, etc.

### About uploading hand-built Ubuntu images

You can upload hand-built Ubuntu images, containing a kernel, bootloader, and a fixed configuration, for deployment to multiple machines.  The image can be built via a tool, such as [packer](https://github.com/canonical/packer-maas), or build with scripts. You can upload these images to the boot-resources endpoint, where it will then be available for deployment to machines.

At a minimum, this image must contain a kernel, a bootloader, and a `/curtin/curtin-hooks` script that configures the network. A sample can be found in the [packer-maas repos](https://github.com/canonical/packer-maas/tree/master/ubuntu/scripts). The image must be in raw img file format, since that is the format MAAS accepts for upload.  This is the most portable format, and the format most builders support. Upon completing the image build, you will upload this img file to the boot-resources endpoint, specifying the architecture for the image.

### About how MAAS handles these images

MAAS will save the image -- in the same way it would save a `tar.gz` file -- in the database.  MAAS can differentiate between custom Ubuntu images and custom non-Ubuntu images, generating appropriate pre-seed configurations for each image type.

MAAS will also recognise the base Ubuntu version, so it can apply the correct ephemeral OS version for installation.  Custom images are always deployed with the ephemeral operating system. The base_image field is used to select the appropriate version of the ephemeral OS to avoid errors. This ensures a smooth deployment later.

### About how MAAS boots these images

When you decide to deploy a machine with your uploaded, custom image, MAAS ensures that the machine receives the kernel, bootloader and root file system provided in the image. The initial boot loader takes over, and boots an ephemeral OS of the same Ubuntu version as the custom image, to reduce the chances of incompatibilities.  Curtin then writes your entire custom image to disk.  Once the custom image is written to disk, it is not modified by MAAS.

Note that custom non-Ubuntu images still use a standard Ubuntu ephemeral OS to boot, prior to installing the non-Ubuntu OS.

### About configuring deployed machine networking

If you deploy a machine with a custom Ubuntu image, MAAS allows you to configure the deployed machine's networks just like you would for any other MAAS machine.  If you create an interface and assign it to a subnet or static address, this will be reflected in the deployed machine.

For this reason, MAAS also does some initial diagnostics while installing the custom image.  MAAS will detect when a network configuration is not present and abort the installation with a warning.  Essentially, MAAS checks to be sure that `cloud-init` and `netplan` are present in the images written by `curtin`.  If not, MAAS won't deploy the machine with the image.

### About configuring deployed machine storage

If you deploy a machine with a custom Ubuntu image, you will also want to be able to configure storage, just like you would do with any other machine.  MAAS facilitates changes to the storage configuration.  You can resize the root partition, as well as attaching and formatting any additional block devices you may desire.

### About static image metrics

As a user, you want to keep track of how many static images are being used, and how many deployed machines are using static images.  The standard MAAS dashboard reflects both of these metrics.

## How to upload a custom Ubuntu image

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
rad-end

rad-begin /snap/2.9/ui /snap/3.0/ui /deb/2.9/ui /deb/3.0/ui /snap/2.9/cli /snap/3.0/cli /deb/2.9/cli /deb/3.0/cli

MAAS supports deploying custom DD or TGZ images. Canonical provides both [lp:maas-image-builder](https://launchpad.net/maas-image-builder) and [gh:canonical/packer-maas](https://github.com/canonical/packer-maas) to support creating custom images; however, these tools do not currently support Ubuntu. Instead Canonical suggests [customising Ubuntu](/t/how-to-customise-machines/nnnn) using cloud-init user_data or Curtin preseed data.

# Why customised Ubuntu deployments aren't supported

When the [MAAS stream](https://images.maas.io/ephemeral-v3/stable/) is generated by [lp:maas-images](https://launchpad.net/maas-images) it starts by downloading the base SquashFS rootfs from cloud-images.ubuntu.com that is used for all clouds. The SquashFS does not contain a kernel so [lp:maas-images](https://launchpad.net/maas-images) mounts the SquashFS with an overlay and chroots in. It then  installs a kernel and extra initramfs scripts from the cloud-initramfs-rooturl and cloud-initramfs-copymods packages to allow network booting. Once everything is installed the kernel and newly generated initramfs are pulled out of the overlay and everything is unmounted. [lp:maas-images](https://launchpad.net/maas-images)w provides the unmodified SquashFS, installed kernel, and generated initramfs as separate files on images.maas.io.

MAAS uses the kernel, initramfs, and SquashFS to perform network booting which allows commissioning, testing, and deployments. When deploying Ubuntu MAAS uses the same version of Ubuntu to network boot into and perform the deployment. This ensures there are no compatibility issues. Other operating systems use the Ubuntu version selected for the ephemeral environment for deployment.

Currently MAAS only allows custom images to be loaded as a single TGZ or DD.GZ, there is no way to upload a kernel, `initrd`, and `rootfs` as separate files. Even if MAAS was modified to allow the kernel, `initrd`, and `rootfs` as separate files MAAS requires `cloud-initramfs-copymods` and `cloud-initramfs-rooturl` to be included in the initrd. It is difficult for MAAS to detect if these scripts are missing and even harder for users to debug if they are missing.

# Warnings on creating a custom Ubuntu image
1. Custom images are always deployed with the ephemeral operating system. This can cause hard to debug errors. For example CentOS 6 can only be deployed by Ubuntu Xenial due to advances in the ext4 filesystem.
2. MAAS will still install and configure the GA kernel. If your custom image contains a kernel it most likely won't be used. MAAS will not allow you to select which kernel(GA, HWE, lowlatency, etc) when deploying a custom Ubuntu image.
3. All GNU/Linux custom images should be created as a TGZ to enable storage customisation. When a DD.GZ is used MAAS/Curtin simply writes the file to the filesystem.

# How to create a custom Ubuntu image for MAAS

Note: LXD may prevent device files from being created when extracting the rootfs, it is suggested to do this on metal or on a VM:

1. Download the rootfs from images.maas.io
    `wget http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-root.tar.xz`
2. Create a work directory
    `mkdir /tmp/work`
3. Extract the rootfs
    `cd /tmp/work`
    `sudo tar xf ../focal-server-cloudimg-amd64-root.tar.xz`

    or

   `unsquashfs ../focal-server-cloudimg-amd64-root.squash`
4. Setup chroot
   `sudo mount -o bind /proc /tmp/work/proc`
   `sudo mount -o bind /dev /tmp/work/dev`
   `sudo mount -o bind /sys /tmp/work/sys`
   `sudo mv /tmp/work/etc/resolv.conf /tmp/work/etc/resolv.conf.bak`
   `sudo cp /etc/resolv.conf /tmp/work/etc/`
5. Chroot in
    `sudo chroot /tmp/work /bin/bash`
6. Customise image
    `apt update`
    `apt dist-upgrade`
   `apt install emacs-nox jq tree`
    `apt autoremove`
7. Exit chroot and unmount binds
  `exit`
   `sudo umount /tmp/work/proc`
   `sudo umount /tmp/work/dev`
   `sudo umount /tmp/work/sys`
   `sudo mv /tmp/work/etc/resolv.conf.bak /tmp/work/etc/resolv.conf`
8. Create TGZ
   `sudo tar -czf ~/focal-custom.tgz -C /tmp/work .`
9. Upload it to MAAS
    Note: Ubuntu release names and versions are reserved
    `maas $PROFILE boot-resources create name='custom/focal-custom' title='Ubuntu 20.04 Custom Image' architecture='amd64/generic' filetype='tgz' content@=~/focal-custom.tgz`
10. Configure and deploy as normal
rad-end
