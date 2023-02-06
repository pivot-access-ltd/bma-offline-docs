<!-- "How to use controller tags" -->
This article will show you:

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]

- [How to discover the ID of your region controller(s)](#heading--discover-the-id-of-your-region-controllers)
- [How to assign tags to a region controller](#heading--assign-tags-to-a-region-controller)
- [How to remove tags from a region controller](#heading--remove-tags-from-a-region-controller)
- [How to list tags for all region controllers](#heading--list-tags-for-all-region-controllers)
- [How to view tags for one region controller](#heading--view-tags-for-one-region-controller)
- [How to discover the ID of your rack controller(s)](#heading--discover-the-id-of-your-rack-controllers)
- [How to assign tags to a rack controller](#heading--assign-tags-to-a-rack-controller)
- [How to remove tags from a rack controller](#heading--remove-tags-from-a-rack-controller)
- [How to list tags for all rack controllers](#heading--list-tags-for-all-rack-controllers)
- [How to view tags for one rack controller](#heading--view-tags-for-one-rack-controller)

<a href="#heading--discover-the-id-of-your-region-controllers"><h2 id="heading--discover-the-id-of-your-region-controllers">How to discover the ID of your region controller(s)</h2></a>

You can discover the ID of your region controller(s) with the following command:

```nohighlight
maas $PROFILE region-controllers read \
| jq -r '(["name","id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
| @tsv' | column -t
```

For example:

```nohighlight
maas admin region-controllers read \
| jq -r '(["name","id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
| @tsv' | column -t
```

Typical output would look something like this:

```nohighlight
name                         id
----                         --
bill-Lenovo-Yoga-C740-15IML  86xya8
```

<a href="#heading--assign-tags-to-a-region-controller"><h2 id="heading--assign-tags-to-a-region-controller">How to assign tags to a region controller</h2></a>

To add tags to a region controller, you can use a command of this form:

```nohighlight
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID
```

If you need to find the ID of your region controller(s), you can [look it up](#heading--discover-the-id-of-your-region-controllers).

For example:

```nohighlight
maas admin tag update-nodes virtual add=86xya8
```

This command produces output similar to the following:

```nohighlight
Success.
Machine-readable output follows:
{
    "added": 1,
    "removed": 0
}
```

You can check your work by [listing all tags for your region controllers](#heading--list-tags-for-all-region-controllers).

<a href="#heading--remove-tags-from-a-region-controller"><h2 id="heading--remove-tags-from-a-region-controller">How to remove tags from a region controller</h2></a>

To remove tags from a region controller, you can use a command like this:

```nohighlight
maas $PROFILE tag update-nodes $TAG_NAME remove=$SYSTEM_ID
```

If you need to find the ID of your region controller(s), you can [look it up](#heading--discover-the-id-of-your-region-controllers).

For example:

```nohighlight
maas admin tag update-nodes virtual remove=86xya8
```

This command produces output similar to the following:

```nohighlight
Success.
Machine-readable output follows:
{
    "added": 0,
    "removed": 1
}
```

You can check your work by [listing all tags for your region controllers](#heading--list-tags-for-all-region-controllers).

<a href="#heading--list-tags-for-all-region-controllers"><h2 id="heading--list-tags-for-all-region-controllers">How to list tags for all region controllers</h2></a>

To list tags for all region controllers, you can use a command similar to this:

```nohighlight
maas $PROFILE region-controllers read | jq -r '(["hostname","sysid","tags"]|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]]) | @tsv' | column -t
```

For example:

```nohighlight
maas admin region-controllers read | jq -r '(["hostname","sysid","tags"]|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]]) | @tsv' | column -t
```

This will produce output something like this:

```nohighlight
hostname                     sysid   tags
--------                     -----   ----
bill-Lenovo-Yoga-C740-15IML  86xya8  virtual  lxd-vm-host
```

<a href="#heading--view-tags-for-one-region-controller"><h2 id="heading--view-tags-for-one-region-controller">How to view tags for one region controller</h2></a>

To view tags for a specific region controller, you can try a command like this:

```nohighlight
maas $PROFILE region-controller read $SYSTEM_ID | jq -r '(["hostname","sysid","tags"]|(.,map(length*"-"))),([.hostname,.system_id,.tag_names[]]) | @tsv' | column -t
```

If you need to find the ID of your region controller(s), you can [look it up](#heading--discover-the-id-of-your-region-controllers).

For example:

```nohighlight
maas admin region-controller read 86xya8 \
| jq -r '(["hostname","sysid","tags"]
|(.,map(length*"-"))),([.hostname,.system_id,.tag_names[]])
| @tsv' | column -t
```

This should produce output similar to the following:

```nohighlight
hostname                     sysid   tags
--------                     -----   ----
bill-Lenovo-Yoga-C740-15IML  86xya8  virtual  lxd-vm-host
```



<a href="#heading--discover-the-id-of-your-rack-controllers"><h2 id="heading--discover-the-id-of-your-rack-controllers">How to discover the ID of your rack controller(s)</h2></a>

You can discover the ID of your rack controller(s) with the following command:

```nohighlight
maas $PROFILE rack-controllers read \
| jq -r '(["name","id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
| @tsv' | column -t
```

For example:

```nohighlight
maas admin rack-controllers read \
| jq -r '(["name","id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
| @tsv' | column -t
```

Typical output would look something like this:

```nohighlight
name                         id
----                         --
bill-Lenovo-Yoga-C740-15IML  86xya8
```

<a href="#heading--assign-tags-to-a-rack-controller"><h2 id="heading--assign-tags-to-a-rack-controller">How to assign tags to a rack controller</h2></a>

To add tags to a rack controller, you can use a command of this form:

```nohighlight
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID
```

If you need to find the ID of your rack controller(s), you can [look it up](#heading--discover-the-id-of-your-rack-controllers).

For example:

```nohighlight
maas admin tag update-nodes virtual add=86xya8
```

This command produces output similar to the following:

```nohighlight
Success.
Machine-readable output follows:
{
    "added": 1,
    "removed": 0
}
```

You can check your work by [listing all tags for your rack controllers](#heading--list-tags-for-all-rack-controllers).

<a href="#heading--remove-tags-from-a-rack-controller"><h2 id="heading--remove-tags-from-a-rack-controller">How to remove tags from a rack controller</h2></a>

To remove tags from a rack controller, you can use a command like this:

```nohighlight
maas $PROFILE tag update-nodes $TAG_NAME remove=$SYSTEM_ID
```

If you need to find the ID of your rack controller(s), you can [look it up](#heading--discover-the-id-of-your-rack-controllers).

For example:

```nohighlight
maas admin tag update-nodes virtual remove=86xya8
```

This command produces output similar to the following:

```nohighlight
Success.
Machine-readable output follows:
{
    "added": 0,
    "removed": 1
}
```

You can check your work by [listing all tags for your rack controllers](#heading--list-tags-for-all-rack-controllers).

<a href="#heading--list-tags-for-all-rack-controllers"><h2 id="heading--list-tags-for-all-rack-controllers">How to list tags for all rack controllers</h2></a>

To list tags for all rack controllers, you can use a command similar to this:

```nohighlight
maas $PROFILE rack-controllers read | jq -r '(["hostname","sysid","tags"]|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]]) | @tsv' | column -t
```

For example:

```nohighlight
maas admin rack-controllers read | jq -r '(["hostname","sysid","tags"]|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]]) | @tsv' | column -t
```

This will produce output something like this:

```nohighlight
hostname                     sysid   tags
--------                     -----   ----
bill-Lenovo-Yoga-C740-15IML  86xya8  virtual  lxd-vm-host
```

<a href="#heading--view-tags-for-one-rack-controller"><h2 id="heading--view-tags-for-one-rack-controller">How to view tags for one rack controller</h2></a>

To view tags for a specific rack controller, you can try a command like this:

```nohighlight
maas $PROFILE rack-controller read $SYSTEM_ID | jq -r '(["hostname","sysid","tags"]|(.,map(length*"-"))),([.hostname,.system_id,.tag_names[]]) | @tsv' | column -t
'''

If you need to find the ID of your rack controller(s), you can [look it up](#heading--discover-the-id-of-your-rack-controllers).

For example:

```nohighlight
maas admin rack-controller read 86xya8 \
| jq -r '(["hostname","sysid","tags"]
|(.,map(length*"-"))),([.hostname,.system_id,.tag_names[]])
| @tsv' | column -t
```

This should produce output similar to the following:

```nohighlight
hostname                     sysid   tags
--------                     -----   ----
bill-Lenovo-Yoga-C740-15IML  86xya8  virtual  lxd-vm-host
```
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
- [How to create and assign controller tags ](#heading--create-and-assign-controller-tags-)
- [How to remove and delete controller tags](#heading--remove-and-delete-controller-tags)
- [How to view controller tags](#heading--view-controller-tags)

<a href="#heading--create-and-assign-controller-tags-"><h2 id="heading--create-and-assign-controller-tags-">How to create and assign controller tags </h2></a>

To create and assign a controller tag:

1. Select *Controllers*.

2. Select the controller you wish to tag.

3. At the bottom left of the top card, select *Tags >*.

4. Select *Controller configuration >> Edit*.

5. Select the *Tags* field.

6. Enter a new tag(s) to assign it to the controller.

7. Select *Save changes* to register your new tag(s).

<a href="#heading--remove-and-delete-controller-tags"><h2 id="heading--remove-and-delete-controller-tags">How to remove and delete controller tags</h2></a>

To remove (and possibly delete) a controller tag:

1. Select *Controllers*.

2. Select the controller you wish to tag.

3. At the bottom left of the top card, select *Tags >*.

4. Select *Controller configuration >> Edit*.

5. Select the *Tags* field.

6. Select the *X* on the tag name to delete it.

7. Select *Save changes* to register your changes.

<a href="#heading--view-controller-tags"><h2 id="heading--view-controller-tags">How to view controller tags</h2></a>

1. Select *Controllers*.

2. Select the controller you wish to tag.

3. At the bottom left of the top card, view the *Tags >* associated with this controller.

4. Select *Cancel* to dismiss this screen.
[/tab]
[/tabs]
