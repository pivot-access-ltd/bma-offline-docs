||2.7|2.8|2.9|3.0|
|-----:|:-----:|:-----:|:-----:|:-----:|
Snap|[CLI](/t/maas-tags-snap-2-7-cli/2886) ~ [UI](/t/maas-tags-snap-2-7-ui/2887)|[CLI](/t/maas-tags-snap-2-8-cli/2888) ~ [UI](/t/maas-tags-snap-2-8-ui/2889)|[CLI](/t/maas-tags-snap-2-9-cli/2890) ~ [UI](/t/maas-tags-snap-2-9-ui/2891)|[CLI](/t/maas-tags-snap-3-0-cli/4021) ~ [UI](/t/maas-tags-snap-3-0-ui/4022)|
Packages|[CLI](/t/maas-tags-deb-2-7-cli/2892) ~ [UI](/t/maas-tags-deb-2-7-ui/2893)|[CLI](/t/maas-tags-deb-2-8-cli/2894) ~ [UI](/t/maas-tags-deb-2-8-ui/2895)|[CLI](/t/maas-tags-deb-2-9-cli/2896) ~ [UI](/t/maas-tags-deb-2-9-ui/2897)|[CLI](/t/maas-tags-deb-3-0-cli/4023) ~ [UI](/t/maas-tags-deb-3-0-ui/4024)|

[note]
Editorial note: i'm reading dissonance between tags in the UI and tags in the CLI.

in the UI, i can set tags for machines, storage configurations (if the storage is in the available state), interfaces, and devices.

in the CLI, with the tags command, i can list nodes, machines, devices, rack controllers, and region controllers by tag, but

 - i can't see a way to set tags for region controllers, rack controllers, devices, or "nodes."
 - i can add tags to a machine, block device, partition, VM host, or network interface.

this is hard to explain to users.  i'm booking time with Lee to help sort this out, and punting until we can connect.
[/note]

Tags are a convenient way to assign descriptive words to machines, interfaces, and storage devices. Using MAAS tags, you can easily select machines that meet certain criteria, helping you to remember that you've defined or reserved certain machines for certain functions.  Annotations extend this capability considerably.  This article will tell you how to use both features.

#### Eight questions you may have:

