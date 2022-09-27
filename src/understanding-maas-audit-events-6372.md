<!-- "Understanding MAAS audit events" -->

An audit event is a MAAS event tagged with `AUDIT`. It captures changes to the MAAS configuration and machine states. These events provide valuable oversight of user actions and automated updates and their effects, especially when multiple users are interacting with multiple machines.

<a href="#heading--Viewing-events"><h2 id="heading--Viewing-events">Viewing events</h2></a>

Audit events must be examined using the MAAS CLI, via the command `events query level=AUDIT`:

```nohighlight
$ maas $PROFILE events query level=AUDIT
```

This command shows 100 successive audit events, with no filtering, in JSON format.  We recommend simplifying the output with the `jq` tool.  For example, the following command picks out the first 20 audit events currently available on your MAAS host:

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

<a href="#heading--Some-options-for-this-command"><h2 id="heading--Some-options-for-this-command">Some options for this command</h2></a>

This command has several options, so let's look at a couple of the most useful ones.  As you may know, most options passed to a MAAS CLI command are `key=value` pairs.  The example above shows three such options, `level=AUDIT after=0 limit=20`.  The option `level=AUDIT` restricts the event query to audit events.

<a href="#heading--Before-and-after-options"><h3 id="heading--Before-and-after-options">The "before" and "after" options</h3></a>

The `maas $PROFILE events query` retrieves 100 records by default.  You can choose where to begin that 100 records by setting the `after` keyword.  In the example above, we've chosen the first 20 audit records by specifying `after=0`, that is, beginning with the first record.  Pay attention to the `0`, since the `after` command works exactly as you'd expect: it picks up some number of records after the number listed.  If you were to use `after=1`, for example, you wouldn't see the first event.

Note that MAAS event numbering has nothing to do with the `level` you've selected, so a given record number may or may not show up in your `level=AUDIT` query.  For example, let's do that audit event pull again, but this time include the record number (`RNO`) in our table.  We can do that with a command like this:

```nohighlight
$ maas $PROFILE events query level=AUDIT after=0 limit=20 \
| jq -r '(["RNO","USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.id,.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

Note that we've added "RNO" to the header, and the `.events[]` array member `.id` (the record number) to the table.  The results for this particular example look like this:

```nohighlight
RNO  USERNAME  HOSTNAME     DATE                        EVENT
---  --------  --------     ----                        -----
309  unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 2 was updated on node 8wmfx3
299  unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  block device sda was updated on node 8wmfx3
298  unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  interface enp5s0 was updated on node 8wmfx3
134  admin     valued-moth  Thu, 21 Apr. 2022 19:36:48  Started deploying 'valued-moth'.
130  admin     valued-moth  Thu, 21 Apr. 2022 19:36:21  Acquired 'valued-moth'.
18   admin     unknown      Thu, 21 Apr. 2022 19:21:46  Updated configuration setting 'completed_intro' to 'True'.
11   admin     unknown      Thu, 21 Apr. 2022 19:20:24  Logged in admin.
```

You'll notice two important things:

1. The records are sorted so that the newest record in your search range shows up first, and the oldest at the bottom of the list.

2. The record numbers aren't consecutive.  That's because MAAS generates lots of other events besides audit events, and the `level=AUDIT` screens those events out.  

You can consult the help message for the `events query` command by typing:

```nohighlight
$ maas $PROFILE events query -h
```

In the listing that follows, you'll notice several values for the `level` parameter; you can try them each to see what kind of output is returned.

You can view records up to a specific value by using the `before=` keyword.  This is useful if you're manually paging through the audit records, looking for something which can't be easily filtered.

<a href="#heading--Limiting-the-number-of-records"><h3 id="heading--Limiting-the-number-of-records">Limiting the number of records</h3></a>

You can limit the number of records that `events query` will show you by adding the `limit=` keyword.  In the examples above, we've limited the output to 20 records.  The default value is 100 records.  You can set this value as high as 1000 records; anything higher than that produces an error, and the command won't complete.  If you want more than 1000 records, you'll need to page through them or use filters to limit the output in a different way.


<a href="#heading--Filtering-audit-records-on-output"><h3 id="heading--Filtering-audit-records-on-output">Filtering audit records on output</h3></a>

You can filter audit records by several different parameters.  Unless otherwise stated, these `keyword=value` pairs can be entered in any order, in any combination, and repeated multiple times if you need to search for more than one value of a given keyword -- that is, you can enter `hostname=grudging-goose hostname=hairy-hippo` to search for any records that contain either of those hostnames.  The parameters are as follows:

- `hostname=`: this keyword allows you to limit your query to a specific hostname(s).
- `mac_address=`: this keyword allows you to limit your query to a specific MAC address(es).
- `id=`: this keyword allows you to limit your query to a specific system ID value(s).
- `zone=`: this keyword allows you to limit your query to a specific zone(s).
- `owner=`: this keyword allows you to limit your query to a specific machine owner(s).

<a href="#heading--The-meaning-of-audit-events"><h3 id="heading--The-meaning-of-audit-events">The meaning of audit events</h3></a>

Let's walk through a sample of, say, fifty audit events and see how to interpret and use them.  Consider the following `jq` output: