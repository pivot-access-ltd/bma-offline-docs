<!-- "How to employ VMWare images" -->
MAAS 2.5 and above can deploy VMware ESXi as a custom image. MAAS cannot directly deploy the VMware ESXi ISO; you must create a specialised image from an official VMWare ISO. To automate the image creation process, Canonical [hosts a repository](https://github.com/canonical/packer-maas) with community-contributed [packer](https://www.packer.io/) templates.

#### This article will tell you:

- [About the prerequisites for creating a VMWare image](#heading--prerequisites-to-create-the-images)
- [About the features and limitations of VMWare images in MAAS](#heading--features-and-limitations)
- [How to customise VMWare images](#heading--customising-the-image)
- [How to build a VMWare image](#heading--building-an-image)
- [How to upload a VMWare image](#heading--uploading-an-image)

[note]
VMware [does not support cloning boot devices](https://kb.vmware.com/s/article/84280) - you may run into issues triggered by non-unique UUID.  [One such issue](https://kb.vmware.com/s/article/84349) may lead to data corruption on VMFS datastores when using cloned boot devices.
[/note]

<a href="#heading--prerequisites-to-create-the-images"><h2 id="heading--prerequisites-to-create-the-images">About the prerequisites for creating a VMWare image</h2></a>

The following are required in order to create and deploy a VMWare image:

- MAAS 2.5.0+
- A physical machine running Ubuntu 18.04+
- **CPU**: 4 2GHz cores
- **Memory**: 8 GB RAM (16 GB RAM recommended)
- **Disk space**: 11 GB
- [The VMWare ESXi ISO](https://my.vmware.com/en/web/vmware/evalcenter?p=free-esxi6)
- [Packer - https://www.packer.io/intro/getting-started/install.html](https://www.packer.io/intro/getting-started/install.html)
- Procedure was tested with precompiled 64-bit Packer 1.3.4 Linux binaries
- <a href="https://github.com/canonical/packer-maas">Packer template</a> for MAAS custom image

<a href="#heading--features-and-limitations"><h2 id="heading--features-and-limitations">About the features and limitations of VMWare images in MAAS</h2></a>

<a href="#heading--no-cloning-support"><h3 id="heading--no-cloning-support">About cloning VMWare images</h3></a>

VMware [does not support cloning boot devices](https://kb.vmware.com/s/article/84280) - you may run into issues triggered by non-unique UUID.  [One such issue](https://kb.vmware.com/s/article/84349) may lead to data corruption on VMFS datastores when using cloned boot devices.

<a href="#heading--networking"><h3 id="heading--networking">About VMWare images and MAAS networking</h3></a>

The following apply to VMWare image creation, with respect to MAAS networking:

- VMware ESXi does not support Linux bridges
- Bonds - MAAS maps the following bond modes to VMware ESXi NIC team sharing with load balancing as follows:
- balance-rr - portid
- active-backup - explicit
- 802.3ad - iphash, LACP rate and XMIT hash policy settings are ignored.
- No other bond modes are currently supported.
- VMware ESXi does not allow VMs to use a PortGroup that has a VMK attached to it. All configured devices will have a VMK attached. To use a vSwitch with VMs, you must leave a device or alias unconfigured in MAAS.

<a href="#heading--storage"><h3 id="heading--storage">About VMWare images and MAAS storage</h3></a>

Custom storage configuration is not supported because VMware ESXi expects specific disk formats. MAAS will extend datastore1 to the full size of the deployment disk. After deployment, VMware tools may be used to access the other disks.

<a href="#heading--esxi-hardware-support"><h3 id="heading--esxi-hardware-support">About ESXi Hardware Support</h3></a>

VMware has [very specific hardware requirements](https://www.vmware.com/resources/compatibility/search.php). In particular, running VMware ESXi is not supported in a virtual machine or MAAS virsh Pod.

<a href="#heading--customising-the-image"><h2 id="heading--customising-the-image">How to customise VMWare images</h2></a>

The image may be customize by modifying packer-maas/vmware-esxi/http/vmware-esxi-ks.cfg see Installation and Upgrade Scripts in the [VMware ESXi installation and Setup manual](https://docs.vmware.com/en/VMware-vSphere/6.7/vsphere-esxi-67-installation-setup-guide.pdf) for more information.

<a href="#heading--building-an-image"><h2 id="heading--building-an-image">How to build a VMWare image</h2></a>

Before an image is built the nbd kernel module must be loaded

    sudo modprobe nbd

Once the nbd kernel module is loaded your current working directory must be in the packer-maas/vmware-esxi directory

    cd /path/to/packer-maas/vmware-esxi

You can now start the image building process using packer with the following command:

    sudo packer build -var
    'vmware_esxi_iso_path=/path/to/VMware-VMvisor-Installer-6.7.0-8169922.x86_64.iso'
    vmware-esxi.json

<a href="#heading--uploading-an-image"><h2 id="heading--uploading-an-image">How to upload a VMWare image</h2></a>

Once you have created the image, upload it to MAAS, using the CLI, with the following command:

    maas $PROFILE boot-resources create name='esxi/6.7' title='VMware ESXi 6.7'
    architecture='amd64/generic' filetype='ddgz' content@=vmware-esxi.dd.gz
