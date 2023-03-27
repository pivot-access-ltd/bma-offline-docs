<!-- "Commissioning log reference" -->
Commissioning logs contain a list of commissioning scripts with a timestamp and result.  You can view the detailed logs for each of these scripts in the UI by clicking on the "Commissioning" tab for a specific machine.  

You will be presented with a status table of commissioning scripts.  Each of the items in the "NAME" column is the name of a [commissioning script](/t/how-to-put-machines-to-work/5112#heading--how-to-commission-a-machine).  Each entry gives a timestamp and a result (e.g. passed, failed, ...). At the end of each line is a link to view the log. It's worth taking a look at each of the script logs and their typical output.

You can also use the MAAS CLI to retrieve the verbatim logs of commissioning script runs, including those that are currently in progress.

```nohighlight
maas $PROFILE node-script-result read $SYSTEM_ID $RESULTS
```

If you only want to see the latest or currently-running result, you can use `current-commissioning`, `current-testing`, or `current-installation` instead of `$SYSTEM_ID`.  You can also limit which results are returned by type (commissioning, testing, or installation), script name, or script run:

```nohighlight
maas $PROFILE node-script-results read \
 $SYSTEM_ID type=$SCRIPT_TYPE filters=$SCRIPT_NAME,$TAGS
```

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

<a href="#heading--maas-support-info"><h2 id="heading--maas-support-info">maas-support-info</h2></a>

MAAS gathers information that helps to identify and characterise the machine for debugging purposes, such as the kernel, versioning of various components, etc.  This script gathers this information, mostly as a bundle to be provided to a support specialist to help get the baseline for the machine in question.  This script runs in parallel with other scripts to speed commissioning. 

Here's a quick breakdown of the fields you may see in the script output:

- **KERNEL INFO:** this is the output of `uname -a` -- the MAC address is the machine name in this case.

- **KERNEL COMMAND LINE:** these are the kernel command line parameters, directed at various modules built into the kernel.  The function `modprobe` parses this kernel command line and collects the relevant module parameters when it loads a module.  Note that this command line could also be used to pull in loadable modules.

- **CLOUD CONFIG QUERY:** a cloud-init query is used to retrieve cloud instance metadata used by cloud-init when booting an instance.  This section shows the specific metadata retrieved during cloud-init query for this machine.

- **CPU CORE COUNT AND MODEL:** the data produced here is similar to the output you could retrieve by running `nproc` and then attempting a `cat /sys/devices/cpu/caps/pmu_name` -- and so on.  There several ways to retrieve this info, but all can produce the number and type of CPU(s) available.

- **PCI INFO:** the devices, real or virtual, that are connected to the machine via PCI (Peripheral Component Interconnect) bus.

- **USB INFO:** the devices, real or virtual, that are connected to the machine via USB bus.

- **MODALIASES:** a modalias is a sysfs technique to capture the information that a hardware item exposes to the kernel, with the file basically providing a template or structure for this information.  Each of the entries in this list describe one particular part of the machine's (real or virtual) hardware, down to the level of alarm timers, framebuffers, and even speakers.  In the event of a bug, this information can help your support engineer (or yourself) understand exactly what hardware is configured for this machine.

- **SERIAL PORTS:** this section just lists the serial devices made available on this machine.

- **NETWORK INTERFACES:** summarises the network interfaces available on this machine -- essentially an abbreviated version of the output from some form of an `ip` command.

- **BLOCK DEVICE SUMMARY:** a thumbnail sketch of the block devices (usually storage) available on this machine.

- **#dmidecode...:** this section presents the basic DMI data, including the BIOS type, extent, size, and table location.

- **DMI DATA:** the raw (undecoded) DMI table for this machine, presented for verification of the following DMI data sections, if desired.

- **DMI KEYPAIRS:** the individual machine specifications, as decoded from the DMI table.  The manpage **dmidecode (8)** gives more details on each of these keypairs.

<a href="#heading--maas-lshw"><h2 id="heading--maas-lshw">maas-lshw</h2></a>

This script pulls system BIOS and vendor info, and generates user-defined tags for later use.  `maas-lshw` runs in parallel with other scripts to speed up the commissioning process.  This output is roughly equivalent to the output of `lshw -xml` on the machine in question.  

There are many available references to decode this information, so for now, here is a short glossary of most the terms (essentially, the tags) that typically appear in a listing like this:

- **businfo** - the bus information for this device.

- **capacity** - the maximum capacity reported by the device.

- **class** - the device's class.

- **clock** - the bus clock of the device (in Hz).

- **description** - a human-readable description of the hardware node.

- **dev** - the device number (major.minor).

- **id** - the internal identifier used by `lshw`.

- **logicalname** - the logical node name used by the system.

- **physid** - the physical id of the device.

- **product** - the specific product name of the device.

- **serial** - the serial number of the device.

- **size** - the actual size of the device.

- **slot** - location of the physical (or virtual) connection.

- **vendor** - the name of the vendor or manufacturer of the device.

- **version** - the version or release information associated with the device.

- **width** - the address width of the device (32/64 bits).

Some additional fields may be present in this output.  These will be identified and described as necessary for specific instances and situations.

<a href="#heading--20-maas-01-install-lldpd"><h2 id="heading--20-maas-01-install-lldpd">20-maas-01-install-lldpd</h2></a>

This script installs the link layer discovery protocol (LLDP) daemon, which will later capture networking information about the machine.  This logs the basic install process to the commissioning logs in real time.

<a href="#heading--maas-list-modaliases"><h2 id="heading--maas-list-modaliases">maas-list-modaliases</h2></a>

This script figures out what hardware modules are loaded, providing a way to autorun certain scripts based on which modules are loaded.  `maas-list-modaliases` runs in parallel with other scripts to speed up the commissioning process.

<a href="#heading--20-maas-02-dhcp-unconfigured-ifaces"><h2 id="heading--20-maas-02-dhcp-unconfigured-ifaces">20-maas-02-dhcp-unconfigured-ifaces</h2></a>

MAAS will want to know all the ways the machine is connected to the network. Only PXE comes online during boot; this script brings all the other networks online so they can be recognised.  This script logs the discovery of these networks to the commissioning logs.

<a href="#heading--maas-get-fruid-api-data"><h2 id="heading--maas-get-fruid-api-data">maas-get-fruid-api-data</h2></a>

This script gathers information for the Facebook wedge power type, and it runs in parallel with other scripts to improve commissioning speed. You will note that this output does not actually contain any specific information, but rather the echoed commands of a script to gather the information.

<a href="#heading--maas-serial-ports"><h2 id="heading--maas-serial-ports">maas-serial-ports</h2></a>

This script lists what serial ports are available on the machine; it runs in parallel to speed up commissioning.  Log output from a normal, successful run is simply a list of serial ports.  The output of this script may be useful when you're trying to verify that a particular serial interface is active and available on your machine.

<a href="#heading--40-maas-01-network-interfaces"><h2 id="heading--40-maas-01-network-interfaces">40-maas-01-network-interfaces</h2></a>

In MAAS 2.9 and below, this script is just used to get the IP address, which can then be associated with a VLAN/subnet.  The results are simply the output of a command similar to `ip a`.  This script is not used in MAAS 3.0 and higher.

<a href="#heading--50-maas-01-commissioning"><h2 id="heading--50-maas-01-commissioning">50-maas-01-commissioning</h2></a>

This script is the main MAAS tool, gathering information on machine resources, such as storage, network devices, CPU, RAM, etc. We currently pull this data using lxd: We use a Go binary built from lxd source that just contains the minimum source to gather the resource information we need.

This output represents a catalogue of the resources available on this machine, in a format readable by both humans and machines.  You can use this to verify that your configuration is what you expected.

<a href="#heading--maas-capture-lldp"><h2 id="heading--maas-capture-lldp">maas-capture-lldp</h2></a>

This script gathers LLDP network information to be presented on the logs page; this data is not used by MAAS at all.  The script runs in parallel with other scripts for speed. Note that the log output from a successful run is uninteresting.

<a href="#heading--maas-kernel-cmdline"><h2 id="heading--maas-kernel-cmdline">maas-kernel-cmdline</h2></a>

This script is used to update the boot devices; it double-checks that the right boot interface is selected.  Successful output is the specific command that boots the machine kernel, something like this:

```nohighlight
nomodeset ro root=squash:http://192.168.122.2:5248/images/ubuntu/amd64/generic/bionic/daily/squashfs ip=::::52-54-00-0b-6d-8c:BOOTIF ip6=off overlayroot=tmpfs overlayroot_cfgdisk=disabled cc:{'datasource_list': ['MAAS']}end_cc cloud-config-url=http://192-168-122-0--24.maas-internal:5248/MAAS/metadata/latest/by-id/pb6833/?op=get_preseed apparmor=0 log_host=192.168.122.2 log_port=5247 BOOTIF=01-52:54:00:0b:6d:8c
```
These are the kernel command line parameters, which control the invocation of various modules built into the kernel.  The function `modprobe` parses this kernel command line and collects the relevant module parameters when it loads a module.  Note that this command line could also be used to pull in loadable modules.