<!-- "Commissioning scripts reference" -->
This document provides technical details about commissioning scripts.  For the corresponding details about test scripts, see [Hardware test scripts reference](/t/hardware-test-scripts-reference/5392).

<a href="#heading--metadata-field-reference"><h2 id="heading--metadata-field-reference">Metadata field reference</h2></a>

Metadata fields tell MAAS when to use the script, how it should run, and what information it's gathering. A script can employ some combination of the following fields:

| Field | Description |
|:------|:------------|
| `name`| The name of the script.|
| `title`| Human-friendly descriptive version of the name, used within the web UI.|
| `description`| Brief outline of what the script does.|
| `tags`| List of tags associated with the script.|
| `type`| Either commissioning or testing.|
| `timeout`| Length of time before MAAS automatically fails and kills execution of the script. The time may be specified in seconds or using the HH:MM:SS format. |
| `destructive`| True or False, depending on whether the script will overwrite system data. You can't run destructive tests on a deployed machine. |
| `comment`| Describes changes made in this revision of the script.  A comment can be passed via the API when uploading the script.  MAAS doesn’t look at the script metadata for this field. |
| `hardware_type`| Defines the type of hardware the script configures or tests. If the script returns results, hardware types associate the results with specific hardware. The following types are valid: |
| | `node`: Not associated with any hardware type; this is the default. |
| | `cpu`: Configures or tests the CPUs on the machine. |
| | `memory`: Configures or tests memory on the machine. |
| | `storage`: Configures or tests storage on the machine. |
| | `network`: Configures or tests network on the machine. |
|   `parallel`| Enables scripts to be run in parallel and can be one of the following: |
| | `disabled`: The script will run serially on its own. |
| | `instance`: Runs in parallel only with other instances of the same script. |
| | `any`: Runs in parallel alongside any other scripts with parallel set to any. |
| `parameters`| What parameters the script accepts. |
| `results`| What results the script will return. |
| `packages`| List of packages to be installed or extracted before running the script. Packages must be specified as a dictionary. For example, `packages: {apt: stress-ng}`, would ask `apt` to install stress-ng. Package sources can be any of the following: |
| | `apt`: Use the Ubuntu apt repositories as configured by MAAS to install a package. |
| | `snap`: Installs packages using [snap][snapcraft]. May also be a list of dictionaries. The dictionary must define the name of the  package to be installed, and optionally, the `channel`, `mode` and `revision`.|
| | `url`: The archive will be downloaded and, if possible, extracted or installed when a Debian package or [snap][snapcraft]. |
|   `for_hardware`| Specifies the hardware that must be on the machine for the script to run. May be a single string or list of strings of the following:
| | `modalias`: Starts with 'modalias:' may optionally contain wild cards. |
| | `PCI ID`: Must be in the format of 'pci:VVVV:PPPP' where VVVV is the vendor ID, and PPPP is the product ID. |
| | `USB ID`: Must be in the format of 'usb:VVVV:PPPP' where VVVV is the vendor ID, and PPPP is the product ID. |
| | `System Vendor`: Starts with 'system_vendor:'. |
| | `System Product`: Starts with 'system_product:'. |
| | `System Version`: Starts with 'system_version:'. |
| | `Mainboard Vendor`: Starts with 'mainboard_vendor:'. |
| | `Mainboard Product`: Starts with 'mainboard_product:'. |
|   `may_reboot` |When True, indicates to MAAS that the script may reboot the machine. MAAS will allow up to 20 minutes between heartbeats while running a script with `may_reboot` set to True. |
| `recommission`| After all commissioning scripts have finished running rerun |
|   `script_type` | commissioning or test. Indicates whether the script should run during commissioning or hardware testing. |

<a href="#heading--parameter-reference"><h2 id="heading--parameter-reference">Parameter reference</h2></a>

Scripts can accept the following types of parameters:

1. storage
2. interface
3. URL

The values of these parameters are strictly checked against existing disks (storage), working interfaces (interface), and valid URLs (URL)  No other types of information can be passed as parameters; they are not configured to pass user-specified data.

Parameters are automatically switched by MAAS to match the device being tested, to allow one test to be run against multiple devices at the same time while keeping separate logs.  For this reason, you may only specify parameters within the embedded YAML of the script, and they must take the form of a dictionary of dictionaries.

The key of the dictionary must be a string, and it's this string that's used by the UI and API when users are setting parameter values during commissioning or testing.  The value is a dictionary with the following fields:

