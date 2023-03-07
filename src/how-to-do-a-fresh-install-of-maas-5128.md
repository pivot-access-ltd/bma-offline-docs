<!-- "How to install MAAS" -->

MAAS is relatively easy to install and configure.  Let's give it a try.

[tabs]
[tab version="v3.3 Snap"]
[note]
PostgreSQL 12 is deprecated with the release of MAAS 3.3, in favour of PostgreSQL 14. Support for PostgreSQL 12 will be discontinued in MAAS 3.4.
[/note]

<a href="#heading--fresh-install-3-3-snap"><h2 id="heading--fresh-install-3-3-snap">How to do a fresh snap install of MAAS 3.3</h2></a>

To install MAAS 3.3 from a snap:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Enter the following command:

```nohighlight
sudo snap install --channel=3.3 maas
```

3. Enter your account password.

At this point, the snap will download and install from the 3.3 channel.

<a href="#heading--init-maas-poc-3-3"><h2 id="heading--init-maas-poc-3-3">How to initialise MAAS 3.3 snap for a test or POC environment</h2></a>

To initialise the MAAS 3.3 snap in a test/POC configuration, simply use the `--help` flag with `maas init` and follow the instructions.
 
<a href="#heading--init-maas-production-3-3"><h2 id="heading--init-maas-production-3-3">Initialise MAAS for a production configuration</h2></a>

To install MAAS in a production configuration:

1. Install PostgreSQL on any machine where you want to keep the database with the following commands:

```nohighlight
sudo apt update -y
sudo apt install -y postgresql
```

2. Create desired values for the following variables (replace them in the commands below):

```nohighlight
$MAAS_DBUSER = ___________
$MAAS_DBPASS = ___________
$MAAS_DBNAME = ___________
$HOSTNAME = _________
```

Note that for most situations, you can use `localhost` for `$HOSTNAME`.

2. Create a suitable PostgreSQL user:

```nohighlight
sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"
```

3. Create the MAAS database:

```nohighlight
sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"
```

4. Edit `/etc/postgresql/14/main/pg_hba.conf` and add a line for the newly created database:

```nohighlight
host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5
```

5. Initialise MAAS via the following command:

```nohighlight
sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"
```
[/tab]
[tab version="v3.3 Packages"]
[note]
PostgreSQL 12 is deprecated with the release of MAAS 3.3, in favour of PostgreSQL 14. Support for PostgreSQL 12 will be discontinued in MAAS 3.4.
[/note]

<a href="#heading--fresh-install-3-3-packages"><h2 id="heading--fresh-install-3-3-packages">How to do a fresh install of MAAS 3.3 from packages</h2></a>

To install MAAS 3.3 from packages:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Add the MAAS 3.3 PPA to your `apt` repository paths:

```nohighlight
sudo apt-add-repository ppa:maas/3.3-next
```

3. Update your `apt` repository lists:

```nohighlight
sudo apt update
```
	
4. Install MAAS with the following command:

```nohighlight
sudo apt-get -y install maas
```

5. Choose "Y" if asked about whether to continue with the install.

<a href="#heading--Distributed-environment-3-3"><h4 id="heading--Distributed-environment-3-3">Distributed environment</h4></a>

To run MAAS region and rack controllers on separate machines:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Add the MAAS 3.3 PPA to your `apt` repository paths on both region and rack target hosts:

```nohighlight
sudo apt-add-repository ppa:maas/3.3
```

3. Update your `apt` repository lists on both region and rack hosts:

```nohighlight
sudo apt update
```
	
4. Install the MAAS region controller on the target region host:

```nohighlight
sudo apt install maas-region-controller
```

5. Install the MAAS rack controller on the target rack host:

```nohighlight
sudo apt install maas-rack-controller
```
	
6. Register the rack controller with the region controller by running the following command on the rack host:

```nohighlight
sudo maas-rack register
```

