<a href="#heading--about-commissioning-scripts"><h2 id="heading--about-commissioning-scripts">About commissioning scripts</h2></a>

MAAS runs scripts during enlistment, commissioning and testing to collect data about nodes. Both enlistment and commissioning run all builtin commissioning scripts, though enlistment runs only built-ins. Commissioning also runs any user-uploaded commissioning scripts by default, unless the user manually provides a list of scripts to run. MAAS uses these commissioning scripts to configure hardware and perform other tasks during commissioning, such as updating the firmware. Similarly, MAAS employs hardware testing scripts to evaluate system hardware and report its status. 

Scripts can be selected to run from web UI during commissioning, by [testing hardware](/t/hardware-testing/nnnn) or from the command line. Note that MAAS only runs built-in commissioning scripts during enlistment. Custom scripts can be run when you explicitly choose to commission a machine.  A typical administrator workflow (with machine states), using customised commissioning scripts, can be represented as:

Add machine -&gt; Enlistment (runs built-in commissioning scripts MAAS) -&gt; New -&gt; Commission (runs built-in and custom commissioning scripts) -&gt; Ready -&gt; Deploy

NOTE: Scripts are run in alphabetical order in an ephemeral environment.  We recommend running your scripts after any MAAS built-in scripts.  This can be done by naming your scripts 99-z*.  It is possible to reboot the system during commissioning using a script, however, as the environment is ephemeral, any changes to the environment will be destroyed upon reboot (barring, of course, firmware type updates).

This article explains script metadata, parameter passing, and results-reporting.  It also offers examples of both commissioning and hardware testing scripts.


<a href="#heading--about-script-results"><h2 id="heading--about-script-results">About script results</h2></a>

A script can output its results to a YAML file, and those results will be associated with the hardware type defined within the script. MAAS provides the path for the results file in an environment variable, `RESULT_PATH`. Scripts should write YAML to this file before exiting.

If the hardware type is storage, for example, and the script accepts a storage type parameter, the result will be associated with a specific storage device.

The YAML file must represent a dictionary with these two fields:

1.   `result`: The completion status of the script. This status can be `passed`, `failed`, `degraded`, or `skipped`. If no status is defined, an exit code of `0` indicates a pass while a non-zero value indicates a failure.
2.   `results`: A dictionary of results. The key may map to a results key defined as embedded YAML within the script. The value of each result must be a string or a list of strings.

