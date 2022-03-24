You can easily manage the basic networking elements of MAAS, including subnets, fabrics, VLANs, spaces, and IP ranges.  This section shows how to access and edit these elements. See [Concepts and terms](/t/maas-concepts-and-terms-reference/nnnn) for the definitions of these networking components.

This section will show you:

* [How to enable network discovery](#heading--how-to-enable-network-discovery)
* [How to toggle subnet management](#heading--how-to-toggle-subnet-management)
rad-begin /deb/2.9/cli /deb/3.0/cli /deb/3.1/cli /snap/2.9/cli /snap/3.0/cli /snap/3.1/cli 
* [How to determine fabric ID](#heading--how-to-determine-fabric-id)
* [How to set a default gateway](#heading--how-to-set-a-default-gateway)
* [How to set a DNS server](#heading--how-to-set-a-dns-server)
* [How to list available subnets](#heading--cli-list-available-subnets)
* [How to view subnet details](#heading--cli-how-to-view-subnet-details)
rad-end
rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui
* [How to access the main networking view](#heading--how-to-access-ui-main-networking-view)
* [How to display the subnet window](#heading--ui-how-to-display-the-subnet-window)
* [How to view the subnet summary](#heading--ui-how-to-view-the-subnet-summary)
* [How to view utilisation](#heading--ui-how-to-view-utilisation)
rad-end
* [How to manage static routes between subnets](#heading--how-to-manage-static-routes)
rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui
* [How to view reserved ranges](#heading--how-to-view-reserved-ranges)
* [How to view used IP addresses](#heading--ui-how-to-view-used-ip-addresses)
rad-end
* [How to set up a bridge with MAAS](#heading--how-to-set-up-a-bridge-with-maas)
* [How to set up a bridge with netplan](#heading--how-to-set-up-a-bridge-with-netplan)

<a href="#heading--how-to-enable-network-discovery"><h3 id="heading--how-to-enable-network-discovery">How to enable network discovery</h3></a>

rad-begin /deb/2.9/cli /deb/3.0/cli /deb/3.1/cli /snap/2.9/cli /snap/3.0/cli /snap/3.1/cli 
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
rad-end

rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui 
Network discovery can be disabled or re-enabled using the switch on the Network discovery dashboard.

<a href="https://assets.ubuntu.com/v1/1782e4aa-installconfig-networking__2.4_discovery.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/1782e4aa-installconfig-networking__2.4_discovery.png"></a>

rad-end

<a href="#heading--how-to-toggle-subnet-management"><h3 id="heading--how-to-toggle-subnet-management">How to toggle subnet management</h3></a>

rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui 
To disable (or re-enable) subnet management, use the following procedure:

1. Navigate to the 'Subnets' page and select the subnet.

2. Press the 'Edit' button to allow changes; the 'Managed allocation' field will become a slide switch.

3. Click the label (or the switch icon itself) to toggle between enabled (dark blue) and disabled (grey).

4. Click 'Save summary'.

The following screenshot illustrates this process.

<a href="https://assets.ubuntu.com/v1/e5d80c8c-installconfig-network-subnet-management__2.6-management-toggle.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/e5d80c8c-installconfig-network-subnet-management__2.6-management-toggle.png"></a>
rad-end

rad-begin /deb/2.9/cli /deb/3.0/cli /deb/3.1/cli /snap/2.9/cli /snap/3.0/cli /snap/3.1/cli 
To enable or disable subnet management:

``` nohighlight
maas $PROFILE subnet update $SUBNET_CIDR managed=false|true
```

For example, to disable subnet management:

``` nohighlight
maas $PROFILE subnet update 192.168.1.0/24 managed=false
```

You can use the subnets ID in place of the CIDR address.
rad-end

rad-begin /deb/2.9/cli /deb/3.0/cli /deb/3.1/cli /snap/2.9/cli /snap/3.0/cli /snap/3.1/cli
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
rad-end

rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui
<a href="#heading--how-to-access-ui-main-networking-view"><h3 id="heading--how-to-access-ui-main-networking-view">How to access the main networking view</h3></a>

To access the main networking view visit the 'Subnets' page:

<a href="https://assets.ubuntu.com/v1/657bb332-installconfig-networking__2.4_subnets.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/657bb332-installconfig-networking__2.4_subnets.png"></a>

This main view can also be filtered either by fabrics or by spaces through the use of the 'Group by' drop-down.
rad-end

rad-begin /deb/2.9/cli /deb/3.0/cli /deb/3.1/cli /snap/2.9/cli /snap/3.0/cli /snap/3.1/cli
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
rad-end

rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui 
<a href="#heading--ui-how-to-display-the-subnet-window"><h3 id="heading--ui-how-to-display-the-subnet-window">How to display the subnet window</h3></a>

Clicking a subnet (here `192.168.100.0/24`) will display its detail screen, which contains several sections, described below.

<a href="#heading--ui-how-to-view-the-subnet-summary"><h3 id="heading--ui-how-to-view-the-subnet-summary">How to view the subnet summary</h3></a>

The **Subnet summary** section is the largest and most complex of the subnet configuration screens:

<a href="https://assets.ubuntu.com/v1/17617b35-installconfig-networking__2.4_subnets-summary.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/17617b35-installconfig-networking__2.4_subnets-summary.png"></a>

This screen presents the following configurable options:

* **Name**: Subnet names can be any valid text string. By default, they are named with the CIDR of the subnet itself.

* **CIDR**: This is the address parameter for the subnet.  In keeping with standard CIDR notation, the number of bits of the prefix are indicated after the slash.

* **Gateway IP**: This is the address of the default gateway for your subnet, which is the IP address that transfers packets to other subnets or networks. Typically, this is simply the first IP address in a block of addresses (the `.1` address).

* **DNS**: This is the address of a DNS (domain name server, or simply "name server") for your subnet.  It's optional, but can be configured if desired.

* **Description**: This field represents free form text that you can enter to describe your subnet, as needed to keep important notes attached to the definition of the subnet.

* **Managed allocation** refers to the ability of MAAS to completely [manage a subnet](#heading--about-managed-subnets).

* **Active mapping** instructs MAAS to scan the subnet every 3 hours to discover hosts that have not been discovered passively.

* **Proxy access** instructs MAAS to allow clients from this subnet to access the MAAS proxy.

* **Allow DNS resolution** allows subnet clients to use MAAS for DNS resolution.

* **Fabric**: This field allows you to set the subnets fabric.

* **VLAN**: This field allows you to set the subnets VLAN.

* **Space** is presented for clarity, though spaces are managed at the VLAN level.

<a href="#heading--ui-how-to-view-utilisation"><h3 id="heading--ui-how-to-view-utilisation">How to view utilisation</h3></a>

This section of the subnet page presents metrics regarding address usage by this subnet.

<a href="https://assets.ubuntu.com/v1/3d3e4b61-installconfig-networking__2.4_subnets-utilisation.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/3d3e4b61-installconfig-networking__2.4_subnets-utilisation.png"></a>

'Subnet addresses' shows the total number of addresses associated with the subnet, here 254. 'Availability' shows how many of those addresses are unused, and therefore "available", here 189, which corresponds to a percentage of roughly 74% of the total. Finally, 'Used' shows the percentage that is used, here roughly 26%.
rad-end 

<a href="#heading--how-to-manage-static-routes"><h3 id="heading--how-to-manage-static-routes">How to manage static routes between subnets</h3></a>

rad-begin /deb/2.9/cli /deb/3.0/cli /deb/3.1/cli /snap/2.9/cli /snap/3.0/cli /snap/3.1/cli
To create a static route between two subnets, use the following command:

```nohighlight
maas admin static-routes create source=$SOURCE_SUBNET destination=$DEST_SUBNET \
gateway_ip=$GATEWAY_IP
```
rad-end

rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui
To create a static route:

1. Click the 'Add static route' button to reveal the edit pane. 

2. Enter a Gateway IP address.

3. Select a destination subnet from the 'Destination' drop-down list.

4. Edit the routing metric value if needed. 

5. Click 'Add' to activate the route. 

Routes can be edited and removed using the icons to the right of each entry.

<a href="https://assets.ubuntu.com/v1/49f5e240-installconfig-networking__2.4_subnets-routes.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/49f5e240-installconfig-networking__2.4_subnets-routes.png"></a>
rad-end

rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui
<a href="#heading--how-to-view-reserved-ranges"><h3 id="heading--how-to-view-reserved-ranges">How to view reserved ranges</h3></a>

The reserved ranges section of the subnet screen looks like this:

<a href="https://assets.ubuntu.com/v1/5f9f50f9-installconfig-networking__2.4_subnets-reserved.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/5f9f50f9-installconfig-networking__2.4_subnets-reserved.png"></a>

More details and instructions regarding these ranges can be found in [IP ranges](/t/how-to-manage-ip-ranges/nnnn).
rad-end


rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui
<a href="#heading--ui-how-to-view-used-ip-addresses"><h3 id="heading--ui-how-to-view-used-ip-addresses">How to view used IP addresses</h3></a>

This section displays hosts (including controllers) associated with the used addresses along with related bits of host information.

<a href="https://assets.ubuntu.com/v1/b9e69b0b-installconfig-networking__2.4_subnets-used.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/b9e69b0b-installconfig-networking__2.4_subnets-used.png"></a>
rad-end

<a href="#heading--how-to-set-up-a-bridge-with-maas"><h3 id="heading--how-to-set-up-a-bridge-with-maas">How to set up a bridge with MAAS</h3></a>

At various times in your MAAS network, you may need to set up a bridge to connect between your machines and MAAS, as shown in this section.

[note]
It's essential to enforce usage of IP addresses to avoid domain name conflicts, should different controllers resolve the same domain name with different IP addresses. You should also avoid using 127.0.0.1 when running multiple controllers, as it would confuse MAAS.
[/note]

rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui
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
rad-end 

rad-begin /deb/2.9/cli /deb/3.0/cli /deb/3.1/cli /snap/2.9/cli /snap/3.0/cli /snap/3.1/cli
You can use the MAAS CLI/API to configure a bridge via the following procedure:

1. Select the interface on which you wish to configure the bridge. This example uses the boot interface, since the boot interface must be connected to a MAAS controlled network -- but any interface is allowed:

        INTERFACE_ID=$(maas $PROFILE machine read $SYSTEM_ID | jq .boot_interface.id)

2. Create the bridge:

         BRIDGE_ID=$(maas $PROFILE interfaces create-bridge $SYSTEM_ID name=br0 parent=$INTERFACE_ID | jq .id)

3. Select the subnet where you want the bridge (this should be a MAAS controlled subnet):

        SUBNET_ID=$(maas $PROFILE subnets read | jq -r '.[] | select(.cidr == "10.0.0.0/24" and .managed == true).id')

4. Connect the bridge to the subnet:

          maas $PROFILE interface link-subnet $SYSTEM_ID $BRIDGE_ID subnet=$SUBNET_ID mode="STATIC" ip_address="10.0.0.101"

rad-end

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
