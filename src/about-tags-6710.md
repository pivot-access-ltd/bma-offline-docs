<!-- "About tags" -->
Tags are short, descriptive, searchable words that can be applied to various MAAS objects, including:

- machines (physical and virtual)
- VM hosts
- controllers (rack and region)
- storage (virtual and physical; block devices or partitions)
- network interfaces
- devices
- nodes (in the CLI only)

Tags serve to help you identify, group, and find objects easily, especially when you routinely deploy hundreds of machines.

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



