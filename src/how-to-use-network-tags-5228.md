<!-- "How to use network tags" -->
This article will show you:

[tabs]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="UI"]
- [How to create and assign network interface tags](#heading--create-and-assign-network-interface-tags)
- [How to remove and delete network interface tags](#heading--remove-and-delete-network-interface-tags)
- [How to view network interface tags](#heading--view-network-interface-tags)

<a href="#heading--create-and-assign-network-interface-tags"><h2 id="heading--create-and-assign-network-interface-tags">How to create and assign network interface tags</h2></a>

To assign a tag to a network interface, use the following procedure:

1. Go to the machine list and select the machine where that interface resides, by clicking on that machine's name:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png"></a>

2. Click on the "Network" tab:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png"></a>

3. Choose the interface you'd like to tag, by selecting the checkbox next to its name:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png"></a>

The checkbox isn't strictly needed to apply the tag, but it helps prevent you from choosing the wrong one when multiple interfaces are available.

4. Select the drop-down under "ACTIONS" at the end of the row, and select "Edit Physical" to edit the parameters of the physical interface:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png"></a>

5. Edit the "Tags" field as desired.

6. Be sure to select the "Tag machine" button to apply your changes to the interface for that machine.

Note that different machines may have the same physical interface name, but different MAC addresses, so it's not typical that interface tags carry over from one machine to the next -- so auto complete menus will be sparse or non-existent most of the time for these tag types.

<a href="#heading--remove-and-delete-network-interface-tags"><h2 id="heading--remove-and-delete-network-interface-tags">How to remove and delete network interface tags</h2></a>

To remove a tag from a network interface, use the following procedure:

1. Go to the machine list and select the machine where that interface resides, by clicking on that machine's name:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png"></a>

2. Click on the "Network" tab:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png"></a>

3. Choose the interface you'd like to un-tag, by selecting the checkbox next to its name:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png"></a>

The checkbox isn't strictly needed to apply the tag, but it helps prevent you from choosing the wrong one when multiple interfaces are available.

4. Select the drop-down under "ACTIONS" at the end of the row, and select "Edit Physical" to edit the parameters of the physical interface:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png"></a>

5. Edit the "Tags" field as desired.

6. Be sure to select the "Tag machine" button to apply your changes to the interface for that machine.

Note that different machines may have the same physical interface name, but different MAC addresses, so it's not typical that interface tags carry over from one machine to the next -- so auto complete menus will be sparse or non-existent most of the time for these tag types.

<a href="#heading--view-network-interface-tags"><h2 id="heading--view-network-interface-tags">How to view network interface tags</h2></a>

To view the tags associated with a network interface, use the following procedure:

1. Go to the machine list and select the machine where that interface resides, by clicking on that machine's name:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png"></a>

2. Click on the "Network" tab:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png"></a>

3. Choose the interface you'd like to see, by selecting the checkbox next to its name:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png"></a>

The checkbox isn't strictly needed to apply the tag, but it helps prevent you from choosing the wrong one when multiple interfaces are available.

4. Select the drop-down under "ACTIONS" at the end of the row, and select "Edit Physical" to edit the parameters of the physical interface:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png"></a>

5. Be sure to cancel the operation when you're done.

Note that different machines may have the same physical interface name, but different MAC addresses, so it's not typical that interface tags carry over from one machine to the next.
[/tab]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="CLI"]
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
