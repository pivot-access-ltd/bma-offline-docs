<!-- "How to change MAAS settings" -->

MAAS has a significant number of configuration settings.  This article will list these settings and their possible values, with brief instructions on how to adjust each setting.

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages" view="UI"]
A *Settings* tab is available at the top of the MAAS interface.

<a href="#heading--General-items"><h2 id="heading--General-items">General</h2></a>

The following options are found in *Settings* > *Configuration* > *General*.

Managing MAAS site identity is useful when you are running more than one MAAS instance - say,  *Test* and *Production* environments.  This section also provides data collection and version notification options. 

- *MAAS name*: The "* MAAS name" is a text box that sets the text which appears at the bottom of every MAAS screen, in front of the version descriptor.

- *Google Analytics*: MAAS uses Google Analytics, Usabilla and Sentry Error Tracking to improve user experience.  You can opt in or out of this service by setting or clearing this checkbox.

- *Release notification*: If you select this checkbox, MAAS will notify all users when new releases are available.

<a href="#heading--Security"><h2 id="heading--Security">Security</h2></a>

Choosing *Settings* > *Configuration* > *Security* provides instructions for enabling TLS with a certificate and a private key.  This is a CLI-operation; use the listed command at the command line, after logging into your MAAS instance.

<a href="#heading--Commissioning"><h2 id="heading--Commissioning">Commissioning</h2></a>

The parameters under *Settings* > *Configuration* > *Commissioning* allow you to change the way machines are commissioned:

- *Default commissioning release*: You can choose the default Ubuntu release that will be used for commissioning from a dropdown menu.

- *Default minimum kernel version*: The default minimum kernel version used on all new and commissioned nodes.  You can also choose this default from a dropdown menu.

- *IPMI username*: You can set the default IPMI username, which will control IPMI access to machines.

- *K_g BMC key*: Specify this key to encrypt all communication between IPMI clients and the BMC. Leave this blank for no encryption. 

- *IPMI privilege level*: You can choose the privilege level for IPMI access from a set of radio buttons (admin, operator, user).

<a href="#heading--Deployment"><h2 id="heading--Deployment">Deployment</h2></a>

*Settings* > *Configuration* > *Deployment* lets you configure machine deployment:

- *Default deployment OS*: You can choose the default operating system used for deployment from a dropdown list.

- *Default deployment OS release*: You can also choose the default OS release used for deployment, also from a dropdown.

- *Default hardware sync interval*: You can set the default hardware sync interval, in minutes.

<a href="#heading--Kernel-parameters"><h2 id="heading--Kernel-parameters">Kernel parameters</h2></a>

Under *Configuration* > *General* > *Kernel parameters*, you can set global boot that are always passed to the machine kernel.

<a href="#heading--Users"><h2 id="heading--Users">Users</h2></a>

*Settings* > *Users* MAAS gives you the ability to manage your users in a tabular format:

- *Add user button*: This button can be used to add a new user.

- *Sortable columns*: some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Actions column*: Each table row also has an "Actions" column, which allows you to delete or edit the information in that row.  Note that the delete and/or edit buttons may be greyed out (unavailable) based on your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen.  A search bar is also provided to help you locate a particular user in a longer list.

<a href="#heading--Images"><h2 id="heading--Images">Images</h2></a>

*Settings* > *Images* allows you to specify parameters that control different types of MAAS images.

<a href="#heading--Ubuntu-images"><h3 id="heading--Ubuntu images">Ubuntu images</h3></a>

Under *Settings* > *Images* > *Ubuntu*, you can enable the installation of proprietary drives by selecting the appropriate checkbox.

<a href="#heading--Windows-images"><h3 id="heading--Windows images">Windows images</h3></a>

*Settings* > *Images* > *Windows* allows you to specify the Windows KMS activation host.  This is the FQDN or IP address of the host that provides the KMS Windows activation service, which is needed for Windows deployments that use KMS activation.

<a href="#heading--VMWare-images"><h3 id="heading--VMWare images">VMWare images</h3></a>

If you are using VMWare images, *Settings* > *Images* > *VMware* offers several parameters that you can adjust:

- *VMware vCenter server FQDN or IP address*: the VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.

- *VMware vCenter username*: the VMware vCenter server username which is passed to a deployed VMware ESXi host.

- *VMware vCenter password*: the VMware vCenter server password which is passed to a deployed VMware ESXi host.

- *VMware vCenter datacenter*: the VMware vCenter datacenter which is passed to a deployed VMware ESXi host.

<a href="#heading--License-keys"><h2 id="heading--License-keys">License keys</h2></a>

*Settings* > *License keys* gives you the ability to manage your product licenses in a tabular format:

- *Add license key button*: This button can be used to add a new license key.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Actions column*: These action buttons allow you to delete or edit the information in that row.  Note that the delete and/or edit buttons may be greyed out (unavailable) based on your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular license key in a longer list.

<a href="#heading--Storage"><h2 id="heading--Storage">Storage</h2></a>

Under *Settings* > *Storage*, you can set some parameters related to machine disks:

- *Default storage layout*: The default storage layout that is applied to a machine when it is commissioned.

- *Erase before releasing*: Checking this box forces users to always erase disks when releasing machines.

- *Use secure erase*: Check this box to use secure erase by default when erasing disks. This will only be used on devices that support secure erase. Other devices will fall back to full wipe or quick erase depending on the selected options.

- *Use quick erase*: Check this box to use quick erase by default when erasing disks.  This box is selected separately to provide a fallback for devices that do not support secure erase, should you have selected secure erase as the default method.  Note that this is not a secure erase; it wipes only the beginning and end of each disk.

<a href="#heading--Network"><h2 id="heading--Network">Network</h2></a>

*Settings* > *Network* allows you to set several network defaults for MAAS machines.

<a href="#heading--HTTP-proxy"><h3 id="heading--HTTP proxy">HTTP proxy</h3></a>

By choosing *Settings* > *Network* > *Proxy*, you can define the HTTP proxy used by MAAS to download images, and used by provisioned machines for APT and YUM packages. Your choices are (1) no proxy, (2) MAAS built-in proxy, (3) external proxy, or (4) peer proxy.  If you choose external or peer proxy, you will be presented with a text box to specify the external proxy URL that the MAAS built-in proxy will use as an upstream cache peer.  Note that machines will be configured to use MAAS' built-in proxy to download APT packages when external or peer proxies are specified.

<a href="#heading--Upstream-DNS"><h3 id="heading--Upstream DNS">Upstream DNS</h3></a>

*Settings* > *Network* > *DNS* lets you set DNS parameters for your MAAS.  Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses).  This only applies when MAAS is running its own DNS server, since this value is used to define forwarding in the DNS server config.  You can set the following parameters:

- *Enable DNSSEC validation*: If you wish to enable DNSSEC validation of upstream zones, you can choose the method from this dropdown list.  This is only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.

- *List of external networks*: You can also provide a list of external networks to be used for MAAS DNS resolution. MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows you to add extra, previously-unknown networks to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.

<a href="#heading--NTP-service"><h3 id="heading--NTP service">NTP service</h3></a>

Access the NTP service is controlled using *Settings* > *Network* > *NTP*. You can enter the address of NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS DHCP services.  

You can also instruct MAAS to *Use external NTP only*, so that all daemons and machines refer directly to the external NTP server (and not to each other). If this is not set, only region controller hosts will be configured to use those external NTP servers; rack controller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.

<a href="#heading--Syslog-configuration"><h3 id="heading--Syslog configuration">Syslog configuration</h3></a>

You can use *Settings* > *Network* > *Syslog* to specify a remote syslog server to which machine logs should be forwarded.  MAAS will use this remote syslog server for all log messages when enlisting, commissioning, testing, and deploying machines. Conversely, clearing this value will restore the default behaviour of forwarding syslog entries to MAAS.

<a href="#heading--Network-discovery"><h3 id="heading--Network discovery">Network discovery</h3></a>

*Settings* > *Network* > *Network discovery*, when enabled, will cause MAAS to use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.  You can set the *Active subnet mapping interval* by choosing a desired interval from a dropdown.  When network discovery is enabled, each rack will scan subnets enabled for active mapping, which helps to ensure that discovery information is accurate and complete.

<a href="#heading--Scripts"><h2 id="heading--Scripts">Scripts</h2></a>

Under the section *Settings* > *Scripts*, MAAS provides a great deal of flexibility when dealing with commissioning and testing scripts.

<a href="#heading--Commissioning-scripts"><h3 id="heading--Commissioning-scripts">Commissioning scripts</h3></a>

*Settings* > *Scripts* > *Commissioning scripts* gives you the ability to manage machine commissioning scripts in a tabular format:

- *Upload script button*: This button can be used to upload a new commissioning script.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Expandable script contents*: Also note that individual script names are clickable, allowing you to expand that row to see the contents of the script.

- *Actions column*: Each table row has an "Actions" column, which allows you to delete the script in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular commissioning script in a longer list.

<a href="#heading--Testing-scripts"><h3 id="heading--Testing-scripts">Testing scripts</h3></a>

Similar to *Commissioning scripts*, the choices *Settings* > *Scripts* > *Testing scripts* give you the ability to manage your machines testing scripts in a tabular format:

- *Upload script button*: This button can be used to upload a new test script.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Expandable script contents*: Also note that individual script names are clickable, allowing you to expand that row to see the contents of the script.

- *Actions column*: Each table row has an "Actions" column, which allows you to delete the script in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular test script in a longer list.

<a href="#heading--DHCP-snippets"><h2 id="heading--DHCP-snippets">DHCP snippets</h2></a>

*Settings* > *DHCP snippets* lets you manage your DHCP snippets in a table:

- *Add snippet button*: This button can be used to add a new DHCP snippet.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Expandable snippets*: Also note that individual snippets are clickable, allowing you to expand that row to see the contents of that snippet.

- *Actions column*: Each table row has an "Actions" column, which allows you to edit delete the snippet in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular snippet in a longer list.

<a href="#heading--Package-repos"><h2 id="heading--Package-repos">Package repos</h2></a>

You can manage your MAAS repositories with the *Settings* > *Package repos* option.  Referenced repos are listed in a table:

- *Add PPA button*: This button can be used to add a new PPA to the search path.

- *Add repository button*: This button can be used to add a new repository to the search path.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Actions column*: Each table row also has an "Actions" column, which allows you to edit or delete the repository information in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular test script in a longer list.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages" view="UI"]
A *Settings* tab is available at the top of the MAAS interface.

<a href="#heading--General-items"><h2 id="heading--General-items">General</h2></a>

The following options are found in *Settings* > *Configuration* > *General*.

Managing MAAS site identity is useful when you are running more than one MAAS instance - say,  *Test* and *Production* environments.  This section also provides data collection and version notification options. 

- *MAAS name*: The "* MAAS name" is a text box that sets the text which appears at the bottom of every MAAS screen, in front of the version descriptor.

- *MAAS name emoji*: You may also paste a suitable emoji in front of the MAAS name to help identify it.

- *MAAS theme main colour*: You may also help identify your MAAS instance by changing the colour of the top bar; several colour choices are available.

- *Google Analytics*: MAAS uses Google Analytics, Usabilla and Sentry Error Tracking to improve user experience.  You can opt in or out of this service by setting or clearing this checkbox.

- *Release notification*: If you select this checkbox, MAAS will notify all users when new releases are available.

<a href="#heading--Security"><h2 id="heading--Security">Security</h2></a>

Choosing *Settings* > *Configuration* > *Security* provides instructions for enabling TLS with a certificate and a private key.  This is a CLI-operation; use the listed command at the command line, after logging into your MAAS instance.

<a href="#heading--Commissioning"><h2 id="heading--Commissioning">Commissioning</h2></a>

The parameters under *Settings* > *Configuration* > *Commissioning* allow you to change the way machines are commissioned:

- *Default commissioning release*: You can choose the default Ubuntu release that will be used for commissioning from a dropdown menu.

- *Default minimum kernel version*: The default minimum kernel version used on all new and commissioned nodes.  You can also choose this default from a dropdown menu.

- *IPMI username*: You can set the default IPMI username, which will control IPMI access to machines.

- *K_g BMC key*: Specify this key to encrypt all communication between IPMI clients and the BMC. Leave this blank for no encryption. 

- *IPMI privilege level*: You can choose the privilege level for IPMI access from a set of radio buttons (admin, operator, user).

<a href="#heading--Deployment"><h2 id="heading--Deployment">Deployment</h2></a>

*Settings* > *Configuration* > *Deployment* lets you configure machine deployment:

- *Default deployment OS*: You can choose the default operating system used for deployment from a dropdown list.

- *Default deployment OS release*: You can also choose the default OS release used for deployment, also from a dropdown.

- *Default hardware sync interval*: You can set the default hardware sync interval, in minutes.

<a href="#heading--Kernel-parameters"><h2 id="heading--Kernel-parameters">Kernel parameters</h2></a>

Under *Configuration* > *General* > *Kernel parameters*, you can set global boot that are always passed to the machine kernel.

<a href="#heading--Users"><h2 id="heading--Users">Users</h2></a>

*Settings* > *Users* MAAS gives you the ability to manage your users in a tabular format:

- *Add user button*: This button can be used to add a new user.

- *Sortable columns*: some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Actions column*: Each table row also has an "Actions" column, which allows you to delete or edit the information in that row.  Note that the delete and/or edit buttons may be greyed out (unavailable) based on your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen.  A search bar is also provided to help you locate a particular user in a longer list.

<a href="#heading--Images"><h2 id="heading--Images">Images</h2></a>

*Settings* > *Images* allows you to specify parameters that control different types of MAAS images.

<a href="#heading--Ubuntu-images"><h3 id="heading--Ubuntu images">Ubuntu images</h3></a>

Under *Settings* > *Images* > *Ubuntu*, you can enable the installation of proprietary drives by selecting the appropriate checkbox.

<a href="#heading--Windows-images"><h3 id="heading--Windows images">Windows images</h3></a>

*Settings* > *Images* > *Windows* allows you to specify the Windows KMS activation host.  This is the FQDN or IP address of the host that provides the KMS Windows activation service, which is needed for Windows deployments that use KMS activation.

<a href="#heading--VMWare-images"><h3 id="heading--VMWare images">VMWare images</h3></a>

If you are using VMWare images, *Settings* > *Images* > *VMware* offers several parameters that you can adjust:

- *VMware vCenter server FQDN or IP address*: the VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.

- *VMware vCenter username*: the VMware vCenter server username which is passed to a deployed VMware ESXi host.

- *VMware vCenter password*: the VMware vCenter server password which is passed to a deployed VMware ESXi host.

- *VMware vCenter datacenter*: the VMware vCenter datacenter which is passed to a deployed VMware ESXi host.

<a href="#heading--License-keys"><h2 id="heading--License-keys">License keys</h2></a>

*Settings* > *License keys* gives you the ability to manage your product licenses in a tabular format:

- *Add license key button*: This button can be used to add a new license key.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Actions column*: These action buttons allow you to delete or edit the information in that row.  Note that the delete and/or edit buttons may be greyed out (unavailable) based on your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular license key in a longer list.

<a href="#heading--Storage"><h2 id="heading--Storage">Storage</h2></a>

Under *Settings* > *Storage*, you can set some parameters related to machine disks:

- *Default storage layout*: The default storage layout that is applied to a machine when it is commissioned.

- *Erase before releasing*: Checking this box forces users to always erase disks when releasing machines.

- *Use secure erase*: Check this box to use secure erase by default when erasing disks. This will only be used on devices that support secure erase. Other devices will fall back to full wipe or quick erase depending on the selected options.

- *Use quick erase*: Check this box to use quick erase by default when erasing disks.  This box is selected separately to provide a fallback for devices that do not support secure erase, should you have selected secure erase as the default method.  Note that this is not a secure erase; it wipes only the beginning and end of each disk.

<a href="#heading--Network"><h2 id="heading--Network">Network</h2></a>

*Settings* > *Network* allows you to set several network defaults for MAAS machines.

<a href="#heading--HTTP-proxy"><h3 id="heading--HTTP proxy">HTTP proxy</h3></a>

By choosing *Settings* > *Network* > *Proxy*, you can define the HTTP proxy used by MAAS to download images, and used by provisioned machines for APT and YUM packages. Your choices are (1) no proxy, (2) MAAS built-in proxy, (3) external proxy, or (4) peer proxy.  If you choose external or peer proxy, you will be presented with a text box to specify the external proxy URL that the MAAS built-in proxy will use as an upstream cache peer.  Note that machines will be configured to use MAAS' built-in proxy to download APT packages when external or peer proxies are specified.

<a href="#heading--Upstream-DNS"><h3 id="heading--Upstream DNS">Upstream DNS</h3></a>

*Settings* > *Network* > *DNS* lets you set DNS parameters for your MAAS.  Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses).  This only applies when MAAS is running its own DNS server, since this value is used to define forwarding in the DNS server config.  You can set the following parameters:

- *Enable DNSSEC validation*: If you wish to enable DNSSEC validation of upstream zones, you can choose the method from this dropdown list.  This is only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.

- *List of external networks*: You can also provide a list of external networks to be used for MAAS DNS resolution. MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows you to add extra, previously-unknown networks to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.

<a href="#heading--NTP-service"><h3 id="heading--NTP service">NTP service</h3></a>

Access the NTP service is controlled using *Settings* > *Network* > *NTP*. You can enter the address of NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS DHCP services.  

You can also instruct MAAS to *Use external NTP only*, so that all daemons and machines refer directly to the external NTP server (and not to each other). If this is not set, only region controller hosts will be configured to use those external NTP servers; rack controller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.

<a href="#heading--Syslog-configuration"><h3 id="heading--Syslog configuration">Syslog configuration</h3></a>

You can use *Settings* > *Network* > *Syslog* to specify a remote syslog server to which machine logs should be forwarded.  MAAS will use this remote syslog server for all log messages when enlisting, commissioning, testing, and deploying machines. Conversely, clearing this value will restore the default behaviour of forwarding syslog entries to MAAS.

<a href="#heading--Network-discovery"><h3 id="heading--Network discovery">Network discovery</h3></a>

*Settings* > *Network* > *Network discovery*, when enabled, will cause MAAS to use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.  You can set the *Active subnet mapping interval* by choosing a desired interval from a dropdown.  When network discovery is enabled, each rack will scan subnets enabled for active mapping, which helps to ensure that discovery information is accurate and complete.

<a href="#heading--Scripts"><h2 id="heading--Scripts">Scripts</h2></a>

Under the section *Settings* > *Scripts*, MAAS provides a great deal of flexibility when dealing with commissioning and testing scripts.

<a href="#heading--Commissioning-scripts"><h3 id="heading--Commissioning-scripts">Commissioning scripts</h3></a>

*Settings* > *Scripts* > *Commissioning scripts* gives you the ability to manage machine commissioning scripts in a tabular format:

- *Upload script button*: This button can be used to upload a new commissioning script.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Expandable script contents*: Also note that individual script names are clickable, allowing you to expand that row to see the contents of the script.

- *Actions column*: Each table row has an "Actions" column, which allows you to delete the script in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular commissioning script in a longer list.

<a href="#heading--Testing-scripts"><h3 id="heading--Testing-scripts">Testing scripts</h3></a>

Similar to *Commissioning scripts*, the choices *Settings* > *Scripts* > *Testing scripts* give you the ability to manage your machines testing scripts in a tabular format:

- *Upload script button*: This button can be used to upload a new test script.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Expandable script contents*: Also note that individual script names are clickable, allowing you to expand that row to see the contents of the script.

- *Actions column*: Each table row has an "Actions" column, which allows you to delete the script in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular test script in a longer list.

<a href="#heading--DHCP-snippets"><h2 id="heading--DHCP-snippets">DHCP snippets</h2></a>

*Settings* > *DHCP snippets* lets you manage your DHCP snippets in a table:

- *Add snippet button*: This button can be used to add a new DHCP snippet.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Expandable snippets*: Also note that individual snippets are clickable, allowing you to expand that row to see the contents of that snippet.

- *Actions column*: Each table row has an "Actions" column, which allows you to edit delete the snippet in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular snippet in a longer list.

<a href="#heading--Package-repos"><h2 id="heading--Package-repos">Package repos</h2></a>

You can manage your MAAS repositories with the *Settings* > *Package repos* option.  Referenced repos are listed in a table:

- *Add PPA button*: This button can be used to add a new PPA to the search path.

- *Add repository button*: This button can be used to add a new repository to the search path.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Actions column*: Each table row also has an "Actions" column, which allows you to edit or delete the repository information in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular test script in a longer list.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages" view="CLI"]

<a href="#heading--changing-settings-with-the-cli"><h2 id="heading--changing-settings-with-the-cli">Changing MAAS settings via the MAAS CLI</h2></a>

Assuming you have successfully logged into the MAAS CLI, you can access configuration values using the `maas $PROFILE maas set-config` command.  This command is used to set MAAS configuration values.

This command accepts keyword arguments.  You must pass each argument as a key-value pair, with an equals sign between the key and the value, like this:

```nohighlight
maas $PROFILE maas set-config key1=value1 key2=value key3=value3 ...
```

These keyword arguments must come after any positional arguments required by a specific command.  The following configuration keywords are currently available:

- *active_discovery_interval*: Active subnet mapping interval. When enabled, each rack will scan subnets enabled for active mapping. This helps ensure discovery information is accurate and complete.
- *boot_images_auto_import*: Automatically import/refresh the boot images every 60 minutes.
- *boot_images_no_proxy*: Set no_proxy with the image repository address when MAAS is behind (or set with) a proxy. By default, when MAAS is behind (and set with) a proxy, it is used to download images from the image repository. In some situations (e.g. when using a local image repository) it doesn't make sense for MAAS to use the proxy to download images because it can access them directly. Setting this option allows MAAS to access the (local) image repository directly by setting the no_proxy variable for the MAAS env with the address of the image repository.
- *commissioning_distro_series*: Default Ubuntu release used for commissioning.
- *completed_intro*: Marks if the initial intro has been completed.
- *curtin_verbose*: Run the fast-path installer with higher verbosity. This provides more detail in the installation logs.
- *default_distro_series*: Default OS release used for deployment.
- *default_dns_ttl*: Default Time-To-Live for the DNS.         If no TTL value is specified at a more specific point this is how long DNS responses are valid, in seconds.
- *default_min_hwe_kernel*: Default Minimum Kernel Version.         The default minimum kernel version used on all new and commissioned nodes.
- *default_osystem*: Default operating system used for deployment.
- *default_storage_layout*: Default storage layout.         Storage layout that is applied to a node when it is commissioned.        Available choices are*: 'bcache' (Bcache layout), 'blank' (No storage (blank) layout), 'custom' (Custom layout (from commissioning storage config)), 'flat' (Flat layout), 'lvm' (LVM layout), 'vmfs6' (VMFS6 layout), 'vmfs7' (VMFS7 layout).
- *disk_erase_with_quick_erase*: Use quick erase by default when erasing disks..         This is not a secure erase; it wipes only the beginning and end of each disk.
- *disk_erase_with_secure_erase*: Use secure erase by default when erasing disks.         Will only be used on devices that support secure erase.  Other devices will fall back to full wipe or quick erase depending on the selected options.
- *dns_trusted_acl*: List of external networks (not previously known), that will be allowed to use MAAS for DNS resolution..         MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows to add extra networks (not previously known) to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.
- *dnssec_validation*: Enable DNSSEC validation of upstream zones.         Only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.
- *enable_analytics*: Enable Google Analytics in MAAS UI to shape improvements in user experience.
- *enable_disk_erasing_on_release*: Erase node disks prior to releasing.         Forces users to always erase disks when releasing.
- *enable_http_proxy*: Enable the use of an APT or YUM and HTTP/HTTPS proxy.         Provision nodes to use the built-in HTTP proxy (or user specified proxy) for APT or YUM. MAAS also uses the proxy for downloading boot images.
- *enable_third_party_drivers*: Enable the installation of proprietary drivers (i.e. HPVSA).
- *enlist_commissioning*: Whether to run commissioning during enlistment..         Enables running all built-in commissioning scripts during enlistment.
- *force_v1_network_yaml*: Always use the legacy v1 YAML (rather than Netplan format, also known as v2 YAML) when composing the network configuration for a machine..
- *hardware_sync_interval*: Hardware Sync Interval.         The interval to send hardware info to MAAS from hardware sync enabled machines, in systemd time span syntax.
- *http_proxy*: Proxy for APT or YUM and HTTP/HTTPS.         This will be passed onto provisioned nodes to use as a proxy for APT or YUM traffic. MAAS also uses the proxy for downloading boot images. If no URL is provided, the built-in MAAS proxy will be used.
- *kernel_opts*: Boot parameters to pass to the kernel by default.
- *maas_auto_ipmi_cipher_suite_id*: MAAS IPMI Default Cipher Suite ID.         The default IPMI cipher suite ID to use when connecting to the BMC via ipmitools        Available choices are*: '' (freeipmi-tools default), '12' (12 - HMAC-MD5::MD5-128::AES-CBC-128), '17' (17 - HMAC-SHA256::HMAC_SHA256_128::AES-CBC-128), '3' (3 - HMAC-SHA1::HMAC-SHA1-96::AES-CBC-128), '8' (8 - HMAC-MD5::HMAC-MD5-128::AES-CBC-128).
- *maas_auto_ipmi_k_g_bmc_key*: The IPMI K_g key to set during BMC configuration..         This IPMI K_g BMC key is used to encrypt all IPMI traffic to a BMC. Once set, all clients will REQUIRE this key upon being commissioned. Any current machines that were previously commissioned will not require this key until they are recommissioned.
- *maas_auto_ipmi_user*: MAAS IPMI user..         The name of the IPMI user that MAAS automatically creates during enlistment/commissioning.
- *maas_auto_ipmi_user_privilege_level*: MAAS IPMI privilege level.         The default IPMI privilege level to use when creating the MAAS user and talking IPMI BMCs        Available choices are*: 'ADMIN' (Administrator), 'OPERATOR' (Operator), 'USER' (User).
- *maas_auto_ipmi_workaround_flags*: IPMI Workaround Flags.         The default workaround flag (-W options) to use for ipmipower commands        Available choices are*: '' (None), 'authcap' (Authcap), 'endianseq' (Endianseq), 'forcepermsg' (Forcepermsg), 'idzero' (Idzero), 'integritycheckvalue' (Integritycheckvalue), 'intel20' (Intel20), 'ipmiping' (Ipmiping), 'nochecksumcheck' (Nochecksumcheck), 'opensesspriv' (Opensesspriv), 'sun20' (Sun20), 'supermicro20' (Supermicro20), 'unexpectedauth' (Unexpectedauth).
- *maas_internal_domain*: Domain name used by MAAS for internal mapping of MAAS provided services..         This domain should not collide with an upstream domain provided by the set upstream DNS.
- *maas_name*: MAAS name.
- *maas_proxy_port*: Port to bind the MAAS built-in proxy (default*: 8000).         Defines the port used to bind the built-in proxy. The default port is 8000.
- *maas_syslog_port*: Port to bind the MAAS built-in syslog (default*: 5247).         Defines the port used to bind the built-in syslog. The default port is 5247.
- *max_node_commissioning_results*: The maximum number of commissioning results runs which are stored.
- *max_node_installation_results*: The maximum number of installation result runs which are stored.
- *max_node_testing_results*: The maximum number of testing results runs which are stored.
- *network_discovery*: .         When enabled, MAAS will use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.
- *node_timeout*: Time, in minutes, until the node times out during commissioning, testing, deploying, or entering rescue mode..         Commissioning, testing, deploying, and entering rescue mode all set a timeout when beginning. If MAAS does not hear from the node within the specified number of minutes the node is powered off and set into a failed status.
- *ntp_external_only*: Use external NTP servers only.         Configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers, rack controller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.
- *ntp_servers*: Addresses of NTP servers.         NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS DHCP services.
- *prefer_v4_proxy*: Sets IPv4 DNS resolution before IPv6.         If prefer_v4_proxy is set, the proxy will be set to prefer IPv4 DNS resolution before it attempts to perform IPv6 DNS resolution.
- *prometheus_enabled*: Enable sending stats to a prometheus gateway..         Allows MAAS to send statistics to Prometheus. This requires the 'prometheus_push_gateway' to be set.
- *prometheus_push_gateway*: Address or hostname of the Prometheus push gateway..         Defines the address or hostname of the Prometheus push gateway where MAAS will send data to.
- *prometheus_push_interval*: Interval of how often to send data to Prometheus (default*: to 60 minutes)..         The internal of how often MAAS will send stats to Prometheus in minutes.
- *promtail_enabled*: Enable streaming logs to Promtail..         Whether to stream logs to Promtail
- *promtail_port*: TCP port of the Promtail Push API..         Defines the TCP port of the Promtail push API where MAAS will stream logs to.
- *release_notifications*: Enable or disable notifications for new MAAS releases..
- *remote_syslog*: Remote syslog server to forward machine logs.         A remote syslog server that MAAS will set on enlisting, commissioning, testing, and deploying machines to send all log messages. Clearing this value will restore the default behaviour of forwarding syslog to MAAS.
- *subnet_ip_exhaustion_threshold_count*: If the number of free IP addresses on a subnet becomes less than or equal to this threshold, an IP exhaustion warning will appear for that subnet.
- *tls_cert_expiration_notification_enabled*: Notify when the certificate is due to expire.         Enable/Disable notification about certificate expiration.
- *tls_cert_expiration_notification_interval*: Certificate expiration reminder (days).         Configure notification when certificate is due to expire in (days).
- *upstream_dns*: Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses).         Only used when MAAS is running its own DNS server. This value is used as the value of 'forwarders' in the DNS server config.
- *use_peer_proxy*: Use the built-in proxy with an external proxy as a peer.         If enable_http_proxy is set, the built-in proxy will be configured to use http_proxy as a peer proxy. The deployed machines will be configured to use the built-in proxy.
- *use_rack_proxy*: Use DNS and HTTP metadata proxy on the rack controllers when a machine is booted..         All DNS and HTTP metadata traffic will flow through the rack controller that a machine is booting from. This isolated region controllers from machines.
- *vcenter_datacenter*: VMware vCenter datacenter.         VMware vCenter datacenter which is passed to a deployed VMware ESXi host.
- *vcenter_password*: VMware vCenter password.         VMware vCenter server password which is passed to a deployed VMware ESXi host.
- *vcenter_server*: VMware vCenter server FQDN or IP address.         VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.
- *vcenter_username*: VMware vCenter username.         VMware vCenter server username which is passed to a deployed VMware ESXi host.
- *windows_kms_host*: Windows KMS activation host.         FQDN or IP address of the host that provides the KMS Windows activation service. (Only needed for Windows deployments using KMS activation.)
[/tab]
[/tabs]
