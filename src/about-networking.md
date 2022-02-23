It's difficult to work effectively with MAAS without a solid understanding of networks.   This page provides opportunities for you to learn:

 - [About TCP/IP networks](#heading--about-tcp-ip-networks)
 - [About cloud networks](#heading--about-cloud-networks)
 - [About MAAS networks](#heading--about-maas-networks)

Most of the examples are related to MAAS, but links are provided for further study, if desired.

<a href="#heading--about-tcp-ip-networks"><h2 id="heading--about-tcp-ip-networks">About TCP/IP networks</h2></a>

TCP/IP networks, and the underlying structure, evolved to meet a specific need: How can we keep a computer network functioning in the event of a catastrophic failure of communications infrastructure?  When nodes go offline, randomly, how can surviving nodes keep the network usable?  The Internet, which relies heavily on TCP/IP networks, has proven over time that it can adapt to changing loads, handle significant failures, and strictly limit the network blast radius when things go wrong.   

Experience has shown us that you will probably have a much easier time working with MAAS if you ensure that you have a solid understanding of network fundamentals.  Rather than bury this basic material, we've decided to include it in the mainstream MAAS networking discussion. Later sections, which help you learn how to design and troubleshoot MAAS networks, will depend heavily on principles explained here.

This section is designed to help you learn:

 - [About the Internet](#heading--about-the-internet)
 - [About the OSI model](#heading--about-the-osi-model)
 - [About the physical layer (L1)](#heading--about-the-physical-layer)
 - [About the datalink layer (L2)](#heading--about-the-datalink-layer)
 - [About bond interfaces](#heading--about-bond-interfaces)
 - [About the network layer](#heading--about-the-network-layer)
 - [About bridge interfaces](#heading--about-bridge-interfaces)
 - [About ARP](#heading--about-arp)
 - [About TCP](#heading--about-tcp)
 - [About DHCP](#heading--about-dhcp)

This material can be read from beginning to end, or you can skip to sections where you feel you might need more clarity.  Just remember that a good understanding of these fundamentals will make it much easier for you to efficiently lay out and debug MAAS networks.

<a href="#heading--about-the-internet"><h3 id="heading--about-the-internet">About the Internet</h3></a>

Suppose we want to connect two computers, "SanDiego" and "Bangor", located at opposite corners of the country.  They should communicate via a network.  How do we make that happen?

This subsection will help you learn:

 - [About the infrastructure of the Internet](#heading--internet-infrastructure)
 - [About Internet network traffic](#heading--about-network-traffic)

We could simply hook up a wire between SanDiego and Bangor.  In fact, that's essentially how it was done in the beginning. It worked, but there were at least two drawbacks:

1. A long wire has lots of impedance.  Signals can disappear into the noise long before they traverse the wire.  Said differently, the signal-to-noise ratio drops critically low before completing the connection.  Repeaters can fix that problem by amplifying the signal while it's still readable.  Repeaters are physical hardware, which has to reside at intervals along the path.  You'd need places to put repeaters, which means you'd have to lease or own real estate in specific locations, at specific distances.  Cost becomes a factor at that point.

<details id="heading--t1-lines"><summary>T1 lines and the early Internet</summary>

In the very early days of long-haul networking, most of the repeaters were owned by the local telephone companies. T1 lines, as they were called, couldn't compete with today's fibre connections, but they did provide a speedy (at the time) 1.5Mbps connection.  For example, in the oil and gas industry of the early 1990s, many of the city offices had wall after wall of T1 lines wired directly into the building.

T1 wasn't designed for network traffic, exactly,  The idea was to multiplex phone calls on one line via Time-Division Multiplexing.  TDM split up the call traffic into little digital packets that were sent on a rotating basis.  The first T1 lines, which showed up around 1962, could handle about 24 calls without the average telephone user noticing.  Telephone linemen generally could tell by the "clipped" nature of the call, as there is a distinctive flatness to the conversation over a digital TDM circuit.

The T1 lines used ordinary, double-twisted-pair copper wiring, with repeaters at roughly one-mile intervals.  Those repeaters were part of the larger greyish-green "cans" (pedestals) that still dot the roadsides today in the US.  When WAN and MAN networking became a thing, the phone company just repurposed some of those pairs to carry data traffic.

Some of the key elements of TCP/IP, like twisted-pair Ethernet cables, packet-based messaging, and multiplexing, are all just holdovers of the original T1 digital subscriber system -- repurposed for computer networking.
</details>

2. A long wire is a single point of failure.  If someone cuts the wire, there's no alternative way for the two computers to communicate.  Obviously, you could run multiple wires, trunk them in separate cables, have backup repeater hardware, and even use different geographical paths for each trunk.  Again, cost is a significant factor here.  

We could solve this by dreaming up all sorts of network architectures, but the easiest way is to create and use something known as the "Internet infrastructure".  As the Internet became "the network", it evolved into what some call an "access-aggregation-core" (AAC) network, which looks something like this: 

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e15a35da43b2788883ec014efb1832b8f641e872.jpeg"></a>

In this model, **SanDiego** sends a message, labelled for **Bangor**, to some router on the Internet (doesn't matter which one).  If this router doesn't know where **Bangor** is, it just sends it on to another router, until the message finds a router that knows where to forward the message. Theoretically, this works great, but from a practical standpoint, there are "short circuits" all over the Internet.

These "sideways paths" are there mostly for performance reasons, like latency, redundancy, and so on.  Sometimes they're there because someone can get a better deal, so the reasoning is financial, too.  Some parts of the Internet look like string art, as in the picture above.  Other places only maintain connections between routers on the same level, so they look more like ladders.

Either way, the AAC network can be very complicated and incorporate lots of redundant loops where network packets can get trapped, trying to find a way out.  We'll discover [later](#heading--about-ip-packets) that TCP/IP has a dedicated way to prevent these infinite loops called the "Time To Live" field.  We'll also talk about how these issues have driven us to design [cloud network architectures](#heading--about-cloud-networks) (known as Clos architectures), which address both the financial and performance impacts of large networks in a much simpler way.

<a href="#heading--internet-infrastructure"><h4 id="heading--internet-infrastructure">About the infrastructure of the Internet</h4></a>

A very old meme explains that the Internet is survivable because every computer can connect to every other computer.  While that might be possible, that's not generally how it works.  There's actually a hierarchy which we refer to as the *Internet Infrastructure*:

 - Internet Infrastructure :: a hierarchy of computers used to transfer messages from one computer to another.

High-level networks, known as Network Service Providers (NSPs), connect to at least three top level nodes called Network Access Points (NAPs).  An NAP is just a way for packets to jump from one NSP to another. NAPs are public access points, but there are also privately-owned access points (at the same level) known as Metropolitan Area Exchanges.  Many of the MAEs are the residue of the phone company's [early T1 lines](#heading--t1-lines), which was the initial backbone for the Internet.  These MAEs act just like a NAP for the purposes of this discussion.

We can simplify the string-art picture above by resolving it into something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b8da34432dd443cd3592487f53887f12889cef06.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b8da34432dd443cd3592487f53887f12889cef06.jpeg"></a>

In theory, the Internet infrastructure and a cloud network should be very similar, but in practice, they diverge greatly.  The real Internet has horizontal connections running everywhere, based on drivers like cost, security, and performance.  Those vertical connections introduce an interface cost (heterogeneous hardware), a performance hit (varying network speeds), and bandwidth variance (differing node architectures).  Contracts for lateral connections change daily, which changes the routing, which changes the way the Internet behaves for users.

<a href="#heading--about-network-traffic"><h4 id="heading--about-network-traffic">About Internet network traffic</h4></a>

As implied by the discussion above, these networks can become very complicated and somewhat unpredictable.  As a result, there's rarely a reason to even count how many hops a message takes, or where it hops, unless you're trying to debug a broken route with, say, [traceroute]([https://linux.die.net/man/8/traceroute).  From a TCP/IP point of view, it's much easier to ignore the specific network, since it gets built on-the-fly, so to speak; and it can change every time a message is sent, even between the same two computers.

In other words, when it comes to designing and troubleshooting networks, knowing the specific route (almost) never helps.  Instead, what we want to know about is the network traffic that travels between computers.  That means we have to understand what kind of traffic travels between computers, besides just the data we send.   The next few sections will explain these fundamentals.

<a href="#heading--about-the-osi-model"><h3 id="heading--about-the-osi-model">About the OSI model</h3></a>

This subsection will help you learn about the OSI model and:

 - [The physical layer](#heading--the-physical-layer)
 - [The datalink layer](#heading--the-datalink-layer)
 - [Interlayer addressing: ARP](#heading--arp)
 - [The network layer](#heading--the-network-layer)
 - [The transport layer](#heading--the-transport-layer)
 - [The session layer](#heading--the-session-layer)
 - [The presentation layer](#heading--the-presentation-layer)
 - [The application layer](#heading--the-application-layer)

When we begin to look at networks as a continuous wire, we need to understand what travels on that wire from one host to the other.  But that depends on our perspective, that is, our level of magnification.  If we look at the highest "zoom" level, all we'll see are electrons travelling down the wire.  That's not very useful for debugging purposes.  We can use that information to determine whether anything's being sent, but if the message isn't going out on the wire, we can't guess why not.

The [Open Systems Interconnection model](https://en.wikipedia.org/wiki/OSI_model) was created to standardise on a few different levels.  The OSI model looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/765cd90cffcecfcc83593cde0483e64977a48223.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/765cd90cffcecfcc83593cde0483e64977a48223.jpeg"></a>

In the OSI model, we start just above the raw physics, with what we'd call the physical layer, also known as Layer 1.  The choice of "1" makes sense, because this is the lowest level we consider.

Layers are normally added on top of each other.  For example, if you put six coats of varnish on a piece of furniture, you're going to have six layers.  The first layer you put on wouldn't sensibly be called "layer 6"; neither does the network layering model work that way.

Here's a quick rundown of what each layer does.  Most likely, we won't get into details about all the layers, because the higher you go, the more widely they vary with the user application.  Higher layers don't really help us understand MAAS networking better.

<a href="#heading--the-physical-layer"><h4 id="heading--the-physical-layer">The physical layer</h4></a>

At the physical layer, we're essentially using binary on/off transitions (clock signals) to detect the bits and bytes of a message fragment.  Conversations about this layer are laced with terms like EIA, bit error rates, V.something, voltage levels, and clock sync.

<a href="#heading--the-datalink-layer"><h4 id="heading--the-datalink-layer">The datalink layer</h4></a>

Layer 2 is the datalink layer, which links two devices that share the same medium (e.g., two routers connected to the same network cable).  Some of these link-layer networks, like Digital Subscriber Lines (DSL), can only connect two devices, but for all practical purposes, most of the modern L2 interfaces are multi-access, meaning more than two stations on the same medium can communicate directly.

Examples of this include Wi-Fi and Ethernet networks. These networks multiplex not by TDM, like the [old T1 networks](#heading--t1-lines), but by shared management of the medium.  As we'll see, communication is self-managed, similar to motorists negotiating a four-way stop: The first device to grab the wire gets to send a little bit, and there are rules for handling simultaneous "grabs".  This type of multiplexing is called packet-division multiplexing.

<details><summary>PDM v. TDM</summary>

The term "packet-division multiplexing" isn't as descriptive as "time-division multiplexing".  Both use fixed transmission units which could be called "packets".  But PDM differs from TDM in one important way: it has better latency.

TDM sets specific timing for each of 24 conversations.  If only one conversation is going on, it only uses the network 1/24th of the time.  In other words, the latency of a conversation on the (original) TDM lines would have been around 96%, meaning that only 4% of the time was any single conversation taking place.

While that worked fine for voice calls for a really long time, it's terrible in terms of network utilisation.  PDM solves this by using the wire when it's free.  As you'll see [a little later on](#heading--about-ethernet), something called "Carrier Sense Multiple Access with Collision Detection" (CSMA/CD) makes the network perform statistically near it's maximum bandwidth when necessary.

CSMA/CD allows any sender to commandeer the wire when it's free, but only for very short, fixed-length packets.  You can't hog the connection to send a giant JPEG file, unless you just happen to be the only device currently active on the network.  Even then, your image must be broken up into packets, sent as short bursts, and very likely surrounded by routine network traffic such as keepalives, cache sends, and DHCP offers.

In short, both methods involve devices taking turns.  TDM turns were originally based on a stopwatch.  PDM turns are based on the four-way stop model.  Better network utilisation means better bandwidth, which means lower cost.
</details>

There are things built into the protocols which manage the conversation, much like the military radio term "over" -- meaning "I'm done talking until I hear something back from you, go ahead." This is the layer where you'd be talking about things like MAC frames, point-to-point protocol, token ring, and Ethernet.

<a href="#heading--arp"><h4 id="heading--arp">Interlayer addressing: ARP</h4></a>

One frequently asked question is this: Is ARP a layer 2 or layer 3 protocol?  Actually, it's both, as you'll [discover later](#heading--about-arp), but it does all of its work at L2.  One way to distinguish L2 from L3 is to find out what happens inside the firmware of the Network Interface Card (NIC), and that's usually where ARP takes place.   ARP maps MAC addresses, which is how things are addressed in L2, into other addresses (e.g., IP addresses), which is how L3 finds things.

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
at the physical layer, we don't look at electrons flowing.  We do look at signals.  This subsection will help you learn the basics of the physical layer, and also:

 - [About variable latency](#heading--about-variable-latency)
 - [Why the physical layer is not very interesting](#heading--physical-layer-uninteresting)

At the physical layer, we're looking for binary (on/off) signals, set to the cadence of a clock.  Every computer brings its own clock to the party, so we need a way to "synchronise our watches".  That method is [NTP](https://en.wikipedia.org/wiki/Network_Time_Protocol) , the network time protocol.  

<a href="#heading--about-variable-latency"><h4 id="heading--about-variable-latency">About variable latency</h4></a>

The most important thing to know about the physical layer is this: It introduces variable latency into the timing of network traffic.

In order to understand variable latency, we need to understand network latency.  Essentially, there's a delay from the time you send a packet until it reaches its destination.  It's like the travel time for a packet (or a bit, matters not) from point to point.  It usually consists of four things:

1. The processing delay - how long does it take the router to process the packet header?
2. A queuing delay - how long does the packet sit idle in routing queues?
3. Transmission delay - how long does it take layer 1 to push the packet's bits onto the link?
4. Propagation delay - how long does it take the bits to travel through the wire to the other end?

The size of the queue directly influences how fast data can get onto the link.  The processing and transmission delays are real, though relatively constant.  The propagation delay depends on network architecture, network congestion, and the number of hops (how many routers between source and destination).  [As we'll see later on](#heading--clos-architecture), within your enterprise, the Clos architecture usually causes significantly less propagation delay.

A variable-latency network is "variable" because of the density of network traffic and the complexity of the route between hosts.  We can't predict congestion or routing, although we can influence local routing with the by the choice of network architecture.  We can't predict transmission delays, although we can statistically put some bounds on them.  Thus almost all digital networks are considered "variable-latency".

<a href="#heading--physical-layer-uninteresting"><h4 id="heading--physical-layer-uninteresting">The physical layer is not very interesting</h4></a>

Other than verifying that traffic is flowing on the wire, the physical layer doesn't usually tell us much about what happened to that DHCP request that never made it to the router.  Consequently, we really won't talk that much about the physical layer.  Just know that it's the thing that's passing bits back and forth between hosts, and very occasionally, we need to scan it to debug network issues.

<a href="#heading--about-the-datalink-layer"><h3 id="heading--about-the-datalink-layer">About the datalink layer (L2)</h3></a>

The only purpose of the link layer -- at least from a TCP/IP perspective -- is to send and receive IP datagrams.  L2 generally doesn't try to maintain a connection with the host on the other end (it's "connectionless"), and it doesn't guarantee delivery or integrity of packets.  All it does is ship them between source and destination.  This subsection will help you learn:

 - [About MAC frames](#heading--about-frames)
 - [About Ethernet](#heading--about-ethernet)
 - [About Media Access Control (MAC)](#heading--about-media-access-control)
 - [About trunking VLANs](#heading--about-trunking-vlans)
 - [About VLANs, subnets, and fabrics](#heading--about-vlans-subnets-and-fabrics)
 - [How to visualise the link layer](#heading--visualising-the-link-layer)

At first, the message-agnostic state of the link layer may seem a little weird.  L2 is not without error-checking and recovery code, but it functions efficiently because it isn't concerned with the data or the message containing the data.  That fact can be surprising, since L3 packets are called "datagrams".

A datagram is just a basic network transfer unit.  It's the indivisible unit for a given layer.  If we're talking about the data-link layer (aka the "link" layer), it's an IEEE 802.xx frame.  At the network layer, it's a data packet.  For the transport layer, it would be called a segment.  Indivisible units in the physical layer are called chips, which are spread-spectrum pulses in the CDMA, noise-utilising transmission system that operates at that layer.

Since datagram isn't carefully used by everyone (think of User Datagram Protocol), we'll agree to call these indivisible layer units PDUs (protocol data units).  This avoids conflation with other uses and reminds you that it's the atomic unit at the current network layer.  At the link layer, it's a frame.

<a href="#heading--about-frames"><h4 id="heading--about-frames">About MAC frames</h4></a>

A MAC frame, or just "frame", encapsulates the packets from the network layer so that they can be transmitted on the physical layer.  A frame can be small or big, anywhere from 5 bytes up to the kilobyte range.  The upper size limit is called the maximum transmission unit (MTU) or maximum frame size.  This size is set by the particular network technology in use.

This last observation brings up a good point: In order to talk sensibly about frames, we'd need to say what kind of frame.  With MAAS, we're always talking about packet-switched networks, so there are potentially four frame types to consider: Ethernet, fibre channel, V.42, and PPP (point-to-point protocol).

Happily, MAAS networks almost exclusively use Ethernet, as defined in the [IEEE 802 standards](https://www.ieee802.org/), so we'll stick to that particular frame type for this discussion.  Where other frame types may come into play, we'll discuss those as special cases.  

<a href="#heading--about-ethernet"><h4 id="heading--about-ethernet">About Ethernet</h4></a>

Before explaining an Ethernet Frame, we need to give a little background information about how Ethernet works.  Otherwise a lot of the frame components either won't make sense, or you'll wonder how it works at all.

Remember earlier, when we talked about voice radio, and the need to say "over"?  Well, Ethernet at the link layer is all about controlling the conversation, so that computers don't "talk over each other".  Ethernet implements an algorithm called CSMA/CD, which stands for "carrier sense multiple access with collision detection."  This algorithm controls which computers can access the shared medium (an Ethernet cable) without any special synchronization requirements.

"Carrier sense" means that every NIC does what humans do when we're talking: it waits for quiet.  In this case, it's waiting for the network to be quiet, that is, when no signal is being sent on the network.

"Collision detection" means that, should two NICs both start to send on a shared network at the same time (because the network was quiet), they each receive a jam signal.  This signal tells them to wait a specific, randomly-generated amount of time before attempting again.  Every time subsequent messages collide, the NIC waits twice the amount of time it previously waited.  When it waits some maximum number of times, the NIC will declare a failure and report that the message didn't go.  This ensures that only one frame is traversing the network at any given time.

<a href="#heading--about-media-access-control"><h4 id="heading--about-media-access-control">About Media Access Control (MAC)</h4></a>

Systems like CSMA/CD are a subset of the Media Access Control (MAC) protocol kit.  MAC is one-half of the link layer, with Logical Link Control (LLC) being the other half.  These are sometimes called sub-layers. LLC mostly just defines the frame format for the 802.xx protocols, like WiFi, so we can safely ignore it for the purposes of MAAS networking.

If you've worked with networks at all, you've heard of MAC addresses.  Those are basically unique serial numbers assigned to network interface devices (like NICs) at the time of manufacture.  Theoretically, they are unique in the world, not counting virtual NICs in virtual machine environments.  [MAC address collisions](https://kb.vmware.com/s/article/219) do happen when using VMs, and there are ways to fix it, assuming that your VMs are confined to a subnet.

The MAC sub-layer is connected to the physical layer by a media-independent interface (MII), independent of the actual link protocol (e.g, cellular broadband, Wi-Fi radio, Bluetooth, Cat5e, T1, ...).  You can learn more about the [MII](https://en.wikipedia.org/wiki/Media-independent_interface) if you're so inclined, but we won't address it again in the context of MAAS networks.

Essentially, the MAC sub-layer grabs higher-level frames and makes them digestible by the physical layer, by encoding them into an MII format.  It adds some synchronization info and pads the message (if needed).   The MAC sub-layer also adds a frame check sequence that makes it easier to identify errors.

In conventional Ethernet networks, all this looks something like the following:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/14f6847ed92339061eb4515c12ac2b6117d5cd7c.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/14f6847ed92339061eb4515c12ac2b6117d5cd7c.jpeg"></a>

Let's decode those blocks of bits:

 - The **Preamble** is 7 bytes of clock sync, basically just zeroes and ones like this: ...0101010101....  This gives the receiving station a chance to catch up and sync their clock, so the following data isn't out of sync (and thus misinterpreted).  To delve just a little deeper, the Preamble helps the receiving NIC figure out the exact amount of time between encoded bits (it's called clock recovery).  NTP is nice, but Ethernet is an asynchronous LAN protocol, meaning it doesn't expect perfectly synchronised clocks between any two NICs.  The Preamble is similar to the way an orchestra conductor might "count the players in" so they all get the same rhythm to start.

<details><summary>Before clock recovery, there was MPE</summary>

Clock recovery is much more reliable than trying to get computers all over the world synced up to the same clock frequency and the same downbeat (starting point).  Ethernet actually started out that way with something called Manchester Encoding or Manchester Phase Encoding (MPE).  This was important because electrical frequency varies not only across the world, but also from moment to moment when the power is slightly "dirty".  MPE involved bouncing a bit between two fractional voltages using a 20MHz oscillator to generate a reference square wave.  It works, but it's not very efficient, so MPE was scrapped in favour of using the Preamble, the way that projectionists use alignment marks on reels of movie film.
   
</details>

 - The **Start Frame Delimiter (SFD)** is the last chance for clock sync.  It is exactly 10101011, where the "11" tells the receiving station that the real header content starts next.  The receiving NIC has to recover the clock by the time it hits the SFD, or abandon the frame to the bit bucket.

 - The **Destination Address (DAddr)** is six bytes long, and gives the physical address -- the MAC address -- of the next hop.  Be aware that the next hop might be the destination, but it's also possible that the next hop might be a NAP, MAE, NSP, or intermediate ISP.  It's basically the next address in the direction of the destination that the sender knows about.  Unlike the Source Address, the Destination Address can be in a broadcast format (similar to a subnet like 192.18.0.0, but using MAC addresses).

 - The **Source Address (SAddr)** is also a six-byte MAC address, this time the MAC address of the sender, which does not change as long as the message is traversing only layer-2 (Ethernet) switches and routers.

 - The **PDU Length (PDULen)** gives the byte length of the entire frame, assuming that it's 1500 or less.  If it's longer than that, it indicates a message type, like IPv4, ARP, or a "q-tagged" frame, which carries a VLAN ID.

 - The **DSAP**, **SSAP**, and **Control** elements are each one byte in length, and help define devices and protocols.  For the most part, we won't be worried about these with MAAS networks.  Just know that as more and more 802 point-standards come out (e.g., 802.11, WiFi), these elements get longer and more complex.

 - The **Data** or "Payload" is the actual packet being sent, which in the case of TCP/IP, is just a TCP header attached to a fixed-length chunk of the application's data.  It's passed on from the layer above.  It cannot be less than 46 bytes, and in conventional Ethernet, it cannot be larger than 1500 bytes.  If the actual data is too small, it's padded out to 46 bytes.

 - The **CRC** or "Frame Checksum" (FCS) is a standard checksum, used to verify that the message hasn't been corrupted along the way.

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
The word "trunking" is derived from the telephone network term trunk lines, which are lines connecting switchboards.

In the original telephone company model, each telephone had a subscriber line, which was a wire that went straight from the local Central Office (CO) to that subscriber's telephone.  Each CO had one switchboard, though it might have many seats.

Connections between Central Offices were handled by trunk lines, because they ran between phone company facilities.  You'd have a thick cable with lots of pairs running from CO to CO, basically enough wires to handle something like 35% of the possible calls.  If you ever got the message, "All circuits are busy now; please try your call again later", you've heard what happens when the system is "trunking above capacity" or "TAC'd", as it was called.

At the CO, the wires would "branch" and run all over the place: First to junction points (those five-foot-tall boxes you see from time to time on the road), then to interface points (the square cans beside the road every half mile or so, also called "pedestals") and from there to subscriber homes.  When you draw out this network, it looks like a tree, where the bundles of cables between COs look like the trunks of trees.

With VLAN trunking, by the way, we're not just multiplexing packets, we're actually multiplexing LAN channels, so to speak.  
</details>

In the parlance of networks, especially VLANs, the term "trunking" is used to indicate the sharing of network routes.  This sharing is made possible by the Ethernet VLAN tags, which make the VLAN-bound messages less dependent on switches and routers to get the traffic to the right place.  Otherwise, you'd have to designate complicated port configurations for switches, which is particularly easy to misconfigure.

Note that the MAC sub-layer is responsible for managing CDMA/CD, that is, detecting a clear line, initiating re-transmission if there's a jam signal, etc.  On the way in, the MAC sub-layer verifies the CRC/FCS and removes frame elements before passing the data up to the higher layers.  Basically, anything that some other MAC layer did to encapsulate the message for sending, the receiving MAC layer un-does on the way in.

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

Some executives are entitled to see anything and everything about the corporation.  An "executive" fabric would group all VLANs together, so that people admitted to that fabric can access the VLANs without having to be explicitly added to each one.  That's very handy in really large organisations, saving a lot of time and effort.

<a href="#heading--visualising-the-link-layer"><h4 id="heading--visualising-the-link-layer">Visualising the link layer</h4></a>

Let's start with a message coming on Layer 1 from SanDiego to Bangor. When the message comes in, the link layer does the following things:

1. It synchronises the NIC, so that bits will indeed be recognised as bits and the message can be properly decoded.

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

This subsection will help you learn:

 - [About packets](#heading--about-packets)
 - [About fixed packet lengths and segmented messaging](#heading--about-fixed-packet-lengths)
 - [About IP packets](#heading--about-ip-packets)
 - [About routing](#heading--about-routing)

The network layer does not guarantee delivery.  Essentially, it makes every effort to deliver IP datagrams (packets) to the destination, but it's error-handling is pretty simple: just toss the packet into the bit-bucket.

It's also a connectionless layer, meaning the packets making up a message aren't part of an ongoing conversation.  They can be split up, encoded, and sent separately, by different routes, and arrive completely out of order.  And packets can get duplicated or corrupted.  Figuring all this out is the job of the protocol stack (e.g., TCP) in layer 4.  The network layer, L3, just delivers packets.  

<details><summary>Network byte order</summary>

A rarely needed (but useful) fact is that the network sends bytes in big endian order.  That means bytes are transmitted starting with bit 0 and working down to bit 31, usually eight bits at a time.  A lot of the computers on the Internet use little endian encoding, which starts at the other end of the word.  In those cases, the byte order has to be reversed somewhere between the computer's memory and Layer 3.

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
 - **Total Length of IP Packet** This field indicates the length of the entire packet, including the data.  This makes it possible to calculate the byte offset of the data within the datagram.
 - **Identification**  This is a serial number, generated by the sending NIC, that helps the participants uniquely identify the datagram.  In a sense, it works like the little "take-a-number" tickets you get at the hamburger stand: Eventually, the number will repeat, but the repeat cycle is so long that there's no chance of confusing packets.  The sequential nature of this field, when used in concert with the Flags and Fragmentation Offset field, helps the protocol stack correctly reassemble the message.
 - **Flags**  This field is basically used to indicate that a packet is a fragment of a longer message.
 - **Fragmentation Offset**  Used with the Identification sequence number, this field allows the system to know which packets precede or follow this one when re-assembling the message.
 - **Time to Live (TTL)**  This indicates the number of routers that a datagram can pass through before it's discarded.  Since routers function by replacing their own destination address with the IP address of the next hop, this essentially limits the number of times a packet's destination IP can be changed.  Most RFC documents suggest keeping this number at 64, it's more often set to something like 255 without any real bottlenecks.
 - **Protocol** This field indicates the higher level protocol (the protocol stack) that generated this message.  Examples are given for TCP and UDP in the figure.
 - **Header Checksum** This calculates a checksum for the header only.  It's only used in IPv4.  Doing integrity-checking on the data is the responsibility of Layer 4.
 - **Source Address** This is the IP address of the sender of the packet, for this hop only.  As shown in the figure below, routers will change this address so they can get the answer back.
 - **Destination Address**  This is the IP address of the destination, for this hop only.  As shown below, routers change this address to act as brokers in the IP chain.

<a href="#heading--about-routing"><h4 id="heading--about-routing">About routing</h3></a>

We now have enough concepts in play to talk about routing.  Routing takes place at the network layer, by changing the source and destination addresses (without losing track of the replaced address).  The process looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/73c49cb76573e42036c59832f5f16b6383fbc0bd.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/73c49cb76573e42036c59832f5f16b6383fbc0bd.jpeg"></a>

The router typically assigns a unique port number to the outbound message, and records the source IP against that port number.  When the message comes back to it on that port number, it can look up the IP address of the NIC that sent the packet and route the answer back.

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

But that's not good enough for the air ambulance, for two reasons.  First, the survey maps are huge, complex, and hard to interpret, and they change somewhat as property is bought or sold.  Second, helicopter navigation is intentionally independent of political boundaries.  Instead, the air ambulance will use your latitude and longitude, which allows them to uniquely locate you on the earth.  Granted, the ambulance company has a tool somewhere that automatically does the math of translating your postal address to lat/long coordinates, but the principle holds.

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

<a href="#heading--messages-sent-to-mac-addresses"><h4 id="heading--messages-sent-to-mac-addresses">Messages are sent to MAC addresses</h4></a>

We often speak of TCP/IP as if messages are sent from one IP address to another, but that's actually not strictly true.  Messages are sent to MAC addresses.  IP addresses are only used to get MAC addresses, so the message can go through.

We can return to the air ambulance company to see a practical analogy.  A 911 call comes in for "20 Main Street, Yourtown, Yourstate, Yourpostalcode".  The address is sent to the pilot of the helicopter, who punches the address into his GPS.  The GPS uses the postal address to retrieve the lat/long coordinates, which are then used to guide the helicopter, via satellite navigation.

The same sort of thing happens when you use the GPS navigator in your car.  The navigator is translating a logical (postal) address to a physical (lat/long) address on the surface of the earth, calculating a route, and translating that route back to logical landmarks (street names) to let you know how to get there.

By the way, You should also note that ARP only works with IPv4.  Certain other protocols, like Point-to-Point Protocol (PPP), don't make use of ARP at all.

<a href="#heading--about-the-arp-frame"><h4 id="heading--about-the-arp-frame">About the ARP frame</h4></a>

ARP sends requests as an Ethernet frame, using the MAC address.  If you remember the MAC frame from earlier:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/14f6847ed92339061eb4515c12ac2b6117d5cd7c.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/14f6847ed92339061eb4515c12ac2b6117d5cd7c.jpeg"></a>

The ARP frame is just a special case of the MAC frame, replacing everything the DSAP, SSAP, control bits, and data with the ARP message shown above.  The resulting ARP frame looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f430da9c144bda4cf2e2901181988f3444d335f8.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f430da9c144bda4cf2e2901181988f3444d335f8.jpeg"></a>

Based on the above diagram, you can see how the ARP request fits into the Ethernet frame to make an ARP frame.

<a href="#heading--about-the-arp-cache"><h4 id="heading--about-the-arp-cache">About the ARP cache</h4></a>

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
 - **HWaddress**: the MAC address of the device.  The "incomplete" entires are meant to indicate that an ARP request was sent for that address, but no response was received.
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

<a href="#heading--more-about-arp"><h4 id="heading--more-about-arp">More about ARP</h4></a>

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

 - **SYN**: used for a three-way TCP handshake; this handshake is how sender and receiver sync up; it serves a purpose similar to the preamble in a MAC frame, but at a different level of synchronization.

 - **FIN**: we're done, close the connection.  This is considered a normal termination of a TCP connection.

 - **NS/CWR/ECE**: used to provide Explicit Congestion Notification; note that OSI provides several methods for endpoints to know that the network is congested.

<details><summary>TCP is like a phone call</summary>

As you can see from the bytes above, TCP is all about the state of a connection, which is basically the same as a phone call.  When you pick up the receiver, you and the caller exchange information.  You say "bye" when the call is over.  If it's a bad connection or one end suddenly gets noisy (think jack-hammers outside), one of you can reset the connection by saying, "Let me call you back in a minute."  Take a minute and try to see how the other header bytes fit this analogy.

Also like a telephone call, TCP provides a connection (the call, however long it lasts), flow control (provided by the two parties on the call), multiplexing (handled by the two handsets, basically letting through multiple frequencies and sounds, so that you can get the tone and breath sounds of the other person, not just their raw words).  Likewise, the two parties try to handle the reliability of the connection by making sure you understand each other.

The analogy spreads a little because some of the items (connection, multiplexing) are handled by the telephone, and some are handled by the people operating the telephone (flow control, reliability).  In the network, the Level 4 protocol stack handles it all.

</details>

There is a lot more to know about TCP, but most of it isn't directly relevant for MAAS networking.  Instead, we direct you to the excellent [Wikipedia article about TCP](https://en.wikipedia.org/wiki/Transmission_Control_Protocol).  Going forward, we'll only bring up specific transport layer elements as we need them.

<a href="#heading--about-dhcp"><h3 id="heading--about-dhcp">About DHCP</h3></a>

Next, we turn our attention to the Dynamic Host Control Protocol or DHCP.  Many issues with MAAS revolve around misunderstanding or unintentional misuse of DHCP, so it's worth it to take an in-depth look.  This section will help you learn:

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

<a href="#heading--about-dora"><h4 id="heading--about-dora">About DORA</h4></a>

The DHCP negotiation process is known as DORA: Discover, Offer, Request, Acknowledge. Just like the exchange above, it’s carried out by the network equivalent of shouting, that is, broadcast exchanges. While the payloads for the messages carry unique addressing information (after the first DISCOVER message), the Destination IP (DIP) is always 255.255.255.255 — broadcast mode. Every machine on the network will see the packet, but they will ignore it when they look at the payload.

By the way, there are several other possible responses at various points in the exchange, such as NACK (from the DHCP server, when the client has waited too long to make the request) and DECLINE (e.g., when the IP address configuration offered isn’t usable by the client).

The network version of the shouting match above looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8c1756c1f0a9309fa01f1f5ccc0573e33e436fa.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8c1756c1f0a9309fa01f1f5ccc0573e33e436fa.jpeg"></a>

Message 1 ("DISCOVER") is the only one that carries no destination info in its payload.  The
entire exchange takes place in broadcasts, rather than addressed packets. Said differently, the DIP (Destination IP address) is always 255.255.255.255, the broadcast address. The exchange becomes semi-private with the first OFFER, via the use of message payloads.

<a href="#heading--about-dhcp-traffic"><h4 id="heading--about-dhcp-traffic">About DHCP traffic</h4></a>

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

1. The DHCP server provides all the needed configuration parameters in both the OFFER and the ACK messages. Nothing is left out: the client receives an IP address, a subnet mask, a router location, the IPs of both DNS servers, the lease time limit, and the identity of the DHCP server. Nothing else is necessary for the requesting client to begin operating independently on the network.

2. The requesting client does not start using the offered IP address until it has received the ACK message. Note that in the DHCP Request, above, the SIP (Source IP) is still 0.0.0.0, even though the client knows the offered IP (it sends it back in the request to confirm).

With that very basic view of DHCP, we can now talk about how multiple DHCP servers and multiple requesting clients can keep things straight.

<a href="#heading--about-dhcp-standard-message-types"><h4 id="heading--about-dhcp-standard-message-types">About DHCP standard message types</h4></a>

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

<a href="#heading--about-dhcp-address-allocation"><h4 id="heading--about-dhcp-address-allocation">About DHCP address allocation</h4></a>

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

<a href="#heading--about-multiple-dhcp-servers-diff-ips"><h4 id="heading--about-multiple-dhcp-servers-diff-ips">About multiple DHCP servers serving different IP ranges</h4></a>

It’s possible to have more than one DHCP server on the same network segment and still have everything work right, with no conflicts and no dropped packets or IP requests. There are three possible scopes for IP ranges to consider:

 - **Adjacent scopes**: In this configuration, IP addresses are assigned from portions of the same subnet. For example, one server might control scope 192.168.14.2 – 192.168.14.187, and another server might manage scope 192.168.14.200 – 192.168.14.247. This is the most common (and most reliable) setup for multiple DHCP servers.

 - **Heterogeneous scopes**: This arrangement basically has DHCP servers on different subnets, such as 192.168.14.2 – .253 for one server, and 10.17.22.3 – .98 for the other. This can be made to work, but it’s extremely difficult to set up and not so easy to manage. 

 - **Overlapping scopes**: In this situation, more than one server can offer the same IP address. There is a way to make this work, by setting up the DHCP servers to talk to one another, but for most applications, this configuration can be avoided. 

Adjacent and heterogeneous scopes are really the same thing. The two servers do not work together; they may not ever be aware of one another. The servers and clients operate independently on a first-come, first-served basis, serving from their specific pool of IP addresses.

A client makes a DHCPRequest. One or both of the servers may answer, depending on load and spare IP addresses. It’s also possible that neither will answer, because they’re both out of IP addresses, but with good network planning — and making one of those servers authoritative — those situations will be kept to a minimum or eliminated entirely.

<a href="#heading--about-multiple-dhcp-servers-overlapping-ranges"><h4 id="heading--about-multiple-dhcp-servers-overlapping-ranges">About multiple DHCP servers serving overlapping IP ranges</h4></a>

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

<a href="#heading--about-dhcp-relays"><h4 id="heading--about-dhcp-relays">About DHCP relays</h4></a>

A DHCP relay is really just a specialised router.  Like all routers, it replaces source and destination addresses of packets crossing its domain so that every server gets the intended messages.  

The only substantial difference is that the DHCP relay knows the IP address of the DHCP server.  When a DHCPRequest reaches the relay from a requesting server, for example, the relay absorbs the broadcast packet and creates a routed unicast packet, bound directly for the DHCP server.  On the way back, the relay converts the DHCPOffer back to a broadcast packet.

<a href="#heading--about-cloud-networks"><h2 id="heading--about-cloud-networks">About cloud networks</h2></a>

Cloud network architectures deviate significantly from the architecture of the Internet infrastructure.  These deviations are driven mostly by economics, simplicity, and scalability.  This section will help you learn:

 - [About the Clos architecture](#heading--clos-architecture)
 - [About STP](#heading--about-stp)


<a href="#heading--clos-architecture"><h3 id="heading--clos-architecture">About the Clos architecture</h3></a>

You [may remember](#heading--internet-infrastructure) that the Internet infrastructure is riddled with side-channels to improve various measures, such as cost and throughput.  Earlier, we saw a fairly pessimistic picture of this infrastructure which helps to explain the variability:

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

<a href="#heading--about-stp"><h3 id="heading--about-stp">About STP</h3></a>

Some switches use the Spanning-Tree Protocol (STP) to negotiate a loop-free path through a root bridge. While scanning, it can cause each port to wait up to 50 seconds before sending data. This delay, in turn, can cause problems with some applications/protocols such as PXE, DHCP and DNS, of which MAAS makes extensive use.

To alleviate this problem, you should enable the [Rapid Spanning Tree Protocol](https://en.wikipedia.org/wiki/Spanning_Tree_Protocol) (known as [Portfast](https://www.cisco.com/c/en/us/td/docs/switches/lan/catalyst4000/8-2glx/configuration/guide/stp_enha.html#wp1019873) for Cisco switches), which allows the ports to come up almost immediately.

<a href="#heading--about-maas-networks"><h2 id="heading--about-maas-networks">About MAAS networks</h2></a>

There are elements of MAAS networking that are unique to the product.  This section will help you learn:

 - [About network discovery](#heading--about-network-discovery)
 - [About subnet management](#heading--about-subnet-management)
 - [About IPv6](#heading--about-ipv6)
 - [About availability zones](#heading--about-availability-zones)

<a href="#heading--about-network-discovery"><h3 id="heading--about-network-discovery">About network discovery</h3></a>

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli 
MAAS constantly listens to the network and reports any discovered devices. Devices are identified when the rack controller observes them communicating on an attached IPv4 subnet. Discovered devices that do not correspond to machines and devices already known to MAAS can be listed via the CLI. If a device advertises a hostname using `mDNS` (such as with `avahi` or `Bonjour`), MAAS will also present the discovered hostname when listing devices.

An unknown discovered device can be added to MAAS as a device, or as a network interface belonging to a machine or device. You can specify values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Indicating a Parent device is optional.
rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui /snap/3.1/ui /deb/3.1/ui 
MAAS constantly listens to the network and reports any discovered devices. Devices are identified when the rack controller observes them communicating on an attached IPv4 subnet. Discovered devices that do not correspond to machines and devices already known to MAAS are shown on the dashboard. If a device advertises a hostname using `mDNS` (such as with `avahi` or `Bonjour`), MAAS will also present the discovered hostname in the Dashboard.

Using the Dashboard, an unknown discovered device can be added to MAAS as a device or as a network interface belonging to a machine or device. Clicking the down arrow to the right of a new device allows values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Selecting a Parent device is optional.
rad-end

<a href="#heading--about-subnet-management"><h3 id="heading--about-subnet-management">About subnet management</h3></a>

Fabrics, VLANs, and spaces do not require much configuration beyond names and descriptions. You can change the MTU for a VLAN, as well as [enable DHCP](/t/how-to-manage-dhcp/nnnn#heading--enabling-dhcp).  None of these options requires detailed instruction.

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

See [Concepts and terms](/t/maas-concepts-and-terms-reference/nnnn#heading--ip-ranges) for an explanation of the two kinds of reserved IP ranges MAAS uses.

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

You can access the Web UI and the [MAAS CLI](/t/how-to-use-the-maas-cli/nnnn) (that is, logging in to the API server) in the same way on both IPv4 and IPv6. To use an IPv6 address in a URL, surround it with square brackets. For example, on the local machine (`::1`, the IPv6 equivalent of `localhost`):

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


