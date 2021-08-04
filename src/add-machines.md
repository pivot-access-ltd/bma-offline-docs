<a href="#heading--how-to-add-a-machine-manually"><h2 id="heading--how-to-add-a-machine-manually">How to add a machine manually</h2></a>

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

<a href="#heading--how-to-add-machines-via-a-chassis"><h2 id="heading--how-to-add-machines-via-a-chassis">How to add machines via a chassis</h2></a>

Use the chassis feature to add multiple machines at once. This feature can only be done via the MAAS UI.

To do this, instead of selecting 'Machine' as above, choose 'Chassis' from the drop-down menu. In the following example, MAAS will add all available VMs from the given  virsh address:

<a href="https://discourse.maas.io/uploads/default/original/1X/e7f88bce68318cf3c6a8e97b4d31d0b6980e0f32.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e7f88bce68318cf3c6a8e97b4d31d0b6980e0f32.jpeg"></a>

The required fields will change based on the type of chassis you choose.

[note]
As with the manual method, the underlying machines will require netbooting.
[/note]

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
To commission, on the "Machines" page, select a machine and choose "Commission" under the "Take action" drop-down menu.

<a href="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png"></a>

You have the option of selecting some extra parameters (checkboxes) and performing hardware tests.

These options include:

-   **Allow SSH access and prevent machine powering off**: Machines are normally powered off after commissioning. This option keeps the machine on and enables SSH so you can access the machine.

-   **Retain network configuration**: When enabled, preserves any custom network settings previously configured for the machine. See [Networking](/t/networking/nnnn) for more information.

-   **Retain storage configuration**: When enabled, preserves any storage settings previously configured for the machine. See [Storage](/t/storage/nnnn) for more details.

