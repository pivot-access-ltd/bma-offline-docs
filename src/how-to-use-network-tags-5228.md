<!-- "How to use network tags" -->
This article will show you:

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
- [How to create and assign network interface tags](#heading--create-and-assign-network-interface-tags)
- [How to remove and delete network interface tags](#heading--remove-and-delete-network-interface-tags)
- [How to view network interface tags](#heading--view-network-interface-tags)

<a href="#heading--create-and-assign-network-interface-tags"><h2 id="heading--create-and-assign-network-interface-tags">How to create and assign network interface tags</h2></a>

To assign a tag to a network interface:

1. Select *Machines*.

2. Select the machine where the desired interface is connected.

3. Select *Network*.

4. Select *Edit physical* in the dropdown at the end of the row for the desired interface.

5. Select the *Tags* field.

6. Enter a tag name to add it.

7. Select *Save interface* to register your changes.

Note that different machines may have the same physical interface name, but different MAC addresses, so it's not typical that interface tags carry over from one machine to the next -- so auto complete menus will be sparse or non-existent most of the time for these tag types.

<a href="#heading--remove-and-delete-network-interface-tags"><h2 id="heading--remove-and-delete-network-interface-tags">How to remove and delete network interface tags</h2></a>

To remove a tag from a network interface:

1. Select *Machines*.

2. Select the machine where the desired interface is connected.

3. Select *Network*.

4. Select *Edit physical* in the dropdown at the end of the row for the desired interface.

5. Select the *Tags* field.

6. Select the *X* on a tag to remove it.

7. Select *Save interface* to register your changes.

Note that different machines may have the same physical interface name, but different MAC addresses, so it's not typical that interface tags carry over from one machine to the next -- so auto complete menus will be sparse or non-existent most of the time for these tag types.

<a href="#heading--view-network-interface-tags"><h2 id="heading--view-network-interface-tags">How to view network interface tags</h2></a>

To view the tags associated with a network interface:

1. Select *Machines*.

2. Select the machine where the desired interface is connected.

3. Select *Network*.

4. Select *Edit physical* in the dropdown at the end of the row for the desired interface.

5. View the assigned tags in the *Tags* field.

6. Select *Cancel* to dismiss this screen when you're done.

Note that different machines may have the same physical interface name, but different MAC addresses, so it's not typical that interface tags carry over from one machine to the next.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
- [How to discover the ID of your network interface](#heading--discover-the-id-of-your-network-interface)
- [How to assign tags to a network interface](#heading--assign-tags-to-a-network-interface)
- [How to remove tags from a network interface](#heading--remove-tags-from-a-network-interface)
- [How to list tags for all network interfaces](#heading--list-tags-for-all-network-interfaces)
- [How to view tags for one network interface](#heading--view-tags-for-one-network-interface)

<a href="#heading--discover-the-id-of-your-network-interface"><h2 id="heading--discover-the-id-of-your-network-interface">How to discover the ID of your network interface</h2></a>

You can use a command of the following form to identify the interfaces associated with a particular device on your MAAS:

```nohighlight
maas $PROFILE interfaces read $SYSTEM_ID \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),(.[]|[.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

For example:

```nohighlight
maas admin interfaces read xn8taa \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),(.[]|[.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

This would produce output similar to the following:

```nohighlight
mac_address        type      id  tags
-----------        ----      --  ----
00:16:3e:18:7f:ee  physical  9   andrpko  plinko  cochise
```

<a href="#heading--assign-tags-to-a-network-interface"><h2 id="heading--assign-tags-to-a-network-interface">How to assign tags to a network interface</h2></a>

To assign a tag to a network interface, using both the device system ID and the interface ID, use a command of the following form:

```nohighlight
maas $PROFILE interface add-tag $SYSTEM_ID $INTERFACE_ID tag=$TAG_NAME
```

For example:

```nohighlight
maas admin interface add-tag xn8taa 9 tag=farquar
```

This command, if successful, will produce a long sequence of JSON describing the interface, including the changes introduced by the command above.  You can also check your work by [listing the tags](#heading--list-tags-for-all-network-interfaces) associated with the device.

<a href="#heading--remove-tags-from-a-network-interface"><h2 id="heading--remove-tags-from-a-network-interface">How to remove tags from a network interface</h2></a>

To remove a tag from a network interface, use both the device system ID and the interface ID in a command similar to this one:

```nohighlight
maas $PROFILE interface remove-tag $SYSTEM_ID $INTERFACE_ID tag=$TAG_NAME
```

For example:

```nohighlight
maas admin interface remove-tag xn8taa 9 tag=farquar
```

This command, if successful, will produce a long sequence of JSON describing the interface, including the changes introduced by the command above.  You can also check your work by [listing the tags](#heading--list-tags-for-all-network-interfaces) associated with the device.

<a href="#heading--list-tags-for-all-network-interfaces"><h2 id="heading--list-tags-for-all-network-interfaces">How to list tags for all network interfaces</h2></a>

To list all the tags for a given network interface on a given device, use a command like this one:

```nohighlight
maas $PROFILE interfaces read $SYSTEM_ID \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),(.[]|[.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

For example:

```nohighlight
maas admin interfaces read xn8taa \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),(.[]|[.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

This would produce output similar to the following:

```nohighlight
mac_address        type      id  tags
-----------        ----      --  ----
00:16:3e:18:7f:ee  physical  9   andrpko  plinko  cochise  farquar
```

<a href="#heading--view-tags-for-one-network-interface"><h2 id="heading--view-tags-for-one-network-interface">How to view tags for one network interface</h2></a>

To view tags for one particular network interface on a specific device, try a command formulated like this:

```nohighlight
maas $PROFILE interface read $SYSTEM_ID $INTERFACE_ID \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),([.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

For example:

```nohighlight
maas admin interface read xn8taa 9 \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),([.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

Typical output might look like this:

```nohighlight
mac_address        type      id  tags
-----------        ----      --  ----
00:16:3e:18:7f:ee  physical  9   andrpko  plinko  cochise
```
[/tab]
[/tabs]
