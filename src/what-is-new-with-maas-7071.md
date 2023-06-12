<!-- "What is new with MAAS" -->

Here you will find release notes for:

- The current version of MAAS
- [Other MAAS versions](#heading--other-maas-versions)

<a href="#heading--MAAS-3-4-beta-1-has-been-released"><h2 id="heading--MAAS-3-4-beta-1-has-been-released">MAAS 3.4 Beta1 has been released</h2></a>

We are happy to announce that MAAS 3.4 Beta1 has been released, with new features and [many bug fixes](#heading--MAAS-3-4-beta-1-bug-list).  MAAS 3.3 is a concerted effort to improve MAAS on multiple fronts, including a large number of bug fixes. 

<a href="#heading--MAAS-3-4-beta-1-features"><h2 id="heading--MAAS-3-4-beta-1-features">MAAS 3.4 Beta 1 features</h2></a>

The following visible new features are a part of MAAS 3.4 Beta 1:

- Redesigned UI: Navigation is moved from the top of the screen to the left side, and made more comprehensive, while at the same time being more compact.  Navigation within panels is handled by discreet, pop-up boxes to avoid disoriented the user.

<!--
- DGX kernel support: There’s ongoing work from Canonical to provide an optimised kernel for Nvidia DGX machines. We want to promote that and make sure that DGX machines use that optimised kernel by default, without the user having to do any special configuration.
-->

- Configurable session timeout: Users are able to fully configure their session timeouts.

- Ansible HA PostgreSQL playbook enhancements: PostgreSQL HA setup is now fully possible with Ansible.

- Ansible observability playbook: Users can now configure O11y with Ansible.

- Allow sorting images by last deployed: Users can now sort out which images they most recently used.

- Packer MAAS - SLES: We've added support for SLES to our Packer repertoire, and done some touch-ups on RHEL.

<a href="#heading--How-to-install-MAAS-3-4-Beta-1"><h2 id="heading--How-to-install-MAAS-3-4-Beta-1">How to install MAAS 3.4 Beta1</h2></a>

MAAS will run on just about any modern hardware configuration, even a development laptop.  If you're not sure whether your target server will handle MAAS, [you can always double-check](/t/maas-installation-requirements/6233).

[note]
**NOTE** Support for PostgreSQL 12 has been discontinued in MAAS 3.4.  Postgres 14 does not run on Focal 20.04 LTS.
[/note]

<a href="#heading--fresh-install-3-4-beta-1-snap"><h3 id="heading--fresh-install-3-4-beta-1-snap">How to do a fresh snap install of MAAS 3.4 Beta1</h3></a>

To install MAAS 3.4 Beta1 from a snap, simply enter the following:

    $ sudo snap install --channel=latest/edge maas

After entering your password, the snap will download and install from the 3.4 Beta channel.

<a href="#heading--upgrade-from-earlier-version-to-snap-3-3"><h3 id="heading--upgrade-from-earlier-version-to-snap-3-3">How to upgrade from an earlier snap version to MAAS 3.3</h3></a>

Maybe instead of a fresh install, you want to upgrade from a earlier snap version to the 3.4 Beta1 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=latest/edge maas

After entering your password, the snap will refresh from the 3.4 Beta1 candidate channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.

<a href="#heading--init-maas-poc"><h3 id="heading--init-maas-poc">How to initialise MAAS 3.4 snap for a test or POC environment</h3></a>

You can initialise MAAS as a compact version for testing.  To achieve this, we provide a separate snap, called `maas-test-db`, which contains a PostgreSQL database for use in testing and evaluating MAAS.   The following instructions will help you take advantage of this test configuration.

Once MAAS is installed, you can use the `--help` flag with `maas init` to get relevant instructions:
 
    $ sudo maas init --help
    usage: maas init [-h] {region+rack,region,rack} . . .

    Initialise MAAS in the specified run mode.

    optional arguments:
      -h, --help            show this help message and exit

    run modes:
      {region+rack,region,rack}
        region+rack         Both region and rack controllers
        region              Region controller only
        rack                Rack controller only

    When installing region or rack+region modes, MAAS needs a
    PostgreSQL database to connect to.

    If you want to set up PostgreSQL for a non-production deployment on
    this machine, and configure it for use with MAAS, you can install
    the maas-test-db snap before running 'maas init':
        sudo snap install maas-test-db
        sudo maas init region+rack --database-uri maas-test-db:///

We'll quickly walk through these instructions to confirm your understanding.  First, install the `maas-test-db` snap:
 
    sudo snap install maas-test-db

Note that this step installs a a running PostgreSQL and a MAAS-ready database instantiation.  When it's done, you can double check with a built-in PostgreSQL shell:

    $ sudo maas-test-db.psql
    psql (12.4)
    Type "help" for help.

    postgres=# \l

This will produce a list of databases, one of which will be `maasdb`, owned by `maas`.  Note that this database is still empty because MAAS is not yet initialised and, hence, is not yet using the database.  Once this is done, you can run the `maas init` command:

    sudo maas init region+rack --database-uri maas-test-db:///

After running for a moment, the command will prompt you for a MAAS URL; typically, you can use the default:
 
    MAAS URL [default=http://10.45.222.159:5240/MAAS]:

When you've entered a suitable URL, or accepted the default, the following prompt will appear:
 
    MAAS has been set up.

    If you want to configure external authentication or use
    MAAS with Canonical RBAC, please run

      sudo maas configauth

    To create admins when not using external authentication, run

      sudo maas createadmin

Let's assume you just want a local testing user named `admin`:

    $ sudo maas createadmin
    Username: admin
    Password: ******
    Again: ******
    Email: admin@example.com
    Import SSH keys [] (lp:user-id or gh:user-id): gh:yourusername

At this point, MAAS is basically set up and running.  You can confirm this with `sudo maas status`.  If you need an API key, you can obtain this with `sudo maas apikey --username yourusername`.  Now you will be able to test and evaluate MAAS by going to the URL you entered or accepted above and entering your `admin` username and password.

<a href="#heading--init-maas-production"><h3 id="heading--init-maas-production">Initialise MAAS for a production configuration</h3></a>

To install MAAS in a production configuration, you need to setup PostgreSQL, as described below.

<a href="#heading--pg-setup"><h4 id="heading--pg-setup">Setting up PostgreSQL from scratch</h4></a>

To set up PostgreSQL, even if it's running on a different machine, you can use the following procedure:

1. You will need to install PostgreSQL on the machine where you want to keep the database.  This can be the same machine as the MAAS region/rack controllers or a totally separate machine.  If PostgreSQL (version 14) is already running on your target machine, you can skip this step. To install PostgreSQL, run these commands:

        sudo apt update
        sudo apt install -y postgresql

2. You want to make sure you have a suitable PostgreSQL user, which can be accomplished with the following command, where `$MAAS_DBUSER` is your desired database username, and `$MAAS_DBPASS` is the intended password for that username.  Note that if you're executing this step in a LXD container (as root, which is the default), you may get a minor error, but the operation will still complete correctly.

        sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"

3. Create the MAAS database with the following command, where `$MAAS_DBNAME` is your desired name for the MAAS database (typically known as `maas`). Again, if you're executing this step in a LXD container as root, you can ignore the minor error that results.

        sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"

4. Edit `/etc/postgresql/14/main/pg_hba.conf` and add a line for the newly created database, replacing the variables with actual  names. You can limit access to a specific network by using a different CIDR than `0/0`.

        host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5

5. You can then initialise MAAS via the following command:

        sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"

[note] You should use `localhost` for `$HOSTNAME` if you're running PostgreSQL on the same box as MAAS.[/note]

Don't worry; if you leave out any of the database parameters, you'll be prompted for those details.

<a href="#heading--fresh-install-3-3-packages"><h3 id="heading--fresh-install-3-3-packages">How to do a fresh install of MAAS 3.3 from packages</h3></a>

MAAS 3.3 from packages runs on 22.04 LTS only.  The recommended way to set up an initial MAAS environment is to put everything on one machine:

``` bash
sudo add-apt-repository ppa:maas/3.4-next
sudo apt update
sudo apt-get -y install maas
```

Executing this command leads you to a list of dependent packages to be installed, and a summary prompt that lets you choose whether to continue with the install. Choosing "Y" proceeds with a standard <code>apt</code> package install.

<h4>Distributed environment</h4> 

<p>For a more distributed environment, you can place the region controller on one machine:</p>

``` bash
sudo apt install maas-region-controller
```

and the rack controller on another:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register
```

These two steps will lead you through two similar <code>apt</code> install sequences.

<!-- 3.2 or lower upgrade to 3.4
<a href="#heading--How-to-upgrade-from-3-2-or-lower-to-MAAS-3-3"><h3 id="heading--How-to-upgrade-from-3-2-or-lower-to-MAAS-3-3">How to upgrade from 3.2 or lower to MAAS 3.3</h3></a>

If you are running MAAS 3.2 or lower, you can upgrade directly to MAAS 3.3. You must first make sure that the target system is running Ubuntu 22.04 LTS by executing the following command:

```nohighlight
lsb_release -a
```
The response should look something like this:

```nohighlight
Distributor ID:	Ubuntu
Description:	Ubuntu xx.yy
Release:	xx.yy
Codename:	$RELEASE_NAME
```

The required “xx.yy” required for MAAS 3.3 is “22.04,” code-named “jammy”.

If you are currently running Ubuntu focal 20.04 LTS, you can upgrade to jammy 22.04 LTS with the following procedure:

Upgrade the release:

```nohighlight
sudo do-release-upgrade --allow-third-party
```

Accept the defaults for any questions asked by the upgrade script.

Reboot the machine when requested.

Check whether the upgrade was successful:

```nohighlight
lsb_release -a
```

A successful upgrade should respond with output similar to the following:

```nohighlight
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

If you’re upgrading from MAAS version 2.8 or lower to version 3.3: While the following procedures should work, note that they are untested. Use at your own risk. Start by making a verifiable backup; see step 1, below.

Back up your MAAS server completely; the tools and media are left entirely to your discretion. Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

Add the MAAS 3.3 PPA to your repository list with the following command, ignoring any apparent error messages:

```nohighlight
sudo apt-add-repository ppa:maas/3.3
```

Run the release upgrade like this, answering any questions with the given default values:

```nohighlight
sudo do-release-upgrade --allow-third-party
```

Check whether your upgrade has been successful by entering:

```nohighlight
lsb_release -a
```

If the ugprade was successful, this command should yield output similar to the following:

```nohighlight
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you’re running the 3.3 release.

If this didn’t work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.3.

-->

<a href="#heading--MAAS-3-4-beta-1-bug-list"><h2 id="heading--MAAS-3-4-beta-1-bug-list">MAAS 3.4 Beta1 bug list</h2></a>

[1999160](https://bugs.launchpad.net/bugs/1999160)`↗`:	Region controller fails to run commissioning scripts in proxied environment		
[1999191](https://bugs.launchpad.net/bugs/1999191)`↗`:	bad interaction between Colorama and the CLI		
[1999557](https://bugs.launchpad.net/bugs/1999557)`↗`:	MAAS fails to startup when installed from deb package and vault is enabled		
[2002109](https://bugs.launchpad.net/bugs/2002109)`↗`:	Migration of BMC power credentials fails with manual driver		
[2002111](https://bugs.launchpad.net/bugs/2002111)`↗`:	Connection to local Vault fails if proxy is configured		
[2003888](https://bugs.launchpad.net/bugs/2003888)`↗`:	Grouped machine list view: Inconsistent display when machine state changes		
[1743648](https://bugs.launchpad.net/bugs/1743648)`↗`:	Image import fails		
[1811799](https://bugs.launchpad.net/bugs/1811799)`↗`:	Normal users can read machine details of owned machines		
[1812377](https://bugs.launchpad.net/bugs/1812377)`↗`:	An admin is allowed to create raids for an Allocated node in the UI, but not the API		
[1958451](https://bugs.launchpad.net/bugs/1958451)`↗`:	power_driver parameter is not preserved		
[1990172](https://bugs.launchpad.net/bugs/1990172)`↗`:	"20-maas-03-machine-resources" commissioning script improperly reports a Pass when the test fails		
[1995084](https://bugs.launchpad.net/bugs/1995084)`↗`:	MAAS TLS sets HSTS forcibly and with too short value		
[1999147](https://bugs.launchpad.net/bugs/1999147)`↗`:	[3.3.0-candidate] failure when arch is requested as a filter		
[1999368](https://bugs.launchpad.net/bugs/1999368)`↗`:	[3.3.0 RC] wrong DNS records		
[1999579](https://bugs.launchpad.net/bugs/1999579)`↗`:	MAAS OpenAPI docs are not available in air-gapped mode		
[2001546](https://bugs.launchpad.net/bugs/2001546)`↗`:	Server reboot will make subnet entries disappear from zone.maas-internal		
[2003310](https://bugs.launchpad.net/bugs/2003310)`↗`:	Refresh scripts are not re-run if they pass, but fail to report the results to the region		
[2003940](https://bugs.launchpad.net/bugs/2003940)`↗`:	MAAS 3.3 RC shows incorrect storage amount		
[2008275](https://bugs.launchpad.net/bugs/2008275)`↗`:	Intel AMT support is broken in MAAS 3.3.0		
[2009137](https://bugs.launchpad.net/bugs/2009137)`↗`:	MAAS OpenApi Schema missing parameters		
[2009186](https://bugs.launchpad.net/bugs/2009186)`↗`:	CLI results in connection timed out when behind haproxy and 5240 is blocked		
[2009805](https://bugs.launchpad.net/bugs/2009805)`↗`:	machine deploy install_kvm=True fails		
[2011274](https://bugs.launchpad.net/bugs/2011274)`↗`:	MAAS 3.4: Deployment fails on LXD VMs		
[2011822](https://bugs.launchpad.net/bugs/2011822)`↗`:	Reverse DNS resolution fails for some machines		
[2012139](https://bugs.launchpad.net/bugs/2012139)`↗`:	maas commands occasionally fail with NO_CERTIFICATE_OR_CRL_FOUND when TLS is enabled		
[2017504](https://bugs.launchpad.net/bugs/2017504)`↗`:	Cannot deploy from the cli when "Allow DNS resolution" is set on minimal subnet		
[1696108](https://bugs.launchpad.net/bugs/1696108)`↗`:	Interface model validates the MAC address twice		
[1773150](https://bugs.launchpad.net/bugs/1773150)`↗`:	smartctl verify fails due to Unicode in Disk Vendor Name		
[1773671](https://bugs.launchpad.net/bugs/1773671)`↗`:	MAC address column should use mono font		
[1959648](https://bugs.launchpad.net/bugs/1959648)`↗`:	Websocket vlan handler should include associated subnet ids		
[1979403](https://bugs.launchpad.net/bugs/1979403)`↗`:	commission failed with MAAS 3.1 when BMC has multiple channels but the first channel is disabled		
[1986590](https://bugs.launchpad.net/bugs/1986590)`↗`:	maas-cli from PPA errors out with traceback - ModuleNotFoundError: No module named 'provisioningserver'		
[1990416](https://bugs.launchpad.net/bugs/1990416)`↗`:	MAAS reports invalid command to run when maas-url is incorrect		
[1993618](https://bugs.launchpad.net/bugs/1993618)`↗`:	Web UI redirection policy can invalidate HAProxy and/or TLS setup		
[1994945](https://bugs.launchpad.net/bugs/1994945)`↗`:	Failure to create ephemeral VM when no architectures are found on the VM host		
[1996997](https://bugs.launchpad.net/bugs/1996997)`↗`:	LXD resources fails on a Raspberry Pi with no Ethernet		
[1999064](https://bugs.launchpad.net/bugs/1999064)`↗`:	`maas_run_scripts.py` does not clean up temporary directory		
[2002550](https://bugs.launchpad.net/bugs/2002550)`↗`:	Controller type displays as "Undefined"		
[2007297](https://bugs.launchpad.net/bugs/2007297)`↗`:	LXD REST API connection goes via proxy		
[2009045](https://bugs.launchpad.net/bugs/2009045)`↗`:	WebSocket API to report reasons for failure for machine bulk actions		
[2009140](https://bugs.launchpad.net/bugs/2009140)`↗`:	MAAS OpenApi Schema cutoff variable names		
[2012054](https://bugs.launchpad.net/bugs/2012054)`↗`:	RPC logging when debug is too verbose

<a href="#heading--other-maas-versions"><h2 id="heading--other-maas-versions">Release notes for other MAAS versions</h2></a>

Here are release notes for other relatively recent MAAS versions:

- [MAAS 3.3](https://maas.io/docs/what-is-new-with-maas-3-3)`↗`
- [MAAS 3.2](https://maas.io/docs/what-is-new-with-maas-3-2)`↗`
- [MAAS 3.1](https://maas.io/docs/what-is-new-with-maas-3-1)`↗`
- [MAAS 3.0](https://maas.io/docs/what-is-new-with-maas-3-0)`↗`
- [MAAS 2.9](https://maas.io/docs/what-is-new-with-maas-2-9)`↗`
- [MAAS 2.8](https://maas.io/docs/what-is-new-with-maas-2-8)`↗`
- [MAAS 2.7](https://maas.io/docs/what-is-new-with-maas-2-7)`↗`