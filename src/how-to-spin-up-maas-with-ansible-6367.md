<!-- "How to spin up MAAS with Ansible" -->

<a href="#heading--MAAS-region-controller"><h2 id="heading--MAAS-region-controller">How to install a region controller with Ansible</h2></a>

As an operator, you want want to install a MAAS region controller onto a given host using Ansible.  To accomplish this, you must:

1. Attach the `maas_region_controller` role to your region controller host by adding the following to the [Inventory file](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html#inventory-basics-formats-hosts-and-groups)`↗`.   In the example below, we've attached the region controller role to a host running on `10.10.0.20` with the user `ubuntu`:

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

2. Set the following Ansible variables in the `Hosts` file:

`[MAAS_Region_Controller]` variables:
```
maas_version: "latest"          # The version of MAAS to install on the host
maas_installation_type: "snap"  # The installation manager to use
maas_snap_channel: "stable"     # The snap channel, if using snap
maas_url: $Ip_Address           # The url of the database for this MAAS
enable_tls: false               # Whether TLS should be enabled for this MAAS
install_metrics: false          # Whether metrics should be enabled (i.e., Grafana agent installed) for this MAAS

# Details for the administrative account
admin_username: "admin"
admin_password: "admin"
admin_email: "admin@email.com"
admin_id: "admin"
```

3. Run the playbook to install the region controller.  A successful run of the playbook should give the operator an accessible and ready MAAS instance.

Some important notes on installation:

- The default installation is a snap.
- The installed region controller is used to set a `maas_url` variable when there is not one already set for later Rack Controller configuration use.
- The operator can optionally enable TLS.
- The playbook sets up the admin user.
- The playbook adds any provided preseeds.
- The playbook only installs the `maas-region-api` deb if the operator chooses the deb installation.
- Once the region controller is installed, the playbook will run migrations using the configured postgresql primary instance.
- Running on an already configured machine -- but with a new version -- should upgrade the instance.
- The operator can override the postgres DSN variable on any machine (hence not setting `maas_postgres_primary` or `maas_postgres_secondary`) to use an existing PostgreSQL instance not managed by this playbook.
- These variables can be also be defined at the Ansible command line using the `--extra_vars` argument.
- The playbook uses an ansible variable to determine what version of MAAS to deploy.  The playbook won’t execute (i.e “skipped” in the context of Ansible) if `host_vars` show the Ubuntu version is incompatible with the version and install method.  
- The Region Controller tasks should be able to execute on multiple hosts in a single execution if the target is an Ansible Group rather than a single host.

<a href="#heading--Finding-the-new-region-controller"><h3 id="heading--Finding-the-new-region-controller">Finding the new region controller</h3></a>

You can find the newly-installed region controller at the specified MAAS host IP address, as though the controller had been installed manually.

<a href="#heading--MAAS-rack-controller"><h2 id="heading--MAAS-rack-controller">How to install a rack controller with Ansible</h2></a>

As an operator, you want to install a MAAS rack controller to a given host, using Ansible. To accomplish this, you must: 

1. Assign a host to the `maas_rack_controller` role in the Ansible `hosts` file:

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

2. Set the following Ansible variables in the `Hosts` file:

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

3. Run the Ansible playbook to install the region controller.

Some notes about installation:

- When running the playbook for a host with the `maas_rack_controller` role, the playbook installs the MAAS Rack Controller on the specified hostd. 
- The `maas_url` variable is used to connect the Region Controller(s), either previously configured from a Region Controller install task, or provided by the user. 
- If the `maas_url` variable is not set, the Rack Controller tasks are “skipped”.  Some notes about the installation:
- The operator can optionally enable TLS.
- The rack controller tasks should be able to execute on multiple hosts in a single execution if an Ansible Group is targeted rather than a single host.
- Only install the maas-rack-controller deb if using the deb installation.
- Running on an already configured machine but with a new version should upgrade the instance.
- You can optionally install a grafana agent by setting the `install_metrics` variable to `true` either in the hosts file or at the command line.

<a href="#heading--Finding-the-new-rack-controller"><h3 id="heading--Finding-the-new-rack-controller">Finding the new rack controller</h3></a>

The rack controller should be accessible at the specified host IP address, just as if you had installed it there manually.

<a href="#heading--MAAS-de-installation"><h3 id="heading--MAAS-de-installation">How to uninstall MAAS with Ansible</h3></a>

As an operator, you want to be able to revert the MAAS setup installed by this playbook, such that the machine is clean of all MAAS packages or snaps.  In order to teardown a MAAS deployment, do the following:

1. Find the entry-point within the playbook to teardown the installed MAAS packages or snaps.  

2. Back up the database and MAAS configuration, if desired.  Note taht the target machine is restored state prior to installation, with no MAAS, directories, or files present on the system.

3. Run the playbook from this entry-point to remove the installation.

Running this playbook with the default configuration with perfectly undo the default installation.

<a href="#heading--MAAS-high-availability"><h3 id="heading--MAAS-high-availability">How to configure MAAS HA with Ansible</h3></a>

As an operator, you want to install a reverse proxy and configure high-availability region controllers for a given host using Ansible.  Note that HA region controllers require an HAProxy configuration. 

You can accomplish this with the following steps:

1. Set the following in the `hosts` file to set the `maas_proxy` role:

```nohighlight
maas_proxy
my.host ansible_user=ssh_user
```
2. Run the full playbook, or add `--tags <target role(s)>` to run only the tasks for a given role.

3. Verify that the HAProxy is forwarding traffic by running the following if HAProxy is on a separate host from the region controller:

```nohighlight
curl -L http://<haproxy host>:5240/MAAS`
```

4. If HAProxys is not on a separate host, change the port number to 5050 when you run the command, like this:

```nohighlight
curl -L http://<haproxy hostd>:5050/MAAS
```

Note that Ansible configures the HAProxy instance for optimal use, such that OS images can be uploaded (for example). An unresponsive Region Controller is taken out of the upstream pool quickly.
The HAProxy instance does not interfere with Nginx/MAAS TLS configuration

<a href="#heading--PostgreSQL-primary-role"><h2 id="heading--PostgreSQL-primary-role">How to install PostgreSQL as a primary</h2></a>

As an operator, you want to install a Postgresql database as a primary to a given host using Ansible. You can accomplish this with the following steps:

1. Set the following in the `hosts` file to set the `maas_postgres_primary` role:

```nohighlight
maas_postgres_primary
my.host ansible_user=ssh_user
```

2. Run the full playbook, or add `--tags <target role(s)>` to run only the tasks for a given role.

3. Verify the primary by running `sudo -u postgres psql` and making sure you get a prompt.

Note that Ansible installs the latest supported version of PostgreSQL supported for the given MAAS version. If the playbook runs with other roles set on targeted hosts / groups, the tasks associated with the maas_postgresql_primary role runs first. If the operator sets a variable for importing a backup, the backup is loaded into PostgreSQL.

<a href="#heading--PostgreSQL-secondary-role"><h2 id="heading--PostgreSQL-secondary-role">How to install a failover PostgreSQL DB</h2></a>

As an operator, you want to install a PostgreSQL database as a failover (secondary) for a given host using Ansible. You can accomplish this with the following steps:

1. Set the following in the `hosts` file to set the `maas_postgres_secondary` role:

```nohighlight
maas_postgres_secondary
my.host ansible_user=ssh_user
```

2. Run the full playbook, or add `--tags <target role(s)>` to run only the tasks for a given role.

3. Verify the primary DB by running `sudo -u postgres psql`.

4. When you get a prompt, enter `select * from pg_stat_replication;`.  This should return a list of all secondaries connected to that primary.

Ansible installs the latest supported version of PostgreSQL for the given MAAS version that’s available for the host’s Ubuntu series in the Ubuntu repo.  A couple of installation notes:

- If the playbook runs with other roles set on targeted hosts / groups, the tasks associated with the maas_postgresql_secondary role runs after maas_postgresql_primary but before any other roles.  The configured secondary from this role replicates from a primary PostgreSQL instance created from the maas_postgresql_primary role.

- Automated failover is configured manually, external to this playbook. Manual failover can be achieved by a separate set of tasks for the maas_postgresql_secondary role, which once successful, changes the machine’s role to a maas_postgresql_primary and its configuration reflects that.

<!--
<a href="#heading--Firewall-rules"><h2 id="heading--Firewall-rules">Firewall rules</h2></a>

As a operator, you want to be able to setup MAAS in a secure way, following best practices and operational guidance on securing MAAS. In order to make a MAAS setup secure, I would Ansible playbooks to configure firewalls and file permissions based on https://maas.io/docs/how-to-secure-maas.

 
<a href="#heading--PostgreSQL-role-bundling-scripts"><h2 id="heading--PostgreSQL-role-bundling-scripts">PostgreSQL role bundling scripts</h2></a> -->
