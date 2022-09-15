<!-- "Configuration settings reference" -->

General notes: this doc must have both UI and CLI versions; these will be (essentially) completely different docs. to avoid chasing so many tabs, there will be one tab for the entire UI version, and one tab for the entire CLI version.

tab = UI version (walks down the lhs navigation)

<h2>Basic configuration</h2>

<h3>General items</h3>

<h4>MAAS name (text box)</h4>

Use MAAS name and unicode emoji(s) to describe your MAAS instance.
Examples:
⛔ maas-prod
my-maas ⚠️ no-deploys

<h4>MAAS theme main colour (radio-button selection)</h4>

Default
Bark
Sage
Olive
Viridian
Prussian green
Blue
Purple
Magenta
Red
Data analytics
<h4>Enable analytics to shape improvements to user experience (checkbox)</h4>

The analytics used in MAAS are Google Analytics, Usabilla and Sentry Error Tracking. Data privacy
Notifications
<h4>Enable new release notifications (checkbox)</h4>

This applies to all users of MAAS. 
<h3>Security</h3>

<h4>TLS status</h4>

(icon) TLS disabled

You can enable TLS with a certificate and a private key in the CLI with the following command:

`maas config-tls enable $key $cert --port YYYY`
<h3>Commissioning</h3>

<h4>Machine settings</h4>

<h5>Default Ubuntu release used for commissioning (dropdown)</h5>

<h5>Default minimum kernel version (dropdown)</h5>

The default minimum kernel version used on all new and commissioned nodes
<h4>IPMI settings</h4>

<h5>MAAS generated IPMI username (text box)</h5>

<h5>K_g BMC key (text box)</h5>

Specify this key to encrypt all communication between IPMI clients and the BMC. Leave this blank for no encryption. IPMI and BMC key
<h5>MAAS generated IPMI user privilege level (radio buttons)</h5>

Admin
operator
User
<h3>Deployment</h3>

<h4>Default operating system used for deployment (dropdown)</h4>

<h4>Default OS release used for deployment (dropdown)</h4>

<h4>Default hardware sync interval (minutes) (text box)</h4>

<h3>Kernel parameters</h3>

<h4>Global boot parameters always passed to the kernel (text box)</h4>

<h2>Users</h2>

<h3>Search box</h3>

<h3>"Add user" button</h3>

<h3>User table</h3>

<h4>user name (sortable by ascending, descending, none)</h4>

<h4>real name (sortable by ascending, descending, none)</h4>

<h4>machines (sortable by ascending, descending, none)</h4>

<h4>Type</h4>

<h4>Last seen</h4>

<h4>Role</h4>

<h4>MAAS keys</h4>

<h4>Actions</h4>

<h5>edit button on each row</h5>

possibly greyed out based on current user role
<h5>delete button on each row</h5>

possibly greyed out based on current user role
<h3>paging buttons, if necessary</h3>

<h2>Images</h2>

<h3>Ubuntu</h3>

<h4>Enable the installation of proprietary drivers (i.e. HPVSA) (checkbox)</h4>

<h3>Windows</h3>

<h4>Windows KMS activation host (text box)</h4>

FQDN or IP address of the host that provides the KMS Windows activation service. (Only needed for Windows deployments using KMS activation.)
<h3>VMware</h3>

<h4>VMware vCenter server FQDN or IP address (text box)</h4>

VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.
<h4>VMware vCenter username (text box)</h4>

VMware vCenter server username which is passed to a deployed VMware ESXi host.
<h4>VMware vCenter password (text box)</h4>

VMware vCenter server password which is passed to a deployed VMware ESXi host.
<h4>VMware vCenter datacenter (text box)</h4>

VMware vCenter datacenter which is passed to a deployed VMware ESXi host.
<h2>License keys</h2>

<h3>search bar</h3>

<h3>"Add license key" button</h3>

<h3>table of licenses</h3>

<h4>Operating system (sortable by ascending, descending, none)</h4>

<h4>Distro series (sortable by ascending, descending, none)</h4>

<h4>Actions</h4>

<h5>edit button on each row</h5>

possibly greyed out based on current user role
<h5>delete button on each row</h5>

possibly greyed out based on current user role
<h3>paging buttons, if necessary</h3>

<h2>Storage</h2>

<h4>Default storage layout (dropdown)</h4>

