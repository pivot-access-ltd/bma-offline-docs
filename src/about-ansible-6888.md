<!-- "About ansible" -->

[Ansible playbooks](https://github.com/maas/MAAS-ansible-playbook) are now available for MAAS. These extended YAML files automate various routine aspects of MAAS setup and configuration.  Automate the drudgery of installing and configuring MAAS with Ansible.  

With MAAS 3.3, playbooks are available to install and configure MAAS, including regions and racks.  There is also a set of groups that will automate setting up specific sections of MAAS. For example, there is a PostgreSQL group that sets up the primary and secondary PostgreSQL roles, bypassing the need to run both playbooks individually.

After installing Ansible, running each of the playbooks on a blank machine will have a fresh install of MAAS ready to go. For example, running the region+rack will setup a region+rack on the host machine.

<a href="#heading--Ansible-basics"><h2 id="heading--Ansible-basics">Ansible basics</h2></a>

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

<a href="#heading--MAAS-Ansible-playbooks"><h2 id="heading--MAAS-Ansible-playbooks">MAAS Ansible playbooks</h2></a>

Playbooks are available to automate the setup for:

- [MAAS region controllers](/t/how-to-spin-up-maas-with-ansible/6367#heading--MAAS-region-controller): install and configure a MAAS region on a targeted host; running the playbook on hosts with a MAAS region will upgrade it.

- [MAAS rack controllers](/t/how-to-spin-up-maas-with-ansible/6367#heading--MAAS-rack-controller): install and configure a MAAS rack.

- [MAAS de-installation](/t/how-to-spin-up-maas-with-ansible/6367#heading--MAAS-de-installation): remove MAAS from a targeted host.

- [MAAS high availability](/t/how-to-spin-up-maas-with-ansible/6367#heading--MAAS-high-availability): install and configure the HA proxy.

- [PostgreSQL primary role](/t/how-to-spin-up-maas-with-ansible/6367#heading--PostgreSQL-primary-role): setup the PostgreSQL primary role.

- [PostgreSQL secondary role](/t/how-to-spin-up-maas-with-ansible/6367#heading--PostgreSQL-secondary-role): setup the PostgreSQL secondary role.

- [Firewall rules](/t/how-to-spin-up-maas-with-ansible/6367#heading--Firewall-rules): setup firewall rules.

MAAS Playbooks will eventually be available through Ansible Galaxy.

There is also a set of groups that will automate setting up specific sections of MAAS.  For example, there is a PostgreSQL group that sets up the primary and secondary PostgreSQL roles, bypassing the need to run both playbooks individually.  These groups include:

- [PostgreSQL role bundling scripts](/t/how-to-spin-up-maas-with-ansible/6367#heading--PostgreSQL-role-bundling-scripts)
- ?? (there must be more, huh?)

After installing Ansible, running each of the playbooks on a blank machine will have a fresh install of MAAS ready to go. For example, running the region+rack will setup a region+rack on the host machine.

<a href="#heading--Running-a-MAAS-Ansible-playbook"><h2 id="heading--Running-a-MAAS-Ansible-playbook">Running a MAAS Ansible playbook</h2></a>

In general terms, you can run any of the MAAS Ansible playbooks with a command of this form:

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

<a href="#heading--Ansible-playbooks-and-MAAS-Observability"><h2 id="heading--Ansible-playbooks-and-MAAS-Observability">Ansible playbooks and MAAS Observability</h2></a>

There is a set of Ansible playbooks that allows you to configure monitoring for MAAS controllers and their dependencies, such as PostgreSQL, with high availability capabilities. Monitoring is crucial for operating any modern system, especially complex systems like HA MAAS. As the installation and configuration of MAAS are made easier through Ansible playbooks, it is important to provide users with a similar means to guarantee reliable monitoring.

The O11y (Observability) for HA MAAS playbooks are designed to be used alongside the official MAAS playbooks. They inherit the inventory and definitions from the official playbooks wherever that's possible.  Following are some example use cases.

<a href="#heading--Single-Grafana-agent-per-host"><h3 id="heading--Single-Grafana-agent-per-host">Single Grafana agent per host</h3></a>

Suppose an operator is running a single grafana-agent per host, managed with Ansible.  O11y playbooks enable the installation of a single grafana-agent process per host to push metrics and logs to Prometheus and Loki services respectively. The agent configuration file combines all metrics and logs sources into a single configuration file based on the roles assigned to the host. You must define the Prometheus or Loki endpoints to trigger the inclusion of the `maas_grafana_agent` task, which installs and configures the agent to scrape all available metrics endpoints and collect logs from all available sources on the host.

<a href="#heading--Exporting-metrics-from-all-MAAS-region-controllers"><h3 id="heading--Exporting-metrics-from-all-MAAS-region-controllers">Exporting metrics from all MAAS region controllers</h3></a>

If you want to export metrics from all MAAS region controllers installed by Ansible, you can do so.  The playbooks enable the installation and configuration of a grafana agent on hosts running region controllers, allowing them to export server metrics.  When running the `maas_grafana_agent` task on hosts with the `maas_region_controller role`, Ansible helps by configuring MAAS to export server metrics and defining the appropriate job configurations in the grafana agent configuration file.

<a href="#heading--Export-metrics-from-all-MAAS-rack-controllers"><h3 id="heading--Export-metrics-from-all-MAAS-rack-controllers">Export metrics from all MAAS rack controllers</h3></a>

It's also possible to export metrics from all MAAS rack controllers installed by Ansible.  The appropriate playbooks allow you to easily install and configure a grafana agent on hosts running rack controllers, so that they can export server metrics.  When running the `maas_grafana_agent` task on hosts with the `maas_rack_controller` role, playbooks will configure MAAS to export server metrics and defining appropriate job configurations.

<a href="#heading--Exporting-logs-from-all-MAAS-region-controllers"><h3 id="heading--Exporting-logs-from-all-MAAS-region-controllers">Exporting logs from all MAAS region controllers</h3></a>

You can also export logs from all MAAS region controllers that were installed by Ansible.  The playbooks enable the installation and configuration of a grafana agent on hosts running region controllers to export logs to Loki.  Ansible will run the `maas_grafana_agent` task on hosts with the `maas_region_controller` role, defining the log scrap job configurations in grafana configuration file, as necessary to export the logs.

<a href="#heading--Exporting-logs-from-all-MAAS-rack-controllers"><h3 id="heading--Exporting-logs-from-all-MAAS-rack-controllers">Exporting logs from all MAAS rack controllers</h3></a>

The playbooks also facilitate exporting logs from all MAAS Rack controllers installed by Ansible, by installing and configuring of a grafana agent on hosts running rack controllers in way that allows them  to export logs to Loki.  These playbooks define the log scrap job configurations needed in the grafana agent configuration file.

<a href="#heading--Exporting-PostgreSQL-metrics-from-Ansible-installed-database-software"><h3 id="heading--Exporting-PostgreSQL-metrics-from-Ansible-installed-database-software">Exporting PostgreSQL metrics from Ansible-installed database software</h3></a>

We provide playbooks that enable installation and configuration of the Postgres-Exporter agent to export PostgreSQL metrics to Prometheus, by installing the Postgres-Exporter agent on hosts with the `maas_postgres role`, running the `maas_grafana_agent` task, and defining the appropriate job configuration in the final grafana agent configuration file.

<a href="#heading--Exporting-logs-from-Ansible-installed-PostgreSQL"><h3 id="heading--Exporting-logs-from-Ansible-installed-PostgreSQL">Exporting logs from Ansible-installed PostgreSQL</h3></a>

We also provide playbooks that will export logs from a PostgreSQL database installed by Ansible.  These playbooks facilitate the installation and configuration of a grafana agent on hosts with the `maas_postgres` role to export PostgreSQL logs to Loki.  Ansible will run the `maas_grafana_agent` task on hosts with the `maas_postgres` role, defining the log scrap job configurations in the final grafana agent configuration file.

<a href="#heading--Installing-alert-rules-to-the-existing-O11y-stack"><h3 id="heading--Installing-alert-rules-to-the-existing-O11y-stack">Installing alert rules to the existing O11y stack</h3></a>

Ansible can install alert rules into your existing observability stack, by downloading MAAS-curated alert rules for Prometheus and Loki.  The playbooks will download and compile alert rules for Prometheus and Loki, which can be copied to a directory of the operator's choice for integration with your O11y stack.

<a href="#heading--Exporting-metrics-from-Pacemaker-and-Corosync"><h3 id="heading--Exporting-metrics-from-Pacemaker-and-Corosync">Exporting metrics from Pacemaker and Corosync</h3></a>

If Ansible has been used to install Pacemaker and Corosync services, our playbooks can further install and configure the HA Cluster exporter to collect Pacemaker and Corosync metrics and use a grafana agent to send metrics to Prometheus.

<a href="#heading--Exporting-logs-from-PAF-Pacemaker-and-Corosync"><h3 id="heading--Exporting-logs-from-PAF-Pacemaker-and-Corosync">Exporting logs from PAF, Pacemaker, and Corosync</h3></a>

If Ansible has been used to install PAF, Pacemaker, and Corosync, our playbooks can further install and configure a grafana agent on hosts with the `maas_ha_postgres` role to allow them to export logs from PAF, Pacemaker, and Corosync services to Loki.