<!-- "Configuration settings reference" -->

MAAS has a significant number of configuration settings.  This article will list these settings and their possible values, with brief instructions on how to adjust each setting.

[tabs]
[tab version="v3.3 Snap,v3.3 Packages" view="UI"]
The MAAS UI provides a Settings tab at the top of the MAAS interface:

![image|690x111](upload://cUehOV6KmXVErPmkMQgTers3i6h.png) 

<a href="#heading--Basic-configuration"><h2 id="heading--Basic-configuration">Basic configuration</h2></a>

<a href="#heading--General-items"><h3 id="heading--General-items">General items</h3></a>

<a href="#heading--MAAS-name"><h4 id="heading--MAAS-name">MAAS name (text box)</h4></a>

Use MAAS name and unicode emoji(s) to describe your MAAS instance.
Examples:
⛔ maas-prod
my-maas ⚠️ no-deploys

<a href="#heading--MAAS-theme-main-colour"><h4 id="heading--MAAS-theme-main-colour">MAAS theme main colour (radio-button selection)</h4></a>

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

<a href="#heading--Enable-analytics-to-shape-improvements-to-user-experience"><h4 id="heading--Enable-analytics-to-shape-improvements-to-user-experience">Enable analytics to shape improvements to user experience (checkbox)</h4></a>

The analytics used in MAAS are Google Analytics, Usabilla and Sentry Error Tracking. Data privacy
Notifications

<a href="#heading--Enable-new-release-notifications"><h4 id="heading--Enable-new-release-notifications">Enable new release notifications (checkbox)</h4></a>

This applies to all users of MAAS.

<a href="#heading--Security"><h3 id="heading--Security">Security</h3></a>

<a href="#heading--TLS-status"><h4 id="heading--TLS-status">TLS status</h4></a>

(icon) TLS disabled

You can enable TLS with a certificate and a private key in the CLI with the following command:

`maas config-tls enable $key $cert --port YYYY`

<a href="#heading--Commissioning"><h3 id="heading--Commissioning">Commissioning</h3></a>

<a href="#heading--Machine-settings"><h4 id="heading--Machine-settings">Machine settings</h4></a>

<a href="#heading--Default-Ubuntu-release-used-for-commissioning"><h5 id="heading--Default-Ubuntu-release-used-for-commissioning">Default Ubuntu release used for commissioning (dropdown)</h5></a>

<a href="#heading--Default-minimum-kernel-version"><h5 id="heading--Default-minimum-kernel-version">Default minimum kernel version (dropdown)</h5></a>

The default minimum kernel version used on all new and commissioned nodes

<a href="#heading--IPMI-settings"><h4 id="heading--IPMI-settings">IPMI settings</h4></a>

<a href="#heading--MAAS-generated-IPMI-username"><h5 id="heading--MAAS-generated-IPMI-username">MAAS generated IPMI username (text box)</h5></a>

<a href="#heading--K_g-BMC-key"><h5 id="heading--K_g-BMC-key">K_g BMC key (text box)</h5></a>

Specify this key to encrypt all communication between IPMI clients and the BMC. Leave this blank for no encryption. IPMI and BMC key

<a href="#heading--MAAS-generated-IPMI-user-privilege-level"><h5 id="heading--MAAS-generated-IPMI-user-privilege-level">MAAS generated IPMI user privilege level (radio buttons)</h5></a>

Admin
operator
User

<a href="#heading--Deployment"><h3 id="heading--Deployment">Deployment</h3></a>

<a href="#heading--Default-operating-system-used-for-deployment"><h4 id="heading--Default-operating-system-used-for-deployment">Default operating system used for deployment (dropdown)</h4></a>

<a href="#heading--Default-OS-release-used-for-deployment"><h4 id="heading--Default-OS-release-used-for-deployment">Default OS release used for deployment (dropdown)</h4></a>

<a href="#heading--Default-hardware-sync-interval-(minutes)"><h4 id="heading--Default-hardware-sync-interval-(minutes)">Default hardware sync interval (minutes) (text box)</h4></a>

<a href="#heading--Kernel-parameters"><h3 id="heading--Kernel-parameters">Kernel parameters</h3></a>

<a href="#heading--Global-boot-parameters-always-passed-to-the-kernel"><h4 id="heading--Global-boot-parameters-always-passed-to-the-kernel">Global boot parameters always passed to the kernel (text box)</h4></a>

<a href="#heading--Users"><h2 id="heading--Users">Users</h2></a>

<a href="#heading--Search-box3"><h3 id="heading--Search-box3">Search box</h3></a>

<a href="#heading--Add-user-button"><h3 id="heading--Add-user-button">Add user button</h3></a>

<a href="#heading--User-table"><h3 id="heading--User-table">User table</h3></a>

<a href="#heading--user-name"><h4 id="heading--user-name">user name (sortable by ascending, descending, none)</h4></a>

<a href="#heading--real-name"><h4 id="heading--real-name">real name (sortable by ascending, descending, none)</h4></a>

<a href="#heading--machines"><h4 id="heading--machines">machines (sortable by ascending, descending, none)</h4></a>

<a href="#heading--Type1"><h4 id="heading--Type1">Type</h4></a>

<a href="#heading--Last-seen"><h4 id="heading--Last-seen">Last seen</h4></a>

<a href="#heading--Role"><h4 id="heading--Role">Role</h4></a>

<a href="#heading--MAAS-keys"><h4 id="heading--MAAS-keys">MAAS keys</h4></a>

<a href="#heading--Actions1"><h4 id="heading--Actions1">Actions</h4></a>

<a href="#heading--edit-button-on-each-row1"><h5 id="heading--edit-button-on-each-row1">edit button on each row</h5></a>

possibly greyed out based on current user role

<a href="#heading--delete-button-on-each-row1"><h5 id="heading--delete-button-on-each-row1">delete button on each row</h5></a>

possibly greyed out based on current user role

<a href="#heading--paging-buttons1"><h3 id="heading--paging-buttons1">paging buttons, if necessary</h3></a>

<a href="#heading--Images"><h2 id="heading--Images">Images</h2></a>

<a href="#heading--Ubuntu"><h3 id="heading--Ubuntu">Ubuntu</h3></a>

<a href="#heading--Enable-the-installation-of-proprietary-drivers-(i.e.-HPVSA)"><h4 id="heading--Enable-the-installation-of-proprietary-drivers-(i.e.-HPVSA)">Enable the installation of proprietary drivers (i.e. HPVSA) (checkbox)</h4></a>

<a href="#heading--Windows"><h3 id="heading--Windows">Windows</h3></a>

<a href="#heading--Windows-KMS-activation-host"><h4 id="heading--Windows-KMS-activation-host">Windows KMS activation host (text box)</h4></a>

FQDN or IP address of the host that provides the KMS Windows activation service. (Only needed for Windows deployments using KMS activation.)

<a href="#heading--VMware"><h3 id="heading--VMware">VMware</h3></a>

<a href="#heading--VMware-vCenter-server-FQDN-or-IP-address"><h4 id="heading--VMware-vCenter-server-FQDN-or-IP-address">VMware vCenter server FQDN or IP address (text box)</h4></a>

VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.

<a href="#heading--VMware-vCenter-username"><h4 id="heading--VMware-vCenter-username">VMware vCenter username (text box)</h4></a>

VMware vCenter server username which is passed to a deployed VMware ESXi host.

<a href="#heading--VMware-vCenter-password"><h4 id="heading--VMware-vCenter-password">VMware vCenter password (text box)</h4></a>

VMware vCenter server password which is passed to a deployed VMware ESXi host.

<a href="#heading--VMware-vCenter-datacenter"><h4 id="heading--VMware-vCenter-datacenter">VMware vCenter datacenter (text box)</h4></a>

VMware vCenter datacenter which is passed to a deployed VMware ESXi host.

<a href="#heading--License-keys"><h2 id="heading--License-keys">License keys</h2></a>

<a href="#heading--search-bar"><h3 id="heading--search-bar">search bar</h3></a>

<a href="#heading--Add-license-key-button"><h3 id="heading--Add-license-key-button">Add license key button</h3></a>

<a href="#heading--table-of-licenses"><h3 id="heading--table-of-licenses">table of licenses</h3></a>

<a href="#heading--Operating-system"><h4 id="heading--Operating-system">Operating system (sortable by ascending, descending, none)</h4></a>

<a href="#heading--Distro-series"><h4 id="heading--Distro-series">Distro series (sortable by ascending, descending, none)</h4></a>

<a href="#heading--Actions2"><h4 id="heading--Actions2">Actions</h4></a>

<a href="#heading--edit-button-on-each-row2"><h5 id="heading--edit-button-on-each-row2">edit button on each row</h5></a>

possibly greyed out based on current user role

<a href="#heading--delete-button-on-each-row2"><h5 id="heading--delete-button-on-each-row2">delete button on each row</h5></a>

possibly greyed out based on current user role

<a href="#heading--paging-buttons2"><h3 id="heading--paging-buttons2">paging buttons, if necessary</h3></a>

<a href="#heading--Storage"><h2 id="heading--Storage">Storage</h2></a>

<a href="#heading--Default-storage-layout"><h4 id="heading--Default-storage-layout">Default storage layout (dropdown)</h4></a>

Storage layout that is applied to a node when it is commissioned.

<a href="#heading--Erase-node-disks-prior-to-releasing"><h4 id="heading--Erase-node-disks-prior-to-releasing">Erase node disks prior to releasing (checkbox)</h4></a>

Forces users to always erase disks when releasing.

<a href="#heading--Use-secure-erase-by-default-when-erasing-disks"><h4 id="heading--Use-secure-erase-by-default-when-erasing-disks">Use secure erase by default when erasing disks (checkbox)</h4></a>

Will only be used on devices that support secure erase. Other devices will fall back to full wipe or quick erase depending on the selected options.

<a href="#heading--Use-quick-erase-by-default-when-erasing-disks"><h4 id="heading--Use-quick-erase-by-default-when-erasing-disks">Use quick erase by default when erasing disks (checkbox)</h4></a>

This is not a secure erase; it wipes only the beginning and end of each disk.

<a href="#heading--Network"><h2 id="heading--Network">Network</h2></a>

<a href="#heading--Proxy"><h3 id="heading--Proxy">Proxy</h3></a>

HTTP proxy used by MAAS to download images, and by provisioned machines for APT and YUM packages. (radio buttons)

<a href="#heading--Dont-use-a-proxy"><h4 id="heading--Dont-use-a-proxy">Don't use a proxy</h4></a>

<a href="#heading--MAAS-built-in"><h4 id="heading--MAAS-built-in">MAAS built-in</h4></a>

<a href="#heading--External"><h4 id="heading--External">External</h4></a>

<a href="#heading--Peer"><h4 id="heading--Peer">Peer</h4></a>

<a href="#heading--External-or-Peer-radio-button-text-box"><h4 id="heading--External-or-Peer-radio-button-text-box">External or Peer radio button followed by a text box with instructions</h4></a>

Enter the external proxy URL that the MAAS built-in proxy will use as an upstream cache peer. Machines will be configured to use MAAS' built-in proxy to download APT packages.

<a href="#heading--DNS"><h3 id="heading--DNS">DNS</h3></a>

<a href="#heading--Upstream-DNS-used-to-resolve-domains-not-managed-by-this-MAAS"><h4 id="heading--Upstream-DNS-used-to-resolve-domains-not-managed-by-this-MAAS">Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses) (text box)</h4></a>

