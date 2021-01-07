<!-- deb-2-7-cli
 deb-2-7-cli -->

<!-- deb-2-7-ui
 deb-2-7-ui -->

<!-- deb-2-8-cli
 deb-2-8-cli -->

<!-- deb-2-8-ui
 deb-2-8-ui -->

<!-- deb-2-9-cli
 deb-2-9-cli -->

<!-- deb-2-9-ui
 deb-2-9-ui -->

<!-- snap-2-7-cli
 snap-2-7-cli -->

<!-- snap-2-7-ui
 snap-2-7-ui -->

<!-- snap-2-8-cli
 snap-2-8-cli -->

<!-- snap-2-8-ui
 snap-2-8-ui -->

<!-- snap-2-9-cli
 snap-2-9-cli -->

<!-- snap-2-9-ui
 snap-2-9-ui -->

MAAS can specify kernel boot options to machines on both a global basis (UI and CLI) and a per-machine basis (CLI-only). A full catalogue of available options can be found in the [Linux kernel parameters list^](https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html) at [kernel.org^](https://www.kernel.org).

<!-- snap-2-7-ui snap-2-8-ui snap-2-9-ui deb-2-7-ui deb-2-8-ui deb-2-9-ui

<a href="#heading--global-kernel-boot-options"><h2 id="heading--global-kernel-boot-options">Global kernel boot options</h2></a>

To set kernel boot options globally, as an admin, open the 'Settings' page and on the 'General' tab scroll down to the 'Global Kernel Parameters' section:

<a href="https://assets.ubuntu.com/v1/8b793b6d-nodes-kernel-options__2.2_global.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/8b793b6d-nodes-kernel-options__2.2_global.png"></a>

Type in the desired (space separated) options and click 'Save'. The contents of the field will be used as-is. Do not use extra characters.
snap-2-7-ui snap-2-8-ui snap-2-9-ui deb-2-7-ui deb-2-8-ui deb-2-9-ui -->

<!-- snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli

#### Two questions you may have:

1. [How can I set global kernel boot options for all machines?](#heading--global-kernel-boot-options)
2. [How can I set kernel boot options for a specific machine?](#heading--per-node-kernel-boot-options)

<a href="#heading--cli"><h2 id="heading--cli">Global kernel boot options</h2></a>

You can set kernel boot options and apply them to all machines with the CLI command:

``` bash
maas $PROFILE maas set-config name=kernel_opts value='$KERNEL_OPTIONS'
```

<a href="#heading--per-node-kernel-boot-options"><h2 id="heading--per-node-kernel-boot-options">Per-machine kernel boot options</h2></a>

Per-machine kernel boot options are set using the CLI.

<strong>NOTE:</strong> 
Per-machine boot options take precedence to global ones.


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
