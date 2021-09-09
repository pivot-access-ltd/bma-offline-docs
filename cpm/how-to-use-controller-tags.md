This article will show you:

rad-begin     /snap/2.9/cli /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli
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
rad-end
rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
- [How to create and assign controller tags ](#heading--create-and-assign-controller-tags-)
- [How to remove and delete controller tags](#heading--remove-and-delete-controller-tags)
- [How to view controller tags](#heading--view-controller-tags)

<a href="#heading--create-and-assign-controller-tags-"><h2 id="heading--create-and-assign-controller-tags-">How to create and assign controller tags </h2></a>

To create and assign a controller tag, you can use the following procedure:

1. Click on the "Controllers" tab to open the controllers page:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png"></a>

2. Click on the hyperlinked name of the controller to which you want to assign tags.  You will see a screen with several cards, like this one:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png"></a>

3. Find the "Tags" card and click on "Edit."  You will be brought to that controller's "Configuration" tab.

4. Click on the "Edit" button for "Controller configuration."
You'll be presented with an editing screen similar to this one:
 
<a href="https://discourse.maas.io/uploads/default/original/2X/3/37401271d0ab3aa130127a251222e5eaf557b20c.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/37401271d0ab3aa130127a251222e5eaf557b20c.png"></a>

5.  Follow the [general procedure](#heading--create-and-assign-tags) to assign a tag to the controller.

<a href="#heading--remove-and-delete-controller-tags"><h2 id="heading--remove-and-delete-controller-tags">How to remove and delete controller tags</h2></a>

To remove (and possibly delete) a controller tag, you can use the following procedure:

1. Click on the "Controllers" tab to open the controllers page:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png"></a>

2. Click on the hyperlinked name of the controller to which you want to assign tags.  You will see a screen with several cards, like this one:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png"></a>

3. Find the "Tags" card and click on "Edit."  You will be brought to that controller's "Configuration" tab.

4. Click on the "Edit" button for "Controller configuration."
You'll be presented with an editing screen similar to this one:
 
<a href="https://discourse.maas.io/uploads/default/original/2X/3/37401271d0ab3aa130127a251222e5eaf557b20c.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/37401271d0ab3aa130127a251222e5eaf557b20c.png"></a>

5.  Follow the [general procedure](#heading--delete-and-remove-tags) to remove a tag from the controller.

<a href="#heading--view-controller-tags"><h2 id="heading--view-controller-tags">How to view controller tags</h2></a>

To view a list of tags assigned to a particular controller, you can use the following procedure:

1. Click on the "Controllers" tab to open the controllers page:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png"></a>

2. Click on the hyperlinked name of the controller of interest..  You will see a screen with several cards, like this one:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/00c569161f52ed83349e8ec9e63b65fa8215f89f.png"></a>

3. Find the "Tags" card; this card will list all the tags assigned to this controller.

rad-end
