
MAAS provides supported images for stable Ubuntu releases, and for CentOS 6.6, CentOS 7, and CentOS 8.0 releases.  [Ubuntu Advantage](https://www.ubuntu.com/support) is needed to build customer Windows, RHEL and ESXi images.

#### Four questions you may have:

rad-begin /deb/2.9/cli
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3100)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2812)
4. [How do I use and manage VMWare images?](/t/vmware-images/3244)
rad-end

rad-begin /deb/2.9/ui
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3101)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2813)
4. [How do I use and manage VMWare images?](/t/vmware-images/3245)
rad-end

rad-begin /deb/3.0/cli
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/4103)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/3983)
4. [How do I use and manage VMWare images?](/t/vmware-images/4175)
rad-end

rad-begin /deb/3.0/ui
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/4104)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/3984)
4. [How do I use and manage VMWare images?](/t/vmware-images/4176)
rad-end

rad-begin /snap/2.9/cli
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3094)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2806)
4. [How do I use and manage VMWare images?](/t/vmware-images/3238)
rad-end

rad-begin /snap/2.9/ui
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3095)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2807)
4. [How do I use and manage VMWare images?](/t/vmware-images/3239)
rad-end

rad-begin /snap/3.0/cli
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/4101)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/3981)
4. [How do I use and manage VMWare images?](/t/vmware-images/4173)
rad-end

rad-begin /snap/3.0/ui
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/4102)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/3982)
4. [How do I use and manage VMWare images?](/t/vmware-images/4174)
rad-end

MAAS stores images in the region controller's database, from where the rack controller proxies them to the individual machines.  It's important to note that for ESXi images, network configuration includes only these five parameters:

1.   DHCP
2.   Static/auto IP assignments
3.   Aliases
4.   VLANs
5.   Bonds

Bonds are mapped to NIC teaming in only three ways:

1.   balance-rr -- portid
2.   active-backup -- explicit
3.   802.3ad -- iphash, LACP rate and XMIT hash policy settings ignored

<a href="#heading--boot-sources"><h2 id="heading--boot-sources">Boot sources</h2></a>

The place from where a region controller downloads its images is known as a boot source. The main characteristics of a boot source are its location (URL) and its associated GPG public keyring.

[note]
A boot resource is another name for an image. So boot resources are found within a boot source.
[/note]

MAAS comes configured with a boot source that should suffice for most users:

[`https://images.maas.io/ephemeral-v3/stable/`](https://images.maas.io/ephemeral-v3/stable/)

rad-begin /deb/2.9/cli
The above URL points to the 'stable' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2812) for some explanation regarding the availability of other streams.
rad-end

rad-begin /deb/2.9/ui
The above URL points to the 'stable' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2813) for some explanation regarding the availability of other streams.
rad-end

rad-begin /deb/3.0/cli
The above URL points to the 'stable' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/3983) for some explanation regarding the availability of other streams.
rad-end

rad-begin /deb/3.0/ui
The above URL points to the 'stable' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/3984) for some explanation regarding the availability of other streams.
rad-end

rad-begin /snap/2.9/cli
The above URL points to the 'stable' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2806) for some explanation regarding the availability of other streams.
rad-end

rad-begin /snap/2.9/ui
The above URL points to the 'stable' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2807) for some explanation regarding the availability of other streams.
rad-end

rad-begin /snap/3.0/cli
The above URL points to the 'stable' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/3981) for some explanation regarding the availability of other streams.
rad-end

rad-begin /snap/3.0/ui
The above URL points to the 'stable' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/3982) for some explanation regarding the availability of other streams.
rad-end

Although the backend supports multiple boot sources, MAAS itself uses a single source. If multiple sources are detected, the web UI will print a warning and will be unable to manage images.
