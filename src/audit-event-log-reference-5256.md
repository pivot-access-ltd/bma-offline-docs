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
 NODE_HARDWARE_SYNC_USB_DEVICE   | Node USB Device hardware sync state chage
(9 rows)
```


