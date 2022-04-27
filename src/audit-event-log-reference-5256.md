<!-- "Audit event log reference" -->
Audit events are a subset of the MAAS event logs.  This article will provide reference material and instructions for users who want to review and report on events designated as MAAS audit events.

<a href="#heading--about-maas-audit-events"><h2 id="heading--about-maas-audit-events">About MAAS audit events</h2></a>

MAAS events are stored in the MAAS database in a table named `maasserver_event`.  This table contains the following information:

- **id**: a unique ID number assigned to table records as a primary key.
- **created**: the timestamp when this event entry was created.
- **updated**: the timestamp when this event entry was last changed (usually equal to the `created` timestamp).
- **action**: generally, the machine action that triggered this event; if this isn't that kind of event, this field is blank.  Note that this field is often blank.
- **description**: a long text description of what took place. This field is almost always populated; this is the primary information used for auditing MAAS events.
- **node_id**: the node ID; this is the numerical node ID, which is infrequently present in the event log records.
- **type_id**: this is the type of event that occurred.  This ID corresponds to an entry in the table `maasserver_eventtype`, which is further correlated to a reporting level.  It is the reporting level that determines whether an event is auditable (i.e., a level 0 event is considered an audit event).
- **node_hostname**: this is the node which triggered the event.  Generally, this will be the name of the region controller, the name of a machine, or blank.  Blank entries are events triggered by MAAS itself, such as `Starting rack boot image import`, which are not triggered by node. 
- **username**: the name of the user whose actions triggered the event.  This field is frequently blank, since many recordable events are triggered by MAAS and not by a specific user.
- **ip_address**: an IP address associated with the event; this field is frequently blank.
- **user_agent**: frequently blank, this field identifies any application or user script which may have triggered an event.  For example, an admin login record will probably fill this field with something like this: `Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.3`.
- **endpoint**: this field refers to communication endpoints.
- **node_system_id**: this is the `$SYSTEM_ID` frequently used in the CLI to reference node.  This field is filled if a particular node participated in the event, even if the node did not trigger that event.  For example, a record described as `40-maas-01-machine-resources changed status from 'Pending' to 'Passed'` might have a `node_system_id` of `bmnfcb`, and a `node_hostname` (in this case, region controller) of `neuromancer`, but no related `action`, meaning that neither `bmnfcb` nor `neuromancer` triggered this event, even though both participated.
- **user_id**: the ID of the user whose action triggered the event.  This field is often empty.

As mentioned above, the `type_id` corresponds to a description in the `maasserver_eventtype` table, which has the following fields:

- **id**: a unique ID number assigned to table records as a primary key.
- **created**: the timestamp when this event entry was created.
- **updated**: the timestamp when this event entry was last changed (usually equal to the `created` timestamp).
- **name**: a unique name for this event type, in human-readable, machine-comprehensible format (i.e., all caps, underbars instead of spaces).
- **description**: a human readable description of the event type.
- **level**: the event level, as a number.  This field corresponds to the mnemonics used in the MAAS CLI (e.g., "AUDIT") to identify event levels.

For audit events, the event `level` is always zero.

<a href="#heading--audit-level-events"><h2 id="heading--audit-level-events">Audit-level events</h2></a>

Audit-level events, or MAAS audit events, are those events whose `type_id` correspond to a `level` of zero. Currently, audit events include the following:

```nohighlight
20220421-1415=# select name, description from maasserver_eventtype where level=0;
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
(9 rows)
```

The following abridged listing gives a sense of the specific events associated with each of these event types:

