<!-- "Audit event log reference" -->
Audit events are a subset of the MAAS event logs.  This article will provide reference material for those who want to review and report on events designated as MAAS audit events.

<a href="#heading--about-maas-audit-events"><h2 id="heading--about-maas-audit-events">About MAAS audit events</h2></a>

MAAS audit events can be viewed via the CLI with a command similar to the following:

```nohighlight
maas $PROFILE events query level=AUDIT
```

Such a command would produce JSON output like this:

```nohighlight
Machine-readable output follows:
{
    "count": 14,
    "events": [
        {
            "username": "admin",
            "node": "e86c7h",
            "hostname": "valued-moth",
            "id": 12729,
            "level": "AUDIT",
            "created": "Mon, 25 Apr. 2022 21:51:23",
            "type": "Node",
            "description": "Started deploying 'valued-moth'."
        },
        {
            "username": "admin",
            "node": "e86c7h",
            "hostname": "valued-moth",
            "id": 12725,
            "level": "AUDIT",
            "created": "Mon, 25 Apr. 2022 21:51:18",
            "type": "Node",
            "description": "Acquired 'valued-moth'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "valued-moth",
            "id": 12502,
            "level": "AUDIT",
            "created": "Mon, 25 Apr. 2022 21:44:51",
            "type": "Node",
            "description": "Aborted 'commissioning' on 'valued-moth'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "valued-moth",
            "id": 12497,
            "level": "AUDIT",
            "created": "Mon, 25 Apr. 2022 21:41:52",
            "type": "Node",
            "description": "Started commissioning on 'valued-moth'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "valued-moth",
            "id": 12493,
            "level": "AUDIT",
            "created": "Mon, 25 Apr. 2022 21:41:18",
            "type": "Node",
            "description": "Started releasing 'valued-moth'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "valued-moth",
            "id": 12486,
            "level": "AUDIT",
            "created": "Mon, 25 Apr. 2022 21:40:42",
            "type": "Node",
            "description": "Acquired 'valued-moth'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "valued-moth",
            "id": 12479,
            "level": "AUDIT",
            "created": "Mon, 25 Apr. 2022 21:40:34",
            "type": "Node",
            "description": "Started releasing 'valued-moth'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "valued-moth",
            "id": 134,
            "level": "AUDIT",
            "created": "Thu, 21 Apr. 2022 19:36:48",
            "type": "Node",
            "description": "Started deploying 'valued-moth'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "valued-moth",
            "id": 130,
            "level": "AUDIT",
            "created": "Thu, 21 Apr. 2022 19:36:21",
            "type": "Node",
            "description": "Acquired 'valued-moth'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "unknown",
            "id": 18,
            "level": "AUDIT",
            "created": "Thu, 21 Apr. 2022 19:21:46",
            "type": "Settings",
            "description": "Updated configuration setting 'completed_intro' to 'True'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "unknown",
            "id": 14,
            "level": "AUDIT",
            "created": "Thu, 21 Apr. 2022 19:20:49",
            "type": "Settings",
            "description": "Updated configuration setting 'upstream_dns' to '8.8.8.8'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "unknown",
            "id": 13,
            "level": "AUDIT",
            "created": "Thu, 21 Apr. 2022 19:20:49",
            "type": "Settings",
            "description": "Updated configuration setting 'maas_name' to 'neuromancer'."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "unknown",
            "id": 12,
            "level": "AUDIT",
            "created": "Thu, 21 Apr. 2022 19:20:47",
            "type": "Settings",
            "description": "Updated configuration setting 'http_proxy' to ''."
        },
        {
            "username": "admin",
            "node": null,
            "hostname": "unknown",
            "id": 11,
            "level": "AUDIT",
            "created": "Thu, 21 Apr. 2022 19:20:24",
            "type": "Authorisation",
            "description": "Logged in admin."
        }
    ],
    "next_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&owner=admin&after=12729",
    "prev_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&owner=admin&before=11"
}
```

These MAAS audit events consist of the following information:

- **username**: the name of the user whose actions triggered the event.  This field is frequently blank, since many recordable events are triggered by MAAS and not by a specific user.
- **node**: this is the `$SYSTEM_ID` frequently used in the CLI to reference node.  This field is filled if a particular node participated in the event, even if the node did not trigger that event.  
- **hostname**: this is the node which triggered the event.  Generally, this will be the name of the region controller, the name of a machine, or blank.  Blank entries are events triggered by MAAS itself, such as `Starting rack boot image import`, which are not triggered by node. 
- **id**: a unique ID number assigned to table records as a primary key.
- **level**: the level of event, such as AUDIT, DEBUG, etc.
- **created**: the timestamp when this event entry was created.
- **description**: a long text description of what took place. This field is almost always populated; this is the primary information used for auditing MAAS events.
- **type**: this is the type of event that occurred, as shown in the following table.

