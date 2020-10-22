<!-- deb-2-7-cli
 deb-2-7-cli -->

<!-- deb-2-7-ui
 deb-2-7-ui -->

<!-- deb-2-8-cli
 deb-2-8-cli -->

<!-- deb-2-8-ui
 deb-2-8-ui -->

<!-- deb-2-9-cli
 deb-2-9-cli -->

<!-- deb-2-9-ui
 deb-2-9-ui -->

<!-- snap-2-7-cli
 snap-2-7-cli -->

<!-- snap-2-7-ui
 snap-2-7-ui -->

<!-- snap-2-8-cli
 snap-2-8-cli -->

<!-- snap-2-8-ui
 snap-2-8-ui -->

<!-- snap-2-9-cli
 snap-2-9-cli -->

<!-- snap-2-9-ui
 snap-2-9-ui -->

Disk erasure pertains to the erasing of data on each of a machine's disks when the machine has been released (see [Release action](/t/concepts-and-terms/785#heading--release)) back into the pool of available machines. The user can choose from among three erasure types before confirming the Release action. A default erasure configuration can also be set.

<h2 id="heading--erasure-types">Erasure types</h2>

The three types of erasure types are:

-   Standard erase
-   Secure erase
-   Quick erase

Each of these are explained below.

<h3 id="heading--standard-erase">Standard erase</h3>

Overwrites all data with zeros.

<h3 id="heading--secure-erase">Secure erase</h3>

Although effectively equivalent to Standard erase, Secure erase is much faster because the disk's firmware performs the operation. Because of this, however, some disks may not be able to perform this erasure type (SCSI, SAS, and FC disks in particular).

<h3 id="heading--quick-erase">Quick erase</h3>

Same as Standard erase but only targets the first 1 MB and the last 1 MB of each disk. This removes the partition tables and/or superblock from the disk, making data recovery difficult but not impossible.

<!-- deb-2-7-ui deb-2-8-ui deb-2-9-ui snap-2-8-ui snap-2-9-ui snap-2-7-ui
<h2 id="heading--default-configuration">Default configuration</h2>

A default erasure configuration can be set on the 'Settings' page by selecting the 'Storage' tab.

<a href="https://assets.ubuntu.com/v1/4e90c4c7-installconfig-storage-erasure__defaults.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/4e90c4c7-installconfig-storage-erasure__defaults.png"></a>

If option 'Erase machines' disks prior to releasing' is chosen then users will be compelled to use disk erasure. That option will be pre-filled in the machine's view and the user will be unable to remove the option.

With the above defaults, the machine's view will look like this when the Release action is chosen:

<a href="https://assets.ubuntu.com/v1/66e1dcc2-installconfig-storage-erasure__defaults-node.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/66e1dcc2-installconfig-storage-erasure__defaults-node.png"></a>

Where 'secure erase' and 'quick erase' can then be configured by the user.

<h2 id="heading--order-of-preference">Order of preference</h2>

If all three options are checked when the machine is released the following order of preference is applied:

1.  Use 'secure erase' if the disk supports it
2.  If it does not then use 'quick erase'
deb-2-7-ui deb-2-8-ui deb-2-9-ui snap-2-8-ui snap-2-9-ui snap-2-7-ui -->

<!-- deb-2-7-cli deb-2-8-cli deb-2-9-cli snap-2-8-cli snap-2-9-cli snap-2-7-cli

<h2>Erasure procedure</h2>

When using the [MAAS CLI](/t/maas-cli/802), you can erase a disk when releasing an individual machine.  Note that this option is not available when releasing multiple machines, so you'll want to make sure you're using:

```
maas $PROFILE machine release...
```

and not:

```
maas $PROFILE machines release...
```

Note the difference in singular and plural "machine/machines" in the commands.  Releasing a machine requires that you have the `system_id` of the machine to be released, which you can obtain with a [basic machine list](/t/the-cli-cookbook/2218#heading--basic-machine-list):

<a href="https://discourse.maas.io/uploads/default/original/1X/a496ac76977909f3403160ca96a1bb7224e785f5.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a496ac76977909f3403160ca96a1bb7224e785f5.jpeg">
</a>

The basic form of the release command, when erasing disks on releasing, is:

```
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true [secure_erase=true ||/&& quick_erase=true]
```

Parameters `secure_erase` and `quick_erase` are both optional, although if you don't specify either of them, the entire disk will be overwritten with null bytes.  Note that this overwrite process is very slow.

Secure erasure uses the drive's secure erase feature, if it has one.  In some cases, this can be much faster than overwriting the entire drive.  Be aware, though, that some drives implement secure erasure as a complete drive overwrite, so this method may still be very slow.  Additionally, if you specify secure erasure and the drive doesn't have this feature, you'll get a complete overwrite anyway -- again, possibly very slow.

Quick erasure wipes 2MB at the start and end of the drive to make recovery both inconvenient and unlikely to happen by accident.  Note, though, that quick erasure is not secure.

<h3>Specifying both erasure types</h3>

If you specify both erasure types, like this:

```
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true secure_erase=true quick_erase=true
```

then MAAS will perform a secure erasure if the drive has that feature; if not, it will perform a quick erasure.  Of course, if you're concerned about completely erasing the drive, and you're not sure whether the disk has secure erase features, the best way to handle that is to specify nothing, and allow the full disk to be overwritten by null bytes:

```
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true
```

deb-2-7-cli deb-2-8-cli deb-2-9-cli snap-2-8-cli snap-2-9-cli snap-2-7-cli -->
