<!-- "Configuration settings reference" -->

MAAS has a significant number of configuration settings.  This article will list these settings and their possible values, with brief instructions on how to adjust each setting.

[tabs]
[tab version="v3.3 Snap,v3.3 Packages" view="UI"]
The MAAS UI provides a Settings tab at the top of the MAAS interface:

<a href="https://discourse.maas.io/uploads/default/original/2X/5/5a754cebaaae078bd04357c60abe6312d7171315.png"><img src="https://discourse.maas.io/uploads/default/original/2X/5/5a754cebaaae078bd04357c60abe6312d7171315.png"></a>

Selections are made by clicking on active links down the left side of the page.

<a href="#heading--General-items"><h2 id="heading--General-items">General items</h2></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b70a6f273934c2f8b5c758be00ad25f4d5482a39.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b70a6f273934c2f8b5c758be00ad25f4d5482a39.png"></a>

<a href="#heading--MAAS-site-identity"><h3 id="heading--MAAS-site-identity">MAAS site identity</h3></a>

The "General" section provides the ability to set the MAAS site identity, which is most useful if you are running more than one MAAS instance.  For example, if you have a "test" environment and a "production" environment, you can differentiate them by name<!-- and colour scheme-->.  This section also provides data collection and version notification options. 

- *MAAS name*: The "* MAAS name" is a text box that sets the text which appears at the bottom of every MAAS screen, in front of the version descriptor:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f49676981aee8b1ab6414507358b990ed24e11d0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f49676981aee8b1ab6414507358b990ed24e11d0.png"></a>

You can also use this MAAS name string with unicode emoji(s) to provide additional visual cues:

<a href="https://discourse.maas.io/uploads/default/original/2X/0/0ccd74fee11f712d0265609ee5e8a8b58e94a546.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/0ccd74fee11f712d0265609ee5e8a8b58e94a546.png"></a>

Each MAAS instance can also display the tab bar in a different color.  This helps users distinguish between different instances.  The available colors are as follows:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/abdac304572b2f4c4de0753a010f77392ee149b8.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/abdac304572b2f4c4de0753a010f77392ee149b8.png"></a>

You can set the tab bar color by selecting the appropriate radio button.

<a href="#heading--Google-analytics"><h3 id="heading--Google analytics">Google analytics</h3></a>

MAAS uses Google Analytics, Usabilla and Sentry Error Tracking to improve user experience.  You can opt in or out of this service by setting or clearing this checkbox:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1888a7c8c785df0bd2a63f3897cafdaadfb04b78.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1888a7c8c785df0bd2a63f3897cafdaadfb04b78.png"></a>

<a href="#heading--Release-notification"><h3 id="heading--Release notification">Release notification</h3></a>

If you select this checkbox, MAAS will notify all users when new releases are available:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3aaf1c0728b16f99ee8bd94091e4ca0fca436544.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3aaf1c0728b16f99ee8bd94091e4ca0fca436544.png"></a>

<a href="#heading--Security"><h2 id="heading--Security">Security</h2></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/6/6353f2cf002d0e69750d16575ae329a4e5c819db.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/6353f2cf002d0e69750d16575ae329a4e5c819db.png"></a>

The MAAS configuration settings maintains a section for security-related parameters.  Currently, there is only one item, "TLS status".  This section gives instructions on how to enable TLS with a certificate and a private key.  This is a CLI-operation; use the listed command at the command line, after logging into your MAAS instance:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8bc6805e395e7eb514af78e7c0c8f276d2110e0a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8bc6805e395e7eb514af78e7c0c8f276d2110e0a.png"></a>

<a href="#heading--Commissioning"><h2 id="heading--Commissioning">Commissioning</h2></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b841dd1c539fc37bc5778a1c71e1194b53fb5103.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b841dd1c539fc37bc5778a1c71e1194b53fb5103.png"></a>

This section provides a number of configurable parameters related to commissioning machines, including settings for the machines themselves. You can also control the IPMI connection used to access machines.

