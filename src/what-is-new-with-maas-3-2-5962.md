<!-- "What is new with MAAS 3.2" -->

<a href="#heading--MAAS-3.2-release-notes"><h2 id="heading--MAAS-3.2-release-notes">MAAS 3.2 release notes</h2></a>

Here you will find release notes for all releases under the 3.2 version.

<a href="#heading--maas-3-2-9-release-notes"><h2 id="heading--maas-3-2-9-release-notes">MAAS 3.2.9 release notes</h2></a>

We are happy to announce that MAAS 3.2.9 has been released.  This point release of MAAS 3.2 provides four [high-profile bug fixes](#heading--MAAS-3-2-9-bug-fixes).

<a href="#heading--MAAS-3-2-8-release-notes"><h2 id="heading--MAAS-3-2-8-release-notes">MAAS 3.2.8 release notes</h2></a>

We are happy to announce that MAAS 3.2.8 has been released.  This point release of MAAS 3.2 provides a number of [high-profile bug fixes](#heading--MAAS-3-2-8-bug-fixes).

<a href="#heading--MAAS-3-2-7-release-notes"><h2 id="heading--MAAS-3-2-7-release-notes">MAAS 3.2.7 release notes</h2></a>

We are happy to announce that MAAS 3.2.7 has been released.  This point release of MAAS 3.2 provides a number of [high-profile bug fixes](#heading--MAAS-3-2-7-bug-fixes).

<a href="#heading--3-2-6-maas-release-notes"><h2 id="heading--3-2-6-maas-release-notes">MAAS 3.2.6 release notes</h2></a>

We are happy to announce that MAAS 3.2.6 has been released. This point release of MAAS 3.2 provides a fix for a critical bug that prevented MAAS from enlisting machines on subnets with active DNS:

- #1989970 [Can't enlist machines on subnets with DNS set](https://bugs.launchpad.net/bugs/1989970)`↗`

No other changes were made for this point release.

<a href="#heading--3-2-5-maas-release-notes"><h2 id="heading--3-2-5-maas-release-notes">MAAS 3.2.5 release notes</h2></a>

MAAS 3.2.5 was an attempt to fix a critical issue in 3.2.4.  This issue was resolved in MAAS 3.2.6, listed above. 

<a href="#heading--3-2-4-maas-release-notes"><h2 id="heading--3-2-4-maas-release-notes">MAAS 3.2.4 release notes</h2></a>

We are happy to announce that MAAS 3.2.4 has been released.  This point release of MAAS 3.2 provides a fix for a critical bug that prevented the controllers page from displaying under certain conditions:

-  #1983624 [Fresh MAAS 3.2 install failed to find controller](https://bugs.launchpad.net/bugs/1983624)`↗`

This release also addresses build issues found in prior point releases.

<a href="#heading--3-2-2-3-2-3-release-notes"><h2 id="heading--3-2-2-3-2-3-release-notes">MAAS 3.2.2 ~ MAAS 3.2.3</h2></a>

MAAS 3.2.2 and MAAS 3.2.3 were successive attempts to fix issues in MAAS.  These issues were resolved in MAAS 3.2.4, listed above.

<a href="#heading--3-2-1-maas-release-notes"><h2 id="heading--3-2-1-maas-release-notes">MAAS 3.2.1 release notes</h2></a>

We are happy to announce that MAAS 3.2.1 has been released.  This point release of MAAS 3.2.1 provides support for Rocky Linux UEFI ([bug number 1955671](https://bugs.launchpad.net/bugs/1955671))`↗`, along with fixes for a number of recently-reported bugs:

- #1955671: [support for rocky linux UEFI](https://bugs.launchpad.net/bugs/1955671)`↗`
- #1980436: [MAAS CLI with anonymous access fails when TLS is enabled](https://bugs.launchpad.net/bugs/1980436)`↗`
- #1980490: [MAAS regiond IPC crash due to a machine-resources binary crash when parsing some VPDs](https://bugs.launchpad.net/bugs/1980490)`↗`
- #1980818: [Configure DHCP for VLAN](https://bugs.launchpad.net/bugs/1980818)`↗`
- #1981536: [volume group creation fails on md device - MAAS 3.2](https://bugs.launchpad.net/bugs/1981536)`↗`
- #1981560: [upgrade from 3.1 to 3.2 using debian packages missing steps](https://bugs.launchpad.net/bugs/1981560)`↗`
- #1982984: [reverse-proxy service is not displayed for region controller](https://bugs.launchpad.net/bugs/1982984)`↗`
- #1929478: [Commissioning fails with binary data in IPMI Lan_Conf_Security_Keys](https://bugs.launchpad.net/bugs/1929478)`↗`
- #1982208: [agent.yaml.example is missing when maas is installed via deb package](https://bugs.launchpad.net/bugs/1982208)`↗`
- #1982846: [Missing update_interface method on controller websocket handler](https://bugs.launchpad.net/bugs/1982846)`↗`

Please see the release notes for the 3.2 release, below, for a summary of 3.2 features.
	
<a href="#heading--current-maas-release-notes"><h2 id="heading--current-maas-release-notes">MAAS 3.2 release notes</h2></a>

We are happy to announce that MAAS 3.2 is now available.

<a href="#heading--new-features"><h2 id="heading--new-features">New MAAS 3.2 features</h2></a>

MAAS 3.2 provides several new features, as well as the usual cadre of bug fixes.

<a href="#heading--improved-performance"><h3 id="heading--improved-performance">Improved performance</h3></a>

As part of the MAAS 3.2 development effort, we have taken steps to improve the performance of machine listings.  To date, we have measured the speed of listing a large number (100-1000) of machines via the REST API to be 32% faster, on average.  During the next cycle, we will be actively working to improve MAAS performance for other operations (such as search).

<a href="#heading--better-redfish-support"><h3 id="heading--better-redfish-support">Better Redfish support</h3></a>

MAAS has previously supported the Redfish protocol for some time, but as an option, preferring IPMI over all others if a choice of protocol was possible.  In contrast, MAAS 3.2 supports Redfish as a BMC protocol by preferring Redfish over IPMI, provided that:

- The BMC has a Redfish Host Interface enabled
- That host interface can be accessed by the MAAS host

MAAS already supports Redfish, but with MAAS 3.2 we’re trying to auto-detect Redfish and use it if it's available.

You may know that Redfish is an alternative to the IPMI protocol for connecting with machine BMCs.  It provides additional features above and beyond those provided by IPMI.  Eventually, Redfish should supplant IPMI as the default BMC interface.

If the machine uses either IPMI or Redfish for its BMC, the ephemeral environment will automatically detect it, create a separate user for MAAS and configure the machine, so that MAAS may check and control the machine’s power status. Note that the name of the user that MAAS creates in the BMC is controlled by the `maas_auto_ipmi_user` config setting, both for IPMI and Redfish; nothing has changed in this regard with MAAS 3.2.

You can check whether or not a machine can communicate via Redfish, with the command: 

```nohighlight
dmidecode -t 42
```

If the machine has been enlisted by MAAS, you can also check the output of the `30-maas-01-bmc-config` commissioning script to discover this.

<a href="#heading--maas-native-tls"><h3 id="heading--maas-native-tls">MAAS native TLS</h3></a>

MAAS 3.2 provides [native TLS](/t/how-to-enable-maas-native-tls/5116#heading--about-maas-native-tls). MAAS now has built-in TLS support for communicating with the UI and API over HTTPS. This eliminates the need to deploy a separate TLS-terminating reverse-proxy solution in front of MAAS to provide secure access to API and UI.  Note that you can still set up an HA proxy if you are using multiple controllers.

<a href="#heading--hardware-sync-for-deployed-machines"><h3 id="heading--hardware-sync-for-deployed-machines">Hardware sync for deployed machines</h3></a>

MAAS 3.2 allows you to [sync hardware changes for deployed machines](https://maas.io/docs/how-to-customise-machines#heading--how-to-enable-hardware-sync-on-a-machine)`↗`.  You can see real-time updates to storage, etc., for a running machine.  This feature requires a special parameter be set prior to deployment.  Coupled with the existing ability to commission deployed machines, MAAS 3.2 moves a step closer to real-time reconfiguration of active, deployed, bare-metal.

<a href="#heading--expanded-tagging-capability"><h3 id="heading--expanded-tagging-capability">Expanded tagging capability</h3></a>
 
MAAS 3.2 provides greatly [expanded tagging capability](/t/how-to-tag-machines/5928#heading--automatic-tags).  You can auto-apply tags to machines that match a custom XPath expression. Setting up an automatic tag lets you recognise special hardware characteristics and settings, e.g., the gpu passthrough.

<a href="#heading--more-new-features"><h3 id="heading--more-new-features">More new features</h3></a>

MAAS 3.2 rounds out the feature set with a few more items:

- [Support for observability (O11y) in MAAS](/t/how-to-monitor-maas/5204): MAAS now supports integration with FOSS Observability stacks.

- [Ability for user to specify IPMI cipher suite](/t/power-drivers-reference/5246): You can explicitly select which cipher suite to use when interacting with a BMC.

- Roll-out of our new tabbed Reader Adaptive Documentation (incremental across the release cycle): We've eliminated the top menus; each page now contains information for all versions, selectable by dropdowns above the relevant sections.

<a href="#heading--how-to-install-maas-3-2"><h2 id="heading--how-to-install-maas-3-2">How to install MAAS 3.2</h2></a>

MAAS 3.2 can be installed fresh from snaps (recommended) with:

```
sudo snap install --channel=3.2 maas
```

MAAS 3.2 can be installed from packages by adding the `ppa:maas/3.2` PPA:

```
sudo add-apt-repository ppa:maas/3.2
sudo apt update
sudo apt install maas
```

You can then install MAAS 3.2 fresh (recommended) with:

```
sudo apt-get -y install maas
```

Or, if you prefer to upgrade, you can:

```
sudo apt upgrade maas
```

At this point, proceed with a normal installation.

<a href="#heading--MAAS-3-2-9-bug-fixes"><h2 id="heading--MAAS-3-2-9-bug-fixes">MAAS 3.2.9 bug fixes</h2></a>

The following high-profile bugs have been fixed in MAAS 3.2.9:

- [2027735](https://bugs.launchpad.net/maas/+bug/2027735)`↗`: Concurrent API calls don't get balanced between regiond processes
- [2020397](https://bugs.launchpad.net/maas/+bug/2020397)`↗`: Custom images which worked ok is not working with 3.2
- [2022926](https://bugs.launchpad.net/maas/+bug/2022926)`↗`: Wrong metadata url in enlist cloud-config
- [2027621](https://bugs.launchpad.net/maas/+bug/2027621)`↗`: ipv6 addresses in dhcpd.conf

<a href="#heading--MAAS-3-2-8-bug-fixes"><h2 id="heading--MAAS-3-2-8-bug-fixes">MAAS 3.2.8 bug fixes</h2></a>

The following bugs have been fixed in MAAS 3.2.8:

- [2009186](https://bugs.launchpad.net/maas/+bug/2009186)`↗`: CLI results in connection timed out when behind haproxy and 5240 is blocked 
- [2009805](https://bugs.launchpad.net/maas/+bug/2009805)`↗`: machine deploy install_kvm=True fails 
- [2012139](https://bugs.launchpad.net/maas/+bug/2012139)`↗`: maas commands occasionally fail with NO_CERTIFICATE_OR_CRL_FOUND when TLS is enabled 
- [1807725](https://bugs.launchpad.net/maas/+bug/1807725)`↗`: Machine interfaces allow '_' character, results on a interface based domain breaking bind (as it doesn't allow it for the host part). 
- [1979403](https://bugs.launchpad.net/maas/+bug/1979403)`↗`: commission failed with MAAS 3.1 when BMC has multiple channels but the first channel is disabled 
- [1986590](https://bugs.launchpad.net/maas/+bug/1986590)`↗`: maas-cli from PPA errors out with traceback - ModuleNotFoundError: No module named 'provisioningserver'

<a href="#heading--MAAS-3-2-7-bug-fixes"><h2 id="heading--MAAS-3-2-7-bug-fixes">MAAS 3.2.7 bug fixes</h2></a>

The following bugs have been fixed in MAAS 3.2.7:

 - [1989974](https://bugs.launchpad.net/maas/+bug/1989974): rackd fails on CIS-hardened machine with "Failed to update and/or record network interface configuration: Expecting value: line 1 column 1 (char 0)"
 - [1938296](https://bugs.launchpad.net/maas/+bug/1938296): MAAS 3.0 incorrectly calculates the amount of free space on drive		High	Alberto Donato 	Fix Released
 - [1982866](https://bugs.launchpad.net/maas/+bug/1982866):	MAAS Breaks historical custom images		High	Christian Grabowski 	Fix Released
 - [1988759](https://bugs.launchpad.net/maas/+bug/1988759):	Provisioning LXD vmhost fails		High	Alberto Donato 	Fix Released
 - [1990014](https://bugs.launchpad.net/maas/+bug/1990014):	regiond.conf "debug_http: true" causes image downloads from regiond to fail with 500 error code		High	Anton Troyanov 	Fix Released
 - [1992185](https://bugs.launchpad.net/maas/+bug/1992185):	unable to deploy a machine with vmhost if a bond interface was created		High	Alberto Donato 	Fix Released
 - [1993152](https://bugs.launchpad.net/maas/+bug/1993152):	Updating a VM host through API unset tags		High	Alberto Donato 	Fix Released
 - [1993289](https://bugs.launchpad.net/maas/+bug/1993289):	Pod storage pool path can't be blank		High	Alberto Donato 	Fix Released
 - [1992330](https://bugs.launchpad.net/maas/+bug/1992330):	Use the rack controller IP as DNS when relaying DHCP		Medium	Björn Tillenius 	Fix Released
 - [1993618](https://bugs.launchpad.net/maas/+bug/1993618):	Web UI redirection policy can invalidate HAProxy and/or TLS setup		Medium	Anton Troyanov 	Fix Released
 - [1994945](https://bugs.launchpad.net/maas/+bug/1994945):	Failure to create ephemeral VM when no architectures are found on the VM host		Medium	Igor Brovtsin 	Fix Released
 - [1996419](https://bugs.launchpad.net/maas/+bug/1996419):	renaming a DNS record to a previous name fails with error: list.remove(x): x not in list		Medium	 	Fix Released
 - [1996997](https://bugs.launchpad.net/maas/+bug/1996997):	LXD resources fails on a Raspberry Pi with no Ethernet

<a href="#heading--bugs-fixed-in-maas-3-2"><h2 id="heading--bugs-fixed-in-maas-3-2">Bugs fixed in MAAS 3.2</h2></a>

Here is the breakdown of bugs fixed across the MAAS 3.2 release:

- [MAAS 3.2.1](https://launchpad.net/maas/+milestone/3.2.1)`↗`
- [MAAS 3.2](https://launchpad.net/maas/3.2/3.2.0)`↗`
- [MAAS 3.2 RC 2](https://launchpad.net/maas/3.2/3.2.0-rc2)`↗`
- [MAAS 3.2 RC 1](https://launchpad.net/maas/+milestone/3.2.0-rc1)`↗`
- [MAAS 3.2 Beta 6](https://launchpad.net/maas/3.2/3.2.0-beta6)`↗`
- [MAAS 3.2 Beta 5](https://launchpad.net/maas/3.2/3.2.0-beta5)`↗`
- [MAAS 3.2 Beta 4](https://launchpad.net/maas/3.2/3.2.0-beta4)`↗`
- [MAAS 3.2 Beta 3](https://launchpad.net/maas/3.2/3.2.0-beta3)`↗`
- [MAAS 3.2 Beta 2](https://launchpad.net/maas/+milestone/3.2.0-beta2)`↗`
- [MAAS 3.2 Beta 1](https://launchpad.net/maas/3.2/3.2.0-beta1)`↗`
 
<a href="#heading--known-issues-maas-3-2"><h2 id="heading--known-issues-maas-3-2">Known issues for MAAS 3.2</h2></a>

The following known issues exist for MAAS 3.2:

<a href="#heading--Cannot-update-controller/device-tags-via-WebSocket-API"><h3 id="heading--Cannot-update-controller/device-tags-via-WebSocket-API">Cannot update controller/device tags via WebSocket API</h3></a>

If you attempt to update a list of tags of a device with an automatic tag, you get an error: "Cannot add tag tag-name to node because it has a definition".

If you attempt to manually make the same API request, but send a list of tags with the automatic tag filtered out, the automatic tag will be removed from the device.

<a href="#heading--other-maas-versions"><h2 id="heading--other-maas-versions">Release notes for other MAAS versions</h2></a>

Here are release notes for other relatively recent MAAS versions:

- [MAAS 3.1](/t/what-is-new-with-maas-3-1/5964)
- [MAAS 3.0](/t/what-is-new-with-maas-3-0/5963)
- [MAAS 2.9](/t/what-is-new-with-maas-2-9/5961)
- [MAAS 2.8](/t/what-is-new-with-maas-2-8/5994)
- [MAAS 2.7](/t/what-is-new-with-maas-2-7/5993)
