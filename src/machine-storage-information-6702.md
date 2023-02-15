<!-- "About machine storage" -->

One of the key elements of managing machines is configuring and managing their storage space.  This subsection will help you learn:

- [About block devices](#heading--about-block-devices)
- [About partitions](#heading--about-partitions)
- [About storage restrictions](#heading--about-storage-restrictions)
- [About VMFS datastores](#heading--about-vmfs-datastores)
- [About UEFI booting](#heading--about-uefi-booting)
- [About final storage modifications](#heading--final-storage-modifications)

The Storage tab on the machine list brings up a form that allows you to view/edit the file system, partitioning and storage parameters for the selected machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

This tab describes the filesystem(s) in use, as well as the available and used partitions for this machine.  


<a href="#heading--about-block-devices"><h3 id="heading--about-block-devices">About block devices</h3></a>

Once the initial storage layout has been configured on a machine, you can perform many operations to view and adjust the entire storage layout for the machine. In MAAS there are two different types of block devices.

**Physical**

A physical block device is a physically attached block device such as a 100GB hard drive connected to a server.

**Virtual**

A virtual block device is a block device that is exposed by the Linux kernel when an operation is performed. Almost all the operations on a physical block device can be performed on a virtual block device, such as a RAID device exposed as md0.


<a href="#heading--about-partitions"><h3 id="heading--about-partitions">About partitions</h3></a>

As with block devices (see [Block devices](#heading--about-block-devices)), MAAS and the MAAS API offer a great deal of control over the creation, formatting, mounting and deletion of partitions.


<a href="#heading--about-storage-restrictions"><h3 id="heading--about-storage-restrictions">About storage restrictions</h3></a>

There are three restrictions for the storage configuration:

1.   An EFI partition is required to be on the boot disk for UEFI.
2.   You cannot place partitions on logical volumes.
3.   You cannot use a logical volume as a Bcache backing device.

Violating these restrictions will prevent a successful deployment.


<a href="#heading--about-vmfs-datastores"><h3 id="heading--about-vmfs-datastores">About VMFS datastores</h3></a>

MAAS can configure custom local VMware VMFS Datastore layouts to maximise the usage of your local disks when deploying VMware ESXi. As VMware ESXi requires specific partitions for operating system usage, you must first apply the VMFS6 storage layout. This layout creates a VMFS Datastore named `datastore1` which uses the disk space left over on the boot disk after MAAS creates the operating system partitions.


<a href="#heading--about-uefi-booting"><h3 id="heading--about-uefi-booting">About UEFI booting</h3></a>

Every layout type supports a machine booting with UEFI. In such a case, MAAS automatically creates an EFI boot partition (`/boot/efi`). Other than setting the machine to boot from UEFI, the user does not need to take any additional action.

[note]
UEFI must be enabled or disabled for the lifespan of the machine. For example, do not enlist a machine with UEFI enabled, and then disable it before commissioning. It won't work!
[/note]

The EFI partition, if created, will be the first partition (`sda1`) and will have a FAT32 filesystem with a size of 512 MB.


<a href="#heading--final-storage-modifications"><h3 id="heading--final-storage-modifications">About final storage modifications</h3></a>

Once MAAS provisions a machine with block devices, via a layout or administrator customisation, a regular user can modify the resulting storage configuration at the filesystem level.

