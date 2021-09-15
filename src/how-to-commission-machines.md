<a ref="#heading--how-to-commission-a-machine"><h2 id="heading--how-to-commission-a-machine">How to commission a machine</h2></a>

rad-begin /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui /snap/3.1/ui /deb/3.1/ui
To commission a machine:

1. Go to the "Machines" page.

2. Select the machine(s) you want to commission.

3. Choose "Commission" under the "Take action" drop-down menu:

<a href="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png"></a>

You have the option of selecting some extra parameters (checkboxes) and performing hardware tests.

These options include:

-   **Allow SSH access and prevent machine powering off**: Machines are normally powered off after commissioning. This option keeps the machine on and enables SSH so you can access the machine.

-   **Retain network configuration**: When enabled, preserves any custom network settings previously configured for the machine. See [Networking](/t/about-networking/nnnn) for more information.

-   **Retain storage configuration**: When enabled, preserves any storage settings previously configured for the machine.

-   **Update firmware**: Runs scripts tagged with `update_firmware`.

-   **Configure HBA**: Runs scripts tagged with `configure_hba`.

<a href="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/5f196ca5e175e3f37d7cffbb2341fb0ee9cee16a.png"></a>

4. Click the Hardware tests field to reveal a drop-down list of tests to add and run during commissioning. 

5. Finalise the directive by hitting "Commission machine".

While commissioning, the machine status will change to reflect this state (Commissioning).  MAAS discovers the machine's network topology.  MAAS then prompts a machine network interface to connect to the fabric, VLAN, and subnet combination for configuration. Usually, MAAS assigns a static IP address out of the reserved IP range for the subnet ("Auto assign" mode). The next section details several assignment modes.

Once commissioned, a machine's status will change to Ready, and an extra tab for the machine called "Commissioning" will become available. This tab contains the results of the scripts executed during the commissioning process.
rad-end

rad-begin   /snap/2.9/cli /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli
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
            "params": "",
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
    "status_action": "",
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
    "description": "",
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
    "distro_series": "",
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
    "osystem": "",
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
        "params": "",
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
    "min_hwe_kernel": "",
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
        "description": "",
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
rad-end

Once commissioned, you may consider [creating or applying a tag](/t/maas-tags/2896) to this machine.  The next step is [deployment](/t/how-to-deploy-machines/nnnn).

<a href="#heading--how-to-manage-commissioning-and-testing-scripts"><h2 id="heading--how-to-manage-commissioning-and-testing-scripts">How to manage commissioning and testing scripts</h2></a>

This section explains:

* [How to download built-in scripts](#heading--how-to-download-built-in-scripts)
rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli
* [How to upload hardware testing scripts](#heading--how-to-upload-hardware-testing-scripts)
* [How to list all uploaded hardware testing scripts](#heading--how-to-list-all-uploaded-hardware-testing-scripts)
* [How to update hardware testing scripts](#heading--how-to-update-hardware-testing-scripts)
* [How to revert hardware testing scripts](#heading--how-to-revert-hardware-testing-scripts)
* [How to download a script](#heading--how-to-download-a-script)
* [How to view script results](#heading--how-to-view-script-results)
* [How to filter script results](#heading--how-to-filter-script-results)
* [How to suppress failed results](#heading--how-to-suppress-failed-results)
rad-end
rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui /snap/3.1/ui /deb/3.1/ui
* [How to upload scripts](#heading--how-to-upload-scripts)
* [How to debug script failures](#heading--how-to-debug-script-failures)
rad-end
* [How to locate script files](#heading--how-to-locate-script-files)
* [How to locate log files](#heading--how-to-locate-log-files)
* [How to run all scripts manually](#heading--how-to-run-all-scripts-manually)

You can also refer to technical details and examples for [commissioning scripts](/t/-/4862) and [testing scripts](/t/-/4861) as needed.

<a href="#heading--how-to-download-built-in-scripts"><h3 id="heading--how-to-download-built-in-scripts">How to download built-in scripts</h3></a>

You can download the source for all commissioning and test scripts via the API with the following command:

``` nohighlight
maas $PROFILE node-script download $SCRIPT_NAME
```

The source code to all built-in scripts is available on [launchpad](https://git.launchpad.net/maas/tree/src/metadataserver/builtin_scripts).

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli
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

[note type="negative" status="Warning"]
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
<a href="#heading--how-to-suppress-failed-results"><h4 id="heading--how-to-suppress-failed-results">How to suppress failed results</h4></a>

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
                    "model": "",
                    "name": "sda",
                    "physical_blockdevice_id": 1,
                    "serial": ""
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

rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui /snap/3.1/ui /deb/3.1/ui
<a href="#heading--how-to-upload-scripts"><h3 id="heading--how-to-upload-scripts">How to upload scripts</h3></a>

Scripts can be uploaded to MAAS using the web UI. Select the 'User scripts' tab of the 'Settings' page - the 'Commissioning scripts' section is near the top. Within the Commissioning scripts section, click the Upload script button followed by 'Choose file' to open a requester, locate the script, and select Upload to upload it to MAAS.

A status message of Commissioning script created will appear.  You'll then be able to select your script after selecting Test hardware from a machine's 'Take action' menu.

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
rad-end

As long as you've added your [SSH key](/t/user-accounts/nnnn#heading--ssh-keys) to MAAS, you can connect with SSH to the machine's IP with a username of `ubuntu`. Type `sudo -i` to get root access.

<a href="#heading--how-to-locate-script-files"><h3 id="heading--how-to-locate-script-files">How to locate script files</h3></a>

Commissioning and testing script files may be found in the following directories:

1.   `/tmp/user_data.sh.*/scripts/commissioning/`: Commissioning scripts
2.   `/tmp/user_data.sh.*/scripts/testing/`: Hardware testing scripts

<a href="#heading--how-to-locate-log-files"><h4 id="heading--how-to-locate-log-files">How to locate log files</h4></a>

Commissioning and testing log files may be found in the following directories:

1.   `/tmp/user_data.sh*/out/`
2.   `/var/log/cloud-init-output.log`
3.   `/var/log/cloud-init.log`

<a href="#heading--how-to-run-all-scripts-manually"><h3 id="heading--how-to-run-all-scripts-manually">How to run all scripts manually</h3></a>

You can also run all commissioning and hardware-testing scripts on a machine for debugging.

```nohighlight
/tmp/user_data.sh.*/bin/maas-run-remote-scripts \
    [--no-download] \
    [--no-send] \
    /tmp/user_data.sh.*
```

Where:

1.   `--no-download`: Optional. Do not download the scripts from MAAS again.
2.   `--no-send`: Optional. Do not send the results to MAAS.

For example, to run all the scripts again without downloading again from MAAS:

```nohighlight
/tmp/user_data.sh.*/bin/maas-run-remote-scripts --no-download /tmp/user_data.sh.*
```

Here, all the scripts are run again after downloading from MAAS, but no output data is sent to MAAS:

```nohighlight
/tmp/user_data.sh.*/bin/maas-run-remote-scripts --no-send /tmp/user_data.sh.*
```