1. [What are the rules for creating a tag name?](#heading--tag-name-rules)
2. [How do I create and assign tags?](#heading--create-a-tag)
3. [How do I remove a tag from a node?](#heading--remove-a-tag)
4. [How do I delete a tag?](#heading--delete-a-tag)
5. [How do I edit a tag?](#heading--edit-a-tag)
6. [How do I list tags?](#heading--list-tags)
7. [How do I filter listings using tags?](#heading--filter-listings-using-tags)
8. [How do I use tags to assign per-machine kernel boot options?](#heading--assign-per-machine-kernel-boot-options)
<!-- commented out until fully drafted
10. [How do I create annotations?]()
11. [How do I remove an annotation from a node?]()
12. [How do I delete an annotation?]()
13. [How do I edit an annotation?]()
14. [How do I view annotations?]()
 commented out until fully drafted -->

<a href="#heading--tag-name-rules"><h2 id="heading--tag-name-rules">What are the rules for creating a tag name?</h2></a>

When creating tags, there are some universal rules that you need to follow:

1. Tag names can include any combination of alphabetic letters (a-zA-Z), numbers (0-9), dashes (-) and underscores (_).
2. Tag names can be a maximum of 256 characters in length.
3. Tag names *cannot* include spaces.

As long as you follow these three simple rules, you shouldn't have a lot of trouble creating and assigning tags.

<a href="#heading--create-a-tag"><h2 id="heading--create-a-tag">How do I create and assign tags?</h2></a>

<!-- snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli snap-3-0-cli deb-3-0-cli

With the MAAS CLI, creating and assigning tags are two distinct operations -- unlike the UI, where they are essentially part of the same operation.  On the other hand, the CLI affords more flexilibity, as it's possible to add tags to some entities and remove them from others in the same command line invocation.

#### questions you may have

1. [How do I create a tag?](#heading--cli-create-tag)
2. [How do I assign a tag to a machine?](#heading--cli-assign-machine-tag)
3. [How do I assign a tag to a block device?](#heading--cli-assign-block-device-tag)
4. [How do I assign a tag to a partition?](#heading--cli-assign-partition-tag)
4. [How do I assign a tag to a VM host?](#heading--cli-assign-vm-host-tag)
5. [How do I assign a tag to a network interface?](#heading--cli-assign-interface-tag)
6. [How do I assign a tag to a device?](#heading--cli-assign-device-tag)

<a href="#heading--cli-create-tag"><h3 id="heading--cli-create-tag">How do I create a tag?</h3></a>

You can create a MAAS tag with the following command:

```bash
maas $PROFILE tags create name=$NAME
```

This command takes the following optional parameters:

* `comment`: a description of the tag in natural language free text; presumably a string that identifies how the tag will be used.

* `definition`: an `XPATH` query that will be evaluated against the `hardware_details` stored for all nodes, that is, the output of ```lshw -xml```; formatted as a string. Review the [explanation of XPATH bindings with tags](/t/discourse/maas-project/4460#heading--tags-and-xpath-entries) for more details about this parameter.

* ```kernel_opts```: all nodes associated with this tag will add this string to their kernel options when booting.  This value overrides the global ```kernel_opts``` setting.  If more than one associated tag has attached kernel options, all the applied options will be concatenated for the machine, in alphabetical order.  Review the [explanation of per-machine kernel boot options](/t/discourse/maas-project/4460#heading--tags-and-kernel-boot-options), or see the section on [per-machine kernel boot options](#heading--assign-per-machine-kernel-boot-options) for more detailed instructions about using this parameter.

<a href="#heading--cli-assign-machine-tag"><h3 id="heading--cli-assign-machine-tag">How do I assign a tag to a machine?</h3></a>

If you want to assign a tag, you can do so with this CLI command:

```
maas $PROFILE tag update-nodes $TAG_NAME key=$VALUE
```

The various key-value pairs are somewhat optional, although at least one `add=$SYSTEM_ID` or `remove=$SYSTEM_ID` follow the `$TAG_NAME` in this command.  The possible key-value pairs are as follows:

* `add=$SYSTEM_ID`: this pair causes MAAS to add $TAG_NAME to the machine $SYSTEM_ID.  You can use as many of these key-value pairs as needed, so it's possible to tag many machines at once with a single command-line invocation.

* `remove=$SYSTEM_ID`: this pair causes MAAS to remove $TAG_NAME from the machine $SYSTEM_ID.  You can use as many of these key-value pairs as needed, so it's possible to remove tags from many machines at once with a single command-line invocation.

[note]
Note that both "add" and "remove" key-value pairs can be combined in a single command-line invocation, so it's possible to add and remove tags from various machines, at the same time, in a single command.
[/note]

* `definition=$XPATH_EXPRESSION`: If given, the entered XPATH expression will be validated against the current definition of the tag.  If the value does not match, MAAS assumes the worker is out of date and will not do the update.

* 'rack_controller=$SYSTEM_ID`: If given, the system ID of the rack controller that processed the given tag initially is used, requiring that the requester be the rack controller.  If not given, the requester must be a MAAS admin.

For example, to assign a *existing* tag named "new-tag" to a machine with system ID "xmprry," the following command would be executed:

```
maas admin tag update-nodes new-tag add=xmprry
```

A successful result should look like this:

```
Success.
Machine-readable output follows:
{
    "added": 1,
    "removed": 0
}
```

If you try to assign a tag that hasn't been created yet, you'll get a "Not Found" error message.  For example:

```
maas admin tag update-nodes revolution add=dtanap
Not Found
```

<a href="#heading--cli-assign-block-device-tag"><h3 id="heading--cli-assign-block-device-tag">How do I assign a tag to a block device?</h3></a>


<a href="#heading--cli-assign-partition-tag"><h3 id="heading--cli-assign-partition-tag">How do I assign a tag to a partition?</h3></a>

<a href="#heading--cli-assign-vm-host-tag"><h3 id="heading--cli-assign-vm-host-tag">How do I assign a tag to a machine?</h3></a>

<a href="#heading--cli-assign-interface-tag"><h3 id="heading--cli-assign-interface-tag">How do I assign a tag to a network interface?</h3></a>

<a href="#heading--remove-a-tag"><h2 id="heading--remove-a-tag">How do I remove a tag from a node?</h2></a>

snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli snap-3-0-cli deb-3-0-cli -->

<!-- snap-2-7-ui snap-2-8-ui snap-2-9-ui deb-2-7-ui deb-2-8-ui deb-2-9-ui snap-3-0-ui deb-3-0-ui 
There are several types of tags available to create (and simultaneously assign) via the MAAS UI.  These include machine tags, storage configuration tags, network interface tags, and device tags.  The following section will provide instructions on how you can assign these various tags in your MAAS instance.

#### Five questions you may have

1. [How do I create and assign any tag, in general?](#heading--create-assign-tag-general)
2. [How do I create and assign a tag to a machine?](#heading--create-assign-machine-tag)
3. [How do I create and assign a tag to a storage configuration?](#heading--create-assign-storage-tag)
4. [How do I create and assign a tag to a network interface?](#heading--create-assign-interface-tag)
5. [How do I create and assign a tag to a device?](#heading--create-assign-device-tag)

<a href="#heading--create-assign-tag-general"><h2 id="heading--create-assign-tag-general">How do I create and assign any tag, in general?</h2></a>

1. Place the cursor in the "Tags" box, wherever it is located on the screen, and type the name of the new tag:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7be5f2bebbba9a09f70a7dea092d091ef45228e2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7be5f2bebbba9a09f70a7dea092d091ef45228e2.png"></a>

Note that tag names can include any combination of alphabetic letters (a-zA-Z), numbers (0-9), dashes (-) and underscores (_), and be a maximum of 256 characters in length. Note that tag names <b>cannot</b> include spaces. A dropdown autocomplete menu appears when you enter this box, and narrows down the autocomplete list as you type.

2. Hit the return key to add the new tag:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3d151d772aae0f8688d0a40e71cfb3c97bc6e8fc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3d151d772aae0f8688d0a40e71cfb3c97bc6e8fc.png"></a>

Note that the autocomplete list will re-appear after you've entered the tag, in case you'd like to enter another tag.

3. When you're done, click on the appropriate completion button to complete the operation.

Note that the tag you just entered will now be added to the tag autocomplete list, in alphabetical order, for re-use with other machines.

<a href="#heading--create-another-tag"><h3 id="heading--create-another-tag">Adding a tag by selecting an existing one</h3></a>

If you start typing in the "Tags" box, and you see either (1) that the tag you want is already created, or (2) that you'd prefer to apply one that's already been created, just click on that tag to add it to the current machine.

You can assign as many tags as you want, as long as they conform to the [tag name rules](#heading--tag-name-rules).  Don't forget to click on the completion button to complete the operation.  

<a href="#heading--create-assign-machine-tag"><h2 id="heading--create-assign-machine-tag">How do I create and assign a tag to a machine?</h2></a>

If you want to create a new tag, and simultaneously assign it to a machine, use the following steps:

1. Go to the machine list and select the machine you're interested in modifying, by checking the box next to the machine name:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/86ee8529206fcfa297865198a55b976e1002b6bf.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/86ee8529206fcfa297865198a55b976e1002b6bf.png"></a>

2. Select the "Take action" dropdown menu and select "Tag":

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f77f19b7aef9f880c12a4d710b91cc3abdc03154.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f77f19b7aef9f880c12a4d710b91cc3abdc03154.png"></a>

3. Create and/or assign the desired tag, as described in the [general tagging procedure](#heading--create-assign-tag-general) above.

4. Don't forget to hit the "Tag machine" button when you're done, to apply your changes to the machine.

<a href="#heading--tag-multiple-machines"><h3 id="heading--tag-multiple-machines">Tagging multiple machines at once</h3></a>

In the first step of the above procedure, you can select more than one machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/0c04973e76012c780035a4ea11a588f341148445.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/0c04973e76012c780035a4ea11a588f341148445.png"></a>

Any tags you add in the "Tags" box will be applied to all selected machines, as noted by the change in the "Tag machine" button:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a503261eb7faa17478b09aa70f48f838b4b0fb87.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a503261eb7faa17478b09aa70f48f838b4b0fb87.png"></a>

Other than the scope of the transaction (e.g., tagging three machines, in this case), everything else about this operation remains the same as that for one tag, above.

<a href="#heading--create-assign-storage-tag"><h2 id="heading--create-assign-storage-tag">How do I create and assign a tag to a storage configuration?</h2></a>

If you want to assign a tag to a storage configuration, follow this process:

1. Go to the machine listing and click on the name of the machine -- the one that contains the storage configuration that you want to tag:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png"></a>

2. Select the "Storage" tab in the individual machine listing:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png"></a>

3. Look for the section labeled "Available disks and partitions" (if there isn't one, you can't assign any storage tags for this machine):

<a href="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png"></a>

4. For an individual logical volume or physical disk, choose the dropdown under "ACTIONS" on the end of the correct row, and select the relevant "Edit..." choice:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png"></a>

Note that you can't add tags to volume groups or other storage collections.

5.  In the dialog which pops up, enter the desired tags in the Tags field, as described in the [general tagging procedure](#heading--create-assign-tag-general) above.

You can assign as many tags as you want, within the constraints that tag names can include any combination of alphabetic letters (a-zA-Z), numbers (0-9), dashes (-) and underscores (_); can be a maximum of 256 characters in length; and <b>cannot</b> include spaces.

6. When you're done, be sure to click the "Save" button to apply your changes to the machine.

<a href="#heading--create-assign-interface-tag"><h2 id="heading--create-assign-interface-tag">How do I create and assign a tag to a network interface?</h2></a>

To assign a tag to a network interface, use the following procedure:

1. Go to the machine list and select the machine where that interface resides, by clicking on that machine's name:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png"></a>

2. Click on the "Network" tab:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png"></a>

3. Choose the interface you'd like to tag, by select the checkbox next to its name:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png"></a>

The checkbox isn't strictly needed to apply the tag, but it helps prevent you from choosing the wrong one when multiple interfaces are available.

4. Select the dropdown under "ACTIONS" at the end of the row, and select "Edit Physical" to edit the parameters of the physical interface:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png"></a>

5. Edit the "Tags" field as desired, as described in the [general tagging procedure](#heading--create-assign-tag-general) above.

6. Be sure to select the "Tag machine" button to apply your changes to the interface for that machine.

Note that different machines may have the same physical interface name, but different MAC addresses, so it's not typical that interface tags carry over from one machine to the next -- so autocomplete menus will be sparse or non-existent most of the time for these tag types.

<a href="#heading--create-assign-device-tag"><h2 id="heading--create-assign-device-tag">How do I create and assign a tag to a device?</h2></a>

To add a tag to a device, follow this procedure:

1. Select the "Devices" tab; it may be in a dropdown labeled "Hardware," if your browser window is not very large:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/22b17d4827f82c103e958205011ca13934fe2f3f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/22b17d4827f82c103e958205011ca13934fe2f3f.png"></a>

2. Select the device you'd like to tag, by clicking on its name:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/94717b99a4cea205099e3fdfd492daefe683e68d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/94717b99a4cea205099e3fdfd492daefe683e68d.png"></a>

3. In the "Tags" card, select the "Edit" link, or choose the "Configuration" tab under the device name:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/901e7bd556f26560e44b4b74c41b506399e86375.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/901e7bd556f26560e44b4b74c41b506399e86375.png"></a>

4. Select the "Edit" button on the "Configuration" tab which comes up:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d80039410bfeba4b6feb35490ccf82b3be80904f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d80039410bfeba4b6feb35490ccf82b3be80904f.png"></a>

5. Edit the "Tags" field, as explained in the [general tagging procedure](#heading--create-assign-tag-general) above.

6. Be sure to hit the "Save changes" button to apply your changes to the device.

<a href="#heading--remove-a-tag"><h2 id="heading--remove-a-tag">How do I remove a tag from a node?</h2></a>

snap-2-7-ui snap-2-8-ui snap-2-9-ui deb-2-7-ui deb-2-8-ui deb-2-9-ui snap-3-0-ui deb-3-0-ui  -->


<a href="#heading--delete-a-tag"><h2 id="heading--delete-a-tag">How do I delete a tag?</h2></a>

<a href="#heading--edit-a-tag"><h2 id="heading--edit-a-tag">How do I edit a tag?</h2></a>

<a href="#heading--list-tags"><h2 id="heading--list-tags">How do I list tags?</h2></a>

<a href="#heading--filter-listings-using-tags"><h2 id="heading--filter-listings-using-tags">How do I filter listings using tags?</h2></a>

<a href="#heading--assign-per-machine-kernel-boot-options"><h2 id="heading--assign-per-machine-kernel-boot-options">How do I use tags to assign per-machine kernel boot options?</h2></a>


#### Five questions you may have:


<!-- deb-2-7-ui
1. [How are tags defined?](#heading--tag-definitions)
2. [How can I set kernel boot options for a specific machine?](/t/maas-tags-deb-2-7-cli/2892#heading--per-node-kernel-boot-options)
3. [How can I see and filter the tag list?](#heading--tag-listing-and-tags-as-search-filters)
4. [How do I see and change which tags are assigned?](#heading--tag-assignment)
5. [How do I manage tags?](#heading--tag-management)
 deb-2-7-ui -->

<!-- deb-2-8-ui
1. [How are tags defined?](#heading--tag-definitions)
2. [How can I set kernel boot options for a specific machine?](/t/maas-tags-deb-2-8-cli/2894#heading--per-node-kernel-boot-options)
3. [How can I see and filter the tag list?](#heading--tag-listing-and-tags-as-search-filters)
4. [How do I see and change which tags are assigned?](#heading--tag-assignment)
5. [How do I manage tags?](#heading--tag-management)
 deb-2-8-ui -->

1. [How are tags defined?](#heading--tag-definitions)
2. [How can I set kernel boot options for a specific machine?](/t/maas-tags-deb-2-9-cli/2896#heading--per-node-kernel-boot-options)
3. [How can I see and filter the tag list?](#heading--tag-listing-and-tags-as-search-filters)
4. [How do I see and change which tags are assigned?](#heading--tag-assignment)
5. [How do I manage tags?](#heading--tag-management)

<!-- snap-2-7-ui
1. [How are tags defined?](#heading--tag-definitions)
2. [How can I set kernel boot options for a specific machine?](/t/maas-tags-snap-2-7-cli/2886#heading--per-node-kernel-boot-options)
3. [How can I see and filter the tag list?](#heading--tag-listing-and-tags-as-search-filters)
4. [How do I see and change which tags are assigned?](#heading--tag-assignment)
5. [How do I manage tags?](#heading--tag-management)
 snap-2-7-ui -->

<!-- snap-2-8-ui
1. [How are tags defined?](#heading--tag-definitions)
2. [How can I set kernel boot options for a specific machine?](/t/maas-tags-snap-2-8-cli/2888#heading--per-node-kernel-boot-options)
3. [How can I see and filter the tag list?](#heading--tag-listing-and-tags-as-search-filters)
4. [How do I see and change which tags are assigned?](#heading--tag-assignment)
5. [How do I manage tags?](#heading--tag-management)
 snap-2-8-ui -->

<!-- snap-2-9-ui
1. [How are tags defined?](#heading--tag-definitions)
2. [How can I set kernel boot options for a specific machine?](/t/maas-tags-snap-2-9-cli/2890#heading--per-node-kernel-boot-options)
3. [How can I see and filter the tag list?](#heading--tag-listing-and-tags-as-search-filters)
4. [How do I see and change which tags are assigned?](#heading--tag-assignment)
5. [How do I manage tags?](#heading--tag-management)
 snap-2-9-ui -->

MAAS supports binding an XPath expressions to a tag using *tag definitions* (see below). This makes auto-assigning tags to matching hardware possible. For instance, you could tag machines that possess fast GPUs and then deploy software that used GPU-accelerated CUDA or OpenCL libraries.

<a href="#heading--tag-definitions"><h2 id="heading--tag-definitions">Tag definitions</h2></a>

A *tag definition* is the criteria by which machines are auto-labelled by the corresponding tag. During machine enlistment, MAAS collects hardware information (using the [lshw](http://ezix.org/project/wiki/HardwareLiSter) utility). The definition used in creating a tag is then constructed using an *XPath expression* based on that information. See [w3schools documentation](https://www.w3schools.com/xml/xpath_intro.asp) for details on XPath.

The collected data for each machine, viewable (in both XML and YAML) in the web UI, is inspected by you for the desired property. Building on the example alluded to above, a property can be a GPU with a clock speed greater than 1GHz. In this case, the following excerpt from a machine's data (in XML format) is pertinent:

``` nohighlight
      <lshw:node id="display" class="display" handle="PCI:0000:00:02.0">
       <lshw:description>VGA compatible controller</lshw:description>
       <lshw:product>GD 5446</lshw:product>
       <lshw:vendor>Cirrus Logic</lshw:vendor>
       <lshw:physid>2</lshw:physid>
       <lshw:businfo>pci@0000:00:02.0</lshw:businfo>
       <lshw:version>00</lshw:version>
       <lshw:width units="bits">32</lshw:width>
       <lshw:clock units="Hz">33000000</lshw:clock>
       <lshw:configuration>
        <lshw:setting id="latency" value="0"/>
       </lshw:configuration>
       <lshw:capabilities>
        <lshw:capability id="vga_controller"/>
       </lshw:capabilities>
       <lshw:resources>
        <lshw:resource type="memory" value="fc000000-fdffffff"/>
        <lshw:resource type="memory" value="febd0000-febd0fff"/>
        <lshw:resource type="memory" value="febc0000-febcffff"/>
       </lshw:resources>
      </lshw:node>
```

MAAS machines will be selected based on these four XPath *predicates*:

1.   *element* of 'node'
2.   with an *attribute* of 'id'
3.   whose *value* is 'display'
4.   and has a *child element* of 'clock units="Hz"'

After adding the speed criteria via an XPath *operator* we end up with this as our tag definition:

``` nohighlight
//node[@id="display"]/'clock units="Hz"' > 1000000000
```

<a href="#heading--tag-listing-and-tags-as-search-filters"><h2 id="heading--tag-listing-and-tags-as-search-filters">Tag listing and tags as search filters</h2></a>

To list all tags, visit the 'Machines' tab and expand the 'Tags' subsection in the left pane.

In this view, you can use tags as machine search filters. Select one or several tags. The machines that satisfy all selected tags will display on the right pane. Notice there is a search field at the top of the right pane. You can type a search expression into this field.

Below, tag 'virtual' has been selected (with the mouse), and the search field automatically reflects this. Five machines satisfy this search filter.

<a href="https://assets.ubuntu.com/v1/69aa9997-nodes-tags__2.6-tags-filter.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/69aa9997-nodes-tags__2.6-tags-filter.png"></a>

Remove a tag from the search filter by either hitting the 'x' character alongside a tag or editing the search expression.

<a href="#heading--tag-assignment"><h2 id="heading--tag-assignment">Tag assignment</h2></a>

To view a machine's currently assigned tags, stay on the 'Machines' page and click on the machine in question. MAAS will display currently-assigned tags in the *Tags* pane of the 'Machine summary'.

Select the 'Configuration' tab and then the 'Edit' button alongside 'Machine configuration' to edit tags:

1.   To unassign a tag hit the 'x' character alongside a tag.
2.   To create a basic tag, type the name of the new tag in the 'Add a tag' field and hit Enter. The tag will be created and automatically assigned to the machine. Repeat if desired.
3.   To assign an existing tag, type at least three characters to trigger a real-time search. Any resulting tags will show up in a drop-down menu. Select as desired.

<a href="https://assets.ubuntu.com/v1/250050ee-nodes-tags__2.6-tags-add-remove.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/250050ee-nodes-tags__2.6-tags-add-remove.png"></a>

You can apply changes by pressing the 'Save changes' button.

[note]
New tags become available as a filter in the 'Machines' page in the web UI immediately after you add them.
[/note]

<a href="#heading--tags-for-network-interfaces"><h3 id="heading--tags-for-network-interfaces">Tags for network interfaces</h3></a>

It's also possible to assign tags to specific network interfaces. You can use these tags when searching for machines within the web UI and when allocating machines from the API.

Network interface tags can only be assigned when a machine is in either a 'Ready' or a 'Broken' state.

With the machine selected from the 'Machines' page, on the 'Interfaces' tab use the 'Edit Physical' button from the 'Actions' menu icon to the right of an interface:

<a href="https://assets.ubuntu.com/v1/dd9cf996-nodes-tags__2.6-tag-net-interfaces.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/dd9cf996-nodes-tags__2.6-tag-net-interfaces.png"></a>

To add a tag, type its name into the 'Tags' field and press Enter. Repeat as desired. Use the small 'x' next to a tag to unassign the tag.

You can apply changes by pressing the 'Save' button.

<a href="#heading--tags-for-storage-configuration"><h3 id="heading--tags-for-storage-configuration">Tags for storage configuration</h3></a>

Alongside tags for an entire machine and network interfaces, you can also define tags for storage devices. You can use these tags like any other, when searching for machines within the web UI, where they appear beneath the 'Storage tag' filter, and when allocating machines from the API.

To add a tag to a storage device, click on the machine with the storage you wish to tag on the 'Machines' page of the web UI and open the 'Storage' tab. Use the menu in the 'Actions' column beneath 'Available disks and partitions' to select 'Edit disk' for your chosen device:

<a href="https://assets.ubuntu.com/v1/43dd9f9d-nodes-tags__2.6-tag-storage.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/43dd9f9d-nodes-tags__2.6-tag-storage.png"></a>

To add a tag, type its name into the 'Tags' field and press Enter. Repeat as desired. Use the small 'x' next to a tag to unassign the tag.

You can apply changes by pressing the 'Save' button.

<!-- snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli
#### Ten questions you may have:

1. [How do I get started with the MAAS CLI?](/t/maas-cli/802)
2. [How can I set kernel boot options for a specific machine?](#heading--per-node-kernel-boot-options)
3. [How do I create tags?](#heading--rudimentary-tag-creation)
4. [How do I do tag creation and auto-assignment?](#heading--tag-creation-and-auto-assignment)
5. [How do I delete a tag?](#heading--delete-a-tag)
6. [How do I list all tags?](#heading--list-all-tags)
7. [How do I list nodes/machines labelled with a tag?](#heading--list-nodesmachines-labelled-with-a-tag)
8. [How do I handle Juju integration?](#heading--juju-integration)
9. [How do I effect manual tag assignment?](#heading--manual-tag-assignment)
10. [How do I effect hybrid tag assignment?](#heading--hybrid-tag-assignment)

<a href="#heading--rudimentary-tag-creation"><h2 id="heading--rudimentary-tag-creation">Tag creation</h2></a>

``` bash
maas $PROFILE tags create name=$TAG_NAME
```

<a href="#heading--tag-creation-and-auto-assignment"><h2 id="heading--tag-creation-and-auto-assignment">Tag creation and auto-assignment</h2></a>

When you supply a [definition](#heading--tag-definitions) during a tag's creation, MAAS automatically applies the tag to all the nodes that satisfy the definition:

``` bash
maas $PROFILE tags create name=$TAG_NAME \
    comment='$TAG_COMMENT' definition='$TAG_DEFINITION'
```

For example,

``` bash
maas $PROFILE tags create name='gpu' \
    comment='GPU with clock speed >1GHz for running CUDA type operations.' \
    definition='//node[@id="display"]/'clock units="Hz"' > 1000000000'
```

We recommend that each tag have a short name and a comment that adequately describes it. You should make sure to create both of these because they will help you identify and use the tag later.

<h2 id="heading--tags-for-network-interfaces">Tags for network interfaces</h2>

It's also possible to assign tags to specific network interfaces. You can use these tags when searching for machines within the web UI and when allocating machines from the API.

Network interface tags can only be assigned when a machine is in either a 'Ready' or a 'Broken' state.

To add a tag to a network interface, use the following command:

```
maas $PROFILE interface add-tag $SYSTEM_ID $INTERFACE_ID tag=$TAG_STRING
```

To delete a tag from a network interface:

```
maas $PROFILE interface remove-tag $SYSTEM_ID $INTERFACE_ID tag=$TAG_STRING
```

<a href="#heading--tags-for-network-interfaces"><h3 id="heading--tags-for-network-interfaces">Tags for network interfaces</h3></a>

It's also possible to assign tags to specific network interfaces. You can use these tags when searching for machines within the web UI and when allocating machines from the API.

Network interface tags can only be assigned when a machine is in either a 'Ready' or a 'Broken' state.

To add a tag to a network interface, use the following command:

```
maas $PROFILE interface add-tag $SYSTEM_ID $INTERFACE_ID tag=$TAG_STRING
```

To delete a tag from a network interface:

```
maas $PROFILE interface remove-tag $SYSTEM_ID $INTERFACE_ID tag=$TAG_STRING
```

<h2 id="><h2 id="heading--delete-a-tag">Delete a tag</h2></a>

``` bash
maas $PROFILE tag delete $TAG_NAME
```

<a href="#heading--list-all-tags"><h2 id="heading--list-all-tags">List all tags</h2></a>

To list all tags present on the region controller:

``` bash
maas $PROFILE tags read
```

<a href="#heading--list-nodesmachines-labelled-with-a-tag"><h2 id="heading--list-nodesmachines-labelled-with-a-tag">List nodes/machines labelled with a tag</h2></a>

To list what nodes (or machines) a tag applies to:

``` bash
maas $PROFILE tag nodes $TAG_NAME
maas $PROFILE tag machines $TAG_NAME
```

<a href="#heading--juju-integration"><h2 id="heading--juju-integration">Juju integration</h2></a>

Although you can use a tag in the web UI (as a node search filter), you realise most of the benefit when you're deploying applications with Juju.

For example, to use the 'gpu' tag to deploy a (hypothetical) service called 'cuda':

``` bash
juju deploy --constraints tags=gpu cuda
```

You can also use multiple tags in addition to the normal Juju constraints:

``` bash
juju deploy --constraints "mem=1024 tags=gpu,intel" cuda
```

<a href="#heading--manual-tag-assignment"><h2 id="heading--manual-tag-assignment">Manual tag assignment</h2></a>

It is possible to assign tags to nodes manually by simply omitting the definition and applying the tag to a node by referencing its system id:

``` bash
maas $PROFILE tags create name=$TAG_NAME comment='$TAG_COMMENT'
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID
```

To remove a tag:

``` bash
maas $PROFILE tag update-nodes $TAG_NAME remove=$SYSTEM_ID
```

In the same operation, a tag can be added to some nodes and removed from others:

``` bash
maas $PROFILE tag update-nodes $TAG_NAME \
    add=$SYSTEM_ID_1 add=$SYSTEM_ID_2 remove=$SYSTEM_ID_3
```

<a href="#heading--hybrid-tag-assignment"><h2 id="heading--hybrid-tag-assignment">Hybrid tag assignment</h2></a>

You can also create a tag with a definition (thereby map to certain nodes), remove the definition (but retain the mapping), and then add the tag manually to specific nodes. This action is useful for hardware which is conceptually similar but does not all satisfy a single tag definition. Here are the commands you would use to do this:

``` bash
maas $PROFILE tags create name=$TAG_NAME \
    comment='$TAG_COMMENT' definition='$TAG_DEFINITION'
maas $PROFILE tag update $TAG_NAME definition=''
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID
```

<a href="#heading--per-node-kernel-boot-options"><h2 id="heading--per-node-kernel-boot-options">Per-machine kernel boot options</h2></a>

Per-machine kernel boot options are set using the CLI.

[note]
Per-machine boot options take precedence to global ones. Please also note that, even though a deployed machine has a `kernel_opt` tag applied, MAAS won't apply the `kernel_opt` associated with that tag until the next deployment.  This means that a machine that has been deployed for a long time can (possibly) inherit kernel options that were applied in the distant past.
[/note]

To specify kernel boot options for an individual machine, first create a tag:

``` bash
maas $PROFILE tags create name='$TAG_NAME' \
    comment='$COMMENT' kernel_opts='$KERNEL_OPTIONS'
```

For example:

``` bash
maas $PROFILE tags create name='nomodeset' \
    comment='nomodeset kernel option' kernel_opts='nomodeset vga'
```

Next, assign the tag to the machine in question:

``` bash
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID
```

If multiple tags attached to a machine have the `kernel_opts` defined, MAAS uses the first one found, in alphabetical order.

See the [CLI tag management](/t/cli-tag-management/801) section for more information about using the CLI to manage tags.
snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli -->



------
****
------
