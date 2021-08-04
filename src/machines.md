Machines are the heart of MAAS. They are the backbone of your data centre application(s), providing the functions that are relevant to your customers. MAAS manages their transit through a life-cycle, from adding and enlistment, through commissioning, allocation, and deployment, finally being released back to the pool, or retired altogether.  You can move them around, create redundant versions (even in other geographies you can access), and basically rearrange them to the extent that your network allows.

<a href="#heading--about-the-machine-life-cycle"><h2 id="heading--about-the-machine-life-cycle">About the machine life-cycle</h2></a>

One of the most important things to understand about machines is their life-cycle.  Machines can be discovered or added, commissioned by MAAS, acquired, deployed, released, marked broken, tested, put into rescue mode, and deleted.  In addition, pools, zones, and tags can be set for machines.

All of these states and actions represent the possible life-cycle of a machine.  This life-cycle isn't strict or linear -- it depends on how you use a machine -- but it's useful to give a general overview of how machines tend to change states.  In the discussion that follows, states and actions are shown in **bold** type.

1. Machines start as servers in your environment, attached to a network or subnet MAAS can manage.

2. If machines are configured to netboot, MAAS can **discover** them and present them to you for possible commissioning, changing their state to **New**.

3. When you select a machine that is marked **New**, you can choose to **commission** it.  If you add a machine manually, it is automatically **commissioned**.

4. Machines that have successfully commissioned can be **acquired** and **deployed**.  Machines that don't successfully commission can be **marked broken** (and later recovered when the issues are resolved).

5. Resolving problems with machines usually involve **testing** the machine.

6. Once you've deployed a machine, and you're done with it, you can **release** it.

7. You can place a machine in **rescue mode**, which allows you to SSH to a machine to make configuration changes or do other maintenance. Once you're done, you can **exit rescue mode***.

8. Any time a machine is on, you have the option to select it and **power off** that machine.

9. You can **abort** any operation that's in progress.

10. You also have the option to set tags, availability zone, or resource pool at various stages along the way.

Since these actions are not necessarily sequential, and the available actions change as the machine state changes, it's not very useful to make a state diagram or flowchart.  Instead, consider the following table:

| Action/State | New | Ready | Acquired | Deployed | Locked | Rescue | Broken |
|:-------------|:---:|:-----:|:--------:|:--------:|:------:|:------:|:------:|	
| Commission   | X   | X     |          |          |        |        |   X    |
| Acquire      |     | X     |          |          |        |        |        |
| Deploy       |     | X     |   X      |          |        |        |        |
| Release      |     |       |   X      |    X     |        |        |        |
| Power on     |     |       |          |    X     |        |        |   X    |
| Power off    |     |       |          |          |        |        |        |
| Test         | X   | X     |   X      |    X     |        |        |   X    |
| Rescue mode  | X   | X     |   X      |    X     |        |        |   X    |
| Exit rescue  |     |       |          |          |        |   X    |        |
| Mark broken  |     |       |   X      |    X     |        |        |        |
| Mark fixed   |     |       |          |          |        |        |   X    |
| Lock         |     |       |          |    X     |        |        |        |
| Unlock       |     |       |          |          |   X    |        |        |
| Tag          | X   | X     |   X      |    X     |        |   X    |   X    |
| Set zone     | X   | X     |   X      |    X     |        |   X    |   X    |
| Set...pool   | X   | X     |   X      |    X     |        |   X    |   X    |
| Delete       | X   | X     |   X      |    X     |        |   X    |   X    |

When a machine is in the state listed in a column, it is possible to take the row actions marked with an "X."  You access these actions from the "Take action" menu in the upper right corner of the machine listing.  Note that some actions, such as "Mark broken" or "Lock," may be hidden when they are not available.

