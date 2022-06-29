<!-- "About cloud networks" -->
Cloud network architectures deviate significantly from the architecture of the Internet infrastructure.  These deviations are driven mostly by economics, simplicity, and scalability.  This section will help you learn:

- [About old and new network architectures](#heading--clos-architecture)

<a href="#heading--clos-architecture"><h2 id="heading--clos-architecture">About old and new network architectures</h2></a>

Before there were networks, monolithic applications ran on a mainframe with hardwired I/O devices.  As CPUs proliferated in separate enclosures, LANs like [Banyan Vines](https://en.wikipedia.org/wiki/Banyan_VINES) grew up.  Proprietary mismatch led to the [OSI model](https://maas.io/docs/about-tcp-ip-networks#heading--about-the-osi-model).  Next came the Web, which distributed processing to client devices.  Now, we have the idea of generic switches and servers in cloud and bare-metal clusters.  Servers have shifted from dedicated applications to being completely [virtualised](https://en.wikipedia.org/wiki/Virtualization).

A traditional AAC architecture looks like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg"></a>

It’s heavy on network hardware; that is, the radio of switches to servers is (too) high.  Switch-driven networks used hardware packet switching ([merchant silicon](https://etherealmind.com/analysis-merchant-custom-silicon)) to serve proprietary network configurations.  In theory, bridges needed no configuration, although [congestion](https://en.wikipedia.org/wiki/Network_congestion) and [mistaken identity](https://en.wikipedia.org/wiki/IP_address#Addressing_conflicts) led to the need for [STP](https://en.wikipedia.org/wiki/Spanning_Tree_Protocol), [per-VLAN trees](https://networklessons.com/spanning-tree/per-vlan-spanning-tree-pvst), and IP address redundancy management techniques.

A cloud architecture simplifies these networks:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fd86954e48538ce9ba8fc6e02df23b0a2337ef12.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fd86954e48538ce9ba8fc6e02df23b0a2337ef12.jpeg"></a>

Cloud architecture is a simple [spine-and-leaf network](https://networklessons.com/cisco/ccna-200-301/spine-and-leaf-architecture), built from cheap, identical switches connecting cheap, identical servers.  Every switch has a path to every other switch, mitigating congestion.  Any switch can route any traffic anywhere, and any server can do any job (at any time).  This architecture moves the developer’s focus from metal to actual computing problems.

<a href="#heading--multicast-routing"><h2 id="heading--multicast-routing">Multicast routing</h2></a>

One helpful tool for modern cloud networks is the concept of multicast routing.  Stated simply, multicast routing allows one packet to be received by many servers, but only if those servers are interested in receiving it.  Multicast receivers -- which have to subscribe in order to receive the packets -- support a much larger (and more flat) network.  This layout more easily scales to the cloud architecture shown above. Multicasting is generally faster and more efficient for certain payloads; unlike broadcast packets, multicast packets are not examined by every NIC in the packet's path.

For example, all IPv6 communications are multicast, so there's no ARP.  Instead, a process called [neighbor discovery](https://en.wikipedia.org/wiki/Neighbor_Discovery_Protocol) (NDP) is used.  But IPv4 networks can also handle multicast transactions.  Both IPv4 and IPv6 protocols support [multicast address blocks](https://en.wikipedia.org/wiki/Multicast_address), which enable multicasting.

A multicasting server sends one packet, and the network handles replication and addressing (multiplexing) of the packets to the subscribed servers.  Multicast is a one-way protocol: any responses have to be sent by other protocols.  For larger server farms, multicast is a good way to handle things like a software update or a database refresh.  Two special protocols handle subscriptions: [IGMP](https://en.wikipedia.org/wiki/Internet_Group_Management_Protocol), used by individual IPv4 receivers, and [PIM](https://en.wikipedia.org/wiki/Protocol_Independent_Multicast), which is used by L3 devices (like routers) to manage multicast "trees" across a network or subnet.