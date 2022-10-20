<!-- "MAAS 3.3 release notes" -->

<!-- Here you will find release notes for:

- [The current version of MAAS](#heading--current-maas-release-notes)
- [Other MAAS versions](#heading--other-maas-versions) -->

<a href="#heading--3-3-0-Beta-1-maas-release-notes"><h2 id="heading--3-3-0-Beta-1-maas-release-notes">MAAS 3.3 Beta 1 release notes</h2></a>

We are happy to announce that MAAS 3.3 Beta 1 has been released, with concerted efforts to improve MAAS on multiple fronts. New features include:

- [Ansible playbooks for HA MAAS, PostgreSQL, and other MAAS configurations](#heading--ansible-playbooks)
- [Improved machine list filtering](#heading--Improved-machine-list-filtering)
<!-- - [Integration of Vault for credential storage](#heading--vault-integration) -->

Improved capabilities include the following:

- [Native support for 22.04 LTS and core22](#heading--22-04-support)
- [UI performance improvements for large machine counts](#heading--UI-performance-improvements)
- [Enhanced MIB support for Windows OS images](#heading--Enhanced-MIB-support-for-Windows-OS-images)
<!-- - [Reliability improvements for simultaneous machine deployments](#heading--simultaneous-deployment-improvements) -->
<!-- - [The first phase of Nvidia DPU support](#heading--nvidia-dpu-support) -->

Greatly expanded documentation sections include:

<!-- - [Shifting the MAAS API documentation to OpenAPI standards](#heading--openapi-support) -->
- [MAAS configuration settings reference](#heading--maas-config-settings-ref)
- [Improved MAAS event documentation](#heading--Improved-MAAS-event-documentation)
- [Improved MAAS audit event documentation](#heading--Improved-MAAS-audit-event-documentation)

This release also includes a massive number of [bug fixes](#heading--MAAS-3-3-Beta-1-bug-list).  Read on to catch up with what we've done so far this cycle.

[note]
**NOTE** that this is a Beta release. While we aim to ensure there is no regression,  there may be bugs. While we work to stabilise the release, we advise against using beta releases in production environments.
[/note]

<a href="#heading--ansible-playbooks"><h3 id="heading--ansible-playbooks">Ansible playbooks for HA MAAS, PostgreSQL, and other MAAS configurations</h3></a>

[Ansible](https://www.redhat.com/en/technologies/management/ansible/what-is-ansible) [playbooks](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html) are now available for MAAS.  These extended YAML files automate various routine aspects of MAAS setup and configuration.  Playbooks are available to:

- install and configure a MAAS region on a targeted host; running the playbook on hosts with a MAAS region will upgrade it.
- install and configure a MAAS rack.
- setup the postgres primary role.
- setup the postgres secondary role.

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

2. You have a wider range of filter choices, as described in the table below.

Note that with this version of MAAS, matching machine counts have been removed from the filter list for better performance.

The following table describes the proposed filter set for the MAAS machine list:

- Items marked as "Dynamic" are populated based on existing data, that is, the "Tags" filter only shows tags that currently exist.  
- Items which are not dynamic present the entire range of possible values, regardless of whether that value currently exists in MAAS; for example, all machine status values are available to be filtered, even if no machines currently have that status.
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

The [procedure](https://maas.io/docs/how-to-create-custom-images#heading--custom-windows-images) for creating custom Windows OS images has been thoroughly updated and verified.

<!--
<a href="#heading--openapi-support"><h3 id="heading--openapi-support">Shifting the MAAS API documentation to OpenAPI standards</h3></a>

MAAS API User want to experience the MAAS API in a more standard way, along the lines of the OpenAPI definition.  MAAS 3.3 begins this process by providing most of the MAAS API functionality in a discover-able form.  You should now be able to easily retrieve human-readable service documentation and API definitions using standard methods.  Consult [the API documentation](https://maas.io/docs/api) for details. -->

<a href="#heading--maas-config-settings-ref"><h3 id="heading--maas-config-settings-ref">MAAS configuration settings reference</h3></a>

MAAS configuration settings are scattered in various (generally relevant) places throughout the documentation, but there has never been one reference page that addresses all settings in one place.  MAAS 3.3 remedies this by adding the [Configuration settings reference](/t/configuration-settings-reference/6347).

<a href="#heading--Improved-MAAS-event-documentation"><h3 id="heading--Improved-MAAS-event-documentation">Improved MAAS event documentation</h3></a>

MAAS event documentation has been expanded to include [much better explanations](/t/understanding-maas-events/6373) of MAAS events, including many examples.

<a href="#heading--Improved-MAAS-audit-event-documentation"><h3 id="heading--Improved-MAAS-audit-event-documentation">Improved MAAS audit event documentation</h3></a>

MAAS audit event documentation has been greatly expanded to include [much better explanations](/t/understanding-maas-audit-events/6372) of MAAS audit events, including many examples and use cases.

<a href="#heading--MAAS-3-3-Beta-1-bug-list"><h2 id="heading--MAAS-3-3-Beta-1-bug-list">MAAS 3.3 Beta 1 bug list</h2></a>

So far in MAAS 3.3, we've fixed well over 100 bugs:

- [1762673](https://bugs.launchpad.net/bugs/1762673): maas insists on running the proxy, even when it's disabled
- [1802505](https://bugs.launchpad.net/bugs/1802505): [ui][2.4][2.5] maas ignores ttl parameter for address records
- [1806707](https://bugs.launchpad.net/bugs/1806707): [2.5] Composing a VM with an interface attached to a (macvtap) network (on a KVM host NIC that is not a bridge) resulted in disconnect interface
- [1811109](https://bugs.launchpad.net/bugs/1811109): [2.5, UI, RBAC] Normal users can unmount the root file system, but not remount it
- [1818004](https://bugs.launchpad.net/bugs/1818004): Slow response in the UI
- [1822640](https://bugs.launchpad.net/bugs/1822640): [websocket, UI] Admins should be able to change ownership of resources over the UI
- [1822840](https://bugs.launchpad.net/bugs/1822840): [UI, feature] Add ability to edit/delete (manage) tags over the UI
- [1825255](https://bugs.launchpad.net/bugs/1825255): TestPostgresListenerService test fails erroneously in CI
- [1826011](https://bugs.launchpad.net/bugs/1826011): [UI] Compose machine from pod misaligned message
- [1826789](https://bugs.launchpad.net/bugs/1826789): stress-ng-cpu-long times out in bionic
- [1826967](https://bugs.launchpad.net/bugs/1826967): Exiting rescue mode shows 'loading ephemeral'
- [1833545](https://bugs.launchpad.net/bugs/1833545): After removing a controller rackd still tries to update DNS
- [1840049](https://bugs.launchpad.net/bugs/1840049): [UI] When changing configuration of an Interface, one has to enter the config twice
- [1852360](https://bugs.launchpad.net/bugs/1852360): Validate network configuration button selects all network scripts that accept an interface parameter
- [1863395](https://bugs.launchpad.net/bugs/1863395): 2.6.2 Unable to change power type to manual via UI
- [1871605](https://bugs.launchpad.net/bugs/1871605): Updating controller name shouldn't be allowed in the UI
- [1874355](https://bugs.launchpad.net/bugs/1874355): Controller details page not updated to match machine details page designs
- [1881948](https://bugs.launchpad.net/bugs/1881948): IPv6 address for power control fails
- [1882633](https://bugs.launchpad.net/bugs/1882633): Logical volume size is required
- [1883232](https://bugs.launchpad.net/bugs/1883232): UI: UI application cached after upgrade
- [1890262](https://bugs.launchpad.net/bugs/1890262): UI: Error message with a custom image URL doesn't clear
- [1893226](https://bugs.launchpad.net/bugs/1893226): Machine-specific minimal commissioning kernel resets to MAAS wide default
- [1893670](https://bugs.launchpad.net/bugs/1893670): UI: display bios_boot_mode in the web UI
- [1898131](https://bugs.launchpad.net/bugs/1898131): IP address gets hidden, instead of subnet when window is resized
- [1905636](https://bugs.launchpad.net/bugs/1905636): UI: CentOS 7 is the default over CentOS 8
- [1909348](https://bugs.launchpad.net/bugs/1909348): MAAS 2.9.0 DNS zone remove @ labels impossible
- [1913800](https://bugs.launchpad.net/bugs/1913800): PCI and USB information missing from controllers page
- [1918963](https://bugs.launchpad.net/bugs/1918963): Controllers page out of sync with nodes
- [1918978](https://bugs.launchpad.net/bugs/1918978): doesn't detect the subarchitecture xgene-uboot for a HP m400 cartridge
- [1927748](https://bugs.launchpad.net/bugs/1927748): Need additional form inputs for DHCP Snippets associated with ipranges
- [1929478](https://bugs.launchpad.net/bugs/1929478): Commissioning fails with binary data in IPMI Lan_Conf_Security_Keys
- [1929973](https://bugs.launchpad.net/bugs/1929973): "Controllers have different installation sources." is not shown on the controllers page
- [1931654](https://bugs.launchpad.net/bugs/1931654): domain.set_default error handling just returns id
- [1933408](https://bugs.launchpad.net/bugs/1933408): Setting discovery parent returns cryptic error
- [1938296](https://bugs.launchpad.net/bugs/1938296): MAAS 3.0 incorrectly calculates the amount of free space on drive
- [1940909](https://bugs.launchpad.net/bugs/1940909): UI: Allow to create a machine as deployed from the UI
- [1951229](https://bugs.launchpad.net/bugs/1951229): CLI: Uninformative errors when adding non-existent tags to machines
- [1955671](https://bugs.launchpad.net/bugs/1955671): support for rocky linux UEFI
- [1956766](https://bugs.launchpad.net/bugs/1956766): UI: Unable to deploy CentOS7 - centos/focal not a supported combination
- [1958817](https://bugs.launchpad.net/bugs/1958817): Cannot delete a tag from multiple machines in a bulk with Web UI
- [1959856](https://bugs.launchpad.net/bugs/1959856): newly added tags in UI don't show until refresh/page change
- [1960571](https://bugs.launchpad.net/bugs/1960571): Domain name should be checked for duplicate against maas_internal_domain
- [1961627](https://bugs.launchpad.net/bugs/1961627): confusing UI to add the first network space
- [1964024](https://bugs.launchpad.net/bugs/1964024): smartctl-validate test runs even when explicitly removed from commissioning step
- [1965172](https://bugs.launchpad.net/bugs/1965172): [3.1] Setting interface into unconfigured does not reset auto-assign IP mode
- [1967577](https://bugs.launchpad.net/bugs/1967577): commissioning fails w/ 3.2-beta1: "please fill out the field"
- [1970803](https://bugs.launchpad.net/bugs/1970803): CLI event filters give extraneous results with more than one filter
- [1971152](https://bugs.launchpad.net/bugs/1971152): Authentication broken with MASS using Candid
- [1973236](https://bugs.launchpad.net/bugs/1973236): MAAS reports failure to detect storage that it already detected
- [1973617](https://bugs.launchpad.net/bugs/1973617): refresh a lxd KVM host resources after it was added
- [1976194](https://bugs.launchpad.net/bugs/1976194): init rack can't find secrets
- [1976196](https://bugs.launchpad.net/bugs/1976196): Controller WebSocket handler contains unimplemented methods
- [1977820](https://bugs.launchpad.net/bugs/1977820): Some tests are skipped due to the "perf" filtering
- [1977822](https://bugs.launchpad.net/bugs/1977822): ERROR: Redfish 'Redfish' object has no attribute '_get_network_interface'
- [1977864](https://bugs.launchpad.net/bugs/1977864): 30-maas-01-bmc-config: ERROR: Redfish string indices must be integers
- [1977866](https://bugs.launchpad.net/bugs/1977866): 30-maas-01-bmc-config: ERROR: 169.254.95.120/16 has host bits set
- [1977895](https://bugs.launchpad.net/bugs/1977895): Certificate metadata missing from controller websocket model
- [1977942](https://bugs.launchpad.net/bugs/1977942): 30-maas-01-bmc-config: ERROR: Redfish 'Redfish' object has no attribute '_bmc_config'
- [1977951](https://bugs.launchpad.net/bugs/1977951): 30-maas-01-bmc-config: ERROR: Redfish nonnumeric port: 'None'
- [1978024](https://bugs.launchpad.net/bugs/1978024): maas auto-creates interface name for docker bridge on controller, which breaks bind
- [1978037](https://bugs.launchpad.net/bugs/1978037): Drop legacy /l/ UI prefix
- [1978072](https://bugs.launchpad.net/bugs/1978072): 30-maas-01-bmc-config: ERROR: Redfish 'dict' object has no attribute 'split'
- [1978121](https://bugs.launchpad.net/bugs/1978121): 30-maas-01-bmc-config: ERROR: ERROR: Unable to add BMC user!
- [1978154](https://bugs.launchpad.net/bugs/1978154): MAAS 3.1 introduces breaking changes for custom centos7 images
- [1978922](https://bugs.launchpad.net/bugs/1978922): MAAS 3.1 - Missing button "Create datastore" in VMFS7 storage layout
- [1979039](https://bugs.launchpad.net/bugs/1979039): TLS certificates are not recognised by CLI maas <profile> boot-resources create action
- [1979256](https://bugs.launchpad.net/bugs/1979256): Add config option for UI theme
- [1979316](https://bugs.launchpad.net/bugs/1979316): UI stuck at the initial configuration page
- [1979317](https://bugs.launchpad.net/bugs/1979317): Initial configuration form doesn't allow proxy URL with hostname
- [1980347](https://bugs.launchpad.net/bugs/1980347): MAAS snap fails to parse supervisor STOPPING state
- [1980436](https://bugs.launchpad.net/bugs/1980436): MAAS CLI with anonymous access fails when TLS is enabled
- [1980490](https://bugs.launchpad.net/bugs/1980490): MAAS regiond IPC crash due to a machine-resources binary crash when parsing some VPDs
- [1980818](https://bugs.launchpad.net/bugs/1980818): Configure DHCP for VLAN
- [1980846](https://bugs.launchpad.net/bugs/1980846): IP Address tooltip on Machines page blocks access to everything underneath and doesnt disappear until mouse-off
- [1981536](https://bugs.launchpad.net/bugs/1981536): volume group creation fails on md device - MAAS 3.2
- [1981560](https://bugs.launchpad.net/bugs/1981560): upgrade from 3.1 to 3.2 using debian packages missing steps
- [1982208](https://bugs.launchpad.net/bugs/1982208): agent.yaml.example is missing when maas is installed via deb package
- [1982315](https://bugs.launchpad.net/bugs/1982315): MAAS not sending correct metadata_url
- [1982328](https://bugs.launchpad.net/bugs/1982328): update docstring to include informative not found change
- [1982846](https://bugs.launchpad.net/bugs/1982846): Missing update_interface method on controller websocket handler
- [1982866](https://bugs.launchpad.net/bugs/1982866): MAAS Breaks historical custom images
- [1982984](https://bugs.launchpad.net/bugs/1982984): reverse-proxy service is not displayed for region controller
- [1983624](https://bugs.launchpad.net/bugs/1983624): Fresh MAAS 3.2 install failed to find controller
- [1984141](https://bugs.launchpad.net/bugs/1984141): duplicate tag results in failed deployment for KVM host
- [1984852](https://bugs.launchpad.net/bugs/1984852): machine.filter_options returns empty, duplicate and mis-typed options
- [1984994](https://bugs.launchpad.net/bugs/1984994): machine.list fails for some group_key values
- [1985741](https://bugs.launchpad.net/bugs/1985741): Commissioning script 'maas-kernel-cmdline' fails with bonded interfaces
- [1986372](https://bugs.launchpad.net/bugs/1986372): UI: Setting Default minimum kernel version for commissioning blocks deployments
- [1987874](https://bugs.launchpad.net/bugs/1987874): interface.update_ip_addresses raise an Exception when exsits multiple StaticIPAddress
- [1988543](https://bugs.launchpad.net/bugs/1988543): VM Discovery fails, resulting in " Error: An architecture is required." when composing a LXD VM
- [1988759](https://bugs.launchpad.net/bugs/1988759): Provisioning LXD vmhost fails
- [1988769](https://bugs.launchpad.net/bugs/1988769): The ppc64 machine in our lab fails during commissioning
- [1988874](https://bugs.launchpad.net/bugs/1988874): Release command is failing for ppc64 machine in our lab
- [1989949](https://bugs.launchpad.net/bugs/1989949): provisioningserver TestGetSourceAddress.test_returns_none_if_no_route_found sometimes fails locally
- [1989970](https://bugs.launchpad.net/bugs/1989970): Can't enlist machines on subnets with DNS set
- [1989974](https://bugs.launchpad.net/bugs/1989974): rackd fails on CIS-hardened machine with "Failed to update and/or record network interface configuration: Expecting value: line 1 column 1 (char 0)"
- [1990014](https://bugs.launchpad.net/bugs/1990014): regiond.conf "debug_http: true" causes image downloads from regiond to fail with 500 error code
- [1990289](https://bugs.launchpad.net/bugs/1990289): allocate call with system_id can allocate a new machine
- [1990649](https://bugs.launchpad.net/bugs/1990649): Kernel parameters form resets to previous value after save
- [1990873](https://bugs.launchpad.net/bugs/1990873): TestKeys - test_get_launchpad_crashes_for_user_not_found
- [1991106](https://bugs.launchpad.net/bugs/1991106): vCenter password field text is visible in settings
- [1991210](https://bugs.launchpad.net/bugs/1991210): Color theme resets with page reload
- [1991229](https://bugs.launchpad.net/bugs/1991229): Selecting all machines in a state in the UI causes traceback in backend
- [1991372](https://bugs.launchpad.net/bugs/1991372): websocket config update notifications are no longer sent
- [1991410](https://bugs.launchpad.net/bugs/1991410): wildcard DNS entry is not allowed
- [1991792](https://bugs.launchpad.net/bugs/1991792): machine.action clone does not accept filter
- [1991795](https://bugs.launchpad.net/bugs/1991795): machine.action does not always throw errors for failed machines
- [1992185](https://bugs.launchpad.net/bugs/1992185): unable to deploy a machine with vmhost if a bond interface was created
- [1992332](https://bugs.launchpad.net/bugs/1992332): websocket machine.list parent group label should return hostname
- [1992686](https://bugs.launchpad.net/bugs/1992686): MAAS 3.3 alpha missing two existing filters
- [1992791](https://bugs.launchpad.net/bugs/1992791): Info icons appear/disappear based on checked options in subnet page
- [1992975](https://bugs.launchpad.net/bugs/1992975): Grouping by parents fails if there's more than one page
- [1993289](https://bugs.launchpad.net/bugs/1993289): Pod storage pool path can't be blank

More bugs are planned for later 3.3 releases.

<a href="#heading--other-maas-versions"><h2 id="heading--other-maas-versions">Release notes for other MAAS versions</h2></a>

Here are release notes for other relatively recent MAAS versions:

- [MAAS 3.2](/t/what-is-new-with-maas-3-2/5962)
- [MAAS 3.1](/t/what-is-new-with-maas-3-1/5964)
- [MAAS 3.0](/t/what-is-new-with-maas-3-0/5963)
- [MAAS 2.9](/t/what-is-new-with-maas-2-9/5961)
- [MAAS 2.8](/t/what-is-new-with-maas-2-8/5994)
- [MAAS 2.7](/t/what-is-new-with-maas-2-7/5993)