These two steps will lead you through two similar <code>apt</code> install sequences.
[/tab]
[tab version="v3.2 Snap"]
<a href="#heading--fresh-install-3-2-snap"><h2 id="heading--fresh-install-3-2-snap">How to do a fresh snap install of MAAS 3.2</h2></a>

To install MAAS 3.2 from a snap:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Enter the following command:

```nohighlight
sudo snap install --channel=3.2 maas
```

3. Enter your account password.

At this point, the snap will download and install from the 3.2 channel.

<a href="#heading--init-maas-poc-3-2"><h2 id="heading--init-maas-poc-3-2">How to initialise MAAS 3.2 snap for a test or POC environment</h2></a>

To initialise MAAS as a compact version for testing, use the `--help` flag with `maas init` to get relevant instructions.
 
<a href="#heading--init-maas-production-3-2"><h2 id="heading--init-maas-production-3-2">Initialise MAAS for a production configuration</h2></a>

In the following, make sure to substitute your own values for `$MAAS_DBUSER`, `$MAAS_DBPASS`, `$MAAS_DBNAME`, `$HOSTNAME`, etc.

To install MAAS in a production configuration:

1. Make sure PostgreSQL is installed on your target database server (can be any machine you wish):

```nohighlight
sudo apt update -y
sudo apt install -y postgresql
```

2. Create a suitable MAAS PostgreSQL user:

```nohighlight
sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"
```

3. Create the MAAS database:

```nohighlight
sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"
```

4. Edit `/etc/postgresql/12/main/pg_hba.conf` and add the following line for the newly created database, replacing the variables with actual names:

```nohighlight
host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5
```

5. Initialise MAAS:

```nohighlight
sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"
```

You can use `localhost` for `$HOSTNAME` if you're running PostgreSQL on the same box as MAAS.
[/tab]
[tab version="v3.2 Packages"]
<a href="#heading--fresh-install-3-2-packages"><h2 id="heading--fresh-install-3-2-packages">How to do a fresh install of MAAS 3.2 from packages</h2></a>

To install MAAS 3.2 from packages:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Add the MAAS 3.2 PPA to your `apt` repository paths:

```nohighlight
sudo apt-add-repository ppa:maas/3.2
```

3. Update your `apt` repository lists:

```nohighlight
sudo apt update
```
	
4. Install MAAS with the following command:

```nohighlight
sudo apt-get -y install maas
```

5. Choose "Y" if asked about whether to continue with the install.

<a href="#heading--create-a-maas-user-3-2"><h2 id="heading--create-a-maas-user-3-2">How to create a MAAS 3.2 user</h2></a>

To create a MAAS 3.2 user:

1. Create a MAAS administrator user to access the web UI:

``` nohighlight
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```
Subtitute `$PROFILE` is the administrative MAAS username you wish to create.  `$EMAIL_ADDRESS` is an email address you may type in at random (currently, MAAS does not use this email address). The `createadmin` option will cause MAAS to ask for an SSH key.

2. To use an SSH key associated with your launchpad accounts, enter `lp:$USERNAME` (substitute your LP username for `$USERNAME`). 

3. Alternatively, to use an SSH key associated with your github account, enter `gh:$USERNAME` (substitute your github username for `$USERNAME`)
[/tab]
[tab version="v3.1 Snap"]
<a href="#heading--fresh-install-3-1-snap"><h2 id="heading--fresh-install-3-1-snap">How to do a fresh snap install of MAAS 3.1</h2></a>

To install MAAS 3.1 from a snap:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Install the 3.2 snap:

```nohighlight
sudo snap install --channel=3.1 maas
```

3. Enter your account password. 

The snap will download and install from the 3.1 channel.

<a href="#heading--init-maas-poc-3-1"><h2 id="heading--init-maas-poc-3-1">How to initialise MAAS 3.1 snap for a test or POC environment</h2></a>

You can initialise MAAS as a compact version for testing.  To achieve this, just use the `--help` flag with `maas init` to get relevant instructions.

<a href="#heading--init-maas-production-3-1"><h2 id="heading--init-maas-production-3-1">Initialise MAAS for a production configuration</h2></a>

