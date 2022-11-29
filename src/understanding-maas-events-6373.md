<!-- "Understanding MAAS events" -->

Events are state changes that happen to MAAS elements, such as controllers, networks, or machines.  These state changes can be caused by MAAS itself, some external agent (such as an external DHCP server), or by users (such as when commissioning a machine).  Being able to review events is often essential to debugging or verifying your MAAS system.

Events can be seen in the MAAS logs, in the UI event log, and in output from the CLI `events query` command.  These three sources provide analogous (but somewhat different information). For example, consider the following log listing, obtained by doing a `grep "fun-zebra" *.log | grep "transition from"` in the MAAS log directory:

```nohighlight
maas.log:2022-09-29T15:04:07.795515-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from COMMISSIONING to TESTING
maas.log:2022-09-29T15:04:17.288763-05:00 neuromancer maas.node: [info] fun-zebra: Status transition from TESTING to READY
```

This information appears this way when events are queried from the CLI:

```nohighlight
        {
            "username": "unknown",
            "node": "bk7mg8",
            "hostname": "fun-zebra",
            "id": 170,
            "level": "INFO",
            "created": "Thu, 29 Sep. 2022 20:04:17",
            "type": "Ready",
            "description": ""
        },
        {
            "username": "unknown",
            "node": "bk7mg8",
            "hostname": "fun-zebra",
            "id": 167,
            "level": "INFO",
            "created": "Thu, 29 Sep. 2022 20:04:07",
            "type": "Running test",
            "description": "smartctl-validate on sda"
        },
```

And it appears like this in the UI events log:

| Time	| Event |
|---|---|
|**Thu, 29 Sep. 2022 20:04:17**	|**Node changed status - From 'Testing' to 'Ready'** |
|Thu, 29 Sep. 2022 20:04:17	|Ready |
|Thu, 29 Sep. 2022 20:04:17	|Script result - smartctl-validate on sda changed status from 'Running' to 'Skipped' |
|Thu, 29 Sep. 2022 20:04:16	|Script result - smartctl-validate on sda changed status from 'Installing dependencies' to 'Running' |
|Thu, 29 Sep. 2022 20:04:07	|Running test - smartctl-validate on sda |
|**Thu, 29 Sep. 2022 20:04:07**	|**Node changed status - From 'Commissioning' to 'Testing'** |

You can see that all three outputs are sources of truth, but the messages are somewhat different, include different information, and contain different levels of detail.

<a href="#heading--Using-the-logs-directly"><h2 id="heading--Using-the-logs-directly">Using the logs directly</h2></a>

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

<a href="#heading--maas-events-query"><h2 id="heading--mass-events-query">MAAS CLI events query command</h2></a>

In fact, probably the best way to review events is via the CLI sub-command, `events query`. This sub-command can help you filter and summarise events.  Let's take a look at how this tool works.

<a href="#heading--Basic-queries"><h3 id="heading--Basic-queries">Basic queries</h3></a>

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

<a href="#heading--using-jq-with-events"><h3 id="heading--using-jq-with-events">Using jq with events</h3></a>

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

<a href="#heading--filter-parameters"><h3 id="heading--filter-parameters">Filter parameters</h3></a>

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

<a href="#heading--hostname-filter"><h3 id="heading--hostname-filter">Hostname, system ID, and MAC address filters</h3></a>

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

<a href="#heading--zone-filter"><h3 id="heading--zone-filter">Zone filter</h3></a>

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

<a href="#heading--level-filter"><h3 id="heading--level-filter">Level filter</h3></a>

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

<a href="#heading--combining-filters"><h3 id="heading--combining-filters">Combining filters</h3></a>

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

<a href="#heading--limit-filter"><h3 id="heading--limit-filter">The limit filter</h3></a>

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

<a href="#heading--before-and-after-filters"><h3 id="heading--before-and-after-filters">The before and after filters</h3></a>

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

<a href="#heading--Using-different-event-levels"><h2 id="heading--Using-different-event-levels">Using different event levels</h2></a>

As mentioned earlier, the `AUDIT` events are [discussed elsewhere](/t/understanding-maas-audit-events/6372).  It may be useful, though to take a closer look at the other event levels here.

<a href="#heading--INFO-and-DEBUG-events"><h3 id="heading--INFO-and-DEBUG-events">INFO and DEBUG events</h3></a>

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

<a href="#heading--ERROR-and-WARNING-events"><h3 id="heading--ERROR-and-WARNING-events">ERROR and WARNING events</h3></a>

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

<a href="#heading--CRITICAL-errors"><h3 id="heading--CRITICAL-errors">CRITICAL errors</h3></a>

`CRITICAL` errors represent major failures, often code failures or trace-backs.  Any `CRITICAL` errors should be immediately examined and resolved, if possible, and [reported as a bug](/t/how-to-report-a-bug/4446) if not resolvable.