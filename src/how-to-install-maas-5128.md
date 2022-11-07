<!-- "How to install MAAS" -->

MAAS is relatively easy to install and configure.  Let's give it a try.

[note]
MAAS will run on just about any modern hardware configuration, even a development laptop.  If you're not sure whether your target server will handle MAAS, [you can always double-check](/t/maas-installation-reference/6233).
[/note]

[note]
**IMPORTANT**: If you're having trouble accessing your MAAS, double-check your URL.  It should be of the form `http://nn.nn.nn.nn:5240/MAAS`, where `nn.nn...` is the IP address.  Note that this is `http` and not `https`.  **ALSO** check whether the IP of your MAAS host may have changed, e.g., due to the MAAS host using a DHCP lease.  If the MAAS host's IP changes for any reason, you will need to re-initialise MAAS to pick up the new IP address.
[/note]

[tabs]
[tab version="v3.3 Beta 1 Snap"]
[note]
**ALSO NOTE** that PostgreSQL 12 is deprecated with the release of MAAS 3.3, in favour of PostgreSQL 14. Support for PostgreSQL 12 will be discontinued in MAAS 3.4.
[/note]

<a href="#heading--fresh-install-3-3-snap"><h2 id="heading--fresh-install-3-3-snap">How to do a fresh snap install of MAAS 3.3</h2></a>

To install MAAS 3.2 from a snap, simply enter the following:

    $ sudo snap install --channel=3.3/beta maas

After entering your password, the snap will download and install from the 3.3 channel.

<a href="#heading--upgrade-from-earlier-version-to-snap-3-3"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-3">How to upgrade from an earlier snap version to MAAS 3.3</h2></a>

Maybe instead of a fresh install, you want to upgrade from a earlier snap version to the 3.3 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=3.3/beta maas

After entering your password, the snap will refresh from the 3.3 Beta channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.

<a href="#heading--init-maas-poc"><h2 id="heading--init-maas-poc">How to initialise MAAS 3.3 snap for a test or POC environment</h2></a>

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

<a href="#heading--init-maas-production"><h2 id="heading--init-maas-production">Initialise MAAS for a production configuration</h2></a>

To install MAAS in a production configuration, you need to setup PostgreSQL, as described below.

<a href="#heading--pg-setup"><h4 id="heading--pg-setup">Setting up PostgreSQL from scratch</h4></a>

To set up PostgreSQL, even if it's running on a different machine, you can use the following procedure:

1. You will need to install PostgreSQL on the machine where you want to keep the database.  This can be the same machine as the MAAS region/rack controllers or a totally separate machine.  If PostgreSQL (version 10 or better) is already running on your target machine, you can skip this step. To install PostgreSQL, run these commands:

        sudo apt update -y
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
[/tab]
[tab version="v3.3 Beta 1 Packages"]
[note]
**ALSO NOTE** that PostgreSQL 12 is deprecated with the release of MAAS 3.3, in favour of PostgreSQL 14. Support for PostgreSQL 12 will be discontinued in MAAS 3.4.
[/note]

<a href="#heading--fresh-install-3-3-packages"><h2 id="heading--fresh-install-3-3-packages">How to do a fresh install of MAAS 3.3 from packages</h2></a>

The recommended way to set up an initial MAAS environment is to put everything on one machine:

``` bash
sudo apt-add-repository ppa:maas/3.3-next
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

<a href="#heading--How-to-upgrade-from-3-2-or-lower-to-MAAS-3-3"><h2 id="heading--How-to-upgrade-from-3-2-or-lower-to-MAAS-3-3">How to upgrade from 3.2 or lower to MAAS 3.3</h2></a>

If you are running MAAS 3.2 or lower, you can upgrade directly to MAAS 3.3. You must first make sure that the target system is running Ubuntu 22.04 LTS or higher, by executing the following command:

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

The minimum “xx.yy” required for MAAS 3.2 is “22.04,” code-named “jammy”.

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

Add the MAAS 3.3 Beta 1 PPA to your repository list with the following command, ignoring any apparent error messages:

```nohighlight
sudo apt-add-repository ppa:maas/3.3-next
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
[/tab]
[tab version="v3.2 Snap"]
<a href="#heading--fresh-install-3-2-snap"><h2 id="heading--fresh-install-3-2-snap">How to do a fresh snap install of MAAS 3.2</h2></a>

To install MAAS 3.2 from a snap, simply enter the following:

    $ sudo snap install --channel=3.2 maas

After entering your password, the snap will download and install from the 3.2 channel.

<a href="#heading--upgrade-from-earlier-version-to-snap-3-2"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-2">How to upgrade from an earlier snap version to MAAS 3.2</h2></a>

Maybe instead of a fresh install, you want to upgrade from a earlier snap version to the 3.2 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=3.2 maas

After entering your password, the snap will refresh from the 3.2 channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.

<a href="#heading--init-maas-poc"><h2 id="heading--init-maas-poc">How to initialise MAAS 3.2 snap for a test or POC environment</h2></a>

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

<a href="#heading--init-maas-production"><h2 id="heading--init-maas-production">Initialise MAAS for a production configuration</h2></a>

To install MAAS in a production configuration, you need to setup PostgreSQL, as described below.

<a href="#heading--pg-setup"><h4 id="heading--pg-setup">Setting up PostgreSQL from scratch</h4></a>

To set up PostgreSQL, even if it's running on a different machine, you can use the following procedure:

1. You will need to install PostgreSQL on the machine where you want to keep the database.  This can be the same machine as the MAAS region/rack controllers or a totally separate machine.  If PostgreSQL (version 10 or better) is already running on your target machine, you can skip this step. To install PostgreSQL, run these commands:

        sudo apt update -y
        sudo apt install -y postgresql

2. You want to make sure you have a suitable PostgreSQL user, which can be accomplished with the following command, where `$MAAS_DBUSER` is your desired database username, and `$MAAS_DBPASS` is the intended password for that username.  Note that if you're executing this step in a LXD container (as root, which is the default), you may get a minor error, but the operation will still complete correctly.

        sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"

3. Create the MAAS database with the following command, where `$MAAS_DBNAME` is your desired name for the MAAS database (typically known as `maas`). Again, if you're executing this step in a LXD container as root, you can ignore the minor error that results.

        sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"

