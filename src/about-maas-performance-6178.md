<!-- "About MAAS performance" -->
The MAAS engineering team actively works to improve the performance of MAAS.  This article explains how performance measurements work, and provides [reference tables](#heading--tables-of-metrics) for the various metrics used by MAAS.

<a href="#heading--performance-measurements"><h2 id="heading--performance-measurements">Recent performance measurements</h2></a>

Recently, we improved the API performance of MAAS, by testing it with simulated loads.  For this testing, we made the following assumptions:

- five rack controllers
- 48 machines per fabric
- five VMs per LXD host
- three different architectures
- six disks per machine, randomly defined as flat, RAID, LVM, and BCACHE disks
- five network interfaces per machine
- machines in a random status, but mostly Ready or Deployed (which best emulates a real-world scenario)

To measure performance, we use continuous performance monitoring, arranged like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d8a0887dd9d6f01311966c10f5d9093feb76806f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d8a0887dd9d6f01311966c10f5d9093feb76806f.png"></a>

On a daily basis, we generate simulation data based on the assumptions above, for 10, 100, and 1000 machines.  These three datapoints help us get a sense of how our performance improvements scale.  A Jenkins tool exercises both the REST API and the WebSocket API, trapping the results in a database, from which we can build a dashboard.  The dashboard looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f5f831164e70273e81b4120b442469f665e16b47.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f5f831164e70273e81b4120b442469f665e16b47.png"></a>

Note that we always compare the current stable release with the release in development, so that we can spot issues before they become harder to find and fix.  We also capture profiling data that allows us to find bottlenecks, generating a heatmap that shows which parts of the code are causing issues at the moment.

For example, comparing MAAS 3.2 to MAAS 3.1, machine listings load, on average, 32% faster for the datasets we're using.  

<a href="#heading--history-of-performance-efforts"><h3 id="heading--history-of-performance-efforts">Performance efforts to date</h3></a>

Here's a short history of our performance efforts to date:

- This [video show-and-tell](https://discourse.maas.io/t/maas-show-and-tell-is-maas-fast-yet/6105)`↗` documents recent efforts to improve MAAS peformance, with quantitative results.
- Here's some [work done by the UI team](https://discourse.maas.io/t/maas-ui-improving-the-performance-of-maas-ui/5820)`↗` to improve the performance of the UI.

Note that this list only captures the bigger, sustained efforts, although there is a constant focus on weeding out slowdowns when we come across them.

<a href="#heading--collecting-your-own-metrics"><h2 id="heading--collecting-your-own-metrics">Collecting your own metrics</h2></a>

It's possible to [collect your own MAAS metrics](/t/how-to-monitor-maas/5204) -- and even share them with the MAAS engineering team.  We are keen to know everything we can about machine counts, network sizes, and MAAS performance in all areas.  Please use the [discourse performance forum](https://discourse.maas.io/c/maas-performance/26)`↗` to share your feedback and observations.

<a href="#heading--recent-developments"><h2 id="heading--recent-developments">Recent developments</h2></a>

As part of the MAAS 3.2 development effort, we have taken steps to improve the performance of machine listings. To date, we have measured the speed of listing a large number (100-1000) of machines via the REST API to be 32% faster, on average.

<a href="#heading--next-steps"><h2 id="heading--next-steps">Next steps</h2></a>

Currently, we are actively working to improve MAAS performance for other operations, such as search.

<a href="#heading--tables-of-metrics"><h2 id="heading--tables-of-metrics">Tables of available metrics</h2></a>

Currently, there are three types of available metrics: 

- [Cluster metrics](#heading--cluster-metrics-table)
- [Node performance metrics](#heading--node-performance-metrics-table)
- [Performance metrics](#heading--performance-metrics)

The tables are generally self-explanatory.

<a href="#heading--cluster-metrics-table"><h3 id="heading--cluster-metrics-table">Cluster metrics</h3></a>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">Metric name</td>
<td class="org-left">Labels</td>
<td class="org-left">Descripton</td>
<td class="org-left">Alert levels</td>
</tr>


<tr>
<td class="org-left">maas_machines</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">The number of machines known by MAAS, by status</td>
<td class="org-left">Any fast variation in the number of machines should trigger an alert</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: machine status</td>
<td class="org-left">Unit = count of machines</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_nodes</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of nodes known by MAAS per type (machine, device or controller)</td>
<td class="org-left">Any fast variation in the number of nodes should trigger an alert</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">type: type of node (machine/device/controller)</td>
<td class="org-left">Unit = count of machines</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_net_spaces</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of network spaces</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of spaces</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_net_fabrics</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of network fabrics</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of fabrics</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_net_vlans</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of network VLANs</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of VLANs</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_net_subnets_v4</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of IPv4 subnets</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count IPv4 subnets</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_net_subnets_v6</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of IPv6 subnets</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of IPv6 subnets</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_net_subnet_ip_count</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of IPs in a subnet by status</td>
<td class="org-left">You should monitor the number of "available" IPs, as the depletion of the pool can prevent new deployments</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: available or used</td>
<td class="org-left">Unit = count of IPs</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_net_subnet_ip_dynamic</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of used dynamic IPs in a subnet</td>
<td class="org-left">You should monitor the number of "available" IPs, as the depletion of the pool can prevent new deployments</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: available or used</td>
<td class="org-left">Unit = count of used dynamic IPs</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">cidr: subnet address</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_net_subnet_ip_reserved</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of used reserved IPs in a subnet</td>
<td class="org-left">You should monitor the number of "available" IPs, as the depletion of the pool can prevent new deployments</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: available or used</td>
<td class="org-left">Unit = count of used reserved IPs</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">cidr: subnet address</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_net_subnet_ip_static</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of used static IPs in a subnet</td>
<td class="org-left">You should monitor the number of "available" IPs, as the depletion of the pool can prevent new deployments</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: available or used</td>
<td class="org-left">Unit = count of used static IPs</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">cidr: subnet address</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_machines_total_mem</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Amount of combined memory for all machines</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = megabytes of memory</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_machines_total_cpu</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Amount of combined CPU counts for all machines</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of CPUs</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_machines_total_storage</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Amount of combined storage space for all machines</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = bytes of storage</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_kvm_pods</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of KVM hosts</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of KVM hosts</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_kvm_machines</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of virtual machines allocated in KVM hosts</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of virtual machines</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_kvm_cores</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Total number of CPU cores present on KVM hosts</td>
<td class="org-left">You should monitor the number of "available" CPU cores, as the depletion of the pool can prevent new deployments</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: available or used</td>
<td class="org-left">Unit = count of KVM cores</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_kvm_memory</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Total amount of RAM present on KVM hosts</td>
<td class="org-left">You should monitor the amount of "available" RAM, as the depletion of the pool can prevent new deployments</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: available or used</td>
<td class="org-left">Unit = megabytes of memory</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_kvm_storage</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Total amount of storage space present on KVM hosts</td>
<td class="org-left">You should monitor the amount of "available" storage space, as the depletion of the pool can prevent new deployments</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: available or used</td>
<td class="org-left">Unit = bytes of storage</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_kvm_overcommit_cores</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Total number of CPU cores present on KVM hosts adjusted by the overcommit setting</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = overcommitted number of cores</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_kvm_overcommit_memory</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Total amount of RAM present on KVM hosts adjusted by the overcommit setting</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = overcommitted megabytes of memory</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_machine_arches</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Total number of machines per architecture</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">arch: machine architecture</td>
<td class="org-left">Unit = count of machines</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_custom_static_images_uploaded</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of custom OS images present in MAAS</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">base_image: custom image base OS</td>
<td class="org-left">Unit = count of images</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">file_type: image file type</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_custom_static_images_deployed</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number deployed machines running custom OS images</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of images</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_vmcluster_projects</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Number of KVM clusters</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of projects</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_vmcluster_hosts</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Total number of KVM hosts in clusters</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of VM hosts</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_vmcluster_vms</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Total number of virtual machines in KVM clusters</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit = count of virtual machines</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>

<a href="#heading--node-performance-metrics-table"><h3 id="heading--node-performance-metrics-table">Node performance metrics</h3></a>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">Metric name</td>
<td class="org-left">Labels</td>
<td class="org-left">Descripton</td>
<td class="org-left">Alert levels</td>
</tr>


<tr>
<td class="org-left">maas_node_cpu_time</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Standard Linux CPU performance counters. see man proc (5)</td>
<td class="org-left">High rates of work performed by either 'user' or 'system'  can indicate this controller is overloaded, while increasing amounts of time spent in 'iowait' could indicate disk degradation.</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: counter</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">Unit: jiffies</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">state: CPU state (see /proc/stat)</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_AnonPages</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total anon (non-file) pages mapped into the page tables</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_Buffers</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total temporary storage element in memory</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_Cached</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total page cache size</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_CommitLimit</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total memory currently available for allocation on the system</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_Committed_AS</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total memory already allocated on the system</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_Dirty</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total memory that currently waits to be written back to the disk</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_HugePages_Free</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total amount of unallocated huge pages</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_HugePages_Rsvd</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">number of reserved huge pages for allocation from the pool</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_HugePages_Surp</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">number of surplus huge pages</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_HugePages_Total</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">total size of the huge pages pool</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_Mapped</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total memory used by mmaped files</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_MemAvailable</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total available RAM to processes</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_MemFree</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">total free RAM</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_MemTotal</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">total usable RAM</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_PageTables</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total amount of memory consumed by page tables</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_Shmem</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total  memory used by shared memory and tmpfs</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_Slab</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total memory used by kernel-level data structures cache</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_SReclaimable</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total memory in reclaimable parts of Slab</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_SUnreclaim</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total memory in unreclaimable parts of Slab</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_SwapCached</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total recently used swap memory</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_SwapTotal</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total amount of swap space available</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_SwapFree</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total unused swap space</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_VmallocUsed</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total size of the used vmalloc memory space</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_Writeback</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total  memory that is being written back at the moment</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_node_mem_WritebackTmp</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total temporary buffer for writebacks</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: gauge</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">pid: process system id</td>
<td class="org-left">Unit: kB</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">service_type: region or rack</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>

<a href="#heading--performance-metrics"><h3 id="heading--performance-metrics">Performance metrics</h3></a>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">Metric name</td>
<td class="org-left">Labels</td>
<td class="org-left">Descripton</td>
<td class="org-left">Alert levels</td>
</tr>


<tr>
<td class="org-left">maas_http_request_latency</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">The time MAAS takes to process a REST API call. It doesn't include any time associated with network, including proxy processing</td>
<td class="org-left">The average response time depends on the endpoint, the controller hardware and size of the cluster. In most cases you can expect a response in less than 30 seconds</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">method: HTTP method</td>
<td class="org-left">Unit: seconds</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">op: REST API operation name</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">path: REST API endpoint</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: HTTP response status code</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_http_response_size</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">The size of REST API responses</td>
<td class="org-left">None defined</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">method: HTTP method</td>
<td class="org-left">Unit: bytes</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">op: REST API operation name</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">path: REST API endpoint</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: HTTP response status code</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_http_request_query_count</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">The number of database operations executed per REST API call</td>
<td class="org-left">The expected maximum number of DB operations performed in a single request depends on the MAAS version. Currently, values over 30 are considered potential bugs.</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">method: HTTP method</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">op: REST API operation name</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">path: REST API endpoint</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: HTTP response status code</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_http_request_query_latency</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">The time required to perform a single database operation during a REST API call. The database latency is measured from the moment MAAS starts a transaction until it gets the reponse</td>
<td class="org-left">The average latency depends on the cluster size and load in the database. Increasing latency trends can point to database degradation or the need to increase resources</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">method: HTTP method</td>
<td class="org-left">Unit: seconds</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">op: REST API operation name</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">path: REST API endpoint</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">status: HTTP response status code</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_rack_region_rpc_call_latency</td>
<td class="org-left">call: RPC operation</td>
<td class="org-left">The time a Region controller takes to perform a RPC call to a Rack controller. The latency is measured from the request to the response.</td>
<td class="org-left">The average latency depends on the controllers involved and the load in the Rack. Spikes might point to transient network issues, while high average values can indicate the need to scale up MAAS either with a higher capacity controller or by adding more controllers</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Unit: seconds</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_region_rack_rpc_call_latency</td>
<td class="org-left">call: RPC operation</td>
<td class="org-left">The time a Rack controller takes to perform a RPC call to a Region controller. The latency is measured from the request to the response.</td>
<td class="org-left">The average latency depends on the controllers involved and the load in the Region. Spikes might point to transient network issues, while high average values can indicate the need to scale up MAAS either with a higher capacity controller or by adding more controllers</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Unit: seconds</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_websocket_call_query_count</td>
<td class="org-left">call: WS operation</td>
<td class="org-left">The number of database operations executed per WebSocket call</td>
<td class="org-left">The expected maximum number of DB operations performed in a single request depends on the MAAS version. Currently, values over 30 are considered potential bugs.</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_websocket_call_query_latency</td>
<td class="org-left">call: WS operation</td>
<td class="org-left">The time required to perform a single database operation during a WebSocket call. The database latency is measured from the moment MAAS starts a transaction until it gets the reponse</td>
<td class="org-left">The average latency depends on the cluster size and load in the database. Increasing latency trends can point to database degradation or the need to increase resources</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Unit: seconds</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_websocket_call_latency</td>
<td class="org-left">call: WS operation</td>
<td class="org-left">The time MAAS takes to process a WebSocket call. It doesn't include any time associated with network, including proxy processing</td>
<td class="org-left">The average response time depends on the operation, the controller hardware and size of the cluster. In most cases you can expect a response in less than 30 seconds</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Unit: seconds</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_dns_update_latency</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">The time MAAS takes to setup all zones in the DNS service per update type, which can be 'reload' (cold-start) or 'dynamic' (RNDC operation)</td>
<td class="org-left">The average time of a reload operation depends on the number of zones and records, and can take a few seconds to complete. A dynamic operation should be much faster, usually under 2 seconds.</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">update_type: reload or dynamic</td>
<td class="org-left">Unit: seconds</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_dns_full_zonefile_write_count</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Count of full DNS zone rewrite operations</td>
<td class="org-left">Full DNS zone rewrite operations should not occur very often, so a high rate of this operation could indicate something abnormal in MAAS</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: counter</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">zone: DNS zone name</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_dns_dynamic_update_count</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Count of dynamic DNS zone update operations</td>
<td class="org-left">MAAS prefers dynamic updates whenever possible, so the rate of this operation should be similar to the rate of machine operations</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: counter</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">zone: DNS zone name</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_rpc_pool_exhaustion_count</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">number of occurances of the RPC connection pool allocate its maxmimum number of connections</td>
<td class="org-left">MAAS automatically manages its connection pool size, so a number of occurences of this is normal. Starting a new connection adds latency to RPC calls, so you might want to tune the `max_idle_rpc_connections` and `max_rpc_connections` parameters if you feel this is occurring too frequently</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: counter</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_lxd_fetch_machine_failure</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total number of failures for fetching LXD machines</td>
<td class="org-left">Failures to fetch LXD VM information can have many reasons, including network issues and high load in the KVM host.</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: counter</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_lxd_disk_creation_failure</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total number of failures of LXD disk creation</td>
<td class="org-left">Failures to allocate storage for a LXD VM are mainly caused by storage pool exaustion</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: counter</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_virsh_storage_pool_creation_failure</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total number of failures of virsh storage pool creation</td>
<td class="org-left">Failures to allocate storage for a Virsh VM are mainly caused by storage pool exaustion</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: counter</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_virsh_fetch_mac_failure</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total number of failures of virsh interfaces enumeration</td>
<td class="org-left">Failures to fetch Virsh VM information can have many reasons, including network issues, Virsh configuration errors and high load in the KVM host.</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: counter</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_virsh_fetch_description_failure</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Total number of failures of virsh domain description</td>
<td class="org-left">Failures to fetch Virsh VM information can have many reasons, including network issues, Virsh configuration errors and high load in the KVM host.</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: counter</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Unit: none</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">maas_tftp_file_transfer_latency</td>
<td class="org-left">host: controller IP address</td>
<td class="org-left">Time required to transfer a file to a machine using TFTP</td>
<td class="org-left">The average time required to transfer a file depends on the file size, network load and the machine TFTP client implementation. Increasing transfer times could mean network connectivity issues or link congestion</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">maas_id: MAAS cluster UUID</td>
<td class="org-left">Type: histogram</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">filename: file requested</td>
<td class="org-left">Unit: seconds</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>

