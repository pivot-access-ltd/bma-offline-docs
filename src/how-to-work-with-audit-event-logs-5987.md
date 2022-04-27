<!-- "How to work with audit event logs" -->
<a href="#heading--how-to-use-the-cli-to-report-audit-events"><h2>How to use the CLI to report audit events</h2></a>

There is currently no reasonably convenient way to isolate audit events using the MAAS UI.  It is possible to download all events from the "Events" tab, perhaps in multiple stages, and apply command-line utilities to that data to get a comprehensible report.

You will probably find it much more efficient to filter audit events and report on them using the MAAS CLI, though. This article will show you how to:

<a href="#heading--how-to-report-events-as-json-using-the-maas-cli"><h2 id="heading--how-to-report-events-as-json-using-the-maas-cli">How to report events as JSON using the MAAS CLI</h2></a>
<a href="#heading--how-to-report-audit-events-as-json-using-the-maas-cli"><h2 id="heading--how-to-report-audit-events-as-json-using-the-maas-cli">How to report audit events as JSON using the MAAS CLI</h2></a>


<a href="#heading--how-to-report-events-as-json-using-the-maas-cli"><h2 id="heading--how-to-report-events-as-json-using-the-maas-cli">How to report events as JSON using the MAAS CLI</h2></a>

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

<a href="#heading--how-to-report-audit-events-as-json-using-the-maas-cli"><h2 id="heading--how-to-report-audit-events-as-json-using-the-maas-cli">How to report audit events as JSON using the MAAS CLI</h2></a>

To report on audit-level events, you just have to add the `level` parameter, like this:

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

[note]
Non-administrative users will only see their own audit event logs listed.
[/note]

Currently, there is no parameter which will filter on `type_id`.

<a href="#heading--how-to-pretty-print-audit-reports-with-jq"><h2 id="heading--how-to-pretty-print-audit-reports-with-jq">How to pretty-print audit reports with jq</h2></a>

A long stream of JSON is not the most efficient means of reporting audit events.  You can use `jq` to create more concise audit reports.  For example, you can try this command:

```nohighlight
maas admin events query level=AUDIT limit=20 | jq -r '.events[] | [.created, .username, .hostname,.description] | @tsv'
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

<!--

There are many user-initiated events in MAAS that an administrator or a user may want to audit. These include someone updating the settings or changing a user's permissions. This page details how to query these events and includes examples of how to perform a query, and the type of data logs can provide.

This article will help you learn:

* [How to list audit events for all users](#heading--list-audit-events-for-all-users)
* [How to list audit events for a specific user](#heading--list-audit-events-for-a-specific-user)

<a href="#heading--list-audit-events-for-all-users"><h2 id="heading--list-audit-events-for-all-users">How to list audit events for all users</h2></a>

To list events for all users, use the following syntax:

``` bash
maas $PROFILE events query level=AUDIT
```


The following is example output from the previous command, using admin as the MAAS profile:

``` no-highlight
Success.
Machine-readable output follows:
{
    "count": 1,
    "events": [
        {
            "username": "admin",
            "node": null,
            "hostname": "",
            "id": 2569,
            "level": "AUDIT",
            "created": "Thu, 01 Feb. 2018 22:28:18",
            "type": "Authorisation",
            "description": "User admin logged in."
        }
    ],
    "next_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&after=2569",
    "prev_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&before=2558"
}
```

The above output shows that there is currently only one audit event log for the user `admin`, and that MAAS created this log when they logged into the web UI.

<a href="#heading--list-audit-events-for-a-specific-user"><h2 id="heading--list-audit-events-for-a-specific-user">How to list audit events for a specific user</h2></a>

To list the audit event logs for a specific user that you have permissions for, supply the `owner=$USERNAME` parameter to the query command:

``` bash
maas $PROFILE events query level=AUDIT owner=$USERNAME
```

As there is only one audit event log in the database (as seen above), generate some more by performing these four actions:

1. Create new non-administrator user `johnnybegood` with `admin` user
2. Logout of web UI as `admin` user and login with `johnnybegood` user
3. Change password of the `johnnybegood` user
4. Log back into the web UI (Django forces a re-login when currently logged in user changes their password).

Let's take a look and see what type of audit event logs we have now, filtering with `owner=johnnybegood` as shown in the following command:

``` bash
maas admin events query level=AUDIT owner=johnnybegood
```

``` bash
Success.
Machine-readable output follows:
{
    "count": 3,
    "events": [
        {
            "username": "johnnybegood",
            "node": null,
            "hostname": "",
            "id": 2877,
            "level": "AUDIT",
            "created": "Mon, 12 Feb. 2018 22:34:46",
            "type": "Authorisation",
            "description": "User 'johnnybegood' logged in."
        },
        {
            "username": "johnnybegood",
            "node": null,
            "hostname": "",
            "id": 2876,
            "level": "AUDIT",
            "created": "Mon, 12 Feb. 2018 22:34:35",
            "type": "Authorisation",
            "description": "Password changed for 'johnnybegood'."
        },
        {
            "username": "johnnybegood",
            "node": null,
            "hostname": "",
            "id": 2875,
            "level": "AUDIT",
            "created": "Mon, 12 Feb. 2018 22:33:56",
            "type": "Authorisation",
            "description": "User 'johnnybegood' logged in."
        }
    ],
    "next_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&owner=johnnybegood&after=2877",
    "prev_uri": "/MAAS/api/2.0/events/?op=query&level=AUDIT&owner=johnnybegood&before=2875"
}
```

As we can see above, only audit event logs for the user `johnnybegood` are generated. These events show the following eight items:

1. The user for the event
2. Whether or not the event is associated with a particular node
3. The node's hostname
4. The event id
5. The level of the event
6. when MAAS created the event
7. The event type
8. The event description
-->