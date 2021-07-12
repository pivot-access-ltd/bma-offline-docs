
MAAS has a robust logging capability, which presents several different views, including a number of node-specific log files and several syslogd-style text logs.  Each of these logs provides different information, or at the very least, different views of the same information.  MAAS gathers logging information about the various MAAS states and records both automated and user-driven actions.

#### Five questions you may have:

rad-begin /deb/2.9/cli
1. [What is the syslog logging path?](#heading--path)
2. [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
3. [What are commissioning logs?](/t/commissioning-logs/2500)
4. [What are test logs?](/t/test-logs/3136)
5. [What are event logs?](/t/event-logs/3393)
6. [What are audit event logs?](t/audit-event-logs/2320)
rad-end

rad-begin /deb/2.9/ui
1. [What is the syslog logging path?](#heading--path)
2. [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
3. [What are commissioning logs?](/t/commissioning-logs/2501)
4. [What are test logs?](/t/test-logs/3137)
5. [What are event logs?](/t/event-logs/3392)
6. [What are audit event logs?](t/audit-event-logs/2321)
rad-end

rad-begin /deb/3.0/cli
1. [What is the syslog logging path?](#heading--path)
2. [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
3. [What are commissioning logs?](/t/commissioning-logs/3871)
4. [What are test logs?](/t/test-logs/4119)
5. [What are event logs?](/t/event-logs/3927)
6. [What are audit event logs?](t/audit-event-logs/3831)
rad-end

rad-begin /deb/3.0/ui
1. [What is the syslog logging path?](#heading--path)
2. [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
3. [What are commissioning logs?](/t/commissioning-logs/3872)
4. [What are test logs?](/t/test-logs/4120)
5. [What are event logs?](/t/event-logs/3928)
6. [What are audit event logs?](t/audit-event-logs/3832)
rad-end

rad-begin /snap/2.9/cli
1. [What is the syslog logging path?](#heading--path)
2. [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
3. [What are commissioning logs?](/t/commissioning-logs/2494)
4. [What are test logs?](/t/test-logs/3130)
5. [What are event logs?](/t/event-logs/3386)
6. [What are audit event logs?](t/audit-event-logs/2314)
rad-end

rad-begin /snap/2.9/ui
1. [What is the syslog logging path?](#heading--path)
2. [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
3. [What are commissioning logs?](/t/commissioning-logs/2495)
4. [What are test logs?](/t/test-logs/3131)
5. [What are event logs?](/t/event-logs/3387)
6. [What are audit event logs?](t/audit-event-logs/2315)
rad-end

rad-begin /snap/3.0/cli
1. [What is the syslog logging path?](#heading--path)
2. [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
3. [What are commissioning logs?](/t/commissioning-logs/3869)
4. [What are test logs?](/t/test-logs/4117)
5. [What are event logs?](/t/event-logs/3925)
6. [What are audit event logs?](t/audit-event-logs/3829)
rad-end

rad-begin /snap/3.0/ui
1. [What is the syslog logging path?](#heading--path)
2. [How do I use a remote syslog server?](#heading--using-a-remote-syslog-server)
3. [What are commissioning logs?](/t/commissioning-logs/2495)
4. [What are test logs?](/t/test-logs/4118)
5. [What are event logs?](/t/event-logs/3926)
6. [What are audit event logs?](t/audit-event-logs/3830)
rad-end

The discussion of these logs and their contents can be very extensive, so each type of logging has its own documentation section, reachable from the left-hand menu -- or from the list of questions above.

<a href="#heading--path"><h2 id="heading--path">The syslog logging path</h2></a>

rad-begin     /deb/2.9/ui /deb/2.9/cli
Syslog data is kept in `/var/log/maas/rsyslog/<machine-name><yyyy-mm-dd>/messages`.  Every machine known to MAAS will have corresponding syslogs.
rad-end

rad-begin     /snap/2.9/ui /snap/2.9/cli
Syslog data is kept in `/var/snap/maas/common/log/rsyslog/<machine-name><yyyy-mm-dd>/messages`. Every machine known to MAAS will have corresponding syslogs.
rad-end

<a href="#heading--using-a-remote-syslog-server"><h2 id="heading--using-a-remote-syslog-server">Using a remote syslog server</h2></a>

rad-begin   /snap/2.9/ui   /deb/2.9/ui
To add a remote syslog server, click the Settings tab and then click the Network services tab. Scroll down to the Syslog section, where you can add a syslog URL or IP:

<a href="https://assets.ubuntu.com/v1/e139d4e9-installconfig-syslog__2.6-remote-syslog.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/e139d4e9-installconfig-syslog__2.6-remote-syslog.png"></a>

Click the Save button to save your changes.
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli
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
rad-end
