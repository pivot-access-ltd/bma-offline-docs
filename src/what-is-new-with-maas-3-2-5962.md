<!-- "MAAS 3.2 RC1 release notes" -->
We are happy to announce that MAAS 3.2 RC1 is now available.

<a href="#heading--new-features"><h2 id="heading--new-features">New MAAS 3.2 features</h2></a>

MAAS 3.2 provides several new features, as well as the usual cadre of bug fixes.

<a href="#heading--better-redfish-support"><h3 id="heading--better-redfish-support">Better Redfish support</h3></a>

MAAS has previously supported the Redfish protocol for some time, but as an option, preferring IPMI over all others if a choice of protocol was possible.  In contrast, MAAS 3.2 supports Redfish as a BMC protocol by preferring Redfish over IPMI, provided that:

- The BMC has a Redfish Host Interface enabled
- That host interface can be accessed by the MAAS host

MAAS already supports Redfish, but with MAAS 3.2 we’re trying to auto-detect Redfish and use it if it's available.

You may know that Redfish is an alternative to the IPMI protocol for connecting with machine BMCs.  It provides additional features above and beyond those provided by IPMI.  Eventually, Redfish should supplant IPMI as the default BMC interface.

Prior to MAAS 3.2, all BMC connections were made via IPMI.  With the release of 3.2, if the machine uses either IPMI or Redfish for its BMC, the ephemeral environment will automatically detect it, create a separate user for MAAS and configure the machine, so that MAAS may check and control the machine’s power status. Note that the name of the user that MAAS creates in the BMC is controlled by the `maas_auto_ipmi_user` config setting, both for IPMI and Redfish; nothing has changed in this regard with MAAS 3.2.

You can check whether or not a machine can communicate via Redfish, with the command: 

```nohighlight
dmidecode -t 42
```

If the machine has been enlisted by MAAS, you can also check the output of the `30-maas-01-bmc-config` commissioning script to discover this.

<a href="#heading--maas-native-tls"><h3 id="heading--maas-native-tls">MAAS native TLS</h3></a>

MAAS 3.2 provides [native TLS](/t/how-to-enable-tls-encryption/5116#heading--about-maas-native-tls). MAAS now has built-in TLS support for communicating with the UI and API over HTTPS. This eliminates the need to deploy a separate TLS-terminating reverse-proxy solution in front of MAAS to provide secure access to API and UI.  Note that you can still set up an HA proxy if you are using multiple controllers.

<a href="#heading--hardware-sync-for-deployed-machines"><h3 id="heading--hardware-sync-for-deployed-machines">Hardware sync for deployed machines</h3></a>

MAAS 3.2 allows you to [sync hardware changes for deployed machines](https://maas.io/docs/how-to-customise-machines#heading--how-to-enable-hardware-sync-on-a-machine).  You can see real-time updates to storage, etc., for a running machine.  This feature requires a special parameter be set prior to deployment.  Coupled with the existing ability to commission deployed machines, MAAS 3.2 moves a step closer to real-time reconfiguration of active, deployed, bare-metal.

<a href="#heading--expanded-tagging-capability"><h3 id="heading--expanded-tagging-capability">Expanded tagging capability</h3></a>
 
MAAS 3.2 provides greatly [expanded tagging capability](/t/how-to-work-with-tags/5928#heading--automatic-tags).  You can auto-apply tags to machines that match a custom XPath expression. Setting up an automatic tag lets you recognise special hardware characteristics and settings, e.g., the gpu passthrough.

<a href="#heading--more-new-features"><h3 id="heading--more-new-features">More new features</h3></a>

MAAS 3.2 rounds out the feature set with a few more items:

- [Support for observability (O11y) in MAAS](/t/how-to-set-up-maas-metrics/5204): MAAS now supports integration with FOSS Observability stacks.

- [Ability for user to specify IPMI cipher suite](/t/power-management-reference/5246): You can explicitly select which cipher suite to use when interacting with a BMC.

- Roll-out of our new tabbed Reader Adaptive Documentation (incremental across the release cycle): We've eliminated the top menus; each page now contains information for all versions, selectable by dropdowns above the relevant sections.

[note]
This is an RC (release candidate) release, so you may still encounter some minor bugs.  We strongly recommend that you take the necessary precautions, which include (but are not limited to) the following steps:

- Install RC versions on a system specifically designated for testing; RC is not strongly recommended for production.
- Take a backup of any unrecoverable data on your test system prior to installing RC versions.
- More specifically, if you use a system for testing MAAS releases, back up the MAAS database and any unique configuration files related to your use of MAAS prior to installing RC versions.

Also, you should make sure that you are using the latest version of PostgreSQL.  [Here's how you can upgrade that](https://discourse.maas.io/t/upgrading-postgresql-to-version-12/5913).

Essentially, the RC should be production-ready, but has not had extensive testing yet -- so it may not function properly under all conditions, possibly overwriting data and configuration information on the test machine.  RC versions usually behave fairly well, but be warned that across-the-board, perfect performance isn't always the case with an RC releases.
 
As you encounter failures, please take the time to [file a bug](https://maas.io/docs/report-a-bug) or let us know your thoughts [on the discourse user forum](https://discourse.maas.io/c/users/8).
[/note]

<a href="#heading--how-to-install-maas-3-2"><h2 id="heading--how-to-install-maas-3-2">How to install MAAS 3.2</h2></a>

MAAS 3.2 can be installed fresh from snaps (recommended) with:

```
sudo snap install --channel=3.2/candidate maas
```

MAAS 3.2 can be installed from packages by adding the `ppa:maas/3.2-rc1` PPA:

```
sudo add-apt-repository ppa:maas/3.2-rc1
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

<a href="#heading--bugs-fixed-in-maas-3-2"><h2 id="heading--bugs-fixed-in-maas-3-2">Bugs fixed in MAAS 3.2</h2></a>

Here is the breakdown of bugs fixed across the MAAS 3.2 release:

- [MAAS 3.2 RC 1](https://launchpad.net/maas/+milestone/3.2.0-rc1)
- [MAAS 3.2 Beta 6](https://launchpad.net/maas/3.2/3.2.0-beta6)
- [MAAS 3.2 Beta 5](https://launchpad.net/maas/3.2/3.2.0-beta5)
- [MAAS 3.2 Beta 4](https://launchpad.net/maas/3.2/3.2.0-beta4)
- [MAAS 3.2 Beta 3](https://launchpad.net/maas/3.2/3.2.0-beta3)
- [MAAS 3.2 Beta 2](https://launchpad.net/maas/+milestone/3.2.0-beta2)
- [MAAS 3.2 Beta 1](https://launchpad.net/maas/3.2/3.2.0-beta1)
 
<a href="#heading--known-issues-maas-3-2"><h2 id="heading--known-issues-maas-3-2">Known issues for MAAS 3.2</h2></a>

The following known issues exist for MAAS 3.2:

<h3>Cannot update controller/device tags via WebSocket API</h3>

If you attempt to update a list of tags of a device with an automatic tag, you get an error: "Cannot add tag tag-name to node because it has a definition".

If you attempt to manually make the same API request, but send a list of tags with the automatic tag filtered out, the automatic tag will be removed from the device.