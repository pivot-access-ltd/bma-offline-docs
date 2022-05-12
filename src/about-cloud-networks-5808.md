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