<!-- "How to manage networking" --> 
Networking is at the very heart of MAAS, and getting it right is essential for smooth operations. Here are some key steps to take:

- [Connect MAAS networks](/t/how-to-connect-maas-networks/5164): First things first -- connect those MAAS networks. You'll need to set up connections between MAAS nodes and controllers so they can communicate. Without this, you're going nowhere fast.  In most cases, you may find it useful to [bone up on MAAS networking essentials](/t/maas-networks/5084) before you start this step.

- [Enable DHCP](/t/how-to-enable-dhcp/5132): Next up, DHCP. It's absolutely critical to get your DHCP setup right if you want MAAS to discover your machines. Without this, your machines are just shouting into the void, with no place to get an IP address and nowhere to get a Network Boot Program (NBP).  Hint: DHCP problems cause more MAAS issues than just about anything else, so if you have any gray areas of understanding, it wouldn't hurt to [check out our DHCP primer](/t/it-is-always-dhcp/6682), appropriately titled, "It is always DHCP" (when it's not DNS, that is).

- [Manage availability zones](/t/how-to-use-availability-zones/5152): And don't forget to consider availability zones. MAAS lets you allocate machines to different zones to ensure fault-tolerance.  If you're running critical applications, like music streaming or disaster recovery, AZs can save you a lot of time and headaches.

If you inherited a MAAS installation and you're relatively new to networking, or you fell into managing one by default, we've got you covered.  You can catch up on [TCP/IP](/t/tcp-ip/6683) and [cloud networking](/t/cloud-networking/6684) -- on us.