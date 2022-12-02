<!-- "How to label and find machines" -->

When you're working with a half-dozen machines, a lot of labelling isn't necessary.  As your constellation of machines grows, though, you reach a point where you can't keep a compact picture in your head.  This is where tags, annotations, and filtering come in.  

Two of the more useful attributes of machines are tags and annotations.  These can be used not only to identify machines, but to customise them (e.g., kernel options) when they are commissioned and deployed. You can [tag machines](/t/how-to-tag-machines/5928), [annotate machines](/t/how-to-annotate-machines/5929), and use tags to mark [machines](/t/how-to-use-machine-tags/5224), [storage](/t/how-to-use-storage-tags/5232), [controllers](/t/how-to-use-controller-tags/5216), and [network interfaces](/t/how-to-use-network-tags/5228).  

You can also use [filtering](/t/how-to-find-machines/5192) to find a given subset of machines.  There isn't a lot of theory, per se, on filtering, since it's just a utility function of the user interface.

The rest of this article contains a little background information on tags and annotations.

<a href="#heading--about-tags"><h3 id="heading--about-tags">About tags</h3></a>

Tags are short, descriptive, searchable words that can be applied to various MAAS objects, including:

- machines (physical and virtual)
- VM hosts
- controllers (rack and region)
- storage (virtual and physical; block devices or partitions)
- network interfaces
- devices
- nodes (in the CLI only)

Tags serve to help you identify, group, and find objects easily, especially when you routinely deploy hundreds of machines.


<a href="#heading--about-annotations"><h3 id="heading--about-annotations">About annotations</h3></a>

Annotations are descriptive, searchable phrases that apply only to machines.  There are two types of annotations: static (always present in any machine state), and dynamic (only present in allocated or deployed states).  Annotations help you identify, characterise, and inform others about your machines.


<a href="#heading--about-tags-and-scripts"><h4 id="heading--about-tags-and-scripts">About tags and scripts</h4></a>

As with general tag management, tags make scripts easier to manage; grouping scripts together for commissioning and testing, for example:

``` bash
maas $PROFILE node-script add-tag $SCRIPT_NAME tag=$TAG
maas $PROFILE node-script remove-tag $SCRIPT_NAME tag=$TAG
```

MAAS runs all commissioning scripts by default. However, you can select which custom scripts to run during commissioning by name or tag:

``` bash
maas $PROFILE machine commission \
commissioning_scripts=$SCRIPT_NAME,$SCRIPT_TAG
```

You can also select which testing scripts to run by name or tag:

``` bash
maas $PROFILE machine commission \
testing_scripts=$SCRIPT_NAME,$SCRIPT_TAG
```

Any testing scripts tagged with commissioning will also run during commissioning.

<a href="#heading--The-big-picture-of-tags"><h2 id="heading--The-big-picture-of-tags">The big picture of tags</h2></a>

- [Work with tags](/t/-/5928): Tags for different objects have similar purposes, but they aren’t necessarily administered in the same way.
- [Work with annotations](/t/-/5929): Annotations are descriptive, searchable phrases that apply only to machines. There are two types of annotations: static (always present in any machine state), and dynamic (only present in allocated or deployed states). Annotations help you identify, characterise, and inform others about your machines.
- [Use machine tags](/t/-/5224): There are a number of ways you can use tags with machines.
- [Use controller tags](/t/-/5216): Controllers can be tagged to help identify and recognise them.
- [Use storage tags](/t/-/5232): Block devices (and to a lesser extent, partitions) can be tagged so you can recognise and identify them easily.
- [Use network tags](/t/-/5228): You can use tags to help distinguish one network interface from another, or group network interfaces by category.


<a href="#heading--Tags-permuted-index"><h2 id="heading--Tags-permuted-index">Tags permuted index</h2></a>

