<!-- How to audit MAAS -->

This article gives concise procedures for working with [audit events](/t/maas-audit-events/6372).  Here you will learn:

- [How to report audit events](#heading--How-to-report-audit-events)
- [How to filter audit events by hostname](#heading--How-to-filter-audit-events-by-hostname)
- [How to filter audit events by MAC address](#heading--How-to-filter-audit-events-by-MAC-address)
- [How to filter audit events by system ID](#heading--How-to-filter-audit-events-by-system-ID)
- [How to filter audit events by zone](#heading--How-to-filter-audit-events-by-zone)
- [How to filter audit events by owner](#heading--How-to-filter-audit-events-by-owner)
- [How to limit the number of audit events displayed](#heading--How-to-limit-the-number-of-audit-events-displayed)
- [How to move the audit event window](#heading--How-to-move-the-audit-event-window)
- [How to audit a machine's life-cycle with audit events](#heading--How-to-audit-a-machines-life-cycle-with-audit-events)

Note that for this article, we will assume you have installed [the `jq` tool](https://stedolan.github.io/jq/)`↗`, which makes the JSON output of `events query` more human-readable.

<a href="#heading--How-to-report-audit-events"><h2 id="heading--How-to-report-audit-events">How to report audit events</h2></a>

To get a list of MAAS audit events, enter this MAAS CLI command:

```nohighlight
$ maas $PROFILE events query level=AUDIT \
| jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This produces a table of 100 of the most recent audit events.  The truncated table might look something like this:

```nohighlight
USERNAME       HOSTNAME         DATE                        EVENT
--------       --------         ----                        -----
paulomalovich  ruling-bobcat    Tue, 04 Oct. 2022 13:19:22  Started testing on 'ruling-bobcat'.
paulomalovich  new-name         Tue, 04 Oct. 2022 11:45:44  Started testing on 'new-name'.
paulomalovich  fine-hornet      Tue, 04 Oct. 2022 11:44:48  Powered off 'fine-hornet'.
paulomalovich  fine-hornet      Tue, 04 Oct. 2022 11:44:39  Powered off 'fine-hornet'.
admin          polong           Tue, 04 Oct. 2022 11:39:44  Started testing on 'polong'.
paulomalovich  fine-hornet      Tue, 04 Oct. 2022 11:35:32  Powered off 'fine-hornet'.
admin          fair-marten      Mon, 03 Oct. 2022 14:13:54  Started testing on 'fair-marten'.
admin          new-name         Mon, 03 Oct. 2022 14:13:54  Started testing on 'new-name'.
paulomalovich  new-name         Fri, 30 Sep. 2022 09:44:25  Started testing on 'new-name'.
stormrider     ruling-bobcat    Wed, 28 Sep. 2022 21:36:36  Marked 'ruling-bobcat' broken.
stormrider     ruling-bobcat    Wed, 28 Sep. 2022 20:46:46  Started commissioning on 'ruling-bobcat'.
stormrider     ruling-bobcat    Wed, 28 Sep. 2022 20:46:38  Set the zone to 'default' on 'ruling-bobcat'.
paulomalovich  top-monkey       Wed, 28 Sep. 2022 14:43:47  Tagging 'top-monkey'.
paulomalovich  fake-controller  Wed, 28 Sep. 2022 14:24:36  Powered on 'fake-controller'.
paulomalovich  fake-controller  Wed, 28 Sep. 2022 14:24:06  Powered on 'fake-controller'.
paulomalovich  fake-controller  Wed, 28 Sep. 2022 14:24:03  Powered off 'fake-controller'.
paulomalovich  new-name         Wed, 28 Sep. 2022 14:19:35  Untagging 'new-name'.
paulomalovich  new-name         Wed, 28 Sep. 2022 14:19:30  Tagging 'new-name'.
stormrider     ruling-bobcat    Tue, 27 Sep. 2022 22:53:35  Aborted 'commissioning' on 'ruling-bobcat'.
stormrider     ruling-bobcat    Tue, 27 Sep. 2022 22:53:30  Aborted 'commissioning' on 'ruling-bobcat'.
stormrider     ruling-bobcat    Tue, 27 Sep. 2022 22:53:11  Started commissioning on 'ruling-bobcat'.
...
```

<a href="#heading--How-to-filter-audit-events-by-hostname"><h2 id="heading--How-to-filter-audit-events-by-hostname">How to filter audit events by hostname</h2></a>

To get a list of MAAS audit events for a specific host, enter this MAAS CLI command:

```nohighlight
$ maas $PROFILE events query level=AUDIT hostname=ruling-bobcat \
| jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This produces a table of 100 of the most recent audit events for the specified hostname.  The truncated table might look something like this:

```nohighlight
paulomalovich  ruling-bobcat  Tue, 04 Oct. 2022 13:19:22  Started testing on 'ruling-bobcat'.
stormrider     ruling-bobcat  Wed, 28 Sep. 2022 21:36:36  Marked 'ruling-bobcat' broken.
stormrider     ruling-bobcat  Wed, 28 Sep. 2022 20:46:46  Started commissioning on 'ruling-bobcat'.
stormrider     ruling-bobcat  Wed, 28 Sep. 2022 20:46:38  Set the zone to 'default' on 'ruling-bobcat'.
stormrider     ruling-bobcat  Tue, 27 Sep. 2022 22:53:35  Aborted 'commissioning' on 'ruling-bobcat'.
stormrider     ruling-bobcat  Tue, 27 Sep. 2022 22:53:30  Aborted 'commissioning' on 'ruling-bobcat'.
stormrider     ruling-bobcat  Tue, 27 Sep. 2022 22:53:11  Started commissioning on 'ruling-bobcat'.
admin          ruling-bobcat  Thu, 22 Sep. 2022 15:19:00  Started commissioning on 'ruling-bobcat'.
admin          ruling-bobcat  Wed, 21 Sep. 2022 10:57:53  Started commissioning on 'ruling-bobcat'.
admin          ruling-bobcat  Tue, 20 Sep. 2022 15:16:41  Started commissioning on 'ruling-bobcat'.
admin          ruling-bobcat  Tue, 20 Sep. 2022 15:02:40  Started commissioning on 'ruling-bobcat'.
admin          ruling-bobcat  Tue, 20 Sep. 2022 11:17:14  Started commissioning on 'ruling-bobcat'.
sugarsmacks    ruling-bobcat  Tue, 23 Aug. 2022 09:24:20  Started releasing 'ruling-bobcat'.
admin          ruling-bobcat  Thu, 23 Jun. 2022 23:26:57  Set the zone to 'forbidden' on 'ruling-bobcat'.
sugarsmacks    ruling-bobcat  Wed, 22 Jun. 2022 10:32:24  Started releasing 'ruling-bobcat'.
...
```

<a href="#heading--How-to-filter-audit-events-by-MAC-address"><h2 id="heading--How-to-filter-audit-events-by-MAC-address">How to filter audit events by MAC address</h2></a>

To get a list of MAAS audit events for a specific MAC address, enter this MAAS CLI command:

```nohighlight
$ maas $PROFILE events query level=AUDIT mac_address=00:07:fe:72:a6:00 \
| jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This produces a table of 100 of the most recent audit events for the hostname with the specified MAC address.  The truncated table might look something like this:

```nohighlight
USERNAME     HOSTNAME     DATE                        EVENT
--------     --------     ----                        -----
admin        fair-marten  Mon, 03 Oct. 2022 14:13:54  Started testing on 'fair-marten'.
sugarsmacks  fair-marten  Wed, 21 Sep. 2022 14:21:25  Tagging 'fair-marten'.
sugarsmacks  fair-marten  Wed, 21 Sep. 2022 14:10:38  Untagging 'fair-marten'.
sugarsmacks  fair-marten  Wed, 22 Jun. 2022 10:20:13  Tagging 'fair-marten'.
edward       fair-marten  Fri, 08 Apr. 2022 11:02:15  Untagging 'fair-marten'.
edward       fair-marten  Fri, 08 Apr. 2022 11:02:14  Tagging 'fair-marten'.
admin        fair-marten  Fri, 11 Feb. 2022 11:00:00  Set the zone to 'twilight' on 'fair-marten'.
admin        fair-marten  Fri, 11 Feb. 2022 10:59:56  Set the zone to 'danger' on 'fair-marten'.
admin        fair-marten  Fri, 11 Feb. 2022 10:59:50  Acquired 'fair-marten'.
carlo        fair-marten  Tue, 11 Jan. 2022 01:56:32  Started testing on 'fair-marten'.
carlo        fair-marten  Tue, 11 Jan. 2022 01:56:26  Marked 'fair-marten' broken.
carlo        fair-marten  Tue, 11 Jan. 2022 01:56:23  Aborted 'testing' on 'fair-marten'.
...
```
Note that the JSON output from `events query` does not print the MAC address, so it is not possible to include that parameter in the output.

<a href="#heading--How-to-filter-audit-events-by-system-ID"><h2 id="heading--How-to-filter-audit-events-by-system-ID">How to filter audit events by system ID</h2></a>

To get a list of MAAS audit events for a specific system ID, enter this MAAS CLI command:

```nohighlight
$ maas $PROFILE events query level=AUDIT id=8r6pw7 \
| jq -r '(["USERNAME","HOSTNAME","SYSTEM_ID", "DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.node,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This produces a table of 100 of the most recent audit events for the hostname with the specified system ID.  The truncated table might look something like this:

```nohighlight
USERNAME       HOSTNAME  SYSTEM_ID  DATE                        EVENT
--------       --------  ---------  ----                        -----
stormrider     karura    8r6pw7     Tue, 27 Sep. 2022 21:53:34  Set the zone to 'twilight' on 'karura'.
admin          karura    8r6pw7     Wed, 21 Sep. 2022 14:00:47  Untagging 'karura'.
admin          karura    8r6pw7     Wed, 21 Sep. 2022 14:00:01  Tagging 'karura'.
admin          karura    8r6pw7     Wed, 21 Sep. 2022 13:58:11  Untagging 'karura'.
admin          karura    8r6pw7     Wed, 21 Sep. 2022 13:57:48  Tagging 'karura'.
hmrxopxi       karura    8r6pw7     Fri, 12 Aug. 2022 00:16:51  Tagging 'karura'.
john           karura    8r6pw7     Tue, 12 Jul. 2022 15:08:27  Powered on 'karura'.
john           karura    8r6pw7     Tue, 12 Jul. 2022 15:08:23  Powered on 'karura'.
john           karura    8r6pw7     Tue, 12 Jul. 2022 15:08:08  Powered off 'karura'.
admin          karura    8r6pw7     Thu, 23 Jun. 2022 23:26:53  Set the zone to 'asd' on 'karura'.
paulomalovich  karura    8r6pw7     Fri, 22 Apr. 2022 08:06:59  Powered off 'karura'.
paulomalovich  karura    8r6pw7     Fri, 22 Apr. 2022 07:09:55  Powered on 'karura'.
```

<a href="#heading--How-to-filter-audit-events-by-zone"><h2 id="heading--How-to-filter-audit-events-by-zone">How to filter audit events by zone</h2></a>

To get a list of MAAS audit events that are in a specific zone, enter this MAAS CLI command:

```nohighlight
$ maas $PROFILE events query level=AUDIT zone=twilight \
| jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This produces a table of 100 of the most recent audit events for the hosts that are in the specified zone.  The truncated table might look something like this:

```nohighlight
USERNAME       HOSTNAME     DATE                        EVENT
--------       --------     ----                        -----
admin          polong       Tue, 04 Oct. 2022 11:39:44  Started testing on 'polong'.
admin          fair-marten  Mon, 03 Oct. 2022 14:13:54  Started testing on 'fair-marten'.
stormrider     polong       Tue, 27 Sep. 2022 21:53:38  Set the zone to 'twilight' on 'polong'.
stormrider     karura       Tue, 27 Sep. 2022 21:53:34  Set the zone to 'twilight' on 'karura'.
sugarsmacks    fair-marten  Wed, 21 Sep. 2022 14:21:25  Tagging 'fair-marten'.
sugarsmacks    fair-marten  Wed, 21 Sep. 2022 14:10:38  Untagging 'fair-marten'.
admin          karura       Wed, 21 Sep. 2022 14:00:47  Untagging 'karura'.
admin          karura       Wed, 21 Sep. 2022 14:00:01  Tagging 'karura'.
admin          karura       Wed, 21 Sep. 2022 13:58:11  Untagging 'karura'.
admin          karura       Wed, 21 Sep. 2022 13:57:48  Tagging 'karura'.
admin          polong       Tue, 13 Sep. 2022 14:14:24  Powered on 'polong'.
```
Note that the JSON output from `events query` does not print the zone, so it is not possible to include that parameter in the output.

<a href="#heading--How-to-filter-audit-events-by-owner"><h2 id="heading--How-to-filter-audit-events-by-owner">How to filter audit events by owner</h2></a>

To get a list of MAAS audit events for machines owned by a specific username, enter this MAAS CLI command:

```nohighlight
$ maas stormrider events query level=AUDIT owner=stormrider | jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This produces a table of 100 of the most recent audit events for the hosts that are owned by the specified username ("owner").  The truncated table might look something like this:

```nohighlight
USERNAME    HOSTNAME       DATE                        EVENT
--------    --------       ----                        -----
stormrider  ruling-bobcat  Wed, 28 Sep. 2022 21:36:36  Marked 'ruling-bobcat' broken.
stormrider  ruling-bobcat  Wed, 28 Sep. 2022 20:46:46  Started commissioning on 'ruling-bobcat'.
stormrider  ruling-bobcat  Wed, 28 Sep. 2022 20:46:38  Set the zone to 'default' on 'ruling-bobcat'.
stormrider  ruling-bobcat  Tue, 27 Sep. 2022 22:53:35  Aborted 'commissioning' on 'ruling-bobcat'.
stormrider  ruling-bobcat  Tue, 27 Sep. 2022 22:53:30  Aborted 'commissioning' on 'ruling-bobcat'.
stormrider  ruling-bobcat  Tue, 27 Sep. 2022 22:53:11  Started commissioning on 'ruling-bobcat'.
stormrider  polong         Tue, 27 Sep. 2022 21:53:38  Set the zone to 'twilight' on 'polong'.
stormrider  karura         Tue, 27 Sep. 2022 21:53:34  Set the zone to 'twilight' on 'karura'.
stormrider  new-name       Tue, 27 Sep. 2022 21:53:14  Set the zone to 'forbidden' on 'new-name'.
```

<a href="#heading--How-to-limit-the-number-of-audit-events-displayed"><h2 id="heading--How-to-limit-the-number-of-audit-events-displayed">How to limit the number of audit events displayed</h2></a>

To limit or expand the number of MAAS audit events shown for any given query, use the `limit=` parameter:

```nohighlight
$ maas stormrider events query level=AUDIT owner=stormrider limit=3 | jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This particular command repeats the query used in the previous section, but limits the number of records returned to three:

```nohighlight
USERNAME    HOSTNAME       DATE                        EVENT
--------    --------       ----                        -----
stormrider  ruling-bobcat  Wed, 28 Sep. 2022 21:36:36  Marked 'ruling-bobcat' broken.
stormrider  ruling-bobcat  Wed, 28 Sep. 2022 20:46:46  Started commissioning on 'ruling-bobcat'.
stormrider  ruling-bobcat  Wed, 28 Sep. 2022 20:46:38  Set the zone to 'default' on 'ruling-bobcat'.
```

This parameter can also be used to expand the number of reported records, up to a maximum of 1000.  Note that the query returns only as many records as are available.  For example, we can attempt to return 1000 records for `owner=stormrider`:

```nohighlight
$ maas stormrider events query level=AUDIT owner=stormrider limit=1000 | jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

Since only a few audit events exist, though, the returned list is much smaller:

```nohighlight
USERNAME    HOSTNAME       DATE                        EVENT
--------    --------       ----                        -----
stormrider  ruling-bobcat  Wed, 28 Sep. 2022 21:36:36  Marked 'ruling-bobcat' broken.
stormrider  ruling-bobcat  Wed, 28 Sep. 2022 20:46:46  Started commissioning on 'ruling-bobcat'.
stormrider  ruling-bobcat  Wed, 28 Sep. 2022 20:46:38  Set the zone to 'default' on 'ruling-bobcat'.
stormrider  ruling-bobcat  Tue, 27 Sep. 2022 22:53:35  Aborted 'commissioning' on 'ruling-bobcat'.
stormrider  ruling-bobcat  Tue, 27 Sep. 2022 22:53:30  Aborted 'commissioning' on 'ruling-bobcat'.
stormrider  ruling-bobcat  Tue, 27 Sep. 2022 22:53:11  Started commissioning on 'ruling-bobcat'.
stormrider  polong         Tue, 27 Sep. 2022 21:53:38  Set the zone to 'twilight' on 'polong'.
stormrider  karura         Tue, 27 Sep. 2022 21:53:34  Set the zone to 'twilight' on 'karura'.
stormrider  new-name       Tue, 27 Sep. 2022 21:53:14  Set the zone to 'forbidden' on 'new-name'.
```

<a href="#heading--How-to-move-the-audit-event-window"><h2 id="heading--How-to-move-the-audit-event-window">How to move the audit event window</h2></a>

To return records that occur before a certain record ID number, enter a command like this one:

```nohighlight
$ maas stormrider events query level=AUDIT after=0 | jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This command will yield a list that starts with the following events:

```nohighlight
USERNAME     HOSTNAME       DATE                        EVENT
--------     --------       ----                        -----
admin        ruling-bobcat  Wed, 17 Nov. 2021 00:04:51  Started deploying 'ruling-bobcat'.
admin        active-amoeba  Mon, 15 Nov. 2021 05:39:48  Set the resource pool to 'default' on 'active-amoeba'.
admin        fair-marten    Mon, 15 Nov. 2021 05:39:48  Set the resource pool to 'default' on 'fair-marten'.
admin        active-amoeba  Mon, 15 Nov. 2021 05:37:26  Set the resource pool to 'new' on 'active-amoeba'.
admin        fair-marten    Mon, 15 Nov. 2021 05:37:26  Set the resource pool to 'new' on 'fair-marten'.
admin        active-amoeba  Mon, 08 Nov. 2021 04:07:44  Started testing on 'active-amoeba'.
admin        active-amoeba  Mon, 08 Nov. 2021 04:05:40  Marked 'active-amoeba' broken.
admin        active-amoeba  Mon, 08 Nov. 2021 04:05:05  Started testing on 'active-amoeba'.
admin        active-amoeba  Mon, 08 Nov. 2021 04:04:57  Marked 'active-amoeba' broken.
admin        bolla          Wed, 16 Jun. 2021 04:35:50  Started importing images on 'bolla'.
```

You can move the start of this window by moving the `after=` setting, like this:

```nohighlight
$ maas stormrider events query level=AUDIT after=2000 | jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This command will yield a list that starts with later events:

```nohighlight
USERNAME     HOSTNAME       DATE                        EVENT
--------     --------       ----                        -----
carlo        fair-marten    Wed, 01 Dec. 2021 06:13:45  Tagging 'fair-marten'.
carlo        new-name       Wed, 01 Dec. 2021 06:13:45  Tagging 'new-name'.
carlo        ruling-bobcat  Wed, 01 Dec. 2021 06:09:55  Tagging 'ruling-bobcat'.
carlo        fair-marten    Wed, 01 Dec. 2021 06:09:55  Tagging 'fair-marten'.
carlo        new-name       Wed, 01 Dec. 2021 06:09:55  Tagging 'new-name'.
carlo        ruling-bobcat  Wed, 01 Dec. 2021 05:33:41  Started commissioning on 'ruling-bobcat'.
carlo        fair-marten    Wed, 01 Dec. 2021 05:33:40  Started commissioning on 'fair-marten'.
carlo        new-name       Wed, 01 Dec. 2021 05:33:40  Started commissioning on 'new-name'.
carlo        ruling-bobcat  Wed, 01 Dec. 2021 05:21:09  Aborted 'commissioning' on 'ruling-bobcat'.
carlo        ruling-bobcat  Wed, 01 Dec. 2021 05:21:07  Aborted 'commissioning' on 'ruling-bobcat'.
carlo        ruling-bobcat  Wed, 01 Dec. 2021 05:21:04  Aborted 'commissioning' on 'ruling-bobcat'.
carlo        ruling-bobcat  Wed, 01 Dec. 2021 05:21:02  Aborted 'commissioning' on 'ruling-bobcat'.
carlo        new-name       Wed, 01 Dec. 2021 05:20:50  Started commissioning on 'new-name'.
carlo        fair-marten    Wed, 01 Dec. 2021 05:20:50  Started commissioning on 'fair-marten'.
carlo        ruling-bobcat  Wed, 01 Dec. 2021 05:20:40  Started commissioning on 'ruling-bobcat'.
carlo        new-name       Wed, 01 Dec. 2021 05:20:39  Started commissioning on 'new-name'.
carlo        fair-marten    Wed, 01 Dec. 2021 05:20:39  Started commissioning on 'fair-marten'.
```

Note that the starting point of the list (newest date first) has moved forward in time somewhat.  You can also use the `before=` parameter to move the window, as desired.

<a href="#heading--How-to-audit-a-machines-life-cycle-with-audit-events"><h2 id="heading--How-to-audit-a-machines-life-cycle-with-audit-events">How to audit a machine's life-cycle with audit events</h2></a>

To audit a machine's life-cycle, using audit events, do the following:

1. Collect a fair amount of audit data on that particular machine using, for example, the hostname to filter events:

```nohighlight
maas stormrider events query hostname=ruling-bobcat level=AUDIT after=0 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' > /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat level=AUDIT after=1000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat level=AUDIT after=2000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat level=AUDIT after=3000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat level=AUDIT after=4000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat level=AUDIT after=5000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
...to the number of events you wish to collect
```

2. Collect non-audit data by excluding the `level=` parameter from the call:

```nohighlight
maas stormrider events query hostname=ruling-bobcat after=0 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat after=1000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat after=2000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat after=3000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat after=4000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat after=5000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
...again, to the number of events you wish to collect
```

3. Collect state information by using the `level=DEBUG` parameter:

```nohighlight
maas stormrider events query hostname=ruling-bobcat level=DEBUG after=0 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat level=DEBUG after=1000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat level=DEBUG after=2000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat level=DEBUG after=3000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat level=DEBUG after=4000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
maas stormrider events query hostname=ruling-bobcat level=DEBUG after=5000 limit=1000 | jq -r '(.events[] | [.id,.level,.type,.created,.description]) 
| @tsv' | column -t -s$'\t' >> /tmp/audit-data
...and again, to the number of events you wish to collect
```

4. Sort your collected data and remove any duplicates (since ranges may overlap at times):

```nohighlight
sort -u /tmp/audit-data > /tmp/life-cycle
```

Let's assume at this point, you have a `life-cycle` file that begins something like this:

```nohighlight
418606  ERROR    Marking node broken               Wed, 17 Nov. 2021 00:02:52  A Physical Interface requires a MAC address.
418607  DEBUG    Node changed status               Wed, 17 Nov. 2021 00:02:52  From 'New' to 'Broken'
418608  DEBUG    Marking node fixed                Wed, 17 Nov. 2021 00:04:24  
418609  DEBUG    Node changed status               Wed, 17 Nov. 2021 00:04:24  From 'Broken' to 'Ready'
418613  DEBUG    User acquiring node               Wed, 17 Nov. 2021 00:04:51  (admin)
418614  DEBUG    Node changed status               Wed, 17 Nov. 2021 00:04:51  From 'Ready' to 'Allocated' (to admin)
418615  DEBUG    User starting deployment          Wed, 17 Nov. 2021 00:04:51  (admin)
418616  DEBUG    Node changed status               Wed, 17 Nov. 2021 00:04:51  From 'Allocated' to 'Deploying'
418617  INFO     Deploying                         Wed, 17 Nov. 2021 00:04:51  
418618  AUDIT    Node                              Wed, 17 Nov. 2021 00:04:51  Started deploying 'ruling-bobcat'.
418619  INFO     Powering on                       Wed, 17 Nov. 2021 00:04:55  
418625  ERROR    Marking node failed               Wed, 17 Nov. 2021 00:05:32  Power on for the node failed: Failed talking to node's BMC: Failed to power pbpncx. BMC never transitioned from off to on.
418626  DEBUG    Node changed status               Wed, 17 Nov. 2021 00:05:32  From 'Deploying' to 'Failed deployment'
418627  ERROR    Failed to power on node           Wed, 17 Nov. 2021 00:05:32  Power on for the node failed: Failed talking to node's BMC: Failed to power pbpncx. BMC never transitioned from off to on.
```

5. Walk down the collected life-cycle data to find out what happened to the machine.  In this case, we can see that:

- The machine was marked "Broken" because one of its physical interfaces lacked a MAC address.
- Someone marked the machine fixed (did they actually fix the problem?), which moved it back to a "Ready" state.
- Someone acquired the machine (successfully) and attempted to deploy it.
- MAAS could not talk to the machine's BMC, so the deployment failed.

In this case, a first thought might be to see whether the machine interface was actually fixed, that is, whether the machine was ever adjusted so that it could communicate with MAAS, or whether an interface issues persists.

Note that you must use more than just AUDIT events when debugging life-cycle issues with a machine.  Also note that issue the command `maas $PROFILE events query` without a specified `level=` parameter does not report audit events, so it's best to collect three sets of information: AUDIT, INFO, and DEBUG, and then process the information according to the event ID.