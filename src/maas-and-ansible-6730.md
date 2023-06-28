<!-- MAAS and ansible -->
A user should probably have a solid grasp of the Ansible standard terminology:

- Playbooks / plays
- Hosts and groups
- Inventory

[Ansible](https://www.redhat.com/en/technologies/management/ansible/what-is-ansible)`↗` is a sophisticated IT automation tool that allows users to set up [playbooks](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html)`↗`, which automate complex, repetitive (or error-prone)`↗` setup activities.  While we won't provide a detailed tutorial on Ansible here, there is a bit of terminology you should master before trying to use Ansible with MAAS:

- **[Modules](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html#modules)`↗`** are binaries (or even pieces of code)`↗` that Ansible can run on a managed node.  These modules can be grouped into named collections.
- **[Tasks](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html#tasks)`↗`** are individual operations with one or more modules; each task generally accomplishes some otherwise-human-driven function, such as "partition and format /sda".
- **[Plays](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html#plays)`↗`** are sequences of tasks that Ansible will execute to accomplish larger operations, e.g., "install the OS" ==> "partition and format /sda", "install binary x.7.iso", etc.
- **[Playbooks](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html)`↗`** are YAML files that run plays in a specific order; for example, "install the OS", "install MAAS", "create a region controller", "sync images", etc.
- **[Inventory](https://docs.ansible.com/ansible/latest/network/getting_started/basic_concepts.html#id3)`↗`** is a source(s)`↗` of managed nodes; also called a "hostfile".

These simple descriptions do not fully explain the terms, so it is worthwhile to consult the referenced links, if necessary, before proceeding.  You will also want to understand how Ansible uses the terms "[hosts and groups](https://docs.ansible.com/ansible/latest/user_guide/intro_patterns.html)`↗`", since these are applied somewhat differently than we use them in MAAS.

Playbooks are available to automate the setup for:

- [MAAS region controllers](#heading--MAAS-region-controller): install and configure a MAAS region on a targeted host; running the playbook on hosts with a MAAS region will upgrade it.

- [MAAS rack controllers](#heading--MAAS-rack-controller): install and configure a MAAS rack.

- [MAAS de-installation](#heading--MAAS-de-installation): remove MAAS from a targeted host.

- [MAAS high availability](#heading--MAAS-high-availability): install and configure the HA proxy.

- [PostgreSQL primary role](#heading--PostgreSQL-primary-role): setup the postgres primary role.

- [PostgreSQL secondary role](#heading--PostgreSQL-secondary-role): setup the postgres secondary role.

- [Firewall rules](#heading--Firewall-rules): setup firewall rules.

MAAS Playbooks will eventually be available through Ansible Galaxy.

There is also a set of groups that will automate setting up specific sections of MAAS.  For example, there is a PostgreSQL group that sets up the primary and secondary PostgreSQL roles, bypassing the need to run both playbooks individually.  These groups include:

- [PostgreSQL role bundling scripts](#heading--PostgreSQL-role-bundling-scripts)
- ?? (there must be more, huh?)

After installing ansible, running each of the playbooks on a blank machine will have a fresh install of MAAS ready to go. For example, running the region+rack will setup a region+rack on the host machine.

<a href="#heading--Running-a-MAAS-Ansible-playbook"><h2 id="heading--Running-a-MAAS-Ansible-playbook">Running a MAAS Ansible playbook</h2></a>

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

A command of this form will run all of the plays below (i.e., the entire playbook).  If you want to run the tasks for one particular role (or roles), you can use the form  `--tags <target role(s)>` to limit which parts of the MAAS Ansible playbook run.  Consult the Ansible documentation for more details on additional options and command structure.

<a href="#heading--MAAS-region-controller"><h2 id="heading--MAAS-region-controller">MAAS region controller</h2></a>

As an operator, you want want to install a MAAS region controller onto a given host using Ansible.  To accomplish this, you must:

- [set a maas_region_controller](#heading--Setting-the-maas_region_controller-role) role on a given host, 
- [run the region controller playbook](#heading--Running-the-region-controller-playbook),
- and [find the newly-configured region controller](#heading--Finding-the-new-region-controller) present on that host .

<a href="#heading--Setting-the-maas_region_controller-role"><h3 id="heading--Setting-the-maas_region_controller-role">Setting the maas_region_controller role</h3></a>

To attach roles to hosts, a user adds each role to their [Inventory file](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#inventory-basics-formats-hosts-and-groups)`↗` in the form of either an INI or a YAML file where each role is followed by the addresses of each host to attach the role to. The example  below attaches the region controller role to a host running on `10.10.0.20` with the user `ubuntu`:*

INI:
```INI
[maas_region_controller]
10.10.0.20 ansible_user=ubuntu
```
YAML:
```YAML
all:
  maas_region_controller:
    hosts:
      10.10.0.20:
        ansible_user: ubuntu
```

<a href="#heading--Running-the-region-controller-playbook"><h3 id="heading--Running-the-region-controller-playbook">Running the region controller playbook</h3></a>

When running the playbook for a host with the maas_region_controller role, the playbook installs the MAAS region controller.  The documented ansible variable `maas_installation_type` provides the user with the ability to set whether it’s a deb installation or a snap installation, along with additional variables for MAAS version, snap channel and/or PPA. 

The default installation is a snap.  A successful run of the playbook should give the operator an accessible and ready MAAS instance.  Some notes on installation:

- The installed region controller is used to set a maas_url variable when there is not one already set for later Rack Controller configuration use.
- The operator can optionally enable TLS.
- The playbook sets up the admin user.
- The playbook adds any provided preseeds.
- The playbook only installs the maas-region-api deb if the operator chooses the deb installation.
- Once the region controller is installed, the playbook will run migrations using the configured postgresql primary instance.
- Running on an already configured machine -- but with a new version -- should upgrade the instance.
- The operator can override the postgres DSN variable on any machine (hence not setting `maas_postgres_primary` or `maas_postgres_secondary`) to use an existing PostgreSQL instance not managed by this playbook.
- Optionally, the user can install a grafana agent by setting the variable `install_metrics=true` either in the hosts or on the command line.

`[MAAS_Region_Controller]` variables:
```
maas_version: "latest"          # The version of MAAS to install on the host
maas_installation_type: "snap"  # The installation manager to use
maas_snap_channel: "stable"     # The snap channel, if using snap
maas_url: $Ip_Address           # The url of the database for this MAAS
enable_tls: false               # Whether TLS should be enabled for this MAAS
install_metrics: false          # Whether metrics should be enabled for this MAAS

# Details for the administrative account
admin_username: "admin"
admin_password: "admin"
admin_email: "admin@email.com"
admin_id: "admin"
```
These variables can be defined in the `Hosts` file above, or at the command line using the `--extra_vars` argument.

The playbook uses an ansible variable to determine what version of MAAS to deploy.  The playbook won’t execute (i.e “skipped” in the context of Ansible) if `host_vars` show the Ubuntu version is incompatible with the version and install method.  The Region Controller tasks should be able to execute on multiple hosts in a single execution if the target is an Ansible Group rather than a single host.

<a href="#heading--Finding-the-new-region-controller"><h3 id="heading--Finding-the-new-region-controller">Finding the new region controller</h3></a>

The newly-installed region controller should be accessible at the specified host ip address, as though the controller had been installed manually.

<a href="#heading--MAAS-rack-controller"><h2 id="heading--MAAS-rack-controller">MAAS rack controller</h2></a>

As an operator, you want to install a MAAS rack controller to a given host, using Ansible. To accomplish this, you must: 

- [set a maas_rack_controller role](#heading--Setting-the-maas_rack_controller-role) on a given host, 
- [run the playbook](#heading--Running-the-rack-controller-playbook), 
- and [find the newly-configured rack controller](#heading--Finding-the-new-rack-controller), now present on the host.

<a href="#heading--Setting-the-maas_rack_controller-role"><h3 id="heading--Setting-the-maas_rack_controller-role">Setting the maas_rack_controller role</h3></a>

Assigning a host the `maas_rack_controller` role is straightforward. The role is given a set of hosts in the `hosts` file of the ansible configuration:

INI
```INI
[$role]
$Host_Ip_Address extra_variable=$Variable_Value
$Second_Host_Ip
```
YAML
```
all:
  $role:
    hosts:
      $Host_Ip_Address:
        extra_variable: $Variable_Value
      $Second_Host_Ip
```

<a href="#heading--Running-the-rack-controller-playbook"><h3 id="heading--Running-the-rack-controller-playbook">Running the rack controller playbook</h3></a>

When running the playbook for a host with the `maas_rack_controller` role, the playbook installs the MAAS Rack Controller. The `maas_url` variable is used to connect the Region Controller(s), either previously configured from a Region Controller install task, or provided by the user. If the `maas_url` variable is not set, the Rack Controller tasks are “skipped”.  Some notes about the installation:

- The operator can optionally enable TLS.
- The rack controller tasks should be able to execute on multiple hosts in a single execution if an Ansible Group is targeted rather than a single host.
- Only install the maas-rack-controller deb if using the deb installation.
- Running on an already configured machine but with a new version should upgrade the instance.
- You can optionally install a grafana agent by setting the `install_metrics` variable to `true` either in the hosts file or at the command line.

`[MAAS_Rack_Controller]` Variables
```bash
maas_version: "latest"          # The version of MAAS to install on the host
maas_installation_type: "snap"  # The installation manager to use
maas_snap_channel: "stable"     # The snap channel, if using snap
maas_url: $Ip_Address           # The url of the database for this MAAS
maas_rack_secret:               # The secret used to enroll a MAAS rack
enable_tls: false               # Whether TLS should be enabled for this MAAS
install_metrics: false          # Whether metrics should be enabled for this MAAS
```

<a href="#heading--Finding-the-new-rack-controller"><h3 id="heading--Finding-the-new-rack-controller">Finding the new rack controller</h3></a>

The rack controller should be accessible at the specified host IP address, just as if you had installed it there manually.

<a href="#heading--MAAS-de-installation"><h3 id="heading--MAAS-de-installation">MAAS de-installation</h3></a>

As an operator, you want to be able to revert the MAAS setup installed by this playbook, such that the machine is clean of all MAAS packages or snaps.  In order to teardown a MAAS deployment, you can run a separate entry-point within the playbook to teardown the installed MAAS packages or snaps.  This entry-point is provided in the playbook to remove the installation that the default entry-point provides: Running this playbook with the default configuration with perfectly undo the default installation.

You must [back up](/t/how-to-back-up-maas/5096) the database and MAAS configuration, if desired.  The target machine is restored state prior to installation, with no MAAS, directories, or files present on the system.

<a href="#heading--MAAS-high-availability"><h3 id="heading--MAAS-high-availability">MAAS high availability</h3></a>

As an operator, you want to install a reverse proxy and configure high-availability region controllers for a given host using Ansible.  Note that HA region controllers require an HAProxy configuration. You can accomplish this with the following steps:

- [set the maas_cluster_proxy](#heading--Set-the-maas_cluster_proxy),
- [have Ansible install and configure HAProxy](#heading--Use-Ansible-to-configure-HAProxy) on the designated instances, 
- and [verify that the HAProxy is forwarding traffic](#heading--Verify-HAProxy-forwarding) to the region controllers.
 
Ansible configures the HAProxy instance for optimal use, such that OS images can be uploaded, for example. An unresponsive Region Controller is taken out of the upstream pool quickly.
The HAProxy instance does not interfere with Nginx/MAAS TLS configuration

<a href="#heading--Set-the-maas_proxy"><h3 id="heading--Set-the-maas_proxy">Set the maas_proxy role</h3></a>

Set the following in the `hosts` file to set the `maas_proxy` role:

```nohighlight
maas_proxy
my.host ansible_user=ssh_user
```

For example, on a host called "neuromancer" with an SSH-capable user called "stormrider", this YAML would be:

```nohighlight
maas_proxy
neuromancer ansible_user=stormrider
```

<a href="#heading--Use-Ansible-to-configure-HAProxy"><h3 id="heading--Use-Ansible-to-configure-HAProxy">Use Ansible to configure HAProxy</h3></a>

Run the full playbook, or add `--tags <target role(s)>` to run only the tasks for a given role.

<a href="#heading--Verify-HAProxy-forwarding"><h3 id="heading--Verify-HAProxy-forwarding">Verify HAProxy forwarding</h3></a>

You can verify the HAProxy forwarding by running `curl -L http://<haproxy host>:5240/MAAS` if HAProxy is on a separate host from the region controller; otherwise, change the port number to 5050 like this:

```nohighlight
curl -L http://<haproxy hostd>:5050/MAAS
```

<a href="#heading--PostgreSQL-primary-role"><h2 id="heading--PostgreSQL-primary-role">PostgreSQL primary role</h2></a>

As an operator, you want to install a Postgresql database as a primary to a given host using Ansible. You can accomplish this with the following steps:

- [set the maas_postgresql_primary role](#heading--Set-the-maas_postgresql_primary-role) on a host, 
- [have Ansible install a readable and writable PostgreSQL instance](#heading--Use-Ansible-to-install-a-postgres-instance), with optimal configuration for MAAS,
- [verify that the PostgreSQL instance is working properly](#heading--Verify-the-PostgreSQL-instance).
 
Ansible installs the latest supported version of PostgreSQL supported for the given MAAS version. **Do they select the MAAS version?  How does it know?**  If the playbook runs with other roles set on targeted hosts / groups, the tasks associated with the maas_postgresql_primary role runs first. If the operator sets a variable for importing a backup, the backup is loaded into PostgreSQL. ** How do they set this variable?  What is the variable?**

<a href="#heading--Set-the-maas_postgres_primary-role"><h3 id="heading--Set-the-maas_postgres_primary-role">Set the maas_postgres_primary role</h3></a>

Set the following in the `hosts` file to set the `maas_postgres_primary` role:

```nohighlight
maas_postgres_primary
my.host ansible_user=ssh_user
```

For example, on a host called "neuromancer" with an SSH-capable user called "stormrider", this YAML would be:

```nohighlight
maas_postgres_primary
neuromancer ansible_user=stormrider
```

<a href="#heading--Use-Ansible-to-install-a-postgres-instance"><h3 id="heading--Use-Ansible-to-install-a-postgres-instance">Use Ansible to install a postgres instance</h3></a>

Run the full playbook, or add `--tags <target role(s)>` to run only the tasks for a given role.

<a href="#heading--Verify-the-PostgreSQL-instance"><h3 id="heading--Verify-the-PostgreSQL-instance">Verify the PostgreSQL instance</h3></a>

You can verify the primary by running `sudo -u postgres psql` and making sure you get a prompt.

<a href="#heading--PostgreSQL-secondary-role"><h2 id="heading--PostgreSQL-secondary-role">PostgreSQL secondary role</h2></a>

As an operator, you want to install a PostgreSQL database as a secondary for a given host using Ansible. You can accomplish this with the following steps:

- set the maas_postregresql_secondary role on a host,
- have Ansible install a readable PostgreSQL instance, with an optimal configuration, set as a failover instance,
- and verify that the failover instance works properly.

Ansible installs the latest supported version of PostgreSQL for the given MAAS version that’s available for the host’s Ubuntu series in the Ubuntu repo. (**need a clearer way to say this**). 

If the playbook runs with other roles set on targeted hosts / groups, the tasks associated with the maas_postgresql_secondary role runs after maas_postgresql_primary but before any other roles.  The configured secondary from this role replicates from a primary PostgreSQL instance created from the maas_postgresql_primary role.

Automated failover is configured manually, external to this playbook. Manual failover can be achieved by a separate set of tasks for the maas_postgresql_secondary role, which once successful, changes the machine’s role to a maas_postgresql_primary and its configuration reflects that.

<a href="#heading--Set-the-maas_postregres_secondary-role-"><h3 id="heading--Set-the-maas_postregres_secondary-role-">Set the maas_postregres_secondary role </h3></a>

Set the following in the `hosts` file to set the `maas_postgres_secondary` role:

```nohighlight
maas_postgres_secondary
my.host ansible_user=ssh_user
```

For example, on a host called "neuromancer" with an SSH-capable user called "stormrider", this YAML would be:

```nohighlight
maas_postgres_secondary
neuromancer ansible_user=stormrider
```

<a href="#heading--Use-Ansible-to-install-PostgreSQL-failover-instance"><h3 id="heading--Use-Ansible-to-install-PostgreSQL-failover-instance">Use Ansible to install PostgreSQL failover instance</h3></a>

Run the full playbook, or add `--tags <target role(s)>` to run only the tasks for a given role.

<a href="#heading--Verify-that-the-failover-instance-works-properly"><h3 id="heading--Verify-that-the-failover-instance-works-properly">Verify that the failover instance works properly</h3></a>

You can verify the primary by running `sudo -u postgres psql`; when you get a prompt, enter `select * from pg_stat_replication;`.  This should return a list of all secondaries connected to that primary.

<!--
<a href="#heading--Firewall-rules"><h2 id="heading--Firewall-rules">Firewall rules</h2></a>

As a operator, you want to be able to setup MAAS in a secure way, following best practices and operational guidance on securing MAAS. In order to make a MAAS setup secure, I would Ansible playbooks to configure firewalls and file permissions based on https://maas.io/docs/how-to-secure-maas.

 
<a href="#heading--PostgreSQL-role-bundling-scripts"><h2 id="heading--PostgreSQL-role-bundling-scripts">PostgreSQL role bundling scripts</h2></a> -->