To install MAAS in a production configuration:

1. Install PostgreSQL on the machine where you want to keep the database:

```nohighlight
sudo apt update -y
sudo apt install -y postgresql
```

2. Make sure you have a suitable PostgreSQL user; in the command that follows, substitute `$MAAS_DBUSER` for your desired database username, and `$MAAS_DBPASS` for the intended password for that username. 

```nohighlight
sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"
```

3. Create the MAAS database, substituing `$MAAS_DBNAME` for your desired MAAS database name.

```nohighlight
sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"
```

4. Edit `/etc/postgresql/10/main/pg_hba.conf` to add a line for the newly created database, again subtituting the variables with your desired values, as used above.

```nohighlight
host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5
```

5. You can then initialise MAAS:

```nohighlight
sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"
```

You can substitute `localhost` for `$HOSTNAME` if you're running PostgreSQL on the same host as MAAS.
[/tab]
[tab version="v3.1 Packages"]
<a href="#heading--fresh-install-3-1-packages"><h2 id="heading--fresh-install-3-1-packages">How to do a fresh install of MAAS 3.1 from packages</h2></a>

To install MAAS 3.1 from packages:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Add the MAAS 3.1 PPA to your `apt` repository paths:

```nohighlight
sudo apt-add-repository ppa:maas/3.1
```

3. Update your `apt` repository lists:

```nohighlight
sudo apt update
```
	
4. Install MAAS with the following command:

```nohighlight
sudo apt-get -y install maas
```
5. Choose "Y" if asked about whether to continue with the install.

<a href="#heading--Distributed-environment-3-1"><h4 id="heading--Distributed-environment-3-1">Distributed environment</h4></a>

For a more distributed environment, do the following:

1. On the machine designated as your region controller, execute this command:


``` bash
sudo apt install maas-region-controller
```

2. On the machine designated as your rack controller, execute these two commands:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register
```

These two steps will lead you through two similar <code>apt</code> install sequences.

<a href="#heading--create-a-maas-user-3-1"><h2 id="heading--create-a-maas-user-3-1">How to create a MAAS 3.1 user</h2></a>

To create a MAAS 3.1 user, execute the following steps:

1. Create a MAAS administrator user to access the web UI:


``` nohighlight
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

`$PROFILE` is the administrative MAAS username you wish to create.  `$EMAIL_ADDRESS` is an email address you may type in at random (currently, MAAS does not use this email address).  The `createadmin` option will ask for an SSH key.

2. To use an SSH key associated with your launchpad accounts, enter `lp:$USERNAME` (substitute your LP username for `$USERNAME`). 

3. Alternatively, to use an SSH key associated with your github account, enter `gh:$USERNAME` (substitute your github username for `$USERNAME`)
[/tab]
[tab version="v3.0 Snap"]
<a href="#heading--fresh-install-3-0-snap"><h2 id="heading--fresh-install-3-0-snap">How to do a fresh snap install of MAAS 3.0</h2></a>

To install MAAS 3.0 from a snap:

1. Enter the following command:

```nohighlight
sudo snap install --channel=3.0/stable maas
```

2. Enter your user password.

The snap will download and install from the 3.0 stable channel.

<a href="#heading--init-maas-poc-3-0"><h2 id="heading--init-maas-poc-3-0">How to initialise MAAS 3.0 snap for a test or POC environment</h2></a>

To initialise MAAS as a compact version for testing, once MAAS is installed, use the `--help` flag with `maas init` to get relevant instructions.

<a href="#heading--init-maas-production-3-0"><h2 id="heading--init-maas-production-3-0">Initialise MAAS for a production configuration</h2></a>

To install MAAS in a production configuration:

1. You will need to install PostgreSQL on the machine where you want to keep the database.

```nohighlight
sudo apt update -y
sudo apt install -y postgresql
```

2. Make sure you have a suitable PostgreSQL user, where `$MAAS_DBUSER` is your desired database username, and `$MAAS_DBPASS` is the intended password for that username.