Only used when MAAS is running its own DNS server. This value is used as the value of 'forwarders' in the DNS server config.

<a href="#heading--Enable-DNSSEC-validation-of-upstream-zones"><h4 id="heading--Enable-DNSSEC-validation-of-upstream-zones">Enable DNSSEC validation of upstream zones (dropdown)</h4></a>

Only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.

<a href="#heading--List-of-external-networks"><h4 id="heading--List-of-external-networks">List of external networks for MAAS DNS resolution (text box)</h4></a>

MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows to add extra networks (not previously known) to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.

<a href="#heading--NTP"><h3 id="heading--NTP">NTP</h3></a>

<a href="#heading--Addresses-of-NTP-servers"><h4 id="heading--Addresses-of-NTP-servers">Addresses of NTP servers (text box)</h4></a>

NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS's DHCP services.

<a href="#heading--Use-external-NTP-servers-only"><h4 id="heading--Use-external-NTP-servers-only">Use external NTP servers only (check box)</h4></a>

Configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers, rack contoller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.

<a href="#heading--Syslog"><h3 id="heading--Syslog">Syslog</h3></a>

<a href="#heading--Remote-syslog-server-to-forward-machine-logs"><h4 id="heading--Remote-syslog-server-to-forward-machine-logs">Remote syslog server to forward machine logs (text box)</h4></a>

