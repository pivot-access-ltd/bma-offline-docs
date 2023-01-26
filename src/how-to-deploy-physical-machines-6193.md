<!-- "How to deploy physical machines" -->

With your network properly configured, and suitable images selected and downloaded, you're ready to [add](/t/how-to-make-machines-available/5160), [customise](/t/how-to-customise-machines/5108), and [deploy](/t/how-to-put-machines-to-work/5112) machines.  This article will help you sort out the theoretical aspects and procedures regarding the MAAS machine life-cycle, if you wish, before diving into the how-to procedures. 

Machines are the heart of MAAS. They are the backbone of your data centre application(s), providing the functions that are relevant to your customers. MAAS manages their transit through a life-cycle, from adding and enlistment, through commissioning, allocation, and deployment, finally being released back to the pool, or retired altogether.  You can move them around, create redundant versions (even in other geographies you can access), and basically rearrange them to the extent that your network allows.

In this article, you will learn:

- [About the machine life-cycle](#heading--about-the-machine-life-cycle)
- [About machine event logs](#heading--event-logs)
- [About the machine list](#heading--about-the-machine-list)
- [About machine storage info](#heading--machine-storage)
- [About disk erasure](#heading--about-disk-erasure)

<a href="#heading--about-the-machine-life-cycle"><h2 id="heading--about-the-machine-life-cycle">About the machine life-cycle</h2></a>

One of the most important things to understand about machines is their life-cycle. In this subsection, you will learn:

- [Introduction to the machine life-cycle](#heading--Introduction-to-the-machine-life-cycle)
- [About machine states](#heading--about-machine-states)
- [About enlistment](#heading--about-enlistment)
- [About commissioning machines](#heading--about-commissioning-machines)
- [About allocation and deployment](#heading--about-allocation-and-deployment)

<a href="#heading--Introduction-to-the-machine-life-cycle"><h3 id="heading--Introduction-to-the-machine-life-cycle">Introduction to the machine life-cycle</h3></a>

Everything that happens to a machine under MAAS control conforms to a specific life-cycle.  All MAAS machines are in a named state, or in transition between states.  Most of these transitions are user-controlled.  Only the "failure" state is reached under the direction of MAAS, when a user's request for certain state changes can't be successfully completed.

In general, the various states and transitions can be summarised in a diagram:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/bd9e5e225ffee4b2e88104e5bbd363dd2ef61a88.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/bd9e5e225ffee4b2e88104e5bbd363dd2ef61a88.jpeg"></a>

The central state flow at the bottom of the diagram is the "standard" life-cycle.  If all goes well, you won't have to deviate much from this flow:

- Machines start as servers in your environment, attached to a network or subnet that MAAS can reach and manage.  If those machines are configured to netboot, MAAS can discover them and enlist them, assigning a status of "NEW". By definition, NEW machines are: (2) enabled to network boot, and (2) on a subnet accessible to MAAS. 

- Once you've pared the list to machines that you want MAAS to control, you can choose to commission them.  You can select any machine that is marked "NEW" and tell MAAS to commission it, or, if you add machine manually, MAAS will automatically commission it.  Commissioning PXE boots the machine and loads an ephemeral version of the Ubuntu operating system into the machine's RAM.  MAAS then uses that OS to scan the machine to determine its hardware configuration: CPUs, RAM, storage layouts, PCI and USB devices, and so forth.  Commissioning can be customised -- more on that in a later section.  If a machine fails to properly commission, either because of a commissioning error, or because the commissioning process timed out, that machine enters a "FAILED" state.
  
- MAAS next tests the machine to make sure it's working properly. These basic tests just assure that the discovered hardware works as expected.  Testing can also be customised, if you wish.  Machines that don't pass these tests are moved to a "FAILED" state.

- Having tested it, MAAS then places that machine in the "READY" state, meaning that MAAS should be able to deploy it, based on the gathered hardware information.

- Before you deploy a machine, you should allocate it.  This step essentially involves taking ownership of the machine, so that no other users can deploy it.

- Having allocated a machine, you can deploy it.  When deploying, MAAS again loads an ephemeral Ubuntu OS onto the machine, uses `curtin` to configure the hardware in the way you've specified, and then loads and boots the OS image you've requested.  Deployment also runs some `cloud-init` steps to finish machine configuration, before leaving it up and ready for use.  

Once deployed, there are a couple of minor state changes you can effect without releasing the machine:

- You can lock a machine, if desired, to provide a little extra insurance that it won't accidentally be changed by you -- or anyone.

- Depending upon the machine's duty cycle, you can also power it on, power it off, or even power-cycle it (to effect a reboot, for example).

Note that these minor state changes are not shown in the diagram above.  There are also some exceptional states you can command:

- For any machine that is ready, allocated, or deployed, you can cycle it through a battery of tests at any time.  Be aware, of course, that testing causes the machine to be unavailable for normal use for the duration of the text cycle.

- Machines that are ready, allocated, or deployed can also be placed in "rescue mode".  Essentially, rescue mode is the same as walking to a malfunctioning or mis-configured machine, taking it off the network, and fixing whatever may be wrong with it -- except that you're doing so via SSH, or by running tests from MAAS, rather than standing in front of the machine.  Machines in rescue mode can't enter normal life cycle states until you remove them from rescue mode.  You can, of course, delete them, modify their parameters (tags, zone, and so on), power them off, and mark them broken.  Rescue mode is like a remote repair state that you can control from wherever you are.

- Machines that are allocated or deployed can also be marked broken.  A broken machine powers off by default.  You can still power it on, delete it, or enter rescue mode, but you can't log into it via SSH.  This state is intended for machines that experience catastrophic hardware or software failures and need direct repairs.

There is one more state that a machine can get into: "failed".  This state is entered when commissioning, allocation, or deployment are not successful.  Getting out of a failed state means figuring out what went wrong, correcting it, and retrying the failed operation.  For example, when a machine fails, you can try and commission it again, hopefully after you've found the bug in your custom commissioning script that's causing it to fail (for instance).

Now that we have a solid overview of the life-cycle, let's break down some of these states and transitions in greater detail.

<a href="#heading--about-enlistment"><h3 id="heading--about-enlistment">About enlistment</h3></a>

MAAS is built to manage machines, including the operating systems on those machines. Enlistment and commissioning are features that make it easier to start managing a machine -- as long as that machine has been configured to netboot. Enlistment enables users to simply connect a machine, configure the firmware properly, and power it on so that MAAS can find it and add it.

Enlistment happens when MAAS starts; it reaches out on connected subnets to locate any nodes -- that is, devices and machines -- that reside on those subnets. MAAS finds a machine that's configured to netboot (e.g., via PXE), boots that machine into Ubuntu, and then sends cloud-init user data which runs standard (i.e., built-in) commissioning scripts. The machine actually adds itself over the MAAS API, and then requests permission to send commissioning data.

Since MAAS doesn't know whether you might intend to actually include these discovered machines in your cloud configuration, it won't automatically take them over, but it will read them to get an idea how they're set up. MAAS then presents these machines to you with a MAAS state of "New." This allows you to examine them and decide whether or not you want MAAS to manage them.

When you configure a machine to netboot -- and turn it on while connected to the network -- MAAS will enlist it, giving it a status of "New."  You can also [add a machine manually](/t/how-to-make-machines-available/5160#heading--how-to-add-a-machine-manually). In either case, the next step is *commissioning*, which boots the machine into an ephemeral Ubuntu kernel so that resource information can be gathered.  You can also run custom commissioning scripts to meet your specific needs.

<a href="#heading--about-the-enlistment-process"><h4 id="heading--about-the-enlistment-process">About the enlistment process</h4></a>

When MAAS enlists a machine, it first contacts the DHCP server, so that the machine can be assigned an IP address.  An IP address is necessary to download a kernel and initrd via TFTP, since these functions can't accept domain names.  Once the machine has a bootable kernel, MAAS boots it:

<a href="https://discourse.maas.io/uploads/default/original/1X/76f7113545e6950fec60bdeac06cfaf79b14b3ff.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/76f7113545e6950fec60bdeac06cfaf79b14b3ff.jpeg"></a>

Next, initrd mounts a Squashfs image, ephemerally via HTTP, so that cloud-init can execute:

<a href="https://discourse.maas.io/uploads/default/original/1X/500f9bd2d070790a4007085705035366bee88a4a.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/500f9bd2d070790a4007085705035366bee88a4a.jpeg"></a>

Finally, cloud-init runs enlistment and setup scripts:

<a href="https://discourse.maas.io/uploads/default/original/1X/bd87f78c8ee668a22640bf15607c9e3e532d46bb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/bd87f78c8ee668a22640bf15607c9e3e532d46bb.jpeg"></a>

The enlistment scripts send information about the machine to the region API server, including the architecture, MAC address and other details.  The API server, in turn, stores these details in the database. This information-gathering process is known as [automatic discovery or network discovery](/t/how-to-set-up-networks/6174#heading--about-network-discovery).

Typically, the next step will be to commission the machine. As an alternative to enlistment, an administrator can add a machine manually. Typically this is done when enlistment doesn't work for some reason. Note that when you manually add a machine, MAAS automatically commissions the machine as soon as you've added it.

After the commissioning process, MAAS places the machine in the ‘Ready’ state. ‘Ready’ is a holding state for machines that are commissioned, waiting to be deployed when needed.

[note]
MAAS runs built-in commissioning scripts during the enlistment phase. When you commission a machine, any customised commissioning scripts you add will have access to data collected during enlistment. Follow the link above for more information about commissioning and commission scripts.
[/note]

<a href="#heading--about-bmc-enlistment"><h4 id="heading--about-bmc-enlistment">About BMC enlistment</h4></a>

For IPMI machines, you only need to provide IPMI credentials. MAAS automatically discovers the machine and runs enlistment configuration by matching the BMC address.  For non-IPMI machines, you must specify a non-PXE MAC address. MAAS automatically discovers the machine and runs enlistment configuration by matching the non-PXE MAC address.

<a href="#heading--about-adding-machines"><h4 id="heading--about-adding-machines">About adding machines</h4></a>

There are two ways to add a machine to MAAS:

1. If you place the machine on a connected network, and the machine is configured to netboot, MAAS will automatically enlist it.

2. If you add a machine manually, MAAS will automatically commission it.  There are also ways to turn off this automatic commissioning, should you desire to do so.

MAAS typically adds a machine via a combination of DHCP, TFTP, and PXE. By now, you should have enabled MAAS to automatically add devices and machines to your environment. This unattended method of adding machines is called enlistment.

Configuring a computer to boot over PXE is done via its BIOS, often referred to as "netboot" or "network boot". Normally, when you add a machine manually, MAAS will immediately attempt to commission the machine. Note that you will need to configure the underlying machine to netboot, or commissioning will fail. MAAS cannot handle this configuration for you.  While the correct method for configuring network boot depends heavily on your server, there are two common elements:

1. The network card on your server must be able to support PXE, i.e., your NIC -- whether independent or integrated on a motherboard -- must have a boot PROM that supports network booting.  You'll need to consult the documentation for the machine in question to determine this. Note that in MAAS versions before 2.5, you are required to provide the MAC address of the PXE interface when adding a new machine manually.

2. You usually have to interrupt the boot process and enter the BIOS/UEFI menu to configure the network card's PXE stack.  Again, you may need to consult your machine's documentation to pin down this step.

Additional steps will vary widely by machine type and architecture.

Regardless of how MAAS adds a machine, there are no special requirements for the underlying machine itself, other than being able to netboot. In particular, there is no need to install an operating system on it.

<a href="#heading--about-cloning-machines"><h4 id="heading--about-cloning-machines">About cloning machines</h4></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages"]
MAAS 3.1 provides the ability to quickly clone or copy configuration from one machine to one or more machines, via the MAAS UI, providing convenient access to an existing API feature.. This is a step towards machine profile templating work. 

Creating a machine profile is a repetitive task. Based on the responses to our survey -- and multiple forum posts, we have learned that most users create multiple machines of the same configuration in batches. Some users create a machine profile template and loop them through the API, while some create a script to interface with the CLI. However, there is no easy way to do this in the UI except by going through each machine and configuring them individually.   

MAAS API already has the cloning functionality, but it was never exposed in the UI. Hence, users may not know that this API feature exists, nor is there any current documentation about how to use this feature.  Although the current cloning API feature does not solve all machine profile templating problems, it is a great place for us to start moving in the direction of machine templates.

### About copying machine configurations

As a MAAS user -- API or UI -- you may want to copy the configuration of a given machine and apply it to multiple existing machines. Assuming that at least one machine is already set to the desired configuration, you should be able to apply these same settings to a list of destination machines.  This means that a user should be able to:

- select the source machine to copy from.
- validate that the source machine exists.
- select at least 1 destination machine.
- validate that the destination machine(s) exist.
- edit the source machine or destination machines, if needed.
- know at all times which machines are affected.
- see the cloned machines when cloning is successful, or
- get clear failure information, if cloning fails. 

### About choosing configuration items to copy

As a MAAS user, you will likely want to select whether storage, network, or both configurations should be cloned. The cloning API allows users to choose interfaces and storage separately.  Thus, this new feature should allow the user to:

- clone only the interface (network) configuration.
- clone only the storage configuration.
- clone both configurations.

### About cloning restrictions

In order for cloning to succeed, a few restrictions must be met:

- The destination interface names must be the same source.
- The destination drive must be equal to or larger than the source drive.
- For static IPs, a new IP will be allocated to the interface on the destination machine
[/tab]
[tab version="v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
Cloning machines is available starting with MAAS version 3.1.
[/tab]
[/tabs]


<a href="#heading--enlisting-deployed-machines"><h4 id="heading--enlisting-deployed-machines">About enlisting deployed machines</h4></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages"]
In general, when adding a machine to MAAS, it network boots the machine into an ephemeral environment to collect hardware information about the machine. While this is not a destructive action, it doesn’t work if you have machines that are already running a workload.

For one, you might not be able to disrupt the workload in order to network boot it. But also, the machine would be marked as Ready, which is incorrect.

When adding a machine, you may specify that the machine is already deployed. In that case, it won’t be going through the normal commissioning process and will be marked as being deployed.

Such machines lack hardware information. In order to update the information, a script is provided to run a subset of the commissioning scripts and send them back to MAAS.

Because already-deployed machines were not deployed by MAAS, most of the standard MAAS commands will not affect the machine and may, at times, return some odd results.  This is not errant behaviour; the goal of enlisting deployed machines is to avoid disturbing their workload. 
[/tab]
[tab version="v3.0 Snap,v3.0 Packages"]
MAAS version 3.0 cannot enlist deployed machines. Please upgrade to MAAS version 3.1 or greater to gain this capability.
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
MAAS version 2.9 cannot enlist deployed machines. Please upgrade to MAAS version 3.1 or greater to gain this capability.
[/tab]
[/tabs]

<a href="#heading--about-commissioning-machines"><h3 id="heading--about-commissioning-machines">About commissioning machines</h3></a>

When MAAS commissions a machine, the following sequence of events takes place:

1.  DHCP server is contacted
2.  kernel and initrd are received over TFTP
3.  machine boots
4.  initrd mounts a Squashfs image ephemerally over HTTP
5.  cloud-init runs built-in and custom commissioning scripts
6.  machine shuts down

The commissioning scripts will talk to the region API server to ensure that everything is in order and that eventual deployment will succeed.

MAAS chooses the latest Ubuntu LTS release as the default image for commissioning.  If desired, you can select a different image in the "Settings" page of the web UI, by selecting the "General" tab and then scrolling down to the Commissioning section.

[note]
Commissioning requires 60 seconds.
[/note]

<a href="#heading--about-numa-sriov-commissioning"><h4 id="heading--about-numa-sriov-commissioning">About commissioning NUMA and SR-IOV nodes</h4></a>

If you are using the NUMA architecture, MAAS versions 2.7 and higher guarantee that machines are assigned to a single NUMA node that contains all the machine's resources. Node boundaries are critical, especially in vNUMA situations.  Splitting nodes can create unnecessary latency.  You want the NUMA node boundaries to match VM boundaries if at all possible.

[note]
You must recommission NUMA/SR-IOV machines that were previously commissioned under version 2.6 or earlier.
[/note]

<a href="https://discourse.maas.io/uploads/default/original/1X/7b47235ff57a570ccba6a6ed09186a3d7483f5a4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/7b47235ff57a570ccba6a6ed09186a3d7483f5a4.png"></a>

When using these nodes, you can specify a node index for interfaces and physical block devices.  MAAS will display the NUMA node index and details, depending upon your configuration, to include the count of NUMA nodes, number of CPU cores, memory, NICs, and node spaces for bonds and block devices.  You can also filter machines by CPU cores, memory, subnet, VLAN, fabric, space, storage, and RAID, among others.

<a href="#heading--about-maas-commissioning-scripts"><h4 id="heading--about-maas-commissioning-scripts">About MAAS commissioning scripts</h4></a>

MAAS runs scripts during enlistment, commissioning and testing to collect data about nodes. Both enlistment and commissioning run all builtin commissioning scripts, though enlistment runs only built-ins. Commissioning also runs any user-uploaded commissioning scripts by default, unless the user manually provides a list of scripts to run. MAAS uses these commissioning scripts to configure hardware and perform other tasks during commissioning, such as updating the firmware. Similarly, MAAS employs hardware testing scripts to evaluate system hardware and report its status.

Scripts can be selected to run from web UI during commissioning, by testing hardware,  or from the command line. Note that MAAS only runs built-in commissioning scripts during enlistment. Custom scripts can be run when you explicitly choose to commission a machine.  A typical administrator workflow (with machine states), using customised commissioning scripts, can be represented as:

Add machine -&gt; Enlistment (runs built-in commissioning scripts MAAS) -&gt; New -&gt; Commission (runs built-in and custom commissioning scripts) -&gt; Ready -&gt; Deploy

NOTE: Scripts are run in alphabetical order in an ephemeral environment.  We recommend running your scripts after any MAAS built-in scripts.  This can be done by naming your scripts 99-z*.  It is possible to reboot the system during commissioning using a script, however, as the environment is ephemeral, any changes to the environment will be destroyed upon reboot (barring, of course, firmware type updates).

When a machine boots, MAAS first instructs it to run cloud-init to set up SSH keys (during commissioning only), set up NTP, and execute a script that runs other commissioning scripts.  Currently, the sequence of MAAS-provided commissioning scripts proceeds like this:

- **maas-support-info:** MAAS gathers information that helps to identify and characterise the machine for debugging purposes, such as the kernel, versioning of various components, etc.  **Runs in parallel with other scripts.**

- **maas-lshw:** this script pulls system BIOS and vendor info, and generates user-defined tags for later use.  **Runs in parallel with other scripts.**

- **20-maas-01-install-lldpd:** this script installs the link layer discovery protocol (LLDP) daemon, which will later capture networking information about the machine.  This script provides some extensive logging.

- **maas-list-modaliases:** this script figures out what hardware modules are loaded, providing a way to autorun certain scripts based on which modules are loaded.  **Runs in parallel with other scripts.**

- **20-maas-02-dhcp-unconfigured-ifaces:** MAAS will want to know all the ways the machine is connected to the network.  Only PXE comes online during boot; this script brings all the other networks online so they can be recognised.  This script provides extensive logging.

- **maas-get-fruid-api-data:** this script gathers information for the Facebook wedge power type.  **Runs in parallel with other scripts.**

- **maas-serial-ports:** this script lists what serial ports are available on the machine.  **Runs in parallel with other scripts.**

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
[note]
As of MAAS version 3.0, **40-maas-01-network-interfaces** is no longer used by MAAS.
[/note]
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
- **40-maas-01-network-interfaces:** this script is just used to get the IP address, which can then be associated with a VLAN/subnet.
[/tab]
[/tabs]

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
- **50-maas-01-commissioning:** this script is the main MAAS tool, gathering information on machine resources, such as storage, network devices, CPU, RAM, details about attached USB and PCI devices, etc.  We currently pull this data using lxd: We use a Go binary built from lxd source that just contains the minimum source to gather the resource information we need.  This script also checks whether the machine being commissioning is a virtual machine, which may affect how MAAS interacts with it.
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
- **50-maas-01-commissioning:** this script is the main MAAS tool, gathering information on machine resources, such as storage, network devices, CPU, RAM, etc.  We currently pull this data using lxd: We use a Go binary built from lxd source that just contains the minimum source to gather the resource information we need. This script also checks whether the machine being commissioning is a virtual machine, which may affect how MAAS interacts with it.
[/tab]
[/tabs]

- **maas-capture-lldp:** this script gathers LLDP network information to be presented on the logs page; this data is not used by MAAS at all.  **Runs in parallel with other scripts.**

- **maas-kernel-cmdline:** this script is used to update the boot devices; it double-checks that the right boot interface is selected.

Commissioning runs the same dozen or so scripts as enlistment, gathering all the same information, but with these caveats:

- Commissioning also runs user-supplied commissioning scripts, if present.  Be aware that these scripts run as root, so they can execute any system command.

- Commissioning runs test scripts which are not run during enlistment.

- Commissioning scripts can send BMC configuration data, and can be used to configure BMC data.

- The environment variable BMC_CONFIG_PATH is passed to serially run commissioning scripts; these scripts may write BMC power credentials to BMC_CONFIG_PATH in YAML format, where each key is a power parameter.  The first script to write BMC_CONFIG_PATH is the only script allowed to configure the BMC, allowing you to override MAAS' built-in BMC detection.  If the script returns 0, that value will be send to MAAS.

- All built-in commissioning scripts have been migrated into the database.

- `maas-run-remote-scripts` is capable of enlisting machines, so enlistment `user-data` scripts have been removed.

- The metadata endpoints `http://<MAAS>:5240/<latest or 2012-03-01>/` and `http://<MAAS>:5240/<latest or 2012-03-01>/meta-data/` are now available anonymously for use during enlistment.

In both enlistment and commissioning, MAAS uses either the MAC address or the UUID to identify machines.  Currently, because some machine types encountered by MAAS do **not** use unique MAC addresses, we are trending toward using the UUID.

[note]
To commission a node, it must have a status of "New".
[/note]

You have the option of setting some parameters to change how commissioning runs:

- `enable_ssh`: Optional integer. Controls whether to enable SSH for the commissioning environment using the user's SSH key(s). '1' == True, '0' == False. Roughly equivalent to the **Allow SSH access and prevent machine powering off** in the web UI.

- `skip_bmc_config`: Optional integer.  Controls whether to skip re-configuration of the BMC for IPMI based machines. '1' == True, '0' == False.

- `skip_networking`: Optional integer.  Controls whether to skip re-configuring the networking on the machine after the commissioning has completed. '1' == True, '0' == False. Roughly equivalent to **Retain network configuration** in the web UI.

- `skip_storage`: Optional integer.  Controls whether to skip re-configuring the storage on the machine after the commissioning has completed. '1' == True, '0' == False.  Roughly equivalent to **Retain storage configuration** in the web UI.

- `commissioning_scripts`: Optional string.  A comma separated list of commissioning script names and tags to be run. By default all custom commissioning scripts are run. Built-in commissioning scripts always run. Selecting `update_firmware` or `configure_hba` will run firmware updates or configure HBA's on matching machines.

- `testing_scripts`: Optional string.  A comma separated list of testing script names and tags to be run. By default all tests tagged `commissioning` will be run. Set to `none` to disable running tests.

- `parameters`: Optional string.  Scripts selected to run may define their own parameters. These parameters may be passed using the parameter name. Optionally a parameter may have the script name prepended to have that parameter only apply to that specific script.

<a href="#heading--commissioning-log"><h4 id="heading--commissioning-log">About machine commissioning logs</h4></a>

MAAS keeps extensive logs of the commissioning process for each machine. These logs present an extremely detailed, timestamped record of completion and status items from the commissioning process.

<a href="#heading--about-disabling-individual-boot-methods"><h4 id="heading--about-disabling-individual-boot-methods">About disabling individual boot methods</h4></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
It is possible to disable individual boot methods.  This must be done via the CLI. When a boot method is disabled MAAS will configure MAAS controlled `isc-dhcpd` to not respond to the associated [boot architecture code](https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml#processor-architecture)`↗`. External DHCP servers must be configured manually.

To allow different boot methods to be in different states on separate physical networks using the same VLAN ID configuration is done on the subnet in the UI or API. When using the API boot methods to be disabled may be specified using the MAAS internal name or [boot architecture code](https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml#processor-architecture)`↗` in octet or hex form. 

For MAAS 3.0 and above, the following boot method changes have been implemented:

- UEFI AMD64 HTTP(00:10) has been re-enabled.
- UEFI ARM64 HTTP(00:13) has been enabled.
- UEFI ARM64 TFTP(00:0B) and UEFI ARM64 HTTP(00:13) will now provide a shim and GRUB signed with the Microsoft boot loader keys.
- grub.cfg for all UEFI platforms has been updated to replace the deprecated `linuxefi` and `initrdefi` commands with the standard `linux` and `initrd` commands.
- GRUB debug may now be enabled by enabling rackd debug logging.

[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
Disabling boot methods is available in MAAS version 3.0 or greater.
[/tab]
[/tabs]


<a href="#heading--about-automatic-script-selection-by-hardware-type"><h4 id="heading--about-automatic-script-selection-by-hardware-type">About automatic script selection by hardware type</h4></a>

When selecting multiple machines, scripts which declare the `for_hardware` field will only run on machines with matching hardware. To automatically run a script when 'Update firmware' or 'Configure HBA' is selected, you must tag the script with 'update_firmware' or 'configure_hba'.

Similarly, scripts selected by tag on the command line which specify the `for_hardware` field will only run on matching hardware.

<a href="#heading--about-script-results"><h4 id="heading--about-script-results">About script results</h4></a>

A script can output its results to a YAML file, and those results will be associated with the hardware type defined within the script. MAAS provides the path for the results file in an environment variable, `RESULT_PATH`. Scripts should write YAML to this file before exiting.

If the hardware type is storage, for example, and the script accepts a storage type parameter, the result will be associated with a specific storage device.

The YAML file must represent a dictionary with these two fields:

1. `result`: The completion status of the script. This status can be `passed`, `failed`, `degraded`, or `skipped`. If no status is defined, an exit code of `0` indicates a pass while a non-zero value indicates a failure.

2. `results`: A dictionary of results. The key may map to a results key defined as embedded YAML within the script. The value of each result must be a string or a list of strings.

Optionally, a script may define what results to return in the YAML file in the metadata fields.. The `results` field should contain a dictionary of dictionaries. The key for each dictionary is a name which is returned by the results YAML. Each dictionary may contain the following two fields:

1. `title` - The title for the result, used in the UI.

2. `description` - The description of the field used as a tool-tip in the UI.

Here is an example of "degrade detection":

``` python
#!/usr/bin/env python3

# --- Start MAAS 1.0 script metadata ---
# name: example
# results:
#   memspeed:
#     title: Memory Speed
#     description: Bandwidth speed of memory while performing random read writes
# --- End MAAS 1.0 script metadata ---

import os
import yaml

memspeed = some_test()

print('Memspeed: %s' % memspeed)
results = {
   'results': {
       'memspeed': memspeed,
   }
}
if memspeed < 100:
   print('WARN: Memory test passed but performance is low!')
   results['status'] = 'degraded'

result_path = os.environ.get("RESULT_PATH")
if result_path is not None:
   with open(result_path, 'w') as results_file:
       yaml.safe_dump(results, results_file)
```


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

<a href="#heading--about-debugging-script-failures"><h4 id="heading--about-debugging-script-failures">About debugging script failures</h4></a>

You can individually access the output from both completed and failed scripts.

<a href="https://assets.ubuntu.com/v1/855015e5-nodes-hw-scripts__2.2_fail.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/855015e5-nodes-hw-scripts__2.2_fail.png"></a>

If you need further details, especially when writing and running your own scripts, you can connect to a machine and examine its logs and environment.

<a href="https://assets.ubuntu.com/v1/da793c67-nodes-hw-scripts__2.4_ssh.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/da793c67-nodes-hw-scripts__2.4_ssh.png"></a>

Because scripts operate within an ephemeral version of Ubuntu, enabling this option stops the machine from shutting down, allowing you to connect and probe a script's status.

As long as you've added your [SSH key](/t/how-to-manage-user-accounts/5184#heading--ssh-keys) to MAAS, you can connect with SSH to the machine's IP with a username of `ubuntu`. Type `sudo -i` to get root access.

<a href="#heading--about-testing-hardware"><h4 id="heading--about-testing-hardware">About testing hardware</h4></a>

If you wish, you can tell MAAS to test machine hardware using well-known Linux utilities.  MAAS can test machines that have a status of **Ready**, **Broken**, or **Deployed**.  You can include testing as part of the commissioning process. When you choose the 'Commission' action, MAAS will display the dialog described below.  Be aware, though, that if the hardware tests fail, the machine will become unavailable for Deployment.

[note]
The majority of testing scripts only work with machines that are backed by physical hardware (e.g. they may be incompatible with VM-based machines).
[/note]

With MAAS, you can easily write, upload and execute your hardware testing scripts and see the results.

<a href="#heading--hardware-tests"><h4 id="heading--hardware-tests">About machine hardware & test logs</h4></a>

MAAS logs test results and allows you to view a summary of tests run against a particular machine.  You can also example details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png"></a>

You can also examine the "raw" log output:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png"></a>

Help interpreting these logs can be found under the [Logging](/t/how-to-work-with-log-files/5240) section of this documentation.

<a href="#heading--about-testing-machine-networking"><h4 id="heading--about-testing-machine-networking">About testing machine networking</h4></a>

MAAS provides a comprehensive suite of network and link testing capabilities.  MAAS can check whether or not links are connected, detect slow links, and report link and interface speeds via UI or API. In addition, you can test Internet connectivity against a user-provided list of URLs or IP addresses.  Bonded NICS will be separated during this testing, so that each side of a redundant interface is fully evaluated.

Network testing also includes customisable network testing and commissioning scripts. There are no particular restrictions on these scripts, allowing you to test a wide variety of possible conditions and situations.

<a href="#heading--about-post-commission-configuration"><h4 id="heading--about-post-commission-configuration">About post-commission configuration</h4></a>

Once commissioned, you can configure the machine's network interface(s). Specifically, when a machine's status is either "Ready" or "Broken", interfaces can be added/removed, attached to a fabric and linked to a subnet, and provided an IP assignment mode. Tags can also be assigned to specific network interfaces.

<a href="#heading--about-allocation-and-deployment"><h3 id="heading--about-allocation-and-deployment">About allocation and deployment</h3></a>

Once a machine has been commissioned, the next logical step is to deploy it. Deploying a machine means, effectively, to [install an operating system on it](/t/how-to-acquire-images/6192#heading--how-images-deploy), along with any other application loads you wish to run on that machine.

 A detailed picture of deployment looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f7e0fb1916bca084de75fc0479bfec3c95adf7b6.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f7e0fb1916bca084de75fc0479bfec3c95adf7b6.png"></a>

We'll come back to this process when we talk about deployment, a little later on. 

Before deploying a machine, MAAS must allocate it (status 'Allocated'). Allocating a machine reserves the machine for the exclusive use of the allocation process. The machine is no longer available to any other process, including another MAAS instance, or a process such as Juju.

The agent that triggers deployment may vary. For instance, if the machines are destined to run complex, inter-related services that scale up or down frequently, like a "cloud" resource, then [Juju](https://jaas.ai/)`↗` is the recommended deployment agent. Juju will also install and configure services on the deployed machines. If you want to use MAAS to install a base operating system and work on the machines manually, then you can deploy a machine directly with MAAS.

Machines deployed with MAAS will also be ready to accept connections via SSH, to the 'ubuntu' user account.  This connection assumes that you have imported an SSH key has to your MAAS account. This is explained in [SSH keys](/t/how-to-manage-user-accounts/5184#heading--ssh-keys).

[note]
Juju adds SSH keys to machines under its control.
[/note]

MAAS also supports machine customisation with a process called "preseeding." For more information about customising machines, see [How to customise machines](/t/how-to-customise-machines/5108).

To deploy, you must configure the underlying machine to netboot.  Such a machine will undergo the following process:

1.  DHCP server is contacted
2.  kernel and initrd are received over TFTP
3.  machine boots
4.  initrd mounts a Squashfs image ephemerally over HTTP
5.  cloud-init triggers deployment process
6.  curtin installation script runs
7.  Squashfs image (same as above) is placed on disk

[note]
The curtin installer uses an image-based method and is now the only installer used by MAAS. Although the older debian-installer method has been removed, curtin continues to support preseed files. For more information about customising machines see [How to customise machines](/t/how-to-customise-machines/5108).
[/note]

Before deploying, you should take two key actions:

1. Review and possibly set the [Ubuntu kernels](/t/how-to-customise-machines/5108#heading--about-ubuntu-kernels) and the [Kernel boot options](/t/how-to-customise-machines/5108#heading--about-kernel-boot-options) that will get used by deployed machines.

2. Ensure any pertinent SSH keys are imported (see [SSH keys](/t/how-to-manage-user-accounts/5184#heading--ssh-keys)) to MAAS so it can connect to deployed machines.

<a href="#heading--event-logs"><h2 id="heading--event-logs">About machine event logs</h2></a>

Event logs display a list of timestamped status updates for events and actions performed on the machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png"></a>

Detailed discussion of this event log can be found under the [Logging](/t/how-to-work-with-log-files/5240) section of this documentation.

<a href="#heading--about-the-machine-list"><h2 id="heading--about-the-machine-list">About the machine list</h2></a>

The machine list is the basic dashboard for many MAAS operations.  In this subsection, you will learn:

- [About the machine summary](#heading--about-the-machine-summary)
- [Handling attached USB and PCI devices](#heading--usb-pci-devices)
- [About machine network info](#heading--about-machine-interfaces)
- [About machine configuration info](#heading--machine-config)
- [About resource pools](#heading--about-resource-pools)
- [About tags](#heading--about-tags)
- [About annotations](#heading--about-annotations)
- [About storage](#heading--about-storage)
  
In the illustration below, you see the machine list for a typical small hospital data centre, including servers ready and allocated for functions like Pharmacy, Orders, Charts, and so on:

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="https://discourse.maas.io/uploads/default/original/1X/30df04b0bcec5fcf6538590ed795cb0514a64675.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/30df04b0bcec5fcf6538590ed795cb0514a64675.jpeg"></a>

Rolling the cursor over status icons often reveals more details. For example, a failed hardware test script will place a warning icon alongside the hardware type tested by the script. Rolling the cursor over this will reveal which test failed.  Likewise, you can find some immediate options by rolling over the column data items in the machines table.

<a href="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg"></a>

The 'Add hardware' drop-down menu is used to add either new machines or a new chassis. This menu changes context when one or more machines are selected from the table, using either the individual checkboxes in the first column or the column title checkbox to select all.

<a href="https://discourse.maas.io/uploads/default/original/1X/9a0747649e6aff999d3c04335eb752accedaf3de.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/9a0747649e6aff999d3c04335eb752accedaf3de.jpeg"></a>

With one or more machines selected, the 'Add hardware' drop-down menu moves to the left, and is joined by the 'Take action' menu.  This menu provides access to the various [machine actions](/t/maas-glossary/5416#node-actions) that can be applied to the selected machine(s):

<a href="https://discourse.maas.io/uploads/default/original/1X/e03d5ac8de9ea4f4827ed057bb2dd83e241aac3b.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e03d5ac8de9ea4f4827ed057bb2dd83e241aac3b.jpeg"></a>

[note]
The 'Filter by' section limits the machines listed in the table to selected keywords and machine attributes.
[/note]

[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
```nohighlight
FQDN               POWER  STATUS     OWNER  TAGS     POOL       NOTE     ZONE
----               -----  ------     -----  ----     ----       ----     ----
52-54-00-15-36-f2  off    Ready      -      Orders   Prescrbr   @md-all  Medications
52-54-00-17-64-c8  off    Ready      -      HRMgmt   StaffComp  @tmclck  Payroll
52-54-00-1d-47-95  off    Ready      -      MedSupp  SuppServ   @storag  Inventory
52-54-00-1e-06-41  off    Ready      -      PatPrtl  BusOfc     @bzstns  BizOffice
52-54-00-1e-a5-7e  off    Ready      -      Pharm    Prescrbr   @rxonly  Pharmacy
52-54-00-2e-b7-1e  off    Allocated  admin  NursOrd  NurServ    @nstns   Nursing
52-54-00-2e-c4-40  off    Allocated  admin  MedAdmn  NurServ    @rxonly  Nursing
52-54-00-2e-ee-17  off    Deployed   admin  Charts   ProServ    @md-all  Physician
```

You can generate a list similar to this for your machines with the command:

```nohighlight
maas admin machines read | jq -r '(["FQDN","POWER","STATUS",
"OWNER", "TAGS", "POOL", "NOTE", "ZONE"] | (., map(length*"-"))),
(.[] | [.hostname, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name, .description // "-", .zone.name]) | @tsv' | column -t
```
[/tab]
[/tabs]

These example machines would typically be duplicated in several different geographies, with a quick way to switch to a redundant node, should anything go wrong (e.g., high availability).  We used the word node there because, In the network language of MAAS, machines are one of several different types of nodes.  A node is simply a network-connected object or, more specifically, an object that can independently communicate on a network. MAAS nodes include controllers, network devices, and of course, machines.

Looking back at the example above, you can see that there are several columns in the machine list, depending on your view:

- **FQDN | MAC**: The fully qualified domain name or the MAC address of the machine.
- **Power**: 'On', 'Off' or 'Error' to highlight an error state.
- **Status**: The current status of the machine, such as 'Ready', 'Commissioning' or 'Failed testing'.
- **Owner**: The MAAS account responsible for the machine.
- **Cores**: The number of CPU cores detected on the machine.
- **RAM**: The amount of RAM, in GiB, discovered on the machine.
- **Disks**: The number of drives detected on the machine.
- **Storage**: The amount of storage, in GB, identified on the machine.

<a href="#heading--about-the-machine-summary"><h3 id="heading--about-the-machine-summary">About the machine summary</h3></a>

Click a machine's FQDN or MAC address to open a detailed view of a machine's status and configuration.

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png"></a>

The default view is 'Machine summary', presented as a series of cards detailing the CPU, memory, storage and tag characteristics of the machine, as well as an overview of its current status. When relevant, 'Edit' links take you directly to the settings pane for the configuration referenced within the card.  The machine menu bar within the web UI also includes links to logs, events, and configuration options:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/21e9f4dca3a3e0a6657b5b2a570c9fc68a3e4961.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/21e9f4dca3a3e0a6657b5b2a570c9fc68a3e4961.png"></a>

The machine status card presents an overview of CPU, memory, storage, tags, and general settings:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png"></a>

The first card presents some basics of the machine resources and configuration:

<a href="https://discourse.maas.io/uploads/default/original/1X/3e50fb21f4985db0a85519e2e933e24658770b9e.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/3e50fb21f4985db0a85519e2e933e24658770b9e.jpeg"></a>

Here are some details on what this card presents, with details on in-card links described in following sections:

- **OVERVIEW** the machine status (in this case "Deployed"), and lists OS version information.  

- **CPU** shows the specifics of the CPU(s), including a link to test the processor(s).

- **MEMORY** gives the total available RAM for this machine, along with a test link.

- **STORAGE** presents the total amount of storage available and the number of disks that provide that storage.  There are two links here: one gives the storage layout (with the opportunity to change it for devices that are in 'Ready' or 'Allocated' states.

- **Owner** identifies the owner of the machine.

- **Domain** indicates the domain in which the machine exists.

- **Zone** shows the AZ in which this machine resides, along with a link to edit the machine configuration (to change the AZ, if desired).

- **Resource pool** shows the pool to which this machine has been assigned, and an edit link.

- **Power type** gives the current power type, which links to the relevant edit form.

- **Tags** presents the list of tags associated with this machine, editable via the link.

Note that clicking any of the links in this card will either present a pop-up form or take you to another item in the machine menu -- so using the browser "back" button will take you completely away from this machine's page.  For example, you can choose the "Test CPU" option, which brings up this overlay:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/6d7fe50e5b296a37a03269a1f5be3d25a2a2481a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/6d7fe50e5b296a37a03269a1f5be3d25a2a2481a.png"></a>

From this screen, you can choose test scripts and run the tests (in the background) as the interface returns to the Machine summary.  A linked note in the CPU block lets you know that the tests are in progress:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3e140872c407e5b9eb06960b5b42353765567192.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3e140872c407e5b9eb06960b5b42353765567192.png"></a> 

And you can watch the results under the "Tests" option in the Machine menu:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f398c9ed670af8c0886ccc1ed8bf586e3faf1e53.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f398c9ed670af8c0886ccc1ed8bf586e3faf1e53.png"></a> 

The rest of the cards on the Machine summary are either self-explanatory, or they're covered in the sections below.  The main point is this: You can see that nearly everything about machines takes place within the main menu's "Machines" option. 

<a href="#heading--usb-pci-devices"><h3 id="heading--usb-pci-devices">Handling attached USB and PCI devices</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
The machines in your MAAS may have devices attached to them via USB or PCI interface, such as keyboards, cameras, network cards, GPUs, etc.  MAAS will recognise these devices and make them visible to you when a machine is commissioned.

For example, the machine details presents USB and PCI devices like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/87f42bafe321d45af94d73216f933a9067f01df2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/87f42bafe321d45af94d73216f933a9067f01df2.png"></a>

Note that this page now includes two new tabs: "PCI devices" and "USB."  For each USB/PCI device attached to your machine, these tabs will list:

- device type
- vendor ID
- a product description
- a product ID
- the driver name
- the containing NUMA node (if any)
- the device address

A typical PCI device tab would look something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/82e1e6f8bc511047ac5f773430f7e5812c7a24d4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/82e1e6f8bc511047ac5f773430f7e5812c7a24d4.png"></a>

The USB tab presents similar information in the same format.

[note]
If you are upgrading from a previous version of MAAS, PCI and USB devices aren't modelled, so you will have to recommission the machine to capture these devices.
[/note]


Once you've commissioned the machine, you have the option of deleting
PCI/USB devices from the machine in any machine state, via the CLI
only, using the following command:

```
maas $PROFILE node-device delete $SYSTEM_ID $DEVICE_ID
```

where:

- $PROFILE   = your user profile (e.g., "admin")
- $SYSTEM_ID = the ID of the machine in question (e.g., "ngx7ry")
- $DEVICE_ID = the ID of the device you want to delete 

If the device is still present in the system, it will be recognised again (and thus "recreated")
when the machine is commissioned again.

<a href="#heading--about-machine-interfaces"><h3 id="heading--about-machine-interfaces">About machine network info</h3></a>

The Network "tab" provides you with a way to view/edit the network and interface configuration for a machine: 

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png"></a> 

In the case of this deployed machine, there are not many editing options.  If the machine is in a 'Ready' state, though, altering the network configuration is possible, as shown in the screenshot above.

Options on this tab are described in the introduction to [Networking](/t/how-to-set-up-networks/6174) article in this documentation set.

<a href="#heading--machine-config"><h3 id="heading--machine-config">About machine configuration info</h3></a>

The final tab from the Machine menu allows you to update machine and power configuration options: 

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png"></a> 

There are two sections to this tab.  The "Machine configuration" section, shown above, offers some general parameters, mostly related to how this machine is grouped and categorised.  More information on these options are found in the relevant sections of the documentation (e.g., tags, resource pools, and so forth). 

The "Power configuration" supplies the parameters necessary for MAAS to access the machine to PXE-boot it: 

<a href="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png"></a> 

More information on Power configuration will be found in the [Power management](/t/power-management-reference/5246) section of this documentation.
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
USB and PCI devices are supported in MAAS version 3.0 and greater.
[/tab]
[/tabs]

<a href="#heading--about-resource-pools"><h3 id="heading--about-resource-pools">About resource pools</h3></a>

Resource pools allow administrators to logically group resources -- machines and VM hosts -- into pools. Pools can help you budget machines for a particular set of functions.  For example, if you're using MAAS to manage a hospital data centre, you may want to keep a certain number of machines reserved for provider use, whether that be for the charts, documentation, or orders application.  You can use resource pools to reserve those machines, regardless of which of the three applications you end up loading onto a particular machine at any given time. 

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


<a href="#heading--about-storage"><h3 id="heading--about-storage">About storage</h3></a>

You have significant latitude when choosing the final storage configuration of a deployed machine. MAAS supports traditional disk partitioning, as well as more complex options such as LVM, RAID, and bcache. MAAS also supports UEFI as a boot mechanism.  This article explains boot mechanisms and layouts, and offers some advice on how to configure layouts and manage storage.

[note]
MAAS doesn’t currently support deploying with ZFS for devices other than the root one.  For this reason, ZFS is disrecommended.
[/note]

A machine's storage is dependant upon the underlying system's disks, but its configuration (i.e., disk usage) is the result of a storage template. In MAAS, this template is called a layout, and MAAS applies it to a machine during commissioning.  Once a layout is applied, a regular user can make modifications to a machine at the filesystem level to arrive at the machine's final storage configuration.  When a machine is no longer needed, a user can choose from among several disk erasure types before releasing it.

[note]
MAAS supports storage configuration for CentOS and RHEL deployments. Support includes RAID, LVM, and custom partitioning with different file systems (ZFS and bcache excluded). This support requires a newer version of Curtin, [available as a PPA](https://launchpad.net/ubuntu/+source/curtin)`↗`.
[/note]


<a href="#heading--machine-storage"><h2 id="heading--machine-storage">About machine storage info</h2></a>

One of the key elements of managing machines is configuring and managing their storage space.  This subsection will help you learn:

- [About block devices](#heading--about-block-devices)
- [About partitions](#heading--about-partitions)
- [About storage restrictions](#heading--about-storage-restrictions)
- [About VMFS datastores](#heading--about-vmfs-datastores)
- [About UEFI booting](#heading--about-uefi-booting)
- [About final storage modifications](#heading--final-storage-modifications)

The Storage tab on the machine list brings up a form that allows you to view/edit the file system, partitioning and storage parameters for the selected machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

This tab describes the filesystem(s) in use, as well as the available and used partitions for this machine.  


<a href="#heading--about-block-devices"><h3 id="heading--about-block-devices">About block devices</h3></a>

Once the initial storage layout has been configured on a machine, you can perform many operations to view and adjust the entire storage layout for the machine. In MAAS there are two different types of block devices.

**Physical**

A physical block device is a physically attached block device such as a 100GB hard drive connected to a server.

**Virtual**

A virtual block device is a block device that is exposed by the Linux kernel when an operation is performed. Almost all the operations on a physical block device can be performed on a virtual block device, such as a RAID device exposed as md0.


<a href="#heading--about-partitions"><h3 id="heading--about-partitions">About partitions</h3></a>

As with block devices (see [Block devices](#heading--about-block-devices)), MAAS and the MAAS API offer a great deal of control over the creation, formatting, mounting and deletion of partitions.


<a href="#heading--about-storage-restrictions"><h3 id="heading--about-storage-restrictions">About storage restrictions</h3></a>

There are three restrictions for the storage configuration:

1.   An EFI partition is required to be on the boot disk for UEFI.
2.   You cannot place partitions on logical volumes.
3.   You cannot use a logical volume as a Bcache backing device.

Violating these restrictions will prevent a successful deployment.


<a href="#heading--about-vmfs-datastores"><h3 id="heading--about-vmfs-datastores">About VMFS datastores</h3></a>

MAAS can configure custom local VMware VMFS Datastore layouts to maximise the usage of your local disks when deploying VMware ESXi. As VMware ESXi requires specific partitions for operating system usage, you must first apply the VMFS6 storage layout. This layout creates a VMFS Datastore named `datastore1` which uses the disk space left over on the boot disk after MAAS creates the operating system partitions.


<a href="#heading--about-uefi-booting"><h3 id="heading--about-uefi-booting">About UEFI booting</h3></a>

Every layout type supports a machine booting with UEFI. In such a case, MAAS automatically creates an EFI boot partition (`/boot/efi`). Other than setting the machine to boot from UEFI, the user does not need to take any additional action.

[note]
UEFI must be enabled or disabled for the lifespan of the machine. For example, do not enlist a machine with UEFI enabled, and then disable it before commissioning. It won't work!
[/note]

The EFI partition, if created, will be the first partition (`sda1`) and will have a FAT32 filesystem with a size of 512 MB.


<a href="#heading--final-storage-modifications"><h3 id="heading--final-storage-modifications">About final storage modifications</h3></a>

Once MAAS provisions a machine with block devices, via a layout or administrator customisation, a regular user can modify the resulting storage configuration at the filesystem level.


<a href="#heading--about-disk-erasure"><h2 id="heading--about-disk-erasure">About disk erasure</h2></a>

Disk erasure pertains to the erasing of data on each of a machine's disks when the machine has been released (see [Release action](/t/maas-glossary/5416#heading--release)) back into the pool of available machines. The user can choose from among three erasure types before confirming the Release action, and a default erasure configuration can also be set.  This section will help you learn:

- [About disk erasure types](#heading--about-disk-erasure-types)
- [About standard erasure](#heading--about-standard-erase)
- [About secure erasure](#heading--about-secure-erasure)
- [About quick erasure](#heading--about-quick-erasure)
- [About erasure order of preference](#heading--about-erasure-order-of-preference)

<a href="#heading--about-disk-erasure-types"><h3 id="heading--about-disk-erasure-types">About disk erasure types</h3></a>

The three disk erasure types are:

1.   Standard erasure
2.   Secure erasure
3.   Quick erasure

Each of these are explained below.


<a href="#heading--about-standard-erase"><h3 id="heading--about-standard-erase">About standard erasure</h3></a>

Overwrites all data with zeros.


<a href="#heading--about-secure-erasure"><h3 id="heading--about-secure-erasure">About secure erasure</h3></a>

Although effectively equivalent to Standard erase, Secure erase is much faster because the disk's firmware performs the operation. Because of this, however, some disks may not be able to perform this erasure type (SCSI, SAS, and FC disks in particular).


<a href="#heading--about-quick-erasure"><h3 id="heading--about-quick-erasure">About quick erasure</h3></a>

Same as Standard erase but only targets the first 1 MB and the last 1 MB of each disk. This removes the partition tables and/or superblock from the disk, making data recovery difficult but not impossible.


<a href="#heading--about-erasure-order-of-preference"><h3 id="heading--about-erasure-order-of-preference">About erasure order of preference</h3></a>

If all three options are checked when the machine is released, the following order of preference is applied:

1.  Use 'secure erase' if the disk supports it
2.  If it does not, then use 'quick erase'

<a href="#heading--Customising-machines"><h2 id="heading--Customising-machines">Customising machines</h2></a>

Prior to deployment, MAAS machines can be customised in a number of ways, including:

- machine storage.
- commissioning and deployment configurations (known as "pre-seeding").
- custom Ubuntu kernels.
- kernel boot options. 
- resource pools.

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages"]
Machines can also be customised post-deployment, while running, either by changing out the physical hardware, or by altering the VM from the VM host side.  This will allow you to:

- add or remove disks
- add or remove network interfaces
- add or remove PCI devices
- add or remove USB devices

[note]
You cannot update these parameters from within MAAS on a deployed machine.
[/note]

While deploying a machine, you can configure that machine to periodically sync its hardware configuration.  Deployed machines will passively update changes to the BMC and tags for that machine, on-the-fly, as these changes are made.

This article will help you learn:

- [About customising machines prior to deployment](#heading--about-customising-machines-prior-to-deployment)
- [About customising deployed machines](#heading--about-customising-deployed-machines)

In short, this article will explain these possible customisations, and provide detailed instructions on how to customise your own machines as desired.
[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
This article will help you learn [about customising machines](#heading--about-customising-machines-prior-to-deployment)

In short, this article will explain these possible customisations, and provide detailed instructions on how to customise your own machines as desired.
[/tab]
[/tabs]

<a href="#heading--about-customising-machines-prior-to-deployment"><h2 id="heading--about-customising-machines-prior-to-deployment">About customising machines prior to deployment</h2></a>

In this section, you'll learn:

- [About customising machine storage](#heading--about-customising-machine-storage)
- [About pre-seeding](#heading--about-pre-seeding) (customising commissioning and deployment)
- [About Ubuntu kernels](#heading--about-ubuntu-kernels)
- [About kernel boot options](#heading--about-kernel-boot-options)
- [About resource pools](#heading--about-resource-pools)

<a href="#heading--about-customising-machine-storage"><h3 id="heading--about-customising-machine-storage">About customising machine storage</h3></a>

You have significant latitude when choosing the final storage configuration of a deployed machine. MAAS supports traditional disk partitioning, as well as more complex options such as LVM, RAID, and bcache. MAAS also supports UEFI as a boot mechanism.  This article explains boot mechanisms and layouts, and offers some advice on how to configure layouts and manage storage.

[note]
MAAS doesn’t currently support deploying with ZFS for devices other than the root one.  For this reason, ZFS is disrecommended.
[/note]

A machine's storage is dependant upon the underlying system's disks, but its configuration (i.e., disk usage) is the result of a storage template. In MAAS, this template is called a layout, and MAAS applies it to a machine during commissioning.  Once a layout is applied, a regular user can make modifications to a machine at the filesystem level to arrive at the machine's final storage configuration.  When a machine is no longer needed, a user can choose from among several disk erasure types before releasing it.

MAAS supports storage configuration for CentOS and RHEL deployments. Support includes RAID, LVM, and custom partitioning with different file systems (ZFS and bcache excluded). This support requires a newer version of Curtin, [available as a PPA](https://launchpad.net/ubuntu/+source/curtin)`↗`.

<a href="#heading--about-uefi-booting"><h4 id="heading--about-uefi-booting">About UEFI booting</h4></a>

Every layout type supports a machine booting with UEFI. In such a case, MAAS automatically creates an EFI boot partition (`/boot/efi`). Other than setting the machine to boot from UEFI, the user does not need to take any additional action.

[note]
UEFI must be enabled or disabled for the lifespan of the machine. For example, do not enlist a machine with UEFI enabled, and then disable it before commissioning. It won't work!
[/note]

The EFI partition, if created, will be the first partition (`sda1`) and will have a FAT32 filesystem with a size of 512 MB.

<a href="#heading--about-block-devices"><h4 id="heading--about-block-devices">About block devices</h4></a>

Once the initial storage layout has been configured on a machine, you can perform many operations to view and adjust the entire storage layout for the machine. In MAAS there are two different types of block devices.

**Physical**

A physical block device is a physically attached block device such as a 100GB hard drive connected to a server.

**Virtual**

A virtual block device is a block device that is exposed by the Linux kernel when an operation is performed. Almost all the operations on a physical block device can be performed on a virtual block device, such as a RAID device exposed as md0.

<a href="#heading--about-partitions"><h4 id="heading--about-partitions">About partitions</h4></a>

As with block devices (see [Block devices](#heading--about-block-devices)), MAAS and the MAAS API offer a great deal of control over the creation, formatting, mounting and deletion of partitions.

<a href="#heading--about-storage-restrictions"><h4 id="heading--about-storage-restrictions">About storage restrictions</h4></a>

There are three restrictions for the storage configuration:

1.   An EFI partition is required to be on the boot disk for UEFI.
2.   You cannot place partitions on logical volumes.
3.   You cannot use a logical volume as a Bcache backing device.

Violating these restrictions will prevent a successful deployment.

<a href="#heading--about-vmfs-datastores"><h4 id="heading--about-vmfs-datastores">About VMFS datastores</h4></a>

MAAS can configure custom local VMware VMFS Datastore layouts to maximise the usage of your local disks when deploying VMware ESXi. As VMware ESXi requires specific partitions for operating system usage, you must first apply the VMFS6 storage layout. This layout creates a VMFS Datastore named `datastore1` which uses the disk space left over on the boot disk after MAAS creates the operating system partitions.

<a href="#heading--final-storage-modifications"><h4 id="heading--final-storage-modifications">About final storage modifications</h4></a>

Once MAAS provisions a machine with block devices, via a layout or administrator customisation, a regular user can modify the resulting storage configuration at the filesystem level.

<a href="#heading--about-disk-erasure"><h4 id="heading--about-disk-erasure">About disk erasure</h4></a>

Disk erasure pertains to the erasing of data on each of a machine's disks when the machine has been released (see [Release action](/t/maas-glossary/5416#heading--release)) back into the pool of available machines. The user can choose from among three erasure types before confirming the Release action. A default erasure configuration can also be set.

<a href="#heading--about-disk-erasure-types"><h4 id="heading--about-disk-erasure-types">About disk erasure types</h4></a>

The three disk erasure types are:

1.   Standard erasure - Overwrites all data with zeros.
2.   Secure erasure - Although effectively equivalent to Standard erase, Secure erase is much faster because the disk's firmware performs the operation. Because of this, however, some disks may not be able to perform this erasure type (SCSI, SAS, and FC disks in particular).
3.   Quick erasure - Same as Standard erase but only targets the first 1 MB and the last 1 MB of each disk. This removes the partition tables and/or superblock from the disk, making data recovery difficult but not impossible.

If all three options are checked when the machine is released, the following order of preference is applied:

1.  Use 'secure erase' if the disk supports it
2.  If it does not, then use 'quick erase'

It is very important to pay close attention to your selections when erasing disks.

<a href="#heading--about-pre-seeding"><h3 id="heading--about-pre-seeding">About pre-seeding</h3></a>

During machine [enlistment](/t/how-to-deploy-physical-machines/6193), [deployment](/t/how-to-put-machines-to-work/5112), commissioning and machine installation, MAAS sends [Tempita-derived](https://raw.githubusercontent.com/ravenac95/tempita/master/docs/index.txt)`↗` configuration files to the [cloud-init](https://launchpad.net/cloud-init)`↗` process running on the target machine. MAAS refers to this process as **preseeding**. These preseed files are used to configure a machine's ephemeral and installation environments and can be modified or augmented to a custom machine configuration.

Preseeding in MAAS can be achieved in two ways:

1.  [Curtin](https://launchpad.net/curtin)`↗`, a preseeding system similar to Kickstart or d-i (Debian Installer), applies customisation during operating system (OS) image installation. MAAS performs these changes on deployment, during OS installation, but before the machine reboots into the installed OS. Curtin customisations are perfect for administrators who want their deployments to have identical setups all the time, every time. [This blog post](https://blog.ubuntu.com/2017/06/02/customising-maas-installs)`↗` contains an excellent high-level overview of custom MAAS installs using Curtin.

2.  [Cloud-init](https://launchpad.net/cloud-init)`↗`, a system for setting up machines immediately after instantiation. cloud-init applies customisations after the first boot, when MAAS changes a machine's status to 'Deployed.' Customisations are per-instance, meaning that user-supplied scripts must be re-specified on redeployment. Cloud-init customisations are the best way for MAAS users to customise their deployments, similar to how the various cloud services prepare VMs when launching instances.

<a href="#heading--templates"><h3 id="heading--templates">About templates</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap"]
The [Tempita](https://raw.githubusercontent.com/ravenac95/tempita/master/docs/index.txt)`↗` template files are found in the `/var/snap/maas/current/preseeds/` directory on the region controller. Each template uses a filename prefix that corresponds to a particular phase of MAAS machine deployment:
[/tab]
[tab version="v3.3 Packages,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages"]
The [Tempita](https://raw.githubusercontent.com/ravenac95/tempita/master/docs/index.txt)`↗` template files are found in the `/etc/maas/preseeds/` directory on the region controller. Each template uses a filename prefix that corresponds to a particular phase of MAAS machine deployment:
[/tab]
[/tabs]


|       Phase       |                 Filename prefix                 |
|:-----------------|:-----------------------------------------------|
| Enlistment  |                      enlist                     |
| Commissioning |                  commissioning                  |
| Installation | curtin ([Curtin](https://launchpad.net/curtin))`↗` |

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

<a href="#heading--about-ubuntu-kernels"><h3 id="heading--about-ubuntu-kernels">About Ubuntu kernels</h3></a>

MAAS supports four types of kernels for its Ubuntu machines:

- General availability kernels
- Hardware enablement kernels
- Hardware enablement kernels (pre-release)
- Low latency kernels

<a href="#heading--general-availability-kernels"><h3 id="heading--general-availability-kernels">About general availability kernels</h3></a>

The *general availability* (GA) kernel is based on the *generic* kernel that ships with a new Ubuntu version. Subsequent fixes are applied regularly by the 'stable' *stream* used when setting up the global image source for MAAS.

MAAS denotes a GA kernel like this:

`ga-<version>`: The GA kernel reflects the major kernel version of the shipped Ubuntu release. For example, 'ga-16.04' is based on the 'generic' 4.4 Ubuntu kernel. As per Ubuntu policy, a GA kernel will never have its major version upgraded until the underlying release is upgraded.

<a href="#heading--hardware-enablement-kernels"><h3 id="heading--hardware-enablement-kernels">About hardware enablement kernels</h3></a>

New hardware gets released all the time. If an Ubuntu host runs an older kernel, it's unlikely that MAAS can support the hardware. Canonical does make every effort to back-port more recent kernels enabling more hardware. The acronym HWE stands for "Hardware Enablement."

You also gain kernel improvements and new features when installing an HWE kernel.

[note]
There is the notion of an HWE *stack*, which refers to the window manager and kernel when the Ubuntu host is running a desktop environment. HWE stacks do not apply to MAAS since machines are provisioned strictly as non-graphical servers.
[/note]

Note that these back-ported/HWE kernels are only available for LTS releases (e.g. Trusty, Xenial, etc.). For example, the first available HWE kernel for Ubuntu 16.04 LTS (Xenial) will be the GA kernel from Ubuntu 16.10 (Yakkety).

Before MAAS 2.1 on Xenial, HWE kernels are referred to by the notation `hwe-<release letter>`. So, to install the Yakkety HWE kernel on Xenial, the `hwe-y` kernel is used. By default, when using the web UI, MAAS imports all available HWE kernels along with its generic boot images. So if you are importing Trusty images, then the following HWE kernels are included: `hwe-u`, `hwe-v`, `hwe-w`, `hwe-x` (presuming the Xenial HWE kernel is available).

In MAAS 2.1, starting with Xenial kernels, the notation has changed. The following is used to refer to the latest HWE kernel available for Xenial: `hwe-16.04`.

See [LTS Enablement Stack](https://wiki.ubuntu.com/Kernel/LTSEnablementStack)`↗` (Ubuntu wiki) for the latest information on HWE.

<a href="#heading--hardware-enablement-kernels-pre-release"><h3 id="heading--hardware-enablement-kernels-pre-release">About pre-release hardware enablement kernels</h3></a>

The pre-release HWE kernel is known as the *edge* HWE kernel.

MAAS denotes the edge kernel like this: `hwe-<version>-edge`.

So 'hwe-16.04' is considered older than 'hwe-16.04-edge'.

See [Rolling LTS Enablement Stack](https://wiki.ubuntu.com/Kernel/RollingLTSEnablementStack#hwe-16.04-edge) (Ubuntu wiki)`↗` for more information.

<a href="#heading--low-latency-kernels"><h3 id="heading--low-latency-kernels">About low latency kernels</h3></a>

The low-latency kernel is based on the GA kernel, but uses a more aggressive configuration to reduce latency. It is categorised as a soft real-time kernel. For more information, see [Criteria for real-time computing](https://en.wikipedia.org/wiki/Real-time_computing#Criteria_for_real-time_computing)`↗` (Wikipedia).

MAAS denotes a low latency kernel in three ways:

1.   `hwe-x-lowlatency`: the Xenial low latency HWE kernel for Trusty
2.   `ga-16.04-lowlatency`: the low latency GA kernel for Xenial
3.   `hwe-16.04-lowlatency`: the low latency HWE kernel for Xenial

<a href="#heading--using-kernels"><h3 id="heading--using-kernels">About choosing a kernel</h3></a>

The kernel installed on a machine during deployment is, by default, the Ubuntu release's native kernel (GA). However, it is possible to tell MAAS to use a different kernel. Via the Web UI, MAAS can help you choose one of these kernels.  There are three different contexts for your choice:

1.   globally (default minimum enlistment and commissioning kernel)
2.   per machine (minimum deploy kernel)
3.   per machine during deployment (specific deploy kernel)

<a href="#heading--about-kernel-boot-options"><h3 id="heading--about-kernel-boot-options">About kernel boot options</h3></a>

MAAS can specify kernel boot options to machines on both a global basis (UI and CLI) and a per-machine basis (CLI-only). A full catalogue of available options can be found in the [Linux kernel parameters list](https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html)`↗` at [kernel.org](https://www.kernel.org)`↗`.

<a href="#heading--about-resource-pools"><h3 id="heading--about-resource-pools">About resource pools</h3></a>

Resource pools allow administrators to logically group resources -- machines and VM hosts -- into pools. Pools can help you budget machines for a particular set of functions.  For example, if you're using MAAS to manage a hospital data centre, you may want to keep a certain number of machines reserved for provider use, whether that be for the charts, documentation, or orders application.  You can use resource pools to reserve those machines, regardless of which of the three applications you end up loading onto a particular machine at any given time. 

Administrators can manage resource pools on the Machines page in the web UI, under the Resource pools tab, or with the MAAS CLI.   Also note that all MAAS installations have a resource pool named "default." MAAS automatically adds new machines to the default resource pool.

<a href="#heading--about-customising-deployed-machines"><h2 id="heading--about-customising-deployed-machines">About customising deployed machines</h2></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages"]
MAAS 3.2 provides the capability to customise deployed machines, in that you can update hardware for a running machine on-the-fly.  Specifically, MAAS will update a deployed machine’s data when you do any of the following things:

- add or remove disks
- add or remove network interfaces
- add or remove PCI devices
- add or remove USB devices

You can find the [procedure here](/t/how-to-customise-machines/5108#heading--how-to-enable-hardware-sync-on-a-machine).

While deploying a machine, you can configure that machine to periodically sync its [hardware configuration](#heading--about-hardware-sync).  Deployed machines will also  passively update changes to the BMC and tags for that machine, as these changes are made.

<a href="#heading--about-updating-hardware"><h3 id="heading--about-about-updating-hardware">About updating hardware</h3></a>

Updating hardware on a deployed machine works by installing a special binary on the deployed machine.   This binary is configured at a given interval and push hardware info to the MAAS metadata endpoint.  By setting “enable_hw_sync” to true on a machine prior to deployment, MAAS will add configuration to install a systemd service and timer that will download the hardware sync binary.  This binary then authenticates the machine, reads the hardware info from the machine and pushes it to MAAS. The interval is set globally in the MAAS settings.

Any changes in hardware are written to the machine’s configuration.  Physical hardware changes will be preserved upon release, while virtual changes, such as a SR-IOV interface, will be dropped.

When deploying a machine from the UI, there is a new “enable_hw_sync” flag available for each machine. This flag marks a machine to be configured with live hardware updates.

When deploying from the CLI, there is an additional `enable_hw_sync` flag on `maas $PROFILE machine deploy`. This flag also marks a machine to be configured with live hardware updates. 

When using the API, there are two additional fields in the request:

- enable_hw_sync: (Boolean) - indicating whether hardware sync should be enabled on the machine, 
- sync_interval: (Int) - indicating the interval, in seconds, that should be set at time of deployment

With respect to `machine.read`, both the RESTful API and Websocket API add the following fields to a response:

- enable_hw_sync: Bool indicating whether hardware sync is enabled on the machine, 
- last_sync: Timestamp of the last time MAAS received hardware sync data for the machine,
- next_sync: Timestamp of the computed estimation of when the next sync should happen,
- sync_interval:  Int the interval, in seconds, that was set at time of deployment
- is_sync_healthy: Bool indicating the sync is working normally when true, false when a sync is late or missing,

With respect to `config.list`, there is a new WebSocket Response result (new “hardware_sync_interval” option):

```nohighlight
[{
   name: "hardware_sync_interval",
   value: String in systemd time span format  e.g. “15m”
	        (only hours, minutes and seconds are recognised)
},…]

 -  hardware_sync_interval is set to `15m` by default
config.update
WebSocket Request params - new “hardware_sync_interval” param

params: {
  name: "hardware_sync_interval",
  value: String in systemd time span format, e.g. “15m”
 }
```

[note]
The API does not throw errors when an invalid string is provided for these parameters.
[/note]

<a href="#heading--about-hardware-sync"><h3 id="heading--about-hardware-sync">About hardware sync</h3></a>

Hardware sync updates the machine’s blockdevice, interface and device sets.  BMC configuration and tags can also be updated on the machine itself. The timestamps of the last sync and the next scheduled sync can be seen in the machine's data.

[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
[note]
The capability to customise deployed machines is available starting with MAAS version 3.2.
[/note]
[/tab]
[/tabs]