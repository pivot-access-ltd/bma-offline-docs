This article explains:

- [How to create, delete, and configure machines](#heading--how-to-create-delete-and-configure-machines)
- [How to examine machines and machine details](#heading--how-to-examine-machines-and-machine-details)

Most of the day-to-day work of managing machines is covered here. Utilising machines to do work -- for example, commissioning, testing, and deploying them -- is discussed in [How to deploy machines](/t/how-to-deploy-machines/nnnn).

<a href="#heading--how-to-create-delete-and-configure-machines"><h2 id="heading--how-to-create-delete-and-configure-machines">How to create, delete, and configure machines</h2></a>

This section shows you:

- [How to add a machine manually](#heading--how-to-add-a-machine-manually)
rad-begin /snap/3.0/ui /snap/2.9/ui /deb/3.0/ui /deb/2.9/ui
- [How to add machines via a chassis](#heading--how-to-add-machines-via-a-chassis)
rad-end
rad-begin /snap/3.0/ui /snap/3.0/cli /deb/3.0/ui /deb/3.0/cli
- [How to manage attached USB and PCI devices](#heading--usb-pci-devices)
rad-end

<a href="#heading--how-to-add-a-machine-manually"><h3 id="heading--how-to-add-a-machine-manually">How to add a machine manually</h3></a>

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

* `$ARCH`: This field refers to the architecture of the machine being added, `amd64` in the local laptop example.

* `$MAC_ADDRESS`: This is the MAC address of the boot-enabled NIC for the machine being added.  Note that the MAC address entered here must use a colon (":") separator, although some MAC addresses are written with dash ("-") separators.

* `$POWER_TYPE`: You must select the power type supported by the machine you are adding, and fill in additional required fields that appear.  See [Power management](/t/power-management/nnnn) for details on the available power types and the relevant parameters for each type. In this example, we've used a "virsh" power type (a libvirt KVM), but your choice will depend on your hardware.

* `$POWER_ID`: This is generally the UUID of the machine being added.

* `$POWER_ADDRESS/$POWER_PASSWORD`: In the case of a KVM, these are the only parameters that need to be entered.  See [Power types](https://maas.io/docs/api#power-types) in the API reference for details on the available power types and the relevant parameters for each type.
rad-end

rad-begin /snap/3.0/ui /deb/3.0/ui /snap/2.9/ui /deb/2.9/ui
<a href="#heading--how-to-add-machines-via-a-chassis"><h3 id="heading--how-to-add-machines-via-a-chassis">How to add machines via a chassis</h3></a>

You can use the chassis feature to add multiple machines at once. To do this, instead of selecting 'Machine' as above, choose 'Chassis' from the drop-down menu. In the following example, MAAS will add all available VMs from the given  virsh address:

<a href="https://discourse.maas.io/uploads/default/original/1X/e7f88bce68318cf3c6a8e97b4d31d0b6980e0f32.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e7f88bce68318cf3c6a8e97b4d31d0b6980e0f32.jpeg"></a>

The required fields will change based on the type of chassis you choose.

[note]
As with the manual method, the underlying machines will require netbooting.
[/note]
rad-end

rad-begin /snap/3.0/ui /deb/3.0/ui /snap/3.0/cli /deb/3.0/cli
<a href="#heading--usb-pci-devices"><h2 id="heading--usb-pci-devices">How to manage attached USB and PCI devices</h2></a>

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
rad-begin commentedout
<a href="#heading--machine-interfaces"><h2 id="heading--machine-interfaces">How to find network info for a machine</h2></a>

To find network info for a specific machine, open that machine's "Network" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png"></a> 

Options on this tab are described in the introduction to [Networking](/t/about-networking/nnnn) article in this documentation set.

<a href="#heading--how-to-find-machine-storage-info"><h2 id="heading--how-to-find-machine-storage-info">How to find machine storage info</h2></a>

To view/edit machine storage info, click on the "Storage" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

See the article [Storage](/t/storage/nnnn) for a detailed instructions on how to use this screen.

<a href="#heading--commissioning-log"><h2 id="heading--commissioning-log">How to find commissioning logs</h2></a>

The "Commissioning" tab brings up a summary log of commissioning events:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png"></a> 

Click on the dropdown at the end of the row you're interested in, and click on "View details":

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png"></a>

This will bring up a detailed log view for that row:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png"></a>

These logs present an extremely detailed, timestamped record of completion and status items from the commissioning process. See the article on [Logging](/t/maas-logging/nnnn) for more details on how to read and interpret these logs.  

<a href="#heading--hardware-tests"><h2 id="heading--hardware-tests">How to find machine hardware & test logs</h2></a>

This tab presents a summary of tests run against this particular machine.  You can view the summary report, or choose the "View details" dropdown to get details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png"></a> 

The format of these screens is very similar to the Configuration logs shown above.  For more information, please see the article on [Hardware testing](/t/how-to-test-machines/nnnn).  

<a href="#heading--raw-log-output"><h2 id="heading--raw-log-output">How to find raw log output for a machine</h2></a>

By choosing "Installation output" on the "Logs" tab, you can see the "raw" log output:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png"></a> 

Help interpreting these logs can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.

<a href="#heading--event-logs"><h2 id="heading--event-logs">How to find a machine's event logs</h2></a>

To view the Event log for a machine, choose the "Event" tab under "Logs."  This displays a list of timestamped status updates for events and actions performed on the machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png"></a> 

There is a dropdown on the upper right which allows you to choose how many events per page you wish to view. Detailed discussion of this event log can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.

<a href="#heading--machine-config"><h2 id="heading--machine-config">How to find machine configuration info</h2></a>

The final tab from the Machine menu allows you to update machine and power configuration options: 

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png"></a> 

There are two sections to this tab.  The "Machine configuration" section, shown above, offers some general parameters, mostly related to how this machine is grouped and categorised.  More information on these options are found in the relevant sections of the documentation (e.g., tags, resource pools, and so forth). 

The "Power configuration" supplies the parameters necessary for MAAS to access the machine to PXE-boot it: 

<a href="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png"></a> 

More information on Power configuration will be found in the [Power management](/t/power-management/nnnn) section of this documentation.
-->
rad-end

rad-begin /snap/3.0/ui /deb/3.0/ui /snap/2.9/ui /deb/2.9/ui
<a href="#heading--how-to-view-the-machine-list"><h2 id="heading--how-to-view-the-machine-list">How to view the machine list</h2></a>

To view the machine list, select "Machines" on the top menu of the MAAS web UI:

<a href="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg"></a> 

To quickly view more details, roll the cursor over status icons:

<a href="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg"></a> 

<a href="#heading--how-to-view-machine-details"><h2 id="heading--how-to-view-machine-details">How to view machine details</h2></a>

To open a detailed view of a machine's status and configuration, click a machine's FQDN or MAC address:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png"></a>


<a href="#heading--machine-interfaces"><h2 id="heading--machine-interfaces">How to find network info for a machine</h2></a>

To find network info for a specific machine, open that machine's "Network" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png"></a> 

Options on this tab are described in the introduction to [Networking](/t/about-networking/nnnn) article in this documentation set.

<a href="#heading--how-to-find-machine-storage-info"><h2 id="heading--how-to-find-machine-storage-info">How to find machine storage info</h2></a>

To view/edit machine storage info, click on the "Storage" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

See the article [Storage](/t/storage/nnnn) for a detailed instructions on how to use this screen.

<a href="#heading--commissioning-log"><h2 id="heading--commissioning-log">How to find commissioning logs</h2></a>

The "Commissioning" tab brings up a summary log of commissioning events:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png"></a> 

Click on the dropdown at the end of the row you're interested in, and click on "View details":

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png"></a>

This will bring up a detailed log view for that row:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png"></a>

These logs present an extremely detailed, timestamped record of completion and status items from the commissioning process. See the article on [Logging](/t/maas-logging/nnnn) for more details on how to read and interpret these logs.  

<a href="#heading--hardware-tests"><h2 id="heading--hardware-tests">How to find machine hardware & test logs</h2></a>

This tab presents a summary of tests run against this particular machine.  You can view the summary report, or choose the "View details" dropdown to get details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png"></a> 

The format of these screens is very similar to the Configuration logs shown above.  For more information, please see the article on [Hardware testing](/t/how-to-test-machines/nnnn).  

<a href="#heading--raw-log-output"><h2 id="heading--raw-log-output">How to find raw log output for a machine</h2></a>

By choosing "Installation output" on the "Logs" tab, you can see the "raw" log output:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png"></a> 

Help interpreting these logs can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.

<a href="#heading--event-logs"><h2 id="heading--event-logs">How to find a machine's event logs</h2></a>

To view the Event log for a machine, choose the "Event" tab under "Logs."  This displays a list of timestamped status updates for events and actions performed on the machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png"></a> 

There is a dropdown on the upper right which allows you to choose how many events per page you wish to view. Detailed discussion of this event log can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.

<a href="#heading--machine-config"><h2 id="heading--machine-config">How to find machine configuration info</h2></a>

The final tab from the Machine menu allows you to update machine and power configuration options: 

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png"></a> 

There are two sections to this tab.  The "Machine configuration" section, shown above, offers some general parameters, mostly related to how this machine is grouped and categorised.  More information on these options are found in the relevant sections of the documentation (e.g., tags, resource pools, and so forth). 

The "Power configuration" supplies the parameters necessary for MAAS to access the machine to PXE-boot it: 

<a href="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png"></a> 

More information on Power configuration will be found in the [Power management](/t/power-management/nnnn) section of this documentation.
rad-end
