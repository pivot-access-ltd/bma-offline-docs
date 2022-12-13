<!-- "Event log reference" -->
The events log tracks state changes and the execution of basic configuration steps, serving as a timeline for your MAAS machines.  A simple view of the events log might look something like this:

```
  Time 	                        Event
  Sun, 04 Oct. 2020 23:12:35 	Ready
  Sun, 04 Oct. 2020 23:12:31 	Running test - smartctl-validate on sda
  Sun, 04 Oct. 2020 23:10:37 	Gathering information
  Sun, 04 Oct. 2020 23:10:30 	Loading ephemeral
  Sun, 04 Oct. 2020 23:10:15 	Performing PXE boot
  Sun, 04 Oct. 2020 23:09:54 	Powering on
  Sun, 04 Oct. 2020 23:09:53 	Commissioning
```

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To view the Events log (for a particular machine), select a machine from the machine list and choose the "Events" tab at the top of the screen:

<a href="https://discourse.maas.io/uploads/default/original/1X/45ad4b968f85ef38e875e6df03d9f832fc7d4743.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/45ad4b968f85ef38e875e6df03d9f832fc7d4743.png"></a>

You can also see a more detailed view by selecting "View full history" in near the upper right of the log output.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To view the raw Events log, enter the following command:

```
maas $PROFILE events query
```

You can tabulate the results, sorted by machine, with the following command:

```
maas admin events query | jq -r '(["HOSTNAME","TIMESTAMP","TYPE","DESCRIPTION"] | (., map(length*"-"))),
(.events[] | [.hostname, .created, .type, .description // "-"]) | @tsv' | column -t -s $'\t'
[/tab]
[/tabs]
