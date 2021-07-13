MAAS can specify kernel boot options to machines on both a global basis (UI and CLI) and a per-machine basis (CLI-only). A full catalogue of available options can be found in the [Linux kernel parameters list](https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html) at [kernel.org](https://www.kernel.org).

#### Two questions you may have:

1. [How can I set global kernel boot options for all machines?](#heading--global-kernel-boot-options)
2. [How can I set kernel boot options for a specific machine?](/t/tags-and-annotations/nnnn#heading--create-tags-with-built-in-kernel-options)

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 

<a href="#heading--global-kernel-boot-options"><h2 id="heading--global-kernel-boot-options">Global kernel boot options</h2></a>

To set kernel boot options globally, as an admin, open the 'Settings' page and on the 'General' tab scroll down to the 'Global Kernel Parameters' section:

<a href="https://assets.ubuntu.com/v1/8b793b6d-nodes-kernel-options__2.2_global.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/8b793b6d-nodes-kernel-options__2.2_global.png"></a>

Type in the desired (space separated) options and click 'Save'. The contents of the field will be used as-is. Do not use extra characters.
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 


<a href="#heading--cli"><h2 id="heading--cli">Global kernel boot options</h2></a>

You can set kernel boot options and apply them to all machines with the CLI command:

``` bash
maas $PROFILE maas set-config name=kernel_opts value='$KERNEL_OPTIONS'
```
rad-end
