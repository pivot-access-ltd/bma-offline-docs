||2.7|2.8|2.9|3.0|
|-----:|:-----:|:-----:|:-----:|:-----:|
Snap|[CLI](/t/maas-installation-snap-2-7-cli/3318) ~ [UI](/t/maas-installation-snap-2-7-ui/3319)|[CLI](/t/maas-installation-snap-2-8-cli/3320) ~ [UI](/t/maas-installation-snap-2-8-ui/3321)|[CLI](/t/maas-installation-snap-2-9-cli/3322) ~ [UI](/t/maas-installation-snap-2-9-ui/3323)|[CLI](/t/maas-installation-snap-3-0-cli/4001) ~ [UI](/t/maas-installation-snap-3-0-ui/4002)|
Packages|[CLI](/t/maas-installation-deb-2-7-cli/3324) ~ [UI](/t/maas-installation-deb-2-7-ui/3325)|[CLI](/t/maas-installation-deb-2-8-cli/3326) ~ [UI](/t/maas-installation-deb-2-8-ui/3327)|[CLI](/t/maas-installation-deb-2-9-cli/3328) ~ [UI](/t/maas-installation-deb-2-9-ui/3329)|[CLI](/t/maas-installation-deb-3-0-cli/4003) ~ [UI](/t/maas-installation-deb-3-0-ui/4004)|

This article will show you how to:

1. [Determine the minimum hardware requirements for MAAS](#heading--top-maas-requirements)
2. [Install MAAS in various configurations and verify your work](#heading--top-maas-install)
3. [Configure your MAAS installation and get it running](#heading--top-maas-config)

All of the headings in this page are anchored and linked, so that you can bookmark them.  Feel free to use these headings to customize your own bookmark folder on your browser toolbar: this may save you time working with MAAS later.

<a href="#heading--top-maas-requirements"><h2 id="heading--top-mass-requirements">MAAS hardware requirements</h2></a>

The minimum requirements for the machines that run MAAS vary widely depending on local implementation and usage.  Below, you will find resource estimates based on MAAS components and operating system (Ubuntu Server). We consider both a test configuration (for proof of concept) and a production environment.

#### Two questions you might have about hardware requirements:

1. [What are the requirements for a test environment?](#heading--test-environment)
2. [What are the requirements for a production environment?](#heading--production-environment)

<a href="#heading--test-environment"><h3 id="heading--test-environment">Requirements for a test environment</h3></a>

Here is a proof-of-concept scenario, with all MAAS components installed on a single host. This scenario assumes two complete sets of images (latest two Ubuntu LTS releases) for a single architecture (amd64).

| | Memory (MB) | CPU (GHz) | Disk (GB) |
|:-----|-----:|-----:|-----:|
| [Region controller](/t/concepts-and-terms/785#heading--controllers) (minus PostgreSQL) | 512 | 0.5 | 5 |
| PostgreSQL | 512 | 0.5 | 5 |
| [Rack controller](/t/concepts-and-terms/785#heading--controllers") | 512 | 0.5 | 5 |
| Ubuntu Server (including logs)| 512 | 0.5 | 5 |

Based on this table, the approximate requirements for this scenario are 2 GB memory, 2 GHz CPU, and 20 GB of disk space.

<a href="#heading--production-environment"><h3 id="heading--production-environment">Requirements for a production environment</h3></a>

Here is a production scenario designed to handle a high number of sustained client connections. This scenario implements both high availability (region and rack) and load balancing (region). MAAS reserves extra space for images (database and rack controller), while some images, such as those for Microsoft Windows, may require a lot more -- so plan accordingly.

| | Memory (MB) | CPU (GHz) | Disk (GB) |
|:-----|-----:|-----:|-----:|
| [Region controller](/t/concepts-and-terms/785#heading--controllers) (minus PostgreSQL) | 2048 | 2.0 | 5 |
| PostgreSQL | 2048 | 2.0 | 20 |
| [Rack controller](/t/concepts-and-terms/785#heading--controllers") | 2048 | 2.0 | 20 |
| Ubuntu Server (including logs)| 512 | 0.5 | 5 |

So, based on the above, the approximate requirements for this scenario are:

1. A region controller (including PostgreSQL) installed on one host, with 4.5 GB memory, 4.5 GHz CPU, and 45 GB of disk space.
2. A duplicate region controller (including PostgreSQL) on a second host, also with 4.5 GB memory, 4.5 GHz CPU, and 45 GB of disk space.
3. A rack controller installed on a third host, with 2.5 GB memory, 2.5 GHz CPU, and 40 GB of disk space.
4. A duplicate rack controller on a fourth host, also with 2.5 GB memory, 2.5 GHz CPU, and 40 GB of disk space.

<!-- deb-2-7-cli
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3012) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2588).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 deb-2-7-cli -->

<!-- deb-2-7-ui
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3013) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2689).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 deb-2-7-ui -->

<!-- deb-2-8-cli
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3014) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2690).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 deb-2-8-cli -->

<!-- deb-2-8-ui
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3015) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2691).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 deb-2-8-ui -->

<!-- deb-2-9-cli
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3016) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2692).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 deb-2-9-cli -->

<!-- deb-2-9-ui
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3017) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2693).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 deb-2-9-ui -->

<!-- deb-3-0-cli
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/4071) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/3947).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 deb-3-0-cli -->

<!-- deb-3-0-ui
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/4070) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/3948).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 deb-3-0-ui -->

<!-- snap-2-7-cli
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3006) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2682).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 snap-2-7-cli -->

<!-- snap-2-7-ui
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3007) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2683).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 snap-2-7-ui -->

<!-- snap-2-8-cli
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3008) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2684).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 snap-2-8-cli -->

<!-- snap-2-8-ui
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3009) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2685).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 snap-2-8-ui -->

<!-- snap-2-9-cli
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3010) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2686).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 snap-2-9-cli -->

<!-- snap-2-9-ui
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/3011) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/2687).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 snap-2-9-ui -->

<!-- snap-3-0-cli
[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/4069) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/3945).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)
 snap-3-0-cli -->

[note]
The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-management/4070) for more details.
[/note]

Some examples of factors that influence hardware specifications include:

1. the number of connecting clients (client activity)
2. how you decide to distribute services
3. whether or not you use [high availability/load balancing](/t/high-availability/3946).
4. the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)

Also, this discussion does not take into account a possible local image mirror, which would be a large consumer of disk space.

One rack controller should only service 1000 machines or less, regardless of how you distribute them across subnets. There is no load balancing at the rack level, so you will need additional, independent rack controllers. Each controller must service its own subnet(s).

<a href="#heading--top-maas-install"><h2 id="heading--top-maas-install">How to install MAAS</h2></a>

<!-- snap-2-7-ui snap-2-7-cli 
MAAS 2.7 can be installed as a snap. This section will walk you through the installation.