For a better understanding of these states and actions, see [Node statuses](/t/concepts-and-terms/785#heading--node-statuses) and [Machine actions](/t/concepts-and-terms/785#heading--machine-actions).

<a href="#heading--about-adding-machines"><h3 id="heading--about-adding-machines">About adding machines</h3></a>

To be crystal clear, there are two ways to add a machine to MAAS:

1. If you place the machine on a connected network, and the machine is configured to netboot, MAAS will automatically enlist it. 

2. If you add a machine manually, MAAS will automatically commission it.  There are also ways to turn off this automatic commissioning, should you desire to do so.

MAAS typically adds a machine via a combination of DHCP, TFTP, and PXE. By now, you should have enabled MAAS to automatically add devices and machines to your environment. This unattended method of adding machines is called enlistment.

Configuring a computer to boot over PXE is done via its BIOS, often referred to as "netboot" or "network boot". Normally, when you add a machine manually, MAAS will immediately attempt to commission the machine. Note that you will need to configure the underlying machine to netboot, or commissioning will fail. MAAS cannot handle this configuration for you.  While the correct method for configuring network boot depends heavily on your server, there are two common elements:

1. The network card on your server must be able to support PXE, i.e., your NIC -- whether independent or integrated on a motherboard -- must have a boot PROM that supports network booting.  You'll need to consult the documentation for the machine in question to determine this. Note that in MAAS versions before 2.5, you are required to provide the MAC address of the PXE interface when adding a new machine manually.

2. You usually have to interrupt the boot process and enter the BIOS/UEFI menu to configure the network card's PXE stack.  Again, you may need to consult your machine's documentation to pin down this step.

Additional steps will vary widely by machine type and architecture.

Regardless of how MAAS adds a machine, there are no special requirements for the underlying machine itself, other than being able to netboot. In particular, there is no need to install an operating system on it.

<a href="#heading--about-enlistment"><h3 id="heading--about-enlistment">About enlistment</h3></a>

MAAS is built to manage machines, including the operating systems on those machines. Enlistment and commissioning are features that make it easier to start managing a machine -- as long as that machine has been configured to netboot. Enlistment enables users to simply connect a machine, configure the firmware properly, and power it on so that MAAS can find it and add it.

Enlistment happens when MAAS starts; it reaches out on connected subnets to locate any nodes -- that is, devices and machines -- that reside on those subnets. MAAS finds a machine that's configured to netboot (e.g., via PXE), boots that machine into Ubuntu, and then sends cloud-init user data which runs standard (i.e., built-in) commissioning scripts. The machine actually adds itself over the MAAS API, and then requests permission to send commissioning data.

Since MAAS doesn't know whether you might intend to actually include these discovered machines in your cloud configuration, it won't automatically take them over, but it will read them to get an idea how they're set up. MAAS then presents these machines to you with a MAAS state of "New." This allows you to examine them and decide whether or not you want MAAS to manage them.

When you configure a machine to netboot -- and turn it on while connected to the network -- MAAS will enlist it, giving it a status of "New."  You can also [add a machine manually](/t/add-machines/nnnn)).  In either case, the next step is *commissioning*, which boots the machine into an ephemeral Ubuntu kernel so that resource information can be gathered.  You can also run [custom commissioning scripts](/t/commissioning-and-hardware-testing-scripts/nnnn) to meet your specific needs.

<a href="#heading--about-the-enlistment-process"><h4 id="heading--about-the-enlistment-process">About the enlistment process</h4></a>

When MAAS enlists a machine, it first contacts the DHCP server, so that the machine can be assigned an IP address.  An IP address is necessary to download a kernel and initrd via TFTP, since these functions can't accept domain names.  Once the machine has a bootable kernel, MAAS boots it:

<a href="https://discourse.maas.io/uploads/default/original/1X/76f7113545e6950fec60bdeac06cfaf79b14b3ff.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/76f7113545e6950fec60bdeac06cfaf79b14b3ff.jpeg"></a> 

Next, initrd mounts a Squashfs image, ephemerally via HTTP, so that cloud-init can execute:

<a href="https://discourse.maas.io/uploads/default/original/1X/500f9bd2d070790a4007085705035366bee88a4a.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/500f9bd2d070790a4007085705035366bee88a4a.jpeg"></a> 

Finally, cloud-init runs enlistment and setup scripts:

<a href="https://discourse.maas.io/uploads/default/original/1X/bd87f78c8ee668a22640bf15607c9e3e532d46bb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/bd87f78c8ee668a22640bf15607c9e3e532d46bb.jpeg"></a> 

The enlistment scripts send information about the machine to the region API server, including the architecture, MAC address and other details.  The API server, in turn, stores these details in the database. This information-gathering process is known as [automatic discovery or network discovery](/t/network-discovery/nnnn).

After the enlistment process, MAAS places the machine in the 'Ready' state.  'Ready' is a holding state for machines that are enlisted (or commissioned), waiting to be deployed when needed.

