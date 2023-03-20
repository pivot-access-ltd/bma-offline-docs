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