Storage layout that is applied to a node when it is commissioned.
<h4>Erase nodes' disks prior to releasing (checkbox)</h4>

Forces users to always erase disks when releasing.
<h4>Use secure erase by default when erasing disks (checkbox)</h4>

Will only be used on devices that support secure erase. Other devices will fall back to full wipe or quick erase depending on the selected options.
<h4>Use quick erase by default when erasing disks (checkbox)</h4>

This is not a secure erase; it wipes only the beginning and end of each disk.
<h2>Network</h2>

<h3>Proxy</h3>

HTTP proxy used by MAAS to download images, and by provisioned machines for APT and YUM packages. (radio buttons)
<h4>Don't use a proxy</h4>

<h4>MAAS built-in</h4>

<h4>External</h4>

<h4>Peer</h4>

<h4>"External" or "Peer" radio button followed by a text box with instructions:</h4>

Enter the external proxy URL that the MAAS built-in proxy will use as an upstream cache peer. Machines will be configured to use MAAS' built-in proxy to download APT packages.
<H3>DNS</h3>

<h4>Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses) (text box)</h4>

Only used when MAAS is running its own DNS server. This value is used as the value of 'forwarders' in the DNS server config.
<h4>Enable DNSSEC validation of upstream zones (dropdown)</h4>

Only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.
<h4>List of external networks (not previously known), that will be allowed to use MAAS for DNS resolution (text box)</h4>

MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows to add extra networks (not previously known) to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.
<H3>NTP</h3>

<h4>Addresses of NTP servers (text box)</h4>

NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS's DHCP services.
<h4>Use external NTP servers only (check box)</h4>

Configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers, rack contoller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.
<h3>Syslog</h3>

<h4>Remote syslog server to forward machine logs (text box)</h4>

A remote syslog server that MAAS will set on enlisting, commissioning, testing, and deploying machines to send all log messages. Clearing this value will restore the default behaviour of forwarding syslog to MAAS.
<h3>Network discovery</h3>

<h4>Network discovery (dropdown)</h4>

When enabled, MAAS will use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.
<h4>Active subnet mapping interval (dropdown)</h4>

When enabled, each rack will scan subnets enabled for active mapping. This helps ensure discovery information is accurate and complete.
<h2>Scripts</h2>

<h3>Commissioning scripts</h3>

<h4>Search box</h4>

<h4>"Upload script" button</h4>

<h4>Table of scripts</h4>

<h5>script name (sortable by ascending, descending, none)</h5>

******* script names are clickable, expanding to show the script code
<h5>description (sortable by ascending, descending, none)</h5>

<h5>uploaded on (sortable by ascending, descending, none)</h5>

<h5>Actions</h5>

******* delete button on each row
possibly greyed out based on current user role
<h4>paging buttons, if necessary</h4>

<h3>Testing scripts</h3>

<h4>Search box</h4>

<h4>"Upload script" button</h4>

<h4>Table of scripts</h4>

<h5>script name (sortable by ascending, descending, none)</h5>

******* script names are clickable, expanding to show the script code
<h5>description (sortable by ascending, descending, none)</h5>

<h5>uploaded on (sortable by ascending, descending, none)</h5>

<h5>Actions</h5>

******* delete button on each row
possibly greyed out based on current user role
<h4>paging buttons, if necessary</h4>

<h2>DHCP snippets</h2>

<h3>Search box</h3>

<h3>"Add snippet" button</h3>

<h3>Table of snippets</h3>

<h4>Snippet name (sortable by ascending, descending, none)</h4>

<h5>snippet names are clickable, expanding to show snippet</h5>

<h4>Type (sortable by ascending, descending, none)</h4>

<h4>Applies to (sortable by ascending, descending, none)</h4>

<h4>Description (sortable by ascending, descending, none)</h4>

<h4>Enabled (sortable by ascending, descending, none)</h4>

<h4>Last edited (sortable by ascending, descending, none)</h4>

<h4>Actions</h4>

<h5>edit button on each row</h5>

possibly greyed out based on current user role
<h5>delete button on each row</h5>

possibly greyed out based on current user role
<h3>paging buttons, if necessary</h3>

<h2>Package repos</h2>

<h3>Search box</h3>

<h3>"Add PPA" button</h3>

<h3>"Add repository" button</h3>

