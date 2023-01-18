<!-- "How to work with log files" -->
MAAS has a robust logging capability, which presents several different views, including a number of node-specific log files and several syslogd-style text logs.  Each of these logs provides different information, or at the very least, different views of the same information.  MAAS gathers logging information about the various MAAS states and records both automated and user-driven actions.

#### This document will help you learn:

- [About the syslog logging path](#heading--path)
- [How to use a remote syslog server](#heading--using-a-remote-syslog-server)

It also links to reference material for:

- [Commissioning logs](/t/commissioning-log-reference/5248)
- [Test logs](/t/test-log-reference/5314)
- [Event logs](/t/event-log-reference/5252)
- [Audit event logs](/t/audit-event-log-reference/5256)

The discussion of these logs and their contents can be very extensive, so each type of logging has its own documentation section, reachable from the left-hand menu -- or from the list of questions above.

<a href="#heading--path"><h2 id="heading--path">About the syslog logging path</h2></a>

[tabs]
[tab version="v3.2 Snap"] 
Syslog data is kept in `/var/snap/maas/common/log/rsyslog/<machine-name><yyyy-mm-dd>/messages`. Every machine known to MAAS will have corresponding syslogs.
[/tab]
[tab version="v3.2 Packages"] 
Syslog data is kept in `/var/log/maas/rsyslog/<machine-name><yyyy-mm-dd>/messages`.  Every machine known to MAAS will have corresponding syslogs.
[/tab]
[tab version="v3.1 Snap"] 
Syslog data is kept in `/var/snap/maas/common/log/rsyslog/<machine-name><yyyy-mm-dd>/messages`. Every machine known to MAAS will have corresponding syslogs.
[/tab]
[tab version="v3.1 Packages"] 
Syslog data is kept in `/var/log/maas/rsyslog/<machine-name><yyyy-mm-dd>/messages`.  Every machine known to MAAS will have corresponding syslogs.
[/tab]
[tab version="v3.0 Snap"] 
Syslog data is kept in `/var/snap/maas/common/log/rsyslog/<machine-name><yyyy-mm-dd>/messages`. Every machine known to MAAS will have corresponding syslogs.
[/tab]
[tab version="v3.0 Packages"] 
Syslog data is kept in `/var/log/maas/rsyslog/<machine-name><yyyy-mm-dd>/messages`.  Every machine known to MAAS will have corresponding syslogs.
[/tab]
[tab version="v2.9 Snap"] 
Syslog data is kept in `/var/snap/maas/common/log/rsyslog/<machine-name><yyyy-mm-dd>/messages`. Every machine known to MAAS will have corresponding syslogs.
[/tab]
[tab version="v2.9 Packages"] 
Syslog data is kept in `/var/log/maas/rsyslog/<machine-name><yyyy-mm-dd>/messages`.  Every machine known to MAAS will have corresponding syslogs.
[/tab]
[/tabs]

<a href="#heading--using-a-remote-syslog-server"><h2 id="heading--using-a-remote-syslog-server">How to use a remote syslog server</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"] 
To add a remote syslog server, click the Settings tab and then click the Network services tab. Scroll down to the Syslog section, where you can add a syslog URL or IP:

<a href="https://assets.ubuntu.com/v1/e139d4e9-installconfig-syslog__2.6-remote-syslog.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/e139d4e9-installconfig-syslog__2.6-remote-syslog.png"></a>

Click the Save button to save your changes.
[/tab]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To add or update a remote syslog server in your MAAS environment:

``` bash
maas $PROFILE maas set-config name="remote_syslog" value="$SYSLOG_FQDN"
```

For example, to set your syslog server to `192.168.100.11`:

``` bash
maas $PROFILE maas set-config name="remote_syslog" value=192.168.100.11
```

If you clear the `remote_syslog` value, MAAS will revert to the default behaviour, which is to send all syslog information to all MAAS region controllers.

For example:

``` bash
maas $PROFILE maas set-config name="remote_syslog" value=""
```

[note]
Note that MAAS controllers' syslogs are not forwarded to the external syslog server -- only machine syslog information is forwarded.
[/note]
[/tab]
[/tabs]

<a href="#heading--Using-the-logs-directly"><h3 id="heading--Using-the-logs-directly">Using the logs directly</h3></a>

By the way, if you're interested in reading the logs, and you're using snaps, you'll find what you need here:

- /var/snap/maas/common/log/maas.log
- /var/snap/maas/common/log/regiond.log
- /var/snap/maas/common/log/rackd.log
- /var/snap/maas/common/log/rsyslog/$MACHINE_NAME/$RELEVANT_DATE/messages

If you’re using packages, you’ll find the log files in these locations:

- /var/log/maas/maas.log
- /var/log/maas/regiond.log
- /var/log/maas/rackd.log
- /var/log/maas/rsyslog/$MACHINE_NAME/$RELEVANT_DATE/messages

These logs can be very large and hard to search, and the web UI does not separate events by type. For instance, commissioning a simple VM produces logging information like this:

```nohighlight
maas.log:2022-09-29T15:00:16.461402-05:00 neuromancer maas.interface: [info] eth0 (physical) on fun-zebra: IP address automatically unlinked: None:type=AUTO
maas.log:2022-09-29T15:00:16.553396-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from NEW to COMMISSIONING
maas.log:2022-09-29T15:00:16.754265-05:00 neuromancer maas.power: [info] Changing power state (on) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T15:00:16.759676-05:00 neuromancer maas.node: [info] fun-zebra: Commissioning started
maas.log:2022-09-29T15:00:18.039441-05:00 neuromancer maas.power: [info] Changed power state (on) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T15:03:26.946507-05:00 neuromancer maas.node: [info] fun-zebra: Storage layout was set to flat.
maas.log:2022-09-29T15:04:07.795515-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from COMMISSIONING to TESTING
maas.log:2022-09-29T15:04:17.288763-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from TESTING to READY
regiond.log:2022-09-29 20:00:16 maasserver.models.signals.interfaces: [info] eth0 (physical) on fun-zebra: deleted IP addresses due to VLAN update (5001 -> 5002).
regiond.log:2022-09-29 20:00:32 maasserver.region_controller: [info] Reloaded DNS configuration; ip 10.103.114.192 connected to fun-zebra on eth0
regiond.log:2022-09-29 20:01:09 maasserver.rpc.leases: [info] Lease update: commit for 10.103.114.192 on 0:16:3e:a2:73:5c at 2022-09-29 20:01:09 (lease time: 600s) (hostname: fun-zebra)
regiond.log:2022-09-29 20:01:14 maasserver.region_controller: [info] Reloaded DNS configuration; ip 10.103.114.192 connected to fun-zebra on eth0
regiond.log:     * node fun-zebra renamed interface eth0 to enp5s0
regiond.log:     * ip 10.103.114.192 connected to fun-zebra on eth0
regiond.log:     * ip 10.103.114.192 disconnected from fun-zebra on eth0
```

Not all of this output is relevant, nor does it all trigger a recorded MAAS event.  Interpreting MAAS logs is a matter of practice with known events in a controlled environment.

<a href="#heading--maas-events-query"><h3 id="heading--mass-events-query">MAAS CLI events query command</h3></a>

In fact, probably the best way to review events is via the CLI sub-command, `events query`. This sub-command can help you filter and summarise events.  Let's take a look at how this tool works.

<a href="#heading--Basic-queries"><h4 id="heading--Basic-queries">Basic queries</h4></a>

MAAS events can be queried with the simple CLI command:

```nohighlight
maas $PROFILE events query
```

where `$PROFILE` is your login name for your MAAS CLI.  This command produces a very long JSON listing, something like this:

```nohighlight
Success.
Machine-readable output follows:
{
    "count": 100,
    "events": [
        {
            "username": "unknown",
            "node": "ebd7dc",
            "hostname": "new-name",
            "id": 588448,
            "level": "WARNING",
            "created": "Tue, 27 Sep. 2022 20:49:37",
            "type": "Failed to query node's BMC",
            "description": "Failed to login to virsh console."
        },
        {
            "username": "unknown",
            "node": "mm3tc8",
            "hostname": "fair-marten",
            "id": 588447,
            "level": "WARNING",
            "created": "Tue, 27 Sep. 2022 20:49:37",
            "type": "Failed to query node's BMC",
            "description": "Failed to login to virsh console."
        },
		[... goes on for 100 events, by default ...]
        {
            "username": "unknown",
            "node": "ebd7dc",
            "hostname": "new-name",
            "id": 588442,
            "level": "WARNING",
            "created": "Tue, 27 Sep. 2022 20:39:22",
            "type": "Failed to query node's BMC",
            "description": "Failed to login to virsh console."
        }
    ],
    "next_uri": "/MAAS/api/2.0/events/?op=query&limit=5&after=588448",
    "prev_uri": "/MAAS/api/2.0/events/?op=query&limit=5&before=588442"
}
```

These listings can be very long and very hard to read.  You'll also notice that this particular MAAS has over 500,000 events, so parsing these logs by hand is certainly not practical.  There are two things you should do to make events easier to interpret:

- use the `jq` command, with some invocations we'll give you, to make neat tables out of your event lists.

- use the various filters -- supplied as part of the `events query` command -- to limit your output.

Let's explore both of these things in turn.

<a href="#heading--using-jq-with-events"><h4 id="heading--using-jq-with-events">Using jq with events</h4></a>

We offer a [more complete tutorial on jq](/t/using-jq-with-the-maas-cli/6027) in this documentation set, but for now, we can give you some invocations that will make events much easier to read.  Let's take our example command above and add some `jq` to it to make the output more readable:

```nohighlight
maas $PROFILE events query limit=20 \
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

This might give us output something like this:

```nohighlight
USERNAME  NODE    HOSTNAME       LEVEL    DATE                        TYPE                        EVENT
--------  ----    --------       -----    ----                        ----                        -----
unknown   ebd7dc  new-name       WARNING  Thu, 10 Mar. 2022 21:59:52  Failed to query node's BMC  Failed to login to virsh console.
unknown   mm3tc8  fair-marten    WARNING  Thu, 10 Mar. 2022 21:59:52  Failed to query node's BMC  Failed to login to virsh console.
unknown   pbpncx  ruling-bobcat  WARNING  Thu, 10 Mar. 2022 21:59:22  Failed to query node's BMC  Pod pbpncx: Failed to connect to the LXD REST API.
unknown   ebd7dc  new-name       WARNING  Thu, 10 Mar. 2022 21:54:34  Failed to query node's BMC  Failed to login to virsh console.
unknown   mm3tc8  fair-marten    WARNING  Thu, 10 Mar. 2022 21:54:34  Failed to query node's BMC  Failed to login to virsh console.
unknown   pbpncx  ruling-bobcat  WARNING  Thu, 10 Mar. 2022 21:54:05  Failed to query node's BMC  Pod pbpncx: Failed to connect to the LXD REST API.
unknown   ebd7dc  new-name       WARNING  Thu, 10 Mar. 2022 21:49:21  Failed to query node's BMC  Failed to login to virsh console.
unknown   mm3tc8  fair-marten    WARNING  Thu, 10 Mar. 2022 21:49:19  Failed to query node's BMC  Failed to login to virsh console.
unknown   pbpncx  ruling-bobcat  WARNING  Thu, 10 Mar. 2022 21:48:49  Failed to query node's BMC  Pod pbpncx: Failed to connect to the LXD REST API.
unknown   mm3tc8  fair-marten    WARNING  Thu, 10 Mar. 2022 21:44:08  Failed to query node's BMC  Failed to login to virsh console.
admin     ebd7dc  new-name       AUDIT    Thu, 09 Jun. 2022 21:39:54  Node                        Tagging 'new-name'.
unknown   pbpncx  contr-105      ERROR    Rack import error           Unable to import boot images: ('Connection broken: IncompleteRead(4096 bytes read)', IncompleteRead(4096 bytes read))
unknown   mm3tc8  fair-marten    WARNING  Thu, 10 Mar. 2022 21:38:50  Failed to query node's BMC  Failed to login to virsh console.
unknown   ebd7dc  contr-105      DEBUG    Thu, 12 May. 2022 21:38:26  Rack import info            Starting rack boot image import
unknown   pbpncx  ruling-bobcat  WARNING  Thu, 10 Mar. 2022 21:38:21  Failed to query node's BMC  Pod pbpncx: Failed to connect to the LXD REST API.
admin     pbpncx  ruling-bobcat  AUDIT    Thu, 16 Jun. 2022 21:35:16  Node                        Started commissioning on 'ruling-bobcat'.
unknown   mm3tc8  fair-marten    WARNING  Thu, 10 Mar. 2022 21:33:44  Failed to query node's BMC  Failed to login to virsh console.
unknown   pbpncx  ruling-bobcat  WARNING  Thu, 10 Mar. 2022 21:33:16  Failed to query node's BMC  Pod pbpncx: Failed to connect to the LXD REST API.
unknown   knpge8  bolla          INFO     Thu, 10 Mar. 2022 20:21:41  Ready                         
unknown   pbpncx  ruling-bobcat  WARNING  Thu, 10 Mar. 2022 18:01:47  Failed to query node's BMC  <LXDAPIException instance at 0x7f0b53e21dc0 with str error:\n Traceback (most recent call last):\n  File "/snap/maas/19076/usr/lib/python3/dist-packages/twisted/python/reflect.py", line 448, in safe_str\n    return str(o)\n  File "/snap/maas/19076/usr/lib/python3/dist-packages/pylxd/exceptions.py", line 18, in __str__\n    if self.response.status_code == 200:  # Operation failure\nAttributeError: 'LXDAPIException' object has no attribute 'status_code'\n>
```

You'll notice, in this listing, we have a mix of event types and responses.  In one case, the log even recorded a code exception.  You can probably see from this listing that events can be very helpful in tracking behaviours and resolving issues with your MAAS instance.  Even limited to 20 records, though, this output is still hard to parse, so let's explore ways to filter this table.

<a href="#heading--filter-parameters"><h4 id="heading--filter-parameters">Filter parameters</h4></a>

The `events query` command accepts several different filters, all of them optional:

- *hostname*: Only events relating to the node with the matching hostname will be returned. This can be specified multiple times to get events relating to more than one node.

- *mac_address*: Only nodes with matching MAC addresses will be returned. Note that MAC address is not part of the standard output, so you'd need to look it up elsewhere.

- *id*: Only nodes with matching system IDs will be returned.  This corresponds to the `node` parameter in the JSON listing, not the `id` parameter there, which is a serial event number.

- *zone*: Only nodes in the zone will be returned.  Note that zones are not part of the standard output, so you'd need to look these up elsewhere.

- *level*: The event level to capture.  You can choose from AUDIT, CRITICAL, DEBUG, ERROR, INFO, or WARNING.  The default is INFO.

- *limit*: Number of events to return. The default is 100, the maximum in one command is 1000.

- *before*: Defines an event id to start returning older events.  This is the "id" part of the JSON, not the system ID or "node".  Note that `before` and `after` cannot be used together, as the results are unpredictable.

- *after*: Defines an event id to start returning newer events.  This is the "id" part of the JSON, not the system ID or "node".  Note that `before` and `after` cannot be used together, as the results are unpredictable.

This list of filters gives us a few different ways to simplify the output.  Let's try some of these combinations on the sample data, above.

<a href="#heading--hostname-filter"><h4 id="heading--hostname-filter">Hostname, system ID, and MAC address filters</h4></a>

We can limit the hostname to, say, "new-name" by entering the following:

```nohighlight
maas $PROFILE events query limit=5 hostname=new-name\
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

This might give us the following output:

```nohighlight
USERNAME  NODE    HOSTNAME  LEVEL    DATE                        TYPE                        EVENT
--------  ----    --------  -----    ----                        ----                        -----
unknown   ebd7dc  new-name  WARNING  Tue, 27 Sep. 2022 21:41:37  Failed to query node's BMC  Failed to login to virsh console.
unknown   ebd7dc  new-name  WARNING  Tue, 27 Sep. 2022 21:36:22  Failed to query node's BMC  Failed to login to virsh console.
unknown   ebd7dc  new-name  WARNING  Tue, 27 Sep. 2022 21:31:22  Failed to query node's BMC  Failed to login to virsh console.
unknown   ebd7dc  new-name  WARNING  Tue, 27 Sep. 2022 21:26:07  Failed to query node's BMC  Failed to login to virsh console.
unknown   ebd7dc  new-name  WARNING  Tue, 27 Sep. 2022 21:21:07  Failed to query node's BMC  Failed to login to virsh console.
```

We would get similar results with this command, using the "id" filter:

```nohighlight
maas $PROFILE events query limit=5 id=ebd7dc\
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

We can also get similar results by looking up this machine's MAC address (52:54:00:32:8b:ea) and filtering by that parameter instead:

```nohighlight
maas $PROFILE events query limit=5 mac_address=52:54:00:32:8b:ea\
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

In this particular case, all three would yield identical outputs.

<a href="#heading--zone-filter"><h4 id="heading--zone-filter">Zone filter</h4></a>

We can look up one of the zones (using the Web UI or other CLI commands), and formulate a filter like this:

```nohighlight
maas $PROFILE events query limit=5 zone=twilight\
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

Note that this query yields slightly different records:

```nohighlight
USERNAME  NODE    HOSTNAME     LEVEL    DATE                        TYPE                        EVENT
--------  ----    --------     -----    ----                        ----                        -----
unknown   mm3tc8  fair-marten  WARNING  Tue, 27 Sep. 2022 21:52:07  Failed to query node's BMC  Failed to login to virsh console.
unknown   mm3tc8  fair-marten  WARNING  Tue, 27 Sep. 2022 21:46:52  Failed to query node's BMC  Failed to login to virsh console.
unknown   mm3tc8  fair-marten  WARNING  Tue, 27 Sep. 2022 21:41:37  Failed to query node's BMC  Failed to login to virsh console.
unknown   mm3tc8  fair-marten  WARNING  Tue, 27 Sep. 2022 21:36:22  Failed to query node's BMC  Failed to login to virsh console.
unknown   mm3tc8  fair-marten  WARNING  Tue, 27 Sep. 2022 21:31:22  Failed to query node's BMC  Failed to login to virsh console.
```

<a href="#heading--level-filter"><h4 id="heading--level-filter">Level filter</h4></a>

We can choose to look at specific events that match a logging level.  For example, we can repeat this command with `level=AUDIT`:

```nohighlight
maas $PROFILE events query limit=5 level=AUDIT\
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

This will yield dramatically different results:

```nohighlight
USERNAME  NODE    HOSTNAME       LEVEL  DATE                        TYPE  EVENT
--------  ----    --------       -----  ----                        ----  -----
admin     ebd7dc  new-name       AUDIT  Thu, 22 Sep. 2022 15:25:55  Node  Overrode failed testing on 'new-name'.
admin     87pnsc  solid-tick     AUDIT  Thu, 22 Sep. 2022 15:22:33  Node  Aborted 'commissioning' on 'solid-tick'.
admin     pbpncx  ruling-bobcat  AUDIT  Thu, 22 Sep. 2022 15:19:00  Node  Started commissioning on 'ruling-bobcat'.
admin     87pnsc  solid-tick     AUDIT  Thu, 22 Sep. 2022 15:18:59  Node  Started commissioning on 'solid-tick'.
zorkobob  mm3tc8  fair-marten    AUDIT  Wed, 21 Sep. 2022 14:21:25  Node  Tagging 'fair-marten'.
zorkobob  mm3tc8  fair-marten    AUDIT  Wed, 21 Sep. 2022 14:10:38  Node  Untagging 'fair-marten'.
```

In fact, there are several different levels associated with MAAS events:

- INFO: the default, used if no `level=` is specified; shows `INFO` and `ERROR` events.  A typical `INFO` event is "Ready", indicating that a machine has reached the "Ready" state.
- CRITICAL: critical MAAS failures; shows only `CRITICAL` events.  These events usually represent severe error conditions that should be immediately remedied.
- ERROR: MAAS errors; shows only `ERROR` events. Typical `ERROR` events include such things as power on/off failures, commissioning timeouts, and image import failures.
- WARNING: failures which may or may not affect MAAS performance; shows `WARNING` and `ERROR` events.  A typical warning event, for example, might include the inability to find and boot a machine.
- DEBUG: information which would help debug MAAS behaviour; shows `DEBUG` and `INFO` events.  Typical `DEBUG` events involve routine image import activities, for example.
- AUDIT: information which helps determine settings and user actions in MAAS; shows only `AUDIT` events.  They are [covered in more detail elsewhere](/t/understanding-maas-audit-events/6372).

<a href="#heading--combining-filters"><h4 id="heading--combining-filters">Combining filters</h4></a>

We can combine the `level` parameter with the `zone` parameter:

```nohighlight
maas $PROFILE events query limit=5 level=AUDIT zone=twilight\
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

This combination gives us a very different output:

```nohighlight
USERNAME     NODE    HOSTNAME     LEVEL  DATE                        TYPE  EVENT
--------     ----    --------     -----  ----                        ----  -----
bobslidell   7h3cw7  polong       AUDIT  Tue, 27 Sep. 2022 21:53:38  Node  Set the zone to 'twilight' on 'polong'.
theotherbob  8r6pw7  karura       AUDIT  Tue, 27 Sep. 2022 21:53:34  Node  Set the zone to 'twilight' on 'karura'.
miltwaddams  mm3tc8  fair-marten  AUDIT  Wed, 21 Sep. 2022 14:21:25  Node  Tagging 'fair-marten'.
mikebolton   mm3tc8  fair-marten  AUDIT  Wed, 21 Sep. 2022 14:10:38  Node  Untagging 'fair-marten'.
admin        8r6pw7  karura       AUDIT  Wed, 21 Sep. 2022 14:00:47  Node  Untagging 'karura'.
```

These various filters can be combined, and even repeated as necessary:

```nohighlight
$ maas $PROFILE events query level=AUDIT hostname=karura hostname=polong limit=5 \
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

Again, this combination gives us a different view of the event data:

```nohighlight
USERNAME    NODE    HOSTNAME  LEVEL  DATE                        TYPE  EVENT
--------    ----    --------  -----  ----                        ----  -----
stormrider  7h3cw7  polong    AUDIT  Tue, 27 Sep. 2022 21:53:38  Node  Set the zone to 'twilight' on 'polong'.
stormrider  8r6pw7  karura    AUDIT  Tue, 27 Sep. 2022 21:53:34  Node  Set the zone to 'twilight' on 'karura'.
admin       8r6pw7  karura    AUDIT  Wed, 21 Sep. 2022 14:00:47  Node  Untagging 'karura'.
admin       8r6pw7  karura    AUDIT  Wed, 21 Sep. 2022 14:00:01  Node  Tagging 'karura'.
admin       8r6pw7  karura    AUDIT  Wed, 21 Sep. 2022 13:58:11  Node  Untagging 'karura'.
```

<a href="#heading--limit-filter"><h4 id="heading--limit-filter">The limit filter</h4></a>

You can use the `limit` filter to restrict the number of records listed, as we have been doing in many of the examples above.  We can expand the last example to `limit=7`, for instance:

```nohighlight
$ maas $PROFILE events query level=AUDIT hostname=karura hostname=polong limit=7 \
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

This gives us a slightly longer list:

```nohighlight
USERNAME    NODE    HOSTNAME  LEVEL  DATE                        TYPE  EVENT
--------    ----    --------  -----  ----                        ----  -----
stormrider  7h3cw7  polong    AUDIT  Tue, 27 Sep. 2022 21:53:38  Node  Set the zone to 'twilight' on 'polong'.
stormrider  8r6pw7  karura    AUDIT  Tue, 27 Sep. 2022 21:53:34  Node  Set the zone to 'twilight' on 'karura'.
admin       8r6pw7  karura    AUDIT  Wed, 21 Sep. 2022 14:00:47  Node  Untagging 'karura'.
admin       8r6pw7  karura    AUDIT  Wed, 21 Sep. 2022 14:00:01  Node  Tagging 'karura'.
admin       8r6pw7  karura    AUDIT  Wed, 21 Sep. 2022 13:58:11  Node  Untagging 'karura'.
admin       8r6pw7  karura    AUDIT  Wed, 21 Sep. 2022 13:57:48  Node  Tagging 'karura'.
admin       7h3cw7  polong    AUDIT  Tue, 13 Sep. 2022 14:14:24  Node  Powered on 'polong'.
```

<a href="#heading--before-and-after-filters"><h4 id="heading--before-and-after-filters">The before and after filters</h4></a>

Let's suppose that we want to repeat the query in the last example, but we want to start from the beginning of the event log (whenever that might have been).  We could modify the above command to something like this:

```nohighlight
$ maas $PROFILE events query level=AUDIT hostname=karura hostname=polong after=0 limit=7 \
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

This would give us a different view:

```nohighlight
USERNAME  NODE    HOSTNAME  LEVEL  DATE                        TYPE  EVENT
--------  ----    --------  -----  ----                        ----  -----
ed        8r6pw7  karura    AUDIT  Tue, 12 Jul. 2022 15:08:27  Node  Powered on 'karura'.
ed        8r6pw7  karura    AUDIT  Tue, 12 Jul. 2022 15:08:23  Node  Powered on 'karura'.
ed        8r6pw7  karura    AUDIT  Tue, 12 Jul. 2022 15:08:08  Node  Powered off 'karura'.
admin     8r6pw7  karura    AUDIT  Thu, 23 Jun. 2022 23:26:53  Node  Set the zone to 'asd' on 'karura'.
peter     8r6pw7  karura    AUDIT  Fri, 22 Apr. 2022 08:06:59  Node  Powered off 'karura'.
peter     8r6pw7  karura    AUDIT  Fri, 22 Apr. 2022 07:09:55  Node  Powered on 'karura'.
ed        7h3cw7  polong    AUDIT  Thu, 27 Jan. 2022 14:34:34  Node  Powered on 'polong'.
```

We could also retrieve very recent records using "before":

```nohighlight
$ maas $PROFILE events query level=AUDIT before=500000 limit=7 \
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

This would return:

```nohighlight
USERNAME  NODE    HOSTNAME     LEVEL  DATE                        TYPE  EVENT
--------  ----    --------     -----  ----                        ----  -----
peter     8r6pw7  karura       AUDIT  Fri, 22 Apr. 2022 08:06:59  Node  Powered off 'karura'.
peter     8r6pw7  karura       AUDIT  Fri, 22 Apr. 2022 07:09:55  Node  Powered on 'karura'.
admin     ebd7dc  new-name     AUDIT  Thu, 14 Apr. 2022 02:24:02  Node  Aborted 'commissioning' on 'new-name'.
admin     ebd7dc  new-name     AUDIT  Thu, 14 Apr. 2022 02:23:44  Node  Started commissioning on 'new-name'.
ed        mm3tc8  fair-marten  AUDIT  Fri, 08 Apr. 2022 11:02:15  Node  Untagging 'fair-marten'.
ed        mm3tc8  fair-marten  AUDIT  Fri, 08 Apr. 2022 11:02:14  Node  Tagging 'fair-marten'.
admin     mm3tc8  fair-marten  AUDIT  Fri, 11 Feb. 2022 11:00:00  Node  Set the zone to 'twilight' on 'fair-marten'.
```

<a href="#heading--Using-different-event-levels"><h3 id="heading--Using-different-event-levels">Using different event levels</h3></a>

As mentioned earlier, the `AUDIT` events are [discussed elsewhere](/t/understanding-maas-audit-events/6372).  It may be useful, though to take a closer look at the other event levels here.

<a href="#heading--INFO-and-DEBUG-events"><h4 id="heading--INFO-and-DEBUG-events">INFO and DEBUG events</h4></a>

We walked the MAAS machine `fun-zebra` through the following states:

- Commissioning
- Allocation
- Deployment
- Releasing
- Testing (with a premature manual abort)
- Rescue mode

The resulting `level=INFO` and `level=DEBUG` event sets are enlightening.

<details><summary>The raw log output, for reference only.</summary>

```nohighlight
maas.log:2022-09-29T15:00:16.461402-05:00 neuromancer maas.interface: [info] eth0 (physical) on fun-zebra: IP address automatically unlinked: None:type=AUTO
maas.log:2022-09-29T15:00:16.553396-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from NEW to COMMISSIONING
maas.log:2022-09-29T15:00:16.754265-05:00 neuromancer maas.power: [info] Changing power state (on) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T15:00:16.759676-05:00 neuromancer maas.node: [info] fun-zebra: Commissioning started
maas.log:2022-09-29T15:00:18.039441-05:00 neuromancer maas.power: [info] Changed power state (on) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T15:03:26.946507-05:00 neuromancer maas.node: [info] fun-zebra: Storage layout was set to flat.
maas.log:2022-09-29T15:04:07.795515-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from COMMISSIONING to TESTING
maas.log:2022-09-29T15:04:17.288763-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from TESTING to READY
maas.log:2022-09-29T16:14:21.778320-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from READY to ALLOCATED
maas.log:2022-09-29T16:14:21.793566-05:00 neuromancer maas.node: [info] fun-zebra: allocated to user case
maas.log:2022-09-29T16:14:27.662829-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from ALLOCATED to DEPLOYING
maas.log:2022-09-29T16:14:31.019526-05:00 neuromancer maas.power: [info] Changing power state (on) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:14:32.334589-05:00 neuromancer maas.power: [info] Changed power state (on) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:22:41.935983-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from DEPLOYING to DEPLOYED
maas.log:2022-09-29T16:23:37.084128-05:00 neuromancer maas.node: [info] fun-zebra: Releasing node
maas.log:2022-09-29T16:23:37.085876-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from DEPLOYED to RELEASING
maas.log:2022-09-29T16:23:37.196437-05:00 neuromancer maas.power: [info] Changing power state (off) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:23:38.546649-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from RELEASING to READY
maas.log:2022-09-29T16:23:38.591042-05:00 neuromancer maas.power: [info] Changed power state (off) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:23:51.876495-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from READY to TESTING
maas.log:2022-09-29T16:23:51.997139-05:00 neuromancer maas.power: [info] Changing power state (on) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:23:52.001167-05:00 neuromancer maas.node: [info] fun-zebra: Testing starting
maas.log:2022-09-29T16:23:53.291863-05:00 neuromancer maas.power: [info] Changed power state (on) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:26:14.607386-05:00 neuromancer maas.power: [info] Changing power state (off) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:26:14.622643-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from TESTING to READY
maas.log:2022-09-29T16:26:14.678433-05:00 neuromancer maas.node: [info] fun-zebra: Testing aborted, stopping node
maas.log:2022-09-29T16:26:16.051940-05:00 neuromancer maas.power: [info] Changed power state (off) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:26:23.081533-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from READY to ENTERING_RESCUE_MODE
maas.log:2022-09-29T16:26:23.160687-05:00 neuromancer maas.power: [info] Changing power state (cycle) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:26:23.163274-05:00 neuromancer maas.node: [info] fun-zebra: Rescue mode starting
maas.log:2022-09-29T16:26:24.528007-05:00 neuromancer maas.power: [info] Changed power state (on) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:28:58.268558-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from ENTERING_RESCUE_MODE to RESCUE_MODE
maas.log:2022-09-29T16:29:52.204837-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from RESCUE_MODE to EXITING_RESCUE_MODE
maas.log:2022-09-29T16:29:52.323798-05:00 neuromancer maas.power: [info] Changing power state (off) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:29:53.708975-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from EXITING_RESCUE_MODE to READY
maas.log:2022-09-29T16:29:53.745776-05:00 neuromancer maas.power: [info] Changed power state (off) of node: fun-zebra (bk7mg8)
maas.log:2022-09-29T16:32:20.147958-05:00 neuromancer maas.node: [info] fun-zebra: moved from default zone to new-zone zone.
regiond.log:2022-09-29 20:00:16 maasserver.models.signals.interfaces: [info] eth0 (physical) on fun-zebra: deleted IP addresses due to VLAN update (5001 -> 5002).
regiond.log:2022-09-29 20:00:32 maasserver.region_controller: [info] Reloaded DNS configuration; ip 10.103.114.192 connected to fun-zebra on eth0
regiond.log:2022-09-29 20:01:09 maasserver.rpc.leases: [info] Lease update: commit for 10.103.114.192 on 0:16:3e:a2:73:5c at 2022-09-29 20:01:09 (lease time: 600s) (hostname: fun-zebra)
regiond.log:2022-09-29 20:01:14 maasserver.region_controller: [info] Reloaded DNS configuration; ip 10.103.114.192 connected to fun-zebra on eth0
regiond.log:     * node fun-zebra renamed interface eth0 to enp5s0
regiond.log:     * ip 10.103.114.192 connected to fun-zebra on eth0
regiond.log:     * ip 10.103.114.192 disconnected from fun-zebra on eth0
regiond.log:2022-09-29 21:15:31 maasserver.rpc.leases: [info] Lease update: commit for 10.103.114.2 on 0:16:3e:a2:73:5c at 2022-09-29 21:15:31 (lease time: 600s) (hostname: fun-zebra)
regiond.log:2022-09-29 21:21:48 maasserver.models.node: [info] fun-zebra: Turning off netboot for node
regiond.log:2022-09-29 21:22:41 metadataserver: [info] No user data registered for node named fun-zebra
regiond.log:2022-09-29 21:23:37 maasserver.models.node: [info] fun-zebra: Turning on netboot for node
regiond.log:2022-09-29 21:23:37 maasserver.models.node: [info] fun-zebra: Turning ephemeral deploy off for node
regiond.log:2022-09-29 21:24:06 maasserver.region_controller: [info] Reloaded DNS configuration; ip 10.103.114.192 connected to fun-zebra on enp5s0
regiond.log:2022-09-29 21:24:43 maasserver.rpc.leases: [info] Lease update: commit for 10.103.114.192 on 0:16:3e:a2:73:5c at 2022-09-29 21:24:43 (lease time: 600s) (hostname: fun-zebra)
regiond.log:2022-09-29 21:24:46 maasserver.region_controller: [info] Reloaded DNS configuration; ip 10.103.114.192 connected to fun-zebra on enp5s0
regiond.log:2022-09-29 21:27:18 maasserver.rpc.leases: [info] Lease update: commit for 10.103.114.192 on 0:16:3e:a2:73:5c at 2022-09-29 21:27:18 (lease time: 600s) (hostname: fun-zebra)
```
</details>

First, let's try this command:

```nohighlight
 maas $PROFILE events query level=INFO hostname=fun-zebra limit=1000 | jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | (., map(length*"-"))),(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) | @tsv' | column -t -s$'\t'
 ```
 
 This will yield a surprisingly compact report:
 
 ```nohighlight
 USERNAME  NODE    HOSTNAME   LEVEL  DATE                        TYPE                   EVENT
--------  ----    --------   -----  ----                        ----                   -----
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:29:53  Exited rescue mode     
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:29:52  Powering off           
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:28:58  Rescue mode            
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:27:18  Loading ephemeral      
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:26:40  Performing PXE boot    
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:26:23  Power cycling          
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:26:23  Entering rescue mode   
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:26:14  Powering off           
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:26:14  Aborted testing        
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:24:08  Performing PXE boot    
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:23:51  Powering on            
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:23:51  Testing                
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:23:38  Released               
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:23:37  Powering off           
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:23:37  Releasing              
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:22:41  Deployed               
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:21:49  Rebooting              
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:18:42  Configuring OS         
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:17:42  Installing OS          
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:17:30  Configuring storage    
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:15:31  Loading ephemeral      
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:14:48  Performing PXE boot    
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:14:31  Powering on            
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:14:27  Deploying              
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:04:17  Ready                  
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:04:07  Running test           smartctl-validate on sda
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:01:27  Gathering information  
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:01:10  Loading ephemeral      
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:00:35  Performing PXE boot    
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:00:16  Powering on            
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:00:16  Commissioning          
 ```
 
Note that most of the `INFO` events are either machine life-cycle events or key operations within those state changes, such as `Loading ephemeral` after a PXE boot.  `DEBUG` events, on the other hand, include `INFO` events for reference, but provide a much more extensive report of individual actions within each state change.  For instance, here is just the snippet of `DEBUG` information for the host's exit from rescue mode:

```nohighlight
USERNAME  NODE    HOSTNAME   LEVEL  DATE                        TYPE                              EVENT
--------  ----    --------   -----  ----                        ----                              -----
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:29:53  Node powered off                  
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:29:53  Node changed status               From 'Exiting rescue mode' to 'Ready'
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:29:53  Exited rescue mode                
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:58  Node status event                 'cloudinit' running config-power-state-change with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:58  Node status event                 'cloudinit' running config-final-message with frequency always
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:58  Node status event                 'cloudinit' running config-phone-home with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:58  Node status event                 'cloudinit' running config-install-hotplug with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:58  Node status event                 'cloudinit' running config-keys-to-console with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:58  Node status event                 'cloudinit' running config-ssh-authkey-fingerprints with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-scripts-user with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-scripts-per-instance with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-scripts-per-boot with frequency always
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-scripts-per-once with frequency once
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-scripts-vendor with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-rightscale_userdata with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-refresh_rmc_and_interface with frequency always
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-reset_rmc with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-salt-minion with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-mcollective with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-chef with frequency always
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-puppet with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-write-files-deferred with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-ubuntu-drivers with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-lxd with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-landscape with frequency once-per-instance
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:28:57  Node status event                 'cloudinit' running config-fan with frequency once-per-instance
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:29:52  Powering off                      
unknown   bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:29:52  Node changed status               From 'Rescue mode' to 'Exiting rescue mode'
case      bk7mg8  fun-zebra  DEBUG  Thu, 29 Sep. 2022 21:29:52  User stopping rescue mode         (case)
```

Notice the detailed `cloudinit` actions necessary to change the machine's state.  The other state changes have similarly detailed outputs in `DEBUG`.

<a href="#heading--ERROR-and-WARNING-events"><h4 id="heading--ERROR-and-WARNING-events">ERROR and WARNING events</h4></a>

Here are a few representative `ERROR` event descriptions taken from a live MAAS machine:

```nohighlight
Node has not been heard from for the last 30 minutes
Node operation 'Commissioning' timed out after 30 minutes.
Unable to import boot images: HTTPConnectionPool(host='localhost', port=5240): Read timed out.
Node operation 'Testing' timed out after 30 minutes.
Power on for the node failed: Failed talking to node's BMC: Failed to login to virsh console.
Unable to import boot images: Invalid sha256 Checksum at http://localhost:5240/MAAS/images-stream/ubuntu/amd64/ga-18.04-lowlatency/bionic/20200206/boot-initrd. Found 834c0eacb1a19526f715f9947bd47904b18ad8c733b0762e690edf6143e10561. Expected addfa86d7c054bd0dc085333ad2850e93223d511d04b59ee516d42d801522324. read 38 bytes expected 61715624 bytes. (size 38 expected 61715624)
``` 

Notice that these `ERROR` events flag failures that are probably going to prevent MAAS from operating properly.  Changing the level to `WARNING` picks up all `ERROR` events, but also includes warnings such as this one:

```nohighlight
Finished importing boot images, the region does not have any boot images available.
```

`WARNINGS` tend to be failures, as well, but failures which are more easily fixed (such as having not successfully downloaded any images).

<a href="#heading--CRITICAL-errors"><h4 id="heading--CRITICAL-errors">CRITICAL errors</h4></a>

`CRITICAL` errors represent major failures, often code failures or trace-backs.  Any `CRITICAL` errors should be immediately examined and resolved, if possible, and [reported as a bug](/t/how-to-report-a-bug/4446) if not resolvable.

<a href="#heading--About-MAAS-audit-events"><h2 id="heading--About-MAAS-audit-events">About MAAS audit events</h2></a>

An audit event is a [MAAS event](/t/understanding-maas-events/6373) tagged with `AUDIT`. It captures changes to the MAAS configuration and machine states. These events provide valuable oversight of user actions and automated updates -- and their effects -- especially when multiple users are interacting with multiple machines.  See [Understanding MAAS events](/t/understanding-maas-events/6373) for basic usage of the CLI `events query` command.

<a href="#heading--Viewing-events"><h3 id="heading--Viewing-events">Viewing events</h3></a>

Audit events are examined using the MAAS CLI with the `level=AUDIT` parameter set:

```nohighlight
$ maas $PROFILE events query level=AUDIT
```

You can use `jq` to prettify the output:

```nohighlight
$ maas $PROFILE events query level=AUDIT after=0 limit=20 \
| jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This command might produce output similar to this:

```nohighlight
USERNAME  HOSTNAME     DATE                        EVENT
--------  --------     ----                        -----
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 2 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 0 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  block device sda was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  interface enp5s0 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  0 bytes of memory was removed on node 8wmfx3
admin     valued-moth  Thu, 21 Apr. 2022 19:36:48  Started deploying 'valued-moth'.
admin     valued-moth  Thu, 21 Apr. 2022 19:36:21  Acquired 'valued-moth'.
admin     unknown      Thu, 21 Apr. 2022 19:21:46  Updated configuration setting 'completed_intro' to 'True'.
admin     unknown      Thu, 21 Apr. 2022 19:20:49  Updated configuration setting 'upstream_dns' to '8.8.8.8'.
admin     unknown      Thu, 21 Apr. 2022 19:20:49  Updated configuration setting 'maas_name' to 'neuromancer'.
admin     unknown      Thu, 21 Apr. 2022 19:20:47  Updated configuration setting 'http_proxy' to ''.
admin     unknown      Thu, 21 Apr. 2022 19:20:24  Logged in admin.
```

You can also use the [various event filters](/t/understanding-maas-events/6373#heading--filter-parameters) with `level=AUDIT` to further restrict your output.

<a href="#heading--The-meaning-of-audit-events"><h4 id="heading--The-meaning-of-audit-events">The meaning of audit events</h4></a>

Let's walk through a sample of, say, eighteen audit events and see how to interpret and use them.  

```nohighlight
maas $PROFILE events query level=AUDIT limit=18 after=0 | jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

Consider the resulting `jq` output:

```nohighlight
USERNAME     NODE    HOSTNAME       LEVEL  DATE                        TYPE  EVENT
--------     ----    --------       -----  ----                        ----  -----
admin        mm3tc8  fair-marten    AUDIT  Tue, 30 Nov. 2021 09:14:02  Node  Set the zone to 'danger' on 'fair-marten'.
admin        ebd7dc  new-name       AUDIT  Tue, 30 Nov. 2021 09:14:02  Node  Set the zone to 'danger' on 'new-name'.
admin        pbpncx  ruling-bobcat  AUDIT  Tue, 30 Nov. 2021 09:13:52  Node  Set the zone to 'default' on 'ruling-bobcat'.
admin        mm3tc8  fair-marten    AUDIT  Tue, 30 Nov. 2021 09:13:52  Node  Set the zone to 'default' on 'fair-marten'.
admin        ebd7dc  new-name       AUDIT  Tue, 30 Nov. 2021 09:13:52  Node  Set the zone to 'default' on 'new-name'.
admin        mm3tc8  fair-marten    AUDIT  Tue, 30 Nov. 2021 09:11:56  Node  Started commissioning on 'fair-marten'.
admin        ebd7dc  new-name       AUDIT  Tue, 30 Nov. 2021 09:11:55  Node  Started commissioning on 'new-name'.
admin        ebd7dc  new-name       AUDIT  Tue, 30 Nov. 2021 09:09:06  Node  Marked 'new-name' broken.
admin        ebd7dc  new-name       AUDIT  Tue, 30 Nov. 2021 07:51:31  Node  Started commissioning on 'new-name'.
admin        mm3tc8  fair-marten    AUDIT  Tue, 30 Nov. 2021 06:07:03  Node  Started commissioning on 'fair-marten'.
admin        ebd7dc  active-amoeba  AUDIT  Tue, 23 Nov. 2021 08:01:10  Node  Started commissioning on 'active-amoeba'.
admin        ebd7dc  active-amoeba  AUDIT  Tue, 23 Nov. 2021 08:00:47  Node  Marked 'active-amoeba' broken.
admin        pbpncx  ruling-bobcat  AUDIT  Wed, 17 Nov. 2021 00:04:51  Node  Started deploying 'ruling-bobcat'.
admin        ebd7dc  active-amoeba  AUDIT  Mon, 15 Nov. 2021 05:39:48  Node  Set the resource pool to 'default' on 'active-amoeba'.
admin        ebd7dc  active-amoeba  AUDIT  Mon, 08 Nov. 2021 04:07:44  Node  Started testing on 'active-amoeba'.
admin        ebd7dc  active-amoeba  AUDIT  Mon, 08 Nov. 2021 04:05:40  Node  Marked 'active-amoeba' broken.
admin        knpge8  bolla          AUDIT  Wed, 16 Jun. 2021 04:35:50  Node  Started importing images on 'bolla'.
admin        knpge8  bolla          AUDIT  Wed, 10 Jun. 2020 21:07:40  Node  Set the zone to 'danger' on 'bolla'.
```

All of these example events are type `Node`, referring to a machine actions.  Node events are probably the most important audit events, because they capture machine life-cycle changes.  When auditing your MAAS, life-cycle events are often the most useful.

Take a moment to consider the MAAS life-cycle, which can be depicted with this state table:

| Machine state | Cm | Aq | Dp | Rl | Ab | Cl | PC | Ts | Rsq | Bk | Lk | Fx | Tg | RP | SZ | Del |
|---------------|----|----|----|----|----|----|----|----|-----|----|----|----|----|----|----|-----|
| New           | Y  |    |    |    |    |    | Y  | Y  | Y   |    |    |    | Y  | Y  | Y  | Y   |
| Failed        | Y  |    |    |    |    |    |    | Y  | Y   | Y  |    |    | Y  | Y  | Y  | Y   |
| Commissioning |    |    |    |    | Y  |    |    |    |     | Y  |    |    | Y  | Y  | Y  |     |
| Ready         | Y  | Y  | Y  |    |    | Y  |    | Y  | Y   | Y  |    |    | Y  | Y  | Y  | Y   |
| Acquired      | Y  |    | Y  | Y  |    |    |    | Y  | Y   | Y  |    |    | Y  | Y  | Y  | Y   |
| Deploying     |    |    |    | Y  | Y  |    | Y  |    |     |    | Y  |    | Y  | Y  | Y  | Y   |
| Deployed      |    |    |    | Y  |    |    | Y  | Y  | Y   | Y  | Y  |    | Y  | Y  | Y  | Y   |
| Broken        | Y  |    |    |    |    |    | Y  | Y  | Y   |    |    | Y  | Y  | Y  | Y  | Y   |
| Rescue mode   |    |    |    |    |    |    |    |    | X   |    |    |    | Y  | Y  | Y  | Y   |

The key for the table columns is as follows:

- *Cm* - can commission.
- *Aq* - can acquire.
- *Dp* - can deploy.
- *Rl* - can release.
- *Ab* - can abort an operation in progress.
- *Cl* - can clone the machine.
- *PC* - can power-cycle the machine (turn in on or off).
- *Ts* - can run tests on the machine.
- *Rsq* - can put the machine in Rescue Mode.
- *Bk* - can mark the machine as broken.
- *Lk* - can lock the machine, preventing others from accessing it.
- *Fx* - can move a broken machine to a fixed state.
- *Tg* - can set tags for a machine.
- *RP* - can set the resource pool for a machine.
- *SZ* - can set the zone for a machine.
- *Del* - can delete the machine.

<a href="#heading--Using-audit-events-to-find-out-what-happened"><h4 id="heading--Using-audit-events-to-find-out-what-happened">Using audit events to find out what happened</h4></a>

Consider these example events that audit state changes:

```nohighlight
ID      LEVEL  TYPE           USERNAME  DESCRIPTION
=================================================================================================
589317  AUDIT  Node           bruce     Marked 'ruling-bobcat' broken.
583324  AUDIT  Node           clark     Tagging 'fair-marten'.
583313  AUDIT  Node           clark     Untagging 'fair-marten'.
584190  AUDIT  Node           diana     Overrode failed testing on 'new-name'.
529870  AUDIT  Node           kara      Powered on 'karura'.
529868  AUDIT  Node           kara      Powered off 'karura'.
435099  AUDIT  Node           barry     Set the zone to 'twilight' on 'fair-marten'.
435097  AUDIT  Node           hal       Acquired 'fair-marten'.
430453  AUDIT  Node           jonn      Started testing on 'fair-marten'.
430449  AUDIT  Node           jonn      Marked 'fair-marten' broken.
430445  AUDIT  Node           clark     Aborted 'testing' on 'fair-marten'.
427583  AUDIT  Node           diana     Set the resource pool to 'default' on 'fair-marten'.
426354  AUDIT  Node           bruce     Started commissioning on 'fair-marten'.
423257  AUDIT  Node           kara      Aborted 'commissioning' on 'fair-marten'.
421915  AUDIT  Node           joanna    Started releasing 'ruling-bobcat'.
28471   AUDIT  Settings       natasha   Updated DHCP snippet 'foo'.
28470   AUDIT  Settings       tony      Created DHCP snippet 'foo'.
28465   AUDIT  Settings       bruce2    Saved script 'setup.sh'.
28464   AUDIT  Settings       hank      Updated configuration setting 'enable_third_party_drivers' to 'False'.
8518    AUDIT  Node           kitty     Acquired 'sweet-krill'.
7615    AUDIT  Node           barry     Deleted the 'machine' 'new-bedbug'.
6238    AUDIT  Node           jonn      Started rescue mode on 'fleet-calf'.
5920    AUDIT  Node           diana     Started deploying 'comic-muskox'.
5907    AUDIT  Authorisation  admin     Logged out admin.
5906    AUDIT  Authorisation  admin     Logged in admin.
5896    AUDIT  Authorisation  hank      Created user 'zorko'.
3944    AUDIT  Node           clark     Deleted the 'machine' 'sweet-urchin'.
```

This is a long (but varied) listing, so there are many questions you might be able to answer:

1. Who deployed `comic-muskox`? 

2. What happened to `sweet-urchin`?

3. Why is `fleet-calf` in rescue mode?

4. Where did these changes come from in `setup.sh`?

5. What caused `ruling-bobcat` to be marked as broken?

6. Who's responsible for the DHCP snippet called `foo`?

Audit events don't answer all questions, but they help you discover whom to ask.

<a href="#heading--Auditing-with-finesse"><h4 id="heading--Auditing-with-finesse">Auditing with finesse</h4></a>

You can use the MAAS CLI, `jq`, and command line text tools to finesse your auditing.  First, you'll have to get a feel for how MAAS describes audit events:

- Set the resource pool to 
- Started commissioning 
- Aborted 'commissioning'
- Started releasing 
- Created DHCP snippet
- Saved script 
- Updated configuration setting 
- Deleted the 'machine' 
- Created user

You can use these snippets as search keys.  Say you walk into the data centre one day and a couple of machines just aren't there any more.  You could run this command:

```nohighlight
$ maas $PROFILE events query limit=1000 after=0 level=AUDIT \
hostname=new-bedbug hostname=sweet-urchin \
| jq -r '(.events[] | [.id,.level,.type,.username,.description]) 
| @tsv' | column -t -s$'\t' \
| grep "Deleted the"
```

Within 30 seconds, you'd know whom to ask:

```nohighlight
7615    AUDIT  Node  barry     Deleted the 'machine' 'new-bedbug'.
3944    AUDIT  Node  clark     Deleted the 'machine' 'sweet-urchin'.
```
Or, you could just check to see what's been deleted:

```nohighlight
33315  AUDIT  Node           Deleted the 'machine' 'keen-lab'.
33314  AUDIT  Node           Deleted the 'machine' 'helloooo'.
31179  AUDIT  Node           Deleted the 'machine' 'firm-ghost'.
31178  AUDIT  Node           Deleted the 'machine' 'proper-troll'.
31177  AUDIT  Node           Deleted the 'machine' 'steady-mammal'.
31176  AUDIT  Node           Deleted the 'machine' 'wired-dove'.
31175  AUDIT  Node           Deleted the 'machine' 'wanted-fox'.
31174  AUDIT  Node           Deleted the 'machine' 'picked-cub'.
31173  AUDIT  Node           Deleted the 'machine' 'claudio'.
31172  AUDIT  Node           Deleted the 'machine' 'next-mullet'.
31171  AUDIT  Node           Deleted the 'machine' 'happy-bengal'.
31170  AUDIT  Node           Deleted the 'machine' 'grown-hawk'.
31169  AUDIT  Node           Deleted the 'machine' 'new-bedbug'.
31168  AUDIT  Node           Deleted the 'machine' 'native-moray'.
31167  AUDIT  Node           Deleted the 'machine' 'fleet-calf'.
31166  AUDIT  Node           Deleted the 'machine' 'daring-ewe'.
31165  AUDIT  Node           Deleted the 'machine' 'sweet-urchin'.
31164  AUDIT  Node           Deleted the 'machine' 'new-chimp'.
31163  AUDIT  Node           Deleted the 'machine' 'humble-bug'.
31162  AUDIT  Node           Deleted the 'machine' 'modern-mutt'.
31161  AUDIT  Node           Deleted the 'machine' 'nice-skink'.
31160  AUDIT  Node           Deleted the 'machine' 'choice-worm'.
31159  AUDIT  Node           Deleted the 'machine' 'wanted-turtle'.
31158  AUDIT  Node           Deleted the 'machine' 'neat-yak'.
31157  AUDIT  Node           Deleted the 'machine' 'superb-piglet'.
31156  AUDIT  Node           Deleted the 'machine' 'rare-ghost'.
31155  AUDIT  Node           Deleted the 'machine' 'unique-weevil'.
31154  AUDIT  Node           Deleted the 'machine' 'finer-akita'.
31153  AUDIT  Node           Deleted the 'machine' 'cool-dog'.
31152  AUDIT  Node           Deleted the 'machine' 'meet-snake'.
31151  AUDIT  Node           Deleted the 'machine' 'native-civet'.
31150  AUDIT  Node           Deleted the 'machine' 'top-burro'.
31149  AUDIT  Node           Deleted the 'machine' 'pro-boa'.
31148  AUDIT  Node           Deleted the 'machine' 'fine-dane'.
31147  AUDIT  Node           Deleted the 'machine' 'clean-ocelot'.
31146  AUDIT  Node           Deleted the 'machine' 'boss-crab'.
31145  AUDIT  Node           Deleted the 'machine' 'crisp-mammal'.
31144  AUDIT  Node           Deleted the 'machine' 'active-panda'.
31143  AUDIT  Node           Deleted the 'machine' 'fit-ram'.
31142  AUDIT  Node           Deleted the 'machine' 'strong-prawn'.
31141  AUDIT  Node           Deleted the 'machine' 'equal-dog'.
31140  AUDIT  Node           Deleted the 'machine' 'sure-kid'.
31139  AUDIT  Node           Deleted the 'machine' 'choice-wren'.
31138  AUDIT  Node           Deleted the 'machine' 'eager-whale'.
31137  AUDIT  Node           Deleted the 'machine' 'fun-boxer'.
31136  AUDIT  Node           Deleted the 'machine' 'clean-filly'.
31135  AUDIT  Node           Deleted the 'machine' 'thingthing'.
31134  AUDIT  Node           Deleted the 'machine' 'prime-walrus'.
28073  AUDIT  Node           Deleted the 'machine' 'ace-boxer'.
28072  AUDIT  Node           Deleted the 'machine' 'active-panda'.
28071  AUDIT  Node           Deleted the 'machine' 'boss-crab'.
24724  AUDIT  Node           Deleted the 'machine' 'ruling-marlin'.
24723  AUDIT  Node           Deleted the 'machine' 'sweet-urchin'.
24722  AUDIT  Node           Deleted the 'machine' 'new-chimp'.
24721  AUDIT  Node           Deleted the 'machine' 'humble-bug'.
24720  AUDIT  Node           Deleted the 'machine' 'next-mullet'.
24719  AUDIT  Node           Deleted the 'machine' 'native-moray'.
24718  AUDIT  Node           Deleted the 'machine' 'grown-hawk'.
24717  AUDIT  Node           Deleted the 'machine' 'happy-bengal'.
24716  AUDIT  Node           Deleted the 'machine' 'picked-cub'.
24715  AUDIT  Node           Deleted the 'machine' 'claudio'.
24714  AUDIT  Node           Deleted the 'machine' 'fleet-calf'.
24713  AUDIT  Node           Deleted the 'machine' 'new-bedbug'.
24712  AUDIT  Node           Deleted the 'machine' 'daring-ewe'.
24711  AUDIT  Node           Deleted the 'machine' 'huge-yeti'.
24502  AUDIT  Node           Deleted the 'machine' 'guided-joey'.
24501  AUDIT  Node           Deleted the 'machine' 'active-adder'.
24500  AUDIT  Node           Deleted the 'machine' 'crisp-chow'.
24499  AUDIT  Node           Deleted the 'machine' 'holy-hippo'.
24498  AUDIT  Node           Deleted the 'machine' 'eager-kid'.
24497  AUDIT  Node           Deleted the 'machine' 'mighty-finch'.
24496  AUDIT  Node           Deleted the 'machine' 'native-koala'.
24415  AUDIT  Node           Deleted the 'machine' 'me'.
24410  AUDIT  Node           Deleted the 'machine' 'you'.
17934  AUDIT  Node           Deleted the 'machine' 'carol'.
17933  AUDIT  Node           Deleted the 'machine' 'bob'.
17932  AUDIT  Node           Deleted the 'machine' 'aaa'.
17931  AUDIT  Node           Deleted the 'machine' 'alice'.
17604  AUDIT  Node           Deleted the 'machine' 'subtle-lark'.
17603  AUDIT  Node           Deleted the 'machine' 'brief-beetle'.
17602  AUDIT  Node           Deleted the 'machine' 'fit-earwig'.
12508  AUDIT  Node           Deleted the 'machine' 'asdf'.
12507  AUDIT  Node           Deleted the 'machine' 'gfd'.
12506  AUDIT  Node           Deleted the 'machine' 'sadasd'.
12505  AUDIT  Node           Deleted the 'machine' 'vocal-krill'.
12504  AUDIT  Node           Deleted the 'machine' 'epic-robin'.
12503  AUDIT  Node           Deleted the 'machine' 'secret-maas'.
12502  AUDIT  Node           Deleted the 'machine' 'thingthing'.
12501  AUDIT  Node           Deleted the 'machine' 'worthy-ray'.
12500  AUDIT  Node           Deleted the 'machine' 'brief-pika'.
12499  AUDIT  Node           Deleted the 'machine' 'sweet-krill'.
12498  AUDIT  Node           Deleted the 'machine' 'awake-dog'.
12497  AUDIT  Node           Deleted the 'machine' 'living-crab'.
12496  AUDIT  Node           Deleted the 'machine' 'quiet-caiman'.
12495  AUDIT  Node           Deleted the 'machine' 'known-kodiak'.
10975  AUDIT  Node           Deleted the 'machine' 'rested-egret'.
10974  AUDIT  Node           Deleted the 'machine' 'good-martin'.
10973  AUDIT  Node           Deleted the 'machine' 'game-elk'.
10972  AUDIT  Node           Deleted the 'machine' 'asda'.
10971  AUDIT  Node           Deleted the 'machine' 'cuddly-eft'.
10970  AUDIT  Node           Deleted the 'machine' 'asdas'.
9423   AUDIT  Node           Deleted the 'machine' 'hostname'.
7615   AUDIT  Node           Deleted the 'machine' 'new-bedbug'.
7614   AUDIT  Node           Deleted the 'machine' 'happy-bengal'.
7613   AUDIT  Node           Deleted the 'machine' 'fleet-calf'.
7612   AUDIT  Node           Deleted the 'machine' 'claudio'.
7611   AUDIT  Node           Deleted the 'machine' 'sweet-urchin'.
7610   AUDIT  Node           Deleted the 'machine' 'picked-cub'.
7609   AUDIT  Node           Deleted the 'machine' 'new-chimp'.
7608   AUDIT  Node           Deleted the 'machine' 'humble-bug'.
7607   AUDIT  Node           Deleted the 'machine' 'grown-hawk'.
7606   AUDIT  Node           Deleted the 'machine' 'native-moray'.
7605   AUDIT  Node           Deleted the 'machine' 'daring-ewe'.
7604   AUDIT  Node           Deleted the 'machine' 'fair-puma'.
7603   AUDIT  Node           Deleted the 'machine' 'funny-panda'.
7602   AUDIT  Node           Deleted the 'machine' 'ace-molly'.
7601   AUDIT  Node           Deleted the 'machine' 'big-locust'.
7600   AUDIT  Node           Deleted the 'machine' 'next-mullet'.
3944   AUDIT  Node           Deleted the 'machine' 'sweet-urchin'.
3943   AUDIT  Node           Deleted the 'machine' 'picked-cub'.
3942   AUDIT  Node           Deleted the 'machine' 'next-mullet'.
3941   AUDIT  Node           Deleted the 'machine' 'new-chimp'.
3940   AUDIT  Node           Deleted the 'machine' 'new-bedbug'.
3939   AUDIT  Node           Deleted the 'machine' 'native-moray'.
3938   AUDIT  Node           Deleted the 'machine' 'humble-bug'.
3937   AUDIT  Node           Deleted the 'machine' 'happy-bengal'.
3936   AUDIT  Node           Deleted the 'machine' 'claudio'.
3935   AUDIT  Node           Deleted the 'machine' 'daring-ewe'.
3934   AUDIT  Node           Deleted the 'machine' 'grown-hawk'.
3933   AUDIT  Node           Deleted the 'machine' 'fleet-calf'.
2685   AUDIT  Node           Deleted the 'machine' 'test-lab'.
2684   AUDIT  Node           Deleted the 'machine' 'test'.
2683   AUDIT  Node           Deleted the 'machine' 'Sootie'.
2682   AUDIT  Node           Deleted the 'machine' 'Tigger'.
```

Of course, that's a complex list, so could simplify, sort, remove any duplicates, and prettify the list a bit with already-available tools:

```nohighlight
$ maas $PROFILE events query limit=1000 after=0 level=AUDIT \
| jq -r '(.events[] | [.description]) | @tsv' \
| column -t -s$'\t' \
| grep "Deleted the" \
| cut -f 4 -d" " \
| sort -u | sed -e"s/'//g" | sed -e"s/\.//g"
```

This would give you a list of machines that have been deleted at least once:

```nohighlight
aaa
ace-boxer
ace-molly
active-adder
active-panda
alice
asda
asdas
asdf
awake-dog
big-locust
bob
boss-crab
brief-beetle
brief-pika
carol
choice-worm
choice-wren
claudio
clean-filly
clean-ocelot
cool-dog
crisp-chow
crisp-mammal
cuddly-eft
daring-ewe
eager-kid
eager-whale
epic-robin
equal-dog
fair-puma
fine-dane
finer-akita
firm-ghost
fit-earwig
fit-ram
fleet-calf
fun-boxer
funny-panda
game-elk
gfd
good-martin
grown-hawk
guided-joey
happy-bengal
helloooo
holy-hippo
hostname
huge-yeti
humble-bug
keen-lab
known-kodiak
living-crab
me
meet-snake
mighty-finch
modern-mutt
native-civet
native-koala
native-moray
neat-yak
new-bedbug
new-chimp
next-mullet
nice-skink
picked-cub
prime-walrus
pro-boa
proper-troll
quiet-caiman
rare-ghost
rested-egret
ruling-marlin
sadasd
secret-maas
Sootie
steady-mammal
strong-prawn
subtle-lark
superb-piglet
sure-kid
sweet-krill
sweet-urchin
test
test-lab
thingthing
Tigger
top-burro
unique-weevil
vocal-krill
wanted-fox
wanted-turtle
wired-dove
worthy-ray
you
```

Still a bit long, but using your imagination and additional command line utilities, you could pare this down even more.

The important points for working with audit data are:

- there are filters available to pinpoint several event attributes, limit the number of records, and focus on a specific set of records.
- the native output of `events query` is JSON; if you have good JSON tools handy, you can use those tools to parse the data further.
- if you don't have JSON tools handy, you can always use `jq` to produce workable text output, which you can then manipulate using standard CLI text tools.

There's probably no limit to what you can figure out if you use audit events properly.
