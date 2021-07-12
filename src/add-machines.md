
There are two ways to add a machine to MAAS:

1. If you place the machine on a connected network, and the machine is configured to netboot, MAAS will automatically enlist it.
2. If you add a machine manually, MAAS will automatically commission it.

This article will explain more about both methods.

#### Questions you may have:

1. [How does enlistment work?](#heading--enlistment)
2. [How do VM host nodes work?](/t/vm-hosting/nnnn)
3. [How do I add virtual machines?](/t/adding-a-vm-host/nnnn)
4. [How do I add a machine manually?](#heading--add-a-node-manually)
5. [How do I add a machine via a chassis?](#heading--add-nodes-via-a-chassis)

MAAS typically adds a machine via a combination of DHCP, TFTP, and PXE. By now, you should have enabled MAAS to automatically add devices and machines to your environment. This unattended method of adding machines is called enlistment.

[note]
Configuring a computer to boot over PXE is done via its BIOS, often referred to as "netboot" or "network boot".
[/note]

Regardless of how MAAS adds a machine, there are no special requirements for the underlying machine. In particular, there is no need to install an operating system on it.

Once MAAS is working to the point of adding machines, you'll probably want to understand statuses and actions. See [Node statuses](/t/concepts-and-terms/785#heading--node-statuses) and [Machine actions](/t/concepts-and-terms/785#heading--machine-actions) respectively.

<a href="#heading--enlistment"><h2 id="heading--enlistment">How enlistment works</h2></a>

When MAAS enlists a machine, it first contacts the DHCP server, so that the machine can be assigned an IP address.  An IP address is necessary to download a kernel and initrd via TFTP, since these functions can't accept domain names.  Once the machine has a bootable kernel, MAAS boots it:

<a href="https://discourse.maas.io/uploads/default/original/1X/76f7113545e6950fec60bdeac06cfaf79b14b3ff.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/76f7113545e6950fec60bdeac06cfaf79b14b3ff.jpeg"></a> 

Next, initrd mounts a Squashfs image, ephemerally via HTTP, so that cloud-init can execute:

<a href="https://discourse.maas.io/uploads/default/original/1X/500f9bd2d070790a4007085705035366bee88a4a.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/500f9bd2d070790a4007085705035366bee88a4a.jpeg"></a> 

Finally, cloud-init runs enlistment and setup scripts:

<a href="https://discourse.maas.io/uploads/default/original/1X/bd87f78c8ee668a22640bf15607c9e3e532d46bb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/bd87f78c8ee668a22640bf15607c9e3e532d46bb.jpeg"></a> 

The enlistment scripts send information about the machine to the region API server, including the architecture, MAC address and other details.  The API server, in turn, stores these details in the database. This information-gathering process is known as [automatic discovery or network discovery](/t/network-discovery/nnnn).

After the enlistment process, MAAS places the machine in the 'Ready' state.  'Ready' is a holding state for machines that are enlisted (or commissioned), waiting to be deployed when needed.

Typically, the next step will be to [commission the machine](/t/commission-machines/nnnn). As an alternative to enlistment, an administrator can add a machine manually (see [below](#heading--add-a-node-manually)). Typically this is done when enlistment doesn't work for some reason. Note that when you manually add a machine, MAAS automatically commissions the machine as soon as you've added it.

[note]
MAAS runs built-in commissioning scripts during the enlistment phase. When you commission a machine, any customised commissioning scripts you add will have access to data collected during enlistment. Follow the link above for more information about commissioning and commission scripts.
[/note]

<a href="#heading--add-a-node-manually"><h2 id="heading--add-a-node-manually">Add a machine manually</h2></a>

Enlistment can be done manually if the hardware specifications of the underlying machine are known.

rad-begin   /deb/2.9/ui /snap/2.9/ui /snap/3.0/ui /deb/3.0/ui 
On the 'Machines' page of the web UI, click the 'Add hardware' button and then select 'Machine'.

Fill in the form and hit 'Save machine'. In this example, you are adding an IPMI machine:

<a href="https://discourse.maas.io/uploads/default/original/1X/faebe2fb37cd73252eaf9521ed1bcf31fb0e76f6.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/faebe2fb37cd73252eaf9521ed1bcf31fb0e76f6.jpeg"></a>

The fields on the "Add machine" screen include the following items:

* **Machine name**: This field is used to identify the machine to the user.  It can be set to anything, though it is often set to the MAC address of the machine in question.  This field is optional, in that MAAS will assign a unique, nonsense name if you leave it blank.  You can change this nonsense name later, if desired.

* **Domain**: This field sets the domain name of the domain managed by MAAS.  It can be set to anything; MAAS assigns the domain name "maas" by default.

* **Architecture**: This field refers to the architecture of the machine being added.

* **Minimum Kernel**: This field supplies a drop-down of possible kernels available for deployment on this machine.

* **Zone**: This field allows you to set the availability zone, selected from AZs that you have already created (if any).

* **Resource pool**: This field allows you to set the resource pool for this machine, selected from pools you have already created (if any).

* **MAC Address**: You should fill in this field with the MAC address of the machine you are adding.  Note that the MAC address entered here must use a colon (":") separator, although some MAC addresses are written with dash ("-") separators.

* **Power type**: You must select the power type supported by the machine you are adding, and fill in additional required fields that appear.  See [Power management](/t/power-management/nnnn) for details on the available power types and the relevant parameters for each type.
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
At the command line, enter the following information:

```
stormrider@wintermute:~$ maas admin machines create \
> architecture=$ARCH \
> max_addresses=$MAC_ADDRESS \
> power_type=$POWER_TYPE \
> power_parameters_power_id=$POWER_ID \
> power_parameters_power_address=$POWER_ADDRESS \
> power_parameters_power_pass=$POWER_PASSWORD
```

When you enter the command (substituting the `$...` parameters for your own particulars), the screen will pause for a moment, and then return a stream of JSON relating to the added machine.

Here's an example with a local laptop MAAS install, using KVMs as virtual machines:

```
stormrider@wintermute:~$ maas admin machines create \
> architecture=amd64 \
> max_addresses=52:54:00:6f:b4:af \
> power_type=virsh \
> power_parameters_power_id=50f6cca2-5d89-43b9-941c-90c9fcd7c156 \
> power_parameters_power_address=qemu+ssh://stormrider@192.168.123.1/system \
> power_parameters_power_pass=xxxxxxx
```

The variable fields in the `machines create` command (the `$...` items) are as follows, in this example: 

```
> architecture=$ARCH \
> mac_addresses=$MAC_ADDRESS \
> power_type=$POWER_TYPE \
> power_parameters_power_id=$POWER_ID \
> power_parameters_power_address=$POWER_ADDRESS \
> power_parameters_power_pass=$POWER_PASSWORD
```

* `$ARCH`: This field refers to the architecture of the machine being added, `amd64` in the local laptop example.

* `$MAC_ADDRESS`: This is the MAC address of the boot-enabled NIC for the machine being added.  Note that the MAC address entered here must use a colon (":") separator, although some MAC addresses are written with dash ("-") separators.

* `$POWER_TYPE`: You must select the power type supported by the machine you are adding, and fill in additional required fields that appear.  See [Power management](/t/power-management/nnnn) for details on the available power types and the relevant parameters for each type. In this example, we've used a "virsh" power type (a libvirt KVM), but your choice will depend on your hardware.

* `$POWER_ID`: This is generally the UUID of the machine being added.

* `$POWER_ADDRESS/$POWER_PASSWORD`: In the case of a KVM, these are the only parameters that need to be entered.  See [Power types](https://maas.io/docs/api#power-types) in the API reference for details on the available power types and the relevant parameters for each type.
rad-end

Normally, when you add a machine manually, MAAS will immediately attempt to commission the machine. Note that you will need to configure the underlying machine to boot over the network, or commissioning will fail. MAAS cannot handle this configuration for you.  While the correct method for configuring network boot depends heavily on your server, there are two common elements:

1. The network card on your server must be able to support PXE, i.e., your NIC -- whether independent or integrated on a motherboard -- must have a boot PROM that supports network booting.  You'll need to consult the documentation for the machine in question to determine this.

2. You usually have to interrupt the boot process and enter the BIOS/UEFI menu to configure the network card's PXE stack.  Again, you may need to consult your machine's documentation to pin down this step.

Additional steps will vary widely by machine type and architecture.

<a href="#heading--bmc-enlistment"><h3 id="heading--bmc-enlistment">BMC enlistment</h3></a>

[note status="2.4"]
Note that in MAAS versions before 2.5, you are required to provide the MAC address of the PXE interface when adding a new machine manually.
[/note]

##### IPMI machines

For IPMI machines, you only need to provide IPMI credentials. MAAS automatically discovers the machine and runs enlistment configuration by matching the BMC address.

##### Non-IPMI machines

For non-IPMI machines, you must specify a non-PXE MAC address. MAAS automatically discovers the machine and runs enlistment configuration by matching the non-PXE MAC address.

<a href="#heading--add-nodes-via-a-chassis"><h2 id="heading--add-nodes-via-a-chassis">Add a machine via a chassis</h2></a>

Use the chassis feature to add multiple machines at once. This feature can only be done via the MAAS UI.

To do this, instead of selecting 'Machine' as above, choose 'Chassis' from the drop-down menu. In the following example, MAAS will add all available VMs from the given  virsh address:

<a href="https://discourse.maas.io/uploads/default/original/1X/e7f88bce68318cf3c6a8e97b4d31d0b6980e0f32.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e7f88bce68318cf3c6a8e97b4d31d0b6980e0f32.jpeg"></a>

The required fields will change based on the type of chassis you choose.

[note]
As with the manual method, the underlying machines will require netbooting.
[/note]

rad-begin /snap/3.0/ui /snap/3.0/cli

<a href="#heading--disable-individual-boot-methods"><h2 id="heading--disable-individual-boot-methods">How do I disable individual boot methods?</h2></a>

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

