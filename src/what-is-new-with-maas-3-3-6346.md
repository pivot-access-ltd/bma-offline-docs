<!-- "What is new with MAAS" -->

Here you will find release notes for:

- [The current version of MAAS](#heading--current-maas-release-notes)
- [Other MAAS versions](#heading--other-maas-versions)

We are happy to announce that MAAS 3.3 RC3 has been released, with [one additional bug fix](#heading--MAAS-3-3-RC3-bug-list).  MAAS 3.3 is a concerted effort to improve MAAS on multiple fronts, including a large number of bug fixes. 

<a href="#heading--Cumulative-summary-of-MAAS-3-3-features"><h2 id="heading--Cumulative-summary-of-MAAS-3-3-features">Cumulative summary of MAAS 3.3 features</h2></a>

New features created for MAAS 3.3 include:

- [Ansible playbooks for HA MAAS, PostgreSQL, and other MAAS configurations](#heading--ansible-playbooks): [Ansible](https://www.redhat.com/en/technologies/management/ansible/what-is-ansible)`↗` [playbooks](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html)`↗` are now available for MAAS, making it easy to automate routine setup and configuration of MAAS.

- [Improved machine list filtering](#heading--Improved-machine-list-filtering): MAAS 3.3 enhances the presentation and filtering of the machine list, with a shorter wait to start filtering and a wider range of filter choices.

- [Integration of Vault for credential storage](#heading--vault-integration): MAAS 3.3 allows you to use [Hashicorp Vault](https://www.vaultproject.io/)`↗` to protect your secrets, if you wish.

Improved capabilities include the following:

- [Native support for 22.04 LTS and core22](#heading--22-04-support): We've removed the requirement to use snaps on 22.04 (Jammy Jellyfish); you now can load MAAS 3.3 on 22.04 using packages.

- [UI performance improvements for large machine counts](#heading--UI-performance-improvements): We've improved the performance of the UI machine list for large (>10000 machines) MAAS instances.  The machine list now goes live just a few seconds after the first visible page loads, with the rest of the list loading in background.

- [Enhanced MIB support for Windows OS images](#heading--Enhanced-MIB-support-for-Windows-OS-images): The [procedure](/t/how-to-build-custom-images/5104#heading--custom-windows-images) for creating custom Windows OS images has been thoroughly updated and verified.

Greatly expanded documentation sections include:

- [MAAS configuration settings reference](#heading--maas-config-settings-ref): There is now one reference page that addresses all MAAS settings in one place.  Other references throughout the document are preserved for now.

- [Improved MAAS event documentation](#heading--Improved-MAAS-event-documentation): MAAS event documentation has been expanded to include [much better explanations](/t/understanding-maas-events/6373) of MAAS events, including many examples.

- [Improved MAAS audit event documentation](#heading--Improved-MAAS-audit-event-documentation): MAAS audit event documentation has been greatly expanded to include [much better explanations](/t/understanding-maas-audit-events/6372) of MAAS audit events, including many examples and use cases.

Several forward-looking improvements are included as well:

- Reliability improvements for simultaneous machine deployments

- The first phase of [Nvidia DPU](https://www.nvidia.com/en-us/networking/products/data-processing-unit/)`↗` support

- Shifting the MAAS API documentation toward [OpenAPI standards](https://www.openapis.org/)`↗`

- Shifting the MAAS documentation toward the [Diátaxis](https://diataxis.fr/)`↗` style of documentation

These will be documented later in blog posts.


This release also includes well over one-hundred [bug fixes](#heading--MAAS-3.3-bug-list).  Read on to catch up with what we've done so far this cycle.

<a href="#heading--How-to-install-MAAS-3-3"><h2 id="heading--How-to-install-MAAS-3-3">How to install MAAS 3.3</h2></a>

MAAS will run on just about any modern hardware configuration, even a development laptop.  If you're not sure whether your target server will handle MAAS, [you can always double-check](/t/maas-installation-requirements/6233).

[note]
**NOTE** that PostgreSQL 12 is deprecated with the release of MAAS 3.3, in favour of PostgreSQL 14. Support for PostgreSQL 12 will be discontinued in MAAS 3.4.
[/note]

<a href="#heading--fresh-install-3-3-snap"><h3 id="heading--fresh-install-3-3-snap">How to do a fresh snap install of MAAS 3.3</h3></a>

To install MAAS 3.3 from a snap, simply enter the following:

    $ sudo snap install --channel=3.3/candidate maas

After entering your password, the snap will download and install from the 3.3 channel.

<a href="#heading--upgrade-from-earlier-version-to-snap-3-3"><h3 id="heading--upgrade-from-earlier-version-to-snap-3-3">How to upgrade from an earlier snap version to MAAS 3.3</h3></a>

Maybe instead of a fresh install, you want to upgrade from a earlier snap version to the 3.3 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=3.3/candidate maas

After entering your password, the snap will refresh from the 3.3 candidate channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.

<a href="#heading--init-maas-poc"><h3 id="heading--init-maas-poc">How to initialise MAAS 3.3 snap for a test or POC environment</h3></a>

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

<a href="#heading--fresh-install-3-3-packages"><h3 id="heading--fresh-install-3-3-packages">How to do a fresh install of MAAS 3.3 from packages</h3></a>

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

<a href="#heading--How-to-upgrade-from-3-2-or-lower-to-MAAS-3-3"><h3 id="heading--How-to-upgrade-from-3-2-or-lower-to-MAAS-3-3">How to upgrade from 3.2 or lower to MAAS 3.3</h3></a>

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

Add the MAAS 3.3 PPA to your repository list with the following command, ignoring any apparent error messages:

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

<a href="#heading--ansible-playbooks"><h2 id="heading--ansible-playbooks">Ansible playbooks for HA MAAS, PostgreSQL, and other MAAS configurations</h2></a>

[Ansible](https://www.redhat.com/en/technologies/management/ansible/what-is-ansible)`↗` [playbooks](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html)`↗` are now available for MAAS.  These extended YAML files automate various routine aspects of MAAS setup and configuration.  

<a href="#heading--Ten-words-or-less-1"><h3 id="heading--Ten-words-or-less-1">Ten words or less</h3></a>

Automate the drudgery of installing and configuring MAAS with Ansible.

<a href="#heading--Background-explanations-on-Ansible"><h3 id="heading--Background-explanations-on-Ansible">Background explanations on Ansible</h3></a>

Ansible is more than scripting; it's a fully-featured automation tool that allows you to group modules (binaries or snippets of code) into specific tasks.  These tasks can be combined to build plays, and plays can be combined to build playbooks.  The idea is to abstract each level so you're not trying to keep track of which lines of Bash code you need to cut and past in between others.  

With MAAS 3.3, playbooks are available to:

- install and configure a MAAS region on a targeted host; running the playbook on hosts with a MAAS region will upgrade it.
- install and configure a MAAS rack.
- setup the postgres primary role.
- setup the postgres secondary role.

MAAS Playbooks are available from a [repository](https://github.com/maas/MAAS-ansible-playbook)`↗`.  They will eventually be available through Ansible Galaxy.

There is also a set of groups that will automate setting up specific sections of MAAS.  For example, there is a PostgreSQL group that sets up the primary and secondary PostgreSQL roles, bypassing the need to run both playbooks individually.

After installing ansible, running each of the playbooks on a blank machine will have a fresh install of MAAS ready to go. For example, running the region+rack will setup a region+rack on the host machine.

<a href="#heading--How-you-can-use-Ansible-playbooks"><h3 id="heading--How-you-can-use-Ansible-playbooks">How you can use Ansible playbooks</h3></a>

In general terms, you can run any of the MAAS Ansible plays with a command of this form:

```nohighlight
ansible-playbook -i hosts \
--extra_vars \
"maas_version=$MAAS_VERSION 
maas_postgres_password=$MAAS_PG_PASSWORD 
maas_postgres_replication_password=$MAAS_PG_REP_PASSWORD 
maas_installation_type=<deb|snap> 
maas_url=$MAAS_URL" \
./site.yaml
```

A command of this form will run all of the plays below (i.e., the entire playbook). If you want to run the tasks for one particular role (or roles), you can use the form --tags <target role(s)> to limit which parts of the MAAS Ansible playbook run. Consult the Ansible documentation for more details on additional options and command structure.

[note]
There's some extra good news here:  These Ansible playbooks were built and tested with MAAS 3.2, so you can use them with all variants of MAAS 3.2.
[/note]

For example, suppose you want to install a MAAS region controller.  As an operator, you want want to install a MAAS region controller onto a given host using Ansible. To accomplish this, you need only:

- set a maas_region_controller role on a given host,
- run the region controller playbook,
- and find the newly-configured region controller present on that host .

To set the `maas_region_controller` role, you add that role to your Inventory file in the form of either an INI or a YAML file, where each role is followed by the addresses of each host to attach the role to. The example below attaches the region controller role to a host running on 10.10.0.20 with the user `ubuntu`:

```nohighlight
INI:

[maas_region_controller]
10.10.0.20 ansible_user=ubuntu
YAML:

all:
  maas_region_controller:
    hosts:
      10.10.0.20:
        ansible_user: ubuntu
```

When running the playbook for a host with the `maas_region_controller` role, the playbook installs the MAAS region controller. The documented ansible variable `maas_installation_type` provides the user with the ability to set whether it’s a deb installation or a snap installation, along with additional variables for MAAS version, snap channel and/or PPA.

The default installation is a snap. A successful run of the playbook should give the operator an accessible and ready MAAS instance.  The playbook uses an Ansible variable to determine what version of MAAS to deploy. The playbook won’t execute (i.e “skipped” in the context of Ansible) if the Ubuntu version is incompatible with the version and install method. The Region Controller tasks should be able to execute on multiple hosts in a single execution if the target is an Ansible Group rather than a single host.  The newly-installed region controller should be accessible at the specified host ip address, as though the controller had been installed manually.

Read the [Ansible playbooks reference](/t/how-to-spin-up-maas-with-ansible/6367) document to learn more about the feature and the additional playbooks that are available.

<!--
<a href="#heading--vault-integration"><h2 id="heading--vault-integration">Integration of Vault for credential storage</h2></a>

MAAS deals with a number of secrets (user password, certificates and keys, API tokens, …), currently stored in the database -- which is insecure by default. This configuration may not meet everyone's security requirements or regulations. For this reason, we've integrated MAAS with Hashicorp Vault, a well-established solution for secure, centralised credential storage.

You can read the [MAAS Vault reference](/t/maas-vault-reference/6368) documentation to learn more. -->

<a href="#heading--Improved-machine-list-filtering"><h2 id="heading--Improved-machine-list-filtering">Improved machine list filtering</h2></a>

MAAS 3.3 dramatically reduces the latency associated with refreshing large machine lists.

<a href="#heading--Ten-words-or-less-2"><h3 id="heading--Ten-words-or-less-2">Ten words or less</h3></a>

You can filter machines mere seconds after one page loads.

<a href="#heading--How-list-filtering-is-improved"><h3 id="heading--How-list-filtering-is-improved">How list filtering is improved</h3></a>

[note]
**NOTE** that this feature is still in development, so some of the feature-set described in this section may not be fully operational yet.  As always, we reserve the right to change this feature-set until the final release of MAAS 3.3. These release notes will be updated as the feature develops.
[/note]

MAAS 3.3 enhances the way you can filter the machine list, in two ways:

1. You may begin filtering within a very short time after the first page of the machine list loads, even if you have more than 10,000 machines in the list.  

2. You have a wider range of filter choices, as described in the table below.

Note that with this version of MAAS, matching machine counts have been removed from the filter list for better performance.

<a href="#heading--More-filter-parameters-have-been-added"><h3 id="heading--More-filter-parameters-have-been-added">More filter parameters have been added</h3></a>

The following table describes the expanded filter set for the MAAS machine list:

- Items marked "Dyn" are dynamic, populated based on existing data, that is, the "Tags" filter only shows tags that currently exist.  
- Items which are not dynamic present the entire range of possible values, regardless of whether that value currently exists in MAAS; for example, all machine status values are available to be filtered, even if no machines currently have that status.
- Items marked "Grp" can be used to group machines, instead of the default machine status.
- Items marked "Man" must be manually entered, i.e., they are not in the UI filter dropdown, but can be entered in the "Search" box if properly formatted (as in the examples given).

See [How to search MAAS](/t/how-to-find-machines/5192) for more details on how to use these parameters.


| Parameter (bold) w/example           | Shows nodes...                   | Dyn | Grp | Man |
|--------------------------------------|----------------------------------|-----|-----|-----|
| **arch**:(=architecture)             | with "architecture"              |     | Grp |     |
| arch:(!=architecture)                | NOT with "architecture"          | Dyn |     |     |
| **zone**:(=zone-name)                | in "zone-name"                   | Dyn | Grp |     |
| zone:(!=zone-name)                   | NOT in "zone-name"               | Dyn |     |     |
| **pool**:(=resource-pool)            | in "resource-pool"               | Dyn | Grp |     |
| pool:(!=resource-pool)               | NOT in "resource-pool"           | Dyn |     |     |
| **pod**:(=pod-name)                  | with "pod-name"                  | Dyn | Grp |     |
| pod:(!=pod-name)                     | NOT with "pod-name"              | Dyn |     |     |
| **pod_type**:(=pod-type)             | with power type "pod-type"       | Dyn | Grp | Man |
| pod_type:(!=pod-type)                | NOT with power type "pod-type"   | Dyn |     | Man |
| **domain**:(=domain-name)            | with "domain-name"               | Dyn | Grp | Man |
| domain:(!=domain-name)               | NOT with "domain-name"           | Dyn |     | Man |
| **status**:(=op-status)              | having "op-status"               |     | Grp |     |
| status:(!=op-status)                 | NOT having "op-status"           | Dyn |     |     |
| **owner**:(=user)                    | owned by "user"                  | Dyn | Grp |     |
| owner:(!=user)                       | NOT owned by "user"              | Dyn |     |     |
| **power_state**:(=power-state)       | having "power-state"             |     | Grp | Man |
| power_state:(!=power-state)          | NOT having "power-state"         | Dyn |     | Man |
| **tags**:(=tag-name)                 | with tag "tag-name"              | Dyn |     |     |
| tags:(!=tag-name)                    | NOT with tag "tag-name"          | Dyn |     |     |
| **fabrics**:(=fabric-name)           | in "fabric-name"                 | Dyn |     |     |
| fabrics:(!=fabric-name)              | NOT in "fabric-name"             | Dyn |     |     |
| **fabric_classes**:(=fabric-class)   | in "fabric-class"                | Dyn |     | Man |
| fabric_classes:(!=fabric-class)      | NOT in "fabric-class"            | Dyn |     | Man |
| **fabric_name**:(=fabric-name)       | in "boot-interface-fabric"       | Dyn |     | Man |
| fabric_name:(!=fabric-name)          | NOT in "boot-interface-fabric"   | Dyn |     | Man |
| **subnets**:(=subnet-name)           | attached to "subnet-name"        | Dyn |     |     |
| subnets:(!=subnet-name)              | Not attached to "subnet-name"    | Dyn |     |     |
| **link_speed**:(link-speed)          | having "link-speed"              | Dyn |     | Man |
| link_speed:(!link-speed)             | NOT having "link-speed"          | Dyn |     | Man |
| **vlans**:(=vlan-name)               | attached to "vlan-name"          | Dyn |     |     |
| vlans:(!=vlan-name)                  | NOT attached to "vlan-name"      | Dyn |     |     |
| **storage**:(storage-MB)             | having "storage-MB"              | Dyn |     | Man |
| **total_storage**:(total-stg-MB)     | having "total-stg-MB"            | Dyn |     | Man |
| total_storage:(!total-stg-MB)        | NOT having "total-stg-MB"        | Dyn |     | Man |
| **cpu_count**:(cpu-count)            | having "cpu-count"               | Dyn |     | Man |
| cpu_count:(!cpu-count)               | NOT having "cpu-count"           | Dyn |     | Man |
| **mem**:(ram-in-MB)                  | having "ram-in-MB"               | Dyn |     | Man |
| mem:(!ram-in-MB)                     | NOT having "ram-in-MB"           | Dyn |     | Man |
| **mac_address**:(=MAC)               | having MAC address "MAC"         | Dyn |     | Man |
| mac_address:(!=MAC)                  | NOT having                       | Dyn |     | Man |
| **agent_name**:(=agent-name)         | Include nodes with agent-name    | Dyn |     | Man |
| agent_name:(!=agent-name)            | Exclude nodes with agent-name    | Dyn |     | Man |
| **cpu_speed**:(cpu-speed-GHz)        | CPU speed                        | Dyn |     | Man |
| cpu_speed:(!cpu-speed-GHz)           | CPU speed                        | Dyn |     | Man |
| **osystem**:(=os-name)               | The OS of the desired node       | Dyn |     | Man |
| osystem:(!=os-name)                  | OS to ignore                     | Dyn |     | Man |
| **distro_series**:(=distro-name)     | Include nodes using distro       | Dyn |     | Man |
| distro_series:(!=distro-name)        | Exclude ndoes using distro       | Dyn |     | Man |
| **ip_addresses**:(=ip-address)       | Node's IP address                | Dyn |     | Man |
| ip_addresses:(!=ip-address)          | IP address to ignore             | Dyn |     | Man |
| **spaces**:(=space-name)             | Node's spaces                    | Dyn |     |     |
| spaces:(!=space-name)                | Node's spaces                    | Dyn |     |     |
| **workloads**:(=annotation-text)     | Node's workload annotations      | Dyn |     |     |
| workloads:(!=annotation-text)        | Node's workload annotations      | Dyn |     |     |
| **physical_disk_count**:(disk-count) | Physical disk Count              | Dyn |     | Man |
| physical_disk_count:(!disk-count)    | Physical disk Count              | Dyn |     | Man |
| **pxe_mac**:(=PXE-MAC)               | Boot interface MAC address       | Dyn |     | Man |
| pxe_mac:(!=PXE-MAC)                  | Boot interface MAC address       | Dyn |     | Man |
| **fqdn**:(=fqdn-value)               | Node FQDN                        | Dyn |     | Man |
| fqdn:(!=fqdn-value)                  | Node FQDN                        | Dyn |     | Man |
| **simple_status**:(=status-val)      | Include nodes with simple-status | Dyn |     | Man |
| simple_status:(!=status-val)         | Exclude nodes with simple-status | Dyn |     | Man |
| **devices**:(=)                      | Devices                          | Dyn |     | Man |
| **interfaces**:(=)                   | Interfaces                       | Dyn |     | Man |
| **parent**:(=)                       | Parent node                      | Dyn | Grp | Man |

<a href="#heading--22-04-support"><h2 id="heading--22-04-support">Native support for 22.04 LTS and core22</h2></a>

MAAS can now be installed as a PPA, directly on Ubuntu 22.04, without the need to use snaps.

<a href="#heading--Ten-words-or-less"><h3 id="heading--Ten-words-or-less">Ten words or less</h3></a>

MAAS packages now run on Ubuntu 22.04, aka Jammy Jellyfish.

<a href="#heading--Notes-on-22.04-LTS-MAAS-packages"><h3 id="heading--Notes-on-22.04-LTS-MAAS-packages">Notes on 22.04 LTS MAAS packages</h3></a>

MAAS users want to install MAAS on a 22.04 LTS system via deb packages, as well as upgrade machines currently running MAAS on Ubuntu 20.04 LTS to 22.04 LTS.  With the advent of MAAS 3.3, we have created an appropriate PPA with all required dependencies.  This PPA can be directly installed on Ubuntu 22.04, Jammy Jellyfish, with no requirement to use snaps.

Note that the upgrade procedure will require a release upgrade from previous Ubuntu versions to Ubuntu 22.04.  Also note that, with this version of MAAS, PostgreSQL 12 is deprecated and should be upgraded to PostgreSQL 14.  The [installation guide](/t/how-to-install-maas/5128) provides the necessary details.

<!--
<a href="#heading--simultaneous-deployment-improvements"><h2 id="heading--simultaneous-deployment-improvements">Reliability improvements for simultaneous machine deployments</h2></a>

MAAS 3.3 brings some behind-the-scenes performance improvements to the product.  When you deploy many machines, you expect them all deploy reliably, with IPs allocated in bulk, and no DNS delays or RPC timeouts.  Within our development system, we've added system tests and metrics to track any failures or latency when large numbers of machines are being deployed.  We've then used these new data to lower the failure rate and reduce latency in those situations.

<a href="#heading--nvidia-dpu-support"><h2 id="heading--nvidia-dpu-support">The first phase of Nvidia DPU support</h2></a>

Long-term, we know that MAAS administrators want to enlist and use DPUs with MAAS.  The Nvidia DPU is a complex machine with a tremendous amount of capability, so this cycle, we made the first steps toward supporting them.  Details will follow in a forward-looking blog post sometime after the MAAS 3.3 release.
-->

<a href="#heading--UI-performance-improvements"><h2 id="heading--UI-performance-improvements">UI performance improvements</h2></a>

We wanted to improve the performance of the machine list page for large (>10000 machines) MAASes, and allow users to search and filter machines as quickly as possible. 

<a href="#heading--Ten-words-or-less-17"><h3 id="heading--Ten-words-or-less-17">Ten words or less</h3></a>

We're working on making large machine lists load in background.

<a href="#heading--Background-performance-work"><h3 id="heading--Background-performance-work">Background performance work</h3></a>

In MAAS 3.2 and earlier, machine search and filter requires that all machines be fetched by the UI client before it becomes usable. For smaller MAASes this may not be an issue, but when considering MAASes with 1000 machines or more this can make the user wait an unacceptably long time before they can search and filter.  With the release of MAAS 3.3, when a MAAS UI user wants to find a particular machine, they do not have to wait for all their machines data to load before they can start searching. The user can start searching for machines within a short time after the visible page of the machine list has fully loaded on the UI screen.  See [Improved machine list filtering](#heading--Improved-machine-list-filtering), in these release notes, for details on the enhanced filtering capabilities that were included in this work.

<a href="#heading--Enhanced-MIB-support-for-Windows-OS-images"><h2 id="heading--Enhanced-MIB-support-for-Windows-OS-images">Enhanced MIB support for Windows OS images</h2></a>

The [procedure](/t/how-to-build-custom-images/5104#heading--custom-windows-images) for creating custom Windows OS images has been thoroughly updated and verified.

<a href="#heading--Ten-words-or-less-5"><h3 id="heading--Ten-words-or-less-5">Ten words or less</h3></a>

MAAS custom Windows images now support most releases and options.

<a href="#heading--What-has-been-added-to-Windows-custom-images"><h3 id="heading--What-has-been-added-to-Windows-custom-images">What has been added to Windows custom images</h3></a>

Specifically, MIB now supports a much wider range of Windows images.  Previously, only 2012 and 2106 Windows versions were supported with MIB.  Now the list is much longer, bringing deployable MAAS versions up to date with the current Windows releases:

 - win2008r2
 - win2008hvr2
 - win2012
 - win2012hv
 - win2012r2
 - win2012hvr2
 - win2016
 - win2016-core
 - win2016hv
 - win2016dc
 - win2016dc-core
 - win2019
 - win2019-core
 - win2019dc
 - win2019dc-core
 - win10ent
 - win10ent-eval
 - win2022
 - win2022-core

There are also special instructions for using both UEFI and BIOS bootloaders, as well as instructions for using LXD containers with custom-built Windows images.  

Finally, MIB has been extended to accept a much wider range of options for windows builds.  Some of the new Windows-specific options include:

 - --windows-iso: path to the Windows ISO image.
 - --windows-edition: identifier for the Windows edition/option being installed (see above).
 - --windows-license-key: Windows license key (required with non-evaluation editions)
 - --windows-language: Windows installation language (default: en-US)
 - --windows-updates: download and install Windows Updates (requires internet access; might require a larger --disk-size option)
 - --windows-drivers: path to directory with Windows drivers to be installed (requires internet access; uses the Windows Driver Kit, by default)
 - --driver-store: combined with --windows-drivers, uses the Windows Driver Store to install drivers early into Windows Setup and image (does not require internet access; does not use the Windows Driver Kit).

Some news Windows-specific platform options include:

 - --uefi: use UEFI partition layout and firmware
 - --virtio: use paravirtualized VirtIO SCSI and VirtIO NET devices (instead of emulated devices) for installation (requires --windows-drivers)
 - --disk-size: specify the (virtual) disk size for Windows setup (must be larger for --windows-updates; increases deployment/copy-to-disk time, and is expanded to physical disk size during deployment)

This update should make it much simpler to use custom-built Windows images with MAAS.


<a href="#heading--openapi-support"><h2 id="heading--openapi-support">Shifting the MAAS API documentation to OpenAPI standards</h2></a>

MAAS API User want to experience the MAAS API in a more standard way, along the lines of the OpenAPI definition.  MAAS 3.3 begins this process by providing most of the MAAS API functionality in a discover-able form.  You should now be able to easily retrieve human-readable service documentation and API definitions using standard methods.  Consult [the API documentation](https://maas.io/docs/api)`↗` for details.

<a href="#heading--maas-config-settings-ref"><h2 id="heading--maas-config-settings-ref">MAAS configuration settings reference</h2></a>

MAAS 3.3 documentation consolidates configuration settings in one article, in addition to their other mentions throughout the documentation set.

<a href="#heading--Ten-words-or-less-6"><h3 id="heading--Ten-words-or-less-6">Ten words or less</h3></a>

"Settings" now has its own page, and some new options.

<a href="#heading--What-is-new-about-this-update"><h3 id="heading--What-is-new-about-this-update">What is new about this update</h3></a>

MAAS configuration settings are scattered in various (generally relevant) places throughout the documentation, but there has never been one reference page that addresses all settings in one place.  MAAS 3.3 remedies this by adding the [Configuration settings reference](/t/how-to-change-maas-settings/6347).

A minor new feature added with MAAS 3.3 is MAAS site identity, which enables some new configuration parameters:

- MAAS name: The “* MAAS name” is a text box that sets the text which appears at the bottom of every MAAS screen, in front of the version descriptor.

- MAAS name emoji: You may also paste a suitable emoji in front of the MAAS name to help identify it.

- MAAS theme main colour: You may also help identify your MAAS instance by changing the colour of the top bar; several colour choices are available.

These enhancements were made available to assist users who have more than one instance (e.g., production and staging), and have issues with operations accidentally making changes to the wrong instance.

<a href="#heading--Improved-MAAS-event-documentation"><h2 id="heading--Improved-MAAS-event-documentation">Improved MAAS event documentation</h2></a>

MAAS event documentation has been expanded to include [much better explanations](/t/understanding-maas-events/6373) of MAAS events, including many examples.

<a href="#heading--Ten-words-or-less-6"><h3 id="heading--Ten-words-or-less-6">Ten words or less</h3></a>

We've finally documented MAAS events, making them easier to decode.

<a href="#heading--Understanding-MAAS-events"><h3 id="heading--Understanding-MAAS-events">Understanding MAAS events</h3></a>

Events are state changes that happen to MAAS elements, caused by MAAS itself, an external agent, or a users. Understanding events is an essential debugging skill.  But events appear in three different places in MAAS, each presentation providing slightly different information.  These screens are usually dense and hard to search.

In this major documentation update, we've standardised on the MAAS CLI events query command as the best way to review, filter, and summarise events.  We've summarised the six main event types:

 - INFO: the default, used if no level= is specified; shows INFO and ERROR events. A typical INFO event is “Ready”, indicating that a machine has reached the “Ready” state.

 - CRITICAL: critical MAAS failures; shows only CRITICAL events. These events usually represent severe error conditions that should be immediately remedied.

 - ERROR: MAAS errors; shows only ERROR events. Typical ERROR events include such things as power on/off failures, commissioning timeouts, and image import failures.

 - WARNING: failures which may or may not affect MAAS performance; shows WARNING and ERROR events. A typical warning event, for example, might include the inability to find and boot a machine.

 - DEBUG: information which would help debug MAAS behaviour; shows DEBUG and INFO events. Typical DEBUG events involve routine image import activities, for example.

 - AUDIT: information which helps determine settings and user actions in MAAS; shows only AUDIT events. They are covered in more detail elsewhere.

In addition, the new document explains how these event types tend to overlap when queried.  We've also provide detailed instructions on how to use the most common filters:

 - hostname: Only events relating to the node with the matching hostname will be returned. This can be specified multiple times to get events relating to more than one node.

 - mac_address: Only nodes with matching MAC addresses will be returned. Note that MAC address is not part of the standard output, so you’d need to look it up elsewhere.

 - id: Only nodes with matching system IDs will be returned. This corresponds to the node parameter in the JSON listing, not the id parameter there, which is a serial event number.

 - zone: Only nodes in the zone will be returned. Note that zones are not part of the standard output, so you’d need to look these up elsewhere.

 - level: The event level to capture. You can choose from AUDIT, CRITICAL, DEBUG, ERROR, INFO, or WARNING. The default is INFO.

 - limit: Number of events to return. The default is 100, the maximum in one command is 1000.

 - before: Defines an event id to start returning older events. This is the “id” part of the JSON, not the system ID or “node”. Note that before and after cannot be used together, as the results are unpredictable.

 - after: Defines an event id to start returning newer events. This is the “id” part of the JSON, not the system ID or “node”. Note that before and after cannot be used together, as the results are unpredictable.

Since the MAAS CLI returns JSON -- which is hard to humans to parse -- we've included some exemplary `jq` predicates of the form:

```nohighlight
maas $PROFILE events query limit=20 \
| jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

And finally, we provided some detailed usage examples.  For instance, we walked a MAAS machine called `fun-zebra` through the following states:

 - Commissioning
 - Allocation
 - Deployment
 - Releasing
 - Testing (with a premature manual abort)
 - Rescue mode

We used this example command:

```nohighlight
 maas $PROFILE events query level=INFO hostname=fun-zebra limit=1000 | jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | (., map(length*"-"))),(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) | @tsv' | column -t -s$'\t'
```

This gave us a reasonably thorough report of what happened to the machine:

```nohighlight
USERNAME  NODE    HOSTNAME   LEVEL  DATE                        TYPE                   EVENT
--------  ----    --------   -----  ----                        ----                   -----
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:29:53  Exited rescue mode     
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:29:52  Powering off           
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:28:58  Rescue mode            
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:27:18  Loading ephemeral      
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:26:40  Performing PXE boot    
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:26:23  Power cycling          
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:26:23  Entering rescue mode   
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:26:14  Powering off           
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:26:14  Aborted testing        
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:24:08  Performing PXE boot    
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:23:51  Powering on            
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:23:51  Testing                
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:23:38  Released               
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:23:37  Powering off           
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:23:37  Releasing              
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:22:41  Deployed               
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:21:49  Rebooting              
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:18:42  Configuring OS         
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:17:42  Installing OS          
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:17:30  Configuring storage    
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:15:31  Loading ephemeral      
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:14:48  Performing PXE boot    
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:14:31  Powering on            
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 21:14:27  Deploying              
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:04:17  Ready                  
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:04:07  Running test           smartctl-validate on sda
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:01:27  Gathering information  
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:01:10  Loading ephemeral      
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:00:35  Performing PXE boot    
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:00:16  Powering on            
unknown   bk7mg8  fun-zebra  INFO   Thu, 29 Sep. 2022 20:00:16  Commissioning          
```

Additional examples and techniques are provided as part of this new documentation.

<a href="#heading--Improved-MAAS-audit-event-documentation"><h2 id="heading--Improved-MAAS-audit-event-documentation">Improved MAAS audit event documentation</h2></a>

MAAS audit event documentation has been greatly expanded to include [much better explanations](/t/understanding-maas-audit-events/6372) of MAAS audit events, including [detailed examples of how to reconstruct machine life-cycles](/t/how-to-work-with-audit-event-logs/5987#heading--How-to-audit-a-machines-life-cycle-with-audit-events) in the updated version of "[How to work with audit event logs](/t/how-to-work-with-audit-event-logs/5987)".

<a href="#heading--Ten-words-or-less-9"><h3 id="heading--Ten-words-or-less-9">Ten words or less</h3></a>

We've finally offered details about how you should audit MAAS.

<a href="#heading--Understanding-how-audit-events-explain-MAAS-internal-operations"><h3 id="heading--Understanding-how-audit-events-explain-MAAS-internal-operations">Understanding how audit events explain MAAS internal operations</h3></a>

There's probably no limit to what you can figure out if you use audit events properly.  The problems are: (1) a lot goes on in MAAS, and (2) you need more than just the explicit audit events to get a clear picture of what's happening.  We've tried to address this by taking a deeper look at the auditing process (not just the events).  

As you may know, an audit event is just a [MAAS event](/t/understanding-maas-events/6373) tagged with `AUDIT`. It generally captures changes to the MAAS configuration and machine states. These events provide valuable oversight of user actions and automated updates -- and their effects -- especially when multiple users are interacting with multiple machines.  

<a href="#heading--Viewing-events"><h3 id="heading--Viewing-events">Viewing events</h3></a>

Audit events are examined using the MAAS CLI with the `level=AUDIT` parameter set:

```nohighlight
$ maas $PROFILE events query level=AUDIT
```

You'll probably get better results by appending a `jq` filter, to prettify the output:

```nohighlight
$ maas $PROFILE events query level=AUDIT after=0 limit=20 \
| jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

By itself, such a command might produce output similar to this:

```nohighlight
USERNAME  HOSTNAME     DATE                        EVENT
--------  --------     ----                        -----
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 2 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 0 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  block device sda was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  interface enp5s0 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  0 bytes of memory was removed on node 8wmfx3
admin     valued-moth  Thu, 21 Apr. 2022 19:36:48  Started deploying 'valued-moth'.
admin     valued-moth  Thu, 21 Apr. 2022 19:36:21  Acquired 'valued-moth'.
admin     unknown      Thu, 21 Apr. 2022 19:21:46  Updated configuration setting 'completed_intro' to 'True'.
admin     unknown      Thu, 21 Apr. 2022 19:20:49  Updated configuration setting 'upstream_dns' to '8.8.8.8'.
admin     unknown      Thu, 21 Apr. 2022 19:20:49  Updated configuration setting 'maas_name' to 'neuromancer'.
admin     unknown      Thu, 21 Apr. 2022 19:20:47  Updated configuration setting 'http_proxy' to ''.
admin     unknown      Thu, 21 Apr. 2022 19:20:24  Logged in admin.
```

You can, of course, use the [various event filters](/t/understanding-maas-events/6373#heading--filter-parameters) with `level=AUDIT` to further restrict your output.

<a href="#heading--The-meaning-of-audit-events"><h3 id="heading--The-meaning-of-audit-events">The meaning of audit events</h3></a>

Later on in the documentation, we walk through a sample of audit events and demonstrate how to interpret and use them.  This includes detailed examples of various audit event queries, walking through real-world examples to answer questions like:

1. Who deployed `comic-muskox`? 

2. What happened to `sweet-urchin`?

3. Why is `fleet-calf` in rescue mode?

4. Where did these changes come from in `setup.sh`?

5. What caused `ruling-bobcat` to be marked as broken?

6. Who's responsible for the DHCP snippet called `foo`?

<a href="#heading--Auditing-with-finesse"><h3 id="heading--Auditing-with-finesse">Auditing with finesse</h3></a>

As part of the updates to our "[How to work with audit event logs](/t/how-to-work-with-audit-event-logs/5987)", we've tried to offer you some finesse in reconstructing machine life-cycles.  We've shown how to combine various levels of MAAS event queries with standard command line utilities to produce clear audit trails such as this one:

```nohighlight
418606  ERROR    Marking node broken               Wed, 17 Nov. 2021 00:02:52  A Physical Interface requires a MAC address.
418607  DEBUG    Node changed status               Wed, 17 Nov. 2021 00:02:52  From 'New' to 'Broken'
418608  DEBUG    Marking node fixed                Wed, 17 Nov. 2021 00:04:24  
418609  DEBUG    Node changed status               Wed, 17 Nov. 2021 00:04:24  From 'Broken' to 'Ready'
418613  DEBUG    User acquiring node               Wed, 17 Nov. 2021 00:04:51  (admin)
418614  DEBUG    Node changed status               Wed, 17 Nov. 2021 00:04:51  From 'Ready' to 'Allocated' (to admin)
418615  DEBUG    User starting deployment          Wed, 17 Nov. 2021 00:04:51  (admin)
418616  DEBUG    Node changed status               Wed, 17 Nov. 2021 00:04:51  From 'Allocated' to 'Deploying'
418617  INFO     Deploying                         Wed, 17 Nov. 2021 00:04:51  
418618  AUDIT    Node                              Wed, 17 Nov. 2021 00:04:51  Started deploying 'ruling-bobcat'.
418619  INFO     Powering on                       Wed, 17 Nov. 2021 00:04:55  
418625  ERROR    Marking node failed               Wed, 17 Nov. 2021 00:05:32  Power on for the node failed: Failed talking to node's BMC: Failed to power pbpncx. BMC never transitioned from off to on.
418626  DEBUG    Node changed status               Wed, 17 Nov. 2021 00:05:32  From 'Deploying' to 'Failed deployment'
418627  ERROR    Failed to power on node           Wed, 17 Nov. 2021 00:05:32  Power on for the node failed: Failed talking to node's BMC: Failed to power pbpncx. BMC never transitioned from off to on.
```

In this case, we managed to recognise, rather quickly, that no physical interface had been defined for `ruling-bobcat`, hence deployment fails because MAAS can't communicate with the node's BMC.  There are many other issues you can recognise with careful use of MAAS events to audit machine behaviours.  We welcome your feedback on this new documentation endeavour.

<a href="#heading--MAAS-3.3-bug-list"><h2 id="heading--MAAS-3.3-bug-list">MAAS 3.3 bug list</h2></a>

The following sections enumerate the bugs we've fixed in MAAS 3.3.

<a href="#heading--MAAS-3-3-Beta-1-bug-list"><h3 id="heading--MAAS-3-3-Beta-1-bug-list">MAAS 3.3 Beta 1 bug list</h3></a>

So far in MAAS 3.3, we've fixed well over 100 bugs:

- [1762673](https://bugs.launchpad.net/bugs/1762673)`↗`: maas insists on running the proxy, even when it's disabled
- [1802505](https://bugs.launchpad.net/bugs/1802505)`↗`: [ui][2.4][2.5] maas ignores ttl parameter for address records
- [1806707](https://bugs.launchpad.net/bugs/1806707)`↗`: [2.5] Composing a VM with an interface attached to a (macvtap) network (on a KVM host NIC that is not a bridge) resulted in disconnect interface
- [1811109](https://bugs.launchpad.net/bugs/1811109)`↗`: [2.5, UI, RBAC] Normal users can unmount the root file system, but not remount it
- [1818004](https://bugs.launchpad.net/bugs/1818004)`↗`: Slow response in the UI
- [1822640](https://bugs.launchpad.net/bugs/1822640)`↗`: [websocket, UI] Admins should be able to change ownership of resources over the UI
- [1822840](https://bugs.launchpad.net/bugs/1822840)`↗`: [UI, feature] Add ability to edit/delete (manage) tags over the UI
- [1825255](https://bugs.launchpad.net/bugs/1825255)`↗`: TestPostgresListenerService test fails erroneously in CI
- [1826011](https://bugs.launchpad.net/bugs/1826011)`↗`: [UI] Compose machine from pod misaligned message
- [1826789](https://bugs.launchpad.net/bugs/1826789)`↗`: stress-ng-cpu-long times out in bionic
- [1826967](https://bugs.launchpad.net/bugs/1826967)`↗`: Exiting rescue mode shows 'loading ephemeral'
- [1833545](https://bugs.launchpad.net/bugs/1833545)`↗`: After removing a controller rackd still tries to update DNS
- [1840049](https://bugs.launchpad.net/bugs/1840049)`↗`: [UI] When changing configuration of an Interface, one has to enter the config twice
- [1852360](https://bugs.launchpad.net/bugs/1852360)`↗`: Validate network configuration button selects all network scripts that accept an interface parameter
- [1863395](https://bugs.launchpad.net/bugs/1863395)`↗`: 2.6.2 Unable to change power type to manual via UI
- [1871605](https://bugs.launchpad.net/bugs/1871605)`↗`: Updating controller name shouldn't be allowed in the UI
- [1874355](https://bugs.launchpad.net/bugs/1874355)`↗`: Controller details page not updated to match machine details page designs
- [1881948](https://bugs.launchpad.net/bugs/1881948)`↗`: IPv6 address for power control fails
- [1882633](https://bugs.launchpad.net/bugs/1882633)`↗`: Logical volume size is required
- [1883232](https://bugs.launchpad.net/bugs/1883232)`↗`: UI: UI application cached after upgrade
- [1890262](https://bugs.launchpad.net/bugs/1890262)`↗`: UI: Error message with a custom image URL doesn't clear
- [1893226](https://bugs.launchpad.net/bugs/1893226)`↗`: Machine-specific minimal commissioning kernel resets to MAAS wide default
- [1893670](https://bugs.launchpad.net/bugs/1893670)`↗`: UI: display bios_boot_mode in the web UI
- 1898131: IP address gets hidden, instead of subnet when window is resized
- [1905636](https://bugs.launchpad.net/bugs/1905636)`↗`: UI: CentOS 7 is the default over CentOS 8
- [1909348](https://bugs.launchpad.net/bugs/1909348)`↗`: MAAS 2.9.0 DNS zone remove @ labels impossible
- [1913800](https://bugs.launchpad.net/bugs/1913800)`↗`: PCI and USB information missing from controllers page
- [1918963](https://bugs.launchpad.net/bugs/1918963)`↗`: Controllers page out of sync with nodes
- [1918978](https://bugs.launchpad.net/bugs/1918978)`↗`: doesn't detect the subarchitecture xgene-uboot for a HP m400 cartridge
- [1927748](https://bugs.launchpad.net/bugs/1927748)`↗`: Need additional form inputs for DHCP Snippets associated with ipranges
- [1929478](https://bugs.launchpad.net/bugs/1929478)`↗`: Commissioning fails with binary data in IPMI Lan_Conf_Security_Keys
- [1929973](https://bugs.launchpad.net/bugs/1929973)`↗`: "Controllers have different installation sources." is not shown on the controllers page
- [1931654](https://bugs.launchpad.net/bugs/1931654)`↗`: domain.set_default error handling just returns id
- [1933408](https://bugs.launchpad.net/bugs/1933408)`↗`: Setting discovery parent returns cryptic error
- [1938296](https://bugs.launchpad.net/bugs/1938296)`↗`: MAAS 3.0 incorrectly calculates the amount of free space on drive
- [1940909](https://bugs.launchpad.net/bugs/1940909)`↗`: UI: Allow to create a machine as deployed from the UI
- [1951229](https://bugs.launchpad.net/bugs/1951229)`↗`: CLI: Uninformative errors when adding non-existent tags to machines
- [1955671](https://bugs.launchpad.net/bugs/1955671)`↗`: support for rocky linux UEFI
- [1956766](https://bugs.launchpad.net/bugs/1956766)`↗`: UI: Unable to deploy CentOS7 - centos/focal not a supported combination
- [1958817](https://bugs.launchpad.net/bugs/1958817)`↗`: Cannot delete a tag from multiple machines in a bulk with Web UI
- [1959856](https://bugs.launchpad.net/bugs/1959856)`↗`: newly added tags in UI don't show until refresh/page change
- [1960571](https://bugs.launchpad.net/bugs/1960571)`↗`: Domain name should be checked for duplicate against maas_internal_domain
- [1961627](https://bugs.launchpad.net/bugs/1961627)`↗`: confusing UI to add the first network space
- [1964024](https://bugs.launchpad.net/bugs/1964024)`↗`: smartctl-validate test runs even when explicitly removed from commissioning step
- [1965172](https://bugs.launchpad.net/bugs/1965172)`↗`: [3.1] Setting interface into unconfigured does not reset auto-assign IP mode
- [1967577](https://bugs.launchpad.net/bugs/1967577)`↗`: commissioning fails w/ 3.2-beta1: "please fill out the field"
- [1970803](https://bugs.launchpad.net/bugs/1970803)`↗`: CLI event filters give extraneous results with more than one filter
- [1971152](https://bugs.launchpad.net/bugs/1971152)`↗`: Authentication broken with MASS using Candid
- [1973236](https://bugs.launchpad.net/bugs/1973236)`↗`: MAAS reports failure to detect storage that it already detected
- [1973617](https://bugs.launchpad.net/bugs/1973617)`↗`: refresh a lxd KVM host resources after it was added
- [1976194](https://bugs.launchpad.net/bugs/1976194)`↗`: init rack can't find secrets
- [1976196](https://bugs.launchpad.net/bugs/1976196)`↗`: Controller WebSocket handler contains unimplemented methods
- [1977820](https://bugs.launchpad.net/bugs/1977820)`↗`: Some tests are skipped due to the "perf" filtering
- [1977822](https://bugs.launchpad.net/bugs/1977822)`↗`: ERROR: Redfish 'Redfish' object has no attribute '_get_network_interface'
- [1977864](https://bugs.launchpad.net/bugs/1977864)`↗`: 30-maas-01-bmc-config: ERROR: Redfish string indices must be integers
- [1977866](https://bugs.launchpad.net/bugs/1977866)`↗`: 30-maas-01-bmc-config: ERROR: 169.254.95.120/16 has host bits set
- [1977895](https://bugs.launchpad.net/bugs/1977895)`↗`: Certificate metadata missing from controller websocket model
- [1977942](https://bugs.launchpad.net/bugs/1977942)`↗`: 30-maas-01-bmc-config: ERROR: Redfish 'Redfish' object has no attribute '_bmc_config'
- [1977951](https://bugs.launchpad.net/bugs/1977951)`↗`: 30-maas-01-bmc-config: ERROR: Redfish nonnumeric port: 'None'
- [1978024](https://bugs.launchpad.net/bugs/1978024)`↗`: maas auto-creates interface name for docker bridge on controller, which breaks bind
- [1978037](https://bugs.launchpad.net/bugs/1978037)`↗`: Drop legacy /l/ UI prefix
- [1978072](https://bugs.launchpad.net/bugs/1978072)`↗`: 30-maas-01-bmc-config: ERROR: Redfish 'dict' object has no attribute 'split'
- [1978121](https://bugs.launchpad.net/bugs/1978121)`↗`: 30-maas-01-bmc-config: ERROR: ERROR: Unable to add BMC user!
- [1978154](https://bugs.launchpad.net/bugs/1978154)`↗`: MAAS 3.1 introduces breaking changes for custom centos7 images
- [1978922](https://bugs.launchpad.net/bugs/1978922)`↗`: MAAS 3.1 - Missing button "Create datastore" in VMFS7 storage layout
- [1979039](https://bugs.launchpad.net/bugs/1979039)`↗`: TLS certificates are not recognised by CLI maas <profile> boot-resources create action
- [1979256](https://bugs.launchpad.net/bugs/1979256)`↗`: Add config option for UI theme
- [1979316](https://bugs.launchpad.net/bugs/1979316)`↗`: UI stuck at the initial configuration page
- [1979317](https://bugs.launchpad.net/bugs/1979317)`↗`: Initial configuration form doesn't allow proxy URL with hostname
- [1980347](https://bugs.launchpad.net/bugs/1980347)`↗`: MAAS snap fails to parse supervisor STOPPING state
- [1980436](https://bugs.launchpad.net/bugs/1980436)`↗`: MAAS CLI with anonymous access fails when TLS is enabled
- [1980490](https://bugs.launchpad.net/bugs/1980490)`↗`: MAAS regiond IPC crash due to a machine-resources binary crash when parsing some VPDs
- [1980818](https://bugs.launchpad.net/bugs/1980818)`↗`: Configure DHCP for VLAN
- [1980846](https://bugs.launchpad.net/bugs/1980846)`↗`: IP Address tooltip on Machines page blocks access to everything underneath and doesnt disappear until mouse-off
- [1981536](https://bugs.launchpad.net/bugs/1981536)`↗`: volume group creation fails on md device - MAAS 3.2
- [1981560](https://bugs.launchpad.net/bugs/1981560)`↗`: upgrade from 3.1 to 3.2 using debian packages missing steps
- [1982208](https://bugs.launchpad.net/bugs/1982208)`↗`: agent.yaml.example is missing when maas is installed via deb package
- [1982315](https://bugs.launchpad.net/bugs/1982315)`↗`: MAAS not sending correct metadata_url
- [1982328](https://bugs.launchpad.net/bugs/1982328)`↗`: update docstring to include informative not found change
- [1982846](https://bugs.launchpad.net/bugs/1982846)`↗`: Missing update_interface method on controller websocket handler
- [1982866](https://bugs.launchpad.net/bugs/1982866)`↗`: MAAS Breaks historical custom images
- [1982984](https://bugs.launchpad.net/bugs/1982984)`↗`: reverse-proxy service is not displayed for region controller
- [1983624](https://bugs.launchpad.net/bugs/1983624)`↗`: Fresh MAAS 3.2 install failed to find controller
- [1984141](https://bugs.launchpad.net/bugs/1984141)`↗`: duplicate tag results in failed deployment for KVM host
- [1984852](https://bugs.launchpad.net/bugs/1984852)`↗`: machine.filter_options returns empty, duplicate and mis-typed options
- [1984994](https://bugs.launchpad.net/bugs/1984994)`↗`: machine.list fails for some group_key values
- [1985741](https://bugs.launchpad.net/bugs/1985741)`↗`: Commissioning script 'maas-kernel-cmdline' fails with bonded interfaces
- [1986372](https://bugs.launchpad.net/bugs/1986372)`↗`: UI: Setting Default minimum kernel version for commissioning blocks deployments
- [1987874](https://bugs.launchpad.net/bugs/1987874)`↗`: interface.update_ip_addresses raise an Exception when exsits multiple StaticIPAddress
- [1988543](https://bugs.launchpad.net/bugs/1988543)`↗`: VM Discovery fails, resulting in " Error: An architecture is required." when composing a LXD VM
- [1988759](https://bugs.launchpad.net/bugs/1988759)`↗`: Provisioning LXD vmhost fails
- [1988769](https://bugs.launchpad.net/bugs/1988769)`↗`: The ppc64 machine in our lab fails during commissioning
- [1988874](https://bugs.launchpad.net/bugs/1988874)`↗`: Release command is failing for ppc64 machine in our lab
- [1989949](https://bugs.launchpad.net/bugs/1989949)`↗`: provisioningserver TestGetSourceAddress.test_returns_none_if_no_route_found sometimes fails locally
- [1989970](https://bugs.launchpad.net/bugs/1989970)`↗`: Can't enlist machines on subnets with DNS set
- [1989974](https://bugs.launchpad.net/bugs/1989974)`↗`: rackd fails on CIS-hardened machine with "Failed to update and/or record network interface configuration: Expecting value: line 1 column 1 (char 0)"
- [1990014](https://bugs.launchpad.net/bugs/1990014)`↗`: regiond.conf "debug_http: true" causes image downloads from regiond to fail with 500 error code
- [1990649](https://bugs.launchpad.net/bugs/1990649)`↗`: Kernel parameters form resets to previous value after save
- [1990873](https://bugs.launchpad.net/bugs/1990873)`↗`: TestKeys - test_get_launchpad_crashes_for_user_not_found
- [1991106](https://bugs.launchpad.net/bugs/1991106)`↗`: vCenter password field text is visible in settings
- [1991210](https://bugs.launchpad.net/bugs/1991210)`↗`: Color theme resets with page reload
- [1991229](https://bugs.launchpad.net/bugs/1991229)`↗`: Selecting all machines in a state in the UI causes traceback in backend
- [1991372](https://bugs.launchpad.net/bugs/1991372)`↗`: websocket config update notifications are no longer sent
- [1991410](https://bugs.launchpad.net/bugs/1991410)`↗`: wildcard DNS entry is not allowed
- [1991792](https://bugs.launchpad.net/bugs/1991792)`↗`: machine.action clone does not accept filter
- [1991795](https://bugs.launchpad.net/bugs/1991795)`↗`: machine.action does not always throw errors for failed machines
- [1992332](https://bugs.launchpad.net/bugs/1992332)`↗`: websocket machine.list parent group label should return hostname
- [1992686](https://bugs.launchpad.net/bugs/1992686)`↗`: MAAS 3.3 alpha missing two existing filters
- [1992975](https://bugs.launchpad.net/bugs/1992975)`↗`: Grouping by parents fails if there's more than one page

More bug-fixes are planned for later 3.3 releases.

<a href="#heading--MAAS-3-3-Beta-2-bug-list"><h3 id="heading--MAAS-3-3-Beta-2-bug-list">MAAS 3.3 Beta 2 bug list</h3></a>

- [1990289](https://bugs.launchpad.net/bugs/1990289)`↗`: allocate call with system_id can allocate a new machine
- [1991784](https://bugs.launchpad.net/bugs/1991784)`↗`: [needs-packaging] GL Excess
- [1992185](https://bugs.launchpad.net/bugs/1992185)`↗`: unable to deploy a machine with vmhost if a bond interface was created
- [1992494](https://bugs.launchpad.net/bugs/1992494)`↗`: Jammy KVM host support
- [1992791](https://bugs.launchpad.net/bugs/1992791)`↗`: Info icons appear/disappear based on checked options in subnet page
- [1993289](https://bugs.launchpad.net/bugs/1993289)`↗`: Pod storage pool path can't be blank

<a href="#heading--MAAS-3-3-Beta-3-bug-list"><h3 id="heading--MAAS-3-3-Beta-3-bug-list">MAAS 3.3 Beta 3 bug list</h3></a>

- [1835271](https://bugs.launchpad.net/bugs/1835271)`↗`: Ephemeral deployment keeps cloud-inits autogenerated netplan config
- [1843268](https://bugs.launchpad.net/bugs/1843268)`↗`: maas become unresponsive with maasserver_notification stuck at concurrent update
- [1886045](https://bugs.launchpad.net/bugs/1886045)`↗`: Error message mentions Pods when trying to release a machine
- [1886850](https://bugs.launchpad.net/bugs/1886850)`↗`: Encrypt the BMC credentials
- [1937138](https://bugs.launchpad.net/bugs/1937138)`↗`: Calling mark_intro_complete doesn't respond correctly
- [1955709](https://bugs.launchpad.net/bugs/1955709)`↗`: Metadata field may_reboot not working correctly in 20.04
- [1988229](https://bugs.launchpad.net/bugs/1988229)`↗`: dhcp snippet create fails when dhcp subnet is relayed regression
- [1990383](https://bugs.launchpad.net/bugs/1990383)`↗`: Link subnet on new machine
- [1992330](https://bugs.launchpad.net/bugs/1992330)`↗`: Use the rack controller IP as DNS when relaying DHCP
- 1993032: maas_hardware_sync creds are readable to local users on deployed OS and can give a super user access to MAAS itself
- [1993152](https://bugs.launchpad.net/bugs/1993152)`↗`: Updating a VM host through API unset tags
- [1994899](https://bugs.launchpad.net/bugs/1994899)`↗`: MAAS cannot mark "broken" VMs as fixed without recommissioning
- [1995397](https://bugs.launchpad.net/bugs/1995397)`↗`: Sentry blocked by CORS
- [1995624](https://bugs.launchpad.net/bugs/1995624)`↗`: suppressing script results no longer available on machine listing
- [1996065](https://bugs.launchpad.net/bugs/1996065)`↗`: CLI errors when redirecting the output to a file
- [1996074](https://bugs.launchpad.net/bugs/1996074)`↗`: Machine details stuck at "Loading" for machines with no disks
- [1996419](https://bugs.launchpad.net/bugs/1996419)`↗`: renaming a DNS record to a previous name fails with error: list.remove(x): x not in list
- [1996935](https://bugs.launchpad.net/bugs/1996935)`↗`: agent.yaml.example is missing when maas is installed via snap
- [1997190](https://bugs.launchpad.net/bugs/1997190)`↗`: Power parameters access attempt from non-db thread 
- [1997191](https://bugs.launchpad.net/bugs/1997191)`↗`: Uncaught exception when configuring DNS
- [1997281](https://bugs.launchpad.net/bugs/1997281)`↗`: machine.count fails for new filter options
- [1997599](https://bugs.launchpad.net/bugs/1997599)`↗`: Losing LXD certificate 
	
<a href="#heading--MAAS-3-3-RC1-bug-list"><h3 id="heading--MAAS-3-3-RC1-bug-list">MAAS 3.3 RC1 bug list</h3></a>

- [1997975](https://bugs.launchpad.net/maas/+bug/1997975)`↗`: Update grafana_agent/agent.yaml.example

<a href="#heading--MAAS-3-3-RC3-bug-list"><h3 id="heading--MAAS-3-3-RC3-bug-list">MAAS 3.3 RC3 bug list</h3></a>

- [1990172](https://bugs.launchpad.net/maas/+bug/1990172)`↗`: "20-maas-03-machine-resources" commissioning script improperly reports a Pass when the test fails 

<a href="#heading--other-maas-versions"><h2 id="heading--other-maas-versions">Release notes for other MAAS versions</h2></a>

Here are release notes for other relatively recent MAAS versions:

- [MAAS 3.2](https://maas.io/docs/what-is-new-with-maas-3-2)`↗`
- [MAAS 3.1](https://maas.io/docs/what-is-new-with-maas-3-1)`↗`
- [MAAS 3.0](https://maas.io/docs/what-is-new-with-maas-3-0)`↗`
- [MAAS 2.9](https://maas.io/docs/what-is-new-with-maas-2-9)`↗`
- [MAAS 2.8](https://maas.io/docs/what-is-new-with-maas-2-8)`↗`
- [MAAS 2.7](https://maas.io/docs/what-is-new-with-maas-2-7)`↗`