A remote syslog server that MAAS will set on enlisting, commissioning, testing, and deploying machines to send all log messages. Clearing this value will restore the default behaviour of forwarding syslog to MAAS.

<a href="#heading--Network-discovery1"><h3 id="heading--Network-discovery1">Network discovery</h3></a>

<a href="#heading--Network-discover2"><h4 id="heading--Network-discover2">Network discovery (dropdown)</h4></a>

When enabled, MAAS will use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.

<a href="#heading--Active-subnet-mapping-interval"><h4 id="heading--Active-subnet-mapping-interval">Active subnet mapping interval (dropdown)</h4></a>

When enabled, each rack will scan subnets enabled for active mapping. This helps ensure discovery information is accurate and complete.

<a href="#heading--Scripts"><h2 id="heading--Scripts">Scripts</h2></a>

<a href="#heading--Commissioning-scripts"><h3 id="heading--Commissioning-scripts">Commissioning scripts</h3></a>

<a href="#heading--Search-box4"><h4 id="heading--Search-box4">Search box</h4></a>

<a href="#heading--Upload-script-button1"><h4 id="heading--Upload-script-button1">Upload script button</h4></a>

<a href="#heading--Table-of-scripts1"><h4 id="heading--Table-of-scripts1">Table of scripts</h4></a>

