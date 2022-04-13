<!-- "How to manage VMWare images" -->
MAAS 2.5 and above can deploy VMware ESXi as a custom image. MAAS cannot directly deploy the VMware ESXi ISO; you must create a specialised image from an official VMWare ISO. Canonical created a [packer](https://www.packer.io/) template to automate the image creation process.

#### This article will tell you:

* [About the prerequisites for creating a VMWare image](#heading--prerequisites-to-create-the-images)
* [About the features and limitations of VMWare images in MAAS](#heading--features-and-limitations)
* [How to customise VMWare images](#heading--customising-the-image)
* [How to build a VMWare image](#heading--building-an-image)
* [How to upload a VMWare image](#heading--uploading-an-image)

<a href="#heading--prerequisites-to-create-the-images"><h2 id="heading--prerequisites-to-create-the-images">About the prerequisites for creating a VMWare image</h2></a>

<a href="#heading--image-creation"><h3 id="heading--image-creation">About VMWare image creation</h3></a>

1.   A physical machine running Ubuntu 18.04+
2.   **CPU**: 4 2GHz cores
3.   **Memory**: 8 GB RAM (16 GB RAM recommended)
4.   **Disk space**: 11 GB
5.   [The VMWare ESXi ISO](https://my.vmware.com/en/web/vmware/evalcenter?p=free-esxi6)
6.   [Packer - https://www.packer.io/intro/getting-started/install.html](https://www.packer.io/intro/getting-started/install.html)
7.   Procedure was tested with precompiled 64-bit Packer 1.3.4 Linux binaries
8.   <a href="https://github.com/canonical/packer-maas">Packer template</a> for MAAS custom image

<a href="#heading--image-deployment"><h3 id="heading--image-deployment">About VMWare image deployment</h3></a>

1.   MAAS 2.5.0+

<a href="#heading--features-and-limitations"><h2 id="heading--features-and-limitations">About the features and limitations of VMWare images in MAAS</h2></a>

<a href="#heading--networking"><h3 id="heading--networking">About VMWare images and MAAS networking</h3></a>

1.   VMware ESXi does not support Linux bridges
2.   Bonds - MAAS maps the following bond modes to VMware ESXi NIC team sharing with load balancing as follows:
3.   balance-rr - portid
4.   active-backup - explicit
5.   802.3ad - iphash, LACP rate and XMIT hash policy settings are ignored.
6.   No other bond modes are currently supported.
7.   VMware ESXi does not allow VMs to use a PortGroup that has a VMK attached to it. All configured devices will have a VMK attached. To use a vSwitch with VMs, you must leave a device or alias unconfigured in MAAS.

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