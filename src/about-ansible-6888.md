<!-- "About Ansible" -->

[Ansible playbooks](https://github.com/maas/MAAS-ansible-playbook) are now available for MAAS. These extended YAML files automate various routine aspects of MAAS setup and configuration.  Automate the drudgery of installing and configuring MAAS with Ansible.  

With MAAS 3.3, playbooks are available to install and configure MAAS, including regions and racks.  There is also a set of groups that will automate setting up specific sections of MAAS. For example, there is a PostgreSQL group that sets up the primary and secondary PostgreSQL roles, bypassing the need to run both playbooks individually.

After installing Ansible, running each of the playbooks on a blank machine will have a fresh install of MAAS ready to go. For example, running the region+rack will setup a region+rack on the host machine.

<a href="#heading--About-Ansible"><h2 id="heading--About-Ansible">About Ansible basics</h2></a>

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

In general terms, you can run any of the MAAS Ansible playbookss with a command of this form:

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
