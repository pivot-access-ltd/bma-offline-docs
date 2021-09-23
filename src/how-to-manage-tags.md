Tags for different objects have similar purposes, but they aren't necessarily administered in the same way -- so we've included detailed articles for each tag type.  That said, many of the common operations regarding tags are performed in the same way.  This article will look at tag management steps that are the same (or very similar) across all types of MAAS tags.

<a href="#heading--name-tags"><h2 id="heading--name-tags">How to name tags</h2></a>

When working with tags, there are some universal rules you need to follow:

1. Tag names can include any combination of alphabetic letters (a-zA-Z), numbers (0-9), dashes (-) and underscores (_).
2. Tag names can be a maximum of 256 characters in length.
3. Tag names *cannot* include spaces.

In general, names that do not conform to these rules cannot be created.

rad-begin /deb/2.9/ui /deb/3.0/ui /deb/3.1/ui /snap/2.9/ui /snap/3.0/ui /snap/3.1/ui
<a href="#heading--create-and-assign-tags"><h2 id="heading--create-and-assign-tags">How to create and assign tags</h2></a>

In the MAAS UI, creating and assigning tags is a combined operation; that is, you create tags as you assign them, rather than creating them first.  Creating tags in the UI is a little different user experience: there is a self-loading completion menu that collects all tags of a similar type.  This completion menu helps you avoid misspelling tags when entering them more than once; otherwise, you might not be able to group and filter tags properly. It also makes tag entry more efficient.

The process for creating and assigning tags in the UI is generally the same for all tag types:

1. Place the cursor in the "Tags" box, wherever it is located on the screen, and type the name of the new tag:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7be5f2bebbba9a09f70a7dea092d091ef45228e2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7be5f2bebbba9a09f70a7dea092d091ef45228e2.png"></a>

2. Hit the return key to add the new tag:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3d151d772aae0f8688d0a40e71cfb3c97bc6e8fc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3d151d772aae0f8688d0a40e71cfb3c97bc6e8fc.png"></a>

The auto complete list will re-appear after you've entered the tag, in case you'd like to enter another tag.

3. When you're done, click on the appropriate completion button to complete the operation.

The tag you just entered will now be added to the tag auto complete list, in alphabetical order, for re-use with other machines.

<a href="#heading--delete-and-remove-tags"><h2 id="heading--delete-and-remove-tags">How to delete and remove tags</h2></a>

With the MAAS UI, you remove tags, rather than explicitly deleting them.  Tags are "deleted" when you have removed them from all machines.   

To remove (unassign) a tag:

1. Find the "Tags" box, wherever it is located on the screen:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7be5f2bebbba9a09f70a7dea092d091ef45228e2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7be5f2bebbba9a09f70a7dea092d091ef45228e2.png"></a>

2. Click the "X" next to the tag you wish to remove.

3. When you're done, click on the appropriate completion button to complete the operation.

>Note that the tag you just removed will be deleted from  the tag auto complete list when it is no longer assigned to any  machines.
rad-end

rad-begin /deb/2.9/cli /deb/3.0/cli /deb/3.1/cli /snap/2.9/cli /snap/3.0/cli /snap/3.1/cli
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
    "definition": "",
    "comment": "a new tag for test purposes",
    "kernel_opts": "",
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
    "definition": "",
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
    "definition": "",
    "comment": "a-new-tag-for-test-purposes",
    "kernel_opts": "",
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
rad-end
