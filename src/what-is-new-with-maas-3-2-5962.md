<!-- "MAAS 3.2 Beta release notes" -->
We are happy to announce that MAAS 3.2 Beta 4 is now available.  This release provides a new feature -- MAAS native TLS --  and more bug fixes.

<a href="#heading--cumulative-summary"><h3 id="heading--cumulative-summary">Cumulative summary of MAAS 3.2 features and fixes</h3></a>

- [MAAS native TLS](/t/how-to-enable-tls-encryption/5116#heading--about-maas-native-tls): MAAS now has built-in TLS support for communicating with the UI and API over HTTPS. This eliminates the need to deploy a separate TLS-terminating reverse-proxy solution in front of MAAS to provide secure access to API and UI.

- [Hardware sync for deployed machines](https://maas.io/docs/how-to-customise-machines#heading--how-to-enable-hardware-sync-on-a-machine): MAAS allows you to sync hardware changes for a deployed and running machine.
 
- [Tag management](/t/how-to-work-with-tags/5928): MAAS now provides greatly expanded tagging capability.
 
- [Support for observability (O11y) in MAAS](/t/how-to-set-up-maas-metrics/5204): MAAS now supports integration with FOSS Observability stacks.

- [Ability for user to specify IPMI cipher suite](/t/power-management-reference/5246): You can explicitly select which cipher suite to use when interacting with a BMC.

- Roll-out of our new tabbed Reader Adaptive Documentation (incremental across the release cycle).

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
