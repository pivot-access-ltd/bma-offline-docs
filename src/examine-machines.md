This document describes the various ways you can evaluate the health and status of your MAAS machines, using the machine list.  It will show you:

- [How to view the machine list](#heading--machine-list)
- [How to view machine details](#heading--node-details)
rad-begin /snap/3.0/ui /deb/3.0/ui /snap/3.0/cli /deb/3.0/cli
- [How to view attached USB and PCI devices](#heading--usb-pci-devices)
rad-end
rad-begin /snap/3.0/ui /deb/3.0/ui /snap/2.9/ui /deb/2.9/ui
- [How to find network info for a machine](#heading--machine-interfaces)
- [How to find storage info for a machine](#heading--machine-storage)
- [How to find commissioning logs](#heading--commissioning-log)
- [How to find machine hardware & test logs](#heading--hardware-tests)
- [How to find raw log output for a machine](#heading--raw-log-output)
- [How to find a machine's event logs](#heading--event-logs)
- [How to find machine configuration info](#heading--machine-config)
rad-end


Some of these may not make complete sense until you've read [about machines](/t/machines/nnnn).

<a href="#heading--machine-list"><h2 id="heading--machine-list">View the machine list</h2></a>

rad-begin     /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
To view the list of machines, choose "Machines" on the top menu of the MAAS web UI:

<a href="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg"></a> 

rad-end

rad-begin     /snap/2.9/cli /deb/2.9/cli  /snap/3.0/cli /deb/3.0/cli 
To view a basic machine list, enter a command such as this one:

```
maas $PROFILE machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t \
| sort -k 1
```

This action will display a table similar to the following:

```
HOSTNAME           SYSID   POWER  STATUS     OWNER  TAGS     POOL     VLAN      FABRIC   SUBNET
--------           -----   -----  ------     -----  ----     ----     ----      ------   ------
52-54-00-15-36-f2  hfqgmw  off    Allocated  admin  virtual  default  untagged  default  192.168.123.0/24
52-54-00-17-64-c8  bdn3qn  off    Allocated  admin  virtual  default
52-54-00-1d-47-95  8d8bxk  off    Allocated  admin  virtual  default  untagged  default  192.168.123.0/24
52-54-00-1e-06-41  wennwm  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-1e-a5-7e  ekf7ae  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-2e-b7-1e  y47pka  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-2e-c4-40  cbgkxg  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-2e-ee-17  ap3ttw  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-2f-6d-3c  c3aybg  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-4a-2a-30  4a33wk  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-4e-60-b2  a488pw  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-52-93-10  hhnq8x  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-5d-b5-a1  hxy44m  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-60-1e-6f  bk7mck  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-60-8d-4b  typh3r  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-62-22-e3  774dk8  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-65-2e-20  t8me3x  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-6a-ac-23  tybxhr  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-6f-b4-af  bs7ye8  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-71-0c-53  hp7pp4  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-77-4e-53  nq36ky  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-98-42-ef  gagbqp  off    Broken     -      -        default  untagged  default
52-54-00-9b-e4-9a  apkp4n  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-9c-51-00  rxfkqt  off    Ready      -      virtual  default  untagged  default  192.168.123.0/24
```

During commissioning and deployment, you can re-read the table to reflect the changing state of each machine:

```
HOSTNAME           SYSID   POWER  STATUS         OWNER  TAGS     POOL     VLAN      FABRIC   SUBNET
--------           -----   -----  ------         -----  ----     ----     ----      ------   ------
52-54-00-15-36-f2  hfqgmw  off    Allocated      admin  virtual  default  untagged  default  192.168.123.0/24
52-54-00-17-64-c8  bdn3qn  off    Allocated      admin  virtual  default
52-54-00-1d-47-95  8d8bxk  off    Allocated      admin  virtual  default  untagged  default  192.168.123.0/24
52-54-00-1e-06-41  wennwm  off    Commissioning  -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-1e-a5-7e  ekf7ae  off    Commissioning  -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-2e-b7-1e  y47pka  off    Deployed       -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-2e-c4-40  cbgkxg  off    Deploying      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-2e-ee-17  ap3ttw  off    Deploying      -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-2f-6d-3c  c3aybg  off    Ready          -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-4a-2a-30  4a33wk  off    Ready          -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-4e-60-b2  a488pw  off    Ready          -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-52-93-10  hhnq8x  off    Ready          -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-5d-b5-a1  hxy44m  off    Ready          -      virtual  default  untagged  default  192.168.123.0/24
52-54-00-60-1e-6f  bk7mck  off    Ready          -      virtual  default  untagged  default  192.168.123.0/24
```

<a href="#heading--node-details"><h2 id="heading--node-details">View machine details</h2></a>

rad-begin     /snap/2.9/cli /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
To get a detailed view of a machine's status and configuration, enter a command similar to the following:

```
maas $PROFILE machine read $SYSTEM_ID | \
jq -r '([.hostname, .status_name, "Power", .power_state]),
[(120*"-")],
(["OVERVIEW", "|", "CPU", "", "", .architecture, "|", "MEMORY", "|", "STORAGE"]),
([.status_name, "|", "\(.cpu_count) core(s)", "", "", "", "|", "\(.memory) MB", "|",
"\(.blockdevice_set[].partitions[].size/(1024*1024*1024)) GiB"]),
(["", "", "|", .hardware_info.cpu_model, "|","","|"]), ([(120*"-")]),
(["Owner", "", "Domain", "", "Zone", "", "Resource pool", "", "Power type", "", "Tags"]),
([.owner // "-", "", .domain.name, "", .zone.name, "", .pool.name,
"", "", .power_type, "", "", .tag_names[0]]) | @tsv'
```

The above command produces output similar to this:

```
52-54-00-15-36-f2	Allocated	Power: off
---------------------------------------------------------------------------------------
OVERVIEW        | CPU                    amd64/generic  | MEMORY   | STORAGE
Allocated       | 1 core(s)                             | 1024 MB  | 4.9921875 GiB
                | Intel Core Processor (Skylake, IBRS)  |          |
---------------------------------------------------------------------------------------
Owner        Domain       Zone        Resource pool        Power type        Tags
admin        maas         default     default              virsh             virtual
```

You can customize this command at length by examining the entire JSON output stream, like this:

```
maas $PROFILE machine read $SYSTEM_ID | jq .
```

rad-end

rad-begin     /snap/2.9/ui /deb/2.9/ui 
Click a machine's FQDN or MAC address to open a detailed view of a machine's status and configuration:

<a href="https://discourse.maas.io/uploads/default/original/1X/c9684bf883d01d3fe610ec27e95618075c44b324.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c9684bf883d01d3fe610ec27e95618075c44b324.jpeg"></a>

rad-end

rad-begin /snap/3.0/ui /deb/3.0/ui
Click a machine's FQDN or MAC address to open a detailed view of a machine's status and configuration.

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png"></a>


rad-begin /snap/3.0/ui /deb/3.0/ui /snap/3.0/cli /deb/3.0/cli
<a href="#heading--usb-pci-devices"><h2 id="heading--usb-pci-devices">How to view attached USB and PCI devices</h2></a>
rad-end

*rad-begin /snap/3.0/ui /deb/3.0/ui

To view USB or PCI devices for a machine, click on the appropriate tabs at the top of the machine summary screen:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/87f42bafe321d45af94d73216f933a9067f01df2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/87f42bafe321d45af94d73216f933a9067f01df2.png"></a>

A typical PCI device tab would look something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/82e1e6f8bc511047ac5f773430f7e5812c7a24d4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/82e1e6f8bc511047ac5f773430f7e5812c7a24d4.png"></a>

The USB tab presents similar information in the same format.

[note]
If you are upgrading from a previous version of MAAS, PCI and USB devices aren't modeled, so you will have to recommission the machine to capture these devices.
[/note]

rad-end

*rad-begin /snap/3.0/cli /deb/3.0/cli
Using the MAAS CLI, you can obtain a list of the USB/PCI devices available in a commissioned machine with the following command:

```
maas $PROFILE node-devices read $SYSTEM_ID
```

where:

- $PROFILE   = your user profile (e.g., "admin")
- $SYSTEM_ID = the ID of the machine in question (e.g., "ngx7ry")

Note that USB/PCI devices are referred to as "node-devices" in the MAAS CLI.

rad-end

*rad-begin /snap/3.0/ui /deb/3.0/ui /snap/3.0/cli /deb/3.0/cli
Once you've commissioned the machine, you have the option of deleting PCI/USB devices from the machine in any machine state, via the CLI only, using the following command:

```
maas $PROFILE node-device delete $SYSTEM_ID $DEVICE_ID
```

where:

- $PROFILE   = your user profile (e.g., "admin")
- $SYSTEM_ID = the ID of the machine in question (e.g., "ngx7ry")
- $DEVICE_ID = the ID of the device you want to delete 

If the device is still present in the system, it will be recogized again (and thus "recreated") when the machine is next commissioned.
rad-end


rad-begin /snap/3.0/ui deb/3.0/ui /snap/2.9/ui /deb/2.9/ui
<a href="#heading--machine-interfaces"><h2 id="heading--machine-interfaces">How to find network info for a machine</h2></a>
rad-end

rad-begin /snap/2.9/ui /deb/2.9/ui

To view or edit the network and interface configurations for a machine, select the "Network" tab: 

<a href="https://discourse.maas.io/uploads/default/original/1X/7a7b22ee7202b50df09c7bef598250db0eb1cc15.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/7a7b22ee7202b50df09c7bef598250db0eb1cc15.jpeg"></a> 

If the machine is in a 'Ready' state, you may alter the network configuration:

<a href="https://discourse.maas.io/uploads/default/original/1X/01d53759105647d71786154e99ff210f8c71d2e7.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/01d53759105647d71786154e99ff210f8c71d2e7.jpeg"></a> 
rad-end

rad-begin /snap/3.0/ui /deb/3.0/ui


The Network "tab" provides you with a way to view/edit the network and interface configuration for a machine: 

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png"></a> 

If the machine is in a 'Ready' state, you may alter the network configuration.

rad-end

rad-begin /deb/2.9/ui /deb/3.0/ui /snap/2.9/ui /snap/3.0/ui
Options on this tab are described in the introduction to [Networking](/t/networking/nnnn) article in this documentation set.
rad-end

rad-begin /deb/2.9/ui /deb/3.0/ui /snap/2.9/ui /snap/3.0/ui
<a href="#heading--machine-storage"><h2 id="heading--machine-storage">How to find storage info for a machine</h2></a>
rad-end

rad-begin /deb/2.9/ui

The Storage tab on the machine list brings up a form that allows you to view/edit the file system, partitioning and storage parameters for the selected machine:

<a href="https://discourse.maas.io/uploads/default/original/1X/9dc30aedf5ed173bb7b474910fa9939f7f066c95.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/9dc30aedf5ed173bb7b474910fa9939f7f066c95.jpeg"></a> 

See the article [Storage](/t/storage/nnnn) for a detailed discussion on how to use this screen.
rad-end

rad-begin /deb/3.0/ui
The Storage tab on the machine list brings up a form that allows you to view/edit the file system, partitioning and storage parameters for the selected machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

See the article [Storage](/t/storage/nnnn) for a detailed discussion on how to use this screen, as well as many other considerations for machine storage configurations.
rad-end

rad-begin /snap/2.9/ui
The Storage tab on the machine list brings up a form that allows you to view/edit the file system, partitioning and storage parameters for the selected machine:

<a href="https://discourse.maas.io/uploads/default/original/1X/9dc30aedf5ed173bb7b474910fa9939f7f066c95.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/9dc30aedf5ed173bb7b474910fa9939f7f066c95.jpeg"></a> 

This tab describes the filesystem(s) in use, as well as the available and used partitions for this machine.  See the article [Storage](/t/storage/nnnn) for a detailed discussion on how to use this screen, as well as many other considerations for machine storage configurations.
rad-end

rad-begin /snap/3.0/ui
The Storage tab on the machine list brings up a form that allows you to view/edit the file system, partitioning and storage parameters for the selected machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

This tab describes the filesystem(s) in use, as well as the available and used partitions for this machine.  See the article [Storage](/t/storage/nnnn) for a detailed discussion on how to use this screen, as well as many other considerations for machine storage configurations.
rad-end

rad-begin /dev/2.9/ui /deb/3.0/ui /snap/3.0/ui /snap/2.9/ui
<a href="#heading--commissioning-log"><h2 id="heading--commissioning-log">How to find commissioning logs</h2></a>
rad-end

rad-begin /deb/2.9/ui

The "Commissioning" tab brings up a summary log of commissioning events:

<a href="https://discourse.maas.io/uploads/default/original/1X/b3d6248013fb5186d3ea61931816fe688b94a6a2.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/b3d6248013fb5186d3ea61931816fe688b94a6a2.jpeg"></a> 

Clicking on any of the "View log" links will take you to specific, detailed logs for that particular event or milestone:

<a href="https://discourse.maas.io/uploads/default/original/1X/13fce404b9bb304e08a7c5de5a395c514e98b9b0.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/13fce404b9bb304e08a7c5de5a395c514e98b9b0.jpeg"></a> 

These logs present an extremely detailed, timestamped record of completion and status items from the commissioning process.  See the article on [Logging](/t/maas-logging/nnnn) for more details on how to read and interpret these logs.
rad-end

rad-begin /deb/3.0/ui /snap/3.0/ui
The "Commissioning" tab brings up a summary log of commissioning events:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e98766009f32972dfe29293f9bc850b99a9a941f.png"></a> 

Click on the dropdown at the end of the row you're interested in, and click on "View details":

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8f7b4c02ce301fb867e7af33267be62498095bb5.png"></a>

This will bring up a detailed log view for that row:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/41a385cdf948dada8bb8d8f94a3137a2b64d46e0.png"></a>

These logs present an extremely detailed, timestamped record of completion and status items from the commissioning process.  
rad-end

rad-begin /snap/2.9/ui
The "Commissioning" tab brings up a summary log of commissioning events:

<a href="https://discourse.maas.io/uploads/default/original/1X/b3d6248013fb5186d3ea61931816fe688b94a6a2.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/b3d6248013fb5186d3ea61931816fe688b94a6a2.jpeg"></a> 

Clicking on any of the "View log" links will take you to specific, detailed logs for that particular event or milestone:

<a href="https://discourse.maas.io/uploads/default/original/1X/13fce404b9bb304e08a7c5de5a395c514e98b9b0.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/13fce404b9bb304e08a7c5de5a395c514e98b9b0.jpeg"></a> 

These logs present an extremely detailed, timestamped record of completion and status items from the commissioning process.  See the article on [Logging](/t/maas-logging/nnnn) for more details on how to read and interpret these logs.
rad-end

rad-begin /deb/2.9/ui /deb/2.9/cli /snap/3.0/ui /snap/3.0/cli
<a href="#heading--hardware-tests"><h2 id="heading--hardware-tests">How to find machine hardware & test logs</h2></a>
rad-end

rad-begin /deb/2.9/ui
This tab presents a summary of tests run against this particular machine:  

<a href="https://discourse.maas.io/uploads/default/original/1X/b6a6ff3c8fae4a638c18a18bf65c4aa51f29e984.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/b6a6ff3c8fae4a638c18a18bf65c4aa51f29e984.jpeg"></a> 

You can view the summary report, or click on a "View log" link to get details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/1X/8113eba28a3f08279ff2b5f7593e30db05d00824.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8113eba28a3f08279ff2b5f7593e30db05d00824.jpeg"></a> 

The format of these screens is very similar to the Configuration logs shown above.  For more information, please see the article on [Hardware testing](/t/hardware-testing/nnnn).
rad-end

rad-begin /deb/3.0/ui
This tab presents a summary of tests run against this particular machine:  

<a href="See the article on [Logging](/t/maas-logging/nnnn) for more details on how to read and interpret these logs." target = "_blank"><img src="See the article on [Logging](/t/maas-logging/nnnn) for more details on how to read and interpret these logs."></a> 

You can view the summary report, or choose the "View details" dropdown to get details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png"></a> 

The format of these screens is very similar to the Configuration logs shown above.  For more information, please see the article on [Hardware testing](/t/hardware-testing/nnnn).
rad-end

rad-begin /snap/2.9/ui
This tab presents a summary of tests run against this particular machine:  

<a href="https://discourse.maas.io/uploads/default/original/1X/b6a6ff3c8fae4a638c18a18bf65c4aa51f29e984.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/b6a6ff3c8fae4a638c18a18bf65c4aa51f29e984.jpeg"></a> 

You can view the summary report, or click on a "View log" link to get details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/1X/8113eba28a3f08279ff2b5f7593e30db05d00824.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8113eba28a3f08279ff2b5f7593e30db05d00824.jpeg"></a> 

The format of these screens is very similar to the Configuration logs shown above.  For more information, please see the article on [Hardware testing](/t/hardware-testing/nnnn).
rad-end

rad-begin /snap/3.0/ui
This tab presents a summary of tests run against this particular machine:  

<a href="See the article on [Logging](/t/maas-logging/nnnn) for more details on how to read and interpret these logs." target = "_blank"><img src="See the article on [Logging](/t/maas-logging/nnnn) for more details on how to read and interpret these logs."></a> 

You can view the summary report, or choose the "View details" dropdown to get details on any particular tests:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e53a2c01b57df49e56bb4d95552b6a038249aa97.png"></a> 

The format of these screens is very similar to the Configuration logs shown above.  For more information, please see the article on [Hardware testing](/t/hardware-testing/nnnn).
rad-end

rad-begin /deb/2.9/ui /deb/3.0/ui /snap/2.9/ui /snap/3.0/ui
<a href="#heading--raw-log-output"><h2 id="heading--raw-log-output">How to find raw log output for a machine</h2></a>
rad-end

rad-begin /deb/2.9/ui
The "Logs" tab shows raw log output, switchable between YAML and XML formats:

<a href="https://discourse.maas.io/uploads/default/original/1X/02b4bc35c8985fe0b954d8deb0afba18866cfe66.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/02b4bc35c8985fe0b954d8deb0afba18866cfe66.jpeg"></a> 

Help interpreting these logs can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.
rad-end

rad-begin /deb/3.0/ui
By choosing "Installation output" on the "Logs" tab, you can see the "raw" log output:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png"></a> 

Help interpreting these logs can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.
rad-end

rad-begin /snap/2.9/ui
The "Logs" tab shows raw log output, switchable between YAML and XML formats:

<a href="https://discourse.maas.io/uploads/default/original/1X/02b4bc35c8985fe0b954d8deb0afba18866cfe66.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/02b4bc35c8985fe0b954d8deb0afba18866cfe66.jpeg"></a> 

Help interpreting these logs can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.
rad-end

rad-begin /snap/3.0/ui
By choosing "Installation output" on the "Logs" tab, you can see the "raw" log output:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dc5bb5e6489a382e257dac605f2dbdc6fa1ca630.png"></a> 

Help interpreting these logs can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.
rad-end

rad-begin     /deb/2.9/ui /snap/2.9/ui /snap/3.0/ui /deb/3.0/ui 
<a href="#heading--event-logs"><h2 id="heading--event-logs">How to find a machine's event logs</h2></a>
rad-end

rad-begin     /deb/2.9/ui /snap/2.9/ui 
The "Event" tab displays a list of timestamped status updates for events and actions performed on the machine:

<a href="https://discourse.maas.io/uploads/default/original/1X/114ada7188f8ebf12883a54c0976ad8abda1d211.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/114ada7188f8ebf12883a54c0976ad8abda1d211.jpeg"></a> 
rad-end

rad-begin /snap/3.0/ui /deb/3.0/ui
To view the Event log for a machine, choose the "Event" tab under "Logs."  This displays a list of timestamped status updates for events and actions performed on the machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/981a1aced2a4c231fa9e4fe1b70e77aeb816f133.png"></a> 
rad-end

rad-begin /deb/2.9/ui
There is a button that allows you to see the next 10 events, and a link to show the entire history.  Detailed discussion of this event log can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.
rad-end

rad-begin /deb/3.0/ui
There is a dropdown on the upper right which allows you to choose how many events per page you wish to view.  Detailed discussion of this event log can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.
rad-end

rad-begin /snap/2.9/ui
There is a button that allows you to see the next 10 events, and a link to show the entire history.  Detailed discussion of this event log can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.
rad-end

rad-begin /snap/3.0/ui
There is a dropdown on the upper right which allows you to choose how many events per page you wish to view. Detailed discussion of this event log can be found under the [Logging](/t/maas-logging/nnnn) section of this documentation.
rad-end

rad-begin     /deb/2.9/ui /snap/2.9/ui /snap/3.0/cli /snap/3.0/ui
<a href="#heading--machine-config"><h2 id="heading--machine-config">How to find machine configuration info</h2></a>
rad-end

rad-begin /deb/2.9/ui /snap/2.9/ui
The final tab from the Machine menu allows you to update machine and power configuration options: 

<a href="https://discourse.maas.io/uploads/default/original/1X/13bb1352103c759365fc6b923672f021982a10c3.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/13bb1352103c759365fc6b923672f021982a10c3.jpeg"></a> 

There are two sections to this tab.  The "Machine configuration" section offers some general parameters, mostly related to how this machine is grouped and categorised.  More information on these options are found in the relevant sections of the documentation (e.g., tags, resource pools, and so forth). 

The "Power configuration" supplies the parameters necessary for MAAS to access the machine to PXE-boot it. Note that this machine failed testing.  Editing the "Power configuration" section gives us a clue as to what might be wrong:
<a href="https://discourse.maas.io/uploads/default/original/1X/8f4c4ae8ec07f42551bad654375f513debc53ef1.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8f4c4ae8ec07f42551bad654375f513debc53ef1.jpeg"></a> 

After entering the correct password and recycling things, the problem goes away:

<a href="https://discourse.maas.io/uploads/default/original/1X/635e27e87bcac0c3cb3ce3085bd2fa55f60ff137.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/635e27e87bcac0c3cb3ce3085bd2fa55f60ff137.jpeg"></a> 
rad-end

rad-begin /snap/3.0/ui /deb/3.0/ui
The final tab from the Machine menu allows you to update machine and power configuration options: 

<a href="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/7/7cfd77228a5cf1a6f779897d501f14fbf78fd4b4.png"></a> 

There are two sections to this tab.  The "Machine configuration" section, shown above, offers some general parameters, mostly related to how this machine is grouped and categorised.  More information on these options are found in the relevant sections of the documentation (e.g., tags, resource pools, and so forth). 

The "Power configuration" supplies the parameters necessary for MAAS to access the machine to PXE-boot it: 

<a href="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/198898362285e4a1308535a4aa701156a67c9616.png"></a> 
rad-end

rad-begin /deb/2.9/ui /deb/3.0/ui /snap/2.9/ui /snap/3.0/ui
More information on Power configuration will be found in the [Power management](/t/power-management/nnnn) section of this documentation.
rad-end