```nohighlight
sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"
```

3. Create the MAAS database with the following command, where `$MAAS_DBNAME` is your desired name for the MAAS database:

```nohighlight
sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"
```

4. Edit `/etc/postgresql/10/main/pg_hba.conf` and add a line for the newly created database, replacing the variables with actual names

```nohighlight
host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5
```

5. Initialise MAAS via the following command:

```nohighlight
sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"
```

Use `localhost` for `$HOSTNAME` if you're running PostgreSQL on the same box as MAAS.
[/tab]
[tab version="v3.0 Packages"]
<a href="#heading--fresh-install-3-0-packages"><h2 id="heading--fresh-install-3-0-packages">How to do a fresh install of MAAS 3.0 from packages</h2></a>

To install MAAS 3.0 from packages:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Add the MAAS 3.0 PPA to your `apt` repository paths:

```nohighlight
sudo apt-add-repository ppa:maas/3.0
```

3. Update your `apt` repository lists:

```nohighlight
sudo apt update
```
	
4. Install MAAS with the following command:

```nohighlight
sudo apt-get -y install maas
```
5. Choose "Y" if asked about whether to continue with the install.

<a href="#heading--Distributed-environment-3-0"><h4 id="heading--Distributed-environment-3-0">Distributed environment</h4></a>

For a more distributed environment, you can place the region controller on one machine:

``` bash
sudo apt install maas-region-controller
```

and the rack controller on another:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register
```

These two steps will lead you through two similar <code>apt</code> install sequences.

<a href="#heading--create-a-maas-user-3-0"><h2 id="heading--create-a-maas-user-3-0">How to create a MAAS 3.0 user</h2></a>

To create a MAAS 3.0 user, execute the following steps:

1. Create a MAAS administrator user to access the web UI:


``` nohighlight
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

`$PROFILE` is the administrative MAAS username you wish to create.  `$EMAIL_ADDRESS` is an email address you may type in at random (currently, MAAS does not use this email address).  The `createadmin` option will ask for an SSH key.

2. To use an SSH key associated with your launchpad accounts, enter `lp:$USERNAME` (substitute your LP username for `$USERNAME`). 

3. Alternatively, to use an SSH key associated with your github account, enter `gh:$USERNAME` (substitute your github username for `$USERNAME`)
[/tab]
[tab version="v2.9 Snap"]
<a href="#heading--fresh-install-2-9-snap"><h2 id="heading--fresh-install-2-9-snap">How to do a fresh snap install of MAAS 2.9</h2></a>

To install MAAS 2.9 from a snap:

1. Enter the following command:

```nohighlight
sudo snap install --channel=2.9 maas
```

2. Enter your user password.

The snap will download and install from the 2.9 stable channel.

<a href="#heading--init-maas-poc-2-9"><h2 id="heading--init-maas-poc-2-9">How to initialise MAAS 2.9 snap for a test or POC environment</h2></a>

To initialise MAAS as a compact version for testing, once MAAS is installed, use the `--help` flag with `maas init` to get relevant instructions.

<a href="#heading--init-maas-production-2-9"><h2 id="heading--init-maas-production-2-9">Initialise MAAS for a production configuration</h2></a>

To install MAAS in a production configuration:

1. You will need to install PostgreSQL on the machine where you want to keep the database.

```nohighlight
sudo apt update -y
sudo apt install -y postgresql
```

2. Make sure you have a suitable PostgreSQL user, where `$MAAS_DBUSER` is your desired database username, and `$MAAS_DBPASS` is the intended password for that username.

```nohighlight
sudo -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"
```

3. Create the MAAS database with the following command, where `$MAAS_DBNAME` is your desired name for the MAAS database:

```nohighlight
sudo -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"
```

4. Edit `/etc/postgresql/10/main/pg_hba.conf` and add a line for the newly created database, replacing the variables with actual names

```nohighlight
host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5
```

5. Initialise MAAS via the following command:

