<!-- "How to put machines to work" -->
The ultimate purpose of MAAS is to deploy and manage machines.  It's important to understand [how images get deployed](/t/how-to-acquire-images/6192#heading--how-images-deploy) -- as explained in [About the machine life-cycle](/t/how-to-manage-machines/6193#heading--about-the-machine-life-cycle), machines must first be enlisted or commissioned, then allocated, then deployed.  This article will help you build on that understanding by explaining:

- [How to commission a machine](#heading--how-to-commission-a-machine)
- [How to test machines](#heading--how-to-test-machines)
- [How to allocate machines](#heading--allocate-machines)
- [How to deploy machines](#heading--deploy)

<a href="#heading--how-to-commission-a-machine"><h2 id="heading--how-to-commission-a-machine">How to commission a machine</h2></a>

Note that if you are using your own commissioning scripts, and you do not want them to automatically run every time, you must specify `noauto`, as in this script snippet:

```
#!/bin/bash
#
# --- Start MAAS 1.0 script metadata ---
# name: 50-script-example
# title: Example
# description: Just an example
# script_type: commissioning
# tags: noauto
```

If you do not specify `noauto`, your custom commissioning scripts will run every time commissioning is attempted.

[tabs]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To commission a machine:

- Go to the "Machines" page.

- Select the machine(s) you want to commission.

- Choose "Commission" under the "Take action" drop-down menu:

<a href="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png"></a>

You have the option of selecting some extra parameters (checkboxes) and performing hardware tests.

These options include:

- **Allow SSH access and prevent machine powering off**: Machines are normally powered off after commissioning. This option keeps the machine on and enables SSH so you can access the machine.

- **Retain network configuration**: When enabled, preserves any custom network settings previously configured for the machine. See [Networking](/t/networking/6680) for more information.

- **Retain storage configuration**: When enabled, preserves any storage settings previously configured for the machine. See [Storage](/t/how-to-manage-machines/6193#heading--about-storage) for more details.

- **Update firmware**: Runs scripts tagged with `update_firmware`.

- **Configure HBA**: Runs scripts tagged with `configure_hba`.

<a href="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png"></a>

- Click the Hardware tests field to reveal a drop-down list of tests to add and run during commissioning. See [Hardware testing](/t/how-to-manage-machines/6193#heading--about-testing-hardware) for more information on hardware testing scripts.

- Finalise the directive by hitting "Commission machine".

While commissioning, the machine status will change to reflect this state (Commissioning).  MAAS discovers the machine's network topology.  MAAS then prompts a machine network interface to connect to the fabric, VLAN, and subnet combination for configuration. Usually, MAAS assigns a static IP address out of the reserved IP range for the subnet ("Auto assign" mode). The next section details several assignment modes.

Once commissioned, a machine's status will change to Ready, and an extra tab for the machine called "Commissioning" will become available. This tab contains the results of the scripts executed during the commissioning process.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To commission a machine that's in the "Ready" state, via the CLI, use the following command:

```nohighlight
maas $PROFILE machine commission $SYSTEM_ID
```
<details><summary>Typical JSON output (long listing)</summary>

```nohighlight
Success.
Machine-readable output follows:
{
    "storage_test_status_name": "Pending",
    "bcaches": [],
    "cpu_count": 1,
    "interface_set": [
        {
            "params": ",
            "numa_node": 0,
            "tags": [],
            "id": 10,
            "mac_address": "52:54:00:15:36:f2",
            "vendor": "Red Hat, Inc.",
            "children": [],
            "effective_mtu": 1500,
            "discovered": [],
            "links": [],
            "link_speed": 0,
            "link_connected": true,
            "system_id": "bhxws3",
            "enabled": true,
            "interface_speed": 0,
            "firmware_version": null,
            "name": "ens3",
            "sriov_max_vf": 0,
            "product": null,
            "vlan": {
                "vid": 0,
                "mtu": 1500,
                "dhcp_on": true,
                "external_dhcp": null,
                "relay_vlan": null,
                "fabric": "fabric-2",
                "primary_rack": "8dwnne",
                "name": "untagged",
                "id": 5003,
                "space": "undefined",
                "secondary_rack": null,
                "fabric_id": 2,
                "resource_uri": "/MAAS/api/2.0/vlans/5003/"
            },
            "parents": [],
            "type": "physical",
            "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/interfaces/10/"
        }
    ],
    "network_test_status_name": "Unknown",
    "numanode_set": [
        {
            "index": 0,
            "memory": 985,
            "cores": [
                0
            ]
        }
    ],
    "locked": false,
    "hardware_uuid": "F677A842-571C-4E65-ADC9-11E2CF92D363",
    "default_gateways": {
        "ipv4": {
            "gateway_ip": null,
            "link_id": null
        },
        "ipv6": {
            "gateway_ip": null,
            "link_id": null
        }
    },
    "status_action": ",
    "status_message": "Commissioning",
    "cpu_test_status_name": "Unknown",
    "memory_test_status": -1,
    "virtualblockdevice_set": [],
    "pool": {
        "name": "default",
        "description": "Default pool",
        "id": 0,
        "resource_uri": "/MAAS/api/2.0/resourcepool/0/"
    },
    "current_testing_result_id": 9,
    "current_installation_result_id": null,
    "netboot": true,
    "description": ",
    "special_filesystems": [],
    "testing_status": 0,
    "memory": 1024,
    "current_commissioning_result_id": 8,
    "storage": 5368.70912,
    "commissioning_status": 0,
    "cpu_test_status": -1,
    "tag_names": [
        "virtual"
    ],
    "memory_test_status_name": "Unknown",
    "swap_size": null,
    "status_name": "Commissioning",
    "other_test_status": -1,
    "pod": null,
    "storage_test_status": 0,
    "blockdevice_set": [
        {
            "id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
            "size": 5368709120,
            "block_size": 512,
            "tags": [
                "ssd"
            ],
            "serial": "QM00001",
            "uuid": null,
            "numa_node": 0,
            "available_size": 5368709120,
            "id": 3,
            "partition_table_type": null,
            "model": "QEMU HARDDISK",
            "path": "/dev/disk/by-dname/sda",
            "storage_pool": null,
            "used_for": "Unused",
            "filesystem": null,
            "system_id": "bhxws3",
            "used_size": 0,
            "partitions": [],
            "name": "sda",
            "type": "physical",
            "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
        }
    ],
    "other_test_status_name": "Unknown",
    "distro_series": ",
    "testing_status_name": "Pending",
    "ip_addresses": [],
    "address_ttl": null,
    "system_id": "bhxws3",
    "physicalblockdevice_set": [
        {
            "firmware_version": "2.5+",
            "serial": "QM00001",
            "uuid": null,
            "numa_node": 0,
            "available_size": 5368709120,
            "size": 5368709120,
            "tags": [
                "ssd"
            ],
            "id": 3,
            "partition_table_type": null,
            "id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
            "model": "QEMU HARDDISK",
            "path": "/dev/disk/by-dname/sda",
            "storage_pool": null,
            "used_for": "Unused",
            "filesystem": null,
            "system_id": "bhxws3",
            "used_size": 0,
            "partitions": [],
            "name": "sda",
            "block_size": 512,
            "type": "physical",
            "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
        }
    ],
    "fqdn": "ace-swan.maas",
    "osystem": ",
    "domain": {
        "authoritative": true,
        "ttl": null,
        "resource_record_count": 0,
        "name": "maas",
        "id": 0,
        "is_default": true,
        "resource_uri": "/MAAS/api/2.0/domains/0/"
    },
    "boot_interface": {
        "params": ",
        "numa_node": 0,
        "tags": [],
        "id": 10,
        "mac_address": "52:54:00:15:36:f2",
        "vendor": "Red Hat, Inc.",
        "children": [],
        "effective_mtu": 1500,
        "discovered": [],
        "links": [],
        "link_speed": 0,
        "link_connected": true,
        "system_id": "bhxws3",
        "enabled": true,
        "interface_speed": 0,
        "firmware_version": null,
        "name": "ens3",
        "sriov_max_vf": 0,
        "product": null,
        "vlan": {
            "vid": 0,
            "mtu": 1500,
            "dhcp_on": true,
            "external_dhcp": null,
            "relay_vlan": null,
            "fabric": "fabric-2",
            "primary_rack": "8dwnne",
            "name": "untagged",
            "id": 5003,
            "space": "undefined",
            "secondary_rack": null,
            "fabric_id": 2,
            "resource_uri": "/MAAS/api/2.0/vlans/5003/"
        },
        "parents": [],
        "type": "physical",
        "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/interfaces/10/"
    },
    "hostname": "ace-swan",
    "network_test_status": -1,
    "min_hwe_kernel": ",
    "power_state": "off",
    "interface_test_status_name": "Unknown",
    "owner_data": {},
    "volume_groups": [],
    "power_type": "virsh",
    "node_type": 0,
    "owner": "admin",
    "cache_sets": [],
    "architecture": "amd64/generic",
    "hwe_kernel": null,
    "zone": {
        "name": "default",
        "description": ",
        "id": 1,
        "resource_uri": "/MAAS/api/2.0/zones/default/"
    },
    "disable_ipv4": false,
    "boot_disk": {
        "firmware_version": "2.5+",
        "serial": "QM00001",
        "uuid": null,
        "numa_node": 0,
        "available_size": 5368709120,
        "size": 5368709120,
        "tags": [
            "ssd"
        ],
        "id": 3,
        "partition_table_type": null,
        "id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
        "model": "QEMU HARDDISK",
        "path": "/dev/disk/by-dname/sda",
        "storage_pool": null,
        "used_for": "Unused",
        "filesystem": null,
        "system_id": "bhxws3",
        "used_size": 0,
        "partitions": [],
        "name": "sda",
        "block_size": 512,
        "type": "physical",
        "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
    },
    "status": 1,
    "iscsiblockdevice_set": [],
    "raids": [],
    "node_type_name": "Machine",
    "hardware_info": {
        "system_vendor": "QEMU",
        "system_product": "Standard PC (i440FX + PIIX, 1996)",
        "system_family": "Unknown",
        "system_version": "pc-i440fx-focal",
        "system_sku": "Unknown",
        "system_serial": "Unknown",
        "cpu_model": "Intel Core Processor (Skylake, IBRS)",
        "mainboard_vendor": "Unknown",
        "mainboard_product": "Unknown",
        "mainboard_serial": "Unknown",
        "mainboard_version": "Unknown",
        "mainboard_firmware_vendor": "SeaBIOS",
        "mainboard_firmware_date": "04/01/2014",
        "mainboard_firmware_version": "1.13.0-1ubuntu1",
        "chassis_vendor": "QEMU",
        "chassis_type": "Other",
        "chassis_serial": "Unknown",
        "chassis_version": "pc-i440fx-focal"
    },
    "commissioning_status_name": "Pending",
    "bios_boot_method": "pxe",
    "interface_test_status": -1,
    "cpu_speed": 0,
    "resource_uri": "/MAAS/api/2.0/machines/bhxws3/"
}
```

</details>

If you need to find the machine's $SYSTEM_ID, you can use a command like this one:

```nohighlight
maas $PROFILE machines read | jq '.[] | .hostname, .system_id'
"ace-swan"
"bhxws3"
```
[/tab]
[/tabs]

Once commissioned, you may consider adding a tag to this machine.  The next step is testing and deployment.

<a href="#heading--how-to-test-machines"><h2 id="heading--how-to-test-machines">How to test machines</h2></a>

This section explains:

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
- [How to download built-in scripts](#heading--how-to-download-built-in-scripts)
- [How to upload scripts](#heading--how-to-upload-scripts)
- [How to debug script failures](#heading--how-to-debug-script-failures)
- [How to locate script files](#heading--how-to-locate-script-files)
- [How to locate log files](#heading--how-to-locate-log-files)
- [How to run all scripts manually](#heading--how-to-run-all-scripts-manually)
- [How to apply a hardware test](#heading--apply-a-hardware-test)
- [How to test network links](#heading--network-link-testing)
- [How to detect slow network links](#heading--slow-link-detection)
- [How to configure network validation and testing scripts](#heading--network-validation-scripts-and-testing)
- [How to customise network testing](#heading--customisable-network-testing)
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
- [How to locate script files](#heading--how-to-locate-script-files)
- [How to locate log files](#heading--how-to-locate-log-files)
- [How to run all scripts manually](#heading--how-to-run-all-scripts-manually)
- [How to apply a hardware test](#heading--apply-a-hardware-test)
- [How to test network links](#heading--network-link-testing)
- [How to detect slow network links](#heading--slow-link-detection)
- [How to configure network validation and testing scripts](#heading--network-validation-scripts-and-testing)
- [How to customise network testing](#heading--customisable-network-testing)
- [How to download built-in scripts](#heading--how-to-download-built-in-scripts)
- [How to upload hardware testing scripts](#heading--how-to-upload-hardware-testing-scripts)
- [How to list all uploaded hardware testing scripts](#heading--how-to-list-all-uploaded-hardware-testing-scripts)
- [How to update hardware testing scripts](#heading--how-to-update-hardware-testing-scripts)
- [How to revert hardware testing scripts](#heading--how-to-revert-hardware-testing-scripts)
- [How to download a script](#heading--how-to-download-a-script)
- [How to delete a script](#heading--how-to-delete-a-script)
- [How to view script results](#heading--how-to-view-script-results)
- [How to filter script results](#heading--how-to-filter-script-results)
- [How to suppress failed results](#heading--how-to-suppress-failed-results)
- [How to upload hardware test scripts](#heading--upload-test-scripts)
- [How to use tags to group commissioning and testing scripts](#heading--tags-group-scripts)
- [How to view testing results](#heading--results)
- [How to test network links](#heading--network-link-testing)
- [How to detect slow network links](#heading--slow-link-detection)
- [How to configure network validation and testing scripts](#heading--network-validation-scripts-and-testing)
- [How to customise network testing](#heading--customisable-network-testing)
[/tab]
[/tabs]

You can also refer to technical details and examples for [commissioning scripts](/t/commissioning-scripts-reference/5375) and [testing scripts](/t/hardware-test-scripts-reference/5392) as needed.

<a href="#heading--how-to-download-built-in-scripts"><h3 id="heading--how-to-download-built-in-scripts">How to download built-in scripts</h3></a>

You can download the source for all commissioning and test scripts via the API with the following command:

``` nohighlight
maas $PROFILE node-script download $SCRIPT_NAME
```

The source code to all built-in scripts is available on [launchpad](https://git.launchpad.net/maas/tree/src/metadataserver/builtin_scripts)`↗`.

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--how-to-upload-scripts"><h3 id="heading--how-to-upload-scripts">How to upload scripts</h3></a>

Scripts can be uploaded to MAAS using the web UI. Select the 'User scripts' tab of the 'Settings' page - the 'Commissioning scripts' section is near the top. Within the Commissioning scripts section, click the Upload script button followed by 'Choose file' to open a requester, locate the script, and select Upload to upload it to MAAS.

A status message of Commissioning script created will appear.  You'll then be able to select your script after selecting [Test hardware](/t/how-to-manage-machines/6193#heading--about-testing-hardware) from a machine's 'Take action' menu.

<a href="https://assets.ubuntu.com/v1/50e08fdf-nodes-hw-scripts__2.4_select.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/50e08fdf-nodes-hw-scripts__2.4_select.png"></a>

[note]
MAAS executes scripts in lexicographical order. This order allows you to control when your scripts execute, and whether they run before or after the standard MAAS scripts.
[/note]

<a href="#heading--how-to-debug-script-failures"><h3 id="heading--how-to-debug-script-failures">How to debug script failures</h3></a>

Clicking on the title of a completed or failed script will reveal the output from that specific script.

<a href="https://assets.ubuntu.com/v1/855015e5-nodes-hw-scripts__2.2_fail.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/855015e5-nodes-hw-scripts__2.2_fail.png"></a>

If you need further details, especially when writing and running your own scripts, you can connect to a machine and examine its logs and environment.

To do this, enable Allow SSH access and prevent the machine from powering off when selecting 'Test hardware' from the machine 'Take action' menu.

<a href="https://assets.ubuntu.com/v1/da793c67-nodes-hw-scripts__2.4_ssh.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/da793c67-nodes-hw-scripts__2.4_ssh.png"></a>

Because scripts operate within an ephemeral version of Ubuntu, enabling this option stops the machine from shutting down, allowing you to connect and probe a script's status.

As long as you've added your [SSH key](/t/how-to-manage-user-accounts/5184) to MAAS, you can connect with SSH to the machine's IP with a username of `ubuntu`. Type `sudo -i` to get root access.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
<a href="#heading--how-to-upload-hardware-testing-scripts"><h3 id="heading--how-to-upload-hardware-testing-scripts">How to upload hardware testing scripts</h3></a>

To upload a hardware testing script to MAAS, enter the following:

```nohighlight
maas $PROFILE node-scripts create name=$SCRIPT_NAME name> \
 script=$PATH_TO_SCRIPT type=testing
```

Changing the type to commissioning adds the test script to the commissioning process.

<a href="#heading--how-to-list-all-uploaded-hardware-testing-scripts"><h3 id="heading--how-to-list-all-uploaded-hardware-testing-scripts">How to list all uploaded hardware testing scripts</h3></a>

You can list all uploaded scripts with the following command:

```nohighlight
maas $PROFILE node-scripts read type=testing filters=$TAG
```

The optional filters argument lets you search for tags assigned to a script, such as using `TAG=cpu` with the above example.

<a href="#heading--how-to-update-hardware-testing-scripts"><h3 id="heading--how-to-update-hardware-testing-scripts">How to update hardware testing scripts</h3></a>

A script's metadata, and even the script itself, can be updated from the command line:

```nohighlight
maas $PROFILE node-script update \
 $SCRIPT_NAME script=$PATH_TO_SCRIPT comment=$COMMENT
```

The JSON formatted output to the above command will include 'history' dictionary entries, detailing script modification times and associated comments:

```nohighlight
"history": [
    {
        "id": 40,
        "created": "Tue, 12 Sep 2017 12:12:08 -0000",
        "comment": "Updated version"
    },
    {
        "id": 34,
        "created": "Fri, 08 Sep 2017 17:07:46 -0000",
        "comment": null
    }
]
```

<a href="#heading--how-to-revert-hardware-testing-scripts"><h3 id="heading--how-to-revert-hardware-testing-scripts">How to revert hardware testing scripts</h3></a>

MAAS keeps a history of all uploaded script versions, allowing you to easily revert to a previous version, using the `id` of the desired version:

```nohighlight
maas $PROFILE node-script revert $SCRIPT_NAME to=$VERSION_ID
```

[note]
The history for later modifications will be lost when reverting to an earlier version of the script.
[/note]

<a href="#heading--how-to-download-a-script"><h3 id="heading--how-to-download-a-script">How to download a script</h3></a>

To download a script, enter the following:

```nohighlight
maas $PROFILE node-script download $SCRIPT_NAME > $LOCAL_FILENAME
```
<a href="#heading--how-to-delete-a-script"><h3 id="heading--how-to-delete-a-script">How to delete a script</h3></a>

To delete a script, use `delete`:

```nohighlight
maas $PROFILE node-script delete $SCRIPT_NAME
```

<a href="#heading--how-to-view-script-results"><h3 id="heading--how-to-view-script-results">How to view script results</h3></a>

The command line allows you to not only view the current script's progress but also retrieve the verbatim output from any previous runs too.

If you only want to see the latest or currently-running result, you can use `current-commissioning`, `current-testing`, or `current-installation` instead of an id:

```nohighlight
maas $PROFILE node-script-result read $SYSTEM_ID $RESULTS
```
<a href="#heading--how-to-filter-script-results"><h4 id="heading--how-to-filter-script-results">How to filter script results</h4></a>

You can also limit which results are returned by type (commissioning, testing, or installation), script name, or script run:

```nohighlight
maas $PROFILE node-script-results read \
 $SYSTEM_ID type=$SCRIPT_TYPE filters=$SCRIPT_NAME,$TAGS
```
<a href="#heading--how-to-suppress-failed-results"><h3 id="heading--how-to-suppress-failed-results">How to suppress failed results</h3></a>

You can also suppress failed results, which is useful if you want to ignore a known failure:

```nohighlight
maas $PROFILE node-script-results update \
 $SYSTEM_ID type=$SCRIPT_TYPE filters=$SCRIPT_NAME,$TAGS suppressed=$SUPPRESSED
```

where `$SUPPRESSED` is either `True` or `False`. The JSON formatted output to the above command will include 'results' dictionary with an entry for `suppressed`:

```nohighlight
"results": [
    {
        "id": 21,
        "created": "Tue, 02 Apr 2019 17:00:36 -0000",
        "updated": "Tue, 02 Apr 2019 20:56:41 -0000",
        "name": "smartctl-validate",
        "status": 5,
        "status_name": "Aborted",
        "exit_status": null,
        "started": "Tue, 02 Apr 2019 20:56:41 -0000",
        "ended": "Tue, 02 Apr 2019 20:56:41 -0000",
        "runtime": "0:00:00",
        "starttime": 1554238601.765214,
        "endtime": 1554238601.765214,
        "estimated_runtime": "0:00:00",
        "parameters": {
            "storage": {
                "argument_format": "{path}",
                "type": "storage",
                "value": {
                    "id_path": "/dev/vda",
                    "model": ",
                    "name": "sda",
                    "physical_blockdevice_id": 1,
                    "serial": "
                }
            }
        },
        "script_id": 1,
        "script_revision_id": null,
        "suppressed": true
    }
]
```

Finally, results can be downloaded, either to stdout, stderr, as combined output or as a tar.xz:

```nohighlight
maas $PROFILE node-script-result download $SYSTEM_ID $RUN_ID output=all \
 filetype=tar.xz > $LOCAL_FILENAME
```

[note]
**$RUN_ID** is labelled `id` in the verbose result output.
[/note]

[/tab]
[/tabs]

<a href="#heading--how-to-locate-script-files"><h3 id="heading--how-to-locate-script-files">How to locate script files</h3></a>

Commissioning and testing script files may be found in the following directories:

- `/tmp/user_data.sh.*/scripts/commissioning/`: Commissioning scripts
- `/tmp/user_data.sh.*/scripts/testing/`: Hardware testing scripts

<a href="#heading--how-to-locate-log-files"><h3 id="heading--how-to-locate-log-files">How to locate log files</h3></a>

Commissioning and testing log files may be found in the following directories:

- `/tmp/user_data.sh*/out/`
- `/var/log/cloud-init-output.log`
- `/var/log/cloud-init.log`

<a href="#heading--how-to-run-all-scripts-manually"><h3 id="heading--how-to-run-all-scripts-manually">How to run all scripts manually</h3></a>

You can also run all commissioning and hardware-testing scripts on a machine for debugging.

```nohighlight
/tmp/user_data.sh.*/bin/maas-run-remote-scripts \
    [--no-download] \
    [--no-send] \
    /tmp/user_data.sh.*
```

Where:

- `--no-download`: Optional. Do not download the scripts from MAAS again.
- `--no-send`: Optional. Do not send the results to MAAS.

For example, to run all the scripts again without downloading again from MAAS:

```nohighlight
/tmp/user_data.sh.*/bin/maas-run-remote-scripts --no-download /tmp/user_data.sh.*
```

Here, all the scripts are run again after downloading from MAAS, but no output data is sent to MAAS:

```nohighlight
/tmp/user_data.sh.*/bin/maas-run-remote-scripts --no-send /tmp/user_data.sh.*
```

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--apply-a-hardware-test"><h3 id="heading--apply-a-hardware-test">How to apply a hardware test</h3></a>

To launch a test, select the target machine from the 'Machines' page and use the 'Take action' drop-down menu to select 'Test hardware'. When ready, hit the 'Test machine' button. Here, a test is applied to a deployed machine:

<a href="https://assets.ubuntu.com/v1/8e876889-nodes-hw-testing__2.4_deployed.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/8e876889-nodes-hw-testing__2.4_deployed.png"></a>

There is the option of not powering off the machine and to allow SSH access.

A default test will be selected (`smartctl-validate`, a hard drive test) but you can choose others by clicking the 'Select scripts' label. Doing so will reveal the following choices:

<a href="https://assets.ubuntu.com/v1/ccfefe25-nodes-hw-testing__2.4_deployed-choices.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/ccfefe25-nodes-hw-testing__2.4_deployed-choices.png"></a>

See [Commissioning scripts reference](/t/commissioning-scripts-reference/5375) for more details on how these scripts work and how you can write your own.

[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
<a href="#heading--upload-test-scripts"><h3 id="heading--upload-test-scripts">How to upload hardware test scripts</h3></a>

To upload a hardware testing script to MAAS, enter the following:

``` bash
maas $PROFILE node-scripts create name=$SCRIPT_NAME name> \
 script=$PATH_TO_SCRIPT type=testing
```

Changing the type to commissioning adds the test script to the commissioning process.

You can list all uploaded scripts with the following command:

``` bash
maas $PROFILE node-scripts read type=testing filters=$TAG
```

The optional filters argument lets you search for tags assigned to a script, such as using `TAG=cpu` with the above example.

A script's metadata, and even the script itself, can be updated from the command line:

``` bash
maas $PROFILE node-script update \
 $SCRIPT_NAME script=$PATH_TO_SCRIPT comment=$COMMENT
```

The JSON formatted output to the above command will include 'history' dictionary entries, detailing script modification times and associated comments:

``` json
"history": [
    {
        "id": 40,
        "created": "Tue, 12 Sep 2017 12:12:08 -0000",
        "comment": "Updated version"
    },
    {
        "id": 34,
        "created": "Fri, 08 Sep 2017 17:07:46 -0000",
        "comment": null
    }
]
```

MAAS keeps a history of all uploaded script versions, allowing you to easily revert to a previous version using the `id` of the version you wish to revert to:

``` bash
maas $PROFILE node-script revert $SCRIPT_NAME to=$VERSION_ID
```

[note]
The history for later modifications will be lost when reverting to an earlier version of the script.
[/note]

To download a script, enter the following:

``` bash
maas $PROFILE node-script download $SCRIPT_NAME > $LOCAL_FILENAME
```

To delete a script, use `delete`:

``` bash
maas $PROFILE node-script delete $SCRIPT_NAME
```

<a href="#heading--tags-group-scripts"><h3 id="heading--tags-group-scripts">How to use tags to group commissioning and testing scripts</h3></a>

Tags make scripts easier to manage; grouping scripts together for commissioning and testing, for example:

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

<a href="#heading--results"><h3 id="heading--results">How to view testing results</h3></a>

The command line allows you to not only view the current script's progress but also retrieve the verbatim output from any previous runs too.

If you only want to see the latest or currently-running result, you can use `current-commissioning`, `current-testing`, or `current-installation` instead of an id:

``` bash
maas $PROFILE node-script-result read $SYSTEM_ID $RESULTS
```

You can also limit which results are returned by type (commissioning, testing, or installation), script name, or script run:

``` bash
maas $PROFILE node-script-results read \
 $SYSTEM_ID type=$SCRIPT_TYPE filters=$SCRIPT_NAME,$TAGS
```

You can also suppress failed results, which is useful if you want to ignore a known failure:

``` bash
maas $PROFILE node-script-results update \
 $SYSTEM_ID type=$SCRIPT_TYPE filters=$SCRIPT_NAME,$TAGS suppressed=$SUPPRESSED
```

where `$SUPPRESSED` is either `True` or `False`. The JSON formatted output to the above command will include 'results' dictionary with an entry for `suppressed`:

``` json
"results": [
    {
        "id": 21,
        "created": "Tue, 02 Apr 2019 17:00:36 -0000",
        "updated": "Tue, 02 Apr 2019 20:56:41 -0000",
        "name": "smartctl-validate",
        "status": 5,
        "status_name": "Aborted",
        "exit_status": null,
        "started": "Tue, 02 Apr 2019 20:56:41 -0000",
        "ended": "Tue, 02 Apr 2019 20:56:41 -0000",
        "runtime": "0:00:00",
        "starttime": 1554238601.765214,
        "endtime": 1554238601.765214,
        "estimated_runtime": "0:00:00",
        "parameters": {
            "storage": {
                "argument_format": "{path}",
                "type": "storage",
                "value": {
                    "id_path": "/dev/vda",
                    "model": ",
                    "name": "sda",
                    "physical_blockdevice_id": 1,
                    "serial": "
                }
            }
        },
        "script_id": 1,
        "script_revision_id": null,
        "suppressed": true
    }
]
```

Finally, results can be downloaded, either to stdout, stderr, as combined output or as a tar.xz:

``` bash
maas $PROFILE node-script-result download $SYSTEM_ID $RUN_ID output=all \
 filetype=tar.xz > $LOCAL_FILENAME
```

[note]
**$RUN_ID** is labelled `id` in the verbose result output.
[/note]
[/tab]
[/tabs]

<a href="#heading--network-link-testing"><h3 id="heading--network-link-testing">How to test network links</h3></a>

MAAS can check whether links are connected or disconnected, so that you can detect unplugged cables.  If you are not running MAAS 2.7 or higher, you must first upgrade and then recommission your machines to find disconnected links.  MAAS not only reports unplugged cables, but also gives a warning when trying to configure a disconnected interface.  In addition, administrators can change the cable connection status after manually resolving the issue.

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
When MAAS detects a broken network link, users will see a screen similar to this one: 

<a href="https://discourse.maas.io/uploads/default/original/1X/687feb2ddea8b317f0deba239bcb1779fd5f33d3.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/687feb2ddea8b317f0deba239bcb1779fd5f33d3.jpeg"></a> 

If you're already using a version of MAAS less than 2.7, you will want to upgrade and recommission your existing machines to check link status.  Note that you will also receive a warning from MAAS when trying to configure a disconnected interface.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To check network testing results, enter the following command:

```
maas $PROFILE interfaces read $SYSTEM_ID \
| jq -r '(["LINK_NAME","LINK_CONNECTED?","LINK_SPEED", "I/F_SPEED"]
| (., map(length*"-"))), (.[] | [.name, .link_connected, .link_speed, .interface_speed])
| @tsv' | column -t
```

which produces an output similar to this:

```
LINK_NAME  LINK_CONNECTED?  LINK_SPEED  I/F_SPEED
---------  ---------------  ----------  ---------
ens3       false            -           1 Gpbs
```

From this screen, you can see that the `ens3` link is not connected (hence an unreported link speed). 
[/tab]
[/tabs]

Once you have manually repaired the broken connection, an administrator can change cable connection status:

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="https://discourse.maas.io/uploads/default/original/1X/b8b24a2e5fbc40b6469a24733a518b510cf0d955.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/b8b24a2e5fbc40b6469a24733a518b510cf0d955.jpeg"></a> 
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
```
maas $PROFILE interface update $SYSTEM_ID $INTERFACE_ID link_connected=true
```
[/tab]
[/tabs]

<a href="#heading--slow-link-detection"><h2 id="heading--slow-link-detection">How to detect slow network links</h2></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
As servers and hardware get faster, the chances increase that you might encounter a speed mismatch when connecting your NIC to a network device.  MAAS can warn you if your interface is connected to a link slower than what the interface supports, by automatically detecting link and interface speed and reporting them via the UI:

<a href="https://discourse.maas.io/uploads/default/original/1X/e73a81df222f44c0b364eefcd0880e2a84c7303b.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e73a81df222f44c0b364eefcd0880e2a84c7303b.jpeg"></a>  

Depending on your physical hardware, the problem may not be repairable, but once you identify a slow link, you can replace a slow switch without recommissioning.  
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
As servers and hardware get faster, the chances increase that you might encounter a speed mismatch when connecting your NIC to a network device.  MAAS can warn you if your interface is connected to a link slower than what the interface supports, when you run the above command:

```
maas $PROFILE interfaces read $SYSTEM_ID \
| jq -r '(["LINK_NAME","LINK_CONNECTED?","LINK_SPEED", "I/F_SPEED"]
| (., map(length*"-"))), (.[] | [.name, .link_connected, .link_speed, .interface_speed])
| @tsv' | column -t
```

From the resulting output, you can detect when your link/interface speeds are slower than expected. Depending on your physical hardware, the problem may not be repairable, but once you identify a slow link, you can replace a slow switch without recommissioning.  

[/tab]
[/tabs]

Administrators can change or update the link and interface speeds after manual changes to the connection:

```
maas $PROFILE interface update $SYSTEM_ID $INTERFACE_ID link_speed=$NEW_LINK_SPEED \
interface_speed=$NEW_INTERFACE_SPEED
```

This functionality is only available through the MAAS CLI.

<a href="#heading--network-validation-scripts-and-testing"><h3 id="heading--network-validation-scripts-and-testing">How to configure network validation and testing scripts</h3></a>

MAAS allows you to configure network connectivity testing in a number of ways. If MAAS can’t connect to the rack controller, deployment can’t complete.  MAAS can check connectivity to the rack controller and warn you if there’s no link, long before you have to try and debug it. For example, if you can’t connect to your gateway controller, traffic can’t leave your network. 

Via the Web UI only, MAAS can check this link and recognise that there’s no connectivity, which alleviates hard-to-detect network issues:

<a href="https://discourse.maas.io/uploads/default/original/1X/c4f81cb3ef1a90f0a46fb62c893a4cc9f7e5f45a.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c4f81cb3ef1a90f0a46fb62c893a4cc9f7e5f45a.jpeg"></a> 

Users can now test their network configuration to check for:

- Interfaces which have a broken network configuration
- Bonds that are not fully operational
- Broken gateways, rack controllers, and Internet links

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
In addition, MAAS can comprehensively test Internet connectivity testing. You can give a list of URLs or IP addresses to check from the network testing screen:

<a href="https://discourse.maas.io/uploads/default/original/1X/12dd87ce0bffd54c2e459c4dea850af5fcbe14d0.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/12dd87ce0bffd54c2e459c4dea850af5fcbe14d0.jpeg"></a> 
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
In addition, MAAS can comprehensively test Internet connectivity testing. You can give a list of URLs or IP addresses to check:

<a href="https://discourse.maas.io/uploads/default/original/1X/b92a8ca1821bc1ccf60cf7fddcb57f3fbeda4408.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/b92a8ca1821bc1ccf60cf7fddcb57f3fbeda4408.jpeg"></a> 
[/tab]
[/tabs]

In the ephemeral environment, standard DHCP is still applied, but when network testing runs, MAAS can apply your specific configuration for the duration of the test.  While all URLs / IPs are tested with all interfaces, MAAS can test each of your interfaces individually, including breaking apart bonded NICS and testing each side of your redundant interfaces. You can also run different tests on each pass, e.g., a different set of URLs, although each run would be a different testing cycle.

To test individual interfaces, for example, you could issue the following CLI command:

<a href="https://discourse.maas.io/uploads/default/original/1X/7fadb56a2939f7a781510a55813141de03521e0d.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/7fadb56a2939f7a781510a55813141de03521e0d.jpeg"></a> 

Note that in this command, we are testing internet connectivity to the single interface "br0."

<a href="#heading--customisable-network-testing"><h3 id="heading--customisable-network-testing">How to customise network testing</h3></a>

MAAS allow you to customise network testing according to your needs.  You can create your own commissioning scripts and tests related to networking, and you can run them during the network testing portion of the MAAS workflow.

<a href="https://discourse.maas.io/uploads/default/original/1X/0dcf089dbd8efc2fc9d0782d3b15f47647e950b8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0dcf089dbd8efc2fc9d0782d3b15f47647e950b8.jpeg"></a> 

There are no particular restrictions on these scripts, so you can test a wide variety of possible conditions and situations.  Administrators can upload network tests and test scripts.  Administrators can also create tests which accept an interface parameter, or scripts which apply custom network configurations.  

Users can specify unique parameters using the API, override machines which fail network testing (allowing their use), and suppress individual failed network tests.  Users can also review the health status from all interface tests, even sorting them by interface name and MAC.  In addition, MAAS can report the overall status of all interfaces.

<a href="#heading--allocate-machines"><h2 id="heading--allocate-machines">How to allocate machines</h2></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To allocate a node with the web UI, select a machine which is in the "Ready" state, and drop down the "Take action" menu:

<a href="https://discourse.maas.io/uploads/default/original/1X/3724346e052c865f4e865d1caf2778b115f0798f.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/3724346e052c865f4e865d1caf2778b115f0798f.jpeg"></a>

Select "Allocate" from the drop-down menu, which will bring you to a confirmation screen:

<a href="https://discourse.maas.io/uploads/default/original/1X/a0ece8bf58c03db3c89ad71afcaeb9101bd34e24.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a0ece8bf58c03db3c89ad71afcaeb9101bd34e24.jpeg"></a>

MAAS will allocate the selected machine; you can now find it in the list of "Allocated" machines:

<a href="https://discourse.maas.io/uploads/default/original/1X/a2bdb8b7b7c5705daee14bdea5caed223537917d.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a2bdb8b7b7c5705daee14bdea5caed223537917d.jpeg"></a>
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]

To allocate a random node:

``` bash
maas $PROFILE machines allocate
```

To allocate a specific node:

``` bash
maas $PROFILE machines allocate system_id=$SYSTEM_ID
```

[/tab]
[/tabs]

[note]
To allocate a node, it must have a status of 'Ready'.
[/note]

<a href="#heading--deploy"><h2 id="heading--deploy">How to deploy machines</h2></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To deploy directly from MAAS, select one or more machine(s) and press the 'Deploy' button.

<a href="https://assets.ubuntu.com/v1/56958753-nodes-deploy__2.4_deploy.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/56958753-nodes-deploy__2.4_deploy.png"></a>

You then have the option of deviating from the default OS, release, and kernel. When ready, press 'Deploy X machine(s)' (where 'X' is the number of machines selected).

<a href="https://assets.ubuntu.com/v1/d65b9884-nodes-deploy__2.6-deploy-confirm.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/d65b9884-nodes-deploy__2.6-deploy-confirm.png"></a>

While a machine is deploying its status will change to Deploying to 'OS', where 'OS' is the name of the OS being deployed (e.g. 'Deploying to Ubuntu 16.04 LTS').

Once a machine has finished deploying its status will change to just the name of the OS (e.g. 'Ubuntu 18.04 LTS').
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To deploy a node:

``` bash
maas $PROFILE machine deploy $SYSTEM_ID
```

To deploy a node as a KVM host:

``` bash
maas $PROFILE machine deploy $SYSTEM_ID install_kvm=True
```

[note]
To deploy with the CLI, the node must have a status of 'Allocated'. See 'Allocate a node' above.
[/note]

<a href="#heading--configure-deployment-timeout"><h3 id="heading--configure-deployment-timeout">Configure deployment timeout</h3></a>

By default, when you deploy a machine, MAAS will consider the deployment a failure if it doesn't complete within 30 minutes.  You can configure this timeout, if you wish, with the command:

```
maas $PROFILE maas set-config name=node-timeout value=$NUMBER_OF_MINUTES
```

<a href="#heading--enlisted-deployed-machines"><h3 id="heading--enlisted-deployed-machines">How to enlist a machine that’s already running a workload</h3></a>

In order to add machine that’s already running a workload, there are currently two options:

Via the API/CLI, you can create a machine, passing the deployed flag:

```
$ maas $profile machines create deployed=true hostname=mymachine \   
architecture=amd64 mac_addresses=00:16:3e:df:35:bb power_type=manual
```

On the machine itself (the recommended way, if the machine is running Ubuntu), you can download a helper script from MAAS and create the machine that way:

```
$ wget http://$MAAS_IP:5240/MAAS/maas-run-scripts
$ chmod 755 maas-run-scripts
$ ./maas-run-scripts register-machine --hostname mymachine \
 > http://$MAAS_IP:5240/MAAS $MAAS_API_TOKEN
```

Now you have a machine in MAAS that’s in the deployed state, with no hardware information yet.

<a href="#heading--update-deployed-hw-info"><h3 id="heading--update-deployed-hw-info">How to update hardware information for a deployed machine</h3></a>

The recommended way of updating the hardware information for a deployed machine is to download the maas-run-scripts script and run it on the machine itself:

```
$ wget http://$MAAS_IP:5240/MAAS/maas-run-scripts
$ chmod 755 maas-run-scripts
$ ./maas-run-scripts report-results --config mymachine-creds.yaml
```

If you created the machine with the maas-run-scripts, you should have such a mymachine-creds.yaml file already. If not, it should look like this:

```
reporting:
          maas:
            consumer_key: $CONSUMER_KEY
            endpoint: http://$MAAS_IP:5240/MAAS/metadata/status/$SYSTEM_ID
            token_key: $TOKEN_KEY
            token_secret: $TOKEN_SECRET
```

You may get the needed credentials from the MAAS API, for example:

```
$ maas $profile machine get-token wxwwga
Success.
Machine-readable output follows:
{
        "token_key": "Lyy9BS4tKsQakDQScy",
        "token_secret": "V8vta8Azwn6FZVkfHnuTvLGLScAvEufB",
        "consumer_key": "YGT6QKSH65aap4tGnw"
}
```

[/tab]
[/tabs]
