<!-- "How to use storage tags" -->
This article explains:

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
- [How to create and assign block device tags](#heading--create-and-assign-block-device-tags)
- [How to remove and delete block device tags](#heading--remove-and-delete-block-device-tags)
- [How to list block device and partition tags](#heading--list-block-device-and-partition-tags)
- [How to view block device tags](#heading--view-block-device-tags)
- [How to view partition tags](#heading--view-partition-tags)

<a href="#heading--create-and-assign-block-device-tags"><h2 id="heading--create-and-assign-block-device-tags">How to create and assign block device tags</h2></a>

In order to create and assign tags to a block device, the device has to be in an "available" state, with no active partitions. To create and assign tags to block devices:

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select that machine that has the block-device you want to tag:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png"></a>

3. Click on the "Storage" tab and focus on the block labelled "Available disks and partitions:"

<a href="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png"></a>

4. Click the drop-down arrow at the right end of the row containing the block device you want to tag. Choose the "Edit..." option (the wording may vary, e.g, "Edit physical..."). This will take you to an editing screen for that block device:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/2912877532c3ea0b744ff3c88c7ef2046598bebc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/2912877532c3ea0b744ff3c88c7ef2046598bebc.png"></a>

5. Add tags as desired.

6. Be sure to click on the "Save" button when you're done.

<a href="#heading--remove-and-delete-block-device-tags"><h2 id="heading--remove-and-delete-block-device-tags">How to remove and delete block device tags</h2></a>

In order to remove tags from a block device, the device has to be in an "available" state, with no active partitions. To remove and delete tags from a block devices:

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select that machine that has the block-device with the tag you want to remove:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png"></a>

3. Click on the "Storage" tab and focus on the block labelled "Available disks and partitions:"

<a href="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png"></a>

4. Click the drop-down arrow at the right end of the row containing the block device you want to tag. Choose the "Edit..." option (the wording may vary, e.g, "Edit physical..."). This will take you to an editing screen for that block device:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/2912877532c3ea0b744ff3c88c7ef2046598bebc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/2912877532c3ea0b744ff3c88c7ef2046598bebc.png"></a>

5. Delete tags by clicking the "X" next to them.

6. Be sure to click on the "Save" button when you're done.

<a href="#heading--list-block-device-and-partition-tags"><h2 id="heading--list-block-device-and-partition-tags">How to list block device and partition tags</h2></a>

To see block device and partition tags in the UI, you can list all storage links by using the filter tool on the machine list.  Here's how:

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select the "Filters" drop-down and open the section titled "Storage tags:"

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c03216c0c2b6097f73b8161922b602aac4fdc3d6.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c03216c0c2b6097f73b8161922b602aac4fdc3d6.png"></a>

Here you will see a list of all block device and partition tags currently assigned to machines in this MAAS.  If you wish to filter the machine list by a given tag, just make sure that it's checked (and other storage tags unchecked) in the filter list.

<a href="#heading--view-block-device-tags"><h2 id="heading--view-block-device-tags">How to view block device tags</h2></a>

To view all tags associated with block devices on a given machine:

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select that machine that has the block device that interests you:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png"></a>

3. Click on the "Storage" tab and check the page for tags:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/feb789078b8f5f2f6f23acc056f8c037381d2cfc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/feb789078b8f5f2f6f23acc056f8c037381d2cfc.png"></a>

<a href="#heading--view-partition-tags"><h2 id="heading--view-partition-tags">How to view partition tags</h2></a>

To view all tags associated with partitions on a given machine:

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select that machine that has the block device that interests you:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png"></a>

3. Click on the "Storage" tab and check the page for tags:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/feb789078b8f5f2f6f23acc056f8c037381d2cfc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/feb789078b8f5f2f6f23acc056f8c037381d2cfc.png"></a>

[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]

- [How to discover the ID of your block device](#heading--discover-the-id-of-your-block-device) 
- [How to assign tags to a block device](#heading--assign-tags-to-a-block-device)
- [How to remove tags from a block device](#heading--remove-tags-from-a-block-device)
- [How to list tags for all block devices](#heading--list-tags-for-all-block-devices)
- [How to view tags for one block device](#heading--view-tags-for-one-block-device)
- [How to discover the ID of your partition](#heading--discover-the-id-of-your-partition)
- [How to assign tags to a partition](#heading--assign-tags-to-a-partition)
- [How to remove tags from a partition](#heading--remove-tags-from-a-partition)
- [How to list tags for all partitions](#heading--list-tags-for-all-partitions)
- [How to view tags for one partition](#heading--view-tags-for-one-partition)

<a href="#heading--discover-the-id-of-your-block-device"><h2 id="heading--discover-the-id-of-your-block-device">How to discover the ID of your block device</h2></a>

Block devices do not exist apart from the physical or virtual machines to which they are attached.  Finding the ID of the block device that interests you requires starting with a particular machine, in a command form that looks like this:

```nohighlight
maas $PROFILE block-devices read $SYSTEM_ID \
| jq -r '(["system_id","block_device_id","path","avail_size"]
|(.,map(length*"-"))),(.[]|[.system_id,.id,.path,.available_size])
| @tsv' | column -t
```

For example:

```nohighlight
maas admin block-devices read qk4b3g \
| jq -r '(["system_id","block_device_id","path","avail_size"]
|(.,map(length*"-"))),(.[]|[.system_id,.id,.path,.available_size])
| @tsv' | column -t
```

This example would produce output that looks something like this:

```nohighlight
system_id  block_device_id  path                    avail_size
---------  ---------------  ----                    ----------
qk4b3g     10               /dev/disk/by-dname/sda  0
```

The `path` component is printed to help you confirm that you are choosing the right block device, when there are several present.  The `avail-size` column will tell you whether you can operate on that block device at all: If the available size is "0," for example, you can't set a block device tag on any part of that drive.  Instead, you'd want to see something like this:

```nohighlight
system_id  block_device_id  path                    avail_size
---------  ---------------  ----                    ----------
xn8taa     8                /dev/disk/by-dname/sda  1996488704
```

<a href="#heading--assign-tags-to-a-block-device"><h2 id="heading--assign-tags-to-a-block-device">How to assign tags to a block device</h2></a>

You can only assign tags to a block device that is available. You can find out whether the block device is available at all when you [discover its ID](#heading--discover-the-id-of-your-block-device).

To assign an existing tag to a block device, you would type a command formulated like this:

```nohighlight
maas $PROFILE block-device add-tag $SYSTEM_ID $BLOCK_DEVICE_ID tag=$TAG_NAME
```

If you're not sure about the ID of your block device, you can [look it up](#heading--discover-the-id-of-your-block-device).

For example:

```nohighlight
maas admin block-device add-tag xn8taa 8 tag=farquar
```

If this command succeeds, it will display `Success`, followed by a JSON sequence describing the new state of the block device.

Note that if you try to add a tag to a block device that is not available, that is, to a block device that is in use, you will get a result like this:

```nohighlight
Not Found
```

<a href="#heading--remove-tags-from-a-block-device"><h2 id="heading--remove-tags-from-a-block-device">How to remove tags from a block device</h2></a>

You can only remove tags from a block device that is available. You can find out whether the block device is available at all when you [discover its ID](#heading--discover-the-id-of-your-block-device).

To remove an assigned tag from a block device, you would type a command formulated like this:

```nohighlight
maas $PROFILE block-device remove-tag $SYSTEM_ID $BLOCK_DEVICE_ID tag=$TAG_NAME
```

If you're not sure about the ID of your block device, you can [look it up](#heading--discover-the-id-of-your-block-device).

For example:

```nohighlight
maas admin block-device remove-tag xn8taa 8 tag=farquar
```

If this command succeeds, it will display `Success`, followed by a JSON sequence describing the new state of the block device.

Note that if you try to remove a tag from a block device that is not available, that is, from a block device that is in use, you will get a result like this:

```nohighlight
Not Found
```

<a href="#heading--list-tags-for-all-block-devices"><h2 id="heading--list-tags-for-all-block-devices">How to list tags for all block devices</h2></a>

To list tags for all block devices associated with a physical or virtual machine, you can use a command of this form:

```nohighlight
maas $PROFILE block-devices read $SYSTEM_ID | jq -r '(["id","tags"]|(.,map(length*"-"))),(.[]|[.id,.tags[]]) | @tsv' | column -t
```

For example:

```nohighlight
maas admin block-devices read xn8taa | jq -r '(["id","tags"]|(.,map(length*"-"))),(.[]|[.id,.tags[]]) | @tsv' | column -t
```

This command would produce output similar to this:

```nohighlight
id  tags
--  ----
8   hello  ssd  trinkoplinko
```

<a href="#heading--view-tags-for-one-block-device"><h2 id="heading--view-tags-for-one-block-device">How to view tags for one block device</h2></a>

To view tags for one specific block device, you can enter a command like this:

```nohighlight
maas $PROFILE block-device read $SYSTEM_ID $BLOCK_DEVICE_ID | jq -r '(["id","tags"]|(.,map(length*"-"))),([.id,.tags[]]) | @tsv' | column -t
```

If you're not sure about the ID of your block device, you can [look it up](#heading--discover-the-id-of-your-block-device).

For example:

```nohighlight
maas admin block-device read xn8taa 8 | jq -r '(["id","tags"]|(.,map(length*"-"))),([.id,.tags[]]) | @tsv' | column -t
```

This command would produce output similar to this:

```nohighlight
id  tags
--  ----
8   hello  ssd  trinkoplinko
9   20gig  ssd
10  250Gs  ssd
```


<a href="#heading--discover-the-id-of-your-partition"><h2 id="heading--discover-the-id-of-your-partition">How to discover the ID of your partition</h2></a>

Partitions do not exist apart from the block devices on which they reside.  Finding the ID of the partition that interests you requires starting with a particular machine and block device, similar to this command:

```nohighlight
maas $PROFILE partitions read $SYSTEM_ID $BLOCK_DEVICE_ID \
| jq -r '(["system_id","block_dev_id","part_id","path"]
|(.,map(length*"-"))),(.[]|[.system_id,.device_id,.id,.path])
|@tsv' | column -t
```

For example:

```nohighlight
maas admin partitions read xn8taa 8 \
| jq -r '(["system_id","block_dev_id","part_id","path"]
|(.,map(length*"-"))),(.[]|[.system_id,.device_id,.id,.path])
|@tsv' | column -t
 ```

This example would produce output that looks something like this:

```nohighlight
system_id  block_dev_id  part_id  path
---------  ------------  -------  ----
xn8taa     8             67       /dev/disk/by-dname/sda-part1
```

The `path` component is printed to help you confirm that you are choosing the right partition, when there are several present.  

<a href="#heading--assign-tags-to-a-partition"><h2 id="heading--assign-tags-to-a-partition">How to assign tags to a partition</h2></a>

You can only assign tags to a partition that is available.  To assign an existing tag to a partition, you would type a command formulated like this:

```nohighlight
maas $PROFILE partition add-tag $SYSTEM_ID $BLOCK_DEVICE_ID $PARTITION_ID tag=$TAG_NAME
```

If you're not sure about the ID of your partition, you can [look it up](#heading--discover-the-id-of-your-partition).

For example:

```nohighlight
maas admin partition add-tag xn8taa 8 67 tag=farquar
```

If this command succeeds, it will display `Success`, followed by a JSON sequence describing the new state of the partition.

Note that if you try to add a tag to a partition that is not available, that is, to a partition that is in use, you will get a result like this:

```nohighlight
Not Found
```

<a href="#heading--remove-tags-from-a-partition"><h2 id="heading--remove-tags-from-a-partition">How to remove tags from a partition</h2></a>

You can only remove tags from a partition that is available.  To remove a existing tag from a partition, you would type a command formulated like this:

```nohighlight
maas $PROFILE partition remove-tag $SYSTEM_ID $BLOCK_DEVICE_ID $PARTITION_ID tag=$TAG_NAME
```

If you're not sure about the ID of your partition, you can [look it up](#heading--discover-the-id-of-your-partition).

For example:

```nohighlight
maas admin partition remove-tag xn8taa 8 67 tag=farquar
```

If this command succeeds, it will display `Success`, followed by a JSON sequence describing the new state of the partition.

Note that if you try to remove a tag from a partition that is not available, that is, from a partition that is in use, you will get a result like this:

```nohighlight
Not Found
```

On the other hand, if you try to remove a tag that is not assigned to the partition you've chosen, MAAS will simply return `Success`, followed by a JSON sequence describing the current state of the partition.

<a href="#heading--list-tags-for-all-partitions"><h2 id="heading--list-tags-for-all-partitions">How to list tags for all partitions</h2></a>

To list tags for all partitions of a particular block device, use a command like this one:

```nohighlight
maas $PROFILE partitions read $SYSTEM_ID $BLOCK_DEVICE_ID \
| jq -r '(["id","tags"]
|(.,map(length*"-"))),(.[]|[.id,.tags[]])
| @tsv' | column -t
```

For example:

```nohighlight
maas admin partitions read xn8taa 8 \
| jq -r '(["id","tags"]
|(.,map(length*"-"))),(.[]|[.id,.tags[]])
| @tsv' | column -t
```

A command like this should return output similar to the following:

```nohighlight
id  tags
--  ----
54  farquar swap opendisk
67  foobar  farquar
97  foobar
```

<a href="#heading--view-tags-for-one-partition"><h2 id="heading--view-tags-for-one-partition">How to view tags for one partition</h2></a>

To view tags for one partition, enter a command similar to this:

```nohighlight
maas $PROFILE partition read $SYSTEM_ID $BLOCK_DEVICE_ID $PARTITION_ID | jq -r '(["id","tags"]|(.,map(length*"-"))),([.id,.tags[]]) | @tsv' | column -t
```

If you're not sure about the ID of your partition, you can [look it up](#heading--discover-the-id-of-your-partition).

For example:

```nohighlight
maas admin partition read xn8taa 8 67 | jq -r '(["id","tags"]|(.,map(length*"-"))),([.id,.tags[]]) | @tsv' | column -t
```

This command should produce output similar to this:

```nohighlight
id  tags
--  ----
67  foobar  farquar
```

[/tab]
[/tabs]