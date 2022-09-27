<!-- "Understanding MAAS events" -->

Events are state changes that happen to MAAS elements, such as controllers, networks, or machines.  These state changes can be caused by MAAS itself, some external agent (such as an external DHCP server), or by users (such as when commissioning a machine).  Being able to review events is often essential to debugging or verifying your MAAS system.

Every event can be reviewed by scanning the MAAS logs.  If you're using snaps, the logs of interest are:

- /var/snap/maas/common/log/maas.log
- /var/snap/maas/common/log/regiond.log
- /var/snap/maas/common/log/rackd.log
- /var/snap/maas/common/log/rsyslog/$MACHINE_NAME/$RELEVANT_DATE/messages

If you’re using packages, you’ll find the log files in these locations:

- /var/log/maas/maas.log
- /var/log/maas/regiond.log
- /var/log/maas/rackd.log
- /var/log/maas/rsyslog/$MACHINE_NAME/$RELEVANT_DATE/messages

These logs can be very large and hard to search, so MAAS provides a CLI tool which can help you filter and summarise events.  Let's take a look at how this tool works.

<a href="#heading--maas-events-query"><h2 id="heading--mass-events-query">MAAS CLI events query command</h2></a>

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

<a href="#heading--using-jq-with-events"><h2 id="heading--using-jq-with-events">Using jq with events</h2></a>

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

<a href="#heading--filter-parameters"><h2 id="heading--filter-parameters">Filter parameters</h2></a>

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
$ maas stormrider events query level=AUDIT hostname=karura hostname=polong limit=5 \
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
$ maas stormrider events query level=AUDIT hostname=karura hostname=polong limit=7 \
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
$ maas stormrider events query level=AUDIT hostname=karura hostname=polong after=0 limit=7 \
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
$ maas stormrider events query level=AUDIT before=500000 limit=7 \
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