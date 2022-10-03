<!-- "Ansible playbooks reference" -->

[Ansible](https://www.redhat.com/en/technologies/management/ansible/what-is-ansible) [playbooks](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html) are available to automate the setup for:

- [MAAS region controllers](heading--MAAS-region-controller): install and configure a MAAS region on a targeted host; running the playbook on hosts with a MAAS region will upgrade it.

- [MAAS rack controllers](heading--MAAS-rack-controller): install and configure a MAAS rack.

- [PostgreSQL primary role](heading--PostgreSQL-primary-role): setup the postgres primary role.

- [PostgreSQL secondary role](heading--PostgreSQL-secondary-role): setup the postgres secondary role.

- [Firewall rules](heading--Firewall-rules): setup firewall rules.

MAAS Playbooks are available from a [repository](https://github.com/maas/MAAS-ansible-playbook).  They will eventually be available through Ansible Galaxy.

There is also a set of groups that will automate setting up specific sections of MAAS.  For example, there is a PostgreSQL group that sets up the primary and secondary PostgreSQL roles, bypassing the need to run both playbooks individually.  These groups include:

- [PostgreSQL role bundling scripts](heading--PostgreSQL-role-bundling-scripts)
- ?? (there must be more, huh?)

After installing ansible, running each of the playbooks on a blank machine will have a fresh install of MAAS ready to go. For example, running the region+rack will setup a region+rack on the host machine.

<a href="#heading--MAAS-region-controller"><h2 id="heading--MAAS-region-controller">MAAS region controller</h2></a>

<a href="#heading--MAAS-rack-controller"><h2 id="heading--MAAS-rack-controller">MAAS rack controller</h2></a>

<a href="#heading--PostgreSQL-primary-role"><h2 id="heading--PostgreSQL-primary-role">PostgreSQL primary role</h2></a>

<a href="#heading--PostgreSQL-secondary-role"><h2 id="heading--PostgreSQL-secondary-role">PostgreSQL secondary role</h2></a>

<a href="#heading--Firewall-rules"><h2 id="heading--Firewall-rules">Firewall rules</h2></a>

<a href="#heading--PostgreSQL-role-bundling-scripts"><h2 id="heading--PostgreSQL-role-bundling-scripts">PostgreSQL role bundling scripts</h2></a>
