<!-- "How to manage machine interfaces" -->
This article will explain the following procedures related to machine interfaces:

* [How to edit machine interfaces](#heading--how-to-edit-interfaces")
* [How to create a bond interface](#heading--bond-interfaces)
* [How to create a bridge interface](#heading--bridge-interfaces)
* [How to delete an interface](#heading--delete-an-interface)
* [How to assign a network interface to a fabric](#heading--assign-a-network-interface-to-a-fabric)
* [How to discover interface identifiers](#heading--interface-identifiers)
* [How to create a VLAN interface](#heading--create-a-vlan-interface)
* [How to delete a VLAN interface](#heading--delete-a-vlan-interface)

<a href="#heading--how-to-edit-interfaces"><h2 id="heading--how-to-edit-interfaces">How to edit machines interfaces</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
From a machine's "Interfaces" page, click the menu icon for the interface to be edited and select "Edit Physical" from the resulting menu:

<a href="https://discourse.maas.io/uploads/default/original/1X/438475b8906736b45fc809cd105a56be5052397d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/438475b8906736b45fc809cd105a56be5052397d.png"></a>

The following window will appear:

<a href="https://discourse.maas.io/uploads/default/original/1X/70b21d256df52399ac7ab09c3051f4bf011da55e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/70b21d256df52399ac7ab09c3051f4bf011da55e.png"></a>

Four modes determine how a subnet address is assigned when MAAS deploys the machine. You can select one of these modes by clicking on the "IP mode" drop-down menu.

-   **Auto assign**: MAAS will assign a random static address (`iface eth0 inet static`). The pool of available addresses depends on whether the subnet is managed or unmanaged (see [Subnet management](/t/how-to-manage-networks/5164#heading--how-to-toggle-subnet-management)).

-   **Static assign**: The administrator will specify a static address using a secondary field.

-   **DHCP**: The machine leases a dynamic IP address, via either MAAS-managed DHCP or an external DHCP server.

-   **Unconfigured**: The interface is not configured.

Press the "Save" button to apply the changes.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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

See [Concepts and terms](/t/maas-concepts-and-terms-reference/5416#heading--ip-ranges) for the definitions of reserved range types.

<a href="#heading--bond-interfaces"><h2 id="heading--bond-interfaces">How to create a bond interface</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
A bond is created by selecting more than one interface and clicking the now-active "Create bond" button:

<a href="https://discourse.maas.io/uploads/default/original/1X/7dd772c961c9f6f871f657b0397646446a4e23e7.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/7dd772c961c9f6f871f657b0397646446a4e23e7.png"></a>

After clicking the "Create bond" button, the bond configuration pane will appear.

From the bond configuration pane, you can rename the bond, select a bond mode (see below), assign a MAC address to the aggregate device and attach one or more tags.

The interfaces aggregated into the bond interface are listed below the "Tags" field. Use the "Primary" column to select the interface to act as the primary device.

<a href="https://discourse.maas.io/uploads/default/original/1X/699a55f98f3e1a81da75d1595e40bb74c99aff8e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/699a55f98f3e1a81da75d1595e40bb74c99aff8e.png"></a>

You can select from the following bonding modes on the "Bond mode" drop-down menu:

-   **balance-rr**: Transmit packets in sequential order from the first available slave through to the last. This mode provides load balancing and fault tolerance.

-   **active-backup**: Only one slave in the bond is active. A different slave becomes active if, and only if, the active slave fails. The bond's MAC address is externally visible on only one port (network adaptor) to avoid confusing the switch.

-   **balance-xor**: Transmit based on the selected transmit hash policy. The default policy is simple, which means that an XOR operation selects packages.  This XOR compares the source MAC address and the resultant XOR between the destination MAC address, the packet type identifier, and the modulo slave count.

-   **broadcast**: Transmit everything on all slave interfaces. This mode provides fault tolerance.

-   **802.3ad**: Creates aggregation groups that share the same speed and duplex settings. This mode utilises all slaves in the active aggregation, following the IEEE 802.3ad specification.

-   **balance-tlb**: Adaptive transmit load balancing, channel bonding that does not require any special switch support.

-   **balance-alb**: Adaptive load balancing, includes balance-tlb plus receive load balancing (rlb) for IPV4 traffic. This mode does not require any special switch support.  ARP negotiation achieves load balancing in this case.

Press the "Save" button when you're done.

[note]
The MAC address defaults to the MAC address of the primary interface.
[/note]
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
A bond can be created with the following command:

```
maas $PROFILE interfaces create-bond $SYSTEM_ID name=$BOND_NAME \
parents=$IFACE1_ID mac_address=$MAC_ADDR \ 
parents=$IFACE2_ID bond_mode=$BOND_MODE \
bond_updelay=$BOND_UP bond_downdelay=$BOND_DOWN mtu=$MTU
```

Use the `parents` parameters to define which interfaces form the aggregate interface.

The `bond_updelay` and `bond_downdelay` parameters specify the number of milliseconds to wait before either enabling or disabling a slave after a failure has been detected.

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
| `bond_downdelay`| Optional integer.  Specifies the time, in milliseconds, to wait before disabling a slave after a link failure has been detected. |
| `bond_updelay`| Optional integer.  Specifies the time, in milliseconds, to wait before enabling a slave after a link recovery has been detected. |
| `bond_lacp_rate`| Optional string.  Option specifying the rate at which to ask the link partner to transmit LACPDU packets in 802.3ad mode. Available options are ``fast`` or ``slow``. (Default: ``slow``). |
| `bond_xmit_hash_policy`| Optional string.  The transmit hash policy to use for slave selection in balance-xor, 802.3ad, and tlb modes. Possible values are: ``layer2``, ``layer2+3``, ``layer3+4``, ``encap2+3``, ``encap3+4``. (Default: ``layer2``) |
| `bond_num_grat_arp`| Optional integer.  The number of peer notifications (IPv4 ARP or IPv6 Neighbour Advertisements) to be issued after a failover. (Default: 1) |
| `mtu`| Optional integer.  Maximum transmission unit. |
| `accept_ra`| Optional Boolean.  Accept router advertisements. (IPv6 only) |
| `autoconf`| Optional Boolean.  Perform stateless autoconfiguration. (IPv6 only) |
| `bond_mode`| Optional string.  The operating mode of the bond.  (Default: active-backup). |

Supported bonding modes include:

| Mode | Behaviour |
|:-----|:---------|
|  `balance-rr`:| Transmit packets in sequential order from the first available slave through the last. This mode provides load balancing and fault tolerance. |
|  `active-backup`| Only one slave in the bond is active. A different slave becomes active if, and only if, the active slave fails. The bond's MAC address is externally visible on only one port (network adaptor) to avoid confusing the switch. |
|  `balance-xor`| Transmit based on the selected transmit hash policy. The default policy is a simple [(source MAC address XOR'd with destination MAC address XOR packet type ID) modulo slave count]. |
|  `broadcast`| Transmits everything on all slave interfaces. This mode provides fault tolerance. |
|  `802.3ad`| IEEE 802.3ad dynamic link aggregation. Creates aggregation groups that share the same speed and duplex settings. Uses all slaves in the active aggregator according to the 802.3ad specification. |
|  `balance-tlb`| Adaptive transmit load balancing: channel bonding that does not require any special switch support. |
|  `balance-alb`| Adaptive load balancing: includes balance-tlb plus receive load balancing (rlb) for IPV4 traffic, and does not require any special switch support. The receive load balancing is achieved by ARP negotiation. |
[/tab]
[/tabs]

<a href="#heading--bridge-interfaces"><h2 id="heading--bridge-interfaces">How to create a bridge interface</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="https://discourse.maas.io/uploads/default/original/1X/83ef3d6f40d5b558396d96717dd2822fc1ce8b68.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/83ef3d6f40d5b558396d96717dd2822fc1ce8b68.png"></a>

Press the "Save" button when you're done.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
Please use the UI interface to create a bridge interface.  Select the "UI" dropdown above to see how.
[/tab]
[/tabs]

<a href="#heading--delete-an-interface"><h2 id="heading--delete-an-interface">How to delete an interface</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
An interface can only be deleted via the MAAS CLI.  Choose the "CLI" dropdown above to see how.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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

1. `name`: Optional string.  Name of the interface.

2. `mac_address`: Optional string.  MAC address of the interface.

3. `tags`: Optional string.  Tags for the interface.

4. `vlan`: Optional string.  VLAN the interface is connected to.

5. `parent`: Optional integer.  Parent interface id for this bridge interface.

6. `bridge_type`: Optional string.  The type of bridge to create. Possible values are: ``standard``, ``ovs``.

7. `bridge_stp`: Optional Boolean.  Turn spanning tree protocol on or off. (Default: False).

8. `bridge_fd`: Optional integer.  Set bridge forward delay to time seconds. (Default: 15).

9. `mtu`: Optional integer.  Maximum transmission unit.

10. `accept_ra`: Optional Boolean.  Accept router advertisements. (IPv6 only)

11. `autoconf`: Optional Boolean.  Perform stateless autoconfiguration. (IPv6 only)
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

<a href="#heading--assign-a-network-interface-to-a-fabric"><h2 id="heading--assign-a-network-interface-to-a-fabric">How to assign a network interface to a fabric</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
A network interface may be assigned to a fabric with the MAAS CLI only.  Choose the "CLI" dropdown above to see how.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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

<a href="#heading--interface-identifiers"><h2 id="heading--interface-identifiers">How to discover interface identifiers</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
Interface identifiers can only be discovered via the MAAS CLI.  Choose the "CLI" dropdown above to see how.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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

<a href="#heading--create-a-vlan-interface"><h2 id="heading--create-a-vlan-interface">How to create a VLAN interface</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
VLAN interfaces can only be created via the MAAS CLI. Select the "CLI" dropdown above to see how.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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

<a href="#heading--delete-a-vlan-interface"><h2 id="heading--delete-a-vlan-interface">How to delete a VLAN interface</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
VLAN interfaces can only be deleted via the MAAS CLI. Select the "CLI" dropdown above to see how.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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