-   **Update firmware**: Runs scripts tagged with `update_firmware`. See [Testing scripts](/t/commissioning-and-hardware-testing-scripts/nnnn#heading--automatic-script-selection-by-hardware-type) for more details.

-   **Configure HBA**: Runs scripts tagged with `configure_hba`. As above, see [Testing scripts](/t/commissioning-and-hardware-testing-scripts/nnnn#heading--automatic-script-selection-by-hardware-type) for further details.

<a href="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png"></a>

Click the Hardware tests field to reveal a drop-down list of tests to add and run during commissioning. See [Hardware testing](/t/hardware-testing/nnnn)) for more information on hardware testing scripts.

Finalise the directive by hitting "Commission machine".

While commissioning, the machine status will change to reflect this state (Commissioning).  MAAS discovers the machine's network topology.  MAAS then prompts a machine network interface to connect to the fabric, VLAN, and subnet combination for configuration. Usually, MAAS assigns a static IP address out of the reserved IP range for the subnet ("Auto assign" mode). The next section details several assignment modes.

Once commissioned, a machine's status will change to Ready, and an extra tab for the machine called "Commissioning" will become available. This tab contains the results of the scripts executed during the commissioning process.
rad-end

Once commissioned, you may consider [creating or applying a tag](/t/maas-tags/2896) to this machine.  The next step is [deployment](/t/deploy-machines/nnnn).

<a href="#heading--about-numa-sriov-commissioning"><h2 id="heading--about-numa-sriov-commissioning">About commissioning NUMA and SR-IOV nodes</h2></a>

If you are using the NUMA architecture, MAAS versions 2.7 and higher guarantee that machines are assigned to a single NUMA node that contains all the machine's resources. Node boundaries are critical, especially in vNUMA situations.  Splitting nodes can create unnecessary latency.  You want the NUMA node boundaries to match VM boundaries if at all possible.

[note]
You must recommission NUMA/SR-IOV machines that were previously commissioned under version 2.6 or earlier.
[/note]

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
<a href="https://discourse.maas.io/uploads/default/original/1X/7b47235ff57a570ccba6a6ed09186a3d7483f5a4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/7b47235ff57a570ccba6a6ed09186a3d7483f5a4.png"></a> 

When using these nodes, you can specify a node index for interfaces and physical block devices.  MAAS will display the NUMA node index and details, depending upon your configuration, to include the count of NUMA nodes, number of CPU cores, memory, NICs, and node spaces for bonds and block devices.  You can also filter machines by CPU cores, memory, subnet, VLAN, fabric, space, storage, and RAID, among others.
rad-end

<a href="#heading--about-maas-commissioning-scripts"><h2 id="heading--about-maas-commissioning-scripts">About MAAS commissioning scripts</h2></a>

When a machine boots, MAAS first instructs it to run cloud-init to set up SSH keys (during commissioning only), set up NTP, and execute a script that runs other commissioning scripts.  Currently, the sequence of MAAS-provided commissioning scripts proceeds like this:

* **maas-support-info:** MAAS gathers information that helps to identify and characterise the machine for debugging purposes, such as the kernel, versioning of various components, etc.  **Runs in parallel with other scripts.**

* **maas-lshw:** this script pulls system BIOS and vendor info, and generates user-defined tags for later use.  **Runs in parallel with other scripts.**

* **20-maas-01-install-lldpd:** this script installs the link layer discovery protocol (LLDP) daemon, which will later capture networking information about the machine.  This script provides some extensive logging.

* **maas-list-modaliases:** this script figures out what hardware modules are loaded, providing a way to autorun certain scripts based on which modules are loaded.  **Runs in parallel with other scripts.**

* **20-maas-02-dhcp-unconfigured-ifaces:** MAAS will want to know all the ways the machine is connected to the network.  Only PXE comes online during boot; this script brings all the other networks online so they can be recognised.  This script provides extensive logging.

* **maas-get-fruid-api-data:** this script gathers information for the Facebook wedge power type.  **Runs in parallel with other scripts.**

* **maas-serial-ports:** this script lists what serial ports are available on the machine.  **Runs in parallel with other scripts.**

rad-begin /snap/2.9/ui /snap/2.9/cli /deb/2.9/ui /deb/2.9/cli
* **40-maas-01-network-interfaces:** this script is just used to get the IP address, which can then be associated with a VLAN/subnet.
rad-end

rad-begin /snap/2.9/ui /snap/2.9/cli /deb/2.9/ui /deb/2.9/cli 
* **50-maas-01-commissioning:** this script is the main MAAS tool, gathering information on machine resources, such as storage, network devices, CPU, RAM, etc.  We currently pull this data using lxd: We use a Go binary built from lxd source that just contains the minimum source to gather the resource information we need.  This script also checks whether the machine being commissioning is a virtual machine, which may affect how MAAS interacts with it.
rad-end

rad-begin /snap/3.0/ui /snap/3.0/cli /deb/3.0/ui /deb/3.0/cli
* **50-maas-01-commissioning:** this script is the main MAAS tool, gathering information on machine resources, such as storage, network devices, CPU, RAM, details about attached USB and PCI devices, etc.  We currently pull this data using lxd: We use a Go binary built from lxd source that just contains the minimum source to gather the resource information we need.  This script also checks whether the machine being commissioning is a virtual machine, which may affect how MAAS interacts with it.
rad-end

* **maas-capture-lldp:** this script gathers LLDP network information to be presented on the logs page; this data is not used by MAAS at all.  **Runs in parallel with other scripts.**

* **maas-kernel-cmdline:** this script is used to update the boot devices; it double-checks that the right boot interface is selected. 

Commissioning runs the same dozen or so scripts as enlistment, gathering all the same information, but with these seven caveats: 

1. Commissioning also runs user-supplied commissioning scripts, if present.  Be aware that these scripts run as root, so they can execute any system command.

2. Commissioning runs test scripts which are not run during enlistment.

3. Commissioning scripts can send BMC configuration data, and can be used to configure BMC data.

4. The environment variable BMC_CONFIG_PATH is passed to serially run commissioning scripts; these scripts may write BMC power credentials to BMC_CONFIG_PATH in YAML format, where each key is a power parameter.  The first script to write BMC_CONFIG_PATH is the only script allowed to configure the BMC, allowing you to override MAAS' built-in BMC detection.  If the script returns 0, that value will be send to MAAS.

5. All built-in commissioning scripts have been migrated into the database.

6. `maas-run-remote-scripts` is capable of enlisting machines, so enlistment `user-data` scripts have been removed.

7. The metadata endpoints `http://<MAAS>:5240/<latest or 2012-03-01>/` and `http://<MAAS>:5240/<latest or 2012-03-01>/meta-data/` are now available anonymously for use during enlistment.

In both enlistment and commissioning, MAAS uses either the MAC address or the UUID to identify machines.  Currently, because some machine types encountered by MAAS do **not** use unique MAC addresses, we are trending toward using the UUID.


rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
To commission a machine:

``` bash
maas $PROFILE machine commission $SYSTEM_ID
```

[note]
To commission a node, it must have a status of "New".
[/note]

To commission all nodes in the "New" state:

``` bash
maas $PROFILE machines accept-all
```

You have the option of setting some parameters to change how commissioning runs:

1. `enable_ssh`: Optional integer. Controls whether to enable SSH for the commissioning environment using the user's SSH key(s). '1' == True, '0' == False. Roughly equivalent to the **Allow SSH access and prevent machine powering off** in the web UI.

2. `skip_bmc_config`: Optional integer.  Controls whether to skip re-configuration of the BMC for IPMI based machines. '1' == True, '0' == False.

3. `skip_networking`: Optional integer.  Controls whether to skip re-configuring the networking on the machine after the commissioning has completed. '1' == True, '0' == False. Roughly equivalent to **Retain network configuration** in the web UI.

4. `skip_storage`: Optional integer.  Controls hether to skip re-configuring the storage on the machine after the commissioning has completed. '1' == True, '0' == False.  Roughly equivalent to **Retain storage configuration** in the web UI.

5. `commissioning_scripts`: Optional string.  A comma separated list of commissioning script names and tags to be run. By default all custom commissioning scripts are run. Built-in commissioning scripts always run. Selecting `update_firmware` or `configure_hba` will run firmware updates or configure HBA's on matching machines.

6. `testing_scripts`: Optional string.  A comma seperated list of testing script names and tags to be run. By default all tests tagged `commissioning` will be run. Set to `none` to disable running tests.

7. `parameters`: Optional string.  Scripts selected to run may define their own parameters. These parameters may be passed using the parameter name. Optionally a parameter may have the script name prepended to have that parameter only apply to that specific script.

rad-end


<!-- comment -->
