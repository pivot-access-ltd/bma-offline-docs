<!-- "Understanding MAAS audit events" -->

Audit events must be examined using the MAAS CLI, as there is no corresponding MAAS web UI tool at present.

The CLI command `events query level=AUDIT` will help you review audit events:

```nohighlight
$ maas admin events query level=AUDIT
```

This command will show you 100 successive audit events, with no filtering, in JSON format.  Since JSON format can be very long, we recommend that you apply the `jq` tool to present records in a more readable way.  For example, the following command picks out the first 20 audit events currently available on your MAAS host:

```nohighlight
$ maas admin events query level=AUDIT after=0 limit=20 \
| jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This command might produce output simlar to this:

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