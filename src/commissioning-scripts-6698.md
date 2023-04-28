<!-- "Commissioning scripts" -->

MAAS runs scripts during enlistment, commissioning and testing to collect data about nodes. Both enlistment and commissioning run all builtin commissioning scripts, though enlistment runs only built-ins. Commissioning also runs any user-uploaded commissioning scripts by default, unless the user manually provides a list of scripts to run. MAAS uses these commissioning scripts to configure hardware and perform other tasks during commissioning, such as updating the firmware. Similarly, MAAS employs hardware testing scripts to evaluate system hardware and report its status.

Scripts can be selected to run from web UI during commissioning, by testing hardware,  or from the command line. Note that MAAS only runs built-in commissioning scripts during enlistment. Custom scripts can be run when you explicitly choose to commission a machine.  A typical administrator workflow (with machine states), using customised commissioning scripts, can be represented as:

Add machine -&gt; Enlistment (runs built-in commissioning scripts MAAS) -&gt; New -&gt; Commission (runs built-in and custom commissioning scripts) -&gt; Ready -&gt; Deploy

NOTE: Scripts are run in alphabetical order in an ephemeral environment.  We recommend running your scripts after any MAAS built-in scripts.  This can be done by naming your scripts 99-z*.  It is possible to reboot the system during commissioning using a script, however, as the environment is ephemeral, any changes to the environment will be destroyed upon reboot (barring, of course, firmware type updates).

When a machine boots, MAAS first instructs it to run cloud-init to set up SSH keys (during commissioning only), set up NTP, and execute a script that runs other commissioning scripts.  Currently, the sequence of MAAS-provided commissioning scripts proceeds like this:

- **maas-support-info:** MAAS gathers information that helps to identify and characterise the machine for debugging purposes, such as the kernel, versioning of various components, etc.  **Runs in parallel with other scripts.**

- **maas-lshw:** this script pulls system BIOS and vendor info, and generates user-defined tags for later use.  **Runs in parallel with other scripts.**

- **20-maas-01-install-lldpd:** this script installs the link layer discovery protocol (LLDP) daemon, which will later capture networking information about the machine.  This script provides some extensive logging.

- **maas-list-modaliases:** this script figures out what hardware modules are loaded, providing a way to autorun certain scripts based on which modules are loaded.  **Runs in parallel with other scripts.**

- **20-maas-02-dhcp-unconfigured-ifaces:** MAAS will want to know all the ways the machine is connected to the network.  Only PXE comes online during boot; this script brings all the other networks online so they can be recognised.  This script provides extensive logging.

- **maas-get-fruid-api-data:** this script gathers information for the Facebook wedge power type.  **Runs in parallel with other scripts.**

- **maas-serial-ports:** this script lists what serial ports are available on the machine.  **Runs in parallel with other scripts.**

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
[note]
As of MAAS version 3.0, **40-maas-01-network-interfaces** is no longer used by MAAS.
[/note]
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
- **40-maas-01-network-interfaces:** this script is just used to get the IP address, which can then be associated with a VLAN/subnet.
[/tab]
[/tabs]

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
- **50-maas-01-commissioning:** this script is the main MAAS tool, gathering information on machine resources, such as storage, network devices, CPU, RAM, details about attached USB and PCI devices, etc.  We currently pull this data using lxd: We use a Go binary built from lxd source that just contains the minimum source to gather the resource information we need.  This script also checks whether the machine being commissioning is a virtual machine, which may affect how MAAS interacts with it.
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
- **50-maas-01-commissioning:** this script is the main MAAS tool, gathering information on machine resources, such as storage, network devices, CPU, RAM, etc.  We currently pull this data using lxd: We use a Go binary built from lxd source that just contains the minimum source to gather the resource information we need. This script also checks whether the machine being commissioning is a virtual machine, which may affect how MAAS interacts with it.
[/tab]
[/tabs]

- **maas-capture-lldp:** this script gathers LLDP network information to be presented on the logs page; this data is not used by MAAS at all.  **Runs in parallel with other scripts.**

- **maas-kernel-cmdline:** this script is used to update the boot devices; it double-checks that the right boot interface is selected.

Commissioning runs the same dozen or so scripts as enlistment, gathering all the same information, but with these caveats:

- Commissioning also runs user-supplied commissioning scripts, if present.  Be aware that these scripts run as root, so they can execute any system command.

- Commissioning runs test scripts which are not run during enlistment.

- Commissioning scripts can send BMC configuration data, and can be used to configure BMC data.

- The environment variable BMC_CONFIG_PATH is passed to serially run commissioning scripts; these scripts may write BMC power credentials to BMC_CONFIG_PATH in YAML format, where each key is a power parameter.  The first script to write BMC_CONFIG_PATH is the only script allowed to configure the BMC, allowing you to override MAAS' built-in BMC detection.  If the script returns 0, that value will be send to MAAS.

- All built-in commissioning scripts have been migrated into the database.

- `maas-run-remote-scripts` is capable of enlisting machines, so enlistment `user-data` scripts have been removed.

- The metadata endpoints `http://<MAAS>:5240/<latest or 2012-03-01>/` and `http://<MAAS>:5240/<latest or 2012-03-01>/meta-data/` are now available anonymously for use during enlistment.

In both enlistment and commissioning, MAAS uses either the MAC address or the UUID to identify machines.  Currently, because some machine types encountered by MAAS do **not** use unique MAC addresses, we are trending toward using the UUID.

[note]
To commission a node, it must have a status of "New".
[/note]

You have the option of setting some parameters to change how commissioning runs:

- `enable_ssh`: Optional integer. Controls whether to enable SSH for the commissioning environment using the user's SSH key(s). '1' == True, '0' == False. Roughly equivalent to the **Allow SSH access and prevent machine powering off** in the web UI.

- `skip_bmc_config`: Optional integer.  Controls whether to skip re-configuration of the BMC for IPMI based machines. '1' == True, '0' == False.

- `skip_networking`: Optional integer.  Controls whether to skip re-configuring the networking on the machine after the commissioning has completed. '1' == True, '0' == False. Roughly equivalent to **Retain network configuration** in the web UI.

- `skip_storage`: Optional integer.  Controls whether to skip re-configuring the storage on the machine after the commissioning has completed. '1' == True, '0' == False.  Roughly equivalent to **Retain storage configuration** in the web UI.

- `commissioning_scripts`: Optional string.  A comma separated list of commissioning script names and tags to be run. By default all custom commissioning scripts are run. Built-in commissioning scripts always run. Selecting `update_firmware` or `configure_hba` will run firmware updates or configure HBA's on matching machines.

- `testing_scripts`: Optional string.  A comma separated list of testing script names and tags to be run. By default all tests tagged `commissioning` will be run. Set to `none` to disable running tests.

- `parameters`: Optional string.  Scripts selected to run may define their own parameters. These parameters may be passed using the parameter name. Optionally a parameter may have the script name prepended to have that parameter only apply to that specific script.
