||2.7|2.8|2.9|3.0|
|-----:|:-----:|:-----:|:-----:|:-----:|
Snap|[CLI](/t/whats-new-in-maas-snap-2-7-cli/4300) ~ [UI](/t/whats-new-in-maas-snap-2-7-ui/4301)|[CLI](/t/whats-new-in-maas-snap-2-8-cli/4298) ~ [UI](/t/whats-new-in-maas-snap-2-8-ui/4299)|[CLI](/t/whats-new-in-maas-snap-2-9-cli/4296) ~ [UI](/t/whats-new-in-maas-snap-2-9-ui/4297)|[CLI](/t/whats-new-in-maas-snap-3-0-cli/4181) ~ [UI](/t/whats-new-in-maas-snap-3-0-ui/4182)|
Packages|[CLI](/t/whats-new-in-maas-deb-2-7-cli/4294) ~ [UI](/t/whats-new-in-maas-deb-2-7-ui/4295)|[CLI](/t/whats-new-in-maas-deb-2-8-cli/4292) ~ [UI](/t/whats-new-in-maas-deb-2-8-ui/4293)|[CLI](/t/whats-new-in-maas-deb-2-9-cli/4290) ~ [UI](/t/whats-new-in-maas-deb-2-9-ui/4291)|[CLI](/t/whats-new-in-maas-deb-3-0-cli/4289) ~ [UI](/t/whats-new-in-maas-deb-3-0-ui/4184)|

<!-- snap-2-7-cli snap-2-7-ui deb-2-7-cli deb-2-7-ui
<h2>MAAS 2.7 release notes</h2>

<h3>MAAS 2.7.3 released</h3>

