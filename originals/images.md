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

MAAS provides supported images for stable Ubuntu releases, and for CentOS 6.6, CentOS 7, and CentOS 8.0 releases.  [Ubuntu Advantage](https://www.ubuntu.com/support) is needed to build customer Windows, RHEL and ESXi images.

#### Four questions you may have:

<!-- deb-2-7-cli
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3096)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2808)
4. [How do I use and manage VMWare images?](/t/vmware-images/3240)
 deb-2-7-cli -->

<!-- deb-2-7-ui
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3097)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2809)
4. [How do I use and manage VMWare images?](/t/vmware-images/3241)
 deb-2-7-ui -->

<!-- deb-2-8-cli
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3098)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2810)
4. [How do I use and manage VMWare images?](/t/vmware-images/3242)
 deb-2-8-cli -->

<!-- deb-2-8-ui
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3099)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2811)
4. [How do I use and manage VMWare images?](/t/vmware-images/3243)
 deb-2-8-ui -->

<!-- deb-2-9-cli
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3100)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2812)
4. [How do I use and manage VMWare images?](/t/vmware-images/3244)
 deb-2-9-cli -->

<!-- deb-2-9-ui
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3101)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2813)
4. [How do I use and manage VMWare images?](/t/vmware-images/3245)
 deb-2-9-ui -->

<!-- snap-2-7-cli
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3090)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2802)
4. [How do I use and manage VMWare images?](/t/vmware-images/3234)
 snap-2-7-cli -->

<!-- snap-2-7-ui
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3091)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2803)
4. [How do I use and manage VMWare images?](/t/vmware-images/3235)
 snap-2-7-ui -->

<!-- snap-2-8-cli
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3092)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2804)
4. [How do I use and manage VMWare images?](/t/vmware-images/3236)
 snap-2-8-cli -->

<!-- snap-2-8-ui
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3093)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2805)
4. [How do I use and manage VMWare images?](/t/vmware-images/3237)
 snap-2-8-ui -->

<!-- snap-2-9-cli
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3094)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2806)
4. [How do I use and manage VMWare images?](/t/vmware-images/3238)
 snap-2-9-cli -->

<!-- snap-2-9-ui
1. [What are boot sources, and why do they matter?](#heading--boot-sources)
2. [How do I select and import an image?](/t/select-and-import-images/3095)
3. [How do I set up and use a local image mirror?](/t/local-image-mirror/2807)
4. [How do I use and manage VMWare images?](/t/vmware-images/3239)
 snap-2-9-ui -->

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

<h2 id="heading--boot-sources">Boot sources</h2>

The place from where a region controller downloads its images is known as a boot source. The main characteristics of a boot source are its location (URL) and its associated GPG public keyring.

<strong>NOTE:</strong> 
A boot resource is another name for an image. So boot resources are found within a boot source.


MAAS comes configured with a boot source that should suffice for most users:

[`https://images.maas.io/ephemeral-v3/daily/`](https://images.maas.io/ephemeral-v3/daily/)

<!-- deb-2-7-cli
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2808) for some explanation regarding the availability of other streams.
 deb-2-7-cli -->

<!-- deb-2-7-ui
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2809) for some explanation regarding the availability of other streams.
 deb-2-7-ui -->

<!-- deb-2-8-cli
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2810) for some explanation regarding the availability of other streams.
 deb-2-8-cli -->

<!-- deb-2-8-ui
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2811) for some explanation regarding the availability of other streams.
 deb-2-8-ui -->

<!-- deb-2-9-cli
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2812) for some explanation regarding the availability of other streams.
 deb-2-9-cli -->

<!-- deb-2-9-ui
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2813) for some explanation regarding the availability of other streams.
 deb-2-9-ui -->

<!-- snap-2-7-cli
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2802) for some explanation regarding the availability of other streams.
 snap-2-7-cli -->

<!-- snap-2-7-ui
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2803) for some explanation regarding the availability of other streams.
 snap-2-7-ui -->

<!-- snap-2-8-cli
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2804) for some explanation regarding the availability of other streams.
 snap-2-8-cli -->

<!-- snap-2-8-ui
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2805) for some explanation regarding the availability of other streams.
 snap-2-8-ui -->

<!-- snap-2-9-cli
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2806) for some explanation regarding the availability of other streams.
 snap-2-9-cli -->

<!-- snap-2-9-ui
The above URL points to the 'daily' stream (for the v3 format). See [Local image mirror](/t/local-image-mirror/2807) for some explanation regarding the availability of other streams.
 snap-2-9-ui -->

Although the backend supports multiple boot sources, MAAS itself uses a single source. If multiple sources are detected, the web UI will print a warning and will be unable to manage images.
