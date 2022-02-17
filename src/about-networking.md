It's difficult to work effectively with MAAS without a solid understanding of networks.   This page provides opportunities for you to learn:

 - [About TCP/IP networks](#heading--about-tcp-ip-networks)
 - [About cloud networks](#heading--about-cloud-networks)
 - [About MAAS networks](#heading--about-maas-networks)

Most of the examples are related to MAAS, but links are provided for further study, if desired.

<a href="#heading--about-tcp-ip-networks"><h2 id="heading--about-tcp-ip-networks">About TCP/IP networks</h2></a>

TCP/IP networks, and the underlying structure, evolved to meet a specific need: How can we keep a computer network functioning in the event of a catastrophic failure of communications infrastructure?  When nodes go offline, randomly, how can surviving nodes keep the network usable?  The Internet, which relies heavily on TCP/IP networks, has proven over time that it can adapt to changing loads, handle significant failures, and strictly limit the network blast radius when things go wrong.   

Experience has shown us that you will probably have a much easier time working with MAAS if you ensure a solid understanding of network fundamentals.  Rather than bury this basic material, we've decided to include it in the mainstream MAAS networking discussion. Later sections, which help you learn how to design and troubleshoot MAAS networks, will depend heavily on principles explained here.

This section is designed to help you understand:

 - [Internet infrastructure](#heading--about-the-internet-infrastructure)
 - [The OSI model](#heading--about-the-osi-model)
 - [Layer 1: the physical layer](#heading--about-the-physical-layer)
 - [Layer 2: the datalink layer](#heading--about-the-datalink-layer)
 - [Layer 3: the network layer](#heading--about-the-network-layer)
 - [How ARP works](#heading--about-arp)
 - [Layer 4: the transport layer](#heading--about-the-transport-layer)

This material can be read from beginning to end, or you can skip to sections where you feel you might need more clarity.  Just remember that a good understanding of these fundamentals will make it much easier for you to efficiently lay out and debug MAAS networks.

<a href="#heading--about-the-internet-infrastructure"><h3 id="heading--internet-infrastructure">About the Internet infrastructure</h3></a>

Suppose we want to connect two computers, "SanDiego" and "Bangor", located at opposite corners of the country.  They should communicate via a network.  How do we make that happen?  We could simply hook up a wire between SanDiego and Bangor.  In fact, that's essentially how it was done in the beginning. It worked, but there were at least two drawbacks:

1. A long wire has lots of impedance.  Signals can disappear into the noise long before they traverse the wire.  Said differently, the signal-to-noise ratio drops critically low before completing the connection.  Repeaters can fix that problem by amplifying the signal while it's still readable.  Repeaters are physical hardware, which has to reside at intervals along the path.  You'd need places to put repeaters, which means you'd have to lease or own real estate in specific locations, at specific distances.  Cost becomes a factor at that point.

2. A long wire is a single point of failure.  If someone cuts the wire, there's no alternative way for the two computers to communicate.  Obviously, you could run multiple wires, trunk them in separate cables, have backup repeater hardware, and even use different geographical paths for each trunk.  Again, cost is a significant factor here.  

We could solve this by dreaming up all sorts of network architectures, but the easiest way is to create and use the Internet.  As the Internet became "the network", it evolved into what some call the "access-aggregation-core" (AAC) network, which looks something like this: 

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg"></a>

In this model, *SanDiego* sends a message, labelled for *Bangor*, to some router on the Internet (which one doesn't matter so much).  If this router doesn't know where *Bangor* is, it just sends it on to another router, until the message finds a router that knows where to forward the message. Theoretically, this works great, but from a practical standpoint, there are "short circuits" all over the Internet.

These "sideways paths" are there mostly for performance reasons, like latency, redundancy, and so on.  Sometimes they're there because someone can get a better deal, so the reasoning is financial, too.  Some parts of the Internet look like string art, as in the picture above.  Other places only maintain connections between routers on the same level, so they look more like ladders.

Either way, the AAC network can be very complicated and incorporate lots of redundant loops where network packets can get trapped, trying to find a way out.  We'll discover later that TCP/IP has a dedicated way to prevent these infinite loops called the "Time To Live" field.  We'll also talk about how these issues have driven us to design cloud network architectures (known as Clos architectures), which address both the financial and performance impacts of large networks in a much simpler way.

<a href="#heading--internet-infrastructure"><h4 id="heading--internet-infrastructure">About the infrastructure of the Internet</h4></a>

A very old meme explains that the Internet is survivable because every computer can connect to every other computer.  While that might be possible, that's not generally how it works.  There's actually a hierarchy which we refer to as the *Internet Infrastructure*:

- Internet Infrastructure :: a hierarchy of computers used to transfer messages from one computer to another.

High-level networks, known as Network Service Providers (NSPs), connect to at least three top level nodes called Network Access Points (NAPs).  An NAP is just a way for packets to jump from one NSP to another. NAPs are public access points, but there are also privately-owned access points (at the same level) known as Metropolitan Area Exchanges; these act just like a NAP for the purposes of this discussion.  We can simplify the string-art picture above by resolving it into something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b8da34432dd443cd3592487f53887f12889cef06.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b8da34432dd443cd3592487f53887f12889cef06.jpeg"></a>

In theory, the Internet infrastructure and a cloud network should be very similar, but in practice, they diverge greatly.  The real Internet has horizontal connections running everywhere, based on drivers like cost, security, and performance.

<a href="#heading--about-network-traffic"><h4 id="heading--about-network-traffic">About network traffic</h4></a>

As implied by the discussion above, these networks can become very complicated.  There's rarely a reason to even want to know how many hops a message takes, or where it hops, unless you're trying to debug a broken route with, say, [traceroute]([https://linux.die.net/man/8/traceroute).  From a TCP/IP point of view, it's much easier to ignore the specific network, since it gets built on-the-fly, so to speak; and it can change every time a message is sent, even between the same two computers.

In other words, when it comes to designing and troubleshooting networks, knowing the specific route (almost) never helps.  Instead, what we want to know about is the /network traffic/ that travels between computers.  That means we have to understand what /kind/ of traffic travels between computers, besides just the data we send.   The next few sections will explain these concepts.

<a href="#heading--about-the-osi-model"><h3 id="heading--about-the-osi-model">About the OSI model</h3></a>

When we begin to look at networks as a continuous wire, we need to understand what travels on that wire from one host to the other.  But that depends on our perspective, that is, our level of magnification.  If we look at the highest "zoom" level, all we'll see are electrons travelling down the wire.  That's not very useful for debugging purposes.  We can use that information to determine whether anything's being sent, but if the message isn't going out on the wire, we can't guess why not.

The [Open Systems Interconnection model](https://en.wikipedia.org/wiki/OSI_model) was created to standardize on a few different levels.  The OSI model looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/765cd90cffcecfcc83593cde0483e64977a48223.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/765cd90cffcecfcc83593cde0483e64977a48223.jpeg"></a>

In the OSI model, we start just above the raw physics, with what we'd call the physical layer, also known as Layer 1.  The choice of "1" makes sense, because this is the lowest level we consider.

Layers are normally added on top of each other.  For example, if you put six coats of varnish on a piece of furniture, you're going to have six layers.  The first layer you put on wouldn't sensibly be called "layer 6".  Neither does the layering model work that way in networks.

Here's a quick rundown of what each layer does.  Most likely, we won't get into details about all the layers.  The higher you go, the more widely they vary with the user application, so it really doesn't help us understand MAAS networking better.

<a href="#heading--the-physical-layer"><h4 id="heading--the-physical-layer">The physical layer</h4></a>

At the physical layer, we're essentially using binary on/off transitions (clock signals) to detect the bits and bytes of a message fragment.  Conversations about this layer are laced with terms like EIA, bit error rates, V.something, voltage levels, and clock sync.

<a href="#heading--the-datalink-layer"><h4 id="heading--the-datalink-layer">The datalink layer</h4></a>

Layer 2 is the datalink layer, which links two devices that share the same medium (e.g., two routers connected to the same network cable).  Some of these link-layer networks, like Digital Subscriber Lines (DSL), can only connect two devices, but for all practical purposes, most of the modern L2 interfaces are multi-access, meaning more than two stations on the same medium can communicate directly.  Examples of this include Wi-Fi and Ethernet networks.

There are things built into the protocols which manage the conversation, much like the military radio term "over" -- meaning "I'm done talking until I hear something back from you, go ahead." This is the layer where you'd be talking about things like MAC frames, point-to-point protocol, token ring, and Ethernet.

<a href="#heading--arp"><h4 id="heading--arp">Interlayer addressing: ARP</h4></a>

One frequently asked question is this: Is ARP a layer 2 or layer 3 protocol?  Actually, it's both, as you'll discover later, but it does all of its work at L2.  One way to distinguish L2 from L3 is to find out what happens inside the firmware of the Network Interface Card (NIC), and that's usually where ARP takes place.   ARP maps MAC addresses, which is how things are addressed in L2, into other addresses (e.g., IP addresses), which is how L3 finds things.

<a href="#heading--the-network-layer"><h4 id="heading--the-network-layer">The network layer</h4></a>

Layer 3 is the plane where packets are managed, independent of Layers 1 and 2.  At layer 3, everything is coded in terms of packet formats that are independent of the type of link-layer network you're using.  These packet formats are compatible with (but not driven by) the constraints of the physical layer.  Things like addressing schemes and routing algorithms are the main characteristic of this layer.

This layer is where most of the magic happens for networking.  If you're talking to someone about this layer, you'd want to be fluent in your packet format of choice, like IP, DECNet, or AppleTalk. IP addresses are usually the key focus of diagnostics here.

<a href="#heading--the-transport-layer"><h4 id="heading--the-transport-layer">The transport layer</h4></a>

Layer 4 brings us to protocols implemented only by the end hosts (i.e., not by the routers or other switching gear that connect the network).  This layer handles things like redundancy, confirmed delivery, managing packets on an unreliable network, and so forth.  This is the last layer that TCP/IP has anything to say about; layers above this are unique to specific applications.  Troubleshooting this level would involve knowing about entire protocol sets, like UDP or TCP.

<a href="#heading--the-session-layer"><h4 id="heading--the-session-layer">The session layer</h4></a>

Layer 5, the session layer, is where ongoing interactions between applications happen. The data is couched in terms of things an application might understand (e.g., cookies for a Web browser).    This is also the layer where check-pointing (i.e., saving work finished so far) happens.  At this layer, we'd discuss things like RPC, SQL, or NetBIOS.

<a href="#heading--the-presentation-layer"><h4 id="heading--the-presentation-layer">The presentation layer</h4></a>

The presentation layer converts data between formats and ensures standard encodings are used to present the information to the application. This layer is all about file formats: ASCII, EBCDIC, JPEG, GIF, and HTML, to name just a few.

<a href="#heading--the-application-layer"><h4 id="heading--the-application-layer">The application layer</h4></a>

The top layer, layer 7, is totally the province of the application(s) involved in processing messages.  Two techs talking about this layer would be swapping stories about application protocols, like FTP, DNS, SMTP, or NFS.  Almost nothing that happens at this layer -- except for throughput estimates or fouled daemon code -- filters into designing or debugging MAAS networks.

<a href="#heading--about-the-physical-layer"><h3 id="heading--about-the-physical-layer">About the physical layer (L1)</h3></a>

The phrase "physical layer" may conjure up notions of physics, but don't worry -- 
at the physical layer, we don't look at electrons flowing.  We do look at signals.  Specifically, we're looking for binary (on/off) signals, set to the cadence of a clock.  Every computer brings its own clock to the party, so we need a way to "synchronise our watches".  That method is [NPT](https://en.wikipedia.org/wiki/Network_Time_Protocol) , the network time protocol.  

<a href="#heading--about-variable-latency"><h4 id="heading--about-variable-latency">About variable latency</h4></a>

The most important thing to know about the physical layer is this: It introduces variable latency into the timing of network traffic.

In order to understand variable latency, we need to understand network latency.  Essentially, there's a delay from the time you send a packet until it reaches its destination.  It's like the travel time for a packet (or a bit, matters not) from point to point.  It usually consists of four things:

1. The processing delay - how long does it take the router to process the packet header?
2. A queuing delay - how long does the packet sit idle in routing queues?
3. Transmission delay - how long does it take layer 1 to push the packet's bits onto the link?
4. Propagation delay - how long does it take the bits to travel through the wire to the other end?

The size of the queue directly influences how fast data can get onto the link.  The processing and transmission delays are real, though relatively constant.  The propagation delay depends on network architecture, network congestion, and the number of hops (how many routers between source and destination).  As we'll see later on, within your enterprise, the Clos architecture usually causes significantly less propagation delay.

A variable-latency network is "variable" because of the density of network traffic and the complexity of the route between hosts.  We can't predict congestion or routing (although we can influence local routing with the Clos architecture).  Nor can we predict transmission delays; thus "variable-latency".

<a href="#heading--physical-layer-uninteresting"><h4 id="heading--physical-layer-uninteresting">The physical layer is not very interesting</h4></a>

Other than verifying that traffic is flowing on the wire, the physical layer doesn't usually tell us much about what happened to that DHCP request that never made it to the router.  Consequently, we really won't talk that much about the physical layer.  Just know that it's the thing that's passing bits back and forth between hosts, and very occasionally, we need to scan it to debug network issues.

<a href="#heading--about-the-datalink-layer"><h3 id="heading--about-the-datalink-layer">About the datalink layer (L2)</h3></a>

The only purpose of the link layer -- at least from a TCP/IP perspective -- is to send and receive IP datagrams.  L2 generally doesn't try to maintain a connection with the host on the other end (it's "connectionless"), and it doesn't guarantee delivery or integrity of packets.  All it does is ship them between source and destination.

At first, that may seem a little weird.  L2 is not without error checking and recovery code, but it functions efficiently precisely because it isn't concerned with the data or the message containing the data.  That fact can be surprising, since L3 packets, like unique bit-groupings are several layers, are called "datagrams".

A datagram is a basic network transfer unit.  It's the indivisible unit for a given layer.  If we're talking about the data-link layer (aka the "link" layer), it's an IEEE 802.xx frame.  At the network layer, it's a data packet.  For the transport layer, it would be called a segment.  Indivisible units in the physical layer are called chips, which are spread-spectrum pulses in the CDMA, noise-utilizing transmission system that operates at that layer.

Since datagram isn't carefully used by everyone (think of User Datagram Protocol), we agree to call these indivisible laye units PDUs (protocol data units).  This avoids conflation with other uses and reminds you that it's the atomic unit at the current network layer.  At the link layer, it's a frame.

<a href="#heading--about-frames"><h4 id="heading--about-frames">About MAC frames</h4></a>

A MAC frame, or just "frame", encapsulates the packets from the network layer so that they can be transmitted on the physical layer.  A frame can be small or big, anywhere from 5 bytes up to the kilobyte range.  The upper size limit is called the maximum transmission unit (MTU) or maximum frame size.  This size is set by the particular network technology in use.

This last observation brings up a good point: In order to talk sensibly about frames, we'd need to say what kind of frame.  In that case, we're talking about packet-switched networks, so there are about four frame types to consider: Ethernet, fiber channel, V.42, and PPP (point-to-point protocol).  MAAS networks almost exclusively use Ethernet, as defined in the [IEEE 802 standards](https://www.ieee802.org/).  

<a href="#heading--about-ethernet"><h4 id="heading--about-ethernet">About Ethernet</h4></a>

Before explaining an Ethernet Frame, we need to give a little background information about how Ethernet works.  Otherwise a lot of the frame components either won't make sense, or you'll wonder how it works at all.

Remember earlier, when we talked about voice radio, and the need to say "over"?  Well, Ethernet at the link layer is all about controlling the conversation, so that computers don't "talk over each other".  Ethernet implements an algorithm called CSMA/CD, which stands for "carrier sense multiple access with collision detection."  This algorithm controls which computers can access the shared medium (an Ethernet cable) without any special synchronization requirements.

"Carrier sense" means that every NIC does what humans do when we're talking: it waits for quiet.  In this case, it's waiting for the network to be quiet, that is, when no signal is being sent on the network.

"Collision detection" means that, should two NICs both start to send on a shared network at the same time (because the network was quiet), they each receive a jam signal.  This signal tells them to wait a specific, randomly-generated amount of time before attempting again.  Every time subsequent messages collide, the NIC waits twice the amount of time it previously waited.  When it waits some maximum number of times, the NIC will declare a failure and report that the message didn't go.  This ensures that only one frame is traversing the network at any given time.

<a href="#heading--about-media-access-control"><h4 id="heading--about-media-access-control">About Media Access Control (MAC)</h4></a>

Systems like CSMA/CD are a subset of the Media Access Control (MAC) protocol kit.  MAC is one-half of the link layer, with Logical Link Control (LLC) being the other half.  These are sometimes called sublayers. LLC mostly just defines the frame format for the 802.xx protocols, like WiFi, so we can safely ignore it for the purposes of MAAS networking.

If you've worked with networks at all, you've heard of MAC addresses.  Those are basically unique, serial numbers assigned to network interface devices (like NICs) at the time of manufacture.  Theoretically, they are unique in the world, not counting virtual NICs in virtual machine environments.  [MAC address collisions](https://kb.vmware.com/s/article/219) do happen when using VMs, and there are ways to fix it, assuming that your VMs are confined to a subnet.

The MAC sublayer is connected to the physical layer by a media-independent interface (MII), independent of the actual link protocol (e.g, cellular broadband, Wi-Fi radio, Bluetooth, Cat5e, ...).  You can learn more about the [MII](https://en.wikipedia.org/wiki/Media-independent_interface) if you're so inclined, but we won't address it again in the context of MAAS networks.

Essentially, the MAC sublayer grabs higher-level frames and makes them digestible by the physical layer, by encoding them into an MII format.  It adds some synchronization info and pads the message (if needed).   The MAC sublayer also adds a frame check sequence that makes it easier to identify errors.

In conventional Ethernet networks, all this looks something like the following:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/14f6847ed92339061eb4515c12ac2b6117d5cd7c.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/14f6847ed92339061eb4515c12ac2b6117d5cd7c.jpeg"></a>

Let's decode those blocks of bits.

The Preamble is 7 bytes of clock sync, basically just zeroes and ones like this: ...0101010101....  This gives the receiving station a chance to catch up and sync their clock, so the following data isn't out of sync (and thus misinterpreted).  To delve just a little deeper, the Preamble helps the receiving NIC figure out the exact amount of time between encoded bits (it's called clock recovery).  NTP is nice, but Ethernet is an asynchronous LAN protocol, meaning it doesn't expect perfectly synchronized clocks between any two NICs.  The Preamble is similar to the way an orchestra conductor might "count the players in" so they all get the same rhythm to start.

<details><summary>Before clock recovery, there was MPE</summary>

Clock recovery is much more reliable than trying to get computers all over the world synced up to the same clock frequency and the same downbeat (starting point).  Ethernet actually started out that way with something called Manchester Encoding or Manchester Phase Encoding (MPE).  This was important because electrical frequency varies not only across the world, but also from moment to moment when the power is slightly "dirty".  MPE involved bouncing a bit between two fractional voltages using a 20MHz oscillator to generate a reference square wave.  It works, but it's not very efficient, so MPE was scrapped in favor of using the Preamble, the way that projectionists use alignment marks on reels of movie film.
   
</details>

The Start Frame Delimiter is the last chance for clock sync.  It is exactly 10101011, where the "11" tells the receiving station that the real header content starts next.  The receiving NIC has to recover the clock by the time it hits the SFD, or abandon the frame to the bit bucket.

The Destination Address is six bytes long, and gives the physical address -- the MAC address -- of the next hop.  Be aware that the next hop might be the destination, but it's also possible that the next hop might be a NAP, MAE, NSP, or intermediate ISP.  It's basically the next address in the direction of the destination that the sender knows about.  Unlike the Source Address, the Destination Address can be in a broadcast format (similar to a subnet like 192.18.0.0, but using MAC addresses).

The Source Address is also a six-byte MAC address, this time the MAC address of the sender, which does not change as long as the message is traversing only layer-2 (Ethernet) switches and routers.

The PDU Length gives the byte length of the entire frame, assuming that it's 1500 or less.  If it's longer than that, it indicates a message type, like IPv4, ARP, or a "q-tagged" frame, which carries a VLAN ID.

The DSAP, SSAP, and Control elements are each one byte in length, and help define devices and protocols.  For the most part, we won't be worried about these with MAAS networks.  Just know that as more and more 802 point-standards come out (e.g., 802.11, WiFi), these elements get longer and more complex.

The Data or Payload is the actual packet being sent, passed on from the layer above.  It cannot be less than 46 bytes, and in conventional Ethernet, it cannot be larger than 1500 bytes.  If the actual data is too small, it's padded out to 46 bytes.

The CRC or Frame Checksum (FCS) is a standard checksum, used to verify that the message hasn't been corrupted along the way.

The Preamble and SFD are often considered to be part of the IEEE "packet", so some people start counting the "frame" at the Destination Address.  That distinction shouldn't affect anything we do with MAAS networks, but it's nice to keep in mind, in case you run into someone who groups packets differently than you do.

<a href="#heading--about-trunking-vlans"><h4 id="heading--about-trunking-vlans">About Trunking VLANs</h4></a>

There is a crucial modification to the basic frame format called a P/Q or VLAN Tag.  This allows something called VLAN trunking, which means sending all the VLAN data over the same wire and port, but giving the NICs a field (the P/Q tag) to control access.  On paper, it looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/6e58930520fe4ed38d5ea49fab7a337627a88a55.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/6e58930520fe4ed38d5ea49fab7a337627a88a55.jpeg"></a>

As you can see in the modified P/Q frame, the following fields replace part of the frame:

 - Sixteen bits of tags or a protocol ID.

 - Three bits representing a priority.

 - One bit is used as a Canonical Format Indicator (CFI), which is 0 if the following VLAN ID is in Ethernet format, or 1 if it's in Token Ring format.

 - Twelve bits of VLAN ID.

This matters when we're building complex MAAS networks with lots of VLANS that probably cross over switches.  After all, VLANs were initially controlled with ports and switches, although they more commonly use tags now.  When more than one VLAN spans multiple switches, frames need to carry VLAN information that can be used by switches to sort or "trunk" the traffic.

<details><summary>The origin of "trunking"</summary>
The word /trunking/ is derived from the telephone network term trunk lines, which are lines connecting switchboards.

In the original telephone company model, each telephone had a subscriber line, which was a wire that went straight from the local Central Office (CO) to that subscriber's telephone.  Each CO had one switchboard, though it might have many seats.

Connections between Central Offices were handled by trunk lines, because they ran between phone company facilities.  You'd have a thick cable with lots of pairs running from CO to CO, basically enough wires to handle something like 35% of the possible calls.  If you ever got the message, "All circuits are busy now; please try your call again later", you've heard what happens when the system is "trunking above capacity" or "TAC'd", as it was called.

At the CO, the wires would "branch" and run all over the place: First to junction points (those five-foot-tall boxes you see from time to time on the road), then to interface points (the square cans beside the road every half mile or so, also called "pedestals") and from there to subscriber homes.  When you draw out this network, it looks like a tree, where the bundles of cables between COs look like the trunks of trees.

</details>

In the parlance of networks, especially VLANs, the term "trunking" is used to indicate the sharing of network routes.  This sharing is made possible by the Ethernet VLAN tags, which make the VLAN-bound messages less dependent on switches and routers to get the traffic to the right place.  Otherwise, you'd have to designate complicated port configurations for switches, which is particularly easy to misconfigure.

Note that the MAC sublayer is responsible for managing CDMA/CD, that is, detecting a clear line, initiating retransmission if there's a jam signal, etc.  On the way in, the MAC sublayer verifies the CRC/FCS and removes frame elements before passing the data up to the higher layers.  Basically, anything that some other MAC layer did to encapsulate the message for sending, the receiving MAC layer un-does on the way in.

<a href="#heading--about-vlans-subnets-and-fabrics"><h4 id="heading--about-vlans-subnets-and-fabrics">About VLANs, subnets, and fabrics</h4></a>

When working with MAAS networks, you will frequently be concerned with VLANs, subnets, and fabrics, which are all network groupings:

1. Subnets define (group) a range of IP addresses.
   
2. VLANs group subnets.

3. Fabrics group VLANs.

Let's give each of these terms a MAAS context.

**Subnets**

A subnet is a range or collection of IP addresses.  A subnet just means "sub-network," and that's exactly what it is: a subset of IP addresses that can be treated like a single block for some operations.

Subnets are defined in CIDR (Classless Inter-Domain Routing) notation. If you want to use the addresses from 192.168.13.0 to 192.168.13.255 in a subnet, you can specify that with 192.168.13.0/24.  The "24" refers to the number of bits in the subnet address, with the remainder out of 32 bits free to address hosts.  Since 8 bits can represent 256 things, that means /24 gives you the last octet, or 255 host IP addresses.

<details><summary>Whatever happened to subnet classes?</summary>

Subnets used to be defined in terms of subnet classes, like A, B, and C. That got to be a limitation, because those three classes define a fixed number of bits of the IP address that represent the split between subnet addresses and host addresses.  In other words, the class defined how many hosts could be in the network, and three classes wasn't really adequate to address all the possible permutations that network architects needed.  The change to CIDR notation made subnets more granular, allowing many more subnets from the same network.

</details>

**VLANs**

A VLAN used to be a series of IP addresses that could access a given port on a specific switch, generally the switch that gated some protected resource.  With the advent of VLAN trunking (see above), VLANs are marked with the 802.1Q (P/Q) bits in the MAC frame.  In theory, any set of addresses can be associated with any VLAN.

MAAS encourages a correspondence of subnets to VLANs. Every IP should be in exactly one subnet, and every subnet should be part of exactly one VLAN.  You don't have to do that: you could, for example, have two different subnets that overlap, like 192.168.43.0/24 and 192.168.43.0/26.  The ".26" subnet would use fewer bits for the host addresses, so only some of the addresses would overlap.  MAAS generally prevents this kind of address overlap.

Likewise, putting one subnet in two different VLANs might be possible, but it isn't practical or easy to debug when conflicts happen.  MAAS endeavours to enforce a clean "fan-out" across the network, with no possibility of conflicting IP addresses.

**Fabrics**

A fabric just collects VLANs together.  If you stick to the clean fan-out, that also means that a fabric collects subnets.  A fabric provides a higher level grouping.

Consider a MAAS-centric example.  Suppose you have one VLAN for HR, and one VLAN for payroll, so that nobody else can see HR's private files, and likewise you've got payroll data limited to just those people who should see it.

Some executives are entitled to see anything and everything about the corporation.  An "executive" fabric would group all VLANs together, so that people admitted to that fabric can access the VLANs without having to be explicitly added to each one.  That's very handy in really large organizations, saving a lot of time and effort.

<a href="#heading--visualising-the-link-layer"><h4 id="heading--visualising-the-link-layer">Visualising the link layer</h4></a>

Let's start with a message coming on Layer 1 from SanDiego to Bangor. When the message comes in, the link layer does the following things:

1. It synchronizes the NIC, so that bits will indeed be recognized as bits and the message can be properly decoded.

2. It handles the source and destination addresses, using ARP as necessary. 

3. It interprets the length/type bytes and uses them, which means it must judge the length of a frame, and of the data in a frame, or, alternatively, decide whether a frame is IPv4, ARP, or VLAN ("q-tagged").  

4. It processes VLAN tags, which means, at the very least, dealing with the message priority, deciding whether the VLAN frame is Ethernet or Token Ring, and capturing and using the VLAN ID.  The layer handles messages by priority, knows how and when to send Ethernet or Token Ring frames, and knows how to route traffic to a specific VLAN.

5. It computes the checksum to make sure the message is valid.

Next, we'll take a look at the network layer, where most of the message transactions take place, and where most of our debugging will be done.

<a href="#heading--about-bond-interfaces"><h3 id="heading--about-bond-interfaces">About bond interfaces</h3></a>

A bond interface is used to aggregate two or more physical interfaces into a single logical interface. Combining multiple network connections in parallel can increase network throughput beyond what a single NIC will allow.  It also provides some redundancy in case one of the NICs should fail.

Bonded interfaces use a special frame format called LACPDU, or "Link Aggregation Control Protocol Data Unit.  More information about these special frames, and about the theory behind bonded NICs, can be found in the [relevant IEEE standard](https://1.ieee802.org/tsn/802-1ax-rev/).

<a href="#heading--about-the-network-layer"><h3 id="heading--about-the-network-layer">About the network layer</h3></a>

You might have noticed in the original OSI model that "IP" was part of Layer 3, and protocol stacks like UDP and TCP were part of Layer 4.  It's a little bit confusing that we say "TCP/IP" when the "IP" really applies to so many other protocols like UDP and ICMP.  There are certainly other protocols and protocol stacks, but for the purposes of MAAS networks, we're talking almost exclusively about TCP/IP.

The network layer does not guarantee delivery.  Essentially, it makes every effort to deliver IP datagrams (packets) to the destination, but it's error-handling is pretty simple: just toss the packet into the bit-bucket.

It's also a connectionless layer, meaning the packets making up a message aren't part of an ongoing conversation.  They can be split up, encoded, and sent separately, by different routes, and arrive completely out of order.  And packets can get duplicated or corrupted.  Figuring all this out is the job of the protocol stack (e.g., TCP) in layer 4.  The network layer, L3, just delivers packets.  

<details><summary>Network byte order</summary>

A rarely needed (but useful) fact is that the network sends bytes in /big endian/ order.  That means bytes are transmitted starting with bit 0 and working down to bit 31, usually eight bits at a time.  A lot of the computers on the Internet use little endian encoding, which starts at the other end of the word.  In those cases, the byte order has to be reversed somewhere between the computer's memory and Layer 3.

For most situations, that fact isn't particularly useful, but there is the occasional fault that involves failure to reverse byte order along the path from RAM to NIC.

</details>

<a href="#heading--about-packets"><h4 id="heading--about-packets">About packets</h3></a>

Packets are basic Internet Protocol (IP) message units.  A message will probably be split into multiple packets by L4 (the transport layer) so it can be efficiently sent.

For example, imagine that you're sending a very long letter to your friend, and all you have are lots of envelopes and first-class stamps.  If you've ever done a lot of mailing, you'll know that mailing a one-ounce letter costs you, say, fifty-eight cents.  If you add another ounce of paper to it, that second ounce only costs you, say, twenty cents.  But all you have are first class (i.e., fifty-eight-cent) stamps.

If you don't want to waste your money, you can either cram more pages in the envelope, until you're at three ounces (the most you can get with two stamps), or send two letters, each with one ounce in it.  The way envelopes go through the mailing system, you're better off not over-stuffing an envelope.  So what do you do?

You sit down and write the letter to your friend, carefully numbering the pages.  Then you divide it into piles of pages that are just under one ounce. Finally, you put each pile into an addressed, stamped envelope and mail each letter separately.  When your friend gets the letters, it doesn't matter which one gets there first, because they can reassemble your message, using the page numbers.

<a href="#heading--about-fixed-packet-lengths"><h4 id="heading--about-fixed-packet-lengths">About fixed packet lengths and segmented messaging</h3></a>

We could have designed computer networks to take messages of indeterminate lengths, but that presents some unique challenges when trying to manage network traffic.  For example, suppose you send seven overstuffed letters to your friend, and so does everyone else on your block?  All these huge letters aren't going to fit in one letter-carrier's bag, so they'll have to either send out two delivery people, or wait until tomorrow to send out someone's letters.

Choosing a fixed (relatively short) length makes it statistically possible for everyone's letters (everyone's messages) to be delivered at a fairly constant, reliable rate.  That rate will vary with the size of the overall message, not with who threw their message on the Internet first.  A larger message takes longer to send.

Messages are split into packets of consistent length before they're passed to L3, so larger messages take longer.  It's statistically more efficient to split messages into equally-sized packets than any other arrangement -- the method that gets the highest count of complete messages through the network in a given amount of time. In network terminology, it's the highest-throughput approach to network traffic.  Specifically, this technique is called multiplexing.

<a href="#heading--about-ip-packets"><h4 id="heading--about-ip-packets">About IP packets</h3></a>

The IP datagram (packet) is the backbone of most modern networks.  The following diagram depicts an IPv4 header, which attaches to the front of data packets up to about 65K long:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fc349972f6b7509b5b2459bf3bb44419961f0bcd.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fc349972f6b7509b5b2459bf3bb44419961f0bcd.jpeg"></a>

Note that IPv6 headers have only the version field in common with IPv4 headers; otherwise, they are completely different.  Here are the header fields and what information they carry:

- **IP Protocol Version**  This is "4" for IPv4 and "6" for IPv6.  There are [lots of others](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml), but they generally don't touch a MAAS network.
- **Internet Header Length** The number of 32-bit words in the header, including the options (but not including the data, since it's just the header).  Most of the time, this will have the value "5", but options do exist and are sometimes included.
- **Differentiated Services Code Point** This is used to specify special classes of service.  Normally, IP packets are delivered on a "best-effort" basis, that is, Layer 3 will try everything possible to make sure a packet gets delivered.  You can cause L3 to deliver packets with higher priority (implying more certainty) by using a different DSCP.
- **ECN = Explicit Congestion Notification** These bits are both set by an ECN-capable router when that router is above a certain traffic threshold.  They are there to alert a sender to slow down (or expect delays) when the network segment in use is particularly congested.
- **Total Length of IP Packet** This field indicates the length of the entire packet, /including/ the data.  This makes it possible to calculate the byte offset of the data within the datagram.
- **Identification**  This is a serial number, generated by the sending NIC, that helps the participants uniquely identify the datagram.  In a sense, it works like the little "take-a-number" tickets you get at the hamburger stand: Eventually, the number will repeat, but the repeat cycle is so long that there's no chance of confusing packets.  The sequential nature of this field, when used in concert with the Flags and Fragmentation Offset field, helps the protocol stack correctly reassemble the message.
- **Flags**  This field is basically used to indicate that a packet is a fragment of a longer message.
- **Fragmentation Offset**  Used with the Identification sequence number, this field allows the system to know which packets precede or follow this one when re-assembling the message.
- **Time to Live (TTL)**  This indicates the number of routers that a datagram can pass through before it's discarded.  Since routers function by replacing their own destination address with the IP address of the next hop, this essentially limits the number of times a packet's destination IP can be changed.  Most RFC documents suggest keeping this number at 64, it's more often set to something like 255 without any real bottlenecks.
- **Protocol** This field indicates the higher level protocol (the protocol stack) that generated this message.  Examples are given for TCP and UDP in the figure.
- **Header Checksum** This calculates a checksum for the header only.  It's only used in IPv4.  Doing integrity-checking on the data is the responsibility of Layer 4.
- **Source Address** This is the IP address of the sender of the packet, /for this hop only/.  As shown in the figure below, routers will change this address so they can get the answer back.
- **Destination Address**  This is the IP address of the destination, /for this hop only/.  As shown below, routers change this address to act as brokers in the IP chain.

<a href="#heading--about-routing"><h4 id="heading--about-routing">About routing</h3></a>

We now have enough concepts in play to talk about routing.  Routing takes place at the network layer, by changing the source and destination addresses (without losing track of the replaced address).  The process looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/73c49cb76573e42036c59832f5f16b6383fbc0bd.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/73c49cb76573e42036c59832f5f16b6383fbc0bd.jpeg"></a>

The router typically assigns a unique port number to the outbound message, and records the source IP against that port number.  When the message comes back to it on that port number, it can look up the IP address of the NIC that sent the packet and route the answer back.

<a href="#heading--about-bridge-interfaces"><h3 id="heading--about-bridge-interfaces">About bridge interfaces</h3></a>

A network bridge may be useful if you intend to use virtual machines or containers with MAAS. You can create a network bridge with MAAS; via netplan; or by any other established method to create a network bridge.

<a href="#heading--about-maas-networks"><h2 id="heading--about-maas-networks">About MAAS networks</h2></a>

<a href="#heading--about-network-discovery"><h3 id="heading--about-network-discovery">About network discovery</h3></a>

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
