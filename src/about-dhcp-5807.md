<!-- "It is always DHCP" -->
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

<a href="#heading--about-dora"><h2 id="heading--about-dora">About DORA</h2></a>

The DHCP negotiation process is known as DORA: Discover, Offer, Request, Acknowledge. Just like the exchange above, it’s carried out by the network equivalent of shouting, that is, broadcast exchanges. While the payloads for the messages carry unique addressing information (after the first DISCOVER message), the Destination IP (DIP) is always 255.255.255.255 — broadcast mode. Every machine on the network will see the packet, but they will ignore it when they look at the payload.

By the way, there are several other possible responses at various points in the exchange, such as NACK (from the DHCP server, when the client has waited too long to make the request) and DECLINE (e.g., when the IP address configuration offered isn’t usable by the client).

The network version of the shouting match above looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8c1756c1f0a9309fa01f1f5ccc0573e33e436fa.jpeg" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8c1756c1f0a9309fa01f1f5ccc0573e33e436fa.jpeg"></a>

Message 1 ("DISCOVER") is the only one that carries no destination info in its payload.  The
entire exchange takes place in broadcasts, rather than addressed packets. Said differently, the DIP (Destination IP address) is always 255.255.255.255, the broadcast address. The exchange becomes semi-private with the first OFFER, via the use of message payloads.

<a href="#heading--about-dhcp-traffic"><h2 id="heading--about-dhcp-traffic">About DHCP traffic</h2></a>

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

<a href="#heading--about-dhcp-standard-message-types"><h2 id="heading--about-dhcp-standard-message-types">About DHCP standard message types</h2></a>

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

<a href="#heading--about-dhcp-address-allocation"><h2 id="heading--about-dhcp-address-allocation">About DHCP address allocation</h2></a>

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

<a href="#heading--about-multiple-dhcp-servers-diff-ips"><h2 id="heading--about-multiple-dhcp-servers-diff-ips">About multiple DHCP servers serving different IP ranges</h2></a>

It’s possible to have more than one DHCP server on the same network segment and still have everything work right, with no conflicts and no dropped packets or IP requests. There are three possible scopes for IP ranges to consider:

- **Adjacent scopes**: In this configuration, IP addresses are assigned from portions of the same subnet. For example, one server might control scope 192.168.14.2 – 192.168.14.187, and another server might manage scope 192.168.14.200 – 192.168.14.247. This is the most common (and most reliable) setup for multiple DHCP servers.

- **Heterogeneous scopes**: This arrangement basically has DHCP servers on different subnets, such as 192.168.14.2 – .253 for one server, and 10.17.22.3 – .98 for the other. This can be made to work, but it’s extremely difficult to set up and not so easy to manage. 

- **Overlapping scopes**: In this situation, more than one server can offer the same IP address. There is a way to make this work, by setting up the DHCP servers to talk to one another, but for most applications, this configuration can be avoided. 

Adjacent and heterogeneous scopes are really the same thing. The two servers do not work together; they may not ever be aware of one another. The servers and clients operate independently on a first-come, first-served basis, serving from their specific pool of IP addresses.

A client makes a DHCPRequest. One or both of the servers may answer, depending on load and spare IP addresses. It’s also possible that neither will answer, because they’re both out of IP addresses, but with good network planning — and making one of those servers authoritative — those situations will be kept to a minimum or eliminated entirely.

<a href="#heading--about-multiple-dhcp-servers-overlapping-ranges"><h2 id="heading--about-multiple-dhcp-servers-overlapping-ranges">About multiple DHCP servers serving overlapping IP ranges</h2></a>

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

<a href="#heading--about-dhcp-relays"><h2 id="heading--about-dhcp-relays">About DHCP relays</h2></a>

A DHCP relay is really just a specialised router.  Like all routers, it replaces source and destination addresses of packets crossing its domain so that every server gets the intended messages.  

The only substantial difference is that the DHCP relay knows the IP address of the DHCP server.  When a DHCPRequest reaches the relay from a requesting server, for example, the relay absorbs the broadcast packet and creates a routed unicast packet, bound directly for the DHCP server.  On the way back, the relay converts the DHCPOffer back to a broadcast packet.