4. Edit `/etc/postgresql/12/main/pg_hba.conf` and add a line for the newly created database, replacing the variables with actual  names. You can limit access to a specific network by using a different CIDR than `0/0`.

        host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5

5. You can then initialise MAAS via the following command:

        sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"

[note] You should use `localhost` for `$HOSTNAME` if you're running PostgreSQL on the same box as MAAS.[/note]

Don't worry; if you leave out any of the database parameters, you'll be prompted for those details.
[/tab]
[tab version="v3.2 Packages"]
<a href="#heading--fresh-install-3-2-packages"><h2 id="heading--fresh-install-3-2-packages">How to do a fresh install of MAAS 3.2 from packages</h2></a>

The recommended way to set up an initial MAAS environment is to put everything on one machine:

``` bash
sudo apt-add-repository ppa:maas/3.2
sudo apt update
sudo apt-get -y install maas
```

Executing this command leads you to a list of dependent packages to be installed, and a summary prompt that lets you choose whether to continue with the install:

<a href="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg"></a>

Choosing "Y" proceeds with a standard <code>apt</code> package install.

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

<a href="#heading--upgrade-to-3-2"><h2 id="heading--upgrade-to-3-2">How to ugprade to MAAS 3.2 from MAAS 2.9 or higher</h2></a>

Maybe you'd prefer to upgrade from MAAS 2.9 or higher to MAAS 3.2. You can also [upgrade from older versions](#heading--upgrade-from-2-8-to-3-2) with bit more work.

To upgrade from MAAS 2.9 - 3.1 to MAAS 3.2, follow these steps:

1. Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

2. Add the MAAS 3.2 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.2
```

3. Run the MAAS upgrade like this:

```
sudo apt update
sudo apt upgrade maas
```

4. Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.2 release.

5. If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.2.

<a href="#heading--upgrade-from-2-8-to-3-2"><h2 id="heading--upgrade-from-2-8-to-3-2">How to upgrade from 2.8 or lower to MAAS 3.2</h2></a>

If you are running MAAS 2.8 or lower, you can upgrade directly to MAAS 3.2. You must first make sure that the target system is running Ubuntu 20.04 LTS or higher, by executing the following command:

```
lsb_release -a
```

The response should look something like this:

```
Distributor ID:	Ubuntu
Description:	Ubuntu xx.yy
Release:	xx.yy
Codename:	$RELEASE_NAME
```

The minimum "xx.yy" required for MAAS 3.2 is "20.04," code-named "focal."

If you are currently running Ubuntu bionic 18.04 LTS, you can upgrade to focal 20.04 LTS with the following procedure:

1. Upgrade the release:

```
sudo do-release-upgrade --allow-third-party
```

2. Accept the defaults for any questions asked by the upgrade script.

3. Reboot the machine when requested.

4. Check whether the upgrade was successful:

```
lsb_release -a
```

A successful upgrade should respond with output similar to the following:

```
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

[note]
If you're upgrading from MAAS version 2.8 or lower to version 3.2, please remember: While the following procedures should work, note that they are untested.  Use at your own risk.  Start by making a verifiable backup; see step 1, below.
[/note]

1. Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

2. Add the MAAS 3.2 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.2
```

3. Run the release upgrade like this, answering any questions with the given default values:

```
sudo do-release-upgrade --allow-third-party
```

4. Check whether your upgrade has been successful by entering:

```
lsb_release -a
```

If the ugprade was successful, this command should yield output similar to the following:

```
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

5. Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.2 release.

6. If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.2.

<a href="#heading--create-a-maas-user"><h2 id="heading--create-a-maas-user">How to create a MAAS 3.2 user</h2></a>

You will need to create a MAAS administrator user to access the web UI:

``` nohighlight
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

$PROFILE is the administrative MAAS username you wish to create.  $EMAIL_ADDRESS is an email address you may type in at random (currently, MAAS does not use this email address).

The `createadmin` option will ask for an SSH key.  If you have an SSH key associated with your launchpad or github accounts, you can enter the username here to use the associated key. For launchpad, just enter `lp:username`, and for github, enter `gh:username` at the prompt. In both cases, the actual username has to be supplied after the `lp:` or `gh:` prefix.
[/tab]
[tab version="v3.1 Snap"]
<a href="#heading--fresh-install-3-1-snap"><h2 id="heading--fresh-install-3-1-snap">How to do a fresh snap install of MAAS 3.1</h2></a>

To install MAAS 3.1 from a snap, simply enter the following:

    $ sudo snap install --channel=3.1/stable maas

After entering your password, the snap will download and install from the 3.1 channel.

<a href="#heading--upgrade-from-earlier-version-to-snap-3-1"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-1">How to upgrade from an earlier snap version to MAAS 3.1</h2></a>

Maybe you actually want to upgrade from a earlier snap version to the 3.1 snap.  If you are using a `region+rack` configuration, do this:

    $ sudo snap refresh --channel=3.1/stable maas

After entering your password, the snap will refresh from the 3.1 channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.

<a href="#heading--init-maas-poc"><h2 id="heading--init-maas-poc">How to initialise MAAS 3.1 snap for a test or POC environment</h2></a>

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

<a href="#heading--init-maas-production"><h2 id="heading--init-maas-production">Initialise MAAS for a production configuration</h2></a>

To install MAAS in a production configuration, you need to setup PostgreSQL, as described below.

<a href="#heading--pg-setup"><h4 id="heading--pg-setup">Setting up PostgreSQL from scratch</h4></a>

To set up PostgreSQL, even if it's running on a different machine, you can use the following procedure:

1. You will need to install PostgreSQL on the machine where you want to keep the database.  This can be the same machine as the MAAS region/rack controllers or a totally separate machine.  If PostgreSQL (version 10 or better) is already running on your target machine, you can skip this step. To install PostgreSQL, run these commands:

        sudo apt update -y
        sudo apt install -y postgresql

2. You want to make sure you have a suitable PostgreSQL user, which can be accomplished with the following command, where `$MAAS_DBUSER` is your desired database username, and `$MAAS_DBPASS` is the intended password for that username.  Note that if you're executing this step in a LXD container (as root, which is the default), you may get a minor error, but the operation will still complete correctly.

        sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"

3. Create the MAAS database with the following command, where `$MAAS_DBNAME` is your desired name for the MAAS database (typically known as `maas`). Again, if you're executing this step in a LXD container as root, you can ignore the minor error that results.

        sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"

4. Edit `/etc/postgresql/10/main/pg_hba.conf` and add a line for the newly created database, replacing the variables with actual  names. You can limit access to a specific network by using a different CIDR than `0/0`.

        host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5

5. You can then initialise MAAS via the following command:

        sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"

[note] You should use `localhost` for `$HOSTNAME` if you're running PostgreSQL on the same box as MAAS.[/note]

Don't worry; if you leave out any of the database parameters, you'll be prompted for those details.
[/tab]
[tab version="v3.1 Packages"]
<a href="#heading--fresh-install-3-1-packages"><h2 id="heading--fresh-install-3-1-packages">How to do a fresh install of MAAS 3.1 from packages</h2></a>

The recommended way to set up an initial MAAS environment is to put everything on one machine:

``` bash
sudo apt-add-repository ppa:maas/3.1
sudo apt update
sudo apt-get -y install maas
```

Executing this command leads you to a list of dependent packages to be installed, and a summary prompt that lets you choose whether to continue with the install:

<a href="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg"></a>

Choosing "Y" proceeds with a standard <code>apt</code> package install.

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

<a href="#heading--upgrade-from-3-0-to-3-1"><h2 id="heading--upgrade-from-3-0-to-3-1">How to ugprade from MAAS 2.9 or 3.0 to MAAS 3.1</h2></a>

You can upgrade from MAAS 2.9 or MAAS 3.0 to MAAS 3.1:

1. Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

2. Add the MAAS 3.1 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.1
```

