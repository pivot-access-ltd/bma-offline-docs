This article is a list of advanced tasks you can perform with the MAAS CLI.

#### Thirteen questions you may have:

2. [How do I edit machine hostname and power parameters?](/t/cli-advanced-tasks/793#heading--edit-node-hostname-and-power-parameters)
3.[How do I relay DHCP?](/t/cli-advanced-tasks/793#heading--relay-dhcp)
DNS?](/t/cli-advanced-tasks/793#heading--create-an-a-or-aaaa-record-in-dns)
11. [How do I create an alias (CNAME) record in DNS?](/t/cli-advanced-tasks/793#heading--create-an-alias-cname-record-in-dns)
12. [How do I create a Mail Exchange pointer record in DNS?](/t/cli-advanced-tasks/793#heading--create-a-mail-exchange-pointer-record-in-dns)
13. [How do I add or update a remote syslog server?](/t/cli-advanced-tasks/793#heading--add-or-update-a-remote-syslog-server)


<a href="#heading--create-an-a-or-aaaa-record-in-dns"><h2 id="heading--create-an-a-or-aaaa-record-in-dns">Create an A or AAAA record in DNS</h2></a>

An administrator can create an A record when creating a DNS resource with an IPv4 address.

``` bash
mass $PROFILE dnsresources create fqdn=$HOSTNAME.$DOMAIN ip_addresses=$IPV4ADDRESS
```

An administrator can create an AAAA record when creating a DNS resource with an IPv6 address.

``` bash
mass $PROFILE dnsresources create fqdn=$HOSTNAME.$DOMAIN ip_addresses=$IPV6ADDRESS
```

<a href="#heading--create-an-alias-cname-record-in-dns"><h2 id="heading--create-an-alias-cname-record-in-dns">Create an alias (CNAME) record in DNS</h2></a>

An administrator can set a DNS Alias (CNAME record) to an already existing DNS entry of a machine.

``` bash
mass $PROFILE dnsresource-records create fqdn=$HOSTNAME.$DOMAIN rrtype=cname rrdata=$ALIAS
```

For example, to set `webserver.maas.io` to alias to `www.maas.io`:

``` bash
maas $PROFILE dnsresource-records create fqdn=webserver.maas.io rrtype=cname rrdata=www
```

<a href="#heading--create-a-mail-exchange-pointer-record-in-dns"><h2 id="heading--create-a-mail-exchange-pointer-record-in-dns">Create a Mail Exchange pointer record in DNS</h2></a>

An administrator can set a DNS Mail Exchange pointer record (MX and value) to a domain.

``` bash
maas $PROFILE dnsresource-records create fqdn=$DOMAIN rrtype=mx rrdata='10 $MAIL_SERVER.$DOMAIN'
```

For example, to set the domain.name managed by MAAS to have an MX record and that you own the domain:

``` bash
maas $PROFILE dnsresource-records create fqdn=maas.io rrtype=mx rrdata='10 smtp.maas.io'
```

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
