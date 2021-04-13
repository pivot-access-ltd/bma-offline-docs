||2.7|2.8|2.9|3.0|
|-----:|:-----:|:-----:|:-----:|:-----:|
Snap|[CLI](/t/maas-rsyslog-files-snap-2-7-cli/3430) ~ [UI](/t/maas-rsyslog-files-snap-2-7-ui/3431)|[CLI](/t/maas-rsyslog-files-snap-2-8-cli/3432) ~ [UI](/t/maas-rsyslog-files-snap-2-8-ui/3433)|[CLI](/t/maas-rsyslog-files-snap-2-9-cli/3434) ~ [UI](/t/maas-rsyslog-files-snap-2-9-ui/3435)|[CLI](/t/maas-rsyslog-files-snap-3-0-cli/4017) ~ [UI](/t/maas-rsyslog-files-snap-3-0-ui/4018)|
Packages|[CLI](/t/maas-rsyslog-files-deb-2-7-cli/3436) ~ [UI](/t/maas-rsyslog-files-deb-2-7-ui/3437)|[CLI](/t/maas-rsyslog-files-deb-2-8-cli/3438) ~ [UI](/t/maas-rsyslog-files-deb-2-8-ui/3439)|[CLI](/t/maas-rsyslog-files-deb-2-9-cli/3441) ~ [UI](/t/maas-rsyslog-files-deb-2-9-ui/3440)|[CLI](/t/maas-rsyslog-files-deb-3-0-cli/4019) ~ [UI](/t/maas-rsyslog-files-deb-3-0-ui/4020)|

<a href="#heading--add-or-update-a-remote-syslog-server"><h2 id="heading--add-or-update-a-remote-syslog-server">Add or update a remote syslog server</h2></a>

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


