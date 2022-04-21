<!-- "About customising machines" -->
Prior to deployment, MAAS machines can be customised in a number of ways, including:

- machine storage.
- commissioning and deployment configurations (known as "pre-seeding").
- custom Ubuntu kernels.
- kernel boot options. 
- resource pools.

[tabs]
[tab version="v3.2 Snap,v3.2 Packages"]
Machines can also be customised post-deployment, while running, either by changing out the physical hardware, or by altering the VM from the VM host side.  This will allow you to:

- Add or remove disks
- Add or remove network interfaces
- Add or remove PCI devices
- Add or remove USB devices

[note]
You cannot update these parameters from within MAAS on a deployed machine.
[/note]

While deploying a machine, you can configure that machine to periodically sync its hardware configuration.  Deployed machines will passively update changes to the BMC and tags for that machine, on-the-fly, as these changes are made.

This article will help you learn:

- [About customising machines prior to deployment](#heading--about-customising-machines-prior-to-deployment)
- [About customising deployed machines](#heading--about-customising-deployed-machines)

In short, this article will explain these possible customisations, and provide detailed instructions on how to customise your own machines as desired.
[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
This article will help you learn [about customising machines](#heading--about-customising-machines-prior-to-deployment)

In short, this article will explain these possible customisations, and provide detailed instructions on how to customise your own machines as desired.
[/tab]
[/tabs]

<a href="#heading--about-customising-machines-prior-to-deployment"><h2 id="heading--about-customising-machines-prior-to-deployment">About customising machines prior to deployment</h2></a>

In this section, you'll learn:

- [About customising machine storage](#heading--about-customising-machine-storage)
- [About pre-seeding](#heading--about-pre-seeding) (customising commissioning and deployment)
- [About Ubuntu kernels](#heading--about-ubuntu-kernels)
- [About kernel boot options](#heading--about-kernel-boot-options)
- [About resource pools](#heading--about-resource-pools)

<a href="#heading--about-customising-machine-storage"><h3 id="heading--about-customising-machine-storage">About customising machine storage</h3></a>

You have significant latitude when choosing the final storage configuration of a deployed machine. MAAS supports traditional disk partitioning, as well as more complex options such as LVM, RAID, and bcache. MAAS also supports UEFI as a boot mechanism.  This article explains boot mechanisms and layouts, and offers some advice on how to configure layouts and manage storage.

A machine's storage is dependant upon the underlying system's disks, but its configuration (i.e., disk usage) is the result of a storage template. In MAAS, this template is called a layout, and MAAS applies it to a machine during commissioning.  Once a layout is applied, a regular user can make modifications to a machine at the filesystem level to arrive at the machine's final storage configuration.  When a machine is no longer needed, a user can choose from among several disk erasure types before releasing it.

MAAS supports storage configuration for CentOS and RHEL deployments. Support includes RAID, LVM, and custom partitioning with different file systems (ZFS and bcache excluded). This support requires a newer version of Curtin, [available as a PPA](https://launchpad.net/ubuntu/+source/curtin).

<a href="#heading--about-uefi-booting"><h4 id="heading--about-uefi-booting">About UEFI booting</h4></a>

Every layout type supports a machine booting with UEFI. In such a case, MAAS automatically creates an EFI boot partition (`/boot/efi`). Other than setting the machine to boot from UEFI, the user does not need to take any additional action.

[note type="negative" status="Warning"]
UEFI must be enabled or disabled for the lifespan of the machine. For example, do not enlist a machine with UEFI enabled, and then disable it before commissioning. It won't work!
[/note]

The EFI partition, if created, will be the first partition (`sda1`) and will have a FAT32 filesystem with a size of 512 MB.

<a href="#heading--about-block-devices"><h4 id="heading--about-block-devices">About block devices</h4></a>

Once the initial storage layout has been configured on a machine, you can perform many operations to view and adjust the entire storage layout for the machine. In MAAS there are two different types of block devices.

**Physical**

A physical block device is a physically attached block device such as a 100GB hard drive connected to a server.

**Virtual**

A virtual block device is a block device that is exposed by the Linux kernel when an operation is performed. Almost all the operations on a physical block device can be performed on a virtual block device, such as a RAID device exposed as md0.

<a href="#heading--about-partitions"><h4 id="heading--about-partitions">About partitions</h4></a>

As with block devices (see [Block devices](#heading--about-block-devices)), MAAS and the MAAS API offer a great deal of control over the creation, formatting, mounting and deletion of partitions.

<a href="#heading--about-storage-restrictions"><h4 id="heading--about-storage-restrictions">About storage restrictions</h4></a>

There are three restrictions for the storage configuration:

1.   An EFI partition is required to be on the boot disk for UEFI.
2.   You cannot place partitions on logical volumes.
3.   You cannot use a logical volume as a Bcache backing device.

Violating these restrictions will prevent a successful deployment.

<a href="#heading--about-vmfs-datastores"><h4 id="heading--about-vmfs-datastores">About VMFS datastores</h4></a>

MAAS can configure custom local VMware VMFS Datastore layouts to maximise the usage of your local disks when deploying VMware ESXi. As VMware ESXi requires specific partitions for operating system usage, you must first apply the VMFS6 storage layout. This layout creates a VMFS Datastore named `datastore1` which uses the disk space left over on the boot disk after MAAS creates the operating system partitions.

<a href="#heading--final-storage-modifications"><h4 id="heading--final-storage-modifications">About final storage modifications</h4></a>

Once MAAS provisions a machine with block devices, via a layout or administrator customisation, a regular user can modify the resulting storage configuration at the filesystem level.

<a href="#heading--about-disk-erasure"><h4 id="heading--about-disk-erasure">About disk erasure</h4></a>

Disk erasure pertains to the erasing of data on each of a machine's disks when the machine has been released (see [Release action](/t/maas-concepts-and-terms-reference/5416#heading--release)) back into the pool of available machines. The user can choose from among three erasure types before confirming the Release action. A default erasure configuration can also be set.

<a href="#heading--about-disk-erasure-types"><h4 id="heading--about-disk-erasure-types">About disk erasure types</h4></a>

The three disk erasure types are:

1.   Standard erasure - Overwrites all data with zeros.
2.   Secure erasure - Although effectively equivalent to Standard erase, Secure erase is much faster because the disk's firmware performs the operation. Because of this, however, some disks may not be able to perform this erasure type (SCSI, SAS, and FC disks in particular).
3.   Quick erasure - Same as Standard erase but only targets the first 1 MB and the last 1 MB of each disk. This removes the partition tables and/or superblock from the disk, making data recovery difficult but not impossible.

If all three options are checked when the machine is released the following order of preference is applied:

1.  Use 'secure erase' if the disk supports it
2.  If it does not then use 'quick erase'

It is very important to pay close attention to your selections when erasing disks.

<a href="#heading--about-pre-seeding"><h3 id="heading--about-pre-seeding">About pre-seeding</h3></a>

During machine [enlistment](/t/about-machines/5080), [deployment](/t/how-to-deploy-machines/5112), commissioning and machine installation, MAAS sends [Tempita-derived](https://raw.githubusercontent.com/ravenac95/tempita/master/docs/index.txt) configuration files to the [cloud-init](https://launchpad.net/cloud-init) process running on the target machine. MAAS refers to this process as **preseeding**. These preseed files are used to configure a machine's ephemeral and installation environments and can be modified or augmented to a custom machine configuration.

Preseeding in MAAS can be achieved in two ways:

1.  [Curtin](https://launchpad.net/curtin), a preseeding system similar to Kickstart or d-i (Debian Installer), applies customisation during operating system (OS) image installation. MAAS performs these changes on deployment, during OS installation, but before the machine reboots into the installed OS. Curtin customisations are perfect for administrators who want their deployments to have identical setups all the time, every time. [This blog post](https://blog.ubuntu.com/2017/06/02/customising-maas-installs) contains an excellent high-level overview of custom MAAS installs using Curtin.

2.  [Cloud-init](https://launchpad.net/cloud-init), a system for setting up machines immediately after instantiation. cloud-init applies customisations after the first boot, when MAAS changes a machine's status to 'Deployed.' Customisations are per-instance, meaning that user-supplied scripts must be re-specified on redeployment. Cloud-init customisations are the best way for MAAS users to customise their deployments, similar to how the various cloud services prepare VMs when launching instances.

<a href="#heading--templates"><h3 id="heading--templates">About templates</h3></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
The [Tempita](https://raw.githubusercontent.com/ravenac95/tempita/master/docs/index.txt) template files are found in the `/var/snap/maas/current/preseeds/` directory on the region controller. Each template uses a filename prefix that corresponds to a particular phase of MAAS machine deployment:
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
The [Tempita](https://raw.githubusercontent.com/ravenac95/tempita/master/docs/index.txt) template files are found in the `/etc/maas/preseeds/` directory on the region controller. Each template uses a filename prefix that corresponds to a particular phase of MAAS machine deployment:
[/tab]
[/tabs]


|       Phase       |                 Filename prefix                 |
|:-----------------|:-----------------------------------------------|
| Enlistment  |                      enlist                     |
| Commissioning |                  commissioning                  |
| Installation | curtin ([Curtin](https://launchpad.net/curtin)) |

Additionally, the template for each phase typically consists of two files. The first is a higher-level file that often contains little more than a URL or a link to further credentials, while a second file contains the executable logic.

The `enlist` template, for example, contains only minimal variables, whereas `enlist_userdata` includes both user variables and initialisation logic.

[note]
Tempita’s inheritance mechanism is the reverse of what you might expect. Inherited files, such as `enlist_userdata`, become the new template which can then reference variables from the higher-level file, such as `enlist`.
[/note]

<a href="#heading--template-naming"><h3 id="heading--template-naming">About template naming</h3></a>

MAAS interprets templates in lexical order by their filename.  This order allows for base configuration options and parameters to be overridden based on a combination of operating system, architecture, sub-architecture, release, and machine name.

Some earlier versions of MAAS only support Ubuntu. If the machine operating system is Ubuntu, then filenames without `{os}` will also be tried, to maintain backward compatibility.

Consequently, template files are interpreted in the following order:

1.  `{prefix}_{os}_{node_arch}_{node_subarch}_{release}_{node_name}` or `{prefix}_{node_arch}_{node_subarch}_{release}_{node_name}`

2.  `{prefix}_{os}_{node_arch}_{node_subarch}_{release}` or `{prefix}_{node_arch}_{node_subarch}_{release}`

3.  `{prefix}_{os}_{node_arch}_{node_subarch}` or `{prefix}_{node_arch}_{node_subarch}`

4.  `{prefix}_{os}_{node_arch}` or `{prefix}_{node_arch}`

5.  `{prefix}_{os}`

6.  `{prefix}`

7.  `generic`

The machine needs to be the machine name, as shown in the web UI URL.

The prefix can be either `enlist`, `enlist_userdata`, `commissioning`, `curtin`, `curtin_userdata` or `preseed_master`. Alternatively, you can omit the prefix and the following underscore.

For example, to create a generic configuration template for Ubuntu 16.04 Xenial running on an x64 architecture, the file would need to be called `ubuntu_amd64_generic_xenial_node`.

To create the equivalent template for curtin_userdata, the file would be called `curtin_userdata_ubuntu_amd64_generic_xenial_node`.

[note]
Any file targeting a specific machine will replace the values and configuration held within any generic files. If those values are needed, you will need to copy these generic template values into your new file.
[/note]

<a href="#heading--about-ubuntu-kernels"><h3 id="heading--about-ubuntu-kernels">About Ubuntu kernels</h3></a>

MAAS supports four types of kernels for its Ubuntu machines:

1.   General availability kernels
2.   Hardware enablement kernels
3.   Hardware enablement kernels (pre-release)
4.   Low latency kernels

<a href="#heading--general-availability-kernels"><h3 id="heading--general-availability-kernels">About general availability kernels</h3></a>

The *general availability* (GA) kernel is based on the *generic* kernel that ships with a new Ubuntu version. Subsequent fixes are applied regularly by the 'stable' *stream* used when setting up the global image source for MAAS.

MAAS denotes a GA kernel like this:

`ga-<version>`: The GA kernel reflects the major kernel version of the shipped Ubuntu release. For example, 'ga-16.04' is based on the 'generic' 4.4 Ubuntu kernel. As per Ubuntu policy, a GA kernel will never have its major version upgraded until the underlying release is upgraded.

<a href="#heading--hardware-enablement-kernels"><h3 id="heading--hardware-enablement-kernels">About hardware enablement kernels</h3></a>

New hardware gets released all the time. If an Ubuntu host runs an older kernel, it's unlikely that MAAS can support the hardware. Canonical does make every effort to back-port more recent kernels enabling more hardware. The acronym HWE stands for "Hardware Enablement."

You also gain kernel improvements and new features when installing an HWE kernel.

[note]
There is the notion of an HWE *stack*, which refers to the window manager and kernel when the Ubuntu host is running a desktop environment. HWE stacks do not apply to MAAS since machines are provisioned strictly as non-graphical servers.
[/note]

Note that these back-ported/HWE kernels are only available for LTS releases (e.g. Trusty, Xenial, etc.). For example, the first available HWE kernel for Ubuntu 16.04 LTS (Xenial) will be the GA kernel from Ubuntu 16.10 (Yakkety).

Before MAAS 2.1 on Xenial, HWE kernels are referred to by the notation `hwe-<release letter>`. So, to install the Yakkety HWE kernel on Xenial, the `hwe-y` kernel is used. By default, when using the web UI, MAAS imports all available HWE kernels along with its generic boot images. So if you are importing Trusty images, then the following HWE kernels are included: `hwe-u`, `hwe-v`, `hwe-w`, `hwe-x` (presuming the Xenial HWE kernel is available).

In MAAS 2.1, starting with Xenial kernels, the notation has changed. The following is used to refer to the latest HWE kernel available for Xenial: `hwe-16.04`.

See [LTS Enablement Stack](https://wiki.ubuntu.com/Kernel/LTSEnablementStack) (Ubuntu wiki) for the latest information on HWE.

<a href="#heading--hardware-enablement-kernels-pre-release"><h3 id="heading--hardware-enablement-kernels-pre-release">About pre-release hardware enablement kernels</h3></a>

The pre-release HWE kernel is known as the *edge* HWE kernel.

MAAS denotes the edge kernel like this: `hwe-<version>-edge`.

So 'hwe-16.04' is considered older than 'hwe-16.04-edge'.

See [Rolling LTS Enablement Stack](https://wiki.ubuntu.com/Kernel/RollingLTSEnablementStack#hwe-16.04-edge) (Ubuntu wiki) for more information.

<a href="#heading--low-latency-kernels"><h3 id="heading--low-latency-kernels">About low latency kernels</h3></a>

The low-latency kernel is based on the GA kernel, but uses a more aggressive configuration to reduce latency. It is categorised as a soft real-time kernel. For more information, see [Criteria for real-time computing](https://en.wikipedia.org/wiki/Real-time_computing#Criteria_for_real-time_computing) (Wikipedia).

MAAS denotes a low latency kernel in three ways:

1.   `hwe-x-lowlatency`: the Xenial low latency HWE kernel for Trusty
2.   `ga-16.04-lowlatency`: the low latency GA kernel for Xenial
3.   `hwe-16.04-lowlatency`: the low latency HWE kernel for Xenial

<a href="#heading--using-kernels"><h3 id="heading--using-kernels">About choosing a kernel</h3></a>

The kernel installed on a machine during deployment is, by default, the Ubuntu release's native kernel (GA). However, it is possible to tell MAAS to use a different kernel. Via the Web UI, MAAS can help you choose one of these kernels.  There are three different contexts for your choice:

1.   globally (default minimum enlistment and commissioning kernel)
2.   per machine (minimum deploy kernel)
3.   per machine during deployment (specific deploy kernel)

<a href="#heading--about-kernel-boot-options"><h3 id="heading--about-kernel-boot-options">About kernel boot options</h3></a>

MAAS can specify kernel boot options to machines on both a global basis (UI and CLI) and a per-machine basis (CLI-only). A full catalogue of available options can be found in the [Linux kernel parameters list](https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html) at [kernel.org](https://www.kernel.org).

<a href="#heading--about-resource-pools"><h3 id="heading--about-resource-pools">About resource pools</h3></a>

Resource pools allow administrators to logically group resources -- machines and VM hosts -- into pools. Pools can help you budget machines for a particular set of functions.  For example, if you're using MAAS to manage a hospital data centre, you may want to keep a certain number of machines reserved for provider use, whether that be for the charts, documentation, or orders application.  You can use resource pools to reserve those machines, regardless of which of the three applications you end up loading onto a particular machine at any given time. 

Administrators can manage resource pools on the Machines page in the web UI, under the Resource pools tab, or with the MAAS CLI.   Also note that all MAAS installations have a resource pool named "default." MAAS automatically adds new machines to the default resource pool.

<a href="#heading--about-customising-deployed-machines"><h2 id="heading--about-customising-deployed-machines">About customising deployed machines</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages"]
MAAS 3.2 provides the capability to customise deployed machines, in that you can update hardware for a running machine on-the-fly.  Specifically, MAAS will update a deployed machine’s data when you do any of the following things:

- Add or remove disks
- Add or remove network interfaces
- Add or remove PCI devices
- Add or remove USB devices

In addition, while deploying a machine, you can configure that machine to periodically sync its [hardware configuration](#heading--about-hardware-sync).  Deployed machines will also  passively update changes to the BMC and tags for that machine, as these changes are made.

<a href="#heading--about-updating-hardware"><h3 id="heading--about-about-updating-hardware">About updating hardware</h3></a>

Updating hardware on a deployed machine works by installing a special binary on the deployed machine.   This binary is configured at a given interval and push hardware info to the MAAS metadata endpoint.  By setting “enable_hw_sync” to true on a machine prior to deployment, MAAS will add configuration to install a systemd service and timer that will download the hardware sync binary.  This binary then authenticates the machine, reads the hardware info from the machine and pushes it to MAAS. The interval is set globally in the MAAS settings.

Any changes in hardware are written to the machine’s configuration.  Physical hardware changes will be preserved upon release, while virtual changes, such as a SR-IOV interface, will be dropped.

When deploying a machine from the UI, there is a new “enable_hw_sync” flag available for each machine. This flag marks a machine to be configured with live hardware updates.

When deployoing from the CLI, there is an additional `enable_hw_sync` flag on `maas $PROFILE machine deploy`. This flag also marks a machine to be configured with live hardware updates. 

When using the API, there are two additional fields in the request:

- enable_hw_sync: (Boolean) - indicating whether hardware sync should be enabled on the machine, 
- sync_interval: (Int) - indicating the interval, in seconds, that should be set at time of deployment

With respect to `machine.read`, both the RESTful API and Websocket API add the following fields to a response:

- enable_hw_sync: Bool indicating whether hardware sync is enabled on the machine, 
- last_sync: Timestamp of the last time MAAS received hardware sync data for the machine,
- next_sync: Timestamp of the computed estimation of when the next sync should happen,
- sync_interval:  Int the interval, in seconds, that was set at time of deployment
- is_sync_healthy: Bool indicating the sync is working normally when true, false when a sync is late or missing,

With respect to `config.list`, there is a new WebSocket Response result (new “hardware_sync_interval” option):

```nohighlight
[{
   name: "hardware_sync_interval",
   value: String in systemd time span format  e.g. “15m”
	        (only hours, minutes and seconds are recognised)
},…]

 -  hardware_sync_interval is set to `15m` by default
config.update
WebSocket Request params - new “hardware_sync_interval” param

params: {
  name: "hardware_sync_interval",
  value: String in systemd time span format, e.g. “15m”
 }
```

[note]
The API does not throw errors when an invalid string is provided for these parameters.
[/note]

<a href="#heading--about-hardware-sync"><h3 id="heading--about-hardware-sync">About hardware sync</h3></a>

Hardware sync updates the machine’s blockdevice, interface and device sets.  BMC configuration and tags can also be updated on the machine itself. The timestamps of the last sync and the next scheduled sync can be seen in the machine's data.

[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
[note]
The capability to customise deployed machines is available starting with MAAS version 3.2.
[/note]
[/tab]
[/tabs]