<a href="#heading--Machine-settings"><h3 id="heading--Machine-settings">Machine settings</h3></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/4/4fa33fbdb1fdd9db43b118e93f6bd76b061e79ea.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/4fa33fbdb1fdd9db43b118e93f6bd76b061e79ea.png"></a>

- *Default commissioning release*: You can choose the default Ubuntu release that will be used for commissioning from a dropdown menu.

- *Default minimum kernel version*: The default minimum kernel version used on all new and commissioned nodes.  You can also choose this default from a dropdown menu.

<a href="#heading--IPMI-settings"><h3 id="heading--IPMI-settings">IPMI settings</h3></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/0/0cd76e009226318e7afee4f594e86390ac99dfb1.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/0cd76e009226318e7afee4f594e86390ac99dfb1.png"></a>

- *IPMI username*: You can set the default IPMI username, which will control IPMI access to machines.

- *K_g BMC key*: Specify this key to encrypt all communication between IPMI clients and the BMC. Leave this blank for no encryption. 

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1c7dc2b1666148cde9487cbf06bd8efbbaca656b.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1c7dc2b1666148cde9487cbf06bd8efbbaca656b.png"></a>

- *IPMI privilege level*: You can choose the privilege level for IPMI access from a set of radio buttons (admin, operator, user).

<a href="#heading--Deployment"><h2 id="heading--Deployment">Deployment</h2></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f28aa8c31ff843b47c44fb47e482b5163902c1c5.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f28aa8c31ff843b47c44fb47e482b5163902c1c5.png"></a>

There are also a number of parameters which control MAAS machine deployment:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/66c5fe86db6dfdc043803b50d15c3e6929b5aa0c.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/66c5fe86db6dfdc043803b50d15c3e6929b5aa0c.png"></a>

- *Default deployment OS*: You can choose the default operating system used for deployment from a dropdown list.

- *Default deployment OS release*: You can also choose the default OS release used for deployment, also from a dropdown.

- *Default hardware sync interval*: You can set the default hardware sync interval, in minutes.

<a href="#heading--Kernel-parameters"><h2 id="heading--Kernel-parameters">Kernel parameters</h2></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/5/557e89310a2e1b512457c38497302fcb533a39ef.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/5/557e89310a2e1b512457c38497302fcb533a39ef.png"></a>

You can set the kernel parameters used with machine kernels:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d2edc0a4c48ee76ac78a6e5c03a5eda810ed793d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d2edc0a4c48ee76ac78a6e5c03a5eda810ed793d.png"></a>

- *Global boot parmeters*: You can set global boot parameters that are always passed to the machine kernel.

<a href="#heading--Users"><h2 id="heading--Users">Users</h2></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/8/807555f84904bd48b2279317b378b3184a5a1742.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/807555f84904bd48b2279317b378b3184a5a1742.png"></a>

MAAS configuration gives you the ability to manage your users:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d8fd3cfd3c24e8ee4a58b743078155cea05e27e2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d8fd3cfd3c24e8ee4a58b743078155cea05e27e2.png"></a>

- *Add user button*: This button can be used to add a new user.

- *User table*: This table lists user attributes, including username, real name, machines they can access, when the user was last seen, MAAS keys, and a user type and role.  Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

Each table row also has an "Actions" column, which allows you to delete or edit the information in that row.  Note that the delete and/or edit buttons may be greyed out (unavailable) based on your role.

Note that if the table becomes longer than one screen will accomodate, paging buttons will appear at the bottom of the screen.  A search bar is also provided to help you locate a particular user in a longer list.

<a href="#heading--Images"><h2 id="heading--Images">Images</h2></a>

This section of the configuration settings allows you to specify parameters that control images.

<a href="https://discourse.maas.io/uploads/default/original/2X/3/37362d55a4c37b563af13c665e27a818f4dd63e7.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/37362d55a4c37b563af13c665e27a818f4dd63e7.png"></a>

<a href="#heading--Ubuntu-images"><h3 id="heading--Ubuntu images">Ubuntu images</h3></a>

