<!-- "Get to know your machines" -->
As an exercise, let's create some virtual machines with MAAS and find out how to examine them.  Be sure you've completed [this tutorial](/t/bootstrap-maas/5092) first, so that everything is set up and running.

<a href="#heading--Step-1-Create-a-virtual-machine"><h2 id="heading--Step-1-Create-a-virtual-machine">Step 1: Create a virtual machine</h2></a>

Create your first virtual machine with the following procedure:

1. Open your web browser and access the MAAS web interface.

2. In the MAAS navigation menu, click on "KVM" and then select "LXD".

3. Choose the LXD KVM host you previously created in the [previous tutorial](/t/bootstrap-maas/5092), or any other available LXD KVM host.

4. Select "Add VM".

5. Optionally, provide a name for the new VM.

6. Scroll down to the "Compose machine" section and select it. You should see a success message shortly after.

7. Navigate to the "Hardware" tab and click on "Machines".

8. Look for the newly created-machine by checking for the "Commissioning" message.

9. Underneath the "Commissioning" status, you will see MAAS progressing through the various stages of commissioning for the machine. This process may take a few minutes.

10. Watch for the machine to change to the "Ready" status, and switch off.

Congratulations!  You just created your first MAAS machine.

<a href="#heading--Step-2-Get-to-know-your-new-machine"><h2 id="heading--Step-2-Get-to-know-your-new-machine">Step 2: Get to know your new machine</h2></a>

Select the machine name; MAAS will zoom in on the machine, displaying several tabs across the top.  Let's briefly run through each tab in turn, using typical values for a standard LXD VM (yours may vary some).

<a href="#heading--Status-tab"><h3 id="heading--Status-tab">Status tab</h3></a>

The "Virtual Machine Status" section provides an overview of the current status and configuration of the virtual machine. Let's break down the different panels:

- **Ready**: This indicates that the virtual machine is ready for use, that is, it can be allocated and deployed.

- **CPU**: Specifies the CPU architecture and details of the virtual machine's processor. In this case, it is an AMD64/Generic CPU with 1 core running at 1.6 GHz, specifically an Intel Core i5-10210U CPU. You can also test the CPU to verify its functionality.

- **Memory**: Displays the amount of memory allocated to the virtual machine, which is 2 GiB (gibibytes). You can also perform a memory test if needed.

- **Storage**: Indicates the total storage capacity of the virtual machine, which is 8 GB over 1 disk. You can click on "View results" to get more detailed information about the storage configuration.

- **Owner**: Shows the owner of the virtual machine. Since your machine has not been *Allocated*, it will not have any owner information.

- **Host**: Specifies the network bridge (lxdbr0) to which the virtual machine is connected.

- **Zone**: Identifies the zone in which the virtual machine resides. For a new machine, it is the default zone.

- **Resource pool**: Indicates the resource pool to which the virtual machine belongs. For a new machine, it is the default resource pool.

- **Power type**: Specifies the power type used for the virtual machine, which is LXD.

- **Tags**: Displays any tags assigned to the virtual machine. As a new LXD VM, it has the tags "pod-console-logging" and "virtual".

- **Hardware Information**: Provides details about the virtual machine's hardware configuration.

- **System**: Describes the system information of the virtual machine, including the vendor (e.g., QEMU), product (e.g., Standard PC), version, and serial number.

- **Mainboard**: Specifies information about the virtual machine's mainboard, including the vendor (e.g., Canonical Ltd.), product (e.g, LXD), firmware (e.g., EFI Development Kit II / OVMF), boot mode (e.g., UEFI), version, and date.

- **1 NUMA NODE**: Indicates the NUMA (Non-Uniform Memory Access) node configuration of the virtual machine. It shows the details of Node 0, including the CPU cores (e.g., 1 core) and memory (e.g., 2 GiB) assigned to that node.

