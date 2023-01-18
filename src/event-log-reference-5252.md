<!-- "Event log reference" -->
The events log tracks state changes and the execution of basic configuration steps, serving as a timeline for your MAAS machines.  A simple view of the events log might look something like this:

```
  Time 	                        Event
  Sun, 04 Oct. 2020 23:12:35 	Ready
  Sun, 04 Oct. 2020 23:12:31 	Running test - smartctl-validate on sda
  Sun, 04 Oct. 2020 23:10:37 	Gathering information
  Sun, 04 Oct. 2020 23:10:30 	Loading ephemeral
  Sun, 04 Oct. 2020 23:10:15 	Performing PXE boot
  Sun, 04 Oct. 2020 23:09:54 	Powering on
  Sun, 04 Oct. 2020 23:09:53 	Commissioning
```

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To view the Events log (for a particular machine), select a machine from the machine list and choose the "Events" tab at the top of the screen:

<a href="https://discourse.maas.io/uploads/default/original/1X/45ad4b968f85ef38e875e6df03d9f832fc7d4743.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/45ad4b968f85ef38e875e6df03d9f832fc7d4743.png"></a>

You can also see a more detailed view by selecting "View full history" in near the upper right of the log output.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To view the raw Events log, enter the following command:

```
maas $PROFILE events query
```

You can tabulate the results, sorted by machine, with the following command:

```
maas admin events query | jq -r '(["HOSTNAME","TIMESTAMP","TYPE","DESCRIPTION"] | (., map(length*"-"))),
(.events[] | [.hostname, .created, .type, .description // "-"]) | @tsv' | column -t -s $'\t'
[/tab]
[/tabs]

<a href="#heading--Table-of-event-logs"><h2 id="heading--Table-of-event-logs">Table of event logs</h2></a>

Non-AUDIT MAAS events can be divided into four categories:

* INFO: informational only; no failure or potential failure state detected.
* WARNING: warnings; a potential failure state was detected, or a failure may occur in the future if this condition is not corrected.
* ERROR: errors; a failure state was observed.  The intended operation likely did not complete successfully.
* DEBUG: debugging messages; internal informational messages, used to help characterize failure states.

These four categories are summarized below.  Both the internal (code) representation and the corresponding external message are shown, as MAAS sometimes throws exceptions which use the internal representation.

<a href="#heading--INFO-events"><h3 id="heading--INFO-events">INFO events</h3></a>

| Internal representation | External message |
|:---|:----|
| ABORTED_COMMISSIONING  | Aborted commissioning |
| ABORTED_DEPLOYMENT  | Aborted deployment |
| ABORTED_DISK_ERASING  | Aborted disk erasing |
| ABORTED_TESTING  | Aborted testing |
| COMMISSIONING  | Commissioning |
| CONFIGURING_OS  | Configuring OS |
| CONFIGURING_STORAGE  | Configuring storage |
| ENTERING_RESCUE_MODE  | Entering rescue mode |
| EXITED_RESCUE_MODE  | Exited rescue mode |
| FAILED_COMMISSIONING  | Failed commissioning |
| FAILED_EXITING_RESCUE_MODE  | Failed exiting rescue mode |
| FAILED_TESTING  | Failed testing |
| GATHERING_INFO  | Gathering information |
| INSTALLING_OS  | Installing OS |
| LOADING_EPHEMERAL  | Loading ephemeral |
| NODE_POWER_CYCLE_STARTING  | Power cycling |
| NODE_POWER_OFF_STARTING  | Powering off |
| NODE_POWER_ON_STARTING  | Powering on |
| PERFORMING_PXE_BOOT  | Performing PXE boot |
| RESCUE_MODE  | Rescue mode |
| RUNNING_TEST  | Running test |
| SCRIPT_DID_NOT_COMPLETE  | Script |

<a href="#heading--WARNING-events"><h3 id="heading--WARNING-events">WARNING events</h3></a>

| Internal representation | External message |
|:---|:----|
| NODE_POWER_QUERY_FAILED  | Failed to query node's BMC |
| RACK_IMPORT_WARNING  | Rack import warning |
| REGION_IMPORT_WARNING  | Region import warning |

<a href="#heading--ERROR-events"><h3 id="heading--ERROR-events">ERROR events</h3></a>

| Internal representation | External message |
|:---|:----|
| NODE_COMMISSIONING_EVENT_FAILED  | Node commissioning failure |
| NODE_ENTERING_RESCUE_MODE_EVENT_FAILED  | Node entering rescue mode failure |
| NODE_EXITING_RESCUE_MODE_EVENT_FAILED  | Node exiting rescue mode failure |
| NODE_INSTALL_EVENT_FAILED  | Node installation failure |
| NODE_POST_INSTALL_EVENT_FAILED  | Node post-installation failure |
| NODE_POWER_CYCLE_FAILED  | Failed to power cycle node |
| NODE_POWER_OFF_FAILED  | Failed to power off node |
| NODE_POWER_ON_FAILED  | Failed to power on node |
| RACK_IMPORT_ERROR  | Rack import error |
| REGION_IMPORT_ERROR  | Region import error |
| REQUEST_NODE_MARK_BROKEN_SYSTEM  | Marking node broken |
| REQUEST_NODE_MARK_FAILED_SYSTEM  | Marking node failed |
| SCRIPT_RESULT_ERROR  | Script result lookup or storage error |

<a href="#heading--DEBUG-events"><h3 id="heading--DEBUG-events">DEBUG events</h3></a>

| Internal representation | External message |
|:---|:----|
| NODE_CHANGED_STATUS  | Node changed status |
| NODE_COMMISSIONING_EVENT  | Node commissioning |
| NODE_ENTERING_RESCUE_MODE_EVENT  | Node entering rescue mode |
| NODE_EXITING_RESCUE_MODE_EVENT  | Node exiting rescue mode |
| NODE_HTTP_REQUEST  | HTTP Request |
| NODE_INSTALLATION_FINISHED  | Installation complete |
| NODE_INSTALL_EVENT  | Node installation |
| NODE_POWERED_OFF  | Node powered off |
| NODE_POWERED_ON  | Node powered on |
| NODE_PXE_REQUEST  | PXE Request |
| NODE_STATUS_EVENT  | Node status event |
| NODE_TFTP_REQUEST  | TFTP Request |
| RACK_IMPORT_INFO  | Rack import info |
| REGION_IMPORT_INFO  | Region import info |
| REQUEST_CONTROLLER_REFRESH  | Starting refresh of controller hardware and networking information |
| REQUEST_NODE_ABORT_COMMISSIONING  | User aborting node commissioning |
| REQUEST_NODE_ABORT_DEPLOYMENT  | User aborting deployment |
| REQUEST_NODE_ABORT_ERASE_DISK  | User aborting disk erase |
| REQUEST_NODE_ABORT_TESTING  | User aborting node testing |
| REQUEST_NODE_ACQUIRE  | User acquiring node |
| REQUEST_NODE_ERASE_DISK  | User erasing disk |
| REQUEST_NODE_LOCK  | User locking node |
| REQUEST_NODE_MARK_BROKEN  | User marking node broken |
| REQUEST_NODE_MARK_FAILED  | User marking node failed |
| REQUEST_NODE_MARK_FIXED  | User marking node fixed |
| REQUEST_NODE_MARK_FIXED_SYSTEM  | Marking node fixed |
| REQUEST_NODE_OVERRIDE_FAILED_TESTING  | User overrode 'Failed testing' status |
| REQUEST_NODE_RELEASE  | User releasing node |
| REQUEST_NODE_START  | User powering up node |
| REQUEST_NODE_START_COMMISSIONING  | User starting node commissioning |
| REQUEST_NODE_START_DEPLOYMENT  | User starting deployment |
| REQUEST_NODE_START_RESCUE_MODE  | User starting rescue mode |
| REQUEST_NODE_START_TESTING  | User starting node testing |
| REQUEST_NODE_STOP  | User powering down node |
| REQUEST_NODE_STOP_RESCUE_MODE  | User stopping rescue mode |
| REQUEST_NODE_UNLOCK  | User unlocking node |
| REQUEST_RACK_CONTROLLER_ADD_CHASSIS  | Querying chassis and enlisting all machines |
| SCRIPT_RESULT_CHANGED_STATUS  | Script result |
