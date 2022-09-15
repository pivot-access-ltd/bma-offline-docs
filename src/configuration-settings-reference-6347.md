<!-- "Configuration settings reference" -->

- outline
-- general
*** this doc must have both UI and CLI versions
*** these will be (essentially) completely different docs
*** to avoid chasing so many tabs:
**** one tab for the entire UI version
**** one tab for the entire CLI version
** UI version (walks down the lhs navigation)
*** Basic configuration
**** General items
***** MAAS name (text box)
Use MAAS name and unicode emoji(s) to describe your MAAS instance.
Examples:
⛔ maas-prod
my-maas ⚠️ no-deploys

***** MAAS theme main colour (radio-button selection)
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
***** Enable analytics to shape improvements to user experience (checkbox)
The analytics used in MAAS are Google Analytics, Usabilla and Sentry Error Tracking. Data privacy
Notifications
***** Enable new release notifications (checkbox)
This applies to all users of MAAS. 
**** Security
***** TLS status
(icon) TLS disabled

You can enable TLS with a certificate and a private key in the CLI with the following command:

`maas config-tls enable $key $cert --port YYYY`
**** Commissioning
***** Machine settings
****** Default Ubuntu release used for commissioning (dropdown)
****** Default minimum kernel version (dropdown)
The default minimum kernel version used on all new and commissioned nodes
***** IPMI settings
****** MAAS generated IPMI username (text box)
****** K_g BMC key (text box)
Specify this key to encrypt all communication between IPMI clients and the BMC. Leave this blank for no encryption. IPMI and BMC key
****** MAAS generated IPMI user privilege level (radio buttons)
Admin
operator
User
**** Deployment
***** Default operating system used for deployment (dropdown)
***** Default OS release used for deployment (dropdown)
***** Default hardware sync interval (minutes) (text box)
**** Kernel parameters
***** Global boot parameters always passed to the kernel (text box)
*** Users
**** Search box
**** "Add user" button
**** User table
***** user name (sortable by ascending, descending, none)
***** real name (sortable by ascending, descending, none)
***** machines (sortable by ascending, descending, none)
***** Type
***** Last seen
***** Role
***** MAAS keys
***** Actions
****** edit button on each row
possibly greyed out based on current user role
****** delete button on each row
possibly greyed out based on current user role
**** paging buttons, if necessary
*** Images
**** Ubuntu
***** Enable the installation of proprietary drivers (i.e. HPVSA) (checkbox)
**** Windows
***** Windows KMS activation host (text box)
FQDN or IP address of the host that provides the KMS Windows activation service. (Only needed for Windows deployments using KMS activation.)
**** VMware
***** VMware vCenter server FQDN or IP address (text box)
VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.
***** VMware vCenter username (text box)
VMware vCenter server username which is passed to a deployed VMware ESXi host.
***** VMware vCenter password (text box)
VMware vCenter server password which is passed to a deployed VMware ESXi host.
***** VMware vCenter datacenter (text box)
VMware vCenter datacenter which is passed to a deployed VMware ESXi host.
*** License keys
**** search bar
**** "Add license key" button
**** table of licenses
***** Operating system (sortable by ascending, descending, none)
***** Distro series (sortable by ascending, descending, none)
***** Actions
****** edit button on each row
possibly greyed out based on current user role
****** delete button on each row
possibly greyed out based on current user role
**** paging buttons, if necessary
*** Storage
***** Default storage layout (dropdown)
Storage layout that is applied to a node when it is commissioned.
***** Erase nodes' disks prior to releasing (checkbox)
Forces users to always erase disks when releasing.
***** Use secure erase by default when erasing disks (checkbox)
Will only be used on devices that support secure erase. Other devices will fall back to full wipe or quick erase depending on the selected options.
***** Use quick erase by default when erasing disks (checkbox)
This is not a secure erase; it wipes only the beginning and end of each disk.
*** Network
**** Proxy
HTTP proxy used by MAAS to download images, and by provisioned machines for APT and YUM packages. (radio buttons)
***** Don't use a proxy
***** MAAS built-in
***** External
***** Peer
***** "External" or "Peer" radio button followed by a text box with instructions:
Enter the external proxy URL that the MAAS built-in proxy will use as an upstream cache peer. Machines will be configured to use MAAS' built-in proxy to download APT packages.
**** DNS
***** Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses) (text box)
Only used when MAAS is running its own DNS server. This value is used as the value of 'forwarders' in the DNS server config.
***** Enable DNSSEC validation of upstream zones (dropdown)
Only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.
***** List of external networks (not previously known), that will be allowed to use MAAS for DNS resolution (text box)
MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows to add extra networks (not previously known) to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.
**** NTP
***** Addresses of NTP servers (text box)
NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS's DHCP services.
***** Use external NTP servers only (check box)
Configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers, rack contoller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.
**** Syslog
***** Remote syslog server to forward machine logs (text box)
A remote syslog server that MAAS will set on enlisting, commissioning, testing, and deploying machines to send all log messages. Clearing this value will restore the default behaviour of forwarding syslog to MAAS.
**** Network discovery
***** Network discovery (dropdown)
When enabled, MAAS will use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.
***** Active subnet mapping interval (dropdown)
When enabled, each rack will scan subnets enabled for active mapping. This helps ensure discovery information is accurate and complete.
*** Scripts
**** Commissioning scripts
***** Search box
***** "Upload script" button
***** Table of scripts
****** script name (sortable by ascending, descending, none)
******* script names are clickable, expanding to show the script code
****** description (sortable by ascending, descending, none)
****** uploaded on (sortable by ascending, descending, none)
****** Actions
******* delete button on each row
possibly greyed out based on current user role
***** paging buttons, if necessary
**** Testing scripts
***** Search box
***** "Upload script" button
***** Table of scripts
****** script name (sortable by ascending, descending, none)
******* script names are clickable, expanding to show the script code
****** description (sortable by ascending, descending, none)
****** uploaded on (sortable by ascending, descending, none)
****** Actions
******* delete button on each row
possibly greyed out based on current user role
***** paging buttons, if necessary
*** DHCP snippets
**** Search box
**** "Add snippet" button
**** Table of snippets
***** Snippet name (sortable by ascending, descending, none)
****** snippet names are clickable, expanding to show snippet
***** Type (sortable by ascending, descending, none)
***** Applies to (sortable by ascending, descending, none)
***** Description (sortable by ascending, descending, none)
***** Enabled (sortable by ascending, descending, none)
***** Last edited (sortable by ascending, descending, none)
***** Actions
****** edit button on each row
possibly greyed out based on current user role
****** delete button on each row
possibly greyed out based on current user role
**** paging buttons, if necessary
*** Package repos
**** Search box
**** "Add PPA" button
**** "Add repository" button
**** Table of snippets
***** Repo name (sortable by ascending, descending, none)
***** URL (sortable by ascending, descending, none)
***** Enabled (sortable by ascending, descending, none)
***** Actions
****** edit button on each row
possibly greyed out based on current user role
****** delete button on each row
possibly greyed out based on current user role
**** paging buttons, if necessary
** CLI version (follows the pattern of the CLI help)
*** basic help text reprinted
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

