<!-- "About MAAS" -->

MAAS is an open-source tool that lets you create a data centre from bare-metal servers. You can discover, commission, deploy, and dynamically reconfigure a large network of individual units.  MAAS converts your hardware investment into a cohesive, flexible, distributed data centre, with a minimum of time and effort.

This section will answer a few questions:

- [What is MAAS?](#heading--what-is-maas)
- [What does MAAS offer me?](#heading--what-maas-offers)
- [Can MAAS co-locate key components to conserve resources?](#heading--colocation-of-key-components)

<a href="#heading--what-is-maas"><h2 id="heading--what-is-maas">What is MAAS?</h2></a>

MAAS expands to "Metal As A Service" -- it converts bare-metal servers into cloud instances of virtual machines. There is no need to manage individual units. You can quickly provision or destroy machines, as if they were instances hosted in a public cloud like Amazon AWS, Google GCE, or Microsoft Azure.

MAAS can act as a standalone PXE/preseed service or integrate with other technologies. It works exceptionally well with [Juju](https://juju.is/docs/olm/maas)`↗`, the service and model management tool. MAAS manages the machines and Juju manages the services running on those machines -- a perfect arrangement.  Virtual machines (VMs)`↗` can even act as MAAS machines if they boot from the network via PXE.

<a href="https://discourse.maas.io/uploads/default/original/1X/d19eff9ef45c554d085ee1d657e4ddd810eac6df.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/d19eff9ef45c554d085ee1d657e4ddd810eac6df.jpeg"></a>

<details><summary>Tell me about PXE booting</summary>

PXE stands for "Preboot Execution Environment," usually pronounced "pixie."  The term refers to a way of booting an OS image (or other software assembly) downloaded to a client via a NIC.  The NIC must be PXE-capable for this to work.  Many NICs can be configured to support PXE boot with a software switch.

</details>

<a href="#heading--what-maas-offers"><h2 id="heading--what-maas-offers">What MAAS offers</h2></a>

MAAS can manage a large number of physical machines by merging them into user-defined resource pools. MAAS automatically provisions participating machines and makes them available for use. You can return unused machines to the assigned pool at any time.

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
MAAS also discovers all of the USB and PCI devices attached to your physical or virtual machines, and allows you to delete them from the machine's visible configuration, prior to deployment, if you so desire.
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
[note]
MAAS 2.9 does not discover USB and PCI devices.  This feature is available from MAAS version 3.0.
[/note]
[/tab]
[/tabs]

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--ui-smooth-maas-experience"><h2 id="heading--ui-smooth-maas-experience">A smooth system-management experience</h2></a>

MAAS integrates all the tools you need into a smooth system-management experience. It includes the following thirteen features:

1. web UI (optimised for mobile devices)
2. Ubuntu, CentOS, Windows, and RHEL installation support
3. open-source IP address management (IPAM)
4. full API/CLI support
5. high availability (optional)
6. IPv6 support
7. inventory of components
8. DHCP and DNS for other devices on the network
9. DHCP relay integration
10. VLAN and fabric support
11. NTP for the entire infrastructure
12. hardware testing
13. composable hardware support

These tools can be controlled from a responsive web UI.  You can easily (re)configure and scale your data centre with MAAS.

<a href="https://discourse.maas.io/uploads/default/original/1X/00968a71b82ce01c45ae3b345ed6b1270d0927bf.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/00968a71b82ce01c45ae3b345ed6b1270d0927bf.jpeg"></a> 

[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
<a href="#heading--cli-smooth-maas-experience"><h2 id="heading--cli-smooth-maas-experience">A smooth system-management experience</h2></a>

MAAS integrates all the tools you need into a smooth system-management experience. It includes the following eleven features:

1. Ubuntu, CentOS, Windows, and RHEL installation support
2. open-source IP address management (IPAM)
3. high availability (optional)
4. IPv6 support
5. inventory of components
6. DHCP and DNS for other devices on the network
7. DHCP relay integration
8. VLAN and fabric support
9. NTP for the entire infrastructure
10. hardware testing
11. composable hardware support


<a href="https://discourse.maas.io/uploads/default/original/1X/40fdae53957095e5a830458dc5c7a62ea5d78c10.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/40fdae53957095e5a830458dc5c7a62ea5d78c10.jpeg"></a> 

[/tab]
[/tabs]

MAAS works with any system configuration tools. Both the [Chef](https://www.chef.io/chef)`↗` and [Juju](https://jaas.ai/)`↗` teams recommend MAAS as a physical provisioning system.

[note]
Please note that Windows and RHEL images require [Ubuntu Pro](https://www.ubuntu.com/support)`↗` to work correctly with MAAS.
[/note]

<a href="#heading--colocation-of-key-components"><h2 id="heading--colocation-of-key-components">Colocation of key components</h2></a>

MAAS relies on two key components: the *region controller* and the *rack controller*. The region controller handles operator requests; the rack controller provides high-bandwidth services to multiple racks. In essence, rack controllers manage racks, while the region controller manages the data centre. We generally recommended installing both controllers on the same system.  The default MAAS install delivers this co-located configuration automatically. This all-in-one solution also provides DHCP. 

See [Concepts and terms](/t/maas-glossary/5416#heading--controllers) for a deeper understanding of these components. Note that in special cases, such as [high availability or load balancing](/t/how-to-enable-high-availability/5120), you will want to install multiple region and rack controllers.  You should also review your existing network design to determine whether [MAAS-managed DHCP](/t/how-to-enable-dhcp/5132) will cause problems.

<a href="https://discourse.maas.io/uploads/default/original/1X/3ad2b128fbc034e9f575f21c0415a6e6c55baea3.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/3ad2b128fbc034e9f575f21c0415a6e6c55baea3.jpeg"></a>