On 24 August 2020, MAAS 2.7.3 was released, replacing the `2.7/stable` channel in snap and the [ppa:maas/2.7](https://launchpad.net/~maas/+archive/ubuntu/2.7).  You can update your 2.7 release to 2.7.3 by with:

    snap refresh --channel=2.7/stable

or by using the aforementioned PPA.  The focus for this release has been [bug-fixing](https://launchpad.net/maas/+milestone/2.7.3rc1) -- there were no changes to MAAS since RC1.

Thanks to everyone who reported the issues with previous 2.7 releases and helped us with the logs.

<h3>MAAS 2.7.2 released</h3>

On 30 July 2020, MAAS 2.7.2 was released, replacing the `2.7/stable` channel in snap and the [ppa:maas/2.7](https://launchpad.net/~maas/+archive/ubuntu/2.7).  You can update your 2.7 release to 2.7.2 by with:

    snap refresh --channel=2.7/stable

or by using the aforementioned PPA.  The focus for this release has been [bug-fixing](https://launchpad.net/maas/+milestone/2.7.2rc1) -- there were no changes to MAAS since RC1.

Thanks to everyone who reported the issues with previous 2.7 releases and helped us with the logs.

<a href="#heading--upgrade-2-6-to-2-7-snap"><h3 id="heading--upgrade-2-6-to-2-7-snap">Upgrading from MAAS 2.6 snap</h3></a> 

If you are using the MAAS 2.6 snap, which had to be installed with `--devmode`, you can update to 2.7 with the following parameters:

    snap refresh maas --devmode --channel=2.7

Be aware that you will still be in `--devmode`, which means the snap won't automatically upgrade.  You'll have to check manually for updates (via `snap refresh`).  Once you’re upgraded to MAAS 2.7 using this method, future snap updates won’t require the devmode parameter. So, for example, when a later version of 2.7 (or even 2.8) is released, you will be able to `snap refresh` to those channels and get out of devmode.  Once refreshed out of devmode in this way, you'll get updates for point releases automatically.

An alternative to avoid devmode would be to do a clean install of MAAS 2.7, that is, removing 2.6 with `snap remove maas` and reinstalling MAAS 2.7 with:

    snap install --channel=2.7 maas

Note that you can check the devmode status of your snap with:

    snap list maas


---

<h2>MAAS 2.7 released</h2>

Following on from MAAS 2.6.2, we are happy to announce that MAAS 2.7 is now available. This release features some critical bug fixes, along with some exciting new features:

### CentOS 8 image support

Users can now deploy CentOS 8 images in MAAS. The Images page in the MAAS UI will now offer a choice to select and download CentOS 8. Note that users of previous versions may see CentOS 8 as an available option, but cannot download or deploy it.

### Network testing features

MAAS 2.7 brings a slate of new network testing and link detection features, as detailed below.

#### Network link disconnect detection

MAAS 2.7 can check whether links are connected or disconnected. Previously, when commissioning, you couldn’t detect unplugged cables. Now you can. You will have to take a couple of steps for existing MAAS deployments: First, you will have to upgrade to 2.7, then run commissioning again to see if a link is disconnected. But you no longer have to puzzle over what’s broken when this happens.

MAAS will report disconnected network cables, and users will receive a warning when trying to configure a disconnected interface. Administrators will be able to change cable connection status through both API and UI after manually rectifying the situation.

#### Slow network link detection

MAAS 2.7 makes sure you’re getting the most out of your link speed. As servers and hardware get faster — 10G, 40G, even 100G NICS — the chances increase that you might plug your 10G NIC into a 1G switch, for example. Previously, with MAAS, you’d be stuck with the speed of the slowest link, but there wasn’t a way to verify your link speed without recommissioning. Depending on your physical hardware, that might still be an issue, but the MAAS UI can now warn you if your interface is connected to a link slower than what the interface supports. And all information shown in the UI is available via the API, as well. You can still replace a slow switch without recommissioning.

MAAS will automatically detect link and interface speed during commissioning and report them via the API/UI. Administrators will be able to change or update the link and interface speeds via the API/UI after manual changes to the connection. MAAS 2.7 will also report link speed, allowing users to filter and list machines by their link speed in the UI. Users can also employ this information to allocate machines by their link speed in the API.

#### Network validation scripts and testing

MAAS 2.7 allows you to configure network connectivity testing in a number of ways. If you’ve used MAAS, you know that if it can’t connect to the rack controller, deployment can’t complete. Now MAAS can check connectivity to the rack controller and warn you if there’s no link, long before you have to try and debug it. For example, if you can’t connect to your gateway controller, traffic can’t leave your network. MAAS can now check this link and recognise that there’s no connectivity, which alleviates a lot of annoying (and sometimes hard-to-detect) network issues.

Users can now test their network configuration to check for:

1. Interfaces which have a broken network configuration
2. Bonds that are not fully operational
3. Broken gateways, rack controllers, and Internet links

In addition, Internet connectivity testing has been greatly expanded. Previously, MAAS gave a yes/no link check during network testing. Now you can give a list of URLs or IP addresses to check. In the ephemeral environment, standard DHCP is still applied, but when network testing runs, we can apply your specific configuration for the duration of the test. While all URLs / IPs are tested with all interfaces, we do test each of your interfaces individually, including breaking apart bonded NICS and testing each side of your redundant interfaces. You can also run different tests on each pass, e.g., a different set of URLs, although each run would be a different testing cycle. For testing individual interfaces, you can use the API.

Of course, the main network feature available in 2.7 is improved — and customisable — network testing. You can now create your own commissioning scripts and tests related to networking. You can create your own network tests (e.g., a network throughput test) and run them during the network testing portion of the MAAS workflow. There are no particular restrictions on these scripts, so you can test a wide variety of possible conditions and situations.

Administrators can upload network tests and test scripts, as well as create tests which accept an interface parameter, or scripts which apply custom network configurations. Users can then specify (unique) parameters using the API, override machines which fail network testing (allowing their use), and suppress individual failed network tests. All users benefit from enhanced reporting, as they are now able to see the overall status of all interfaces via the API, the UI Machine list, and the UI Interfaces tab; review the health status from all interface tests; and view the interface test results by interface name and MAC.

#### Live IP address detection to prevent address conflicts

In some cases, MAAS connects with subnet which are not empty. Normally, the user has to tell MAAS about IP addresses which are already assigned on that subnet, and if that step is skipped, MAAS may assign and in-use IP address to one of the machines under its control, leading to an IP conflict.

MAAS 2.7 alleviates this problem by detecting IPs in use on a subnet, so that it can avoid assigning that IP to a MAAS-managed machine. The system is not perfect; for example, if NIC on a subnet-connected machine is in a quiescent state -- or turned off -- MAAS may not detect it before duplicating the IP. Note that at least one rack controller must have access to the previously-assigned machine in order for this feature to work. MAAS 2.7 will also recognise when the subnet ARP cache is full and re-check the oldest IPs added to the cache to search for free IP addresses.

### Introductory NUMA / SR-IOV support

NUMA (Non-Uniform Memory Access) is a useful way of achieving high-efficiency computing, by pairing a CPU core with a very fast connection to RAM and PCI buses. Typically the CPU socket and the closest banks of DIMM constitute a NUMA node. Obviously, if you’re deploying a MAAS machine under NUMA to get maximum performance, you would like for that machine to be confined to a single NUMA node. MAAS 2.7 introduces this capability.

MAAS will display the NUMA node index and details. Users can also see the count of available NUMA nodes, along with CPU cores, memory, NICS, and node spans for bonds and block devices (although node-spanning may not produce suitable performance). From a reporting standpoint, users can filter machines by CPU cores, memory, subnet, VLAN, fabric, space, storage, and RAID.

Similarly, the SR-IOV (Single Root I/O Virtualisation) allows a PCIe device (e.g, a NIC) to appear to be multiple separate devices. A network adaptor can be subdivided into multiple adaptors by adding a Virtual Function (VF). MAAS 2.7 supports the use of multiple VF adaptors to intelligently use SR-IOV edge clouds, by allowing users to see that a NIC supports SR-IOV, along with the supported VF counts.

The goal of this feature is to help users choose the right machine to deploy an edge cloud.

### Settings and user preferences redesign

As part of our efforts to make the UI faster and more responsive, we have completely redesigned the Settings and User preferences within the MAAS UI.

### Strictly-confined Snap support

With 2.7, MAAS is fully confined within the Snap container. No need for installation qualifiers (such as “--devmode”) to permit use of external resources, i.e., outside the Snap container. This means that we will begin to transition to recommending the Snap install as the default (and primary) MAAS install method. This also means that MAAS now gains the benefit of confined snap security features.

### Update to hardware information gathering methods

MAAS has switched hardware information gathering from lshw/lsblk to lxd output during commissioning, because it more easily provides the information needed to complete resource discovery. Note that this information may not be particularly reliable for your use, so you may need to create your own commissioning scripts if you need something more detailed or specific.

### Bug fixes

A number of bug fixes (see the [list in Launchpad](https://bugs.launchpad.net/maas/+bugs?field.milestone%3Alist=87757&field.milestone%3Alist=89662&field.milestone%3Alist=89714&field.milestone%3Alist=89840&field.milestone%3Alist=89954&field.milestone%3Alist=89682&field.status%3Alist=FIXRELEASED)).
snap-2-7-cli snap-2-7-ui deb-2-7 deb-2-7-ui -->

<!-- snap-2-9-cli snap-2-9-ui deb-2-9-ui deb-2-9-cli

<h2>MAAS 2.9.2 release notes</h2>

We have released MAAS 2.9.2, which contains two new features, and some notable [bug fixes](https://launchpad.net/maas/+milestone/2.9.2). The two new features are:

1. Proxmox driver: A driver has been added to MAAS 2.9.2 which intereacts with the Proxmox API.  Only one URL is needed, though a username and credentials are required.  Credentials can be either a password or an API token.  Note that if you use a token, you have to configure the permissions for the token.  Newly-created Proxmox tokens don't assign any permissions by default, so you must add `power on`, `power off`, and `query power` permissions to the token before using it.

2. Power driver Webhook:  A webhook was added to 2.9.2, which allows MAAS to interface with another web service that's running the power commands.  This webhook is provided for interacting with objects that MAAS does not support, that is, the MAAS team supports the driver itself, but whatever is interfacing to the driver is not supported.  This webhook as three URLs, one each for power on, power off, and power query.  Optionally, this webhook also supports a power user and password or token (RFC 6717).  This gives you a way to add your own power drivers without waiting for the driver to be added to MAAS.  There is a [video tutorial](https://discourse.maas.io/t/maas-show-and-tell-proxmox-and-webhook/3754/3) available on this new feature.

You can also find a [digest](#heading--bug-fixes-2-9-2) of the 2.9.2 bug fixes below.

<h2>MAAS 2.9.1 release notes</h2>

Building upon MAAS 2.9, we have released 2.9.1, which contains some notable [bug fixes](https://launchpad.net/maas/+milestone/2.9.1).  You can find a [digest](#heading--bug-fixes-2-9-1) of these fixes below.

<h2>MAAS 2.9 release notes</h2>

Following on from MAAS 2.8, we are happy to announce that MAAS 2.9 is now available.

#### What are the new features & fixes for MAAS 2.9 and MAAS 2.9.1?

1. [Focal Fossa (20.04) as default commissioning/deployment release](#heading--focal-default)
2. [Support for OpenVswitch bridge type](#heading--openvswitch)
3. [Support for NUMA, SR-IOV, and hugepages](#heading--numa)
4. [Improved performance for large MAAS installations](#heading--improved-perf-large-maas)
5. [New release notifications](#heading--new-release-notifications)
6. [IPMI configuration screens](#heading--ipmi-config-screens)
7. [Descriptions when marking machines broken](#heading--descrip-mark-mach-broken)
8. [Curtin 20.2 now included](#heading--curtin-20-2-included)
9. [HTTP boot disabled](#heading--http-boot-disabled)
10. [BMC/IPMI default parameter additions](#heading--bmc-param-additions)
11. [New global IPMI configuration options](#heading--new-config-options)
12. [Addition of IPMI config options to UI](#heading--global-config-settings)
13. [New MAAS CLI power command](#heading--maas-power)
14. [Commissioning speed improvements](#heading--commissioning-speed)
15. [BMC improvements](#heading--bmc-improve)
16. [IPMI power driver upgrades](#heading--ipmi-driver)
17. [Enlistment script improvements](#heading--enlistment-scripts)
18. [Commissioning script improvements](#heading--commissioning-scripts)
19. [Commissioning script reordering](#heading--commissioning-reorder)
20. [Reader Adaptive Documentation](#heading--rad)
21. [Offline documentation](#heading--offline-docs)

<h4>Six other questions you may have:</h4>

1. [What known issues should I be aware of?](#heading--known-issues)
2. [How do I install MAAS 2.9?](/t/maas-installation/3323)
3. [How do I upgrade my MAAS 2.8 snap to a MAAS 2.9 snap?](/t/maas-installation/3323#heading--upgrade-maas-snap)
4. [How do I install MAAS 2.9 from packages?](/t/maas-installation/3329#heading--install-from-packages)
5. [How do I upgrade MAAS 2.8 to MAAS 2.9 using packages?](/t/maas-installation/3329#heading--upgrade-via-packages)
6. [What bugs are fixed so far in this release?](#heading--bug-fixes)

<h2 id="heading--focal-default">Focal Fossa (Ubuntu 20.04 LTS) as default release</h2>

Ubuntu 20.04 LTS (Focal Fossa) is now the default commissioning and deployment release for new MAAS installations.  Machines deployed with Focal may now be registered as KVM hosts.

<h2 id="heading--openvswitch">Support for OpenVswitch bridge type</h2>

MAAS 2.9 allows you to create an OpenVswitch bridge type when creating a bridge.

<h2 id="heading--numa">Support for NUMA, SR-IOV, and hugepages</h2>

MAAS 2.9 adds extensive optimisation tools for using NUMA with virtual machines. You can now see how many VMs are allocated to each NUMA node, along with the allocations of cores, storage, and memory. You can quickly spot a VM running in multiple NUMA nodes, and optimise accordingly, with instant updates on pinning and allocations. You can also tell which VMs are currently running.  Using the CLI, you can also pin nodes to specific cores, and configure hugepages for use by VMs.

Specifically, there are five new features available to support NUMA, SR-IOV, and hugepages:

1. You can examine resources on a per-NUMA-node basis.
2. You can pin nodes to specific cores (CLI only).
3. You can see resources for VM hosts supporting NUMA nodes.
4. You can see the alignment between VM host interfaces and NUMA nodes.
5. You can configure and use hugepages (configurable in CLI only).

This functionality comes with an enhanced panel in the "KVM" details section:

<a href="https://discourse.maas.io/uploads/default/optimized/1X/57245bbbfe6d28e83c9b7fb30e52caf05714eb00_2_485x500.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/1X/57245bbbfe6d28e83c9b7fb30e52caf05714eb00_2_485x500.png"></a>

See the [VM hosting](/t/vm-hosting-snap-2-9-ui/2747) page for more details, and be sure to use the menu at the top of that page to select your desired build method and interface, so that you'll see the most relevant instructions.

<h2 id="heading--improved-perf-large-maas">Improved performance for large MAAS installations</h2>

MAAS 2.9 includes changes to the machine batch size that the UI loads. Previously the UI loaded machines in batches of 25; it now pulls in 25 for the first call, then 100 at a time in subsequent batches.

You can see the results of the investigation in [this video podcast](https://discourse.maas.io/t/maas-show-and-tell-improving-ui-performance-for-large-maas-installs/3515).

<h2 id="heading--new-release-notifications">New release notifications</h2>

MAAS now includes new release notifications for users and administrators.  These appear when a new release is available:

<a href="https://discourse.maas.io/uploads/default/original/1X/c4f426b9f493a970efcc59c4d948d24fa5f12860.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c4f426b9f493a970efcc59c4d948d24fa5f12860.png"></a>

Both regular and administrative users can snooze these notifications for two weeks at a time.  Administrative users can opt out of new release notifications completely, preventing notifications for any user of that MAAS.

<h2 id="heading--ipmi-config-screens">IPMI configuration screens</h2>

MAAS now includes UI panels corresponding to the [IPMI power driver upgrades](#heading--ipmi-driver) mentioned earlier:

<a href="https://discourse.maas.io/uploads/default/original/1X/433b28f5dd807caef7c7382f9a877607c2ea2dac.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/433b28f5dd807caef7c7382f9a877607c2ea2dac.png"></a>

This screen can be reached from `Settings | Configuration | Commissioning`.

<h2 id="heading--descrip-mark-mach-broken">Descriptions when marking machines broken</h2>

When marking a machine broken, a description can now included:

<a href="https://discourse.maas.io/uploads/default/original/1X/69df48044c964d27caf59b60dcf5bf5210894c15.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/69df48044c964d27caf59b60dcf5bf5210894c15.png"></a>

This description appears in that machine's row on the machine list.

<h2 id="heading--curtin-20-2-included">Curtin 20.2 now included</h2>

A number of MAAS issues have actually been issues with an older version of Curtin.  MAAS now includes Curtin 20.2, which fixes many of these issues, including [MAAS is changing my boot order!](https://discourse.maas.io/t/maas-is-changing-my-boot-order/3491).

<h2 id="heading--http-boot-disabled">HTTP boot disabled</h2>

MAAS 2.9 disables HTTP boot. There are known issues with HTTP boot in MAAS, as well as known issues for HTTP boot with grub (e.g. https://bugs.launchpad.net/maas/+bug/1899581)  This shouldn’t affect machine boot, as machines will normally try PXE as a fallback boot method if HTTP boot fails.  Be aware, though, that machine boot will fail if the BIOS is configured to boot only over HTTP; those machines need to be reconfigured to use PXE.

<h2 id="heading--bmc-param-additions">30-maas-01-bmc-config parameter additions</h2>

Four new parameters have been added for IPMI BMC configuration.  These parameters will pull from the global defaults, eliminating the need to set the corresponding parameter in each instance.

1. maas_auto_ipmi_user - The username for the MAAS created IPMI user. Default comes from the global configuration setting.
2. maas_auto_ipmi_user_password - The password for the MAAS created IPMI user, by default a random password is generated.
3. maas_auto_ipmi_k_g_bmc_key - he IPMI K_g pre-shared encryption key to be set when adding the MAAS IPMI user. Note not all IPMI BMCs support setting the k_g key, if MAAS is unable to set the key commissioning will fail. Default comes from the global configuration setting. If an IPMI K_g key is set but the key is rejected by the BMC MAAS will automatically retry without the K_g key. This works around an edge case where some BMCs will allow you to set an K_g key but don’t allow it to be used.
4. maas_auto_ipmi_user_privilege_level - The IPMI user privilege level to use when adding the MAAS IPMI user. Possible options are USER, OPERATOR, or ADMIN. Default comes from the global configuration setting.

Note that MAAS will not capture the BMC MAC address when detecting IPMI BMCs.

<h2 id="heading--new-config-options">New global IPMI configuration options</h2>

Two new global IPMI configuration options have been added:

1. maas_auto_ipmi_k_g_bmc_key - sets a global default IPMI BMC key.
2. maas_auto_ipmi_user_privilege_level - sets a global default IPMI BMC user privilege level.
    
<h2 id="heading--global-config-settings">Addition of IPMI config options to UI</h2>

You may now set the global configuration options `maas_auto_ipmi_user`, `maas_auto_ipmi_k_g_bmc_key`, and `maas_auto_ipmi_user_privilege_level` on the "Settings" page in the UI under "Commissioning."

<h2 id="heading--maas-power">New maas.power CLI command</h2>

Available in all MAAS 2.9 releases is the new `maas.power` CLI command. This command interfaces directly with the supported MAAS power drivers. This command can be used to control the power on a machine before it has been added to MAAS, for all maas supported power drivers.  You can get power status, turn machines on or off, and cycle power.  The `maas.power --help` shows usage details, including syntax for naming each power type (consistent with other MAAS CLI commands).

<h2 id="heading--rad">IPMI BMC detection improvements (RAD)</h2>

This release adds two improvements to IPMI BMC detection capability:

1. The IPMI cipher suite ID will now be automatically detected. MAAS tries to find the most secure cipher suite available. Preference order is 17, 3, 8, 12. If detection fails MAAS will fall back to using freeipmi-tool default, 3, which is what previous versions of MAAS use.
2. The IPMI K_g BMC key will now be automatically detected if previously set. 

<h3 id="heading--rad">Reader Adaptive Documentation (RAD)</h3>

This release features Reader Adaptive Documentation, which allows you to adapt individual pages to your install method (Snap vs. Deb), version (2.7/2.8/2.9), and preferred interface (CLI/UI). 

<h2 id="heading--offline-docs">Offline documentation</h2>

This release will include offline documentation for those users whose MAAS installations reside behind firewalls, unable to access the online documentation.

<h2 id="heading--bmc-improve">BMC improvements</h2>

Three substantial improvements to BMC usage have been released:

1. IPMI, HP Moonshot, and Facebook Wedge BMC detection and configuration scripts have been migrated to the commissioning script `30-maas-01-bmc-config `.
2. BMC detection and configuration are now logged to commissioning results.
3. If BMC configuration is skipped a ScriptResult will log this result, and indicate which user chose to skip the configuration step.

<h3 id="heading--ipmi-driver">IPMI power driver upgrades</h3>

Three new configuration options have been added to the IPMI power driver:

1. K_g - The BMC Key of the IPMI device. Used to encrypt all traffic to and from the device during communication.
2. Cipher Suite ID - The cipher suite to use when communicating with the IPMI BMC. Only 3, 8, 12, and 17 are available as only those enable ciphers for authentication, integrity, and confidentiality. Defaults to 3, freeipmi-tools default. See http://fish2.com/ipmi/bp.pdf for more information.
3. Privilege Level - The IPMI privilege level to use when communicating with the BMC. Defaults to OPERATOR.

See the [2.9 UI](https://maas.io/docs/snap/2.9/ui/power-management#heading--ipmi) or [2.9 CLI](https://maas.io/docs/snap/2.9/cli/power-management#heading--ipmi) power management pages for details.

<h2 id="heading--enlistment-scripts">Improvements in enlistment scripting</h2>

Script flow and capabilities have been improved in three ways:

<ol>
<li>`maas-run-remote-scripts` can now enlist machines.</li>
<li>Enlistment `user_data` scripts have been removed.</li>
<li> The metadata endpoints `http://<MAAS>:5240/<latest or 2012-03-01>/` and `http://<MAAS>:5240/<latest or 2012-03-01>/meta-data/` are now available anonymously for use during enlistment.</li>
</ol>

<h2 id="heading--commissioning-scripts">Major improvements to commissioning script capabilities</h2>

Seven major improvements were made to commissioning script flow and capabilities:

<ol>
<li>Commissioning scripts can now send BMC configuration data</li>
<li>Commissioning scripts can now be used to configure BMC data. </li>
<li>The environment variable BMC_CONFIG_PATH is passed to serially run commissioning scripts. </li>
<li>These scripts may write BMC power credentials to BMC_CONFIG_PATH in a YAML format where each key is the power parameter. </li>
<li>If the commissioning script returns 0, it will be sent to MAAS. </li>
<li>The first script to write BMC_CONFIG_PATH is the only script that may configure the BMC, allowing you to override MAAS's builtin BMC detection.</li>
<li>All builtin commissioning scripts have been migrated into the database.</li>
</ol>

<h2 id="heading--commissioning-reorder">Commissioning script reordering</h2>

Commissioning scripts have been reordered and some are now set to run in parallel. You can now easily set a script to run before the builtin MAAS commissioning scripts. There are nine significant changes:

<ol>
<li>00-maas-03-install-lldpd -> 20-maas-01-install-lldpd</li>

<li>00-maas-05-dhcp-unconfigured-ifaces -> 20-maas-02-dhcp-unconfigured-ifaces</li>

<li>99-maas-05-kernel-cmdline -> maas -kernel-cmdline</li>

<li>00-maas-00-support-info -> maas-support-info(now runs in parallel)</li>

<li>00-maas-01-lshw -> maas-lshw(now runs in parallel)</li>

<li>00-maas-04-list-modaliases -> maas-list-modaliases(now runs in parallel)</li>

<li>00-maas-06-get-fruid-api-data -> maas-get-fruid-api-data(now runs in parallel)</li>

<li>00-maas-08-serial-ports -> maas-serial-ports(now runs in parallel)</li>

<li>99-maas-01-capture-lldp -> maas-capture-lldp(now runs in parallel)</li>
</ol>

See the [commissioning logs page](https://maas.io/docs/snap/2.9/ui/commissioning-logs) for more details on these changes.

<h2 id="heading--commissioning-speed">Improvements in commissioning speed and logging</h2>

Four improvements have been made to speed up the commissioning process, mostly by running scripts in parallel (see above):

<ol>
<li>Commissioning should now take 60s.</li>
<li>Logging has been added to 20-maas-01-install-lldpd  (commissioning log output).</li>
<li>Logging added to 20-maas-02-dhcp-unconfigured-ifaces (commissioning log output).</li>
<li>`user_data` can now be input directly into the UI.</li>
</ol>

<a href="#heading--bug-fixes"><h2 id="heading--bug-fixes">Bug fixes</h2></a>

<a href="#heading--bug-fixes-2-9-2"><h3 id="heading--bug-fixes-2-9-2">Bugs fixed in 2.9.2 release</h3></a>

1. In the MAAS UI, ARM servers based on the [Hi1620 ARM SoC appear as an "Unknown model"](https://bugs.launchpad.net/maas/+bug/1897946).  A fix was added to [lxd-4.11]( https://discuss.linuxcontainers.org/t/lxd-4-11-has-been-released/10135), released 2021-02-05.

2. Debian package installs of MAAS [reached an "impossible situation"](https://bugs.launchpad.net/maas/+bug/1910910) trying to install the MAAS region controller. This is caused because of an unsupported move from the transitional MAAS PPA to the latest PPA.  The workaround is to purge the MAAS packages (and the snap, if installed), and install clean with the latest PPA enabled, which will install the correct versions.

3. CentOS/RHEL 7+ ship with an unsigned version of GRUB [which breaks UEFI secure boot](https://bugs.launchpad.net/curtin/+bug/1895067).  This bug is believed to be fixed in curtin version 21.1, which is now supported by MAAS 2.9.2.

4. Debug [could not be properly enabled for MAAS snap version 2.9.1](https://bugs.launchpad.net/maas/+bug/1914588).  This has been remedied.

5. The MAAS [Backup doc article](https://maas.io/docs/snap/2.9/ui/backup) [was not clearly written with respect to stopping critical services](https://bugs.launchpad.net/maas/+bug/1892998).  The article has been reworked to make clear in what order steps should be performed so that services are not stopped before appropriate data has been retrieved for backup.

6. Deselecting all architectures in the Ubuntu extra architectures repo [blocks all deployments](https://bugs.launchpad.net/maas/+bug/1894116).  The default architectures have been changed to prevent this issue.

7. MAAS does not allow [FQDNs to be used in place of IPs](https://bugs.launchpad.net/maas/+bug/1911825) when a BMC extracts the address from the `power_address`.  This incorrect behaviour was changed in 2.9.2.

8. The Proxmox driver [uses a hard-coded port that cannot be customised](https://bugs.launchpad.net/maas/+bug/1914165).  This port is now customisable in 2.9.2.

<a href="#heading--bug-fixes-2-9-1"><h3 id="heading--bug-fixes-2-9-1">Bugs fixed in 2.9.1 release</h3></a>

1. It is now possible to [delete an LXD VM in an offline state](https://bugs.launchpad.net/maas/+bug/1908434).
2. MAAS now handles multiple NUMA nodes even when there are [gaps in the numbering](https://bugs.launchpad.net/maas/+bug/1910473).
3. A [snap install issue](https://bugs.launchpad.net/maas/+bug/1910909) was fixed.
4. The way MAAS handles [gateways WRT DHCP](https://bugs.launchpad.net/maas/+bug/1910909) was adjusted.
5. A majority of the document [headings have been converted to links](https://bugs.launchpad.net/maas/+bug/1900010) for easy bookmarking.

<a href="#heading--bug-fixes-2-9"><h3 id="heading--bug-fixes-2-9">Bugs fixed in 2.9 release</h3></a>

1. MAAS 2.9 includes a fix for [Bug #1894727: Admin uses cannot change other user's passwords via the UI](https://bugs.launchpad.net/maas/+bug/1894727).

<h2 id="heading--known-issues">Known issues</h2>

### RAD LHS menu

There is a known issue with the Reader Adaptive Documentation left-hand-side menu (navigation), in that the menu links cannot currently be adapted to the RAD parameters.  This means that selecting a different page in the LHS menu will take you the the RAD for the current recommended version (in this case, Snap/2.8/UI).  Every page that is different in RAD, though, should present you with a top menu, so that you can choose the RAD parameters matching your own preferences.

### Erroneous message about "missing migration"

When upgrading to any release above 2.8, using packages, you may receive a warning about missing migration(s) -- specifically something that looks like this:

```
Setting up maas-common (2.8.3~rc1-8583-g.9ddc8051f-0ubuntu1~18.04.1) ...
Setting up maas-region-api (2.8.3~rc1-8583-g.9ddc8051f-0ubuntu1~18.04.1) ...
Setting up maas-region-controller (2.8.3~rc1-8583-g.9ddc8051f-0ubuntu1~18.04.1) ...
Operations to perform:
  Apply all migrations: auth, contenttypes, maasserver, metadataserver, piston3, sessions, sites
Running migrations:
  No migrations to apply.
  Your models have changes that are not yet reflected in a migration, and so won't be applied.
  Run 'manage.py makemigrations' to make new migrations, and then re-run 'manage.py migrate' to apply them.
```

This warning message has no effect on the installation or operation of MAAS, so it can be safely ignored.
snap-2-9-cli snap-2-9-ui deb-2-9-cli deb-2-9-ui -->


<!-- snap-2-8-cli snap-2-8-ui deb-2-8-cli deb-2-8-ui
<h2>MAAS 2.8 release notes</h2>

<h3>MAAS 2.8.3 released</h3>

MAAS 2.8.3 has been released, replacing the `2.8/stable` channel in snap and the [ppa:maas/2.8](https://launchpad.net/~maas/+archive/ubuntu/2.8).  You can update your 2.8 release to 2.8.3 with the command:

    snap refresh --channel=2.8/stable

or by using the aforementioned PPA.  The focus for this release has been [bugfixing](https://bugs.launchpad.net/maas/+milestone/2.8.3rc1) and [more bugfixing](https://bugs.launchpad.net/maas/+milestone/2.8.3).  No other changes have been made to MAAS with this release.

Here's a summary of the bugs that were fixed in 2.8.3:

* [DNS Servers not set as expected](https://bugs.launchpad.net/maas/+bug/1881133): MAAS was using the region controller IP in dhcpd.conf when other DNS servers are present, effectively bypassing the rack controller proxy to machines.  The code was updated to use the region controller IP for DNS only if no other DNS servers are found.

* [not able to import new image after MAAS upgrade](https://bugs.launchpad.net/maas/+bug/1890468): After upgrading from MAAS 2.6.2 to snap-MAAS 2.8.1, it is impossible to import a new image.  This was fixed in MAAS 2.8.3.

* [an unlogged chown permission error leaves a temporary file behind](https://bugs.launchpad.net/maas/+bug/1883748): Fixed in MAAS 2.8.3.

* [smartctl-validate fails to detect that NVME device is SMART-capable](https://bugs.launchpad.net/maas/+bug/1904329): MAAS 2.8.2 fails to realise that WD Black gaming NVMEs are smart devices, hence MAAS doesn't display attributes.  This is fixed in 2.8.3.

* [cannot use release API on stuck observed IPs](https://bugs.launchpad.net/maas/+bug/1898122): The CLI/API provide commands for forcing the release of an IP, but MAAS 2.8.2 was not allowing these commands to run successfully.  This was fixed.  There is also a workaround for those who cannot upgrade to 2.8.3 right away:

    $ sudo -iu postgres psql
    \c $MAAS_DB \\ -- switch to $MAASDB
    UPDATE maasserver_staticipaddress SET alloc_type = 5 where ip = '$IP_ADDRESS' AND alloc_type = 6;
    ^D
    $ maas $PROFILE ipaddresses release ip='$IP_ADDRESS' force=true

* [MAAS is unable to handle duplicate UUIDs](https://bugs.launchpad.net/maas/+bug/1893690): The firmware for Dell servers (and possibly others) has a bug whereby they use the service number for the UUID, which is not guaranteed to be unique.  This caused MAAS commissioning to fail. The code was modified in 2.8.3 to detect and remove duplicate UUIDs, allowing MAAS to fall back to the MAC address.  There is also a database workaround for those who cannot upgrade to 2.8.3 right away:

    UPDATE maasserver_node SET hardware_uuid=NULL where hardware_uuid='$DUPLICATE_UUID';

* [Ubuntu 20.04 pxe installation fails...](https://bugs.launchpad.net/curtin/+bug/1876258):
When trying to PXE install Ubuntu 20.04, the installation fails with "no such file or directory, /dev/disk/by-id exception." This was an issue with block devices being created without serial numbers, bug fixed in curtin and released with 2.8.3.

* [Failed to allocate the required AUTO IP addresses after 2 retries](https://bugs.launchpad.net/maas/+bug/1902425): MAAS incorrectly perceives that there are no available IP addresses, when in fact, there are plenty still available.  This is fixed in 2.8.3.

* [maas 2.9 rc1 machines create error (backport)](https://bugs.launchpad.net/maas/+bug/1904398): Adding `commission=true` to a CLI machine creation command produces an error.  This was fixed in 2.9 and back-ported to 2.8.3.

* [Lists of LXD nodes are represented in an incompatible data structure](https://bugs.launchpad.net/maas/+bug/1910473): Fixed in 2.8.3.

* Deselecting all architectures in the Ubuntu extra architectures repo [blocks all deployments (backport)](https://bugs.launchpad.net/maas/+bug/1894116).  The default architectures have been changed to prevent this issue. This was fixed in 2.9 and back-ported to 2.8.3.

* [Can't commission without a test (backport)](https://bugs.launchpad.net/maas/+bug/1884278): MAAS 2.8 does not allow machines to be commissioned with zero tests selected; this occurs only for multiple machines, and only when commissioning from the UI.  This was fixed in 2.9 and back-ported to 2.8.3.

Note that there is a workaround for those not ready to upgrade to 2.8.3, specifically, using the CLI to commission machines without testing them:

    maas $PROFILE machine commission $SYSTEM_ID testing_scripts=none

* [UI should not autoselect noauto commissioning scripts (backport)](https://bugs.launchpad.net/maas/+bug/1884827): Previously, users gained the ability to upload commissioning scripts which do not automatically run, but the UI ignores the "noauto" tag and runs the script anyway.  This was fixed in 2.9 and back-ported to 2.8.3.

* [ipmi-config command not found in snap (backport)](https://bugs.launchpad.net/maas/+bug/1891331): The `ipmi-config` cannot be found in a MAAS snap, due to path confusion in the wrapper script. This was fixed in 2.9 and back-ported to 2.8.3.

* [Admin users cannot change other user's passwords via UI (backport)](https://bugs.launchpad.net/maas/+bug/1894727): An administrator is unable to change users passwords via the UI.  This was fixed in 2.9 and back-ported to 2.8.3.

* [all rack addresses in VLAN are included in list of nameservers sent to deployed server (backport)](https://bugs.launchpad.net/maas/+bug/1896684): From the Bug Description: "MAAS forces all rack addresses for all subnets in a single VLAN to any system deployed into any of those subnets. If the deployed systems are isolated, with no gateway configured, they may end up with broken DNS due to having nameservers configured which are not reachable."
This was fixed in 2.9 and back-ported to 2.8.3.

<h3>MAAS 2.8.2 released</h3>

On 1 September 2020, MAAS 2.8.2 was released, replacing the `2.8/stable` channel in snap and the [ppa:maas/2.8](https://launchpad.net/~maas/+archive/ubuntu/2.8).  You can update your 2.8 release to 2.8.2 with the command:

    snap refresh --channel=2.8/stable

or by using the aforementioned PPA.  The focus for this release has been [bugfixing](https://launchpad.net/maas/+milestone/2.8.2rc1) -- there were no changes to MAAS since RC1.

Thanks to everyone who reported the issues with previous 2.7 releases and helped us with the logs.

<h3>MAAS 2.8 released</h3>

Following on from MAAS 2.7, we are happy to announce that MAAS 2.8 is now available. This release features some critical bug fixes, along with some exciting new features.

<h4>Six questions you may have:</h4>

1. [What are the new features & fixes for 2.8?](#heading--2-8-release-notes)
2. [What known issues should I be aware of?](#heading--2-8-known-issues)
3. [How do I install MAAS 2.8 as a snap?](/t/maas-installation/3312)
4. [How do I upgrade my MAAS 2.7 snap to a MAAS 2.8 snap?](/t/maas-installation/3312#heading--upgrade-maas-snap)
5. [How do I install MAAS 2.8 from packages?](/t/maas-installation/3327)
6. [What bugs were fixed in this release?](#heading--bug-fixes)

<h2 id="heading--2-8-release-notes">LXD-based VM host support (Beta)</h2>

MAAS 2.8 adds the beta capability to use LXD-based VM hosts and virtual machines (VMs), in addition to the [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt)-based VM hosts/VMs already available.  These new LXD VM hosts use the same underlying technology as libvirt (QEMU). Unlike libvirt KVMs, though, LXD VMs can be managed without requiring SSH access to the VM host. LXD are remotely accessed via secure HTTP transport, which provides better security for LXD-based VMs. In addition, LXD has a better API, and is part of a much larger constellation of enterprise software, offering a wider range of future features and use cases.

## UI performance improvements for the machine listing page

Within MAAS 2.8, we have made a number of performance improvements to everything related to the machine listing.  Some of the most visible changes involve the way that long lists are presented within categories (see the example below), but there are a number of other changes that make the list easier and more efficient to use.

<a href="https://discourse.maas.io/uploads/default/original/1X/b4ec4124225f052fb8646f754c22d287fffcc850.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/b4ec4124225f052fb8646f754c22d287fffcc850.jpeg"></a> 

Among those other changes are persisting UI state for grouping, new grouping options, bookmark-able URLs with filter and search parameters, and many other performance improvements. If you're interested in more details, see this [blog post](https://ubuntu.com/blog/building-a-cross-framework-ui-with-single-spa-in-maas-2-8).

## Support for using an external/remote PostgreSQL MAAS database with the snap version of MAAS

In order to make MAAS more scalable, we have separated the MAAS database from the MAAS snap, so that the DB can be situated separately.  MAAS 2.8 now allows the MAAS DB to be located outside the snap on localhost, or on a separate, external or remote server.  We complement this capability with extensive instructions for setting up and managing this configuration.  To support those who are testing MAAS, we've also provided a test DB configuration that embeds the database in a separate snap that can easily be connected to MAAS.

<h2 id="heading--bug-fixes">Bug fixes</h2>

We've also fixed number of bugs (see the [list in Launchpad](https://bugs.launchpad.net/bugs/+bugs?field.milestone%3Alist=89978&field.milestone%3Alist=90576&field.milestone%3Alist=90599&field.milestone%3Alist=90640&field.milestone%3Alist=90645&field.milestone%3Alist=90722&field.milestone%3Alist=91005&field.milestone%3Alist=91123&field.milestone%3Alist=91124&field.milestone%3Alist=91180&field.status%3Alist=FIXRELEASED)).  Notable among these are the following:

- [MAAS event table](https://bugs.launchpad.net/maas/+bug/1860619): Power events are now being logged differently to reduce log sizes and improve performance.

- [Unprivileged users controlling services](https://bugs.launchpad.net/maas/+bug/1864201): Unprivileged users can no longer start, stop, or restart services via HTTP channels.

- [Adding KVMs to snap-installed MAAS](https://bugs.launchpad.net/maas/+bug/1852405): SSH key usage has been updated so that KVMs can now be added to snap-installed MAAS without difficulty.

- [Trouble editing physical interfaces in GUI](https://bugs.launchpad.net/maas/+bug/1864241): It is now possible to edit physical interface parameters, when appropriate, from the web UI.

- [Subnet pages slow to load](https://bugs.launchpad.net/maas/+bug/1873430): Subnet pages now load more quickly and efficiently.

- [Trouble loading multiple MAC addresses](https://bugs.launchpad.net/maas/+bug/1865122): You can now reliably load multiple MAC addresses using the web UI.

- [Disabling DNS on regiond subnet breaks DNS](https://bugs.launchpad.net/maas/+bug/1871584): This problem has been resolved.

<h2 id="heading--2-8-known-issues">Known issues</h2>

* **Browser caching issue:** There is a known issue with browser caching on some MAAS pages.  If you initially encounter a page which does not appear to be correctly formatted, please manually clear your browser cache (**not Ctrl-F5**) and it should restore the page to normal.  You manually clear your browser cache, for example, in the "History" section of the menu on a Chrome browser.

* **Extra power types when adding chassis:** ([see bug report](https://bugs.launchpad.net/maas/+bug/1883743)) When adding a chassis, the "Power type" drop-down will show power types not supported by a chassis.  Selecting one of the non-supported power types will result in the UI blocking the action.  Here is a list of power types supported for chassis creation:
  * `mscm` - Moonshot Chassis Manager
  * `msftocs` - Microsoft OCS Chassis Manager
  * `powerkvm` - Virtual Machines on Power KVM, managed by Virsh
  * `recs_box` - Christmann RECS|Box servers
  * `sm15k` - SeaMicro 1500 Chassis
  * `ucsm` - Cisco UCS Manager
  * `virsh` - virtual machines managed by Virsh
  * `vmware` - virtual machines managed by VMware

* **MAAS keys count in user list is bogus:** ([see bug report](https://bugs.launchpad.net/maas/+bug/1884112)) The count of keys shown in the User list in the UI is wrong.

* **Leftover lock files may be present under some conditions:** Even if you purge an old MAAS Debian package, it can leave lock files in `/run/lock/maas*`.  This can cause issues if you later reinstall MAAS, and the previous MAAS user UID has been reassigned.  At that point, MAAS can't remove those files and create new ones.  If this occurs, it is easily fixed by removing those files manually before reinstalling.
snap-2-8-cli snap-2-8-ui deb-2-8-cli deb-2-8-ui -->

<h3>MAAS 3.0 BETA release notes</h3>

We are happy to announce that MAAS 3.0 Beta 1 has been released. This release provides some new features, along with critical bug fixes.

<!-- deb-3-0-ui deb-3-0-cli
The Beta 1 can be installed by adding the `3.0-next` PPA:

```
sudo add-apt-repository ppa:maas/3.0-next
sudo apt update
```

You can then either install MAAS 3.0 Beta1 fresh (recommended) with:

```
sudo apt-get -y install maas
```

Or, if you prefer to upgrade (remember, this is a Beta), you can do so with:

```
sudo apt upgrade maas
```

At this point, you may proceed with a normal installation.

 deb-3-0-cli deb-3-0-ui -->

The Beta 1 can be installed fresh (recommended) with:

```
sudo snap install --channel=3.0/beta maas
```

At this point, you may proceed with a normal installation.

NOTE that this is currently a BETA release, so there will be bugs, instabilities, and missing or incomplete features.  As such, we invite you to thoroughly test this release and provide feedback.  Please remember to [file bugs](https://bugs.launchpad.net/maas/+filebug) as you find them, and please feel free to interact with the developers on [discourse](https://discourse.maas.io/).

<h2>Significant changes</h2>

With the advent of MAAS 3.0, we are removing support for RSD pods.  Registered pods and their machines will be removed by MAAS upon upgrading to MAAS 3.0.

<h4>New features in MAAS 3.0 Beta 1</h4>

1. [PCI and USB devices are now modelled in MAAS](#heading--pci-usb-devices)
2. [IBM Z DPM partition support](#heading--ibm-z-dpm)
3. [Proxmox support](#heading--proxmox-support)
4. [LXD projects support](#heading--lxd-projects-support)
5. [PCI and USB device tabs in machine details](#heading--pci-usb-device-tabs)
6. [Workload annotations](#heading--workload-annotations)
7. [Fixed status bar](#heading--fixed-status-bar)

<h2 id="heading--pci-usb-devices">PCI and USB devices are now modelled in MAAS</h2>

MAAS 3.0 models all PCI and USB devices detected during commissioning:

* Existing machines will have to be recommissioned to have PCI and USB devices modelled

* PCI and USB devices are shown in the UI and on the API using the node-devices endpoint

* Node devices may be deleted on the API only

On the API using the allocate operation on the machines endpoint a machine may allocated by a device vendor_id, product_id, vendor_name, product_name, or commissioning_driver.

<h2 id="heading--ibm-z-dpm">IBM Z DPM partition support</h2>

IBM Z14 and above mainframe partitions are supported in MAAS 3.0.  Note that partitions must use HyperV sockets and properly-defined storage groups.  IBM Z DPM Partitions can be added as a chassis, which allows you to add all partitions in an HMC at once.

<h2 id="heading--proxmox-support">Proxmox support</h2>

MAAS 3.0 supports Proxmox as a power driver:

* Only Proxmox VMs are supported

* You may authenticate with Proxmox using a username and password or a username and API token

* If an API token is used, it must be given permission to query, start and stop VMs.

* Proxmox VMs can be added as a chassis; this allows you to add all VMs in Proxmox at once.

Note that proxmox support has also been back-ported to MAAS 2.9

<h2 id="heading--lxd-projects-support">LXD projects support</h2>

MAAS 3.0 supports the use of LXD projects:

* LXD VM hosts registered in MAAS are now tied to a specific LXD project which MAAS uses to manage VMs

* MAAS doesn’t create or manage machines for VMs in other projects

* MAAS creates the specified project when the VM host is registered, if it doesn't exist

* All existing VMs in the specified project are commissioned on registration

* Resource usage is reported at both project and global levels

<h2 id="heading--pci-usb-device-tabs">PCI and USB device tabs in UI machine details</h2>

Tables for detected PCI and USB devices have been added to the machine details page for MAAS 3.0:

<a  href="https://discourse.maas.io/uploads/default/original/2X/8/87f42bafe321d45af94d73216f933a9067f01df2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/87f42bafe321d45af94d73216f933a9067f01df2.png"></a>

These tables include a new skeleton loading state while node devices are being fetched:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/4faa1d8cd996a25ee5089ada924b405bc8903aa4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/4faa1d8cd996a25ee5089ada924b405bc8903aa4.png"></a>

The user is prompted to commission the machine if no devices are detected.

<h2 id="heading--workload-annotations">Workload annotations</h2>

Workload annotations have been added to the machine summary page in MAAS 3.0.  These allow you to apply `owner_data` to a machine and make it visible while the machine is in allocated or deployed state:

<a href="https://discourse.maas.io/uploads/default/original/2X/5/54682ae5f9c7bb449a1ad222679be0156f27d109.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/5/54682ae5f9c7bb449a1ad222679be0156f27d109.png"></a>

This data is cleared once the machine state changes to something other than "allocated" or "deployed."  The machine list can be filtered by these workload annotations.  MAAS will warn you on the release page to remind you that workload annotations will be cleared upon releasing the machine.

<h2 id="heading--fixed-status-bar">Fixed status bar</h2>

In MAAS 3.0, a fixed status bar has been added to the bottom of the screen, which will always display the MAAS name and version on the left.  The right side of the status bar is intended to show contextual data, depending on the UI panel currently displayed. For now, the only data shown is a “last commissioned” timestamp when the user is on a machine details page:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3a15d7e1d7251f3e928e3054a2aab71f414503bd.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3a15d7e1d7251f3e928e3054a2aab71f414503bd.png"></a>