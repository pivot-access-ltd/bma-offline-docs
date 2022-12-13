<!-- "What is new with MAAS 2.9" -->

<h2>MAAS 2.9.2 release notes</h2>

We have released MAAS 2.9.2, which contains two new features, and some notable [bug fixes](https://launchpad.net/maas/+milestone/2.9.2)`↗`. The two new features are:

- Proxmox driver: A driver has been added to MAAS 2.9.2 which interacts with the Proxmox API.  Only one URL is needed, though a username and credentials are required.  Credentials can be either a password or an API token.  Note that if you use a token, you have to configure the permissions for the token.  Newly-created Proxmox tokens don't assign any permissions by default, so you must add `power on`, `power off`, and `query power` permissions to the token before using it.

- Power driver Webhook:  A webhook was added to 2.9.2, which allows MAAS to interface with another web service that's running the power commands.  This webhook is provided for interacting with objects that MAAS does not support, that is, the MAAS team supports the driver itself, but whatever is interfacing to the driver is not supported.  This webhook as three URLs, one each for power on, power off, and power query.  Optionally, this webhook also supports a power user and password or token (RFC 6717).  This gives you a way to add your own power drivers without waiting for the driver to be added to MAAS.  There is a [video tutorial](https://discourse.maas.io/t/maas-show-and-tell-proxmox-and-webhook/3754/3)`↗` available on this new feature.

You can also find a [digest](#heading--bug-fixes-2-9-2) of the 2.9.2 bug fixes below.

<h2>MAAS 2.9.1 release notes</h2>

Building upon MAAS 2.9, we have released 2.9.1, which contains some notable [bug fixes](https://launchpad.net/maas/+milestone/2.9.1)`↗`.  You can find a [digest](#heading--bug-fixes-2-9-1)`↗` of these fixes below.

<h2>MAAS 2.9 release notes</h2>

Following on from MAAS 2.8, we are happy to announce that MAAS 2.9 is now available.

#### What are the new features & fixes for MAAS 2.9 and MAAS 2.9.1?

- [Focal Fossa (20.04) as default commissioning/deployment release](#heading--focal-default)
- [Support for OpenVswitch bridge type](#heading--openvswitch)
- [Support for NUMA, SR-IOV, and hugepages](#heading--numa)
- [Improved performance for large MAAS installations](#heading--improved-perf-large-maas)
- [New release notifications](#heading--new-release-notifications)
- [IPMI configuration screens](#heading--ipmi-config-screens)
- [Descriptions when marking machines broken](#heading--descrip-mark-mach-broken)
- [Curtin 20.2 now included](#heading--curtin-20-2-included)
- [HTTP boot disabled](#heading--http-boot-disabled)
- [BMC/IPMI default parameter additions](#heading--bmc-param-additions)
- [New global IPMI configuration options](#heading--new-config-options)
- [Addition of IPMI config options to UI](#heading--global-config-settings)
- [New MAAS CLI power command](#heading--maas-power)
- [Commissioning speed improvements](#heading--commissioning-speed)
- [BMC improvements](#heading--bmc-improve)
- [IPMI power driver upgrades](#heading--ipmi-driver)
- [Enlistment script improvements](#heading--enlistment-scripts)
- [Commissioning script improvements](#heading--commissioning-scripts)
- [Commissioning script reordering](#heading--commissioning-reorder)
- [Reader Adaptive Documentation](#heading--rad)
- [Offline documentation](#heading--offline-docs)

<h4>Six other questions you may have:</h4>

- [What known issues should I be aware of?](#heading--known-issues)
- [How do I install MAAS 2.9?](/t/how-to-install-maas/5128)
- [How do I upgrade my MAAS 2.8 snap to a MAAS 2.9 snap?](/t/how-to-install-maas/5128#heading--upgrade-maas-snap)
- [How do I install MAAS 2.9 from packages?](/t/how-to-install-maas/5128#heading--install-from-packages)
- [How do I upgrade MAAS 2.8 to MAAS 2.9 using packages?](/t/how-to-install-maas/5128#heading--upgrade-via-packages)
- [What bugs are fixed so far in this release?](#heading--bug-fixes)

<h2 id="heading--focal-default">Focal Fossa (Ubuntu 20.04 LTS) as default release</h2>

Ubuntu 20.04 LTS (Focal Fossa) is now the default commissioning and deployment release for new MAAS installations.  Machines deployed with Focal may now be registered as KVM hosts.

<h2 id="heading--openvswitch">Support for OpenVswitch bridge type</h2>

MAAS 2.9 allows you to create an OpenVswitch bridge type when creating a bridge.

<h2 id="heading--numa">Support for NUMA, SR-IOV, and hugepages</h2>

MAAS 2.9 adds extensive optimisation tools for using NUMA with virtual machines. You can now see how many VMs are allocated to each NUMA node, along with the allocations of cores, storage, and memory. You can quickly spot a VM running in multiple NUMA nodes, and optimise accordingly, with instant updates on pinning and allocations. You can also tell which VMs are currently running.  Using the CLI, you can also pin nodes to specific cores, and configure hugepages for use by VMs.

Specifically, there are five new features available to support NUMA, SR-IOV, and hugepages:

- You can examine resources on a per-NUMA-node basis.
- You can pin nodes to specific cores (CLI only).
- You can see resources for VM hosts supporting NUMA nodes.
- You can see the alignment between VM host interfaces and NUMA nodes.
- You can configure and use hugepages (configurable in CLI only).

This functionality comes with an enhanced panel in the "KVM" details section:

<a href="https://discourse.maas.io/uploads/default/optimized/1X/57245bbbfe6d28e83c9b7fb30e52caf05714eb00_2_485x500.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/1X/57245bbbfe6d28e83c9b7fb30e52caf05714eb00_2_485x500.png"></a>

See the [VM hosting](/t/about-vm-hosting/5068) page for more details, and be sure to use the menu at the top of that page to select your desired build method and interface, so that you'll see the most relevant instructions.

<h2 id="heading--improved-perf-large-maas">Improved performance for large MAAS installations</h2>

MAAS 2.9 includes changes to the machine batch size that the UI loads. Previously the UI loaded machines in batches of 25; it now pulls in 25 for the first call, then 100 at a time in subsequent batches.

You can see the results of the investigation in [this video podcast](https://discourse.maas.io/t/maas-show-and-tell-improving-ui-performance-for-large-maas-installs/3515)`↗`.

<h2 id="heading--new-release-notifications">New release notifications</h2>

MAAS now includes new release notifications for users and administrators.  These appear when a new release is available:

<a href="https://discourse.maas.io/uploads/default/original/1X/c4f426b9f493a970efcc59c4d948d24fa5f12860.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c4f426b9f493a970efcc59c4d948d24fa5f12860.png"></a>

Both regular and administrative users can snooze these notifications for two weeks at a time.  Administrative users can opt out of new release notifications completely, preventing notifications for any user of that MAAS.

<h2 id="heading--ipmi-config-screens">IPMI configuration screens</h2>

MAAS now includes UI panels corresponding to the [IPMI power driver upgrades](#heading--ipmi-driver) mentioned earlier:

<a href="https://discourse.maas.io/uploads/default/original/1X/433b28f5dd807caef7c7382f9a877607c2ea2dac.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/433b28f5dd807caef7c7382f9a877607c2ea2dac.png"></a>

This screen can be reached from `Settings | Configuration | Commissioning`.

<h2 id="heading--descrip-mark-mach-broken">Descriptions when marking machines broken</h2>

When marking a machine broken, a description can now be included:

<a href="https://discourse.maas.io/uploads/default/original/1X/69df48044c964d27caf59b60dcf5bf5210894c15.png?" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/69df48044c964d27caf59b60dcf5bf5210894c15.png?"></a>

This description appears in that machine's row on the machine list.

<h2 id="heading--curtin-20-2-included">Curtin 20.2 now included</h2>

A number of MAAS issues have actually been issues with an older version of Curtin.  MAAS now includes Curtin 20.2, which fixes many of these issues, including [MAAS is changing my boot order!](https://discourse.maas.io/t/maas-is-changing-my-boot-order/3491)`↗`.

<h2 id="heading--http-boot-disabled">HTTP boot disabled</h2>

MAAS 2.9 disables HTTP boot. There are known issues with HTTP boot in MAAS, as well as known issues for HTTP boot with grub (e.g. https://bugs.launchpad.net/maas/+bug/1899581 `↗`)  This shouldn’t affect machine boot, as machines will normally try PXE as a fallback boot method if HTTP boot fails.  Be aware, though, that machine boot will fail if the BIOS is configured to boot only over HTTP; those machines need to be reconfigured to use PXE.

<h2 id="heading--bmc-param-additions">30-maas-01-bmc-config parameter additions</h2>

Four new parameters have been added for IPMI BMC configuration.  These parameters will pull from the global defaults, eliminating the need to set the corresponding parameter in each instance.

- maas_auto_ipmi_user - The username for the MAAS created IPMI user. Default comes from the global configuration setting.
- maas_auto_ipmi_user_password - The password for the MAAS created IPMI user, by default a random password is generated.
- maas_auto_ipmi_k_g_bmc_key - he IPMI K_g pre-shared encryption key to be set when adding the MAAS IPMI user. Note not all IPMI BMCs support setting the k_g key, if MAAS is unable to set the key commissioning will fail. Default comes from the global configuration setting. If an IPMI K_g key is set but the key is rejected by the BMC MAAS will automatically retry without the K_g key. This works around an edge case where some BMCs will allow you to set an K_g key but don’t allow it to be used.
- maas_auto_ipmi_user_privilege_level - The IPMI user privilege level to use when adding the MAAS IPMI user. Possible options are USER, OPERATOR, or ADMIN. Default comes from the global configuration setting.

Note that MAAS will not capture the BMC MAC address when detecting IPMI BMCs.

<h2 id="heading--new-config-options">New global IPMI configuration options</h2>

Two new global IPMI configuration options have been added:

- maas_auto_ipmi_k_g_bmc_key - sets a global default IPMI BMC key.
- maas_auto_ipmi_user_privilege_level - sets a global default IPMI BMC user privilege level.
    
<h2 id="heading--global-config-settings">Addition of IPMI config options to UI</h2>

You may now set the global configuration options `maas_auto_ipmi_user`, `maas_auto_ipmi_k_g_bmc_key`, and `maas_auto_ipmi_user_privilege_level` on the "Settings" page in the UI under "Commissioning."

<h2 id="heading--maas-power">New maas.power CLI command</h2>

Available in all MAAS 2.9 releases is the new `maas.power` CLI command. This command interfaces directly with the supported MAAS power drivers. This command can be used to control the power on a machine before it has been added to MAAS, for all maas supported power drivers.  You can get power status, turn machines on or off, and cycle power.  The `maas.power --help` shows usage details, including syntax for naming each power type (consistent with other MAAS CLI commands).

<h2 id="heading--rad">IPMI BMC detection improvements (RAD)</h2>

This release adds two improvements to IPMI BMC detection capability:

- The IPMI cipher suite ID will now be automatically detected. MAAS tries to find the most secure cipher suite available. Preference order is 17, 3, 8, 12. If detection fails MAAS will fall back to using freeipmi-tool default, 3, which is what previous versions of MAAS use.
- The IPMI K_g BMC key will now be automatically detected if previously set. 

<h3 id="heading--rad">Reader Adaptive Documentation (RAD)</h3>

This release features Reader Adaptive Documentation, which allows you to adapt individual pages to your install method (Snap vs. Deb), version (2.7/2.8/2.9), and preferred interface (CLI/UI). 

<h2 id="heading--offline-docs">Offline documentation</h2>

This release will include offline documentation for those users whose MAAS installations reside behind firewalls, unable to access the online documentation.

<h2 id="heading--bmc-improve">BMC improvements</h2>

Three substantial improvements to BMC usage have been released:

- IPMI, HP Moonshot, and Facebook Wedge BMC detection and configuration scripts have been migrated to the commissioning script `30-maas-01-bmc-config `.
- BMC detection and configuration are now logged to commissioning results.
- If BMC configuration is skipped a ScriptResult will log this result, and indicate which user chose to skip the configuration step.

<h3 id="heading--ipmi-driver">IPMI power driver upgrades</h3>

Three new configuration options have been added to the IPMI power driver:

- K_g - The BMC Key of the IPMI device. Used to encrypt all traffic to and from the device during communication.
- Cipher Suite ID - The cipher suite to use when communicating with the IPMI BMC. Only 3, 8, 12, and 17 are available as only those enable ciphers for authentication, integrity, and confidentiality. Defaults to 3, freeipmi-tools default. See http://fish2.com/ipmi/bp.pdf `↗` for more information.
- Privilege Level - The IPMI privilege level to use when communicating with the BMC. Defaults to OPERATOR.

See the [2.9 UI](https://maas.io/docs/power-management#heading--ipmi)`↗` or [2.9 CLI](https://maas.io/doc/power-management#heading--ipmi)`↗` power management pages for details.

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

See the [commissioning logs page](https://maas.io/docs/commissioning-logs)`↗` for more details on these changes.

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

- In the MAAS UI, ARM servers based on the [Hi1620 ARM SoC appear as an "Unknown model"](https://bugs.launchpad.net/maas/+bug/1897946)`↗`.  A fix was added to [lxd-4.11]( https://discuss.linuxcontainers.org/t/lxd-4-11-has-been-released/10135)`↗`, released 2021-02-05.

- Debian package installs of MAAS [reached an "impossible situation"](https://bugs.launchpad.net/maas/+bug/1910910)`↗` trying to install the MAAS region controller. This is caused because of an unsupported move from the transitional MAAS PPA to the latest PPA.  The workaround is to purge the MAAS packages (and the snap, if installed)`↗`, and install clean with the latest PPA enabled, which will install the correct versions.

- CentOS/RHEL 7+ ship with an unsigned version of GRUB [which breaks UEFI secure boot](https://bugs.launchpad.net/curtin/+bug/1895067)`↗`.  This bug is believed to be fixed in curtin version 21.1, which is now supported by MAAS 2.9.2.

- Debug [could not be properly enabled for MAAS snap version 2.9.1](https://bugs.launchpad.net/maas/+bug/1914588)`↗`.  This has been remedied.

- The MAAS [Backup doc article](https://maas.io/docs/backup)`↗` [was not clearly written with respect to stopping critical services](https://bugs.launchpad.net/maas/+bug/1892998)`↗`.  The article has been reworked to make clear in what order steps should be performed so that services are not stopped before appropriate data has been retrieved for backup.

- Deselecting all architectures in the Ubuntu extra architectures repo [blocks all deployments](https://bugs.launchpad.net/maas/+bug/1894116)`↗`.  The default architectures have been changed to prevent this issue.

- MAAS does not allow [FQDNs to be used in place of IPs](https://bugs.launchpad.net/maas/+bug/1911825)`↗` when a BMC extracts the address from the `power_address`.  This incorrect behaviour was changed in 2.9.2.

- The Proxmox driver [uses a hard-coded port that cannot be customised](https://bugs.launchpad.net/maas/+bug/1914165)`↗`.  This port is now customisable in 2.9.2.

<a href="#heading--bug-fixes-2-9-1"><h3 id="heading--bug-fixes-2-9-1">Bugs fixed in 2.9.1 release</h3></a>

- It is now possible to [delete an LXD VM in an offline state](https://bugs.launchpad.net/maas/+bug/1908434)`↗`.
- MAAS now handles multiple NUMA nodes even when there are [gaps in the numbering](https://bugs.launchpad.net/maas/+bug/1910473)`↗`.
- A [snap install issue](https://bugs.launchpad.net/maas/+bug/1910909)`↗` was fixed.
- The way MAAS handles [gateways WRT DHCP](https://bugs.launchpad.net/maas/+bug/1910909)`↗` was adjusted.
- A majority of the document [headings have been converted to links](https://bugs.launchpad.net/maas/+bug/1900010)`↗` for easy bookmarking.

<a href="#heading--bug-fixes-2-9"><h3 id="heading--bug-fixes-2-9">Bugs fixed in 2.9 release</h3></a>

- MAAS 2.9 includes a fix for [Bug #1894727: Admin uses cannot change other user's passwords via the UI](https://bugs.launchpad.net/maas/+bug/1894727)`↗`.

<h2 id="heading--known-issues">Known issues</h2>

### RAD LHS menu

There is a known issue with the Reader Adaptive Documentation left-hand-side menu (navigation), in that the menu links cannot currently be adapted to the RAD parameters.  This means that selecting a different page in the LHS menu will take you the the RAD for the current recommended version.  Every page that is different in RAD, though, should present you with a top menu, so that you can choose the RAD parameters matching your own preferences.

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