3. Run the MAAS upgrade like this:

```
sudo apt update
sudo apt upgrade maas
```

4. Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.1 release.

5. If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.1.

<a href="#heading--upgrade-from-2-8-to-3-1"><h2 id="heading--upgrade-from-2-8-to-3-1">How to upgrade from 2.8 or lower to MAAS 3.1</h2></a>

If you are running MAAS 2.8 or lower, you can also upgrade directly to MAAS 3.1, but it requires some extra steps.  You must first make sure that the target system is running Ubuntu 20.04 LTS or higher, by executing the following command:

```
lsb_release -a
```

The response should look something like this:

```
Distributor ID:	Ubuntu
Description:	Ubuntu xx.yy
Release:	xx.yy
Codename:	$RELEASE_NAME
```

The minimum "xx.yy" required for MAAS 3.0 is "20.04," code-named "focal."

If you are currently running Ubuntu bionic 18.04 LTS, you can upgrade to focal 20.04 LTS with the following procedure:

1. Upgrade the release:

```
sudo do-release-upgrade --allow-third-party
```

2. Accept the defaults for any questions asked by the upgrade script.

3. Reboot the machine when requested.

4. Check whether the upgrade was successful:

```
lsb_release -a
```

A successful upgrade should respond with output similar to the following:

```
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

[note]
If you're upgrading from MAAS version 2.8 or lower to version 3.1: While the following procedures should work, note that they are untested.  Use at your own risk.  Start by making a verifiable backup; see step 1, below.
[/note]

1. Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

2. Add the MAAS 3.1 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.1
```

3. Run the release upgrade like this, answering any questions with the given default values:

```
sudo do-release-upgrade --allow-third-party
```

4. Check whether your upgrade has been successful by entering:

```
lsb_release -a
```

If the ugprade was successful, this command should yield output similar to the following:

```
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

5. Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.1 release.

6. If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.1.

<a href="#heading--create-a-maas-user"><h2 id="heading--create-a-maas-user">How to create a MAAS 3.1 user</h2></a>

You will need to create a MAAS administrator user to access the web UI:

``` nohighlight
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

$PROFILE is the administrative MAAS username you wish to create.  $EMAIL_ADDRESS is an email address you may type in at random (currently, MAAS does not use this email address).

The `createadmin` option will ask for an SSH key.  If you have an SSH key associated with your launchpad or github accounts, you can enter the username here to use the associated key. For launchpad, just enter `lp:username`, and for github, enter `gh:username` at the prompt. In both cases, the actual username has to be supplied after the `lp:` or `gh:` prefix.
[/tab]
[tab version="v3.0 Snap"]
<a href="#heading--fresh-install-3-0-snap"><h2 id="heading--fresh-install-3-0-snap">How to do a fresh snap install of MAAS 3.0</h2></a>

To install MAAS 3.0 from a snap, simply enter the following:

    $ sudo snap install --channel=3.0/stable maas

After entering your password, the snap will download and install from the 3.0 stable channel.

<a href="#heading--upgrade-from-earlier-version-to-snap-3-0"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-0">How to upgrade from an earlier snap version to MAAS 3.0</h2></a>

Maybe you need to upgrade from a earlier snap version to the 3.0 snap, instead of installing fresh.  If you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=3.0/stable maas

After entering your password, the snap will refresh from the 3.0 channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.

<a href="#heading--init-maas-poc"><h2 id="heading--init-maas-poc">How to initialise MAAS 3.0 snap for a test or POC environment</h2></a>

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

<a href="#heading--init-maas-production"><h2 id="heading--init-maas-production">Initialise MAAS for a production configuration</h2></a>

To install MAAS in a production configuration, you need to setup PostgreSQL, as described below.

<a href="#heading--pg-setup"><h4 id="heading--pg-setup">Setting up PostgreSQL from scratch</h4></a>

To set up PostgreSQL, even if it's running on a different machine, you can use the following procedure:

1. You will need to install PostgreSQL on the machine where you want to keep the database.  This can be the same machine as the MAAS region/rack controllers or a totally separate machine.  If PostgreSQL (version 10 or better) is already running on your target machine, you can skip this step. To install PostgreSQL, run these commands:

        sudo apt update -y
        sudo apt install -y postgresql

2. You want to make sure you have a suitable PostgreSQL user, which can be accomplished with the following command, where `$MAAS_DBUSER` is your desired database username, and `$MAAS_DBPASS` is the intended password for that username.  Note that if you're executing this step in a LXD container (as root, which is the default), you may get a minor error, but the operation will still complete correctly.

        sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"

3. Create the MAAS database with the following command, where `$MAAS_DBNAME` is your desired name for the MAAS database (typically known as `maas`). Again, if you're executing this step in a LXD container as root, you can ignore the minor error that results.

        sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"

4. Edit `/etc/postgresql/10/main/pg_hba.conf` and add a line for the newly created database, replacing the variables with actual  names. You can limit access to a specific network by using a different CIDR than `0/0`.

        host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5

5. You can then initialise MAAS via the following command:

        sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"

[note] You should use `localhost` for `$HOSTNAME` if you're running PostgreSQL on the same box as MAAS.[/note]

Don't worry; if you leave out any of the database parameters, you'll be prompted for those details.
[/tab]
[tab version="v3.0 Packages"]
<a href="#heading--fresh-install-3-0-packages"><h2 id="heading--fresh-install-3-0-packages">How to do a fresh install of MAAS 3.0 from packages</h2></a>

The recommended way to install MAAS from packages uses the "everything on one machine" model:

``` bash
sudo apt-add-repository ppa:maas/3.0
sudo apt update
sudo apt-get -y install maas
```

Executing this command leads you to a list of dependent packages to be installed, and a summary prompt that lets you choose whether to continue with the install:

<a href="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg"></a>

Choosing "Y" proceeds with a standard <code>apt</code> package install.

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

<a href="#heading--upgrade-from-2-9-to-3-0"><h2 id="heading--upgrade-from-2-9-to-3-0">How to ugprade from MAAS 2.9 to MAAS 3.0</h2></a>

Maybe you want to upgrade from a working 2.9 instance to MAAS 3.0.   You can easily do that with these steps:

1. Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

2. Add the MAAS 3.0 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.0
```

3. Run the MAAS upgrade like this:

```
sudo apt update
sudo apt upgrade maas
```

4. Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.0 release.

5. If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.0.

<a href="#heading--upgrade-from-2-8-to-3-0"><h2 id="heading--upgrade-from-2-8-to-3-0">How to upgrade from 2.8 or lower to MAAS 3.0</h2></a>

If you are running MAAS 2.8 or lower, you can upgrade directly to MAAS 3.0, but there's a little more work involved.  You must also make sure that the target system is running Ubuntu 20.04 LTS or higher, by executing the following command:

```
lsb_release -a
```

The response should look something like this:

```
Distributor ID:	Ubuntu
Description:	Ubuntu xx.yy
Release:	xx.yy
Codename:	$RELEASE_NAME
```

The minimum "xx.yy" required for MAAS 3.0 is "20.04," code-named "focal."

If you are currently running Ubuntu bionic 18.04 LTS, you can upgrade to focal 20.04 LTS with the following procedure:

1. Upgrade the release:

```
sudo do-release-upgrade --allow-third-party
```

2. Accept the defaults for any questions asked by the upgrade script.

3. Reboot the machine when requested.

4. Check whether the upgrade was successful:

```
lsb_release -a
```

A successful upgrade should respond with output similar to the following:

```
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

[note]
If you're upgrading from MAAS version 2.8 or lower to version 3.0: While the following procedures should work, note that they are untested.  Use at your own risk.  Start by making a verifiable backup; see step 1, below.
[/note]

1. Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

2. Add the MAAS 3.0 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.0
```

3. Run the release upgrade like this, answering any questions with the given default values:

```
sudo do-release-upgrade --allow-third-party
```

4. Check whether your upgrade has been successful by entering:

```
lsb_release -a
```

If the ugprade was successful, this command should yield output similar to the following:

```
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

5. Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.0 release.

6. If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.0.

<a href="#heading--create-a-maas-user"><h2 id="heading--create-a-maas-user">How to create a MAAS 3.0 user</h2></a>

You will need to create a MAAS administrator user to access the web UI:

``` nohighlight
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

$PROFILE is the administrative MAAS username you wish to create.  $EMAIL_ADDRESS is an email address you may type in at random (currently, MAAS does not use this email address).

The `createadmin` option will ask for an SSH key.  If you have an SSH key associated with your launchpad or github accounts, you can enter the username here to use the associated key. For launchpad, just enter `lp:username`, and for github, enter `gh:username` at the prompt. In both cases, the actual username has to be supplied after the `lp:` or `gh:` prefix.
[/tab]
[tab version="v2.9 Snap"]
<a href="#heading--fresh-install-2-9-snap"><h2 id="heading--fresh-install-2-9-snap">How to do a fresh snap install of MAAS 2.9</h2></a>

To install MAAS 2.9 directly, from a snap, simply enter the following:

    $ sudo snap install --channel=2.9/stable maas

After entering your password, the snap will download and install from the 2.9 stable channel.

<a href="#heading--upgrade-from-earlier-version-to-snap-2-9"><h2 id="heading--upgrade-from-earlier-version-to-snap-2-9">How to upgrade from an earlier snap version to MAAS 2.9</h2></a>

If you want to upgrade from a earlier snap version to the 2.9 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=3.0/stable maas

After entering your password, the snap will refresh from the 3.0 channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.

<a href="#heading--init-maas-poc"><h2 id="heading--init-maas-poc">How to initialise MAAS 2.9 snap for a test or POC environment</h2></a>

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

<a href="#heading--init-maas-production"><h2 id="heading--init-maas-production">Initialise MAAS for a production configuration</h2></a>

To install MAAS in a production configuration, you need to setup PostgreSQL, as described below.

<a href="#heading--pg-setup"><h4 id="heading--pg-setup">Setting up PostgreSQL from scratch</h4></a>

To set up PostgreSQL, even if it's running on a different machine, you can use the following procedure:

1. You will need to install PostgreSQL on the machine where you want to keep the database.  This can be the same machine as the MAAS region/rack controllers or a totally separate machine.  If PostgreSQL (version 10 or better) is already running on your target machine, you can skip this step. To install PostgreSQL, run these commands:

        sudo apt update -y
        sudo apt install -y postgresql

2. You want to make sure you have a suitable PostgreSQL user, which can be accomplished with the following command, where `$MAAS_DBUSER` is your desired database username, and `$MAAS_DBPASS` is the intended password for that username.  Note that if you're executing this step in a LXD container (as root, which is the default), you may get a minor error, but the operation will still complete correctly.

        sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"

3. Create the MAAS database with the following command, where `$MAAS_DBNAME` is your desired name for the MAAS database (typically known as `maas`). Again, if you're executing this step in a LXD container as root, you can ignore the minor error that results.

        sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"

4. Edit `/etc/postgresql/10/main/pg_hba.conf` and add a line for the newly created database, replacing the variables with actual  names. You can limit access to a specific network by using a different CIDR than `0/0`.

        host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5

5. You can then initialise MAAS via the following command:

        sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"

[note] You should use `localhost` for `$HOSTNAME` if you're running PostgreSQL on the same box as MAAS.[/note]

Don't worry; if you leave out any of the database parameters, you'll be prompted for those details.
[/tab]
[tab version="v2.9 Packages"]
<a href="#heading--fresh-install-2-9-packages"><h2 id="heading--fresh-install-2-9-packages">How to do a fresh install of MAAS 2.9 from packages</h2></a>

The recommended way to set up an initial MAAS environment is to put everything on one machine:

``` bash
sudo apt-get -y install maas
```

Executing this command leads you to a list of dependent packages to be installed, and a summary prompt that lets you choose whether to continue with the install:

<a href="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg"></a>

Choosing "Y" proceeds with a standard <code>apt</code> package install.

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

<a href="#heading--upgrade-from-2-8-to-2-9"><h2 id="heading--upgrade-from-2-8-to-2-9">How to upgrade from MAAS 2.8 or lower to MAAS 2.9</h2></a>

MAAS 2.8 is the last supported version for Ubuntu 18.04 LTS.  Newer versions of MAAS will not be back-portable, and consequently, to upgrade to MAAS 2.9 and all future versions, you will also need to upgrade the base operating system to Ubuntu 20.04.  You do these two operations all at once, with the following procedure:

```
sudo add-apt-repository ppa:maas/2.9
```

You will get a message similar to this:

```
 For stable releases of 2.9.x
 More info: https://launchpad.net/~maas/+archive/ubuntu/2.9