<a href="#heading--script-name1"><h5 id="heading--script-name1">script name (sortable by ascending, descending, none)</h5></a>

******* script names are clickable, expanding to show the script code

<a href="#heading--description1"><h5 id="heading--description1">description (sortable by ascending, descending, none)</h5></a>

<a href="#heading--uploaded-on1"><h5 id="heading--uploaded-on1">uploaded on (sortable by ascending, descending, none)</h5></a>

<a href="#heading--Actions3"><h5 id="heading--Actions3">Actions</h5></a>

******* delete button on each row
possibly greyed out based on current user role

<a href="#heading--paging-buttons3"><h4 id="heading--paging-buttons3">paging buttons, if necessary</h4></a>

<a href="#heading--Testing-scripts"><h3 id="heading--Testing-scripts">Testing scripts</h3></a>

<a href="#heading--Search-box5"><h4 id="heading--Search-box5">Search box</h4></a>

<a href="#heading--Upload-script-button2"><h4 id="heading--Upload-script-button2">Upload script button</h4></a>

<a href="#heading--Table-of-scripts2"><h4 id="heading--Table-of-scripts2">Table of scripts</h4></a>

<a href="#heading--script-name2"><h5 id="heading--script-name2">script name (sortable by ascending, descending, none)</h5></a>

******* script names are clickable, expanding to show the script code

<a href="#heading--description2"><h5 id="heading--description2">description (sortable by ascending, descending, none)</h5></a>

<a href="#heading--uploaded-on2"><h5 id="heading--uploaded-on2">uploaded on (sortable by ascending, descending, none)</h5></a>

<a href="#heading--Actions4"><h5 id="heading--Actions4">Actions</h5></a>

******* delete button on each row
possibly greyed out based on current user role

<a href="#heading--paging-buttons4"><h4 id="heading--paging-buttons4">paging buttons, if necessary</h4></a>

<a href="#heading--DHCP-snippets"><h2 id="heading--DHCP-snippets">DHCP snippets</h2></a>

<a href="#heading--Search-box1"><h3 id="heading--Search-box1">Search box</h3></a>

<a href="#heading--Add-snippet-button"><h3 id="heading--Add-snippet-button">Add snippet button</h3></a>

<a href="#heading--Table-of-snippets"><h3 id="heading--Table-of-snippets">Table of snippets</h3></a>

<a href="#heading--Snippet-name"><h4 id="heading--Snippet-name">Snippet name (sortable by ascending, descending, none)</h4></a>

<a href="#heading--snippet-names-are-clickable-expanding-to-show-snippet"><h5 id="heading--snippet-names-are-clickable-expanding-to-show-snippet">snippet names are clickable, expanding to show snippet</h5></a>

<a href="#heading--Type2"><h4 id="heading--Type2">Type (sortable by ascending, descending, none)</h4></a>

<a href="#heading--Applies-to"><h4 id="heading--Applies-to">Applies to (sortable by ascending, descending, none)</h4></a>

<a href="#heading--Description3"><h4 id="heading--Description3">Description (sortable by ascending, descending, none)</h4></a>

<a href="#heading--Enabled1"><h4 id="heading--Enabled1">Enabled (sortable by ascending, descending, none)</h4></a>

<a href="#heading--Last-edited"><h4 id="heading--Last-edited">Last edited (sortable by ascending, descending, none)</h4></a>

<a href="#heading--Actions5"><h4 id="heading--Actions5">Actions</h4></a>

<a href="#heading--edit-button-on-each-row3"><h5 id="heading--edit-button-on-each-row3">edit button on each row</h5></a>

possibly greyed out based on current user role

<a href="#heading--delete-button-on-each-row3"><h5 id="heading--delete-button-on-each-row3">delete button on each row</h5></a>

possibly greyed out based on current user role