<h3>Table of snippets</h3>

<h4>Repo name (sortable by ascending, descending, none)</h4>

<h4>URL (sortable by ascending, descending, none)</h4>

<h4>Enabled (sortable by ascending, descending, none)</h4>

<h4>Actions</h4>

<h5>edit button on each row</h5>

possibly greyed out based on current user role
<h5>delete button on each row</h5>

possibly greyed out based on current user role
<h3>paging buttons, if necessary</h3>


tab = CLI version (follows the pattern of the CLI help)
<h2>basic help text reprinted</h2>

Set a configuration value


This method accepts keyword arguments.  Pass each argument as a
key-value pair with an equals sign between the key and the value:
key1=value1 key2=value key3=value3.  Keyword arguments must come after
any positional arguments.

Set a configuration value.

:param value: Optional.  The value of the configuration
item to be set.
:type value: String

 :param name: Required.  The name of the
configuration item to be set.

Available configuration items:

:active_discovery_interval: Active subnet mapping interval.         When enabled, each rack will scan subnets enabled for active mapping. This helps ensure discovery information is accurate and complete.
:boot_images_auto_import: Automatically import/refresh the boot images every 60 minutes.
:boot_images_no_proxy: Set no_proxy with the image repository address when MAAS is behind (or set with) a proxy..         By default, when MAAS is behind (and set with) a proxy, it is used to download images from the image repository. In some situations (e.g. when using a local image repository) it doesn't make sense for MAAS to use the proxy to download images because it can access them directly. Setting this option allows MAAS to access the (local) image repository directly by setting the no_proxy variable for the MAAS env with the address of the image repository.
:commissioning_distro_series: Default Ubuntu release used for commissioning.
:completed_intro: Marks if the initial intro has been completed.
:curtin_verbose: Run the fast-path installer with higher verbosity. This provides more detail in the installation logs.
:default_distro_series: Default OS release used for deployment.
:default_dns_ttl: Default Time-To-Live for the DNS.         If no TTL value is specified at a more specific point this is how long DNS responses are valid, in seconds.
:default_min_hwe_kernel: Default Minimum Kernel Version.         The default minimum kernel version used on all new and commissioned nodes.
:default_osystem: Default operating system used for deployment.
:default_storage_layout: Default storage layout.         Storage layout that is applied to a node when it is commissioned.        Available choices are: 'bcache' (Bcache layout), 'blank' (No storage (blank) layout), 'custom' (Custom layout (from commissioning storage config)), 'flat' (Flat layout), 'lvm' (LVM layout), 'vmfs6' (VMFS6 layout), 'vmfs7' (VMFS7 layout).
:disk_erase_with_quick_erase: Use quick erase by default when erasing disks..         This is not a secure erase; it wipes only the beginning and end of each disk.
:disk_erase_with_secure_erase: Use secure erase by default when erasing disks.         Will only be used on devices that support secure erase.  Other devices will fall back to full wipe or quick erase depending on the selected options.
:dns_trusted_acl: List of external networks (not previously known), that will be allowed to use MAAS for DNS resolution..         MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows to add extra networks (not previously known) to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.
:dnssec_validation: Enable DNSSEC validation of upstream zones.         Only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.
:enable_analytics: Enable Google Analytics in MAAS UI to shape improvements in user experience.
:enable_disk_erasing_on_release: Erase nodes' disks prior to releasing.         Forces users to always erase disks when releasing.
:enable_http_proxy: Enable the use of an APT or YUM and HTTP/HTTPS proxy.         Provision nodes to use the built-in HTTP proxy (or user specified proxy) for APT or YUM. MAAS also uses the proxy for downloading boot images.
:enable_third_party_drivers: Enable the installation of proprietary drivers (i.e. HPVSA).
:enlist_commissioning: Whether to run commissioning during enlistment..         Enables running all built-in commissioning scripts during enlistment.
:force_v1_network_yaml: Always use the legacy v1 YAML (rather than Netplan format, also known as v2 YAML) when composing the network configuration for a machine..
:hardware_sync_interval: Hardware Sync Interval.         The interval to send hardware info to MAAS fromhardware sync enabled machines, in systemd time span syntax.
:http_proxy: Proxy for APT or YUM and HTTP/HTTPS.         This will be passed onto provisioned nodes to use as a proxy for APT or YUM traffic. MAAS also uses the proxy for downloading boot images. If no URL is provided, the built-in MAAS proxy will be used.
:kernel_opts: Boot parameters to pass to the kernel by default.
:maas_auto_ipmi_cipher_suite_id: MAAS IPMI Default Cipher Suite ID.         The default IPMI cipher suite ID to use when connecting to the BMC via ipmitools        Available choices are: '' (freeipmi-tools default), '12' (12 - HMAC-MD5::MD5-128::AES-CBC-128), '17' (17 - HMAC-SHA256::HMAC_SHA256_128::AES-CBC-128), '3' (3 - HMAC-SHA1::HMAC-SHA1-96::AES-CBC-128), '8' (8 - HMAC-MD5::HMAC-MD5-128::AES-CBC-128).
:maas_auto_ipmi_k_g_bmc_key: The IPMI K_g key to set during BMC configuration..         This IPMI K_g BMC key is used to encrypt all IPMI traffic to a BMC. Once set, all clients will REQUIRE this key upon being commissioned. Any current machines that were previously commissioned will not require this key until they are recommissioned.
:maas_auto_ipmi_user: MAAS IPMI user..         The name of the IPMI user that MAAS automatically creates during enlistment/commissioning.
:maas_auto_ipmi_user_privilege_level: MAAS IPMI privilege level.         The default IPMI privilege level to use when creating the MAAS user and talking IPMI BMCs        Available choices are: 'ADMIN' (Administrator), 'OPERATOR' (Operator), 'USER' (User).
:maas_auto_ipmi_workaround_flags: IPMI Workaround Flags.         The default workaround flag (-W options) to use for ipmipower commands        Available choices are: '' (None), 'authcap' (Authcap), 'endianseq' (Endianseq), 'forcepermsg' (Forcepermsg), 'idzero' (Idzero), 'integritycheckvalue' (Integritycheckvalue), 'intel20' (Intel20), 'ipmiping' (Ipmiping), 'nochecksumcheck' (Nochecksumcheck), 'opensesspriv' (Opensesspriv), 'sun20' (Sun20), 'supermicro20' (Supermicro20), 'unexpectedauth' (Unexpectedauth).
:maas_internal_domain: Domain name used by MAAS for internal mapping of MAAS provided services..         This domain should not collide with an upstream domain provided by the set upstream DNS.
:maas_name: MAAS name.
:maas_proxy_port: Port to bind the MAAS built-in proxy (default: 8000).         Defines the port used to bind the built-in proxy. The default port is 8000.
:maas_syslog_port: Port to bind the MAAS built-in syslog (default: 5247).         Defines the port used to bind the built-in syslog. The default port is 5247.
:max_node_commissioning_results: The maximum number of commissioning results runs which are stored.
:max_node_installation_results: The maximum number of installation result runs which are stored.
:max_node_testing_results: The maximum number of testing results runs which are stored.
:network_discovery: .         When enabled, MAAS will use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.
:node_timeout: Time, in minutes, until the node times out during commissioning, testing, deploying, or entering rescue mode..         Commissioning, testing, deploying, and entering rescue mode all set a timeout when beginning. If MAAS does not hear from the node within the specified number of minutes the node is powered off and set into a failed status.
:ntp_external_only: Use external NTP servers only.         Configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers, rack contoller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.
:ntp_servers: Addresses of NTP servers.         NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS's DHCP services.
:prefer_v4_proxy: Sets IPv4 DNS resolution before IPv6.         If prefer_v4_proxy is set, the proxy will be set to prefer IPv4 DNS resolution before it attempts to perform IPv6 DNS resolution.
:prometheus_enabled: Enable sending stats to a prometheus gateway..         Allows MAAS to send statistics to Prometheus. This requires the 'prometheus_push_gateway' to be set.
:prometheus_push_gateway: Address or hostname of the Prometheus push gateway..         Defines the address or hostname of the Prometheus push gateway where MAAS will send data to.
:prometheus_push_interval: Interval of how often to send data to Prometheus (default: to 60 minutes)..         The internal of how often MAAS will send stats to Prometheus in minutes.
:promtail_enabled: Enable streaming logs to Promtail..         Whether to stream logs to Promtail
:promtail_port: TCP port of the Promtail Push API..         Defines the TCP port of the Promtail push API where MAAS will stream logs to.
:release_notifications: Enable or disable notifications for new MAAS releases..
:remote_syslog: Remote syslog server to forward machine logs.         A remote syslog server that MAAS will set on enlisting, commissioning, testing, and deploying machines to send all log messages. Clearing this value will restore the default behaviour of forwarding syslog to MAAS.
:subnet_ip_exhaustion_threshold_count: If the number of free IP addresses on a subnet becomes less than or equal to this threshold, an IP exhaustion warning will appear for that subnet.
:tls_cert_expiration_notification_enabled: Notify when the certificate is due to expire.         Enable/Disable notification about certificate expiration.
:tls_cert_expiration_notification_interval: Certificate expiration reminder (days).         Configure notification when certificate is due to expire in (days).
:upstream_dns: Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses).         Only used when MAAS is running its own DNS server. This value is used as the value of 'forwarders' in the DNS server config.
:use_peer_proxy: Use the built-in proxy with an external proxy as a peer.         If enable_http_proxy is set, the built-in proxy will be configured to use http_proxy as a peer proxy. The deployed machines will be configured to use the built-in proxy.
:use_rack_proxy: Use DNS and HTTP metadata proxy on the rack controllers when a machine is booted..         All DNS and HTTP metadata traffic will flow through the rack controller that a machine is booting from. This isolated region controllers from machines.
:vcenter_datacenter: VMware vCenter datacenter.         VMware vCenter datacenter which is passed to a deployed VMware ESXi host.
:vcenter_password: VMware vCenter password.         VMware vCenter server password which is passed to a deployed VMware ESXi host.
:vcenter_server: VMware vCenter server FQDN or IP address.         VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.
:vcenter_username: VMware vCenter username.         VMware vCenter server username which is passed to a deployed VMware ESXi host.
:windows_kms_host: Windows KMS activation host.         FQDN or IP address of the host that provides the KMS Windows activation service. (Only needed for Windows deployments using KMS activation.)
:type name: String