- **Network**: Provides information about the virtual machine's network configuration. It displays the network interface name, MAC address, assigned IP address, subnet, link speed, fabric, VLAN, DHCP status, and SR-IOV (Single Root I/O Virtualization) support.

- **Test network**: Allows you to perform a network test to check the connectivity and functionality of the virtual machine's network.

Let's run some tests to assess the virtual machine's CPU performance. Follow these steps:

1. Select *Test CPU...*.

2. In the displayed panel, select *Start tests for machine*.  Notice that the *Test...* button in the CPU panel will transform into a hyperlinked number, accompanied by the phrase *View results*.

3. Select the hyperlinked number to navigate to the *Tests* tab. Most likely, several tests will be listed as *Pending*.

4. Switch to the *Summary* tab and click on *View results*; this action will also redirect you to the *Tests* tab.

5. Keep an eye on the *Tests* tab as the tests are being executed.

6. Periodically, access the *Logs* section to view more detailed status updates about the ongoing testing process.

7. If you wish to stop the tests, do this: Go to the navigation menu, select *Hardware > Machines*, mark the checkbox corresponding to the machine undergoing tests, and choose *Actions > Abort* (confirm the action when prompted).

Feel free to explore other Test... options independently.  By following these steps, you can evaluate the the fitness and performance of the virtual machine and monitor the progress of the tests.

<a href="#heading--Network-tab"><h3 id="heading--Network-tab">Network tab</h3></a>

The network tab in MAAS provides a comprehensive overview of the network configuration for your machines. It displays essential information such as interfaces, bonds, bridges, VLANs, subnets, and DHCP snippets. Each entry in the table represents a distinct network element and includes details like MAC address, link speed, associated fabric, subnet information, and more. Additionally, you can perform various actions related to network management, such as adding interfaces, creating bonds and bridges, and validating the network configuration. 

For the moment, let's ignore most of the buttons on this page and explore the central table that describes the interfaces. Reviewing the table, we find the following columns:

- **NAME**: The name of the interface or bridge. It identifies the network device within MAAS.
- **MAC**: The MAC address associated with the network device. It serves as a unique identifier for the device.
- **PXE**: Indicates whether the interface can be used to PXE (Preboot Execution Environment) boot the device.
- **LINK/INTERFACE SPEED**: Represents the link speed and interface speed of the network device. It indicates the maximum data transfer rate between the device and the network. This column may contain zeroes under certain conditions, such as when the link has not been tested or is not active.
- **TYPE: Specifies the type of network device, such as "Physical" for a physical interface or "Alias" for an alias interface.
- **NUMA NODE**: Identifies the NUMA (Non-Uniform Memory Access) node to which the network device is assigned. NUMA architecture optimizes memory access in multiprocessor systems.
- **FABRIC**: Indicates the associated fabric, which represents a network fabric or infrastructure in MAAS. It helps organize and manage network resources.
- **VLAN**: Describes the VLAN (Virtual Local Area Network) configuration for the network device. VLANs enable the segmentation and isolation of network traffic.
- **SUBNET**: Provides details about the subnet associated with the network device.
- **NAME**: The name of the subnet, which helps identify and differentiate it from other subnets. This is often the same as the subnet address, unless you have otherwise labelled it.
- **IP ADDRESS**: The IP address assigned to the subnet, or alternatively, the IP allocation method (e.g., "Auto assign"),.
- **STATUS**: Reflects the status of the network configuration. It indicates whether the configuration is active, pending, or has encountered an error. A blank status does not necessarily indicate an error.
- **DHCP**: Displays the DHCP (Dynamic Host Configuration Protocol) status. It indicates whether DHCP is enabled or disabled for the subnet, and how the DHCP is provided.
- **ACTIONS**: Shows the available actions for network management. These actions may include disconnecting an interface, setting an alias, changing the VLAN configuration, editing the physical interface, removing the interface altogether, or, if the interface is an alias, editing or removing the alias.