<a href="#heading--paging-buttons5"><h3 id="heading--paging-buttons5">paging buttons, if necessary</h3></a>

<a href="#heading--Package-repos"><h2 id="heading--Package-repos">Package repos</h2></a>

<a href="#heading--Search-box2"><h3 id="heading--Search-box2">Search box</h3></a>

<a href="#heading--Add-PPA-button"><h3 id="heading--Add-PPA-button">"Add PPA" button</h3></a>

<a href="#heading--Add-repository-button"><h3 id="heading--Add-repository-button">"Add repository" button</h3></a>

<a href="#heading--Table-of-snippets"><h3 id="heading--Table-of-snippets">Table of snippets</h3></a>

<a href="#heading--Repo-name"><h4 id="heading--Repo-name">Repo name (sortable by ascending, descending, none)</h4></a>

<a href="#heading--URL"><h4 id="heading--URL">URL (sortable by ascending, descending, none)</h4></a>

<a href="#heading--Enabled2"><h4 id="heading--Enabled2">Enabled (sortable by ascending, descending, none)</h4></a>

<a href="#heading--Actions6"><h4 id="heading--Actions6">Actions</h4></a>

<a href="#heading--edit-button-on-each-row4"><h5 id="heading--edit-button-on-each-row4">edit button on each row</h5></a>

possibly greyed out based on current user role

<a href="#heading--delete-button-on-each-row4"><h5 id="heading--delete-button-on-each-row4">delete button on each row</h5></a>

possibly greyed out based on current user role

<a href="#heading--paging-buttons6"><h3 id="heading--paging-buttons6">paging buttons, if necessary</h3></a>

[/tab]
[tab version="v3.3 Snap,v3.3 Packages" view="CLI"]

<a href="#heading--basic-help-text-reprinted"><h2 id="heading--basic-help-text-reprinted">basic help text reprinted</h2></a>

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
:enable_disk_erasing_on_release: Erase node disks prior to releasing.         Forces users to always erase disks when releasing.
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

<a href="#heading--active_discovery_interval"><h2 id="heading--active_discovery_interval">:active_discovery_interval:</h2></a>

Active subnet mapping interval. When enabled, each rack will scan subnets enabled for active mapping. This helps ensure discovery information is accurate and complete.

<a href="#heading--boot_images_auto_import"><h2 id="heading--boot_images_auto_import">:boot_images_auto_import:</h2></a>

Automatically import/refresh the boot images every 60 minutes.

<a href="#heading--boot_images_no_proxy"><h2 id="heading--boot_images_no_proxy">:boot_images_no_proxy:</h2></a>

Set no_proxy with the image repository address when MAAS is behind (or set with) a proxy..         By default, when MAAS is behind (and set with) a proxy, it is used to download images from the image repository. In some situations (e.g. when using a local image repository) it doesn't make sense for MAAS to use the proxy to download images because it can access them directly. Setting this option allows MAAS to access the (local) image repository directly by setting the no_proxy variable for the MAAS env with the address of the image repository.

<a href="#heading--commissioning_distro_series"><h2 id="heading--commissioning_distro_series">:commissioning_distro_series:</h2></a>

Default Ubuntu release used for commissioning.

<a href="#heading--completed_intro"><h2 id="heading--completed_intro">:completed_intro:</h2></a>

Marks if the initial intro has been completed.

<a href="#heading--curtin_verbose"><h2 id="heading--curtin_verbose">:curtin_verbose:</h2></a>

Run the fast-path installer with higher verbosity. This provides more detail in the installation logs.

<a href="#heading--default_distro_series"><h2 id="heading--default_distro_series">:default_distro_series:</h2></a>

Default OS release used for deployment.

<a href="#heading--default_dns_ttl"><h2 id="heading--default_dns_ttl">:default_dns_ttl:</h2></a>

Default Time-To-Live for the DNS.         If no TTL value is specified at a more specific point this is how long DNS responses are valid, in seconds.

<a href="#heading--default_min_hwe_kernel:-"><h2 id="heading--default_min_hwe_kernel:-">:default_min_hwe_kernel: </h2></a>

Default Minimum Kernel Version.         The default minimum kernel version used on all new and commissioned nodes.

<a href="#heading--default_osystem:-"><h2 id="heading--default_osystem:-">:default_osystem: </h2></a>

Default operating system used for deployment.

<a href="#heading--default_storage_layout:-"><h2 id="heading--default_storage_layout:-">:default_storage_layout: </h2></a>

Default storage layout.         Storage layout that is applied to a node when it is commissioned.        Available choices are:
'bcache' (Bcache layout), 'blank' (No storage (blank) layout), 'custom' (Custom layout (from commissioning storage config)), 'flat' (Flat layout), 'lvm' (LVM layout), 'vmfs6' (VMFS6 layout), 'vmfs7' (VMFS7 layout).

<a href="#heading--disk_erase_with_quick_erase"><h2 id="heading--disk_erase_with_quick_erase">:disk_erase_with_quick_erase:</h2></a>

Use quick erase by default when erasing disks..         This is not a secure erase; it wipes only the beginning and end of each disk.

<a href="#heading--disk_erase_with_secure_erase"><h2 id="heading--disk_erase_with_secure_erase">:disk_erase_with_secure_erase:</h2></a>

Use secure erase by default when erasing disks.         Will only be used on devices that support secure erase.  Other devices will fall back to full wipe or quick erase depending on the selected options.

<a href="#heading--dns_trusted_acl"><h2 id="heading--dns_trusted_acl">:dns_trusted_acl:</h2></a>

List of external networks (not previously known), that will be allowed to use MAAS for DNS resolution..         MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows to add extra networks (not previously known) to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.

<a href="#heading--dnssec_validation"><h2 id="heading--dnssec_validation">:dnssec_validation:</h2></a>

Enable DNSSEC validation of upstream zones.         Only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.

<a href="#heading--enable_analytics"><h2 id="heading--enable_analytics">:enable_analytics:</h2></a>

Enable Google Analytics in MAAS UI to shape improvements in user experience.

<a href="#heading--enable_disk_erasing_on_release"><h2 id="heading--enable_disk_erasing_on_release">:enable_disk_erasing_on_release:</h2></a>

Erase node disks prior to releasing.         Forces users to always erase disks when releasing.

<a href="#heading--enable_http_proxy"><h2 id="heading--enable_http_proxy">:enable_http_proxy:</h2></a>

Enable the use of an APT or YUM and HTTP/HTTPS proxy.         Provision nodes to use the built-in HTTP proxy (or user specified proxy) for APT or YUM. MAAS also uses the proxy for downloading boot images.

<a href="#heading--enable_third_party_drivers"><h2 id="heading--enable_third_party_drivers">:enable_third_party_drivers:</h2></a>

Enable the installation of proprietary drivers (i.e. HPVSA).

<a href="#heading--enlist_commissioning"><h2 id="heading--enlist_commissioning">:enlist_commissioning:</h2></a>

Whether to run commissioning during enlistment..         Enables running all built-in commissioning scripts during enlistment.

<a href="#heading--force_v1_network_yaml"><h2 id="heading--force_v1_network_yaml">:force_v1_network_yaml:</h2></a>

Always use the legacy v1 YAML (rather than Netplan format, also known as v2 YAML) when composing the network configuration for a machine..

<a href="#heading--hardware_sync_interval"><h2 id="heading--hardware_sync_interval">:hardware_sync_interval:</h2></a>

Hardware Sync Interval.         The interval to send hardware info to MAAS fromhardware sync enabled machines, in systemd time span syntax.

<a href="#heading--http_proxy"><h2 id="heading--http_proxy">:http_proxy:</h2></a>

Proxy for APT or YUM and HTTP/HTTPS.         This will be passed onto provisioned nodes to use as a proxy for APT or YUM traffic. MAAS also uses the proxy for downloading boot images. If no URL is provided, the built-in MAAS proxy will be used.

<a href="#heading--kernel_opts"><h2 id="heading--kernel_opts">:kernel_opts:</h2></a>

Boot parameters to pass to the kernel by default.

<a href="#heading--maas_auto_ipmi_cipher_suite_id: "><h2 id="heading--maas_auto_ipmi_cipher_suite_id: ">:maas_auto_ipmi_cipher_suite_id: </h2></a>

MAAS IPMI Default Cipher Suite ID.         The default IPMI cipher suite ID to use when connecting to the BMC via ipmitools        Available choices are:
'' (freeipmi-tools default), '12' (12 - HMAC-MD5::MD5-128::AES-CBC-128), '17' (17 - HMAC-SHA256::HMAC_SHA256_128::AES-CBC-128), '3' (3 - HMAC-SHA1::HMAC-SHA1-96::AES-CBC-128), '8' (8 - HMAC-MD5::HMAC-MD5-128::AES-CBC-128).

<a href="#heading--maas_auto_ipmi_k_g_bmc_key"><h2 id="heading--maas_auto_ipmi_k_g_bmc_key">:maas_auto_ipmi_k_g_bmc_key:</h2></a>

The IPMI K_g key to set during BMC configuration..         This IPMI K_g BMC key is used to encrypt all IPMI traffic to a BMC. Once set, all clients will REQUIRE this key upon being commissioned. Any current machines that were previously commissioned will not require this key until they are recommissioned.

<a href="#heading--maas_auto_ipmi_user"><h2 id="heading--maas_auto_ipmi_user">:maas_auto_ipmi_user:</h2></a>

MAAS IPMI user..         The name of the IPMI user that MAAS automatically creates during enlistment/commissioning.

<a href="#heading--maas_auto_ipmi_user_privilege_level"><h2 id="heading--maas_auto_ipmi_user_privilege_level">:maas_auto_ipmi_user_privilege_level:</h2></a>

MAAS IPMI privilege level.         The default IPMI privilege level to use when creating the MAAS user and talking IPMI BMCs        Available choices are:
'ADMIN' (Administrator), 'OPERATOR' (Operator), 'USER' (User).

<a href="#heading--maas_auto_ipmi_workaround_flags: "><h2 id="heading--maas_auto_ipmi_workaround_flags: ">:maas_auto_ipmi_workaround_flags: </h2></a>

IPMI Workaround Flags.         The default workaround flag (-W options) to use for ipmipower commands        Available choices are:
'' (None), 'authcap' (Authcap), 'endianseq' (Endianseq), 'forcepermsg' (Forcepermsg), 'idzero' (Idzero), 'integritycheckvalue' (Integritycheckvalue), 'intel20' (Intel20), 'ipmiping' (Ipmiping), 'nochecksumcheck' (Nochecksumcheck), 'opensesspriv' (Opensesspriv), 'sun20' (Sun20), 'supermicro20' (Supermicro20), 'unexpectedauth' (Unexpectedauth).

<a href="#heading--maas_internal_domain"><h2 id="heading--maas_internal_domain">:maas_internal_domain:</h2></a>

Domain name used by MAAS for internal mapping of MAAS provided services..         This domain should not collide with an upstream domain provided by the set upstream DNS.

<a href="#heading--maas_name"><h2 id="heading--maas_name">:maas_name:</h2></a>

MAAS name.

<a href="#heading--maas_proxy_port: "><h2 id="heading--maas_proxy_port: ">:maas_proxy_port: </h2></a>

Port to bind the MAAS built-in proxy (default: 8000).         Defines the port used to bind the built-in proxy. The default port is 8000.

<a href="#heading--maas_syslog_port: "><h2 id="heading--maas_syslog_port: ">:maas_syslog_port: </h2></a>

Port to bind the MAAS built-in syslog (default: 5247).         Defines the port used to bind the built-in syslog. The default port is 5247.

<a href="#heading--max_node_commissioning_results"><h2 id="heading--max_node_commissioning_results">:max_node_commissioning_results:</h2></a>

The maximum number of commissioning results runs which are stored.

<a href="#heading--max_node_installation_results"><h2 id="heading--max_node_installation_results">:max_node_installation_results:</h2></a>

The maximum number of installation result runs which are stored.

<a href="#heading--max_node_testing_results"><h2 id="heading--max_node_testing_results">:max_node_testing_results:</h2></a>

The maximum number of testing results runs which are stored.

<a href="#heading--network_discovery"><h2 id="heading--network_discovery">:network_discovery:</h2></a>

When enabled, MAAS will use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.

<a href="#heading--node_timeout"><h2 id="heading--node_timeout">:node_timeout:</h2></a>

Time, in minutes, until the node times out during commissioning, testing, deploying, or entering rescue mode..         Commissioning, testing, deploying, and entering rescue mode all set a timeout when beginning. If MAAS does not hear from the node within the specified number of minutes the node is powered off and set into a failed status.

<a href="#heading--ntp_external_only"><h2 id="heading--ntp_external_only">:ntp_external_only:</h2></a>

Use external NTP servers only.         Configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers, rack contoller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.

<a href="#heading--ntp_servers"><h2 id="heading--ntp_servers">:ntp_servers:</h2></a>

Addresses of NTP servers.         NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS's DHCP services.

<a href="#heading--prefer_v4_proxy"><h2 id="heading--prefer_v4_proxy">:prefer_v4_proxy:</h2></a>

Sets IPv4 DNS resolution before IPv6.         If prefer_v4_proxy is set, the proxy will be set to prefer IPv4 DNS resolution before it attempts to perform IPv6 DNS resolution.

<a href="#heading--prometheus_enabled"><h2 id="heading--prometheus_enabled">:prometheus_enabled:</h2></a>

