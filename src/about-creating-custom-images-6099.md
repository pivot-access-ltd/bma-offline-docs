<!-- "About creating custom images" -->
You can create and customise your own images for MAAS using [packer](https://www.packer.io), with [Canonical-provided templates](https://github.com/canonical/packer-maas).  It is also possible to create your own templates, using the [packer documentation](https://www.packer.io/docs), although that effort might be completely unsupported.

<figure><a href="https://discourse.maas.io/uploads/default/original/2X/a/a80ed5eb191a798d049cb82fade4ee117f5128fd.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a80ed5eb191a798d049cb82fade4ee117f5128fd.png"></a><caption>A large MAAS instance deploying multiple custom OS images</caption></figure>

[note]
While it may be possible to deploy a certain image with MAAS, the particular use case may not be supported by that image’s vendor due to licensing or technical reasons. Canonical recommends that, whenever possible, you should customise machines using cloud-init user_data or Curtin preseed data, instead of creating a custom image.
[/note]

This article will help you learn:

- [About static Ubuntu images](#heading--about-static-ubuntu-images)
- [About uploading hand-built Ubuntu images](#heading--about-uploading-hand-built-ubuntu-images)
- [About how MAAS handles these images](#heading--about-how-maas-handles-these-images)
- [About how MAAS boots these images](#heading--about-how-maas-boots-these-images)
- [About configuring deployed machine networking](#heading--about-configuring-deployed-machine-networking)
- [About configuring deployed machine storage](#heading--about-configuring-deployed-machine-storage)
- [About static image metrics](#heading--about-static-image-metrics)
- [About packer](#heading--about-packer)
- [About packer dependencies](#heading--about-packer-dependencies)
- [About packer templates](#heading--about-packer-templates)
- [About the image installation process](#heading--about-the-image-installation-process)
- [About packer-created images](#heading--about-packer-created-images)

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

<a href="#heading--about-packer"><h2 id="heading--about-packer">About packer</h2></a>

The [packer documentation](https://www.packer.io/docs) has an excellent, in-depth discussion of what packer does, how it works, and where it is limited.  Simply put, packer creates OS images that can be uploaded and deployed using MAAS. We can summarise packer with the following linearised flowchart:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/47cb177f4ee2f52ac00c877449770a23cfa0c9b4.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/47cb177f4ee2f52ac00c877449770a23cfa0c9b4.jpeg"></a>

We can walk through packer operation like this:

 - A template is created or obtained which drives the packer build.  The [packer-maas](https://github.com/canonical/packer-maas) repository uses JSON templates.

 - The template specifies packer commands and data sources.

 - The template specifies a builder, which creates the MAAS-consumable images.

 - Multiple builds can run in parallel.  Within the MAAS domain, we typically don't set templates up that way, but it is possible to do so.

 - Post-processors do things to the built image to make it usable, e.g., compressing the file into a `tar.gz` image.

 - Provisioners spin up a running version of the image and install additional software, before collapsing the entire image into an upload package.

 - Because packer creates a wide-range of load packages, the results are called "artefacts" in packer terminology.  MAAS simply refers to these as "images".

Note that we said this flow is linearised.  You can see that provisioners might need to run before a post-processor creates an uploadable `tar.gz` image.  The actual flow depends on the template, which depends on the OS being customised into an image.  In the parlance of packer, all of these components -- builders, post-processors, provisioners -- are sometimes referred to collectively as "plugins".
    
<a href="#heading--about-packer-dependencies"><h2 id="heading--about-packer-dependencies">About packer dependencies</h2></a>

Depending upon which image you are building, packer-maas may require various dependencies.  For example, when customising an Ubuntu image, you'd need to install the following dependencies:

 - qemu-utils
 - qemu-system
 - ovmf
 - cloud-image-utils

These dependencies -- and the functionality they provide -- will be explained in the specific image sections which follow.

<a href="#heading--about-packer-templates"><h2 id="heading--about-packer-templates">About packer templates</h2></a>

A [packer template](https://www.packer.io/docs/templates) could just as easily be called a "packer script".  It contains declarations and commands that sequence and configure plugins.  Templates also have built-in functions to help you customise your artefacts. While packer is slowly transitioning to a dedicated language called HCL2, packer-maas still depends on JSON templates.

Templates are run by the packer `build` command.  Within packer-maas, packer commands (like `build`) are collected into makefiles that prevent you from having to know a lot about how packer works.  Even so, it's beneficial to take a quick tour of how a typical packer template works.  Let's use the [ubuntu-flat](https://github.com/canonical/packer-maas/blob/master/ubuntu/ubuntu-flat.json) template as a simple example.

[note]
Building workable templates is extremely difficult. This section is intended to familiarise you with templates and their components so that you can possibly pinpoint bugs in community-provided templates.  If you want to build your own template, you should rely on the [packer documentation](https://www.packer.io/docs) as your guide.
[/note]

This template builds a customised Ubuntu image with packer:

```nohighlight
{
    "variables": {
        "name": "ubuntu-20.04",
        "http_directory": "http",
        "http_proxy": "{{env `http_proxy`}}",
        "https_proxy": "{{env `https_proxy`}}",
        "no_proxy": "{{env `no_proxy`}}",
        "ssh_username": "ubuntu",
        "ssh_password": "ubuntu"
    },
    "builders": [
        {
            "boot_command": [
                "<wait>e<wait5>",
                "<down><wait><down><wait><down><wait2><end><wait5>",
                "<bs><bs><bs><bs><wait>autoinstall ---<wait><f10>"
            ],
            "boot_wait": "2s",
            "cpus": 2,
            "disk_size": "4G",
            "headless": true,
            "http_directory": "{{user `http_directory`}}",
            "iso_checksum": "file:http://releases.ubuntu.com/20.04/SHA256SUMS",
            "iso_url": "https://releases.ubuntu.com/focal/ubuntu-20.04.4-live-server-amd64.iso",
            "iso_target_path": "packer_cache/ubuntu.iso",
            "memory": 1024,
            "type": "qemu",
            "format": "raw",
            "qemuargs": [
                [ "-vga", "qxl"],
                [ "-device", "virtio-blk-pci,drive=drive0,bootindex=0" ],
                [ "-device", "virtio-blk-pci,drive=cdrom0,bootindex=1" ],
                [ "-device", "virtio-blk-pci,drive=drive1,bootindex=2" ],
                [ "-drive", "if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.fd"],
                [ "-drive", "if=pflash,format=raw,file=OVMF_VARS.fd"],
                [ "-drive", "file=output-qemu/packer-qemu,if=none,id=drive0,cache=writeback,discard=ignore,format=raw"],
                [ "-drive", "file=seeds-flat.iso,format=raw,cache=none,if=none,id=drive1"],
                [ "-drive", "file=packer_cache/ubuntu.iso,if=none,id=cdrom0,media=cdrom" ]
            ],
            "shutdown_command": "sudo -S shutdown -P now",
            "ssh_username": "{{user `ssh_username`}}",
            "ssh_password": "{{user `ssh_password`}}",
            "ssh_handshake_attempts": 500,
            "ssh_wait_timeout": "45m",
            "ssh_timeout": "45m"
        }
    ],
    "provisioners": [
        {
            "type": "file",
            "sources": [
                "{{template_dir}}/scripts/curtin-hooks",
                "{{template_dir}}/scripts/install-custom-packages",
                "{{template_dir}}/scripts/setup-bootloader",
                "{{template_dir}}/packages/custom-packages.tar.gz"
            ],
            "destination": "/tmp/"
        },
        {
            "environment_vars": [
                "HOME_DIR=/home/ubuntu",
                "http_proxy={{user `http_proxy`}}",
                "https_proxy={{user `https_proxy`}}",
                "no_proxy={{user `no_proxy`}}"
            ],
            "execute_command": "echo 'ubuntu' | {{.Vars}} sudo -S -E sh -eux '{{.Path}}'",
            "expect_disconnect": true,
            "scripts": [
                "{{template_dir}}/scripts/curtin.sh",
                "{{template_dir}}/scripts/networking.sh",
                "{{template_dir}}/scripts/cleanup.sh"
            ],
            "type": "shell"
        }
    ],
    "post-processors": [
        {
            "type": "shell-local",
            "inline_shebang": "/bin/bash -e",
            "inline": [
                "IMG_FMT=raw",
                "source ../scripts/setup-nbd",
                "OUTPUT=${OUTPUT:-custom-ubuntu.tar.gz}",
                "source ./scripts/tar-rootfs"
            ]
        }
    ]
}
```

You can see that the sections match the general flow of a `packer` session: declarations (variables); builders; provisioners; and post-processors.  We can deconstruct these briefly to understand what the template is doing.  This will help explain the image creation process.

<a href="#heading--variables"><h3 id="heading--variables">Variables (declaration section)</h3></a>

The variables section of this template looks like this:

```nohighlight
    "variables": {
        "name": "ubuntu-20.04",
        "http_directory": "http",
        "http_proxy": "{{env `http_proxy`}}",
        "https_proxy": "{{env `https_proxy`}}",
        "no_proxy": "{{env `no_proxy`}}",
        "ssh_username": "ubuntu",
        "ssh_password": "ubuntu"
    },
```

Most of this is straightforward.  We're going to use a base image of Ubuntu 20.04, keeping the HTTP files in directory `http` and making three possible proxy options available: HTTP, HTTPS, or no proxy.  The produced image will have an SSH username and password of "ubuntu".  It's that simple.

These declaration sections can get a lot more complicated, depending upon what's needed to make a clean image.  Note that most of the packer-maas templates are kept as simple as possible.

<a href="#heading--builders"><h3 id="heading--builders">Builder section</h3></a>

The builders section of this template is a little more robust:

```nohighlight
    "builders": [
        {
            "boot_command": [
                "<wait>e<wait5>",
                "<down><wait><down><wait><down><wait2><end><wait5>",
                "<bs><bs><bs><bs><wait>autoinstall ---<wait><f10>"
            ],
            "boot_wait": "2s",
            "cpus": 2,
            "disk_size": "4G",
            "headless": true,
            "http_directory": "{{user `http_directory`}}",
            "iso_checksum": "file:http://releases.ubuntu.com/20.04/SHA256SUMS",
            "iso_url": "https://releases.ubuntu.com/focal/ubuntu-20.04.4-live-server-amd64.iso",
            "iso_target_path": "packer_cache/ubuntu.iso",
            "memory": 1024,
            "type": "qemu",
            "format": "raw",
            "qemuargs": [
                [ "-vga", "qxl"],
                [ "-device", "virtio-blk-pci,drive=drive0,bootindex=0" ],
                [ "-device", "virtio-blk-pci,drive=cdrom0,bootindex=1" ],
                [ "-device", "virtio-blk-pci,drive=drive1,bootindex=2" ],
                [ "-drive", "if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.fd"],
                [ "-drive", "if=pflash,format=raw,file=OVMF_VARS.fd"],
                [ "-drive", "file=output-qemu/packer-qemu,if=none,id=drive0,cache=writeback,discard=ignore,format=raw"],
                [ "-drive", "file=seeds-flat.iso,format=raw,cache=none,if=none,id=drive1"],
                [ "-drive", "file=packer_cache/ubuntu.iso,if=none,id=cdrom0,media=cdrom" ]
            ],
            "shutdown_command": "sudo -S shutdown -P now",
            "ssh_username": "{{user `ssh_username`}}",
            "ssh_password": "{{user `ssh_password`}}",
            "ssh_handshake_attempts": 500,
            "ssh_wait_timeout": "45m",
            "ssh_timeout": "45m"
        }
    ],
```

Note that the builders section is a JSON array, so it can contain multiple tools, as needed.  A few of these we can run through rather quickly, as their purpose is obvious on inspection:

 - `"cpus": 2,`: sets up the image for a two-CPU virtual/machine.
 - `"disk_size": "4G",` : sets up the image to expect a 4Gb disk.
 - `"headless": true,` : the image expects to run headless, that is, without a console.
 - `"http_directory": "{{user `http_directory`}}",`: the HTTP directory will be the user's HTTP directory.
 - `"iso_checksum": "file:http://releases.ubuntu.com/20.04/SHA256SUMS",`: the checksum for the ISO image will be found here.
 - `"iso_url": "https://releases.ubuntu.com/focal/ubuntu-20.04.4-live-server-amd64.iso",`: the ISO image itself will be found at this URL.
 - `"iso_target_path": "packer_cache/ubuntu.iso",`: the packer artefact will be stored at this path.
 - `"memory": 1024,`: the image should expect this much memory.
 - `"format": "raw",`: the image should be written in raw (`dd`) format.
 - `"shutdown_command": "sudo -S shutdown -P now",`: here's the shutdown command to user.
 - `"ssh_username": "{{user `ssh_username`}}",`: here's how you gather the SSH username.
 - `"ssh_password": "{{user `ssh_password`}}",`: here's how you gather the SSH password.
 - `"ssh_handshake_attempts": 500,`: here's how many times you try SSH.
 - `"ssh_wait_timeout": "45m",`: use a really long SSH wait timeout.
 - `"ssh_timeout": "45m"`: use a really long SSH timeout, too.

The high number of SSH handshake attempts -- and the really long timeouts -- have to do with trying to catch the system after it has successfully booted.  Because of the way packer works, it has no direct way to be informed that the system has booted.  As a consequence, to finish the build and run provisioners and post-processors, packer has to keep trying for a while until an SSH connection is successful.  In practice, this should only take 2-3 minutes, but this template uses a very long value, just to be sure.

The values we skipped over tell packer how to build the OS; `"type": "qemu",` tells us that we're using QEMU to build this image.  The arguments to QEMU are as follows:

```nohighlight
"qemuargs": [
[ "-vga", "qxl"],
[ "-device", "virtio-blk-pci,drive=drive0,bootindex=0" ],
[ "-device", "virtio-blk-pci,drive=cdrom0,bootindex=1" ],
[ "-device", "virtio-blk-pci,drive=drive1,bootindex=2" ],
[ "-drive", "if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.fd"],
[ "-drive", "if=pflash,format=raw,file=OVMF_VARS.fd"],
[ "-drive", "file=output-qemu/packer-qemu,if=none,id=drive0,cache=writeback,discard=ignore,format=raw"],
[ "-drive", "file=seeds-flat.iso,format=raw,cache=none,if=none,id=drive1"],
[ "-drive", "file=packer_cache/ubuntu.iso,if=none,id=cdrom0,media=cdrom" ]
],
```

If you study the QEMU documentation, it's easy to see what these commands are doing.  Essentially, we're using QEMU to create an image as a raw `dd` file, putting it in a specific location.

You may also notice that some of the QEMU options require additional dependencies, including `ovmf` (being used to flash the UEFI bootloader), `qemu-utils` (a fast processor emulator), and `qemu-system` (which is a machine architecture emulator.  Every template has different dependency requirements, just like any script.

Finally, there is the "boot section" of the builder template:

```nohighlight
"boot_command": [
    "<wait>e<wait5>",
    "<down><wait><down><wait><down><wait2><end><wait5>",
    "<bs><bs><bs><bs><wait>autoinstall ---<wait><f10>"
],
"boot_wait": "2s",
```

These two elements control how packer will attempt to boot the newly-built image.  Notice that the boot command, in particular, is extremely complex.  Getting a packer-generated image to boot for provisioning is one of the most difficult elements of template design.

<a href="#heading--provisioners"><h3 id="heading--provisioners">Provisioner section</h3></a>

The provisioner section of this simple template looks something like this:

```nohighlight
"provisioners": [
    {
        "type": "file",
        "sources": [
            "{{template_dir}}/scripts/curtin-hooks",
            "{{template_dir}}/scripts/install-custom-packages",
            "{{template_dir}}/scripts/setup-bootloader",
            "{{template_dir}}/packages/custom-packages.tar.gz"
        ],
        "destination": "/tmp/"
    },
    {
        "environment_vars": [
            "HOME_DIR=/home/ubuntu",
            "http_proxy={{user `http_proxy`}}",
            "https_proxy={{user `https_proxy`}}",
            "no_proxy={{user `no_proxy`}}"
        ],
        "execute_command": "echo 'ubuntu' | {{.Vars}} sudo -S -E sh -eux '{{.Path}}'",
        "expect_disconnect": true,
        "scripts": [
            "{{template_dir}}/scripts/curtin.sh",
            "{{template_dir}}/scripts/networking.sh",
            "{{template_dir}}/scripts/cleanup.sh"
        ],
        "type": "shell"
    }
],
```

Rather than walking through each of these lines individually, we can just note that this JSON causes packer to:

 - retrieve scripts that set up the bootloader, configure curtin hooks, and install custom packages from a named gzip source.
 - set the homedir and proxy options for the image.
 - set up curtin and networking for the image.
 - clean up the image prior to post-processing.

If you are interested in more details, you can [examine the scripts](https://github.com/canonical/packer-maas/tree/master/ubuntu/scripts) to see what they do.

<a href="#heading--post-processing"><h3 id="heading--post-processing">Post-processing section</h3></a>

The post-processing section of this template prepares the image for use:

```nohighlight
"post-processors": [
    {
        "type": "shell-local",
        "inline_shebang": "/bin/bash -e",
        "inline": [
            "IMG_FMT=raw",
            "source ../scripts/setup-nbd",
            "OUTPUT=${OUTPUT:-custom-ubuntu.tar.gz}",
            "source ./scripts/tar-rootfs"
        ]
    }
]
```

You can see right away that this template has one post-processor (only one JSON array entry).  This post-processor is a local shell, invoked with the `-e` option, which causes the shell to terminate if there's an error (rather than continuing with the next command).  In this case, we can see that the shell runs four commands:

 - sets `$IMG_FMT` to "raw"
 - runs the script `setup-nbd`
 - sets $OUTPUT to "<name of image>-custom-ubuntu.tar.gz"
 - runs the script `tar-rootfs`

In this case, it's worth a quick look at the two scripts to see what this post-processor does. First, let's glance at `setup-nbd`:

```highlight
#!/bin/bash -e
#
# setup-nbd - Bind Packer qemu output to a free /dev/nbd device.
#
# Author: Lee Trager <lee.trager@canonical.com>
#
# Copyright (C) 2020 Canonical
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

if [ $UID -ne 0 ]; then
    echo "ERROR: Must be run as root!" >&2
    exit 1
fi

if [ ! -f output-qemu/packer-qemu ]; then
    echo "ERROR: Not in the same path as template!" >&2
    exit
fi

echo 'Loading nbd...'
shopt -s extglob
modprobe nbd
for nbd in /sys/class/block/nbd+([0-9]); do
    if [ "$(cat ${nbd}/size)" -eq 0 ]; then
	nbd="/dev/$(basename $nbd)"
	echo "Using $nbd"
	break
    fi
done

if [ -z "${nbd}" ] || ! echo $nbd | grep -q "/dev"; then
    echo "ERROR: Unable to find nbd device to mount image!" >&2
    exit 1
fi

echo "Binding image to $nbd..."
qemu-nbd -d $nbd
if [ -n "$IMG_FMT" ]; then
    qemu-nbd -c $nbd -f "$IMG_FMT" -n output-qemu/packer-qemu
else
    qemu-nbd -c $nbd -n output-qemu/packer-qemu
fi
echo 'Waiting for partitions to be created...'
tries=0
while [ ! -e "${nbd}p1" -a $tries -lt 60 ]; do
    sleep 1
    tries=$((tries+1))
done
```

As you can see, this is just a well-structured script to export a QEMU image as a Network Block Device, binding it to a `/dev/nbd` directory.  This is first step in creating MAAS-loadable Ubuntu image.  The second step comes in `tar-rootfs`:

```nohighlight
#!/bin/bash -e
#
# tar-rootfs - Create a tar.gz from a binded /dev/nbd device
#
# Author: Alexsander de Souza <alexsander.souza@canonical.com>
#
# Copyright (C) 2021 Canonical
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

cleanup() {
    qemu-nbd -d "$nbd"
    [ -d "${TMP_DIR}" ] && rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

if [ ${UID} -ne 0 ]; then
    echo "ERROR: Must be run as root!" >&2
    exit 1
fi

TMP_DIR=$(mktemp -d /tmp/packer-maas-XXXX)

echo 'Mounting root partition...'
mount "${nbd}p2" "${TMP_DIR}"
mount "${nbd}p1" "${TMP_DIR}/boot/efi"

echo "Creating MAAS image $OUTPUT..."
tar -Sczpf "$OUTPUT" --acls --selinux --xattrs -C "${TMP_DIR}" .

echo 'Unmounting image...'
umount "${TMP_DIR}/boot/efi"
umount "${TMP_DIR}"
```

This script just creates a `.tar.gz` from a bound `/dev/nbd` device (where the QEMU image was initially stored by the last script.

As you can see, the process of creating a customised packer image is not overly complex.  Nevertheless, it's a difficult process to get right, hence our community-contributed templates.

<a href="#heading--about-the-image-installation-process"><h2 id="heading--about-the-image-installation-process">About the image installation process</h2></a>

Installing a packer-created image is highly dependent on the application.  In the case of MAAS, we use the CLI `boot-resources` command to upload the image to MAAS, something like this:

```nohighlight
$ maas admin boot-resources create \
    name='custom/ubuntu-tgz' \
    title='Ubuntu Custom TGZ' \
    architecture='amd64/generic' \
    filetype='tgz' \
    content@=custom-ubuntu.tar.gz
```

At this point, the image shows up in MAAS, synced to the controller, the same as any other image.

<a href="#heading--about-packer-created-images"><h2 id="heading--about-packer-created-images">About packer-created images</h2></a>

If you're interested in the anatomy of a packer-created image, for example, an ISO image, you can use `isoinfo` to explore the image file.  The image should be found in the packer git repository, under `<imagename>/packer-cache`.  Ideally, it shouldn't differ too much from any other customised ISO image.  You can explore with a few of the `isoinfo` commands.  For example, you can read the primary volume descriptor like this:

```nohighlight
stormrider@neuromancer:~/mnt/Dropbox/src/git/packer-maas/ubuntu/packer_cache$ isoinfo -d -i ubuntu.iso | more                                                         
CD-ROM is in ISO 9660 format
System id: 
Volume id: Ubuntu-Server 20.04.4 LTS amd64
Volume set id: 
Publisher id: 
Data preparer id: XORRISO-1.2.4 2012.07.20.130001, LIBISOBURN-1.2.4, LIBISOFS-1.2.4, LIBBURN-1.2.4
Application id: 
Copyright File id: 
Abstract File id: 
Bibliographic File id: 
Volume set size is: 1
Volume set sequence number is: 1
Logical block size is: 2048
Volume size is: 650240
El Torito VD version 1 found, boot catalog is in sector 250
Joliet with UCS level 3 found
Rock Ridge signatures version 1 found
Eltorito validation header:
    Hid 1
    Arch 0 (x86)
    ID ''
    Key 55 AA
    Eltorito defaultboot header:
        Bootid 88 (bootable)
        Boot media 0 (No Emulation Boot)
        Load segment 0
        Sys type 0
        Nsect 4
        Bootoff 8EC04 584708
```

You could also generate an exhaustive directory listing with `isoinfo -f -i <isoname>`, and possibly pipe that through `grep` to ensure that your desired packages have been added to the image.  Or, if you prefer to sweep the image directories manually, you can use `isoinfo -l -i <isoname>`.  The larger point, of course, is that a packer-generated image is essentially identical to any prepared ISO image, including, of course, any customisations (e.g., extra software) that the template loads before finalising the image.