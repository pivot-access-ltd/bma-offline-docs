<!-- "How to do a fresh install of MAAS" -->

MAAS is relatively easy to install and configure.  Let's give it a try.

[tabs]
[tab version="v3.3 Snap"]
[note]
PostgreSQL 12 is deprecated with the release of MAAS 3.3, in favour of PostgreSQL 14. Support for PostgreSQL 12 will be discontinued in MAAS 3.4.
[/note]
To install MAAS 3.3 from a snap:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Enter the following command:

```nohighlight
sudo snap install --channel=3.3 maas
```

3. Enter your account password.

At this point, the snap will download and install from the 3.3 channel.
[/tab]
[tab version="v3.3 Packages"]
[note]
PostgreSQL 12 is deprecated with the release of MAAS 3.3, in favour of PostgreSQL 14. Support for PostgreSQL 12 will be discontinued in MAAS 3.4.
[/note]
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

[/tab]
[tab version="v3.2 Snap"]
To install MAAS 3.2 from a snap:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Enter the following command:

```nohighlight
sudo snap install --channel=3.2 maas
```

3. Enter your account password.

At this point, the snap will download and install from the 3.2 channel.

[/tab]
[tab version="v3.2 Packages"]
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
[/tab]
[tab version="v3.1 Snap"]
To install MAAS 3.1 from a snap:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Install the 3.2 snap:

```nohighlight
sudo snap install --channel=3.1 maas
```

3. Enter your account password. 

The snap will download and install from the 3.1 channel.
[/tab]
[tab version="v3.1 Packages"]
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
[/tab]
[tab version="v3.0 Snap"]
To install MAAS 3.0 from a snap:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.


2. Enter the following command:

```nohighlight
sudo snap install --channel=3.0 maas
```

3. Enter your user password.

The snap will download and install from the 3.0 channel.
[/tab]
[tab version="v3.0 Packages"]
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
[/tab]
[tab version="v2.9 Snap"]
To install MAAS 2.9 from a snap:

1. Check the [MAAS installation requirements](/t/maas-installation-requirements/6233) to make sure that your hardware will support MAAS.

2. Enter the following command:

```nohighlight
sudo snap install --channel=2.9 maas
```

3. Enter your user password.

The snap will download and install from the 2.9 stable channel.
[/tab]
[tab version="v2.9 Packages"]
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
[/tab]
[/tabs]

[tabs]
[tab version="v3.3 Snap,v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap"]
<a href="#heading--init-maas-poc"><h2 id="heading--init-maas-poc">How to initialise MAAS for a test or POC</h2></a>

To initialise the MAAS snap in a test/POC configuration, simply use the `--help` flag with `maas init` and follow the instructions.
 
<a href="#heading--init-maas-production-3-3"><h2 id="heading--init-maas-production-3-3">How to initialise MAAS for production</h2></a>

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

3. Create a suitable PostgreSQL user:

```nohighlight
sudo -i -u postgres psql -c "CREATE USER \"$MAAS_DBUSER\" WITH ENCRYPTED PASSWORD '$MAAS_DBPASS'"
```

4. Create the MAAS database:

```nohighlight
sudo -i -u postgres createdb -O "$MAAS_DBUSER" "$MAAS_DBNAME"
```

5. Edit `/etc/postgresql/14/main/pg_hba.conf` and add a line for the newly created database:

```nohighlight
host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5
```

6. Initialise MAAS via the following command:

```nohighlight
sudo maas init region+rack --database-uri "postgres://$MAAS_DBUSER:$MAAS_DBPASS@$HOSTNAME/$MAAS_DBNAME"
```
[/tab]
[tab version="v3.3 Packages,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages"]
<a href="#heading--Distributed-environment"><h2 id="heading--Distributed-environment">How to create a distributed environment</h2></a>

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

<a href="#heading--create-a-maas-user"><h2 id="heading--create-a-maas-user">How to create a MAAS admin user</h2></a>

To create a MAAS administrative user:

1. Create a MAAS administrator user to access the web UI:

``` nohighlight
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```
Subtitute `$PROFILE` is the administrative MAAS username you wish to create.  `$EMAIL_ADDRESS` is an email address you may type in at random (currently, MAAS does not use this email address). The `createadmin` option will cause MAAS to ask for an SSH key.

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

<a href="#heading--reinitialising-maas"><h2 id="heading--reinitialising-maas">How to re-initialise MAAS</h2></a>

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
To configure MAAS for first-time use:

1. Access MAAS at this address, where `$API_HOST` is the hostname or IP address of the region API server, which was set during installation:

```
http://${API_HOST}:5240/MAAS
```
2. Log in at the prompts, with the login information you created when initialising MAAS.

3. On the first welcome screen, set the DNS forwarder to a suitable value, e.g., `8.8.8.8`. This could be your own internal DNS server, if you have one.

4. Select an Ubuntu image to import; you may be required to select at least one LTS version.

5. Click *Continue*; a screen labelled, “SSH keys for admin:” appears.

6. In the *Source* drop-down, select “Launchpad,” “Github,” or “Upload.”  

7. If you want to upload your SSH public key from Launchpad, you would enter the following, where `<username>` is your Launchpad username:

```nohighlight
lp:<username>
```

8. If you want to upload your github public SSH key, you would enter the following, where `<username>` is your GitHub username:

```nohighlight
gh:<username>
```

9. If you want to use your existing public key from your home directory, select *Upload*.

10. Copy your entire public key from `.ssh/id_rsa.pub` (or wherever you may have stored the key).

11. Paste the public key into the block labelled “Public key.”  

12. Press the “Import” button to import this key.

13. You should see a message that MAAS has been successfully set up. Click *Go to the Dashboard* to proceed.

14. Select *Subnets* from the top menu.

15. Choose the VLAN on which you want to enable DHCP.

16. Select *Enable DHCP*.

You should now be able to add, commission, and deploy machines.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
Once you've successfully installed MAAS (regardless of method), you can login to the MAAS CLI via the following process:

1. Generate the API-key for the login you're going to use, replacing `$PROFILE` with whatever username you set during the `createadmin` part of the install process.

```
sudo maas apikey --username=$PROFILE > api-key-file
```


2. Login with the following command, substituting `$MAAS_URL` with the URL that was returned to you when you initialised MAAS, for example, `192.168.43.251:5240/MAAS`.  :

```
maas login $PROFILE $MAAS_URL < api-key-file
```

3. Set upstream DNS (8.8.8.8 is always a reliable value):

```
maas $PROFILE maas set-config name=upstream_dns value="8.8.8.8"
```

4. Add a public SSH key to a MAAS user account:

```
maas $PROFILE sshkeys create "key=$SSH_KEY"
```

5. See what images you may have already downloaded:

```
maas $PROFILE boot-resources read | jq -r '.[] | "\(.name)\t\(.architecture)"'
```

6. Selecting it for download (e.g., "trusty" in this example):

```
maas $PROFILE boot-source-selections create 1 os="ubuntu" release="trusty" arches="amd64" subarches="*"  labels="*"
```

7. Import your selected images:

```
maas admin boot-resources import
```

8. Identify a valid fabric ID for DHCP (returns `"fabric_id": $FABRIC_ID,`):

```
maas $PROFILE subnet read $SUBNET_CIDR | grep fabric_id
```
8. Find the name of the primary rack controller:

```
maas $PROFILE rack-controllers read | grep hostname | cut -d '"' -f 4
```

9. reate an IP range for DHCP (in this case, a dynamic range):

```
maas $PROFILE ipranges create type=dynamic start_ip=$START_IP end_ip=$END_IP
```

10. Use this collected information to turn on DHCP:

```
maas $PROFILE vlan update $FABRIC_ID untagged dhcp_on=True primary_rack=$RACK_CONTR_HOSTNAME
```

You should now be able to add, commission, and deploy machines.
[/tab]
[/tabs]