If you are using Ubuntu images, you can enable the installation of proprietry drives by selecting the appropriate checkbox:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/fb4822256f5f9102af2e4a1cd5974ced2bca9075.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/fb4822256f5f9102af2e4a1cd5974ced2bca9075.png"></a>

Additional options may be added to this menu from time to time.

<a href="#heading--Windows-images"><h3 id="heading--Windows images">Windows images</h3></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/c/cdbb64a45bdca8d8433b34818725ad14fab18119.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/cdbb64a45bdca8d8433b34818725ad14fab18119.png"></a>

If you are using Windows images, you can specify the Windows KMS activation host.  This is the FQDN or IP address of the host that provides the KMS Windows activation service: 

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d2e83dd7ace5b84e6aa9db8159f91f2149bbeffa.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d2e83dd7ace5b84e6aa9db8159f91f2149bbeffa.png"></a>

This is only needed for Windows deployments that use KMS activation.

<a href="#heading--VMWare-images"><h3 id="heading--VMWare images">VMWare images</h3></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b92a7722885c7374ebbe02ced472fa0cd54d51ec.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b92a7722885c7374ebbe02ced472fa0cd54d51ec.png"></a>

If you are usijng VMWare images, there are several parameters you can adjust:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/be3a4b46eb2b1d238d77b29380986e0b903e988f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/be3a4b46eb2b1d238d77b29380986e0b903e988f.png"></a>

- *VMware vCenter server FQDN or IP address*: the VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.

- *VMware vCenter username*: the VMware vCenter server username which is passed to a deployed VMware ESXi host.

- *VMware vCenter password*: the VMware vCenter server password which is passed to a deployed VMware ESXi host.

- *VMware vCenter datacenter*: the VMware vCenter datacenter which is passed to a deployed VMware ESXi host.

<a href="#heading--License-keys"><h2 id="heading--License-keys">License keys</h2></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d1834664928572f9bbc652d6223b62b6580d7f43.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d1834664928572f9bbc652d6223b62b6580d7f43.png"></a>

MAAS configuration gives you the ability to manage your license key:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/6935fddce5b33a7952f7bc6eb9c6248b2d2ec733.png" target="_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/6935fddce5b33a7952f7bc6eb9c6248b2d2ec733.png">

- *Add license key button*: This button can be used to add a new license key.

- *License table*: This table lists license attributes, including operating system and distro series.  Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

Each table row also has an "Actions" column, which allows you to delete or edit the information in that row.  Note that the delete and/or edit buttons may be greyed out (unavailable) based on your role.

Note that if the table becomes longer than one screen will accomodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular license key in a longer list.

<a href="#heading--Storage"><h2 id="heading--Storage">Storage</h2></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a749db087c74e4b6733f773cd6720be5308173ef.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a749db087c74e4b6733f773cd6720be5308173ef.png"></a>

You can set some parameters related to machine storage layouts:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/965f6a622092cae03a4043cdb22d337a1ae981cc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/965f6a622092cae03a4043cdb22d337a1ae981cc.png"></a>

- *Default storage layout*: The default storage layout that is applied to a machine when it is commissioned.

- *Erase before releasing*: Checking this box forces users to always erase disks when releasing machines.

- *Use secure erase*: Check this box to use secure erase by default when erasing disks. This will only be used on devices that support secure erase. Other devices will fall back to full wipe or quick erase depending on the selected options.

- *Use quick erase*: Check this box to use quick erase by default when erasing disks.  This box is selected separately to provide a fallback for devices that do not support secure erase, should you have selected secure erase as the default method.  Note that this is not a secure erase; it wipes only the beginning and end of each disk.

<a href="#heading--Network"><h2 id="heading--Network">Network</h2></a>

You can set some network defaults for MAAS machines.

<a href="https://discourse.maas.io/uploads/default/original/2X/8/82f10e6375158387ba01842e2e68b18e638e5966.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/82f10e6375158387ba01842e2e68b18e638e5966.png"></a>

<a href="#heading--HTTP-proxy"><h3 id="heading--HTTP proxy">HTTP proxy</h3></a>