Press [ENTER] to continue or Ctrl-c to cancel adding it.

Hit:1 http://security.ubuntu.com/ubuntu bionic-security InRelease
Hit:2 http://ppa.launchpad.net/maas/2.8/ubuntu bionic InRelease          
Hit:3 http://archive.ubuntu.com/ubuntu bionic InRelease                  
Hit:4 http://archive.ubuntu.com/ubuntu bionic-updates InRelease                                     
Ign:5 http://ppa.launchpad.net/maas/2.9/ubuntu bionic InRelease          
Hit:6 http://archive.ubuntu.com/ubuntu bionic-backports InRelease        
Err:7 http://ppa.launchpad.net/maas/2.9/ubuntu bionic Release                 
  404  Not Found [IP: 91.189.95.85 80]
Reading package lists... Done
E: The repository 'http://ppa.launchpad.net/maas/2.9/ubuntu bionic Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
```

This message seems to indicate that nothing happened, but, in fact, this command still creates the file:

```
/etc/apt/sources.list.d/maas-ubuntu-2_9-bionic.list
```

This file identifies the path to the 2.9 PPA, even though it incorrectly implies there's a Bionic release there:

```
deb http://ppa.launchpad.net/maas/2.9/ubuntu bionic main
```

Still, that's enough for `do-release-upgrade` to figure out that there is a 2.9 PPA, and when it checks, it will find a Focal version of MAAS, which it will bring over and install in place of 2.8.  It isn't necessary to stop MAAS or do anything else, except go ahead and run the upgrade:

```
sudo do-release-upgrade --allow-third-party
```

This command will produce a lot of output, ask you a few questions (for which the defaults are usually fine), and eventually ask you to reboot.  Once your machine has come back up, you can check whether your upgrade has been successful by entering:

```
lsb_release -a
```

If the ugprade was successful, this command should yield output similar to the following:

```
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
```

You have now upgraded to the Ubuntu 20.04 LTS base, and if you check your running MAAS install, you should see that the version has been updated to the latest stable 2.9 release.

<a href="#heading--create-a-maas-user"><h2 id="heading--create-a-maas-user">How to create a MAAS 2.9 user</h2></a>

You will need to create a MAAS administrator user to access the web UI:

``` nohighlight
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

$PROFILE is the administrative MAAS username you wish to create.  $EMAIL_ADDRESS is an email address you may type in at random (currently, MAAS does not use this email address).

The `createadmin` option will ask for an SSH key.  If you have an SSH key associated with your launchpad or github accounts, you can enter the username here to use the associated key. For launchpad, just enter `lp:username`, and for github, enter `gh:username` at the prompt. In both cases, the actual username has to be supplied after the `lp:` or `gh:` prefix.
[/tab]
[/tabs]

<a href="#heading--service-status"><h2 id="heading--service-status">How to check the status of MAAS services</h2></a>

You can check the status of running services with:

    sudo maas status

Typically, the output looks something like this:

    bind9                            RUNNING   pid 7999, uptime 0:09:17
    dhcpd                            STOPPED   Not started
    dhcpd6                           STOPPED   Not started
    ntp                              RUNNING   pid 8598, uptime 0:05:42
    postgresql                       RUNNING   pid 8001, uptime 0:09:17
    proxy                            STOPPED   Not started
    rackd                            RUNNING   pid 8000, uptime 0:09:17
    regiond:regiond-0                RUNNING   pid 8003, uptime 0:09:17
    regiond:regiond-1                RUNNING   pid 8008, uptime 0:09:17
    regiond:regiond-2                RUNNING   pid 8005, uptime 0:09:17
    regiond:regiond-3                RUNNING   pid 8015, uptime 0:09:17
    tgt                              RUNNING   pid 8040, uptime 0:09:15

<a href="#heading--reinitialising-maas"><h3 id="heading--reinitialising-maas">How to re-initialise MAAS</h3></a>

It is also possible to re-initialise MAAS to switch modes.  For example, to switch from `rack` to `region`:
 
    sudo maas init region

