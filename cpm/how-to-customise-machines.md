<a href="#heading--about-custom-machine-setup"><h2 id="heading--about-custom-machine-setup">About custom machine setup</h2></a>

During machine [enlistment](/t/machines/nnnn##heading--about-enlistment), [deployment](/t/how-to-deploy-machines/nnnn), commissioning and machine installation, MAAS sends [Tempita-derived](https://raw.githubusercontent.com/ravenac95/tempita/master/docs/index.txt) configuration files to the [cloud-init](https://launchpad.net/cloud-init) process running on the target machine. MAAS refers to this process as **preseeding**.These preseed files are used to configure a machine's ephemeral and installation environments and can be modified or augmented to a custom machine configuration.

Customisation in MAAS happens in two ways:

1.  [Curtin](https://launchpad.net/curtin), a preseeding system similar to Kickstart or d-i (Debian Installer), applies customisation during operating system (OS) image installation. MAAS performs these changes on deployment, during OS installation, but before the machine reboots into the installed OS. Curtin customisations are perfect for administrators who want their deployments to have identical setups all the time, every time. [This blog post](https://blog.ubuntu.com/2017/06/02/customising-maas-installs) contains an excellent high-level overview of custom MAAS installs using Curtin.

2.  [Cloud-init](https://launchpad.net/cloud-init), a system for setting up machines immediately after instantiation. cloud-init applies customisations after the first boot, when MAAS changes a machine's status to 'Deployed.' Customisations are per-instances, meaning that user-supplied scripts must be re-specified on redeployment. Cloud-init customisations are the best way for MAAS users to customise their deployments, similar to how the various cloud services prepare VMs when launching instances.

<a href="#heading--about-kerel-boot-options"><h2 id="heading--about-kernel-boot-options">About kernel boot options</h2></a>

MAAS can specify kernel boot options to machines on both a global basis (UI and CLI) and a per-machine basis (CLI-only). A full catalogue of available options can be found in the [Linux kernel parameters list](https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html) at [kernel.org](https://www.kernel.org).

<a href="#heading--templates"><h3 id="heading--templates">About templates</h3></a>

rad-begin     /snap/2.9/ui /snap/2.9/cli /snap/3.0/ui /snap/3.0/cli
The [Tempita](https://raw.githubusercontent.com/ravenac95/tempita/master/docs/index.txt) template files are found in the `/var/snap/maas/current/preseeds/` directory on the region controller. Each template uses a filename prefix that corresponds to a particular phase of MAAS machine deployment:
rad-end

rad-begin     /deb/2.9/ui /deb/2.9/cli /deb/3.0/ui /deb/3.0/cli
The [Tempita](https://raw.githubusercontent.com/ravenac95/tempita/master/docs/index.txt) template files are found in the `/etc/maas/preseeds/` directory on the region controller. Each template uses a filename prefix that corresponds to a particular phase of MAAS machine deployment:
rad-end


|       Phase       |                 Filename prefix                 |
|:-----------------|:-----------------------------------------------|
| Enlistment  |                      enlist                     |
| Commissioning |                  commissioning                  |
| Installation | curtin ([Curtin](https://launchpad.net/curtin)) |

Additionally, the template for each phase typically consists of two files. The first is a higher-level file that often contains little more than a URL or a link to further credentials, while a second file contains the executable logic.

The `enlist` template, for example, contains only minimal variables, whereas `enlist_userdata` includes both user variables and initialisation logic.

[note]
Tempita’s inheritance mechanism is the reverse of what you might expect. Inherited files, such as `enlist_userdata`, become the new template which can then reference variables from the higher-level file, such as `enlist`.
[/note]

<a href="#heading--template-naming"><h3 id="heading--template-naming">About template naming</h3></a>

MAAS interprets templates in lexical order by their filename.  This order allows for base configuration options and parameters to be overridden based on a combination of operating system, architecture, sub-architecture, release, and machine name.

Some earlier versions of MAAS only support Ubuntu. If the machine operating system is Ubuntu, then filenames without `{os}` will also be tried, to maintain backward compatibility.

Consequently, template files are interpreted in the following order:

1.  `{prefix}_{os}_{node_arch}_{node_subarch}_{release}_{node_name}` or `{prefix}_{node_arch}_{node_subarch}_{release}_{node_name}`

2.  `{prefix}_{os}_{node_arch}_{node_subarch}_{release}` or `{prefix}_{node_arch}_{node_subarch}_{release}`

3.  `{prefix}_{os}_{node_arch}_{node_subarch}` or `{prefix}_{node_arch}_{node_subarch}`

4.  `{prefix}_{os}_{node_arch}` or `{prefix}_{node_arch}`

5.  `{prefix}_{os}`

6.  `{prefix}`

7.  `generic`

The machine needs to be the machine name, as shown in the web UI URL.

The prefix can be either `enlist`, `enlist_userdata`, `commissioning`, `curtin`, `curtin_userdata` or `preseed_master`. Alternatively, you can omit the prefix and the following underscore.

For example, to create a generic configuration template for Ubuntu 16.04 Xenial running on an x64 architecture, the file would need to be called `ubuntu_amd64_generic_xenial_node`.

To create the equivalent template for curtin_userdata, the file would be called `curtin_userdata_ubuntu_amd64_generic_xenial_node`.

[note]
Any file targeting a specific machine will replace the values and configuration held within any generic files. If those values are needed, you will need to copy these generic template values into your new file.
[/note]

<a href="#heading--about-ubuntu-kernels"><h2 id="heading--about-ubuntu-kernels">About Ubuntu kernels</h2></a>

MAAS supports four types of kernels for its Ubuntu machines:

1.   General availability kernels
2.   Hardware enablement kernels
3.   Hardware enablement kernels (pre-release)
4.   Low latency kernels

<a href="#heading--general-availability-kernels"><h2 id="heading--general-availability-kernels">About general availability kernels</h2></a>

The *general availability* (GA) kernel is based on the *generic* kernel that ships with a new Ubuntu version. Subsequent fixes are applied regularly by the 'stable' *stream* used when setting up the global image source for MAAS.

MAAS denotes a GA kernel like this:

`ga-<version>`: The GA kernel reflects the major kernel version of the shipped Ubuntu release. For example, 'ga-16.04' is based on the 'generic' 4.4 Ubuntu kernel. As per Ubuntu policy, a GA kernel will never have its major version upgraded until the underlying release is upgraded.

<a href="#heading--hardware-enablement-kernels"><h2 id="heading--hardware-enablement-kernels">About hardware enablement kernels</h2></a>

New hardware gets released all the time. If an Ubuntu host runs an older kernel, it's unlikely that MAAS can support the hardware. Canonical does make every effort to back-port more recent kernels enabling more hardware. The acronym HWE stands for "Hardware Enablement."

You also gain kernel improvements and new features when installing an HWE kernel.

[note]
There is the notion of an HWE *stack*, which refers to the window manager and kernel when the Ubuntu host is running a desktop environment. HWE stacks do not apply to MAAS since machines are provisioned strictly as non-graphical servers.
[/note]

Note that these back-ported/HWE kernels are only available for LTS releases (e.g. Trusty, Xenial, etc.). For example, the first available HWE kernel for Ubuntu 16.04 LTS (Xenial) will be the GA kernel from Ubuntu 16.10 (Yakkety).

Before MAAS 2.1 on Xenial, HWE kernels are referred to by the notation `hwe-<release letter>`. So, to install the Yakkety HWE kernel on Xenial, the `hwe-y` kernel is used. By default, when using the web UI, MAAS imports all available HWE kernels along with its generic boot images. So if you are importing Trusty images, then the following HWE kernels are included: `hwe-u`, `hwe-v`, `hwe-w`, `hwe-x` (presuming the Xenial HWE kernel is available).

In MAAS 2.1, starting with Xenial kernels, the notation has changed. The following is used to refer to the latest HWE kernel available for Xenial: `hwe-16.04`.

See [LTS Enablement Stack](https://wiki.ubuntu.com/Kernel/LTSEnablementStack) (Ubuntu wiki) for the latest information on HWE.

<a href="#heading--hardware-enablement-kernels-pre-release"><h2 id="heading--hardware-enablement-kernels-pre-release">About pre-release hardware enablement kernels</h2></a>

The pre-release HWE kernel is known as the *edge* HWE kernel.

MAAS denotes the edge kernel like this: `hwe-<version>-edge`.

So 'hwe-16.04' is considered older than 'hwe-16.04-edge'.

See [Rolling LTS Enablement Stack](https://wiki.ubuntu.com/Kernel/RollingLTSEnablementStack#hwe-16.04-edge) (Ubuntu wiki) for more information.

<a href="#heading--low-latency-kernels"><h2 id="heading--low-latency-kernels">About low latency kernels</h2></a>

The low-latency kernel is based on the GA kernel, but uses a more aggressive configuration to reduce latency. It is categorised as a soft real-time kernel. For more information, see [Criteria for real-time computing](https://en.wikipedia.org/wiki/Real-time_computing#Criteria_for_real-time_computing) (Wikipedia).

MAAS denotes a low latency kernel in three ways:

1.   `hwe-x-lowlatency`: the Xenial low latency HWE kernel for Trusty
2.   `ga-16.04-lowlatency`: the low latency GA kernel for Xenial
3.   `hwe-16.04-lowlatency`: the low latency HWE kernel for Xenial

<a href="#heading--using-kernels"><h2 id="heading--using-kernels">About choosing a kernel</h2></a>

The kernel installed on a machine during deployment is, by default, the Ubuntu release's native kernel (GA). However, it is possible to tell MAAS to use a different kernel. Via the Web UI, MAAS can help you choose one of these kernels.  There are three different contexts for your choice:

1.   globally (default minimum enlistment and commissioning kernel)
2.   per machine (minimum deploy kernel)
3.   per machine during deployment (specific deploy kernel)

<a href="#heading--how-to-customise-machines-with-curtin"><h2 id="heading--how-to-customise-machines-with-curtin">How to customise machines with curtin</h2></a>

You can customise the Curtin installation by either editing the existing `curtin_userdata` template or by adding a custom file as described above.

Curtin provides hooks to execute custom code before and after installation takes place. These hooks are named `early` and `late` respectively, and they can both be overridden to execute the Curtin configuration in the ephemeral environment. Additionally, the `late` hook can be used to execute a configuration for a machine being installed, a state known as in-target.

Curtin commands look like this:

    foo: ["command", "--command-arg", "command-arg-value"]

Each component of the given command makes up an item in an array. Note, however, that the following won't work:

    foo: ["sh", "-c", "/bin/echo", "foobar"]

This syntax won't work because the value of `sh`'s `-c` argument is itself an entire command. The correct way to express this is:

    foo: ["sh", "-c", "/bin/echo foobar"]

The following is an example of an early command that will run before the installation takes place in the ephemeral environment. The command pings an external machine to signal that the installation is about to start:

``` bash
early_commands:
  signal: ["wget", "--no-proxy", "http://example.com/", "--post-data", "system_id=&signal=starting_install", "-O", "/dev/null"]
```

The following is an example of two late commands that run after installation is complete. Both run in-target, on the machine being installed.

The first command adds a PPA to the machine. The second command creates a file containing the machine’s system ID:

``` bash
late_commands:
  add_repo: ["curtin", "in-target", "--", "add-apt-repository", "-y", "ppa:my/ppa"]
  custom: ["curtin", "in-target", "--", "sh", "-c", "/bin/echo -en 'Installed ' > /tmp/maas_system_id"]
```

<a href="#heading--how-to-customise-machines-with-cloud-init"><h2 id="heading--how-to-customise-machines-with-cloud-init">How to customise machines with cloud-init</h2></a>

rad-begin   /snap/2.9/cli   /deb/2.9/cli /deb/3.0/cli /snap/3.0/cli
Using cloud-init to customise a machine after deployment is relatively easy. If you're not familiar with the MAAS command-line interface (CLI), start by reviewing the [MAAS CLI](/t/maas-cli/nnnn) page.

After you're logged in, use the following command to deploy a machine with a custom script you've written:

    maas $PROFILE machine deploy $SYSTEM_ID user_data=<base-64-encoded-script>

The three replacable parameters shown above decode to:

1.   `$PROFILE`: Your MAAS login. E.g. `admin`
2.   `$SYSTEM_ID`: The machine's system ID (see example below)
3.   `<base-64-encoded-script>`: A base-64 encoded copy of your customisation script. See below for an example.

E.g.:

Suppose you would like to import an SSH key immediately after your machine deployment. First, you want to find the machine's `system_id`, which you can do with this short, command-line `jq` script:

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id]) | @tsv' | column -t
```

You might then use this script, called `import_key.sh`, to retrieve the needed key:

``` bash
#!/bin/bash
(
echo === $date ===
ssh-import-id foobar_user
) | tee /ssh-key-import.log
```

This script echos the date in addition to the output of the `ssh-import-key` command. It also adds that output to a file, `/ssh-key-import.log`.

Base-64 encoding is required because the MAAS command-line interacts with the MAAS API, and base-64 encoding allows MAAS to send the script inside a POST HTTP command.

Use the `base64` command to output a base-64 encoded version of your script:

    base64 -w0 ./import_key.sh

Putting it together:

    maas $PROFILE machine deploy $SYSTEM_ID user_data=$(base64 -w0 ./import_key.sh)

After MAAS deploys the machine, you'll find `/ssh-key-import.log` on the machine you deployed.
rad-end

rad-begin    /snap/2.9/ui   /deb/2.9/ui /deb/3.0/ui /snap/3.0/ui
<a href="#heading--cloud-init-ui"><h3 id="heading--cloud-init-ui">How to customise machines using cloud-init</h3></a>

It's easy to customise cloud-init via the web UI.  When you've selected a machine and choose 'Take action >> Deploy,' you'll be presented with the following screen:

<a href="https://discourse.maas.io/uploads/default/original/1X/4cb95189de94d0f478ac899c05fbdbe038607f14.jpeg"><img src="https://discourse.maas.io/uploads/default/original/1X/4cb95189de94d0f478ac899c05fbdbe038607f14.jpeg"></a>

Select a viable release (in this case, "Ubuntu 18.04...") and check the box labelled "Cloud-init user-data...":

<a href="https://discourse.maas.io/uploads/default/original/1X/12d98a2c14671c02ef61a5e87c1eda19956b0afb.jpeg"><img src="https://discourse.maas.io/uploads/default/original/1X/12d98a2c14671c02ef61a5e87c1eda19956b0afb.jpeg"></a>

Paste the desired script directly into the box, and select "Start deployment for machine."  For example, to import an SSH key immediately after your machine deployment, you could paste this script:

``` bash
#!/bin/bash
(
echo === $date ===
ssh-import-id foobar_user
) | tee /ssh-key-import.log
```

[note]
No script validation of any kind is provided with this capability.  You will need to test and debug your own cloud-init scripts.
[/note]
rad-end


<a href="#heading--global-kernel-boot-options"><h2 id="heading--global-kernel-boot-options">How to set global kernel boot options</h2></a>

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 


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

See [How can I set kernel boot options for a specific machine?](/t/tags-and-annotations/nnnn#heading--create-tags-with-built-in-kernel-options) to set per-machine kernel boot options.

<!-- comment -->

<a href="#heading--set-a-default-minimum-kernel-for-enlistment-and-commissioning"><h2 id="heading--set-a-default-minimum-kernel-for-enlistment-and-commissioning">How to set a default minimum kernel for enlistment and commissioning</h2></a>

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 

To set the default minimum enlistment and commissioning kernel (based on Ubuntu release: GA kernel) for all machines visit the 'General' tab of the 'Settings' page and select a kernel in the 'Default Minimum Kernel Version' field of the *Commissioning* section. Don't forget to click 'Save'.

<a href="https://assets.ubuntu.com/v1/e0c7f298-nodes-kernels__2.6-default-minimum-kernel.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/e0c7f298-nodes-kernels__2.6-default-minimum-kernel.png"></a>

<a href="#heading--set-a-minimum-deploy-kernel-for-a-machine"><h2 id="heading--set-a-minimum-deploy-kernel-for-a-machine">How to set a minimum deployment kernel for a machine</h2></a>

To set the minimum deploy kernel on a machine basis, click on a machine from the 'Machines' page of the web UI and switch to its 'Configuration' page. Click 'Edit' in the 'Machine configuration' section, select a kernel in the 'Minimum Kernel' field followed by 'Save changes'.

<a href="https://assets.ubuntu.com/v1/e1016632-nodes-kernels__2.6-machine-minimum-kernel.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/e1016632-nodes-kernels__2.6-machine-minimum-kernel.png"></a>

<a href="#heading--set-a-specific-kernel-during-machine-deployment"><h2 id="heading--set-a-specific-kernel-during-machine-deployment">How to set a specific kernel during machine deployment</h2></a>

To set a specific kernel during deployment, select a machine from the 'Machines' page and choose 'Deploy' under 'Take action'. Then choose a kernel from the (third) kernel field. Hit 'Deploy machine' to initiate the deployment.

<a href="https://assets.ubuntu.com/v1/0d25737f-nodes-kernels__2.6-machine-during-deploy-kernel.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/0d25737f-nodes-kernels__2.6-machine-during-deploy-kernel.png"></a>

MAAS verifies that the specified kernel is available for the given Ubuntu release (series) before deploying the machine.
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 

To set a default minimum kernel for all new and commissioned machines:

``` bash
maas $PROFILE maas set-config name=default_min_hwe_kernel value=$KERNEL
```

For example, to set it to the 16.04 GA kernel:

``` bash
maas $PROFILE maas set-config name=default_min_hwe_kernel value=ga-16.04
```

[note]
The command option `default_min_hwe_kernel` appears to apply to only HWE kernels but this is not the case.
[/note]

<a href="#heading--set-a-minimum-deploy-kernel-for-a-machine"><h2 id="heading--set-a-minimum-deploy-kernel-for-a-machine">How to set a minimum deployment kernel for a machine</h2></a>

To set the minimum deploy kernel on a per-machine basis:

``` bash
maas $PROFILE machine update $SYSTEM_ID min_hwe_kernel=$HWE_KERNEL
```

For example, to set it to the HWE 16.04 kernel:

``` bash
maas $PROFILE machine update $SYSTEM_ID min_hwe_kernel=hwe-16.04
```

[note]
The command option `default_min_hwe_kernel` appears to apply to only HWE kernels but this is not the case.
[/note]

<a href="#heading--set-a-specific-kernel-during-machine-deployment"><h2 id="heading--set-a-specific-kernel-during-machine-deployment">How to set a specific kernel during machine deployment</h2></a>

To set a specific kernel during the deployment of a machine:

``` bash
maas $PROFILE machine deploy $SYSTEM_ID distro_series=$SERIES hwe_kernel=$KERNEL
```

The operation will fail if the kernel specified by `hwe_kernel` is older than the kernel (possibly) given by `default_min_hwe_kernel`. Similarly, it will not work if the kernel is not available for the given distro series (such as 'hwe-16.10' for 'xenial').

For example, to deploy a Xenial node with the HWE 16.04 edge kernel:

``` bash
maas $PROFILE machine deploy $SYSTEM_ID distro_series=xenial hwe_kernel=hwe-16.04-edge
```

[note]
The command option `hwe_kernel` appears to apply to only HWE kernels but this is not the case.
[/note]
rad-end

<!-- comment -->

