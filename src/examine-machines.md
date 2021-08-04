This document describes the various ways you can evaluate the health and status of your MAAS machines, using the machine list.  It will show you:

- [How to view the machine list](#heading--how-to-view-the-machine-list)
- [How to view machine details](#heading--how-to-view-machine-details)
- [How to manage attached USB and PCI devices](#heading--usb-pci-devices)
- [How to find network info for a machine](#heading--machine-interfaces)
- [How to find storage info for a machine](#heading--machine-storage)
- [How to find commissioning logs](#heading--commissioning-log)
- [How to find machine hardware & test logs](#heading--hardware-tests)
- [How to find raw log output for a machine](#heading--raw-log-output)
- [How to find a machine's event logs](#heading--event-logs)
- [How to find machine configuration info](#heading--machine-config)

<a href="#heading--how-to-view-the-machine-list"><h2 id="heading--how-to-view-the-machine-list">How to view the machine list</h2></a>

To view the machine list, select "Machines" on the top menu of the MAAS web UI:

<a href="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/19e038dbc6e669bfffc0ea5a9946432a75142bfb.jpeg"></a> 

To quickly view more details, roll the cursor over status icons:

<a href="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8f78a8877a029e7a44bcd4cf3d138499637fe790.jpeg"></a> 

<a href="#heading--how-to-view-machine-details"><h2 id="heading--how-to-view-machine-details">How to view machine details</h2></a>

To open a detailed view of a machine's status and configuration, click a machine's FQDN or MAC address:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a8ff4caf6362a3d695682499a74d64cb189dfc37.png"></a>

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

<a href="#heading--machine-interfaces"><h2 id="heading--machine-interfaces">How to find network info for a machine</h2></a>

To find network info for a specific machine, open that machine's "Network" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c5316db130ae05a9cdabcd49ffaa69f0bb405d1d.png"></a> 

Options on this tab are described in the introduction to [Networking](/t/networking/nnnn) article in this documentation set.

<a href="#heading--how-to-find-machine-storage-info"><h2 id="heading--how-to-find-machine-storage-info">How to find machine storage info</h2></a>

To view/edit machine storage info, click on the "Storage" tab in the machine summary:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/658f4814716a1347fda62ab799ba0d72506c128e.png"></a> 

See the article [Storage](/t/storage/nnn) for a detailed instructions on how to use this screen.

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

The format of these screens is very similar to the Configuration logs shown above.  For more information, please see the article on [Hardware testing](/t/hardware-testing/nnnn).  

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
