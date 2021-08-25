This article explains:

- [How to create, delete, and configure machines](#heading--how-to-create-delete-and-configure-machines)
- [How to examine machines and machine details](#heading--how-to-examine-machines-and-machine-details)

Most of the day-to-day work of managing machines is covered here. Utilising machines to do work -- for example, commissioning, testing, and deploying them -- is discussed in [How to deploy machines](/t/how-to-deploy-machines/nnnn).

* How to create, delete, and configure machines

<a href="#heading--how-to-create-delete-and-configure-machines"><h2 id="heading--how-to-create-delete-and-configure-machines">How to create, delete, and configure machines</h2></a>

This section shows you:

- [How to add a machine manually](#heading--how-to-add-a-machine-manually)
rad-begin /snap/3.0/ui /snap/2.9/ui /deb/3.0/ui /deb/2.9/ui
- [How to add machines via a chassis](#heading--how-to-add-machines-via-a-chassis)
rad-end
rad-begin /snap/3.0/ui /snap/3.0/cli /deb/3.0/ui /deb/3.0/cli
- [How to manage attached USB and PCI devices](#heading--usb-pci-devices)
rad-end

** How to add a machine manually
<a href="#heading--how-to-add-a-machine-manually"><h3 id="heading--how-to-add-a-machine-manually">How to add a machine manually</h3></a>

rad-begin   /deb/2.9/ui /snap/2.9/ui /snap/3.0/ui /deb/3.0/ui 
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

- **Power type**: You must select the power type supported by the machine you are adding, and fill in additional required fields that appear.  See [Power management](/t/power-management/nnnn) for details on the available power types and the relevant parameters for each type.
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
At the command line, enter the following information:

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

- `$POWER_TYPE`: You must select the power type supported by the machine you are adding, and fill in additional required fields that appear.  See [Power management](/t/power-management/nnnn) for details on the available power types and the relevant parameters for each type. In this example, we've used a "virsh" power type (a libvirt KVM), but your choice will depend on your hardware.

- `$POWER_ID`: This is generally the UUID of the machine being added.

- `$POWER_ADDRESS/$POWER_PASSWORD`: In the case of a KVM, these are the only parameters that need to be entered.  See [Power types](https://maas.io/docs/api#power-types) in the API reference for details on the available power types and the relevant parameters for each type.
rad-end

** how to add machines via a chassis
rad-begin /snap/3.0/ui /deb/3.0/ui /snap/2.9/ui /deb/2.9/ui
<a href="#heading--how-to-add-machines-via-a-chassis"><h3 id="heading--how-to-add-machines-via-a-chassis">How to add machines via a chassis</h3></a>

You can use the chassis feature to add multiple machines at once. To do this, instead of selecting 'Machine' as above, choose 'Chassis' from the drop-down menu. In the following example, MAAS will add all available VMs from the given  virsh address:

<a href="https://discourse.maas.io/uploads/default/original/1X/e7f88bce68318cf3c6a8e97b4d31d0b6980e0f32.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e7f88bce68318cf3c6a8e97b4d31d0b6980e0f32.jpeg"></a>

The required fields will change based on the type of chassis you choose.

[note]
As with the manual method, the underlying machines will require netbooting.
[/note]
rad-end

** how to manage attached usb and pci devices
rad-begin /snap/3.0/ui /deb/3.0/ui /snap/3.0/cli /deb/3.0/cli
<a href="#heading--usb-pci-devices"><h3 id="heading--usb-pci-devices">How to manage attached USB and PCI devices</h3></a>

To delete PCI/USB devices from the machine in any machine state, via the CLI only, using the following command:

```
maas $PROFILE node-device delete $SYSTEM_ID $DEVICE_ID
```

where:

- $PROFILE   = your user profile (e.g., "admin")
- $SYSTEM_ID = the ID of the machine in question (e.g., "ngx7ry")
- $DEVICE_ID = the ID of the device you want to delete 

If the device is still present in the system, it will be recogized again (and thus "recreated")
when the machine is commissioned again.
rad-end

* how to examine machines and machine details

<a href="#heading--how-to-examine-machines-and-machine-details"><h2 id="heading--how-to-examine-machines-and-machine-details">How to examine machines and machine details</h2></a>

This section describes the various ways you can evaluate the health and status of your MAAS machines, using the machine list.  It will show you:

- [How to view the machine list](#heading--how-to-view-the-machine-list)
- [How to view machine details](#heading--how-to-view-machine-details)
rad-begin /snap/3.0/ui /snap/2.9/ui /deb/3.0/ui /deb/2.9/ui
- [How to find network info for a machine](#heading--machine-interfaces)
- [How to find storage info for a machine](#heading--machine-storage)
- [How to find commissioning logs](#heading--commissioning-log)
- [How to find machine hardware & test logs](#heading--hardware-tests)
- [How to find raw log output for a machine](#heading--raw-log-output)
- [How to find a machine's event logs](#heading--event-logs)
- [How to find machine configuration info](#heading--machine-config)
rad-end

* how to view the machine list
rad-begin /snap/3.0/cli /deb/3.0/cli /snap/2.9/cli /deb/2.9/cli
<a href="#heading--how-to-view-the-machine-list"><h2 id="heading--how-to-view-the-machine-list">How to view the machine list</h2></a>

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
* how to view machine details
<a href="#heading--how-to-view-machine-details"><h2 id="heading--how-to-view-machine-details">How to view machine details</h2></a>

To view output similar to the MAAS UI machine details page, execute the following shell script:

```nohighlight
#!/bin/bash

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

* how to find network info for a machine
rad-begin /snap/3.0/ui /snap/2.9/ui /deb/3.0/ui /deb/2.9/ui 
<a href="#heading--machine-interfaces"><h2 id="heading--machine-interfaces">How to find network info for a machine</h2></a>

To find network info for a specific machine, open that machine's "Network" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png"></a> 

Options on this tab are described in the introduction to [Networking](/t/about-networking/nnnn) article in this documentation set.

* how to find machine storage info
<a href="#heading--how-to-find-machine-storage-info"><h2 id="heading--how-to-find-machine-storage-info">How to find machine storage info</h2></a>

To view/edit machine storage info, click on the "Storage" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

See the article [Storage](/t/storage/nnnn) for a detailed instructions on how to use this screen.

* how to find commissioning logs
<a href="#heading--commissioning-log"><h2 id="heading--commissioning-log">How to find commissioning logs</h2></a>

The "Commissioning" tab brings up a summary log of commissioning events:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png"></a> 

Click on the dropdown at the end of the row you're interested in, and click on "View details":

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png"></a>

This will bring up a detailed log view for that row:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png"></a>

These logs present an extremely detailed, timestamped record of completion and status items from the commissioning process. See the article on [Logging](/t/maas-logging/nnnn) for more details on how to read and interpret these logs.  

* how to find machine hardware and test logs
<a href="#heading--hardware-tests"><h2 id="heading--hardware-tests">How to find machine hardware & test logs</h2></a>

This tab presents a summary of tests run against this particular machine.  You can view the summary report, or choose the "View details" dropdown to get details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png"></a> 

The format of these screens is very similar to the Configuration logs shown above.  For more information, please see the article on [Hardware testing](/t/how-to-test-machines/nnnn).  

* how to find raw log output for a machine
<a href="#heading--raw-log-output"><h2 id="heading--raw-log-output">How to find raw log output for a machine</h2></a>

By choosing "Installation output" on the "Logs" tab, you can see the "raw" log output:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png"></a> 

Help interpreting these logs can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.

* how to find a machine's event logs
<a href="#heading--event-logs"><h2 id="heading--event-logs">How to find a machine's event logs</h2></a>

To view the Event log for a machine, choose the "Event" tab under "Logs."  This displays a list of timestamped status updates for events and actions performed on the machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png"></a> 

There is a dropdown on the upper right which allows you to choose how many events per page you wish to view. Detailed discussion of this event log can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.

* how to find machine configuration info
<a href="#heading--machine-config"><h2 id="heading--machine-config">How to find machine configuration info</h2></a>

The final tab from the Machine menu allows you to update machine and power configuration options: 

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png"></a> 

There are two sections to this tab.  The "Machine configuration" section, shown above, offers some general parameters, mostly related to how this machine is grouped and categorised.  More information on these options are found in the relevant sections of the documentation (e.g., tags, resource pools, and so forth). 

The "Power configuration" supplies the parameters necessary for MAAS to access the machine to PXE-boot it: 

<a href="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png"></a> 

More information on Power configuration will be found in the [Power management](/t/power-management/nnnn) section of this documentation.
-->
rad-end

* how to view the machine list
rad-begin /snap/3.0/ui /deb/3.0/ui /snap/2.9/ui /deb/2.9/ui
<a href="#heading--how-to-view-the-machine-list"><h2 id="heading--how-to-view-the-machine-list">How to view the machine list</h2></a>

To view the machine list, select "Machines" on the top menu of the MAAS web UI:

<a href="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg"></a> 

To quickly view more details, roll the cursor over status icons:

<a href="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg"></a> 

* how to view machine details
<a href="#heading--how-to-view-machine-details"><h2 id="heading--how-to-view-machine-details">How to view machine details</h2></a>

To open a detailed view of a machine's status and configuration, click a machine's FQDN or MAC address:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png"></a>


* how to find network info for a machine
<a href="#heading--machine-interfaces"><h2 id="heading--machine-interfaces">How to find network info for a machine</h2></a>

To find network info for a specific machine, open that machine's "Network" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png"></a> 

Options on this tab are described in the introduction to [Networking](/t/about-networking/nnnn) article in this documentation set.

* how to find machine storage info
<a href="#heading--how-to-find-machine-storage-info"><h2 id="heading--how-to-find-machine-storage-info">How to find machine storage info</h2></a>

To view/edit machine storage info, click on the "Storage" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

See the article [Storage](/t/storage/nnnn) for a detailed instructions on how to use this screen.

* how to find commissioning logs
<a href="#heading--commissioning-log"><h2 id="heading--commissioning-log">How to find commissioning logs</h2></a>

The "Commissioning" tab brings up a summary log of commissioning events:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png"></a> 

Click on the dropdown at the end of the row you're interested in, and click on "View details":

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png"></a>

This will bring up a detailed log view for that row:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png"></a>

These logs present an extremely detailed, timestamped record of completion and status items from the commissioning process. See the article on [Logging](/t/maas-logging/nnnn) for more details on how to read and interpret these logs.  

* how to find machine hardware and test logs
<a href="#heading--hardware-tests"><h2 id="heading--hardware-tests">How to find machine hardware & test logs</h2></a>

This tab presents a summary of tests run against this particular machine.  You can view the summary report, or choose the "View details" dropdown to get details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png"></a> 

The format of these screens is very similar to the Configuration logs shown above.  For more information, please see the article on [Hardware testing](/t/how-to-test-machines/nnnn).  

* how to find raw log output for a machine
<a href="#heading--raw-log-output"><h2 id="heading--raw-log-output">How to find raw log output for a machine</h2></a>

By choosing "Installation output" on the "Logs" tab, you can see the "raw" log output:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png"></a> 

Help interpreting these logs can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.

* how to find a machine's event logs
<a href="#heading--event-logs"><h2 id="heading--event-logs">How to find a machine's event logs</h2></a>

To view the Event log for a machine, choose the "Event" tab under "Logs."  This displays a list of timestamped status updates for events and actions performed on the machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png"></a> 

There is a dropdown on the upper right which allows you to choose how many events per page you wish to view. Detailed discussion of this event log can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.

* how to find machine configuration info
<a href="#heading--machine-config"><h2 id="heading--machine-config">How to find machine configuration info</h2></a>

The final tab from the Machine menu allows you to update machine and power configuration options: 

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png"></a> 

There are two sections to this tab.  The "Machine configuration" section, shown above, offers some general parameters, mostly related to how this machine is grouped and categorised.  More information on these options are found in the relevant sections of the documentation (e.g., tags, resource pools, and so forth). 

The "Power configuration" supplies the parameters necessary for MAAS to access the machine to PXE-boot it: 

<a href="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png"></a> 

More information on Power configuration will be found in the [Power management](/t/power-management/nnnn) section of this documentation.
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 

#### Seven questions you may have:

1. [How can I create a resource pool?](#heading--creating-a-resource-pool)
2. [How can I list available resource pools?](#heading--list-available-resource-pools)
3. [How can I list a single resource pool?](#heading--list-a-single-resource-pool)
4. [How can I update a resource pool?](#heading--update-a-resource-pool)
5. [How can I delete a resource pool?](#heading--delete-a-resource-pool)
6. [How can I add a machine to a resource pool?](#heading--add-a-machine-to-a-resource-pool)
7. [How can I get started with MAAS CLI?](/t/maas-cli/802)

* how to create a resource pool
<a href="#heading--creating-a-resource-pool"><h2 id="heading--creating-a-resource-pool">Creating a resource pool</h2></a>

Here's an example that demonstrates how to create a new resource pool named `myresource`.

``` bash
maas $PROFILE resource-pools create name=myresource description="A new resource pool."
```

[note]
The `description` field is optional.
[/note]

* how to list available resource pools
<a href="#heading--list-available-resource-pools"><h2 id="heading--list-available-resource-pools">List available resource pools</h2></a>

``` bash
maas $PROFILE resource-pools read
```
* how to list a single resource pool
<a href="#heading--list-a-single-resource-pool"><h2 id="heading--list-a-single-resource-pool">List a single resource pool</h2></a>

``` bash
maas $PROFILE resource-pool read $RESOURCE_POOL_ID
```

* how to update a resource pool
<a href="#heading--update-a-resource-pool"><h2 id="heading--update-a-resource-pool">Update a resource pool</h2></a>

``` bash
maas $PROFILE resource-pool update $RESOURCE_POOL_ID name=newname description="A new description."
```

[note]
The `name` and `description` fields are optional.
[/note]

* how to delete a resource pool
<a href="#heading--delete-a-resource-pool"><h2 id="heading--delete-a-resource-pool">Delete a resource pool</h2></a>

``` bash
maas $PROFILE resource-pool delete $RESOURCE_POOL_ID
```

* how to add a machine to a resource pool
<a href="#heading--add-a-machine-to-a-resource-pool"><h2 id="heading--add-a-machine-to-a-resource-pool">Add a machine to a resource pool</h2></a>

``` bash
maas $PROFILE machine update $SYSTEM_ID pool=$POOL_NAME
```

rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
#### Six questions you may have:

1. [How can I add a resource pool?](#heading--add-a-resource-pool)
2. [How can I delete a resource pool?](#heading--deleting-a-resource-pool)
3. [How do I add a node to a resource pool?](#heading--add-a-node-to-a-resource-pool)
4. [How do I remove a node from a resource pool?](#heading--removing-a-node-from-a-resource-pool)
5. [How do I add a VM host to a resource pool?](#heading--add-a-vm-host-to-a-resource-pool)
6. [How do I remove a VM host from a resource pool?](#heading--removing-a-vm-host-from-a-resource-pool)

Administrators can manage resource pools on the Machines page in the web UI, under the Resource pools tab.   Also note that all MAAS installations have a resource pool named "default." MAAS automatically adds new machines to the default resource pool.

* how to add a resource pool
<a href="#heading--add-a-resource-pool"><h2 id="heading--add-a-resource-pool">Add a resource pool</h2></a>

Use the Add pool button to add a new resource pool.

After giving your new pool a name and description, click the Add pool button:

<a href="https://assets.ubuntu.com/v1/2f010325-nodes-resource-pools__2.5_add-pool.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/2f010325-nodes-resource-pools__2.5_add-pool.png"></a>

* how to delete a resource pool
<a href="#heading--deleting-a-resource-pool"><h2 id="heading--deleting-a-resource-pool">Deleting a resource pool</h2></a>

To delete a resource pool, click the trashcan icon next to the pool.

<a href="https://assets.ubuntu.com/v1/630ed938-nodes-resource-pools__2.5_delete-pool.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/630ed938-nodes-resource-pools__2.5_delete-pool.png"></a>

[note]
If you delete a resource pool, all machines that belong to that resource pool will return to the default pool.
[/note]

* how to add a node to a resource pool
<a href="#heading--add-a-node-to-a-resource-pool"><h2 id="heading--add-a-node-to-a-resource-pool">Add a machine to a resource pool</h2></a>

To add a machine to a resource pool, on the Machines page, select the machine you want to add to the resource pool. Next, select the Configuration tab. Now select the resource pool and click the Save changes button.

<a href="https://assets.ubuntu.com/v1/648e7a8e-nodes-resource-pools__2.5_add-machine.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/648e7a8e-nodes-resource-pools__2.5_add-machine.png"></a>

* how to remove a node from a resource pool
<a href="#heading--removing-a-node-from-a-resource-pool"><h2 id="heading--removing-a-node-from-a-resource-pool">Removing a machine from a resource pool</h2></a>

To remove a machine from a resource pool, follow the same procedure you would use to add a machine, but select "default" as the new resource pool. This action will return the machine to the default resource pool.

* how to add a vm host to a resource pool
<a href="#heading--add-a-vm-host-to-a-resource-pool"><h2 id="heading--add-a-vm-host-to-a-resource-pool">Add a VM host to a resource pool</h2></a>

You can add a VM host to a resource pool when you create a new VM host, or you can edit a VM host's configuration:

<a href="https://assets.ubuntu.com/v1/84a89952-nodes-resource-pools__2.5_pod_to_pool.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/84a89952-nodes-resource-pools__2.5_pod_to_pool.png"></a>

* how to remove a vm host from a resource pool
<a href="#heading--removing-a-vm-host-from-a-resource-pool"><h2 id="heading--removing-a-vm-host-from-a-resource-pool">Removing a VM host from a resource pool</h2></a>

To remove a VM host from a resource pool, follow the same procedure you would use to add a VM host to a resource pool, except select "default" as the new resource pool. This action will return the machine to the default resource pool.

rad-end


This article will show you how to:


rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
- [Work with tags](#heading--work-with-tags)
rad-end
rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
- [Work with annotations](#heading--work-with-annotations)
rad-end
rad-begin     /snap/2.9/cli /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli
- [Work with tags](#heading--work-with-tags)
rad-end
rad-begin     /snap/2.9/cli /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli
- [Work with annotations](#heading--work-with-annotations)
rad-end

All headings have been hyperlinked for easy bookmarking.  Note that not all functions for tags and annotations can be accessed via one interface (UI/CLI), so you will occasionally encounter cross-links.

rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui

* how to work with tags
<a href="#heading--work-with-tags"><h2 id="heading--work-with-tags">Work with tags</h2></a>

This section is devoted to procedures for working with tags.  We begin with some general operations that apply to all tag types, such as naming conventions and basic mechanics.  We then walk through the various tag types, providing procedures that will help you create, assign, remove, delete, list, view, and filter tags, covering the nuances of each type.

Specifically, this section will show you how to:

rad-end

rad-begin /deb/2.9/ui
- [Work with tags in general](#heading--work-with-tags-in-general)
- [Work with machine and VM tags](#heading--work-with-machine-and-vm-tags)
- [Work with controller tags](#heading--work-with-controller-tags)
- [Work with block device tags](#heading--work-with-block-device-tags)
- [Work with partition tags](#heading--work-with-partition-tags)
- [Work with network tags](#heading--work-with-network-tags)
- [Work with device tags](#heading--work-with-device-tags)
- [Work with node tags (CLI only)](/t/-/2896#heading--work-with-node-tags)
rad-end
rad-begin /deb/3.0/ui
- [Work with tags in general](#heading--work-with-tags-in-general)
- [Work with machine and VM tags](#heading--work-with-machine-and-vm-tags)
- [Work with controller tags](#heading--work-with-controller-tags)
- [Work with block device tags](#heading--work-with-block-device-tags)
- [Work with partition tags](#heading--work-with-partition-tags)
- [Work with network tags](#heading--work-with-network-tags)
- [Work with device tags](#heading--work-with-device-tags)
- [Work with node tags (CLI only)](/t/-/4023#heading--work-with-node-tags)
rad-end
rad-begin /snap/2.9/ui
- [Work with tags in general](#heading--work-with-tags-in-general)
- [Work with machine and VM tags](#heading--work-with-machine-and-vm-tags)
- [Work with controller tags](#heading--work-with-controller-tags)
- [Work with block device tags](#heading--work-with-block-device-tags)
- [Work with partition tags](#heading--work-with-partition-tags)
- [Work with network tags](#heading--work-with-network-tags)
- [Work with device tags](#heading--work-with-device-tags)
- [Work with node tags (CLI only)](/t/-/2890#heading--work-with-node-tags)
rad-end
rad-begin /snap/3.0/ui
- [Work with tags in general](#heading--work-with-tags-in-general)
- [Work with machine and VM tags](#heading--work-with-machine-and-vm-tags)
- [Work with controller tags](#heading--work-with-controller-tags)
- [Work with block device tags](#heading--work-with-block-device-tags)
- [Work with partition tags](#heading--work-with-partition-tags)
- [Work with network tags](#heading--work-with-network-tags)
- [Work with device tags](#heading--work-with-device-tags)
- [Work with node tags (CLI only)](/t/-/4021#heading--work-with-node-tags)
rad-end
rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui

Tags for these different objects have similar purposes, but they aren't necessarily administered in the same way -- so we've included detailed sections for each tag type.

** how to work with tags in general
<a href="#heading--work-with-tags-in-general"><h3 id="heading--work-with-tags-in-general">Work with tags in general</h3></a>

There are a few general procedures for working with tags, centred around naming conventions and basic mechanics.  These procedures apply to nearly all tag types.  They will be referenced often in the subsections that follow.

As a general rule, you'll want to know how to:

- [Name tags](#heading--name-tags)
- [Create and assign tags](#heading--create-and-assign-tags)
- [Delete and remove tags](#heading--delete-and-remove-tags)

*** how to name tags

** how to work with machine and vm tags
<a href="#heading--work-with-machine-and-vm-tags"><h3 id="heading--work-with-machine-and-vm-tags">Work with machine and VM tags</h3></a>

This subsection will show you how to:
rad-end

rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui

*** how to create and assign machine tags

** how to work with controller tags
** how to work with block device tags
<a href="#heading--work-with-block-device-tags"><h3 id="heading--work-with-block-device-tags">Work with block device tags</h3></a>

In the parlance of MAAS, a block device is generally an unassigned and unpartitioned physical or virtual disk. This subsection will show you how to:
 

- [Create and assign block device tags](#heading--create-and-assign-block-device-tags)
- [Remove and delete block device tags](#heading--remove-and-delete-block-device-tags)
- [List block device tags](#heading--list-block-device-tags)
- [View block device tags](#heading--view-block-device-tags)

*** how to create and assign block device tags
<a href="#heading--create-and-assign-block-device-tags"><h4 id="heading--create-and-assign-block-device-tags">Create and assign block device tags</h4></a>

In order to create and assign tags to a block device, the device has to be in an "available" state, with no active partitions. To create and assign tags to block devices:

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select that machine that has the block-device you want to tag:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png"></a>

3. Click on the "Storage" tab and focus on the block labelled "Available disks and partitions:"

<a href="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png"></a>

4. Click the drop-down arrow at the right end of the row containing the block device you want to tag. Choose the "Edit..." option (the wording may vary, e.g, "Edit physical..."). This will take you to an editing screen for that block device:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/2912877532c3ea0b744ff3c88c7ef2046598bebc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/2912877532c3ea0b744ff3c88c7ef2046598bebc.png"></a>

5. Add tags as described in the [general procedure](#heading--create-and-assign-tags).

6. Be sure to click on the "Save" button when you're done.

*** how to remove and delete block device tags
<a href="#heading--remove-and-delete-block-device-tags"><h4 id="heading--remove-and-delete-block-device-tags">Remove and delete block device tags</h4></a>

In order to remove tags from a block device, the device has to be in an "available" state, with no active partitions. To remove and delete tags from a block devices:

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select that machine that has the block-device with the tag you want to remove:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png"></a>

3. Click on the "Storage" tab and focus on the block labelled "Available disks and partitions:"

<a href="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/0b78891d0933af01489304c778c6168f2c6776f9.png"></a>

4. Click the drop-down arrow at the right end of the row containing the block device you want to tag. Choose the "Edit..." option (the wording may vary, e.g, "Edit physical..."). This will take you to an editing screen for that block device:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/2912877532c3ea0b744ff3c88c7ef2046598bebc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/2912877532c3ea0b744ff3c88c7ef2046598bebc.png"></a>

5. Delete tags by clicking the "X" next to them, as described in the [general procedure](#heading--create-and-assign-tags).

6. Be sure to click on the "Save" button when you're done.

*** how to list block device tags
<a href="#heading--list-block-device-tags"><h4 id="heading--list-block-device-tags">List block device tags</h4></a>
rad-end

rad-begin /deb/2.9/ui
There is no explicit way to list all block device tags in the UI; see the [MAAS CLI](/t/-/2896#heading--list-tags-for-all-block-devices) for a more comprehensive procedure. You can list all storage links, though -- block device and partition -- by using the filter tool on the machine list.  Here's how:
rad-end
rad-begin /deb/3.0/ui
There is no explicit way to list all block device tags in the UI; see the [MAAS CLI](/t/-/4023#heading--list-tags-for-all-block-devices) for a more comprehensive procedure. You can list all storage links, though -- block device and partition -- by using the filter tool on the machine list.  Here's how:
rad-end
rad-begin /snap/2.9/ui
There is no explicit way to list all block device tags in the UI; see the [MAAS CLI](/t/-/2890#heading--list-tags-for-all-block-devices) for a more comprehensive procedure. You can list all storage links, though -- block device and partition -- by using the filter tool on the machine list.  Here's how:
rad-end
rad-begin /snap/3.0/ui
There is no explicit way to list all block device tags in the UI; see the [MAAS CLI](/t/-/4021#heading--list-tags-for-all-block-devices) for a more comprehensive procedure. You can list all storage links, though -- block device and partition -- by using the filter tool on the machine list.  Here's how:
rad-end
rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select the "Filters" drop-down and open the section titled "Storage tags:"

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c03216c0c2b6097f73b8161922b602aac4fdc3d6.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c03216c0c2b6097f73b8161922b602aac4fdc3d6.png"></a>

Here you will see a list of all block device and partition tags currently assigned to machines in this MAAS.  If you wish to filter the machine list by a given tag, just make sure that it's checked (and other storage tags unchecked) in the filter list.

*** how to view block device tags
<a href="#heading--view-block-device-tags"><h4 id="heading--view-block-device-tags">View block device tags</h4></a>

To view all tags associated with block devices on a given machine:

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select that machine that has the block device that interests you:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png"></a>

3. Click on the "Storage" tab and check the page for tags:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/feb789078b8f5f2f6f23acc056f8c037381d2cfc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/feb789078b8f5f2f6f23acc056f8c037381d2cfc.png"></a>

** how to work with partition tags
<a href="#heading--work-with-partition-tags"><h3 id="heading--work-with-partition-tags">Work with partition tags</h3></a>

This subsection will show you how to:

rad-begin /deb/2.9/ui
- [Assign partition tags (CLI only)](/t/-/2896#heading--assign-tags-to-a-partition)
- [Remove partition tags (CLI only)](/t/-/2896#heading--remove-tags-from-a-partition)
- [List partition tags](#heading--list-partition-tags)
- [View partition tags](#heading--view-partition-tags)
rad-end
rad-begin /deb/3.0/ui
- [Assign partition tags (CLI only)](/t/-/4023#heading--assign-tags-to-a-partition)
- [Remove partition tags (CLI only)](/t/-/4023#heading--remove-tags-from-a-partition)
- [List partition tags](#heading--list-partition-tags)
- [View partition tags](#heading--view-partition-tags)
rad-end
rad-begin /snap/2.9/ui
- [Assign partition tags (CLI only)](/t/-/2890#heading--assign-tags-to-a-partition)
- [Remove partition tags (CLI only)](/t/-/2890#heading--remove-tags-from-a-partition)
- [List partition tags](#heading--list-partition-tags)
- [View partition tags](#heading--view-partition-tags)
rad-end
rad-begin /snap/3.0/ui
- [Assign partition tags (CLI only)](/t/-/4021#heading--assign-tags-to-a-partition)
- [Remove partition tags (CLI only)](/t/-/4021#heading--remove-tags-from-a-partition)
- [List partition tags](#heading--list-partition-tags)
- [View partition tags](#heading--view-partition-tags)
rad-end
rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui

*** how to list partition tags
<a href="#heading--list-partition-tags"><h4 id="heading--list-partition-tags">List partition tags</h4></a>

rad-end
rad-begin /deb/2.9/ui
There is no explicit way to list all partition tags in the UI; see the [MAAS CLI](/t/-/2896#heading--list-tags-for-all-partitions) for a more comprehensive procedure.
rad-end
rad-begin /deb/3.0/ui
There is no explicit way to list all partition tags in the UI; see the [MAAS CLI](/t/-/4023#heading--list-tags-for-all-partitions) for a more comprehensive procedure.
rad-end
rad-begin /snap/2.9/ui
There is no explicit way to list all partition tags in the UI; see the [MAAS CLI](/t/-/2890#heading--list-tags-for-all-partitions) for a more comprehensive procedure.
rad-end
rad-begin /snap/3.0/ui
There is no explicit way to list all partition tags in the UI; see the [MAAS CLI](/t/-/4021#heading--list-tags-for-all-partitions) for a more comprehensive procedure.
rad-end
rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui

You can list all storage links (block device and partition) by using the filter tool on the machine list.  Here's how:

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select the "Filters" drop-down and open the section titled "Storage tags:"

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c03216c0c2b6097f73b8161922b602aac4fdc3d6.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c03216c0c2b6097f73b8161922b602aac4fdc3d6.png"></a>

Here you will see a list of all block device and partition tags currently assigned to machines in this MAAS.

*** how to view partition tags
<a href="#heading--view-partition-tags"><h4 id="heading--view-partition-tags">View partition tags</h4></a>

To view all tags associated with partitions on a given machine:

1. Go to the machine list:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. Select that machine that has the block device that interests you:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9dc953000f245311b4e3f4751adb1d2973d0fe38.png"></a>

3. Click on the "Storage" tab and check the page for tags:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/feb789078b8f5f2f6f23acc056f8c037381d2cfc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/feb789078b8f5f2f6f23acc056f8c037381d2cfc.png"></a>

** how to work with network tags
<a href="#heading--work-with-network-tags"><h3 id="heading--work-with-network-tags">Work with network tags</h3></a>

This subsection will show you how to:
rad-end
rad-begin /deb/2.9/ui
- [Create and assign network interface tags](#heading--create-and-assign-network-interface-tags)
- [Remove and delete network interface tags](#heading--remove-and-delete-network-interface-tags)
- [List network interface tags (CLI only)](/t/-/2896#heading--list-tags-for-all-network-interfaces)
- [View network interface tags](#heading--view-network-interface-tags)
rad-end
rad-begin /deb/3.0/ui
- [Create and assign network interface tags](#heading--create-and-assign-network-interface-tags)
- [Remove and delete network interface tags](#heading--remove-and-delete-network-interface-tags)
- [List network interface tags (CLI only)](/t/-/4023#heading--list-tags-for-all-network-interfaces)
- [View network interface tags](#heading--view-network-interface-tags)
rad-end
rad-begin /snap/2.9/ui
- [Create and assign network interface tags](#heading--create-and-assign-network-interface-tags)
- [Remove and delete network interface tags](#heading--remove-and-delete-network-interface-tags)
- [List network interface tags (CLI only)](/t/-/2890#heading--list-tags-for-all-network-interfaces)
- [View network interface tags](#heading--view-network-interface-tags)
rad-end
rad-begin /snap/3.0/ui
- [Create and assign network interface tags](#heading--create-and-assign-network-interface-tags)
- [Remove and delete network interface tags](#heading--remove-and-delete-network-interface-tags)
- [List network interface tags (CLI only)](/t/-/4021#heading--list-tags-for-all-network-interfaces)
- [View network interface tags](#heading--view-network-interface-tags)
rad-end
rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui

*** how to create and assign network interface tags
<a href="#heading--create-and-assign-network-interface-tags"><h4 id="heading--create-and-assign-network-interface-tags">Create and assign network interface tags</h4></a>

To assign a tag to a network interface, use the following procedure:

1. Go to the machine list and select the machine where that interface resides, by clicking on that machine's name:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png"></a>

2. Click on the "Network" tab:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png"></a>

3. Choose the interface you'd like to tag, by selecting the checkbox next to its name:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png"></a>

>The checkbox isn't strictly needed to apply the tag, but it helps prevent you from choosing the wrong one when multiple interfaces are available.

4. Select the drop-down under "ACTIONS" at the end of the row, and select "Edit Physical" to edit the parameters of the physical interface:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png"></a>

5. Edit the "Tags" field as desired, as described in the [general tagging procedure](#heading--create-and-assign-tags) above.

6. Be sure to select the "Tag machine" button to apply your changes to the interface for that machine.

Note that different machines may have the same physical interface name, but different MAC addresses, so it's not typical that interface tags carry over from one machine to the next -- so auto complete menus will be sparse or non-existent most of the time for these tag types.

*** how to remove and delete network interface tags
<a href="#heading--remove-and-delete-network-interface-tags"><h4 id="heading--remove-and-delete-network-interface-tags">Remove and delete network interface tags</h4></a>

To remove a tag from a network interface, use the following procedure:

1. Go to the machine list and select the machine where that interface resides, by clicking on that machine's name:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png"></a>

2. Click on the "Network" tab:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png"></a>

3. Choose the interface you'd like to un-tag, by selecting the checkbox next to its name:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png"></a>

>The checkbox isn't strictly needed to apply the tag, but it helps prevent you from choosing the wrong one when multiple interfaces are available.

4. Select the drop-down under "ACTIONS" at the end of the row, and select "Edit Physical" to edit the parameters of the physical interface:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png"></a>

5. Edit the "Tags" field as desired, as described in the [general tagging procedure](#heading--create-and-assign-tags) above.

6. Be sure to select the "Tag machine" button to apply your changes to the interface for that machine.

Note that different machines may have the same physical interface name, but different MAC addresses, so it's not typical that interface tags carry over from one machine to the next -- so auto complete menus will be sparse or non-existent most of the time for these tag types.

*** how to view network interface tags
<a href="#heading--view-network-interface-tags"><h4 id="heading--view-network-interface-tags">View network interface tags</h4></a>

To view the tags associated with a network interface, use the following procedure:

1. Go to the machine list and select the machine where that interface resides, by clicking on that machine's name:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1030782316875c112b9e56586a79478a566fe33a.png"></a>

2. Click on the "Network" tab:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/9aebbe5708683d937c682e64e22c72d537629cf8.png"></a>

3. Choose the interface you'd like to see, by selecting the checkbox next to its name:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fb2fb338372ac16229dd9acf00aae545660865f2.png"></a>

>The checkbox isn't strictly needed to apply the tag, but it helps prevent you from choosing the wrong one when multiple interfaces are available.

4. Select the drop-down under "ACTIONS" at the end of the row, and select "Edit Physical" to edit the parameters of the physical interface:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8694d71a49ae8171ac2088005af8b71101894abb.png"></a>

5. Be sure to cancel the operation when you're done.

Note that different machines may have the same physical interface name, but different MAC addresses, so it's not typical that interface tags carry over from one machine to the next.

** how to work with device tags
<a href="#heading--work-with-device-tags"><h3 id="heading--work-with-device-tags">Work with device tags</h3></a>

This subsection will show you how to:
 
- [Create and assign device tags](#heading--create-and-assign-device-tags)
- [Remove and delete device tags](#heading--remove-and-delete-device-tags)
- [List device tags](#heading--list-device-tags)
- [View device tags](#heading--view-device-tags)

*** how to create and assign device tags
<a href="#heading--create-and-assign-device-tags"><h4 id="heading--create-and-assign-device-tags">Create and assign device tags</h4></a>

To add a tag to a device, follow this procedure:

1. Select the "Devices" tab; it may be in a drop-down labelled "Hardware," if your browser window is not very large:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/22b17d4827f82c103e958205011ca13934fe2f3f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/22b17d4827f82c103e958205011ca13934fe2f3f.png"></a>

2. Select the device you'd like to tag, by clicking on its name:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/94717b99a4cea205099e3fdfd492daefe683e68d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/94717b99a4cea205099e3fdfd492daefe683e68d.png"></a>

3. In the "Tags" card, select the "Edit" link, or choose the "Configuration" tab under the device name:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/901e7bd556f26560e44b4b74c41b506399e86375.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/901e7bd556f26560e44b4b74c41b506399e86375.png"></a>

4. Select the "Edit" button on the "Configuration" tab which comes up:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d80039410bfeba4b6feb35490ccf82b3be80904f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d80039410bfeba4b6feb35490ccf82b3be80904f.png"></a>

5. Edit the "Tags" field, as explained in the [general tagging procedure](#heading--create-assign-tag-general) above.

6. Be sure to hit the "Save changes" button to apply your changes to the device.

*** how to remove and delete device tags
<a href="#heading--remove-and-delete-device-tags"><h4 id="heading--remove-and-delete-device-tags">Remove and delete device tags</h4></a>

To remove a tag from a device, follow this procedure:

1. Select the "Devices" tab; it may be in a drop-down labelled "Hardware," if your browser window is not very large:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/22b17d4827f82c103e958205011ca13934fe2f3f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/22b17d4827f82c103e958205011ca13934fe2f3f.png"></a>

2. Select the device you'd like to un-tag, by clicking on its name:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/94717b99a4cea205099e3fdfd492daefe683e68d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/94717b99a4cea205099e3fdfd492daefe683e68d.png"></a>

3. In the "Tags" card, select the "Edit" link, or choose the "Configuration" tab under the device name:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/901e7bd556f26560e44b4b74c41b506399e86375.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/901e7bd556f26560e44b4b74c41b506399e86375.png"></a>

4. Select the "Edit" button on the "Configuration" tab which comes up:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d80039410bfeba4b6feb35490ccf82b3be80904f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d80039410bfeba4b6feb35490ccf82b3be80904f.png"></a>

5. Edit the "Tags" field, as explained in the [general tagging procedure](#heading--create-assign-tag-general) above.

6. Be sure to hit the "Save changes" button to apply your changes to the device.

*** how to list device tags
<a href="#heading--list-device-tags"><h4 id="heading--list-device-tags">List device tags</h4></a>

1. Go to the device list:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8748ed53d5a24425e808698c902a22536a08f994.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8748ed53d5a24425e808698c902a22536a08f994.png"></a>

2. Select the "Filters" drop-down and open the section titled "Tags:"

<a href="https://discourse.maas.io/uploads/default/original/2X/9/957ff8874fb8336335ec5073c14068f36a7aeeb6.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/957ff8874fb8336335ec5073c14068f36a7aeeb6.png"></a>

Here you will see a list of all device tags currently assigned to devices in this MAAS.

*** how to view device tags
<a href="#heading--view-device-tags"><h4 id="heading--view-device-tags">View device tags</h4></a>

1. Go to the device list:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8748ed53d5a24425e808698c902a22536a08f994.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8748ed53d5a24425e808698c902a22536a08f994.png"></a>

2. Select the device that has your interest by clicking on its name.  A device summary will appear:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/eadc32f46c714080005faa0be7f744d4143df379.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/eadc32f46c714080005faa0be7f744d4143df379.png"></a>

The "Tags" card on that screen with show you all the tags currently associated with this device.

* how to work with annotations
<a href="#heading--work-with-annotations"><h2 id="heading--work-with-annotations">Work with annotations</h2></a>

This section will explain how to:
rad-end
rad-begin /snap/3.0/ui /deb/3.0/ui 

- [Work with static annotations](#heading--work-with-static-annotations)
- [Work with dynamic (workload) annotations](#heading--work-with-dynamic-workload-annotations)

** how to work with static annotations
<a href="#heading--work-with-static-annotations"><h3 id="heading--work-with-static-annotations">Work with static annotations</h3></a>

This subsection will show you how to:
rad-end
rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
 
- [Create and assign static annotations](#heading--create-and-assign-static-annotations)
- [Delete static annotations](#heading--delete-static-annotations)
- [View static annotations](#heading--view-static-annotations)

*** how to create and assign static annotations
<a href="#heading--create-and-assign-static-annotations"><h4 id="heading--create-and-assign-static-annotations">Create and assign static annotations</h4></a>

To create and assign static annotations (a note) to a machine, follow this procedure:

1. Go to the machine list and click on the machine of interest:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. This will bring up a machine summary for that machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png"></a>

3. Select "Configuration" and click the "Edit" button to the right of the "Machine configuration" section:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png"></a>

4. Add free-form notes in the "Note" field, as desired.

5. Click "Save changes" to update the machine's configuration.

*** how to delete static annotations
<a href="#heading--delete-static-annotations"><h4 id="heading--delete-static-annotations">Delete static annotations</h4></a>

To delete static annotations (a note) from a machine, follow this procedure:

1. Go to the machine list and click on the machine of interest:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. This will bring up a machine summary for that machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png"></a>

3. Select "Configuration" and click the "Edit" button to the right of the "Machine configuration" section:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png"></a>

4. Edit the free-form notes in the "Note" field, as desired.

5. Click "Save changes" to update the machine's configuration.

*** how to view static annotations
<a href="#heading--view-static-annotations"><h4 id="heading--view-static-annotations">View static annotations</h4></a>

To view static annotations, you can follow this procedure:

1. Go to the machine list and look at the machine of interest; you should see the first few characters of a note in the bottom half of the column marked "POOL/NOTE:"

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3286feef733f4b56a94708d3af044c1523e78369.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3286feef733f4b56a94708d3af044c1523e78369.png"></a>

2. Click on the machine, which will bring up a machine summary for that machine. Switch to the configuration tab to see the full note:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e9a324a428a3374b616b2986ee5f56d13eb1e07d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e9a324a428a3374b616b2986ee5f56d13eb1e07d.png"></a>

rad-end

rad-begin /snap/3.0/ui /deb/3.0/ui
** how to work with dynamic workload annotations
<a href="#heading--work-with-dynamic-workload-annotations"><h3 id="heading--work-with-dynamic-workload-annotations">Work with dynamic (workload) annotations</h3></a>
 
This subsection will show you how to:

rad-end
rad-begin /deb/3.0/ui 
- [Create dynamic (workload) annotations (CLI only)](/t/-/4023#heading--set-dynamic-annotations-for-a-machine)
- [Delete dynamic (workload) annotations (CLI only)](/t/-/4023#heading--clear-and-change-dynamic-annotations-for-a-machine)
- [View dynamic (workload) annotations for one machine](#heading--view-dynamic-workload-annotations-for-one-machine)
- [Filter on dynamic (workload) annotations](#heading--filter-on-dynamic-workload-annotations)
rad-end
rad-begin /snap/3.0/ui 
- [Create dynamic (workload) annotations (CLI only)](/t/-/4021#heading--set-dynamic-annotations-for-a-machine)
- [Delete dynamic (workload) annotations (CLI only)](/t/-/4021#heading--clear-and-change-dynamic-annotations-for-a-machine)
- [View dynamic (workload) annotations for one machine](#heading--view-dynamic-workload-annotations-for-one-machine)
- [Filter on dynamic (workload) annotations](#heading--filter-on-dynamic-workload-annotations)
rad-end

rad-begin /snap/3.0/ui /deb/3.0/ui
*** how to view dynamic workload annotations for one machine
<a href="#heading--view-dynamic-workload-annotations-for-one-machine"><h4 id="heading--view-dynamic-workload-annotations-for-one-machine">View dynamic (workload) annotations for one machine</h4></a>

To view the dynamic (workload) annotations for one machine, do the following:

1. Go to the machine list and select the machine of interest by clicking on its hyperlinked name.

2. In the machine summary that comes up, look for the "Workload Annotations" card, in the lower, right-hand corner:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e7def7a50f9c854f7aae0efc34897338c46c32c0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e7def7a50f9c854f7aae0efc34897338c46c32c0.png"></a>

<a href="#heading--filter-on-dynamic-workload-annotations"><h4 id="heading--filter-on-dynamic-workload-annotations">Filter on dynamic (workload) annotations</h4></a>

To filter machines by dynamic (workload) annotations, use the following procedure:

1. Go to the machine list and select the "Filter" drop-down; open the "Workload" segment:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/946fb41e9cefb10a0b59787ce22b70a91b248d01.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/946fb41e9cefb10a0b59787ce22b70a91b248d01.jpeg"></a>

2. Select one or more values from this list to filter the machine list by these workload annotations.

rad-end

rad-begin     /snap/2.9/cli /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli

* how to work with tags
<a href="#heading--work-with-tags"><h2 id="heading--work-with-tags">Work with tags</h2></a>

This section is devoted to procedures for working with tags.  We begin with some general operations that apply to all tags types, such as naming conventions and basic mechanics.  We then walk through the various tag types, providing procedures that will help you create, assign, remove, delete, list, view, and filter tags, covering the nuances of each type.

Specifically, this section will show you how to:

- [Work with tags, independent of application](#heading--work-with-tags-independent-of-application)
- [Work with machine tags](#heading--work-with-machine-tags)
- [Work with virtual machine host tags](#heading--work-with-virtual-machine-host-tags)
- [Work with region controller tags](#heading--work-with-region-controller-tags)
- [Work with rack controller tags](#heading--work-with-rack-controller-tags)
- [Work with block device tags](#heading--work-with-block-device-tags)
- [Work with partition tags](#heading--work-with-partition-tags)
- [Work with network tags](#heading--work-with-network-tags)
- [Work with device tags](#heading--work-with-device-tags)
- [Work with node tags](#heading--work-with-node-tags)

** how to work with tags, independent of application
<a href="#heading--work-with-tags-independent-of-application"><h3 id="heading--work-with-tags-independent-of-application">Work with tags, independent of application</h3></a>

This subsection will explain how to:

- [Create a tag](#heading--create-a-tag)
- [Create tags with built-in kernel options](#heading--create-tags-with-built-in-kernel-options)
- [Delete a tag](#heading--delete-a-tag)
- [Update a tag](#heading--update-a-tag)
- [List all tags available on this MAAS](#heading--list-all-tags-available-on-this-maas)
- [Rebuild a tag](#heading--rebuild-a-tag)



** how to work with machine tags

** how to work with region controller tags


** how to work with block device tags
<a href="#heading--work-with-block-device-tags"><h3 id="heading--work-with-block-device-tags">Work with block device tags</h3></a>

This subsection will show you how to:

- [Discover the ID of your block device](#heading--discover-the-id-of-your-block-device) 
- [Assign tags to a block device](#heading--assign-tags-to-a-block-device)
- [Remove tags from a block device](#heading--remove-tags-from-a-block-device)
- [List tags for all block devices](#heading--list-tags-for-all-block-devices)
- [View tags for one block device](#heading--view-tags-for-one-block-device)

<a href="#heading--discover-the-id-of-your-block-device"><h4 id="heading--discover-the-id-of-your-block-device">Discover the ID of your block device</h4></a>

Block devices do not exist apart from the physical or virtual machines to which they are attached.  Finding the ID of the block device that interests you requires starting with a particular machine, in a command form that looks like this:

```bash
maas $PROFILE block-devices read $SYSTEM_ID \
| jq -r '(["system_id","block_device_id","path","avail_size"]
|(.,map(length*"-"))),(.[]|[.system_id,.id,.path,.available_size])
| @tsv' | column -t
```

For example:

```bash
maas admin block-devices read qk4b3g \
| jq -r '(["system_id","block_device_id","path","avail_size"]
|(.,map(length*"-"))),(.[]|[.system_id,.id,.path,.available_size])
| @tsv' | column -t
```

This example would produce output that looks something like this:

```nohighlight
system_id  block_device_id  path                    avail_size
---------  ---------------  ----                    ----------
qk4b3g     10               /dev/disk/by-dname/sda  0
```

The `path` component is printed to help you confirm that you are choosing the right block device, when there are several present.  The `avail-size` column will tell you whether you can operate on that block device at all: If the available size is "0," for example, you can't set a block device tag on any part of that drive.  Instead, you'd want to see something like this:

```nohighlight
system_id  block_device_id  path                    avail_size
---------  ---------------  ----                    ----------
xn8taa     8                /dev/disk/by-dname/sda  1996488704
```

<a href="#heading--assign-tags-to-a-block-device"><h4 id="heading--assign-tags-to-a-block-device">Assign tags to a block device</h4></a>

You can only assign tags to a block device that is available. You can find out whether the block device is available at all when you [discover its ID](#heading--discover-the-id-of-your-block-device).

To assign an existing tag to a block device, you would type a command formulated like this:

```bash
maas $PROFILE block-device add-tag $SYSTEM_ID $BLOCK_DEVICE_ID tag=$TAG_NAME
```

If you're not sure about the ID of your block device, you can [look it up](#heading--discover-the-id-of-your-block-device).

For example:

```
maas admin block-device add-tag xn8taa 8 tag=farquar
```

If this command succeeds, it will display `Success`, followed by a JSON sequence describing the new state of the block device.

Note that if you try to add a tag to a block device that is not available, that is, to a block device that is in use, you will get a result like this:

```nohighlight
Not Found
```

<a href="#heading--remove-tags-from-a-block-device"><h4 id="heading--remove-tags-from-a-block-device">Remove tags from a block device</h4></a>

You can only remove tags from a block device that is available. You can find out whether the block device is available at all when you [discover its ID](#heading--discover-the-id-of-your-block-device).

To remove an assigned tag from a block device, you would type a command formulated like this:

```bash
maas $PROFILE block-device remove-tag $SYSTEM_ID $BLOCK_DEVICE_ID tag=$TAG_NAME
```

If you're not sure about the ID of your block device, you can [look it up](#heading--discover-the-id-of-your-block-device).

For example:

```
maas admin block-device remove-tag xn8taa 8 tag=farquar
```

If this command succeeds, it will display `Success`, followed by a JSON sequence describing the new state of the block device.

Note that if you try to remove a tag from a block device that is not available, that is, to a block device that is in use, you will get a result like this:

```nohighlight
Not Found
```

<a href="#heading--list-tags-for-all-block-devices"><h4 id="heading--list-tags-for-all-block-devices">List tags for all block devices</h4></a>

To list tags for all block devices associated with a physical or virtual machine, you can use a command of this form:

```bash
maas $PROFILE block-devices read $SYSTEM_ID | jq -r '(["id","tags"]|(.,map(length*"-"))),(.[]|[.id,.tags[]]) | @tsv' | column -t
```

For example:

```bash
maas admin block-devices read xn8taa | jq -r '(["id","tags"]|(.,map(length*"-"))),(.[]|[.id,.tags[]]) | @tsv' | column -t
```

This command would produce output similar to this:

```nohighlight
id  tags
--  ----
8   hello  ssd  trinkoplinko
```

<a href="#heading--view-tags-for-one-block-device"><h4 id="heading--view-tags-for-one-block-device">View tags for one block device</h4></a>

To view tags for one specific block device, you can enter a command like this:

```bash
maas $PROFILE block-device read $SYSTEM_ID $BLOCK_DEVICE_ID | jq -r '(["id","tags"]|(.,map(length*"-"))),([.id,.tags[]]) | @tsv' | column -t
```

If you're not sure about the ID of your block device, you can [look it up](#heading--discover-the-id-of-your-block-device).

For example:

```bash
maas admin block-device read xn8taa 8 | jq -r '(["id","tags"]|(.,map(length*"-"))),([.id,.tags[]]) | @tsv' | column -t
```

This command would produce output similar to this:

```nohighlight
id  tags
--  ----
8   hello  ssd  trinkoplinko
9   20gig  ssd
10  250Gs  ssd
```

** how to work with partition tags
<a href="#heading--work-with-partition-tags"><h3 id="heading--work-with-partition-tags">Work with partition tags</h3></a>

This subsection will show you how to:

- [Discover the ID of your partition](#heading--discover-the-id-of-your-partition)
- [Assign tags to a partition](#heading--assign-tags-to-a-partition)
- [Remove tags from a partition](#heading--remove-tags-from-a-partition)
- [List tags for all partitions](#heading--list-tags-for-all-partitions)
- [View tags for one partition](#heading--view-tags-for-one-partition)

<a href="#heading--discover-the-id-of-your-partition"><h4 id="heading--discover-the-id-of-your-partition">Discover the ID of your partition</h4></a>

Partitions do not exist apart from the block devices on which they reside.  Finding the ID of the partition that interests you requires starting with a particular machine and block device, similar to this command:

```bash
maas $PROFILE partitions read $SYSTEM_ID $BLOCK_DEVICE_ID \
| jq -r '(["system_id","block_dev_id","part_id","path"]
|(.,map(length*"-"))),(.[]|[.system_id,.device_id,.id,.path])
|@tsv' | column -t
```

For example:

```bash
maas admin partitions read xn8taa 8 \
| jq -r '(["system_id","block_dev_id","part_id","path"]
|(.,map(length*"-"))),(.[]|[.system_id,.device_id,.id,.path])
|@tsv' | column -t
 ```

This example would produce output that looks something like this:

```nohighlight
system_id  block_dev_id  part_id  path
---------  ------------  -------  ----
xn8taa     8             67       /dev/disk/by-dname/sda-part1
```

The `path` component is printed to help you confirm that you are choosing the right partition, when there are several present.  

<a href="#heading--assign-tags-to-a-partition"><h4 id="heading--assign-tags-to-a-partition">Assign tags to a partition</h4></a>

You can only assign tags to a partition that is available.  To assign an existing tag to a partition, you would type a command formulated like this:

```bash
maas $PROFILE partition add-tag $SYSTEM_ID $BLOCK_DEVICE_ID $PARTITION_ID tag=$TAG_NAME
```

If you're not sure about the ID of your partition, you can [look it up](#heading--discover-the-id-of-your-partition).

For example:

```bash
maas admin partition add-tag xn8taa 8 67 tag=farquar
```

If this command succeeds, it will display `Success`, followed by a JSON sequence describing the new state of the partition.

Note that if you try to add a tag to a partition that is not available, that is, to a partition that is in use, you will get a result like this:

```nohighlight
Not Found
```

<a href="#heading--remove-tags-from-a-partition"><h4 id="heading--remove-tags-from-a-partition">Remove tags from a partition</h4></a>

You can only remove tags from a partition that is available.  To remove a existing tag from a partition, you would type a command formulated like this:

```bash
maas $PROFILE partition remove-tag $SYSTEM_ID $BLOCK_DEVICE_ID $PARTITION_ID tag=$TAG_NAME
```

If you're not sure about the ID of your partition, you can [look it up](#heading--discover-the-id-of-your-partition).

For example:

```bash
maas admin partition remove-tag xn8taa 8 67 tag=farquar
```

If this command succeeds, it will display `Success`, followed by a JSON sequence describing the new state of the partition.

Note that if you try to remove a tag from a partition that is not available, that is, to a partition that is in use, you will get a result like this:

```nohighlight
Not Found
```

On the other hand, if you try to remove a tag that is not assigned to the partition you've chosen, MAAS will simply return `Success`, followed by a JSON sequence describing the current state of the partition.

<a href="#heading--list-tags-for-all-partitions"><h4 id="heading--list-tags-for-all-partitions">List tags for all partitions</h4></a>

To list tags for all partitions of a particular block device, use a command like this one:

```bash
maas $PROFILE partitions read $SYSTEM_ID $BLOCK_DEVICE_ID \
| jq -r '(["id","tags"]
|(.,map(length*"-"))),(.[]|[.id,.tags[]])
| @tsv' | column -t
```

For example:

```bash
maas admin partitions read xn8taa 8 \
| jq -r '(["id","tags"]
|(.,map(length*"-"))),(.[]|[.id,.tags[]])
| @tsv' | column -t
```

A command like this should return output similar to the following:

```nohighlight
id  tags
--  ----
54  farquar swap opendisk
67  foobar  farquar
97  foobar
```

<a href="#heading--view-tags-for-one-partition"><h4 id="heading--view-tags-for-one-partition">View tags for one partition</h4></a>

To view tags for one partition, enter a command similar to this:

```bash
maas $PROFILE partition read $SYSTEM_ID $BLOCK_DEVICE_ID $PARTITION_ID | jq -r '(["id","tags"]|(.,map(length*"-"))),([.id,.tags[]]) | @tsv' | column -t
```

If you're not sure about the ID of your partition, you can [look it up](#heading--discover-the-id-of-your-partition).

For example:

```bash
maas admin partition read xn8taa 8 67 | jq -r '(["id","tags"]|(.,map(length*"-"))),([.id,.tags[]]) | @tsv' | column -t
```

This command should produce output similar to this:

```nohighlight
id  tags
--  ----
67  foobar  farquar
```
** how to work with network tags
<a href="#heading--work-with-network-tags"><h3 id="heading--work-with-network-tags">Work with network tags</h3></a>

This subsection will show you how to:

- [Discover the ID of your network interface](#heading--discover-the-id-of-your-network-interface)
- [Assign tags to a network interface](#heading--assign-tags-to-a-network-interface)
- [Remove tags from a network interface](#heading--remove-tags-from-a-network-interface)
- [List tags for all network interfaces](#heading--list-tags-for-all-network-interfaces)
- [View tags for one network interface](#heading--view-tags-for-one-network-interface)

<a href="#heading--discover-the-id-of-your-network-interface"><h4 id="heading--discover-the-id-of-your-network-interface">Discover the ID of your network interface</h4></a>

You can use a command of the following form to identify the interfaces associated with a particular device on your MAAS:

```bash
maas $PROFILE interfaces read $SYSTEM_ID \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),(.[]|[.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

For example:

```bash
maas admin interfaces read xn8taa \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),(.[]|[.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

This would produce output similar to the following:

```nohighlight
mac_address        type      id  tags
-----------        ----      --  ----
00:16:3e:18:7f:ee  physical  9   andrpko  plinko  cochise
```

<a href="#heading--assign-tags-to-a-network-interface"><h4 id="heading--assign-tags-to-a-network-interface">Assign tags to a network interface</h4></a>

To assign a tag to a network interface, using both the device system ID and the interface ID, use a command of the following form:

```bash
maas $PROFILE interface add-tag $SYSTEM_ID $INTERFACE_ID tag=$TAG_NAME
```

For example:

```bash
maas admin interface add-tag xn8taa 9 tag=farquar
```

This command, if successful, will produce a long sequence of JSON describing the interface, including the changes introduced by the command above.  You can also check your work by [listing the tags](#heading--list-tags-for-all-network-interfaces) associated with the device.

<a href="#heading--remove-tags-from-a-network-interface"><h4 id="heading--remove-tags-from-a-network-interface">Remove tags from a network interface</h4></a>

To remove a tag from a network interface, use both the device system ID and the interface ID in a command similar to this one:

```bash
maas $PROFILE interface remove-tag $SYSTEM_ID $INTERFACE_ID tag=$TAG_NAME
```

For example:

```bash
maas admin interface remove-tag xn8taa 9 tag=farquar
```

This command, if successful, will produce a long sequence of JSON describing the interface, including the changes introduced by the command above.  You can also check your work by [listing the tags](#heading--list-tags-for-all-network-interfaces) associated with the device.

<a href="#heading--list-tags-for-all-network-interfaces"><h4 id="heading--list-tags-for-all-network-interfaces">List tags for all network interfaces</h4></a>

To list all the tags for a given network interface on a given device, use a command like this one:

```bash
maas $PROFILE interfaces read $SYSTEM_ID \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),(.[]|[.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

For example:

```bash
maas admin interfaces read xn8taa \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),(.[]|[.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

This would produce output similar to the following:

```nohighlight
mac_address        type      id  tags
-----------        ----      --  ----
00:16:3e:18:7f:ee  physical  9   andrpko  plinko  cochise  farquar
```

<a href="#heading--view-tags-for-one-network-interface"><h4 id="heading--view-tags-for-one-network-interface">View tags for one network interface</h4></a>

To view tags for one particular network interface on a specific device, try a command formulated like this:

```bash
maas $PROFILE interface read $SYSTEM_ID $INTERFACE_ID \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),([.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

For example:

```bash
maas admin interface read xn8taa 9 \
| jq -r '(["mac_address","type","id","tags"]
|(.,map(length*"-"))),([.mac_address,.type,.id,.tags[]])
|@tsv'| column -t
```

Typical output might look like this:

```nohighlight
mac_address        type      id  tags
-----------        ----      --  ----
00:16:3e:18:7f:ee  physical  9   andrpko  plinko  cochise
```
** how to work with device tags
<a href="#heading--work-with-device-tags"><h3 id="heading--work-with-device-tags">Work with device tags</h3></a>

This subsection will show you how to:

- [Identify your devices](#heading--identify-your-devices)
- [Assign tags to a device](#heading--assign-tags-to-a-device)
- [Remove tags from a device](#heading--remove-tags-from-a-device)
- [List tags for all devices](#heading--list-tags-for-all-devices)
- [View tags for one device](#heading--view-tags-for-one-device)

<a href="#heading--identify-your-devices"><h4 id="heading--identify-your-devices">Identify your devices</h4></a>

You can use a command similar to the following to identify your devices:

```bash
maas $PROFILE devices read \
| jq -r '(["hostname","system_id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
|@tsv' | column -t
```

For example:

```bash
maas admin devices read \
| jq -r '(["hostname","system_id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
|@tsv' | column -t
```

This command produces a result similar to the following:

```nohighlight
hostname     system_id
--------     ---------
better-sole  t8pmrs
light-aphid  76b6tt
```

<a href="#heading--assign-tags-to-a-device"><h4 id="heading--assign-tags-to-a-device">Assign tags to a device</h4></a>

To assign tags to a device, you can use a command of the following form:

```
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID
```

For example:

```bash
maas admin tag update-nodes farquar add=t8pmrs
```

A successful command like this might produce output similar to this:

```
Success.
Machine-readable output follows:
{
    "added": 1,
    "removed": 0
}
```

You can also check your work by [listing tags for all devices](#heading--list-tags-for-all-devices).

<a href="#heading--remove-tags-from-a-device"><h4 id="heading--remove-tags-from-a-device">Remove tags from a device</h4></a>

To remove tags from a device, you can use a command of the following form:

```
maas $PROFILE tag update-nodes $TAG_NAME remove=$SYSTEM_ID
```

For example:

```bash
maas admin tag update-nodes farquar remove=t8pmrs
```

A successful command like this might produce output similar to this:

```nohighlight
Success.
Machine-readable output follows:
{
    "added": 0,
    "removed": 1
}
```

You can also check your work by [listing tags for all devices](#heading--list-tags-for-all-devices).

<a href="#heading--list-tags-for-all-devices"><h4 id="heading--list-tags-for-all-devices">List tags for all devices</h4></a>

If you want to list tags for all devices, you could use a command similar to this one:

```bash
maas $PROFILE devices read \
| jq -r '(["hostname","system_id","tags"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]])
|@tsv' | column -t
```

For example:

```bash
maas admin devices read \
| jq -r '(["hostname","system_id","tags"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]])
|@tsv' | column -t
```

Such a command would produce output that looks something like this:

```nohighlight
hostname     system_id  tags
--------     ---------  ----
better-sole  t8pmrs     farquar
light-aphid  76b6tt
```

<a href="#heading--view-tags-for-one-device"><h4 id="heading--view-tags-for-one-device">View tags for one device</h4></a>

You can view the tags for a single device with the command:

```bash
maas $PROFILE device read $SYSTEM_ID \
| jq -r '(["hostname","system_id","tags"]
|(.,map(length*"-"))),([.hostname,.system_id,.tag_names[]])
|@tsv' | column -t
```

If you need to know the system ID of your device, you can [look it up](#heading--identify-your-devices).

[note]
Note that this command differs in that (1) it uses the singular "device" instead of "devices;" (2) it gives the system ID of a specific device; and (3) it uses the single-record form of the ```jq``` tag list ("([.hostname,.system_id,.tag_names[]]", rather than "(.[]|[.hostname....").
[/note]

For example:

```bash
maas admin device read t8pmrs \
| jq -r '(["hostname","system_id","tags"]
|(.,map(length*"-"))),([.hostname,.system_id,.tag_names[]])
|@tsv' | column -t
```

Sample output might look like this:

```nohighlight
hostname     system_id  tags
--------     ---------  ----
better-sole  t8pmrs     farquar
```
** how to work with node tags
<a href="#heading--work-with-node-tags"><h3 id="heading--work-with-node-tags">Work with node tags</h3></a>

- [Identify your nodes](#heading--identify-your-nodes)
- [Assign tags to a node](#heading--assign-tags-to-a-node)
- [Remove tags from a node](#heading--remove-tags-from-a-node)
- [List tags for all nodes](#heading--list-tags-for-all-nodes)
- [View tags for one node](#heading--view-tags-for-one-node)

<a href="#heading--identify-your-nodes"><h4 id="heading--identify-your-nodes">Identify your nodes</h4></a>

If you need to identify the system ID of your nodes, you can do so with a command like this one:

```bash
maas $PROFILE nodes read \
| jq -r '(["hostname","system_id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
|@tsv'|column -t
```

For example:

```bash
```

When listing nodes, you should expect a large output, similar to this or larger:

```nohighlight
hostname                     system_id
--------                     ---------
better-sole                  t8pmrs
light-aphid                  76b6tt
divine-stork                 8b3ypp
casual-prawn                 4end6r
driven-teal                  tgaat6
immune-beetle                43xand
good-osprey                  napfxk
smart-hen                    c4rwq7
boss-satyr                   xn8taa
golden-martin                8fxery
crack-guinea                 qk4b3g
finer-leech                  cy3dtr
free-mouse                   gxtbq4
humble-bunny                 srqnnb
wanted-muskox                ekw7fh
one-boa                      by477d
great-urchin                 srnx4g
ace-frog                     g6arwg
alive-marlin                 gbwnfb
picked-parrot                am77wn
tough-kit                    ke3wc7
legal-whale                  8nq3mt
game-sponge                  76pdc6
fun-ghoul                    qxfm7k
aware-earwig                 8m8hs7
chief-crane                  7fapx7
select-tapir                 4ascbr
on-slug                      snfs8d
polite-llama                 dbqd4m
frank-coyote                 wcmk48
usable-condor                ed8hmy
still-imp                    h6ra6d
bill-Lenovo-Yoga-C740-15IML  86xya8
```

A node listing will show all the machines, controllers, and devices in the system.

<a href="#heading--assign-tags-to-a-node"><h4 id="heading--assign-tags-to-a-node">Assign tags to a node</h4></a>

To assign tags to any node (regardless of its type), you can use a command of this form:

'''bash
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID
'''

For example, 

```
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID
```

For example:

```bash
maas admin tag update-nodes farquar add=t8pmrs
```

A successful command like this might produce output similar to this:

```
Success.
Machine-readable output follows:
{
    "added": 1,
    "removed": 0
}
```

You can also check your work by [listing tags for all devices](#heading--list-tags-for-all-nodes).

<a href="#heading--remove-tags-from-a-node"><h4 id="heading--remove-tags-from-a-node">Remove tags from a node</h4></a>

To remove tags from a node, regardless of type, you can use a command like this one:

```
maas $PROFILE tag update-nodes $TAG_NAME remove=$SYSTEM_ID
```

For example:

```bash
maas admin tag update-nodes farquar remove=t8pmrs
```

A successful command like this might produce output similar to this:

```nohighlight
Success.
Machine-readable output follows:
{
    "added": 0,
    "removed": 1
}
```

You can also check your work by [listing tags for all devices](#heading--list-tags-for-all-nodes).

<a href="#heading--list-tags-for-all-nodes"><h4 id="heading--list-tags-for-all-nodes">List tags for all nodes</h4></a>

If you want to list tags for all nodes, you could use a command similar to this one:

```bash
maas $PROFILE nodes read \
| jq -r '(["hostname","system_id","tags"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]])
|@tsv' | column -t
```

For example:

```bash
maas admin nodes read \
| jq -r '(["hostname","system_id","tags"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.tag_names[]])
|@tsv' | column -t
```

Such a command would produce output that looks something like this:

```nohighlight
hostname                     system_id  tags
--------                     ---------  ----
better-sole                  t8pmrs     farquar
light-aphid                  76b6tt
divine-stork                 8b3ypp     pod-console-logging  virtual
casual-prawn                 4end6r     pod-console-logging  virtual
driven-teal                  tgaat6     pod-console-logging  virtual
immune-beetle                43xand     pod-console-logging  virtual
good-osprey                  napfxk     pod-console-logging  virtual
smart-hen                    c4rwq7     pod-console-logging  virtual
boss-satyr                   xn8taa     pod-console-logging  androko
golden-martin                8fxery     pod-console-logging  virtual
crack-guinea                 qk4b3g     pod-console-logging  virtual
finer-leech                  cy3dtr     pod-console-logging  virtual
free-mouse                   gxtbq4     pod-console-logging  virtual
humble-bunny                 srqnnb     pod-console-logging  virtual
wanted-muskox                ekw7fh     pod-console-logging  virtual
one-boa                      by477d     pod-console-logging  virtual
great-urchin                 srnx4g     pod-console-logging  virtual
ace-frog                     g6arwg     pod-console-logging  virtual  farquar
alive-marlin                 gbwnfb     pod-console-logging  virtual
picked-parrot                am77wn     pod-console-logging  virtual
tough-kit                    ke3wc7     pod-console-logging  virtual
legal-whale                  8nq3mt     pod-console-logging  virtual
game-sponge                  76pdc6     pod-console-logging  virtual
fun-ghoul                    qxfm7k     pod-console-logging  virtual
aware-earwig                 8m8hs7     pod-console-logging  virtual
chief-crane                  7fapx7     pod-console-logging  virtual
select-tapir                 4ascbr     pod-console-logging  virtual
on-slug                      snfs8d     pod-console-logging  virtual
polite-llama                 dbqd4m     pod-console-logging  virtual
frank-coyote                 wcmk48     pod-console-logging  virtual
usable-condor                ed8hmy     pod-console-logging  virtual
still-imp                    h6ra6d     pod-console-logging  virtual
bill-Lenovo-Yoga-C740-15IML  86xya8     lxd-vm-host
```

<a href="#heading--view-tags-for-one-node"><h4 id="heading--view-tags-for-one-node">View tags for one node</h4></a>

You could use a command with a form like this to view the tags for one node:

```bash
maas $PROFILE node read $SYSTEM_ID \
| jq -r '(["hostname","system_id","tags"]
|(.,map(length*"-"))),([.hostname,.system_id,.tag_names[]])
|@tsv' | column -t
```

For example:

```bash
maas admin node read xn8taa \
| jq -r '(["hostname","system_id","tags"]
|(.,map(length*"-"))),([.hostname,.system_id,.tag_names[]])
|@tsv' | column -t
```

This command produces output that looks something like this:

```nohighlight
hostname    system_id  tags
--------    ---------  ----
boss-satyr  xn8taa     pod-console-logging  androko
```

rad-end
rad-begin     /snap/2.9/cli /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli

* how to work with annotations
<a href="#heading--work-with-annotations"><h2 id="heading--work-with-annotations">Work with annotations</h2></a>

This section will show you how to:

- [Work with static annotations](#heading--work-with-static-annotations)
- [Work with dynamic (workload) annotations](#heading--work-with-dynamic-workload-annotations)

** how to work with static annotations
<a href="#heading--work-with-static-annotations"><h3 id="heading--work-with-static-annotations">Work with static annotations</h3></a>

This subsection will show you how to:

- [Identify your machines](#heading--identify-your-machines)
- [Set a static annotation for a machine](#heading--set-a-static-annotation-for-a-machine)
- [Change or clear a static annotation for a machine](#heading--change-or-clear-a-static-annotation-for-a-machine)
- [List static annotations for all machines](#heading--list-static-annotations-for-all-machines)
- [View a static annotation for one machine](#heading--view-a-static-annotation-for-one-machine)


<a href="#heading--identify-your-machines"><h4 id="heading--identify-your-machines">Identify your machines</h4></a>

To identify your available machines, use a command like this one:

```bash
maas $PROFILE machines read \
| jq -r '(["hostname","system_id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
|@tsv' | column -t
```

For example:

```bash
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

<a href="#heading--set-a-static-annotation-for-a-machine"><h4 id="heading--set-a-static-annotation-for-a-machine">Set a static annotation for a machine</h4></a>

If you want to set the static annotation for a given machine, you can do so with a command that looks like this:

```bash
maas $PROFILE machine update $SYSTEM_ID description="$STATIC_ANNOTATION"
```

For example:

```bash
maas admin machine update ke3wc7 description="kilo-echo-3-whisky-charlie-7"
```

You can check your work by [viewing the static annotations for one machine](#heading--view-a-static-annotation-for-one-machine).

<a href="#heading--change-or-clear-a-static-annotation-for-a-machine"><h4 id="heading--change-or-clear-a-static-annotation-for-a-machine">Change or clear a static annotation for a machine</h4></a>

If you want to set the static annotation for a given machine, use the same command you'd use to set a static annotation:

```bash
maas $PROFILE machine update $SYSTEM_ID description="$STATIC_ANNOTATION"
```

The existing annotation will be overwritten by the new one you enter.  For example:

```bash
maas admin machine update ke3wc7 description=""
```

You can check your work by [viewing the static annotations for one machine](#heading--view-a-static-annotation-for-one-machine).


<a href="#heading--list-static-annotations-for-all-machines"><h4 id="heading--list-static-annotations-for-all-machines">List static annotations for all machines</h4></a>

To list static annotations for all machines, enter a command similar to this one:

```bash
maas $PROFILE machines read \
| jq -r '(["hostname","system_id","description"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.description])
|@tsv' | column -t
```

For example:

```bash
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

<a href="#heading--view-a-static-annotation-for-one-machine"><h4 id="heading--view-a-static-annotation-for-one-machine">View a static annotation for one machine</h4></a>

To view a static annotation for one machine, try a command like this:

```bash
 maas $PROFILE machine read $SYSTEM_ID \
| jq -r '(["hostname","system_id","description"]
|(.,map(length*"-"))),([.hostname,.system_id,.description])
|@tsv' | column -t
```

For example:

```bash
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
** how to work with dynamic (workload) annoations
<a href="#heading--work-with-dynamic-workload-annotations"><h3 id="heading--work-with-dynamic-workload-annotations">Work with dynamic (workload) annotations</h3></a>

This section will show you how to:

- [Identify machines that can receive dynamic annotations](#heading--identify-machines-that-can-receive-dynamic-annotations)
- [Set dynamic annotations for a machine](#heading--set-dynamic-annotations-for-a-machine)
- [Clear and change dynamic annotations for a machine](#heading--clear-and-change-dynamic-annotations-for-a-machine)
- [List dynamic annotations for all machines](#heading--list-dynamic-annotations-for-all-machines)
- [List dynamic allocations for one machine](#heading--list-dynamic-annotations-for-one-machine)

<a href="#heading--identify-machines-that-can-receive-dynamic-annotations"><h4 id="heading--identify-machines-that-can-receive-dynamic-annotations">Identify machines that can receive dynamic annotations</h4></a>

You can only set dynamic annotations for machines that are in the "Allocated" or "Deployed" state.  To identify which of your machines are in these states, you can execute the following command:

```bash
maas $PROFILE machines read \
| jq -r '(["hostname","system_id","status"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.status_name])
|@tsv' | column -t
```

For example:

```bash
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

<a href="#heading--set-dynamic-annotations-for-a-machine"><h4 id="heading--set-dynamic-annotations-for-a-machine">Set dynamic annotations for a machine</h4></a>

Dynamic annotations, otherwise known as "workload annotations" or "owner data," can be used to keep track of the runtime status of machines that are acquired or deployed.  These annotations are set using `key=value` pairs.  You can set any `key=value` pair that you wish for any machine, although it's probably more useful if you standardise your key names.

To set a dynamic annotation for a machine, you can enter a command like this:

```bash
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=$VALUE
```

For example:

```bash
maas admin machine set-owner-data tgaat6 owner=gsmith@zorko.com
```

This command will return a JSON string representative of the machine's new configuration, including the dynamic annotations you've added. You can check your work by [listing the dynamic annotations for the one machine](#heading--list-dynamic-annotations-for-one-machine) you just edited, or by [listing dynamic annotations for all machines](#heading--list-dynamic-annotations-for-all-machines).

<a href="#heading--clear-and-change-dynamic-annotations-for-a-machine"><h4 id="heading--clear-and-change-dynamic-annotations-for-a-machine">Clear and change dynamic annotations for a machine</h4></a>

You can change dynamic annotations for a machine simply by executing a new `set-owner-data` command:

```bash
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=$NEW_VALUE
```

You can clear a dynamic annotation by entering the empty string (`""`) as the $VALUE:

```bash
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=""
```

These commands will return a JSON string representative of the machine's new configuration, including the dynamic annotations you've changed or cleared. You can check your work by [listing the dynamic annotations for the one machine](#heading--list-dynamic-annotations-for-one-machine) you just edited, or by [listing dynamic annotations for all machines](#heading--list-dynamic-annotations-for-all-machines).

<a href="#heading--list-dynamic-annotations-for-all-machines"><h4 id="heading--list-dynamic-annotations-for-all-machines">List dynamic annotations for all machines</h4></a>

You can list the current dynamic annotations for all machines with a command like this:

```bash
maas $PROFILE machines read \
| jq -r '(["hostname","system_id","owner_data"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.owner_data[]])
|@tsv' | column -t
```

For example:

```bash
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

<a href="#heading--list-dynamic-annotations-for-one-machine"><h4 id="heading--list-dynamic-annotations-for-one-machine">List dynamic allocations for one machine</h4></a>

You can list the dynamic annotations for one machine by entering a command of the form:

```bash
maas $PROFILE machine read $SYSTEM_ID \
| jq -r '(["hostname","system_id","owner_data"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.owner_data[]])
|@tsv' | column -t
```

For example:

```bash
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
rad-end

* how to set global storage layouts
<a href="#heading--how-to-set-global-storage-layouts"><h2 id="heading--how-to-set-global-storage-layouts">How to set global storage layouts</h2></a>

Layouts can be set globally and on a per-machine basis.

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
All machines will have a default layout applied when commissioned. An administrator can configure the default layout on the 'Settings' page, under the 'Storage' tab.

<a href="https://discourse.maas.io/uploads/default/original/1X/80de3bc701552cd00bec707830accf380c214b17.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/80de3bc701552cd00bec707830accf380c214b17.png"></a>
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
All machines will have a default layout applied when commissioned. To set the default storage layout for all machines:

```
maas $PROFILE maas set-config name=default_storage_layout value=$LAYOUT_TYPE
```

For example, to set the default layout to Flat:

```
maas $PROFILE maas set-config name=default_storage_layout value=flat
```

Important: The new default will only apply to newly-commissioned machines.

rad-end

[note type="caution" status="Important"]
The new default will only apply to newly-commissioned machines.
[/note]
** how to set per-machine storage layouts
<a href="#heading--how-to-set-per-machine-storage-layouts"><h3 id="heading--how-to-set-per-machine-storage-layouts">How to set per-machine storage layouts</h3></a>

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
An administrator can change the layout for a single machine as well as customise that layout providing this is done while the machine has a status of 'Ready'. This is only possible via the CLI: to see how, click the "CLI" option for your version and delivery method above.
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
An administrator can set a storage layout for a machine with a status of ‘Ready’ like this:

```
maas $PROFILE machine set-storage-layout $SYSTEM_ID storage_layout=$LAYOUT_TYPE [$OPTIONS]
```

For example, to set an LVM layout where the logical volume has a size of 5 GB:

```
maas $PROFILE machine set-storage-layout $SYSTEM_ID storage_layout=lvm lv_size=5368709120

```
You must specify all storage sizes in bytes.

This action will remove the configuration that may exist on any block device.
rad-end

[note]
Only an administrator can modify storage at the block device level (providing the machine has a status of 'Ready').
[/note]

rad-begin   /deb/2.9/ui  /snap/2.9/ui  /snap/3.0/ui /deb/3.0/ui
* how to set default erasure configuration
<a href="#heading--how-to-set-default-erasure-configuration"><h2 id="heading--how-to-set-default-erasure-configuration">How to set the default erasure configuration</h2></a>

A default erasure configuration can be set on the 'Settings' page by selecting the 'Storage' tab.

<a href="https://assets.ubuntu.com/v1/4e90c4c7-installconfig-storage-erasure__defaults.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/4e90c4c7-installconfig-storage-erasure__defaults.png"></a>

If option 'Erase machines' disks prior to releasing' is chosen then users will be compelled to use disk erasure. That option will be pre-filled in the machine's view and the user will be unable to remove the option.

With the above defaults, the machine's view will look like this when the Release action is chosen:

<a href="https://assets.ubuntu.com/v1/66e1dcc2-installconfig-storage-erasure__defaults-node.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/66e1dcc2-installconfig-storage-erasure__defaults-node.png"></a>

Where 'secure erase' and 'quick erase' can then be configured by the user.

rad-end

rad-begin   /deb/2.9/cli  /snap/2.9/cli  /snap/3.0/cli /deb/3.0/cli 

* how to erase disks
<a href="#heading--how-to-erase-disks"><h2 id="heading--how-to-erase-disks">How to erase disks</h2></a>

When using the [MAAS CLI](/t/maas-cli/nnnn), you can erase a disk when releasing an individual machine.  Note that this option is not available when releasing multiple machines, so you'll want to make sure you're using:

```
maas $PROFILE machine release...
```

and not:

```
maas $PROFILE machines release...
```

Note the difference in singular and plural "machine/machines" in the commands.  Releasing a machine requires that you have the `system_id` of the machine to be released, which you can obtain with a command like this one:

```
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

```
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true [secure_erase=true ||/&& quick_erase=true]
```

Parameters `secure_erase` and `quick_erase` are both optional, although if you don't specify either of them, the entire disk will be overwritten with null bytes.  Note that this overwrite process is very slow.

Secure erasure uses the drive's secure erase feature, if it has one.  In some cases, this can be much faster than overwriting the entire drive.  Be aware, though, that some drives implement secure erasure as a complete drive overwrite, so this method may still be very slow.  Additionally, if you specify secure erasure and the drive doesn't have this feature, you'll get a complete overwrite anyway -- again, possibly very slow.

Quick erasure wipes 2MB at the start and end of the drive to make recovery both inconvenient and unlikely to happen by accident.  Note, though, that quick erasure is not secure.

** how to specify conditional erasure types
<a href="#heading--how-to-specify-conditional-erasure-types"><h3 id="heading--how-to-specify-conditional-erasure-types">How to specify conditional erasure types</h3></a>

If you specify both erasure types, like this:

```
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true secure_erase=true quick_erase=true
```

then MAAS will perform a secure erasure if the drive has that feature; if not, it will perform a quick erasure.  Of course, if you're concerned about completely erasing the drive, and you're not sure whether the disk has secure erase features, the best way to handle that is to specify nothing, and allow the full disk to be overwritten by null bytes:

```
maas $PROFILE machine release $SYSTEM_ID comment="some comment" erase=true
```

rad-end

** how to list block devices
<a href="#heading--how-to-list-block-devices"><h3 id="heading--how-to-list-block-devices">How to list block devices</h3></a>

To view all block devices on a machine use the read operation. This list both physical and virtual block devices, as you can see in the output from the following command:

``` bash
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

** how to read a block device
<a href="#heading--how-to-read-a-block-device"><h3 id="heading--how-to-read-a-block-device">How to read a block device</h3></a>

If you want to read just one block device instead of listing all block devices the read operation on the block device endpoint provides that information. To display the details on device '11' from the previous output, for example, we could enter:

``` bash
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

``` bash
s admin block-device read <node-id> vda
```

[note]
MAAS allows the name of a block device to be changed. If the block device name has changed then the API call needs to use the new name.
[/note]

    Using the ID is safer as it never changes.

** how to create a block device
<a href="#heading--how-to-create-a-block-device"><h3 id="heading--how-to-create-a-block-device">How to create a block device</h3></a>

MAAS gathers the required information itself on block devices when re- commissioning a machine. If this doesn't provide the required information, it is also possible - though not recommended - for an administrator to use the API to manually add a physical block device to a machine.

``` bash
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

** how to update a block device
<a href="#heading--how-to-update-a-block-device"><h3 id="heading--how-to-update-a-block-device">How to update a block device</h3></a>

An administrator can also update the details held on a physical block device, such as its name, from the API:

``` bash
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

** how to delete a block device
<a href="#heading--how-to-delete-a-block-device"><h3 id="heading--how-to-delete-a-block-device">How to delete a block device</h3></a>

Physical and virtual block devices can be deleted by an administrator, while ordinary users can only delete virtual block devices:

``` bash
maas admin block-device delete <node-id> 12
```

** how to format a block device
<a href="#heading--format-block-device"><h3 id="heading--format-block-device">Format Block Device</h3></a>

An entire block device can be formatted by defining a filesystem with the 'format' API call:

``` bash
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

** how to unformat a block device
<a href="#heading--how-to-unformat-a-block-device"><h3 id="heading--how-to-unformat-a-block-device">How to unformat a block device</h3></a>

You can remove the filesystem from a block device with the 'unformat' API call:

``` bash
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

** how to mount a block device
<a href="#heading--how-to-mount-a-block-device"><h3 id="heading--how-to-mount-a-block-device">How to mount a block device</h3></a>

If a block device has a filesystem, you can use the 'maas' command to mount a block devices at a given mount point:

``` bash
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

** how to unmount a block device
<a href="#heading--how-to-unmount-a-block-device"><h3 id="heading--how-to-unmount-a-block-device">How to unmount a block device</h3></a>

To remove the mount point from the block device, use the 'unmount' call:

``` bash
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

** how to set a block device as a boot disk
<a href="#heading--how-to-set-a-block-device-as-a-boot-disk"><h3 id="heading--how-to-set-a-block-device-as-a-boot-disk">How to set a block device as a boot disk</h3></a>

By default, MAAS picks the first added block device to the machine as the boot disk. In most cases this works as expected as the BIOS usually enumerates the boot disk as the first block device. There are cases where this fails and the boot disk needs to be set to another disk. This API allow setting which block device on a machine MAAS should use as the boot disk.:

``` bash
maas admin block-device set-boot-disk <node-id> 10
```

[note]
Only an administrator can set which block device should be used as the boot disk and only a physical block device can be set as as the boot disk. This operation should be done before a machine is acquired or the storage layout will be applied to the previous boot disk.
[/note]

** how to list paritions
<a href="#heading--how-to-list-partitions"><h3 id="heading--how-to-list-partitions">How to list partitions</h3></a>

To view all the partitions on a block device, use the 'partitions read' API call:

``` bash
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

``` bash
maas admin partition read <node-id> 10 9
```

** how to create a partition
<a href="#heading--how-to-create-a-partition"><h3 id="heading--how-to-create-a-partition">How to create a partition</h3></a>

To create a new partition on a block device, use the 'create' API call:

``` bash
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

** how to delete a partition
<a href="#heading--how-to-delete-a-partition"><h3 id="heading--how-to-delete-a-partition">How to delete a partition</h3></a>

Partitions can be deleted from a block device with the 'delete' API call. Make sure you double check the partition details as the partition is deleted immediately, with no further confirmation:

``` bash
maas admin partition delete <node-id> 10 9
```

Successful output from the 'delete' command will look like this:

``` bash
Success.
Machine-readable output follows:
```

** how to format a paritition
<a href="#heading--how-to-format-a-partition"><h3 id="heading--how-to-format-a-partition">How to format a partition</h3></a>

Partitions can be formatted in a similar way to block devices:

``` bash
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

** how to unformat a partition
<a href="#heading--how-to-unformat-a-partition"><h3 id="heading--how-to-unformat-a-partition">How to unformat a partition</h3></a>

You can also remove the filesystem from a partition with the 'unformat' API call:

``` bash
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
** how to mount a paritition
<a href="#heading--how-to-mount-a-partition"><h3 id="heading--how-to-mount-a-partition">How to mount a partition</h3></a>

A formatted partition can be mounted at a given mount point with the 'mount' command.

``` bash
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
** how to unmount a partition
<a href="#heading--how-to-unmount-a-partition"><h3 id="heading--how-to-unmount-a-partition">How to unmount a partition</h3></a>

A previous mounted partition can be unmounted with the 'unmount' command:

``` bash
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

* how to list vmfs datastores
<a href="#heading--how-to-list-vmfs-datastores"><h2 id="heading--how-to-list-vmfs-datastores">How to list VMFS datastores</h2></a>

To view all VMFS Datastores on a machine, use the 'vmfs-datastores read' API call:

``` bash
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

* how to view a vmfs datastore
<a href="#heading--how-to-view-a-vmfs-datastore"><h2 id="heading--how-to-view-a-vmfs-datastore">How to view a VMFS datastore</h2></a>

To view a specific VMFS Datastores on a machine, use the 'vmfs-datastore read' API call:

``` bash
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

* how to create a vmfs datastore
<a href="#heading--how-to-create-a-vmfs-datastore"><h2 id="heading--how-to-create-a-vmfs-datastore">How to create a VMFS datastore</h2></a>

A VMware VMFS datastore is created on one or more [block devices](#heading--about-block-devices) or [partitions](#heading--about-partitions).

To create a VMFS Datastores on a machine use the 'vmfs-datastores create' API call:

``` bash
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

* how to edit a vmfs datastdore
<a href="#heading--how-to-edit-a-vmfs-datastore"><h2 id="heading--how-to-edit-a-vmfs-datastore">How to edit a VMFS datastore</h2></a>

To edit an existing VMFS Datastores on a machine use the 'vmfs-datastore update' API call:

``` bash
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
* how to delete a vmfs datastore
<a href="#heading--how-to-delete-a-vmfs-datastore"><h2 id="heading--how-to-delete-a-vmfs-datastore">How to delete a VMFS datastore</h2></a>

To delete a VMFS Datastores on a machine use the 'vmfs-datastore delete' API call:

``` bash
maas $PROFILE vmfs-datastore delete $SYSTEM_ID $VMFS_ID
```
* storage layouts reference
<a href="#heading--storage-layouts-reference"><h2 id="heading--storage-layouts-reference">Storage layouts reference</h2></a>

There are three layout types:

1.   Flat layout
2.   LVM layout
3.   bcache layout

The layout descriptions below will include the EFI partition. If your system is not using UEFI, regard `sda2` as `sda1` (with an additional 512 MB available to it).

** flat storage layout reference
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

** lvm storage layout reference
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

** bcache storage layout reference
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

1. `root_device`: The block device upon which to place the root partition. Default is the boot disk.

2. `root_size`: Size of the default VMFS Datastore. Default is 100%, meaning the remaining size of the root disk.

** blank storage layout reference

<a href="#heading--blank-storage-layout-reference"><h3 id="heading--blank-storage-layout-reference">Blank storage layout reference</h3></a>

The blank layout removes all storage configuration from all storage devices. It is useful when needing to apply a custom storage configuration.

[note type="negative" status="Warning"]
Machines with the blank layout applied are not deployable; you must first configure storage manually.
[/note]
