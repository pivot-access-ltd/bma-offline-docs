<!-- Networking -->
Congratulations!  Now that you've [gotten started with MAAS](/t/how-to-get-started-with-maas/6202), configuring your MAAS networks is an important next step.  This major section will help you learn about the theory and practice of MAAS networking.

If you're eager to get started, you can go ahead and [connect your MAAS networks](/t/how-to-connect-maas-networks/5164) and [set up DHCP](/t/how-to-enable-dhcp/5132). You might even want to create some [availability zones](/t/how-to-manage-availability-zones/5152).

But don't feel rushed -- it depends on your comfort level with [MAAS networking](#heading--How-MAAS-networks) and [DHCP itself](#heading--Its-always-DHCP).  There are detailed explanations below, along with some catch-up summaries of [TCP/IP](#heading--TCP-IP-primer) and [cloud networking](#heading--About-cloud-networks).  Scan these first if you feel the need.

<a href="#heading--How-MAAS-networks-connect"><h2 id="heading--How-MAAS-networks-connect">How MAAS networks connect</h2></a>

Some elements of MAAS networking are unique to the product, while others are standard networking concepts that are uniquely applied to MAAS.  This section will help you learn:

- [PXE booting is essential](#heading--about-pxe-booting)
- [Power drivers define machines](#heading--about-power-drivers)
- [Proxies](#heading--about-proxies)
- [RPC](#heading--about-RPC)
- [What is network discovery?](#heading--about-network-discovery)
- [Subnets](#heading--subnets)
- [VLANs](#heading--vlans)
- [You manage subnets](#heading--about-subnet-management)
- [MAAS is IPv6-enabled](#heading--about-ipv6)
- [Availability zones](#heading--about-availability-zones)

<a href="#heading--about-pxe-booting"><h3 id="heading--about-pxe-booting">PXE booting is essential</h3></a>

PXE booting, or [Preboot eXecution Environment](https://en.wikipedia.org/wiki/Preboot_Execution_Environment)`↗`, refers to the ability to boot a machine via a Network Interface Card (NIC).  PXE booting requires a Network Interface Card (NIC)`↗` which is equipped with a PXE API which can be accessed by the server wishing to boot the device.

This PXE API has a very small hardware footprint, both to keep NIC density smaller (small footprint PXE ROMs) and to simplify the PXE boot process.  Typically a PXE-capable NIC implements the PXE API with a simple universal network device interface, a tiny UDP/IP stack, a special pre-boot DHCP module, and a trivial file transfer protocol (TFTP) module.  TFTP does have low throughput, but it has been amended twice, once with [better block sizes](https://datatracker.ietf.org/doc/html/rfc2348)`↗`, and once with [better window sizes](https://datatracker.ietf.org/doc/html/rfc7440)`↗`.  Both of these help to allow for payload deliveries large enough to accommodate basic bootable images, such as the ephemeral Ubuntu image that MAAS transmits, via TFTP, in order to commission a machine.

PXE absolutely depends on its bundled, [load-balancing DHCP server](/t/how-to-enable-high-availability/5120#heading--dhcp-ha), which kicks off the process by assigning an IP address.  With this offer, the DHCP server also sets the `next-server` address to the TFTP server.  This allows the booting machine to make a TFTP request, allowing the TFTP server to send a network boot program (NBP) and associated peripheral files.  Considered in detail, the sequence is as follows:

- The machine in question is powered on via its baseboard management controller (BMC).
- The UEFI PXE firmware broadcasts a DHCPDISCOVER message (customised for PXE) to the UDP port (67), requesting network config and booting parameters.
- If the machine receives a PXE-enabled DHCPOFFER, it sets its IP address and requests an NBP from the `next-server` address.
- The machine transfers the network booting program into its own RAM space, via TFTP.
- This NBP downloads an ephemeral kernel with initrd.

From there, a full ephemeral Ubuntu image is loaded and commissioning (or deployment) can take place.

Here are some related concepts you may want to explore:

- [UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)`↗`
- [BOOTP](https://en.wikipedia.org/wiki/Bootstrap_Protocol)`↗`
- [TFTP](https://en.wikipedia.org/wiki/Trivial_File_Transfer_Protocol)`↗`
- [HTTP booting](https://documentation.suse.com/sles/15-SP2/html/SLES-all/cha-deployment-prep-uefi-httpboot.html)`↗`
- [Bootstrap loading via TFTP](https://datatracker.ietf.org/doc/html/rfc906)`↗`

If you still have questions about PXE booting, please consider posting a question on our [discourse forum](https://discourse.maas.io/c/users/8)`↗`.

<a href="#heading--about-power-drivers"><h3 id="heading--about-power-drivers">Power drivers define machines</h3></a>

Power drivers are units of software, embedded in MAAS, that interface with the [BMC](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface#Baseboard_management_controller)`↗` to power-cycle a machine remotely.  Different machines use different BMC configurations.  Typically, these vary by manufacturer, although there are some standard IPMI drivers that can be used.  In addition, it is sometimes possible to control a machine with a specialised BMC via a generic IPMI driver.

IPMI is designed as a set of protocols that bypass the system's CPU, BIOS, UEFI, and/or OS.  Essentially, IPMI provides a network connection directly to the hardware, allowing a number of management and monitoring functions.  From the perspective of MAAS, the main use of IPMI is to access the machine's BMC to power-cycle the machine.  In order for [PXE-booting](#heading--about-pxe-booting) to start, the machine itself must send a PXE-enabled DHCPDISCOVER, which requires the machine to be powered on.

Specific machine models have different IPMI parameters that can or must be used to successfully power on a machine, although many models respond reasonably well to standard IPMI or [Redfish](https://en.wikipedia.org/wiki/Redfish_(specification))`↗` commands. MAAS includes customised power drivers for all of the machines listed in the [power catalogue](/t/power-management-reference/5246#heading--power-catalogue)`↗`.

IPMI provides many other functions and capabilities besides power-cycling the machine, such as monitoring system state (e.g., temperature) and possibly adjusting some parameters remotely.  MAAS generally does not avail itself of these additional features.

<a href="#heading--about-proxies"><h3 id="heading--about-proxies">Proxies</h3></a>

A [proxy server](https://en.wikipedia.org/wiki/Proxy_server)`↗` ("proxy service" or just "proxy") is an intermediary application that serves to broker network transactions between two hosts.  Proxies provide several benefits, including privacy (protecting internal IP addresses from discovery by those on other networks), security (performing some checks against incoming packets), and load-balancing (routing packets to multiple servers, based on actual load or some statistical algorithm)`↗`.  

MAAS provides an [internal proxy](/t/how-to-connect-maas-networks/5164#heading--internal-proxy-maas-proxy), which is an HTTP caching proxy server that is available to all hosts residing in any subnet managed by MAAS.  In addition, MAAS allows you to define an [external proxy](/t/how-to-connect-maas-networks/5164#heading--configure-proxy) if desired.

<a href="#heading--internal-proxy-maas-proxy"><h3 id="heading--internal-proxy-maas-proxy">About the MAAS internal proxy</h3></a>

MAAS provides an internal proxy server. Although it is set up to work well with APT/package requests, it is effectively an HTTP caching proxy server. If you configure the MAAS region controller as the default gateway for the machines it manages then the proxy will work transparently (on TCP port 3128). Otherwise, machines will need to access it on TCP port 8000.

By default, the proxy is available to all hosts residing in any subnet detected by MAAS, not just MAAS-managed machines. It is therefore recommended to disable access to those subnets that represent untrusted networks.

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap"]
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
[/tab]
[tab version="v3.3 Packages"]
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
[/tab]
[tab version="v3.2 Snap"]
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
[/tab]
[tab version="v3.2 Packages"]
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
[/tab]
[tab version="v3.1 Snap"]
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
[/tab]
[tab version="v3.1 Packages"]
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
[/tab]
[tab version="v3.0 Snap"]
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
[/tab]
[tab version="v3.0 Packages"]
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
[/tab]
[tab version="v2.9 Snap"]
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
[/tab]
[tab version="v2.9 Packages"]
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
[/tab]
[/tabs]

<a href="#heading--about-rpc"><h3 id="heading--about-rpc">RPC</h3></a>

A [Remote Procedure Call](https://www.ibm.com/docs/en/aix/7.1?topic=concepts-remote-procedure-call)`↗`, or RPC, is a method by which one computer can execute a subroutine sent by another process or system.  These procedures run as if they were native to the machine executing them, even though they may have been prepared or coded on the requesting machine.  In the case of MAAS, [RPC is used for communication between the region and rack controllers](/t/how-to-tune-controllers/6498#heading--rackregion)`↗`, specifically to transfer the PXE configuration from region to rack.  This allows the relevant MAAS rack to answer the machine's DHCPDISCOVER with a DHCPOFFER that contains the correct PXE booting information to bring the machine to an ephemeral Ubuntu instance. 

<a href="#heading--about-network-discovery"><h3 id="heading--about-network-discovery">What is network discovery?</h3></a>

MAAS constantly listens to the network and reports any discovered devices. Devices are identified when the rack controller observes them communicating on an attached IPv4 subnet. Discovered devices that do not correspond to machines and devices already known to MAAS can be listed via the CLI. If a device advertises a hostname using `mDNS` (such as with `avahi` or `Bonjour`), MAAS will also present the discovered hostname when listing devices.

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
Using the Dashboard, an unknown discovered device can be added to MAAS as a device or as a network interface belonging to a machine or device. Clicking the down arrow to the right of a new device allows values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Selecting a Parent device is optional.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
An unknown discovered device can be added to MAAS as a device, or as a network interface belonging to a machine or device. You can specify values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Indicating a Parent device is optional.
[/tab]
[/tabs]

<a href="#heading--subnets"><h3 id="heading--subnets">Subnets</h3></a>

A [subnet](https://en.wikipedia.org/wiki/Subnetwork#firstHeading)`↗` is a "layer 3" network, defined by a network address and a network mask length (in bits)`↗` and usually written in "CIDR" format. MAAS supports IPv4 and IPv6 subnets. Examples include:

``` no-highlight
- 0.0.0/8
- 16.0.0/12
- 168.0.0/16
2001:db8:4d41:4153::/64
```
<a href="#heading--the-subnet-summary"><h3 id="heading--the-subnet-summary">About the subnet summary</h3></a>

The **Subnet summary** section is the largest and most complex of the subnet configuration screens.  It presents the following configurable options:

- **Name**: Subnet names can be any valid text string. By default, they are named with the CIDR of the subnet itself.

- **CIDR**: This is the address parameter for the subnet.  In keeping with standard CIDR notation, the number of bits of the prefix are indicated after the slash.

- **Gateway IP**: This is the address of the default gateway for your subnet, which is the IP address that transfers packets to other subnets or networks. Typically, this is simply the first IP address in a block of addresses (the `.1` address).

- **DNS**: This is the address of a DNS (domain name server, or simply "name server") for your subnet.  It's optional, but can be configured if desired.

- **Description**: This field represents free form text that you can enter to describe your subnet, as needed to keep important notes attached to the definition of the subnet.

- **Managed allocation** refers to the ability of MAAS to completely [manage a subnet](#heading--about-managed-subnets).

- **Active mapping** instructs MAAS to scan the subnet every 3 hours to discover hosts that have not been discovered passively.

- **Proxy access** instructs MAAS to allow clients from this subnet to access the MAAS proxy.

- **Allow DNS resolution** allows subnet clients to use MAAS for DNS resolution.

- **Fabric**: This field allows you to set the subnets fabric.

- **VLAN**: This field allows you to set the subnets VLAN.

- **Space** is presented for clarity, though spaces are managed at the VLAN level.

<a href="#heading--subnet-utilisation"><h3 id="heading--subnet-utilisation">Subnet utilisation</h3></a>

- 'Subnet addresses' shows the total number of addresses associated with the subnet. 

- 'Availability' shows how many of those addresses are unused, and therefore "available".

- 'Used' shows the percentage that is used.

<a href="#heading--IP-modes"><h3 id="heading--IP-modes">IP modes</h3></a>

Four modes determine how a subnet address is assigned when MAAS deploys the machine. You can select one of these modes by clicking on the "IP mode" drop-down menu:

-   **Auto assign**: MAAS will assign a random static address (`iface eth0 inet static`). The pool of available addresses depends on whether the subnet is managed or unmanaged (see [Subnet management](/t/how-to-connect-maas-networks/5164#heading--how-to-toggle-subnet-management)).

-   **Static assign**: The administrator will specify a static address using a secondary field.

-   **DHCP**: The machine leases a dynamic IP address, via either MAAS-managed DHCP or an external DHCP server.

-   **Unconfigured**: The interface is not configured.

<a href="#heading--vlans"><h3 id="heading--vlans">VLANs</h3></a>

[VLANs](https://en.wikipedia.org/wiki/Virtual_LAN#firstHeading) (Virtual LANs)`↗` are a common way to create logically separate networks using the same physical infrastructure.

Managed switches can assign VLANs to each port in either a "tagged" or an "untagged" manner. A VLAN is said to be "untagged" on a particular port when it is the default VLAN for that port and requires no special configuration to access it.

You can use also use tagged VLANs with MAAS nodes. If a switch port is configured to allow tagged VLAN frames from a MAAS node, that node can automatically access interfaces on that VLAN.

A "Default VLAN" is created for every fabric, to which every new VLAN-aware object in the fabric will be associated with by default (unless specified otherwise).

<a href="#heading--about-subnet-management"><h3 id="heading--about-subnet-management">You manage subnets</h3></a>

Fabrics, VLANs, and spaces do not require much configuration beyond names and descriptions. You can change the MTU for a VLAN, as well as [enable DHCP](/t/how-to-enable-dhcp/5132#heading--enabling-dhcp).  None of these options requires detailed instruction.

This subsection will help you learn:

- [About managed subnets](#heading--about-managed-subnets)
- [About unmanaged subnets](#heading--about-unmanaged-subnets)
- [About IP address tracking](#heading--about-ip-address-tracking)

A [subnet](https://en.wikipedia.org/wiki/Subnetwork)`↗`, on the other hand, provides a number of configuration options relevant to the day-to-day operation of MAAS. By default, MAAS manages subnets in your configuration, but this is easily changed.

When a subnet is managed, MAAS handles all aspects of IP address allocation. This process includes managing DHCP leases and assigned static addresses. Typically MAAS would have one managed subnet, with any additional subnets unmanaged. This arrangement allows for more control over which subnet gets used for DHCP. Additionally, as detailed below, an unmanaged subnet treats reserved IP ranges differently, in a way that some administrators find more intuitive.

<a href="#heading--about-managed-subnets"><h4 id="heading--about-managed-subnets">About managed subnets</h4></a>

When you enable management for a subnet, MAAS will:

- Lease addresses for DHCP from a reserved dynamic IP range
- Assign static addresses not included in a reserved IP range, typically via 'Auto assign' IP allocation mode for a node.

See [the glossary](/t/maas-glossary/5416#heading--ip-ranges) for an explanation of the two kinds of reserved IP ranges MAAS uses.

If needed, you can also define a static route between two subnets. A static route is defined on a per-subnet basis to use a particular gateway, using a configured destination.

<a href="#heading--about-unmanaged-subnets"><h4 id="heading--about-unmanaged-subnets">About unmanaged subnets</h4></a>

When management is disabled for a subnet, the definition of a reserved IP range differs from the managed mode. Here, a reserved IP range tells MAAS to **only allocate addresses from this range** (via 'Auto assign'). Also, DHCP will never lease addresses from an unmanaged subnet.

<a href="#heading--about-ip-address-tracking"><h4 id="heading--about-ip-address-tracking">About IP address tracking</h4></a>

When you enable IP address tracking, MAAS will keep track of all assigned addresses, regardless of whether they come from managed or unmanaged subnets.

<a href="#heading--about-ipv6"><h3 id="heading--about-ipv6">MAAS is IPv6-enabled</h3></a>

Support for IPv6 in MAAS is similar to support for IPv4.  This subsection will help you learn:

- [About enabling IPv6](#heading--about-enabling-ipv6)
- [About IPv6 subnets](#heading--about-ipv6-subnets)
- [About IPV6 routing](#heading--about-ipv6-routing)

A rack controller in an IPv6 context needs to have the region API server URL specified with brackets:

``` nohighlight
http://[::1]:5240/MAAS/
```

You can access the Web UI and the [MAAS CLI](/t/try-out-the-maas-cli/5236) (that is, logging in to the API server) in the same way on both IPv4 and IPv6. To use an IPv6 address in a URL, surround it with square brackets. For example, on the local machine (`::1`, the IPv6 equivalent of `localhost`):

[note]
MAAS can only control most BMCs using IPv4.
[/note]

<a href="#heading--about-enabling-ipv6"><h4 id="heading--about-enabling-ipv6">About enabling IPv6</h4></a>

You enable IPv6 networking in the same way that you enable IPv4 networking: configure a separate rack controller interface for your IPv6 subnet. The IPv6 interface must define a static address range. Provided that you already have a functioning IPv6 network, that's all there is to it. The following sections explain requirements, supported operations, and what to do if you don't yet have a functioning IPv6 network.

An IPv6 interface can use the same network interface on the rack controller as an existing IPv4 network interface. It just defines a different subnet, with IPv6 addressing. A machine that's connected to the IPv4 subnet also connected to the IPv6 subnet on the same network segment.

<a href="#heading--about-ipv6-subnets"><h4 id="heading--about-ipv6-subnets">About IPv6 subnets</h4></a>

If you define a reserved static IP range, then machines deployed on the subnet will get a static address in this range. Since IPv6 networks usually are 64 bits wide, you can be generous with the range size. You can typically leave the netmask and broadcast address fields blank.

You may want MAAS to manage DHCP and DNS, but it's not required. Machines do not need a DHCP server at all for IPv6; MAAS configures static IPv6 addresses on a machine's network interface while deploying it. A DHCPv6 server can provide addresses for containers or virtual machines running on the machines, as well as devices on the network that are not managed by MAAS. The machines do not need DHCPv6. MAAS will not be aware of any addresses issued by DHCP, and cannot guarantee that they will stay unchanged.

<a href="#heading--about-ipv6-routing"><h4 id="heading--about-ipv6-routing">About IPV6 routing</h4></a>

In IPv6, clients do not discover routes through DHCP. Routers make themselves known on their networks by sending out route advertisements. These RAs also contain other configuration items:

- Switches that allow stateless configuration of their unique IP addresses, based on MAC addresses. 
- Switches that enable them to request stateless configuration from a DHCP server.
- Switches that In any allow them to request a stateful IP address from a DHCP server. 

Since a network interface can have any number of IPv6 addresses even on a single subnet, several of these address assignment mechanisms can be combined.

However, when MAAS configures IPv6 networking on a machine, it does not rely on RAs. It statically configures a machine's default IPv6 route to use the router that is set on the cluster interface, so that the machine will know their default gateway. They do not need DHCP and will not auto-configure global addresses.

You may be planning to operate DHCPv6 clients as well, for example, on machines not managed by MAAS, or on virtual machines hosted by MAAS machines.  If this is the case, you may want to configure RAs, so that those clients obtain configuration over DHCP.

If you need RAs, but your gateway does not send them, you could install and configure `radvd` somewhere on the network to advertise its route.

<a href="#heading--Its-always-DHCP"><h2 id="heading--Its-always-DHCP">About MAAS and DHCP</h2></a>

MAAS enlists and commissions machines through the use of its [load-balancing DHCP server](/t/how-to-enable-high-availability/5120#heading--dhcp-ha) running on an untagged VLAN. Although this MAAS-managed DHCP can also be part of the deploy phase, an external DHCP server can optionally be used instead for this purpose. If MAAS detects an external DHCP server, it will display it on the rack controller's page, accessible by selecting 'Controllers' from the top menu in the web UI.

In addition, the machine subnet is usually on the untagged VLAN. If not, you will need to route DHCP packets between the subnet and the MAAS-provided DHCP subnet. It is also possible to forward DHCP traffic from one VLAN to another using an external DHCP relay service.

This documentation presupposes that MAAS-managed DHCP is used to enlist and commission machines.  Using an external DHCP server for enlistment and commissioning may work, but note that this is not supported. MAAS cannot manage an external DHCP server, nor can it keep leases synchronised when you return a machine to the pool.  Also, an external DHCP server may prevent you from commissioning and deploying machines, because the machine receives the address of its TFTP boot server in the DHCP `next-server` statement, which is part of MAAS DHCP.

<a href="#heading--about-ip-conflicts"><h3 id="heading--about-ip-conflicts">About IP conflicts</h3></a>

In some cases, MAAS manages a subnet that is not empty, which could result in MAAS assigning a duplicate IP address.  MAAS is capable of detecting IPs in use on a subnet.  Be aware that there are two caveats:

1. If a previously-assigned NIC is in a quiescent state or turned off, MAAS may not detect it before duplicating an IP address.

2. At least one rack controller must have access to the IP-assigned machine in order for this feature to work.

MAAS also recognises when the subnet ARP cache is full, so that it can re-check the oldest IPs added to the cache to search for free IP addresses.

<a href="#heading--external-dhcp-and-a-reserved-ip-range"><h3 id="heading--external-dhcp-and-a-reserved-ip-range">External DHCP and reserved IP ranges</h3></a>

If an external DHCP server is used to deploy machines, then a reserved IP range should be created to prevent the address namespace from being corrupted. For instance, address conflicts may occur if you set a machine's IP assignment mode to 'Auto assign' in the context of an external DHCP server. Such a range should correspond to the lease range of the external server.

<a href="#heading--About-DHCP-relays"><h3 id="heading--About-DHCP-relays">About DHCP relays</h3></a>

You should not enable DHCP relays in MAAS without sufficient planning.  In particular, MAAS does not provide the actual relay. It must be set up as an external service by the administrator. What MAAS does provide is the DHCP configuration that MAAS-managed DHCP requires in order to satisfy any client requests relayed from another VLAN.

<a href="#heading--About-MAAS-DHCP-snippets"><h3 id="heading--About-MAAS-DHCP-snippets">About MAAS DHCP snippets</h3></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap" view="UI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/snap/maas/common/maas/dhcpd.conf` or `/var/snap/maas/common/maas/dhcpd6.conf`. Be aware that if you edit these files directly, you will need to `sudo` to `root`, as there is no `maas` user in the snap (all relevant files are owned by `root`). For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.3 Packages" view="CLI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/lib/maas/dhcpd.conf` or `/var/lib/maas/dhcpd6.conf`. For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]

[tab version="v3.2 Snap" view="UI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/snap/maas/common/maas/dhcpd.conf` or `/var/snap/maas/common/maas/dhcpd6.conf`. Be aware that if you edit these files directly, you will need to `sudo` to `root`, as there is no `maas` user in the snap (all relevant files are owned by `root`). For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.2 Packages" view="CLI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/lib/maas/dhcpd.conf` or `/var/lib/maas/dhcpd6.conf`. For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.1 Snap" view="UI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/snap/maas/common/maas/dhcpd.conf` or `/var/snap/maas/common/maas/dhcpd6.conf`. Be aware that if you edit these files directly, you will need to `sudo` to `root`, as there is no `maas` user in the snap (all relevant files are owned by `root`). For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.1 Packages" view="CLI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/lib/maas/dhcpd.conf` or `/var/lib/maas/dhcpd6.conf`. For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.0 Snap" view="UI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/snap/maas/common/maas/dhcpd.conf` or `/var/snap/maas/common/maas/dhcpd6.conf`. Be aware that if you edit these files directly, you will need to `sudo` to `root`, as there is no `maas` user in the snap (all relevant files are owned by `root`). For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.0 Packages" view="CLI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/lib/maas/dhcpd.conf` or `/var/lib/maas/dhcpd6.conf`. For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v2.9 Snap" view="UI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/snap/maas/common/maas/dhcpd.conf` or `/var/snap/maas/common/maas/dhcpd6.conf`. Be aware that if you edit these files directly, you will need to `sudo` to `root`, as there is no `maas` user in the snap (all relevant files are owned by `root`). For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v2.9 Packages" view="CLI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/lib/maas/dhcpd.conf` or `/var/lib/maas/dhcpd6.conf`. For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[/tabs]

When you create a snippet, MAAS enables it by default.

[note]
Modifications made directly to `dhcpd.conf.template` or `dhcpd6.conf.template` are not supported.
[/note]

<a href="#heading--MAAS-IP-ranges"><h2 id="heading--MAAS-IP-ranges">MAAS IP ranges</h2></a>

In MAAS-managed networks, you can further manage your subnets with a reserved range of IP addresses.  You can reserve IP addresses by adding one or more reserved ranges to a subnet configuration. You can define two types of ranges: reserved ranges and reserved dynamic ranges.  

A reserved range operates differently depending on whether the subnet is managed or unmanaged.  For a managed (subnet), MAAS will never assign IP addresses inside this range.  You can use this range for anything, such as infrastructure systems, network hardware, external DHCP, or an OpenStack namespace.  For an unmanaged (subnet), MAAS will only assign IP addresses inside this range -- but MAAS can assign any IP within this range.

A reserved dynamic range is used by MAAS for enlisting, commissioning and, if enabled, MAAS-managed DHCP on the machine's VLAN during commissioning and deployment. If created with the Web UI, an initial range is created as part of the DHCP enablement process. MAAS never uses IP addresses from this range for an unmanaged subnet.

<a href="#heading--DHCP-primer"><h2 id="heading--DHCP-primer">DHCP primer</h2></a>

The Dynamic Host Control Protocol or DHCP is a key part of how MAAS is able to manage bare-metal servers.  Many issues with MAAS revolve around misunderstanding -- or unintentional misuse -- of DHCP, so it's worth it to take an in-depth look.  This section will help you learn:

- [About DORA](#heading--about-dora)
- [About DHCP traffic](#heading--about-dhcp-traffic)
- [About DHCP standard message types](#heading--about-dhcp-standard-message-types)
- [About DHCP address allocation](#heading--about-dhcp-address-allocation)
- [About multiple DHCP servers serving different IP ranges](#heading--about-multiple-dhcp-servers-diff-ips)
- [About multiple DHCP servers serving overlapping IP ranges](#heading--about-multiple-dhcp-servers-overlapping-ranges)
- [About DHCP relays](#heading--about-dhcp-relays)

Consider the analogy of assigning a street address to your house, which we've already used earlier. Usually, this is done by the local 911 dispatch office, or some other central authority. They typically use either a survey map or a latitude/longitude pair to locate you, before they assign your house numbers from a pool of available addresses, compatible with other addresses in the area.

Let’s assume that you’re not sure who to call, so you just broadcast a message to everyone in range — your neighbours, the local authorities, etc. You explain that you’re at a given latitude and longitude, and that you want to REQUEST an address.

“Hello. My LatLong is 80.0, 35.7. I need a street address! Can someone out there help me?”

It’s a long shot, you know, but it’s the only thing you can think of at the moment. And — surprise — someone authoritative answers you with an OFFER.

“Hello, LatLong 80.0, 35.7! I have a unique address of 62 Wimberly Place, here are the details. By the way, I am at 46 Reardon Lane if you need to reach me.”

You’re not going to miss this chance, so you let the authority know that, yes, you do want that address, just as they gave it to you. In fact, just to make sure, you formally REQUEST the address.

"Hello? 46 Reardon Lane? I’d like to formally request that 62 Wimberly Place address. Is it still available?"

Happily, the authority ACKNOWLEDGES that the address is yours, or at least, for a while, anyway.

"LatLong 80.0, 35.7, that address is still available. I’m marking it down to you! Enjoy, but be aware that you'll need to reclaim this address every three years."

We used “LatLong 80.0, 35.7” because this particular negotiation is basically carried out by shouting across the fences. Even so, the two participants have to know for sure they’re talking to the right party, so identifiers have to be used that are guaranteed to be unique. 62 Reardon Lane has their address, so they’re already unique. 80.0, 35.7 has no address, so they have to use something else that uniquely identifies them.

<a href="#heading--about-dora"><h3 id="heading--about-dora">About DORA</h3></a>

The DHCP negotiation process is known as DORA: Discover, Offer, Request, Acknowledge. Just like the exchange above, it’s carried out by the network equivalent of shouting, that is, broadcast exchanges. While the payloads for the messages carry unique addressing information (after the first DISCOVER message), the Destination IP (DIP) is always 255.255.255.255 — broadcast mode. Every machine on the network will see the packet, but they will ignore it when they look at the payload.

By the way, there are several other possible responses at various points in the exchange, such as NACK (from the DHCP server, when the client has waited too long to make the request) and DECLINE (e.g., when the IP address configuration offered isn’t usable by the client).

The network version of the shouting match above looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8c1756c1f0a9309fa01f1f5ccc0573e33e436fa.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8c1756c1f0a9309fa01f1f5ccc0573e33e436fa.jpeg"></a>

Message 1 ("DISCOVER") is the only one that carries no destination info in its payload.  The
entire exchange takes place in broadcasts, rather than addressed packets. Said differently, the DIP (Destination IP address) is always 255.255.255.255, the broadcast address. The exchange becomes semi-private with the first OFFER, via the use of message payloads.

<a href="#heading--about-dhcp-traffic"><h3 id="heading--about-dhcp-traffic">About DHCP traffic</h3></a>

In fact, it’s worthwhile to (very briefly) consider a DHCP packet exchange. Typically, it looks something like this:

``` nohighlight
# DHCP Discover
Ethernet Header: DA=FF-FF-FF-FF-FF-FF, SA=<client MAC>
IP Header: SIP=0.0.0.0, DIP=255.255.255.255
DHCP Payload: Client MAC=<client MAC>

# DHCP Offer
Ethernet Header: DA=FF-FF-FF-FF-FF-FF, SA=<DHCP server MAC>
IP Header: SIP=<DHCP server IP address>, DIP=255.255.255.255
DHCP Payload: Offered IP=<offered IP>, Client MAC=<client MAC>,
Subnet Mask=<Subnet mask>, Router IP=<router IP>, 
DNS=<DNS server1 IP, DNS server2 IP>, IP Lease Time=<time>s,
DHCP Server Identifier=<DHCP server IP address>

# DHCP Request
Ethernet Header: DA=FF-FF-FF-FF-FF-FF, SA=<client MAC>
IP Header: SIP=0.0.0.0, DIP=255.255.255.255
DHCP Payload: Client MAC=<client MAC>, 
Requested IP Address=<offered IP>, 
DHCP Server Identifier=<DHCP server IP address>

# DHCP Ack
Ethernet Header: DA=FF-FF-FF-FF-FF-FF, SA=<DHCP server MAC>
IP Header: SIP=<DHCP server IP address>, DIP=255.255.255.255
DHCP Payload: Offered IP=<offered IP>, Client MAC=<client MAC>,
Subnet Mask=<Subnet mask>, Router IP=<router IP>, 
DNS=<DNS server1 IP, DNS server2 IP>, IP Lease Time=<time>s,
DHCP Server Identifier=<DHCP server IP address>
```

A couple of clarifications can come in handy here:

- The DHCP server provides all the needed configuration parameters in both the OFFER and the ACK messages. Nothing is left out: the client receives an IP address, a subnet mask, a router location, the IPs of both DNS servers, the lease time limit, and the identity of the DHCP server. Nothing else is necessary for the requesting client to begin operating independently on the network.

- The requesting client does not start using the offered IP address until it has received the ACK message. Note that in the DHCP Request, above, the SIP (Source IP) is still 0.0.0.0, even though the client knows the offered IP (it sends it back in the request to confirm).

With that very basic view of DHCP, we can now talk about how multiple DHCP servers and multiple requesting clients can keep things straight.

<a href="#heading--about-dhcp-standard-message-types"><h3 id="heading--about-dhcp-standard-message-types">About DHCP standard message types</h3></a>

DHCP is, technically, a network management protocol. In other words, it’s part of a collection of hardware and software tools that help to manage network traffic. DHCP is designed to automatically assign IP addresses and other communication parameters, such as default gateway, domain name, name server IPs, or time server IPs to clients. 

There are (at least) two participants in a DHCP transaction: a server and a client, but the client has to meet some requirements to participate. Specifically, the client has to implement an instance of the DHCP protocol stack; without that, it has no idea how to formulate Discovery and Request packets, nor can it recognise Offers or Acknowledgements (or NAKs, for that matter).

For what it’s worth, the “DHCP protocol stack” just means that a device can handle at least the following standard message types:

- **DHCPDiscover**: a broadcast message sent in the hopes of finding a DHCP server.  Note that clients that don’t get a DHCP response may be able to assign themselves an Automatic Private IPv4 address (APIPA), which should always be in the range 169.254.0.0/16. This is good to know, because you want to pretty much always leave that scope (that range of IP addresses) unused by anything else in your system.

- **DHCPOffer**: also a broadcast message, one that offers an IPv4 address lease; the lease is more than just an IP address, as we saw in the last DHCP blog.

- **DHCPRequest**: If you haven’t noticed by now, DHCP exchanges are little like rolling snowballs: they pick up more protocol information as they go and keep it for the duration of the transaction, sending it back and forth. In this case, the client sends back everything the DHCP server sent, along with a request to actually take the offered lease.

- **DHCPAcknowlegement**: If everything matches up when the DHCP server gets the Request, it responds with an Acknowledgement, which basically says, “Okay, you can lease this IP address for a set period of time.”

- **DHCPNak**: If the client waits too long to Request an Offer (generally, if a different server has already claimed the offered IP address), the DHCP server may respond with a Nak. This requires the client to start over again at Discover.

- **DHCPDecline**: If the client determines that, for some reason, the Offer has a configuration that won’t work for it, it can Decline the offer — that this also means it has to start again at Discover.

- **DHCPRelease**: When a client is done with an IP address, it can send a Release message to cancel the rest of the lease and return the IP address to the server’s available pool.

- **DHCPInform**: This is a relatively new message, which allows a client that already has an IP address to easily get other configuration parameters (related to that IP address) from a DHCP server.

Note that, shortly before a lease expires, most DHCP clients will renew the lease, often with a shortened form of the exchange (Request/Acknowledge) which does not require a full DORA exchange. Also, this renewal exchange takes place directly between the client and the DHCP server, rather than being broadcast across the entire network.

<a href="#heading--about-dhcp-address-allocation"><h3 id="heading--about-dhcp-address-allocation">About DHCP address allocation</h3></a>

There are (at least) three ways that a DHCP server can assign addresses to requesting clients:

- **Manual or static allocation** essentially means that the client receives a specifically-chosen IP address, or, at a minimum, keeps the first one that it’s assigned until the client decides to release it.

- **Dynamic allocation** means that a DHCP server assigns IP addresses from an available pool (scope) of addresses, which can change to another available address in that scope at any time, depending on the network dynamics.

- **Automatic allocation** is sort of a cross between the other two types. The DHCP server assigns an address from its defined scope, but then remembers which client got what address, and re-assigns that address to the same client when a new request is made.

Regardless of the allocation method, the DHCP server’s scope — its range of IP addresses that it controls (and can assign) — is something that must be user-configured.

DHCP is “connectionless,” meaning that basically everything takes place via UDP, usually by broadcast packets — that is, packets not overtly addressed to a specific device. The messages become targeted pretty quickly, using the payload to specify the IP address of the DHCP server and the MAC address of the requesting client, to avoid requiring every other device on the network to completely decode every DHCP message. Note that it is possible to target a UDP packet at a specific server by choosing a unicast message type.

A DHCP client can request its previous IP address, if it had one, but whether it gets that address or not depends on four things: scope, allocation, topology, and authority. Specifically:

 - The larger the DHCP server’s scope of addresses, the more likely it is that the requested address will be available again.

 - The chances of getting the same IP address again also depend on how the server is allocating addresses (see above). Static allocation guarantees the same address; automatic allocation makes it very likely; with dynamic allocation, it’s impossible to predict.

- Topology also plays into this process: if the DHCP server is using one or more DHCP relays to get some or all of its addresses, the chances of re-using the same IP address go down.

- Authority also affects the probability. An authoritative DHCP server will definitely answer any unanswered DHCPDiscover message, but that server is pulling only from its own scope.

<a href="#heading--about-multiple-dhcp-servers-diff-ips"><h3 id="heading--about-multiple-dhcp-servers-diff-ips">About multiple DHCP servers serving different IP ranges</h3></a>

It’s possible to have more than one DHCP server on the same network segment and still have everything work right, with no conflicts and no dropped packets or IP requests. There are three possible scopes for IP ranges to consider:

- **Adjacent scopes**: In this configuration, IP addresses are assigned from portions of the same subnet. For example, one server might control scope 192.168.14.2 – 192.168.14.187, and another server might manage scope 192.168.14.200 – 192.168.14.247. This is the most common (and most reliable) setup for multiple DHCP servers.

- **Heterogeneous scopes**: This arrangement basically has DHCP servers on different subnets, such as 192.168.14.2 – .253 for one server, and 10.17.22.3 – .98 for the other. This can be made to work, but it’s extremely difficult to set up and not so easy to manage. 

- **Overlapping scopes**: In this situation, more than one server can offer the same IP address. There is a way to make this work, by setting up the DHCP servers to talk to one another, but for most applications, this configuration can be avoided. 

Adjacent and heterogeneous scopes are really the same thing. The two servers do not work together; they may not ever be aware of one another. The servers and clients operate independently on a first-come, first-served basis, serving from their specific pool of IP addresses.

A client makes a DHCPRequest. One or both of the servers may answer, depending on load and spare IP addresses. It’s also possible that neither will answer, because they’re both out of IP addresses, but with good network planning — and making one of those servers authoritative — those situations will be kept to a minimum or eliminated entirely.

<a href="#heading--about-multiple-dhcp-servers-overlapping-ranges"><h3 id="heading--about-multiple-dhcp-servers-overlapping-ranges">About multiple DHCP servers serving overlapping IP ranges</h3></a>

Some DHCP implementations offer a feature called server conflict detection or SCD. In short, DHCP SCD uses ICMP Echo messages (pings) — with an appropriate wait time — to see if an IP address is in use before trying to lease it to a client. If all the DHCP servers on a given subnet have SCD enabled, you don’t have to worry about whether the DHCP server scopes overlap. You can assign whatever set of IP addresses you want to whichever DHCP server -- even identical IP ranges -- and they will work together without causing any IP conflict errors.

Oddly, SCD is assumed by the creators of DHCP.  In RFC 2131, ping checks are recommended on both ends, in all cases, by the DHCP server and the client:

"As a consistency check, the allocating server SHOULD probe the reused address before allocating the address, e.g., with an ICMP echo request, and the client SHOULD probe the newly received address, e.g., with ARP."

The capital letters there came from the spec itself. Essentially, DHCP servers really should check to make sure the addresses they send out aren’t already in use — and clients that get them should make sure they’re actually free before they use them.

From an architectural perspective, it might make more sense for DHCP servers to be enabled to talk to each other and coordinate assignment of IP addresses. It is possible to build and configure such DHCP servers, but that type of coordination usually isn't possible in a MAAS networking environment.  Usually, in MAAS networks, there is an external source of DHCP outside the control of the MAAS administrator, one which can't be isolated from the MAAS network.  

As a protocol, DHCP is designed to be loosely coupled. Specifically, any client that has the DHCP protocol stack can discover any DHCP server or servers; any server can make an offer; and a client can take whichever offer it wants (though it’s typically coded to take the first DHCP offer that it can accept). Keeping that loosely-coupled architecture intact means letting DHCP servers check to see if the address they’re sending is in use before offering it, and letting clients check to see if an IP address is in use before they request to accept the offer.

There’s no exact count, but it’s fair to say that a non-trivial number of MAAS installation and configuration issues revolve around competing DHCP servers, that is, multiple DHCP servers on the same subnet, using the same scope (or overlapping scopes), colliding with each other and preventing machines from getting IP addresses. This collision usually shows up as an ability to power on a machine, but not to commission it, since it can’t manage to complete the process of getting an IP address via DHCP.

MAAS already has some conflict detection built in.  If MAAS manages a subnet that is not empty -- which could result in MAAS assigning a duplicate IP address -- MAAS is capable of detecting IPs in use on a subnet. Be aware that there are two caveats

1. If a previously-assigned NIC is in a quiescent state or turned off, MAAS may not detect it before duplicating an IP address.

2. At least one rack controller must have access to the IP-assigned machine in order for this feature to work.

MAAS also recognises when the subnet ARP cache is full, so that it can re-check the oldest IPs added to the cache to search for free IP addresses.

If you want your configuration to run more smoothly, it’s useful to enable SCD on every DHCP provider on your network, if you can. It doesn’t hurt anything, and it really doesn’t cost that much (besides a little extra delay when assigning addresses). There are plenty of network issues associated with a large, bare-metal network. There’s no reason why DHCP conflicts need to be one of those issues.

<a href="#heading--about-dhcp-relays"><h3 id="heading--about-dhcp-relays">About DHCP relays</h3></a>

A DHCP relay is really just a specialised router.  Like all routers, it replaces source and destination addresses of packets crossing its domain so that every server gets the intended messages.  

The only substantial difference is that the DHCP relay knows the IP address of the DHCP server.  When a DHCPRequest reaches the relay from a requesting server, for example, the relay absorbs the broadcast packet and creates a routed unicast packet, bound directly for the DHCP server.  On the way back, the relay converts the DHCPOffer back to a broadcast packet.

<a href="#heading--about-availability-zones"><h2 id="heading--about-availability-zones">Availability zones</h2></a>
An availability zone is an organisational unit containing nodes, where each node is in exactly one zone. While in production, a machine can be allocated from a specific zone.  Availability zones can be used for fault-tolerance, service performance, and power management. See [Zone examples](/t/how-to-set-up-networks/6174#heading--about-availability-zones) for more details.

A newly installed MAAS comes with a default zone which initially contains all nodes. You cannot remove the 'default' zone or change its name, but you can create new zones and assign machine to them. 
This subsection explains some characteristics and uses of availability zones.  

Here you have the opportunity to learn:

- [About fault tolerance](#heading--fault-tolerance)
- [About service performance](#heading--service-performance)
- [About power management](#heading--power-management)


<a href="#heading--fault-tolerance"><h3 id="heading--fault-tolerance">About fault tolerance</h3></a>

Fault tolerance is "the property that enables a system to continue operating properly in the event of the failure of (or one or more faults within) some of its components". To help create better fault tolerance, multiple MAAS zones can be employed.

For this, a zone can be defined in different ways. It can be based on power supply for instance, or it can represent a portion of your network or an entire data centre location.

Machines that work in tandem in order to provide an instance of a service should be allocated in the same zone. The entire service should be replicated in another zone.

<a href="#heading--service-performance"><h3 id="heading--service-performance">About service performance</h3></a>

Service performance is the ability of your service to operate in the most efficient manner possible where the typical criteria used is speed. Multiple MAAS zones can be used to help.

Nodes should be allocated in the zone closest to the performance-critical resources they need.

For example, for applications that are highly sensitive to network latency, it may make sense to design a network topology consisting of several smaller networks, and have each of those represented as a zone. The zones can then be used to allocate nodes that have the best performance depending on the service offered.

<a href="#heading--power-management"><h3 id="heading--power-management">About power management</h3></a>

Power management is concerned with power usage density and cooling. This topic can be addressed with the use of several MAAS zones.

Nodes can be distributed in such a way that power-hungry and/or "hot" systems are located in different zones. This can help mitigate power consumption and heat problems.


<a href="#heading--About-cloud-networks"><h2 id="heading--About-cloud-networks">About cloud networks</h2></a>

Cloud network architectures deviate significantly from the architecture of the Internet infrastructure.  These deviations are driven mostly by economics, simplicity, and scalability.  This article will help you learn:

- [About old and new network architectures](#heading--clos-architecture)
- [Problems with the AAG architecture](#heading--aag-problems)
- [Disaggregating the cloud](#heading--disaggregating-the-cloud)
- [Routing still rules](#heading--routing-still-rules)

<a href="#heading--clos-architecture"><h3 id="heading--clos-architecture">About old and new network architectures</h3></a>

Before there were networks, monolithic applications ran on a mainframe with hardwired I/O devices.  As CPUs proliferated in separate enclosures, LANs like [Banyan Vines](https://en.wikipedia.org/wiki/Banyan_VINES)`↗` grew up.  Proprietary mismatch led to the [OSI model](https://maas.io/docs/about-tcp-ip-networks#heading--about-the-osi-model)`↗`.  Next came the Web, which distributed processing to client devices.  Now, we have the idea of generic switches and servers in cloud and bare-metal clusters.  Servers have shifted from dedicated applications to being completely [virtualised](https://en.wikipedia.org/wiki/Virtualization)`↗`.

A traditional AAC architecture looks like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg"></a>

It’s heavy on network hardware; that is, the radio of switches to servers is (too) high.  Switch-driven networks used hardware packet switching ([merchant silicon](https://etherealmind.com/analysis-merchant-custom-silicon)`↗`) to serve proprietary network configurations.  In theory, bridges needed no configuration, although [congestion](https://en.wikipedia.org/wiki/Network_congestion)`↗` and [mistaken identity](https://en.wikipedia.org/wiki/IP_address#Addressing_conflicts)`↗` led to the need for [STP](https://en.wikipedia.org/wiki/Spanning_Tree_Protocol)`↗`, [per-VLAN trees](https://networklessons.com/spanning-tree/per-vlan-spanning-tree-pvst)`↗`, and IP address redundancy management techniques.

A cloud architecture simplifies these networks:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fd86954e48538ce9ba8fc6e02df23b0a2337ef12.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fd86954e48538ce9ba8fc6e02df23b0a2337ef12.jpeg"></a>

Cloud architecture is a simple [spine-and-leaf network](https://networklessons.com/cisco/ccna-200-301/spine-and-leaf-architecture)`↗`, built from cheap, identical switches connecting cheap, identical servers.  Every switch has a path to every other switch, mitigating congestion.  Any switch can route any traffic anywhere, and any server can do any job (at any time)`↗`.  This architecture moves the developer’s focus from metal to actual computing problems.

<a href="#heading--aag-problems"><h3 id="heading--aag-problems">Problems with the AAG architecture</h3></a>

Modern applications generate much more server-to-server traffic than the original Access-Aggregation-Core networks envisioned.  As a result, the AAG architecture presents several problems under load:

- **VLAN shorting**: At cloud scale, 12 bits of VLAN ID don't provide nearly enough VLAN instances.  Even with Multi-instance/STP, there simply aren't enough virtual LAN networks to accommodate the build-out of even a modest cloud configuration.  Tenant machines come and go rapidly, and STP hello messages simply can't keep up.
- **STP switch-count**: STP is only designed for two aggregation switches, which throttles bandwidth and causes massive, constant congestion in an extended cloud network.
- **Million-plus-packet floods**: Broadcast-and-learn bridges can't keep up with a million-plus MAC addresses, and even if they do, when those cached addresses start to time out, the periodic re-learning floods edge hosts, incapacitating them on a regular basis.
- **Unintentional VLAN partitioning**: Large VLANs plus many devices creates a high-probability of a configuration mistake or an ID refresh miss; these issues cause the network to be invisibly partitioned, making troubleshooting all but impossible.
- **ARP storms**: Hundreds of virtual machines bound to a couple of aggregation switches translates to a network-saturating flurry of ARP refreshes.  There's no easy fix for this without changing the network topology, or setting the refresh timer so high that DHCP hosts will fall off the DNS periodically.

There are other issues usually cited, but these are most concrete.

<a href="#heading--disaggregating-the-cloud"><h3 id="heading--disaggregating-the-cloud">Disaggregating the cloud</h3></a>

An effective cloud architecture breaks routers and bridges into separate hardware and software, sometimes called "switch disaggregation".  A merchant-silicon chassis (the hardware) can be combined with someone else's NOS (network operating system, the software) to produce more standard and cost-effective network switch-gear.  In practice, few cloud providers actually create their own NOS, choosing instead to either integrate merchant silicon with a separately purchased NOS, or, more likely, to buy bundled units from switch providers that have broader integration experience.

Either way, the effect is to have switch-gear which is (1) less likely to be proprietary, and (2) easier to upgrade as the hardware advances.  Switch disaggregation effectively commoditizes the switching elements, effectively eliminating them from network throughput calculations.  In other words, the bridges and routers in a modern cloud network are essentially invisible, uninteresting, and inexpensive, which facilitates the cloud-network build-out model.

<a href="#heading--routing-still-rules"><h3 id="heading--routing-still-rules">Routing still rules</h3></a>

Regardless of your network vintage, packet routing is still the fundamental algorithm that gates throughput.  If you're familiar with routing, this section can be skipped. If you're trying to level up your cloud networking knowledge, this section should help quite a bit.

Routing is fundamentally simple: you're trying to get a packet from a source to a destination, using the destination IP address embedded in that packet.  In practice, routing is more complicated.  Most of the routers in a network path are not forwarding directly to the destination.  Instead, they're sending the packet to the next hop, that is, another, reachable router that is closer to the intended destination.

In [the TCP/IP tutorial](#heading--borrowed-from-ma-bell), we talked about telephone-line repeaters that refreshed the signal to keep it crystal clear over long runs of wire.  The signals didn't have to make it to the intended recipient, they just had to make it to the next repeater, which boosted the signal, cleaned up the noise, and sent the call on down the line to another repeater.  Eventually the call would make it to the subscriber.

Routing works very much the same way: most of the routers in the loop understand how to find another router which is close to the intended destination.  That "next hop" will take care of repackaging the packets and sending them further down the line.  What matters in high-traffic cloud networks is not routing, per se, but how the packets are routed.  The choice of routing protocols can make all the difference in whether or not your network lags.  For this reason, we're going to take a more extended look at routing.

<a href="#heading--multicast-routing"><h4 id="heading--multicast-routing">Multicast routing</h4></a>

One helpful tool for modern cloud networks is the concept of multicast routing.  Stated simply, multicast routing allows one packet to be received by many servers, but only if those servers are interested in receiving it.  Multicast receivers -- which have to subscribe in order to receive the packets -- support a much larger (and more flat) network.  This layout more easily scales to the cloud architecture shown above. Multicasting is generally faster and more efficient for certain payloads; unlike broadcast packets, multicast packets are not examined by every NIC in the packet's path.

For example, all IPv6 communications are multicast, so there's no ARP.  Instead, a process called [neighbour discovery](https://en.wikipedia.org/wiki/Neighbor_Discovery_Protocol)`↗` (NDP) is used.  But IPv4 networks can also handle multicast transactions.  Both IPv4 and IPv6 protocols support [multicast address blocks](https://en.wikipedia.org/wiki/Multicast_address)`↗`, which enable multicasting.

A multicasting server sends one packet, and the network handles replication and addressing (multiplexing) of the packets to the subscribed servers.  Multicast is a one-way protocol: any responses have to be sent by other protocols.  For larger server farms, multicast is a good way to handle things like a software update or a database refresh.  Two special protocols handle subscriptions: [IGMP](https://en.wikipedia.org/wiki/Internet_Group_Management_Protocol)`↗`, used by individual IPv4 receivers, and [PIM](https://en.wikipedia.org/wiki/Protocol_Independent_Multicast)`↗`, which is used by L3 devices (like routers) to manage multicast "trees" across a network or subnet.