```nohighlight
              name               |                 description                  
---------------------------------+----------------------------------------------
 AUTHORISATION                   | Authorisation
 SETTINGS                        | Settings
 NODE                            | Node
 NODE_HARDWARE_SYNC_MEMORY       | Node Memory hardware sync state change
 NODE_HARDWARE_SYNC_INTERFACE    | Node Interface hardware sync state change
 NODE_HARDWARE_SYNC_BLOCK_DEVICE | Node Block Device hardware sync state change
 NODE_HARDWARE_SYNC_PCI_DEVICE   | Node PCI Device hardware sync state change
 NODE_HARDWARE_SYNC_CPU          | Node CPU hardware sync state change
 NODE_HARDWARE_SYNC_USB_DEVICE   | Node USB Device hardware sync state change
```

<a href="#heading--table-of-audit-events"><h3 id="heading--table-of-audit-events">Table of audit events</h3></a>

The following abridged listing gives a sense of the specific events associated with each of these event types:

```nohighlight
              name               | action  |                         description                          
---------------------------------+---------+--------------------------------------------------------------
 AUTHORISATION                   |         | Logged in admin.
 NODE                            |         | Started commissioning a machine.
 NODE                            |         | Started releasing a machine.
 NODE                            |         | Acquired a machine.
 NODE                            |         | Aborted commissioning on a machine.
 NODE                            |         | Started deploying a machine.
 NODE                            |         | Aborted deployment of a machine. 
 NODE_HARDWARE_SYNC_BLOCK_DEVICE | added   | Added a block device to a machine.
 NODE_HARDWARE_SYNC_BLOCK_DEVICE | removed | Removed a block device from a machine.
 NODE_HARDWARE_SYNC_BLOCK_DEVICE | updated | Updated a block device on a machine.
 NODE_HARDWARE_SYNC_CPU          | added   | Added a CPU to a machine.
 NODE_HARDWARE_SYNC_CPU          | removed | Removed a CPU from a machine.
 NODE_HARDWARE_SYNC_INTERFACE    | added   | Added an interface to a machine.
 NODE_HARDWARE_SYNC_INTERFACE    | removed | Removed an interface from a machine.
 NODE_HARDWARE_SYNC_INTERFACE    | updated | Updated an interface on a machine.  
 NODE_HARDWARE_SYNC_MEMORY       | added   | Added memory to a machine.
 NODE_HARDWARE_SYNC_MEMORY       | removed | Removed memory from a machine.
 NODE_HARDWARE_SYNC_MEMORY       | updated | Updated memory on a machine.
 NODE_HARDWARE_SYNC_PCI_DEVICE   | updated | Updated a PCI device on a machine.
 NODE_HARDWARE_SYNC_PCI_DEVICE   | added   | Added a PCI device to a machine.
 NODE_HARDWARE_SYNC_PCI_DEVICE   | removed | Removed a PCI device from a machine.
 NODE_HARDWARE_SYNC_USB_DEVICE   | added   | Added a USB device to a machine.
 NODE_HARDWARE_SYNC_USB_DEVICE   | removed | Removed a USB device from a machine.
 NODE_HARDWARE_SYNC_USB_DEVICE   | updated | Updated a USB device on a machine.
 SETTINGS                        |         | Updated MAAS settings.
```

You will notice that these audit event logs are essentially state changes:

- **AUTHORISATION**: Authorisation-type events, such as logging on or off the MAAS instance.
- **SETTINGS**: Any changes to MAAS settings.
- **NODE**: Node state changes, e.g., "Deployed" to "Released".
- **NODE_HARDWARE_SYNC_MEMORY**: Node memory hardware sync state changes.
- **NODE_HARDWARE_SYNC_INTERFACE**: Node interface hardware sync state changes.
- **NODE_HARDWARE_SYNC_BLOCK_DEVICE**: Node block device hardware sync state changes.
- **NODE_HARDWARE_SYNC_PCI_DEVICE**: Node PCI device hardware sync state changes.
- **NODE_HARDWARE_SYNC_CPU**: Node CPU hardware sync state changes.
- **NODE_HARDWARE_SYNC_USB_DEVICE**: Node USB Device hardware sync state changes.

For information on how to use these audit events to answer specific questions, see [How to work with audit event logs](/t/how-to-work-with-audit-event-logs/5987).