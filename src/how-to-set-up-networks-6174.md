<!-- "How to set up networks" -->
Congratulations!  Now that you've [gotten started with MAAS](/t/how-to-get-started-with-maas/6202), configuring your MAAS networks is an important next step.  This major section will help you learn about the theory and practice of MAAS networking.

If you're eager to get started, you can go ahead and [connect your MAAS networks](/t/how-to-connect-maas-networks/5164) and [set up DHCP](/t/how-to-enable-dhcp/5132). You might even want to create some [availability zones](/t/how-to-manage-availability-zones/5152).

But don't feel rushed -- it depends on your comfort level with [MAAS networking](#heading--How-MAAS-networks) and [DHCP itself](#heading--Its-always-DHCP).  There are detailed explanations below, along with some catch-up summaries of [TCP/IP](#heading--TCP-IP-primer) and [cloud networking](#heading--About-cloud-networks).  Scan these first if you feel the need.

<a href="#heading--How-MAAS-networks"><h2 id="heading--How-MAAS-networks">How MAAS networks</h2></a>

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

<a href="#heading--about-power-drivers"><h3 id="heading--about-power-drivers">Power drivers define machines</h3></a>

Power drivers are units of software, embedded in MAAS, that interface with the [BMC](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface#Baseboard_management_controller) to power-cycle a machine remotely.  Different machines use different BMC configurations.  Typically, these vary by manufacturer, although there are some standard IPMI drivers that can be used.  In addition, it is sometimes possible to control a machine with a specialised BMC via a generic IPMI driver.

IPMI is designed as a set of protocols that bypass the system's CPU, BIOS, UEFI, and/or OS.  Essentially, IPMI provides a network connection directly to the hardware, allowing a number of management and monitoring functions.  From the perspective of MAAS, the main use of IPMI is to access the machine's BMC to power-cycle the machine.  In order for [PXE-booting](#heading--about-pxe-booting) to start, the machine itself must send a PXE-enabled DHCPDISCOVER, which requires the machine to be powered on.

Specific machine models have different IPMI parameters that can or must be used to successfully power on a machine, although many models respond reasonably well to standard IPMI or [Redfish](https://en.wikipedia.org/wiki/Redfish_(specification)) commands. MAAS includes customised power drivers for all of the machines listed in the [power catalogue](/t/power-management-reference/5246#heading--power-catalogue).

IPMI provides many other functions and capabilities besides power-cycling the machine, such as monitoring system state (e.g., temperature) and possibly adjusting some parameters remotely.  MAAS generally does not avail itself of these additional features.

<a href="#heading--about-proxies"><h3 id="heading--about-proxies">Proxies</h3></a>

A [proxy server](https://en.wikipedia.org/wiki/Proxy_server) ("proxy service" or just "proxy") is an intermediary application that serves to broker network transactions between two hosts.  Proxies provide several benefits, including privacy (protecting internal IP addresses from discovery by those on other networks), security (performing some checks against incoming packets), and load-balancing (routing packets to multiple servers, based on actual load or some statistical algorithm).  

MAAS provides an [internal proxy](/t/how-to-connect-maas-networks/5164#heading--internal-proxy-maas-proxy), which is an HTTP caching proxy server that is available to all hosts residing in any subnet managed by MAAS.  In addition, MAAS allows you to define an [external proxy](/t/how-to-connect-maas-networks/5164#heading--configure-proxy) if desired.

<a href="#heading--about-rpc"><h3 id="heading--about-rpc">RPC</h3></a>

A [Remote Procedure Call](https://www.ibm.com/docs/en/aix/7.1?topic=concepts-remote-procedure-call), or RPC, is a method by which one computer can execute a subroutine sent by another process or system.  These procedures run as if they were native to the machine executing them, even though they may have been prepared or coded on the requesting machine.  In the case of MAAS, [RPC is used for communication between the region and rack controllers](/t/how-to-tune-controllers-6498#heading--rackregion), specifically to transfer the PXE configuration from region to rack.  This allows the relevant MAAS rack to answer the machine's DHCPDISCOVER with a DHCPOFFER that contains the correct PXE booting information to bring the machine to an ephemeral Ubuntu instance. 

<a href="#heading--about-network-discovery"><h3 id="heading--about-network-discovery">Waht is network discovery?</h3></a>

MAAS constantly listens to the network and reports any discovered devices. Devices are identified when the rack controller observes them communicating on an attached IPv4 subnet. Discovered devices that do not correspond to machines and devices already known to MAAS can be listed via the CLI. If a device advertises a hostname using `mDNS` (such as with `avahi` or `Bonjour`), MAAS will also present the discovered hostname when listing devices.

[tabs]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
Using the Dashboard, an unknown discovered device can be added to MAAS as a device or as a network interface belonging to a machine or device. Clicking the down arrow to the right of a new device allows values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Selecting a Parent device is optional.
[/tab]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
An unknown discovered device can be added to MAAS as a device, or as a network interface belonging to a machine or device. You can specify values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Indicating a Parent device is optional.
[/tab]
[/tabs]

<a href="#heading--subnets"><h2 id="heading--subnets">Subnets</h2></a>

A [subnet](https://en.wikipedia.org/wiki/Subnetwork#firstHeading) is a "layer 3" network, defined by a network address and a network mask length (in bits) and usually written in "CIDR" format. MAAS supports IPv4 and IPv6 subnets. Examples include:

``` no-highlight
- 0.0.0/8
- 16.0.0/12
- 168.0.0/16
2001:db8:4d41:4153::/64
```

<a href="#heading--vlans"><h2 id="heading--vlans">VLANs</h2></a>

[VLANs](https://en.wikipedia.org/wiki/Virtual_LAN#firstHeading) (Virtual LANs) are a common way to create logically separate networks using the same physical infrastructure.

Managed switches can assign VLANs to each port in either a "tagged" or an "untagged" manner. A VLAN is said to be "untagged" on a particular port when it is the default VLAN for that port and requires no special configuration to access it.

You can use also use tagged VLANs with MAAS nodes. If a switch port is configured to allow tagged VLAN frames from a MAAS node, that node can automatically access interfaces on that VLAN.

A "Default VLAN" is created for every fabric, to which every new VLAN-aware object in the fabric will be associated with by default (unless specified otherwise).

<a href="#heading--about-subnet-management"><h3 id="heading--about-subnet-management">You manage subnets</h3></a>

Fabrics, VLANs, and spaces do not require much configuration beyond names and descriptions. You can change the MTU for a VLAN, as well as [enable DHCP](/t/how-to-enable-dhcp/5132#heading--enabling-dhcp).  None of these options requires detailed instruction.

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


<a href="#heading--about-availability-zones"><h3 id="heading--about-availability-zones">Availability zones</h3></a>

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

<a href="#heading--Its-always-DHCP"><h2 id="heading--Its-always-DHCP">It's always DHCP</h2></a>

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

<a href="#heading--TCP-IP-primer"><h2 id="heading--TCP-IP-primer">A TCP/IP primer</h2></a>

Good understanding of networking fundamentals makes it much easier to design, operate, and debug MAAS networks. You may have a good grasp of these fundamentals, but not everyone does, and that's perfectly normal.  Here's a quick refresher on TCP/IP networking, with references.  Feel free to pick and choose sections as you need them.

TCP/IP networks evolved to meet a specific need: How can we keep a network functioning if important nodes go offline?  Well, you build the ARPAnet -- now called the Internet -- which relies heavily on TCP/IP networks.  The OSI model underlying TCP/IP can adapt to changing loads, handle significant failures, and strictly limit the network "blast radius" (yes, that's what it's called) when things go wrong.   

This article is designed to help you learn:

- [About the Internet](#heading--about-the-internet)
- [About the OSI model](#heading--about-the-osi-model)
- [About bond interfaces](#heading--about-bond-interfaces)
- [About bridge interfaces](#heading--about-bridge-interfaces)
- [About ARP](#heading--about-arp)
- [About TCP](#heading--about-tcp)
- [About DNS](#heading--about-dns)
- [About other network elements](#heading--other-network-elements)

[note]
While some standard networking concepts, such as PXE booting, RPC, subnets, power drivers, and proxies are not unique to MAAS, they are sometimes used in a unique way by MAAS -- so we explain these concepts in the article entitled "[About MAAS networking](#heading--How-MAAS-networks)".
[/note]

<a href="#heading--about-the-internet"><h3 id="heading--about-the-internet">About the Internet</h3></a>

A network could be nothing more than a bunch of computers connected with wires. This isn't efficient or affordable.  Obviously, many wires are hard to keep straight. Also, impedance would dampen the signals after a relatively short run of wire.  An easier way is the Internet infrastructure, which is an [access-aggregation-core (AAC)](https://www.cisco.com/c/en/us/td/docs/solutions/Enterprise/Data_Center/DC_Infra2_5/DCInfra_2.html) network.  AAC looks something like this: 

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg"></a>

Routers are the multiplexing elements in AAC networks.  Ladders of lateral paths aren't theoretical; they exist mostly for performance reasons, like latency, redundancy, cost, and so on.  This means an AAC network incorporates redundant loops or "packet-traps".  TCP/IP has a dedicated solution for this problem, called ["Time To Live"](https://en.wikipedia.org/wiki/Time_to_live#firstHeading).

Issues with ladder networks drove the development of cloud network architectures (also known as Clos architectures), which address financial and performance impacts of large networks in a much simpler way. [Cloud networking](#About-cloud-networks) is covered elsewhere, and should be next on your reading list.

[Network switching](https://en.wikipedia.org/wiki/Network_switch#firstHeading) is a very large topic unto itself.  It's worth catching up if you're weak in this area, since some elements of switching are exposed in MAAS networks.  Also important to review are [routers](https://en.wikipedia.org/wiki/Router_%28computing%29#firstHeading), [bridges](https://en.wikipedia.org/wiki/Network_bridge#firstHeading), and bonded NICs, aka [link aggregation](https://en.wikipedia.org/wiki/Link_aggregation#firstHeading).  All of these come into play every time a MAAS network is modified.

<a href="#heading--borrowed-from-ma-bell"><h4 id="heading--borrowed-from-ma-bell">Yesterday's phone network is today's Internet</h4></a>

Most of today's modern networking is a direct translation of the landline telephone system into the digital space.  Network switching is really just an outgrowth of [crossbar](https://en.wikipedia.org/wiki/Number_Five_Crossbar_Switching_System#firstHeading), which is how local phone calls were "switched" or "routed" to the correct telephone line.  In most cases, every number dialled closed one more relay, with all seven relays making a connection to the target phone line.

Small exchanges often "swallowed" dialled digits. For example, if every local phone number had the exchange "881", those numbers wouldn't trigger any relays beyond just sending the call to the "881" [frameset](https://en.wikipedia.org/wiki/Distribution_frame#firstHeading).  In some small exchanges, it wasn't even necessary to dial the exchange, just the four digits of the phone number, if the caller had the same exchange.  Essentially, these were the early [subnets](https://en.wikipedia.org/wiki/Subnetwork#firstHeading).

Over time, the increasing density of telephone coverage and self-service long-distance changed all this.  More wires had to be installed, and repeaters were needed to get signals across longer distances as local exchanges were replaced by centralised exchanges called "central offices" (CO).  A CO would have frames for 8 or 10 exchanges, essentially serving the same function as today's network routers.

Repeaters had to be installed at regular intervals to overcome the impedance associated with longer wires.  Those color-camouflaged, "go-away-grey" metal cans (called pedestals) popped up everywhere, partly for easy re-routing of wires, and partly to house repeaters.  We still have those in today's networks, but they're called racks or patch-panels.

In the very early days of long-haul networking, most of the repeaters were owned by the local telephone companies. T1 lines, as they were called, couldn't compete with today's fibre connections, but they did provide a speedy (at the time) 1.5Mbps connection.  For example, in the oil and gas industry of the early 1990s, many of the city offices had wall after wall of T1 lines wired directly into the building.

T1 wasn't designed for network traffic, exactly,  The idea was to multiplex phone calls on one line via Time-Division Multiplexing.  TDM split up the call traffic into little digital packets that were sent on a rotating basis.  The first T1 lines, which showed up around 1962, could handle about 24 calls without the average telephone user noticing.  Telephone linemen generally could tell by the "clipped" nature of the call, as there is a distinctive flatness to the conversation over a digital TDM circuit.  These "little digital packets" formed the model for the packet networking we have today.

The T1 lines used ordinary, double-twisted-pair copper wiring, with repeaters at roughly one-mile intervals (about every fourth pedestal). When WAN and MAN networking became a thing, the phone company just repurposed some of those pairs to carry data traffic.  Many other key elements of TCP/IP, like twisted-pair Ethernet cables, packet-based messaging, and multiplexing, are all just holdovers of the original telephone system, repurposed for computer networking.

<a href="#heading--internet-infrastructure"><h4 id="heading--internet-infrastructure">More about Internet infrastructure</h4></a>

The Internet is theoretically survivable because every computer can connect to every other computer.  That's not standard operating procedure.  High-level networks [(Network Service Providers, NSPs)](https://en.wikipedia.org/wiki/Internet_service_provider#firstHeading) connect to at least three top level nodes called Network Access Points (NAPs), aka [Internet Exchange Points](https://en.wikipedia.org/wiki/Internet_exchange_point#firstHeading).  At these points, packets to jump from one NSP to another. NAPs are public access points, Metropolitan Area Exchanges are private. These are virtually indistinguishable for the purposes of this discussion.

As an aside, many of the MAEs are the residue of the phone company's early T1 lines, which was the initial backbone for the Internet.  These MAEs act just like a NAP for the purposes of this discussion.

A simpler picture of the Internet infrastructure looks like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b8da34432dd443cd3592487f53887f12889cef06.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b8da34432dd443cd3592487f53887f12889cef06.jpeg"></a>

In theory, the Internet infrastructure and a cloud network should be very similar.  In practice, they diverge greatly.  The real Internet has horizontal connections running everywhere, based on drivers like cost, security, and performance.  Those vertical connections introduce an interface cost (heterogeneous hardware), a performance hit (varying network speeds), and bandwidth variance (differing node architectures).  Contracts for lateral connections change daily, which changes the routing, which changes the way the Internet behaves for users.

<a href="#heading--about-network-traffic"><h4 id="heading--about-network-traffic">About Internet network traffic</h4></a>

On-the-fly, Internet network paths can become very complicated and somewhat unpredictable.  As a result, there's rarely a reason to even count how many hops a message takes, or where it hops, unless you're trying to debug a broken route with, say, [traceroute](https://linux.die.net/man/8/traceroute)‘↗‘.  From a TCP/IP point of view, it's much easier to ignore the specific network, since each one is custom built, so to speak.  The path can theoretically change every time a message is sent, even between the same two computers.

When it comes to designing and troubleshooting networks, knowing the specific route (almost) never helps.  What we do want to know about is the network traffic between computers.  We have to understand what kind of data travels between computers, besides just the data we send.  Internet data flows are governed by the OSI model.   

<a href="#heading--about-the-osi-model"><h3 id="heading--about-the-osi-model">About the OSI model</h3></a>

This subsection will help you learn about the OSI model and:

- [About the physical layer (L1)](#heading--about-the-physical-layer)
- [About the datalink layer (L2)](#heading--about-the-datalink-layer)
- [About the network layer (L3)](#heading--about-the-network-layer)
- [About the transport layer (L4)](#heading--about-the-transport-layer)
- [About the session layer (L5)](#heading--the-session-layer)
- [About the presentation layer (L6)](#heading--the-presentation-layer)
- [About the application layer (L7)](#heading--the-application-layer)

Networks are really just continuous wires.  We need to understand what travels on those wires, which depends on our perspective -- our level of magnification.  At the highest "zoom" level, all we'll see are electrons travelling down the wire; that's a level of abstraction that isn't comprehensible for debugging purposes.  About all we can tell is whether or not the circuit's dead.

The [Open Systems Interconnection model](https://en.wikipedia.org/wiki/OSI_model) was created to standardise on a few different levels.  The OSI model looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/765cd90cffcecfcc83593cde0483e64977a48223.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/765cd90cffcecfcc83593cde0483e64977a48223.jpeg"></a>

The OSI model starts just above the raw physics, with the physical layer, also known as Layer 1.

The choice of "1" makes sense, because this is the lowest level we consider. Layers are normally added on top of each other.  For example, if you put six coats of varnish on a piece of furniture, you're going to have six layers.  The first layer you put on wouldn't sensibly be called "layer 6"; neither network layering work that way.

Here's a quick rundown of what each layer does.  Most likely, we won't get into details about all the layers, because the higher you go, the more widely they vary with the user application.  Higher layers don't really help us better understand MAAS networking, any more than watching electrons travel through a wire help us debug a missing packet.

<a href="#heading--about-the-physical-layer"><h4 id="heading--about-the-physical-layer">About the physical layer (L1)</h4></a>

The phrase "physical layer" may conjure up notions of physics, but don't worry: we look at signals, not electrons.  Here you can learn about the basics of the physical layer, and also:

- [About variable latency](#heading--about-variable-latency)
- [Why the physical layer is not very interesting](#heading--physical-layer-uninteresting)

At the physical layer, we're looking for binary (on/off) signals, set to the cadence of a clock.  Every computer brings its own clock to the party, so we definitely need a way to "synchronise our watches".  [NTP](https://en.wikipedia.org/wiki/Network_Time_Protocol), the network time protocol, does the trick.  

<a href="#heading--about-variable-latency"><h5 id="heading--about-variable-latency">About variable latency</h5></a>

Variable latency is the important thing to know about the physical layer, because it affects the timing of network traffic. In order to understand variable latency, we need to understand network latency.  Packets aren't sent without some delay, because of:

1. The processing delay - how long it takes the router to process the packet header.
2. A queuing delay - how long the packet sits idle in routing queues.
3. Transmission delay - how long it takes layer 1 to push the packet's bits onto the link.
4. Propagation delay - how long it takes the bits to travel through the wire to the other end.

The size of the queue directly influences how fast data can get onto the link.  The processing and transmission delays are real, though relatively constant.  The propagation delay doesn't just depend on the speed of light, because there may be lots of other "relay" computers in the link.  Propagation depends on network architecture, network congestion, and the number of hops (how many routers between source and destination), among other things.  As we'll see later on, within your enterprise, [modern cloud architectures](#About-cloud-networks) usually create significantly less propagation delay.

Variable-latency networks are "variable" because of the density of network traffic and the complexity of the route between hosts.  We can't predict congestion or routing, although we can influence local routing by choosing the right network architecture.  We can't predict transmission delays, though we can statistically bound them.  Almost all digital networks are considered "variable-latency".

<a href="#heading--physical-layer-uninteresting"><h5 id="heading--physical-layer-uninteresting">The physical layer is not very interesting</h5></a>

Other than verifying that signals are flowing, the physical layer doesn't usually tell us much about what happened to that DHCP request that never made it to the router.  Consequently, we really won't talk that much about the physical layer.  Just know that it's the thing that's passing bits back and forth between hosts, and very occasionally, we need to scan it to debug network issues.

<a href="#heading--about-the-datalink-layer"><h4 id="heading--about-the-datalink-layer">About the datalink layer (L2)</h4></a>

The datalink layer (the "link" layer, layer 2 or "L2") has one purpose: send and receive IP datagrams.  L2 doesn't maintain a connection with the target host; it's intentionally "connectionless", and it doesn't guarantee delivery or integrity of packets.  It just ships them between source and destination.  This subsection will help you learn:

- [About MAC frames](#heading--about-frames)
- [About Ethernet](#heading--about-ethernet)
- [About Media Access Control (MAC)](#heading--about-media-access-control)
- [About trunking VLANs](#heading--about-trunking-vlans)
- [About VLANs, subnets, and fabrics](#heading--about-vlans-subnets-and-fabrics)
- [How to visualise the link layer](#heading--visualising-the-link-layer)

At first, the message-agnostic state of the link layer may seem a little weird.  L2 is not without error-checking and recovery code, but it functions efficiently because it isn't concerned with the data or the message containing the data.  That fact can be surprising, since L3 packets are called "datagrams".

A datagram is just a basic network transfer unit -- the indivisible unit for a given layer.  If we're talking about the data-link layer (aka the "link" layer), it's an IEEE 802.xx frame.  At the network layer, it's a data packet.  For the transport layer, it would be called a segment.  Indivisible units in the physical layer are called chips, which are spread-spectrum pulses in the CDMA, noise-utilising transmission system that operates at that layer.

Since datagram isn't carefully used by everyone (think of User Datagram Protocol), we'll agree to call these indivisible layer units PDUs (protocol data units).  This avoids conflation with other uses and reminds you that it's the atomic unit at the current network layer.  Just remember that, at the link layer (L2), it's a frame.

<a href="#heading--about-frames"><h5 id="heading--about-frames">About MAC frames</h5></a>

A MAC frame, or just "frame", encapsulates the packets from the network layer so that they can be transmitted on the physical layer.  A frame can be small or big, anywhere from 5 bytes up to the kilobyte range.  The upper size limit is called the maximum transmission unit (MTU) or maximum frame size.  This size is set by the particular network technology in use.

This last observation brings up a good point: In order to talk sensibly about frames, we'd need to say what kind of frame.  With MAAS, we're always talking about packet-switched networks, so there are potentially four frame types to consider: Ethernet, fibre channel, V.42, and PPP (point-to-point protocol).

Happily, MAAS networks almost exclusively use Ethernet, as defined in the [IEEE 802 standards](https://www.ieee802.org/), so we'll stick to that particular frame type for this discussion.  Where other frame types may come into play, we'll discuss those as special cases.  

<a href="#heading--about-ethernet"><h5 id="heading--about-ethernet">About Ethernet</h5></a>

Before explaining an Ethernet Frame, we need to give a little background information about how Ethernet works; otherwise a lot of the frame components either won't make sense, or you'll wonder how it works at all.

Remember earlier, when we talked about voice radio, and the need to say "over"?  Well, Ethernet at the link layer is all about controlling the conversation, so that computers don't "talk over each other".  Ethernet implements an algorithm called CSMA/CD, which stands for "carrier sense multiple access with collision detection."  This algorithm controls which computers can access the shared medium (an Ethernet cable) without any special synchronisation requirements.

"Carrier sense" means that every NIC does what humans do when we're talking: it waits for quiet.  In this case, it's waiting for the network to be quiet, that is, when no signal is being sent on the network.

"Collision detection" means that, should two NICs both start to send on a shared network at the same time (because the network was quiet), they each receive a jam signal.  This signal tells them to wait a specific, randomly-generated amount of time before attempting again.  Every time subsequent messages collide, the NIC waits twice the amount of time it previously waited.  When it waits some maximum number of times, the NIC will declare a failure and report that the message didn't go.  This ensures that only one frame is traversing the network at any given time.

<a href="#heading--about-media-access-control"><h5 id="heading--about-media-access-control">About Media Access Control (MAC)</h5></a>

Systems like CSMA/CD are a subset of the Media Access Control (MAC) protocol kit.  MAC is one-half of the link layer, with Logical Link Control (LLC) being the other half -- though these are sometimes called sub-layers. LLC mostly just defines the frame format for the 802.xx protocols, like WiFi, so we can safely ignore it for the purposes of MAAS networking.

If you've worked with networks at all, you've heard of MAC addresses.  Those are basically unique serial numbers assigned to network interface devices (like NICs) at the time of manufacture.  Theoretically, they are unique in the world, not counting virtual NICs in virtual machine environments.  [MAC address collisions](https://kb.vmware.com/s/article/219) do happen when using VMs, and there are ways to fix it, assuming that your VMs are confined to a subnet.

The MAC sub-layer is connected to the physical layer by a media-independent interface (MII), independent of the actual link protocol (e.g, cellular broadband, Wi-Fi radio, Bluetooth, Cat5e, T1, ...).  You can learn more about the [MII](https://en.wikipedia.org/wiki/Media-independent_interface) if you're so inclined, but we won't address it again in the context of MAAS networks.

Essentially, the MAC sub-layer grabs higher-level frames and makes them digestible by the physical layer, by encoding them into an MII format.  It adds some synchronisation info and pads the message (if needed).   The MAC sub-layer also adds a frame check sequence that makes it easier to identify errors.

In conventional Ethernet networks, all this looks something like the following:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/14f6847ed92339061eb4515c12ac2b6117d5cd7c.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/14f6847ed92339061eb4515c12ac2b6117d5cd7c.jpeg"></a>

Let's decode those blocks of bits:

- The **Preamble** is 7 bytes of clock sync, basically just zeroes and ones like this: ...0101010101....  This gives the receiving station a chance to catch up and sync their clock, so the following data isn't out of sync (and thus misinterpreted).  To delve just a little deeper, the Preamble helps the receiving NIC figure out the exact amount of time between encoded bits (it's called clock recovery).  NTP is nice, but Ethernet is an asynchronous LAN protocol, meaning it doesn't expect perfectly synchronised clocks between any two NICs.  The Preamble is similar to the way an orchestra conductor might "count the players in" so they all get the same rhythm to start.  Before clock recovery, there was MPE. Clock recovery is much more reliable than trying to get computers all over the world synced up to the same clock frequency and the same downbeat (starting point).  Ethernet actually started out that way with something called Manchester Encoding or Manchester Phase Encoding (MPE).  This was important because electrical frequency varies not only across the world, but also from moment to moment when the power is slightly "dirty".  MPE involved bouncing a bit between two fractional voltages using a 20MHz oscillator to generate a reference square wave.  It works, but it's not very efficient, so MPE was scrapped in favour of using the Preamble, the way that projectionists use alignment marks on reels of movie film.
   
- The **Start Frame Delimiter (SFD)** is the last chance for clock sync.  It is exactly 10101011, where the "11" tells the receiving station that the real header content starts next.  The receiving NIC has to recover the clock by the time it hits the SFD, or abandon the frame to the bit bucket.

- The **Destination Address (DAddr)** is six bytes long, and gives the physical address -- the MAC address -- of the next hop.  Be aware that the next hop might be the destination, but it's also possible that the next hop might be a NAP, MAE, NSP, or intermediate ISP.  It's basically the next address in the direction of the destination that the sender knows about.  Unlike the Source Address, the Destination Address can be in a broadcast format (similar to a subnet like 192.18.0.0, but using MAC addresses).

- The **Source Address (SAddr)** is also a six-byte MAC address, this time the MAC address of the sender, which does not change as long as the message is traversing only layer-2 (Ethernet) switches and routers.

- The **PDU Length (PDULen)** gives the byte length of the entire frame, assuming that it's 1500 or less.  If it's longer than that, it indicates a message type, like IPv4, ARP, or a "q-tagged" frame, which carries a VLAN ID.

- The **DSAP**, **SSAP**, and **Control** elements are each one byte in length, and help define devices and protocols.  For the most part, we won't be worried about these with MAAS networks.  Just know that as more and more 802 point-standards come out (e.g., 802.11, WiFi), these elements get longer and more complex.

- The **Data** or "Payload" is the actual packet being sent, which in the case of TCP/IP, is just a TCP header attached to a fixed-length chunk of the application's data.  It's passed on from the layer above.  It cannot be less than 46 bytes, and in conventional Ethernet, it cannot be larger than 1500 bytes.  If the actual data is too small, it's padded out to 46 bytes.

- The **CRC** or "Frame Checksum" (FCS) is a standard checksum, used to verify that the message hasn't been corrupted along the way.

The Preamble and SFD are often considered to be part of the IEEE "packet", so some people start counting the "frame" at the Destination Address.  That distinction shouldn't affect anything we do with MAAS networks, but it's nice to keep in mind, in case you run into someone who groups packets differently than you do.

<a href="#heading--about-trunking-vlans"><h5 id="heading--about-trunking-vlans">About Trunking VLANs</h5></a>

There is a crucial modification to the basic frame format called a P/Q or VLAN Tag.  This allows something called VLAN trunking, which means sending all the VLAN data over the same wire and port, but giving the NICs a field (the P/Q tag) to control access.  On paper, it looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/6e58930520fe4ed38d5ea49fab7a337627a88a55.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/6e58930520fe4ed38d5ea49fab7a337627a88a55.jpeg"></a>

As you can see in the modified P/Q frame, the following fields replace part of the frame:

- Sixteen bits of tags or a protocol ID.

- Three bits representing a priority.

- One bit is used as a Canonical Format Indicator (CFI), which is 0 if the following VLAN ID is in Ethernet format, or 1 if it's in Token Ring format.

- Twelve bits of VLAN ID.

This matters when we're building complex MAAS networks with lots of VLANS that probably cross over switches.  After all, VLANs were initially controlled with ports and switches, although they more commonly use tags now.  When more than one VLAN spans multiple switches, frames need to carry VLAN information that can be used by switches to sort or "trunk" the traffic.

<a href="#heading--origin-of-trunking"><h4 id="heading--origin-of-trunking">The origin of "trunking"</h4></a>

The word "trunking" is derived from the telephone network term trunk lines, which are lines connecting switchboards.

In the original telephone company model, each telephone had a subscriber line, which was a wire that went straight from the local Central Office (CO) to that subscriber's telephone.  Each CO had one switchboard, though it might have many seats.

Connections between Central Offices were handled by trunk lines, because they ran between phone company facilities.  You'd have a thick cable with lots of pairs running from CO to CO, basically enough wires to handle something like 35% of the possible calls.  If you ever got the message, "All circuits are busy now; please try your call again later", you've heard what happens when the system is "trunking above capacity" or "TAC'd", as it was called.

At the CO, the wires would "branch" and run all over the place: First to junction points (those five-foot-tall boxes you see from time to time on the road), then to interface points (the square cans beside the road every half mile or so, also called "pedestals") and from there to subscriber homes.  When you draw out this network, it looks like a tree, where the bundles of cables between COs look like the trunks of trees.

With VLAN trunking, by the way, we're not just multiplexing packets, we're actually multiplexing LAN channels, so to speak.  

In the parlance of networks, especially VLANs, the term "trunking" is used to indicate the sharing of network routes.  This sharing is made possible by the Ethernet VLAN tags, which make the VLAN-bound messages less dependent on switches and routers to get the traffic to the right place.  Otherwise, you'd have to designate complicated port configurations for switches, which is particularly easy to misconfigure.

Note that the MAC sub-layer is responsible for managing CDMA/CD, that is, detecting a clear line, initiating re-transmission if there's a jam signal, etc.  On the way in, the MAC sub-layer verifies the CRC/FCS and removes frame elements before passing the data up to the higher layers.  Basically, anything that some other MAC layer did to encapsulate the message for sending, the receiving MAC layer un-does on the way in.

<a href="#heading--about-vlans-subnets-and-fabrics"><h5 id="heading--about-vlans-subnets-and-fabrics">About VLANs, subnets, and fabrics</h5></a>

When working with MAAS networks, you will frequently be concerned with VLANs, subnets, and fabrics, which are all network groupings:

- Subnets define (group) a range of IP addresses.
   
- VLANs group subnets.

- Fabrics group VLANs.

Let's give each of these terms a MAAS context.

**Subnets**

A subnet is a range or collection of IP addresses.  A subnet just means "sub-network," and that's exactly what it is: a subset of IP addresses that can be treated like a single block for some operations.

Subnets are defined in CIDR (Classless Inter-Domain Routing) notation. If you want to use the addresses from 192.168.13.0 to 192.168.13.255 in a subnet, you can specify that with 192.168.13.0/24.  The "24" refers to the number of bits in the subnet address, with the remainder out of 32 bits free to address hosts.  Since 8 bits can represent 256 things, that means /24 gives you the last octet, or 255 host IP addresses.

**Whatever happened to subnet classes?**  Subnets used to be defined in terms of subnet classes, like A, B, and C. That got to be a limitation, because those three classes define a fixed number of bits of the IP address that represent the split between subnet addresses and host addresses.  In other words, the class defined how many hosts could be in the network, and three classes wasn't really adequate to address all the possible permutations that network architects needed.  The change to CIDR notation made subnets more granular, allowing many more subnets from the same network.

**VLANs**

A VLAN used to be a series of IP addresses that could access a given port on a specific switch, generally the switch that gated some protected resource.  With the advent of VLAN trunking (see above), VLANs are marked with the 802.1Q (P/Q) bits in the MAC frame.  In theory, any set of addresses can be associated with any VLAN.

MAAS encourages a correspondence of subnets to VLANs. Every IP should be in exactly one subnet, and every subnet should be part of exactly one VLAN.  You don't have to do that: you could, for example, have two different subnets that overlap, like 192.168.43.0/24 and 192.168.43.0/26.  The ".26" subnet would use fewer bits for the host addresses, so only some of the addresses would overlap.  MAAS generally prevents this kind of address overlap.

Likewise, putting one subnet in two different VLANs might be possible, but it isn't practical or easy to debug when conflicts happen.  MAAS endeavours to enforce a clean "fan-out" across the network, with no possibility of conflicting IP addresses.

**Fabrics**

A fabric just collects VLANs together.  If you stick to the clean fan-out, that also means that a fabric collects subnets.  A fabric provides a higher level grouping.

Consider a MAAS-centric example.  Suppose you have one VLAN for HR, and one VLAN for payroll, so that nobody else can see HR's private files, and likewise you've got payroll data limited to just those people who should see it.

Some executives are entitled to see anything and everything about the corporation.  An "executive" fabric would group all VLANs together, so that people admitted to that fabric can access the VLANs without having to be explicitly added to each one.  That's very handy in really large organisations, saving a lot of time and effort.

<a href="#heading--visualising-the-link-layer"><h5 id="heading--visualising-the-link-layer">Visualising the link layer</h5></a>

Let's start with a message coming on Layer 1 from SanDiego to Bangor. When the message comes in, the link layer does the following things:

1. It synchronises the NIC, so that bits will indeed be recognised as bits and the message can be properly decoded.

2. It handles the source and destination addresses, using ARP as necessary. 

3. It interprets the length/type bytes and uses them, which means it must judge the length of a frame, and of the data in a frame, or, alternatively, decide whether a frame is IPv4, ARP, or VLAN ("q-tagged").  

4. It processes VLAN tags, which means, at the very least, dealing with the message priority, deciding whether the VLAN frame is Ethernet or Token Ring, and capturing and using the VLAN ID.  The layer handles messages by priority, knows how and when to send Ethernet or Token Ring frames, and knows how to route traffic to a specific VLAN.

5. It computes the checksum to make sure the message is valid.

Next, we'll take a look at the network layer, where most of the message transactions take place, and where most of our debugging will be done.

<a href="#heading--arp"><h4 id="heading--arp">Interlayer addressing: ARP</h5></a>

One frequently asked question is this: Is ARP a layer 2 or layer 3 protocol?  Actually, it's both, as you'll [discover later](#heading--about-arp), but it does all of its work at L2.  One way to distinguish L2 from L3 is to find out what happens inside the firmware of the Network Interface Card (NIC), and that's usually where ARP takes place.   ARP maps MAC addresses, which is how things are addressed in L2, into other addresses (e.g., IP addresses), which is how L3 finds things.

<a href="#heading--about-the-network-layer"><h4 id="heading--about-the-network-layer">About the network layer</h4></a>

You might have noticed in the original OSI model that "IP" was part of Layer 3, and protocol stacks like UDP and TCP were part of Layer 4.  It's a little bit confusing that we say "TCP/IP" when the "IP" really applies to so many other protocols like UDP and ICMP.  There are certainly other protocols and protocol stacks, but for the purposes of MAAS networks, we're talking almost exclusively about TCP/IP.

This subsection will help you learn:

- [About packets](#heading--about-packets)
- [About fixed packet lengths and segmented messaging](#heading--about-fixed-packet-lengths)
- [About IP packets](#heading--about-ip-packets)
- [About routing](#heading--about-routing)

The network layer does not guarantee delivery.  Essentially, it makes every effort to deliver IP datagrams (packets) to the destination, but it's error-handling is pretty simple: just toss the packet into the bit-bucket.

It's also a connectionless layer, meaning the packets making up a message aren't part of an ongoing conversation.  They can be split up, encoded, and sent separately, by different routes, and arrive completely out of order.  And packets can get duplicated or corrupted.  Figuring all this out is the job of the protocol stack (e.g., TCP) in layer 4.  The network layer, L3, just delivers packets.  

**Network byte order**: A rarely needed (but useful) fact is that the network sends bytes in big endian order.  That means bytes are transmitted starting with bit 0 and working down to bit 31, usually eight bits at a time.  A lot of the computers on the Internet use little endian encoding, which starts at the other end of the word.  In those cases, the byte order has to be reversed somewhere between the computer's memory and Layer 3. For most situations, that fact isn't particularly useful, but there is the occasional fault that involves failure to reverse byte order along the path from RAM to NIC.

<a href="#heading--about-packets"><h5 id="heading--about-packets">About packets</h4></a>

Packets are basic Internet Protocol (IP) message units.  A message will probably be split into multiple packets by L4 (the transport layer) so it can be efficiently sent.

For example, imagine that you're sending a very long letter to your friend, and all you have are lots of envelopes and first-class stamps.  If you've ever done a lot of mailing, you'll know that mailing a one-ounce letter costs you, say, fifty-eight cents.  If you add another ounce of paper to it, that second ounce only costs you, say, twenty cents.  But all you have are first class (i.e., fifty-eight-cent) stamps.

If you don't want to waste your money, you can either cram more pages in the envelope, until you're at three ounces (the most you can get with two stamps), or send two letters, each with one ounce in it.  The way envelopes go through the mailing system, you're better off not over-stuffing an envelope.  So what do you do?

You sit down and write the letter to your friend, carefully numbering the pages.  Then you divide it into piles of pages that are just under one ounce. Finally, you put each pile into an addressed, stamped envelope and mail each letter separately.  When your friend gets the letters, it doesn't matter which one gets there first, because they can reassemble your message, using the page numbers.

<a href="#heading--about-fixed-packet-lengths"><h5 id="heading--about-fixed-packet-lengths">About fixed packet lengths and segmented messaging</h4></a>

We could have designed computer networks to take messages of indeterminate lengths, but that presents some unique challenges when trying to manage network traffic.  For example, suppose you send seven overstuffed letters to your friend, and so does everyone else on your block?  All these huge letters aren't going to fit in one letter-carrier's bag, so they'll have to either send out two delivery people, or wait until tomorrow to send out someone's letters.

Choosing a fixed (relatively short) length makes it statistically possible for everyone's letters (everyone's messages) to be delivered at a fairly constant, reliable rate.  That rate will vary with the size of the overall message, not with who threw their message on the Internet first.  A larger message takes longer to send.

Messages are split into packets of consistent length before they're passed to L3, so larger messages take longer.  It's statistically more efficient to split messages into equally-sized packets than any other arrangement -- the method that gets the highest count of complete messages through the network in a given amount of time. In network terminology, it's the highest-throughput approach to network traffic.  Specifically, this technique is called multiplexing.

<a href="#heading--about-ip-packets"><h5 id="heading--about-ip-packets">About IP packets</h4></a>

The IP datagram (packet) is the backbone of most modern networks.  The following diagram depicts an IPv4 header, which attaches to the front of data packets up to about 65K long:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fc349972f6b7509b5b2459bf3bb44419961f0bcd.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fc349972f6b7509b5b2459bf3bb44419961f0bcd.jpeg"></a>

Note that IPv6 headers have only the version field in common with IPv4 headers; otherwise, they are completely different.  Here are the header fields and what information they carry:

- **IP Protocol Version**  This is "4" for IPv4 and "6" for IPv6.  There are [lots of others](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml), but they generally don't touch a MAAS network.
- **Internet Header Length** The number of 32-bit words in the header, including the options (but not including the data, since it's just the header).  Most of the time, this will have the value "5", but options do exist and are sometimes included.
- **Differentiated Services Code Point** This is used to specify special classes of service.  Normally, IP packets are delivered on a "best-effort" basis, that is, Layer 3 will try everything possible to make sure a packet gets delivered.  You can cause L3 to deliver packets with higher priority (implying more certainty) by using a different DSCP.
- **ECN = Explicit Congestion Notification** These bits are both set by an ECN-capable router when that router is above a certain traffic threshold.  They are there to alert a sender to slow down (or expect delays) when the network segment in use is particularly congested.
- **Total Length of IP Packet** This field indicates the length of the entire packet, including the data.  This makes it possible to calculate the byte offset of the data within the datagram.
- **Identification**  This is a serial number, generated by the sending NIC, that helps the participants uniquely identify the datagram.  In a sense, it works like the little "take-a-number" tickets you get at the hamburger stand: Eventually, the number will repeat, but the repeat cycle is so long that there's no chance of confusing packets.  The sequential nature of this field, when used in concert with the Flags and Fragmentation Offset field, helps the protocol stack correctly reassemble the message.
- **Flags**  This field is basically used to indicate that a packet is a fragment of a longer message.
- **Fragmentation Offset**  Used with the Identification sequence number, this field allows the system to know which packets precede or follow this one when re-assembling the message.
- **Time to Live (TTL)**  This indicates the number of routers that a datagram can pass through before it's discarded.  Since routers function by replacing their own destination address with the IP address of the next hop, this essentially limits the number of times a packet's destination IP can be changed.  Most RFC documents suggest keeping this number at 64, it's more often set to something like 255 without any real bottlenecks.
- **Protocol** This field indicates the higher level protocol (the protocol stack) that generated this message.  Examples are given for TCP and UDP in the figure.
- **Header Checksum** This calculates a checksum for the header only.  It's only used in IPv4.  Doing integrity-checking on the data is the responsibility of Layer 4.
- **Source Address** This is the IP address of the sender of the packet, for this hop only.  As shown in the figure below, routers will change this address so they can get the answer back.
- **Destination Address**  This is the IP address of the destination, for this hop only.  As shown below, routers change this address to act as brokers in the IP chain.

<a href="#heading--about-routing"><h5 id="heading--about-routing">About routing</h4></a>

We now have enough concepts in play to talk about routing.  Routing takes place at the network layer, by changing the source and destination addresses (without losing track of the replaced address).  The process looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/73c49cb76573e42036c59832f5f16b6383fbc0bd.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/73c49cb76573e42036c59832f5f16b6383fbc0bd.jpeg"></a>

The router typically assigns a unique port number to the outbound message, and records the source IP against that port number.  When the message comes back to it on that port number, it can look up the IP address of the NIC that sent the packet and route the answer back.

<a href="#heading--about-the-transport-layer"><h4 id="heading--about-the-transport-layer">About the transport layer</h4></a>

Layer 4 brings us to protocols implemented only by the end hosts (i.e., not by the routers or other switching gear that connect the network).  This layer handles things like redundancy, confirmed delivery, managing packets on an unreliable network, and so forth.  This is the last layer that TCP/IP has anything to say about; layers above this are unique to specific applications.  Troubleshooting this level would involve knowing about entire protocol sets, like UDP or TCP.

<a href="#heading--about-the-session-layer"><h4 id="heading--about-the-session-layer">About the session layer</h4></a>

Layer 5, the session layer, is where ongoing interactions between applications happen. The data is couched in terms of things an application might understand (e.g., cookies for a Web browser).    This is also the layer where check-pointing (i.e., saving work finished so far) happens.  At this layer, we'd discuss things like RPC, SQL, or NetBIOS.

<a href="#heading--about-the-presentation-layer"><h4 id="heading--about-the-presentation-layer">About the presentation layer</h4></a>

The presentation layer converts data between formats and ensures standard encodings are used to present the information to the application. This layer is all about file formats: ASCII, EBCDIC, JPEG, GIF, and HTML, to name just a few.

<a href="#heading--about-the-application-layer"><h4 id="heading--about-the-application-layer">About the application layer</h4></a>

The top layer, layer 7, is totally the province of the application(s) involved in processing messages.  Two techs talking about this layer would be swapping stories about application protocols, like FTP, DNS, SMTP, or NFS.  Almost nothing that happens at this layer -- except for throughput estimates or fouled daemon code -- filters into designing or debugging MAAS networks.


<a href="#heading--about-bond-interfaces"><h3 id="heading--about-bond-interfaces">About bond interfaces</h3></a>

A bond interface is used to aggregate two or more physical interfaces into a single logical interface. Combining multiple network connections in parallel can increase network throughput beyond what a single NIC will allow.  It also provides some redundancy in case one of the NICs should fail.

Bonded interfaces use a special frame format called LACPDU, or "Link Aggregation Control Protocol Data Unit.  More information about these special frames, and about the theory behind bonded NICs, can be found in the [relevant IEEE standard](https://1.ieee802.org/tsn/802-1ax-rev/).

<a href="#heading--about-bridge-interfaces"><h3 id="heading--about-bridge-interfaces">About bridge interfaces</h3></a>

Let's take a short diversion to talk about bridge interfaces.  These will be important when we discuss ARP a little further down.

A network bridge may be useful if you intend to use virtual machines or containers with MAAS.  Bridges are, to some extent, artefacts of the AAC network.  Frequently, people ask about the difference between a switch and a bridge.  The core answer lies in the number of ports: switches have as many ports as you can afford; bridges usually have fewer ports, often only two.

Switches traditionally forward packets, without storing them, to a specific host on a specific port, building up a table of host vs. port in the process to reduce broadcast transmissions. Switches traditionally use ASICs (Application Specific Integrated Circuits), otherwise known as "merchant silicon", designed especially for that purpose.

Bridges, on the other hand, provide store and forward packets between two LANs, generally using software.  They might still integrate merchant silicon, or even start as an ODM (original design manufacturer) box with no NOS (network operating system), similar to the way some mid-range switches are built.  Software added on top, plus the low port count and the store-and-forward approach.

Bridges can use MAC addresses (L2) to direct packets, can essentially emulate L3 routing (recording IP addresses of bridged messages for correct return trips), or some combination of both.  Switches usually just route packets between ports.

You can create a network bridge with MAAS; via netplan; or by any other established method to create a network bridge.  For example, when you're using LXD, you typically create a virtual bridge, called `lxdbr0` by default, that bridges between the MAAS host and the LXD instance.  On the host side, the LXD bridge looks like this:

``` nohighlight
7: lxdbr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:16:3e:e4:2b:fe brd ff:ff:ff:ff:ff:ff
    inet 10.90.194.1/24 scope global lxdbr0
       valid_lft forever preferred_lft forever
    inet6 fd42:1fc6:f588:d0b8::1/64 scope global 
       valid_lft forever preferred_lft forever
    inet6 fe80::216:3eff:fee4:2bfe/64 scope link 
       valid_lft forever preferred_lft forever
```

On the MAAS side, the virtual bridge looks like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fbdef2010657939f5f25ee2f157ba5a92af72090.png" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fbdef2010657939f5f25ee2f157ba5a92af72090.png"></a>

Where the 10.190.94.0/24 network is usually part of a VLAN offering MAAS-provided DHCP:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1067a379ba9411713ed1a67e78e249535771b08c.png" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1067a379ba9411713ed1a67e78e249535771b08c.png"></a>

There are other DHCP configurations possible with MAAS (we'll cover this later).  The important point here is not to get overly hung up on the terms "switch", "bridge", and "router".  Instead, figure out whether you want to forward messages based on port numbers, MAC addresses, or IP addresses -- or some combination -- and then find real or virtual devices that will do this for you.

<a href="#heading--about-arp"><h3 id="heading--about-arp">About ARP</h3></a>
 
In theory, every NIC card in the world has a unique identifier, called a /MAC address/.  "MAC" stands for "Media Access Control" -- you can find a [little history of this](https://en.wikipedia.org/wiki/Medium_access_control]) on Wikipedia, if you're interested.

This subsection will help you learn:

- [About TCP/IP vs. MAC addresses](#heading--tcp-ip-does-not-use-mac-addresses)
- [About fixed versus assigned addressing](#heading--fixed-versus-assigned-addressing)
- [About address resolution](#heading--address-resolution)
- [That messages are sent to MAC addresses](#heading--messages-sent-to-mac-addresses)
- [About the ARP frame](#heading--about-the-arp-frame)
- [About the ARP cache](#heading--about-the-arp-cache)
- [More about ARP](#heading--more-about-arp)

When you're assigning MAC addresses with virtual machines, of course, you may be re-using one that's actually assigned to a network device out there somewhere.  Inside your Layer 2 network, that isn't a problem, because only devices connected to a physical switch -- that's actually connected to the physical Internet -- care about unique MAC addresses.  Inside your network, the only conflicts you need to worry about are the ones you create by hand-assigning MAC addresses.

The shorter answer to that implied question is this: MAC addresses must be unique across the domain where they're used.  

<a href="#heading--tcp-ip-does-not-use-mac-addresses"><h4 id="heading--tcp-ip-does-not-use-mac-addresses">TCP/IP does not use MAC addresses</h4></a>

If we look at the IP datagram again, we see that it doesn't know about MAC addresses at all:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fc349972f6b7509b5b2459bf3bb44419961f0bcd.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fc349972f6b7509b5b2459bf3bb44419961f0bcd.jpeg"></a>

TCP, UDP, and a number of other protocol stacks are written to use IP addresses.  Routers depend on IP addresses, as we've already seen. This creates a bit of a conundrum: How do we map between MAC and IP addresses, and what does the mapping?  Is it a layer 2 or layer 3 operation?

The first thing to remember is that the MAC address is "ROM-burned" into the NIC card.  IP addresses, on the other hand, are assigned to a NIC by a DHCP server or an administrator.  This intentional separation of addressing schemes is what makes the Internet flexible.

<a href="#heading--fixed-versus-assigned-addressing"><h4 id="heading--fixed-versus-assigned-addressing">Fixed versus assigned addressing</h4></a>

Here's an analogy.  Your postal address doesn't /actually/ define where your house is located.  There are two layers of other addressing schemes that are actually used by government organisations, like your county tax assessor or the local air ambulance company.

One is your land survey location.  Depending on where you live, this is defined by a series of coordinates that go something like this: county, township, section, plat, lot, etc.  If you've ever looked at your property tax bill, it will have your postal address on it, but it will not actually use your postal address to define the taxable property.  Instead, it uses this unique set of (rather obscure) coordinates to place you exactly on land survey maps.

But that's not good enough for the air ambulance, for two reasons.  First, the survey maps are huge, complex, and hard to interpret, and they change somewhat as property is bought or sold.  Second, helicopter navigation is intentionally independent of political boundaries.  Instead, the air ambulance will use your latitude and longitude, which allows them to uniquely locate you on the earth.  Granted, the ambulance company has a tool somewhere that automatically does the maths of translating your postal address to lat/long coordinates, but the principle holds.

In terms of your local network, each of these "address levels" applies.  Your postal address corresponds to the IP address of a machine.  That IP address may or may not be unique, depending on the domain.  For example, you can use Google Maps to try and locate something like "20 Main Street", and you'll get a really long list of responses that vary by city.

Likewise, there are probably hundreds of thousands of local networks using addresses in the "192.168...." subnet, since it's so common for local IP addressing.  As mentioned above, routers at the network layer take care of protecting these unique local addresses when going out on the Internet. On the other hand, your NIC's MAC address is like the GPS lat/long coordinates; it's unique across the entire world.

What about the analogue of survey maps?  Well, it's not hard to argue that these are more like the MAC addresses that you assign to your VMs.  Every county in a state like, say, Mississippi has the coordinates Township 1, Section 1, Parcel 1 -- but the outer domain (the county) makes those coordinates unique.  Granted, we don't use a different format for MAC addresses for VMs than we do for Internet-connected NICs, but you get the idea.

<a href="#heading--address-resolution"><h4 id="heading--address-resolution">Address resolution</h4></a>

Address resolution is what we call the process of mapping between IP addresses and MAC addresses.  It's done with something called ARP, which stands for "Address Resolution Protocol".  Oddly enough, ARP takes on a life of its own, so you may hear it discussed in unusual ways.  Some people call it "the ARP", others speak of "arpd" (the ARP daemon), although if you look at [the man page for arpd](https://linux.die.net/man/8/arpd), you'll see those characterisations are not precisely correct.

A frequent question is, "Where does ARP take place?"  Maybe the better question is, "Where is ARP implemented?"  As always with Internet-related things, the answer can vary, but normally, ARP is implemented as part of the embedded code in the NIC.  Technically, this means that ARP operates at Layer 2.  More often, you'll see vendors hedge their bets on this, with phrases such as "operates below the Network Layer", as in [this explanation](https://support.hpe.com/hpesc/public/docDisplay?docId=emr_na-c00686597#:~:text=ARP%20is%20a%20protocol%20used,network%20and%20OSI%20link%20layer).

In reality, in order to work correctly, ARP has to map IP and MAC addresses, since the ARP message looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/18a95f7ed64b83ec1302c92e41696d137783e7bc.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/18a95f7ed64b83ec1302c92e41696d137783e7bc.jpeg"></a>

To better understand, let's walk an ARP call.  It begins in say, a Web browser, when the browser makes a call to parse the URL.  In most cases, that URL contains a hostname (not an IP address), so the following sort of dance takes place:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1365006a1692e4788df733c58e1435e67da57536.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1365006a1692e4788df733c58e1435e67da57536.jpeg"></a>

We won't go into this in much detail now, just know that the browser is able to gather an IP address, if it exists.  To make the walk-through less confusing, let's assume that we're looking for a host with IP 192.168.17.4.

Next, the browser requests a connection with 192.168.17.4, using the TCP protocol, which sends a connection request, as an IP packet, to 192.168.17.4.  Along the way, there is probably more than one router hop.  

ARP sends a broadcast request to everything on the relevant subnet.  This request looks like the ARP message above, but it's encoded as a MAC frame, which helps to answer the often-fuzzy question, "Is ARP Layer 2 or Layer 3?"  As you see, this is an L2 message.  Incidentally, ARP only works as a broadcast, by the way; that is, it only works on a broadcast network.

A very important note for some systems like MAAS: ARP requests don't typically span VLANs.  

Essentially, this ARP message contains the IP address 192.168.17.4, but no corresponding MAC address in the message.  This tells the owner of 192.168.17.4 that it should reply with a similar ARP message, including its MAC address.  When the sender receives the ARP reply, it can send the datagram directly to the destination host, embedded in an Ethernet frame, using the MAC address.

By the way, for efficiency, the sending host and the intermediate routers are all doing ARP caching.  They copy down the mapping between IP and MAC addresses, holding onto it for about twenty minutes.  In terms of most network transactions, twenty minutes is an eternity.

<a href="#heading--messages-sent-to-mac-addresses"><h5 id="heading--messages-sent-to-mac-addresses">Messages are sent to MAC addresses</h5></a>

We often speak of TCP/IP as if messages are sent from one IP address to another, but that's actually not strictly true.  Messages are sent to MAC addresses.  IP addresses are only used to get MAC addresses, so the message can go through.

We can return to the air ambulance company to see a practical analogy.  A 911 call comes in for "20 Main Street, Yourtown, Yourstate, Yourpostalcode".  The address is sent to the pilot of the helicopter, who punches the address into his GPS.  The GPS uses the postal address to retrieve the lat/long coordinates, which are then used to guide the helicopter, via satellite navigation.

The same sort of thing happens when you use the GPS navigator in your car.  The navigator is translating a logical (postal) address to a physical (lat/long) address on the surface of the earth, calculating a route, and translating that route back to logical landmarks (street names) to let you know how to get there.

By the way, You should also note that ARP only works with IPv4.  Certain other protocols, like Point-to-Point Protocol (PPP), don't make use of ARP at all.

<a href="#heading--about-the-arp-frame"><h5 id="heading--about-the-arp-frame">About the ARP frame</h5></a>

ARP sends requests as an Ethernet frame, using the MAC address.  If you remember the MAC frame from earlier:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/14f6847ed92339061eb4515c12ac2b6117d5cd7c.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/14f6847ed92339061eb4515c12ac2b6117d5cd7c.jpeg"></a>

The ARP frame is just a special case of the MAC frame, replacing everything the DSAP, SSAP, control bits, and data with the ARP message shown above.  The resulting ARP frame looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f430da9c144bda4cf2e2901181988f3444d335f8.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f430da9c144bda4cf2e2901181988f3444d335f8.jpeg"></a>

Based on the above diagram, you can see how the ARP request fits into the Ethernet frame to make an ARP frame.

<a href="#heading--about-the-arp-cache"><h5 id="heading--about-the-arp-cache">About the ARP cache</h5></a>

Let's take a look at the ARP cache on a local system, ~cloudburst~. We can do that like this:

``` nohighlight
stormrider@cloudburst:~$ arp
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.1.24             ether   0c:8b:7d:f1:51:d3   C                     wlo1
10.250.204.17                    (incomplete)                              mpqemubr0
192.168.1.24             ether   0c:8b:7d:f1:51:d3   C                     enx606d3c645a57
192.168.117.16                   (incomplete)                              virbr0
```

The columns are mostly obvious, but just in case:

- **Address**: the IP address that's been cached.
- **HWtype**: the Hardware Type field, which is blank when there's no MAC address (as is the case in a number of these entries).
- **HWaddress**: the MAC address of the device.  The "incomplete" entries are meant to indicate that an ARP request was sent for that address, but no response was received.
- **Flags Mask**: this field can have three values: "C" indicates that ARP learned this on its own, based on ARP responses; "M" means that the data was manually entered in the ARP table by a user; and "P" means "Publish," which just tells the host how to respond to incoming ARP packets.
- **Iface**: the interface name.

In this case, ~virbr0~ and ~mpqemubr0~ are virtual bridges used for different sets of libvirsh VMs that haven't been used for anything in a while. Also note that something called ~lxdbr0~, which is an LXD bridge, doesn't even show up.

Let's see if we can influence that.  First, let's take a look using ~ip a~:

``` nohighlight
stormrider@cloudburst:~$ ip a show up
5: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 52:54:00:d6:70:6c brd ff:ff:ff:ff:ff:ff
    inet 192.168.117.1/24 brd 192.168.117.255 scope global virbr0
       valid_lft forever preferred_lft forever
6: mpqemubr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 52:54:00:84:0a:4c brd ff:ff:ff:ff:ff:ff
    inet 10.250.204.1/24 brd 10.250.204.255 scope global mpqemubr0
       valid_lft forever preferred_lft forever
7: lxdbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 00:16:3e:e4:2b:fe brd ff:ff:ff:ff:ff:ff
    inet 10.90.195.1/24 scope global lxdbr0
       valid_lft forever preferred_lft forever
    inet6 fd42:1fc6:f588:d0b8::1/64 scope global 
       valid_lft forever preferred_lft forever
```

You'll see that all three bridges are in a DOWN state, and again, ~lxdbr0~ is so cold that it doesn't even show up in the ARP table.  Let's bring up a LXD VM connected to ~lxdbr0~ and look at the ARP table again:

``` nohighlight
stormrider@cloudburst:~$ arp
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.1.24             ether   0c:8b:7d:f1:51:d3   C                     wlo1
10.250.204.17                    (incomplete)                              mpqemubr0
192.168.1.24             ether   0c:8b:7d:f1:51:d3   C                     enx606d3c645a57
192.168.117.16                   (incomplete)                              virbr0
10.90.195.16             ether   00:16:3e:fc:71:98   C                     lxdbr0
```

Note that the ~lxdbr0~ bridge now shows up and has a MAC address, too -- no incomplete entry here.  If we look at the MAC address of ~lxdbr0~ in the ~ip~ listing, we'll see it matches up.

Those "(incomplete)" entries are old.  They've been cached, but no traffic has passed through those bridges in a really long time.  The cache is just persistent in holding onto the IP addresses, but not the MAC addresses (since they could be stale).  We can prove this to ourselves by clearing the cache:

``` nohighlight
stormrider@cloudburst:~$ sudo ip -s neigh flush all
[sudo] password for stormrider: 

*Round 1, deleting 18 entries ***
*Flush is complete after 1 round ***
```

...and rebuilding the ARP table:

``` nohighlight
stormrider@cloudburst:~$ arp
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.1.24             ether   0c:8b:7d:f1:51:d3   C                     wlo1
192.168.1.24             ether   0c:8b:7d:f1:51:d3   C                     enx606d3c645a57
10.90.195.16             ether   00:16:3e:fc:71:98   C                     lxdbr0
```

<a href="#heading--more-about-arp"><h5 id="heading--more-about-arp">More about ARP</h5></a>

Another form of ARP is promiscuous ARP, in which some proxy host pretends to be the destination host and provides an ARP response on behalf of the actual destination host.  You shouldn't use this form of ARP unless there's no other choice.  You can Google it (and use it at your own risk), but it won't be described here.

There is also gratuitous ARP, when the source and destination IP addresses are the same.  This can be used for at least two purposes:

1. To find out if someone else already has the source machine's IPv4 address, a technique called Address Conflict Detection by some references.

2. To update the source machine's new MAC address (e.g., a new NIC card was installed) in upstream ARP cache entries.  This is something akin to pre-caching MAC addresses before they're actually needed.

You can [read more about](https://en.wikipedia.org/wiki/Address_Resolution_Protocol) these (and many more) nuances of ARP, but this introduction should answer most of the immediate questions. 

<a href="#heading--about-tcp"><h3 id="heading--about-tcp">About TCP</h3></a>

If the Internet Protocol (IP) is connectionless, the transport layer is all about connections.  The transport-layer protocol in use -- we'll talk exclusively about Transmission Control Protocol or TCP here -- the L4 protocol is the last place in the stack where the entire message exists in one piece.  L4 breaks up larger messages into segments.  Each segment gets a TCP header, and gets passed on to L3 where it becomes an IP packet.

<a href="#heading--about-the-tcp-header"><h4 id="heading--about-the-tcp-header">About the TCP header</h4></a>

Here's a diagram of the L4-to-L3 hand-off:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8f2aba29b1299bba2630177c0301dd518cacb57.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8f2aba29b1299bba2630177c0301dd518cacb57.jpeg"></a>

We can get a pretty good idea what happens at Layer 4 just by decoding the contents of the TCP header. It contains the following fields:

- **Source port**: the application port number of the host sending the data.  For example, if this is an FTP message, the source port would probably be 21.

- **Destination port**: the port number of the application requested on the destination host.  If this is FTP, again this port would likely be 21.

- **Sequence number**: the sequence number of this segment of data, to help the other end put the data back together in the correct order, as well as help Level 4 on the receiving end know whether a packet's been dropped or lost.

- **Acknowledgement number**: essentially, the next sequence number the destination host is expecting; used to "gate" packets through the connection.

- **TCP header length**: given to know where the data begins.

- **Reserved**: reserved for future use, basically; currently always set to 0.

- **Code bits**: essentially a set of flags; see the list below.

- **Window**: used to negotiate the "window" size, that is, how many bytes the destination host is willing to receive at once; this allows for the most efficient transmission possible, based on the characteristics of the two communicating hosts.

- **Checksum (CRC)**: used to check the integrity of the segment.

- **Urgent pointer**: data byte count where urgent data ends; used if the urgent flag is set (see below).


The code bits can indicate the following things:

- **URG**: indicates that the urgent pointer field is meaningful, used to prioritise this message over other messages.

- **ACK**: used to acknowledge successful delivery of the previous segment.

- **PSH**: push notification; tells the receiving host the message is complete, you can push the data to the application.

- **RST**: request a connection reset when the error level reaches a certain threshold; basically, "let's try that again from the top."  This is considered an abnormal termination of the TCP connection.

- **SYN**: used for a three-way TCP handshake; this handshake is how sender and receiver sync up; it serves a purpose similar to the preamble in a MAC frame, but at a different level of synchronisation.

- **FIN**: we're done, close the connection.  This is considered a normal termination of a TCP connection.

- **NS/CWR/ECE**: used to provide Explicit Congestion Notification; note that OSI provides several methods for endpoints to know that the network is congested.

<a href="#heading--tcp-is-like-a-phone-call"><h4 id="heading--tcp-is-like-a-phone-call">TCP is like a phone call</h4></a>

As you can see from the bytes above, TCP is all about the state of a connection, which is basically the same as a phone call.  When you pick up the receiver, you and the caller exchange information.  You say "bye" when the call is over.  If it's a bad connection or one end suddenly gets noisy (think jack-hammers outside), one of you can reset the connection by saying, "Let me call you back in a minute."  Take a minute and try to see how the other header bytes fit this analogy.

Also like a telephone call, TCP provides a connection (the call, however long it lasts), flow control (provided by the two parties on the call), multiplexing (handled by the two handsets, basically letting through multiple frequencies and sounds, so that you can get the tone and breath sounds of the other person, not just their raw words).  Likewise, the two parties try to handle the reliability of the connection by making sure you understand each other.

The analogy spreads a little because some of the items (connection, multiplexing) are handled by the telephone, and some are handled by the people operating the telephone (flow control, reliability).  In the network, the Level 4 protocol stack handles it all.

There is a lot more to know about TCP, but most of it isn't directly relevant for MAAS networking.  Instead, we direct you to the excellent [Wikipedia article about TCP](https://en.wikipedia.org/wiki/Transmission_Control_Protocol).  Going forward, we'll only bring up specific transport layer elements as we need them.

<a href="#heading--about-dns"><h3 id="heading--about-dns">About DNS</h3></a>

Because IP addresses are hard for humans to remember, the Internet supports the use of host names to identify hosts.  These host names are associated with the host's actual IP address in a server known as a Domain Name server.  The overall protocol is known as the [Domain Name System](https://en.wikipedia.org/wiki/Domain_Name_System).  

<a href="#heading--other-network-elements"><h3 id="heading--other-network-elements">About other network elements</h3></a>

This section summarises a number of other networking elements that may occasionally come up when working with MAAS networks.  These include:

- [Client](#heading--client)
- [Hub](#heading--hub)
- [LAN](#heading--lan)
- [MAC address](#heading--mac-address)
- [MAN](#heading--MAN)
- [Network cable](#heading--network-cable)
- [Patch panel](#heading--patch-panel)
- [Repeater](#heading--repeater)
- [Router](#heading--router)
- [Server](#heading--server)
- [Switch](#heading--switch)
- [Network topology](#heading--network-topology)
- [WAN](#heading--WAN)

<a href="#heading--client"><h4 id="heading--client">Client</h4></a>

In the client/server age, the lines between client and server are blurred and sometimes reversible.  For the purposes of MAAS and general networking principles, we can define a [client](https://en.wikipedia.org/wiki/Client_%28computing%29#firstHeading) as a node that uses shared resources via a network.  If that same client provides shared resources to other nodes, it could also be considered a server.  

<a href="#heading--server"><h4 id="heading--server">Server</h4></a>

A [server](https://en.wikipedia.org/wiki/Server_%28computing%29#Classes_of_computers) is a node that provides shared resources to clients via a network.  If that same server uses shared resources from other nodes, it could also be considered a client, but only in that context.

<a href="#heading--hub"><h4 id="heading--hub">Hub</h4></a>

[Hubs](https://en.wikipedia.org/wiki/Ethernet_hub#firstHeading) essentially started as repeaters.  While they may be able to connect more than two computers together (i.e., multiple RJ45 ports), they provide no improvement over simple bus networks, since every connected NIC must examine every packet.  They are rarely used anymore.

<a href="#heading--mac-address"><h4 id="heading--mac-address">MAC address</h4></a>

A [MAC address](https://en.wikipedia.org/wiki/MAC_address#firstHeading) or "media access control" address is a unique address or "physical address" associated with a network interface.  They are 48 bits in length, which allows for 280 trillion devices, arranged into six hexadecimal octets, separated by colons or dashes.  Every computer in the world theoretically has a unique MAC address.  You can identify a node's IP address with the command `ipconfig /all`.

<a href="#heading--network-cable"><h4 id="heading--network-cable">Network cable</h4></a>

[Network cables](https://en.wikipedia.org/wiki/Category_5_cable#firstHeading) are special cables that connect non-wireless-based nodes.  They consist of our pairs of insulated, 24-gauge wire, colour-coded (solid/striped), usually in four colours: blue, green, orange, and brown.  The matching colour pairs are twisted together, each pair at a different turn rate to prevent electromagnetic interference between pairs.
These twists must be maintained all the way up to the (RJ45) connector.

Even with insulation, careful twisting, and connector-termination, natural losses in the cable cause the network signals to become too weak to maintain reliable data rates after a certain length.  In the case of Cat 5e cable, the maximum cable length is 100 meters to maintain 1Gb per second.  For Cat 6, the max length to maintain 10Gb per second is 55 meters.  These limits are overcome with [repeaters](#heading--repeater), which amplify the signal and relay it to the next repeater or NIC.

<a href="#heading--repeater"><h4 id="heading--repeater">Repeater</h4></a>

Technically, a [repeater](https://en.wikipedia.org/wiki/Repeater#firstHeading) is a network signal amplifier with two RJ45 connectors which adds one maximum length (for the cable type) to the network connection or "run."  In practice, repeaters usually come in the form of [hubs](#heading--hub) or [switches](#heading--switch), which can usually perform other functions as well.

<a href="#heading--switch"><h4 id="heading--switch">Switch</h4></a>

A [switch](https://en.wikipedia.org/wiki/Network_switch#firstHeading) is a "smart" device that connects cables from nodes to make networks.  Like a hub, a switch amplifies signals, that is, it acts as a repeater.  Switches learn by induction which cables receive which IP addresses.  Over time a switch will direct each packet only to devices which indicate that they will accept the addresses associated with those packets.

<a href="#heading--network-topology"><h4 id="heading--network-topology">Network topology</h4></a>

[Topology](https://en.wikipedia.org/wiki/Network_topology#mw-content-text) describes how nodes are connected to a network, specifically referring to the shapes made by the cables and the paths that packets can take.  There are probably as many topologies are there are shapes, but here are some of the most common:

- Bus topology: the most basic network topology, a group of computers connected to a single, long cable.  In this configuration, every computer sees every packet.  A [hub](#heading--hub) network, for instance, is still a bus topology, because every machine sees every packet.

- Star or switch topology: a group of computers connected to a [switch](#heading--switch).  As the switch learns where packets are supposed to go, the star quickly evolves so that only packets are only seen by computers that are intended to receive the packet.

- Backbone topology: a hybrid network configuration in which several stars are connected to a bus.

- Daisy-chain topology: stars connected to stars, or more accurately, switches connected to switches.

- Mesh topology: nodes with multiple interfaces and multiple connections.  Useful where wide-area networks ([WAN](#heading--wan)) where there would otherwise be lots of intermediaries.  Not popular or particularly cost effective for [LAN](#heading--lan) networks.

<a href="#heading--patch-panel"><h4 id="heading--patch-panel">Patch panel</h4></a>

A [patch panel](https://en.wikipedia.org/wiki/Patch_panel#firstHeading) is simply a 24- to 48-port panel of connectors that can link together three- to ten-foot cables.  A patch panel allows jumpers from network runs to devices in racks, without putting strain and "cable creep" on long runs.

<a href="#heading--lan"><h4 id="heading--lan">LAN</h4></a>

Besides topology, networks can also be classified by their size, range, or "reach."  One such classification is the [Local Area Network (LAN)](https://en.wikipedia.org/wiki/Local_area_network#firstHeading), which connects computers in close proximity (about 300 feet).

<a href="#heading--WAN"><h4 id="heading--WAN">WAN</h4></a>

A [WAN (wide area network)](https://en.wikipedia.org/wiki/Wide_area_network#firstHeading) is a network which connects LANs across large geographic distances, e.g., thousands of miles.

<a href="#heading--MAN"><h4 id="heading--MAN">MAN</h4></a>

A [metro area network or MAN](https://en.wikipedia.org/wiki/Metropolitan_area_network#firstHeading) connects LANs over a smaller area, like a city or urban footprint.  Basically, if it isn't really a WAN, but you can't connect it with cables, it's usually considered a MAN.

<a href="#heading--router"><h4 id="heading--router">Router</h4></a>

A [router](https://en.wikipedia.org/wiki/Router_%28computing%29#firstHeading) is a device that transfers packets from one network to another.  Unlike switches, which only ensure that pre-addressed packets get to the correct recipient machines, routers actually modify or encapsulate packets to ensure that they can travel on other networks to reach a remote destination.  Choices about routing are so important that we'll spend a [great deal of time on the subject](#heading--routing-still-rules) when we learn about cloud networking.

<a href="#heading--About-cloud-networks"><h2 id="heading--About-cloud-networks">About cloud networks</h2></a>

Cloud network architectures deviate significantly from the architecture of the Internet infrastructure.  These deviations are driven mostly by economics, simplicity, and scalability.  This article will help you learn:

- [About old and new network architectures](#heading--clos-architecture)
- [Problems with the AAG architecture](#heading--aag-problems)
- [Disaggregating the cloud](#heading--disaggregating-the-cloud)
- [Routing still rules](#heading--routing-still-rules)

<a href="#heading--clos-architecture"><h3 id="heading--clos-architecture">About old and new network architectures</h3></a>

Before there were networks, monolithic applications ran on a mainframe with hardwired I/O devices.  As CPUs proliferated in separate enclosures, LANs like [Banyan Vines](https://en.wikipedia.org/wiki/Banyan_VINES) grew up.  Proprietary mismatch led to the [OSI model](https://maas.io/docs/about-tcp-ip-networks#heading--about-the-osi-model).  Next came the Web, which distributed processing to client devices.  Now, we have the idea of generic switches and servers in cloud and bare-metal clusters.  Servers have shifted from dedicated applications to being completely [virtualised](https://en.wikipedia.org/wiki/Virtualization).

A traditional AAC architecture looks like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg"></a>

It’s heavy on network hardware; that is, the radio of switches to servers is (too) high.  Switch-driven networks used hardware packet switching ([merchant silicon](https://etherealmind.com/analysis-merchant-custom-silicon)) to serve proprietary network configurations.  In theory, bridges needed no configuration, although [congestion](https://en.wikipedia.org/wiki/Network_congestion) and [mistaken identity](https://en.wikipedia.org/wiki/IP_address#Addressing_conflicts) led to the need for [STP](https://en.wikipedia.org/wiki/Spanning_Tree_Protocol), [per-VLAN trees](https://networklessons.com/spanning-tree/per-vlan-spanning-tree-pvst), and IP address redundancy management techniques.

A cloud architecture simplifies these networks:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fd86954e48538ce9ba8fc6e02df23b0a2337ef12.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fd86954e48538ce9ba8fc6e02df23b0a2337ef12.jpeg"></a>

Cloud architecture is a simple [spine-and-leaf network](https://networklessons.com/cisco/ccna-200-301/spine-and-leaf-architecture), built from cheap, identical switches connecting cheap, identical servers.  Every switch has a path to every other switch, mitigating congestion.  Any switch can route any traffic anywhere, and any server can do any job (at any time).  This architecture moves the developer’s focus from metal to actual computing problems.

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

For example, all IPv6 communications are multicast, so there's no ARP.  Instead, a process called [neighbour discovery](https://en.wikipedia.org/wiki/Neighbor_Discovery_Protocol) (NDP) is used.  But IPv4 networks can also handle multicast transactions.  Both IPv4 and IPv6 protocols support [multicast address blocks](https://en.wikipedia.org/wiki/Multicast_address), which enable multicasting.

A multicasting server sends one packet, and the network handles replication and addressing (multiplexing) of the packets to the subscribed servers.  Multicast is a one-way protocol: any responses have to be sent by other protocols.  For larger server farms, multicast is a good way to handle things like a software update or a database refresh.  Two special protocols handle subscriptions: [IGMP](https://en.wikipedia.org/wiki/Internet_Group_Management_Protocol), used by individual IPv4 receivers, and [PIM](https://en.wikipedia.org/wiki/Protocol_Independent_Multicast), which is used by L3 devices (like routers) to manage multicast "trees" across a network or subnet.