Here, you can choose the HTTP proxy used by MAAS to download images, and used by provisioned machines for APT and YUM packages. Your choices are (1) no proxy, (2) MAAS built-in proxy, (3) external proxy, or (4) peer proxy.  If you choose external or peer proxy, you will be presented with a text box to specify the external proxy URL that the MAAS built-in proxy will use as an upstream cache peer. 

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c3e3667484f71938d364252566b65eb039251636.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c3e3667484f71938d364252566b65eb039251636.png"></a>

Note that machines will be configured to use MAAS' built-in proxy to download APT packages when external or peer proxies are specified.

<a href="#heading--Upstream-DNS"><h3 id="heading--Upstream DNS">Upstream DNS</h3></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8ff7c117866781710b64daa8804167debf6d3a85.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8ff7c117866781710b64daa8804167debf6d3a85.png"></a>

Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses). Only used when MAAS is running its own DNS server. This value is used as the value of 'forwarders' in the DNS server config.

<a href="https://discourse.maas.io/uploads/default/original/2X/1/147467aff277c3fb45b94922f7f88f90e34509ec.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/147467aff277c3fb45b94922f7f88f90e34509ec.png"></a>

- *Enable DNSSEC validation*: If you wish to enable DNSSEC validation of upstream zones, you can choose the method from this dropdown list.  This is only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.

- *List of external networks*: You can also provide a ist of external networks to be used for MAAS DNS resolution. MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows you to add extra, previously-unknown networks to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.

<a href="#heading--NTP-service"><h3 id="heading--NTP service">NTP service</h3></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/a/abf10690d730a2333ca8b910638f97fa4e04c03b.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/abf10690d730a2333ca8b910638f97fa4e04c03b.png"></a>

You can enter the address of NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS's DHCP services.

<a href="https://discourse.maas.io/uploads/default/original/2X/2/2e61953512a232b26ed51d43b01040d7482408d0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/2e61953512a232b26ed51d43b01040d7482408d0.png"></a>

- *Use external NTP only*:  You can configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers; rack contoller hosts will in turn refer to the regions' NTP servers; deployed machines will refer to the racks' NTP servers.

<a href="#heading--Syslog-configuration"><h3 id="heading--Syslog configuration">Syslog configuration</h3></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/5/50812e0362109f8c894eb3087b49030608fb3675.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/5/50812e0362109f8c894eb3087b49030608fb3675.png"></a>

You can specify a remote syslog server to which machine logs should be forwarded.  This will be a remote syslog server that MAAS will set on enlisting, commissioning, testing, and deploying machines to send all log messages. 

<a href="https://discourse.maas.io/uploads/default/original/2X/e/ed9853326328cce615a4c551074c0ee2ffa84e7b.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/ed9853326328cce615a4c551074c0ee2ffa84e7b.png"></a>

Clearing this value will restore the default behaviour of forwarding syslog to MAAS.

<a href="#heading--Network-discovery"><h3 id="heading--Network discovery">Network discovery</h3></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/1/1d3e161b8ae204b25183be53df23f72172822d2b.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/1d3e161b8ae204b25183be53df23f72172822d2b.png"></a>

When this choice is enabled, MAAS will use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.

<a href="https://discourse.maas.io/uploads/default/original/2X/4/44ebe9af4eeaecbf3d4e7604085238991d1ce7bc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/44ebe9af4eeaecbf3d4e7604085238991d1ce7bc.png"></a>

- *Active subnet mapping interval*: You can choose the subnet mapping interval from this dropdown.  When enabled, each rack will scan subnets enabled for active mapping. This helps ensure discovery information is accurate and complete.

<a href="#heading--Scripts"><h2 id="heading--Scripts">Scripts</h2></a>

MAAS provides a great deal of flexibility when dealing with commissioning and testing scripts.

<a href="#heading--Commissioning-scripts"><h3 id="heading--Commissioning-scripts">Commissioning scripts</h3></a>

<a href="https://discourse.maas.io/t/image-scrapbook/4398" target = "_blank"><img src="https://discourse.maas.io/t/image-scrapbook/4398"></a>

MAAS configuration gives you the ability to manage your commissioning scripts:

