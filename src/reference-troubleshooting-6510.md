<!-- "About MAAS events" -->
MAAS events are key to most debugging efforts.  Events are state changes that happen to MAAS elements, such as controllers, networks, or machines.  These state changes can be caused by MAAS itself, some external agent (such as an external DHCP server), or by users (such as when commissioning a machine).  Being able to review events is often essential to debugging or verifying your MAAS system.

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

