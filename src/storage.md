<a href="#heading--about-storage"><h2 id="heading--about-storage">About storage</h2></a>

You have significant latitude when choosing the final storage configuration of a deployed machine. MAAS supports traditional disk partitioning, as well as more complex options such as LVM, RAID, and bcache. MAAS also supports UEFI as a boot mechanism.  This article explains boot mechanisms and layouts, and offers some advice on how to configure layouts and manage storage.

A machine's storage is dependant upon the underlying system's disks, but its configuration (i.e., disk usage) is the result of a storage template. In MAAS, this template is called a layout, and MAAS applies it to a machine during commissioning.  Once a layout is applied, a regular user can make modifications to a machine at the filesystem level to arrive at the machine's final storage configuration.  When a machine is no longer needed, a user can choose from among several disk erasure types before releasing it.

[note]
MAAS supports storage configuration for CentOS and RHEL deployments. Support includes RAID, LVM, and custom partitioning with different file systems (ZFS and bcache excluded). This support requires a newer version of Curtin, [available as a PPA](https://launchpad.net/ubuntu/+source/curtin).
[/note]

<a href="#heading--about-uefi-booting"><h3 id="heading--about-uefi-booting">About UEFI booting</h3></a>

Every layout type supports a machine booting with UEFI. In such a case, MAAS automatically creates an EFI boot partition (`/boot/efi`). Other than setting the machine to boot from UEFI, the user does not need to take any additional action.

[note type="negative" status="Warning"]
UEFI must be enabled or disabled for the lifespan of the machine. For example, do not enlist a machine with UEFI enabled, and then disable it before commissioning. It won't work!
[/note]

The EFI partition, if created, will be the first partition (`sda1`) and will have a FAT32 filesystem with a size of 512 MB.

<a href="#heading--final-storage-modifications"><h2 id="heading--final-storage-modifications">About final storage modifications</h2></a>

Once MAAS provisions a machine with block devices, via a layout or administrator customisation, a regular user can modify the resulting storage configuration at the filesystem level.

<a href="#heading--about-disk-erasure"><h2 id="heading--about-disk-erasure">About disk erasure</h2></a>

Disk erasure pertains to the erasing of data on each of a machine's disks when the machine has been released (see [Release action](/t/concepts-and-terms/785#heading--release)) back into the pool of available machines. The user can choose from among three erasure types before confirming the Release action. A default erasure configuration can also be set.

<a href="#heading--about-disk-erasure-types"><h2 id="heading--about-disk-erasure-types">About disk erasure types</h2></a>

The three disk erasure types are:

1.   Standard erasure
2.   Secure erasure
3.   Quick erasure

Each of these are explained below.

<a href="#heading--about-standard-erase"><h3 id="heading--about-standard-erase">Abot standard erasure</h3></a>

Overwrites all data with zeros.

<a href="#heading--about-secure-erasure"><h3 id="heading--about-secure-erasure">About secure eraseure</h3></a>

Although effectively equivalent to Standard erase, Secure erase is much faster because the disk's firmware performs the operation. Because of this, however, some disks may not be able to perform this erasure type (SCSI, SAS, and FC disks in particular).

<a href="#heading--about-quick-erasure"><h3 id="heading--about-quick-erasuree">About quick erasure</h3></a>

Same as Standard erase but only targets the first 1 MB and the last 1 MB of each disk. This removes the partition tables and/or superblock from the disk, making data recovery difficult but not impossible.

<a href="#heading--about-erasure-order-of-preference"><h2 id="heading--about-erasure-order-of-preference">About erasure order of preference</h2></a>

If all three options are checked when the machine is released the following order of preference is applied:

1.  Use 'secure erase' if the disk supports it
2.  If it does not then use 'quick erase'

<a href="#heading--how-to-set-global-storage-layouts"><h2 id="heading--how-to-set-global-storage-layouts">How to set global storage layouts</h2></a>

Layouts can be set globally and on a per-machine basis.

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
All machines will have a default layout applied when commissioned. An administrator can configure the default layout on the 'Settings' page, under the 'Storage' tab.

<a href="https://discourse.maas.io/uploads/default/original/1X/80de3bc701552cd00bec707830accf380c214b17.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/80de3bc701552cd00bec707830accf380c214b17.png"></a>
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
All machines will have a default layout applied when commissioned. To set the default storage layout for all machines:

```
maas $PROFILE maas set-config name=default_storage_layout value=$LAYOUT_TYPE
```

For example, to set the default layout to Flat:

```
maas $PROFILE maas set-config name=default_storage_layout value=flat
```

Important: The new default will only apply to newly-commissioned machines.

rad-end

[note type="caution" status="Important"]
The new default will only apply to newly-commissioned machines.
[/note]

<a href="#heading--how-to-set-per-machine-storage-layouts"><h3 id="heading--how-to-set-per-machine-storage-layouts">How to set per-machine storage layouts</h3></a>

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
An administrator can change the layout for a single machine as well as customise that layout providing this is done while the machine has a status of 'Ready'. This is only possible via the CLI: to see how, click the "CLI" option for your version and delivery method above.
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
An administrator can set a storage layout for a machine with a status of ‘Ready’ like this:

```
maas $PROFILE machine set-storage-layout $SYSTEM_ID storage_layout=$LAYOUT_TYPE [$OPTIONS]
```

For example, to set an LVM layout where the logical volume has a size of 5 GB:

```
maas $PROFILE machine set-storage-layout $SYSTEM_ID storage_layout=lvm lv_size=5368709120

```
You must specify all storage sizes in bytes.

This action will remove the configuration that may exist on any block device.
rad-end

[note]
Only an administrator can modify storage at the block device level (providing the machine has a status of 'Ready').
[/note]

rad-begin   /deb/2.9/ui  /snap/2.9/ui  /snap/3.0/ui /deb/3.0/ui 
<a href="#heading--how-to-set-default-erasure-configuration"><h2 id="heading--how-to-set-default-erasure-configuration">How to set the default erasure configuration</h2></a>

A default erasure configuration can be set on the 'Settings' page by selecting the 'Storage' tab.

<a href="https://assets.ubuntu.com/v1/4e90c4c7-installconfig-storage-erasure__defaults.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/4e90c4c7-installconfig-storage-erasure__defaults.png"></a>

If option 'Erase machines' disks prior to releasing' is chosen then users will be compelled to use disk erasure. That option will be pre-filled in the machine's view and the user will be unable to remove the option.

With the above defaults, the machine's view will look like this when the Release action is chosen:

<a href="https://assets.ubuntu.com/v1/66e1dcc2-installconfig-storage-erasure__defaults-node.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/66e1dcc2-installconfig-storage-erasure__defaults-node.png"></a>

Where 'secure erase' and 'quick erase' can then be configured by the user.

rad-end

rad-begin   /deb/2.9/cli  /snap/2.9/cli  /snap/3.0/cli /deb/3.0/cli 

<a href="#heading--how-to-erase-disks"><h2 id="heading--how-to-erase-disks">How to erase disks</h2></a>

When using the [MAAS CLI](/t/maas-cli/nnnn), you can erase a disk when releasing an individual machine.  Note that this option is not available when releasing multiple machines, so you'll want to make sure you're using:

```
maas $PROFILE machine release...
```

and not:

```
maas $PROFILE machines release...
```

Note the difference in singular and plural "machine/machines" in the commands.  Releasing a machine requires that you have the `system_id` of the machine to be released, which you can obtain with a command like this one:

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t
```

<a href="https://discourse.maas.io/uploads/default/original/1X/a496ac76977909f3403160ca96a1bb7224e785f5.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a496ac76977909f3403160ca96a1bb7224e785f5.jpeg">
</a>

The basic form of the release command, when erasing disks on releasing, is:

```
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true [secure_erase=true ||/&& quick_erase=true]
```

Parameters `secure_erase` and `quick_erase` are both optional, although if you don't specify either of them, the entire disk will be overwritten with null bytes.  Note that this overwrite process is very slow.

Secure erasure uses the drive's secure erase feature, if it has one.  In some cases, this can be much faster than overwriting the entire drive.  Be aware, though, that some drives implement secure erasure as a complete drive overwrite, so this method may still be very slow.  Additionally, if you specify secure erasure and the drive doesn't have this feature, you'll get a complete overwrite anyway -- again, possibly very slow.

Quick erasure wipes 2MB at the start and end of the drive to make recovery both inconvenient and unlikely to happen by accident.  Note, though, that quick erasure is not secure.

<a href="#heading--how-to-specify-conditional-erasure-types"><h3 id="heading--how-to-specify-conditional-erasure-types">How to specify conditional erasure types</h3></a>

If you specify both erasure types, like this:

```
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true secure_erase=true quick_erase=true
```

then MAAS will perform a secure erasure if the drive has that feature; if not, it will perform a quick erasure.  Of course, if you're concerned about completely erasing the drive, and you're not sure whether the disk has secure erase features, the best way to handle that is to specify nothing, and allow the full disk to be overwritten by null bytes:

```
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true
```

rad-end

<a href="#heading--storage-layouts-reference"><h2 id="heading--storage-layouts-reference">Storage layouts reference</h2></a>

There are three layout types:

1.   Flat layout
2.   LVM layout
3.   bcache layout

The layout descriptions below will include the EFI partition. If your system is not using UEFI, regard `sda2` as `sda1` (with an additional 512 MB available to it).

<a href="#heading--flat-storage-layout-reference"><h3 id="heading--flat-storage-layout-reference">Flat layout storage reference</h3></a>

With the Flat layout, a partition spans the entire boot disk. The partition is formatted with the ext4 filesystem and uses the `/` mount point:

| Name | Size        | Type | Filesystem | Mount point |
|:----:|------------:|:----:|:----------:|:------------|
| sda  | -           | disk |            |             |
| sda1 | 512 MB      | part | FAT32      | /boot/efi   |
| sda2 | rest of sda | part | ext4       | /           |

The following three options are supported:

1. `boot_size`: Size of the boot partition on the boot disk. Default is 0, meaning not to create the boot partition. The '/boot' will be placed on the root filesystem.

2. `root_device`: The block device on which to place the root partition. The default is the boot disk.

3. `root_size`: Size of the root partition. Default is 100%, meaning the entire size of the root device.

<a href="#heading--lvm-storage-layout-reference"><h3 id="heading--lvm-storage-layout-reference">LVM storage layout reference</h3></a>

The LVM layout creates the volume group `vgroot` on a partition that spans the entire boot disk. A logical volume `lvroot` is created for the full size of the volume group; is formatted with the ext4 filesystem; and uses the `/` mount point:

| Name   | Size        | Type | Filesystem     | Mount point |
|:----:|------------:|:----:|:----------:|:------------|
| sda    | -           | disk |                |             |
| sda1   | 512 MB      | part | FAT32          | /boot/efi   |
| sda2   | rest of sda | part | lvm-pv(vgroot) |             |
| lvroot | rest of sda | lvm  | ext4           | /           |
| vgroot | rest of sda | lvm  |                |             |

The following six options are supported:

1. `boot_size`: Size of the boot partition on the boot disk. Default is 0, meaning not to create the boot partition. The '/boot' will be placed on the root filesystem.
2. `root_device`: The block device on which to place the root partition. The default is the boot disk.
3. `root_size`: Size of the root partition. Default is 100%, meaning the entire size of the root device.
4. `vg_name`: Name of the created volume group. Default is `vgroot`.
5. `lv_name`: Name of the created logical volume. Default is `lvroot`.
6. `lv_size`: Size of the created logical volume. Default is 100%, meaning the entire size of the volume group.

<a href="#heading--bcache-storage-layout-reference"><h3 id="heading--bcache-storage-layout-reference">bcache storage layout reference</h3></a>

A bcache layout will create a partition that spans the entire boot disk as the backing device. It uses the smallest block device tagged with 'ssd' as the cache device. The bcache device is formatted with the ext4 filesystem and uses the `/` mount point. If there are no 'ssd' tagged block devices on the machine, then the bcache device will not be created, and the Flat layout will be used instead:

| Name      | Size        | Type | Filesystem | Mount point |
|:----:|------------:|:----:|:----------:|:------------|
| sda       | -           | disk |            |             |
| sda1      | 512 MB      | part | FAT32      | /boot/efi   |
| sda2      | rest of sda | part | bc-backing |             |
| sdb (ssd) | -           | disk |            |             |
| sdb1      | 100% of sdb | part | bc-cache   |             |
| bcache0   | per sda2    | disk | ext4       | /           |

The following seven options are supported:

1. `boot_size`: Size of the boot partition on the boot disk. Default is 0, meaning not to create the boot partition. The '/boot' will be placed on the root filesystem.
2. `root_device`: The block device upon which to place the root partition. The default is the boot disk.
3. `root_size`: Size of the root partition. Default is 100%, meaning the entire size of the root device.
4. `cache_device`: The block device to use as the cache device. Default is the smallest block device tagged ssd.
5. `cache_mode`: The cache mode to which MAAS should set the created bcache device. The default is `writethrough`.
6. `cache_size`: The size of the partition on the cache device. Default is 100%, meaning the entire size of the cache device.
7. `cache_no_part`: Whether or not to create a partition on the cache device. Default is false, meaning to create a partition using the given `cache_size`. If set to true, no partition will be created, and the raw cache device will be used as the cache.

<a href="#heading--vmfs6-storage-layout-reference"><h3 id="heading--vmfs6-storage-layout-reference">VMFS6 storage layout reference</h3></a>

The VMFS6 layout is used for VMware ESXi deployments only. It is required when configuring VMware VMFS Datastores. This layout creates all operating system partitions, in addition to the default datastore. The datastore may be modified.  New datastores may be created or extended to include other storage devices. The base operating system partitions may not be modified because VMware ESXi requires them. Once applied another storage layout must be applied to remove the operating system partitions.

| Name | Size      | Type    | Use               |
|:-----|------------:|:----:|:----------|
| sda  | -         | disk    |                   |
| sda1 | 3 MB      | part    | EFI               |
| sda2 | 4 GB      | part    | Basic Data        |
| sda3 | Remaining | part    | VMFS Datastore 1  |
| sda4 | -         | skipped |                   |
| sda5 | 249 MB    | part    | Basic Data        |
| sda6 | 249 MB    | part    | Basic Data        |
| sda7 | 109 MB    | part    | VMware Diagnostic |
| sda8 | 285 MB    | part    | Basic Data        |
| sda9 | 2.5 GB    | part    | VMware Diagnostic |

The following options are supported:

1. `root_device`: The block device upon which to place the root partition. Default is the boot disk.

2. `root_size`: Size of the default VMFS Datastore. Default is 100%, meaning the remaining size of the root disk.

<a href="#heading--blank-storage-layout-reference"><h3 id="heading--blank-storage-layout-reference">Blank storage layout reference</h3></a>

The blank layout removes all storage configuration from all storage devices. It is useful when needing to apply a custom storage configuration.

[note type="negative" status="Warning"]
Machines with the blank layout applied are not deployable; you must first configure storage manually.
[/note]