<h2>:active_discovery_interval:</h2>

Active subnet mapping interval. When enabled, each rack will scan subnets enabled for active mapping. This helps ensure discovery information is accurate and complete.
<h2>:boot_images_auto_import:</h2>

Automatically import/refresh the boot images every 60 minutes.
<h2>:boot_images_no_proxy:</h2>

Set no_proxy with the image repository address when MAAS is behind (or set with) a proxy..         By default, when MAAS is behind (and set with) a proxy, it is used to download images from the image repository. In some situations (e.g. when using a local image repository) it doesn't make sense for MAAS to use the proxy to download images because it can access them directly. Setting this option allows MAAS to access the (local) image repository directly by setting the no_proxy variable for the MAAS env with the address of the image repository.
<h2>:commissioning_distro_series:</h2>

Default Ubuntu release used for commissioning.
<h2>:completed_intro:</h2>

Marks if the initial intro has been completed.
<h2>:curtin_verbose:</h2>

Run the fast-path installer with higher verbosity. This provides more detail in the installation logs.
<h2>:default_distro_series:</h2>

Default OS release used for deployment.
<h2>:default_dns_ttl:</h2>

Default Time-To-Live for the DNS.         If no TTL value is specified at a more specific point this is how long DNS responses are valid, in seconds.
<h2>:default_min_hwe_kernel: </h2>

