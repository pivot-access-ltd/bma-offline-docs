<!-- "Understanding MAAS audit events" -->

An audit event is a [MAAS event](/t/understanding-maas-events/6373) tagged with `AUDIT`. It captures changes to the MAAS configuration and machine states. These events provide valuable oversight of user actions and automated updates and their effects, especially when multiple users are interacting with multiple machines.  See the [Understanding MAAS events](/t/understanding-maas-events/6373) for the basic operation of the CLI `events query` command.

<a href="#heading--Viewing-events"><h2 id="heading--Viewing-events">Viewing events</h2></a>

Audit events are examined using the MAAS CLI with the `level=AUDIT`:

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

<a href="#heading--The-meaning-of-audit-events"><h3 id="heading--The-meaning-of-audit-events">The meaning of audit events</h3></a>

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

As it turns out, all of these events are of type `Node`, which means they refer to a particular machine.  These node events are probably the most important aspect of MAAS audit events -- mainly because they indicate changes to a machine's life-cycle.  When auditing your MAAS, these life-cycle events will typically be the most useful.

Let's take a moment to consider the MAAS life-cycle, which can be depicted like this: