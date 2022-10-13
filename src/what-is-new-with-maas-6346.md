<!-- "MAAS 3.3 release notes" -->

<!-- Here you will find release notes for:

- [The current version of MAAS](#heading--current-maas-release-notes)
- [Other MAAS versions](#heading--other-maas-versions) -->

<a href="#heading--3-3-0-Beta-1-maas-release-notes"><h2 id="heading--3-3-0-Beta-1-maas-release-notes">MAAS 3.3 Beta 1 release notes</h2></a>

We are happy to announce that MAAS 3.3 Beta 1 has been released, with concerted efforts to improve MAAS on multiple fronts. New features include:

- [Ansible playbooks for HA MAAS, PostgreSQL, and other MAAS configurations](#heading--ansible-playbooks)
<!-- - [Integration of Vault for credential storage](#heading--vault-integration) -->
- [Improved machine list filtering](#heading--Improved-machine-list-filtering)

Improved capabilities include the following:

- [Native support for 22.04 LTS and core22](#heading--22-04-support)
<!-- - [Reliability improvements for simultaneous machine deployments](#heading--simultaneous-deployment-improvements) -->
<!-- - [The first phase of Nvidia DPU support](#heading--nvidia-dpu-support) -->
- [UI performance improvements for large machine counts](#heading--UI-performance-improvements)
- [Enhanced MIB support for Windows OS images](#heading--Enhanced-MIB-support-for-Windows-OS-images)

Greatly expanded documentation sections include:

<!-- - [Shifting the MAAS API documentation to OpenAPI standards](#heading--openapi-support) -->
- [MAAS configuration settings reference](#heading--maas-config-settings-ref)
- [Improved MAAS event documentation](#heading--Improved-MAAS-event-documentation)
- [Improved MAAS audit event documentation](#heading--Improved-MAAS-audit-event-documentation)

Read on to catch up with what we've done so far this cycle.

<a href="#heading--ansible-playbooks"><h3 id="heading--ansible-playbooks">Ansible playbooks for HA MAAS, PostgreSQL, and other MAAS configurations</h3></a>

[Ansible](https://www.redhat.com/en/technologies/management/ansible/what-is-ansible) [playbooks](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html) are now available for MAAS.  These extended YAML files automate various routine aspects of MAAS setup and configuration.  Playbooks are available to:

- install and configure a MAAS region on a targeted host; running the playbook on hosts with a MAAS region will upgrade it.
- install and configure a MAAS rack.
- setup the postgres primary role.
- setup the postgres secondary role.
- setup firewall rules.

MAAS Playbooks are available from a [repository](https://github.com/maas/MAAS-ansible-playbook).  They will eventually be available through Ansible Galaxy.

There is also a set of groups that will automate setting up specific sections of MAAS.  For example, there is a PostgreSQL group that sets up the primary and secondary PostgreSQL roles, bypassing the need to run both playbooks individually.

After installing ansible, running each of the playbooks on a blank machine will have a fresh install of MAAS ready to go. For example, running the region+rack will setup a region+rack on the host machine.

Read the [Ansible playbooks reference](/t/ansible-playbooks-reference/6367) document to learn more.

<!--
<a href="#heading--vault-integration"><h3 id="heading--vault-integration">Integration of Vault for credential storage</h3></a>

MAAS deals with a number of secrets (user password, certificates and keys, API tokens, …), currently stored in the database -- which is insecure by default. This configuration may not meet everyone's security requirements or regulations. For this reason, we've integrated MAAS with Hashicorp Vault, a well-established solution for secure, centralised credential storage.

You can read the [MAAS Vault reference](/t/maas-vault-reference/6368) documentation to learn more. -->

<a href="#heading--Improved-machine-list-filtering"><h3 id="heading--Improved-machine-list-filtering">Improved machine list filtering</h3></a>

[note]
**NOTE** that this feature is still in development, so some of the feature-set described in this section may not be fully operational yet.  As always, we reserve the right to change this feature-set until the final release of MAAS 3.3. These release notes will be updated as the feature develops.
[/note]

MAAS 3.3 enhances the way you can filter the machine list, in two ways:

1. You may begin filtering within a very short time after the first page of the machine list loads, even if you have more than 10,000 machines in the list.  

2. You have a wider range of filter choices, as descsribed in the table below.

Note that with this version of MAAS, matching machine counts have been removed from the filter list for better performance.

The following table describes the proposed filter set for the MAAS machine list:

- Items marked as "Dynamic" are populated based on existing data, that is, the "Tags" filter only shows tags that currently exist.  
- Items which are not dynamic present the entire range of possible values, regardless of whether that value currently existds in MAAS; for example, all machine status values are available to be filtered, even if no machines currently have that status.
- Items marked as "Grouping" can be used to group machines, instead of the default machine status.

See [How to search MAAS](/t/how-to-search-maas/5192) for details on how to use these parameters.


| Parameter            | Description                                              | Dynamic | Grouping |
|----------------------|----------------------------------------------------------|---------|----------|
| arch                 | Include nodes with this architecture                     |         | Grouping |
| !arch                | Exclude nodes with this architecture                     | Dynamic |          |
| zone                 | Include nodes in this zone                               | Dynamic | Grouping |
| !zone                | Exclude nodes in this zone                               | Dynamic |          |
| pool                 | Include nodes in this resource pool                      | Dynamic | Grouping |
| !pool                | Exclude nodes in this resource pool                      | Dynamic |          |
| pod                  | Include pods matching this name                          | Dynamic | Grouping |
| !pod                 | Exclude pods matching this name                          | Dynamic |          |
| pod_type             | Include pods with this power type                        | Dynamic | Grouping |
| !pod_type            | Exclude pods with this power type                        | Dynamic |          |
| domain               | Include nodes in this domain                             | Dynamic | Grouping |
| !domain              | Exclude nodes in this domain                             | Dynamic |          |
| status               | Include nodes with this status                           |         | Grouping |
| !status              | Exclude nodes with the specified status                  | Dynamic |          |
| owner                | Include nodes owned by these users                       | Dynamic | Grouping |
| !owner               | Exclude nodes owned by these users                       | Dynamic |          |
| power_state          | Include nodes with this power state                      |         | Grouping |
| !power_state         | Exclude nodes with this power state                      | Dynamic |          |
| tags                 | Include nodes with this tag                              | Dynamic |          |
| !tags                | Exclude nodes with this tag                              | Dynamic |          |
| fabrics              | Include nodes attached to this fabric                    | Dynamic |          |
| !fabrics             | Exclude nodes attached to this fabric                    | Dynamic |          |
| fabric_classes       | Include nodes attached to this class of fabric           | Dynamic |          |
| !fabric_classes      | Exclude nodes attached to this class of fabric           | Dynamic |          |
| fabric_name          | Include nodes with this boot interface fabric            | Dynamic |          |
| !fabric_name         | Exclude nodes with this boot interface fabric            | Dynamic |          |
| subnets              | Attached to subnets                                      | Dynamic |          |
| !subnets             | Not attached to subnets                                  | Dynamic |          |
| link_speed           | Link speed                                               | Dynamic |          |
| !link_speed          | Link speed                                               | Dynamic |          |
| vlans                | Attached to VLANs                                        | Dynamic |          |
| !vlans               | Not attached to VLANs                                    | Dynamic |          |
| storage              | Storage                                                  | Dynamic |          |
| total_storage        | Total storage                                            | Dynamic |          |
| !total_storage       | Total storage                                            | Dynamic |          |
| cpu_count            | CPU count                                                | Dynamic |          |
| !cpu_count           | CPU count                                                | Dynamic |          |
| mem                  | Memory                                                   | Dynamic |          |
| !mem                 | Memory                                                   | Dynamic |          |
| mac_address          | MAC addresses to filter on                               | Dynamic |          |
| !mac_address         | MAC addresses to filter on                               | Dynamic |          |
| agent_name           | Only include nodes with events matching the agent name   | Dynamic |          |
| !agent_name          | Excludes nodes with events matching the agent name       | Dynamic |          |
| cpu_speed            | CPU speed                                                | Dynamic |          |
| !cpu_speed           | CPU speed                                                | Dynamic |          |
| osystem              | The OS of the desired node                               | Dynamic |          |
| !osystem             | OS to ignore                                             | Dynamic |          |
| distro_series        | The OS distribution of the desired node                  | Dynamic |          |
| !distro_series       | OS distribution to ignore                                | Dynamic |          |
| ip_addresses         | Node's IP address                                        | Dynamic |          |
| !ip_addresses        | IP address to ignore                                     | Dynamic |          |
| spaces               | Node's spaces                                            | Dynamic |          |
| !spaces              | Node's spaces                                            | Dynamic |          |
| workloads            | Node's workload annotations                              | Dynamic |          |
| !workloads           | Node's workload annotations                              | Dynamic |          |
| physical_disk_count  | Physical disk Count                                      | Dynamic |          |
| !physical_disk_count | Physical disk Count                                      | Dynamic |          |
| pxe_mac              | Boot interface MAC address                               | Dynamic |          |
| !pxe_mac             | Boot interface MAC address                               | Dynamic |          |
| fqdn                 | Node FQDN                                                | Dynamic |          |
| !fqdn                | Node FQDN                                                | Dynamic |          |
| simple_status        | Only includes nodes with the specified simplified status | Dynamic |          |
| !simple_status       | Exclude nodes with the specified simplified status       | Dynamic |          |
| devices              | Devices                                                  | Dynamic |          |
| interfaces           | Interfaces                                               | Dynamic |          |
| parent               | Parent node                                              | Dynamic | Grouping |

<a href="#heading--22-04-support"><h3 id="heading--22-04-support">Native support for 22.04 LTS and core22</h3></a>

MAAS users want to install MAAS on a 22.04 LTS system via deb packages, as well as upgrade machines currently running MAAS on Ubuntu 20.04 LTS to 22.04 LTS.  With the advent of MAAS 3.3, we have created an appropriate PPA with all required dependencies.  This PPA can be directly installed on Ubuntu 22.04, Jammy Jellyfish, with no requirement to use snaps.

Note that the upgrade procedure will require a release upgrade from previous Ubuntu versions to Ubuntu 22.04.  Also note that, with this version of MAAS, PostgreSQL 12 is deprecated and should be upgraded to PostgreSQL 14.  The [installation guide](/t/how-to-install-maas/5128) provides the necessary details.

<!--
<a href="#heading--simultaneous-deployment-improvements"><h3 id="heading--simultaneous-deployment-improvements">Reliability improvements for simultaneous machine deployments</h3></a>

MAAS 3.3 brings some behind-the-scenes performance improvements to the product.  When you deploy many machines, you expect them all deploy reliably, with IPs allocated in bulk, and no DNS delays or RPC timeouts.  Within our development system, we've added system tests and metrics to track any failures or latency when large numbers of machines are being deployed.  We've then used these new data to lower the failure rate and reduce latency in those situations.

<a href="#heading--nvidia-dpu-support"><h3 id="heading--nvidia-dpu-support">The first phase of Nvidia DPU support</h3></a>

Long-term, we know that MAAS administrators want to enlist and use DPUs with MAAS.  The Nvidia DPU is a complex machine with a tremendous amount of capability, so this cycle, we made the first steps toward supporting them.  Details will follow in a forward-looking blog post sometime after the MAAS 3.3 release.
-->

<a href="#heading--UI-performance-improvements"><h3 id="heading--UI-performance-improvements">UI performance improvements</h3></a>

We wanted to improve the performance of the machine list page for large (>10000 machines) MAASes, and allow users to search and filter machines as quickly as possible. In MAAS 3.2 and earlier, machine search and filter requires that all machines be fetched by the UI client before it becomes usable. For smaller MAASes this may not be an issue, but when considering MAASes with 1000 machines or more this can make the user wait an unacceptably long time before they can search and filter.

With the release of MAAS 3.3, when a MAAS UI user wants to find a particular machine, they do not have to wait for all their machines data to load before they can start searching. The user can start searching for machines within a short time after the visible page of the machine list has fully loaded on the UI screen.  See [Improved machine list filtering](#heading--Improved-machine-list-filtering), in these release notes, for details on the enhanced filtering capabilities that were included in this work.

<a href="#heading--Enhanced-MIB-support-for-Windows-OS-images"><h3 id="heading--Enhanced-MIB-support-for-Windows-OS-images">Enhanced MIB support for Windows OS images</h3></a>

<a href="#heading--openapi-support"><h3 id="heading--openapi-support">Shifting the MAAS API documentation to OpenAPI standards</h3></a>

MAAS API User want to experience the MAAS API in a more standard way, along the lines of the OpenAPI definition.  MAAS 3.3 begins this process by providing most of the MAAS API functionality in a discover-able form.  You should now be able to easily retrieve human-readable service documentation and API definitions using standard methods.  Consult [the API documentation](https://maas.io/docs/api) for details.

<a href="#heading--maas-config-settings-ref"><h3 id="heading--maas-config-settings-ref">MAAS configuration settings reference</h3></a>

MAAS configuration settings are scattered in various (generally relevant) places throughout the documentation, but there has never been one reference page that addresses all settings in one place.  MAAS 3.3 remedies this by adding the [Configuration settings reference](/t/configuration-settings-reference/6347).

<a href="#heading--Improved-MAAS-event-documentation"><h3 id="heading--Improved-MAAS-event-documentation">Improved MAAS event documentation</h3></a>

<a href="#heading--Improved-MAAS-audit-event-documentation"><h3 id="heading--Improved-MAAS-audit-event-documentation">Improved MAAS audit event documentation</h3></a>

<!---
<a href="#heading--other-maas-versions"><h2 id="heading--other-maas-versions">Release notes for other MAAS versions</h2></a>

Here are release notes for other relatively recent MAAS versions:

- [MAAS 3.2](/t/what-is-new-with-maas-3-2/5962)
- [MAAS 3.1](/t/what-is-new-with-maas-3-1/5964)
- [MAAS 3.0](/t/what-is-new-with-maas-3-0/5963)
- [MAAS 2.9](/t/what-is-new-with-maas-2-9/5961)
- [MAAS 2.8](/t/what-is-new-with-maas-2-8/5994)
- [MAAS 2.7](/t/what-is-new-with-maas-2-7/5993)
 -->