Default Minimum Kernel Version.         The default minimum kernel version used on all new and commissioned nodes.
<h2>:default_osystem: </h2>

Default operating system used for deployment.
<h2>:default_storage_layout: </h2>

Default storage layout.         Storage layout that is applied to a node when it is commissioned.        Available choices are:
'bcache' (Bcache layout), 'blank' (No storage (blank) layout), 'custom' (Custom layout (from commissioning storage config)), 'flat' (Flat layout), 'lvm' (LVM layout), 'vmfs6' (VMFS6 layout), 'vmfs7' (VMFS7 layout).
<h2>:disk_erase_with_quick_erase:</h2>

Use quick erase by default when erasing disks..         This is not a secure erase; it wipes only the beginning and end of each disk.
<h2>:disk_erase_with_secure_erase:</h2>

Use secure erase by default when erasing disks.         Will only be used on devices that support secure erase.  Other devices will fall back to full wipe or quick erase depending on the selected options.
<h2>:dns_trusted_acl:</h2>

List of external networks (not previously known), that will be allowed to use MAAS for DNS resolution..         MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows to add extra networks (not previously known) to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.
<h2>:dnssec_validation:</h2>

Enable DNSSEC validation of upstream zones.         Only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.
<h2>:enable_analytics:</h2>