Typically, the next step will be to commission the machine. As an alternative to enlistment, an administrator can add a machine manually (see [below](#heading--add-a-node-manually)). Typically this is done when enlistment doesn't work for some reason. Note that when you manually add a machine, MAAS automatically commissions the machine as soon as you've added it.

[note]
MAAS runs built-in commissioning scripts during the enlistment phase. When you commission a machine, any customised commissioning scripts you add will have access to data collected during enlistment. Follow the link above for more information about commissioning and commission scripts.
[/note]

<a href="#heading--about-bmc-enlistment"><h4 id="heading--about-bmc-enlistment">About BMC enlistment</h4></a>

For IPMI machines, you only need to provide IPMI credentials. MAAS automatically discovers the machine and runs enlistment configuration by matching the BMC address.  For non-IPMI machines, you must specify a non-PXE MAC address. MAAS automatically discovers the machine and runs enlistment configuration by matching the non-PXE MAC address.

<a href="#heading--about-commissioning-machines"><h3 id="heading--about-commissioning-machines">About commissioning machines</h3></a>

When MAAS commissions a machine, the following sequence of events takes place:

1.  DHCP server is contacted
2.  kernel and initrd are received over TFTP
3.  machine boots
4.  initrd mounts a Squashfs image ephemerally over HTTP
5.  cloud-init runs built-in and [custom commissioning scripts](/t/commissioning-and-hardware-testing-scripts/nnnn)
6.  machine shuts down

The commissioning scripts will talk to the region API server to ensure that everything is in order and that eventual deployment will succeed.

MAAS chooses the latest Ubuntu LTS release as the default image for commissioning.  If desired, you can select a different image in the "Settings" page of the web UI, by selecting the "General" tab and then scrolling down to the Commissioning section.

[note]
Commissioning requires 60 seconds.
[/note]

rad-begin /snap/3.0/ui /snap/3.0/cli /deb/3.0/ui /deb/3.0/cli

<a href="#heading--about-disabling-individual-boot-methods"><h3 id="heading--about-disabling-individual-boot-methods">About disabling individual boot methods</h3></a>

In MAAS 3.0, it is possible to diable individual boot methods.  This must be done via the CLI. When a boot method is disabled MAAS will configure MAAS controlled `isc-dhcpd` to not respond to the associated [boot architecture code](https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml#processor-architecture). External DHCP servers must be configured manually.

To allow different boot methods to be in different states on separate physical networks using the same VLAN ID configuration is done on the subnet in the UI or API. When using the API boot methods to be disabled may be specified using the MAAS internal name or [boot architecture code](https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml#processor-architecture) in octet or hex form. For example the following disabled i386/AMD64 PXE, AMD64 UEFI TFTP, and AMD64 UEFI HTTP

```bash 
maas $PROFILE subnet \
update $SUBNET \
disabled_boot_architectures="0x00 uefi_amd64_tftp 00:10"
```

Specifically, for MAAS 3.0, the following changes have been implemented:

* UEFI AMD64 HTTP(00:10) has been reenabled.
* UEFI ARM64 HTTP(00:13) has been enabled.
* UEFI ARM64 TFTP(00:0B) and UEFI ARM64 HTTP(00:13) will now provide a shim and GRUB signed with the Microsoft boot loader keys.
* grub.cfg for all UEFI platforms has been updated to replace the deprecated `linuxefi` and `initrdefi` commands with the standard `linux` and `initrd` commands.
* GRUB debug may now be enabled by enabling [rackd debug logging](https://discourse.maas.io/t/running-installed-maas-in-debug-logging-mode/168).

rad-end

<a href="#heading--about-the-machine-list"><h2 id="heading--about-the-machine-list">About the machine list</h2></a>

In the illustration below, you see the machine list for a typical small hospital data centre, including servers ready and allocated for functions like Pharmacy, Orders, Charts, and so on:

<a href="https://discourse.maas.io/uploads/default/original/1X/30df04b0bcec5fcf6538590ed795cb0514a64675.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/30df04b0bcec5fcf6538590ed795cb0514a64675.jpeg"></a> 


These example machines would typically be duplicated in several different geographies, with a quick way to switch to a redundant node, should anything go wrong (e.g., high availability).  We used the word node there because, In the network language of MAAS, machines are one of several different types of nodes.  A node is simply a network-connected object or, more specifically, an object that can independently communicate on a network. MAAS nodes include controllers, network devices, and of course, machines.   

Looking back at the example above, you can see that there are several columns in the machine list:

<a href="https://discourse.maas.io/uploads/default/original/1X/e6339dd1439b3b54be7a75f7239d1981754a07f6.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e6339dd1439b3b54be7a75f7239d1981754a07f6.jpeg"></a> 

The columns list eight details for each machine:

1.   **FQDN | MAC**: The fully qualified domain name or the MAC address of the machine.
2.   **Power**: 'On', 'Off' or 'Error' to highlight an error state.
3.   **Status**: The current status of the machine, such as 'Ready', 'Commissioning' or 'Failed testing'.
4.   **Owner**: The MAAS account responsible for the machine.
5.   **Cores**: The number of CPU cores detected on the machine.
6.   **RAM**: The amount of RAM, in GiB, discovered on the machine.
7.   **Disks**: The number of drives detected on the machine.
8.   **Storage**: The amount of storage, in GB, identified on the machine.

You can view the list of machines from the choice "Machines" on the top menu of the MAAS web UI.  This action will display a table like the one above, listing all the machines that are currently visible to your MAAS installation.  During commissioning and deployment, MAAS updates the table to reflect the changing state of each machine. These values are augmented with green, amber and red icons to represent successful, in-progress and failed transitions, respectively. The MAAS web UI employs similar icons and colours throughout the interface to reflect a machine's status. 

<a href="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg"></a> 

Rolling the cursor over status icons often reveals more details. For example, a failed hardware test script will place a warning icon alongside the hardware type tested by the script. Rolling the cursor over this will reveal which test failed.  Likewise, you can find some immediate options by rolling over the column data items in the machines table.

<a href="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg"></a> 

The 'Add hardware' drop-down menu is used to add either new machines or a new chassis. This menu changes context when one or more machines are selected from the table, using either the individual checkboxes in the first column or the column title checkbox to select all.

<a href="https://discourse.maas.io/uploads/default/original/1X/9a0747649e6aff999d3c04335eb752accedaf3de.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/9a0747649e6aff999d3c04335eb752accedaf3de.jpeg"></a> 

With one or more machines selected, the 'Add hardware' drop-down menu moves to the left, and is joined by the 'Take action' menu.  This menu provides access to the various [machine actions](/t/concepts-and-terms/785#node-actions) that can be applied to the selected machine(s):

<a href="https://discourse.maas.io/uploads/default/original/1X/e03d5ac8de9ea4f4827ed057bb2dd83e241aac3b.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e03d5ac8de9ea4f4827ed057bb2dd83e241aac3b.jpeg"></a> 

[note]
The 'Filter by' section limits the machines listed in the table to selected keywords and machine attributes.
[/note]

<a href="#heading--about-the-machine-summary-h3"><h3 id="heading--about-the-machine-summary-h3">About the machine summary</h3></a>

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

The rest of the cards on the Machine summary are either self-explanatory, or they're covered in the sections below.  The main point is this: You can see that nearly everything about machines takes place within the main menu's "Machines" option.  Incidentally, you can learn more about testing by visiting the [Hardware testing](/t/hardware-testing/3942) page.

rad-begin /snap/3.0/ui /snap/3.0/cli /deb/3.0/ui /deb/3.0/cli
<a href="#heading--usb-pci-devices"><h3 id="heading--usb-pci-devices">Handling attached USB and PCI devices</h3></a>

The machines in your MAAS may have devices attached to them via USB or PCI interface, such as keyboards, cameras, network cards, GPUs, etc.  MAAS will recognize these devices and make them visible to you when a machine is commissioned.



For example, the machine details presents USB and PCI devices like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/87f42bafe321d45af94d73216f933a9067f01df2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/87f42bafe321d45af94d73216f933a9067f01df2.png"></a>

Note that this page now includes two new tabs: "PCI devices" and "USB."  For each USB/PCI device attached to your machine, these tabs will list:

* device type
* vendor ID
* a product description
* a product ID
* the driver name
* the containing NUMA node (if any)
* the device address

A typical PCI device tab would look something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/82e1e6f8bc511047ac5f773430f7e5812c7a24d4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/82e1e6f8bc511047ac5f773430f7e5812c7a24d4.png"></a>

The USB tab presents similar information in the same format.

[note]
If you are upgrading from a previous version of MAAS, PCI and USB devices aren't modeled, so you will have to recommission the machine to capture these devices.
[/note]



Once you've commissioned the machine, you have the option of deleting PCI/USB devices from the machine in any machine state, via the CLI only, using the following command:

```
maas $PROFILE node-device delete $SYSTEM_ID $DEVICE_ID
```

where:

* $PROFILE   = your user profile (e.g., "admin")
* $SYSTEM_ID = the ID of the machine in question (e.g., "ngx7ry")
* $DEVICE_ID = the ID of the device you want to delete 

If the device is still present in the system, it will be recogized again (and thus "recreated")
when the machine is commissioned again.
rad-end


<a href="#heading--about-machine-interfaces-h3"><h3 id="heading--about-machine-interfaces-h3">About machine network info</h3></a>

The Network "tab" provides you with a way to view/edit the network and interface configuration for a machine: 

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png"></a> 

In the case of this deployed machine, there are not many editing options.  If the machine is in a 'Ready' state, though, altering the network configuration is possible, as shown in the screenshot above.


Options on this tab are described in the introduction to [Networking](/t/networking/4046) article in this documentation set.




<a href="#heading--machine-storage-h3"><h3 id="heading--machine-storage-h3">About machine storage info</h3></a>

The Storage tab on the machine list brings up a form that allows you to view/edit the file system, partitioning and storage parameters for the selected machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

This tab describes the filesystem(s) in use, as well as the available and used partitions for this machine.  See the article [Storage](/t/storage/4106) for a detailed discussion on how to use this screen, as well as many other considerations for machine storage configurations.


<a href="#heading--commissioning-log-h3"><h3 id="heading--commissioning-log-h3">About machine commissioning logs</h3></a>

The "Commissioning" tab brings up a summary log of commissioning events:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png"></a> 

Click on the dropdown at the end of the row you're interested in, and click on "View details":

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png"></a>

This will bring up a detailed log view for that row:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png"></a>

These logs present an extremely detailed, timestamped record of completion and status items from the commissioning process.  

<a href="#heading--hardware-tests-h3"><h3 id="heading--hardware-tests-h3">About machine hardware & test logs</h3></a>

This tab presents a summary of tests run against this particular machine:  

<a href="See the article on [Logging](/t/maas-logging/4010) for more details on how to read and interpret these logs." target = "_blank"><img src="See the article on [Logging](/t/maas-logging/4010) for more details on how to read and interpret these logs."></a> 

You can view the summary report, or choose the "View details" dropdown to get details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png"></a> 

The format of these screens is very similar to the Configuration logs shown above.  For more information, please see the article on [Hardware testing](/t/hardware-testing/3942).


By choosing "Installation output" on the "Logs" tab, you can see the "raw" log output:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png"></a> 

Help interpreting these logs can be found under the [Logging](/t/maas-logging/4010) section of this documentation.


<a href="#heading--event-logs-h3"><h3 id="heading--event-logs-h3">About machine event logs</h3></a>

To view the Event log for a machine, choose the "Event" tab under "Logs."  This displays a list of timestamped status updates for events and actions performed on the machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png"></a> 




There is a dropdown on the upper right which allows you to choose how many events per page you wish to view. Detailed discussion of this event log can be found under the [Logging](/t/maas-logging/4010) section of this documentation.


<a href="#heading--machine-config-h3"><h3 id="heading--machine-config-h3">About machine configuration info</h3></a>

The final tab from the Machine menu allows you to update machine and power configuration options: 

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png"></a> 

There are two sections to this tab.  The "Machine configuration" section, shown above, offers some general parameters, mostly related to how this machine is grouped and categorised.  More information on these options are found in the relevant sections of the documentation (e.g., tags, resource pools, and so forth). 

The "Power configuration" supplies the parameters necessary for MAAS to access the machine to PXE-boot it: 

<a href="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png"></a> 

More information on Power configuration will be found in the [Power management](/t/power-management/4070) section of this documentation.

<a href="#heading--about-post-commission-configuration"><h2 id="heading--about-post-commission-configuration">About post-commission configuration</h2></a>

Once commissioned, you can configure the machine's network interface(s). Specifically, when a machine's status is either "Ready" or "Broken", interfaces can be added/removed, attached to a fabric and linked to a subnet, and provided an IP assignment mode. Tags can also be assigned to specific network interfaces.

<a href="#heading--about-bond-and-bridge-interfaces"><h2 id="heading--about-bond-and-bridge-interfaces">About bond and bridge interfaces</h2></a>

A bond interface is used to aggregate two or more physical interfaces into a single logical interface. Combining multiple network connections in parallel can increase network throughput beyond what a single NIC will allow.  It also provides some redundancy in case one of the NICs should fail.  More information about the theory behind bonded NICs is found in the [relevant IEEE standard](https://1.ieee802.org/tsn/802-1ax-rev/).

A network bridge may be useful if you intend to put virtual machines or containers on the machine.  You can create a bridge by selecting an interface and clicking the now-active "Create bridge" button. A form will appear that allows you to configure a MAC address, STP, and an appropriate tag.