<a href="#heading--additional-init-options"><h2 id="heading--additional-init-options">How to list additional MAAS initialisation options</h2></a>

The `init` command can takes optional arguments. To list them, as well as read a brief description of each, you can enter:

    sudo maas init --help


<a href="#heading--configure-maas"><h2 id="heading--configure-maas">How to configure MAAS</h2></a>

[tabs]
[tab version="v3.3 Beta 1 Snap, v3.3 Beta 1 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
Once you've successfully installed MAAS (regardless of method), you can now login here:

```
http://${API_HOST}:5240/MAAS
```

where $API_HOST is the hostname or IP address of the region API server, which was set during installation.  You will see a screen like this:</p>

<a href="https://discourse.maas.io/uploads/default/original/1X/efd8e3f150dfec28114c452c12e24e320848e075.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/efd8e3f150dfec28114c452c12e24e320848e075.jpeg"></a> 

Log in at the prompts, with the login information you created when initialising MAAS.

<a href="#heading--configuration"><h3 id="heading--configuration">Configuration</h3></a>

After a fresh MAAS installation, the web UI presents a couple of welcome  screens.  From these screens, you can set many system-wide options, including connectivity, image downloads, and authentication keys.

<a href="https://discourse.maas.io/uploads/default/original/1X/337aa15e178b14b0ba9a0646953268bf7adac0bb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/337aa15e178b14b0ba9a0646953268bf7adac0bb.jpeg"></a>  

Your main concerns for this experiment are the DNS forwarder, the Ubuntu image import section, and the SSH public key, though you might want to set the region name to something memorable, since this text will appear at the bottom of every MAAS screen in this install domain. Set the DNS forwarder to something obvious, e.g., `8.8.8.8`, Google’s DNS server.  Set this to your own internal DNS server if you know the IP address.

<a href="https://discourse.maas.io/uploads/default/original/1X/f9751eb857dcd0c124783edeb1aaf87b8b538127.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/f9751eb857dcd0c124783edeb1aaf87b8b538127.jpeg"></a>  

Select an Ubuntu image to import, noting that you may be required to select at least one LTS version, depending upon the version of MAAS that snap installed.  In this example, we've already chosen an image, and downloading is partially complete.

<a href="https://discourse.maas.io/uploads/default/original/1X/6445cde5ffc1e237a1e6d85d280f451bc0b2ab92.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/6445cde5ffc1e237a1e6d85d280f451bc0b2ab92.jpeg"></a>  

When you click on “Continue,” the screen will shift to a screen labelled, “SSH keys for admin:”  

<a href="https://discourse.maas.io/uploads/default/original/1X/dbdcdce7c8f3b7181f894bdfe987758e0c8635fc.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/dbdcdce7c8f3b7181f894bdfe987758e0c8635fc.jpeg"></a> 

In the source drop-down, select “Launchpad,” “Github,” or “Upload.”  If you choose one of the first two, you will need to enter your username for that service.  For example, if you want to upload your SSH public key from Launchpad, you would enter:

    lp:<username>


<a href="https://discourse.maas.io/uploads/default/original/1X/0e4cbf7c8fae3f21664a4d5fe8d0f90785dd6859.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0e4cbf7c8fae3f21664a4d5fe8d0f90785dd6859.jpeg"></a> 

Likewise, if you want to upload your github public SSH key, you would enter:

    gh:<username>

If you want to use your existing public key from your home directory, you can select “Upload”and then copy your entire public key from <code>.ssh/id_rsa.pub</code> (or wherever you may have stored the key):

<a href="https://discourse.maas.io/uploads/default/original/1X/a94f1f68db07dd9be9e8eaed50f22828c7bb51e0.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a94f1f68db07dd9be9e8eaed50f22828c7bb51e0.jpeg"></a> 

and paste it into the block labelled “Public key.”  Finally, press the “Import” button to import this key:

<a href="https://discourse.maas.io/uploads/default/original/1X/ab62bf22308343988016189fbbb851c44caf2e33.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/ab62bf22308343988016189fbbb851c44caf2e33.jpeg"></a> 

With this complete, you’ll see that MAAS has been successfully set up. Click ‘Go to the Dashboard’ to proceed.

[note]
Note that you may have to wait a few moments for your selected images to sync locally.
[/note]

<a href="#heading--enabling-dhcp"><h3 id="heading--enabling-dhcp">How to enable DHCP</h3></a>

Before moving forward with MAAS, you'll want to enable DHCP.  You can do this very easily from the web UI by selecting "Subnets" from the top menu, choosing the VLAN on which you want to enable DHCP, and select the button marked, "Enable DHCP."

<a href="#heading--networking"><h3 id="heading--networking">About network discovery</h3></a>

The Dashboard landing page lists non-registered devices that MAAS detected automatically on the network. This network discovery process allows you to easily add or map devices already connected to your network -- devices that you may not necessarily want to manage with MAAS.
[/tab]
[tab version="v3.3 Beta 1 Snap,v3.3 Beta 1 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
Once you've successfully installed MAAS (regardless of method), you can login to the MAAS CLI via the following process.  First, generate the API-key for the user you're going to employing:

```
sudo maas apikey --username=$PROFILE > api-key-file
```

Replace $PROFILE with whatever username you set during the `createadmin` part of the install process.  Next, login with the following command:

```
maas login $PROFILE $MAAS_URL < api-key-file
```

Substitute $MAAS_URL with the URL that was returned to you when you initialised MAAS, for example, `192.168.43.251:5240/MAAS`.  Remember that, once you've logged in, you can get extensive CLI help with the command:

```
maas admin --help
```

Sample output is shown in the detail section below.

<details><summary>MAAS CLI help, sample output</summary>
usage: maas admin [-h] COMMAND ...

Issue commands to the MAAS region controller at `http://192.168.43.251:5240/MAAS/api/2.0/.`

optional arguments:
  -h, --help            show this help message and exit

drill down:
  COMMAND
    account             Manage the current logged-in user.
    bcache-cache-set    Manage bcache cache set on a machine.
    bcache-cache-sets   Manage bcache cache sets on a machine.
    bcache              Manage bcache device on a machine.
    bcaches             Manage bcache devices on a machine.
    block-device        Manage a block device on a machine.
    block-devices       Manage block devices on a machine.
    boot-resource       Manage a boot resource.
    boot-resources      Manage the boot resources.
    boot-source         Manage a boot source.
    boot-source-selection
                        Manage a boot source selection.
    boot-source-selections
                        Manage the collection of boot source selections.
    boot-sources        Manage the collection of boot sources.
    commissioning-script
                        Manage a custom commissioning script.
    commissioning-scripts
                        Manage custom commissioning scripts.
    dhcpsnippet         Manage an individual DHCP snippet.
    dhcpsnippets        Manage the collection of all DHCP snippets in MAAS.
    dnsresource         Manage dnsresource.
    dnsresource-record  Manage dnsresourcerecord.
    dnsresource-records
                        Manage DNS resource records (e.g. CNAME, MX, NS, SRV,
                        TXT)
    dnsresources        Manage dnsresources.
    device              Manage an individual device.
    devices             Manage the collection of all the devices in the MAAS.
    discoveries         Query observed discoveries.
    discovery           Read or delete an observed discovery.
    domain              Manage domain.
    domains             Manage domains.
    events              Retrieve filtered node events.
    fabric              Manage fabric.
    fabrics             Manage fabrics.
    fan-network         Manage Fan Network.
    fan-networks        Manage Fan Networks.
    file                Manage a FileStorage object.
    files               Manage the collection of all the files in this MAAS.
    ipaddresses         Manage IP addresses allocated by MAAS.
    iprange             Manage IP range.
    ipranges            Manage IP ranges.
    interface           Manage a node's or device's interface.
    interfaces          Manage interfaces on a node.
    license-key         Manage a license key.
    license-keys        Manage the license keys.
    maas                Manage the MAAS server.
    machine             Manage an individual machine.
    machines            Manage the collection of all the machines in the MAAS.
    network             Manage a network.
    networks            Manage the networks.
    node                Manage an individual Node.
    node-results        Read the collection of commissioning script results.
    node-script         Manage or view a custom script.
    node-script-result  Manage node script results.
    node-script-results
                        Manage node script results.
    node-scripts        Manage custom scripts.
    nodes               Manage the collection of all the nodes in the MAAS.
    notification        Manage an individual notification.
    notifications       Manage the collection of all the notifications in
                        MAAS.
    package-repositories
                        Manage the collection of all Package Repositories in
                        MAAS.
    package-repository  Manage an individual package repository.
    partition           Manage partition on a block device.
    partitions          Manage partitions on a block device.
    pod                 Manage an individual pod.
    pods                Manage the collection of all the pod in the MAAS.
    rack-controller     Manage an individual rack controller.
    rack-controllers    Manage the collection of all rack controllers in MAAS.
    raid                Manage a specific RAID (Redundant Array of Independent
                        Disks) on a machine.
    raids               Manage all RAIDs (Redundant Array of Independent
                        Disks) on a machine.
    region-controller   Manage an individual region controller.
    region-controllers  Manage the collection of all region controllers in
                        MAAS.
    resource-pool       Manage a resource pool.
    resource-pools      Manage resource pools.
    sshkey              Manage an SSH key.
    sshkeys             Manage the collection of all the SSH keys in this
                        MAAS.
    sslkey              Manage an SSL key.
    sslkeys             Operations on multiple keys.
    space               Manage space.
    spaces              Manage spaces.
    static-route        Manage static route.
    static-routes       Manage static routes.
    subnet              Manage subnet.
    subnets             Manage subnets.
    tag                 Tags are properties that can be associated with a Node
                        and serve as criteria for selecting and allocating
                        nodes.
    tags                Manage all tags known to MAAS.
    user                Manage a user account.
    users               Manage the user accounts of this MAAS.
    version             Information about this MAAS instance.
    vlan                Manage a VLAN on a fabric.
    vlans               Manage VLANs on a fabric.
    vm-host             Manage an individual vm-host.
    vm-hosts            Manage the collection of all the vm-hosts in the MAAS.
    vmfs-datastore      Manage VMFS datastore on a machine.
    vmfs-datastores     Manage VMFS datastores on a machine.
    volume-group        Manage volume group on a machine.
    volume-groups       Manage volume groups on a machine.
    zone                Manage a physical zone.
    zones               Manage physical zones.

This is a profile.  Any commands you issue on this profile will
operate on the MAAS region server.

The command information you see here comes from the region server's
API; it may differ for different profiles.  If you believe the API may
have changed, use the command's 'refresh' sub-command to fetch the
latest version of this help information from the server.
</details>

<a href="#heading--configuration"><h3 id="heading--configuration">Configuration</h3></a>

Configuring MAAS consists of four broad steps:

1. Setting upstream DNS
2. Importing an SSH key for your admin user
3. Importing images
4. Configuring DNS

This section will cover those four operations

<a href="#heading--setting-dns"><h4 id="heading--setting-dns">How to set upstream DNS</h4></a>

After logging in for the first time, you will need to set a number of system-wide configuration options.  First up, you should configure DNS.  You can check out the help for DNS settings, known in the CLI as a "DNS forwarder":

```
maas $PROFILE maas set-config name=upstream_dns value="8.8.8.8"
```

Here, we've set the DNS forwarder to "8.8.8.8" (Google), which is a reliable value.

<a href="#heading--setting-ssh"><h4 id="heading--setting-ssh">How to set up SSH for the admin user</h4></a>

To add a public SSH key to a MAAS user account, type the following command:

```
maas $PROFILE sshkeys create "key=$SSH_KEY"
```

<a href="#heading--importing-images"><h4 id="heading--importing-images">How to import images</h4></a>

Before going any further, it's worthwhile to start the image import, as it can sometimes take a few minutes.  You can see what images you already have downloaded with this command:

```
maas $PROFILE boot-resources read | jq -r '.[] | "\(.name)\t\(.architecture)"'
```

This command will return a list similar to the following:

```
grub-efi-signed/uefi        amd64/generic
grub-efi/uefi           arm64/generic
grub-ieee1275/open-firmware ppc64el/generic
pxelinux/pxe            i386/generic
ubuntu/bionic           amd64/ga-18.04
ubuntu/bionic           amd64/ga-18.04-lowlatency
ubuntu/bionic           amd64/hwe-18.04
ubuntu/bionic           amd64/hwe-18.04-edge
ubuntu/bionic           amd64/hwe-18.04-lowlatency
ubuntu/bionic           amd64/hwe-18.04-lowlatency-edge
```

Suppose you also want a version called "Trusty" -- you can import a new image by first selecting it for download, like this:

```
maas $PROFILE boot-source-selections create 1 os="ubuntu" release="trusty" arches="amd64" subarches="*"  labels="*"
```

which returns some JSON confirming your action:

```
Success.
Machine-readable output follows:
{
    "os": "ubuntu",
    "release": "trusty",
    "arches": [
        "amd64"
    ],
    "subarches": [
        "*"
    ],
    "labels": [
        "*"
    ],
    "boot_source_id": 1,
    "id": 2,
    "resource_uri": "/MAAS/api/2.0/boot-sources/1/selections/2/"
}
```
Once selected, you can start the image import with this command:

```
maas admin boot-resources import
```

which offers a shorter confirmation message:

```
Success.
Machine-readable output follows:
Import of boot resources started
```

<a href="#heading--enabling-dhcp"><h4 id="heading--enabling-dhcp">How to enable DHCP</h4></a>

Once your image has been imported, you'll want to get DHCP working, which means finding the untagged VLAN. In truth, it shouldn’t be too hard, because at this point, there still should only be one.

In order to turn on DHCP, you need to know two things besides the VLAN name (“untagged”): the fabric ID and the primary rack controller name. To start, all the fabrics will be on the same untagged VLAN, so any fabric will do. You can find a valid fabric ID by reading it from any subnet, so just pick one  (e.g., 192.168.123.0/24) and find a usable fabric ID like this:

```
maas $PROFILE subnet read $SUBNET_CIDR | grep fabric_id
```

which returns (in this example):

```
"fabric_id": $FABRIC_ID,
```

Next, find the name of the primary rack controller. It's usually fairly obvious, but for purposes of argument, assume that it's not known. You can get it this way:

```
maas $PROFILE rack-controllers read | grep hostname | cut -d '"' -f 4
```

This returns a hostname, which we'll call:

```
$RACK_CONTR_HOSTNAME
```

Finally, you need to create an IP range for DHCP, in this case, a dynamic range:

```
maas $PROFILE ipranges create type=dynamic start_ip=$START_IP end_ip=$END_IP
```

This command returns something similar to this sample output:

    Success.
    Machine-readable output follows:
    {
        "subnet": {
            "name": "192.168.123.0/24",
            "description": "",
            "vlan": {
                "vid": 0,
                "mtu": 1500,
                "dhcp_on": false,
                "external_dhcp": null,
                "relay_vlan": null,
                "fabric": "fabric-2",
                "primary_rack": null,
                "name": "untagged",
                "id": 5003,
                "space": "undefined",
                "secondary_rack": null,
                "fabric_id": 2,
                "resource_uri": "/MAAS/api/2.0/vlans/5003/"
            },
            "cidr": "192.168.123.0/24",
            "rdns_mode": 2,
            "gateway_ip": null,
            "dns_servers": [],
            "allow_dns": true,
            "allow_proxy": true,
            "active_discovery": false,
            "managed": true,
            "id": 4,
            "space": "undefined",
            "resource_uri": "/MAAS/api/2.0/subnets/4/"
        },
        "type": "dynamic",
        "start_ip": "192.168.123.190",
        "end_ip": "192.168.123.253",
        "user": {
            "is_superuser": true,
            "username": "admin",
            "email": "admin@admin.com",
            "is_local": true,
            "resource_uri": "/MAAS/api/2.0/users/admin/"
        },
        "comment": "",
        "id": 1,
        "resource_uri": "/MAAS/api/2.0/ipranges/1/"
    }

So you should now be able to turn on DHCP like this:

```
maas $PROFILE vlan update $FABRIC_ID untagged dhcp_on=True primary_rack=$RACK_CONTR_HOSTNAME
```

If you've done everything correctly, you should see JSON output similar to this sample:

    Success.
    Machine-readable output follows:
    {
        "vid": 0,
        "mtu": 1500,
        "dhcp_on": true,
        "external_dhcp": null,
        "relay_vlan": null,
        "fabric": "fabric-2",
        "space": "undefined",
        "primary_rack": "8dwnne",
        "secondary_rack": null,
        "name": "untagged",
        "fabric_id": 2,
        "id": 5003,
        "resource_uri": "/MAAS/api/2.0/vlans/5003/"
    }

[/tab]
[/tabs]

<!--
<a href="#heading--maas-init-modes"><h3 id="heading--maas-init-modes">MAAS initialisation modes reference</h3></a>

MAAS supports the following modes, which dictate what services will run on the local system:

| Mode          | Region | Rack | Database | Description                           |
|:--------------|:------:|:----:|:--------:|:--------------------------------------|
| `region`      | X      |      |          | Region API server only                |
| `rack`        |        | X    |          | Rack controller only                  |
| `region+rack` | X      | X    |          | Region API server and rack controller |
| `none`        |        |      |          | Reinitialises MAAS and stops services |

<a href="#heading--ssh-keys"><h3 id="heading--ssh-keys">About SSH keys</h3></a>

MAAS uses your Launchpad or Github SSH keys to access machines that have been deployed.  Normally, you enter this key during the initialisation of MAAS.  If you don't have a key associated with either of these services, you will have an opportunity to paste your public key into the MAAS SSH key list, after you've started MAAS for the first time as part of the welcome screens.

<a href="#heading--maas-url"><h3 id="heading--maas-url">About the MAAS URL</h3></a>

All run modes (except `none`) prompt for a MAAS URL, interpreted differently depending on the mode:

-   `region`: Used to create a new region controller.
-   `rack`: Used to locate the region controller.

<a href="#heading--shared-secret"><h3 id="heading--shared-secret">About the shared secret</h3></a>

The 'rack' and 'region+rack' modes will additionally ask for a shared secret that will allow the new rack controller to register with the region controller.

-->
