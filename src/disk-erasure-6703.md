<!-- "About disk erasure" -->
Disk erasure pertains to the erasing of data on each of a machine's disks when the machine has been released (see [Release action](/t/maas-glossary/5416#heading--release)) back into the pool of available machines. The user can choose from among three erasure types before confirming the Release action, and a default erasure configuration can also be set.  This section will help you learn:

- [About disk erasure types](#heading--about-disk-erasure-types)
- [About standard erasure](#heading--about-standard-erase)
- [About secure erasure](#heading--about-secure-erasure)
- [About quick erasure](#heading--about-quick-erasure)
- [About erasure order of preference](#heading--about-erasure-order-of-preference)

<a href="#heading--about-disk-erasure-types"><h3 id="heading--about-disk-erasure-types">About disk erasure types</h3></a>

The three disk erasure types are:

1.   Standard erasure
2.   Secure erasure
3.   Quick erasure

Each of these are explained below.


<a href="#heading--about-standard-erase"><h3 id="heading--about-standard-erase">About standard erasure</h3></a>

Overwrites all data with zeros.


<a href="#heading--about-secure-erasure"><h3 id="heading--about-secure-erasure">About secure erasure</h3></a>

Although effectively equivalent to Standard erase, Secure erase is much faster because the disk's firmware performs the operation. Because of this, however, some disks may not be able to perform this erasure type (SCSI, SAS, and FC disks in particular).


<a href="#heading--about-quick-erasure"><h3 id="heading--about-quick-erasure">About quick erasure</h3></a>

Same as Standard erase but only targets the first 1 MB and the last 1 MB of each disk. This removes the partition tables and/or superblock from the disk, making data recovery difficult but not impossible.


<a href="#heading--about-erasure-order-of-preference"><h3 id="heading--about-erasure-order-of-preference">About erasure order of preference</h3></a>

If all three options are checked when the machine is released, the following order of preference is applied:

1.  Use 'secure erase' if the disk supports it
2.  If it does not, then use 'quick erase'
