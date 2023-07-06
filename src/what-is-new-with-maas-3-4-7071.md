<!-- "What is new with MAAS 3.4" -->

Here you will find release notes for the Beta version(s) of MAAS 3.4.

<a href="#heading--MAAS-3-4-Beta3-has-been-released"><h2 id="heading--MAAS-3-4-Beta3-has-been-released">MAAS 3.4 Beta3 has been released</h2></a>

We are happy to announce that MAAS 3.4 Beta3 has been released with [more bug fixes](#heading--MAAS-3-4-Beta3-bug-list).

<a href="#heading--MAAS-3-4-Beta2-has-been-released"><h2 id="heading--MAAS-3-4-Beta2-has-been-released">MAAS 3.4 Beta2 has been released</h2></a>

We are happy to announce that MAAS 3.4 Beta2 has been released with [more bug fixes](#heading--MAAS-3-4-Beta2-bug-list).

<a href="#heading--MAAS-3-4-beta-1-has-been-released"><h2 id="heading--MAAS-3-4-beta-1-has-been-released">MAAS 3.4 Beta1 has been released</h2></a>

We are happy to announce that MAAS 3.4 Beta1 has been released, with [many bug fixes](#heading--MAAS-3-4-beta-1-bug-list).

<a href="#heading--MAAS-3-4-features"><h2 id="heading--MAAS-3-4-features">MAAS 3.4 Beta 1 features</h2></a>

MAAS 3.4 provides several new features.

<a href="#heading--redesigned-ui"><h3 id="heading--redesigned-ui">Redesigned UI</h3></a>

The MAAS User Interface (UI) has undergone a significant redesign, introducing the MAAS UI new layout. This new layout incorporates various features and improvements aimed at enhancing the user experience for MAAS users and operators who primarily interact with the UI.  The MAAS UI new layout introduces several enhancements that aim to improve usability, customization, and navigation within the application

- Customizable column visibility: One of the major improvements in the MAAS UI new layout is the ability for users to customize the visibility of columns on the machine list. This feature empowers users to focus on the specific information they need, while hiding irrelevant columns. By allowing users to tailor their view, this enhancement improves readability, reduces clutter, and provides a more personalized experience.

- Action forms in side panel: Previously, the action forms in MAAS were located in the header section, which made it less intuitive for users to access and interact with them. The redesigned UI moves these action forms to the side panel, providing a more logical placement and easy access to perform actions on machines. This change enhances the usability of the forms and improves the overall workflow for users.

- Streamlined action button group: The introduction of a new action button group eliminates the need for the previous "Take action" menu. Users can now directly access commonly used actions for machines, both in the details view and the machine list. This streamlines the workflow and simplifies the process of performing actions on machines, saving users time and effort.

- Improved side navigation: To enhance navigation within the application, the MAAS UI new layout implements a new side navigation system. Users can conveniently navigate through different sections of the app using the side panel. Additionally, the inclusion of a secondary side navigation specifically for settings and account pages improves the organization and accessibility of these sections.

#### Intended Benefits

The MAAS UI was redesigned with several user benefits in mind.

- Enhanced table interaction: Users can now customize their views by selecting the columns they care about the most. This modular table feature allows for a personalized experience, ensuring users can focus on the information that matters to them.

- Improved form interaction: Forms in the MAAS UI have been redesigned to scale with the content. By migrating all forms into panels, users have more space to view other components such as the machine list, resulting in a more comfortable and efficient form interaction experience.

- Efficient navigation: The new layout addresses the challenges posed by a growing navigation menu. With the introduction of the side panel navigation, users can easily explore different sections of the app, providing a scalable and user-friendly navigation experience.

- Enhanced search capability: The MAAS UI new layout improves the efficiency of the search feature. Users can search for machines based on conventions and tags, making it easier to find specific machines and take actions. The new layout also provides clearer feedback when the "take action" button is disabled, enhancing the overall search and interaction experience.

- Performance improvements based on user feedback: Based on user feedback received through Discourse, several performance issues have been identified and addressed. The MAAS team has worked diligently to optimize machine information loading times and resolve delays encountered while opening machine pages. These performance improvements ensure a smoother and faster user experience when interacting with the MAAS UI.

The MAAS UI new layout introduces a redesigned interface with enhanced features to provide a more efficient and user-friendly experience for MAAS users and operators. By allowing users to customize their views, streamlining form interactions

<!--
- DGX kernel support: There’s ongoing work from Canonical to provide an optimised kernel for Nvidia DGX machines. We want to promote that and make sure that DGX machines use that optimised kernel by default, without the user having to do any special configuration.
-->

<a href="#heading--Configurable-session-timeout"><h3 id="heading--Configurable-session-timeout">Configurable session timeout</h3></a>

In MAAS 3.4, we've introduced the Configurable Session Timeout feature, offering better control over session length. This feature allows you to set a personalized duration for your sessions, hopefully avoiding abrupt disconnections or lingering sessions.  If you're a user who has login repeatedly, due to short session defaults, or you're concerned about leaving your session accessible for too long, setting a custom timeout is useful and potentially more secure.

<a href="#heading--Ansible-HA-PostgreSQL-playbook-enhancements"><h3 id="heading--Ansible-HA-PostgreSQL-playbook-enhancements">Ansible HA PostgreSQL playbook enhancements</h3></a>

With the latest iteration of MAAS 3.4, we have made significant enhancements to the Ansible playbook, enabling a full High Availability (HA) setup for PostgreSQL. Users can now configure a PostgreSQL cluster with failover and redundancy capabilities directly through the Ansible playbook. This streamlined method incorporates tools such as PAF, corosync, and pacemaker.  With PostgreSQL HA enabled, traffic will automatically redirect to a standby database. This can significantly improve system load balancing. 

<a href="#heading--Ansible-observability-playbook"><h3 id="heading--Ansible-observability-playbook">Ansible observability playbook</h3></a>

In MAAS 3.4, we've introduced an Ansible Observability (O11y) playbook, allowing users to configure O11y using Ansible. This playbook configures metrics collection, log management, and other key O11y features. Users can easily deploy and manage observability.  Ansible also enables version control for configurations, making it easier to track changes and roll back if necessary.

<!--
- Allow sorting images by last deployed: Users can now sort out which images they most recently used.
-->

<a href="#heading--Packer-MAAS---SLES"><h3 id="heading--Packer-MAAS---SLES">Packer MAAS - SLES</h3></a>

The MAAS 3.4 release expands Packer support to include SUSE Linux Enterprise Server (SLES), expanding the the list of deployable Linux distributions.  We also support openSUSE and openSUSE Tumbleweed. And we’ve added a template for Red Hat Enterprise Linux (RHEL) version 9.

<a href="#heading--How-to-install-MAAS-3-4-Beta"><h2 id="heading--How-to-install-MAAS-3-4-Beta">How to install MAAS 3.4 Beta</h2></a>

MAAS will run on just about any modern hardware configuration, even a development laptop.  If you're not sure whether your target server will handle MAAS, [you can always double-check](/t/maas-installation-requirements/6233).

[note]
**NOTE** Support for PostgreSQL 12 has been discontinued in MAAS 3.4.  Postgres 14 does not run on Focal 20.04 LTS.
[/note]

<a href="#heading--fresh-install-3-4-beta-1-snap"><h3 id="heading--fresh-install-3-4-beta-1-snap">How to do a fresh snap install of MAAS 3.4 Beta1</h3></a>

To install MAAS 3.4 Beta from a snap, simply enter the following:

    $ sudo snap install --channel=latest/edge maas

After entering your password, the snap will download and install from the 3.4 Beta channel.

<a href="#heading--upgrade-from-earlier-version-to-snap-3-3"><h3 id="heading--upgrade-from-earlier-version-to-snap-3-3">How to upgrade from an earlier snap version to MAAS 3.3</h3></a>

Maybe instead of a fresh install, you want to upgrade from a earlier snap version to the 3.4 Beta1 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=latest/edge maas

After entering your password, the snap will refresh from the 3.4 Beta channel.  You will **not** need to re-initialise MAAS.

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

- [1999160](https://bugs.launchpad.net/bugs/1999160)`↗`:	Region controller fails to run commissioning scripts in proxied environment		
- [1999191](https://bugs.launchpad.net/bugs/1999191)`↗`:	bad interaction between Colorama and the CLI		
- [1999557](https://bugs.launchpad.net/bugs/1999557)`↗`:	MAAS fails to startup when installed from deb package and vault is enabled		
- [2002109](https://bugs.launchpad.net/bugs/2002109)`↗`:	Migration of BMC power credentials fails with manual driver		
- [2002111](https://bugs.launchpad.net/bugs/2002111)`↗`:	Connection to local Vault fails if proxy is configured		
- [2003888](https://bugs.launchpad.net/bugs/2003888)`↗`:	Grouped machine list view: Inconsistent display when machine state changes		
- [1743648](https://bugs.launchpad.net/bugs/1743648)`↗`:	Image import fails		
- [1811799](https://bugs.launchpad.net/bugs/1811799)`↗`:	Normal users can read machine details of owned machines		
- [1812377](https://bugs.launchpad.net/bugs/1812377)`↗`:	An admin is allowed to create raids for an Allocated node in the UI, but not the API		
- [1958451](https://bugs.launchpad.net/bugs/1958451)`↗`:	power_driver parameter is not preserved		
- [1990172](https://bugs.launchpad.net/bugs/1990172)`↗`:	"20-maas-03-machine-resources" commissioning script improperly reports a Pass when the test fails		
- [1995084](https://bugs.launchpad.net/bugs/1995084)`↗`:	MAAS TLS sets HSTS forcibly and with too short value		
- [1999147](https://bugs.launchpad.net/bugs/1999147)`↗`:	[3.3.0-candidate] failure when arch is requested as a filter		
- [1999368](https://bugs.launchpad.net/bugs/1999368)`↗`:	[3.3.0 RC] wrong DNS records		
- [1999579](https://bugs.launchpad.net/bugs/1999579)`↗`:	MAAS OpenAPI docs are not available in air-gapped mode		
- [2001546](https://bugs.launchpad.net/bugs/2001546)`↗`:	Server reboot will make subnet entries disappear from zone.maas-internal		
- [2003310](https://bugs.launchpad.net/bugs/2003310)`↗`:	Refresh scripts are not re-run if they pass, but fail to report the results to the region		
- [2003940](https://bugs.launchpad.net/bugs/2003940)`↗`:	MAAS 3.3 RC shows incorrect storage amount		
- [2008275](https://bugs.launchpad.net/bugs/2008275)`↗`:	Intel AMT support is broken in MAAS 3.3.0		
- [2009137](https://bugs.launchpad.net/bugs/2009137)`↗`:	MAAS OpenApi Schema missing parameters		
- [2009186](https://bugs.launchpad.net/bugs/2009186)`↗`:	CLI results in connection timed out when behind haproxy and 5240 is blocked		
- [2009805](https://bugs.launchpad.net/bugs/2009805)`↗`:	machine deploy install_kvm=True fails		
- [2011274](https://bugs.launchpad.net/bugs/2011274)`↗`:	MAAS 3.4: Deployment fails on LXD VMs		
- [2011822](https://bugs.launchpad.net/bugs/2011822)`↗`:	Reverse DNS resolution fails for some machines		
- [2012139](https://bugs.launchpad.net/bugs/2012139)`↗`:	maas commands occasionally fail with NO_CERTIFICATE_OR_CRL_FOUND when TLS is enabled		
- [2017504](https://bugs.launchpad.net/bugs/2017504)`↗`:	Cannot deploy from the cli when "Allow DNS resolution" is set on minimal subnet		
- [1696108](https://bugs.launchpad.net/bugs/1696108)`↗`:	Interface model validates the MAC address twice		
- [1773150](https://bugs.launchpad.net/bugs/1773150)`↗`:	smartctl verify fails due to Unicode in Disk Vendor Name		
- [1773671](https://bugs.launchpad.net/bugs/1773671)`↗`:	MAC address column should use mono font		
- [1959648](https://bugs.launchpad.net/bugs/1959648)`↗`:	Websocket vlan handler should include associated subnet ids		
- [1979403](https://bugs.launchpad.net/bugs/1979403)`↗`:	commission failed with MAAS 3.1 when BMC has multiple channels but the first channel is disabled		
- [1986590](https://bugs.launchpad.net/bugs/1986590)`↗`:	maas-cli from PPA errors out with traceback - ModuleNotFoundError: No module named 'provisioningserver'		
- [1990416](https://bugs.launchpad.net/bugs/1990416)`↗`:	MAAS reports invalid command to run when maas-url is incorrect		
- [1993618](https://bugs.launchpad.net/bugs/1993618)`↗`:	Web UI redirection policy can invalidate HAProxy and/or TLS setup		
- [1994945](https://bugs.launchpad.net/bugs/1994945)`↗`:	Failure to create ephemeral VM when no architectures are found on the VM host		
- [1996997](https://bugs.launchpad.net/bugs/1996997)`↗`:	LXD resources fails on a Raspberry Pi with no Ethernet		
- [1999064](https://bugs.launchpad.net/bugs/1999064)`↗`:	`maas_run_scripts.py` does not clean up temporary directory		
- [2002550](https://bugs.launchpad.net/bugs/2002550)`↗`:	Controller type displays as "Undefined"		
- [2007297](https://bugs.launchpad.net/bugs/2007297)`↗`:	LXD REST API connection goes via proxy		
- [2009045](https://bugs.launchpad.net/bugs/2009045)`↗`:	WebSocket API to report reasons for failure for machine bulk actions		
- [2009140](https://bugs.launchpad.net/bugs/2009140)`↗`:	MAAS OpenApi Schema cutoff variable names		
- [2012054](https://bugs.launchpad.net/bugs/2012054)`↗`:	RPC logging when debug is too verbose

<a href="#heading--MAAS-3-4-Beta2-bug-list"><h2 id="heading--MAAS-3-4-Beta2-bug-list">MAAS 3.4 Beta2 bug list</h2></a>

- [1974050](https://bugs.launchpad.net/bugs/1974050)`↗`: Vmware no longer supports image cloning
- [2009209](https://bugs.launchpad.net/bugs/2009209)`↗`: snap deployed maas is not able to use openstack nova power type due to missing python3-novaclient dependency
- [1830619](https://bugs.launchpad.net/bugs/1830619)`↗`: The "authoritative" field value is ignored when creating/editing domains
- [1914762](https://bugs.launchpad.net/bugs/1914762)`↗`: test network configuration broken with openvswitch bridge
- [1999668](https://bugs.launchpad.net/bugs/1999668)`↗`: reverse DNS not working for some interfaces
- [2016908](https://bugs.launchpad.net/bugs/2016908)`↗`: udev fails to make prctl() syscall with apparmor=0 (as used by maas by default)
- [2019229](https://bugs.launchpad.net/bugs/2019229)`↗`: 3.4.0~beta1 maas-region-api fails to start with pylxd 2.3.2~alpha1-420-10-g.72426bf~ubuntu22.04.1
- [1818672](https://bugs.launchpad.net/bugs/1818672)`↗`: Option to show full name of a user in the UI
- [1823153](https://bugs.launchpad.net/bugs/1823153)`↗`: maas init doesn't check if the user or email already exists
- [1876365](https://bugs.launchpad.net/bugs/1876365)`↗`: host passthrough not working with KVMs
- [2018149](https://bugs.launchpad.net/bugs/2018149)`↗`: MAAS generates netplan with illegal autoconf and accept_ra flags for 22.04
- [2020427](https://bugs.launchpad.net/bugs/2020427)`↗`: crash importing large database dump into maas-test-db

<a href="#heading--MAAS-3-4-Beta3-bug-list"><h2 id="heading--MAAS-3-4-Beta3-bug-list">MAAS 3.4 Beta3 bug list</h2></a>

- [2020882](https://bugs.launchpad.net/maas/+bug/2020882)`↗`: Machine config hints FileNotFoundError
- [2022833](https://bugs.launchpad.net/maas/+bug/2022833)`↗`: machine-config-hints fails on Power machines
- [1835153](https://bugs.launchpad.net/maas/+bug/1835153)`↗`: Ephemeral deployment creates pending ScriptResult
- [1996204](https://bugs.launchpad.net/maas/+bug/1996204)`↗`: failing metrics cause 500 error
- [2011841](https://bugs.launchpad.net/maas/+bug/2011841)`↗`: DNS resolution fails
- [2013529](https://bugs.launchpad.net/maas/+bug/2013529)`↗`: Nodes stuck in Failed Disk Erasing due to wrong ipxe boot file
- [2021965](https://bugs.launchpad.net/maas/+bug/2021965)`↗`: MAAS Settings (sidebar) scroll issue
- [1807725](https://bugs.launchpad.net/maas/+bug/1807725)`↗`: Machine interfaces allow '_' character, results on a interface based domain breaking bind (as it doesn't allow it for the host part).
- [2006497](https://bugs.launchpad.net/maas/+bug/2006497)`↗`: unsupported configuration in virsh command
- [2011853](https://bugs.launchpad.net/maas/+bug/2011853)`↗`: Auto-discovered subnet does not get correct VLAN 
- [2020865](https://bugs.launchpad.net/maas/+bug/2020865)`↗`: flaky test: src/tests/maasperf/cli/test_machines.py::test_perf_list_machines_CLI