[Snaps](https://snapcraft.io/docs) are containerised software packages. To install MAAS from a snap simply enter the following:

``` bash
sudo snap install maas --channel=2.7
```

After entering your password, the snap will download and install from the 2.7 channel. However, MAAS needs initialising before it's ready to go.

<a href="#heading--initialisation"><h3 id="heading--initialisation">Initialisation</h3></a>

The next step involves initialising MAAS with a *run mode*. Selecting one of the following modes dictates what services will run on the local system:

| Mode          | Region | Rack | Database | Description                           |
|---------------|--------|------|----------|---------------------------------------|
| `all`*        | X      | X    | X        | All services (see warning below)      |
| `region`      | X      |      |          | Region API server only                |
| `rack`        |        | X    |          | Rack controller only                  |
| `region+rack` | X      | X    |          | Region API server and rack controller |
| `none`        |        |      |          | Reinitialises MAAS and stops services |

[note type="Warning" status="all mode being deprecated"]
Configuring the MAAS snap in "all" mode will be [deprecated in MAAS version 2.8.0 and removed in MAAS version 2.9.0](https://maas.io/deprecations/MD1).
[/note]

To initialise MAAS and select a run mode, use the `maas init` command with the *--mode* argument.

<a href="#heading--example"><h4 id="heading--example">Example</h4></a>

The following demonstrates the `all` mode, a popular initialisation choice for MAAS:

``` bash
sudo maas init --mode all
```

A dialog will appear that will gather some basic information:

``` no-highlight
MAAS URL [default=http://10.55.60.1:5240/MAAS]: http://192.168.122.1:5240/MAAS
Create first admin account:       
Username: admin
Password: ******
Again: ******
Email: admin@example.com
Import SSH keys [] (lp:user-id or gh:user-id): lp:petermatulis
```

[note]
You will use the username and password to access the web UI.  If you enter a [Launchpad](https://launchpad.net/) or [GitHub](https://github.com) account name with associated SSH key, MAAS will import them automatically.
[/note]

<a href="#heading--maas-url"><h4 id="heading--maas-url">MAAS URL</h4></a>

All run modes (except `none`) prompt for a MAAS URL, interpreted differently depending on the mode:

-   `all`, `region+rack`: Used to create a new region controller as well as to tell the rack controller how to find the region controller.
-   `region`: Used to create a new region controller.
-   `rack`: Used to locate the region controller.

<a href="#heading--shared-secret"><h3 id="heading--shared-secret">Shared secret</h3></a>

The 'rack' and 'region+rack' modes will additionally ask for a shared secret that will allow the new rack controller to register with the region controller.

<a href="#heading--reinitialising-maas"><h4 id="heading--reinitialising-maas">Reinitialising MAAS</h4></a>

Re-initalising MAAS is useful to reset MAAS when the configuration changes.  For example, if you are hosting MAAS on a system that gets its IP from DHCP, and the lease sometimes gets renewed, your base MAAS IP address will need to be update.  Likewise, if you switch the MAAS configuration from `rack` to `region`, you'll need to re-initialise as well. 

To re-initialise MAAS:

``` bash
sudo maas init --mode region
```

<a href="#heading--additional-init-options"><h4 id="heading--additional-init-options">Additional `init` options</h4></a>

The `init` command can take a number of optional arguments. To list them all as well as read a brief description of each:

``` bash
sudo maas init --help
```

<a href="#heading--configuration-verification"><h3 id="heading--configuration-verification">Configuration verification</h3></a>

After a *snap* installation of MAAS, you can verify the currently-running configuration with:

``` bash
sudo maas config
```

Sample output (for mode 'all'):

``` no-highlight
Mode: all
Settings:
maas_url=http://192.168.122.1:5240/MAAS
```

<a href="#heading--service-statuses"><h3 id="heading--service-statuses">Service statuses</h3></a>

You can check the status of running services with:

``` bash
sudo maas status
```

Sample output (for mode 'all'):

``` no-highlight
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
snap-2-7-ui snap-2-7-cli -->


<!-- snap-2-7-ui
With MAAS installed and initialised, you can now open the web UI in your browser and begin your [Configuration journey](#heading--top-maas-config).
snap-2-7-ui -->

<!-- snap-2-7-cli
With MAAS installed and initialised, you can now open the web UI in your browser and begin your [Configuration journey](#heading--top-maas-config).
snap-2-7-cli -->

<!-- snap-2-8-ui snap-2-8-cli
MAAS can be installed in either of two configurations:  test or production.  The test configuration uses a small PostgreSQL database (in a separate snap), designed for use with MAAS. The full-up production configuration uses a separate PostgreSQL database for performance and scalability.  This article will walk you through both install methods.

#### Thirteen questions you may have about installing MAAS:

1. [How do I install (but not initialise) the MAAS snap?](#heading--install-maas-snap)
2. [How do I upgrade my 2.7 snap to version 2.8?](#heading--upgrade-maas-snap)
3. [What are MAAS initialisation modes?](#heading--maas-init-modes)
4. [How do I initialise MAAS for a test or proof-of-concept configuration?](#heading--init-poc)
5. [How do I initialise MAAS for a production configuration?](#heading--init-prod)
6. [How do I migrate an existing snap install?](/t/tips-tricks-and-traps/1506#heading--migrate-maas)
7. [What if I want to manually export the MAAS database to an existing PostgreSQL server?](/t/tips-tricks-and-traps/1506#heading--manual-export)
8. [How can I check the service status of my MAAS configuration?](#heading--service-status)
9. [How do I re-initialise MAAS, if I want to?](#heading--reinitialising-maas)
10. [How can I discover additional init options?](#heading--additional-init-options)
11. [Give me an example of initialising MAAS](#heading--example)
12. [Tell me about the MAAS URL](#heading--maas-url)
13. [Tell me about the shared secret](#heading--shared-secret)

[note]
If you have installed `bind9` or have it running, you will need to uninstall it before installing MAAS.  You can check with `ps aux | grep named` to see if it's running. The `bind9` daemon interferes with MAAS operation and creates a number of unusual, hard-to-debug errors -- but don't worry, MAAS provides DNS and can work with existing DNS servers.
[/note]

<a href="#heading--install-maas-snap"><h3 id="heading--install-maas-snap">Installing MAAS from the snap</h3></a>

[Snaps](https://snapcraft.io/docs) are containerised software packages. To install MAAS from a snap simply enter the following:

    $ sudo snap install maas --channel=2.8

After entering your password, the snap will download and install from the 2.8 channel -- though MAAS needs initialising before it's ready to go.

<a href="#heading--upgrade-maas-snap"><h3 id="heading--upgrade-maas-snap">Upgrading MAAS from 2.7</h3></a>

If you want to upgrade from a 2.7 snap to 2.8, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=2.8 maas

After entering your password, the snap will refresh from the 2.8 channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.

<a href="#heading--maas-init-modes"><h3 id="heading--maas-init-modes">MAAS initialisation modes</h3></a>

MAAS supports the following modes, which dictate what services will run on the local system:

| Mode          | Region | Rack | Database | Description                           |
|---------------|--------|------|----------|---------------------------------------|
| `all`*        | X      | X    | X        | Deprecated (see warning below)        |
| `region`      | X      |      |          | Region API server only                |
| `rack`        |        | X    |          | Rack controller only                  |
| `region+rack` | X      | X    |          | Region API server and rack controller |
| `none`        |        |      |          | Reinitialises MAAS and stops services |

[note type="Warning" status="all mode being deprecated"]
The MAAS initialisation mode "all" is [deprecated in MAAS version 2.8.0 and will be removed in MAAS version 2.9.0](https://maas.io/deprecations/MD1).
[/note]

<a href="#heading--init-poc"><h3 id="heading--init-poc">Initialising MAAS as a test configuration</h3></a>

We want to provide a more compact version for those who may be testing MAAS.  To achieve this, we're providing a separate snap, called `maas-test-db`, which provides a PostgreSQL database for use in testing and evaluating MAAS.   The following instructions will help you take advantage of this test configuration.

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

    $ maas-test-db.psql
    psql (10.6)
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

<a href="#heading--configuration-verification"><h3 id="heading--configuration-verification">Configuration verification</h3></a>

After a snap installation of MAAS, you can verify the currently-running configuration with:

    sudo maas config

<a href="#heading--init-prod"><h3 id="heading--init-prod">Initialise MAAS for a production configuration</h3></a>

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

<a href="#heading--service-status"><h3 id="heading--service-status">Checking MAAS service status</h3></a>

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

snap-2-8-cli snap-2-8-ui -->

<!-- snap-2-8-cli
With MAAS installed and initialised, you can now open the web UI in your browser and begin your [Configuration journey](#heading--top-maas-config).
 snap-2-8-cli -->

<!-- snap-2-8-ui
With MAAS installed and initialised, you can now open the web UI in your browser and begin your [Configuration journey](#heading--top-maas-config).
 snap-2-8-ui -->

<!-- snap-2-8-cli snap-2-8-ui
<a href="#heading--example"><h3 id="heading--example">Example of MAAS initialisation</h3></a>

The following demonstrates the `region+rack` mode, a popular initialisation choice for MAAS:

    sudo maas init region+rack

`maas` will ask for the MAAS URL:

    MAAS URL [default=http://10.55.60.1:5240/MAAS]: http://192.168.122.1:5240/MAAS

If you also need to create an admin user, you can use:

    sudo maas createadmin

which takes you through the following exchange:

    Create first admin account:       
    Username: admin
    Password: ******
    Again: ******
    Email: admin@example.com
    Import SSH keys [] (lp:user-id or gh:user-id): lp:petermatulis

[note]
You will use the username and password created above to access the web UI.  If you enter a [Launchpad](https://launchpad.net/) or [GitHub](https://github.com) account name with associated SSH key, MAAS will import them automatically.
[/note]

<a href="#heading--maas-url"><h3 id="heading--maas-url">MAAS URL</h3></a>

All run modes (except `none`) prompt for a MAAS URL, interpreted differently depending on the mode:

-   `region`: Used to create a new region controller.
-   `rack`: Used to locate the region controller.

<a href="#heading--shared-secret"><h3 id="heading--shared-secret">Shared secret</h3></a>

The 'rack' and 'region+rack' modes will additionally ask for a shared secret that will allow the new rack controller to register with the region controller.

<a href="#heading--reinitialising-maas"><h3 id="heading--reinitialising-maas">Reinitialising MAAS</h3></a>

It is also possible to re-initialise MAAS to switch modes.  For example, to switch from `rack` to `region`:
 
    sudo maas init region

<a href="#heading--additional-init-options"><h3 id="heading--additional-init-options">Additional `init` options</h3></a>

The `init` command can takes optional arguments. To list them, as well as read a brief description of each, you can enter:

    sudo maas init --help

snap-2-8-ui snap-2-8-cli -->

<!-- snap-2-9-ui snap-2-9-cli
MAAS can be installed in either of two configurations:  test or production.  The test configuration uses a small PostgreSQL database (in a separate snap), designed for use with MAAS. The full-up production configuration uses a separate PostgreSQL database for performance and scalability.  This article will walk you through both install methods.

#### Thirteen questions you may have about installing MAAS:

1. [How do I install (but not initialise) the MAAS 2.9 snap?](#heading--install-maas-snap)
2. [How do I upgrade my 2.8 snap to version 2.9?](#heading--upgrade-maas-snap)
3. [What are MAAS initialisation modes?](#heading--maas-init-modes)
4. [How do I initialise MAAS for a test or proof-of-concept configuration?](#heading--init-poc)
5. [How do I initialise MAAS for a production configuration?](#heading--init-prod)
6. [How do I migrate an existing snap install?](/t/tips-tricks-and-traps/1506#heading--migrate-maas)
7. [What if I want to manually export the MAAS database to an existing PostgreSQL server?](/t/tips-tricks-and-traps/1506#heading--manual-export)
8. [How can I check the service status of my MAAS configuration?](#heading--service-status)
9. [How do I re-initialise MAAS, if I want to?](#heading--reinitialising-maas)
10. [How can I discover additional init options?](#heading--additional-init-options)
11. [Give me an example of initialising MAAS](#heading--example)
12. [Tell me about the MAAS URL](#heading--maas-url)
13. [Tell me about the shared secret](#heading--shared-secret)

[note]
If you have installed `bind9` or have it running, you will need to uninstall it before installing MAAS.  You can check with `ps aux | grep named` to see if it's running. The `bind9` daemon interferes with MAAS operation and creates a number of unusual, hard-to-debug errors -- but don't worry, MAAS provides DNS and can work with existing DNS servers.
[/note]

<a href="#heading--install-maas-snap"><h3 id="heading--install-maas-snap">Installing MAAS from the snap</h3></a>

[Snaps](https://snapcraft.io/docs) are containerised software packages. To install MAAS from a snap simply enter the following:

    $ sudo snap install --channel=2.9/stable maas

After entering your password, the snap will download and install from the 2.9 stable channel -- though MAAS needs initialising before it's ready to go.

<a href="#heading--upgrade-maas-snap"><h3 id="heading--upgrade-maas-snap">Upgrading MAAS from 2.8</h3></a>

If you want to upgrade from a 2.8 snap to 2.9, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=2.9/stable maas

After entering your password, the snap will refresh from the 2.9 stable channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.

<a href="#heading--maas-init-modes"><h3 id="heading--maas-init-modes">MAAS initialisation modes</h3></a>

MAAS supports the following modes, which dictate what services will run on the local system:

| Mode          | Region | Rack | Database | Description                           |
|---------------|--------|------|----------|---------------------------------------|
| `region`      | X      |      |          | Region API server only                |
| `rack`        |        | X    |          | Rack controller only                  |
| `region+rack` | X      | X    |          | Region API server and rack controller |
| `none`        |        |      |          | Reinitialises MAAS and stops services |

<a href="#heading--init-poc"><h3 id="heading--init-poc">Initialising MAAS as a test configuration</h3></a>

We want to provide a more compact version for those who may be testing MAAS.  To achieve this, we're providing a separate snap, called `maas-test-db`, which provides a PostgreSQL database for use in testing and evaluating MAAS.   The following instructions will help you take advantage of this test configuration.

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

    $ maas-test-db.psql
    psql (10.6)
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

<a href="#heading--configuration-verification"><h3 id="heading--configuration-verification">Configuration verification</h3></a>

After a snap installation of MAAS, you can verify the currently-running configuration with:

    sudo maas config

<a href="#heading--init-prod"><h3 id="heading--init-prod">Initialise MAAS for a production configuration</h3></a>

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

<a href="#heading--service-status"><h3 id="heading--service-status">Checking MAAS service status</h3></a>

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

snap-2-9-cli snap-2-9-ui -->

<!-- snap-2-9-cli
With MAAS installed and initialised, you can now open the web UI in your browser and begin your [Configuration journey](#heading--top-maas-config).
 snap-2-9-cli -->

<!-- snap-2-9-ui
With MAAS installed and initialised, you can now open the web UI in your browser and begin your [Configuration journey](#heading--top-maas-config).
 snap-2-9-ui -->

<!-- snap-2-9-cli snap-2-9-ui
<a href="#heading--example"><h3 id="heading--example">Example of MAAS initialisation</h3></a>

The following demonstrates the `region+rack` mode, a popular initialisation choice for MAAS:

    sudo maas init region+rack

`maas` will ask for the MAAS URL:

    MAAS URL [default=http://10.55.60.1:5240/MAAS]: http://192.168.122.1:5240/MAAS

If you also need to create an admin user, you can use:

    sudo maas createadmin

which takes you through the following exchange:

    Create first admin account:       
    Username: admin
    Password: ******
    Again: ******
    Email: admin@example.com
    Import SSH keys [] (lp:user-id or gh:user-id): lp:petermatulis

[note]
You will use the username and password created above to access the web UI.  If you enter a [Launchpad](https://launchpad.net/) or [GitHub](https://github.com) account name with associated SSH key, MAAS will import them automatically.
[/note]

<a href="#heading--maas-url"><h3 id="heading--maas-url">MAAS URL</h3></a>

All run modes (except `none`) prompt for a MAAS URL, interpreted differently depending on the mode:

-   `region`: Used to create a new region controller.
-   `rack`: Used to locate the region controller.

<a href="#heading--shared-secret"><h3 id="heading--shared-secret">Shared secret</h3></a>

The 'rack' and 'region+rack' modes will additionally ask for a shared secret that will allow the new rack controller to register with the region controller.

<a href="#heading--reinitialising-maas"><h3 id="heading--reinitialising-maas">Reinitialising MAAS</h3></a>

It is also possible to re-initialise MAAS to switch modes.  For example, to switch from `rack` to `region`:
 
    sudo maas init region

<a href="#heading--additional-init-options"><h3 id="heading--additional-init-options">Additional `init` options</h3></a>

The `init` command can takes optional arguments. To list them, as well as read a brief description of each, you can enter:

    sudo maas init --help

snap-2-9-ui snap-2-9-cli -->

<!-- deb-2-8-cli deb-2-8-ui

<a href="#heading--upgrade-2-7-to-2-8"><h3 id="heading--upgrade-2-7-to-2-8">Upgrading from MAAS 2.7</h3></a>

Upgrading from MAAS 2.7 to MAAS 2.8 is accomplished via the following command sequence:

```
sudo add-apt-repository ppa:maas/2.8
sudo apt update
sudo apt upgrade maas
```

<a href="#heading--install-from-packages"><h3 id="heading--install-from-packages">Install MAAS from packages</h3></a>

You can install a 2.8 stable version of MAAS via the PPA listed on the [MAAS launchpad](https://launchpad.net/~maas), specifically:

-   [ppa:maas/2.8](https://launchpad.net/~maas/+archive/ubuntu/2.8)

To add the 2.8 PPA, type:

``` bash
sudo add-apt-repository -yu ppa:maas/2.8
```

<a href="#heading--installation-scenarios"><h4 id="heading--installation-scenarios">Installation scenarios</h4></a>

The recommended way to set up an initial MAAS environment is to put everything on one machine:

``` bash
sudo apt install maas
```

Executing this command leads you to a list of dependent packages to be installed, and a summary prompt that lets you choose whether to continue with the install:

<a href="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg"></a>

Choosing "Y" proceeds with a standard <code>apt</code> package install.

<h4>Distributed environment</h4> 

<p>For a more distributed environment, you can place the region controller on one machine:</p>

``` bash
sudo apt install maas-region-controller
```

and the rack controller (see [Rack controller](/t/rack-controller/771) for details) on another:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register
```

These two steps will lead you through two similar <code>apt</code> install sequences.

<a href="#heading--creating-a-maas-user"><h4 id="heading--creating-a-maas-user">Creating a MAAS user</h4></a>

<p>Finally, you will need to create a MAAS administrator user to access the web UI:</p>

``` bash
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

<p>For example, the process might go like this:</p>

<a href="https://discourse.maas.io/uploads/default/original/1X/315a94f85b928644037839677fd51871df0c1319.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/315a94f85b928644037839677fd51871df0c1319.jpeg"></a>

<p>The username can be anything. You will also be prompted to supply a password for the user. The command option <code>--password=$PASSWORD</code> can be used to specify one but, depending on your environment, this may pose a security risk.</p>

<div class="p-notification">
<p class="p-notification__response">At this time, MAAS does not make use of the email address. However, it may do so in the future.</p>
</div>

Finally, the <code>createadmin</code> option asks for an SSH key:

<a
href="https://discourse.maas.io/uploads/default/original/1X/472ce8e02273187370565e3d40175fe0ea8e351e.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/472ce8e02273187370565e3d40175fe0ea8e351e.jpeg"></a>

<p>If you have an SSH key associated with your launchpad or github accounts, you can enter the username here to use the associated key.  For launchpad, just enter <code>lp:username</code>, and for github, enter <code>gh:username</code> at the prompt.  In both cases, the actual username has to be supplied after the <code>lp:</code> or <code>gh:</code> prefix. </p>

<p>If you don't have a key associated with either of these services, you will have an opportunity to paste your public key into the MAAS SSH key list, after you've started MAAS for the first time as part of the welcome screens.</p>

<a href="#heading--next-steps"><h4 id="heading--next-steps">Next steps</h4></a>

deb-2-8-cli deb-2-8-ui -->

<!-- deb-2-8-cli
Once you have installed your MAAS environment (region + rack controller) and any possible extra rack controllers(s), you are ready to begin your [Configuration journey](#heading--top-maas-config).
deb-2-8-cli -->

<!-- deb-2-8-ui
Once you have installed your MAAS environment (region + rack controller) and any possible extra rack controllers(s), you are ready to begin your [Configuration journey](#heading--top-maas-config).
deb-2-8-ui -->

<!-- deb-2-7-cli deb-2-7-ui

<a href="#heading--upgrade-2-6-to-2-7"><h3 id="heading--upgrade-2-6-to-2-7">Upgrading from MAAS 2.6</h3></a>

Upgrading from MAAS 2.6 to MAAS 2.7 is accomplished via the following command sequence:

```
sudo add-apt-repository ppa:maas/2.7
sudo apt update
sudo apt upgrade maas
```

<a href="#heading--install-from-packages"><h3 id="heading--install-from-packages">Install MAAS from packages</h3></a>

You can install a 2.7 stable version of MAAS via the PPA listed on the [MAAS launchpad](https://launchpad.net/~maas), specifically:

-   [ppa:maas/2.7](https://launchpad.net/~maas/+archive/ubuntu/2.7)

To add the 2.7 PPA, type:

``` bash
sudo add-apt-repository -yu ppa:maas/2.7
```

<a href="#heading--installation-scenarios"><h4 id="heading--installation-scenarios">Installation scenarios</h4></a>

The recommended way to set up an initial MAAS environment is to put everything on one machine:

``` bash
sudo apt install maas
```

Executing this command leads you to a list of dependent packages to be installed, and a summary prompt that lets you choose whether to continue with the install:

<a href="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0eb9d0ed0711d3a6c548d44cf2ed48f49000a4b5.jpeg"></a>

Choosing "Y" proceeds with a standard <code>apt</code> package install.

<h4>Distributed environment</h4> 

<p>For a more distributed environment, you can place the region controller on one machine:</p>

``` bash
sudo apt install maas-region-controller
```

and the rack controller (see [Rack controller](/t/rack-controller/771) for details) on another:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register
```

These two steps will lead you through two similar <code>apt</code> install sequences.

<a href="#heading--creating-a-maas-user"><h4 id="heading--creating-a-maas-user">Creating a MAAS user</h4></a>

<p>Finally, you will need to create a MAAS administrator user to access the web UI:</p>

``` bash
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

<p>For example, the process might go like this:</p>

<a href="https://discourse.maas.io/uploads/default/original/1X/315a94f85b928644037839677fd51871df0c1319.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/315a94f85b928644037839677fd51871df0c1319.jpeg"></a>

<p>The username can be anything. You will also be prompted to supply a password for the user. The command option <code>--password=$PASSWORD</code> can be used to specify one but, depending on your environment, this may pose a security risk.</p>

<div class="p-notification">
<p class="p-notification__response">At this time, MAAS does not make use of the email address. However, it may do so in the future.</p>
</div>

Finally, the <code>createadmin</code> option asks for an SSH key:

<a
href="https://discourse.maas.io/uploads/default/original/1X/472ce8e02273187370565e3d40175fe0ea8e351e.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/472ce8e02273187370565e3d40175fe0ea8e351e.jpeg"></a>

<p>If you have an SSH key associated with your launchpad or github accounts, you can enter the username here to include the key.  For launchpad, just enter <code>lp:username</code>, and for github, enter <code>gh:username</code> at the prompt.  In both cases, the actual username has to be supplied after the <code>lp:</code> or <code>gh:</code> prefix. </p>

<p>If you don't have a key associated with either of these services, you will have an opportunity to paste your public key into the MAAS SSH key list, after you've started MAAS for the first time as part of the welcome screens.</p>

<a href="#heading--next-steps"><h4 id="heading--next-steps">Next steps</h4></a>

deb-2-7-cli deb-2-7-ui -->

<!-- deb-2-7-cli
Once you have installed your MAAS environment (region + rack controller) and any possible extra rack controllers(s), you are ready to begin your [Configuration journey](#heading--top-maas-config).
deb-2-7-cli -->

<!-- deb-2-7-ui
Once you have installed your MAAS environment (region + rack controller) and any possible extra rack controllers(s), you are ready to begin your [Configuration journey](#heading--top-maas-config).
deb-2-7-ui -->

<!-- deb-2-9-cli deb-2-9-ui
<a href="#heading--upgrade-via-packages"><h3 id="heading--upgrade-via-packages">Upgrade MAAS 2.8 to MAAS 2.9</h3></a>

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
sudo do-release-upgrade --allow-third-parties
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

<a href="#heading--installation-scenarios"><h3 id="heading--installation-scenarios">Installing MAAS 2.9 fresh</h3></a>

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

and the rack controller (see [Rack controller](/t/rack-controller/771) for details) on another:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register
```

These two steps will lead you through two similar <code>apt</code> install sequences.

<a href="#heading--creating-a-maas-user"><h4 id="heading--creating-a-maas-user">Creating a MAAS user</h4></a>

<p>Finally, you will need to create a MAAS administrator user to access the web UI:</p>

``` bash
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

<p>For example, the process might go like this:</p>

<a href="https://discourse.maas.io/uploads/default/original/1X/315a94f85b928644037839677fd51871df0c1319.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/315a94f85b928644037839677fd51871df0c1319.jpeg"></a>

<p>The username can be anything. You will also be prompted to supply a password for the user. The command option <code>--password=$PASSWORD</code> can be used to specify one but, depending on your environment, this may pose a security risk.</p>

<div class="p-notification">
<p class="p-notification__response">At this time, MAAS does not make use of the email address. However, it may do so in the future.</p>
</div>

Finally, the <code>createadmin</code> option asks for an SSH key:

<a
href="https://discourse.maas.io/uploads/default/original/1X/472ce8e02273187370565e3d40175fe0ea8e351e.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/472ce8e02273187370565e3d40175fe0ea8e351e.jpeg"></a>

<p>If you have an SSH key associated with your launchpad or github accounts, you can enter the username here to include the key.  For launchpad, just enter <code>lp:username</code>, and for github, enter <code>gh:username</code> at the prompt.  In both cases, the actual username has to be supplied after the <code>lp:</code> or <code>gh:</code> prefix. </p>

<p>If you don't have a key associated with either of these services, you will have an opportunity to paste your public key into the MAAS SSH key list, after you've started MAAS for the first time as part of the welcome screens.</p>

<a href="#heading--next-steps"><h4 id="heading--next-steps">Next steps</h4></a>

deb-2-9-cli deb-2-9-ui -->

<!-- deb-2-9-cli
Once you have installed your MAAS environment (region + rack controller) and any possible extra rack controllers(s), you are ready to begin your [Configuration journey](#heading--top-maas-config).
deb-2-9-cli -->

<!-- deb-2-9-ui
Once you have installed your MAAS environment (region + rack controller) and any possible extra rack controllers(s), you are ready to begin your [Configuration journey](#heading--top-maas-config).
deb-2-9-ui -->

MAAS can be installed in either of two configurations:  test or production.  The test configuration uses a small PostgreSQL database (in a separate snap), designed for use with MAAS. The full-up production configuration uses a separate PostgreSQL database for performance and scalability.  This article will walk you through both install methods.

#### Thirteen questions you may have about installing MAAS:

1. [How do I install (but not initialise) the MAAS 3.0 Beta snap?](#heading--install-maas-snap)
2. [How do I upgrade my 2.9 snap to the MAAS 3.0 Beta?](#heading--upgrade-maas-snap)
3. [What are MAAS initialisation modes?](#heading--maas-init-modes)
4. [How do I initialise MAAS for a test or proof-of-concept configuration?](#heading--init-poc)
5. [How do I initialise MAAS for a production configuration?](#heading--init-prod)
6. [How do I migrate an existing snap install?](/t/tips-tricks-and-traps/1506#heading--migrate-maas)
7. [What if I want to manually export the MAAS database to an existing PostgreSQL server?](/t/tips-tricks-and-traps/1506#heading--manual-export)
8. [How can I check the service status of my MAAS configuration?](#heading--service-status)
9. [How do I re-initialise MAAS, if I want to?](#heading--reinitialising-maas)
10. [How can I discover additional init options?](#heading--additional-init-options)
11. [Give me an example of initialising MAAS](#heading--example)
12. [Tell me about the MAAS URL](#heading--maas-url)
13. [Tell me about the shared secret](#heading--shared-secret)

[note]
If you have installed `bind9` or have it running, you will need to uninstall it before installing MAAS.  You can check with `ps aux | grep named` to see if it's running. The `bind9` daemon interferes with MAAS operation and creates a number of unusual, hard-to-debug errors -- but don't worry, MAAS provides DNS and can work with existing DNS servers.
[/note]

<a href="#heading--install-maas-snap"><h3 id="heading--install-maas-snap">Installing MAAS from the snap</h3></a>

[Snaps](https://snapcraft.io/docs) are containerised software packages. To install MAAS from a snap simply enter the following:

    $ sudo snap install --channel=3.0/beta maas

After entering your password, the snap will download and install from the 3.0 beta channel -- though MAAS needs initialising before it's ready to go.

<a href="#heading--upgrade-maas-snap"><h3 id="heading--upgrade-maas-snap">Upgrading MAAS from 2.9</h3></a>

If you want to upgrade from a 2.9 snap to 3.0 Beta 1 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=3.0/beta maas

After entering your password, the snap will refresh from the 3.0 beta channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.

<a href="#heading--maas-init-modes"><h3 id="heading--maas-init-modes">MAAS initialisation modes</h3></a>

MAAS supports the following modes, which dictate what services will run on the local system:

| Mode          | Region | Rack | Database | Description                           |
|---------------|--------|------|----------|---------------------------------------|
| `region`      | X      |      |          | Region API server only                |
| `rack`        |        | X    |          | Rack controller only                  |
| `region+rack` | X      | X    |          | Region API server and rack controller |
| `none`        |        |      |          | Reinitialises MAAS and stops services |

<a href="#heading--init-poc"><h3 id="heading--init-poc">Initialising MAAS as a test configuration</h3></a>

We want to provide a more compact version for those who may be testing MAAS.  To achieve this, we're providing a separate snap, called `maas-test-db`, which provides a PostgreSQL database for use in testing and evaluating MAAS.   The following instructions will help you take advantage of this test configuration.

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

    $ maas-test-db.psql
    psql (10.6)
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

<a href="#heading--configuration-verification"><h3 id="heading--configuration-verification">Configuration verification</h3></a>

After a snap installation of MAAS, you can verify the currently-running configuration with:

    sudo maas config

<a href="#heading--init-prod"><h3 id="heading--init-prod">Initialise MAAS for a production configuration</h3></a>

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

<a href="#heading--service-status"><h3 id="heading--service-status">Checking MAAS service status</h3></a>

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


<!-- snap-3-0-cli
With MAAS installed and initialised, you can now open the web UI in your browser and begin your [Configuration journey](#heading--top-maas-config).
 snap-3-0-cli -->

With MAAS installed and initialised, you can now open the web UI in your browser and begin your [Configuration journey](#heading--top-maas-config).

<a href="#heading--example"><h3 id="heading--example">Example of MAAS initialisation</h3></a>

The following demonstrates the `region+rack` mode, a popular initialisation choice for MAAS:

    sudo maas init region+rack

`maas` will ask for the MAAS URL:

    MAAS URL [default=http://10.55.60.1:5240/MAAS]: http://192.168.122.1:5240/MAAS

If you also need to create an admin user, you can use:

    sudo maas createadmin

which takes you through the following exchange:

    Create first admin account:       
    Username: admin
    Password: ******
    Again: ******
    Email: admin@example.com
    Import SSH keys [] (lp:user-id or gh:user-id): lp:petermatulis

[note]
You will use the username and password created above to access the web UI.  If you enter a [Launchpad](https://launchpad.net/) or [GitHub](https://github.com) account name with associated SSH key, MAAS will import them automatically.
[/note]

<a href="#heading--maas-url"><h3 id="heading--maas-url">MAAS URL</h3></a>

All run modes (except `none`) prompt for a MAAS URL, interpreted differently depending on the mode:

-   `region`: Used to create a new region controller.
-   `rack`: Used to locate the region controller.

<a href="#heading--shared-secret"><h3 id="heading--shared-secret">Shared secret</h3></a>

The 'rack' and 'region+rack' modes will additionally ask for a shared secret that will allow the new rack controller to register with the region controller.

<a href="#heading--reinitialising-maas"><h3 id="heading--reinitialising-maas">Reinitialising MAAS</h3></a>

It is also possible to re-initialise MAAS to switch modes.  For example, to switch from `rack` to `region`:
 
    sudo maas init region

<a href="#heading--additional-init-options"><h3 id="heading--additional-init-options">Additional `init` options</h3></a>

The `init` command can takes optional arguments. To list them, as well as read a brief description of each, you can enter:

    sudo maas init --help


<!-- deb-3-0-cli deb-3-0-ui
<a href="#heading--installation-scenarios"><h3 id="heading--installation-scenarios">Installing MAAS 3.0 Beta 1</h3></a>

The recommended way to set up an initial MAAS environment is to put everything on one machine:

``` bash
sudo apt-add-repository paa:maas/3.0-next
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

and the rack controller (see [Rack controller](/t/rack-controller/771) for details) on another:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register
```

These two steps will lead you through two similar <code>apt</code> install sequences.

<a href="#heading--creating-a-maas-user"><h4 id="heading--creating-a-maas-user">Creating a MAAS user</h4></a>

<p>Finally, you will need to create a MAAS administrator user to access the web UI:</p>

``` bash
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

<p>For example, the process might go like this:</p>

<a href="https://discourse.maas.io/uploads/default/original/1X/315a94f85b928644037839677fd51871df0c1319.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/315a94f85b928644037839677fd51871df0c1319.jpeg"></a>

<p>The username can be anything. You will also be prompted to supply a password for the user. The command option <code>--password=$PASSWORD</code> can be used to specify one but, depending on your environment, this may pose a security risk.</p>

<div class="p-notification">
<p class="p-notification__response">At this time, MAAS does not make use of the email address. However, it may do so in the future.</p>
</div>

Finally, the <code>createadmin</code> option asks for an SSH key:

<a
href="https://discourse.maas.io/uploads/default/original/1X/472ce8e02273187370565e3d40175fe0ea8e351e.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/472ce8e02273187370565e3d40175fe0ea8e351e.jpeg"></a>

<p>If you have an SSH key associated with your launchpad or github accounts, you can enter the username here to include the key.  For launchpad, just enter <code>lp:username</code>, and for github, enter <code>gh:username</code> at the prompt.  In both cases, the actual username has to be supplied after the <code>lp:</code> or <code>gh:</code> prefix. </p>

<p>If you don't have a key associated with either of these services, you will have an opportunity to paste your public key into the MAAS SSH key list, after you've started MAAS for the first time as part of the welcome screens.</p>

<a href="#heading--next-steps"><h4 id="heading--next-steps">Next steps</h4></a>

deb-3-0-cli deb-3-0-ui -->

<!-- deb-3-0-cli
Once you have installed your MAAS environment (region + rack controller) and any possible extra rack controllers(s), you are ready to begin your [Configuration journey](#heading--top-maas-config).
deb-3-0-cli -->

<!-- deb-3-0-ui
Once you have installed your MAAS environment (region + rack controller) and any possible extra rack controllers(s), you are ready to begin your [Configuration journey](#heading--top-maas-config).
deb-3-0-ui -->

<a href="#heading--top-maas-config"><h2 id="heading--top-maas-config">How to configure MAAS</h2></a>

<!-- snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli snap-3-0-cli deb-3-0-cli 
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

Issue commands to the MAAS region controller at http://192.168.43.251:5240/MAAS/api/2.0/.

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

<a href="#heading--setting-dns"><h4 id="heading--setting-dns">Setting DNS</h4></a>

After logging in for the first time, you will need to set a number of system-wide configuration options.  First up, you should configure DNS.  You can check out the help for DNS settings, known in the CLI as a "DNS forwarder":

```
maas $PROFILE maas set-config name=upstream_dns value="8.8.8.8"
```

Here, we've set the DNS forwarder to "8.8.8.8" (Google), which is a reliable value.

<a href="#heading--setting-ssh"><h4 id="heading--setting-ssh">Setting SSH for the admin user</h4></a>

To add a public SSH key to a MAAS user account, type the following command:

```
maas $PROFILE sshkeys create "key=$SSH_KEY"
```

<a href="#heading--importing-images"><h4 id="heading--importing-images">Importing images</h4></a>

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
maas $PROFILE boot-source-selections create 1 \ > os="ubuntu" release="trusty" arches="amd64" subarches="*" \ > labels="*"
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

<a href="#heading--enabling-dhcp"><h4 id="heading--enabling-dhcp">Enabling DHCP</h4></a>

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
maas $PROFILE vlan update $FABRIC_ID untagged dhcp_on=True primary_rack=$RACK_CONTR_HOSTHNAME
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

snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli  snap-3-0-cli deb-3-0-cli -->

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

<a href="#heading--enabling-dhcp"><h3 id="heading--enabling-dhcp">Enabling DHCP</h3></a>

Before moving forward with MAAS, you'll want to enable DHCP.  You can do this very easily from the web UI by selecting "Subnets" from the top menu, choosing the VLAN on which you want to enable DHCP, and select the button marked, "Enable DHCP."

<a href="#heading--networking"><h3 id="heading--networking">Networking</h3></a>

<!-- deb-2-7-ui
The Dashboard landing page lists non-registered devices that MAAS detected automatically on the network. This [network discovery](/t/network-discovery/2929) process allows you to easily add or map devices already connected to your network -- devices that you may not necessarily want to manage with MAAS.
 deb-2-7-ui -->

<!-- deb-2-8-ui
The Dashboard landing page lists non-registered devices that MAAS detected automatically on the network. This [network discovery](/t/network-discovery/2931) process allows you to easily add or map devices already connected to your network -- devices that you may not necessarily want to manage with MAAS.
 deb-2-8-ui -->

<!-- deb-2-9-ui
The Dashboard landing page lists non-registered devices that MAAS detected automatically on the network. This [network discovery](/t/network-discovery/2933) process allows you to easily add or map devices already connected to your network -- devices that you may not necessarily want to manage with MAAS.
 deb-2-9-ui -->

<!-- deb-3-0-ui
The Dashboard landing page lists non-registered devices that MAAS detected automatically on the network. This [network discovery](/t/network-discovery/4044) process allows you to easily add or map devices already connected to your network -- devices that you may not necessarily want to manage with MAAS.
 deb-3-0-ui -->

<!-- snap-2-7-ui
The Dashboard landing page lists non-registered devices that MAAS detected automatically on the network. This [network discovery](/t/network-discovery/2923) process allows you to easily add or map devices already connected to your network -- devices that you may not necessarily want to manage with MAAS.
 snap-2-7-ui -->

<!-- snap-2-8-ui
The Dashboard landing page lists non-registered devices that MAAS detected automatically on the network. This [network discovery](/t/network-discovery/2925) process allows you to easily add or map devices already connected to your network -- devices that you may not necessarily want to manage with MAAS.
 snap-2-8-ui -->

<!-- snap-2-9-ui
The Dashboard landing page lists non-registered devices that MAAS detected automatically on the network. This [network discovery](/t/network-discovery/2927) process allows you to easily add or map devices already connected to your network -- devices that you may not necessarily want to manage with MAAS.
 snap-2-9-ui -->

The Dashboard landing page lists non-registered devices that MAAS detected automatically on the network. This [network discovery](/t/network-discovery/4042) process allows you to easily add or map devices already connected to your network -- devices that you may not necessarily want to manage with MAAS.

<a href="https://discourse.maas.io/uploads/default/original/1X/902f07b6e96d06dcd072501473ce85ff3d303610.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/902f07b6e96d06dcd072501473ce85ff3d303610.jpeg"></a>  

[note]
Network discovery can be disabled at any time from the button on the Dashboard view.  Also note that you can get back to the dashboard at any time by clicking the MAAS logo.
[/note]

<a href="#heading--spaces-fabrics-zones-and-subnets"><h4 id="heading--spaces-fabrics-zones-and-subnets">Spaces, fabrics, zones and subnets</h4></a>

Networks in large data centres can be very complex. MAAS offers comprehensive control over networking so that you have the flexibility to reconfigure racks and deploy machines as you see fit. You can isolate machine deployment not only with DNS domains, but also via [subnets](/t/concepts-and-terms/785#heading--subnets), [spaces](/t/concepts-and-terms/785#heading--spaces), [zones](/t/concepts-and-terms/785#heading--zones), and [fabrics](/t/concepts-and-terms/785#heading--fabrics).  The links provide more details, but these are all basically collections:

* **subnet** has the traditional meaning: a range of IP addresses covering a subset of IP addresses.  Generally speaking , a subnet is a collection of IP addresses which includes at least two addresses.
* a **space** is a collection of subnets that you can create with MAAS, understanding that each subnet can belong to only one space.  Spaces allow multiple subnets to communicate without requiring a direct network path between them.
* a **zone** is also an ad-hoc collection, but one which groups individual nodes, rather than subnets.  MAAS allows you to create and edit zones at will.
* a **fabric** is essentially a collection of trunked switches, allowing you to access a group of VLANs.

Here is a diagram that helps to illustrate these concepts:

<a href="https://discourse.maas.io/uploads/default/original/1X/dd60fdeba34d3cf33d4cf42db1f745ba95542b69.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/dd60fdeba34d3cf33d4cf42db1f745ba95542b69.jpeg"></a> 

Be aware that these network settings are spread across several web UI configuration pages. The Zones page, for example, enables you to see how many machines, devices and controllers are using a zone, and allows you to add and edit zones.  The Subnets page, shown below, provides access to fabric, VLAN, subnet and spaces configuration.

<a href="https://discourse.maas.io/uploads/default/original/1X/89d90a15e70a57e6951ee62910b503895e08251e.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/89d90a15e70a57e6951ee62910b503895e08251e.jpeg"></a> 

<a href="#heading--deploy-hardware"><h3 id="heading--deploy-hardware">Deployment</h3></a>

MAAS-managed machines are listed -- and operated on -- from the Machines page, making it one of the most important screens in the MAAS web UI:

<a href="https://discourse.maas.io/uploads/default/original/1X/58a37e0dc29bc233f771c33d07a0e03e8d55cb87.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/58a37e0dc29bc233f771c33d07a0e03e8d55cb87.jpeg"></a> 

If you are testing MAAS using virtual machines, the machines appear here as soon as they boot. New machines are added automatically when they first connect to your network. Alternatively, the ‘Add hardware’ menu lets you add machines manually, via their MAC address.

After you configure power and interfaces, MAAS must commission machines to retrieve CPU, memory and storage information. From this point, you can command MAAS to acquire, test, deploy and release these machines as you work with your MAAS cloud.

<!-- deb-2-7-ui
While you are testing MAAS, be sure to check out filters, which can narrow your view based on both [tags](/t/maas-tags/2893) and hardware characteristics.  You can select and manage machines in either filtered or full views.
 deb-2-7-ui -->

<!-- deb-2-8-ui
While you are testing MAAS, be sure to check out filters, which can narrow your view based on both [tags](/t/maas-tags/2895) and hardware characteristics.  You can select and manage machines in either filtered or full views.
 deb-2-8-ui -->

<!-- deb-2-9-ui
While you are testing MAAS, be sure to check out filters, which can narrow your view based on both [tags](/t/maas-tags/2897) and hardware characteristics.  You can select and manage machines in either filtered or full views.
 deb-2-9-ui -->

<!-- deb-3-0-ui
While you are testing MAAS, be sure to check out filters, which can narrow your view based on both [tags](/t/maas-tags/4024) and hardware characteristics.  You can select and manage machines in either filtered or full views.
 deb-3-0-ui -->

<!-- snap-2-7-ui
While you are testing MAAS, be sure to check out filters, which can narrow your view based on both [tags](/t/maas-tags/2887) and hardware characteristics.  You can select and manage machines in either filtered or full views.
 snap-2-7-ui -->

<!-- snap-2-8-ui
While you are testing MAAS, be sure to check out filters, which can narrow your view based on both [tags](/t/maas-tags/2889) and hardware characteristics.  You can select and manage machines in either filtered or full views.
 snap-2-8-ui -->

<!-- snap-2-9-ui
While you are testing MAAS, be sure to check out filters, which can narrow your view based on both [tags](/t/maas-tags/2891) and hardware characteristics.  You can select and manage machines in either filtered or full views.
 snap-2-9-ui -->

While you are testing MAAS, be sure to check out filters, which can narrow your view based on both [tags](/t/maas-tags/4022) and hardware characteristics.  You can select and manage machines in either filtered or full views.


<a href="#heading--images"><h4 id="heading--images">Images</h4></a>

When it comes to running applications, MAAS can easily deploy any supported variant of Ubuntu, including LTS and non-LTR versions for x86, ARM, PPC and s390x systems. You can also deploy several other operating systems to your machines, including CentOS 7, CentOS 6, Windows, RHEL, and ESXi images, via <a href="https://www.ubuntu.com/support" rel="nofollow noopener">Ubuntu Advantage^</a>.

<a href="https://discourse.maas.io/uploads/default/original/1X/27c47222c1fc0e34ed70134a1007dde067d2de81.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/27c47222c1fc0e34ed70134a1007dde067d2de81.jpeg"></a> 

<a href="#heading--vm-hosts"><h4 id="heading--vm-hosts">VM hosts</h4></a>


<!-- deb-2-7-cli
[VM hosts]( /t/vm-hosting/2748) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 deb-2-7-cli -->

<!-- deb-2-7-ui
[VM hosts]( /t/vm-hosting/2749) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 deb-2-7-ui -->

<!-- deb-2-8-cli
[VM hosts]( /t/vm-hosting/2750) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 deb-2-8-cli -->

<!-- deb-2-8-ui
[VM hosts]( /t/vm-hosting/2751) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 deb-2-8-ui -->

<!-- deb-2-9-cli
[VM hosts]( /t/vm-hosting/2752) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 deb-2-9-cli -->

<!-- deb-3-0-ui
[VM hosts](/t/vm-hosting/4164) can give you greater control over your hardware.  A LXD (pronounced "lex-D") VM host is a collection of individual virtual machines.  You can use a LXD VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 deb-3-0-ui -->

<!-- deb-3-0-cli
[VM hosts](/t/vm-hosting/4163) can give you greater control over your hardware.  A LXD (pronounced "lex-D") VM host is a collection of individual virtual machines.  You can use a LXD VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 deb-3-0-cli -->

<!-- deb-2-9-ui
[VM hosts](/t/vm-hosting/2753) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 deb-2-9-ui -->

<!-- snap-2-7-cli
[VM hosts]( /t/vm-hosting/2742) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 snap-2-7-cli -->

<!-- snap-2-7-ui
[VM hosts]( /t/vm-hosting/2743) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 snap-2-7-ui -->

<!-- snap-2-8-cli
[VM hosts]( /t/vm-hosting/2744) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 snap-2-8-cli -->

<!-- snap-2-8-ui
[VM hosts]( /t/vm-hosting/2745) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 snap-2-8-ui -->

<!-- snap-2-9-cli
[VM hosts]( /t/vm-hosting/2746) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 snap-2-9-cli -->

<!-- snap-2-9-ui
[VM hosts]( /t/vm-hosting/2747) can give you greater control over your hardware.  A VM host is a collection of individual virtual machines.  You can use a VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 snap-2-9-ui -->

<!-- snap-3-0-cli
[VM hosts](/t/vm-hosting/4161) can give you greater control over your hardware.  A LXD (pronounced "lex-D") VM host is a collection of individual virtual machines.  You can use a LXD VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!
 snap-3-0-cli -->

[VM hosts](/t/vm-hosting/4162) can give you greater control over your hardware.  A LXD (pronounced "lex-D") VM host is a collection of individual virtual machines.  You can use a LXD VM host to compose machines into an abstraction of resources that functions like a physical machine -- without building one!

<!-- deb-2-9-ui snap-2-9-ui
It’s easy to add a virsh VM host: click the "Add KVM" button on the "KVM" page of the web UI, give the VM host a name, and select `virsh` or `lxd` as the VM host type.  You will also need to enter the address for the KVM host: in the case of `virsh`, this address looks something like `qemu+ssh://<yourusername>@10.249.0.2/system`, with password equal to the password for `<yourusername>`; if you're using `lxd`, this address will be the IP of the LXD bridge gateway (.1), with the password being the trust password you entered when initializing LXD.

After you create a VM host, you compose hardware by selecting the VM host, and then selecting "Compose" from the Action menu. You can configure composed hardware as desired, including the number of cores, CPU speed, RAM and combined storage.  Then just click "Compose machine", and MAAS will combine resources to create a new, single entity that can be used just like any other machine.  VM hosts abstract multiple resources:

<a href="https://discourse.maas.io/uploads/default/original/1X/c57d7cf802bfd3f968cc54a829cd1629c45e9f62.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c57d7cf802bfd3f968cc54a829cd1629c45e9f62.jpeg"></a> 

into pools of composable hardware:

<a href="https://discourse.maas.io/uploads/default/original/1X/763029b5678b6f88317359d28eac3003f7298f37.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/763029b5678b6f88317359d28eac3003f7298f37.jpeg"></a> 
 deb-2-9-ui snap-2-9-ui -->

<!-- snap-2-7-ui snap-2-8-ui deb-2-7-ui deb-2-8-ui
It’s easy to add a virsh VM host: click the "Add KVM" button on the "KVM" page of the web UI, give the VM host a name, and select as the VM host type.  You will also need to enter the address for the KVM host; this address will look something like 'qemu+ssh://<yourusername>@10.249.0.2/system`, where the paasword will be the same password `<yourusername>` uses to log into the host.

After you create a VM host, you compose hardware by selecting the VM host, and then selecting "Compose" from the Action menu. You can configure composed hardware as desired, including the number of cores, CPU speed, RAM and combined storage.  Then just click "Compose machine", and MAAS will combine resources to create a new, single entity that can be used just like any other machine.  VM hosts abstract multiple resources:

<a href="https://discourse.maas.io/uploads/default/original/1X/c57d7cf802bfd3f968cc54a829cd1629c45e9f62.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c57d7cf802bfd3f968cc54a829cd1629c45e9f62.jpeg"></a> 

into pools of composable hardware:

<a href="https://discourse.maas.io/uploads/default/original/1X/763029b5678b6f88317359d28eac3003f7298f37.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/763029b5678b6f88317359d28eac3003f7298f37.jpeg"></a> 
snap-2-7-ui snap-2-8-ui deb-2-7-ui deb-2-8-ui -->

It’s easy to add a LXD VM host: click the "Add KVM" button on the "KVM" page of the web UI, give the VM host a name, and select "lxd" as the VM host type.  You will also need to enter the IP address for the gateway (.1) of the bridge you're using to connect to LXD.  The password will be the trust password you created when initializing LXD.

<a href="https://discourse.maas.io/uploads/default/original/2X/f/ff398586b76154dd20e4c194e30f5c832a7dac89.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/ff398586b76154dd20e4c194e30f5c832a7dac89.png"></a>

After you create a VM host, you compose hardware by selecting the host, and then selecting "Compose" from the Action menu. You can configure composed hardware as desired, including the number of cores, CPU speed, RAM and combined storage.  Then just click "Compose machine", and MAAS will combine resources to create a new, single entity that can be used just like any other machine.  VM hosts abstact multiple resources into pools of composable hardware.

There you have it: A quick tour of MAAS and its capabilities.  Read on through the documentation to learn more.