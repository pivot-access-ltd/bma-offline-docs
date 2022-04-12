<!-- "MAAS logging reference" -->
MAAS has a robust logging capability, which presents several different views, including a number of node-specific log files and several syslogd-style text logs.  Each of these logs provides different information, or at the very least, different views of the same information.  MAAS gathers logging information about the various MAAS states and records both automated and user-driven actions.

#### Five questions you may have:

1. [What is the syslog logging path?](#heading--path)
2. [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
3. [What are commissioning logs?](/t/commissioning-log-reference/5248)
4. [What are test logs?](/t/test-log-reference/5314)
5. [What are event logs?](/t/event-log-reference/5252)

The discussion of these logs and their contents can be very extensive, so each type of logging has its own documentation section, reachable from the left-hand menu -- or from the list of questions above.

<a href="#heading--path"><h2 id="heading--path">The syslog logging path</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap"] 
Syslog data is kept in `/var/snap/maas/common/log/rsyslog/<machine-name><yyyy-mm-dd>/messages`. Every machine known to MAAS will have corresponding syslogs.
[/tab]
[tab version="v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages"] 
Syslog data is kept in `/var/log/maas/rsyslog/<machine-name><yyyy-mm-dd>/messages`.  Every machine known to MAAS will have corresponding syslogs.
[/tab]
[/tabs]

<a href="#heading--using-a-remote-syslog-server"><h2 id="heading--using-a-remote-syslog-server">Using a remote syslog server</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="UI"] 
To add a remote syslog server, click the Settings tab and then click the Network services tab. Scroll down to the Syslog section, where you can add a syslog URL or IP:

<a href="https://assets.ubuntu.com/v1/e139d4e9-installconfig-syslog__2.6-remote-syslog.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/e139d4e9-installconfig-syslog__2.6-remote-syslog.png"></a>

Click the Save button to save your changes.
[/tab]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="CLI"]
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
