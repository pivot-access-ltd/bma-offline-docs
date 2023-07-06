<!-- "About ansible" -->
Ansible is a powerful and widely used IT automation tool that simplifies the management and configuration of systems. It allows users to define their infrastructure as code using YAML-based playbooks, making it easier to automate complex tasks, deploy applications, and manage configurations.

Ansible playbooks are at the core of Ansible's automation capabilities. They are written in YAML, which is a human-readable data serialization format. Playbooks define a set of tasks to be executed on remote systems or managed nodes. These tasks can include various actions such as installing packages, copying files, executing commands, and more. Playbooks provide a declarative approach to system configuration, where users specify the desired state of their systems rather than writing procedural scripts.

<a href="#heading--ansible-modules"><h2 id="heading--ansible-modules">Ansible modules</h2></a>

Modules are the building blocks of Ansible playbooks. They are standalone scripts or programs that Ansible runs on managed nodes to perform specific tasks. Modules can manage system components, install software, interact with APIs, and more. Ansible provides a rich set of modules that cover a wide range of use cases. These modules are executed remotely on managed nodes, allowing users to perform actions on multiple systems simultaneously.

<a href="#heading--ansible-roles"><h2 id="heading--ansible-roles">Ansible roles</h2></a>

Roles are a way to organize and package related tasks, variables, and files into reusable components. They provide a higher level of abstraction and allow for modular and structured playbook development. Roles help in creating more maintainable and scalable playbooks by promoting code reuse and separation of concerns. They are particularly useful when managing complex systems with multiple components and configurations.

<a href="#heading--inventory"><h2 id="heading--inventory">Inventory</h2></a>

The Ansible Inventory is a file or collection of files that specify the managed nodes or hosts on which Ansible tasks are executed. It defines the hosts and groups of hosts that Ansible can connect to and manage. The inventory file can be static or dynamic, allowing for dynamic inventory management based on external sources such as cloud providers, configuration management systems, or custom scripts.

<a href="#heading--using-ansible-with-maas"><h2 id="heading--using-ansible-with-maas">Using Ansible with MAAS</h2></a>

MAAS provides Ansible playbooks that automate various aspects of MAAS setup and configuration. These playbooks simplify the process of installing and configuring MAAS components such as regions and racks. By leveraging Ansible, MAAS administrators can automate the drudgery of setting up MAAS and ensure consistent deployments across their infrastructure.

The MAAS Ansible playbooks enable users to define the desired state of their MAAS environment and automate the necessary steps to achieve that state. The playbooks take care of tasks such as installing dependencies, configuring networking, setting up databases, and more. They provide a streamlined and repeatable approach to MAAS deployment, reducing the time and effort required for manual setup.

By using Ansible with MAAS, administrators can benefit from the flexibility and scalability of Ansible's automation capabilities. They can easily customize the playbooks to suit their specific requirements, add additional tasks or roles, and integrate MAAS into their broader infrastructure management workflows.

With the release of MAAS 3.3, Ansible playbooks are available to install and configure MAAS, including regions and racks. These playbooks automate the setup process, saving administrators from manual configuration steps. Additionally, there are specific groups within the playbooks that automate the setup of different sections of MAAS, such as the PostgreSQL group that sets up primary and secondary PostgreSQL roles. By utilizing these playbooks, users can easily automate the installation and configuration of MAAS.

<a href="#heading--running-maas-ansible-playbooks"><h2 id="heading--running-maas-ansible-playbooks">Running MAAS Ansible playbooks</h2></a>

To run a MAAS Ansible playbook, you use a command structure similar to this:

```bash
ansible-playbook -i hosts \
--extra-vars \
"maas_version=$MAAS_VERSION 
maas_postgres_password=$MAAS_PG_PASSWORD 
maas_postgres_replication_password=$MAAS_PG_REP_PASSWORD 
maas_installation_type=<deb|snap> 
maas_url=$MAAS_URL" \
./site.yaml
```

This command typically runs the entire playbook, executing all the plays within it. If you want to run specific tasks for a particular role, you can use the `--tags` option to limit the execution to specific parts of the playbook. For additional options and command structures, consult the Ansible documentation.

<a href="#heading--maas-ansible-playbooks-and-maas-observability"><h2 id="heading--maas-ansible-playbooks-and-maas-observability">MAAS Ansible playbooks and MAAS observability</h2></a>

In addition to the basic MAAS Ansible playbooks, there is a set of Ansible playbooks designed to configure monitoring for MAAS controllers and their dependencies, such as PostgreSQL, with high availability capabilities. These playbooks enable the installation and configuration of monitoring agents, such as Grafana agents, to export metrics and logs from MAAS controllers.

Here are some example use cases for the observability playbooks:

- Single Grafana agent per host: These playbooks allow the installation of a single Grafana agent per host, which pushes metrics and logs to Prometheus and Loki services, respectively. The agent configuration file combines all metrics and logs sources into a single configuration file based on the assigned host roles.

- Exporting metrics from MAAS controllers: The playbooks enable the installation and configuration of a Grafana agent on hosts running MAAS region controllers or rack controllers. This allows the export of server metrics from these controllers, providing insights into their performance and health.

- Exporting logs from MAAS controllers: Playbooks facilitate the installation and configuration of a Grafana agent on hosts with MAAS region controllers or rack controllers to export logs to Loki. This enables centralized log collection and analysis for troubleshooting and monitoring purposes.

- Exporting PostgreSQL metrics and logs: The PostgreSQL group in the Ansible playbooks introduces a playbook specifically designed for high availability (HA) failover of PostgreSQL within MAAS. This playbook utilizes Corosync and Pacemaker to automate the failover process and ensure continuous availability of the PostgreSQL database.

<a href="#heading--technical-details-of-the-postgresql-ha-playbook"><h2 id="heading--technical-details-of-the-postgresql-ha-playbook">Technical details of the PostgreSQL HA playbook</h2></a>

The PostgreSQL HA playbook enhances the reliability and availability of the MAAS PostgreSQL database. It automates the failover process using Corosync and Pacemaker, which manage failure detection and election. The playbook refactors the PostgreSQL roles to remove the distinction between "primary" and "secondary" roles. Instead, an Ansible Fact is utilized to track the primary status dynamically.

During execution, the playbook sets up Corosync as the messaging layer for communication between the nodes in the cluster. It establishes a reliable and fault-tolerant network connection, allowing the nodes to exchange heartbeat messages and monitor each other's health. Pacemaker serves as the cluster resource manager, leveraging the information from Corosync to determine the cluster's state and manage the failover of resources, including the primary role for PostgreSQL.

The PostgreSQL HA playbook also handles the installation and configuration of the HAProxy Postgres proxy, ensuring continuous connectivity and flexible cluster topology management for region controllers. By automating the failover process and utilizing the refactored PostgreSQL roles, the playbook enables seamless transition to a secondary PostgreSQL instance in the event of a primary failure, maintaining uninterrupted service.

The execution of the PostgreSQL HA playbook is integrated with the overall MAAS Ansible playbooks set. By running the playbook on a blank machine, administrators can perform a fresh install of MAAS with HA failover capability for PostgreSQL. The playbook automates the setup of a region and rack on the host machine, ensuring a fully functional MAAS deployment.

The availability of the PostgreSQL HA playbook within the MAAS Ansible playbooks enhances the reliability and availability of the MAAS PostgreSQL database. By utilizing Corosync and Pacemaker, the playbook automates the failover process, ensuring continuous operation even in the event of a primary failure. It simplifies administration, improves data integrity, and provides a solid foundation for building high-performance and resilient infrastructures using MAAS.