Enable Google Analytics in MAAS UI to shape improvements in user experience.
<h2>:enable_disk_erasing_on_release:</h2>

Erase nodes' disks prior to releasing.         Forces users to always erase disks when releasing.
<h2>:enable_http_proxy:</h2>

Enable the use of an APT or YUM and HTTP/HTTPS proxy.         Provision nodes to use the built-in HTTP proxy (or user specified proxy) for APT or YUM. MAAS also uses the proxy for downloading boot images.
<h2>:enable_third_party_drivers:</h2>

Enable the installation of proprietary drivers (i.e. HPVSA).
<h2>:enlist_commissioning:</h2>

Whether to run commissioning during enlistment..         Enables running all built-in commissioning scripts during enlistment.
<h2>:force_v1_network_yaml:</h2>

Always use the legacy v1 YAML (rather than Netplan format, also known as v2 YAML) when composing the network configuration for a machine..
<h2>:hardware_sync_interval:</h2>

Hardware Sync Interval.         The interval to send hardware info to MAAS fromhardware sync enabled machines, in systemd time span syntax.
<h2>:http_proxy:</h2>

Proxy for APT or YUM and HTTP/HTTPS.         This will be passed onto provisioned nodes to use as a proxy for APT or YUM traffic. MAAS also uses the proxy for downloading boot images. If no URL is provided, the built-in MAAS proxy will be used.
<h2>:kernel_opts:</h2>

Boot parameters to pass to the kernel by default.
<h2>:maas_auto_ipmi_cipher_suite_id: </h2>

MAAS IPMI Default Cipher Suite ID.         The default IPMI cipher suite ID to use when connecting to the BMC via ipmitools        Available choices are:
'' (freeipmi-tools default), '12' (12 - HMAC-MD5::MD5-128::AES-CBC-128), '17' (17 - HMAC-SHA256::HMAC_SHA256_128::AES-CBC-128), '3' (3 - HMAC-SHA1::HMAC-SHA1-96::AES-CBC-128), '8' (8 - HMAC-MD5::HMAC-MD5-128::AES-CBC-128).
<h2>:maas_auto_ipmi_k_g_bmc_key:</h2>

The IPMI K_g key to set during BMC configuration..         This IPMI K_g BMC key is used to encrypt all IPMI traffic to a BMC. Once set, all clients will REQUIRE this key upon being commissioned. Any current machines that were previously commissioned will not require this key until they are recommissioned.
<h2>:maas_auto_ipmi_user:</h2>

MAAS IPMI user..         The name of the IPMI user that MAAS automatically creates during enlistment/commissioning.
<h2>:maas_auto_ipmi_user_privilege_level:</h2>

MAAS IPMI privilege level.         The default IPMI privilege level to use when creating the MAAS user and talking IPMI BMCs        Available choices are:
'ADMIN' (Administrator), 'OPERATOR' (Operator), 'USER' (User).
<h2>:maas_auto_ipmi_workaround_flags: </h2>

IPMI Workaround Flags.         The default workaround flag (-W options) to use for ipmipower commands        Available choices are:
'' (None), 'authcap' (Authcap), 'endianseq' (Endianseq), 'forcepermsg' (Forcepermsg), 'idzero' (Idzero), 'integritycheckvalue' (Integritycheckvalue), 'intel20' (Intel20), 'ipmiping' (Ipmiping), 'nochecksumcheck' (Nochecksumcheck), 'opensesspriv' (Opensesspriv), 'sun20' (Sun20), 'supermicro20' (Supermicro20), 'unexpectedauth' (Unexpectedauth).
<h2>:maas_internal_domain:</h2>

Domain name used by MAAS for internal mapping of MAAS provided services..         This domain should not collide with an upstream domain provided by the set upstream DNS.
<h2>:maas_name:</h2>

MAAS name.
<h2>:maas_proxy_port: </h2>

Port to bind the MAAS built-in proxy (default: 8000).         Defines the port used to bind the built-in proxy. The default port is 8000.
<h2>:maas_syslog_port: </h2>

