<!-- "How to work with audit event logs" -->
You can display and filter audit events via the CLI.  The basic command to report events is:

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

<a href="#heading--how-to-report-audit-events"><h2 id="heading--how-to-report-audit-events">How to report audit events</h2></a>

To report on audit-level events, you just have to add the `level` parameter to the previous command, like this:

```nohighlight
maas $PROFILE events query level=AUDIT
```

This produces a stream of JSON representing only the audit events:

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
stormrider@neuromancer:~$ maas $PROFILE events query level=AUDIT limit=3
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

The `limit` parameter can be changed up to a maximum of 1000 entries.

[note]
Non-administrative users will only see their own audit events listed.
[/note]

<a href="#heading--how-to-filter-audit-event-records"><h2 id="heading--how-to-filter-audit-event-records">How to filter audit event records</h2></a>

You can filter audit event records by hostname, mac_address, system id, zone, and owner.  For example, if you want to know what actions the user `admin` took on hostname `valued-moth`, you could enter a command such as this one:

```nohighlight
maas $PROFILE events query level=AUDIT owner=admin hostname=valued-moth
```

which might produce output similar to the following:

```nohighlight
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
    ],
    "next_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&hostname=valued-moth&owner=admin&after=12729",
    "prev_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&hostname=valued-moth&owner=admin&before=11"
}
```

<a href="#heading--how-to-pretty-print-audit-reports-with-jq"><h2 id="heading--how-to-pretty-print-audit-reports-with-jq">How to pretty-print audit reports with jq</h2></a>

A long stream of JSON is not the most efficient means of reporting audit events.  You can use `jq` to create more concise audit reports.  For example, you can try this command:

```nohighlight
maas $PROFILE events query level=AUDIT limit=20 | jq -r '.events[] | [.created, .username, .hostname,.description] | @tsv'
```

This produces a table of the first 20 audit events, filtering out the less interesting fields:

```nohighlight
Mon, 25 Apr. 2022 21:51:23	admin	valued-moth	Started deploying 'valued-moth'.
Mon, 25 Apr. 2022 21:51:18	admin	valued-moth	Acquired 'valued-moth'.
Mon, 25 Apr. 2022 21:44:51	admin	valued-moth	Aborted 'commissioning' on 'valued-moth'.
Mon, 25 Apr. 2022 21:41:52	admin	valued-moth	Started commissioning on 'valued-moth'.
Mon, 25 Apr. 2022 21:41:18	admin	valued-moth	Started releasing 'valued-moth'.
Mon, 25 Apr. 2022 21:40:42	admin	valued-moth	Acquired 'valued-moth'.
Mon, 25 Apr. 2022 21:40:34	admin	valued-moth	Started releasing 'valued-moth'.
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	cpu Intel(R) Core(TM) i5-10210U CPU was added on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	usb device 7 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	usb device 5 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	usb device 3 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	usb device 11 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	usb device 10 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	usb device 6 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	usb device 4 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	usb device 8 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	pci device 31 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	pci device 31 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	pci device 31 was removed on node 8wmfx3
Mon, 25 Apr. 2022 21:30:50	unknown	valued-moth	pci device 31 was removed on node 8wmfx3
```

You can also look for events triggered by a specific user, by adding the `owner` parameter to the CLI invocation above, in this case using the owner `admin`:

```nohighlight
maas admin events query level=AUDIT owner="admin" limit=1000 | jq -r '.events[] | [.created, .username, .hostname,.description] | @tsv'
```

This query returns results similar to these:

```nohighlight
Mon, 25 Apr. 2022 21:51:23	admin	valued-moth	Started deploying 'valued-moth'.
Mon, 25 Apr. 2022 21:51:18	admin	valued-moth	Acquired 'valued-moth'.
Mon, 25 Apr. 2022 21:44:51	admin	valued-moth	Aborted 'commissioning' on 'valued-moth'.
Mon, 25 Apr. 2022 21:41:52	admin	valued-moth	Started commissioning on 'valued-moth'.
Mon, 25 Apr. 2022 21:41:18	admin	valued-moth	Started releasing 'valued-moth'.
Mon, 25 Apr. 2022 21:40:42	admin	valued-moth	Acquired 'valued-moth'.
Mon, 25 Apr. 2022 21:40:34	admin	valued-moth	Started releasing 'valued-moth'.
Thu, 21 Apr. 2022 19:36:48	admin	valued-moth	Started deploying 'valued-moth'.
Thu, 21 Apr. 2022 19:36:21	admin	valued-moth	Acquired 'valued-moth'.
Thu, 21 Apr. 2022 19:21:46	admin	unknown	Updated configuration setting 'completed_intro' to 'True'.
Thu, 21 Apr. 2022 19:20:49	admin	unknown	Updated configuration setting 'upstream_dns' to '8.8.8.8'.
Thu, 21 Apr. 2022 19:20:49	admin	unknown	Updated configuration setting 'maas_name' to 'neuromancer'.
Thu, 21 Apr. 2022 19:20:47	admin	unknown	Updated configuration setting 'http_proxy' to ''.
Thu, 21 Apr. 2022 19:20:24	admin	unknown	Logged in admin.
```

<a id="#heading--using-audit-events-to-audit-maas"><h2 id="heading--using-audit-events-to-audit-maas">Using audit events to audit MAAS</h2></a>

Given the procedures above, you can use audit events to answer questions about a particular MAAS instance.  We will only offer a couple of examples here.  You can certainly extrapolate to suit your own particular needs.

<a id="#heading--auditing-machine-actions"><h3 id="heading--using-auditing-machine-actions">Auditing machine actions</h2></a>

For example, suppose you were trying to discover who deployed a specific machine (say, `valued-moth`) and when it was deployed.  You could enter a command sequence like this one:

```nohighlight
maas admin events query level=AUDIT owner="admin" hostname="valued-moth" limit=1000 | jq -r '.events[] | [.created, .username, .hostname,.description] | @tsv' | grep valued-moth | grep deploy
```

Such a command might yield results such as these:

```nohighlight
Mon, 25 Apr. 2022 21:51:23	admin	valued-moth	Started deploying 'valued-moth'.
Thu, 21 Apr. 2022 19:36:48	admin	valued-moth	Started deploying 'valued-moth'.
```

<a id="#heading--auditing-settings-changes"><h3 id="heading--using-auditing-settings-changes">Auditing settings changes</h2></a>

Or as another example, imagine trying to isolate recent changes to MAAS settings made by `admin`.  You could enter a command similar to this one:

```nohighlight
maas admin events query level=AUDIT owner="admin" limit=1000 | jq -r '.events[] | [.created, .username, .hostname,.description] | @tsv' | grep setting
```

which might give you results like these:

```nohighlight
Thu, 21 Apr. 2022 19:21:46	admin	unknown	Updated configuration setting 'completed_intro' to 'True'.
Thu, 21 Apr. 2022 19:20:49	admin	unknown	Updated configuration setting 'upstream_dns' to '8.8.8.8'.
Thu, 21 Apr. 2022 19:20:49	admin	unknown	Updated configuration setting 'maas_name' to 'neuromancer'.
Thu, 21 Apr. 2022 19:20:47	admin	unknown	Updated configuration setting 'http_proxy' to ''.
````

Using `jq` along with `grep` and other command line utilities, you can quickly produce reports that answer a wide range of audit questions about the current MAAS instance.