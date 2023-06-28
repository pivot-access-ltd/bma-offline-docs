<!-- About device labels -->
When you're working with a half-dozen machines, a lot of labelling isn't necessary.  As your constellation of machines grows, though, you reach a point where you can't keep a compact picture in your head.  This is where tags, annotations, and filtering come in.  

Two of the more useful attributes of machines are tags and annotations.  These can be used not only to identify machines, but to customise them (e.g., kernel options) when they are commissioned and deployed. You can [tag machines](/t/how-to-tag-machines/5928), [annotate machines](/t/how-to-annotate-machines/5929), and use tags to mark [machines](/t/how-to-use-machine-tags/5224), [storage](/t/how-to-use-storage-tags/5232), [controllers](/t/how-to-use-controller-tags/5216), and [network interfaces](/t/how-to-use-network-tags/5228).  

You can also use [filtering](/t/how-to-find-machines/5192) to find a given subset of machines.  There isn't a lot of theory, per se, on filtering, since it's just a utility function of the user interface.

The rest of this article contains a little background information on tags and annotations.

<a href="#heading--about-tags"><h2 id="heading--about-tags">About tags</h2></a>

Tags are short, descriptive, searchable words that can be applied to various MAAS objects, including:

- machines (physical and virtual)
- VM hosts
- controllers (rack and region)
- storage (virtual and physical; block devices or partitions)
- network interfaces
- devices
- nodes (in the CLI only)

Tags serve to help you identify, group, and find objects easily, especially when you routinely deploy hundreds of machines.


<a href="#heading--about-annotations"><h2 id="heading--about-annotations">About annotations</h2></a>

Annotations are descriptive, searchable phrases that apply only to machines.  There are two types of annotations: static (always present in any machine state), and dynamic (only present in allocated or deployed states).  Annotations help you identify, characterise, and inform others about your machines.


<a href="#heading--about-tags-and-scripts"><h2 id="heading--about-tags-and-scripts">About tags and scripts</h2></a>

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

<a href="#heading--automatic-tags"><h2 id="heading--automatic-tags">About automatic tags</h2></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages"]
Automatic tags are tags with a definition. The definition allows you to auto-apply tags to machines that match with an [XPath expression](#heading--xpath-expressions) you created. Setting up an automatic tag will help you recognise special hardware characteristics and settings. For instance, we can configure the gpu passthrough by creating an XPath expression that recognises a prospective GPU, as shown in the example below.  

In the MAAS REST API, a tag has 4 attributes namely, name, definition, kernel options, and a comment. When this tag is created, the MAAS REST API will try to match all machines with this definition and automatically apply the tag to those machines. Every time a new machine is discovered in your MAAS, if new machines match this definition, they will be automatically tagged as well.

<a href="#heading--xpath-expressions"><h2 id="heading--xpath-expressions">About XPath expressions</h2></a>

MAAS automatic tags accept XPath expressions in the definition attribute of the tag. XPath expressions are evaluated against `lshw`'s XML output; they are used to locate elements or attributes of the XML document for use in configuring automatic tags. You can use the lshw output in the hardware configuration details of a machine in MAAS and use that to create an XPath expression. 

<a href="#heading--node-capabilities"><h2 id="heading--node-capabilities">About node capabilities</h2></a>

Capabilities are used to report features of a given node. The exact meaning of each feature depends on the type of node. It can be the presence of an arithmetical co-processor for a CPU, the ability to run at 1GB/s for a network interface, etc. In most cases, capabilities reported by lshw are auto-documented.

To see the capabilities of a specific machine, you can download your HW configuration information, as described above.

<a href="#heading--kernel-options"><h2 id="heading--kernel-options">About Kernel options</h2></a>

You can add kernel options when creating both manual and automatic tags. Kernel options will be automatically applied at boot time or when the machine with that tag is commissioned or deployed. 

When updating kernel options on a tag that matches Deployed machines, be aware that the new kernel option will be applied during boot time, so you will need to release and re-deploy them to pick up the change. Otherwise, these deployed machines will have the old kernel options.

If there are multiple tags associated with a machine, the kernel options will be concatenated from all the tags combined, sorted alphabetically .
[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]

[note]
Tag management UI is available starting in MAAS v3.2.
[/note]
[/tab]
[/tabs]



