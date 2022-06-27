<!-- "How to configure MAAS networking" -->
Congratulations!  Now that you've [installed and configured MAAS](/t/how-to-install-maas/5128), configuring your MAAS networks is an important next step.  This major section will help you learn about the theory and practice of MAAS networking.  You can search for [big picture topics](#heading--networking-the-big-picture), or [get down to the details](#heading--networking-specific-topics) right away.

<a href="#heading--networking-the-big-picture"><h2 id="heading--networking-the-big-picture">Networking: the big picture</h2></a>

If you're uncertain about your relevant networking knowledge, you can take a few minutes to learn:

- [About TCP/IP networks](/t/about-tcp-ip-networks/5806): Enjoy reading a little about the history of the Internet, and a lot about the OSI model and TCP/IP, along with key topics like bonds, bridges, ARP, and DNS -- with some network lore thrown to help you appreciate the way TCP/IP networks evolved from the POTS (plain old telephone system).
- [About cloud networks](/t/about-cloud-networks/5808): The original Internet infrastructure is the backbone, but cloud networking calls for a different, more performant and scalable architecture.
- [About DHCP](/t/about-dhcp/5807): DHCP is the most misunderstood aspect of MAAS, hence deserving of a separate theory section.
- [About MAAS networking](/t/about-maas-networking/5084): Most of the MAAS networking terminology is not unique to MAAS, but it's used in somewhat unique ways.

On the other hand, if you're ready to get right down to business, you can investigate:

- [How to manage networks](/t/how-to-manage-networks/5164): Here, you'll learn how to manipulate subnets, examine IP ranges, set up bridges, and generally make sure MAAS can "see" your machines.
- [How to manage IP addresses](/t/how-to-manage-networks/5164): Now that you know how to examine MAAS IP ranges, it's time to learn how to configure MAAS DHCP (in several different configurations), and be sure that you have IP addresses available for your machines to use when they PXE-boot.
- [How to enable TLS](/t/how-to-enable-tls-encryption/5116): You may want to encrypt MAAS communications, or you may even want to do even more to [secure MAAS](/t/how-to-secure-maas/5196); this section guides you through the relevant processes.
- [How to manage availability zones](/t/how-to-manage-availability-zones/5152): Just in case you want to optimise the performance of your networks (and your MAAS instance), you can enable availability zones to polish things up.

These broader topics cover a lot of material, so if you're looking for something in particular, try the longer list of specific topics below.

<a href="#heading--networking-specific-topics"><h2 id="heading--networking-specific-topics">Networking: specific topics</h2></a>

Nobody knows everything, of course, but some folks are only vexed by a couple of bits of network theory.  If that's the case, you can use this detailed list to pinpoint the topics you want to brush up on:

- [About the Internet](/t/about-tcp-ip-networks/5806#heading--about-the-internet): the Access-Aggregation-Core ladder that is the World-Wide Web.
-- [More about the Internet infrastructure](/t/about-tcp-ip-networks/5806#heading--internet-infrastructure): a little cleaner picture of how people think it looks.
-- [About Internet network traffic](/t/about-tcp-ip-networks/5806#heading--about-network-traffic): Network paths on the Internet aren't guaranteed to be deterministic, because they aren't supposed to be.
- [About the OSI model](/t/about-tcp-ip-networks/5806#heading--about-the-osi-model): You can take in the whole Open Systems Interconnect model, or you can focus on the individual layers listed just below.
- [About the physical layer (L1)](https://discourse.maas.io/t/about-tcp-ip-networks/5806#heading--about-the-physical-layer): the signals that network cards exchange to send data, like the Morse Code of the Internet; this is where [variable latency](https://discourse.maas.io/t/about-tcp-ip-networks/5806#heading--about-variable-latency) can cause packets to get out of order.
- [About the datalink layer (L2)](https://discourse.maas.io/t/about-tcp-ip-networks/5806#heading--about-the-datalink-layer): where IP datagrams, or more precisely, IEEE 802.xx frames, get passed around.  This layer really couldn't care less whether the message gets there, or whether the datagrams are delivered in order.  All that's taken care of by the frames themselves.
- [About MAC, MAC frames and Ethernet](https://discourse.maas.io/t/about-tcp-ip-networks/5806#heading--about-frames): Everything you wanted to know about Protocol Data Units (PDUs), what's in them, and why the contents permit layer 2 to be so careless and sloppy.
- [VLANs, subnets, fabrics, and trunking](https://discourse.maas.io/t/about-tcp-ip-networks/5806#heading--about-trunking-vlans): From P/Q tags in the MAC frame, we get to VLANs, which gets us to subnets and fabrics, which are the fundamental building blocks for MAAS networks.
