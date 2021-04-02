13. [How do I add or update a remote syslog server?](/t/cli-advanced-tasks/793#heading--add-or-update-a-remote-syslog-server)


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



------
****
------
