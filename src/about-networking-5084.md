<a href="#heading--about-maas-networks"><h2 id="heading--about-maas-networks">About MAAS networks</h2></a>

There are elements of MAAS networking that are unique to the product.  This section will help you learn:

 - [About network discovery](#heading--about-network-discovery)
 - [About subnet management](#heading--about-subnet-management)
 - [About IPv6](#heading--about-ipv6)
 - [About availability zones](#heading--about-availability-zones)

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

<a href="#heading--about-subnet-management"><h3 id="heading--about-subnet-management">About subnet management</h3></a>

Fabrics, VLANs, and spaces do not require much configuration beyond names and descriptions. You can change the MTU for a VLAN, as well as [enable DHCP](/t/how-to-manage-dhcp/5132#heading--enabling-dhcp).  None of these options requires detailed instruction.

This subsection will help you learn:

 - [About managed subnets](#heading--about-managed-subnets)
 - [About unmanaged subnets](#heading--about-unmanaged-subnets)
 - [About IP address tracking](#heading--about-ip-address-tracking)

A subnet, on the other hand, provides a number of configuration options relevant to the day-to-day operation of MAAS. By default, MAAS manages subnets in your configuration, but this is easily changed.

When a subnet is managed, MAAS handles all aspects of IP address allocation. This process includes managing DHCP leases and assigned static addresses. Typically MAAS would have one managed subnet, with any additional subnets unmanaged. This arrangement allows for more control over which subnet gets used for DHCP. Additionally, as detailed below, an unmanaged subnet treats reserved IP ranges differently, in a way that some administrators find more intuitive.

<a href="#heading--about-managed-subnets"><h4 id="heading--about-managed-subnets">About managed subnets</h4></a>

When you enable management for a subnet, MAAS will:

1.   Lease addresses for DHCP from a reserved dynamic IP range
2.   Assign static addresses not included in a reserved IP range, typically via 'Auto assign' IP allocation mode for a node.

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

 * Switches that allow stateless configuration of their unique IP addresses, based on MAC addresses. 
* Switches that enable them to request stateless configuration from a DHCP server.
* Switches that In any allow them to request a stateful IP address from a DHCP server. 

Since a network interface can have any number of IPv6 addresses even on a single subnet, several of these address assignment mechanisms can be combined.

However, when MAAS configures IPv6 networking on a machine, it does not rely on RAs. It statically configures a machine's default IPv6 route to use the router that is set on the cluster interface, so that the machine will know their default gateway. They do not need DHCP and will not autoconfigure global addresses.

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