| Field | Description |
|:------|:------------|
|   `type`: Every parameter must contain a type field, which describes what the parameter may accept and its default values. It may be one of the following: |
| |   `storage`: Allows the selection of a storage device on the currently running machine.|
| |   `interface`: Allows the selection of an interface on the currently running machine.|
| |   `url`: Allows the the passing of a valid URL.|
| |   `runtime`: Specifies how long the script may run. This overrides the timeout value. It is currently only passed as the environment variable RUNTIME.|
|   `title`: The title of the parameter field when displayed in the UI. The following types have the following default values:|
| |   `storage`: storage device.|
| |   `interface`: interface specifier.|
| |   `url`: valid URL.|
|   `argument-format`: Specifies how the argument should be passed to the script. Input is described as `{input}`. The storage type may also use `{name}`, `{path}`, `{model}` or `{serial}`. MAAS will look up the values of path, model, and serial based on user selection. For storage, `{input}` is synonymous with `{path}`. The interface type may also use `{name}`, `{mac_address}`, `{product}`, or `{vendor}`. For interface `{input}` is synonymous with `{name}`. The following types have the following default values:|
| |   `storage`: `--storage={path}`|
| |   `interface`: `--interface={name}`|
| |   `url`: `--url={input}`|
|   `default`: The default value of the parameter. The following types have the following default values. Setting these to '' or None will override these values:|
| |   `storage`: all.|
| |   `interface`: all.|
|   `required`: Whether or not user input is required. A value of false sets no default, and no user input will mean no parameters passed to the script. Defaults to `true`.|
|   `results`: What results the script will return on completion. You can only define this parameter within the embedded YAML of the script. Results may be a list of strings or a dictionary of dictionaries.|

Example script using default values:

``` python
#!/usr/bin/env python3

# --- Start MAAS 1.0 script metadata ---
# name: example
# parallel: instance
# parameters:
#   storage: {type: storage}
# --- End MAAS 1.0 script metadata ---

import argparse

parser = argparse.ArgumentParser(description='')
parser.add_argument(
    '--storage', dest='storage', required=True,
    help='path to storage device you want to test. e.g. /dev/sda')
args = parser.parse_args()

print("Testing: %s" % args.storage)
```

Example script using customised parameters:

``` bash
#!/bin/bash

# --- Start MAAS 1.0 script metadata ---
# name: example
# parallel: instance
# parameters:
#   storage:
#     type: storage
#     argument-format: '{model}' '{serial}'
# --- End MAAS 1.0 script metadata ---

echo "Model: $1"
echo "Serial: $2"
```

<a href="#heading--environment-variable-reference"><h2 id="heading--environment-variable-reference">Environment variable reference</h2></a>

The following environment variables are available when a script runs within the MAAS environment:

1.   `OUTPUT_STDOUT_PATH`: The path to the log of STDOUT from the script.
2.   `OUTPUT_STDERR_PATH`: The path to the log of STDERR from the script.
3.   `OUTPUT_COMBINED_PATH`: The path to the log of the combined STDOUT and STDERR from the script.
4.   `RESULT_PATH`: Path for the script to write a result YAML.
5.   `DOWNLOAD_PATH`: The path where MAAS will download all files.
6.   `RUNTIME`: The amount of time the script has to run in seconds.
7.   `HAS_STARTED`: When 'True', MAAS has run the script once before but not to completion. Indicates the machine has rebooted.

<a href="#heading--commissioning-script-example-configure-hpa"><h2 id="heading--commissioning-script-example-configure-hpa">Commissioning script example: Configure HPA</h2></a>

Below is a sample script to configure an Intel C610/X99 HPA controller on an HP system. The script will only run on systems with an Intel C610/X99 controller identified by the PCI ID 8086:8d06.

Before the script runs, MAAS will download and install the [HP RESTful Interface Tool](https://downloads.linux.hpe.com/SDR/project/hprest/)`↗` package from HP. After the script completes, the built-in commissioning scripts will be re-run to capture the new configuration.

```nohighlight
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

<a href="#heading--commissioning-script-example-update-firmware"><h2 id="heading--commissioning-script-example-update-firmware">Commissioning script example: Update firmware</h2></a>

Below is a sample script to update the mainboard firmware on an ASUS P8P67 Pro using a vendor-provided tool. The tool is automatically downloaded and extracted by MAAS. The script reboots the system to complete the update. The system will boot back into the MAAS ephemeral environment to finish commissioning and (optionally) testing.

[note]
Currently, MAAS does not support vendor tools which use UEFI boot capsules or need to store resource files on disk while rebooting.
[/note]

```nohighlight
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
