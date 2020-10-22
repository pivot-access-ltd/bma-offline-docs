<!-- deb-2-7-cli
deb-2-7-cli -->

<!-- deb-2-7-ui
 deb-2-7-ui -->

<!-- deb-2-8-cli
 deb-2-8-cli -->

<!-- deb-2-8-ui
 deb-2-8-ui -->

<!-- deb-2-9-cli
 deb-2-9-cli -->

<!-- deb-2-9-ui
 deb-2-9-ui -->

<!-- snap-2-7-cli
 snap-2-7-cli -->

<!-- snap-2-7-ui
 snap-2-7-ui -->

<!-- snap-2-8-cli
 snap-2-8-cli -->

<!-- snap-2-8-ui
 snap-2-8-ui -->

<!-- snap-2-9-cli
 snap-2-9-cli -->

<!-- snap-2-9-ui
 snap-2-9-ui -->

MAAS has a robust logging capability, which presents several different views, including a number of node-specific log files and several syslogd-style text logs.  Each of these logs provides different information, or at the very least, different views of the same information.  MAAS gathers logging information about the various MAAS states and records both automated and user-driven actions.

#### Quick questions you may have:

<!-- deb-2-7-cli
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2496)
* [What are test logs?](/t/test-logs/3132)
* [What are event logs?](/t/event-logs/3388)
deb-2-7-cli -->

<!-- deb-2-7-ui
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2497)
* [What are test logs?](/t/test-logs/3133)
* [What are event logs?](/t/event-logs/3389)
 deb-2-7-ui -->

<!-- deb-2-8-cli
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2498)
* [What are test logs?](/t/test-logs/3134)
* [What are event logs?](/t/event-logs/3390)
 deb-2-8-cli -->

<!-- deb-2-8-ui
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2499)
* [What are test logs?](/t/test-logs/3135)
* [What are event logs?](/t/event-logs/3391)
 deb-2-8-ui -->

<!-- deb-2-9-cli
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2500)
* [What are test logs?](/t/test-logs/3136)
* [What are event logs?](/t/event-logs/3393)
 deb-2-9-cli -->

<!-- deb-2-9-ui
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2501)
* [What are test logs?](/t/test-logs/3137)
* [What are event logs?](/t/event-logs/3392)
 deb-2-9-ui -->

<!-- snap-2-7-cli
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2490)
* [What are test logs?](/t/test-logs/3126)
* [What are event logs?](/t/event-logs/3382)
 snap-2-7-cli -->

<!-- snap-2-7-ui
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2491)
* [What are test logs?](/t/test-logs/3127)
* [What are event logs?](/t/event-logs/3383)
 snap-2-7-ui -->

<!-- snap-2-8-cli
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2492)
* [What are test logs?](/t/test-logs/3128)
* [What are event logs?](/t/event-logs/3384)
 snap-2-8-cli -->

<!-- snap-2-8-ui
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2493)
* [What are test logs?](/t/test-logs/3129)
* [What are event logs?](/t/event-logs/3385)
 snap-2-8-ui -->

<!-- snap-2-9-cli
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2494)
* [What are test logs?](/t/test-logs/3130)
* [What are event logs?](/t/event-logs/3386)
 snap-2-9-cli -->

<!-- snap-2-9-ui
* [What is the syslog logging path?](#heading--path)
* [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
* [What are commissioning logs?](/t/commissioning-logs/2495)
* [What are test logs?](/t/test-logs/3131)
* [What are event logs?](/t/event-logs/3387)
 snap-2-9-ui -->

The discussion of these logs and their contents can be very extensive, so each type of logging has its own documentation section, reachable from the left-hand menu -- or from the list of questions above.

<h2 id="heading--path">The syslog logging path</h2>

<!-- deb-2-7-ui deb-2-7-cli deb-2-8-ui deb-2-8-cli deb-2-9-ui deb-2-9-cli
Syslog data is kept in `/var/log/maas/rsyslog/<machine-name><yyyy-mm-dd>/messages`.  Every machine known to MAAS will have corresponding syslogs.
deb-2-7-ui deb-2-7-cli deb-2-8-ui deb-2-8-cli deb-2-9-ui deb-2-9-cli -->

<!-- snap-2-7-ui snap-2-7-cli snap-2-8-ui snap-2-8-cli snap-2-9-ui snap-2-9-cli
Syslog data is kept in `/var/snap/maas/common/log/rsyslog/<machine-name><yyyy-mm-dd>/messages`. Every machine known to MAAS will have corresponding syslogs.
snap-2-7-ui snap-2-7-cli snap-2-8-ui snap-2-8-cli snap-2-9-ui snap-2-9-cli -->

<h2 id="heading--using-a-remote-syslog-server">Using a remote syslog server</h2>

<!-- snap-2-7-ui snap-2-8-ui snap-2-9-ui deb-2-7-ui deb-2-8-ui deb-2-9-ui
To add a remote syslog server, click the Settings tab and then click the Network services tab. Scroll down to the Syslog section, where you can add a syslog URL or IP:

<a href="https://assets.ubuntu.com/v1/e139d4e9-installconfig-syslog__2.6-remote-syslog.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/e139d4e9-installconfig-syslog__2.6-remote-syslog.png"></a>

Click the Save button to save your changes.
snap-2-7-ui snap-2-8-ui snap-2-9-ui deb-2-7-ui deb-2-8-ui deb-2-9-ui -->

<!-- snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli
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

<strong>NOTE:</strong> 
Note that MAAS controllers' syslogs are not forwarded to the external syslog server -- only machine syslog information is forwarded.

snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli -->

