<!-- "Storage layouts reference" -->
There are several possible MAAS storage layouts:

- [Flat layout storage](#heading--flat-storage-layout-reference)
- [LVM storage layout](#heading--lvm-storage-layout-reference)
- [bcache storage layout](#heading--bcache-storage-layout-reference)
- [VMFS6 storage layout](#heading--vmfs6-storage-layout-reference)
- [Blank storage layout](#heading--blank-storage-layout-reference)

The reference descriptions below include the EFI partition. If your system is not using UEFI, regard `sda2` as `sda1` (with an additional 512 MB available to it).

<a href="#heading--flat-storage-layout-reference"><h3 id="heading--flat-storage-layout-reference">Flat layout storage reference</h2></a>

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

<a href="#heading--lvm-storage-layout-reference"><h2 id="heading--lvm-storage-layout-reference">LVM storage layout reference</h2></a>

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

<a href="#heading--bcache-storage-layout-reference"><h2 id="heading--bcache-storage-layout-reference">bcache storage layout reference</h2></a>

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

<a href="#heading--vmfs6-storage-layout-reference"><h2 id="heading--vmfs6-storage-layout-reference">VMFS6 storage layout reference</h2></a>

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

<a href="#heading--blank-storage-layout-reference"><h2 id="heading--blank-storage-layout-reference">Blank storage layout reference</h2></a>

The blank layout removes all storage configuration from all storage devices. It is useful when needing to apply a custom storage configuration.

[note]
Machines with the blank layout applied are not deployable; you must first configure storage manually.
[/note]
