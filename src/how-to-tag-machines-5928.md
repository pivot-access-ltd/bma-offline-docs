<!-- "How to tag machines" -->
[Tags](/t/how-to-label-and-find-machines/6200#heading--about-tags) for different objects have similar purposes, but they aren't necessarily administered in the same way -- so we've included detailed articles for each tag type.  That said, many of the common operations regarding tags are performed in the same way.  This article will present some general, explanatory information, and then look at tag management steps that are the same (or very similar) across all types of MAAS tags.

<a href="#heading--name-tags"><h2 id="heading--name-tags">How to name tags</h2></a>

When working with tags, there are some universal rules you need to follow:

1. Tag names can include any combination of alphabetic letters (a-zA-Z), numbers (0-9), dashes (-) and underscores (_).
2. Tag names can be a maximum of 256 characters in length.
3. Tag names *cannot* include spaces.

In general, names that do not conform to these rules cannot be created.

<a href="#heading--xpath-hardware-config-info"><h2 id="heading--xpath-hardware-config-info">How to download hardware configuration information</h2></a>

To download hardware configuration information in XML format:

1. Select *Machines*.

2. Select a machine which is allocated or deployed.

3. Select *Logs >> Installation output >> Download >> Machine output (XML)*.

You can [learn more about these attributes](https://ezix.org/project/wiki/HardwareLiSter)`↗` if desired.  Note that:

- Size and capacity can have various meanings depending on the device
- The size of a node is always equal to its capacity
- Serial refers to the device’s serial number, but is used to report the MAC address for network devices, GUID for disk partition.

You can also find device classes from the same sources. 

<a href="#heading--Automatic-tags"><h2 id="heading--Automatic-tags">Automatic tags</h2></a>

MAAS 3.2 and above provide greatly expanded tagging capability. You can auto-apply tags to machines that match a custom XPath expression. Setting up an automatic tag lets you recognise special hardware characteristics and settings, e.g., the gpu passthrough.

[tabs]
[tab version="v3.4 Snap,v3.4 Packages" view="UI"]
<a href="#heading--how-to-create-automatic-tags"><h2 id="heading--how-to-create-automatic-tags">How to create automatic tags</h1></a>

To create automatic tags:

1. Select *Organisation > Tags*.

2. Select *Create new tag*.

3. Enter the *Tag name*.

4. Optionally enter a *Comment*.

5. Optionally enter *Kernel options*.

6. Enter an XPath-based *Definition*.  A tag is considered automatic when the definition field is filled with an XPath expression. The current version of our UI will only validate if your XPath expression is valid or not, but it will not show you which machines it will apply to before you create the tag.

7. Select *Save* to register your changes.

Once an automatic tag is created the screen will initially show that 0 machines are tagged. That is because MAAS is running a background task to auto-apply the tag to matching machines. It can take some time to see that the number of machines tagged is populating. 

[note]
Kernel options will be applied at boot time. So by default kernel options will not be applied to any machines until they are deployed. If machines are deployed before they are tagged, the kernel option will be applied when these machines are redeployed.
[/note]

<a href="#heading--how-to-update-automatic-tags"><h2 id="heading--how-to-update-automatic-tags">How to update the definition of a tag</h2></a>

1. Select *Organisation > Tags*.

2. Select the pencil icon on the right end of the tag's row.

3. Edit the *Definition*.

4. Select *Save* to register your changes.

Keep in mind that when a new definition is updated, MAAS will re-tag all the machines that match with the new definition. This can take some time, since it is a background process. 
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages" view="UI"]
<a href="#heading--how-to-create-automatic-tags"><h2 id="heading--how-to-create-automatic-tags">How to create automatic tags</h1></a>

To create automatic tags:

1. Select *Machines*.

2. Select *Tags*.

3. Select *Create new tag*.

4. Enter the *Tag name*.

5. Optionally enter a *Comment*.

6. Optionally enter *Kernel options*.

7. Enter an XPath-based *Definition*.  A tag is considered automatic when the definition field is filled with an XPath expression. The current version of our UI will only validate if your XPath expression is valid or not, but it will not show you which machines it will apply to before you create the tag.

8. Select *Save* to register your changes.

Once an automatic tag is created the screen will initially show that 0 machines are tagged. That is because MAAS is running a background task to auto-apply the tag to matching machines. It can take some time to see that the number of machines tagged is populating. 

[note]
Kernel options will be applied at boot time. So by default kernel options will not be applied to any machines until they are deployed. If machines are deployed before they are tagged, the kernel option will be applied when these machines are redeployed.
[/note]

<a href="#heading--how-to-update-automatic-tags"><h2 id="heading--how-to-update-automatic-tags">How to update the definition of a tag</h2></a>

1. Select *Machines*.

2. Select *Tags*.

3. Select the pencil icon on the right end of the tag's row.

4. Edit the *Definition*.

5. Select *Save* to register your changes.

Keep in mind that when a new definition is updated, MAAS will re-tag all the machines that match with the new definition. This can take some time, since it is a background process. 
[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
Automatic tags are only available in MAAS 3.2 and above.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages" view="CLI"]
Automatic tags are only available via the MAAS UI.
[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
Automatic tags are only available in MAAS 3.2 and above.
[/tab]
[/tabs]

<a href="#heading--update-tag-kernel-options"><h2 id="heading--update-tag-kernel-options">How to update the kernel options on a tag</h2></a>

To update the kernel options on a tag:

1. Select *Machines*.

2. Select *Tags*.

3. Select the pencil icon on the right end of the tag's row.

4. Edit the *Kernel options*.

5. Select *Save* to register your changes.

Kernel options can exist for both manual and automatic tags. However, they will be applied during boot time (commissioning and deploying).

[note]
If the tagged machines are deployed, the updated kernel option won’t apply until the machines are redeployed. We suggest that you release those machines prior to the update, then redeploy those machines when the kernel options of the tag are updated.
[/note]

<a href="#heading--unassign-tags-from-machines"><h2 id="heading--unassign-tags-from-machines">How to unassign tags from machines</h2></a>

To unassign tags from machines:

1. Select *Machines*.

2. Select the checkbox(es) next to the machine(s) you wish to untag.

3. Select *Take action >> Tag*.  A table of tags appears at the top of the screen.

4. For each tag you wish to unassign, select *Remove*.  The text will change to *Discard* with an *X* to the right.

5. If you want to undo a choice before saving, click the *X* to right of *Discard* to undo the proposed change.

6. When you're satisfied with your new tag configuration, select *Save* to finalize and register your choice(s).

[note]
Automatic tags cannot be unassigned manually. You can either update or delete automatic tags.
[/note]

You can also unassign tags individually by going to *Machines >> {machine-name} >> Configuration >> Tags >> Edit*. The *Tags* table functions exactly the same as what's described above.

<a href="#heading--see-all-tagged-nodes"><h2 id="heading--see-all-tagged-nodes">How to see all tagged nodes</h2></a>

To see how many nodes (Machines, controllers, devices) are tagged, search for GRUB_CMDLINE_LINUX_DEFAULT in the "Installation output" tab of the machine details page. That log should stay around for the lifetime of the deployment of the machine.  The log gets overwritten when you redeploy the machine.  For example:

```nohighlight
GRUB_CMDLINE_LINUX_DEFAULT="sysrq_always_enabled dyndbg='file drivers/usb/* +p' console=tty1 console=ttyS0"
```



[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages" view="UI"]
<a href="#heading--create-and-assign-tags"><h2 id="heading--create-and-assign-tags">How to create and assign tags</h2></a>

In the MAAS UI, creating and assigning tags is a combined operation; that is, you create tags as you assign them, rather than creating them first.  Creating tags in the UI is a little different user experience: there is a self-loading completion menu that collects all tags of a similar type.  This completion menu helps you avoid misspelling tags when entering them more than once; otherwise, you might not be able to group and filter tags properly. It also makes tag entry more efficient.

To create and assign a tag to specific machines:

1. Select *Machines*.

2. Select the checkbox next to the machines you wish to tag.

3. Select *Take action >> Tag*.  A *Tag* dialogue will pop up at the top of the screen.

4. In the box labeled *Search existing or add new tags*, enter the name for your proposed tag (e.g., *{tag-name}*).

5. Select *Create tag {tag-name}*, under the *Search...* box.  A modal dialogue box pops up; *{tag-name}* will automatically populate the *Tag name* field.

6. Optionally enter a *Comment*.

7. Optionally enter some *Kernal options*.

8. Select *Create and add to tag changes*.  You will be returned to the previous screen; note that your changes have not yet been registered with MAAS.

9. If you wish to abaondon this new tag without assigning it, select *Discard X* to the right of the new tag name.  It will disappear from the list.

10. If you're happy with the new tag(s), select *Save* to apply your changes to the selected machines.  You'll be returned to *Machines*.

You can confirm your changes by hovering over the *Tags* list in the *Machines* screen.

<a href="#heading--delete-and-remove-tags"><h2 id="heading--delete-and-remove-tags">How to delete and remove tags</h2></a>

You have two choices when it comes to eliminating tags from machines in your MAAS instance: you can delete them from all machines, or simply remove them from specific machines.

<a href="#heading--delete-from-all-machines"><h3 id="heading--delete-from-all-machines">Deleting tags from all machines at once</h3></a>

To delete tags from all machines:

1. Select *Machines*.

2. Select *Tags*.

3. Select the trash can icon to the right of the tag you'd like to delete.  A warning dialogue will pop up at the top of the screen.

4. Select *Delete*.

The tag will be unassigned from all machines and deleted.  There is no undo.

<a href="#heading--remove-from-some-machines"><h3 id="heading--remove-from-some-machines">Removing a tag from specific machines</h3></a>

To remove a tag only from specific machines:

1. Select *Machines*.

2. Select the checkbox next to each machine from which you want the tag removed.

3. Select *Take action >> Tag*.

4. For each tag you wish to unassign, select *Remove*.  The text will change to *Discard* with an *X* to the right.

5. If you want to undo a choice before saving, click the *X* to right of *Discard* to undo the proposed change.

6. When you're satisfied with your new tag configuration, select *Save* to finalize and register your choice(s).

[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--create-and-assign-tags"><h2 id="heading--create-and-assign-tags">How to create and assign tags</h2></a>

In the MAAS UI, creating and assigning tags is a combined operation; that is, you create tags as you assign them, rather than creating them first.  Creating tags in the UI is a little different user experience: there is a self-loading completion menu that collects all tags of a similar type.  This completion menu helps you avoid misspelling tags when entering them more than once; otherwise, you might not be able to group and filter tags properly. It also makes tag entry more efficient.

The process for creating and assigning tags in the UI is generally the same for all tag types:

1. Place the cursor in the *Tags* box.

2. Type the name of the new tag.

3. Press the return key to add the new tag.  The auto complete list will re-appear after you've entered the tag, in case you'd like to enter another tag.

4. When you're done, select the appropriate completion button to register your changes.

The tag you just entered will now be added to the tag auto complete list, in alphabetical order, for re-use with other machines.

<a href="#heading--delete-and-remove-tags"><h2 id="heading--delete-and-remove-tags">How to delete and remove tags</h2></a>

With the MAAS UI, you remove tags, rather than explicitly deleting them.  Tags are "deleted" when you have removed them from all machines.

To remove (unassign) a tag:

1. Find the *Tags* box.

2. Click the *X* next to the tag you wish to remove.

3. When you're done, select the appropriate completion button to register your changes.

Note that the tag you just removed will be deleted from  the tag auto complete list when it is no longer assigned to any  machines.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
<a href="#heading--create-a-tag"><h2 id="heading--create-a-tag">How to create a tag</h2></a>

With the CLI, you can create a tag with the following command:

```nohighlight
maas $PROFILE tags create name=$TAG_NAME comment='$TAG_COMMENT'
```

For example, depending upon your system configuration, you might type a command similar to this one:

```nohighlight
maas admin tags create name="new_tag" comment="a new tag for test purposes"
```

When the command is successful, you should see output similar to this:

```nohighlight
Success.
Machine-readable output follows:
{
    "name": "new_tag",
    "definition": ",
    "comment": "a new tag for test purposes",
    "kernel_opts": ",
    "resource_uri": "/MAAS/api/2.0/tags/new_tag/"
}
```

You can verify your work by [listing all the tags on this MAAS](#heading--list-all-tags-available-on-this-maas).

<a href="#heading--create-tags-with-built-in-kernel-options"><h2 id="heading--create-tags-with-built-in-kernel-options">How to create tags with built-in kernel options</h2></a>

You can create tags with embedded kernel boot options.  When you apply such tags to a machine, those kernel boot options will be applied to that machine on the next deployment.

To create a tag with embedded kernel boot options, use the following command:

```nohighlight
maas $PROFILE tags create name='$TAG_NAME' \
    comment='$TAG_COMMENT' kernel_opts='$KERNEL_OPTIONS'
```

For example:

```nohighlight
maas admin tags create name='nomodeset_tag' \
    comment='nomodeset_kernel_option' kernel_opts='nomodeset vga'
```

This command yields the following results:

```nohighlight
Success.
Machine-readable output follows:
{
    "name": "nomodeset_tag",
    "definition": ",
    "comment": "nomodeset_kernel_option",
    "kernel_opts": "nomodeset vga",
    "resource_uri": "/MAAS/api/2.0/tags/nomodeset_tag/"
}
```

You can check your work with a modified form of the listing command:

```nohighlight
maas admin tags read | jq -r \
'(["tag_name","tag_comment","kernel_options"]
|(.,map(length*"-"))),(.[]|[.name,.comment,.kernel_opts]) 
| @tsv' | column -t
```

This should give you results something like this:

```nohighlight
tag_name             tag_comment                  kernel_options                     
--------             -----------                  --------------                     
virtual                                                                              
new_tag              a-new-tag-for-test-purposes                                     
pod-console-logging  console=tty1                 console=ttyS0                      
nomodeset_tag        nomodeset_kernel_option      nomodeset       vga
```

<a href="#heading--delete-a-tag"><h2 id="heading--delete-a-tag">How to delete a tag</h2></a>

With the CLI, you can delete a tag with the following command:

```nohighlight
maas $PROFILE tag delete $TAG_NAME
```

For example, depending upon your system configuration, you might type a command similar to this one:

```nohighlight
maas admin tag delete zorko
```

When the command is successful, you should see output similar to this:

```nohighlight
Success.
Machine-readable output follows:
```

Note that there is no actual "Machine-readable output" produced by this command, in most cases. Also note that remove a tag removes it from any nodes where you may have assigned it, but does not affect those nodes in any other way.

You can check your work by [listing all the tags on this MAAS](#heading--list-all-tags-available-on-this-maas).

<a href="#heading--update-a-tag"><h2 id="heading--update-a-tag">How to update a tag</h2></a>

You can update a tag (e.g., a tag comment) like this:

```nohighlight
maas $PROFILE tag update $TAG_NAME comment='$TAG_COMMENT'
```

For example:

```nohighlight
maas admin tag update new_tag comment="a-new-tag-for-test-purposes"
```

This should return an output similar to this one:

```nohighlight
Success.
Machine-readable output follows:
{
    "name": "new_tag",
    "definition": ",
    "comment": "a-new-tag-for-test-purposes",
    "kernel_opts": ",
    "resource_uri": "/MAAS/api/2.0/tags/new_tag/"
}
```

You can always verify by [listing all the tags on this MAAS](#heading--list-all-tags-available-on-this-maas).

<a href="#heading--list-all-tags-available-on-this-maas"><h2 id="heading--list-all-tags-available-on-this-maas">How to list all tags available on this MAAS</h2></a>

You can list all tags that currently exist in this MAAS with a command of the form:

```nohighlight
maas $PROFILE tags read | jq -r '(["tag_name","tag_comment"]|(.,map(length*"-"))),(.[]|[.name,.comment]) | @tsv' | column -t
```

For example:

```nohighlight
maas admin tags read | jq -r '(["tag_name","tag_comment"]|(.,map(length*"-"))),(.[]|[.name,.comment]) | @tsv' | column -t
```

Your output might look like this:

```nohighlight
tag_name  tag_comment
--------  -----------
virtual   
new_tag   a-new-tag-for-test-purposes
```

<a href="#heading--rebuild-a-tag"><h2 id="heading--rebuild-a-tag">How to rebuild a tag</h2></a>

If you need to update tags for all machines – without having to recommission them – you can accomplish this with the rebuild command:

```nohighlight
maas $PROFILE tag rebuild $TAG
```

This command automatically applies the tag to all machines regardless of state, even machines that are actively deployed. For example:

```nohighlight
maas admin tag rebuild virtual
```

This command would produce output similar to the following:

```nohighlight
Success.
Machine-readable output follows:
{
    "rebuilding": "virtual"
}
```
[/tab]
[/tabs]
