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
**NOTE** that this feature is still in development, so some of the feature-set described in this section may not be fully operational yet.  As always, we reserve the right to change this feature-set until the final release of MAAS 3.3.
[/note]


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
