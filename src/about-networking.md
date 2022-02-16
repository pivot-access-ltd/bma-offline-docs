It's difficult to work effectively with MAAS without a solid understanding of networks.   This page provides opportunities for you to learn:

 - [About TCP/IP networks](#heading--about-tcp-ip-networks)
 - [About cloud networks](#heading--about-cloud-networks)
 - [About MAAS networks](#heading--about-maas-networks)

Most of the examples are related to MAAS, but links are provided for further study, if desired.

<a href="#heading--about-tcp-ip-networks"><h2 id="heading--about-tcp-ip-networks">About TCP/IP networks</h2></a>

TCP/IP networks, and the underlying structure, evolved to meet a specific need: How can we keep a computer network functioning in the event of a catastrophic failure of communications infrastructure?  When nodes go offline, randomly, how can surviving nodes keep the network usable?  The Internet, which relies heavily on TCP/IP networks, has proven over time that it can adapt to changing loads, handle significant failures, and strictly limit the network blast radius when things go wrong.   

Experience has shown us that you will probably have a much easier time working with MAAS if you ensure a solid understanding of network fundamentals.  Rather than bury this basic material, we've decided to included it in the mainstream MAAS networking discussion. Later sections, which help you learn how to design and troubleshoot MAAS networks, will depend heavily on principles explained here.

This section is designed to help you understand:

 - [The OSI model](#heading--about-the-osi-model)
 - [Layer 1: the physical layer](#heading--about-the-physical-layer)
 - [Layer 2: the datalink layer](#heading--about-the-datalink-layer)
 - [Layer 3: the network layer](#heading--about-the-network-layer)
 - [How ARP works](#heading--about-arp)
 - [Layer 4: the transport layer](#heading--about-the-transport-layer)

This material can be read from beginning to end, or you can skip to sections where you feel you might need more clarity.  Just remember that a good understanding of these fundamentals will make it much easier for you to efficiently lay out and debug MAAS networks.

<a href="#heading--about-the-osi-model"><h3 id="heading--about-the-osi-model">About the OSI model</h3></a>

Suppose we want to connect two computers, "SanDiego" and "Bangor", located at opposite corners of the country.  They should communicate via a network.  How do we make that happen?  We could simply hook up a wire between SanDiego and Bangor.  In fact, that's essentially how it was done in the beginning. It worked, but there wereat least two drawbacks:

1. A long wire has lots of impedance.  Signals can disappear into the noise long before they get traverse the wire.  Said differently, the signal-to-noise ratio drops critically low before completing the connection.  Repeaters can fix that problem by amplifying the signal while it's still readable.  Repeaters are physical hardware, which has to reside at intervals along the path.  You'd need places to put repeaters, which means you'd have to lease or own real estate in specific locations, at specific distances.  Cost becomes a factor at that point.

2. A long wire is a single point of failure.  If someone cuts the wire, there's no alternative way for the two computers to communicate.  Obviously, you could run multiple wires, trunk them in separate cables, have backup repeater hardware, and even use different geographical paths for each trumk.  Again, cost is a significant factor here.  

We could solve this by dreaming up all sorts of network architectures, but the easiest way is to create and use the Internet.  As the Internet became "the network", it evolved into what some call the "access-aggregation-core" (AAC) network, which looks something like this: 

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg"></a>

In this model, *SanDiego* sends a message, labelled for *Bangor*, to some router on the Internet (which one doesn't matter so much).  If this router doesn't know where *Bangor* is, it just sends it on to another router, until the message finds a router that knows where to forward the message. Theoretically, this works great, but from a practical standpoint, there are "short circuits" all over the Interne.

These "sideways paths" are there mostly for performance reasons, like latency, redundancy, and so on.  Sometimes they're there because someone can get a better deal, so the reasoning is financial, too.  Some parts of the Internet look like string art, as in the picture above.  Other places only maintain connections between routers on the same level, so they look more like ladders.

Either way, the AAC network can be very complicated and incorporate lots of redundant loops where network packets can get trapped, trying to find a way out.  We'll discover later that TCP/IP has a dedicated way to prevent these infinite loops called the "Time To Live" field.  We'll also talk about how these issues have driven us to design cloud network architectures (known as Clos architectures), which address both the financial and performance impacts of large networks in a much simpler way.

<a href="#heading--internet-infrastructure"><h3 id="heading--internet-infrastructure">About the infrastructure of the Internet</h3></a>

A very old meme explains that the Internet is survivable because every computer can connect every other computer.  While that might be possible, that's not generally how it works.  There's actually a hierarchy which we refer to as the *Internet Infrastructure*:

- Internet Infrastructure :: a hierarchy of computers used to transfer messages from one computer to another.

High-level networks, known as Network Service Providers (NSPs), connect to at least three top level nodes called Network Access Points (NAPs).  An NAP is just a way for packets to jump from one NSP to another. NAPs are public access points, but there are also privately-owned access points (at the same level) known as Metropolitan Area Exchanges; these act just like a NAP for the purposes of this discussion.  We can simplify the string-art picture above by resolving it into something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b8da34432dd443cd3592487f53887f12889cef06.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b8da34432dd443cd3592487f53887f12889cef06.jpeg"></a>

In theory, the Internet infrastructure and a cloud network should be very similar, but in practice, they diverge greatly.  The real Internet has horizontal connections running everywhere, based on drivers like cost, security, and performance.

<a href="#heading--about-network-traffic"><h3 id="heading--about-network-traffic">About network traffic</h3></a>

As implied by the discussion above, these networks can become very complicated.  There's rarely a reason to even want to know how many hops a message takes, or where it hops, unless you're trying to debug a broken route with, say, [traceroute]([https://linux.die.net/man/8/traceroute).  From a TCP/IP point of view, it's much easier to ignore the specific network, since it gets built on-the-fly, so to speak; and it can change every time a message is sent, even between the same two computers.

In other words, when it comes to designing and troubleshooting networks, knowing the specific route (almost) never helps.  Instead, what we want to know about is the /network traffic/ that travels between computers.  That means we have to understand what /kind/ of traffic travels between computers, besides just the data we send. 

<a href="#heading--about-bond-and-bridge-interfaces"><h3 id="heading--about-bond-and-bridge-interfaces">About bond and bridge interfaces</h3></a>

A bond interface is used to aggregate two or more physical interfaces into a single logical interface. Combining multiple network connections in parallel can increase network throughput beyond what a single NIC will allow.  It also provides some redundancy in case one of the NICs should fail.  More information about the theory behind bonded NICs is found in the [relevant IEEE standard](https://1.ieee802.org/tsn/802-1ax-rev/).

A network bridge may be useful if you intend to use virtual machines or containers with MAAS. You can create a network bridge with MAAS; via netplan; or by any other established method to create a network bridge.

<a href="#heading--about-network-discovery"><h2 id="heading--about-network-discovery">About network discovery</h2></a>

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli 
MAAS constantly listens to the network and reports any discovered devices. Devices are identified when the rack controller observes them communicating on an attached IPv4 subnet. Discovered devices that do not correspond to machines and devices already known to MAAS can be listed via the CLI. If a device advertises a hostname using `mDNS` (such as with `avahi` or `Bonjour`), MAAS will also present the discovered hostname when listing devices.

An unknown discovered device can be added to MAAS as a device, or as a network interface belonging to a machine or device. You can specify values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Indicating a Parent device is optional.
rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui /snap/3.1/ui /deb/3.1/ui 
MAAS constantly listens to the network and reports any discovered devices. Devices are identified when the rack controller observes them communicating on an attached IPv4 subnet. Discovered devices that do not correspond to machines and devices already known to MAAS are shown on the dashboard. If a device advertises a hostname using `mDNS` (such as with `avahi` or `Bonjour`), MAAS will also present the discovered hostname in the Dashboard.

Using the Dashboard, an unknown discovered device can be added to MAAS as a device or as a network interface belonging to a machine or device. Clicking the down arrow to the right of a new device allows values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Selecting a Parent device is optional.
rad-end

<a href="#heading--about-subnet-management"><h2 id="heading--about-subnet-management">About subnet management</h2></a>

Fabrics, VLANs, and spaces do not require much configuration beyond names and descriptions. You can change the MTU for a VLAN, as well as [enable DHCP](/t/how-to-manage-dhcp/nnnn#heading--enabling-dhcp).  None of these options requires detailed instruction.

A subnet, on the other hand, provides a number of configuration options relevant to the day-to-day operation of MAAS. By default, MAAS manages subnets in your configuration, but this is easily changed.

When a subnet is managed, MAAS handles all aspects of IP address allocation. This process includes managing DHCP leases and assigned static addresses. Typically MAAS would have one managed subnet, with any additional subnets unmanaged. This arrangement allows for more control over which subnet gets used for DHCP. Additionally, as detailed below, an unmanaged subnet treats reserved IP ranges differently, in a way that some administrators find more intuitive.

<a href="#heading--about-managed-subnets"><h3 id="heading--about-managed-subnets">About managed subnets</h3></a>

When you enable management for a subnet, MAAS will:

1.   Lease addresses for DHCP from a reserved dynamic IP range
2.   Assign static addresses not included in a reserved IP range, typically via 'Auto assign' IP allocation mode for a node.

See [Concepts and terms](/t/maas-concepts-and-terms-reference/nnnn#heading--ip-ranges) for an explanation of the two kinds of reserved IP ranges MAAS uses.

If needed, you can also define a static route between two subnets. A static route is defined on a per-subnet basis to use a particular gateway, using a configured destination.

<a href="#heading--about-unmanaged-subnets"><h3 id="heading--about-unmanaged-subnets">About unmanaged subnets</h3></a>

When management is disabled for a subnet, the definition of a reserved IP range differs from the managed mode. Here, a reserved IP range tells MAAS to **only allocate addresses from this range** (via 'Auto assign'). Also, DHCP will never lease addresses from an unmanaged subnet.

<a href="#heading--about-ip-address-tracking"><h3 id="heading--about-ip-address-tracking">About IP address tracking</h3></a>

When you enable IP address tracking, MAAS will keep track of all assigned addresses, regardless of whether they come from managed or unmanaged subnets.

<a href="#heading--about-ipv6"><h2 id="heading--about-ipv6">About IPv6</h2></a>

Support for IPv6 in MAAS is similar to support for IPv4.  A rack controller in an IPv6 context needs to have the region API server URL specified with brackets:

``` nohighlight
http://[::1]:5240/MAAS/
```

You can access the Web UI and the [MAAS CLI](/t/how-to-use-the-maas-cli/nnnn) (that is, logging in to the API server) in the same way on both IPv4 and IPv6. To use an IPv6 address in a URL, surround it with square brackets. For example, on the local machine (`::1`, the IPv6 equivalent of `localhost`):

[note]
MAAS can only control most BMCs using IPv4.
[/note]

<a href="#heading--about-enabling-ipv6"><h3 id="heading--about-enabling-ipv6">About enabling IPv6</h3></a>

You enable IPv6 networking in the same way that you enable IPv4 networking: configure a separate rack controller interface for your IPv6 subnet. The IPv6 interface must define a static address range. Provided that you already have a functioning IPv6 network, that's all there is to it. The following sections explain requirements, supported operations, and what to do if you don't yet have a functioning IPv6 network.

An IPv6 interface can use the same network interface on the rack controller as an existing IPv4 network interface. It just defines a different subnet, with IPv6 addressing. A machine that's connected to the IPv4 subnet also connected to the IPv6 subnet on the same network segment.

<a href="#heading--about-ipv6-subnets"><h3 id="heading--about-ipv6-subnets">About IPv6 subnets</h3></a>

If you define a reserved static IP range, then machines deployed on the subnet will get a static address in this range. Since IPv6 networks usually are 64 bits wide, you can be generous with the range size. You can typically leave the netmask and broadcast address fields blank.

You may want MAAS to manage DHCP and DNS, but it's not required. Machines do not need a DHCP server at all for IPv6; MAAS configures static IPv6 addresses on a machine's network interface while deploying it. A DHCPv6 server can provide addresses for containers or virtual machines running on the machines, as well as devices on the network that are not managed by MAAS. The machines do not need DHCPv6. MAAS will not be aware of any addresses issued by DHCP, and cannot guarantee that they will stay unchanged.

<a href="#heading--about-ipv6-routing"><h3 id="heading--about-ipv6-routing">About IPV6 routing</h3></a>

In IPv6, clients do not discover routes through DHCP. Routers make themselves known on their networks by sending out route advertisements. These RAs also contain other configuration items:

 * Switches that allow stateless configuration of their unique IP addresses, based on MAC addresses. 
* Switches that enable them to request stateless configuration from a DHCP server.
* Switches that In any allow them to request a stateful IP address from a DHCP server. 

Since a network interface can have any number of IPv6 addresses even on a single subnet, several of these address assignment mechanisms can be combined.

However, when MAAS configures IPv6 networking on a machine, it does not rely on RAs. It statically configures a machine's default IPv6 route to use the router that is set on the cluster interface, so that the machine will know their default gateway. They do not need DHCP and will not autoconfigure global addresses.

You may be planning to operate DHCPv6 clients as well, for example, on machines not managed by MAAS, or on virtual machines hosted by MAAS machines.  If this is the case, you may want to configure RAs, so that those clients obtain configuration over DHCP.

If you need RAs, but your gateway does not send them, you could install and configure `radvd` somewhere on the network to advertise its route.

<a href="#heading--about-stp"><h3 id="heading--about-stp">About STP</h3></a>

Some switches use the Spanning-Tree Protocol (STP) to negotiate a loop-free path through a root bridge. While scanning, it can cause each port to wait up to 50 seconds before sending data. This delay, in turn, can cause problems with some applications/protocols such as PXE, DHCP and DNS, of which MAAS makes extensive use.

To alleviate this problem, you should enable the [Rapid Spanning Tree Protocol](https://en.wikipedia.org/wiki/Spanning_Tree_Protocol) (known as [Portfast](https://www.cisco.com/c/en/us/td/docs/switches/lan/catalyst4000/8-2glx/configuration/guide/stp_enha.html#wp1019873) for Cisco switches), which allows the ports to come up almost immediately.

<a href="#heading--about-availability-zones"><h2 id="heading--about-availability-zones">About availability zones</h2></a>

This section explains some characteristics and uses of availability zones.

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
