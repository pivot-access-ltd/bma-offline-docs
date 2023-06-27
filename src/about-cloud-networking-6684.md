<!-- "Cloud networking" -->

Cloud network architectures deviate significantly from the architecture of the Internet infrastructure.  These deviations are driven mostly by economics, simplicity, and scalability.  This article will help you learn:

- [About old and new network architectures](#heading--clos-architecture)
- [Problems with the AAG architecture](#heading--aag-problems)
- [Disaggregating the cloud](#heading--disaggregating-the-cloud)
- [Routing still rules](#heading--routing-still-rules)

<a href="#heading--clos-architecture"><h2 id="heading--clos-architecture">About old and new network architectures</h2></a>

Before there were networks, monolithic applications ran on a mainframe with hardwired I/O devices.  As CPUs proliferated in separate enclosures, LANs like [Banyan Vines](https://en.wikipedia.org/wiki/Banyan_VINES)`↗` grew up.  Proprietary mismatch led to the [OSI model](https://maas.io/docs/about-tcp-ip-network#heading--about-the-osi-model)`↗`.  Next came the Web, which distributed processing to client devices.  Now, we have the idea of generic switches and servers in cloud and bare-metal clusters.  Servers have shifted from dedicated applications to being completely [virtualised](https://en.wikipedia.org/wiki/Virtualization)`↗`.

A traditional AAC architecture looks like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg"></a>

It’s heavy on network hardware; that is, the radio of switches to servers is (too) high.  Switch-driven networks used hardware packet switching ([merchant silicon](https://etherealmind.com/analysis-merchant-custom-silicon)`↗`) to serve proprietary network configurations.  In theory, bridges needed no configuration, although [congestion](https://en.wikipedia.org/wiki/Network_congestion)`↗` and [mistaken identity](https://en.wikipedia.org/wiki/IP_address#Addressing_conflicts)`↗` led to the need for [STP](https://en.wikipedia.org/wiki/Spanning_Tree_Protocol)`↗`, [per-VLAN trees](https://networklessons.com/spanning-tree/per-vlan-spanning-tree-pvst)`↗`, and IP address redundancy management techniques.

A cloud architecture simplifies these networks:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fd86954e48538ce9ba8fc6e02df23b0a2337ef12.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fd86954e48538ce9ba8fc6e02df23b0a2337ef12.jpeg"></a>

Cloud architecture is a simple [spine-and-leaf network](https://networklessons.com/cisco/ccna-200-301/spine-and-leaf-architecture)`↗`, built from cheap, identical switches connecting cheap, identical servers.  Every switch has a path to every other switch, mitigating congestion.  Any switch can route any traffic anywhere, and any server can do any job (at any time)`↗`.  This architecture moves the developer’s focus from metal to actual computing problems.

<a href="#heading--aag-problems"><h2 id="heading--aag-problems">Problems with the AAG architecture</h2></a>

Modern applications generate much more server-to-server traffic than the original Access-Aggregation-Core networks envisioned.  As a result, the AAG architecture presents several problems under load:

- **VLAN shorting**: At cloud scale, 12 bits of VLAN ID don't provide nearly enough VLAN instances.  Even with Multi-instance/STP, there simply aren't enough virtual LAN networks to accommodate the build-out of even a modest cloud configuration.  Tenant machines come and go rapidly, and STP hello messages simply can't keep up.
- **STP switch-count**: STP is only designed for two aggregation switches, which throttles bandwidth and causes massive, constant congestion in an extended cloud network.
- **Million-plus-packet floods**: Broadcast-and-learn bridges can't keep up with a million-plus MAC addresses, and even if they do, when those cached addresses start to time out, the periodic re-learning floods edge hosts, incapacitating them on a regular basis.
- **Unintentional VLAN partitioning**: Large VLANs plus many devices creates a high-probability of a configuration mistake or an ID refresh miss; these issues cause the network to be invisibly partitioned, making troubleshooting all but impossible.
- **ARP storms**: Hundreds of virtual machines bound to a couple of aggregation switches translates to a network-saturating flurry of ARP refreshes.  There's no easy fix for this without changing the network topology, or setting the refresh timer so high that DHCP hosts will fall off the DNS periodically.

There are other issues usually cited, but these are most concrete.

<a href="#heading--disaggregating-the-cloud"><h2 id="heading--disaggregating-the-cloud">Disaggregating the cloud</h2></a>

An effective cloud architecture breaks routers and bridges into separate hardware and software, sometimes called "switch disaggregation".  A merchant-silicon chassis (the hardware) can be combined with someone else's NOS (network operating system, the software) to produce more standard and cost-effective network switch-gear.  In practice, few cloud providers actually create their own NOS, choosing instead to either integrate merchant silicon with a separately purchased NOS, or, more likely, to buy bundled units from switch providers that have broader integration experience.

Either way, the effect is to have switch-gear which is (1) less likely to be proprietary, and (2) easier to upgrade as the hardware advances.  Switch disaggregation effectively commoditizes the switching elements, effectively eliminating them from network throughput calculations.  In other words, the bridges and routers in a modern cloud network are essentially invisible, uninteresting, and inexpensive, which facilitates the cloud-network build-out model.

<a href="#heading--routing-still-rules"><h2 id="heading--routing-still-rules">Routing still rules</h2></a>

Regardless of your network vintage, packet routing is still the fundamental algorithm that gates throughput.  If you're familiar with routing, this section can be skipped. If you're trying to level up your cloud networking knowledge, this section should help quite a bit.

Routing is fundamentally simple: you're trying to get a packet from a source to a destination, using the destination IP address embedded in that packet.  In practice, routing is more complicated.  Most of the routers in a network path are not forwarding directly to the destination.  Instead, they're sending the packet to the next hop, that is, another, reachable router that is closer to the intended destination.

In [the TCP/IP tutorial](/t/tcp-ip/6683#heading--borrowed-from-ma-bell), we talked about telephone-line repeaters that refreshed the signal to keep it crystal clear over long runs of wire.  The signals didn't have to make it to the intended recipient, they just had to make it to the next repeater, which boosted the signal, cleaned up the noise, and sent the call on down the line to another repeater.  Eventually the call would make it to the subscriber.

Routing works very much the same way: most of the routers in the loop understand how to find another router which is close to the intended destination.  That "next hop" will take care of repackaging the packets and sending them further down the line.  What matters in high-traffic cloud networks is not routing, per se, but how the packets are routed.  The choice of routing protocols can make all the difference in whether or not your network lags.  For this reason, we're going to take a more extended look at routing.

<a href="#heading--multicast-routing"><h3 id="heading--multicast-routing">Multicast routing</h3></a>

One helpful tool for modern cloud networks is the concept of multicast routing.  Stated simply, multicast routing allows one packet to be received by many servers, but only if those servers are interested in receiving it.  Multicast receivers -- which have to subscribe in order to receive the packets -- support a much larger (and more flat) network.  This layout more easily scales to the cloud architecture shown above. Multicasting is generally faster and more efficient for certain payloads; unlike broadcast packets, multicast packets are not examined by every NIC in the packet's path.

For example, all IPv6 communications are multicast, so there's no ARP.  Instead, a process called [neighbour discovery](https://en.wikipedia.org/wiki/Neighbor_Discovery_Protocol)`↗` (NDP) is used.  But IPv4 networks can also handle multicast transactions.  Both IPv4 and IPv6 protocols support [multicast address blocks](https://en.wikipedia.org/wiki/Multicast_address)`↗`, which enable multicasting.

A multicasting server sends one packet, and the network handles replication and addressing (multiplexing) of the packets to the subscribed servers.  Multicast is a one-way protocol: any responses have to be sent by other protocols.  For larger server farms, multicast is a good way to handle things like a software update or a database refresh.  Two special protocols handle subscriptions: [IGMP](https://en.wikipedia.org/wiki/Internet_Group_Management_Protocol)`↗`, used by individual IPv4 receivers, and [PIM](https://en.wikipedia.org/wiki/Protocol_Independent_Multicast)`↗`, which is used by L3 devices (like routers) to manage multicast "trees" across a network or subnet.