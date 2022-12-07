<!-- "How to tag machines" -->
Tags for different objects have similar purposes, but they aren't necessarily administered in the same way -- so we've included detailed articles for each tag type.  That said, many of the common operations regarding tags are performed in the same way.  This article will present some general, explanatory information, and then look at tag management steps that are the same (or very similar) across all types of MAAS tags.

<a href="#heading--name-tags"><h2 id="heading--name-tags">How to name tags</h2></a>

When working with tags, there are some universal rules you need to follow:

1. Tag names can include any combination of alphabetic letters (a-zA-Z), numbers (0-9), dashes (-) and underscores (_).
2. Tag names can be a maximum of 256 characters in length.
3. Tag names *cannot* include spaces.

In general, names that do not conform to these rules cannot be created.

<a href="#heading--automatic-tags"><h2 id="heading--automatic-tags">About automatic tags</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages"]
Automatic tags are tags with a definition. The definition allows you to auto-apply tags to machines that match with an [XPath expression](#heading--xpath-expressions) you created. Setting up an automatic tag will help you recognise special hardware characteristics and settings. For instance, we can configure the gpu passthrough by creating an XPath expression that recognises a prospective GPU, as shown in the example below.  

In our REST API, a tag has 4 attributes namely, name, definition, kernel options, and comment. The example below shows you how to fill in the definition attribute to create an automatic tag.  In this case, we are tagging all machines that have Intel VT-d enabled and have a Tesla v100 PCIe 16GB GPU:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b40bc145f3129b257ba49bda53442f1b63c7b229.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7be5f2bebbba9a09f70a7dea092d091ef45228e2.png"></a>

When this tag is created, our REST API will try to match all machines with this definition and automatically apply the `gpgpu-tesla-v-100` tag to those machines. Every time a new machine is discovered in your MAAS, if new machines match this definition, they will be automatically tagged as well.

<a href="#heading--xpath-expressions"><h2 id="heading--xpath-expressions">About XPath expressions</h2></a>

MAAS automatic tags accept XPath expressions in the definition attribute of the tag. XPath expressions are evaluated against `lshw`'s XML output; they are used to locate elements or attributes of the XML document for use in configuring automatic tags. You can use the lshw output in the hardware configuration details of a machine in MAAS and use that to create an XPath expression. 

<a href="#heading--xpath-hardware-config-info"><h3 id="heading--xpath-hardware-config-info">Hardware configuration information</h3></a>

You can download your HW configuration information in the XML format by going to the machine details page of any allocated or deployed machines.  Choose Logs >> Installation output >> Download >> Machine output (XML) to capture these details:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/387b8b6a7ded18e523c818500d79f0d657868b87.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/387b8b6a7ded18e523c818500d79f0d657868b87.png"></a>

You can [learn more about these attributes](https://ezix.org/project/wiki/HardwareLiSter) if desired.  Note that:

* Size and capacity can have various meanings depending on the device
* The size of a node is always equal to its capacity
* Serial refers to the device’s serial number, but is used to report the MAC address for network devices, GUID for disk partition.

<a href="#heading--device-classes"><h3 id="heading--device-classes">Device classes</h3></a>

You can also find device classes from the same sources:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7368ba42d0d34571447dbb6830b363abace580bb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7368ba42d0d34571447dbb6830b363abace580bb.png"></a>

<a href="#heading--node-capabilities"><h3 id="heading--node-capabilities">Capabilities</h3></a>

Capabilities are used to report features of a given node. The exact meaning of each feature depends on the type of node. It can be the presence of an arithmetical co-processor for a CPU, the ability to run at 1GB/s for a network interface, etc. In most cases, capabilities reported by lshw are auto-documented.

To see the capabilities of a specific machine, you can download your HW configuration information, as described above.

<a href="#heading--kernel-options"><h2 id="heading--kernel-options">About Kernel options</h2></a>

You can add kernel options when creating both manual and automatic tags. Kernel options will be automatically applied at boot time or when the machine with that tag is commissioned or deployed. 

When updating kernel options on a tag that matches Deployed machines, be aware that the new kernel option will be applied during boot time, so you will need to release and re-deploy them to pick up the change. Otherwise, these deployed machines will have the old kernel options.

If there are multiple tags associated with a machine, the kernel options will be concatenated from all the tags combined, sorted alphabetically .

<a href="#heading--how-to-create-automatic-tags"><h2 id="heading--how-to-create-automatic-tags">How to create automatic tags</h1></a>

You can create an automatic tag by going to the `Tag` tab and click `Create new tag`. A tag is considered automatic when the definition field is filled with an XPath expression. The current version of our UI will only validate if your XPath expression is valid or not, but it will not show you which machines it will apply to before you create the tag.

Here is a thumbnail sketch of how automatic tags work:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fb003af31284581af931868daff1d735b6a52336.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fb003af31284581af931868daff1d735b6a52336.png"></a>

When you choose to create a new tag, you are presented with a screen similar to this one:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e56224d790144ba30199f37370437d63aed09cd3.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e56224d790144ba30199f37370437d63aed09cd3.png"></a>

While creating the tag, you also have an option to add kernel options to an automatic tag. Bear in mind that if a machine has multiple tags, it will be tagged alphabetically and the kernel option from the last tag will be applied to that machine. 

Once an automatic tag is created the screen will initially show that 0 machines are tagged. That is because MAAS is running a background task to auto-apply the tag to matching machines. It can take some time to see that the number of machines tagged is populating. 

[note]
Kernel options will be applied at boot time. So by default kernel options will not be applied to any machines until they are deployed. If machines are deployed before they are tagged, the kernel option will be applied when these machines are redeployed.
[/note]

<a href="#heading--how-to-update-automatic-tags"><h2 id="heading--how-to-update-automatic-tags">How to update the definition of a tag</h2></a>

To update the definition for the automatic tag, go to the ‘Tag’ tab and click the edit icon:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/011d3179b7128fc1bee33a7368ca18267fe92c76.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/011d3179b7128fc1bee33a7368ca18267fe92c76.png"></a>

This will open up the form and allow you to make changes in edit mode:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1f4a8159dc08a0b013df323fbf88dcf80b932e3e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1f4a8159dc08a0b013df323fbf88dcf80b932e3e.png"></a>

If the new definition is not a valid XPath expression, MAAS will generate an error:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f8dff191b24ac07338c9c6e33d8a03e7e5001c46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f8dff191b24ac07338c9c6e33d8a03e7e5001c46.png"></a>

Keep in mind that when a new definition is updated, MAAS will re-tag all the machines that match with the new definition. This can take some time, since it is a background process. 

<a href="#heading--update-tag-kernel-options"><h2 id="heading--update-tag-kernel-options">How to update the kernel option on a Tag</h2></a>

Kernel options can exist for both manual and automatic tags. However, they will be applied during boot time (commissioning and deploying).  To update the kernel options, go to the ‘Tag’ tab and click the edit icon. Update the text area in the kernel option in this form:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/24ba6c81862981fdb7739cf61f2936b5204378e7.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/24ba6c81862981fdb7739cf61f2936b5204378e7.png"></a>

[note]
If the tagged machines are deployed, the updated kernel option won’t apply until the machines are redeployed. We suggest that you release those machines prior to the update, then redeploy those machines when the kernel options of the tag are updated.
[/note]

<a href="#heading--unassign-tags-from-machines"><h2 id="heading--unassign-ags-from-machines">How to unassign tags from machines</h2></a>

There are two ways to unassign tags. In the machine listing page, select all machines that you would like to unassign the tag then click ‘Tag’. A tag form is open. In the first field, ‘Tags’, click the x icon on the chip component to unassign the tags:

<a href="https://discourse.maas.io/uploads/default/original/2X/7/721d2f6c087ffaa9022f9a15e18783f309a4a3d0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/721d2f6c087ffaa9022f9a15e18783f309a4a3d0.png"></a>

Click "Remove" to unassign a tag:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9d0cd6b1a09f67237d48fb634c22b5f407c1ec4a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9d0cd6b1a09f67237d48fb634c22b5f407c1ec4a.png"></a>

The numbers prescribed in the chip indicate the number of selected machines associated with that tag. You may click on the chip to view its information. After unassigning, click save to confirm the changes. 

[note]
Automatic tags cannot be unassigned manually. You can either update or delete automatic tags.
[/note]

You can also unassign tags individually by going to the configuration tab on the machine details page; click the "X" icon to unassign the tag:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8b4cb6617d2287eca7617c962578f90722ac2332.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8b4cb6617d2287eca7617c962578f90722ac2332.png"></a>

You may reassign the tag by typing or clicking on the text field to see existing tags. Note that the tag will be assigned to all selected machines. 

<a href="#heading--see-all-tagged-nodes"><h2 id="heading--see-all-tagged-nodes">How to see all tagged nodes</h2></a>

To see how many nodes (Machines, controllers, devices) are tagged, search for GRUB_CMDLINE_LINUX_DEFAULT in the "Installation output" tab of the machine details page. That log should stay around for the lifetime of the deployment of the machine.  The log gets overwritten when you redeploy the machine.  For example:

```nohighlight
GRUB_CMDLINE_LINUX_DEFAULT="sysrq_always_enabled dyndbg='file drivers/usb/* +p' console=tty1 console=ttyS0"
```

<a href="#heading--tag-definition-reference"><h2 id="heading--tag-definition-reference">Tag definition reference examples</h2></a>

Here are some examples of tag definitions -- [more examples are available](https://github.com/canonical/mxt).

Commonly used Xpath functions usually include:

* contains
* starts-with
* ends-with

### Example 1

This definition will identify machines with proper CPU tags, cores, and RAM, and tag them as a hypervisor:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d1c8e2674445045ee9c8c9f1d14f3fa413af9be8.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d1c8e2674445045ee9c8c9f1d14f3fa413af9be8.png"></a>

This example looks for at least 40 cores and 256 GB of RAM and has all the required CPU features for being a hypervisor for both Intel and AMD.

[note]
Don't forget to adjust cores and RAM (in bytes) to suit your particular needs and available resources.
[/note]

You can also define this tag with the CLI:

```nohighlight
maas ${MAAS_PROFILE} tags create name=hypervisor \
definition='//node[@id="memory"]/size >= "274877906944" and \
//node[@id="cpu"]/configuration/setting/id="cores" >= 40 and \
//node[@id="cpu"]//capabilities/capability/@id = "vmx" or @id="svm" and \
//node[@id="cpu"]//capabilities/capability/@id = "aes" and 
//node[@id="cpu"]//capabilities/capability/@id = "flexpriority" and 
//node[@id="cpu"]//capabilities/capability/@id = "tpr_shadow" and 
//node[@id="cpu"]//capabilities/capability/@id = "ept" and 
//node[@id="cpu"]//capabilities/capability/@id = "vpid" and 
//node[@id="cpu"]//capabilities/capability/@id = "vnmi"'
```

### Example 2

This will tag UEFI enabled KVM VMs running on AMD-based servers:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/adde5f51e396a3a2d2f70daad7787fe087723664.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/adde5f51e396a3a2d2f70daad7787fe087723664.png"></a>

You can also do this with the CLI:

```nohighlight
maas ${MAAS_PROFILE} tags create \
name=kvm-amd-uefi \
definition='//node[@class="system"]/vendor = "QEMU" and //node[@id="firmware"]/capabilities/capability/@id = "virtualmachine" and //node[@id="firmware"]/capabilities/capability/@id = "uefi" and //node[@class="processor"]/vendor[starts-with(.,"Advanced Micro Devices")]' \
kernel_opts='nomodeset console=tty0 console=ttyS0,115200n8 amd_iommu=on kvm-amd.nested=1 kvm-amd.enable_apicv=n kvm.ignore_msrs=1' \
comment='Tag for automatically identifying AMD-based KVM vms (UEFI BIOS)'
```

### Example 3

This will automatically tag servers that have NVME controllers:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/166cd775669610ba454b5f2883e7729b79770bd0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/166cd775669610ba454b5f2883e7729b79770bd0.png"></a>

To accomplish the same thing in the CLI:

```nohighlight
maas ${MAAS_PROFILE} tags create name=NVME comment="xpath tag for automatically tagging servers that have NVME controllers" definition='//node[@id="storage" and @class="storage"]/description = "Non-Volatile memory controller"'
```

### Example 4

This will tag servers with Mellanox ConnectX-5 NICs:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/34ed75cf40ded49ac5eb8d76467817b5618b11a9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/34ed75cf40ded49ac5eb8d76467817b5618b11a9.png"></a>

And you can also do this in the CLI:

```nohighlight
maas ${MAAS_PROFILE} tags create \
name=connectx-5 \
definition='//node[@class="network"]/vendor[starts-with(.,"Mellanox")] and //node[@class="network"]/product[contains(.,"ConnectX-5")]' \
comment='Tag for automatically identifying servers with Mellanox Technologies ConnectX-5 cards'
```

### Example 5

This will enable GPU passthrough for Nvidia Quadro K series GPUs on AMD:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3f258d7e98c0adc7b605b8d2846b76737d46a27e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3f258d7e98c0adc7b605b8d2846b76737d46a27e.png"></a>

You can also duplicate this example in the CLI:

```nohighlight
maas ${MAAS_PROFILE} tags create \
name=gpgpu-quadro-k-a \
comment="Enable passthrough for Nvidia Quadro K series GPUs on AMD" \
definition='//node[@id="cpu:0"]/capabilities/capability/@id = "svm" and //node[@id="display"]/vendor[contains(.,"NVIDIA")] and //node[@id="display"]/description[contains(.,"3D")] and //node[@id="display"]/product[contains(.,"Quadro K")]'
```

[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]

[note]
Tag management UI is available starting in MAAS v3.2.
[/note]
[/tab]
[/tabs]

[tabs]
[tab version="v3.2 Snap,v3.2 Packages" view="UI"]
<a href="#heading--create-and-assign-tags"><h2 id="heading--create-and-assign-tags">How to create and assign tags</h2></a>

In the MAAS UI, creating and assigning tags is a combined operation; that is, you create tags as you assign them, rather than creating them first.  Creating tags in the UI is a little different user experience: there is a self-loading completion menu that collects all tags of a similar type.  This completion menu helps you avoid misspelling tags when entering them more than once; otherwise, you might not be able to group and filter tags properly. It also makes tag entry more efficient.

To remove a tag only from specific machines, go to the machine list and select the machines from which you want to remove that tag.  Choose the "Take action" button and select the "Tag" option:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/db90b855d4fb5eccc968d9a2375d3b187b619150.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/db90b855d4fb5eccc968d9a2375d3b187b619150.png"></a>

On the screen that follows, enter the name of the new tag in the tag name box, without spaces:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a7538882ca97278fbf927e11ccdc43b7e796c882.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a7538882ca97278fbf927e11ccdc43b7e796c882.png"></a>

A modal dialog pops up, giving you the opportunity to enter a name, comments, and kernel options for the new tag:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3a064e0677857fb6476b6bf60382eb3a34a602de.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3a064e0677857fb6476b6bf60382eb3a34a602de.png"></a>

Select "Create and add to tag changes"; you will be returned to the previous screen, with a special row labeled "To be added":

<a href="https://discourse.maas.io/uploads/default/original/2X/e/ec92304c819bdc697b5b42fc6245326c76d19300.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/ec92304c819bdc697b5b42fc6245326c76d19300.png"></a>

If the tag to be added looks correct, select "Save" to save and implement your changes.

<a href="#heading--delete-and-remove-tags"><h2 id="heading--delete-and-remove-tags">How to delete and remove tags</h2></a>

You have two choices when it comes to eliminating tags from machines in your MAAS instance: you can delete them from all machines, or simply remove them from specific machines.

<a href="#heading--delete-from-all-machines"><h3 id="heading--delete-from-all-machines">Deleting tags from all machines at once</h3></a>

To delete tags from all machines at the same time, go to the "Tags" tab in the machine list and click the trash can icon next to the tag you'd like to delete:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/bdb87e9731694b7b68b135fd77114fab19823012.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/bdb87e9731694b7b68b135fd77114fab19823012.png"></a>

A confirmation screen will pop up, warning you that you are about to remove the tag from all machines.  To confirm your choice, select the "Delete" button, or cancel if you change your mind:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/200020d67b7324fc55482604d4dae0eee16d0b42.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/200020d67b7324fc55482604d4dae0eee16d0b42.png"></a>

The tag will be deleted from the system altogether, and removed from every machine to which it was assigned.

<a href="#heading--remove-from-some-machines"><h3 id="heading--remove-from-some-machines">Removing a tag from specific machines</h3></a>

To remove a tag only from specific machines, go to the machine list and select the machines from which you want to remove that tag.  Choose the "Take action" button and select the "Tag" option:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/db90b855d4fb5eccc968d9a2375d3b187b619150.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/db90b855d4fb5eccc968d9a2375d3b187b619150.png"></a>

[note]
You may not remove automatic tags using this screen.
[/note]

Click the trash can icon ("Remove") next to the tags you with to remove from these particular machines:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/988417aa224e34e627135cd0374a50eba34b0eab.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/988417aa224e34e627135cd0374a50eba34b0eab.png"></a>

The tag will be removed from the selected machines.

[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
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
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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
[/tab]
[/tabs]