*** :active_discovery_interval:
Active subnet mapping interval. When enabled, each rack will scan subnets enabled for active mapping. This helps ensure discovery information is accurate and complete.
*** :boot_images_auto_import:
Automatically import/refresh the boot images every 60 minutes.
*** :boot_images_no_proxy:
Set no_proxy with the image repository address when MAAS is behind (or set with) a proxy..         By default, when MAAS is behind (and set with) a proxy, it is used to download images from the image repository. In some situations (e.g. when using a local image repository) it doesn't make sense for MAAS to use the proxy to download images because it can access them directly. Setting this option allows MAAS to access the (local) image repository directly by setting the no_proxy variable for the MAAS env with the address of the image repository.
*** :commissioning_distro_series:
Default Ubuntu release used for commissioning.
*** :completed_intro:
Marks if the initial intro has been completed.
*** :curtin_verbose:
Run the fast-path installer with higher verbosity. This provides more detail in the installation logs.
*** :default_distro_series:
Default OS release used for deployment.
*** :default_dns_ttl:
Default Time-To-Live for the DNS.         If no TTL value is specified at a more specific point this is how long DNS responses are valid, in seconds.
*** :default_min_hwe_kernel: 
Default Minimum Kernel Version.         The default minimum kernel version used on all new and commissioned nodes.
*** :default_osystem: 
Default operating system used for deployment.
*** :default_storage_layout: 
Default storage layout.         Storage layout that is applied to a node when it is commissioned.        Available choices are:
'bcache' (Bcache layout), 'blank' (No storage (blank) layout), 'custom' (Custom layout (from commissioning storage config)), 'flat' (Flat layout), 'lvm' (LVM layout), 'vmfs6' (VMFS6 layout), 'vmfs7' (VMFS7 layout).
*** :disk_erase_with_quick_erase:
Use quick erase by default when erasing disks..         This is not a secure erase; it wipes only the beginning and end of each disk.
*** :disk_erase_with_secure_erase:
Use secure erase by default when erasing disks.         Will only be used on devices that support secure erase.  Other devices will fall back to full wipe or quick erase depending on the selected options.
*** :dns_trusted_acl:
List of external networks (not previously known), that will be allowed to use MAAS for DNS resolution..         MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows to add extra networks (not previously known) to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.
*** :dnssec_validation:
Enable DNSSEC validation of upstream zones.         Only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.
*** :enable_analytics:
Enable Google Analytics in MAAS UI to shape improvements in user experience.
*** :enable_disk_erasing_on_release:
Erase nodes' disks prior to releasing.         Forces users to always erase disks when releasing.
*** :enable_http_proxy:
Enable the use of an APT or YUM and HTTP/HTTPS proxy.         Provision nodes to use the built-in HTTP proxy (or user specified proxy) for APT or YUM. MAAS also uses the proxy for downloading boot images.
*** :enable_third_party_drivers:
Enable the installation of proprietary drivers (i.e. HPVSA).
*** :enlist_commissioning:
Whether to run commissioning during enlistment..         Enables running all built-in commissioning scripts during enlistment.
*** :force_v1_network_yaml:
Always use the legacy v1 YAML (rather than Netplan format, also known as v2 YAML) when composing the network configuration for a machine..
*** :hardware_sync_interval:
Hardware Sync Interval.         The interval to send hardware info to MAAS fromhardware sync enabled machines, in systemd time span syntax.
*** :http_proxy:
Proxy for APT or YUM and HTTP/HTTPS.         This will be passed onto provisioned nodes to use as a proxy for APT or YUM traffic. MAAS also uses the proxy for downloading boot images. If no URL is provided, the built-in MAAS proxy will be used.
*** :kernel_opts:
Boot parameters to pass to the kernel by default.
*** :maas_auto_ipmi_cipher_suite_id: 
MAAS IPMI Default Cipher Suite ID.         The default IPMI cipher suite ID to use when connecting to the BMC via ipmitools        Available choices are:
'' (freeipmi-tools default), '12' (12 - HMAC-MD5::MD5-128::AES-CBC-128), '17' (17 - HMAC-SHA256::HMAC_SHA256_128::AES-CBC-128), '3' (3 - HMAC-SHA1::HMAC-SHA1-96::AES-CBC-128), '8' (8 - HMAC-MD5::HMAC-MD5-128::AES-CBC-128).
*** :maas_auto_ipmi_k_g_bmc_key:
The IPMI K_g key to set during BMC configuration..         This IPMI K_g BMC key is used to encrypt all IPMI traffic to a BMC. Once set, all clients will REQUIRE this key upon being commissioned. Any current machines that were previously commissioned will not require this key until they are recommissioned.
*** :maas_auto_ipmi_user:
MAAS IPMI user..         The name of the IPMI user that MAAS automatically creates during enlistment/commissioning.
*** :maas_auto_ipmi_user_privilege_level:
MAAS IPMI privilege level.         The default IPMI privilege level to use when creating the MAAS user and talking IPMI BMCs        Available choices are:
'ADMIN' (Administrator), 'OPERATOR' (Operator), 'USER' (User).
*** :maas_auto_ipmi_workaround_flags: 
IPMI Workaround Flags.         The default workaround flag (-W options) to use for ipmipower commands        Available choices are:
'' (None), 'authcap' (Authcap), 'endianseq' (Endianseq), 'forcepermsg' (Forcepermsg), 'idzero' (Idzero), 'integritycheckvalue' (Integritycheckvalue), 'intel20' (Intel20), 'ipmiping' (Ipmiping), 'nochecksumcheck' (Nochecksumcheck), 'opensesspriv' (Opensesspriv), 'sun20' (Sun20), 'supermicro20' (Supermicro20), 'unexpectedauth' (Unexpectedauth).
*** :maas_internal_domain:
Domain name used by MAAS for internal mapping of MAAS provided services..         This domain should not collide with an upstream domain provided by the set upstream DNS.
*** :maas_name:
MAAS name.
*** :maas_proxy_port: 
Port to bind the MAAS built-in proxy (default: 8000).         Defines the port used to bind the built-in proxy. The default port is 8000.
*** :maas_syslog_port: 
Port to bind the MAAS built-in syslog (default: 5247).         Defines the port used to bind the built-in syslog. The default port is 5247.
*** :max_node_commissioning_results:
The maximum number of commissioning results runs which are stored.
*** :max_node_installation_results:
The maximum number of installation result runs which are stored.
*** :max_node_testing_results:
The maximum number of testing results runs which are stored.
*** :network_discovery:
When enabled, MAAS will use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.
*** :node_timeout:
Time, in minutes, until the node times out during commissioning, testing, deploying, or entering rescue mode..         Commissioning, testing, deploying, and entering rescue mode all set a timeout when beginning. If MAAS does not hear from the node within the specified number of minutes the node is powered off and set into a failed status.
*** :ntp_external_only:
Use external NTP servers only.         Configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers, rack contoller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.
*** :ntp_servers:
Addresses of NTP servers.         NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS's DHCP services.
*** :prefer_v4_proxy:
Sets IPv4 DNS resolution before IPv6.         If prefer_v4_proxy is set, the proxy will be set to prefer IPv4 DNS resolution before it attempts to perform IPv6 DNS resolution.
*** :prometheus_enabled:
Enable sending stats to a prometheus gateway..         Allows MAAS to send statistics to Prometheus. This requires the 'prometheus_push_gateway' to be set.
*** :prometheus_push_gateway:
Address or hostname of the Prometheus push gateway..         Defines the address or hostname of the Prometheus push gateway where MAAS will send data to.
*** :prometheus_push_interval:
Interval of how often to send data to Prometheus (default:to 60 minutes)..         The internal of how often MAAS will send stats to Prometheus in minutes.
*** :promtail_enabled:
Enable streaming logs to Promtail..         Whether to stream logs to Promtail
*** :promtail_port:
TCP port of the Promtail Push API..         Defines the TCP port of the Promtail push API where MAAS will stream logs to.
*** :release_notifications:
Enable or disable notifications for new MAAS releases..
*** :remote_syslog:
Remote syslog server to forward machine logs.         A remote syslog server that MAAS will set on enlisting, commissioning, testing, and deploying machines to send all log messages. Clearing this value will restore the default behaviour of forwarding syslog to MAAS.
*** :subnet_ip_exhaustion_threshold_count:
If the number of free IP addresses on a subnet becomes less than or equal to this threshold, an IP exhaustion warning will appear for that subnet.
*** :tls_cert_expiration_notification_enabled:
Notify when the certificate is due to expire.         Enable/Disable notification about certificate expiration.
*** :tls_cert_expiration_notification_interval:
Certificate expiration reminder (days).         Configure notification when certificate is due to expire in (days).
*** :upstream_dns:
Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses).         Only used when MAAS is running its own DNS server. This value is used as the value of 'forwarders' in the DNS server config.
*** :use_peer_proxy:
Use the built-in proxy with an external proxy as a peer.         If enable_http_proxy is set, the built-in proxy will be configured to use http_proxy as a peer proxy. The deployed machines will be configured to use the built-in proxy.
*** :use_rack_proxy:
Use DNS and HTTP metadata proxy on the rack controllers when a machine is booted..         All DNS and HTTP metadata traffic will flow through the rack controller that a machine is booting from. This isolated region controllers from machines.
*** :vcenter_datacenter:
VMware vCenter datacenter.         VMware vCenter datacenter which is passed to a deployed VMware ESXi host.
*** :vcenter_password:
VMware vCenter password.         VMware vCenter server password which is passed to a deployed VMware ESXi host.
*** :vcenter_server:
VMware vCenter server FQDN or IP address.         VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.
*** :vcenter_username:
VMware vCenter username.         VMware vCenter server username which is passed to a deployed VMware ESXi host.
*** :windows_kms_host:
Windows KMS activation host.         FQDN or IP address of the host that provides the KMS Windows activation service. (Only needed for Windows deployments using KMS activation.)