```nohighlight
sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"
```

Use `localhost` for `$HOSTNAME` if you're running PostgreSQL on the same box as MAAS.
[/tab]
[tab version="v2.9 Packages"]
<a href="#heading--fresh-install-2-9-packages"><h2 id="heading--fresh-install-2-9-packages">How to do a fresh install of MAAS 2.9 from packages</h2></a>

To install MAAS 2.9 from packages:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Add the MAAS 2.9 PPA to your `apt` repository paths:

```nohighlight
sudo apt-add-repository ppa:maas/2.9
```

3. Update your `apt` repository lists:

```nohighlight
sudo apt update
```
	
4. Install MAAS with the following command:

```nohighlight
sudo apt-get -y install maas
```
5. Choose "Y" if asked about whether to continue with the install.

<a href="#heading--Distributed-environment-2-9"><h4 id="heading--Distributed-environment-2-9">Distributed environment</h4></a>

For a more distributed environment, you can place the region controller on one machine:

``` bash
sudo apt install maas-region-controller
```

and the rack controller on another:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register
```

These two steps will lead you through two similar <code>apt</code> install sequences.

<a href="#heading--create-a-maas-user-2-9"><h2 id="heading--create-a-maas-user-2-9">How to create a MAAS 2.9 user</h2></a>

To create a MAAS 3.0 user, execute the following steps:

1. Create a MAAS administrator user to access the web UI:


``` nohighlight
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

`$PROFILE` is the administrative MAAS username you wish to create.  `$EMAIL_ADDRESS` is an email address you may type in at random (currently, MAAS does not use this email address).  The `createadmin` option will ask for an SSH key.

2. To use an SSH key associated with your launchpad accounts, enter `lp:$USERNAME` (substitute your LP username for `$USERNAME`). 

3. Alternatively, to use an SSH key associated with your github account, enter `gh:$USERNAME` (substitute your github username for `$USERNAME`)
[/tab]
[/tabs]

<a href="#heading--service-status"><h2 id="heading--service-status">How to check the status of MAAS services</h2></a>

To check the status of running services, enter:

```nohighlight
sudo maas status
```

Typical output looks like this:

```nohighlight
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
```
Your mileage may vary.

<a href="#heading--reinitialising-maas"><h3 id="heading--reinitialising-maas">How to re-initialise MAAS</h3></a>

To switch a machine from from `rack` to `region`:
 
```nohighlight
sudo maas init region
```

<a href="#heading--additional-init-options"><h2 id="heading--additional-init-options">How to list additional MAAS initialisation options</h2></a>

The `init` command can takes optional arguments. To list them, as well as read a brief description of each, you can enter:

```nohighlight
sudo maas init --help
```

<a href="#heading--configure-maas"><h2 id="heading--configure-maas">How to configure MAAS</h2></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
Once you've successfully installed MAAS, you can access it at this address:

```
http://${API_HOST}:5240/MAAS
```

where `$API_HOST` is the hostname or IP address of the region API server, which was set during installation.  You will see a screen like this:</p>

<a href="https://discourse.maas.io/uploads/default/original/1X/efd8e3f150dfec28114c452c12e24e320848e075.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/efd8e3f150dfec28114c452c12e24e320848e075.jpeg"></a> 

Log in at the prompts, with the login information you created when initialising MAAS.

<a href="#heading--configuration"><h3 id="heading--configuration">Configuration</h3></a>

After a fresh MAAS installation, the web UI presents a couple of welcome screens.  From these screens, you can set many system-wide options, including connectivity, image downloads, and authentication keys:

<a href="https://discourse.maas.io/uploads/default/original/1X/337aa15e178b14b0ba9a0646953268bf7adac0bb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/337aa15e178b14b0ba9a0646953268bf7adac0bb.jpeg"></a>  

Your main concerns for this experiment are the DNS forwarder, the Ubuntu image import section, and the SSH public key, though you might want to set the region name to something memorable, since this text will appear at the bottom of every MAAS screen in this install domain. Set the DNS forwarder to something obvious, e.g., `8.8.8.8`, Google’s DNS server.  Set this to your own internal DNS server if you know the IP address.

