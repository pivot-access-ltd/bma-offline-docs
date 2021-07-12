
This is how a markdown file
handles a newline in the middle of a paragraph.

The MAAS rsyslog files allow you to monitor what's going on within individual MAAS machines. They are located at
rad-begin     /snap/2.9/ui /snap/2.9/cli /snap/3.0/ui /snap/3.0/cli
`/var/snap/maas/common/log/rsyslog/`. 
rad-end
rad-begin     /deb/2.9/ui /deb/2.9/cli /deb/3.0/ui /deb/3.0/cli
`/var/log/maas/rsyslog`. 
rad-end
Within this directory, there is one subdirectory for each machine, and within machine subirectories, there is one directory for each date upon which logging data was collected. These files will give you a great deal of the information you need to debug issues with your machines.

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


