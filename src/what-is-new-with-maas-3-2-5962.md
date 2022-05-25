<!-- "MAAS 3.2 Beta release notes" -->
<!-- "MAAS 3.2 Beta release notes" -->
We are happy to announce that MAAS 3.2 Beta 5 is now available.

It's unusual for the MAAS team to release a Beta without a new feature, but we decided to make an important exception. We've spent a lot of time recently focusing on a collection of life-cycle and controller bugs.  Fixing these bugs should improve user experience with respect to controller startup, communication, and operation; enlistment; commissioning; and deployment.  To that end, we've released a special Beta that's restricted to some high-profile bugs in those areas.

Below, you'll find a list of what we've fixed in Beta 5 -- and we'd really like to have your help in testing these fixes.

## Controller issues

We focused on conspicuous controller issues in three areas: startup, communication, and user operations.

### Controller startup issues

 * [Controllers can't refresh their networking configuration with PCI devices](https://bugs.launchpad.net/bugs/1973304): the VPD file could not be read from within a container; fixed.

 * MAAS 3.1 can't configure DHCP because the controllers can't detect network and storage layout (private bug): the bond interface was being created too early in the cycle under certain unusual conditions; the code was adjusted to fix this.

 * [MAAS 3.0 fails to initialize regiond when an IPoIB (e.g., Infiniband) device is present](https://bugs.launchpad.net/maas/+bug/1939456): fixed by skipping over IP addresses for long-MAC NICs like Infiniband, during controller startup.
 
 * [MAAS server startup fails because of missing GPU information](https://bugs.launchpad.net/maas/+bug/1970435): fixed by a soliciting a fix for a related LXD bug.
 
### Controller communication issues

 * [Wrong preseed metadata URL provided when using multiple rack controllers](https://bugs.launchpad.net/bugs/1972865): minor port issue; fixed.

 * [No rack controllers can access the BMC of a node](https://bugs.launchpad.net/bugs/1938573): fixed an corner case where MAAS fails to make sure it's got the right rack controller.

### Controller operational issues

 * [Can't delete a rack controller with the UI](https://bugs.launchpad.net/bugs/1971742): fixed a UX<-->core asynch I/O bug.

## Life-cycle issues

We also tried to cherry-pick some of the most important life-cycle issues, mostly around enlistment, commissioning, and deployment.

### Enlistment issues

 * [IPMI power_driver parameter is not preserved from enlistment to commissioning](https://bugs.launchpad.net/bugs/1958451): extended BMC code to update IPMI 1.5 handling.
 
 * [Enlist step fails with latest Beta of MAAS 3.2](https://bugs.launchpad.net/maas/+bug/1974031): relatively minor bug fix.
 
### Commissioning issues

 * [iPXE is not detected properly on derivatives of vanilla iPXE (Mellanox Flexboot)](https://bugs.launchpad.net/bugs/1939608): fixed MAAS to properly detect iPXE in an outlier scenario; note that applying DHCP snippets won't work because of the way the iPXE bootloader is hardcoded. 

 * [Power9 PowerVM LPAR fails to commission properly](https://bugs.launchpad.net/bugs/1971754): compensated for a syntax issue with Power9 LPAR power driver.

 * [Websocket produces an error with diskless machines](https://bugs.launchpad.net/bugs/1952216): fixed a previously-unnoticed bootdisk ID error for diskless machines.

### Deployment issues

 * [Calling vm-host update fails when resetting overcommit ratios](https://bugs.launchpad.net/bugs/1972052): fixed a unique index violation in the overcommit ratio code.
 
 * ['maas-run-scripts report-results' is not distro-agnostic](https://bugs.launchpad.net/bugs/1962519): eliminated use of `dpkg` by `maas-run-scripts` script.

 * [Cannot deploy Centos7 with xfs when using Focal as commissioning image](https://bugs.launchpad.net/bugs/1958433): mitigated incompatible changes to xfs between Bionic and Focal releases.
 
 * [Deployment fails when trying to register a VM host](https://bugs.launchpad.net/bugs/1970962): fixed a minor bug related to Jammy updates.

<a href="#heading--new-features"><h2 id="heading--new-features">New MAAS 3.2 features</h2></a>

MAAS 3.2 provides several new features, as well as the usual cadre of bug fixes.

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
This is a Beta release, so you may encounter bugs and incomplete features.  We strongly recommend that you take the necessary precautions, which include (but are not limited to) the following steps:

- Install Beta versions on a system specifically designated for testing; Beta is not recommended for production.
- Take a backup of any unrecoverable data on your test system prior to installing Beta versions.
- More specifically, if you use a system for testing MAAS releases, back up the MAAS database and any unique configuration files related to your use of MAAS prior to installing Beta versions.

Also, you should make sure that you are using the latest version of PostgreSQL.  [Here's how you can upgrade that](https://discourse.maas.io/t/upgrading-postgresql-to-version-12/5913).

Essentially, expect that the Beta may not function properly under all conditions, possibly overwriting data and configuration information on the test machine.  Beta versions usually behave fairly well, but be warned that across-the-board, error-free performance isn't something we expect from Beta releases.
 
As you encounter failures, please take the time to [file a bug](https://maas.io/docs/report-a-bug) or let us know your thoughts [on the discourse user forum](https://discourse.maas.io/c/users/8).
[/note]

<a href="#heading--how-to-install-maas-3-2"><h2 id="heading--how-to-install-maas-3-2">How to install MAAS 3.2</h2></a>

MAAS 3.2 can be installed fresh from snaps (recommended) with:

```
sudo snap install --channel=3.2/beta maas
```

MAAS 3.2 can be installed from packages by adding the `ppa:maas/3.2-next` PPA:

```
sudo add-apt-repository ppa:maas/3.2-next
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

- [MAAS 3.2 Beta 4](https://launchpad.net/maas/3.2/3.2.0-beta4)
- [MAAS 3.2 Beta 3](https://launchpad.net/maas/3.2/3.2.0-beta3)
- [MAAS 3.2 Beta 2](https://launchpad.net/maas/+milestone/3.2.0-beta2)
- [MAAS 3.2 Beta 1](https://launchpad.net/maas/3.2/3.2.0-beta1)
 
<a href="#heading--known-issues-maas-3-2"><h2 id="heading--known-issues-maas-3-2">Known issues for MAAS 3.2</h2></a>

Currently, there are no known issues associated with MAAS 3.2.0.