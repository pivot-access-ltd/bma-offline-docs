<!-- "How to build MAAS images" -->
There are two methods for building custom images to be deployed to MAAS machines: MAAS Image Builder, and [packer](https://www.packer.io/).  This article will help you learn:

- [How to use packer to build MAAS images](#heading--how-to-use-packer-to-build-maas-images)
- [How to use MAAS Image Builder to build MAAS images](#heading--how-to-use-maas-image-builder-to-build-maas-images)

<a href="#heading--how-to-use-packer-to-build-maas-images"><h2 id="heading--how-to-use-packer-to-build-maas-images">How to use packer to build MAAS images</h2></a>

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

<a href="#heading--how-to-install-packer"><h3 id="heading--how-to-install-packer">How to install packer</h3></a>

Packer is easily installed from its Debian package:

```nohighlight
sudo apt install packer
```

It should install without additional prompts.

<a href="#heading--how-to-install-qemu-utils"><h4 id="heading--how-to-install-qemu-utils">How to install qemu-utils</h4></a>

You can install `qemu-utils` from Debian packages as follows:

```nohighlight
sudo apt install qemu-utils
```

<a href="#heading--how-to-obtain-templates"><h3 id="heading--how-to-obtain-templates">How to obtain templates</h3></a>

You can obtain the packer templates by cloning the [packer-maas github repository](https://github.com/canonical/packer-maas.git), like this:

```nohighlight
git clone https://github.com/canonical/packer-maas.git
```

Make sure to pay attention to where the repository is cloned.  The Packer template in this cloned repository creates a Ubuntu AMD64 image for use with MAAS.

<a href="#heading--how-to-create-a-packer-image"><h3 id="heading--how-to-create-a-packer-image">How to create and use packer images</h3></a>

This subsection will help you learn:

- [About packer prequisites](#heading--about-packer-prequisites)
- [About packer deployment requirements](#heading--about-packer-deployment-requirements)
- [About customising images](#heading--about-customising-images)
- [About building images via a proxy](#heading--about-building-images-via-a-proxy)
- [How to build a packer image](#heading--how-to-build-a-packer-image)
- [How to upload packer images to MAAS](#heading--how-to-upload-packer-images-to-maas)
- [About the default image username](#heading--about-the-default-image-username)

<a href="#heading--about-packer-prequisites"><h4 id="heading--about-packer-prequisites">About packer prequisites</h4></a>

The following are required to to create a packer MAAS image:

* A machine running Ubuntu 18.04+ with the ability to run KVM virtual machines.
* qemu-utils
* ovmf
* cloud-image-utils
* [Packer](https://www.packer.io/intro/getting-started/install.html)

<a href="#heading--about-packer-deployment-requirements"><h4 id="heading--about-packer-deployment-requirements">About packer deployment requirements</h4></a>

The following are required to deploy a packer MAAS image:

* [MAAS](https://maas.io) 3.0+
* [Curtin](https://launchpad.net/curtin) 21.0+

<a href="#heading--about-customising-images"><h4 id="heading--about-customising-images">About customising images</h4></a>

It is possible to customize the image either during the Ubuntu installation, or afterwards (before packing the final image). The former is done by providing [autoinstall config](https://ubuntu.com/server/docs/install/autoinstall), editing the _user-data-flat_ and _user-data-lvm_ files. The latter is performed by the _install-custom-packages_ script.

<a href="#heading--about-building-images-via-a-proxy"><h4 id="heading--about-building-images-via-a-proxy">About building images via a proxy</h4></a>

The Packer template downloads the Ubuntu net installer from the Internet. To tell Packer to use a proxy, set the HTTP_PROXY environment variable to your proxy server. Alternatively, you may redefine iso_url to a local file, set iso_checksum_type to none to disable the checksums, and remove iso_checksum_url.

<a href="#heading--how-to-build-a-packer-image"><h4 id="heading--how-to-build-a-packer-image">How to build a packer image</h4></a>

You can easily build a raw image with LVM, using the Makefile:

```nohighlight
$ make custom-ubuntu-lvm.dd.gz
```

You can also build a TGZ image with the Makefile:

```shell
$ make custom-ubuntu.tar.gz
```

In addition, you can manually run packer. Your current working directory must be in `packer-maas/ubuntu`, where this file is located. Once in `packer-maas/ubuntu`, you can generate an image with the following command sequence:

```nohighlight
$ sudo PACKER_LOG=1 packer build ubuntu-lvm.json
```

or with this command sequence:

```nohighlight
$ sudo PACKER_LOG=1 packer build ubuntu-flat.json
```

[note]
ubuntu-lvm.json and ubuntu-flat.json are configured to run Packer in headless mode. Only Packer output will be seen. If you wish to see the installation output connect to the VNC port given in the Packer output or change the value of headless to false in the JSON file.
[/note]

This process is non-interactive.

<a href="#heading--how-to-upload-packer-images-to-maas"><h4 id="heading--how-to-upload-packer-images-to-maas">How to upload packer images to MAAS</h4></a>

You can upload a LVM raw image with the following command:

```nohighlight
$ maas admin boot-resources create \
    name='custom/ubuntu-raw' \
    title='Ubuntu Custom RAW' \
    architecture='amd64/generic' \
    filetype='ddgz' \
    content@=custom-ubuntu-lvm.dd.gz
```

You can upload a TGZ image to MAAS with this command:

```nohighlight
$ maas admin boot-resources create \
    name='custom/ubuntu-tgz' \
    title='Ubuntu Custom TGZ' \
    architecture='amd64/generic' \
    filetype='tgz' \
    content@=custom-ubuntu.tar.gz
```

<a href="#heading--about-the-default-image-username"><h4 id="heading--about-the-default-image-username">About the default image username</h4></a>

The default username for packer-created images is `ubuntu`, the same as the default username for other MAAS images.


<a href="#heading--how-to-use-maas-image-builder-to-build-maas-images"><h2 id="heading--how-to-use-maas-image-builder-to-build-maas-images">How to use MAAS Image Builder to build MAAS images</h2></a>

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

<a href="#heading--install-mib"><h3 id="heading--install-mib">How to install MAAS Image Builder</h3></a>

To get MAAS Image Builder, you must be subscribed to a private PPA provided by Canonical Support to those customers who have purchased [Ubuntu Advantage for Infrastructure](https://support.canonical.com/ua/s/article/How-to-access-the-MAAS-Image-Builder-tool).  Note that the steps below will fail if you have not purchased Ubuntu Advantage and been subscribed to the private PPA by your Canonical support rep.

Once subscribed, you need to obtain your credentials at this external link:

https://launchpad.net/~/+archivesubscriptions

Also, you must add the repository with the <code>add-apt-repository</code> command.  Note: Be sure to substitute your unique URL in the command below:

    $ sudo add-apt-repository \
    “https://LaunchpadID:Password@private-ppa.launchpad.net/maas-image-builder-partners/stable/ubuntu"

Once you have added the private PPA, you can install the Image Builder like this:

    $ sudo apt-get install maas-image-builder

All done? Great!  Now you can build and customise images for MAAS machines, as shown in the sections below.

<a href="#heading--custom-centos-images"><h3 id="heading--custom-centos-images">How to create custom CentOS images</h3></a>

MAAS already provides the latest available CentOS 6, CentOS 7, and CentOS 8 for automatic download. If you need something else, though, MAAS Image Builder supports the ability to create various CentOS images.

<h4 id="heading--centos-nw-rqmts">Network Requirements</h4>

Access to the Internet is required, since you will need to start with one of these sites:

- http://mirror.centos.org - OS, updates, and extra repositories
- https://download.fedoraproject.org - EPEL
- https://copr-be.cloud.fedoraproject.org - Canonical maintained cloud-init repository

<h4 id="heading--images-behind-proxy">Creating images behind a proxy</h4>

MAAS Image Builder can create CentOS images behind a proxy -- just set the ‘http_proxy’ environment variable to _your_ particular proxy. Once deployed, <code>yum</code> will use this MAAS-configured proxy.

<h4 id="heading--centos-create-images">Creating the images</h4>

<code>maas-image-builder</code> is designed to automate the process of generating the images for MAAS and <code>curtin</code>.  Here are some specific examples:

    $ sudo maas-image-builder -o centos6-amd64-root-tgz --arch amd64 centos --edition 6 
    $ sudo maas-image-builder -o centos6-i386-root-tgz --arch i386 centos --edition 6
    $ sudo maas-image-builder -o centos7-amd64-root-tgz --arch amd64 centos --edition 7

<h4 id="heading--centos-customize-images">Customising CentOS images</h4>

Starting from MAAS Image Builder 1.0.4, customisation of CentOS images is now supported.  You can provide a custom kickstart, in _addition_ to the kickstart that MAAS Image Builder uses to create the images. You can customise your image like this:

    $ sudo maas-image-builder -o centos7-amd64-root-tgz --arch amd64 centos --edition 7 --custom-kickstart ./custom.ks

<h4 id="heading--centos-upload-images">Uploading the image into MAAS</h4>

Custom CentOS images can be uploaded to MAAS as shown in the command below.  _Do note_ that the name **must** start with ‘centos’ and **must** be one line:

    maas admin boot-resources create name=centos/centos6-custom architecture=amd64/generic content@=./build-output/centos-amd64-root-tgz

You can use the MAAS WebUI to check that your custom CentOS image is valid and selectable for deployment.

<a href="#heading--custom-rhel-images"><h3 id="heading--custom-rhel-images">How to create custom RHEL images</h3></a>

Currently, MAAS _only_ supports RHEL as a custom image. In future versions of MAAS, RHEL will be natively supported.

<h4 id="heading--rhel-requirements">Some Requirements</h4>

In order to create RHEL images, you will need access to these sites:

- A RHEL DVD ISO - Contains all RHEL archives which are not available without a license
- https://download.fedoraproject.org - Access to the EPEL repository to install required deps
- https://copr-be.cloud.fedoraproject.org - Access to the Canonical maintained cloud-init copr repository

<h4 id="heading--rhel-behind-proxy">Creating images behind a proxy</h4>

MAAS image builder supports creating RHEL images behind a proxy. To use a proxy when building a RHEL image, just set the ‘http_proxy’ environment variable to _your_ local proxy. Once deployed, <code>yum</code> will use the MAAS-configured proxy.

<h4 id="heading--rhel-create-images">Creating the images</h4>

To generate a usable RHEL image, <code>maas-image-builder</code> automates image generation; these images can be used by MAAS and <code>curtin</code>.

     $ sudo maas-image-builder -a amd64 -o rhel7-amd64-root-tgz rhel --rhel-iso blah.iso

<h4 id="heading--rhel-install">Install into MAAS</h4>

The custom RHEL image can be uploaded to MAAS, but note that the name **must** start with ‘rhel’ and **must** be expressed as a single line, like this:

    maas admin boot-resources create name=rhel/7 title="RedHat Enterprise Linux 7" architecture=amd64/generic content@=rhel7-amd64-root-tgz

<a href="#heading--custom-windows-images"><h3 id="heading--custom-windows-images">How to create Windows images</h3></a>

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

<h4 id="heading--mib-windows">Image Builder</h4>

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

<h4 id="heading--mib-debug-windows">Debug</h4>

You can debug the Windows installation process by connecting to <code>localhost:5901</code> using a VNC client.

<h4 id="heading--windows-image-install">Install into MAAS</h4>

The generated images need to be placed into the correct directories so MAAS can deploy them onto a node:

    maas admin boot-resources create name=windows/win2012hvr2 \
    architecture=amd64/generic filetype=ddtgz \ 
    content@=./build-output/windows-win2012hvr2-amd64-root-dd 

Now, using the MAAS WebUI, a node can be selected to use Windows Hyper-V 2012 R2. This selection gets reset when a node is stopped, so make sure to set it _before_ starting nodes. You can also set the default operating system (and release) in the settings menu, which removes the need to set it per-node.

<a href="#heading--other-custom-images"><h3 id="heading--other-custom-images">How to create other kinds of custom images</h3></a>

To install other custom images, use the following command sequence:

    maas <user> boot-resources create name=<custom-image-codename> title="Ubuntu Custom Image" \
    architecture=amd64/generic content@=/location/of/custom/image/ubuntu-custom-root-tgz

As an example:

    maas admin boot-resources create name=custom1 \
    title=”Ubuntu Custom Image” architecture=amd64/generic \
    content@=/home/ubuntu/ubuntu-custom-root-tgz