<a href="https://discourse.maas.io/uploads/default/original/2X/5/500f13e4fc1a2d1b19b10dea42dfa8d54bd86065.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/5/500f13e4fc1a2d1b19b10dea42dfa8d54bd86065.png"></a>

- *Upload script button*: This button can be used to upload a new commissioning script.

- *Table of commissioning scripts*: This table lists script attributes, including script name, description, and upload timestamp.  Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

Also note that individual script names are clickable, allowing you to expand that row to see the contents of the script.

Each table row also has an "Actions" column, which allows you to delete the script in that row, depending upon your role.

Note that if the table becomes longer than one screen will accomodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular commissioning script in a longer list.

<a href="#heading--Testing-scripts"><h3 id="heading--Testing-scripts">Testing scripts</h3></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3ff427b8977bd22b3b8ddec4cdcb63211102d42f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3ff427b8977bd22b3b8ddec4cdcb63211102d42f.png"></a>

The MAAS configuration settings give you the ability to manage your testing scripts:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/42587a5d69826413e57851eb5e476e5dd2fe5d69.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/42587a5d69826413e57851eb5e476e5dd2fe5d69.png"></a>

- *Upload script button*: This button can be used to upload a new test script.

- *Table of commissioning scripts*: This table lists script attributes, including script name, description, and upload timestamp.  Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

Also note that individual script names are clickable, allowing you to expand that row to see the contents of the script.

Each table row also has an "Actions" column, which allows you to delete the script in that row, depending upon your role.

Note that if the table becomes longer than one screen will accomodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular test script in a longer list.

<a href="#heading--DHCP-snippets"><h2 id="heading--DHCP-snippets">DHCP snippets</h2></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c188db5925593b8d9ebadeb4f696ffd8f24f311d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c188db5925593b8d9ebadeb4f696ffd8f24f311d.png"></a>

The MAAS configuration settings give you the ability to manage any DHCP snippets you wish to apply:

<a href="https://discourse.maas.io/uploads/default/original/2X/5/5ced76625f4324169eff2b83d2c860afd470e42f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/5/5ced76625f4324169eff2b83d2c860afd470e42f.png"></a>

- *Add snippet button*: This button can be used to add a new DHCP snippet.

- *Table of snippets*: This table lists snippet attributes, including snippet name, type, description, application, data of last edit, and whether or not that snippet is currently enabled.  Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

Also note that individual snippet names are clickable, allowing you to expand that row to see the language of that snippet.

Each table row also has an "Actions" column, which allows you to edit or delete the snippet in that row, depending upon your role.

Note that if the table becomes longer than one screen will accomodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular test script in a longer list.

<a href="#heading--Package-repos"><h2 id="heading--Package-repos">Package repos</h2></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a2a38a59ecab87c7abee31672aa86ebfaa755512.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a2a38a59ecab87c7abee31672aa86ebfaa755512.png"></a>

MAAS configuration settings give you the ability to manage any package repos you wish to apply to your MAAS instance:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/46d19603bd763243f1b35f0de301cb55b3ae5182.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/46d19603bd763243f1b35f0de301cb55b3ae5182.png"></a>

- *Add PPA button*: This button can be used to add a new PPA to the search path.

- *Add repository button*: This button can be used to add a new repository to the search path.

- *Table of repositories*: This table lists enabled respositores, including the repo name, URL, and whether or not that repository is currently enabled in the search path.  Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

Also note that individual snippet names are clickable, allowing you to expand that row to see the language of that snippet.

Each table row also has an "Actions" column, which allows you to edit or delete the repository information in that row, depending upon your role.

Note that if the table becomes longer than one screen will accomodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular test script in a longer list.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages" view="CLI"]

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
- *hardware_sync_interval*: Hardware Sync Interval.         The interval to send hardware info to MAAS fromhardware sync enabled machines, in systemd time span syntax.
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
- *ntp_external_only*: Use external NTP servers only.         Configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers, rack contoller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.
- *ntp_servers*: Addresses of NTP servers.         NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS's DHCP services.
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