| | |
|-----:|:------|
| [a block device](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-block-device) |How to assign tags to |
| [a block device](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-block-device) |How to remove tags from |
| [About automatic tags](/t/how-to-work-with-tags/5928#heading--automatic-tags) | |
| [About Kernel options](/t/how-to-work-with-tags/5928#heading--kernel-options) | |
| [About XPath expressions](/t/how-to-work-with-tags/5928#heading--xpath-expressions) | |
| [Adding and removing machine tags simultaneously from multiple machines](/t/how-to-use-machine-tags/5224#heading--adding-and-removing-machine-tags-simultaneously) | |
| [all block devices](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-block-devices) |How to list tags for |
| [all machines at once](/t/how-to-work-with-tags/5928#heading--delete-from-all-machines) |Deleting tags from |
| [all machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-all-machines) |How to list machine tags for |
| [all machines](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-all-machines) |How to list dynamic annotations for |
| [all machines](/t/how-to-work-with-annotations/5929#heading--list-static-annotations-for-all-machines) |How to list static annotations for |
| [all network interfaces](/t/how-to-use-network-tags/5228#heading--list-tags-for-all-network-interfaces) |How to list tags for |
| [all partitions](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-partitions) |How to list tags for |
| [all rack controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-rack-controllers) |How to list tags for |
| [all region controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-region-controllers) |How to list tags for |
| [all tagged nodes](/t/how-to-work-with-tags/5928#heading--see-all-tagged-nodes) |How to see |
| [all tags available on this MAAS](/t/how-to-work-with-tags/5928#heading--list-all-tags-available-on-this-maas) |How to list |
| [all virtual machine hosts](/t/how-to-use-machine-tags/5224#heading--list-tags-for-all-vm-hosts) |How to list tags for |
| [a machine](/t/how-to-use-machine-tags/5224#heading--assign-machine-tags-to-a-machine) |How to assign machine tags to |
| [a machine](/t/how-to-use-machine-tags/5224#heading--remove-machine-tags-from-a-machine) |How to remove machine tags from |
| [a machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or clear a static annotation for |
| [a machine](/t/how-to-work-with-annotations/5929#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear and change dynamic annotations for |
| [a machine](/t/how-to-work-with-annotations/5929#heading--set-a-static-annotation-for-a-machine) |How to set a static annotation for |
| [a machine](/t/how-to-work-with-annotations/5929#heading--set-dynamic-annotations-for-a-machine) |How to set dynamic annotations for |
| [and assign block device tags](/t/how-to-use-storage-tags/5232#heading--create-and-assign-block-device-tags) |How to create |
| [and assign controller tags ](/t/how-to-use-controller-tags/5216#heading--create-and-assign-controller-tags-) |How to create |
| [and assign machine tags to machines](/t/how-to-use-machine-tags/5224#heading--create-and-assign-machine-tags-to-machines) |How to create |
| [and assign network interface tags](/t/how-to-use-network-tags/5228#heading--create-and-assign-network-interface-tags) |How to create |
| [and assign static annotations](/t/how-to-work-with-annotations/5929#heading--create-and-assign-static-annotations) |How to create |
| [and assign tags](/t/how-to-work-with-tags/5928#heading--create-and-assign-tags) |How to create |
| [and change dynamic annotations for a machine](/t/how-to-work-with-annotations/5929#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear |
| [and delete block device tags](/t/how-to-use-storage-tags/5232#heading--remove-and-delete-block-device-tags) |How to remove |
| [and delete controller tags](/t/how-to-use-controller-tags/5216#heading--remove-and-delete-controller-tags) |How to remove |
| [and delete machine tags from machines](/t/how-to-use-machine-tags/5224#heading--remove-and-delete-machine-tags-from-machines) |How to remove |
| [and delete network interface tags](/t/how-to-use-network-tags/5228#heading--remove-and-delete-network-interface-tags) |How to remove |
| [and partition tags](/t/how-to-use-storage-tags/5232#heading--list-block-device-and-partition-tags) |How to list block device |
| [and remove tags](/t/how-to-work-with-tags/5928#heading--delete-and-remove-tags) |How to delete |
| [and removing machine tags simultaneously from multiple machines](/t/how-to-use-machine-tags/5224#heading--adding-and-removing-machine-tags-simultaneously) |Adding |
| [a network interface](/t/how-to-use-network-tags/5228#heading--assign-tags-to-a-network-interface) |How to assign tags to |
| [a network interface](/t/how-to-use-network-tags/5228#heading--remove-tags-from-a-network-interface) |How to remove tags from |
| [annotation for a machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or clear a static |
| [annotation for a machine](/t/how-to-work-with-annotations/5929#heading--set-a-static-annotation-for-a-machine) |How to set a static |
| [annotation for one machine](/t/how-to-work-with-annotations/5929#heading--view-a-static-annotation-for-one-machine) |How to view a static |
| [annotations for all machines](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-all-machines) |How to list dynamic |
| [annotations for all machines](/t/how-to-work-with-annotations/5929#heading--list-static-annotations-for-all-machines) |How to list static |
| [annotations for a machine](/t/how-to-work-with-annotations/5929#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear and change dynamic |
| [annotations for a machine](/t/how-to-work-with-annotations/5929#heading--set-dynamic-annotations-for-a-machine) |How to set dynamic |
| [annotations for one machine](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-one-machine) |How to list dynamic |
| [annotations for one machine](/t/how-to-work-with-annotations/5929#heading--view-dynamic-workload-annotations-for-one-machine) |How to view dynamic (workload) |
| [annotations](/t/how-to-work-with-annotations/5929#heading--create-and-assign-static-annotations) |How to create and assign static |
| [annotations](/t/how-to-work-with-annotations/5929#heading--delete-static-annotations) |How to delete static |
| [annotations](/t/how-to-work-with-annotations/5929#heading--filter-on-dynamic-workload-annotations) |How to filter on dynamic (workload) |
| [annotations](/t/how-to-work-with-annotations/5929#heading--identify-machines-that-can-receive-dynamic-annotations) |How to identify machines that can receive dynamic |
| [annotations](/t/how-to-work-with-annotations/5929#heading--view-static-annotations) |How to view static |
| [annotations](/t/how-to-work-with-annotations/5929#heading--work-with-annotations) |Work with |
| [annotations](/t/how-to-work-with-annotations/5929#heading--work-with-dynamic-workload-annotations) |How to work with dynamic (workload) |
| [annotations](/t/how-to-work-with-annotations/5929#heading--work-with-static-annotations) |How to work with static |
| [a partition](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-partition) |How to assign tags to |
| [a partition](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-partition) |How to remove tags from |
| [a rack controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-rack-controller) |How to assign tags to |
| [a rack controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-rack-controller) |How to remove tags from |
| [a region controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-region-controller) |How to assign tags to |
| [a region controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-region-controller) |How to remove tags from |
| [assign block device tags](/t/how-to-use-storage-tags/5232#heading--create-and-assign-block-device-tags) |How to create and |
| [assign controller tags ](/t/how-to-use-controller-tags/5216#heading--create-and-assign-controller-tags-) |How to create and |
| [assign machine tags to a machine](/t/how-to-use-machine-tags/5224#heading--assign-machine-tags-to-a-machine) |How to |
| [assign machine tags to machines](/t/how-to-use-machine-tags/5224#heading--create-and-assign-machine-tags-to-machines) |How to create and |
| [assign network interface tags](/t/how-to-use-network-tags/5228#heading--create-and-assign-network-interface-tags) |How to create and |
| [assign static annotations](/t/how-to-work-with-annotations/5929#heading--create-and-assign-static-annotations) |How to create and |
| [assign tags](/t/how-to-work-with-tags/5928#heading--create-and-assign-tags) |How to create and |
| [assign tags to a block device](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-block-device) |How to |
| [assign tags to a network interface](/t/how-to-use-network-tags/5228#heading--assign-tags-to-a-network-interface) |How to |
| [assign tags to a partition](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-partition) |How to |
| [assign tags to a rack controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-rack-controller) |How to |
| [assign tags to a region controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-region-controller) |How to |
| [assign tags to a virtual machine host](/t/how-to-use-machine-tags/5224#heading--assign-tags-to-a-vm-host) |How to |
| [a static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or clear |
| [a static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--set-a-static-annotation-for-a-machine) |How to set |
| [a static annotation for one machine](/t/how-to-work-with-annotations/5929#heading--view-a-static-annotation-for-one-machine) |How to view |
| [a tag from specific machines](/t/how-to-work-with-tags/5928#heading--remove-from-some-machines) |Removing |
| [a tag](/t/how-to-work-with-tags/5928#heading--create-a-tag) |How to create |
| [a tag](/t/how-to-work-with-tags/5928#heading--delete-a-tag) |How to delete |
| [a tag](/t/how-to-work-with-tags/5928#heading--how-to-update-automatic-tags) |How to update the definition of |
| [a tag](/t/how-to-work-with-tags/5928#heading--rebuild-a-tag) |How to rebuild |
| [a tag](/t/how-to-work-with-tags/5928#heading--update-a-tag) |How to update |
| [a Tag](/t/how-to-work-with-tags/5928#heading--update-tag-kernel-options) |How to update the kernel option on |
| [at once](/t/how-to-use-machine-tags/5224#heading--tag-multiple-machines) |How to tag multiple machines |
| [at once](/t/how-to-work-with-tags/5928#heading--delete-from-all-machines) |Deleting tags from all machines |
| [automatic tags](/t/how-to-work-with-tags/5928#heading--automatic-tags) |About |
| [automatic tags](/t/how-to-work-with-tags/5928#heading--how-to-create-automatic-tags) |How to create |
| [available on this MAAS](/t/how-to-work-with-tags/5928#heading--list-all-tags-available-on-this-maas) |How to list all tags |
| [a virtual machine host](/t/how-to-use-machine-tags/5224#heading--assign-tags-to-a-vm-host) |How to assign tags to |
| [a virtual machine host](/t/how-to-use-machine-tags/5224#heading--remove-tags-from-a-vm-host) |How to remove tags from |
| [a VM host](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-a-vm-host) |How to view machine tags for |
| [block device and partition tags](/t/how-to-use-storage-tags/5232#heading--list-block-device-and-partition-tags) |How to list |
| [block devices](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-block-devices) |How to list tags for all |
| [block device tags](/t/how-to-use-storage-tags/5232#heading--create-and-assign-block-device-tags) |How to create and assign |
| [block device tags](/t/how-to-use-storage-tags/5232#heading--remove-and-delete-block-device-tags) |How to remove and delete |
| [block device tags](/t/how-to-use-storage-tags/5232#heading--view-block-device-tags) |How to view |
| [block device](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-block-device) |How to assign tags to a |
| [block device](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-block-device) |How to discover the ID of your |
| [block device](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-block-device) |How to remove tags from a |
| [block device](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-block-device) |How to view tags for one |
| [built-in kernel options](/t/how-to-work-with-tags/5928#heading--create-tags-with-built-in-kernel-options) |How to create tags with |
| [can receive dynamic annotations](/t/how-to-work-with-annotations/5929#heading--identify-machines-that-can-receive-dynamic-annotations) |How to identify machines that |
| [Capabilities](/t/how-to-work-with-tags/5928#heading--node-capabilities) | |
| [change dynamic annotations for a machine](/t/how-to-work-with-annotations/5929#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear and |
| [change or clear a static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) |How to |
| [classes](/t/how-to-work-with-tags/5928#heading--device-classes) |Device |
| [clear and change dynamic annotations for a machine](/t/how-to-work-with-annotations/5929#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to |
| [clear a static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or |
| [configuration information](/t/how-to-work-with-tags/5928#heading--xpath-hardware-config-info) |Hardware |
| [controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-rack-controllers) |How to discover the ID of your rack |
| [controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-region-controllers) |How to discover the ID of your region |
| [controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-rack-controllers) |How to list tags for all rack |
| [controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-region-controllers) |How to list tags for all region |
| [controller tags ](/t/how-to-use-controller-tags/5216#heading--create-and-assign-controller-tags-) |How to create and assign |
| [controller tags](/t/how-to-use-controller-tags/5216#heading--remove-and-delete-controller-tags) |How to remove and delete |
| [controller tags](/t/how-to-use-controller-tags/5216#heading--view-controller-tags) |How to view |
| [controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-rack-controller) |How to assign tags to a rack |
| [controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-region-controller) |How to assign tags to a region |
| [controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-rack-controller) |How to remove tags from a rack |
| [controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-region-controller) |How to remove tags from a region |
| [controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-rack-controller) |How to view tags for one rack |
| [controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-region-controller) |How to view tags for one region |
| [create and assign block device tags](/t/how-to-use-storage-tags/5232#heading--create-and-assign-block-device-tags) |How to |
| [create and assign controller tags ](/t/how-to-use-controller-tags/5216#heading--create-and-assign-controller-tags-) |How to |
| [create and assign machine tags to machines](/t/how-to-use-machine-tags/5224#heading--create-and-assign-machine-tags-to-machines) |How to |
| [create and assign network interface tags](/t/how-to-use-network-tags/5228#heading--create-and-assign-network-interface-tags) |How to |
| [create and assign static annotations](/t/how-to-work-with-annotations/5929#heading--create-and-assign-static-annotations) |How to |
| [create and assign tags](/t/how-to-work-with-tags/5928#heading--create-and-assign-tags) |How to |
| [create a tag](/t/how-to-work-with-tags/5928#heading--create-a-tag) |How to |
| [create automatic tags](/t/how-to-work-with-tags/5928#heading--how-to-create-automatic-tags) |How to |
| [create tags with built-in kernel options](/t/how-to-work-with-tags/5928#heading--create-tags-with-built-in-kernel-options) |How to |
| [definition of a tag](/t/how-to-work-with-tags/5928#heading--how-to-update-automatic-tags) |How to update the |
| [definition reference examples](/t/how-to-work-with-tags/5928#heading--tag-definition-reference) |Tag |
| [delete and remove tags](/t/how-to-work-with-tags/5928#heading--delete-and-remove-tags) |How to |
| [delete a tag](/t/how-to-work-with-tags/5928#heading--delete-a-tag) |How to |
| [delete block device tags](/t/how-to-use-storage-tags/5232#heading--remove-and-delete-block-device-tags) |How to remove and |
| [delete controller tags](/t/how-to-use-controller-tags/5216#heading--remove-and-delete-controller-tags) |How to remove and |
| [delete machine tags from machines](/t/how-to-use-machine-tags/5224#heading--remove-and-delete-machine-tags-from-machines) |How to remove and |
| [delete network interface tags](/t/how-to-use-network-tags/5228#heading--remove-and-delete-network-interface-tags) |How to remove and |
| [delete static annotations](/t/how-to-work-with-annotations/5929#heading--delete-static-annotations) |How to |
| [Deleting tags from all machines at once](/t/how-to-work-with-tags/5928#heading--delete-from-all-machines) | |
| [device and partition tags](/t/how-to-use-storage-tags/5232#heading--list-block-device-and-partition-tags) |How to list block |
| [Device classes](/t/how-to-work-with-tags/5928#heading--device-classes) | |
| [devices](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-block-devices) |How to list tags for all block |
| [device tags](/t/how-to-use-storage-tags/5232#heading--create-and-assign-block-device-tags) |How to create and assign block |
| [device tags](/t/how-to-use-storage-tags/5232#heading--remove-and-delete-block-device-tags) |How to remove and delete block |
| [device tags](/t/how-to-use-storage-tags/5232#heading--view-block-device-tags) |How to view block |
| [device](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-block-device) |How to assign tags to a block |
| [device](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-block-device) |How to discover the ID of your block |
| [device](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-block-device) |How to remove tags from a block |
| [device](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-block-device) |How to view tags for one block |
| [discover the ID of your block device](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-block-device) |How to |
| [discover the ID of your network interface](/t/how-to-use-network-tags/5228#heading--discover-the-id-of-your-network-interface) |How to |
| [discover the ID of your partition](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-partition) |How to |
| [discover the ID of your rack controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-rack-controllers) |How to |
| [discover the ID of your region controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-region-controllers) |How to |
| [discover your virtual machine host ID](/t/how-to-use-machine-tags/5224#heading--discover-your-vm-host-id) |How to |
| [dynamic annotations for all machines](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-all-machines) |How to list |
| [dynamic annotations for a machine](/t/how-to-work-with-annotations/5929#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear and change |
| [dynamic annotations for a machine](/t/how-to-work-with-annotations/5929#heading--set-dynamic-annotations-for-a-machine) |How to set |
| [dynamic annotations for one machine](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-one-machine) |How to list |
| [dynamic annotations](/t/how-to-work-with-annotations/5929#heading--identify-machines-that-can-receive-dynamic-annotations) |How to identify machines that can receive |
| [dynamic (workload) annotations for one machine](/t/how-to-work-with-annotations/5929#heading--view-dynamic-workload-annotations-for-one-machine) |How to view |
| [dynamic (workload) annotations](/t/how-to-work-with-annotations/5929#heading--filter-on-dynamic-workload-annotations) |How to filter on |
| [dynamic (workload) annotations](/t/how-to-work-with-annotations/5929#heading--work-with-dynamic-workload-annotations) |How to work with |
| [examples](/t/how-to-work-with-tags/5928#heading--tag-definition-reference) |Tag definition reference |
| [expressions](/t/how-to-work-with-tags/5928#heading--xpath-expressions) |About XPath |
| [filter on dynamic (workload) annotations](/t/how-to-work-with-annotations/5929#heading--filter-on-dynamic-workload-annotations) |How to |
| [for all block devices](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-block-devices) |How to list tags |
| [for all machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-all-machines) |How to list machine tags |
| [for all machines](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-all-machines) |How to list dynamic annotations |
| [for all machines](/t/how-to-work-with-annotations/5929#heading--list-static-annotations-for-all-machines) |How to list static annotations |
| [for all network interfaces](/t/how-to-use-network-tags/5228#heading--list-tags-for-all-network-interfaces) |How to list tags |
| [for all partitions](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-partitions) |How to list tags |
| [for all rack controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-rack-controllers) |How to list tags |
| [for all region controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-region-controllers) |How to list tags |
| [for all virtual machine hosts](/t/how-to-use-machine-tags/5224#heading--list-tags-for-all-vm-hosts) |How to list tags |
| [for a machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or clear a static annotation |
| [for a machine](/t/how-to-work-with-annotations/5929#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear and change dynamic annotations |
| [for a machine](/t/how-to-work-with-annotations/5929#heading--set-a-static-annotation-for-a-machine) |How to set a static annotation |
| [for a machine](/t/how-to-work-with-annotations/5929#heading--set-dynamic-annotations-for-a-machine) |How to set dynamic annotations |
| [for a VM host](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-a-vm-host) |How to view machine tags |
| [for multiple machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-multiple-machines) |How to list machine tags |
| [for one block device](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-block-device) |How to view tags |
| [for one machine](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-one-machine) |How to view machine tags |
| [for one machine](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-one-machine) |How to list dynamic annotations |
| [for one machine](/t/how-to-work-with-annotations/5929#heading--view-a-static-annotation-for-one-machine) |How to view a static annotation |
| [for one machine](/t/how-to-work-with-annotations/5929#heading--view-dynamic-workload-annotations-for-one-machine) |How to view dynamic (workload) annotations |
| [for one network interface](/t/how-to-use-network-tags/5228#heading--view-tags-for-one-network-interface) |How to view tags |
| [for one partition](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-partition) |How to view tags |
| [for one rack controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-rack-controller) |How to view tags |
| [for one region controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-region-controller) |How to view tags |
| [for one virtual machine host](/t/how-to-use-machine-tags/5224#heading--view-tags-for-one-vm-host) |How to view tags |
| [from a block device](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-block-device) |How to remove tags |
| [from all machines at once](/t/how-to-work-with-tags/5928#heading--delete-from-all-machines) |Deleting tags |
| [from a machine](/t/how-to-use-machine-tags/5224#heading--remove-machine-tags-from-a-machine) |How to remove machine tags |
| [from a network interface](/t/how-to-use-network-tags/5228#heading--remove-tags-from-a-network-interface) |How to remove tags |
| [from a partition](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-partition) |How to remove tags |
| [from a rack controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-rack-controller) |How to remove tags |
| [from a region controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-region-controller) |How to remove tags |
| [from a virtual machine host](/t/how-to-use-machine-tags/5224#heading--remove-tags-from-a-vm-host) |How to remove tags |
| [from machines](/t/how-to-use-machine-tags/5224#heading--remove-and-delete-machine-tags-from-machines) |How to remove and delete machine tags |
| [from machines](/t/how-to-work-with-tags/5928#heading--unassign-tags-from-machines) |How to unassign tags |
| [from multiple machines](/t/how-to-use-machine-tags/5224#heading--adding-and-removing-machine-tags-simultaneously) |Adding and removing machine tags simultaneously |
| [from specific machines](/t/how-to-work-with-tags/5928#heading--remove-from-some-machines) |Removing a tag |
| [Hardware configuration information](/t/how-to-work-with-tags/5928#heading--xpath-hardware-config-info) | |
| [host ID](/t/how-to-use-machine-tags/5224#heading--discover-your-vm-host-id) |How to discover your virtual machine |
| [hosts](/t/how-to-use-machine-tags/5224#heading--list-tags-for-all-vm-hosts) |How to list tags for all virtual machine |
| [host](/t/how-to-use-machine-tags/5224#heading--assign-tags-to-a-vm-host) |How to assign tags to a virtual machine |
| [host](/t/how-to-use-machine-tags/5224#heading--remove-tags-from-a-vm-host) |How to remove tags from a virtual machine |
| [host](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-a-vm-host) |How to view machine tags for a VM |
| [host](/t/how-to-use-machine-tags/5224#heading--view-tags-for-one-vm-host) |How to view tags for one virtual machine |
| [How to assign machine tags to a machine](/t/how-to-use-machine-tags/5224#heading--assign-machine-tags-to-a-machine) | |
| [How to assign tags to a block device](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-block-device) | |
| [How to assign tags to a network interface](/t/how-to-use-network-tags/5228#heading--assign-tags-to-a-network-interface) | |
| [How to assign tags to a partition](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-partition) | |
| [How to assign tags to a rack controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-rack-controller) | |
| [How to assign tags to a region controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-region-controller) | |
| [How to assign tags to a virtual machine host](/t/how-to-use-machine-tags/5224#heading--assign-tags-to-a-vm-host) | |
| [How to change or clear a static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) | |
| [How to clear and change dynamic annotations for a machine](/t/how-to-work-with-annotations/5929#heading--clear-and-change-dynamic-annotations-for-a-machine) | |
| [How to create and assign block device tags](/t/how-to-use-storage-tags/5232#heading--create-and-assign-block-device-tags) | |
| [How to create and assign controller tags ](/t/how-to-use-controller-tags/5216#heading--create-and-assign-controller-tags-) | |
| [How to create and assign machine tags to machines](/t/how-to-use-machine-tags/5224#heading--create-and-assign-machine-tags-to-machines) | |
| [How to create and assign network interface tags](/t/how-to-use-network-tags/5228#heading--create-and-assign-network-interface-tags) | |
| [How to create and assign static annotations](/t/how-to-work-with-annotations/5929#heading--create-and-assign-static-annotations) | |
| [How to create and assign tags](/t/how-to-work-with-tags/5928#heading--create-and-assign-tags) | |
| [How to create a tag](/t/how-to-work-with-tags/5928#heading--create-a-tag) | |
| [How to create automatic tags](/t/how-to-work-with-tags/5928#heading--how-to-create-automatic-tags) | |
| [How to create tags with built-in kernel options](/t/how-to-work-with-tags/5928#heading--create-tags-with-built-in-kernel-options) | |
| [How to delete and remove tags](/t/how-to-work-with-tags/5928#heading--delete-and-remove-tags) | |
| [How to delete a tag](/t/how-to-work-with-tags/5928#heading--delete-a-tag) | |
| [How to delete static annotations](/t/how-to-work-with-annotations/5929#heading--delete-static-annotations) | |
| [How to discover the ID of your block device](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-block-device) | |
| [How to discover the ID of your network interface](/t/how-to-use-network-tags/5228#heading--discover-the-id-of-your-network-interface) | |
| [How to discover the ID of your partition](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-partition) | |
| [How to discover the ID of your rack controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-rack-controllers) | |
| [How to discover the ID of your region controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-region-controllers) | |
| [How to discover your virtual machine host ID](/t/how-to-use-machine-tags/5224#heading--discover-your-vm-host-id) | |
| [How to filter on dynamic (workload) annotations](/t/how-to-work-with-annotations/5929#heading--filter-on-dynamic-workload-annotations) | |
| [How to identify machines that can receive dynamic annotations](/t/how-to-work-with-annotations/5929#heading--identify-machines-that-can-receive-dynamic-annotations) | |
| [How to identify your machines](/t/how-to-work-with-annotations/5929#heading--identify-your-machines) | |
| [How to list all tags available on this MAAS](/t/how-to-work-with-tags/5928#heading--list-all-tags-available-on-this-maas) | |
| [How to list block device and partition tags](/t/how-to-use-storage-tags/5232#heading--list-block-device-and-partition-tags) | |
| [How to list dynamic annotations for all machines](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-all-machines) | |
| [How to list dynamic annotations for one machine](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-one-machine) | |
| [How to list machine tags for all machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-all-machines) | |
| [How to list machine tags for multiple machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-multiple-machines) | |
| [How to list static annotations for all machines](/t/how-to-work-with-annotations/5929#heading--list-static-annotations-for-all-machines) | |
| [How to list tags for all block devices](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-block-devices) | |
| [How to list tags for all network interfaces](/t/how-to-use-network-tags/5228#heading--list-tags-for-all-network-interfaces) | |
| [How to list tags for all partitions](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-partitions) | |
| [How to list tags for all rack controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-rack-controllers) | |
| [How to list tags for all region controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-region-controllers) | |
| [How to list tags for all virtual machine hosts](/t/how-to-use-machine-tags/5224#heading--list-tags-for-all-vm-hosts) | |
| [How to name tags](/t/how-to-work-with-tags/5928#heading--name-tags) | |
| [How to rebuild a tag](/t/how-to-work-with-tags/5928#heading--rebuild-a-tag) | |
| [How to remove and delete block device tags](/t/how-to-use-storage-tags/5232#heading--remove-and-delete-block-device-tags) | |
| [How to remove and delete controller tags](/t/how-to-use-controller-tags/5216#heading--remove-and-delete-controller-tags) | |
| [How to remove and delete machine tags from machines](/t/how-to-use-machine-tags/5224#heading--remove-and-delete-machine-tags-from-machines) | |
| [How to remove and delete network interface tags](/t/how-to-use-network-tags/5228#heading--remove-and-delete-network-interface-tags) | |
| [How to remove machine tags from a machine](/t/how-to-use-machine-tags/5224#heading--remove-machine-tags-from-a-machine) | |
| [How to remove tags from a block device](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-block-device) | |
| [How to remove tags from a network interface](/t/how-to-use-network-tags/5228#heading--remove-tags-from-a-network-interface) | |
| [How to remove tags from a partition](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-partition) | |
| [How to remove tags from a rack controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-rack-controller) | |
| [How to remove tags from a region controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-region-controller) | |
| [How to remove tags from a virtual machine host](/t/how-to-use-machine-tags/5224#heading--remove-tags-from-a-vm-host) | |
| [How to see all tagged nodes](/t/how-to-work-with-tags/5928#heading--see-all-tagged-nodes) | |
| [How to set a static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--set-a-static-annotation-for-a-machine) | |
| [How to set dynamic annotations for a machine](/t/how-to-work-with-annotations/5929#heading--set-dynamic-annotations-for-a-machine) | |
| [How to tag multiple machines at once](/t/how-to-use-machine-tags/5224#heading--tag-multiple-machines) | |
| [How to unassign tags from machines](/t/how-to-work-with-tags/5928#heading--unassign-tags-from-machines) | |
| [How to update a tag](/t/how-to-work-with-tags/5928#heading--update-a-tag) | |
| [How to update the definition of a tag](/t/how-to-work-with-tags/5928#heading--how-to-update-automatic-tags) | |
| [How to update the kernel option on a Tag](/t/how-to-work-with-tags/5928#heading--update-tag-kernel-options) | |
| [How to view a static annotation for one machine](/t/how-to-work-with-annotations/5929#heading--view-a-static-annotation-for-one-machine) | |
| [How to view block device tags](/t/how-to-use-storage-tags/5232#heading--view-block-device-tags) | |
| [How to view controller tags](/t/how-to-use-controller-tags/5216#heading--view-controller-tags) | |
| [How to view dynamic (workload) annotations for one machine](/t/how-to-work-with-annotations/5929#heading--view-dynamic-workload-annotations-for-one-machine) | |
| [How to view machine tags for a VM host](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-a-vm-host) | |
| [How to view machine tags for one machine](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-one-machine) | |
| [How to view network interface tags](/t/how-to-use-network-tags/5228#heading--view-network-interface-tags) | |
| [How to view partition tags](/t/how-to-use-storage-tags/5232#heading--view-partition-tags) | |
| [How to view static annotations](/t/how-to-work-with-annotations/5929#heading--view-static-annotations) | |
| [How to view tags for one block device](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-block-device) | |
| [How to view tags for one network interface](/t/how-to-use-network-tags/5228#heading--view-tags-for-one-network-interface) | |
| [How to view tags for one partition](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-partition) | |
| [How to view tags for one rack controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-rack-controller) | |
| [How to view tags for one region controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-region-controller) | |
| [How to view tags for one virtual machine host](/t/how-to-use-machine-tags/5224#heading--view-tags-for-one-vm-host) | |
| [How to work with dynamic (workload) annotations](/t/how-to-work-with-annotations/5929#heading--work-with-dynamic-workload-annotations) | |
| [How to work with static annotations](/t/how-to-work-with-annotations/5929#heading--work-with-static-annotations) | |
| [identify machines that can receive dynamic annotations](/t/how-to-work-with-annotations/5929#heading--identify-machines-that-can-receive-dynamic-annotations) |How to |
| [identify your machines](/t/how-to-work-with-annotations/5929#heading--identify-your-machines) |How to |
| [ID of your block device](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-block-device) |How to discover the |
| [ID of your network interface](/t/how-to-use-network-tags/5228#heading--discover-the-id-of-your-network-interface) |How to discover the |
| [ID of your partition](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-partition) |How to discover the |
| [ID of your rack controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-rack-controllers) |How to discover the |
| [ID of your region controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-region-controllers) |How to discover the |
| [ID](/t/how-to-use-machine-tags/5224#heading--discover-your-vm-host-id) |How to discover your virtual machine host |
| [information](/t/how-to-work-with-tags/5928#heading--xpath-hardware-config-info) |Hardware configuration |
| [interfaces](/t/how-to-use-network-tags/5228#heading--list-tags-for-all-network-interfaces) |How to list tags for all network |
| [interface tags](/t/how-to-use-network-tags/5228#heading--create-and-assign-network-interface-tags) |How to create and assign network |
| [interface tags](/t/how-to-use-network-tags/5228#heading--remove-and-delete-network-interface-tags) |How to remove and delete network |
| [interface tags](/t/how-to-use-network-tags/5228#heading--view-network-interface-tags) |How to view network |
| [interface](/t/how-to-use-network-tags/5228#heading--assign-tags-to-a-network-interface) |How to assign tags to a network |
| [interface](/t/how-to-use-network-tags/5228#heading--discover-the-id-of-your-network-interface) |How to discover the ID of your network |
| [interface](/t/how-to-use-network-tags/5228#heading--remove-tags-from-a-network-interface) |How to remove tags from a network |
| [interface](/t/how-to-use-network-tags/5228#heading--view-tags-for-one-network-interface) |How to view tags for one network |
| [kernel option on a Tag](/t/how-to-work-with-tags/5928#heading--update-tag-kernel-options) |How to update the |
| [kernel options](/t/how-to-work-with-tags/5928#heading--create-tags-with-built-in-kernel-options) |How to create tags with built-in |
| [Kernel options](/t/how-to-work-with-tags/5928#heading--kernel-options) |About |
| [list all tags available on this MAAS](/t/how-to-work-with-tags/5928#heading--list-all-tags-available-on-this-maas) |How to |
| [list block device and partition tags](/t/how-to-use-storage-tags/5232#heading--list-block-device-and-partition-tags) |How to |
| [list dynamic annotations for all machines](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-all-machines) |How to |
| [list dynamic annotations for one machine](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-one-machine) |How to |
| [list machine tags for all machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-all-machines) |How to |
| [list machine tags for multiple machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-multiple-machines) |How to |
| [list static annotations for all machines](/t/how-to-work-with-annotations/5929#heading--list-static-annotations-for-all-machines) |How to |
| [list tags for all block devices](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-block-devices) |How to |
| [list tags for all network interfaces](/t/how-to-use-network-tags/5228#heading--list-tags-for-all-network-interfaces) |How to |
| [list tags for all partitions](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-partitions) |How to |
| [list tags for all rack controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-rack-controllers) |How to |
| [list tags for all region controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-region-controllers) |How to |
| [list tags for all virtual machine hosts](/t/how-to-use-machine-tags/5224#heading--list-tags-for-all-vm-hosts) |How to |
| [MAAS](/t/how-to-work-with-tags/5928#heading--list-all-tags-available-on-this-maas) |How to list all tags available on this |
| [machine host ID](/t/how-to-use-machine-tags/5224#heading--discover-your-vm-host-id) |How to discover your virtual |
| [machine hosts](/t/how-to-use-machine-tags/5224#heading--list-tags-for-all-vm-hosts) |How to list tags for all virtual |
| [machine host](/t/how-to-use-machine-tags/5224#heading--assign-tags-to-a-vm-host) |How to assign tags to a virtual |
| [machine host](/t/how-to-use-machine-tags/5224#heading--remove-tags-from-a-vm-host) |How to remove tags from a virtual |
| [machine host](/t/how-to-use-machine-tags/5224#heading--view-tags-for-one-vm-host) |How to view tags for one virtual |
| [machines at once](/t/how-to-use-machine-tags/5224#heading--tag-multiple-machines) |How to tag multiple |
| [machines at once](/t/how-to-work-with-tags/5928#heading--delete-from-all-machines) |Deleting tags from all |
| [machines that can receive dynamic annotations](/t/how-to-work-with-annotations/5929#heading--identify-machines-that-can-receive-dynamic-annotations) |How to identify |
| [machines](/t/how-to-use-machine-tags/5224#heading--adding-and-removing-machine-tags-simultaneously) |Adding and removing machine tags simultaneously from multiple |
| [machines](/t/how-to-use-machine-tags/5224#heading--create-and-assign-machine-tags-to-machines) |How to create and assign machine tags to |
| [machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-all-machines) |How to list machine tags for all |
| [machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-multiple-machines) |How to list machine tags for multiple |
| [machines](/t/how-to-use-machine-tags/5224#heading--remove-and-delete-machine-tags-from-machines) |How to remove and delete machine tags from |
| [machines](/t/how-to-work-with-annotations/5929#heading--identify-your-machines) |How to identify your |
| [machines](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-all-machines) |How to list dynamic annotations for all |
| [machines](/t/how-to-work-with-annotations/5929#heading--list-static-annotations-for-all-machines) |How to list static annotations for all |
| [machines](/t/how-to-work-with-tags/5928#heading--remove-from-some-machines) |Removing a tag from specific |
| [machines](/t/how-to-work-with-tags/5928#heading--unassign-tags-from-machines) |How to unassign tags from |
| [machine tags for all machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-all-machines) |How to list |
| [machine tags for a VM host](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-a-vm-host) |How to view |
| [machine tags for multiple machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-multiple-machines) |How to list |
| [machine tags for one machine](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-one-machine) |How to view |
| [machine tags from a machine](/t/how-to-use-machine-tags/5224#heading--remove-machine-tags-from-a-machine) |How to remove |
| [machine tags from machines](/t/how-to-use-machine-tags/5224#heading--remove-and-delete-machine-tags-from-machines) |How to remove and delete |
| [machine tags simultaneously from multiple machines](/t/how-to-use-machine-tags/5224#heading--adding-and-removing-machine-tags-simultaneously) |Adding and removing |
| [machine tags to a machine](/t/how-to-use-machine-tags/5224#heading--assign-machine-tags-to-a-machine) |How to assign |
| [machine tags to machines](/t/how-to-use-machine-tags/5224#heading--create-and-assign-machine-tags-to-machines) |How to create and assign |
| [machine](/t/how-to-use-machine-tags/5224#heading--assign-machine-tags-to-a-machine) |How to assign machine tags to a |
| [machine](/t/how-to-use-machine-tags/5224#heading--remove-machine-tags-from-a-machine) |How to remove machine tags from a |
| [machine](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-one-machine) |How to view machine tags for one |
| [machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or clear a static annotation for a |
| [machine](/t/how-to-work-with-annotations/5929#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear and change dynamic annotations for a |
| [machine](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-one-machine) |How to list dynamic annotations for one |
| [machine](/t/how-to-work-with-annotations/5929#heading--set-a-static-annotation-for-a-machine) |How to set a static annotation for a |
| [machine](/t/how-to-work-with-annotations/5929#heading--set-dynamic-annotations-for-a-machine) |How to set dynamic annotations for a |
| [machine](/t/how-to-work-with-annotations/5929#heading--view-a-static-annotation-for-one-machine) |How to view a static annotation for one |
| [machine](/t/how-to-work-with-annotations/5929#heading--view-dynamic-workload-annotations-for-one-machine) |How to view dynamic (workload) annotations for one |
| [multiple machines at once](/t/how-to-use-machine-tags/5224#heading--tag-multiple-machines) |How to tag |
| [multiple machines](/t/how-to-use-machine-tags/5224#heading--adding-and-removing-machine-tags-simultaneously) |Adding and removing machine tags simultaneously from |
| [multiple machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-multiple-machines) |How to list machine tags for |
| [name tags](/t/how-to-work-with-tags/5928#heading--name-tags) |How to |
| [network interfaces](/t/how-to-use-network-tags/5228#heading--list-tags-for-all-network-interfaces) |How to list tags for all |
| [network interface tags](/t/how-to-use-network-tags/5228#heading--create-and-assign-network-interface-tags) |How to create and assign |
| [network interface tags](/t/how-to-use-network-tags/5228#heading--remove-and-delete-network-interface-tags) |How to remove and delete |
| [network interface tags](/t/how-to-use-network-tags/5228#heading--view-network-interface-tags) |How to view |
| [network interface](/t/how-to-use-network-tags/5228#heading--assign-tags-to-a-network-interface) |How to assign tags to a |
| [network interface](/t/how-to-use-network-tags/5228#heading--discover-the-id-of-your-network-interface) |How to discover the ID of your |
| [network interface](/t/how-to-use-network-tags/5228#heading--remove-tags-from-a-network-interface) |How to remove tags from a |
| [network interface](/t/how-to-use-network-tags/5228#heading--view-tags-for-one-network-interface) |How to view tags for one |
| [nodes](/t/how-to-work-with-tags/5928#heading--see-all-tagged-nodes) |How to see all tagged |
| [of a tag](/t/how-to-work-with-tags/5928#heading--how-to-update-automatic-tags) |How to update the definition |
| [of your block device](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-block-device) |How to discover the ID |
| [of your network interface](/t/how-to-use-network-tags/5228#heading--discover-the-id-of-your-network-interface) |How to discover the ID |
| [of your partition](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-partition) |How to discover the ID |
| [of your rack controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-rack-controllers) |How to discover the ID |
| [of your region controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-region-controllers) |How to discover the ID |
| [on a Tag](/t/how-to-work-with-tags/5928#heading--update-tag-kernel-options) |How to update the kernel option |
| [once](/t/how-to-use-machine-tags/5224#heading--tag-multiple-machines) |How to tag multiple machines at |
| [once](/t/how-to-work-with-tags/5928#heading--delete-from-all-machines) |Deleting tags from all machines at |
| [on dynamic (workload) annotations](/t/how-to-work-with-annotations/5929#heading--filter-on-dynamic-workload-annotations) |How to filter |
| [one block device](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-block-device) |How to view tags for |
| [one machine](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-one-machine) |How to view machine tags for |
| [one machine](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-one-machine) |How to list dynamic annotations for |
| [one machine](/t/how-to-work-with-annotations/5929#heading--view-a-static-annotation-for-one-machine) |How to view a static annotation for |
| [one machine](/t/how-to-work-with-annotations/5929#heading--view-dynamic-workload-annotations-for-one-machine) |How to view dynamic (workload) annotations for |
| [one network interface](/t/how-to-use-network-tags/5228#heading--view-tags-for-one-network-interface) |How to view tags for |
| [one partition](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-partition) |How to view tags for |
| [one rack controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-rack-controller) |How to view tags for |
| [one region controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-region-controller) |How to view tags for |
| [one virtual machine host](/t/how-to-use-machine-tags/5224#heading--view-tags-for-one-vm-host) |How to view tags for |
| [on this MAAS](/t/how-to-work-with-tags/5928#heading--list-all-tags-available-on-this-maas) |How to list all tags available |
| [option on a Tag](/t/how-to-work-with-tags/5928#heading--update-tag-kernel-options) |How to update the kernel |
| [options](/t/how-to-work-with-tags/5928#heading--create-tags-with-built-in-kernel-options) |How to create tags with built-in kernel |
| [options](/t/how-to-work-with-tags/5928#heading--kernel-options) |About Kernel |
| [or clear a static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change |
| [partitions](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-partitions) |How to list tags for all |
| [partition tags](/t/how-to-use-storage-tags/5232#heading--list-block-device-and-partition-tags) |How to list block device and |
| [partition tags](/t/how-to-use-storage-tags/5232#heading--view-partition-tags) |How to view |
| [partition](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-partition) |How to assign tags to a |
| [partition](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-partition) |How to discover the ID of your |
| [partition](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-partition) |How to remove tags from a |
| [partition](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-partition) |How to view tags for one |
| [rack controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-rack-controllers) |How to discover the ID of your |
| [rack controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-rack-controllers) |How to list tags for all |
| [rack controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-rack-controller) |How to assign tags to a |
| [rack controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-rack-controller) |How to remove tags from a |
| [rack controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-rack-controller) |How to view tags for one |
| [rebuild a tag](/t/how-to-work-with-tags/5928#heading--rebuild-a-tag) |How to |
| [receive dynamic annotations](/t/how-to-work-with-annotations/5929#heading--identify-machines-that-can-receive-dynamic-annotations) |How to identify machines that can |
| [reference examples](/t/how-to-work-with-tags/5928#heading--tag-definition-reference) |Tag definition |
| [region controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-region-controllers) |How to discover the ID of your |
| [region controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-region-controllers) |How to list tags for all |
| [region controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-region-controller) |How to assign tags to a |
| [region controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-region-controller) |How to remove tags from a |
| [region controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-region-controller) |How to view tags for one |
| [remove and delete block device tags](/t/how-to-use-storage-tags/5232#heading--remove-and-delete-block-device-tags) |How to |
| [remove and delete controller tags](/t/how-to-use-controller-tags/5216#heading--remove-and-delete-controller-tags) |How to |
| [remove and delete machine tags from machines](/t/how-to-use-machine-tags/5224#heading--remove-and-delete-machine-tags-from-machines) |How to |
| [remove and delete network interface tags](/t/how-to-use-network-tags/5228#heading--remove-and-delete-network-interface-tags) |How to |
| [remove machine tags from a machine](/t/how-to-use-machine-tags/5224#heading--remove-machine-tags-from-a-machine) |How to |
| [remove tags from a block device](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-block-device) |How to |
| [remove tags from a network interface](/t/how-to-use-network-tags/5228#heading--remove-tags-from-a-network-interface) |How to |
| [remove tags from a partition](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-partition) |How to |
| [remove tags from a rack controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-rack-controller) |How to |
| [remove tags from a region controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-region-controller) |How to |
| [remove tags from a virtual machine host](/t/how-to-use-machine-tags/5224#heading--remove-tags-from-a-vm-host) |How to |
| [remove tags](/t/how-to-work-with-tags/5928#heading--delete-and-remove-tags) |How to delete and |
| [Removing a tag from specific machines](/t/how-to-work-with-tags/5928#heading--remove-from-some-machines) | |
| [removing machine tags simultaneously from multiple machines](/t/how-to-use-machine-tags/5224#heading--adding-and-removing-machine-tags-simultaneously) |Adding and |
| [see all tagged nodes](/t/how-to-work-with-tags/5928#heading--see-all-tagged-nodes) |How to |
| [set a static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--set-a-static-annotation-for-a-machine) |How to |
| [set dynamic annotations for a machine](/t/how-to-work-with-annotations/5929#heading--set-dynamic-annotations-for-a-machine) |How to |
| [simultaneously from multiple machines](/t/how-to-use-machine-tags/5224#heading--adding-and-removing-machine-tags-simultaneously) |Adding and removing machine tags |
| [specific machines](/t/how-to-work-with-tags/5928#heading--remove-from-some-machines) |Removing a tag from |
| [static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or clear a |
| [static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--set-a-static-annotation-for-a-machine) |How to set a |
| [static annotation for one machine](/t/how-to-work-with-annotations/5929#heading--view-a-static-annotation-for-one-machine) |How to view a |
| [static annotations for all machines](/t/how-to-work-with-annotations/5929#heading--list-static-annotations-for-all-machines) |How to list |
| [static annotations](/t/how-to-work-with-annotations/5929#heading--create-and-assign-static-annotations) |How to create and assign |
| [static annotations](/t/how-to-work-with-annotations/5929#heading--delete-static-annotations) |How to delete |
| [static annotations](/t/how-to-work-with-annotations/5929#heading--view-static-annotations) |How to view |
| [static annotations](/t/how-to-work-with-annotations/5929#heading--work-with-static-annotations) |How to work with |
| [Tag definition reference examples](/t/how-to-work-with-tags/5928#heading--tag-definition-reference) | |
| [tag from specific machines](/t/how-to-work-with-tags/5928#heading--remove-from-some-machines) |Removing a |
| [tagged nodes](/t/how-to-work-with-tags/5928#heading--see-all-tagged-nodes) |How to see all |
| [tag multiple machines at once](/t/how-to-use-machine-tags/5224#heading--tag-multiple-machines) |How to |
| [tags available on this MAAS](/t/how-to-work-with-tags/5928#heading--list-all-tags-available-on-this-maas) |How to list all |
| [tags for all block devices](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-block-devices) |How to list |
| [tags for all machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-all-machines) |How to list machine |
| [tags for all network interfaces](/t/how-to-use-network-tags/5228#heading--list-tags-for-all-network-interfaces) |How to list |
| [tags for all partitions](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-partitions) |How to list |
| [tags for all rack controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-rack-controllers) |How to list |
| [tags for all region controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-region-controllers) |How to list |
| [tags for all virtual machine hosts](/t/how-to-use-machine-tags/5224#heading--list-tags-for-all-vm-hosts) |How to list |
| [tags for a VM host](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-a-vm-host) |How to view machine |
| [tags for multiple machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-multiple-machines) |How to list machine |
| [tags for one block device](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-block-device) |How to view |
| [tags for one machine](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-one-machine) |How to view machine |
| [tags for one network interface](/t/how-to-use-network-tags/5228#heading--view-tags-for-one-network-interface) |How to view |
| [tags for one partition](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-partition) |How to view |
| [tags for one rack controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-rack-controller) |How to view |
| [tags for one region controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-region-controller) |How to view |
| [tags for one virtual machine host](/t/how-to-use-machine-tags/5224#heading--view-tags-for-one-vm-host) |How to view |
| [tags from a block device](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-block-device) |How to remove |
| [tags from all machines at once](/t/how-to-work-with-tags/5928#heading--delete-from-all-machines) |Deleting |
| [tags from a machine](/t/how-to-use-machine-tags/5224#heading--remove-machine-tags-from-a-machine) |How to remove machine |
| [tags from a network interface](/t/how-to-use-network-tags/5228#heading--remove-tags-from-a-network-interface) |How to remove |
| [tags from a partition](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-partition) |How to remove |
| [tags from a rack controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-rack-controller) |How to remove |
| [tags from a region controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-region-controller) |How to remove |
| [tags from a virtual machine host](/t/how-to-use-machine-tags/5224#heading--remove-tags-from-a-vm-host) |How to remove |
| [tags from machines](/t/how-to-use-machine-tags/5224#heading--remove-and-delete-machine-tags-from-machines) |How to remove and delete machine |
| [tags from machines](/t/how-to-work-with-tags/5928#heading--unassign-tags-from-machines) |How to unassign |
| [tags simultaneously from multiple machines](/t/how-to-use-machine-tags/5224#heading--adding-and-removing-machine-tags-simultaneously) |Adding and removing machine |
| [tags ](/t/how-to-use-controller-tags/5216#heading--create-and-assign-controller-tags-) |How to create and assign controller |
| [tags](/t/how-to-use-controller-tags/5216#heading--remove-and-delete-controller-tags) |How to remove and delete controller |
| [tags](/t/how-to-use-controller-tags/5216#heading--view-controller-tags) |How to view controller |
| [tags](/t/how-to-use-network-tags/5228#heading--create-and-assign-network-interface-tags) |How to create and assign network interface |
| [tags](/t/how-to-use-network-tags/5228#heading--remove-and-delete-network-interface-tags) |How to remove and delete network interface |
| [tags](/t/how-to-use-network-tags/5228#heading--view-network-interface-tags) |How to view network interface |
| [tags](/t/how-to-use-storage-tags/5232#heading--create-and-assign-block-device-tags) |How to create and assign block device |
| [tags](/t/how-to-use-storage-tags/5232#heading--list-block-device-and-partition-tags) |How to list block device and partition |
| [tags](/t/how-to-use-storage-tags/5232#heading--remove-and-delete-block-device-tags) |How to remove and delete block device |
| [tags](/t/how-to-use-storage-tags/5232#heading--view-block-device-tags) |How to view block device |
| [tags](/t/how-to-use-storage-tags/5232#heading--view-partition-tags) |How to view partition |
| [tags](/t/how-to-work-with-tags/5928#heading--automatic-tags) |About automatic |
| [tags](/t/how-to-work-with-tags/5928#heading--create-and-assign-tags) |How to create and assign |
| [tags](/t/how-to-work-with-tags/5928#heading--delete-and-remove-tags) |How to delete and remove |
| [tags](/t/how-to-work-with-tags/5928#heading--how-to-create-automatic-tags) |How to create automatic |
| [tags](/t/how-to-work-with-tags/5928#heading--name-tags) |How to name |
| [tags to a block device](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-block-device) |How to assign |
| [tags to a machine](/t/how-to-use-machine-tags/5224#heading--assign-machine-tags-to-a-machine) |How to assign machine |
| [tags to a network interface](/t/how-to-use-network-tags/5228#heading--assign-tags-to-a-network-interface) |How to assign |
| [tags to a partition](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-partition) |How to assign |
| [tags to a rack controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-rack-controller) |How to assign |
| [tags to a region controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-region-controller) |How to assign |
| [tags to a virtual machine host](/t/how-to-use-machine-tags/5224#heading--assign-tags-to-a-vm-host) |How to assign |
| [tags to machines](/t/how-to-use-machine-tags/5224#heading--create-and-assign-machine-tags-to-machines) |How to create and assign machine |
| [tags with built-in kernel options](/t/how-to-work-with-tags/5928#heading--create-tags-with-built-in-kernel-options) |How to create |
| [tag](/t/how-to-work-with-tags/5928#heading--create-a-tag) |How to create a |
| [tag](/t/how-to-work-with-tags/5928#heading--delete-a-tag) |How to delete a |
| [tag](/t/how-to-work-with-tags/5928#heading--how-to-update-automatic-tags) |How to update the definition of a |
| [tag](/t/how-to-work-with-tags/5928#heading--rebuild-a-tag) |How to rebuild a |
| [tag](/t/how-to-work-with-tags/5928#heading--update-a-tag) |How to update a |
| [Tag](/t/how-to-work-with-tags/5928#heading--update-tag-kernel-options) |How to update the kernel option on a |
| [that can receive dynamic annotations](/t/how-to-work-with-annotations/5929#heading--identify-machines-that-can-receive-dynamic-annotations) |How to identify machines |
| [the definition of a tag](/t/how-to-work-with-tags/5928#heading--how-to-update-automatic-tags) |How to update |
| [the ID of your block device](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-block-device) |How to discover |
| [the ID of your network interface](/t/how-to-use-network-tags/5228#heading--discover-the-id-of-your-network-interface) |How to discover |
| [the ID of your partition](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-partition) |How to discover |
| [the ID of your rack controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-rack-controllers) |How to discover |
| [the ID of your region controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-region-controllers) |How to discover |
| [the kernel option on a Tag](/t/how-to-work-with-tags/5928#heading--update-tag-kernel-options) |How to update |
| [this MAAS](/t/how-to-work-with-tags/5928#heading--list-all-tags-available-on-this-maas) |How to list all tags available on |
| [](/t/how-to-use-controller-tags/5216#heading--create-and-assign-controller-tags-) |How to create and assign controller tags |
| [to a block device](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-block-device) |How to assign tags |
| [to a machine](/t/how-to-use-machine-tags/5224#heading--assign-machine-tags-to-a-machine) |How to assign machine tags |
| [to a network interface](/t/how-to-use-network-tags/5228#heading--assign-tags-to-a-network-interface) |How to assign tags |
| [to a partition](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-partition) |How to assign tags |
| [to a rack controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-rack-controller) |How to assign tags |
| [to a region controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-region-controller) |How to assign tags |
| [to assign machine tags to a machine](/t/how-to-use-machine-tags/5224#heading--assign-machine-tags-to-a-machine) |How |
| [to assign tags to a block device](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-block-device) |How |
| [to assign tags to a network interface](/t/how-to-use-network-tags/5228#heading--assign-tags-to-a-network-interface) |How |
| [to assign tags to a partition](/t/how-to-use-storage-tags/5232#heading--assign-tags-to-a-partition) |How |
| [to assign tags to a rack controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-rack-controller) |How |
| [to assign tags to a region controller](/t/how-to-use-controller-tags/5216#heading--assign-tags-to-a-region-controller) |How |
| [to assign tags to a virtual machine host](/t/how-to-use-machine-tags/5224#heading--assign-tags-to-a-vm-host) |How |
| [to a virtual machine host](/t/how-to-use-machine-tags/5224#heading--assign-tags-to-a-vm-host) |How to assign tags |
| [to change or clear a static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--change-or-clear-a-static-annotation-for-a-machine) |How |
| [to clear and change dynamic annotations for a machine](/t/how-to-work-with-annotations/5929#heading--clear-and-change-dynamic-annotations-for-a-machine) |How |
| [to create and assign block device tags](/t/how-to-use-storage-tags/5232#heading--create-and-assign-block-device-tags) |How |
| [to create and assign controller tags ](/t/how-to-use-controller-tags/5216#heading--create-and-assign-controller-tags-) |How |
| [to create and assign machine tags to machines](/t/how-to-use-machine-tags/5224#heading--create-and-assign-machine-tags-to-machines) |How |
| [to create and assign network interface tags](/t/how-to-use-network-tags/5228#heading--create-and-assign-network-interface-tags) |How |
| [to create and assign static annotations](/t/how-to-work-with-annotations/5929#heading--create-and-assign-static-annotations) |How |
| [to create and assign tags](/t/how-to-work-with-tags/5928#heading--create-and-assign-tags) |How |
| [to create a tag](/t/how-to-work-with-tags/5928#heading--create-a-tag) |How |
| [to create automatic tags](/t/how-to-work-with-tags/5928#heading--how-to-create-automatic-tags) |How |
| [to create tags with built-in kernel options](/t/how-to-work-with-tags/5928#heading--create-tags-with-built-in-kernel-options) |How |
| [to delete and remove tags](/t/how-to-work-with-tags/5928#heading--delete-and-remove-tags) |How |
| [to delete a tag](/t/how-to-work-with-tags/5928#heading--delete-a-tag) |How |
| [to delete static annotations](/t/how-to-work-with-annotations/5929#heading--delete-static-annotations) |How |
| [to discover the ID of your block device](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-block-device) |How |
| [to discover the ID of your network interface](/t/how-to-use-network-tags/5228#heading--discover-the-id-of-your-network-interface) |How |
| [to discover the ID of your partition](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-partition) |How |
| [to discover the ID of your rack controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-rack-controllers) |How |
| [to discover the ID of your region controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-region-controllers) |How |
| [to discover your virtual machine host ID](/t/how-to-use-machine-tags/5224#heading--discover-your-vm-host-id) |How |
| [to filter on dynamic (workload) annotations](/t/how-to-work-with-annotations/5929#heading--filter-on-dynamic-workload-annotations) |How |
| [to identify machines that can receive dynamic annotations](/t/how-to-work-with-annotations/5929#heading--identify-machines-that-can-receive-dynamic-annotations) |How |
| [to identify your machines](/t/how-to-work-with-annotations/5929#heading--identify-your-machines) |How |
| [to list all tags available on this MAAS](/t/how-to-work-with-tags/5928#heading--list-all-tags-available-on-this-maas) |How |
| [to list block device and partition tags](/t/how-to-use-storage-tags/5232#heading--list-block-device-and-partition-tags) |How |
| [to list dynamic annotations for all machines](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-all-machines) |How |
| [to list dynamic annotations for one machine](/t/how-to-work-with-annotations/5929#heading--list-dynamic-annotations-for-one-machine) |How |
| [to list machine tags for all machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-all-machines) |How |
| [to list machine tags for multiple machines](/t/how-to-use-machine-tags/5224#heading--list-machine-tags-for-multiple-machines) |How |
| [to list static annotations for all machines](/t/how-to-work-with-annotations/5929#heading--list-static-annotations-for-all-machines) |How |
| [to list tags for all block devices](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-block-devices) |How |
| [to list tags for all network interfaces](/t/how-to-use-network-tags/5228#heading--list-tags-for-all-network-interfaces) |How |
| [to list tags for all partitions](/t/how-to-use-storage-tags/5232#heading--list-tags-for-all-partitions) |How |
| [to list tags for all rack controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-rack-controllers) |How |
| [to list tags for all region controllers](/t/how-to-use-controller-tags/5216#heading--list-tags-for-all-region-controllers) |How |
| [to list tags for all virtual machine hosts](/t/how-to-use-machine-tags/5224#heading--list-tags-for-all-vm-hosts) |How |
| [to machines](/t/how-to-use-machine-tags/5224#heading--create-and-assign-machine-tags-to-machines) |How to create and assign machine tags |
| [to name tags](/t/how-to-work-with-tags/5928#heading--name-tags) |How |
| [to rebuild a tag](/t/how-to-work-with-tags/5928#heading--rebuild-a-tag) |How |
| [to remove and delete block device tags](/t/how-to-use-storage-tags/5232#heading--remove-and-delete-block-device-tags) |How |
| [to remove and delete controller tags](/t/how-to-use-controller-tags/5216#heading--remove-and-delete-controller-tags) |How |
| [to remove and delete machine tags from machines](/t/how-to-use-machine-tags/5224#heading--remove-and-delete-machine-tags-from-machines) |How |
| [to remove and delete network interface tags](/t/how-to-use-network-tags/5228#heading--remove-and-delete-network-interface-tags) |How |
| [to remove machine tags from a machine](/t/how-to-use-machine-tags/5224#heading--remove-machine-tags-from-a-machine) |How |
| [to remove tags from a block device](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-block-device) |How |
| [to remove tags from a network interface](/t/how-to-use-network-tags/5228#heading--remove-tags-from-a-network-interface) |How |
| [to remove tags from a partition](/t/how-to-use-storage-tags/5232#heading--remove-tags-from-a-partition) |How |
| [to remove tags from a rack controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-rack-controller) |How |
| [to remove tags from a region controller](/t/how-to-use-controller-tags/5216#heading--remove-tags-from-a-region-controller) |How |
| [to remove tags from a virtual machine host](/t/how-to-use-machine-tags/5224#heading--remove-tags-from-a-vm-host) |How |
| [to see all tagged nodes](/t/how-to-work-with-tags/5928#heading--see-all-tagged-nodes) |How |
| [to set a static annotation for a machine](/t/how-to-work-with-annotations/5929#heading--set-a-static-annotation-for-a-machine) |How |
| [to set dynamic annotations for a machine](/t/how-to-work-with-annotations/5929#heading--set-dynamic-annotations-for-a-machine) |How |
| [to tag multiple machines at once](/t/how-to-use-machine-tags/5224#heading--tag-multiple-machines) |How |
| [to unassign tags from machines](/t/how-to-work-with-tags/5928#heading--unassign-tags-from-machines) |How |
| [to update a tag](/t/how-to-work-with-tags/5928#heading--update-a-tag) |How |
| [to update the definition of a tag](/t/how-to-work-with-tags/5928#heading--how-to-update-automatic-tags) |How |
| [to update the kernel option on a Tag](/t/how-to-work-with-tags/5928#heading--update-tag-kernel-options) |How |
| [to view a static annotation for one machine](/t/how-to-work-with-annotations/5929#heading--view-a-static-annotation-for-one-machine) |How |
| [to view block device tags](/t/how-to-use-storage-tags/5232#heading--view-block-device-tags) |How |
| [to view controller tags](/t/how-to-use-controller-tags/5216#heading--view-controller-tags) |How |
| [to view dynamic (workload) annotations for one machine](/t/how-to-work-with-annotations/5929#heading--view-dynamic-workload-annotations-for-one-machine) |How |
| [to view machine tags for a VM host](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-a-vm-host) |How |
| [to view machine tags for one machine](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-one-machine) |How |
| [to view network interface tags](/t/how-to-use-network-tags/5228#heading--view-network-interface-tags) |How |
| [to view partition tags](/t/how-to-use-storage-tags/5232#heading--view-partition-tags) |How |
| [to view static annotations](/t/how-to-work-with-annotations/5929#heading--view-static-annotations) |How |
| [to view tags for one block device](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-block-device) |How |
| [to view tags for one network interface](/t/how-to-use-network-tags/5228#heading--view-tags-for-one-network-interface) |How |
| [to view tags for one partition](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-partition) |How |
| [to view tags for one rack controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-rack-controller) |How |
| [to view tags for one region controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-region-controller) |How |
| [to view tags for one virtual machine host](/t/how-to-use-machine-tags/5224#heading--view-tags-for-one-vm-host) |How |
| [to work with dynamic (workload) annotations](/t/how-to-work-with-annotations/5929#heading--work-with-dynamic-workload-annotations) |How |
| [to work with static annotations](/t/how-to-work-with-annotations/5929#heading--work-with-static-annotations) |How |
| [unassign tags from machines](/t/how-to-work-with-tags/5928#heading--unassign-tags-from-machines) |How to |
| [update a tag](/t/how-to-work-with-tags/5928#heading--update-a-tag) |How to |
| [update the definition of a tag](/t/how-to-work-with-tags/5928#heading--how-to-update-automatic-tags) |How to |
| [update the kernel option on a Tag](/t/how-to-work-with-tags/5928#heading--update-tag-kernel-options) |How to |
| [view a static annotation for one machine](/t/how-to-work-with-annotations/5929#heading--view-a-static-annotation-for-one-machine) |How to |
| [view block device tags](/t/how-to-use-storage-tags/5232#heading--view-block-device-tags) |How to |
| [view controller tags](/t/how-to-use-controller-tags/5216#heading--view-controller-tags) |How to |
| [view dynamic (workload) annotations for one machine](/t/how-to-work-with-annotations/5929#heading--view-dynamic-workload-annotations-for-one-machine) |How to |
| [view machine tags for a VM host](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-a-vm-host) |How to |
| [view machine tags for one machine](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-one-machine) |How to |
| [view network interface tags](/t/how-to-use-network-tags/5228#heading--view-network-interface-tags) |How to |
| [view partition tags](/t/how-to-use-storage-tags/5232#heading--view-partition-tags) |How to |
| [view static annotations](/t/how-to-work-with-annotations/5929#heading--view-static-annotations) |How to |
| [view tags for one block device](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-block-device) |How to |
| [view tags for one network interface](/t/how-to-use-network-tags/5228#heading--view-tags-for-one-network-interface) |How to |
| [view tags for one partition](/t/how-to-use-storage-tags/5232#heading--view-tags-for-one-partition) |How to |
| [view tags for one rack controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-rack-controller) |How to |
| [view tags for one region controller](/t/how-to-use-controller-tags/5216#heading--view-tags-for-one-region-controller) |How to |
| [view tags for one virtual machine host](/t/how-to-use-machine-tags/5224#heading--view-tags-for-one-vm-host) |How to |
| [virtual machine host ID](/t/how-to-use-machine-tags/5224#heading--discover-your-vm-host-id) |How to discover your |
| [virtual machine hosts](/t/how-to-use-machine-tags/5224#heading--list-tags-for-all-vm-hosts) |How to list tags for all |
| [virtual machine host](/t/how-to-use-machine-tags/5224#heading--assign-tags-to-a-vm-host) |How to assign tags to a |
| [virtual machine host](/t/how-to-use-machine-tags/5224#heading--remove-tags-from-a-vm-host) |How to remove tags from a |
| [virtual machine host](/t/how-to-use-machine-tags/5224#heading--view-tags-for-one-vm-host) |How to view tags for one |
| [VM host](/t/how-to-use-machine-tags/5224#heading--view-machine-tags-for-a-vm-host) |How to view machine tags for a |
| [with annotations](/t/how-to-work-with-annotations/5929#heading--work-with-annotations) |Work |
| [with built-in kernel options](/t/how-to-work-with-tags/5928#heading--create-tags-with-built-in-kernel-options) |How to create tags |
| [with dynamic (workload) annotations](/t/how-to-work-with-annotations/5929#heading--work-with-dynamic-workload-annotations) |How to work |
| [with static annotations](/t/how-to-work-with-annotations/5929#heading--work-with-static-annotations) |How to work |
| [(workload) annotations for one machine](/t/how-to-work-with-annotations/5929#heading--view-dynamic-workload-annotations-for-one-machine) |How to view dynamic |
| [(workload) annotations](/t/how-to-work-with-annotations/5929#heading--filter-on-dynamic-workload-annotations) |How to filter on dynamic |
| [(workload) annotations](/t/how-to-work-with-annotations/5929#heading--work-with-dynamic-workload-annotations) |How to work with dynamic |
| [Work with annotations](/t/how-to-work-with-annotations/5929#heading--work-with-annotations) | |
| [work with dynamic (workload) annotations](/t/how-to-work-with-annotations/5929#heading--work-with-dynamic-workload-annotations) |How to |
| [work with static annotations](/t/how-to-work-with-annotations/5929#heading--work-with-static-annotations) |How to |
| [XPath expressions](/t/how-to-work-with-tags/5928#heading--xpath-expressions) |About |
| [your block device](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-block-device) |How to discover the ID of |
| [your machines](/t/how-to-work-with-annotations/5929#heading--identify-your-machines) |How to identify |
| [your network interface](/t/how-to-use-network-tags/5228#heading--discover-the-id-of-your-network-interface) |How to discover the ID of |
| [your partition](/t/how-to-use-storage-tags/5232#heading--discover-the-id-of-your-partition) |How to discover the ID of |
| [your rack controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-rack-controllers) |How to discover the ID of |
| [your region controller(s)](/t/how-to-use-controller-tags/5216#heading--discover-the-id-of-your-region-controllers) |How to discover the ID of |
| [your virtual machine host ID](/t/how-to-use-machine-tags/5224#heading--discover-your-vm-host-id) |How to discover |
