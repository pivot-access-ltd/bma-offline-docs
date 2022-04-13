<!-- "About cloud networks" -->
Cloud network architectures deviate significantly from the architecture of the Internet infrastructure.  These deviations are driven mostly by economics, simplicity, and scalability.  This section will help you learn:

 - [About the Clos architecture](#heading--clos-architecture)
 - [About STP](#heading--about-stp)

<a href="#heading--clos-architecture"><h2 id="heading--clos-architecture">About the Clos architecture</h2></a>

You may remember that the Internet infrastructure is riddled with side-channels to improve various measures, such as cost and throughput.  Earlier, we saw a fairly pessimistic picture of this infrastructure which helps to explain the variability:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg"></a>

Because of this variability, network performance is uneven and constantly morphing, as different groups of LANs seek better "numbers".  Given that various nodes are constantly upgrading bandwidth, devices, and network speeds to compete for customers, the churn isn't a surprise.  Regulating this churn helps nothing in the long run, of course, but changing the "atomic structure" of the network itself can make things a lot better.   

The structure of the Internet backbone is something like a dirty snowball.  On the way downhill, the snowball picks up rocks, sticks, abandoned shoes, trash, insects, and anything else that gets in its path.  In other words, the Internet infrastructure grows by incorporating anything and everything that helps it move forward.  Differing protocols, link speeds, formats, hardware, software, bandwidth, and media are all added to the infrastructure, almost randomly.

At scale -- that is, considered from the perspective of the global village -- this rolling snowball does pretty well.  Enterprise clouds, though, feel the effects of this variability much more strongly.  Over time, enterprises have learned to heavily standardise their networks, at the lowest level, for more scalable, consistent, and reliable performance.  

The resulting architecture, drawn from the fractal topology created by [Charles Clos](https://en.wikipedia.org/wiki/Clos_network) in a 1952 paper about telephone switching.  "Fractal" is the key word here, in the sense of a simple, repeating pattern.  Where the AAC network is made up of all sorts of devices with different characteristics, the Clos topology can be built from just two basic devices: one type of switch, and one type of server:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fd86954e48538ce9ba8fc6e02df23b0a2337ef12.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fd86954e48538ce9ba8fc6e02df23b0a2337ef12.jpeg"></a>

All the switches in the diagram can be the same unit of hardware, if desired.  The designation "TOR" (for "Top of Rack") simply shows the terminal switch in this network topology, known as a **leaf** switch.  The higher-level switches are referred to as **spine** switches.  The ghosted objects are meant to show how this architecture is (theoretically) infinitely scalable.  

Several inherent characteristics make a Clos ("fractal") architecture more suitable for MAAS networks:

 - Every leaf connects to every spine, or at the very least, every leaf connects to many spines.  By creating many paths through the network, this architecture increases both bandwidth and capacity, with the primary cost being the cabling.

 - The spines only connect leaves, so all functionality is pushed to the racks (some would say "the edges of the network").

 - Networks can be easily scaled with simple, fixed-form-factor switches.

 - The network does not use bridging via the [Spanning Tree Protocol](https://en.wikipedia.org/wiki/Spanning_Tree_Protocol) to interconnect the switches, in this arrangement. Instead, [Equal-Cost Multipath routing](https://en.wikipedia.org/wiki/Equal-cost_multi-path_routing) is used.

 - The network tends to be nonblocking because the oversubscription ratio tends toward 1:1, meaning that the bandwidth between the TOR leaf switches and the servers can easily be adjusted to be roughly equal to the bandwidth between the leaf switch and every other spine switch.  It depends on how interconnect link speeds are defined, but with homogeneous hardware the relative settings and calculations are much simpler and more constant.

 - Networks have a small blast radius, meaning that the loss of a single link does not have a significant effect on the performance of the overall network.  For example, if every leaf switch is connected to each of five spine switches, the loss of one link (or one spine switch) would probably not noticeably degrade network performance.

<a href="#heading--about-stp"><h2 id="heading--about-stp">About STP</h2></a>

Some switches use the Spanning-Tree Protocol (STP) to negotiate a loop-free path through a root bridge. While scanning, it can cause each port to wait up to 50 seconds before sending data. This delay, in turn, can cause problems with some applications/protocols such as PXE, DHCP and DNS, of which MAAS makes extensive use.

To alleviate this problem, you should enable the [Rapid Spanning Tree Protocol](https://en.wikipedia.org/wiki/Spanning_Tree_Protocol) (known as [Portfast](https://www.cisco.com/c/en/us/td/docs/switches/lan/catalyst4000/8-2glx/configuration/guide/stp_enha.html#wp1019873) for Cisco switches), which allows the ports to come up almost immediately.