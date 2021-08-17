<a href="#heading--about-bond-and-bridge-interfaces"><h2 id="heading--about-bond-and-bridge-interfaces">About bond and bridge interfaces</h2></a>

A bond interface is used to aggregate two or more physical interfaces into a single logical interface. Combining multiple network connections in parallel can increase network throughput beyond what a single NIC will allow.  It also provides some redundancy in case one of the NICs should fail.  More information about the theory behind bonded NICs is found in the [relevant IEEE standard](https://1.ieee802.org/tsn/802-1ax-rev/).

A network bridge may be useful if you intend to use virtual machines or containers with MAAS. 

<a href="#heading--about-network-discovery"><h2 id="heading--about-network-discovery">About network discovery</h2></a>

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
MAAS constantly listens to the network and reports any discovered devices. Devices are identified when the rack controller observes them communicating on an attached IPv4 subnet. Discovered devices that do not correspond to machines and devices already known to MAAS are shown on the dashboard. If a device advertises a hostname using `mDNS` (such as with `avahi` or `Bonjour`), MAAS will also present the discovered hostname when listing devices..

An unknown discovered device can be added to MAAS as a device or as a network interface belonging to a machine or device. Clicking the down arrow to the right of a new device allows values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Selecting a Parent device is optional.

To enable network discovery, enter the following at the command line:

```
maas admin maas set-config name=network_discovery value="enabled"
```

Network discovery can be disabled or re-enabled at any time with this CLI command.
rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
MAAS constantly listens to the network and reports any discovered devices. Devices are identified when the rack controller observes them communicating on an attached IPv4 subnet. Discovered devices that do not correspond to machines and devices already known to MAAS are shown on the dashboard. If a device advertises a hostname using `mDNS` (such as with `avahi` or `Bonjour`), MAAS will also present the discovered hostname in the Dashboard.

Using the Dashboard, an unknown discovered device can be added to MAAS as a device or as a network interface belonging to a machine or device. Clicking the down arrow to the right of a new device allows values such as 'Type', 'Domain', 'IP Assignment' and 'Parent' to be changed prior to the device being added. Selecting a Parent device is optional.

Network discovery can be disabled or re-enabled using the switch on the Network discovery dashboard.

<a href="https://assets.ubuntu.com/v1/1782e4aa-installconfig-networking__2.4_discovery.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/1782e4aa-installconfig-networking__2.4_discovery.png"></a>

rad-end

<a href="#heading--about-subnet-management"><h2 id="heading--about-subnet-management">About subnet management</h2></a>

The topic of subnet management pertains to whether or not MAAS is in full control of a subnet. When a subnet is managed, MAAS handles all aspects of IP address allocation. This process includes DHCP leases and assigned static addresses. Typically MAAS would have one managed subnet, but any additional subnets can be unmanaged. This arrangement allows for more control over which subnet gets used for DHCP and which ones do not. Additionally, as detailed below, an unmanaged subnet treats reserved IP ranges differently, and in a way that some administrators find more intuitive.

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
#### Seven questions you may have:

1. [What are managed subnets?](#heading--managed-subnets)
2. [What are unmanaged subnets?](#heading--unmanaged-subnets)
3. [What is IP address tracking?](#heading--ip-address-tracking)
4. [How do I control subnet management](#heading--controlling-subnet-management)
5. [How do I determine a fabric ID to use in other CLI subnet calls?](#heading--determine-fabric-id)
6. [How do I set a default gateway with the CLI?](#heading--default-gateway)
7. [How do i set the DNS server with the CLI?](#heading--set-dns-server)
rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
#### Four questions you may have:

1. [What are managed subnets?](#heading--managed-subnets)
2. [What are unmanaged subnets?](#heading--unmanaged-subnets)
3. [What is IP address tracking?](#heading--ip-address-tracking)
4. [How do I control subnet management](#heading--controlling-subnet-management)
rad-end

<a href="#heading--managed-subnets"><h3 id="heading--managed-subnets">Managed subnets</h3></a>

When you enable management for a subnet, MAAS will:

1.   Lease addresses for DHCP from a reserved dynamic IP range
2.   Assign static addresses not included in a reserved IP range, typically via 'Auto assign' IP allocation mode for a node.

See [Concepts and terms](/t/concepts-and-terms/785#heading--ip-ranges) for an explanation of the two kinds of reserved IP ranges MAAS uses and [Post-commission configuration](/t/commission-machines/nnnn#heading--post-commission-configuration) for information on IP allocation modes.

<a href="#heading--unmanaged-subnets"><h3 id="heading--unmanaged-subnets">Unmanaged subnets</h3></a>

When management is disabled for a subnet, the definition of a reserved IP range differs from the managed mode. Here, a reserved IP range tells MAAS to **only allocate addresses from this range** (via 'Auto assign'). Also, DHCP will never lease addresses from an unmanaged subnet.

<a href="#heading--controlling-subnet-management"><h3 id="heading--controlling-subnet-management">Controlling subnet management</h3></a>

By default, MAAS manages subnets in your configuration, but it is easy to change this.

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
To disable (or re-enable) subnet management navigate to the 'Subnets' page and select the subnet. Press the 'Edit' button to allow changes. The 'Managed allocation' field will become a slide switch. Click the label (or the switch icon itself) to toggle between enabled (dark blue) and disabled (grey) and click 'Save summary'.

<a href="https://assets.ubuntu.com/v1/e5d80c8c-installconfig-network-subnet-management__2.6-management-toggle.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/e5d80c8c-installconfig-network-subnet-management__2.6-management-toggle.png"></a>
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 

To enable or disable subnet management:

``` bash
maas $PROFILE subnet update $SUBNET_CIDR managed=false|true
```

For example, to disable:

``` bash
maas $PROFILE subnet update 192.168.1.0/24 managed=false
```

You can use the subnet's ID in place of the CIDR address.
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli
<a href="#heading--determine-fabric-id"><h3 id="heading--determine-fabric-id">Determine fabric ID</h3></a>

To determine a fabric ID based on a subnet address:

```
FABRIC_ID=$(maas $PROFILE subnet read $SUBNET_CIDR \
    | grep fabric | cut -d ' ' -f 10 | cut -d '"' -f 2)
```

This may come in handy when you need a fabric ID for other CLI calls.

<a href="#heading--default-gateway"><h3 id="heading--default-gateway">Set a default gateway</h3></a>

To set the default gateway for a subnet:

```
maas $PROFILE subnet update $SUBNET_CIDR gateway_ip=$MY_GATEWAY
```

<a href="#heading--set-dns-server"><h3 id="heading--set-dns-server">Set a DNS server</h3></a>

To set the DNS server for a subnet:

```
maas $PROFILE subnet update $SUBNET_CIDR dns_servers=$MY_NAMESERVER
```

rad-end

<a href="#heading--ip-address-tracking"><h3 id="heading--ip-address-tracking">IP address tracking</h3></a>

MAAS will keep track of all assigned addresses, regardless of whether they come from managed or unmanaged subnets.

<a href="#heading--how-to-manage-networking"><h2 id="heading--how-to-manage-networking">How to manage networking</h2></a>

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli
You can use the CLI to manage the networking elements of MAAS, including subnets, fabrics, VLANs, and spaces.  This page shows how to access and edit these elements. See [Concepts and terms](/t/concepts-and-terms/785) for the definitions of networking objects, along with a basic networking tutorial.

This document will show you:

1. [How to list available subnets](#heading--cli-list-available-subnets)
2. [How to manage subnets](#heading--cli-managing-subnets)
3. [How to manage static routes](#heading--static-routes)
4. [How to manage reserved ranges](#heading--reserved-ranges)
5. [How to set up a bridge](#heading--setting-up-a-bridge)
6. [How to set up a bridge with the MAAS CLI/API](#heading--maas-bridge-cli)
7. [How to set up a bridge with netplan](#heading--maas-bridge-netplan)

<a href="#heading--cli-list-available-subnets"><h2 id="heading--cli-list-available-subnets">How to list available subnets</h2></a>

To view the list of available subnets, enter the following command:

```
maas admin subnets read | \
jq -r '(["FABRIC", "VLAN", "DHCP", "SUBNET"]
| (., map(length*"-"))),
(.[] | [.vlan.fabric, .vlan.name, .vlan.dhcp_on, .cidr])
| @tsv' \
| column -t
```

which produces output something like this:

```
FABRIC        VLAN      DHCP       SUBNET
------        ----      ---------  ------
Patient-Care  untagged  true       192.168.123.0/24
fabric-0      untagged  false      0.0.0.0/0
fabric-0      untagged  false      10.0.0.0/24
fabric-1      untagged  false      10.70.132.0/24
fabric-1      untagged  false      fd42:8b52:7114:9ef8::/64
fabric-3      untagged  true       192.168.43.0/24
fabric-3      untagged  true       2600:100d:b125:d5e9::/64
fabric-3      untagged  true       2600:100d:b120:3933::/64
fabric-3      untagged  true       2600:100d:b109:dee0::/64
fabric-3      untagged  true       2600:100d:b104:94c0::/64
```
rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /deb/3.0/ui /snap/3.0/ui
You can use the Web UI to manage the networking elements of MAAS, including subnets, fabrics, VLANs, and spaces.  This page shows how to access and edit these elements. See [Concepts and terms](/t/concepts-and-terms/785) for the definitions of networking objects, along with a basic networking tutorial (if needed).

This document will show you:

1. [How to access the main networking view](#heading--ui-main-view)
2. [How to view the subnet window](#heading--ui-subnet-window)
3. [How to view the subnet summary](#heading--ui-subnet-summary)
4. [How to view utilisation](#heading--ui-utilisation)
5. [How to manage static routes](#heading--static-routes)
6. [How to manage reserved ranges](#heading--reserved-ranges)
7. [How to view used addresses](#heading--ui-used-addresses)
8. [How to set up a bridge](#heading--setting-up-a-bridge)
9. [How to set up a bridge with the web UI](#heading--maas-bridge-web-ui)
10. [How to set up a bridge with netplan](#heading--maas-bridge-netplan)

<a href="#heading--ui-main-view"><h2 id="heading--ui-main-view">How to access the main networking view</h2></a>

To access the main networking view visit the 'Subnets' page:

<a href="https://assets.ubuntu.com/v1/657bb332-installconfig-networking__2.4_subnets.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/657bb332-installconfig-networking__2.4_subnets.png"></a>

Due to the nature of this example, we re-use elements like fabrics, VLANs, subnets, and spaces.  MAAS can automatically detect these elements -- here there are two fabrics, one VLAN, five subnets, and two spaces -- but if MAAS doesn't find them, they can be added manually using the 'Add' button.

This main view can also be filtered either by fabrics or by spaces through the use of the 'Group by' drop-down.
rad-end

Fabrics, VLANs, and spaces do not require much configuration beyond names and descriptions. You can change the MTU for a VLAN, as well as [enable DHCP](/t/managing-dhcp/nnnn#heading--enabling-dhcp) (see 'Take action' button).  None of these options requires detailed instruction. A subnet, on the other hand, provides a number of configuration options relevant to the day-to-day operation of MAAS.

rad-begin   /snap/2.9/cli   /deb/2.9/cli /deb/3.0/cli /snap/3.0/cli
<a href="#heading--cli-managing-subnets"><h2 id="heading--cli-managing-subnets">How to manage subnets</h3></a>

You can view the details of an individual subnet with the command:

```
maas $PROFILE subnet read $SUBNET_ID \
| jq -r '(["NAME","CIDR","GATEWAY","DNS","DISCOVERY","FABRIC","VLAN"]
| (., map(length*"-"))), ([.name,.cidr,.gateway_ip // "-", .allow_dns,.active_discovery,.vlan.name,.vlan.fabric]) | @tsv' | column -t
```

This command retrieves output similar to this:

```
NAME              CIDR              GATEWAY  DNS   DISCOVERY  FABRIC    VLAN
----              ----              -------  ---   ---------  ------    ----
192.168.123.0/24  192.168.123.0/24  -        true  false      untagged  default
```

If you don't know the subnet ID, you can look it up like this:

```
maas $PROFILE subnets read \
| jq -r '(["NAME", "SUBNET_ID"]
| (., map(length*"-"))), (.[] | [.name, .id]) | @tsv' \
| column -t | grep $SUBNET_NAME
```

For example, if you're using the "admin" profile, and your subnet name contains "192.168.123," you could find the subnet ID with this command:

```
maas admin subnets read \
| jq -r '(["NAME", "SUBNET_ID"]
| (., map(length*"-"))), (.[] | [.name, .id]) | @tsv' \
| column -t | grep 192.168.123
```

Subnets support the following configurable values:
rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
<a href="#heading--ui-subnet-window"><h2 id="heading--ui-subnet-window">How to display the subnet window</h3></a>

Clicking a subnet (here `192.168.100.0/24`) will display its detail screen, which presents several vertical sections.  Let's take them one by one.

<a href="#heading--ui-subnet-summary"><h3 id="heading--ui-subnet-summary">How to view the subnet summary</h3></a>

The **Subnet summary** section is the largest and most complex of the subnet configuration screens:

<a href="https://assets.ubuntu.com/v1/17617b35-installconfig-networking__2.4_subnets-summary.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/17617b35-installconfig-networking__2.4_subnets-summary.png"></a>

This screen presents the following configurable options:
rad-end

* **Name**: Subnet names can be any valid text string, although usually, and by default, they are named with the CIDR of the subnet itself.

* **CIDR**: This is the address parameter for the subnet.  In keeping with standard CIDR notation, the number of bits of the prefix are indicated after the slash.

* **Gateway IP**: This is the address of the default gateway for your subnet, which is the IP address that transfers packets to other subnets or networks. Typically, this is simply the first IP address in a block of addresses (the `.1` address).

* **DNS**: This is the address of a DNS (domain name server, or simply "nameserver") for your subnet.  It's optional, but can be configured if desired.

* **Description**: This field represents freeform text that you can enter to describe your subnet, as needed to keep important notes attached to the definition of the subnet.

* **Managed allocation** refers to the ability of MAAS to completely manage a subnet. See [Subnet management](/t/subnet-management/nnnn).

* **Active mapping** instructs MAAS to scan the subnet every 3 hours to discover hosts that have not been discovered passively.

* **Proxy access** instructs MAAS to allow clients from this subnet to access the MAAS proxy.

* **Allow DNS resolution** allows subnet clients to use MAAS for DNS resolution.

* **Fabric**: This field allows you to set the subnet's fabric.

* **VLAN**: This field allows you to set the subnet's VLAN.

* **Space** is presented for clarity, though spaces are managed at the VLAN level.

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
<a href="#heading--ui-utilisation"><h3 id="heading--ui-utilisation">How to view utilisation</h3></a>

This section of the subnet page presents metrics regarding address usage by this subnet.

<a href="https://assets.ubuntu.com/v1/3d3e4b61-installconfig-networking__2.4_subnets-utilisation.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/3d3e4b61-installconfig-networking__2.4_subnets-utilisation.png"></a>

'Subnet addresses' shows the total number of addresses associated with the subnet, here 254. 'Availability' shows how many of those addresses are unused, and therefore "available", here 189, which corresponds to a percentage of roughly 74% of the total. Finally, 'Used' shows the percentage that is used, here roughly 26%.
rad-end 

<a href="#heading--static-routes"><h2 id="heading--static-routes">How to manage static routes</h2></a>

This section can be used to define a static route between two subnets. A route is defined on a per-subnet basis to use a particular gateway, using a configured destination and metric.

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli
To create a static route, use the following command:

```
maas admin static-routes create source=$SOURCE_SUBNET destination=$DEST_SUBNET \
gateway_ip=$GATEWAY_IP
```
rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
To create a static route, click the 'Add static route' button to reveal the edit pane. Enter a Gateway IP address, select a destination subnet from the 'Destination' drop-down list, and edit the routing metric value if needed. Clicking 'Add' will activate the route. Routes can be edited and removed using the icons to the right of each entry.

<a href="https://assets.ubuntu.com/v1/49f5e240-installconfig-networking__2.4_subnets-routes.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/49f5e240-installconfig-networking__2.4_subnets-routes.png"></a>
rad-end

<a href="#heading--reserved-ranges"><h2 id="heading--reserved-ranges">How to manage reserved ranges</h2></a>

rad-begin   /snap/2.9/ui   /deb/2.9/ui /deb/3.0/ui /snap/3.0/ui
The reserved ranges section of the subnet screen looks like this:

<a href="https://assets.ubuntu.com/v1/5f9f50f9-installconfig-networking__2.4_subnets-reserved.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/5f9f50f9-installconfig-networking__2.4_subnets-reserved.png"></a>
rad-end

This subject is treated separately in [IP ranges](/t/ip-ranges/nnnn).

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
<a href="#heading--ui-used-addresses"><h2 id="heading--ui-used-addresses">How to view used IP addresses</h2></a>

This section displays hosts (including controllers) associated with the used addresses along with related bits of host information.

<a href="https://assets.ubuntu.com/v1/b9e69b0b-installconfig-networking__2.4_subnets-used.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/b9e69b0b-installconfig-networking__2.4_subnets-used.png"></a>
rad-end

<a href="#heading--setting-up-a-bridge"><h2 id="heading--setting-up-a-bridge">How to set up a bridge</h2></a>

At various times in your MAAS network, you may need to set up a bridge to connect between your machines and MAAS.  This section explains several ways of accomplishing this.

[note]
It's essential to enforce usage of IP addresses to avoid domain name conflicts, should different controllers resolve the same domain name with different IP addresses. You should also avoid using 127.0.0.1 when running multiple controllers, as it would confuse MAAS.
[/note]

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
<a href="#heading--maas-bridge-web-ui"><h2 id="heading--maas-bridge-web-ui">How to set up a bridge with MAAS UI</h2></a>

You can use the MAAS UI to configure a bridge. Select the machine you want to bridge and switch to the "Network" tab. Select the network where you want to create the bridge and click "Create bridge:"

<a href="https://discourse.maas.io/uploads/default/original/1X/29624d737106c5bad777aee9d2c8cad9c3de7151.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/29624d737106c5bad777aee9d2c8cad9c3de7151.jpeg"></a> 

Configure the bridge on a subnet MAAS controls.  You may use any IP mode for the bridge:

<a href="https://discourse.maas.io/uploads/default/original/1X/dd8567ff1cd76606c5ce1751e606fcfab2bc7ce2.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/dd8567ff1cd76606c5ce1751e606fcfab2bc7ce2.jpeg"></a> 

When you're done, it should look something like this:

<a href="https://discourse.maas.io/uploads/default/original/1X/e392d638f0acecb9d54c81bbca4ee17cbcd05445.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e392d638f0acecb9d54c81bbca4ee17cbcd05445.jpeg"></a> 

Then you can deploy using the bridge.

rad-end

rad-begin /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
**NOTE** that you can create an "OpenVswitch" bridge if desired, and MAAS will create the netplan model for you.
rad-end 

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli
<a href="#heading--maas-bridge-cli"><h2 id="heading--maas-bridge-cli">How to use the MAAS API to configure a bridge</h2></a>

You can use the MAAS CLI/API to configure a bridge, with the following procedure:

1. Select the interface you wish to configure the bridge on. This example uses the boot interface, since the boot interface must be connected to a MAAS controlled network -- but any interface is allowed:

        INTERFACE_ID=$(maas $PROFILE machine read $SYSTEM_ID | jq .boot_interface.id)

2. Create the bridge:

         BRIDGE_ID=$(maas $PROFILE interfaces create-bridge $SYSTEM_ID name=br0 parent=$INTERFACE_ID | jq .id)

3. Select the subnet where you want the bridge (this should be a MAAS controlled subnet):

        SUBNET_ID=$(maas $PROFILE subnets read | jq -r '.[] | select(.cidr == "10.0.0.0/24" and .managed == true).id')

4. Connect the bridge to the subnet:

          maas $PROFILE interface link-subnet $SYSTEM_ID $BRIDGE_ID subnet=$SUBNET_ID mode="STATIC" ip_address="10.0.0.101"

rad-end

<a href="#heading--maas-bridge-netplan"><h2 id="heading--maas-bridge-netplan">How to use netplan to configure a bridge</h2></a>

You can also use netplan to configure a bridge:

Open your netplan configuration file.  This should be in `/etc/netplan`.  It could be called `50-cloud-init.yaml`, `netplan.yaml`, or something else.  Modify the file to add a bridge, using the example below to guide you:

```
network:
    bridges:
        br0:
            addresses:
            - 10.0.0.101/24
            gateway4: 10.0.0.1
            interfaces:
            - enp1s0
            macaddress: 52:54:00:39:9d:f9
            mtu: 1500
            nameservers:
                addresses:
                - 10.0.0.2
                search:
                - maas
            parameters:
                forward-delay: 15
                stp: false
    ethernets:
        enp1s0:
            match:
                macaddress: 52:54:00:39:9d:f9
            mtu: 1500
            set-name: enp1s0
        enp2s0:
            match:
                macaddress: 52:54:00:df:87:ac
            mtu: 1500
            set-name: enp2s0
        enp3s0:
            match:
                macaddress: 52:54:00:a7:ac:46
            mtu: 1500
            set-name: enp3s0
    version: 2
```

Apply the new configuration with `netplan apply`.
