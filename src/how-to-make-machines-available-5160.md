<!-- How to make machines available -->
This article explains:

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages" view="UI"]
- [How to create, delete, and configure machines](#heading--how-to-create-delete-and-configure-machines)
- [How to clone machines](#heading--how-to-clone-machines)
- [How to examine machines and machine details](#heading--how-to-examine-machines-and-machine-details)
- [How to use resource pools](#heading--how-to-use-resource-pools)
- [How to use machine storage](#heading--how-to-use-machine-storage)
[/tab]
[tab version="v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
- [How to create, delete, and configure machines](#heading--how-to-create-delete-and-configure-machines)
- [How to examine machines and machine details](#heading--how-to-examine-machines-and-machine-details)
- [How to use resource pools](#heading--how-to-use-resource-pools)
- [How to use machine storage](#heading--how-to-use-machine-storage)
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages" view="CLI"]
- [How to create, delete, and configure machines](#heading--how-to-create-delete-and-configure-machines)
- [How to clone machines](#heading--how-to-clone-machines)
- [How to examine machines and machine details](#heading--how-to-examine-machines-and-machine-details)
- [How to use resource pools](#heading--how-to-use-resource-pools)
- [How to use annotations](#heading--how-to-use-annotations)
- [How to use machine storage](#heading--how-to-use-machine-storage)
[/tab]
[tab version="v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
- [How to create, delete, and configure machines](#heading--how-to-create-delete-and-configure-machines)
- [How to examine machines and machine details](#heading--how-to-examine-machines-and-machine-details)
- [How to use resource pools](#heading--how-to-use-resource-pools)
- [How to use annotations](#heading--how-to-use-annotations)
- [How to use machine storage](#heading--how-to-use-machine-storage)
[/tab]
[/tabs]

This article also provides a [storage layouts reference](#heading--storage-layouts-reference).

Most of the day-to-day work of managing machines is covered here. Utilising machines to do work -- for example, commissioning, testing, and deploying them -- is discussed in [How to deploy machines](/t/how-to-put-machines-to-work/5112).

<a href="#heading--how-to-create-delete-and-configure-machines"><h2 id="heading--how-to-create-delete-and-configure-machines">How to create, delete, and configure machines</h2></a>

This section shows you:

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
- [How to add a machine manually](#heading--how-to-add-a-machine-manually)
- [How to add machines via a chassis](#heading--how-to-add-machines-via-a-chassis)
- [How to manage attached USB and PCI devices](#heading--usb-pci-devices)
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
- [How to add a machine manually](#heading--how-to-add-a-machine-manually)
- [How to add machines via a chassis](#heading--how-to-add-machines-via-a-chassis)
[/tab]
[/tabs]

<a href="#heading--how-to-add-a-machine-manually"><h3 id="heading--how-to-add-a-machine-manually">How to add a machine manually</h3></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages" view="UI"]
To add a machine manually,

1. Select *Machines*.

2. Select *Add hardware > Machine.*

3. Fill in the form and select *Save machine* to register your choice.

4. Alternatively, you can select *Save and add another* to register your choice and repeat the form to add another machine.

The fields on the "Add machine" screen include the following items:

- **Machine name**: This field is used to identify the machine to the user.  It can be set to anything, though it is often set to the MAC address of the machine in question.  This field is optional, in that MAAS will assign a unique, nonsense name if you leave it blank.  You can change this nonsense name later, if desired.

- **Domain**: This field sets the domain name of the domain managed by MAAS.  It can be set to anything; MAAS assigns the domain name "maas" by default.

- **Architecture**: This field refers to the architecture of the machine being added.

- **Minimum Kernel**: This field supplies a drop-down of possible kernels available for deployment on this machine.

- **Zone**: This field allows you to set the availability zone, selected from AZs that you have already created (if any).

- **Resource pool**: This field allows you to set the resource pool for this machine, selected from pools you have already created (if any).

- **MAC Address**: You should fill in this field with the MAC address of the machine you are adding.  Note that the MAC address entered here must use a colon (":") separator, although some MAC addresses are written with dash ("-") separators.

- **Power type**: You must select the power type supported by the machine you are adding, and fill in additional required fields that appear.  See [Power management reference](/t/power-management-reference/5246) for details on the available power types and the relevant parameters for each type.

<a href="#heading--how-to-add-machines-via-a-chassis"><h3 id="heading--how-to-add-machines-via-a-chassis">How to add machines via a chassis</h3></a>

You can use the chassis feature to add multiple machines at once. To do this, instead of selecting *Machine* as above, choose *Chassis* from the drop-down menu.  The required fields will change based on the type of chassis you choose.

[note]
As with the manual method, the underlying machines will require netbooting.
[/note]
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
On the 'Machines' page of the web UI, click the 'Add hardware' button and then select 'Machine'.

Fill in the form and hit 'Save machine'. In this example, you are adding an IPMI machine:

<a href="https://discourse.maas.io/uploads/default/original/1X/faebe2fb37cd73252eaf9521ed1bcf31fb0e76f6.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/faebe2fb37cd73252eaf9521ed1bcf31fb0e76f6.jpeg"></a>

The fields on the "Add machine" screen include the following items:

- **Machine name**: This field is used to identify the machine to the user.  It can be set to anything, though it is often set to the MAC address of the machine in question.  This field is optional, in that MAAS will assign a unique, nonsense name if you leave it blank.  You can change this nonsense name later, if desired.

- **Domain**: This field sets the domain name of the domain managed by MAAS.  It can be set to anything; MAAS assigns the domain name "maas" by default.

- **Architecture**: This field refers to the architecture of the machine being added.

- **Minimum Kernel**: This field supplies a drop-down of possible kernels available for deployment on this machine.

- **Zone**: This field allows you to set the availability zone, selected from AZs that you have already created (if any).

- **Resource pool**: This field allows you to set the resource pool for this machine, selected from pools you have already created (if any).

- **MAC Address**: You should fill in this field with the MAC address of the machine you are adding.  Note that the MAC address entered here must use a colon (":") separator, although some MAC addresses are written with dash ("-") separators.

- **Power type**: You must select the power type supported by the machine you are adding, and fill in additional required fields that appear.  See [Power management reference](/t/power-management-reference/5246) for details on the available power types and the relevant parameters for each type.

<a href="#heading--how-to-add-machines-via-a-chassis"><h3 id="heading--how-to-add-machines-via-a-chassis">How to add machines via a chassis</h3></a>

You can use the chassis feature to add multiple machines at once. To do this, instead of selecting 'Machine' as above, choose 'Chassis' from the drop-down menu. In the following example, MAAS will add all available VMs from the given  virsh address:

<a href="https://discourse.maas.io/uploads/default/original/1X/e7f88bce68318cf3c6a8e97b4d31d0b6980e0f32.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e7f88bce68318cf3c6a8e97b4d31d0b6980e0f32.jpeg"></a>

The required fields will change based on the type of chassis you choose.

[note]
As with the manual method, the underlying machines will require netbooting.
[/note]

[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To create a new machine at the command line, enter the following information:

```nohighlight
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

```nohighlight
stormrider@wintermute:~$ maas admin machines create \
> architecture=amd64 \
> max_addresses=52:54:00:6f:b4:af \
> power_type=virsh \
> power_parameters_power_id=50f6cca2-5d89-43b9-941c-90c9fcd7c156 \
> power_parameters_power_address=qemu+ssh://stormrider@192.168.123.1/system \
> power_parameters_power_pass=xxxxxxx
```

The variable fields in the `machines create` command (the `$...` items) are as follows, in this example: 

```nohighlight
> architecture=$ARCH \
> mac_addresses=$MAC_ADDRESS \
> power_type=$POWER_TYPE \
> power_parameters_power_id=$POWER_ID \
> power_parameters_power_address=$POWER_ADDRESS \
> power_parameters_power_pass=$POWER_PASSWORD
```

- `$ARCH`: This field refers to the architecture of the machine being added, `amd64` in the local laptop example.

- `$MAC_ADDRESS`: This is the MAC address of the boot-enabled NIC for the machine being added.  Note that the MAC address entered here must use a colon (":") separator, although some MAC addresses are written with dash ("-") separators.

- `$POWER_TYPE`: You must select the power type supported by the machine you are adding, and fill in additional required fields that appear.  See [Power management reference](/t/power-management-reference/5246) for details on the available power types and the relevant parameters for each type. In this example, we've used a "virsh" power type (a libvirt KVM), but your choice will depend on your hardware.

- `$POWER_ID`: This is generally the UUID of the machine being added.

- `$POWER_ADDRESS/$POWER_PASSWORD`: In the case of a KVM, these are the only parameters that need to be entered.  See [Power types](https://maas.io/docs/api#power-types)`↗` in the API reference for details on the available power types and the relevant parameters for each type.
[/tab]
[/tabs]

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
<a href="#heading--usb-pci-devices"><h3 id="heading--usb-pci-devices">How to manage attached USB and PCI devices</h3></a>

To delete PCI/USB devices from the machine in any machine state, via the CLI only, using the following command:

```nohighlight
maas $PROFILE node-device delete $SYSTEM_ID $DEVICE_ID
```

where:

- $PROFILE   = your user profile (e.g., "admin")
- $SYSTEM_ID = the ID of the machine in question (e.g., "ngx7ry")
- $DEVICE_ID = the ID of the device you want to delete 

If the device is still present in the system, it will be recognised again (and thus "recreated") when the machine is commissioned again.
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
MAAS version 2.9 does not recognise PCI and USB devices.  Please upgrade to MAAS version 3.0 or greater to obtain this capability.
[/tab]
[/tabs]

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages"]
<a href="#heading--how-to-clone-machines"><h2 id="heading--how-to-clone-machines">How to clone machines</h2></a>

1. Select *Machines*.

2. Checkbox the machine you want to overwrite with a cloned copy of another machine.

3. Select *Actions > Clone from*.

4. *Select the source machine*.

5. *Select what to clone*.

6. Select *Clone to machine*.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages"]
<a href="#heading--how-to-clone-machines"><h2 id="heading--how-to-clone-machines">How to clone machines</h2></a>

Assume you have two machines available, like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/6f662618011e3eb1f8e0bfe85748825db4a6ac25.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/6f662618011e3eb1f8e0bfe85748825db4a6ac25.png"></a>

Select the machine *to which you want to clone configuration*, and select "Clone from..."

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b4e42a59f1d4bc6d63f2cd24d77316eea3aada1b.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b4e42a59f1d4bc6d63f2cd24d77316eea3aada1b.png"></a>

Under "1. Select the source machine" -- choose a machine from the attached list:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/287bbf3db4bbc3253a976ecde8965c341fc1bee3.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/287bbf3db4bbc3253a976ecde8965c341fc1bee3.png"></a>

Under "2. Select what to clone", choose "Network", "Storage", or both (here, we've chosen "Storage"):

<a href="https://discourse.maas.io/uploads/default/original/2X/6/622afe3c0bcd4775ef4c19460cf0f1f480c11efb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/622afe3c0bcd4775ef4c19460cf0f1f480c11efb.png"></a>

Click "Clone to machine". MAAS will report the status of the attempt.

[/tab]
[tab version="v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
Cloning capability is available in MAAS from version 3.1 forward.
[/tab]
[/tabs]

<a href="#heading--how-to-examine-machines-and-machine-details"><h2 id="heading--how-to-examine-machines-and-machine-details">How to examine machines and machine details</h2></a>

This section describes the various ways you can evaluate the health and status of your MAAS machines, using the machine list.  It will show you:

- [How to view the machine list](#heading--how-to-view-the-machine-list)
- [How to view machine details](#heading--how-to-view-machine-details)
- [How to find network info for a machine](#heading--machine-interfaces)
- [How to find storage info for a machine](#heading--how-to-find-machine-storage-info)
- [How to find commissioning logs](#heading--commissioning-log)
- [How to find machine hardware & test logs](#heading--hardware-tests)
- [How to find raw log output for a machine](#heading--raw-log-output)
- [How to find a machine's event logs](#heading--event-logs)
- [How to find machine configuration info](#heading--machine-config)

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
<a href="#heading--how-to-view-the-machine-list"><h3 id="heading--how-to-view-the-machine-list">How to view the machine list</h3></a>

To view the machine list, enter a command similar to this one:

```nohighlight
maas $PROFILE machines read | jq -r '(["HOSTNAME","SYSID",
"POWER","STATUS","OWNER", "TAGS", "POOL","VLAN","FABRIC",
"SUBNET"] | (., map(length*"-"))),(.[] | [.hostname, .system_id, 
.power_state, .status_name, .owner // "-",.tag_names[0] // "-", 
.pool.name,.boot_interface.vlan.name,.boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t
```

This will return a relatively compact machine listing:

```nohighlight
HOSTNAME      SYSID   POWER  STATUS     OWNER  TAGS                 POOL     VLAN      FABRIC    SUBNET
 --------      -----   -----  ------     -----  ----                 ----     ----      ------    ------
 lxd-vm-1      r8d6yp  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 lxd-vm-2      tfftrx  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 lxd-vm-3      grwpwc  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 lxd-vm-4      6s8dt4  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 lxd-vm-5      pyebgm  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 lxd-vm-6      ebnww6  off    New        -      pod-console-logging  default  untagged  fabric-1  
 libvirt-vm-1  m7ffsg  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 libvirt-vm-2  kpawad  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 libvirt-vm-3  r44hr6  error  Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 libvirt-vm-4  s3sdkw  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 libvirt-vm-5  48dg8m  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 libvirt-vm-6  bacx77  on     Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 ```
 
You can view various details for your machines, by changing the `jq` command as desired:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t
```

This command, for example, will display machine power status, life-cycle status, and various networking parameters:

```nohighlight
HOSTNAME      SYSID   POWER  STATUS     OWNER  TAGS                 POOL     VLAN      FABRIC    SUBNET
--------      -----   -----  ------     -----  ----                 ----     ----      ------    ------
lxd-vm-1      r8d6yp  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-2      tfftrx  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-3      grwpwc  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-4      6s8dt4  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-5      pyebgm  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-6      ebnww6  off    New        -      pod-console-logging  default  untagged  fabric-1  
libvirt-vm-1  m7ffsg  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-2  kpawad  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-3  r44hr6  error  Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-4  s3sdkw  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-5  48dg8m  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-6  bacx77  on     Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
```
<a href="#heading--how-to-view-machine-details"><h3 id="heading--how-to-view-machine-details">How to view machine details</h3></a>

To view output similar to the MAAS UI machine details page, execute the following shell script:

```nohighlight
#!/bin/nohighlight

maas admin machine read r3rd6h | jq '.' > /tmp/machine-json
cat /tmp/machine-json | jq -r '([.hostname,.status_name,"| Power:",.power_state,"| Kernel:",.hwe_kernel,"| Owner:",.owner]) | @tsv' | column -t -o " " > /tmp/machine-details
cat /tmp/machine-json | jq -r '(["CPU:",.architecture,"/",.cpu_count,"core(s) /",.cpu_speed,"Mhz","| Type:",.hardware_info.cpu_model]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '(["Memory:",.memory,"MB | Storage:",.storage,"MB | Power type:",.power_type]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '(["Zone:",.zone.name,"| Resource pool:",.pool.name,"| Domain:",.domain.name]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '(["Tags:",.tag_names[]]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '(["SYSTEM Vendor:",.hardware_info.system_vendor,"| Product:",.hardware_info.system_product]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '([".......Vsn:",.hardware_info.system_version,"| Serial:",.hardware_info.system_serial]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '(["MAINBOARD Vendor:",.hardware_info.mainboard_vendor,"| Product:",.hardware_info.mainboard_product]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '(["..........Firmware:",.hardware_info.mainboard_firmware_vendor]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '(["..........Firmware Vsn:",.hardware_info.mainboard_firmware_version,"| Date:",.hardware_info.mainboard_firmware_date]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '(["NETWORK: Vendor:",.boot_interface.vendor]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '([".........Name:",.boot_interface.name,"| MAC:",.boot_interface.mac_address,"| Link speed:",.boot_interface.link_speed,"Mbps"]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-json | jq -r '([".........Fabric:",.boot_interface.vlan.fabric,"| MAAS DHCP:",.boot_interface.vlan.dhcp_on,"| SR-IOV:",.boot_interface.sriov_max_vf]) | @tsv' | column -t -o " " >> /tmp/machine-details
cat /tmp/machine-details
```

This shell script should produce output similar to the following:

```nohighlight
merry-cobra Deployed | Power: on | Kernel: ga-20.04 | Owner: admin
CPU: amd64/generic / 1 core(s) / 1600 Mhz | Type: Intel(R) Core(TM) i5-8265U CPU
Memory: 2048 MB | Storage: 8000.004096 MB | Power type: lxd
Zone: default | Resource pool: default | Domain: maas
Tags: pod-console-logging virtual
SYSTEM Vendor: QEMU | Product: Standard PC (Q35 + ICH9, 2009)
.......Vsn: pc-q35-5.2 | Serial: Unknown
MAINBOARD Vendor: Canonical Ltd. | Product: LXD
..........Firmware: EFI Development Kit II / OVMF
..........Firmware Vsn: 0.0.0 | Date: 02/06/2015
NETWORK: Vendor: Red Hat, Inc.
.........Name: enp5s0 | MAC: 00:16:3e:cc:17:58 | Link speed: 0 Mbps
.........Fabric: fabric-5 | MAAS DHCP: true | SR-IOV: 0
```
[/tab]
[tab version="v3.4 Snap,v3.4 Packages" view="UI"]
<a href="#heading--how-to-view-the-machine-list"><h3 id="heading--how-to-view-the-machine-list">How to view the machine list</h3></a>

To view the machine list, simply select *Machines*.

<a href="#heading--how-to-view-machine-details"><h3 id="heading--how-to-view-machine-details">How to view machine details</h3></a>

To open a detailed view of a machine's status and configuration:

1. Select *Machines*.

2. Click on a machine name.

<a href="#heading--machine-interfaces"><h3 id="heading--machine-interfaces">How to find network info for a machine</h3></a>

To find network info for a specific machine:

1. Select *Machines*.

2. Click on a machine name.

3. Select *Network*.

<a href="#heading--how-to-find-machine-storage-info"><h3 id="heading--how-to-find-machine-storage-info">How to find machine storage info</h3></a>

To view/edit machine storage info:

1. Select *Machines*.

2. Click on a machine name.

3. Select *Storage*.

<a href="#heading--How-to-view-PCI-devices-for-a-given-machine"><h3 id="heading--How-to-view-PCI-devices-for-a-given-machine">How to view PCI devices for a given machine</h3></a>

To view the list of PCI devices associated with a given machine:

1. Select *Machines*.

2. Click on a machine name.

3. Select *PCI devices*

<a href="#heading--How-to-view-USB-devices-for-a-given-machine"><h3 id="heading--How-to-view-USB-devices-for-a-given-machine">How to view USB devices for a given machine</h3></a>

To view the list of USB devices associated with a given machine:

1. Select *Machines*.

2. Click on a machine name.

3. Select *USB*.

<a href="#heading--commissioning-log"><h3 id="heading--commissioning-log">How to find commissioning logs</h3></a>

To view commissioning logs for a given machine:

1. Select *Machines*.

2. Click on a machine name.

3. Select *Commissioning*.

4. To examine an individual log, select *View details* at the end of the row for that log.

5. To review the commissioning history, select *View previous tests* at the end of the row for that log.

<a href="#heading--hardware-tests"><h3 id="heading--hardware-tests">How to find machine hardware & test logs</h3></a>

To view commissioning logs for a given machine:

1. Select *Machines*.

2. Click on a machine name.

3. Select *Test*.

4. To examine an individual log, select *View details* at the end of the row for that log.

5. To review the commissioning history, select *View previous tests* at the end of the row for that log.

<a href="#heading--raw-log-output"><h3 id="heading--raw-log-output">How to find raw log output for a machine</h3></a>

1. Select *Machines*.

2. Click on the machine name.

3. Select *Logs*.

4. Select *Installation output*.

<a href="#heading--event-logs"><h3 id="heading--event-logs">How to find a machine's event logs</h3></a>

1. Select *Machines*.

2. Click on the machine name.

3. Select *Logs*.

4. Using the *Download* dropdown, you can download logs in various formats.

<a href="#heading--machine-config"><h3 id="heading--machine-config">How to find machine configuration info</h3></a>

1. Select *Machines*.

2. Click on the machine name.

3. Select *Configuration*.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--how-to-view-the-machine-list"><h3 id="heading--how-to-view-the-machine-list">How to view the machine list</h3></a>

To view the machine list, select "Machines" on the top menu of the MAAS web UI:

<a href="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg"></a> 

To quickly view more details, roll the cursor over status icons:

<a href="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg"></a> 

<a href="#heading--how-to-view-machine-details"><h3 id="heading--how-to-view-machine-details">How to view machine details</h3></a>

To open a detailed view of a machine's status and configuration, click a machine's FQDN or MAC address:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png"></a>

<a href="#heading--machine-interfaces"><h3 id="heading--machine-interfaces">How to find network info for a machine</h3></a>

To find network info for a specific machine, open that machine's "Network" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png"></a> 

Options on this tab are described in the introduction to [Networking](/t/how-to-set-up-networks/6174) article in this documentation set.

<a href="#heading--how-to-find-machine-storage-info"><h3 id="heading--how-to-find-machine-storage-info">How to find machine storage info</h3></a>

To view/edit machine storage info, click on the "Storage" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

See the section about [storage](/t/how-to-deploy-physical-machines/6193#heading--about-storage) for more information.

<a href="#heading--commissioning-log"><h3 id="heading--commissioning-log">How to find commissioning logs</h3></a>

The "Commissioning" tab brings up a summary log of commissioning events:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png"></a> 

Click on the dropdown at the end of the row you're interested in, and click on "View details":

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png"></a>

This will bring up a detailed log view for that row:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png"></a>

These logs present an extremely detailed, timestamped record of completion and status items from the commissioning process. See the article on [logging](/t/how-to-work-with-log-files/5240) for more details on how to read and interpret these logs.  

<a href="#heading--hardware-tests"><h3 id="heading--hardware-tests">How to find machine hardware & test logs</h3></a>

This tab presents a summary of tests run against this particular machine.  You can view the summary report, or choose the "View details" dropdown to get details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png"></a> 

The format of these screens is very similar to the Configuration logs shown above.   

<a href="#heading--raw-log-output"><h3 id="heading--raw-log-output">How to find raw log output for a machine</h3></a>

By choosing "Installation output" on the "Logs" tab, you can see the "raw" log output:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png"></a> 

Help interpreting these logs can be found under the [logging](/t/how-to-work-with-log-files/5240) section of this documentation.

<a href="#heading--event-logs"><h3 id="heading--event-logs">How to find a machine's event logs</h3></a>

To view the Event log for a machine, choose the "Event" tab under "Logs."  This displays a list of timestamped status updates for events and actions performed on the machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png"></a> 

There is a dropdown on the upper right which allows you to choose how many events per page you wish to view. Detailed discussion of this event log can be found under the [logging](/t/how-to-work-with-log-files/5240) section of this documentation.

<a href="#heading--machine-config"><h3 id="heading--machine-config">How to find machine configuration info</h3></a>

The final tab from the Machine menu allows you to update machine and power configuration options: 

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png"></a> 

There are two sections to this tab.  The "Machine configuration" section, shown above, offers some general parameters, mostly related to how this machine is grouped and categorised.  More information on these options are found in the relevant sections of the documentation (e.g., tags, resource pools, and so forth). 

The "Power configuration" supplies the parameters necessary for MAAS to access the machine to PXE-boot it: 

<a href="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png"></a> 

More information on Power configuration will be found in the [Power management](/t/power-management-reference/5246) section of this documentation.

[/tab]
[/tabs]

<a href="#heading--how-to-use-resource-pools"><h2 id="heading--how-to-use-resource-pools">How to use resource pools</h2></a>

This section will explain:

[tabs]
[tab version="v3.4 Snap,v3.4 Packages" view="UI"]
- [How to add a resource pool](#heading--add-a-resource-pool)
- [How to delete a resource pool](#heading--deleting-a-resource-pool)
- [How to add a node to a resource pool](#heading--add-a-node-to-a-resource-pool)
- [How to remove a node from a resource pool](#heading--removing-a-node-from-a-resource-pool)
- [How to add a VM host to a resource pool](#heading--add-a-vm-host-to-a-resource-pool)
- [How to remove a VM host from a resource pool](#heading--removing-a-vm-host-from-a-resource-pool)

Administrators can manage resource pools on the Machines page in the web UI, under the Resource pools tab.   Also note that all MAAS installations have a resource pool named "default." MAAS automatically adds new machines to the default resource pool.

<a href="#heading--add-a-resource-pool"><h3 id="heading--add-a-resource-pool">How to add a resource pool</h3></a>

1. Select *Organisation > Pools > Add pool*.

2. Enter a *Name* and -- optionally -- a *Description*.

3. Select *Save pool* to register your changes.

<a href="#heading--deleting-a-resource-pool"><h3 id="heading--deleting-a-resource-pool">How to delete a resource pool</h3></a>

1. Select *Organisation > Pools*.

2. Select the trashcan icon at the end of the pool's row.

3. Select *Delete*.

[note]
If you delete a resource pool, all machines that belong to that resource pool will return to the default pool.
[/note]

<a href="#heading--add-a-node-to-a-resource-pool"><h3 id="heading--add-a-node-to-a-resource-pool">How to add a machine to a resource pool</h3></a>

1. Select *Machines*.

2. Select the machine(s) you wish to add to a resource pool.

3. Select *Categorise > Set pool*.

4. Choose *Select pool* and choose a pool from the *Resource pool* dropdown.

5. Alternatively, choose *Create pool*, and create a new pool to assign.

6. Select *Set pool...* to register your changes.

<a href="#heading--removing-a-node-from-a-resource-pool"><h3 id="heading--removing-a-node-from-a-resource-pool">How to remove a machine from a resource pool</h3></a>

1. Select *Machines*.

2. Select the machine(s) you wish to add to a resource pool.

3. Select *Categorise > Set pool*.

4. Choose *Select pool* and choose "default" from the *Resource pool* dropdown.

5. Select *Set pool...* to register your changes.

<a href="#heading--add-a-vm-host-to-a-resource-pool"><h3 id="heading--add-a-vm-host-to-a-resource-pool">How to add a VM host to a resource pool</h3></a>

1. Select *KVM > LXD*.

2. Click on the VM host you wish to add to a resource pool.

3. Select *KVM host settings*.

4. Choose a *Resource pool*.

5. Select *Save changes* to register your changes.

<a href="#heading--removing-a-vm-host-from-a-resource-pool"><h3 id="heading--removing-a-vm-host-from-a-resource-pool">How to remove a VM host from a resource pool</h3></a>

1. Select *KVM > LXD*.

2. Click on the VM host you wish to add to a resource pool.

3. Select *KVM host settings*.

4. Choose the "default" *Resource pool*.

5. Select *Save changes* to register your changes.

[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
- [How to add a resource pool](#heading--add-a-resource-pool)
- [How to delete a resource pool](#heading--deleting-a-resource-pool)
- [How to add a node to a resource pool](#heading--add-a-node-to-a-resource-pool)
- [How to remove a node from a resource pool](#heading--removing-a-node-from-a-resource-pool)
- [How to add a VM host to a resource pool](#heading--add-a-vm-host-to-a-resource-pool)
- [How to remove a VM host from a resource pool](#heading--removing-a-vm-host-from-a-resource-pool)

Administrators can manage resource pools on the Machines page in the web UI, under the Resource pools tab.   Also note that all MAAS installations have a resource pool named "default." MAAS automatically adds new machines to the default resource pool.

<a href="#heading--add-a-resource-pool"><h3 id="heading--add-a-resource-pool">How to add a resource pool</h3></a>

Use the Add pool button to add a new resource pool.

After giving your new pool a name and description, click the Add pool button:

<a href="https://assets.ubuntu.com/v1/2f010325-nodes-resource-pools__2.5_add-pool.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/2f010325-nodes-resource-pools__2.5_add-pool.png"></a>

<a href="#heading--deleting-a-resource-pool"><h3 id="heading--deleting-a-resource-pool">How to delete a resource pool</h3></a>

To delete a resource pool, click the trashcan icon next to the pool.

<a href="https://assets.ubuntu.com/v1/630ed938-nodes-resource-pools__2.5_delete-pool.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/630ed938-nodes-resource-pools__2.5_delete-pool.png"></a>

[note]
If you delete a resource pool, all machines that belong to that resource pool will return to the default pool.
[/note]

<a href="#heading--add-a-node-to-a-resource-pool"><h3 id="heading--add-a-node-to-a-resource-pool">How to add a machine to a resource pool</h3></a>

To add a machine to a resource pool, on the Machines page, select the machine you want to add to the resource pool. Next, select the Configuration tab. Now select the resource pool and click the Save changes button.

<a href="https://assets.ubuntu.com/v1/648e7a8e-nodes-resource-pools__2.5_add-machine.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/648e7a8e-nodes-resource-pools__2.5_add-machine.png"></a>

<a href="#heading--removing-a-node-from-a-resource-pool"><h3 id="heading--removing-a-node-from-a-resource-pool">How to remove a machine from a resource pool</h3></a>

To remove a machine from a resource pool, follow the same procedure you would use to add a machine, but select "default" as the new resource pool. This action will return the machine to the default resource pool.

<a href="#heading--add-a-vm-host-to-a-resource-pool"><h3 id="heading--add-a-vm-host-to-a-resource-pool">How to add a VM host to a resource pool</h3></a>

You can add a VM host to a resource pool when you create a new VM host, or you can edit a VM host's configuration:

<a href="https://assets.ubuntu.com/v1/84a89952-nodes-resource-pools__2.5_pod_to_pool.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/84a89952-nodes-resource-pools__2.5_pod_to_pool.png"></a>

<a href="#heading--removing-a-vm-host-from-a-resource-pool"><h3 id="heading--removing-a-vm-host-from-a-resource-pool">How to remove a VM host from a resource pool</h3></a>

To remove a VM host from a resource pool, follow the same procedure you would use to add a VM host to a resource pool, except select "default" as the new resource pool. This action will return the machine to the default resource pool.

[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
- [How to create a resource pool](#heading--creating-a-resource-pool)
- [How to list available resource pools](#heading--list-available-resource-pools)
- [How to list a single resource pool](#heading--list-a-single-resource-pool)
- [How to update a resource pool](#heading--update-a-resource-pool)
- [How to delete a resource pool](#heading--delete-a-resource-pool)
- [How to add a machine to a resource pool](#heading--add-a-machine-to-a-resource-pool)

<a href="#heading--creating-a-resource-pool"><h3 id="heading--creating-a-resource-pool">How to create a resource pool</h3></a>

Here's an example that demonstrates how to create a new resource pool named `myresource`.

``` nohighlight
maas $PROFILE resource-pools create name=myresource description="A new resource pool."
```

[note]
The `description` field is optional.
[/note]

<a href="#heading--list-available-resource-pools"><h3 id="heading--list-available-resource-pools">How to list available resource pools</h3></a>

``` nohighlight
maas $PROFILE resource-pools read
```
<a href="#heading--list-a-single-resource-pool"><h3 id="heading--list-a-single-resource-pool">How to list a single resource pool</h3></a>

``` nohighlight
maas $PROFILE resource-pool read $RESOURCE_POOL_ID
```

<a href="#heading--update-a-resource-pool"><h3 id="heading--update-a-resource-pool">How to update a resource pool</h3></a>

``` nohighlight
maas $PROFILE resource-pool update $RESOURCE_POOL_ID name=newname description="A new description."
```

[note]
The `name` and `description` fields are optional.
[/note]

<a href="#heading--delete-a-resource-pool"><h3 id="heading--delete-a-resource-pool">How to delete a resource pool</h3></a>

``` nohighlight
maas $PROFILE resource-pool delete $RESOURCE_POOL_ID
```

<a href="#heading--add-a-machine-to-a-resource-pool"><h3 id="heading--add-a-machine-to-a-resource-pool">How to add a machine to a resource pool</h3></a>

``` nohighlight
maas $PROFILE machine update $SYSTEM_ID pool=$POOL_NAME
```

<a href="#heading--how-to-use-annotations"><h2 id="heading--how-to-use-annotations">How to use annotations</h2></a>

This section will show you:

- [How to use static annotations](#heading--work-with-static-annotations)
- [How to use dynamic (workload) annotations](#heading--work-with-dynamic-workload-annotations)

<a href="#heading--work-with-static-annotations"><h3 id="heading--work-with-static-annotations">How to use static annotations</h3></a>

This subsection will show you how to:

- [How to identify your machines](#heading--identify-your-machines)
- [How to set a static annotation for a machine](#heading--set-a-static-annotation-for-a-machine)
- [How to change or clear a static annotation for a machine](#heading--change-or-clear-a-static-annotation-for-a-machine)
- [How to list static annotations for all machines](#heading--list-static-annotations-for-all-machines)
- [How to view a static annotation for one machine](#heading--view-a-static-annotation-for-one-machine)

<a href="#heading--identify-your-machines"><h4 id="heading--identify-your-machines">How to identify your machines</h4></a>

To identify your available machines, use a command like this one:

```nohighlight
maas $PROFILE machines read \
| jq -r '(["hostname","system_id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
|@tsv' | column -t
```

For example:

```nohighlight
maas admin machines read \
| jq -r '(["hostname","system_id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
|@tsv' | column -t
```

Typical output might look something like this:

```nohighlight
hostname       system_id
--------       ---------
divine-stork   8b3ypp
casual-prawn   4end6r
driven-teal    tgaat6
immune-beetle  43xand
good-osprey    napfxk
smart-hen      c4rwq7
boss-satyr     xn8taa
golden-martin  8fxery
crack-guinea   qk4b3g
finer-leech    cy3dtr
free-mouse     gxtbq4
humble-bunny   srqnnb
wanted-muskox  ekw7fh
one-boa        by477d
great-urchin   srnx4g
ace-frog       g6arwg
alive-marlin   gbwnfb
picked-parrot  am77wn
tough-kit      ke3wc7
legal-whale    8nq3mt
game-sponge    76pdc6
fun-ghoul      qxfm7k
aware-earwig   8m8hs7
chief-crane    7fapx7
select-tapir   4ascbr
on-slug        snfs8d
polite-llama   dbqd4m
frank-coyote   wcmk48
usable-condor  ed8hmy
still-imp      h6ra6d
```

<a href="#heading--set-a-static-annotation-for-a-machine"><h4 id="heading--set-a-static-annotation-for-a-machine">How to set a static annotation for a machine</h4></a>

If you want to set the static annotation for a given machine, you can do so with a command that looks like this:

```nohighlight
maas $PROFILE machine update $SYSTEM_ID description="$STATIC_ANNOTATION"
```

For example:

```nohighlight
maas admin machine update ke3wc7 description="kilo-echo-3-whisky-charlie-7"
```

You can check your work by [viewing the static annotations for one machine](#heading--view-a-static-annotation-for-one-machine).

<a href="#heading--change-or-clear-a-static-annotation-for-a-machine"><h4 id="heading--change-or-clear-a-static-annotation-for-a-machine">How to change or clear a static annotation for a machine</h4></a>

If you want to set the static annotation for a given machine, use the same command you'd use to set a static annotation:

```nohighlight
maas $PROFILE machine update $SYSTEM_ID description="$STATIC_ANNOTATION"
```

The existing annotation will be overwritten by the new one you enter.  For example:

```nohighlight
maas admin machine update ke3wc7 description=""
```

You can check your work by [viewing the static annotations for one machine](#heading--view-a-static-annotation-for-one-machine).


<a href="#heading--list-static-annotations-for-all-machines"><h4 id="heading--list-static-annotations-for-all-machines">How to list static annotations for all machines</h4></a>

To list static annotations for all machines, enter a command similar to this one:

```nohighlight
maas $PROFILE machines read \
| jq -r '(["hostname","system_id","description"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.description])
|@tsv' | column -t
```

For example:

```nohighlight
maas admin machines read \
| jq -r '(["hostname","system_id","description"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.description])
|@tsv' | column -t
```

Output might look something like this:

```nohighlight
hostname       system_id  description
--------       ---------  -----------
driven-teal    tgaat6     tango-golf
humble-bunny   srqnnb     sierra-romeo
tough-kit      ke3wc7     kilo-echo
```

<a href="#heading--view-a-static-annotation-for-one-machine"><h4 id="heading--view-a-static-annotation-for-one-machine">How to view a static annotation for one machine</h4></a>

To view a static annotation for one machine, try a command like this:

```nohighlight
 maas $PROFILE machine read $SYSTEM_ID \
| jq -r '(["hostname","system_id","description"]
|(.,map(length*"-"))),([.hostname,.system_id,.description])
|@tsv' | column -t
```

For example:

```nohighlight
 maas admin machine read tgaat6 \
| jq -r '(["hostname","system_id","description"]
|(.,map(length*"-"))),([.hostname,.system_id,.description])
|@tsv' | column -t
```

A command like this might produce output as follows:

```nohighlight
hostname     system_id  description
--------     ---------  -----------
driven-teal  tgaat6     tango-golf
```

<a href="#heading--work-with-dynamic-workload-annotations"><h3 id="heading--work-with-dynamic-workload-annotations">How to use dynamic (workload) annotations</h3></a>

This section will show you how to:

- [How to identify machines that can receive dynamic annotations](#heading--identify-machines-that-can-receive-dynamic-annotations)
- [How to set dynamic annotations for a machine](#heading--set-dynamic-annotations-for-a-machine)
- [How to clear and change dynamic annotations for a machine](#heading--clear-and-change-dynamic-annotations-for-a-machine)
- [How to list dynamic annotations for all machines](#heading--list-dynamic-annotations-for-all-machines)
- [How to list dynamic allocations for one machine](#heading--list-dynamic-annotations-for-one-machine)

<a href="#heading--identify-machines-that-can-receive-dynamic-annotations"><h4 id="heading--identify-machines-that-can-receive-dynamic-annotations">How to identify machines that can receive dynamic annotations</h4></a>

You can only set dynamic annotations for machines that are in the "Allocated" or "Deployed" state.  To identify which of your machines are in these states, you can execute the following command:

```nohighlight
maas $PROFILE machines read \
| jq -r '(["hostname","system_id","status"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.status_name])
|@tsv' | column -t
```

For example:

```nohighlight
maas admin machines read \
| jq -r '(["hostname","system_id","status"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.status_name])
|@tsv' | column -t
```

Output should look something like this:

```nohighlight
hostname       system_id  status
--------       ---------  ------
divine-stork   8b3ypp     Deployed
casual-prawn   4end6r     Ready
driven-teal    tgaat6     Allocated
immune-beetle  43xand     Allocated
good-osprey    napfxk     Allocated
smart-hen      c4rwq7     Allocated
boss-satyr     xn8taa     Ready
golden-martin  8fxery     Allocated
crack-guinea   qk4b3g     Allocated
finer-leech    cy3dtr     Deployed
free-mouse     gxtbq4     Allocated
humble-bunny   srqnnb     Allocated
wanted-muskox  ekw7fh     Deployed
one-boa        by477d     Allocated
great-urchin   srnx4g     Allocated
ace-frog       g6arwg     Ready
alive-marlin   gbwnfb     Deployed
picked-parrot  am77wn     Allocated
tough-kit      ke3wc7     Deployed
legal-whale    8nq3mt     Allocated
game-sponge    76pdc6     Allocated
fun-ghoul      qxfm7k     Allocated
aware-earwig   8m8hs7     Deployed
chief-crane    7fapx7     Ready
select-tapir   4ascbr     Allocated
on-slug        snfs8d     Allocated
polite-llama   dbqd4m     Allocated
frank-coyote   wcmk48     Allocated
usable-condor  ed8hmy     Deployed
still-imp      h6ra6d     Allocated
```

<a href="#heading--set-dynamic-annotations-for-a-machine"><h4 id="heading--set-dynamic-annotations-for-a-machine">How to set dynamic annotations for a machine</h4></a>

Dynamic annotations, otherwise known as "workload annotations" or "owner data," can be used to keep track of the runtime status of machines that are allocated or deployed.  These annotations are set using `key=value` pairs.  You can set any `key=value` pair that you wish for any machine, although it's probably more useful if you standardise your key names.

To set a dynamic annotation for a machine, you can enter a command like this:

```nohighlight
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=$VALUE
```

For example:

```nohighlight
maas admin machine set-owner-data tgaat6 owner=gsmith@zorko.com
```

This command will return a JSON string representative of the machine's new configuration, including the dynamic annotations you've added. You can check your work by [listing the dynamic annotations for the one machine](#heading--list-dynamic-annotations-for-one-machine) you just edited, or by [listing dynamic annotations for all machines](#heading--list-dynamic-annotations-for-all-machines).

<a href="#heading--clear-and-change-dynamic-annotations-for-a-machine"><h4 id="heading--clear-and-change-dynamic-annotations-for-a-machine">How to clear and change dynamic annotations for a machine</h4></a>

You can change dynamic annotations for a machine simply by executing a new `set-owner-data` command:

```nohighlight
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=$NEW_VALUE
```

You can clear a dynamic annotation by entering the empty string (`""`) as the $VALUE:

```nohighlight
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=""
```

These commands will return a JSON string representative of the machine's new configuration, including the dynamic annotations you've changed or cleared. You can check your work by [listing the dynamic annotations for the one machine](#heading--list-dynamic-annotations-for-one-machine) you just edited, or by [listing dynamic annotations for all machines](#heading--list-dynamic-annotations-for-all-machines).

<a href="#heading--list-dynamic-annotations-for-all-machines"><h4 id="heading--list-dynamic-annotations-for-all-machines">How to list dynamic annotations for all machines</h4></a>

You can list the current dynamic annotations for all machines with a command like this:

```nohighlight
maas $PROFILE machines read \
| jq -r '(["hostname","system_id","owner_data"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.owner_data[]])
|@tsv' | column -t
```

For example:

```nohighlight
maas admin machines read \
| jq -r '(["hostname","system_id","owner_data"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.owner_data[]])
|@tsv' | column -t
```

This command output might look something like this:

```nohighlight
hostname       system_id  owner_data
--------       ---------  ----------
divine-stork   8b3ypp
casual-prawn   4end6r
driven-teal    tgaat6     farquar     foobar
immune-beetle  43xand
good-osprey    napfxk
smart-hen      c4rwq7
```

<a href="#heading--list-dynamic-annotations-for-one-machine"><h4 id="heading--list-dynamic-annotations-for-one-machine">How to list dynamic allocations for one machine</h4></a>

You can list the dynamic annotations for one machine by entering a command of the form:

```nohighlight
maas $PROFILE machine read $SYSTEM_ID \
| jq -r '(["hostname","system_id","owner_data"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.owner_data[]])
|@tsv' | column -t
```

For example:

```nohighlight
maas admin machine read tgaat6 \
| jq -r '(["hostname","system_id","owner_data"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.owner_data[]])
|@tsv' | column -t
```

This will produce output similar to the following:

```nohighlight
hostname     system_id  owner_data
--------     ---------  ----------
driven-teal  tgaat6     farquar     foobar
```
[/tab]
[/tabs]

<a href="#heading--how-to-use-machine-storage"><h2 id="heading--how-to-use-machine-storage">How to use machine storage</h2></a>

This section will explain:

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages"]
- [How to set global storage layouts](#heading--how-to-set-global-storage-layouts)
- [How to set per-machine storage layouts](#heading--how-to-set-per-machine-storage-layouts)
- [How to specify conditional erasure types](#heading--how-to-specify-conditional-erasure-types)
- [How to erase disks](#heading--how-to-erase-disks)
- [How to manage block devices](#heading--how-to-manage-block-devices)
- [How to manage partitions](#heading--how-to-manage-partitions)
- [How to manage VMFS datastores](#heading--how-to-manage-vmfs-datastores)
- [How to define custom storage layouts](#heading--how-to-define-custom-storage-layouts)
[/tab]
[tab version="v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
- [How to set global storage layouts](#heading--how-to-set-global-storage-layouts)
- [How to set per-machine storage layouts](#heading--how-to-set-per-machine-storage-layouts)
- [How to specify conditional erasure types](#heading--how-to-specify-conditional-erasure-types)
- [How to erase disks](#heading--how-to-erase-disks)
- [How to manage block devices](#heading--how-to-manage-block-devices)
- [How to manage partitions](#heading--how-to-manage-partitions)
- [How to manage VMFS datastores](#heading--how-to-manage-vmfs-datastores)
[/tab]
[/tabs]

<a href="#heading--how-to-set-global-storage-layouts"><h3 id="heading--how-to-set-global-storage-layouts">How to set global storage layouts</h3></a>

Layouts can be set globally and on a per-machine basis.

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view=UI"]
All machines will have a default layout applied when commissioned. An administrator can configure the default layout on the 'Settings' page, under the 'Storage' tab.

<a href="https://discourse.maas.io/uploads/default/original/1X/80de3bc701552cd00bec707830accf380c214b17.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/80de3bc701552cd00bec707830accf380c214b17.png"></a>
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
All machines will have a default layout applied when commissioned. To set the default storage layout for all machines:

```nohighlight
maas $PROFILE maas set-config name=default_storage_layout value=$LAYOUT_TYPE
```

For example, to set the default layout to Flat:

```nohighlight
maas $PROFILE maas set-config name=default_storage_layout value=flat
```

Important: The new default will only apply to newly-commissioned machines.

[/tab]
[/tabs]

[note]
The new default will only apply to newly-commissioned machines.
[/note]

<a href="#heading--how-to-set-per-machine-storage-layouts"><h3 id="heading--how-to-set-per-machine-storage-layouts">How to set per-machine storage layouts</h3></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
An administrator can change the layout for a single machine as well as customise that layout providing this is done while the machine has a status of 'Ready'. This is only possible via the CLI: to see how, click the "CLI" option for your version and delivery method above.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
An administrator can set a storage layout for a machine with a status of ‘Ready’ like this:

```nohighlight
maas $PROFILE machine set-storage-layout $SYSTEM_ID storage_layout=$LAYOUT_TYPE [$OPTIONS]
```

For example, to set an LVM layout where the logical volume has a size of 5 GB:

```nohighlight
maas $PROFILE machine set-storage-layout $SYSTEM_ID storage_layout=lvm lv_size=5368709120
```

You must specify all storage sizes in bytes.

This action will remove the configuration that may exist on any block device.
[/tab]
[/tabs]

[note]
Only an administrator can modify storage at the block device level (providing the machine has a status of 'Ready').
[/note]

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--how-to-set-default-erasure-configuration"><h3 id="heading--how-to-set-default-erasure-configuration">How to set the default erasure configuration</h3></a>

A default erasure configuration can be set on the 'Settings' page by selecting the 'Storage' tab.

<a href="https://assets.ubuntu.com/v1/4e90c4c7-installconfig-storage-erasure__defaults.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/4e90c4c7-installconfig-storage-erasure__defaults.png"></a>

If option 'Erase machines' disks prior to releasing' is chosen then users will be compelled to use disk erasure. That option will be pre-filled in the machine's view and the user will be unable to remove the option.

With the above defaults, the machine's view will look like this when the Release action is chosen:

<a href="https://assets.ubuntu.com/v1/66e1dcc2-installconfig-storage-erasure__defaults-node.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/66e1dcc2-installconfig-storage-erasure__defaults-node.png"></a>

Where 'secure erase' and 'quick erase' can then be configured by the user.

[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]

<a href="#heading--how-to-erase-disks"><h3 id="heading--how-to-erase-disks">How to erase disks</h3></a>

When using the [MAAS CLI](/t/maas-cli/5236), you can erase a disk when releasing an individual machine.  Note that this option is not available when releasing multiple machines, so you'll want to make sure you're using:

```nohighlight
maas $PROFILE machine release...
```

and not:

```nohighlight
maas $PROFILE machines release...
```

Note the difference in singular and plural "machine/machines" in the commands.  Releasing a machine requires that you have the `system_id` of the machine to be released, which you can obtain with a command like this one:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t
```

<a href="https://discourse.maas.io/uploads/default/original/1X/a496ac76977909f3403160ca96a1bb7224e785f5.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a496ac76977909f3403160ca96a1bb7224e785f5.jpeg">
</a>

The basic form of the release command, when erasing disks on releasing, is:

```nohighlight
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true [secure_erase=true ||/&& quick_erase=true]
```

Parameters `secure_erase` and `quick_erase` are both optional, although if you don't specify either of them, the entire disk will be overwritten with null bytes.  Note that this overwrite process is very slow.

Secure erasure uses the drive's secure erase feature, if it has one.  In some cases, this can be much faster than overwriting the entire drive.  Be aware, though, that some drives implement secure erasure as a complete drive overwrite, so this method may still be very slow.  Additionally, if you specify secure erasure and the drive doesn't have this feature, you'll get a complete overwrite anyway -- again, possibly very slow.

Quick erasure wipes 2MB at the start and end of the drive to make recovery both inconvenient and unlikely to happen by accident.  Note, though, that quick erasure is not secure.

<a href="#heading--how-to-specify-conditional-erasure-types"><h3 id="heading--how-to-specify-conditional-erasure-types">How to specify conditional erasure types</h3></a>

If you specify both erasure types, like this:

```nohighlight
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true secure_erase=true quick_erase=true
```

then MAAS will perform a secure erasure if the drive has that feature; if not, it will perform a quick erasure.  Of course, if you're concerned about completely erasing the drive, and you're not sure whether the disk has secure erase features, the best way to handle that is to specify nothing, and allow the full disk to be overwritten by null bytes:

```nohighlight
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true
```

<a href="#heading--how-to-manage-block-devices"><h3 id="heading--how-to-manage-block-devices">How to manage block devices</h3></a>

This section will explain:

- [How to list block devices](#heading--how-to-list-block-devices)
- [How to read a block device](#heading--how-to-read-a-block-device)
- [How to create a block device](#heading--how-to-create-a-block-device)
- [How to update a block device](#heading--how-to-update-a-block-device)
- [How to delete a block device](#heading--how-to-delete-a-block-device)
- [How to format Block Device](#heading--format-block-device)
- [How to unformat a block device](#heading--how-to-unformat-a-block-device)
- [How to mount a block device](#heading--how-to-mount-a-block-device)
- [How to unmount a block device](#heading--how-to-unmount-a-block-device)
- [How to set a block device as a boot disk](#heading--how-to-set-a-block-device-as-a-boot-disk)

<a href="#heading--how-to-list-block-devices"><h4 id="heading--how-to-list-block-devices">How to list block devices</h4></a>

To view all block devices on a machine use the read operation. This list both physical and virtual block devices, as you can see in the output from the following command:

``` nohighlight
maas admin block-devices read <node-id>
```

Output:

``` nohighlight
Success.
Machine-readable output follows:
[
    {
        "id": 10,
        "path": "/dev/disk/by-dname/vda",
        "serial": "",
        "block_size": 4096,
        "available_size": 0,
        "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/10/",
        "filesystem": null,
        "id_path": "/dev/vda",
        "size": 5368709120,
        "partition_table_type": "MBR",
        "model": "",
        "type": "physical",
        "uuid": null,
        "used_size": 5365563392,
        "used_for": "MBR partitioned with 1 partition",
        "partitions": [
            {
                "bootable": false,
                "id": 9,
                "resource_uri":"/MAAS/api/2.0/nodes/4y3h8a/blockdevices/10/partition/9",
                "path": "/dev/disk/by-dname/vda-part1",
                "uuid": "aae082cd-8be0-4a64-ab49-e998abd6ea43",
                "used_for": "LVM volume for vgroot",
                "size": 5360320512,
                "type": "partition",
                "filesystem": {
                    "uuid": "a56ebfa6-8ef4-48b5-b6bc-9f9d27065d24",
                    "mount_options": null,
                    "label": null,
                    "fstype": "lvm-pv",
                    "mount_point": null
                }
            }
        ],
        "tags": [
            "rotary"
        ],
        "name": "vda"
    },
    {
        "id": 11,
        "path": "/dev/disk/by-dname/lvroot",
        "serial": null,
        "block_size": 4096,
        "available_size": 0,
        "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/11/",
        "filesystem": {
            "uuid": "7181a0c0-9e16-4276-8a55-c77364d137ca",
            "mount_options": null,
            "label": "root",
            "fstype": "ext4",
            "mount_point": "/"
        },
        "id_path": null,
        "size": 3221225472,
        "partition_table_type": null,
        "model": null,
        "type": "virtual",
        "uuid": "fc8ba89e-9149-412c-bcea-e596eb7c0d14",
        "used_size": 3221225472,
        "used_for": "ext4 formatted filesystem mounted at /",
        "partitions": [],
        "tags": [],
        "name": "vgroot-lvroot"
    }
]
```

<a href="#heading--how-to-read-a-block-device"><h4 id="heading--how-to-read-a-block-device">How to read a block device</h4></a>

If you want to read just one block device instead of listing all block devices the read operation on the block device endpoint provides that information. To display the details on device '11' from the previous output, for example, we could enter:

``` nohighlight
maas admin block-device read <node-id> 11
```

The above command generates the following output:

``` nohighlight
Success.
Machine-readable output follows:
{
    "available_size": 0,
    "path": "/dev/disk/by-dname/vgroot-lvroot",
    "name": "vgroot-lvroot",
    "used_for": "ext4 formatted filesystem mounted at /",
    "type": "virtual",
    "used_size": 3221225472,
    "filesystem": {
        "uuid": "7181a0c0-9e16-4276-8a55-c77364d137ca",
        "mount_point": "/",
        "mount_options": null,
        "fstype": "ext4",
        "label": "root"
    },
    "id_path": null,
    "id": 11,
    "partition_table_type": null,
    "block_size": 4096,
    "tags": [],
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/11/",
    "uuid": "fc8ba89e-9149-412c-bcea-e596eb7c0d14",
    "serial": null,
    "partitions": [],
    "size": 3221225472,
    "model": null
}
```

It is also possible to use the name of the block device, such as 'sda' or 'vda', instead of its 'id':

``` nohighlight
s admin block-device read <node-id> vda
```

[note]
MAAS allows the name of a block device to be changed. If the block device name has changed then the API call needs to use the new name.
[/note]

    Using the ID is safer as it never changes.

<a href="#heading--how-to-create-a-block-device"><h4 id="heading--how-to-create-a-block-device">How to create a block device</h4></a>

MAAS gathers the required information itself on block devices when re- commissioning a machine. If this doesn't provide the required information, it is also possible - though not recommended - for an administrator to use the API to manually add a physical block device to a machine.

``` nohighlight
maas admin block-devices create <node-id> name=vdb model="QEMU" serial="QM00001" size=21474836480 block_size=4096
```

Depending on your configuration, output should be similar to the following:

``` nohighlight
Success.
Machine-readable output follows:
{
    "available_size": 21474836480,
    "path": "/dev/disk/by-dname/vdb",
    "name": "vdb",
    "used_for": "Unused",
    "type": "physical",
    "used_size": 0,
    "filesystem": null,
    "id_path": "",
    "id": 12,
    "partition_table_type": null,
    "block_size": 4096,
    "tags": [],
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/12/",
    "uuid": null,
    "serial": "QM00001",
    "partitions": [],
    "size": 21474836480,
    "model": "QEMU"
}
```

[note]
The serial number is what MAAS will use when a machine is deployed to find the specific block device. It's important that this be correct. In a rare chance that your block device does not provide a model or serial number you can provide an id_path. The id_path should be a path that is always the same, no matter the kernel version.
[/note]

<a href="#heading--how-to-update-a-block-device"><h4 id="heading--how-to-update-a-block-device">How to update a block device</h4></a>

An administrator can also update the details held on a physical block device, such as its name, from the API:

``` nohighlight
maas admin block-device update <node-id> 12 name=newroot
```

Output from this command will show that the 'name' has changed:

``` nohighlight
Success.
Machine-readable output follows:
{
    "block_size": 4096,
    "size": 21474836480,
    "filesystem": null,
    "model": "QEMU",
    "name": "newroot",
    "partitions": [],
    "tags": [],
    "used_size": 0,
    "path": "/dev/disk/by-dname/newroot",
    "id_path": "",
    "uuid": null,
    "available_size": 21474836480,
    "id": 12,
    "used_for": "Unused",
    "type": "physical",
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/12/",
    "partition_table_type": null,
    "serial": "QM00001"
}
```

<a href="#heading--how-to-delete-a-block-device"><h4 id="heading--how-to-delete-a-block-device">How to delete a block device</h4></a>

Physical and virtual block devices can be deleted by an administrator, while ordinary users can only delete virtual block devices:

``` nohighlight
maas admin block-device delete <node-id> 12
```

<a href="#heading--format-block-device"><h4 id="heading--format-block-device">How to format a block device</h4></a>

An entire block device can be formatted by defining a filesystem with the 'format' API call:

``` nohighlight
maas admin block-device format <node-id> 11 fstype=ext4
```

Successful output from this command will look similar to this:

``` nohighlight
Success.
Machine-readable output follows:
{
    "block_size": 4096,
    "size": 3221225472,
    "filesystem": {
        "label": "",
        "fstype": "ext4",
        "mount_options": null,
        "uuid": "75e42f49-9a45-466c-8425-87a40e4f4148",
        "mount_point": null
    },
    "model": null,
    "name": "vgroot-lvroot",
    "partitions": [],
    "tags": [],
    "used_size": 3221225472,
    "path": "/dev/disk/by-dname/vgroot-lvroot",
    "id_path": null,
    "uuid": "fc8ba89e-9149-412c-bcea-e596eb7c0d14",
    "available_size": 0,
    "id": 11,
    "used_for": "Unmounted ext4 formatted filesystem",
    "type": "virtual",
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/11/",
    "partition_table_type": null,
    "serial": null
}
```

[note]
You cannot format a block device that contains partitions or is used to make another virtual block device.
[/note]

<a href="#heading--how-to-unformat-a-block-device"><h4 id="heading--how-to-unformat-a-block-device">How to unformat a block device</h4></a>

You can remove the filesystem from a block device with the 'unformat' API call:

``` nohighlight
maas admin block-device unformat <node-id> 11
```

The output from this command should show the filesystem is now 'null':

``` nohighlight
Success.
Machine-readable output follows:
{
    "available_size": 3221225472,
    "path": "/dev/disk/by-dname/vgroot-lvroot",
    "name": "vgroot-lvroot",
    "used_for": "Unused",
    "type": "virtual",
    "used_size": 0,
    "filesystem": null,
    "id_path": null,
    "id": 11,
    "partition_table_type": null,
    "block_size": 4096,
    "tags": [],
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/11/",
    "uuid": "fc8ba89e-9149-412c-bcea-e596eb7c0d14",
    "serial": null,
    "partitions": [],
    "size": 3221225472,
    "model": null
}
```

<a href="#heading--how-to-mount-a-block-device"><h4 id="heading--how-to-mount-a-block-device">How to mount a block device</h4></a>

If a block device has a filesystem, you can use the 'maas' command to mount a block devices at a given mount point:

``` nohighlight
maas admin block-device mount <node-id> 11 mount_point=/srv
```

The mount point is included in the successful output from the command:

``` nohighlight
Success.
Machine-readable output follows:
{
    "available_size": 0,
    "path": "/dev/disk/by-dname/vgroot-lvroot",
    "name": "vgroot-lvroot",
    "used_for": "ext4 formatted filesystem mounted at /srv",
    "type": "virtual",
    "used_size": 3221225472,
    "filesystem": {
        "uuid": "6f5965ad-49f7-42da-95ff-8000b739c39f",
        "mount_point": "/srv",
        "mount_options": "",
        "fstype": "ext4",
        "label": ""
    },
    "id_path": null,
    "id": 11,
    "partition_table_type": null,
    "block_size": 4096,
    "tags": [],
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/11/",
    "uuid": "fc8ba89e-9149-412c-bcea-e596eb7c0d14",
    "serial": null,
    "partitions": [],
    "size": 3221225472,
    "model": null
}
```

<a href="#heading--how-to-unmount-a-block-device"><h4 id="heading--how-to-unmount-a-block-device">How to unmount a block device</h4></a>

To remove the mount point from the block device, use the 'unmount' call:

``` nohighlight
maas admin block-device unmount <node-id> 11 mount_point=/srv
```

The previous command will include a nullified 'mount_point' in its output:

``` nohighlight
Success.
Machine-readable output follows:
{
    "available_size": 0,
    "path": "/dev/disk/by-dname/vgroot-lvroot",
    "name": "vgroot-lvroot",
    "used_for": "Unmounted ext4 formatted filesystem",
    "type": "virtual",
    "used_size": 3221225472,
    "filesystem": {
        "uuid": "6f5965ad-49f7-42da-95ff-8000b739c39f",
        "mount_point": null,
        "mount_options": null,
        "fstype": "ext4",
        "label": ""
    },
    "id_path": null,
    "id": 11,
    "partition_table_type": null,
    "block_size": 4096,
    "tags": [],
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/11/",
    "uuid": "fc8ba89e-9149-412c-bcea-e596eb7c0d14",
    "serial": null,
    "partitions": [],
    "size": 3221225472,
    "model": null
}
```

<a href="#heading--how-to-set-a-block-device-as-a-boot-disk"><h4 id="heading--how-to-set-a-block-device-as-a-boot-disk">How to set a block device as a boot disk</h4></a>

By default, MAAS picks the first added block device to the machine as the boot disk. In most cases this works as expected as the BIOS usually enumerates the boot disk as the first block device. There are cases where this fails and the boot disk needs to be set to another disk. This API allow setting which block device on a machine MAAS should use as the boot disk.:

``` nohighlight
maas admin block-device set-boot-disk <node-id> 10
```

[note]
Only an administrator can set which block device should be used as the boot disk and only a physical block device can be set as as the boot disk. This operation should be done before a machine is allocated or the storage layout will be applied to the previous boot disk.
[/note]

<a href="#heading--how-to-manage-partitions"><h3 id="heading--how-to-manage-partitions">How to manage partitions</h3></a>

This section will explain:

- [How to list partitions](#heading--how-to-list-partitions)
- [How to create a partition](#heading--how-to-create-a-partition)
- [How to delete a partition](#heading--how-to-delete-a-partition)
- [How to format a partition](#heading--how-to-format-a-partition)
- [How to unformat a partition](#heading--how-to-unformat-a-partition)
- [How to mount a partition](#heading--how-to-mount-a-partition)
- [How to unmount a partition](#heading--how-to-unmount-a-partition)

<a href="#heading--how-to-list-partitions"><h4 id="heading--how-to-list-partitions">How to list partitions</h4></a>

To view all the partitions on a block device, use the 'partitions read' API call:

``` nohighlight
maas admin partitions read <node-id> 10
```

``` nohighlight
Success.
Machine-readable output follows:
[
    {
        "bootable": false,
        "id": 9,
        "resource_uri":
"/MAAS/api/2.0/nodes/4y3h8a/blockdevices/10/partition/9",
        "path": "/dev/disk/by-dname/vda-part1",
        "uuid": "aae082cd-8be0-4a64-ab49-e998abd6ea43",
        "used_for": "LVM volume for vgroot",
        "size": 5360320512,
        "type": "partition",
        "filesystem": {
            "uuid": "a56ebfa6-8ef4-48b5-b6bc-9f9d27065d24",
            "mount_options": null,
            "label": null,
            "fstype": "lvm-pv",
            "mount_point": null
        }
    }
]
```

To view the metadata for a specific partition on a block device, rather than all partitions, use the singular 'partition' API call with an endpoint:

``` nohighlight
maas admin partition read <node-id> 10 9
```

<a href="#heading--how-to-create-a-partition"><h4 id="heading--how-to-create-a-partition">How to create a partition</h4></a>

To create a new partition on a block device, use the 'create' API call:

``` nohighlight
maas admin partitions create <node-id> 10 size=5360320512
```

In addition to bytes, as shown above, the 'size' of a partition can also be defined with a 'G' for gigabytes or 'M' for megabytes. The output from the previous command will look like this:

``` nohighlight
Success.
Machine-readable output follows:
{
    "bootable": false,
    "path": "/dev/disk/by-dname/vda-part1",
    "filesystem": null,
    "used_for": "Unused",
    "type": "partition",
    "id": 10,
    "size": 5360320512,
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/10/partition/10",
    "uuid": "3d32adbf-9943-4785-ab38-963758338c6c"
}
```

<a href="#heading--how-to-delete-a-partition"><h4 id="heading--how-to-delete-a-partition">How to delete a partition</h4></a>

Partitions can be deleted from a block device with the 'delete' API call. Make sure you double check the partition details as the partition is deleted immediately, with no further confirmation:

``` nohighlight
maas admin partition delete <node-id> 10 9
```

Successful output from the 'delete' command will look like this:

``` nohighlight
Success.
Machine-readable output follows:
```

<a href="#heading--how-to-format-a-partition"><h4 id="heading--how-to-format-a-partition">How to format a partition</h4></a>

Partitions can be formatted in a similar way to block devices:

``` nohighlight
maas admin partition format <node-id> 10 9 fstype=ext4
```

The output from the 'format' command will be similar to the following:

``` nohighlight
Success.
Machine-readable output follows:
{
    "id": 9,
    "used_for": "Unmounted ext4 formatted filesystem",
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/10/partition/9",
    "path": "/dev/disk/by-dname/vda-part1",
    "uuid": "aae082cd-8be0-4a64-ab49-e998abd6ea43",
    "size": 5360320512,
    "bootable": false,
    "type": "partition",
    "filesystem": {
        "uuid": "ea593366-be43-4ea3-b2d5-0adf82085a62",
        "mount_point": null,
        "mount_options": null,
        "fstype": "ext4",
        "label": ""
    }
}
```

[note]
You cannot format partitions that are used to make another virtual block device.
[/note]

<a href="#heading--how-to-unformat-a-partition"><h4 id="heading--how-to-unformat-a-partition">How to unformat a partition</h4></a>

You can also remove the filesystem from a partition with the 'unformat' API call:

``` nohighlight
maas admin partition unformat <node-id> 10 10 fstype=ext4
```

``` nohighlight
Success.
Machine-readable output follows:
{
    "bootable": false,
    "path": "/dev/disk/by-dname/vda-part1",
    "filesystem": null,
    "used_for": "Unused",
    "type": "partition",
    "id": 10,
    "size": 5360320512,
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/10/partition/10",
    "uuid": "3d32adbf-9943-4785-ab38-963758338c6c"
}
```

<a href="#heading--how-to-mount-a-partition"><h4 id="heading--how-to-mount-a-partition">How to mount a partition</h4></a>

A formatted partition can be mounted at a given mount point with the 'mount' command.

``` nohighlight
maas admin partition mount <node-id> 10 10 mount_point=/srv
```

The mount point and the filesystem is visible in the output from the command:

``` nohighlight
Success.
Machine-readable output follows:
{
    "bootable": false,
    "id": 10,
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/10/partition/10",
    "path": "/dev/disk/by-dname/vda-part1",
    "uuid": "3d32adbf-9943-4785-ab38-963758338c6c",
    "used_for": "ext4 formatted filesystem mounted at /srv",
    "size": 5360320512,
    "type": "partition",
    "filesystem": {
        "uuid": "1949a5fb-f7bd-4ada-8ba5-d06d3f5857a8",
        "mount_options": "",
        "label": "",
        "fstype": "ext4",
        "mount_point": "/srv"
    }
}
```

<a href="#heading--how-to-unmount-a-partition"><h4 id="heading--how-to-unmount-a-partition">How to unmount a partition</h4></a>

A previous mounted partition can be unmounted with the 'unmount' command:

``` nohighlight
maas admin partition unmount 4y3h8a 10 10
```

After successfully running this command, the mount point will show as 'null' in the output:

``` nohighlight
Success.
Machine-readable output follows:
{
    "bootable": false,
    "id": 10,
    "resource_uri": "/MAAS/api/2.0/nodes/4y3h8a/blockdevices/10/partition/10",
    "path": "/dev/disk/by-dname/vda-part1",
    "uuid": "3d32adbf-9943-4785-ab38-963758338c6c",
    "used_for": "Unmounted ext4 formatted filesystem",
    "size": 5360320512,
    "type": "partition",
    "filesystem": {
        "uuid": "1949a5fb-f7bd-4ada-8ba5-d06d3f5857a8",
        "mount_options": null,
        "label": "",
        "fstype": "ext4",
        "mount_point": null
    }
    "type": "partition",
    "id": 3,
    "size": 2000003072
}
```

<a href="#heading--how-to-manage-vmfs-datastores"><h4 id="heading--how-to-manage-vmfs-datastores">How to manage VMFS datastores</h4></a>

This section will explain:

- [How to list VMFS datastores](#heading--how-to-list-vmfs-datastores)
- [How to view a VMFS datastore](#heading--how-to-view-a-vmfs-datastore)
- [How to create a VMFS datastore](#heading--how-to-create-a-vmfs-datastore)
- [How to edit a VMFS datastore](#heading--how-to-edit-a-vmfs-datastore)
- [How to delete a VMFS datastore](#heading--how-to-delete-a-vmfs-datastore)

<a href="#heading--how-to-list-vmfs-datastores"><h4 id="heading--how-to-list-vmfs-datastores">How to list VMFS datastores</h4></a>

To view all VMFS Datastores on a machine, use the 'vmfs-datastores read' API call:

``` nohighlight
maas $PROFILE vmfs-datastores read $SYSTEM_ID
```

``` nohighlight
[
    {
        "human_size": "45.8 GB",
        "filesystem": {
            "fstype": "vmfs6",
            "mount_point": "/vmfs/volumes/datastore1"
        },
        "uuid": "2779a745-1db3-4fd7-b06e-455b728fffd4",
        "name": "datastore1",
        "system_id": "4qxaga",
        "devices": [
            {
                "uuid": "c55fe657-689d-4570-8492-683dd5fa1c40",
                "size": 35026632704,
                "bootable": false,
                "tags": [],
                "used_for": "VMFS extent for datastore1",
                "filesystem": {
                    "fstype": "vmfs6",
                    "label": null,
                    "uuid": "55ac6422-68b5-440e-ba65-153032605b51",
                    "mount_point": null,
                    "mount_options": null
                },
                "type": "partition",
                "device_id": 5,
                "path": "/dev/disk/by-dname/sda-part3",
                "system_id": "4qxaga",
                "id": 71,
                "resource_uri": "/MAAS/api/2.0/nodes/4qxaga/blockdevices/5/partition/71"
            },
            {
                "uuid": "5182e503-4ad4-446e-9660-fd5052b41cc5",
                "size": 10729029632,
                "bootable": false,
                "tags": [],
                "used_for": "VMFS extent for datastore1",
                "filesystem": {
                    "fstype": "vmfs6",
                    "label": null,
                    "uuid": "a5949b18-d591-4627-be94-346d0fdaf816",
                    "mount_point": null,
                    "mount_options": null
                },
                "type": "partition",
                "device_id": 6,
                "path": "/dev/disk/by-dname/sdb-part1",
                "system_id": "4qxaga",
                "id": 77,
                "resource_uri": "/MAAS/api/2.0/nodes/4qxaga/blockdevices/6/partition/77"
            }
        ],
        "id": 17,
        "size": 45755662336,
        "resource_uri": "/MAAS/api/2.0/nodes/4qxaga/vmfs-datastore/17/"
    }
]
```

<a href="#heading--how-to-view-a-vmfs-datastore"><h4 id="heading--how-to-view-a-vmfs-datastore">How to view a VMFS datastore</h4></a>

To view a specific VMFS Datastores on a machine, use the 'vmfs-datastore read' API call:

``` nohighlight
maas $PROFILE vmfs-datastore read $SYSTEM_ID $VMFS_DATASTORE_ID
```

``` nohighlight
{
    "uuid": "fb6fedc2-f711-40de-ab83-77eddc3e19ac",
    "name": "datastore1",
    "system_id": "b66fn6",
    "id": 18,
    "filesystem": {
        "fstype": "vmfs6",
        "mount_point": "/vmfs/volumes/datastore1"
    },
    "human_size": "2.8 GB",
    "devices": [
        {
            "uuid": "b91df576-ba02-4acb-914f-03ba9a2865b7",
            "size": 2814377984,
            "bootable": false,
            "tags": [],
            "system_id": "b66fn6",
            "used_for": "VMFS extent for datastore1",
            "type": "partition",
            "id": 80,
            "filesystem": {
                "fstype": "vmfs6",
                "label": null,
                "uuid": "4a098d71-1e59-4b5f-932d-fc30a1c0dc96",
                "mount_point": null,
                "mount_options": null
            },
            "device_id": 1,
            "path": "/dev/disk/by-dname/vda-part3",
            "resource_uri": "/MAAS/api/2.0/nodes/b66fn6/blockdevices/1/partition/80"
        }
    ],
    "size": 2814377984,
    "resource_uri": "/MAAS/api/2.0/nodes/b66fn6/vmfs-datastore/18/"
}
```

<a href="#heading--how-to-create-a-vmfs-datastore"><h4 id="heading--how-to-create-a-vmfs-datastore">How to create a VMFS datastore</h4></a>

A VMware VMFS datastore is created on one or more [block devices](#heading--about-block-devices) or [partitions](#heading--about-partitions).

To create a VMFS Datastores on a machine use the 'vmfs-datastores create' API call:

``` nohighlight
maas $PROFILE vmfs-datastores create $SYSTEM_ID name=$VMFS_NAME block_devices=$BLOCK_ID_1,$BLOCK_ID_2 partitions=$PARTITION_ID_1,$PARTITION_ID_2
```

``` nohighlight
{
    "system_id": "b66fn6",
    "devices": [
        {
            "uuid": "b91df576-ba02-4acb-914f-03ba9a2865b7",
            "size": 2814377984,
            "bootable": false,
            "tags": [],
            "device_id": 1,
            "system_id": "b66fn6",
            "type": "partition",
            "used_for": "VMFS extent for datastore42",
            "filesystem": {
                "fstype": "vmfs6",
                "label": null,
                "uuid": "fc374367-a2fb-4e50-9377-768bfe9705b6",
                "mount_point": null,
                "mount_options": null
            },
            "path": "/dev/disk/by-dname/vda-part3",
            "id": 80,
            "resource_uri": "/MAAS/api/2.0/nodes/b66fn6/blockdevices/1/partition/80"
        }
    ],
    "name": "datastore42",
    "filesystem": {
        "fstype": "vmfs6",
        "mount_point": "/vmfs/volumes/datastore42"
    },
    "id": 19,
    "size": 2814377984,
    "uuid": "2711566c-2df4-4cc4-8c06-7392bb1f9532",
    "human_size": "2.8 GB",
    "resource_uri": "/MAAS/api/2.0/nodes/b66fn6/vmfs-datastore/19/"
}
```

<a href="#heading--how-to-edit-a-vmfs-datastore"><h4 id="heading--how-to-edit-a-vmfs-datastore">How to edit a VMFS datastore</h4></a>

To edit an existing VMFS Datastores on a machine use the 'vmfs-datastore update' API call:

``` nohighlight
maas $PROFILE vmfs-datastore update $SYSTEM_ID $VMFS_ID name=$NEW_VMFS_NAME add_block_devices=$NEW_BLOCK_ID_1,$NEW_BLOCK_ID_2 add_partitions=$NEW_PARTITION_ID_1,$NEW_PARTITION_ID_2 remove_partitions=$EXISTING_PARTITION_ID1,$EXISTING_PARTITION_ID2
```

``` nohighlight
{
    "uuid": "2711566c-2df4-4cc4-8c06-7392bb1f9532",
    "name": "datastore42",
    "system_id": "b66fn6",
    "id": 19,
    "filesystem": {
        "fstype": "vmfs6",
        "mount_point": "/vmfs/volumes/datastore42"
    },
    "human_size": "13.5 GB",
    "devices": [
        {
            "uuid": "b91df576-ba02-4acb-914f-03ba9a2865b7",
            "size": 2814377984,
            "bootable": false,
            "tags": [],
            "system_id": "b66fn6",
            "used_for": "VMFS extent for datastore42",
            "type": "partition",
            "id": 80,
            "filesystem": {
                "fstype": "vmfs6",
                "label": null,
                "uuid": "fc374367-a2fb-4e50-9377-768bfe9705b6",
                "mount_point": null,
                "mount_options": null
            },
            "device_id": 1,
            "path": "/dev/disk/by-dname/vda-part3",
            "resource_uri": "/MAAS/api/2.0/nodes/b66fn6/blockdevices/1/partition/80"
        },
        {
            "uuid": "f21fe54e-b5b1-4562-ab6b-e699e99f002f",
            "size": 10729029632,
            "bootable": false,
            "tags": [],
            "system_id": "b66fn6",
            "used_for": "VMFS extent for datastore42",
            "type": "partition",
            "id": 86,
            "filesystem": {
                "fstype": "vmfs6",
                "label": null,
                "uuid": "f3d9b6a3-bab3-4677-becb-bf5a421bfcc2",
                "mount_point": null,
                "mount_options": null
            },
            "device_id": 2,
            "path": "/dev/disk/by-dname/vdb-part1",
            "resource_uri": "/MAAS/api/2.0/nodes/b66fn6/blockdevices/2/partition/86"
        }
    ],
    "size": 13543407616,
    "resource_uri": "/MAAS/api/2.0/nodes/b66fn6/vmfs-datastore/19/"
}
```

<a href="#heading--how-to-delete-a-vmfs-datastore"><h4 id="heading--how-to-delete-a-vmfs-datastore">How to delete a VMFS datastore</h4></a>

To delete a VMFS Datastores on a machine use the 'vmfs-datastore delete' API call:

``` nohighlight
maas $PROFILE vmfs-datastore delete $SYSTEM_ID $VMFS_ID
```
[/tab]
[/tabs]

<a href="#heading--how-to-define-custom-storage-layouts"><h2 id="heading--how-to-define-custom-storage-layouts">How to define custom storage layouts</h2></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages"]
MAAS 3.1 allows you to define a custom storage layout for a machine, via a custom commissioning script.  You must upload a script which conforms to the following rules:

- it must run after the `40-maas-01-machine-resources` script and before the `50-maas-01-commissioning` one, so it should have a name that starts with anything between `41-` and `49-`. This ensures the script can access the JSON file created by the former which provides info about the machine hardware and network resources. In addition, the custom script can directly inspect the machine it's running on to determine how to configure storage.
- it can read machine hardware/network information from the JSON file at the path specified by `$MAAS_RESOURCES_FILE`
- it must output a JSON file at the path specified by `$MAAS_STORAGE_CONFIG_FILE` with the desired storage layout
- names of disks provided in the custom layout must match the ones detected by MAAS and provided in the resources file.

### Configuration format

The configuration contains two main sections:
- `layout`, which lists the desired storage layout in terms of disks and volumes, along with their setup (partitions, volumes, ...).
  This consists of a dictionary of device names and their configuration. Each device must have a `type` property (see below for supported types).
- `mounts`, which lists the desired filesystem mount points.
  As an example:

```json
"mounts": {
  "/": {
    "device": "sda2",
    "options": "noatime"
  },
  "/boot/efi": {
    "device": "sda1"
  },
  "/data": {
    "device": "raid0"
  }     
}
```

A complete `$MAAS_STORAGE_CONFIG_FILE` would look like this:

```json
{
    "layouts": {
        "sda": {
           ...
        },
        "raid0": {
           ...
        },
        ...
    },
    "mounts": {
       "/": {
           ...
       },
       ...
    }
}
```



The following device types are supported in the `"layout"` section:

#### Disk

```json
"sda": {
  "type": "disk",
  "ptable": "gpt",
  "boot": true,
  "partitions": [
    {
      "name": "sda1",
      "fs": "vfat",
      "size": "100M"
      "bootable": true,
    }
  ]
}
```
A `disk` entry defines a physical disk.
The following details can be specified:
- the partition table type (`ptable`), which can be `gpt` or `mbr`
- whether it should be selected as `boot` disk
- optionally, a list of partitions to create, with their `size` and filesystem type (`fs`)

#### LVM

```json
"lvm0": {
  "type": "lvm",
  "members": [
    "sda1",
    "sdb1",
  ],
  "volumes": [
    {
      "name": "data1",
      "size": "5G",
      "fs": "ext4"
    },
    {
      "name": "data2",
      "size": "7G",
      "fs": "btrfs"
    }
  ]
}
```

An `lvm` entry defines a VG (volume group) composed by a set of disks or partitions (listed as `members`). Optionally it's possible to specify the the LVs (logical volumes) to create.
Those are defined similarly to partitions, with a name and size (and optionally the filesystem).

#### Bcache

```json
"bcache0": {
  "type": "bcache",
  "cache-device": "sda",
  "backing-device": "sdf3",
  "cache-mode": "writeback",
  "fs": "ext4"
}
```

A `bcache`  entry must specify a device to use as cache and one to use as storage. Both can be either a partition or a disk.
Optionally the `cache-mode` for the Bcache can be specified.

#### RAID

```json
"myraid": {
  "type": "raid",
  "level": 5,
  "members": [
    "sda",
    "sdb",
    "sdc",
  ],
  "spares": [
    "sdd",
    "sde"
  ],
  "fs": "btrfs"
```

A `raid` entry defines a RAID with a set of member devices.
Spare devices can also be specified.



### Configuration examples

Here's a few examples of custom storage layout configurations that a script could output to the `$MAAS_STORAGE_CONFIG_FILE`. The examples assumes that the machine has 5 disks (named `sda` to `sde`).

Note that there's no need to add entries for those devices in the `layout` section if the disks are not explicitly partitioned, but just used by other devices (e.g. RAID or LVM).

#### Simple single-disk layout with GPT partitioning
```json
{
  "layout": {
    "sda": {
      "type": "disk",
      "ptable": "gpt",
      "boot": true,
      "partitions": [
        {
          "name": "sda1",
          "fs": "vfat",
          "size": "500M",
          "bootable": true
        },
        {
          "name": "sda2",
          "size": "5G",
          "fs": "ext4"
        },
        {
          "name": "sda3",
          "size": "2G",
          "fs": "swap"
        },
        {
          "name": "sda4",
          "size": "120G",
          "fS": "ext4"
        }
      ]
    }
  },
  "mounts": {
    "/": {
      "device": "sda2",
      "options": "noatime"
    },
    "/boot/efi": {
      "device": "sda1"
    },
    "/data": {
      "device": "sda4"
    },
    "none": {
      "device": "sda3"
    }
  }
}
```
In the `mounts` section, options for mount points can be specified. For swap, an entry must be present (with any unique name that doesn't start with a `/`), otherwise the swap will be created but not activated.

#### RAID 5 setup (with spare devices)
```json
{
  "layout": {
    "storage": {
      "type": "raid",
      "level": 5,
      "members": [
        "sda",
        "sdb",
        "sdc"
      ],
      "spares": [
        "sdd",
        "sde"
      ],
      "fs": "btrfs"
    }
  },
  "mounts": {
    "/data": {
      "device": "storage"
    }
  }
}
```
Both full disks and partitions can be used as RAID members.

#### LVM with pre-defined volumes
```json
{
  "layout": {
    "storage": {
      "type": "lvm",
      "members": [
        "sda",
        "sdb",
        "sdc",
        "sdd"
      ],
      "volumes": [
        {
          "name": "data1",
          "size": "1T",
          "fs": "ext4"
        },
        {
          "name": "data2",
          "size": "2.5T",
          "fs": "btrfs"
        }
      ]
    }
  },
  "mounts": {
    "/data1": {
      "device": "data1"
    },
    "/data2": {
      "device": "data2"
    }
  }
}
```
If no volumes are specified, the volume group is still created.

#### Bcache
```json
{
  "layout": {
     "data1": {
      "type": "bcache",
      "cache-device": "sda",
      "backing-device": "sdb",
      "cache-mode": "writeback",
      "fs": "ext4"
    },
    "data2": {
      "type": "bcache",
      "cache-device": "sda",
      "backing-device": "sdc",
      "fs": "btrfs"
    }
  },
  "mounts": {
    "/data1": {
      "device": "data1"
    },
    "/data2": {
      "device": "data2"
    }
  }
}
```
The same cache set can be used by different bcaches by specifying the same `backing-device` for them.

#### LVM on top of RAID with Bcache
```json
{
  "layout": {
    "bcache0": {
      "type": "bcache",
      "backing-device": "sda",
      "cache-device": "sdf"
    },
    "bcache1": {
      "type": "bcache",
      "backing-device": "sdb",
      "cache-device": "sdf"
    },
    "bcache2": {
      "type": "bcache",
      "backing-device": "sdc",
      "cache-device": "sdf"
    },
    "bcache3": {
      "type": "bcache",
      "backing-device": "sdd",
      "cache-device": "sdf"
    },
    "bcache4": {
      "type": "bcache",
      "backing-device": "sde",
      "cache-device": "sdf"
    },
    "raid": {
      "type": "raid",
      "level": 5,
      "members": [
        "bcache0",
        "bcache1",
        "bcache2"
      ],
      "spares": [
        "bcache3",
        "bcache4"
      ]
    },
    "lvm": {
      "type": "lvm",
      "members": [
        "raid"
      ],
      "volumes": [
        {
          "name": "root",
          "size": "10G",
          "fs": "ext4"
        },
        {
          "name": "data",
          "size": "3T",
          "fs": "btrfs"
        }
      ]
    }
  },
  "mounts": {
   "/": {
      "device": "root"
    },
    "/data": {
      "device": "data"
    }
  }
}
```
The RAID is created by using 5 bcache devices, each one using a different disk and the same SSD cache device. LVM is created on top of the RAID device and volumes are then created in it, to provide partitions.

[/tab]
[tab version="v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
Custom storage layouts are available in MAAS version 3.1 and greater.
[/tab]
[/tabs]

<a href="#heading--storage-layouts-reference"><h2 id="heading--storage-layouts-reference">Storage layouts reference</h2></a>

There are three layout types:

1.   Flat layout
2.   LVM layout
3.   bcache layout

The layout descriptions below will include the EFI partition. If your system is not using UEFI, regard `sda2` as `sda1` (with an additional 512 MB available to it).

<a href="#heading--flat-storage-layout-reference"><h3 id="heading--flat-storage-layout-reference">Flat layout storage reference</h3></a>

With the Flat layout, a partition spans the entire boot disk. The partition is formatted with the ext4 filesystem and uses the `/` mount point:

| Name | Size        | Type | Filesystem | Mount point |
|:----:|------------:|:----:|:----------:|:------------|
| sda  | -           | disk |            |             |
| sda1 | 512 MB      | part | FAT32      | /boot/efi   |
| sda2 | rest of sda | part | ext4       | /           |

The following three options are supported:

1. `boot_size`: Size of the boot partition on the boot disk. Default is 0, meaning not to create the boot partition. The '/boot' will be placed on the root filesystem.

2. `root_device`: The block device on which to place the root partition. The default is the boot disk.

3. `root_size`: Size of the root partition. Default is 100%, meaning the entire size of the root device.

<a href="#heading--lvm-storage-layout-reference"><h3 id="heading--lvm-storage-layout-reference">LVM storage layout reference</h3></a>

The LVM layout creates the volume group `vgroot` on a partition that spans the entire boot disk. A logical volume `lvroot` is created for the full size of the volume group; is formatted with the ext4 filesystem; and uses the `/` mount point:

| Name   | Size        | Type | Filesystem     | Mount point |
|:----:|------------:|:----:|:----------:|:------------|
| sda    | -           | disk |                |             |
| sda1   | 512 MB      | part | FAT32          | /boot/efi   |
| sda2   | rest of sda | part | lvm-pv(vgroot) |             |
| lvroot | rest of sda | lvm  | ext4           | /           |
| vgroot | rest of sda | lvm  |                |             |

The following six options are supported:

1. `boot_size`: Size of the boot partition on the boot disk. Default is 0, meaning not to create the boot partition. The '/boot' will be placed on the root filesystem.
2. `root_device`: The block device on which to place the root partition. The default is the boot disk.
3. `root_size`: Size of the root partition. Default is 100%, meaning the entire size of the root device.
4. `vg_name`: Name of the created volume group. Default is `vgroot`.
5. `lv_name`: Name of the created logical volume. Default is `lvroot`.
6. `lv_size`: Size of the created logical volume. Default is 100%, meaning the entire size of the volume group.

<a href="#heading--bcache-storage-layout-reference"><h3 id="heading--bcache-storage-layout-reference">bcache storage layout reference</h3></a>

A bcache layout will create a partition that spans the entire boot disk as the backing device. It uses the smallest block device tagged with 'ssd' as the cache device. The bcache device is formatted with the ext4 filesystem and uses the `/` mount point. If there are no 'ssd' tagged block devices on the machine, then the bcache device will not be created, and the Flat layout will be used instead:

| Name      | Size        | Type | Filesystem | Mount point |
|:----:|------------:|:----:|:----------:|:------------|
| sda       | -           | disk |            |             |
| sda1      | 512 MB      | part | FAT32      | /boot/efi   |
| sda2      | rest of sda | part | bc-backing |             |
| sdb (ssd) | -           | disk |            |             |
| sdb1      | 100% of sdb | part | bc-cache   |             |
| bcache0   | per sda2    | disk | ext4       | /           |

The following seven options are supported:

1. `boot_size`: Size of the boot partition on the boot disk. Default is 0, meaning not to create the boot partition. The '/boot' will be placed on the root filesystem.
2. `root_device`: The block device upon which to place the root partition. The default is the boot disk.
3. `root_size`: Size of the root partition. Default is 100%, meaning the entire size of the root device.
4. `cache_device`: The block device to use as the cache device. Default is the smallest block device tagged ssd.
5. `cache_mode`: The cache mode to which MAAS should set the created bcache device. The default is `writethrough`.
6. `cache_size`: The size of the partition on the cache device. Default is 100%, meaning the entire size of the cache device.
7. `cache_no_part`: Whether or not to create a partition on the cache device. Default is false, meaning to create a partition using the given `cache_size`. If set to true, no partition will be created, and the raw cache device will be used as the cache.

vmfs6 storage layout reference
<a href="#heading--vmfs6-storage-layout-reference"><h3 id="heading--vmfs6-storage-layout-reference">VMFS6 storage layout reference</h3></a>

The VMFS6 layout is used for VMware ESXi deployments only. It is required when configuring VMware VMFS Datastores. This layout creates all operating system partitions, in addition to the default datastore. The datastore may be modified.  New datastores may be created or extended to include other storage devices. The base operating system partitions may not be modified because VMware ESXi requires them. Once applied another storage layout must be applied to remove the operating system partitions.

| Name | Size      | Type    | Use               |
|:-----|------------:|:----:|:----------|
| sda  | -         | disk    |                   |
| sda1 | 3 MB      | part    | EFI               |
| sda2 | 4 GB      | part    | Basic Data        |
| sda3 | Remaining | part    | VMFS Datastore 1  |
| sda4 | -         | skipped |                   |
| sda5 | 249 MB    | part    | Basic Data        |
| sda6 | 249 MB    | part    | Basic Data        |
| sda7 | 109 MB    | part    | VMware Diagnostic |
| sda8 | 285 MB    | part    | Basic Data        |
| sda9 | 2.5 GB    | part    | VMware Diagnostic |

The following options are supported:

- `root_device`: The block device upon which to place the root partition. Default is the boot disk.

- `root_size`: Size of the default VMFS Datastore. Default is 100%, meaning the remaining size of the root disk.

<a href="#heading--blank-storage-layout-reference"><h3 id="heading--blank-storage-layout-reference">Blank storage layout reference</h3></a>

The blank layout removes all storage configuration from all storage devices. It is useful when needing to apply a custom storage configuration.

[note]
Machines with the blank layout applied are not deployable; you must first configure storage manually.
[/note]