Optionally, a script may define what results to return in the YAML file in the [Metadata fields](#Metadata%20fields). The `results` field should contain a dictionary of dictionaries. The key for each dictionary is a name which is returned by the results YAML. Each dictionary may contain the following two fields:

1.   `title` - The title for the result, used in the UI.
2.   `description` - The description of the field used as a tool-tip in the UI.

Example degrade detection:

``` python
#!/usr/bin/env python3

# --- Start MAAS 1.0 script metadata ---
# name: example
# results:
#   memspeed:
#     title: Memory Speed
#     description: Bandwidth speed of memory while performing random read writes
# --- End MAAS 1.0 script metadata ---

import os
import yaml

memspeed = some_test()

print('Memspeed: %s' % memspeed)
results = {
    'results': {
        'memspeed': memspeed,
    }
}
if memspeed < 100:
    print('WARN: Memory test passed but performance is low!')
    results['status'] = 'degraded'

result_path = os.environ.get("RESULT_PATH")
if result_path is not None:
    with open(result_path, 'w') as results_file:
        yaml.safe_dump(results, results_file)
```

<a ref="#heading--how-to-commission-a-machine"><h2 id="heading--how-to-commission-a-machine">How to commission a machine</h2></a>

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
To commission a machine, go to the "Machines" page, select a machine and choose "Commission" under the "Take action" drop-down menu.

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

<a href="#heading--how-to-download-built-in-scripts"><h2 id="heading--how-to-download-built-in-scripts">How to download built-in scripts</h2></a>

You can download the source for all commissioning and test scripts via the API with the following command:

``` bash
maas $PROFILE node-script download $SCRIPT_NAME
```

The source code to all built-in scripts is available on [launchpad](https://git.launchpad.net/maas/tree/src/metadataserver/builtin_scripts).

<a href="#heading--commissioning-script-example-configure-hpa"><h2 id="heading--commissioning-script-examplle-configure-hpa">Commissioning script example: Configure HPA</h2></a>

Below is a sample script to configure an Intel C610/X99 HPA controller on an HP system. The script will only run on systems with an Intel C610/X99 controller identified by the PCI ID 8086:8d06.

Before the scrixpt runs, MAAS will download and install the [HP RESTful Interface Tool](https://downloads.linux.hpe.com/SDR/project/hprest/) package from HP. After the script completes, the built-in commissioning scripts will be re-run to capture the new configuration.

``` bash
#!/bin/bash -ex
# --- Start MAAS 1.0 script metadata ---
# name: hp_c610_x99_ahci
# title: Configure Intel C610/X99 controller on HP systems
# description: Configure Intel C610/X99 controller on HP systems to AHCI
# script_type: commissioning
# tags: configure_hpa
# packages:
#  url: http://downloads.linux.hpe.com/SDR/repo/hprest/pool/non-free/hprest-1.5-26_amd64.deb
# for_hardware: pci:8086:8d06
# recommission: True
# --- End MAAS 1.0 script metadata ---
output=$(sudo hprest get EmbeddedSata --selector HpBios.)
echo $output
if [ $(echo $output | grep -c 'EmbeddedSata=Raid') ]; then
    echo "Server is in Dynamic Smart Array RAID mode. Changing to SATA AHCI support mode."
    sudo hprest set EmbeddedSata=Ahci --selector HpBios. --commit
else:
    echo "No changes made to the system, Server is Already in AHCI Mode"
fi
```

<a href="#heading--commissioning-script-example-update-firmware"><h2 id="heading--commissioning-script-update-firmware">Commissioning script example: Update firmware</h2></a>

Below is a sample script to update the mainboard firmware on an ASUS P8P67 Pro using a vendor-provided tool. The tool will is automatically downloaded and extracted by MAAS. The script reboots the system to complete the update. The system will boot back into the MAAS ephemeral environment to finish commissioning and optionally testing.

[note]
Vendor tools which use UEFI boot capsules or need to store resource files on disk while rebooting are not currently supported.
[/note]

``` bash
#!/bin/bash -ex
# --- Start MAAS 1.0 script metadata ---
# name: update_asus_p8p67_firmware
# title: Firmware update for the ASUS P8P67 mainboard
# description: Firmware update for the ASUS P8P67 mainboard
# script_type: commissioning
# tags: update_firmware
# packages:
#  url: http://example.com/firmware.tar.gz
# for_hardware: mainboard_product:P8P67 PRO
# may_reboot: True
# --- End MAAS 1.0 script metadata ---
$DOWNLOAD_PATH/update_firmware
reboot
```

<a href="#heading--hardware-test-script-example-cpu-stress-test"><h2 id="heading--hardware-test-script-example-cpu-stress-test">Hardware test script example: CPU stress test</h2></a>

As a simple example, here's a functional Bash script replicating part of the stress-ng script bundled with MAAS:

``` bash
#!/bin/bash -e
# --- Start MAAS 1.0 script metadata ---
# name: stress-ng-cpu-test
# title: CPU validation
# description: Run stress-ng memory tests for 5 minutes.
# script_type: test
# hardware_type: cpu
# packages: {apt: stress-ng}
# tags: cpu
# timeout: 00:05:00
# --- End MAAS 1.0 script metadata ---

sudo -n stress-ng --matrix 0 --ignite-cpu --log-brief --metrics-brief --times \
    --tz --verify --timeout 2m
```

This Bash script contains comment-delineated metadata, which configures the script environment and installs any dependencies.  There is also a single line that runs **stress-ng** (a CPU stress-test utility) with various arguments.

<a href="#heading--about-automatic-script-selection-by-hardware-type"><h3 id="heading--about-automatic-script-selection-by-hardware-type">About automatic script selection by hardware type</h3></a>

When selecting [multiple machines](/t/machines/nnnn), scripts which declare the `for_hardware` field will only run on machines with matching hardware. To automatically run a script when 'Update firmware' or 'Configure HBA' is selected, you must tag the script with 'update_firmware' or 'configure_hba'.

Similarly, scripts selected by tag on the command line which specify the `for_hardware` field will only run on matching hardware.

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
<a href="#heading--how-to-upload-hardware-testing-scripts"><h2 id="heading--how-to-upload-hardware-testing-how">How to upload hardware testing scripts</h2></a>

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

A [script's metadata](#hardware-test-script-sample), and even the script itself, can be updated from the command line:

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

[note type="negative" status="Warning"]
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
rad-end

<a href="#heading--about-tags-and-scripts"><h2 id="heading--about-tags-and-scripts">About tags and scripts</h2></a>

As with general tag management, tags make scripts easier to manage; grouping scripts together for commissioning and testing, for example:

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

<a href="#heading--how-to-view-script-results"><h2 id="heading--how-to-view-script-results">How to view script results</h2></a>

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

``` bash
maas $PROFILE node-script-result download $SYSTEM_ID $RUN_ID output=all \
 filetype=tar.xz > $LOCAL_FILENAME
```

[note]
**$RUN_ID** is labelled `id` in the verbose result output.
[/note]

rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
Scripts can be uploaded to MAAS using the web UI. Select the 'User scripts' tab of the 'Settings' page - the 'Commissioning scripts' section is near the top. Within the Commissioning scripts section, click the Upload script button followed by 'Choose file' to open a requester, locate the script, and select Upload to upload it to MAAS.

A status message of Commissioning script created will appear.  You'll then be able to select your script after selecting [Test hardware](/t/hardware-testing/nnnn) from a machine's 'Take action' menu.

<a href="https://assets.ubuntu.com/v1/50e08fdf-nodes-hw-scripts__2.4_select.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/50e08fdf-nodes-hw-scripts__2.4_select.png"></a>

[note]
MAAS executes scripts in lexicographical order. This order allows you to control when your scripts execute, and whether they run before or after the standard MAAS scripts.
[/note]

<a href="#heading--about-debugging-script-failures"><h2 id="heading--about-debugging-script-failures">About debugging script failures</h2></a>

Clicking on the title of a completed or failed script will reveal the output from that specific script.

<a href="https://assets.ubuntu.com/v1/855015e5-nodes-hw-scripts__2.2_fail.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/855015e5-nodes-hw-scripts__2.2_fail.png"></a>

If you need further details, especially when writing and running your own scripts, you can connect to a machine and examine its logs and environment.

To do this, enable Allow SSH access and prevent the machine from powering off when selecting 'Test hardware' from the machine 'Take action' menu.

<a href="https://assets.ubuntu.com/v1/da793c67-nodes-hw-scripts__2.4_ssh.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/da793c67-nodes-hw-scripts__2.4_ssh.png"></a>

Because scripts operate within an ephemeral version of Ubuntu, enabling this option stops the machine from shutting down, allowing you to connect and probe a script's status.
rad-end

As long as you've added your [SSH key](/t/user-accounts/nnnn#heading--ssh-keys) to MAAS, you can connect with SSH to the machine's IP with a username of `ubuntu`. Type `sudo -i` to get root access.

<a href="#heading--how-to-locate-script-files"><h2 id="heading--how-to-locate-script-files">How to locate script files</h2></a>

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

``` bash
/tmp/user_data.sh.*/bin/maas-run-remote-scripts \
    [--no-download] \
    [--no-send] \
    /tmp/user_data.sh.*
```

Where:

1.   `--no-download`: Optional. Do not download the scripts from MAAS again.
2.   `--no-send`: Optional. Do not send the results to MAAS.

For example, to run all the scripts again without downloading again from MAAS:

``` bash
/tmp/user_data.sh.*/bin/maas-run-remote-scripts --no-download /tmp/user_data.sh.*
```

Here, all the scripts are run again after downloading from MAAS, but no output data is sent to MAAS:

``` bash
/tmp/user_data.sh.*/bin/maas-run-remote-scripts --no-send /tmp/user_data.sh.*
```