Enable sending stats to a prometheus gateway..         Allows MAAS to send statistics to Prometheus. This requires the 'prometheus_push_gateway' to be set.

<a href="#heading--prometheus_push_gateway"><h2 id="heading--prometheus_push_gateway">:prometheus_push_gateway:</h2></a>

Address or hostname of the Prometheus push gateway..         Defines the address or hostname of the Prometheus push gateway where MAAS will send data to.

<a href="#heading--prometheus_push_interval"><h2 id="heading--prometheus_push_interval">:prometheus_push_interval:</h2></a>

Interval of how often to send data to Prometheus (default:to 60 minutes)..         The internal of how often MAAS will send stats to Prometheus in minutes.

<a href="#heading--promtail_enabled"><h2 id="heading--promtail_enabled">:promtail_enabled:</h2></a>

Enable streaming logs to Promtail..         Whether to stream logs to Promtail

<a href="#heading--promtail_port"><h2 id="heading--promtail_port">:promtail_port:</h2></a>

TCP port of the Promtail Push API..         Defines the TCP port of the Promtail push API where MAAS will stream logs to.

<a href="#heading--release_notifications"><h2 id="heading--release_notifications">:release_notifications:</h2></a>

Enable or disable notifications for new MAAS releases..

<a href="#heading--remote_syslog"><h2 id="heading--remote_syslog">:remote_syslog:</h2></a>

Remote syslog server to forward machine logs.         A remote syslog server that MAAS will set on enlisting, commissioning, testing, and deploying machines to send all log messages. Clearing this value will restore the default behaviour of forwarding syslog to MAAS.

<a href="#heading--subnet_ip_exhaustion_threshold_count"><h2 id="heading--subnet_ip_exhaustion_threshold_count">:subnet_ip_exhaustion_threshold_count:</h2></a>

If the number of free IP addresses on a subnet becomes less than or equal to this threshold, an IP exhaustion warning will appear for that subnet.

<a href="#heading--tls_cert_expiration_notification_enabled"><h2 id="heading--tls_cert_expiration_notification_enabled">:tls_cert_expiration_notification_enabled:</h2></a>

Notify when the certificate is due to expire.         Enable/Disable notification about certificate expiration.

<a href="#heading--tls_cert_expiration_notification_interval"><h2 id="heading--tls_cert_expiration_notification_interval">:tls_cert_expiration_notification_interval:</h2></a>

Certificate expiration reminder (days).         Configure notification when certificate is due to expire in (days).

<a href="#heading--upstream_dns"><h2 id="heading--upstream_dns">:upstream_dns:</h2></a>

Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses).         Only used when MAAS is running its own DNS server. This value is used as the value of 'forwarders' in the DNS server config.

<a href="#heading--use_peer_proxy"><h2 id="heading--use_peer_proxy">:use_peer_proxy:</h2></a>

Use the built-in proxy with an external proxy as a peer.         If enable_http_proxy is set, the built-in proxy will be configured to use http_proxy as a peer proxy. The deployed machines will be configured to use the built-in proxy.

<a href="#heading--use_rack_proxy"><h2 id="heading--use_rack_proxy">:use_rack_proxy:</h2></a>

Use DNS and HTTP metadata proxy on the rack controllers when a machine is booted..         All DNS and HTTP metadata traffic will flow through the rack controller that a machine is booting from. This isolated region controllers from machines.

<a href="#heading--vcenter_datacenter"><h2 id="heading--vcenter_datacenter">:vcenter_datacenter:</h2></a>

VMware vCenter datacenter.         VMware vCenter datacenter which is passed to a deployed VMware ESXi host.

<a href="#heading--vcenter_password"><h2 id="heading--vcenter_password">:vcenter_password:</h2></a>

VMware vCenter password.         VMware vCenter server password which is passed to a deployed VMware ESXi host.

<a href="#heading--vcenter_server"><h2 id="heading--vcenter_server">:vcenter_server:</h2></a>

VMware vCenter server FQDN or IP address.         VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.

<a href="#heading--vcenter_username"><h2 id="heading--vcenter_username">:vcenter_username:</h2></a>

VMware vCenter username.         VMware vCenter server username which is passed to a deployed VMware ESXi host.

<a href="#heading--windows_kms_host"><h2 id="heading--windows_kms_host">:windows_kms_host:</h2></a>

Windows KMS activation host.         FQDN or IP address of the host that provides the KMS Windows activation service. (Only needed for Windows deployments using KMS activation.)
[/tab]
[/tabs]