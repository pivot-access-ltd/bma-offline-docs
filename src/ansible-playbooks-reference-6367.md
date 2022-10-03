<!-- "Ansible playbooks reference" -->

A user should probably have a solid grasp of the standard terminology in relation to ansible:
Playbook / plays
Hosts and groups

[Ansible](https://www.redhat.com/en/technologies/management/ansible/what-is-ansible) is a sophisticated IT automation tool that allows users to set up [playbooks](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html), which automate complex, repititive (or error-prone) setup activities.  While we won't provide a detailed tutorial on Ansible here (since the links above are excellent), there is a bit of terminology you should master before trying to use Ansible with MAAS:

- **Modules** are binaries (or even pieces of code) that Ansible can run on a managed node.  These modules can be grouped into named collections.
- **Tasks** are individual operations with one or more modules; each task generally accomplishes some otherwise-human-driven function, such as "parition and format /sda".
- **Plays** are sequences of tasks that Ansible will execute to accomplish larger operations, e.g., "install the OS" ==> "partition and format /sda", "install binary x.7.iso", etc.
- **Playbooks** are YAML files that run plays in a specific order; for example, "install the OS", "install MAAS", "create a region controller", "sync images", etc.

These simple descriptions do not fully explain the terms, so it is worthwhile to consult the referenced links, if necessary, before proceeding.  You will also want to understand how Ansible uses the terms "[hosts and groups](https://docs.ansible.com/ansible/latest/user_guide/intro_patterns.html)", since these are applied somewhat differently than we use them in MAAS.

Playbooks are available to automate the setup for:

- [MAAS region controllers](#heading--MAAS-region-controller): install and configure a MAAS region on a targeted host; running the playbook on hosts with a MAAS region will upgrade it.

- [MAAS rack controllers](#heading--MAAS-rack-controller): install and configure a MAAS rack.

- [MAAS high availability](#heading--MAAS-high-availability): install and configure the HA proxy.

- [PostgreSQL primary role](#heading--PostgreSQL-primary-role): setup the postgres primary role.

- [PostgreSQL secondary role](#heading--PostgreSQL-secondary-role): setup the postgres secondary role.

- [Firewall rules](#heading--Firewall-rules): setup firewall rules.

MAAS Playbooks are available from a [repository](https://github.com/maas/MAAS-ansible-playbook).  They will eventually be available through Ansible Galaxy.

There is also a set of groups that will automate setting up specific sections of MAAS.  For example, there is a PostgreSQL group that sets up the primary and secondary PostgreSQL roles, bypassing the need to run both playbooks individually.  These groups include:

- [PostgreSQL role bundling scripts](#heading--PostgreSQL-role-bundling-scripts)
- ?? (there must be more, huh?)

After installing ansible, running each of the playbooks on a blank machine will have a fresh install of MAAS ready to go. For example, running the region+rack will setup a region+rack on the host machine.

<a href="#heading--MAAS-region-controller"><h2 id="heading--MAAS-region-controller">MAAS region controller</h2></a>

As an operator, you want want to install a MAAS region controller onto a given host using Ansible.  To accomplish this, you must:

- [set a maas_region_controller](#heading--Setting-the-maas_region_controller-role) role on a given host, 
- [run the region controller playbook](#heading--Running-the-region-controller-playbook),
- and [find the newly-configured region controller](#heading--Finding-the-new-region-controller) present on that host .

<a href="#heading--Setting-the-maas_region_controller-role"><h3 id="heading--Setting-the-maas_region_controller-role">Setting the maas_region_controller role</h3></a>

**How do we do this?  Please explain!**

<a href="#heading--Running-the-region-controller-playbook"><h3 id="heading--Running-the-region-controller-playbook">Running the region controller playbook</h3></a>

When running the playbook for a host with the maas_region_controller role, the playbook installs the MAAS region controller.  The documented ansible variable (which one?) provides the user with the ability to set whether it’s a deb installation or a snap installation, along with additional variables for MAAS version, snap channel and/or PPA. 

**Please document these variables!**

The default installation is a snap.  A successful run of the playbook should give the operator an accessible and ready MAAS instance.  Some notes on installation:

- The installed region controller is used to set a maas_url variable when there is not one already set for later Rack Controller configuration use.
- The operator can optionally enable TLS.
- The playbook sets up the admin user.
- The playbook adds any provided preseeds.
- The playbook only installs the maas-region-api deb if the operator chooses the deb installation.
- Once the region controller is installed, the playbook will run migrations using the configured postgresql primary instance.
- Running on an already configured machine -- but with a new version -- should upgrade the instance.
- The operator can override the postgres DSN variable on any machine (hence not setting maas_postgresql_primary or maas_postgresql_secondary) to use an existing PostgreSQL instance not managed by this playbook.
- Optionally, the user can install a grafana agent (**how do they do this?**)

The playbook uses an ansible variable to determine what version of MAAS to deploy.  The playbook won’t execute (i.e “skipped” in the context of Ansible) if host_vars show the Ubuntu version is incompatible with the version and install method.  The Region Controller tasks should be able to execute on multiple hosts in a single execution if the target is an Ansible Group rather than a single host.

**please document the steps here:**

<a href="#heading--Finding-the-new-region-controller"><h3 id="heading--Finding-the-new-region-controller">Finding the new region controller</h3></a>

**how does the operator find the newly-installed region controller?**

<a href="#heading--MAAS-rack-controller"><h2 id="heading--MAAS-rack-controller">MAAS rack controller</h2></a>

As an operator, you want to install a MAAS rack controller to a given host, using Ansible. To accomplish this, you must: 

- [set a maas_rack_controller role](#heading--Setting-the-maas_rack_controller-role) on a given host, 
- [run the playbook](#heading--Running-the-rack-controller-playbook), 
- and [find the newly-configured rack controller](#heading--Finding-the-new-rack-controller), now present on the host.

<a href="#heading--Setting-the-maas_rack_controller-role"><h3 id="heading--Setting-the-maas_rack_controller-role">Setting the maas_rack_controller role</h3></a>

**How do we do this?  Please explain!**

<a href="#heading--Running-the-rack-controller-playbook"><h3 id="heading--Running-the-rack-controller-playbook">Running the rack controller playbook</h3></a>

When running the playbook for a host with the maas_rack_controller role, the playbook installs the MAAS Rack Controller. The maas_url variable is used to connect the Region Controller(s), either previously configured from a Region Controller install task, or provided by the user. If the maas_url variable is not set, the Rack Controller tasks are “skipped”.  Some notes about the installation:

- The operator can optionally enable TLS.
- The rack controller tasks should be able to execute on multiple hosts in a single execution if an Ansible Group is targeted rather than a single host.
- Only install the maas-rack-controller deb if using the deb installation.
- Running on an already configured machine but with a new version should upgrade the instance.
- You can optionally install a grafana agent (**how do we do this?**)

<a href="#heading--Finding-the-new-rack-controller"><h3 id="heading--Finding-the-new-rack-controller">Finding the new rack controller</h3></a>

**how does the operator find the newly-installed rack controller?**

<a href="#heading--MAAS-high-availability"><h3 id="heading--MAAS-high-availability">MAAS high availability</h3></a>

<a href="#heading--PostgreSQL-primary-role"><h2 id="heading--PostgreSQL-primary-role">PostgreSQL primary role</h2></a>

<a href="#heading--PostgreSQL-secondary-role"><h2 id="heading--PostgreSQL-secondary-role">PostgreSQL secondary role</h2></a>

<a href="#heading--Firewall-rules"><h2 id="heading--Firewall-rules">Firewall rules</h2></a>

<a href="#heading--PostgreSQL-role-bundling-scripts"><h2 id="heading--PostgreSQL-role-bundling-scripts">PostgreSQL role bundling scripts</h2></a>


A playbook that will setup the postgres primary role                             Christian
User story 4
A playbook that will setup the postgres secondary role                             Christian
User story 5
A playbook that will setup the HAProxy                                     Christian
User story 6
A playbook that will install and configure a MAAS rack                Jack
User story 2
A playbook that will uninstall MAAS from a targeted host                Jack
User story 7
What are we working on currently?
Running a host with both the region and rack playbooks will be set up as region+rack rather than setting up a region, and then a rack.                    Jack
A playbook that will setup firewall rules                        Eline
User story 10
What will the end user see?
MAAS Playbooks found through Ansible Galaxy (eventually).
Currently stored in this private repo, unsure if it will become public as of yet.
A set of groups that will automate setting up specific sections of MAAS
I.e.: a postgres group that sets up the primary, and secondary, without having to manually run the primary and secondary postgres playbooks individually.
After installing ansible, running each of the playbooks on a blank machine will have a fresh install of MAAS ready to go. (ie: running the region+rack will setup a region+rack on the host)
