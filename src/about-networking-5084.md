<!-- "How MAAS networks" -->
Some elements of MAAS networking are unique to the product, while others are standard networking concepts that are uniquely applied to MAAS.  This section will help you learn:

- [About PXE booting](#heading--about-pxe-booting)
- [About power drivers](#heading--about-power-drivers)
- [About proxies](#heading--about-proxies)
- [About RPC](#heading--about-RPC)
- [About network discovery](#heading--about-network-discovery)
- [About subnets](#heading--subnets)
- [About VLANs](#heading--vlans)
- [About subnet management](#heading--about-subnet-management)
- [About IPv6](#heading--about-ipv6)
- [About availability zones](#heading--about-availability-zones)

<a href="#heading--about-pxe-booting"><h3 id="heading--about-pxe-booting">About PXE booting</h3></a>

PXE booting, or [Preboot eXecution Environment](https://en.wikipedia.org/wiki/Preboot_Execution_Environment), refers to the ability to boot a machine via a Network Interface Card (NIC).  PXE booting requires a Network Interface Card (NIC) which is equipped with a PXE API which can be accessed by the server wishing to boot the device.

This PXE API has a very small hardware footprint, both to keep NIC density smaller (small footprint PXE ROMs) and to simplify the PXE boot process.  Typically a PXE-capable NIC implements the PXE API with a simple universal network device interface, a tiny UDP/IP stack, a special pre-boot DHCP module, and a trivial file transfer protocol (TFTP) module.  TFTP does have low throughput, but it has been amended twice, once with [better block sizes](https://datatracker.ietf.org/doc/html/rfc2348), and once with [better window sizes](https://datatracker.ietf.org/doc/html/rfc7440).  Both of these help to allow for payload deliveries large enough to accommodate basic bootable images, such as the ephemeral Ubuntu image that MAAS transmits, via TFTP, in order to commission a machine.

PXE absolutely depends on DHCP, which kicks off the process by assigning an IP address, so that the TFTP server can send a network boot program and its peripheral files.  The machine in question is powered on via its baseboard management controller (BMC).  The UEFI PXE firmware broadcasts a DHCPDISCOVER message (customised for PXE) to the UDP port (67), requesting network config and booting parameters.  Because the discover message is PXE-specific, a PXE-enabled DHCP server is normally required.  Otherwise, the DHCPOFFER will have networking information, but not PXE parameters, which include the IP address of the TFTP server and the name of the network booting program; thus the PXE client would not be able to boot.

If the machine receives a PXE-enabled DHCPOFFER, it will be able to not only set its own network parameters, but also locate the booting resources.  The machine can then transfer the network booting program into its own RAM space, via TFTP.  This booting program, in turn, downloads a basic kernel with initrd.  From there, a full ephemeral Ubuntu image is loaded and commissioning (or deployment) can take place.

Here are some related concepts you may want to explore:

- [UEFI](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)
- [BOOTP](https://en.wikipedia.org/wiki/Bootstrap_Protocol)
- [TFTP](https://en.wikipedia.org/wiki/Trivial_File_Transfer_Protocol)
- [HTTP booting](https://documentation.suse.com/sles/15-SP2/html/SLES-all/cha-deployment-prep-uefi-httpboot.html)
- [Bootstrap loading via TFTP](https://datatracker.ietf.org/doc/html/rfc906)

If you still have questions about PXE booting, please consider posting a question on our [discourse forum](https://discourse.maas.io/c/users/8).

<a href="#heading--about-power-drivers"><h3 id="heading--about-power-drivers">About power drivers</h3></a>

Power drivers are units of software, embedded in MAAS, that interface with the [BMC](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface#Baseboard_management_controller) to power-cycle a machine remotely.  Different machines use different BMC configurations.  Typically, these vary by manufacturer, although there are some standard IPMI drivers that can be used.  In addition, it is sometimes possible to control a machine with a specialised BMC via a generic IPMI driver.

IPMI is designed as a set of protocols that bypass the system's CPU, BIOS, UEFI, and/or OS.  Essentially, IPMI provides a network connection directly to the hardware, allowing a number of management and monitoring functions.  From the perspective of MAAS, the main use of IPMI is to access the machine's BMC to power-cycle the machine.  In order for [PXE-booting](#heading--about-pxe-booting) to start, the machine itself must send a PXE-enabled DHCPDISCOVER, which requires the machine to be powered on.

Specific machine models have different IPMI parameters that can or must be used to successfully power on a machine, although many models respond reasonably well to standard IPMI or [Redfish](https://en.wikipedia.org/wiki/Redfish_(specification)) commands. MAAS includes customised power drivers for all of the machines listed in the [power catalogue](/t/power-management-reference/5246#heading--power-catalogue).

IPMI provides many other functions and capabilities besides power-cycling the machine, such as monitoring system state (e.g., temperature) and possibly adjusting some parameters remotely.  MAAS generally does not avail itself of these additional features.

<a href="#heading--about-proxies"><h3 id="heading--about-proxies">About proxies</h3></a>

A [proxy server](https://en.wikipedia.org/wiki/Proxy_server) ("proxy service" or just "proxy") is an intermediary application that serves to broker network transactions between two hosts.  Proxies provide several benefits, including privacy (protecting internal IP addresses from discovery by those on other networks), security (performing some checks against incoming packets), and load-balancing (routing packets to multiple servers, based on actual load or some statistical algorithm).  

MAAS provides an [internal proxy](/t/how-to-manage-networks/5164#heading--internal-proxy-maas-proxy), which is an HTTP caching proxy server that is available to all hosts residing in any subnet managed by MAAS.  In addition, MAAS allows you to define an [external proxy](/t/how-to-manage-networks/5164#heading--configure-proxy) if desired.

<a href="#heading--about-rpc"><h3 id="heading--about-rpc">About RPC</h3></a>

A [Remote Procedure Call](https://www.ibm.com/docs/en/aix/7.1?topic=concepts-remote-procedure-call), or RPC, is a method by which one computer can execute a subroutine sent by another process or system.  These procedures run as if they were native to the machine executing them, even though they may have been prepared or coded on the requesting machine.  In the case of MAAS, [RPC is used for communication between the region and rack controllers](/t/about-controllers/5072#heading--rackregion), specifically to transfer the PXE configuration from region to rack.  This allows the relevant MAAS rack to answer the machine's DHCPDISCOVER with a DHCPOFFER that contains the correct PXE booting information to bring the machine to an ephemeral Ubuntu instance. 

<a href="#heading--about-network-discovery"><h3 id="heading--about-network-discovery">About network discovery</h3></a>

MAAS constantly listens to the network and reports any discovered devices. Devices are identified when the rack controller observes them communicating on an attached IPv4 subnet. Discovered devices that do not correspond to machines and devices already known to MAAS can be listed via the CLI. If a device advertises a hostname using `mDNS` (such as with `avahi` or `Bonjour`), MAAS will also present the discovered hostname when listing devices.

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
Using the Dashboard, an unknown discovered device can be added to MAAS as a device or as a network interface belonging to a machine or device. Clicking the down arrow to the right of a new device allows values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Selecting a Parent device is optional.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
An unknown discovered device can be added to MAAS as a device, or as a network interface belonging to a machine or device. You can specify values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Indicating a Parent device is optional.
[/tab]
[/tabs]

<a href="#heading--subnets"><h2 id="heading--subnets">About subnets</h2></a>

A [subnet](https://en.wikipedia.org/wiki/Subnetwork#firstHeading) is a "layer 3" network, defined by a network address and a network mask length (in bits) and usually written in "CIDR" format. MAAS supports IPv4 and IPv6 subnets. Examples include:

``` no-highlight
- 0.0.0/8
- 16.0.0/12
- 168.0.0/16
2001:db8:4d41:4153::/64
```

<a href="#heading--vlans"><h2 id="heading--vlans">About VLANs</h2></a>

[VLANs](https://en.wikipedia.org/wiki/Virtual_LAN#firstHeading) (Virtual LANs) are a common way to create logically separate networks using the same physical infrastructure.

Managed switches can assign VLANs to each port in either a "tagged" or an "untagged" manner. A VLAN is said to be "untagged" on a particular port when it is the default VLAN for that port and requires no special configuration to access it.

You can use also use tagged VLANs with MAAS nodes. If a switch port is configured to allow tagged VLAN frames from a MAAS node, that node can automatically access interfaces on that VLAN.

A "Default VLAN" is created for every fabric, to which every new VLAN-aware object in the fabric will be associated with by default (unless specified otherwise).

<a href="#heading--about-subnet-management"><h3 id="heading--about-subnet-management">About subnet management</h3></a>

Fabrics, VLANs, and spaces do not require much configuration beyond names and descriptions. You can change the MTU for a VLAN, as well as [enable DHCP](/t/how-to-manage-dhcp/5132#heading--enabling-dhcp).  None of these options requires detailed instruction.

This subsection will help you learn:

- [About managed subnets](#heading--about-managed-subnets)
- [About unmanaged subnets](#heading--about-unmanaged-subnets)
- [About IP address tracking](#heading--about-ip-address-tracking)

A [subnet](https://en.wikipedia.org/wiki/Subnetwork), on the other hand, provides a number of configuration options relevant to the day-to-day operation of MAAS. By default, MAAS manages subnets in your configuration, but this is easily changed.

When a subnet is managed, MAAS handles all aspects of IP address allocation. This process includes managing DHCP leases and assigned static addresses. Typically MAAS would have one managed subnet, with any additional subnets unmanaged. This arrangement allows for more control over which subnet gets used for DHCP. Additionally, as detailed below, an unmanaged subnet treats reserved IP ranges differently, in a way that some administrators find more intuitive.

<a href="#heading--about-managed-subnets"><h4 id="heading--about-managed-subnets">About managed subnets</h4></a>

When you enable management for a subnet, MAAS will:

- Lease addresses for DHCP from a reserved dynamic IP range
- Assign static addresses not included in a reserved IP range, typically via 'Auto assign' IP allocation mode for a node.

See [Concepts and terms](/t/maas-concepts-and-terms-reference/5416#heading--ip-ranges) for an explanation of the two kinds of reserved IP ranges MAAS uses.

If needed, you can also define a static route between two subnets. A static route is defined on a per-subnet basis to use a particular gateway, using a configured destination.

<a href="#heading--about-unmanaged-subnets"><h4 id="heading--about-unmanaged-subnets">About unmanaged subnets</h4></a>

When management is disabled for a subnet, the definition of a reserved IP range differs from the managed mode. Here, a reserved IP range tells MAAS to **only allocate addresses from this range** (via 'Auto assign'). Also, DHCP will never lease addresses from an unmanaged subnet.

<a href="#heading--about-ip-address-tracking"><h4 id="heading--about-ip-address-tracking">About IP address tracking</h4></a>

When you enable IP address tracking, MAAS will keep track of all assigned addresses, regardless of whether they come from managed or unmanaged subnets.

<a href="#heading--about-ipv6"><h3 id="heading--about-ipv6">About IPv6</h3></a>

Support for IPv6 in MAAS is similar to support for IPv4.  This subsection will help you learn:

- [About enabling IPv6](#heading--about-enabling-ipv6)
- [About IPv6 subnets](#heading--about-ipv6-subnets)
- [About IPV6 routing](#heading--about-ipv6-routing)

A rack controller in an IPv6 context needs to have the region API server URL specified with brackets:

``` nohighlight
http://[::1]:5240/MAAS/
```

You can access the Web UI and the [MAAS CLI](/t/how-to-use-the-maas-cli/5236) (that is, logging in to the API server) in the same way on both IPv4 and IPv6. To use an IPv6 address in a URL, surround it with square brackets. For example, on the local machine (`::1`, the IPv6 equivalent of `localhost`):

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


<a href="#heading--about-availability-zones"><h3 id="heading--about-availability-zones">About availability zones</h3></a>

This subsection explains some characteristics and uses of availability zones.  Here you have the opportunity to learn:

- [About fault tolerance](#heading--fault-tolerance)
- [About service performance](#heading--service-performance)
- [About power management](#heading--power-management)

<a href="#heading--fault-tolerance"><h4 id="heading--fault-tolerance">About fault tolerance</h4></a>

Fault tolerance is "the property that enables a system to continue operating properly in the event of the failure of (or one or more faults within) some of its components". To help create better fault tolerance, multiple MAAS zones can be employed.

For this, a zone can be defined in different ways. It can be based on power supply for instance, or it can represent a portion of your network or an entire data centre location.

Machines that work in tandem in order to provide an instance of a service should be allocated in the same zone. The entire service should be replicated in another zone.

<a href="#heading--service-performance"><h4 id="heading--service-performance">About service performance</h4></a>

Service performance is the ability of your service to operate in the most efficient manner possible where the typical criteria used is speed. Multiple MAAS zones can be used to help.

Nodes should be allocated in the zone closest to the performance-critical resources they need.

For example, for applications that are highly sensitive to network latency, it may make sense to design a network topology consisting of several smaller networks, and have each of those represented as a zone. The zones can then be used to allocate nodes that have the best performance depending on the service offered.

<a href="#heading--power-management"><h4 id="heading--power-management">About power management</h4></a>

Power management is concerned with power usage density and cooling. This topic can be addressed with the use of several MAAS zones.

Nodes can be distributed in such a way that power-hungry and/or "hot" systems are located in different zones. This can help mitigate power consumption and heat problems.