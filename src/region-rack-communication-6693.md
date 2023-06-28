<!-- Region rack communication -->

MAAS communication happens in a strict hierarchy, flowing from the UI/API through the region controller, to the rack controller, to the machines (and back).  While [high availability](/t/how-to-enable-high-availability/5120) (HA) may add controllers, it does not change the flow of communication through the MAAS system.  Understanding this message flow may help you with the machine topics which follow.

<a href="#heading--machinerack"><h2id="heading--machinerack">How machines communicate with the rack controller</h2></a>

All machine communication with MAAS is proxied through rack controllers, including HTTP metadata, DNS, syslog and APT (cache-and-forward proxies via Squid). 

MAAS creates an internal DNS domain, not manageable by the user, and a unique DNS resource for each subnet that is managed by MAAS. Each subnet includes all rack controllers that have an IP on that subnet. Booting machines use the subnet DNS resource to resolve the rack controller available for communication. If multiple rack controllers belong to the same subnet, MAAS uses a round-robin algorithm to balance the load across numerous rack controllers. This arrangement ensures that machines always have a rack controller.

Machines use this internal domain for HTTP metadata queries, APT (proxying via Squid), and Syslog. DNS queries, PXE booting, and NTP polls use IP addresses.

The rack controller installs and configures `bind` as a forwarder. All machines communicate via the rack controller directly.

[note]
Zone management and maintenance still happen within the region controller.
[/note]

<a href="https://discourse.maas.io/uploads/default/original/1X/02a7ca58b989c67c74421b9d5e0c8b32907a2de1.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/02a7ca58b989c67c74421b9d5e0c8b32907a2de1.jpeg"></a>

<a href="#heading--rackregion"><h2 id="heading--rackregion">How region and rack controllers communicate</h2></a>

The MAAS region and rack controllers interact in a number of different ways, depending upon the operation you've requested.  Consider the process of commissioning a machine, that is, taking over the machine and gathering information on its available resources, including CPU, RAM, storage, and MIB information (obtainable via LLDP requests).  Here's a rough idea of what that sequence looks like -- a sequence that is representative of the communication between rack and region controllers:

1. An operator makes a request of MAAS, either via the Web UI or the API.  
2. MAAS translates this to an API request to the region controller.
3. The region controller locates the rack controller that has BMC access to the machine in question, that is, the rack controller that can power on that machine.
4. That same rack controller powers on the machine via IPMI request.
5. The rack controller tasked with providing DHCP handles assigning an IP address to the machine via the [DORA](/t/maas-glossary/5416#heading--dhcp) sequence (Discover, Offer, Request, Acknowledge).  **Note** that this rack controller doesn't have to be the same one that powers on the machine.
6. The DHCP-managing rack controller inserts itself as the DHCP "next-server" and requests a network boot.
7. (Still) the same rack controller RPCs the region controller to get what's needed to boot an ephemeral Ubuntu kernel, namely the kernel, any kernel parameters, an initrd daemon, and a squashfs load.
8. That same rack controller transforms the RPC response from the region controller into a valid PXE config and tells the machine to come get its files.
9. The booting machine loads the kernel and initrd, boots with that initrd, and then loads the squashfs, eventually making its way up to an ephemeral Ubuntu instance.
10. The booted machine pulls cloud-init metadata from the region controller, proxying through the rackd.
11. cloud-init uses this metadata to gather resource information about the machine and pass it back to the region controller, again proxied by the rackd.
12. The region controller (regiond or "region daemon") stores this machine information in a postgres database that is accessible only to the regiond, making MAAS truly stateless with respect to machines.

Again, this list doesn't represent every interaction between the controllers and machines, but it gives you a good idea of how MAAS works.