Port to bind the MAAS built-in syslog (default: 5247).         Defines the port used to bind the built-in syslog. The default port is 5247.
<h2>:max_node_commissioning_results:</h2>

The maximum number of commissioning results runs which are stored.
<h2>:max_node_installation_results:</h2>

The maximum number of installation result runs which are stored.
<h2>:max_node_testing_results:</h2>

The maximum number of testing results runs which are stored.
<h2>:network_discovery:</h2>

When enabled, MAAS will use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.
<h2>:node_timeout:</h2>

Time, in minutes, until the node times out during commissioning, testing, deploying, or entering rescue mode..         Commissioning, testing, deploying, and entering rescue mode all set a timeout when beginning. If MAAS does not hear from the node within the specified number of minutes the node is powered off and set into a failed status.
<h2>:ntp_external_only:</h2>

Use external NTP servers only.         Configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers, rack contoller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.
<h2>:ntp_servers:</h2>

Addresses of NTP servers.         NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS's DHCP services.
<h2>:prefer_v4_proxy:</h2>

Sets IPv4 DNS resolution before IPv6.         If prefer_v4_proxy is set, the proxy will be set to prefer IPv4 DNS resolution before it attempts to perform IPv6 DNS resolution.
<h2>:prometheus_enabled:</h2>

Enable sending stats to a prometheus gateway..         Allows MAAS to send statistics to Prometheus. This requires the 'prometheus_push_gateway' to be set.
<h2>:prometheus_push_gateway:</h2>

Address or hostname of the Prometheus push gateway..         Defines the address or hostname of the Prometheus push gateway where MAAS will send data to.
<h2>:prometheus_push_interval:</h2>

Interval of how often to send data to Prometheus (default:to 60 minutes)..         The internal of how often MAAS will send stats to Prometheus in minutes.
<h2>:promtail_enabled:</h2>

Enable streaming logs to Promtail..         Whether to stream logs to Promtail
<h2>:promtail_port:</h2>

TCP port of the Promtail Push API..         Defines the TCP port of the Promtail push API where MAAS will stream logs to.
<h2>:release_notifications:</h2>

Enable or disable notifications for new MAAS releases..
<h2>:remote_syslog:</h2>

Remote syslog server to forward machine logs.         A remote syslog server that MAAS will set on enlisting, commissioning, testing, and deploying machines to send all log messages. Clearing this value will restore the default behaviour of forwarding syslog to MAAS.
<h2>:subnet_ip_exhaustion_threshold_count:</h2>

If the number of free IP addresses on a subnet becomes less than or equal to this threshold, an IP exhaustion warning will appear for that subnet.
<h2>:tls_cert_expiration_notification_enabled:</h2>

Notify when the certificate is due to expire.         Enable/Disable notification about certificate expiration.
<h2>:tls_cert_expiration_notification_interval:</h2>

Certificate expiration reminder (days).         Configure notification when certificate is due to expire in (days).
<h2>:upstream_dns:</h2>

Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses).         Only used when MAAS is running its own DNS server. This value is used as the value of 'forwarders' in the DNS server config.
<h2>:use_peer_proxy:</h2>

Use the built-in proxy with an external proxy as a peer.         If enable_http_proxy is set, the built-in proxy will be configured to use http_proxy as a peer proxy. The deployed machines will be configured to use the built-in proxy.
<h2>:use_rack_proxy:</h2>

Use DNS and HTTP metadata proxy on the rack controllers when a machine is booted..         All DNS and HTTP metadata traffic will flow through the rack controller that a machine is booting from. This isolated region controllers from machines.
<h2>:vcenter_datacenter:</h2>

VMware vCenter datacenter.         VMware vCenter datacenter which is passed to a deployed VMware ESXi host.
<h2>:vcenter_password:</h2>

VMware vCenter password.         VMware vCenter server password which is passed to a deployed VMware ESXi host.
<h2>:vcenter_server:</h2>

VMware vCenter server FQDN or IP address.         VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.
<h2>:vcenter_username:</h2>

VMware vCenter username.         VMware vCenter server username which is passed to a deployed VMware ESXi host.
<h2>:windows_kms_host:</h2>

Windows KMS activation host.         FQDN or IP address of the host that provides the KMS Windows activation service. (Only needed for Windows deployments using KMS activation.)