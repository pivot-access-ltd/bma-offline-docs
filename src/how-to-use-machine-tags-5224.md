<!-- "How to use machine tags" -->
This article will explain:

[tabs]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="UI"]
- [How to create and assign machine tags to machines](#heading--create-and-assign-machine-tags-to-machines)
- [How to remove and delete machine tags from machines](#heading--remove-and-delete-machine-tags-from-machines)
- [How to list machine tags for multiple machines](#heading--list-machine-tags-for-multiple-machines)
- [How to view machine tags for one machine](#heading--view-machine-tags-for-one-machine)
- [How to view machine tags for a VM host](#heading--view-machine-tags-for-a-vm-host)

<a href="#heading--create-and-assign-machine-tags-to-machines"><h2 id="heading--create-and-assign-machine-tags-to-machines">How to create and assign machine tags to machines</h2></a>

If you want to create a new tag, and simultaneously assign it to a machine, use the following steps:

1. Go to the machine list and select the machine you're interested in modifying, by checking the box next to the machine name:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/86ee8529206fcfa297865198a55b976e1002b6bf.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/86ee8529206fcfa297865198a55b976e1002b6bf.png"></a>

2. Select the "Take action" drop-down menu and select "Tag":

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f77f19b7aef9f880c12a4d710b91cc3abdc03154.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f77f19b7aef9f880c12a4d710b91cc3abdc03154.png"></a>

3. Create and/or assign the desired tag, as described in the [general tagging procedure](#heading--create-and-assign-tags) above.

4. Don't forget to hit the "Tag machine" button when you're done, to apply your changes to the machine.

<a href="#heading--tag-multiple-machines"><h3 id="heading--tag-multiple-machines">How to tag multiple machines at once</h3></a>

In the first step of the above procedure, you can select more than one machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/0c04973e76012c780035a4ea11a588f341148445.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/0c04973e76012c780035a4ea11a588f341148445.png"></a>

Any tags you add in the "Tags" box will be applied to all selected machines, as noted by the change in the "Tag machine" button:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a503261eb7faa17478b09aa70f48f838b4b0fb87.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a503261eb7faa17478b09aa70f48f838b4b0fb87.png"></a>

Other than the scope of the transaction (e.g., tagging three machines, in this case), everything else about this operation conforms to the [general tag assignment procedure](#heading--create-and-assign-tags).

<a href="#heading--remove-and-delete-machine-tags-from-machines"><h2 id="heading--remove-and-delete-machine-tags-from-machines">How to remove and delete machine tags from machines</h2></a>

To remove machine tags from a machine:

1. View a machine's currently assigned tags: stay on the 'Machines' page and click on the machine in question. MAAS will display currently-assigned tags in the *Tags* pane of the 'Machine summary'.

2. Select the 'Configuration' tab and then the 'Edit' button alongside 'Machine configuration' to edit tags:

3. Follow the [general tag removal procedure](#heading--delete-and-remove-tags).

<a href="#heading--list-machine-tags-for-multiple-machines"><h2 id="heading--list-machine-tags-for-multiple-machines">How to list machine tags for multiple machines</h2></a>

In the MAAS UI, you don't explicitly list all machine tags; instead, you filter by them using the "Filter by" drop-down.  This filtered list does not distinguish between virtual machines (VMs) and physical machines, unless you've assigned tags to help with that distinction.

Here's how you can filter the machine list by machine tags, using the MAAS UI:

1. To list all tags, visit the 'Machines' tab and expand the 'Tags' subsection in the left pane. In this view, you can use tags as machine search filters.

2. Select one or several tags. The machines that satisfy all selected tags will display on the right pane. Notice there is a search field at the top of the right pane. You can type a search expression into this field.

Below, tag 'virtual' has been selected (with the mouse), and the search field automatically reflects this. Five machines satisfy this search filter.

<a href="https://assets.ubuntu.com/v1/69aa9997-nodes-tags__2.6-tags-filter.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/69aa9997-nodes-tags__2.6-tags-filter.png"></a>

Remove a tag from the search filter by either hitting the 'x' character alongside a tag or editing the search expression.

<a href="#heading--view-machine-tags-for-one-machine"><h2 id="heading--view-machine-tags-for-one-machine">How to view machine tags for one machine</h2></a>

To view the tags assigned to a specific machine, use the following procedure:

1. On the machine list, select the machine of interest by clicking on its name.

2. On the machine detail screen that comes up, look for the tags on one of the cards presented there: the tags for that machine should be listed there.

<a href="#heading--view-machine-tags-for-a-vm-host"><h2 id="heading--view-machine-tags-for-a-vm-host">How to view machine tags for a VM host</h2></a>

To view the machine tags assigned to a VM host, here's the procedure you'll follow:

1. Click on the KVM tab at the top of the screen.  This will bring you to a list of active KVMs for your system:

<a href="https://discourse.maas.io/uploads/default/original/2X/5/559f0ed9250524792fda93457bc1876304915599.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/5/559f0ed9250524792fda93457bc1876304915599.png"></a>

2. On the detail screen that comes up, choose the "Settings" tab at the top:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8c8454d576b4b49dd99c3f6c6bb2735252591010.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8c8454d576b4b49dd99c3f6c6bb2735252591010.png"></a>

3. In the settings tab, you'll see a box labelled "Tags."  You can use this box to view, assign, edit, or remove tags for the KVM:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e7953d2c5d153b82eac3cb1a3ba105ec194eb077.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e7953d2c5d153b82eac3cb1a3ba105ec194eb077.png"></a>

Note that you can only see the tags for a VM host in the same place that you change it.  For a more comprehensive list of VM host tags, use the MAAS CLI.

[/tab]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="CLI"]
- [How to assign machine tags to a machine](#heading--assign-machine-tags-to-a-machine)
- [How to remove machine tags from a machine](#heading--remove-machine-tags-from-a-machine)
- [How to list machine tags for all machines](#heading--list-machine-tags-for-all-machines)
- [How to view machine tags for one machine](#heading--view-machine-tags-for-one-machine)
- [How to discover your virtual machine host ID](#heading--discover-your-vm-host-id)
- [How to assign tags to a virtual machine host](#heading--assign-tags-to-a-vm-host)
- [How to remove tags from a virtual machine host](#heading--remove-tags-from-a-vm-host)
- [How to list tags for all virtual machine hosts](#heading--list-tags-for-all-vm-hosts)
- [How to view tags for one virtual machine host](#heading--view-tags-for-one-vm-host)

<a href="#heading--assign-machine-tags-to-a-machine"><h2 id="heading--assign-machine-tags-to-a-machine">How to assign machine tags to a machine</h2></a>

You can assign tags to a physical or virtual machine with the following command:

```nohighlight
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID
```

For example:

```nohighlight
maas admin tag update-nodes new_tag add=g6arwg
```

This returns something like the following:

```nohighlight
Success.
Machine-readable output follows:
{
   "added": 1,
   "removed": 0
}
```

You can check your work by listing machine tags, like this:

```nohighlight
maas admin machines read | jq -r \
'(["hostname","sysid","machine_tags"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]])
| @tsv' | column -t
```

This should yield output similar to the following:

```nohighlight
hostname       sysid   machine_tags
--------       -----   ------------
divine-stork   8b3ypp  pod-console-logging  virtual
casual-prawn   4end6r  pod-console-logging  virtual
driven-teal    tgaat6  pod-console-logging  virtual
immune-beetle  43xand  pod-console-logging  virtual
good-osprey    napfxk  pod-console-logging  virtual
smart-hen      c4rwq7  pod-console-logging  virtual
boss-satyr     xn8taa  pod-console-logging  androko
golden-martin  8fxery  pod-console-logging  virtual
crack-guinea   qk4b3g  pod-console-logging  virtual
finer-leech    cy3dtr  pod-console-logging  virtual
free-mouse     gxtbq4  pod-console-logging  virtual
humble-bunny   srqnnb  pod-console-logging  virtual
wanted-muskox  ekw7fh  pod-console-logging  virtual
one-boa        by477d  pod-console-logging  virtual
great-urchin   srnx4g  pod-console-logging  virtual
ace-frog       g6arwg  pod-console-logging  virtual  barbar  farquar  new_tag
alive-marlin   gbwnfb  pod-console-logging  virtual
picked-parrot  am77wn  pod-console-logging  virtual
tough-kit      ke3wc7  pod-console-logging  virtual
legal-whale    8nq3mt  pod-console-logging  virtual
game-sponge    76pdc6  pod-console-logging  virtual
fun-ghoul      qxfm7k  pod-console-logging  virtual
aware-earwig   8m8hs7  pod-console-logging  virtual
chief-crane    7fapx7  pod-console-logging  virtual
select-tapir   4ascbr  pod-console-logging  virtual
on-slug        snfs8d  pod-console-logging  virtual
polite-llama   dbqd4m  pod-console-logging  virtual
frank-coyote   wcmk48  pod-console-logging  virtual
usable-condor  ed8hmy  pod-console-logging  virtual
still-imp      h6ra6d  pod-console-logging  virtual
```

<a href="#heading--remove-machine-tags-from-a-machine"><h2 id="heading--remove-machine-tags-from-a-machine">How to remove machine tags from a machine</h2></a>

You can remove a tag from a physical or virtual machine with this command:

```nohighlight
maas $PROFILE tag update-nodes $TAG_NAME remove=$SYSTEM_ID
```

For example:

```nohighlight
maas admin tag update-nodes new_tag remove=g6arwg
```

This would produce output similar to the following:

```nohighlight
Success.
Machine-readable output follows:
{
    "added": 0,
    "removed": 1
}
```

A quick check to verify results should yield something like this:

```nohighlight
hostname       sysid   machine_tags
--------       -----   ------------
ace-frog       g6arwg  pod-console-logging  virtual  barbar  farquar
```

<a href="#heading--adding-and-removing-machine-tags-simultaneously"><h3 id="heading--adding-and-removing-machine-tags-simultaneously">Adding and removing machine tags simultaneously from multiple machines</h3></a>

You can simultaneously add and remove tags from multiple machines, as long as you are only modifying one tag, with a command like this one:

```nohighlight
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID1 add=$SYSTEM_ID2 remove=$SYSTEM_ID3
```

For example, to remove the tag "barbar" from machine "g6arwg," but add it to machines "8fxery" and "by477d," you could use a command like this:

```nohighlight
maas admin tag update-nodes barbar add=8fxery add=by477d remove=g6arwg
```

This compound operation would yield a response similar to this:

```nohighlight
Success.
Machine-readable output follows:
{
    "added": 2,
    "removed": 1
}
```

Again, verifying by checking the list of machine tags, we enter a command like this:

```nohighlight
maas admin machines read | jq -r \
'(["hostname","sysid","machine_tags"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]])
| @tsv' | column -t
```

The resulting response looks something like this:

```nohighlight
hostname       sysid   machine_tags
--------       -----   ------------
divine-stork   8b3ypp  pod-console-logging  virtual
casual-prawn   4end6r  pod-console-logging  virtual
driven-teal    tgaat6  pod-console-logging  virtual
immune-beetle  43xand  pod-console-logging  virtual
good-osprey    napfxk  pod-console-logging  virtual
smart-hen      c4rwq7  pod-console-logging  virtual
boss-satyr     xn8taa  pod-console-logging  androko
golden-martin  8fxery  pod-console-logging  virtual  barbar
crack-guinea   qk4b3g  pod-console-logging  virtual
finer-leech    cy3dtr  pod-console-logging  virtual
free-mouse     gxtbq4  pod-console-logging  virtual
humble-bunny   srqnnb  pod-console-logging  virtual
wanted-muskox  ekw7fh  pod-console-logging  virtual
one-boa        by477d  pod-console-logging  virtual  barbar
great-urchin   srnx4g  pod-console-logging  virtual
ace-frog       g6arwg  pod-console-logging  virtual  farquar
alive-marlin   gbwnfb  pod-console-logging  virtual
picked-parrot  am77wn  pod-console-logging  virtual
tough-kit      ke3wc7  pod-console-logging  virtual
legal-whale    8nq3mt  pod-console-logging  virtual
game-sponge    76pdc6  pod-console-logging  virtual
fun-ghoul      qxfm7k  pod-console-logging  virtual
aware-earwig   8m8hs7  pod-console-logging  virtual
chief-crane    7fapx7  pod-console-logging  virtual
select-tapir   4ascbr  pod-console-logging  virtual
on-slug        snfs8d  pod-console-logging  virtual
polite-llama   dbqd4m  pod-console-logging  virtual
frank-coyote   wcmk48  pod-console-logging  virtual
usable-condor  ed8hmy  pod-console-logging  virtual
still-imp      h6ra6d  pod-console-logging  virtual
```

<a href="#heading--list-machine-tags-for-all-machines"><h2 id="heading--list-machine-tags-for-all-machines">How to list machine tags for all machines</h2></a>

To list machine tags for all physical and virtual machines, just enter a command similar to this one:

```nohighlight
maas $PROFILE machines read | jq -r '(["hostname","sysid","machine_tags"]|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]]) | @tsv' | column -t
```

For example:

```nohighlight
maas admin machines read | jq -r \
'(["hostname","sysid","machine_tags"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]])
| @tsv' | column -t
```

This gives us a listing similar to this:

```nohighlight
hostname       sysid   machine_tags
--------       -----   ------------
divine-stork   8b3ypp  pod-console-logging  virtual
casual-prawn   4end6r  pod-console-logging  virtual
driven-teal    tgaat6  pod-console-logging  virtual
immune-beetle  43xand  pod-console-logging  virtual
good-osprey    napfxk  pod-console-logging  virtual
smart-hen      c4rwq7  pod-console-logging  virtual
boss-satyr     xn8taa  pod-console-logging  androko
golden-martin  8fxery  pod-console-logging  virtual  barbar
crack-guinea   qk4b3g  pod-console-logging  virtual
finer-leech    cy3dtr  pod-console-logging  virtual
free-mouse     gxtbq4  pod-console-logging  virtual
humble-bunny   srqnnb  pod-console-logging  virtual
wanted-muskox  ekw7fh  pod-console-logging  virtual
one-boa        by477d  pod-console-logging  virtual  barbar
great-urchin   srnx4g  pod-console-logging  virtual
ace-frog       g6arwg  pod-console-logging  virtual  farquar
alive-marlin   gbwnfb  pod-console-logging  virtual
picked-parrot  am77wn  pod-console-logging  virtual
tough-kit      ke3wc7  pod-console-logging  virtual
legal-whale    8nq3mt  pod-console-logging  virtual
game-sponge    76pdc6  pod-console-logging  virtual
fun-ghoul      qxfm7k  pod-console-logging  virtual
aware-earwig   8m8hs7  pod-console-logging  virtual
chief-crane    7fapx7  pod-console-logging  virtual
select-tapir   4ascbr  pod-console-logging  virtual
on-slug        snfs8d  pod-console-logging  virtual
polite-llama   dbqd4m  pod-console-logging  virtual
frank-coyote   wcmk48  pod-console-logging  virtual
usable-condor  ed8hmy  pod-console-logging  virtual
still-imp      h6ra6d  pod-console-logging  virtual
```

<a href="#heading--view-machine-tags-for-one-machine"><h2 id="heading--view-machine-tags-for-one-machine">How to view machine tags for one machine</h2></a>

To view tags for one physical or machine, you can enter a command like this:

```nohighlight
maas $PROFILE machine read $SYSTEM_ID | jq -r '(["hostname","sysid","machine_tags"]|(.,map(length*"-"))),([.hostname,.system_id,.tag_names[]]) | @tsv' | column -t
```

For example:

```nohighlight
maas admin machine read 8fxery | jq -r \
'(["hostname","sysid","machine_tags"]
|(.,map(length*"-"))),([.hostname,.system_id,.tag_names[]])
| @tsv' | column -t
```

Typical output from this command might look like this:

```nohighlight
hostname       sysid   machine_tags
--------       -----   ------------
golden-martin  8fxery  pod-console-logging  virtual  barbar
```

<a href="#heading--discover-your-vm-host-id"><h2 id="heading--discover-your-vm-host-id">How to discover your virtual machine host ID</h2></a>

If you don't know your VM host ID, you can discover it with this command:

```nohighlight
maas $PROFILE vmhosts read \
| jq -r '(["vm_host_name","id"]
|(.,map(length*"-"))),(.[]|[.name,.id])
| @tsv' | column -t
```

For example:

```nohighlight
maas admin vmhosts read \
| jq -r '(["vm_host_name","id"]
|(.,map(length*"-"))),(.[]|[.name,.id])
| @tsv' | column -t
```

This should produce output similar to the following:

```nohighlight
vm_host_name      id
------------      --
my-lxd-vm-host-1  1
```

<a href="#heading--assign-tags-to-a-vm-host"><h2 id="heading--assign-tags-to-a-vm-host">How to assign tags to a virtual machine host</h2></a>

To assign a tag to a virtual machine host, enter the following command:

```nohighlight
maas $PROFILE vmhost add-tag $VMHOST_ID	tag=$TAG_NAME
```

If you don't know the ID of your VM host, you can [look it up beforehand](#heading--discover-your-vm-host-id).

As an example of assigning a tag to a VM host:

```nohighlight
maas admin vmhost add-tag 1 tag=virtual
```

If it worked, this should return `Success`, followed by the JSON that describes the VM host. You can check your work by [listing all VM host tags](#heading--list-tags-for-all-vm-hosts).

<a href="#heading--remove-tags-from-a-vm-host"><h2 id="heading--remove-tags-from-a-vm-host">How to remove tags from a virtual machine host</h2></a>

To remove a tag from a virtual machine host, enter the following command:

```nohighlight
maas $PROFILE vmhost remove-tag $VMHOST_ID tag=$TAG_NAME
```

If you don't know the ID of your VM host, you can [look it up beforehand](#heading--discover-your-vm-host-id).

As an example of removing a tag from a VM host:

```nohighlight
maas admin vmhost remove-tag 1 tag=virtual
```

If it worked, this should return `Success`, followed by the JSON that describes the VM host. You can check your work by [listing all VM host tags](#heading--list-tags-for-all-vm-hosts).


<a href="#heading--list-tags-for-all-vm-hosts"><h2 id="heading--list-tags-for-all-vm-hosts">How to list tags for all virtual machine hosts</h2></a>

You can list tags for all VM hosts with the following command:

```nohighlight
maas $PROFILE vmhosts read | jq -r '(["vm_host_name","id","tags"]|(.,map(length*"-"))),(.[]|[.name,.id,.tags[]]) | @tsv' | column -t
```

For example:

```nohighlight
maas admin vmhosts read | jq -r '(["vm_host_name","id","tags"]|(.,map(length*"-"))),(.[]|[.name,.id,.tags[]]) | @tsv' | column -t
```

This should yield output similar to the following:

```nohighlight
vm_host_name      id  tags
------------      --  ----
my-lxd-vm-host-1  1   morkopongo  pod-console-logging  virtual
```

<a href="#heading--view-tags-for-one-vm-host"><h2 id="heading--view-tags-for-one-vm-host">How to view tags for one virtual machine host</h2></a>

If you want to list the tags for just one VM host, you can use a command like this one:

```nohighlight
maas $PROFILE vmhost read $VMHOST_ID \
| jq -r '(["name","id","tags"]
|(.,map(length*"-"))),([.name,.id,.tags[]])
| @tsv' | column -t
```
If you don't know the ID of your VM host, you can [look it up beforehand](#heading--discover-your-vm-host-id).

As an example of viewing tags for one VM host:

```nohighlight
maas admin vmhost read 1 | jq -r '("name","id","tags"]|(.,map(length*"-"))),([.name,.id,.tags[]]) | @tsv' @ column -t
```

Typical output might look something like this:

```nohighlight
name              id  tags
----              --  ----
my-lxd-vm-host-1  1   morkopongo  pod-console-logging
```
[/tab]
[/tabs]
