<!-- "How to connect MAAS networks" -->
You can easily manage the basic networking elements of MAAS, including subnets, fabrics, VLANs, spaces, IP ranges, machine interfaces, and proxies.  This section shows how to access and edit these elements. 

This article will help you learn:

- [How to manage MAAS network elements](#heading--how-to-manage-MAAS-network-elements)
- [How to manage machine interfaces](#heading--how-to-manage-machine-interfaces)
- [How to manage proxies](#heading--how-to-manage-proxies)
- [How to set up Network Time Protocol (NTP)](#heading--how-to-set-up-ntp)

If you find you need some background information on MAAS networks, or even networking in general, you can consult the of [How MAAS networks](/t/how-to-set-up-networks/6174#heading--How-MAAS-networks) before diving in here.

<a href="#heading--how-to-manage-MAAS-network-elements"><h2 id="heading--how-to-manage-MAAS-network-elements">How to manage MAAS network elements</h2></a>

This section will show you:

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
- [How to enable network discovery](#heading--how-to-enable-network-discovery)
- [How to toggle subnet management](#heading--how-to-toggle-subnet-management)
- [How to access the main networking view](#heading--how-to-access-ui-main-networking-view)
- [How to display the subnet window](#heading--ui-how-to-display-the-subnet-window)
- [How to view the subnet summary](#heading--ui-how-to-view-the-subnet-summary)
- [How to view utilisation](#heading--ui-how-to-view-utilisation)
- [How to manage static routes between subnets](#heading--how-to-manage-static-routes)
- [How to view reserved ranges](#heading--how-to-view-reserved-ranges)
- [How to view used IP addresses](#heading--ui-how-to-view-used-ip-addresses)
- [How to set up a bridge with MAAS](#heading--how-to-set-up-a-bridge-with-maas)
- [How to set up a bridge with netplan](#heading--how-to-set-up-a-bridge-with-netplan)
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
- [How to enable network discovery](#heading--how-to-enable-network-discovery)
- [How to toggle subnet management](#heading--how-to-toggle-subnet-management)
- [How to determine fabric ID](#heading--how-to-determine-fabric-id)
- [How to set a default gateway](#heading--how-to-set-a-default-gateway)
- [How to set a DNS server](#heading--how-to-set-a-dns-server)
- [How to list available subnets](#heading--cli-list-available-subnets)
- [How to view subnet details](#heading--cli-how-to-view-subnet-details)
- [How to manage static routes between subnets](#heading--how-to-manage-static-routes)
- [How to set up a bridge with MAAS](#heading--how-to-set-up-a-bridge-with-maas)
- [How to set up a bridge with netplan](#heading--how-to-set-up-a-bridge-with-netplan)
[/tab]
[/tabs]

<a href="#heading--how-to-enable-network-discovery"><h3 id="heading--how-to-enable-network-discovery">How to enable network discovery</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
Network discovery can be disabled or re-enabled using the switch on the Network discovery dashboard.

<a href="https://assets.ubuntu.com/v1/1782e4aa-installconfig-networking__2.4_discovery.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/1782e4aa-installconfig-networking__2.4_discovery.png"></a>

[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To enable network discovery, enter the following at the command line:

```nohighlight
maas $PROFILE maas set-config name=network_discovery value="enabled"
```

If successful, you should receive output similar to:

```nohighlight
Success.
Machine-readable output follows:
OK
```

Network discovery can be disabled or re-enabled at any time with this CLI command.
[/tab]
[/tabs]

<a href="#heading--how-to-toggle-subnet-management"><h3 id="heading--how-to-toggle-subnet-management">How to toggle subnet management</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To disable (or re-enable) subnet management, use the following procedure:

1. Navigate to the 'Subnets' page and select the subnet.

2. Press the 'Edit' button to allow changes; the 'Managed allocation' field will become a slide switch.

3. Click the label (or the switch icon itself) to toggle between enabled (dark blue) and disabled (grey).

4. Click 'Save summary'.

The following screenshot illustrates this process.

<a href="https://assets.ubuntu.com/v1/e5d80c8c-installconfig-network-subnet-management__2.6-management-toggle.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/e5d80c8c-installconfig-network-subnet-management__2.6-management-toggle.png"></a>

<a href="#heading--how-to-access-ui-main-networking-view"><h3 id="heading--how-to-access-ui-main-networking-view">How to access the main networking view</h3></a>

To access the main networking view visit the 'Subnets' page:

<a href="https://assets.ubuntu.com/v1/657bb332-installconfig-networking__2.4_subnets.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/657bb332-installconfig-networking__2.4_subnets.png"></a>

This main view can also be filtered either by fabrics or by spaces through the use of the 'Group by' drop-down.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To enable or disable subnet management:

``` nohighlight
maas $PROFILE subnet update $SUBNET_CIDR managed=false|true
```

For example, to disable subnet management:

``` nohighlight
maas $PROFILE subnet update 192.168.1.0/24 managed=false
```

You can use the subnets ID in place of the CIDR address.

<a href="#heading--how-to-determine-fabric-id"><h3 id="heading--how-to-determine-fabric-id">How to determine fabric ID</h3></a>

To determine a fabric ID based on a subnet address:

```nohighlight
FABRIC_ID=$(maas $PROFILE subnet read $SUBNET_CIDR \
    | grep fabric | cut -d ' ' -f 10 | cut -d '"' -f 2)
```

This may come in handy when you need a fabric ID for other CLI calls.

<a href="#heading--how-to-set-a-default-gateway"><h3 id="heading--how-to-set-a-default-gateway">How to set a default gateway</h3></a>

To set the default gateway for a subnet:

```nohighlight
maas $PROFILE subnet update $SUBNET_CIDR gateway_ip=$MY_GATEWAY
```

<a href="#heading--how-to-set-a-dns-server"><h3 id="heading--how-to-set-a-dns-server">How to set a DNS server</h3></a>

To set the DNS server for a subnet:

```nohighlight
maas $PROFILE subnet update $SUBNET_CIDR dns_servers=$MY_NAME SERVER
```

<a href="#heading--cli-list-available-subnets"><h3 id="heading--cli-list-available-subnets">How to list available subnets</h3></a>

To view the list of available subnets, enter the following command:

```nohighlight
maas admin subnets read | \
jq -r '(["FABRIC", "VLAN", "DHCP", "SUBNET"]
| (., map(length*"-"))),
(.[] | [.vlan.fabric, .vlan.name, .vlan.dhcp_on, .cidr])
| @tsv' \
| column -t
```

which produces output something like this:

```nohighlight
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
[/tab]
[/tabs]

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--ui-how-to-display-the-subnet-window"><h3 id="heading--ui-how-to-display-the-subnet-window">How to display the subnet window</h3></a>

Clicking a subnet (here `192.168.100.0/24`) will display its detail screen, which contains several sections, described below.

<a href="#heading--ui-how-to-view-the-subnet-summary"><h3 id="heading--ui-how-to-view-the-subnet-summary">How to view the subnet summary</h3></a>

The **Subnet summary** section is the largest and most complex of the subnet configuration screens:

<a href="https://assets.ubuntu.com/v1/17617b35-installconfig-networking__2.4_subnets-summary.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/17617b35-installconfig-networking__2.4_subnets-summary.png"></a>

This screen presents the following configurable options:

- **Name**: Subnet names can be any valid text string. By default, they are named with the CIDR of the subnet itself.

- **CIDR**: This is the address parameter for the subnet.  In keeping with standard CIDR notation, the number of bits of the prefix are indicated after the slash.

- **Gateway IP**: This is the address of the default gateway for your subnet, which is the IP address that transfers packets to other subnets or networks. Typically, this is simply the first IP address in a block of addresses (the `.1` address).

- **DNS**: This is the address of a DNS (domain name server, or simply "name server") for your subnet.  It's optional, but can be configured if desired.

- **Description**: This field represents free form text that you can enter to describe your subnet, as needed to keep important notes attached to the definition of the subnet.

- **Managed allocation** refers to the ability of MAAS to completely [manage a subnet](#heading--about-managed-subnets).

- **Active mapping** instructs MAAS to scan the subnet every 3 hours to discover hosts that have not been discovered passively.

- **Proxy access** instructs MAAS to allow clients from this subnet to access the MAAS proxy.

- **Allow DNS resolution** allows subnet clients to use MAAS for DNS resolution.

- **Fabric**: This field allows you to set the subnets fabric.

- **VLAN**: This field allows you to set the subnets VLAN.

- **Space** is presented for clarity, though spaces are managed at the VLAN level.

<a href="#heading--ui-how-to-view-utilisation"><h3 id="heading--ui-how-to-view-utilisation">How to view utilisation</h3></a>

This section of the subnet page presents metrics regarding address usage by this subnet.

<a href="https://assets.ubuntu.com/v1/3d3e4b61-installconfig-networking__2.4_subnets-utilisation.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/3d3e4b61-installconfig-networking__2.4_subnets-utilisation.png"></a>

'Subnet addresses' shows the total number of addresses associated with the subnet, here 254. 'Availability' shows how many of those addresses are unused, and therefore "available", here 189, which corresponds to a percentage of roughly 74% of the total. Finally, 'Used' shows the percentage that is used, here roughly 26%.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
<a href="#heading--cli-how-to-view-subnet-details"><h3 id="heading--cli-how-to-view-subnet-details">How to view subnet details</h3></a>

You can view the details of an individual subnet with the command:

```nohighlight
maas $PROFILE subnet read $SUBNET_ID \
| jq -r '(["NAME","CIDR","GATEWAY","DNS","DISCOVERY","FABRIC","VLAN"]
| (., map(length*"-"))), ([.name,.cidr,.gateway_ip // "-", .allow_dns,.active_discovery,.vlan.name,.vlan.fabric]) | @tsv' | column -t
```

This command retrieves output similar to this:

```nohighlight
NAME              CIDR              GATEWAY  DNS   DISCOVERY  FABRIC    VLAN
----              ----              -------  ---   ---------  ------    ----
192.168.123.0/24  192.168.123.0/24  -        true  false      untagged  default
```

If you don't know the subnet ID, you can look it up like this:

```nohighlight
maas $PROFILE subnets read \
| jq -r '(["NAME", "SUBNET_ID"]
| (., map(length*"-"))), (.[] | [.name, .id]) | @tsv' \
| column -t | grep $SUBNET_NAME
```

For example, if you're using the "admin" profile, and your subnet name contains "192.168.123," you could find the subnet ID with this command:

```nohighlight
maas admin subnets read \
| jq -r '(["NAME", "SUBNET_ID"]
| (., map(length*"-"))), (.[] | [.name, .id]) | @tsv' \
| column -t | grep 192.168.123
```
[/tab]
[/tabs]

 
<a href="#heading--how-to-manage-static-routes"><h3 id="heading--how-to-manage-static-routes">How to manage static routes between subnets</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To create a static route:

1. Click the 'Add static route' button to reveal the edit pane. 

2. Enter a Gateway IP address.

3. Select a destination subnet from the 'Destination' drop-down list.

4. Edit the routing metric value if needed. 

5. Click 'Add' to activate the route. 

Routes can be edited and removed using the icons to the right of each entry.

<a href="https://assets.ubuntu.com/v1/49f5e240-installconfig-networking__2.4_subnets-routes.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/49f5e240-installconfig-networking__2.4_subnets-routes.png"></a>
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To create a static route between two subnets, use the following command:

```nohighlight
maas admin static-routes create source=$SOURCE_SUBNET destination=$DEST_SUBNET \
gateway_ip=$GATEWAY_IP
```
[/tab]
[/tabs]

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--how-to-view-reserved-ranges"><h3 id="heading--how-to-view-reserved-ranges">How to view reserved ranges</h3></a>

The reserved ranges section of the subnet screen looks like this:

<a href="https://assets.ubuntu.com/v1/5f9f50f9-installconfig-networking__2.4_subnets-reserved.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/5f9f50f9-installconfig-networking__2.4_subnets-reserved.png"></a>

More details and instructions regarding these ranges can be found in [IP ranges](/t/how-to-enable-dhcp/5132#heading--how-to-manage-ip-ranges).
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--ui-how-to-view-used-ip-addresses"><h3 id="heading--ui-how-to-view-used-ip-addresses">How to view used IP addresses</h3></a>

This section displays hosts (including controllers) associated with the used addresses along with related bits of host information.

<a href="https://assets.ubuntu.com/v1/b9e69b0b-installconfig-networking__2.4_subnets-used.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/b9e69b0b-installconfig-networking__2.4_subnets-used.png"></a>
[/tab]
[/tabs]

<a href="#heading--how-to-set-up-a-bridge-with-maas"><h3 id="heading--how-to-set-up-a-bridge-with-maas">How to set up a bridge with MAAS</h3></a>

At various times in your MAAS network, you may need to set up a bridge to connect between your machines and MAAS, as shown in this section.

[note]
It's essential to enforce usage of IP addresses to avoid domain name conflicts, should different controllers resolve the same domain name with different IP addresses. You should also avoid using 127.0.0.1 when running multiple controllers, as it would confuse MAAS.
[/note]

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To configure a bridge with the MAAS UI: 

1. Select the machine you want to bridge. 

2. Switch to the "Network" tab. 

3. Select the network where you want to create the bridge and click "Create bridge:"

<a href="https://discourse.maas.io/uploads/default/original/1X/29624d737106c5bad777aee9d2c8cad9c3de7151.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/29624d737106c5bad777aee9d2c8cad9c3de7151.jpeg"></a> 

4. Configure the bridge on a subnet MAAS controls (you may use any IP mode for the bridge):

<a href="https://discourse.maas.io/uploads/default/original/1X/dd8567ff1cd76606c5ce1751e606fcfab2bc7ce2.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/dd8567ff1cd76606c5ce1751e606fcfab2bc7ce2.jpeg"></a> 

When you're done, it should look something like this:

<a href="https://discourse.maas.io/uploads/default/original/1X/e392d638f0acecb9d54c81bbca4ee17cbcd05445.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e392d638f0acecb9d54c81bbca4ee17cbcd05445.jpeg"></a> 

Then you can deploy machines using this bridge.

**NOTE** that you can create an "Open switch" bridge if desired, and MAAS will create the netplan model for you.
[/tab] 
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
You can use the MAAS CLI/API to configure a bridge via the following procedure:

1. Select the interface on which you wish to configure the bridge. This example uses the boot interface, since the boot interface must be connected to a MAAS controlled network -- but any interface is allowed:

        INTERFACE_ID=$(maas $PROFILE machine read $SYSTEM_ID | jq .boot_interface.id)

2. Create the bridge:

         BRIDGE_ID=$(maas $PROFILE interfaces create-bridge $SYSTEM_ID name=br0 parent=$INTERFACE_ID | jq .id)

3. Select the subnet where you want the bridge (this should be a MAAS controlled subnet):

        SUBNET_ID=$(maas $PROFILE subnets read | jq -r '.[] | select(.cidr == "10.0.0.0/24" and .managed == true).id')

4. Connect the bridge to the subnet:

          maas $PROFILE interface link-subnet $SYSTEM_ID $BRIDGE_ID subnet=$SUBNET_ID mode="STATIC" ip_address="10.0.0.101"

[/tab]
[/tabs]

<a href="#heading--how-to-set-up-a-bridge-with-netplan"><h3 id="heading--how-to-set-up-a-bridge-with-netplan">How to set up a bridge with netplan</h3></a>

You can also use netplan to configure a bridge:

1. Open your netplan configuration file.  This should be in `/etc/netplan`.  It could be called `50-cloud-init.yaml`, `netplan.yaml`, or something else.  

2. Modify the file to add a bridge, using the following example as a guide:

```nohighlight
network:
    bridges:
        br0:
            addresses:
            - 10.0.0.101/24
            gateway4: 10.0.0.1
            interfaces:
            - enp1s0
            mac address: 52:54:00:39:9d:f9
            mtu: 1500
            name servers:
                addresses:
                - 10.0.0.2
                search:
                - maas
            parameters:
                forward-delay: 15
                stp: false
    Ethernet's:
        enp1s0:
            match:
                mac address: 52:54:00:39:9d:f9
            mtu: 1500
            set-name: enp1s0
        enp2s0:
            match:
                mac address: 52:54:00:df:87:ac
            mtu: 1500
            set-name: enp2s0
        enp3s0:
            match:
                mac address: 52:54:00:a7:ac:46
            mtu: 1500
            set-name: enp3s0
    version: 2
```

3. Apply the new configuration with `netplan apply`.

<a href="#heading--how-to-manage-machine-interfaces"><h2 id="heading--how-to-manage-machine-interfaces">How to manage machine interfaces</h2></a>

This section will explain the following procedures related to machine interfaces:

- [How to edit machine interfaces](#heading--how-to-edit-interfaces")
- [How to create a bond interface](#heading--bond-interfaces)
- [How to create a bridge interface](#heading--bridge-interfaces)
- [How to delete an interface](#heading--delete-an-interface)
- [How to assign a network interface to a fabric](#heading--assign-a-network-interface-to-a-fabric)
- [How to discover interface identifiers](#heading--interface-identifiers)
- [How to create a VLAN interface](#heading--create-a-vlan-interface)
- [How to delete a VLAN interface](#heading--delete-a-vlan-interface)

<a href="#heading--how-to-edit-interfaces"><h3 id="heading--how-to-edit-interfaces">How to edit machine interfaces</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
From a machine's "Interfaces" page, click the menu icon for the interface to be edited and select "Edit Physical" from the resulting menu:

<a href="https://discourse.maas.io/uploads/default/original/1X/438475b8906736b45fc809cd105a56be5052397d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/438475b8906736b45fc809cd105a56be5052397d.png"></a>

The following window will appear:

<a href="https://discourse.maas.io/uploads/default/original/1X/70b21d256df52399ac7ab09c3051f4bf011da55e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/70b21d256df52399ac7ab09c3051f4bf011da55e.png"></a>

Four modes determine how a subnet address is assigned when MAAS deploys the machine. You can select one of these modes by clicking on the "IP mode" drop-down menu.

-   **Auto assign**: MAAS will assign a random static address (`iface eth0 inet static`). The pool of available addresses depends on whether the subnet is managed or unmanaged (see [Subnet management](/t/how-to-connect-maas-networks/5164#heading--how-to-toggle-subnet-management)).

-   **Static assign**: The administrator will specify a static address using a secondary field.

-   **DHCP**: The machine leases a dynamic IP address, via either MAAS-managed DHCP or an external DHCP server.

-   **Unconfigured**: The interface is not configured.

Press the "Save" button to apply the changes.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
If you want to edit the IP assignment mode of a network interface, the existing subnet link first needs to be removed.

Begin by finding the interface ID as well as the interface's subnet link ID with the command:

``` bash
maas $PROFILE node read $SYSTEM_ID
```

Once that's done, proceed to unlink and link:

``` bash
maas $PROFILE interface unlink-subnet $SYSTEM_ID $INTERFACE_ID id=$SUBNET_LINK_ID
maas $PROFILE interface link-subnet $SYSTEM_ID $INTERFACE_ID mode=$IP_MODE subnet=$SUBNET_CIDR [$OPTIONS]
```

For instance, to have interface `58`, with subnet link `146`, on machine `exqn37` use DHCP on subnet `192.168.1.0/24`:

``` bash
maas $PROFILE interface unlink-subnet exqn37 58 id=146
maas $PROFILE interface link-subnet exqn37 58 mode=dhcp subnet=192.168.1.0/24
```

If instead of DHCP, you desire a static address, then the second command would look like this:

``` bash
maas $PROFILE interface link-subnet exqn37 58 mode=static subnet=192.168.1.0/24 ip_address=192.168.1.113
```
[/tab]
[/tabs]

See [Concepts and terms](/t/maas-glossary/5416#heading--ip-ranges) for the definitions of reserved range types.

<a href="#heading--bond-interfaces"><h3 id="heading--bond-interfaces">How to create a bond interface</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
A bond is created by selecting more than one interface and clicking the now-active "Create bond" button:

<a href="https://discourse.maas.io/uploads/default/original/1X/7dd772c961c9f6f871f657b0397646446a4e23e7.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/7dd772c961c9f6f871f657b0397646446a4e23e7.png"></a>

After clicking the "Create bond" button, the bond configuration pane will appear.

From the bond configuration pane, you can rename the bond, select a bond mode (see below), assign a MAC address to the aggregate device and attach one or more tags.

The interfaces aggregated into the bond interface are listed below the "Tags" field. Use the "Primary" column to select the interface to act as the primary device.

<a href="https://discourse.maas.io/uploads/default/original/1X/699a55f98f3e1a81da75d1595e40bb74c99aff8e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/699a55f98f3e1a81da75d1595e40bb74c99aff8e.png"></a>

You can select from the following bonding modes on the "Bond mode" drop-down menu:

-   **balance-rr**: Transmit packets in sequential order from the first available follower through to the last. This mode provides load balancing and fault tolerance.

-   **active-backup**: Only one follower in the bond is active. A different follower becomes active if, and only if, the active follower fails. The bond's MAC address is externally visible on only one port (network adaptor) to avoid confusing the switch.

-   **balance-xor**: Transmit based on the selected transmit hash policy. The default policy is simple, which means that an XOR operation selects packages.  This XOR compares the source MAC address and the resultant XOR between the destination MAC address, the packet type identifier, and the modulo follower count.

-   **broadcast**: Transmit everything on all follower interfaces. This mode provides fault tolerance.

-   **802.3ad**: Creates aggregation groups that share the same speed and duplex settings. This mode utilises all followers in the active aggregation, following the IEEE 802.3ad specification.

-   **balance-tlb**: Adaptive transmit load balancing, channel bonding that does not require any special switch support.

-   **balance-alb**: Adaptive load balancing, includes balance-tlb plus receive load balancing (rlb) for IPV4 traffic. This mode does not require any special switch support.  ARP negotiation achieves load balancing in this case.

Press the "Save" button when you're done.

[note]
The MAC address defaults to the MAC address of the primary interface.
[/note]
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
A bond can be created with the following command:

```
maas $PROFILE interfaces create-bond $SYSTEM_ID name=$BOND_NAME \
parents=$IFACE1_ID mac_address=$MAC_ADDR \ 
parents=$IFACE2_ID bond_mode=$BOND_MODE \
bond_updelay=$BOND_UP bond_downdelay=$BOND_DOWN mtu=$MTU
```

Use the `parents` parameters to define which interfaces form the aggregate interface.

The `bond_updelay` and `bond_downdelay` parameters specify the number of milliseconds to wait before either enabling or disabling a follower after a failure has been detected.

The following is an example of `create-bond` in action:

```
maas admin interfaces create-bond 4efwb4 name=bond0 parents=4 \
mac_address=52:52:00:00:00:00 parents=15 bond_mode=802.3ad \
bond_updelay=200 bond_downdelay=200 mtu=9000
```

There are a wide range of bond parameters you can choose when creating a bond:

| Parameter | Type and description |
|:----------|:---------------------|
| `mac_address`| Optional string.  MAC address of the interface. |
| `tags`| Optional string.  Tags for the interface. |
| `vlan`| Optional string.  VLAN the interface is connected to. If not provided then the interface is considered disconnected. |
| `parents`| Required integer.  Parent interface ids that make this bond. |
| `bond_miimon`| Optional integer.  The link monitoring frequency in milliseconds. (Default: 100). |
| `bond_downdelay`| Optional integer.  Specifies the time, in milliseconds, to wait before disabling a follower after a link failure has been detected. |
| `bond_updelay`| Optional integer.  Specifies the time, in milliseconds, to wait before enabling a follower after a link recovery has been detected. |
| `bond_lacp_rate`| Optional string.  Option specifying the rate at which to ask the link partner to transmit LACPDU packets in 802.3ad mode. Available options are ``fast`` or ``slow``. (Default: ``slow``). |
| `bond_xmit_hash_policy`| Optional string.  The transmit hash policy to use for follower selection in balance-xor, 802.3ad, and tlb modes. Possible values are: ``layer2``, ``layer2+3``, ``layer3+4``, ``encap2+3``, ``encap3+4``. (Default: ``layer2``) |
| `bond_num_grat_arp`| Optional integer.  The number of peer notifications (IPv4 ARP or IPv6 Neighbour Advertisements) to be issued after a failover. (Default: 1) |
| `mtu`| Optional integer.  Maximum transmission unit. |
| `accept_ra`| Optional Boolean.  Accept router advertisements. (IPv6 only) |
| `autoconf`| Optional Boolean.  Perform stateless autoconfiguration. (IPv6 only) |
| `bond_mode`| Optional string.  The operating mode of the bond.  (Default: active-backup). |

Supported bonding modes include:

| Mode | Behaviour |
|:-----|:---------|
|  `balance-rr`:| Transmit packets in sequential order from the first available follower through the last. This mode provides load balancing and fault tolerance. |
|  `active-backup`| Only one follower in the bond is active. A different follower becomes active if, and only if, the active follower fails. The bond's MAC address is externally visible on only one port (network adaptor) to avoid confusing the switch. |
|  `balance-xor`| Transmit based on the selected transmit hash policy. The default policy is a simple [(source MAC address XOR'd with destination MAC address XOR packet type ID) modulo follower count]. |
|  `broadcast`| Transmits everything on all follower interfaces. This mode provides fault tolerance. |
|  `802.3ad`| IEEE 802.3ad dynamic link aggregation. Creates aggregation groups that share the same speed and duplex settings. Uses all followers in the active aggregator according to the 802.3ad specification. |
|  `balance-tlb`| Adaptive transmit load balancing: channel bonding that does not require any special switch support. |
|  `balance-alb`| Adaptive load balancing: includes balance-tlb plus receive load balancing (rlb) for IPV4 traffic, and does not require any special switch support. The receive load balancing is achieved by ARP negotiation. |
[/tab]
[/tabs]

<a href="#heading--bridge-interfaces"><h3 id="heading--bridge-interfaces">How to create a bridge interface</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="https://discourse.maas.io/uploads/default/original/1X/83ef3d6f40d5b558396d96717dd2822fc1ce8b68.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/83ef3d6f40d5b558396d96717dd2822fc1ce8b68.png"></a>

Press the "Save" button when you're done.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
Please use the UI interface to create a bridge interface.  Select the "UI" dropdown above to see how.
[/tab]
[/tabs]

<a href="#heading--delete-an-interface"><h3 id="heading--delete-an-interface">How to delete an interface</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
An interface can only be deleted via the MAAS CLI.  Choose the "CLI" dropdown above to see how.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
A bridge interface is created with the following syntax:

```
maas $PROFILE interfaces create-bridge $SYSTEM_ID name=$BRIDGE_NAME \
parent=$IFACE_ID
```

Use `parent` to define the primary interface used for the bridge:

```
maas admin interfaces create-bridge 4efwb4 name=bridged0 parent=4
```

The following parameters may be applied when creating a bridge:

- `name`: Optional string.  Name of the interface.

- `mac_address`: Optional string.  MAC address of the interface.

- `tags`: Optional string.  Tags for the interface.

- `vlan`: Optional string.  VLAN the interface is connected to.

- `parent`: Optional integer.  Parent interface id for this bridge interface.

- `bridge_type`: Optional string.  The type of bridge to create. Possible values are: ``standard``, ``ovs``.

- `bridge_stp`: Optional Boolean.  Turn spanning tree protocol on or off. (Default: False).

- `bridge_fd`: Optional integer.  Set bridge forward delay to time seconds. (Default: 15).

- `mtu`: Optional integer.  Maximum transmission unit.

- `accept_ra`: Optional Boolean.  Accept router advertisements. (IPv6 only)

- `autoconf`: Optional Boolean.  Perform stateless autoconfiguration. (IPv6 only)
[/tab]
[/tabs]

The "delete" command can be used to delete a bridge interface, a bond interface or a physical interface:

```
maas $PROFILE interface delete $SYSTEM_ID $IFACE_ID
```

For example:

```
maas admin interface delete 4efwb4 15
```

The following is output after the successful deletion of an interface:

```
Success.
Machine-readable output follows:
```

Note that while the label is presented, there is no machine-readable output expected after the successful execution of the delete command.

<a href="#heading--assign-a-network-interface-to-a-fabric"><h3 id="heading--assign-a-network-interface-to-a-fabric">How to assign a network interface to a fabric</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
A network interface may be assigned to a fabric with the MAAS CLI only.  Choose the "CLI" dropdown above to see how.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
This task is made easier with the aid of the `jq` utility. It filters the `maas` command (JSON formatted) output and prints it in the desired way, which allows you to view and compare data quickly. Go ahead and install it:

``` bash
sudo apt install jq
```

In summary, MAAS assigns an interface to a fabric by assigning it to a VLAN. First, we need to gather various bits of data.

List some information on all machines:

``` bash
maas $PROFILE machines read | jq ".[] | \
    {hostname:.hostname, system_id: .system_id, status:.status}" --compact-output
```

Example output:

``` no-highlight
{"hostname":"machine1","system_id":"dfgnnd","status":4}
{"hostname":"machine2","system_id":"bkaf6e","status":6}
{"hostname":"machine4","system_id":"63wqky","status":6}
{"hostname":"machine3","system_id":"qwkmar","status":4}
```

[note]
You can only edit an interface when the corresponding machine has a status of 'Ready'. This state is numerically denoted by the integer '4'.
[/note]

List some information for all interfaces on the machine in question (identified by its system id 'dfgnnd'):

``` bash
maas $PROFILE interfaces read dfgnnd | jq ".[] | \
    {id:.id, name:.name, mac:.mac_address, vid:.vlan.vid, fabric:.vlan.fabric}" --compact-output
```

Example output:

``` no-highlight
{"id":8,"name":"eth0","mac":"52:54:00:01:01:01","vid":0,"fabric":"fabric-1"}
{"id":9,"name":"eth1","mac":"52:54:00:01:01:02","vid":null,"fabric":null}
```

List some information for all fabrics:

``` bash
maas $PROFILE fabrics read | jq ".[] | \
    {name:.name, vlans:.vlans[] | {id:.id, vid:.vid}}" --compact-output
```

Example output:

``` no-highlight
{"name":"fabric-0","vlans":{"id":5001,"vid":0}}
{"name":"fabric-1","vlans":{"id":5002,"vid":0}}
{"name":"fabric-2","vlans":{"id":5003,"vid":0}}
```

This example will show how to move interface '8' (on machine 'dfgnnd') from 'fabric-1' to 'fabric-0'. Based on the gathered information, this will consist of changing the interface's VLAN from '5002' to '5001':

``` bash
maas $PROFILE interface update dfgnnd 8 vlan=5001 >/dev/null
```

Verify the operation by relisting information for the machine's interface:

``` bash
maas $PROFILE interfaces read dfgnnd | jq ".[] | \
    {id:.id, name:.name, mac:.mac_address, vid:.vlan.vid, fabric:.vlan.fabric}" --compact-output
```

The output shows that the interface is now on fabric-0:

``` no-highlight
{"id":8,"name":"eth0","mac":"52:54:00:01:01:01","vid":0,"fabric":"fabric-0"}
{"id":9,"name":"eth1","mac":"52:54:00:01:01:02","vid":null,"fabric":null}
```
[/tab]
[/tabs]

<a href="#heading--interface-identifiers"><h3 id="heading--interface-identifiers">How to discover interface identifiers</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
Interface identifiers can only be discovered via the MAAS CLI.  Choose the "CLI" dropdown above to see how.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
The MAAS CLI uses a numeric interface identifier for many interface operations. Use the following command to retrieve the identifier(s):

``` bash
maas $PROFILE interfaces read $SYSTEM_ID
```

Look for either id or the number at the end of an interface's resource URI, such as **15** in the following example output:

``` json
"id": 15,
"mac_address": "52:54:00:55:06:40",
...
"name": "ens9",
...
"resource_uri": "/MAAS/api/2.0/nodes/4efwb4/interfaces/15/"
```
[/tab]
[/tabs]

<a href="#heading--create-a-vlan-interface"><h3 id="heading--create-a-vlan-interface">How to create a VLAN interface</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
VLAN interfaces can only be created via the MAAS CLI. Select the "CLI" dropdown above to see how.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To create a VLAN interface, use the following syntax:

``` bash
maas $PROFILE vlans create $FABRIC_ID name=$NAME vid=$VLAN_ID
```

For example, the following command creates a VLAN called 'Storage network:

``` bash
maas admin vlans create 0 name="Storage network" vid=100
```

The above command generates the following output:

``` no-output
Success.
Machine-readable output follows:
{
    "vid": 100,
    "mtu": 1500,
    "dhcp_on": false,
    "external_dhcp": null,
    "relay_vlan": null,
    "name": "Storage network",
    "space": "undefined",
    "fabric": "fabric-0",
    "id": 5004,
    "primary_rack": null,
    "fabric_id": 0,
    "secondary_rack": null,
    "resource_uri": "/MAAS/api/2.0/vlans/5004/"
}
```

Be aware that the $VLAN_ID parameter does not indicate a VLAN ID that corresponds to the VLAN tag. You must first create the VLAN and then associate it with the interface:

``` bash
maas $PROFILE interfaces create-vlan $SYSTEM_ID vlan=$OUTPUT_VLAN_ID \
parent=$IFACE_ID
```

[note]
**OUTPUT_VLAN_ID** corresponds to the id value output when MAAS created the VLAN.
[/note]

The following example contains values that correspond to the output above:

``` bash
maas admin interfaces create-vlan 4efwb4 vlan=5004 parent=4
```

The above command generates the following output:

``` json
Success.
Machine-readable output follows:
{
    "tags": [],
    "type": "vlan",
    "enabled": true,
    "system_id": "4efwb4",
    "id": 21,
    "children": [],
    "mac_address": "52:54:00:eb:f2:29",
    "params": {},
    "vlan": {
        "vid": 100,
        "mtu": 1500,
        "dhcp_on": false,
        "external_dhcp": null,
        "relay_vlan": null,
        "id": 5004,
        "secondary_rack": null,
        "fabric_id": 0,
        "space": "undefined",
        "fabric": "fabric-0",
        "name": "Storage network",
        "primary_rack": null,
        "resource_uri": "/MAAS/api/2.0/vlans/5004/"
    },
    "parents": [
        "ens3"
    ],
    "effective_mtu": 1500,
    "links": [
        {
            "id": 55,
            "mode": "link_up"
        }
    ],
    "discovered": null,
    "name": "ens3.100",
    "resource_uri": "/MAAS/api/2.0/nodes/4efwb4/interfaces/21/"
}
```
[/tab]
[/tabs]

<a href="#heading--delete-a-vlan-interface"><h3 id="heading--delete-a-vlan-interface">How to delete a VLAN interface</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
VLAN interfaces can only be deleted via the MAAS CLI. Select the "CLI" dropdown above to see how.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
The following command outlines the syntax required to delete a VLAN interface from the command line:

``` bash
maas $PROFILE vlan delete $FABRIC__ID $VLAN_ID
```

Using the values from previous examples, you executed this step as follows:

``` bash
maas admin vlan delete 0 100
```
[/tab]
[/tabs]

<a href="#heading--how-to-manage-proxies"><h2 id="heading--how-to-manage-proxies">How to manage proxies</h2></a>

MAAS provides a way for its managed machines to use a proxy server when they need to access HTTP/HTTPS-based resources, such as the Ubuntu package archive.

There are three possible options:

1.   internal proxy (default)
2.   external proxy
3.   no proxy

Configuring a proxy with MAAS consists of enabling/disabling one of the above three options and enabling/disabling proxying on a specific subnet. This article will help you learn:

- [About the MAAS internal proxy](#heading--internal-proxy-maas-proxy)
- [How to create an external proxy](#heading--configure-proxy)

<a href="#heading--internal-proxy-maas-proxy"><h3 id="heading--internal-proxy-maas-proxy">About the MAAS internal proxy</h3></a>

MAAS provides an internal proxy server. Although it is set up to work well with APT/package requests, it is effectively an HTTP caching proxy server. If you configure the MAAS region controller as the default gateway for the machines it manages then the proxy will work transparently (on TCP port 3128). Otherwise, machines will need to access it on TCP port 8000.

By default, the proxy is available to all hosts residing in any subnet detected by MAAS, not just MAAS-managed machines. It is therefore recommended to disable access to those subnets that represent untrusted networks.

[tabs]
[tab version="v3.3 Snap"]
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
[/tab]
[tab version="v3.3 Packages"]
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
[/tab]
[tab version="v3.2 Snap"]
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
[/tab]
[tab version="v3.2 Packages"]
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
[/tab]
[tab version="v3.1 Snap"]
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
[/tab]
[tab version="v3.1 Packages"]
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
[/tab]
[tab version="v3.0 Snap"]
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
[/tab]
[tab version="v3.0 Packages"]
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
[/tab]
[tab version="v2.9 Snap"]
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
[/tab]
[tab version="v2.9 Packages"]
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
[/tab]
[/tabs]

<a href="#heading--configure-proxy"><h3 id="heading--configure-proxy">How to create an external proxy</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
In the web UI, visit the 'Settings' page and select the 'Network services' tab. The 'Proxy' section is at the top. You can apply your changes by pressing the 'Save' button.

<a href="https://assets.ubuntu.com/v1/55800a33-installconfig-network-proxy__2.4_configure-proxy.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/55800a33-installconfig-network-proxy__2.4_configure-proxy.png"></a>

To enable the internal proxy, ensure that the checkbox adjacent to 'MAAS Built-in' is selected. This internal proxy is the default configuration.

To enable an external proxy, activate the 'External' checkbox and use the new field that is displayed to define the proxy's URL (and port if necessary).

An upstream cache peer can be defined by enabling the 'Peer' checkbox and entering the external proxy URL into the field. With this enabled, machines will be configured to use the MAAS built-in proxy to download cached APT packages.

To prevent MAAS machines from using a proxy, enable the 'Don't use a proxy' checkbox.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
Enabling and disabling proxying, in general, is done via a Boolean option ('true' or 'false'). The following command will disable proxying completely:

``` bash
maas $PROFILE maas set-config name=enable_http_proxy value=false
```

To set an external proxy, ensure proxying is enabled (see above) and then define it:

``` bash
maas $PROFILE maas set-config name=http_proxy value=$EXTERNAL_PROXY
```

For example,

``` bash
maas $PROFILE maas set-config name=enable_http_proxy value=true
maas $PROFILE maas set-config name=http_proxy value=http://squid.example.com:3128/
```

Enabling and disabling proxying per subnet is done via a Boolean option ('true' or 'false'). Here is how you can disable proxying on a per-subnet basis:

``` bash
maas $PROFILE subnet update $SUBNET_CIDR allow_proxy=false
```

For example,

``` bash
maas $PROFILE subnet update 192.168.0.0/22 allow_proxy=false
```

[/tab]
[/tabs]

**NOTE** that the proxy service will still be running.

<a href="#heading--how-to-set-up-ntp"><h2 id="heading--how-to-set-up-ntp">How to set up Network Time Protocol (NTP)</h2></a>

MAAS provides managed NTP services (with [Chrony](https://chrony.tuxfamily.org/)`↗`) for all region and rack controllers. This arrangement allows MAAS to both keep its controllers synchronised, and keep deployed machines synchronised as well. You can configure NTP on the 'Network services' tab of the 'Settings' page.

The region controller configures the NTP service to keep its time synchronised from one or more external sources. By default, the MAAS region controller uses `ntp.ubuntu.com`. Rack controllers also configure the NTP service, synchronising their time with the region controllers.  Rack controllers also configure DHCP with the correct NTP information. Any machine on the network that obtains a DHCP lease from MA/snap/3AS will benefit from NTP support.

<a href="#heading--setting-ntp-server"><h2 id="heading--setting-ntp-server">Setting an external NTP server</h2></a>

External sites, such as an existing NTP infrastructure, can be used directly as a time source for both rack controllers and machines.

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
You can specify an external site by choosing the NTP server(s) and selecting the 'External Only' option. The region controller always uses an external site.

On the 'Settings' page, select the 'Network services' tab and scroll down to the 'NTP' section:

<a href="https://assets.ubuntu.com/v1/69180b4a-installconfig-network-ntp__2.6-configure-ntp.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/69180b4a-installconfig-network-ntp__2.6-configure-ntp.png"></a>

Enter the address of the desired NTP server. Apply any changes by pressing the 'Save' button.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
You can specify an external NTP server with two successive commands:

```
maas $PROFILE maas set-config name=ntp_servers value=$NTP_IP_ADDRESS
```

followed by:

```
maas admin maas set-config name=ntp_external_only value=true
```

[/tab]
[/tabs]