<a href="https://discourse.maas.io/uploads/default/original/1X/f9751eb857dcd0c124783edeb1aaf87b8b538127.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/f9751eb857dcd0c124783edeb1aaf87b8b538127.jpeg"></a>  

Select an Ubuntu image to import, noting that you may be required to select at least one LTS version, depending upon the version of MAAS that snap installed.  In this example, we've already chosen an image, and downloading is partially complete.

<a href="https://discourse.maas.io/uploads/default/original/1X/6445cde5ffc1e237a1e6d85d280f451bc0b2ab92.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/6445cde5ffc1e237a1e6d85d280f451bc0b2ab92.jpeg"></a>  

When you click on “Continue,” the screen will shift to a screen labelled, “SSH keys for admin:”  

<a href="https://discourse.maas.io/uploads/default/original/1X/dbdcdce7c8f3b7181f894bdfe987758e0c8635fc.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/dbdcdce7c8f3b7181f894bdfe987758e0c8635fc.jpeg"></a> 

In the source drop-down, select “Launchpad,” “Github,” or “Upload.”  If you choose one of the first two, you will need to enter your username for that service.  For example, if you want to upload your SSH public key from Launchpad, you would enter:

```nohighlight
lp:<username>
```

<a href="https://discourse.maas.io/uploads/default/original/1X/0e4cbf7c8fae3f21664a4d5fe8d0f90785dd6859.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0e4cbf7c8fae3f21664a4d5fe8d0f90785dd6859.jpeg"></a> 

Likewise, if you want to upload your github public SSH key, you would enter:

```nohighlight
gh:<username>
```

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
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
Once you've successfully installed MAAS (regardless of method), you can login to the MAAS CLI via the following process:

1. Generate the API-key for the login you're going to use:

```
sudo maas apikey --username=$PROFILE > api-key-file
```

Replace `$PROFILE` with whatever username you set during the `createadmin` part of the install process.  

2. Login with the following command:

```
maas login $PROFILE $MAAS_URL < api-key-file
```

Substitute `$MAAS_URL` with the URL that was returned to you when you initialised MAAS, for example, `192.168.43.251:5240/MAAS`.  

3. Decide what's next with the CLI help:

```
maas admin --help
```

<a href="#heading--configuration"><h3 id="heading--configuration">Configuration</h3></a>

Configuring MAAS consists of four broad steps:

1. Set upstream DNS (8.8.8.8 is always a reliable value):

```
maas $PROFILE maas set-config name=upstream_dns value="8.8.8.8"
```

2. Add a public SSH key to a MAAS user account:

```
maas $PROFILE sshkeys create "key=$SSH_KEY"
```

3. See what images you may have already downloaded:

```
maas $PROFILE boot-resources read | jq -r '.[] | "\(.name)\t\(.architecture)"'
```

4. Selecting it for download (e.g., "trusty" in this example):

```
maas $PROFILE boot-source-selections create 1 os="ubuntu" release="trusty" arches="amd64" subarches="*"  labels="*"
```

5. Import your selected images:

```
maas admin boot-resources import
```

6. Identify a valid fabric ID for DHCP (returns `"fabric_id": $FABRIC_ID,`):

```
maas $PROFILE subnet read $SUBNET_CIDR | grep fabric_id
```
7. Find the name of the primary rack controller:

```
maas $PROFILE rack-controllers read | grep hostname | cut -d '"' -f 4
```

8. reate an IP range for DHCP (in this case, a dynamic range):

```
maas $PROFILE ipranges create type=dynamic start_ip=$START_IP end_ip=$END_IP
```

7. Use this collected information to turn on DHCP:

```
maas $PROFILE vlan update $FABRIC_ID untagged dhcp_on=True primary_rack=$RACK_CONTR_HOSTNAME
```
[/tab]
[/tabs]
