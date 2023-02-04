<!-- "How to enable DHCP" -->
Management of DHCP and IP ranges is a key element of configuring and managing MAAS.  This article will help you learn:

- [How to manage MAAS DHCP](#heading--how-to-manage-maas-dhcp)
- [How to manage IP ranges](#heading--how-to-manage-ip-ranges)

If you need it, you can find a [refresher on DHCP](/t/how-to-set-up-networks/6174#heading--Its-always-DHCP) as part of this documentation set.

<a href="#heading--how-to-manage-maas-dhcp"><h2 id="heading--how-to-manage-maas-dhcp">How to manage MAAS DHCP</h2></a>

MAAS enlists and commissions machines through the use of its [load-balancing DHCP server](/t/how-to-enable-high-availability/5120#heading--dhcp-ha) running on an untagged VLAN. Although this MAAS-managed DHCP can also be part of the deploy phase, an external DHCP server can optionally be used instead for this purpose. If MAAS detects an external DHCP server, it will display it on the rack controller's page, accessible by selecting 'Controllers' from the top menu in the web UI.

In addition, the machine subnet is usually on the untagged VLAN. If not, you will need to route DHCP packets between the subnet and the MAAS-provided DHCP subnet. It is also possible to forward DHCP traffic from one VLAN to another using an external DHCP relay service.

This documentation presupposes that MAAS-managed DHCP is used to enlist and commission machines.  Using an external DHCP server for enlistment and commissioning may work, but note that this is not supported. MAAS cannot manage an external DHCP server, nor can it keep leases synchronised when you return a machine to the pool.

This article will help you learn:

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
- [How to enable MAAS-managed DHCP](#heading--enabling-dhcp)
- [How to resolve IP conflicts](#heading--resolving-ip-conflicts)
- [How to extend a reserved dynamic IP range](#heading--extending-a-reserved-dynamic-ip-range)
- [How to configure external DHCP](#heading--external-dhcp-and-a-reserved-ip-range)
- [How to use a DHCP relay](#heading--dhcp-relay)
- [How to customise MAAS with DHCP snippets](#heading--dhcp-snippets)
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
- [How to enable MAAS-managed DHCP](#heading--enabling-dhcp)
- [How to resolve IP conflicts](#heading--resolving-ip-conflicts)
- [How to extend a reserved dynamic IP range](#heading--extending-a-reserved-dynamic-ip-range)
- [How to configure external DHCP](#heading--external-dhcp-and-a-reserved-ip-range)
- [How to use a DHCP relay](#heading--dhcp-relay)
- [How to customise MAAS with DHCP snippets](#heading--dhcp-snippets)
- [How to list DHCP snippets](#heading--list-snippets)
- [How to update a DHCP snippet](#heading--update-a-snippet)
- [How to enable or disable a DHCP snippet](#heading--enable-or-disable-a-snippet)
- [How to delete a DHCP snippet](#heading--delete-a-snippet)
- [How to create an A or AAAA record in DNS](#heading--create-an-a-or-aaaa-record-in-dns)
- [How to create an alias (CNAME) record in DNS](#heading--create-an-alias-cname-record-in-dns)
- [How to create a Mail Exchange pointer record in DNS](#heading--create-a-mail-exchange-pointer-record-in-dns)
- [How to set a DNS forwarder](#heading--set-a-dns-forwarder)
[/tab]
[/tabs]

<a href="#heading--enabling-dhcp"><h3 id="heading--enabling-dhcp">How to enable MAAS-managed DHCP</h3></a>

MAAS-managed DHCP needs a reserved dynamic IP range to enlist and commission machines. You should create such a range when you are enabling DHCP with the web UI.

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To enable MAAS-managed DHCP:

1. Select *Subnets*.

2. Select the desired VLAN.

3. Select *Configure DHCP*.  You will see a new screen.

4. The options *MAAS provides DHCP* and *Provide DHCP from a rack controller* will be pre-selected.

5. If you accept these options, you may need to choose a *Rack controller*.

6. If you choose *Relay to another VLAN*, you will need to choose the target VLAN.

7. Under *Reserved dynamic range*, you may have to select a subnet from the dropdown.

8. You will need to select *Configure DHCP* for your changes to be registered with MAAS.

[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To enable DHCP on a VLAN on a certain fabric:

``` nohighlight
maas $PROFILE vlan update $FABRIC_ID $VLAN_TAG dhcp_on=True \
    primary_rack=$PRIMARY_RACK_CONTROLLER
```

To enable DHCP HA, you will need both a primary and a secondary controller:

``` nohighlight
maas $PROFILE vlan update $FABRIC_ID $VLAN_TAG dhcp_on=True \
    primary_rack=$PRIMARY_RACK_CONTROLLER \
    secondary_rack=$SECONDARY_RACK_CONTROLLER 
```

[note]
You must enable DHCP for PXE booting on the 'untagged' VLAN.
[/note]

You will also need to set a default gateway:

``` nohighlight
maas $PROFILE subnet update $SUBNET_CIDR gateway_ip=$MY_GATEWAY
```

[/tab]
[/tabs]

<a href="#heading--resolving-ip-conflicts"><h4 id="heading--resolving-ip-conflicts">How to resolve IP conflicts</h4></a>

In some cases, MAAS manages a subnet that is not empty, which could result in MAAS assigning a duplicate IP address.  MAAS is capable of detecting IPs in use on a subnet.  Be aware that there are two caveats:

1. If a previously-assigned NIC is in a quiescent state or turned off, MAAS may not detect it before duplicating an IP address.

2. At least one rack controller must have access to the IP-assigned machine in order for this feature to work.

MAAS also recognises when the subnet ARP cache is full, so that it can re-check the oldest IPs added to the cache to search for free IP addresses.

<a href="#heading--extending-a-reserved-dynamic-ip-range"><h3 id="heading--extending-a-reserved-dynamic-ip-range">How to extend a reserved dynamic IP range</h3></a>

If necessary, it is possible to add further portions of the subnet to the dynamic IP range (see [below](#heading--how-to-manage-ip-ranges)). Furthermore, since you enabled DHCP on a VLAN basis and a VLAN can contain multiple subnets, it is possible to add a portion from those subnets as well. Just select the subnet under the 'Subnets' page and reserve a dynamic range. DHCP will be enabled automatically.

<a href="#heading--external-dhcp-and-a-reserved-ip-range"><h3 id="heading--external-dhcp-and-a-reserved-ip-range">How to configure external DHCP</h3></a>

If an external DHCP server is used to deploy machines, then a reserved IP range should be created to prevent the address namespace from being corrupted. For instance, address conflicts may occur if you set a machine's IP assignment mode to 'Auto assign' in the context of an external DHCP server. See [below](#heading--how-to-manage-ip-ranges) to create such a range. It should correspond to the lease range of the external server.

<a href="#heading--dhcp-relay"><h3 id="heading--dhcp-relay">How to use a DHCP relay</h3></a>

You should not enable DHCP relays in MAAS without sufficient planning.  In particular, MAAS does not provide the actual relay. It must be set up as an external service by the administrator. What MAAS does provide is the DHCP configuration that MAAS-managed DHCP requires in order to satisfy any client requests relayed from another VLAN.

To relay from one VLAN (source) to another VLAN (target):

1.  Ensure the target VLAN has DHCP enabled.

2.  Set up the external relay. This relay is set up independently from MAAS. See [DHCP relay](/t/maas-glossary/5246#heading--dhcp-relay) for software suggestions.

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
3.  Configure MAAS-managed DHCP. Navigate to the source VLAN page and select the 'Relay DHCP' action. Fill in the fields in the resulting form. The crucial setting is the target VLAN ('Relay VLAN'). Press the 'Relay DHCP' button to finish.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
3. To relay DHCP traffic for a VLAN (source) through another VLAN (target):

``` nohighlight
maas $PROFILE vlan update $FABRIC_ID $VLAN_VID_SRC relay_vlan=$VLAN_ID_TARGET
```

For example, to relay VLAN with vid 0 (on fabric-2) through VLAN with id 5002 :

``` nohighlight
maas $PROFILE vlan update 2 0 relay_van=5002
```

[/tab]
[/tabs]

<a href="#heading--dhcp-snippets"><h3 id="heading--dhcp-snippets">How to customise MAAS with DHCP snippets</h3></a>

[tabs]
[tab version="v3.3 Snap" view="UI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/snap/maas/common/maas/dhcpd.conf` or `/var/snap/maas/common/maas/dhcpd6.conf`. Be aware that if you edit these files directly, you will need to `sudo` to `root`, as there is no `maas` user in the snap (all relevant files are owned by `root`). For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.3 Packages" view="CLI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/lib/maas/dhcpd.conf` or `/var/lib/maas/dhcpd6.conf`. For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]

[tab version="v3.2 Snap" view="UI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/snap/maas/common/maas/dhcpd.conf` or `/var/snap/maas/common/maas/dhcpd6.conf`. Be aware that if you edit these files directly, you will need to `sudo` to `root`, as there is no `maas` user in the snap (all relevant files are owned by `root`). For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.2 Packages" view="CLI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/lib/maas/dhcpd.conf` or `/var/lib/maas/dhcpd6.conf`. For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.1 Snap" view="UI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/snap/maas/common/maas/dhcpd.conf` or `/var/snap/maas/common/maas/dhcpd6.conf`. Be aware that if you edit these files directly, you will need to `sudo` to `root`, as there is no `maas` user in the snap (all relevant files are owned by `root`). For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.1 Packages" view="CLI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/lib/maas/dhcpd.conf` or `/var/lib/maas/dhcpd6.conf`. For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.0 Snap" view="UI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/snap/maas/common/maas/dhcpd.conf` or `/var/snap/maas/common/maas/dhcpd6.conf`. Be aware that if you edit these files directly, you will need to `sudo` to `root`, as there is no `maas` user in the snap (all relevant files are owned by `root`). For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v3.0 Packages" view="CLI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/lib/maas/dhcpd.conf` or `/var/lib/maas/dhcpd6.conf`. For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v2.9 Snap" view="UI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/snap/maas/common/maas/dhcpd.conf` or `/var/snap/maas/common/maas/dhcpd6.conf`. Be aware that if you edit these files directly, you will need to `sudo` to `root`, as there is no `maas` user in the snap (all relevant files are owned by `root`). For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[tab version="v2.9 Packages" view="CLI"]
When MAAS manages DHCP, you customise it through the use of DHCP snippets. These are user-defined configuration options that can be applied either globally, per subnet, or per machine. You apply a global snippet to all VLANs, subnets, and machines. All three types end up in `/var/lib/maas/dhcpd.conf` or `/var/lib/maas/dhcpd6.conf`. For information on what options to use, refer to the [`dhcpd.conf` man page](http://manpages.ubuntu.com/cgi-bin/search.py?q=dhcpd.conf)`↗`.
[/tab]
[/tabs]

[note]
Modifications made directly to `dhcpd.conf.template` or `dhcpd6.conf.template` are not supported.
[/note]

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To manage snippets:

1. Make sure you are logged in as an administrator.

2. Select *Settings >> DHCP snippets*.

To search DHCP snippets, enter the text to match in *Search DHCP snippets*.  MAAS will progressively update the list of snippets as you type your search terms.

To add a snippet:

1. Select *Add snippet*.

2. Enter the *Snippet name*.

3. Optionally, check *Enabled* to enable the snippet now.  Note that MAAS will not apply the snippet unless it is enabled.

4. Optionally, enter a *Description* for the snippet.

5. Optionally, choose a *Type* for the snippet from the dropdown (defaults to *Global*).  This parameter sets the scope of the snippet.  Note that if you choose a type other than global, you may need to choose the specific scope.  For example, if you choose the *Subnet* type, you must identify the specific subnet to which this snippet applies.

6. Enter the *DHCP snippet*.  This is not validated on entry.

7. Select *Save snippet* to register your changes with MAAS

To edit a snippet, select the pencil icon to the right of the snippet row and edit the fields as desired.

To delete a snippet, select the trash can icon to the right of the snippet.  You will be asked to confirm; be aware that once confirmed, this action cannot be undone.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
When you create a snippet, MAAS enables it by default.

To create a **global** snippet:

``` nohighlight
maas $PROFILE dhcpsnippets create name=$DHCP_SNIPPET_NAME \
    value=$DHCP_CONFIG description=$DHCP_SNIPPET_DESCRIPTION \
    global_snippet=true
```

To create a **subnet** snippet:

``` nohighlight
maas $PROFILE dhcpsnippets create name=$DHCP_SNIPPET_NAME \
    value=$DHCP_CONFIG description=$DHCP_SNIPPET_DESCRIPTION \
    subnet=$SUBNET_ID
```

You can also specify subnets in CIDR format.

To create a **node** snippet:

``` nohighlight
maas $PROFILE dhcpsnippets create name=$DHCP_SNIPPET_NAME \
    value=$DHCP_CONFIG description=$DHCP_SNIPPET_DESCRIPTION \
    node=$NODE_ID
```

You can also use a hostname instead of the node ID.

<a href="#heading--list-snippets"><h4 id="heading--list-snippets">How to list DHCP snippets</h4></a>

To list all snippets (and their characteristics) in the MAAS:

``` nohighlight
maas $PROFILE dhcpsnippets read
```

To list a specific snippet:

``` nohighlight
maas $PROFILE dhcpsnippet read id=$DHCP_SNIPPET_ID
```

The snippet name can also be used instead of its ID:

``` nohighlight
maas $PROFILE dhcpsnippet read name=$DHCP_SNIPPET_NAME
```

<a href="#heading--update-a-snippet"><h4 id="heading--update-a-snippet">How to update a DHCP snippet</h4></a>

Update a snippet attribute:

``` nohighlight
maas $PROFILE dhcpsnippet update $DHCP_SNIPPET_ID <option=value>
```

You can also use a snippet name instead of its ID.

<a href="#heading--enable-or-disable-a-snippet"><h4 id="heading--enable-or-disable-a-snippet">How to enable or disable a DHCP snippet</h4></a>

Enabling and disabling a snippet is considered a snippet update and is done via a Boolean option ('true' or 'false'). You can disable a snippet like this:

``` nohighlight
maas $PROFILE dhcpsnippet update $DHCP_SNIPPET_ID enabled=false
```

When you disable a snippet, MAAS removes the text you added to the dhcpd.conf file when you created the snippet.

<a href="#heading--delete-a-snippet"><h4 id="heading--delete-a-snippet">How to delete a DHCP snippet</h4></a>

To delete a snippet:

``` nohighlight
maas $PROFILE dhcpsnippet delete $DHCP_SNIPPET_ID
```

You can also use a snippet name in place of its ID.

<a href="#heading--set-dns-parameters"><h3 id="heading--set-dns-parameters">How to set DNS parameters</h3></a>

It is possible to set DNS parameters using the MAAS CLI, using the following instructions.

<a href="#heading--create-an-a-or-aaaa-record-in-dns"><h4 id="heading--create-an-a-or-aaaa-record-in-dns">How to create an A or AAAA record in DNS</h4></a>

An administrator can create an A record when creating a DNS resource with an IPv4 address.

``` nohighlight
mass $PROFILE dnsresources create fqdn=$HOSTNAME.$DOMAIN ip_addresses=$IPV4ADDRESS
```

An administrator can create an AAAA record when creating a DNS resource with an IPv6 address.

``` nohighlight
mass $PROFILE dnsresources create fqdn=$HOSTNAME.$DOMAIN ip_addresses=$IPV6ADDRESS
```

<a href="#heading--create-an-alias-cname-record-in-dns"><h4 id="heading--create-an-alias-cname-record-in-dns">How to create an alias (CNAME) record in DNS</h4></a>

An administrator can set a DNS Alias (CNAME record) to an already existing DNS entry of a machine.

``` nohighlight
mass $PROFILE dnsresource-records create fqdn=$HOSTNAME.$DOMAIN rrtype=cname rrdata=$ALIAS
```

For example, to set `webserver.maas.io` to alias to `www.maas.io`:

``` nohighlight
maas $PROFILE dnsresource-records create fqdn=webserver.maas.io rrtype=cname rrdata=www
```

<a href="#heading--create-a-mail-exchange-pointer-record-in-dns"><h4 id="heading--create-a-mail-exchange-pointer-record-in-dns">How to create a Mail Exchange pointer record in DNS</h4></a>

An administrator can set a DNS Mail Exchange pointer record (MX and value) to a domain.

``` nohighlight
maas $PROFILE dnsresource-records create fqdn=$DOMAIN rrtype=mx rrdata='10 $MAIL_SERVER.$DOMAIN'
```

For example, to set the domain.name managed by MAAS to have an MX record and that you own the domain:

``` nohighlight
maas $PROFILE dnsresource-records create fqdn=maas.io rrtype=mx rrdata='10 smtp.maas.io'
```

<a href="#heading--set-a-dns-forwarder"><h3 id="heading--set-a-dns-forwarder">How to set a DNS forwarder</h3></a>

To set a DNS forwarder:

``` nohighlight
maas $PROFILE maas set-config name=upstream_dns value=$MY_UPSTREAM_DNS
```

[/tab]
[/tabs]

<a href="#heading--how-to-manage-ip-ranges"><h2 id="heading--how-to-manage-ip-ranges">How to manage IP ranges</h2></a>

In MAAS-managed networks, you can further manage your subnets with a reserved range of IP addresses.  You can reserve IP addresses by adding one or more reserved ranges to a subnet configuration. You can define two types of ranges: reserved ranges and reserved dynamic ranges.  

A reserved range operates differently depending on whether the subnet is managed or unmanaged.  For a managed (subnet), MAAS will never assign IP addresses inside this range.  You can use this range for anything, such as infrastructure systems, network hardware, external DHCP, or an OpenStack namespace.  For an unmanaged (subnet), MAAS will only assign IP addresses inside this range -- but MAAS can assign any IP within this range.

A reserved dynamic range is used by MAAS for enlisting, commissioning and, if enabled, MAAS-managed DHCP on the machine's VLAN during commissioning and deployment. If created with the Web UI, an initial range is created as part of the DHCP enablement process. MAAS never uses IP addresses from this range for an unmanaged subnet.

This section gives specific instructions about creating and managing IP ranges; it will help you learn:

- [How to create an IP range](#heading--create-a-range)
- [How to edit an existing IP range](#heading--edit-a-range)
- [How to delete an existing IP range](#heading--delete-a-range)

<a href="#heading--create-a-range"><h3 id="heading--create-a-range">How to create an IP range</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]

To create an IP range:

1. Select *Subnets*.

2. In the *SUBNET* column, choose the subnet for which you want to create an IP range.

3. Scroll down to *Reserved ranges*.

4. Select *Reserve range* and choose either *Reserve range* or *Reserve dynamic range*. Note that if you choose a dynamic range, MAAS will automatically provide DHCP for enlistment and commissioning provided that the associated VLAN has DHCP enabled. 

5. A window will appear, allowing you to enter a *Start IP address* and *End IP address*

6. If you didn't select a dynamic range, you may optionally enter a *Purpose* for the range.

6. Select *Reserve* to register your choices with MAAS.

To edit an IP range, click on the pencil icon to the right of a range and make changes as desired.  Be sure to *Save* your changes.

To delete an IP range, click on the trash can icon to the right of a range.  You will be asked to confirm by selecting *Delete*; there is no undo.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
See [Concepts and terms](/t/maas-glossary/5416#heading--ip-ranges) for an explanation of the two kinds of reserved IP ranges MAAS uses.

To create a range of dynamic IP addresses that will be used by MAAS for node enlistment, commissioning, and possibly deployment:

``` bash
maas $PROFILE ipranges create type=dynamic \
    start_ip=$IP_DYNAMIC_RANGE_LOW end_ip=$IP_DYNAMIC_RANGE_HIGH \
    comment='This is a reserved dynamic range'
```

To create a range of IP addresses that will not be used by MAAS:

``` bash
maas $PROFILE ipranges create type=reserved \
    start_ip=$IP_STATIC_RANGE_LOW end_ip=$IP_STATIC_RANGE_HIGH \
    comment='This is a reserved range'
```

To reserve a single IP address that will not be used by MAAS:

``` bash
maas $PROFILE ipaddresses reserve ip_address=$IP_STATIC_SINGLE
```

To remove such a single reserved IP address:

``` bash
maas $PROFILE ipaddresses release ip=$IP_STATIC_SINGLE
```

[/tab]
[/tabs]

<a href="#heading--edit-a-range"><h3 id="heading--edit-a-range">How to edit an existing IP range</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
Click the 'Menu' button at the far right of the row corresponding to the subnet in question and select 'Edit reserved range' from the menu that appears. Edit the fields as desired and click the 'Save' button.

<a href="#heading--delete-a-range"><h3 id="heading--delete-a-range">How to delete an existing IP range</h3></a>

Select 'Remove range' from the menu that appears when clicking the 'Menu' button at the far right of the row corresponding to the subnet in question.

[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To edit an IP range, first find the ID of the desired IP range with the command:

```
maas admin ipranges read
```

Examine the JSON output to find the ID corresponding to the IP range you want to edit, then enter:

```
maas admin iprange update $ID start_ip="<start ip>" end_ip="<end ip>" comment="freeform comment"
```

This command will update the IP range associated with $ID.
[/tab]
[/tabs]