```nohighlight
select maasserver_eventtype.name,maasserver_event.action,maasserver_event.description from maasserver_eventtype inner join maasserver_event on type_id=maasserver_eventtype.id where maasserver_eventtype.level=0 order by maasserver_eventtype.name;

              name               | action  |                         description                          
---------------------------------+---------+--------------------------------------------------------------
 AUTHORISATION                   |         | Logged in admin.
 NODE                            |         | Started commissioning on 'valued-moth'.
 NODE                            |         | Started releasing 'valued-moth'.
 NODE                            |         | Acquired 'valued-moth'.
 NODE                            |         | Started releasing 'valued-moth'.
 NODE                            |         | Aborted 'commissioning' on 'valued-moth'.
 NODE                            |         | Acquired 'valued-moth'.
 NODE                            |         | Started deploying 'valued-moth'.
 NODE                            |         | Acquired 'valued-moth'.
 NODE                            |         | Started deploying 'valued-moth'.
 NODE_HARDWARE_SYNC_BLOCK_DEVICE | added   | block device sda was added on node 8wmfx3
 NODE_HARDWARE_SYNC_BLOCK_DEVICE | removed | block device sda was removed on node 8wmfx3
 NODE_HARDWARE_SYNC_BLOCK_DEVICE | added   | block device nvme0n1 was added on node 8wmfx3
 NODE_HARDWARE_SYNC_BLOCK_DEVICE | removed | block device nvme0n1 was removed on node 8wmfx3
 NODE_HARDWARE_SYNC_CPU          | added   | cpu Intel(R) Core(TM) i5-10210U CPU was added on node 8wmfx3
 NODE_HARDWARE_SYNC_INTERFACE    | updated | interface enp5s0 was updated on node 8wmfx3
 NODE_HARDWARE_SYNC_INTERFACE    | added   | interface enx606d3c64581d was added on node 8wmfx3
 NODE_HARDWARE_SYNC_INTERFACE    | added   | interface tap8ed34737 was added on node 8wmfx3
 NODE_HARDWARE_SYNC_INTERFACE    | added   | interface wlp0s20f3 was added on node 8wmfx3
 NODE_HARDWARE_SYNC_INTERFACE    | removed | interface enp5s0 was removed on node 8wmfx3
 NODE_HARDWARE_SYNC_MEMORY       | removed | 0 bytes of memory was removed on node 8wmfx3
 NODE_HARDWARE_SYNC_MEMORY       | removed | -10.1 kB of memory was removed on node 8wmfx3
 NODE_HARDWARE_SYNC_MEMORY       | added   | 10.1 kB of memory was added on node 8wmfx3
 NODE_HARDWARE_SYNC_PCI_DEVICE   | updated | pci device 2 was updated on node 8wmfx3
 NODE_HARDWARE_SYNC_PCI_DEVICE   | updated | pci device 31 was updated on node 8wmfx3
 NODE_HARDWARE_SYNC_PCI_DEVICE   | added   | pci device 0 was added on node 8wmfx3
 NODE_HARDWARE_SYNC_PCI_DEVICE   | removed | pci device 0 was removed on node 8wmfx3
 NODE_HARDWARE_SYNC_USB_DEVICE   | added   | usb device 3 was added on node 8wmfx3
 NODE_HARDWARE_SYNC_USB_DEVICE   | removed | usb device 8 was removed on node 8wmfx3
 SETTINGS                        |         | Updated configuration setting 'upstream_dns' to '8.8.8.8'.
 SETTINGS                        |         | Updated configuration setting 'maas_name' to 'neuromancer'.
 SETTINGS                        |         | Updated configuration setting 'http_proxy' to ''.
 SETTINGS                        |         | Updated configuration setting 'completed_intro' to 'True'.
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

Obviously, the MAAS database can be queried to examine audit events, as shown above.  In some cases, this method may be the most efficient.  

<a href="#heading--how-to-use-the-cli-to-report-audit-events"><h2>How to use the CLI to report audit events</h2></a>

There is currently no reasonable convenient way to isolate audit events using the MAAS UI.  It is possible to download all events from the "Events" tab, perhaps in multiple stages, and apply command-line utilities to that data to get a comprehensible report.  You will probably find it much more efficient to filter audit events and report on them using the MAAS CLI, though.

The basic command to report events using the MAAS CLI is:

```nohighlight
usage: maas $PROFILE events query [--help] [-d] [-k] [data [data ...]]

List node events


This method accepts keyword arguments.  Pass each argument as a
key-value pair with an equals sign between the key and the value:
key1=value1 key2=value key3=value3.  Keyword arguments must come after
any positional arguments.

List node events, optionally filtered by various criteria
via URL query parameters.

:param hostname: Optional.  An optional hostname. Only
events relating to the node with the matching hostname will be
returned. This can be specified multiple times to get events relating
to more than one node.
:type hostname: String

 :param mac_address: Optional.  An optional list of MAC
addresses.  Only nodes with matching MAC addresses will be returned.
:type mac_address: String

 :param id: Optional.  An optional list of system ids.
Only nodes with matching system ids will be returned.
:type id: String

 :param zone: Optional.  An optional name for a physical
zone. Only nodes in the zone will be returned.
:type zone: String

 :param agent_name: Optional.  An optional agent name.
Only nodes with matching agent names will be returned.
:type agent_name: String

 :param level: Optional.  Desired minimum log level of
returned events. Returns this level of events and greater. Choose from:
AUDIT, CRITICAL, DEBUG, ERROR, INFO, WARNING.  The default is INFO.
:type level: String

 :param limit: Optional.  Optional number of events to
return. Default 100.  Maximum: 1000.
:type limit: String

 :param before: Optional.  Optional event id.  Defines
where to start returning older events.
:type before: String

 :param after: Optional.  Optional event id.  Defines
where to start returning newer events.
:type after: String

 :param owner: Optional.  If specified, filters the list
to show only events owned by the specified username.
:type owner: String


Common command-line options:
    --help, -h
	Show this help message and exit.
    -d, --debug
	Display more information about API responses.
    -k, --insecure
	Disable SSL certificate check
```

For example, to report on audit-level events, you just have to add the `level` parameter, like this:

```nohighlight
maas $PROFILE events query level=AUDIT
```

This produces a stream of JSON representing the audit events:

```nohighlight
Success.
Machine-readable output follows:
{
    "count": 100,
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
       ...
   ],
    "next_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&after=12729",
    "prev_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&before=12383"
}
```

By default, this list is limited to 100 events; that can be changed by specifying the `limit` parameter:

```nohighlight
tormrider@neuromancer:~$ maas admin events query level=AUDIT limit=3
Success.
Machine-readable output follows:
{
    "count": 3,
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
        }
    ],
    "next_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&limit=3&after=12729",
    "prev_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&limit=3&before=12502"
}
```

Currently, there is no parameter which will filter on `type`.