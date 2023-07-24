<!-- "Metrics reference" -->
This document provides detailed reference information for the available MAAS metrics. 

- [Cluster metrics](#heading--cluster-metrics)
  - [maas_machines](#heading--maas_machines)
  - [maas_nodes](#heading--maas_nodes)
  - [maas_net_spaces](#heading--maas_net_spaces)
  - [maas_net_fabrics](#heading--maas_net_fabrics)
  - [maas_net_vlans](#heading--maas_net_vlans)
  - [maas_net_subnets_v4](#heading--maas_net_subnets_v4)
  - [maas_net_subnets_v6](#heading--maas_net_subnets_v6)
  - [maas_net_subnet_ip_count](#heading--maas_net_subnet_ip_count)
  - [maas_net_subnet_ip_dynamic](#heading--maas_net_subnet_ip_dynamic)
  - [maas_net_subnet_ip_reserved](#heading--maas_net_subnet_ip_reserved)
  - [maas_net_subnet_ip_static](#heading--maas_net_subnet_ip_static)
  - [maas_machines_total_mem](#heading--maas_machines_total_mem)
  - [maas_machines_total_cpu](#heading--maas_machines_total_cpu)
  - [maas_machines_total_storage](#heading--maas_machines_total_storage)
  - [maas_kvm_pods](#heading--maas_kvm_pods)
  - [maas_kvm_machines](#heading--maas_kvm_machines)
  - [maas_kvm_cores](#heading--maas_kvm_cores)
  - [maas_kvm_memory](#heading--maas_kvm_memory)
  - [maas_kvm_storage](#heading--maas_kvm_storage)
  - [maas_kvm_overcommit_cores](#heading--maas_kvm_overcommit_cores)
  - [maas_kvm_overcommit_memory](#heading--maas_kvm_overcommit_memory)
  - [maas_machine_arches](#heading--maas_machine_arches)
  - [maas_custom_static_images_uploaded](#heading--maas_custom_static_images_uploaded)
  - [maas_custom_static_images_deployed](#heading--maas_custom_static_images_deployed)
  - [maas_vmcluster_projects](#heading--maas_vmcluster_projects)
  - [maas_vmcluster_hosts](#heading--maas_vmcluster_hosts)
  - [maas_vmcluster_vms](#heading--maas_vmcluster_vms)
- [Performance metrics](#heading--performance-metrics)
  - [maas_http_request_latency](#heading--maas_http_request_latency)
  - [maas_http_response_size](#heading--maas_http_response_size)
  - [maas_http_request_query_count](#heading--maas_http_request_query_count)
  - [maas_http_request_query_latency](#heading--maas_http_request_query_latency)
  - [maas_rack_region_rpc_call_latency](#heading--maas_rack_region_rpc_call_latency)
  - [maas_region_rack_rpc_call_latency](#heading--maas_region_rack_rpc_call_latency)
  - [maas_websocket_call_query_count](#heading--maas_websocket_call_query_count)
  - [maas_websocket_call_query_latency](#heading--maas_websocket_call_query_latency)
  - [maas_websocket_call_latency](#heading--maas_websocket_call_latency)
  - [maas_dns_update_latency](#heading--maas_dns_update_latency)
  - [maas_dns_full_zonefile_write_count](#heading--maas_dns_full_zonefile_write_count)
  - [maas_dns_dynamic_update_count](#heading--maas_dns_dynamic_update_count)
  - [maas_rpc_pool_exhaustion_count](#heading--maas_rpc_pool_exhaustion_count)
  - [maas_lxd_fetch_machine_failure](#heading--maas_lxd_fetch_machine_failure)
  - [maas_lxd_disk_creation_failure](#heading--maas_lxd_disk_creation_failure)
  - [maas_virsh_storage_pool_creation_failure](#heading--maas_virsh_storage_pool_creation_failure)
  - [maas_virsh_fetch_mac_failure](#heading--maas_virsh_fetch_mac_failure)
  - [maas_virsh_fetch_description_failure](#heading--maas_virsh_fetch_description_failure)
  - [maas_tftp_file_transfer_latency](#heading--maas_tftp_file_transfer_latency)

<a href="#heading--cluster-metrics"><h2 id="heading--cluster-metrics">Cluster metrics</h2></a>

<a href="#heading--maas_machines"><h3 id="heading--maas_machines">maas_machines</h3></a>

The number of machines known by MAAS, by status

* Type: Gauge
* Unit: Count of machines
* [details="Labels"]
   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | status | machine status |
   [/details]

<a href="#heading--maas_nodes"><h3 id="heading--maas_nodes">maas_nodes</h3></a>

Number of nodes known by MAAS per type (machine, device or controller)

* Type: Gauge
* Unit: Count of machines
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | type | type of node (machine/device/controller) |
   [/details]

<a href="#heading--maas_net_spaces"><h3 id="heading--maas_net_spaces">maas_net_spaces</h3></a>

Number of network spaces

* Type: Gauge
* Unit: Count of spaces
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_net_fabrics"><h3 id="heading--maas_net_fabrics">maas_net_fabrics</h3></a>

Number of network fabrics

* Type: Gauge
* Unit: Count of fabrics
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_net_vlans"><h3 id="heading--maas_net_vlans">maas_net_vlans</h3></a>

Number of network VLANs

* Type: Gauge
* Unit: Count of vlans
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_net_subnets_v4"><h3 id="heading--maas_net_subnets_v4">maas_net_subnets_v4</h3></a>

Number of IPv4 subnets

* Type: Gauge
* Unit: Count ipv4 subnets
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_net_subnets_v6"><h3 id="heading--maas_net_subnets_v6">maas_net_subnets_v6</h3></a>

Number of IPv6 subnets

* Type: Gauge
* Unit: Count of ipv6 subnets
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_net_subnet_ip_count"><h3 id="heading--maas_net_subnet_ip_count">maas_net_subnet_ip_count</h3></a>

Number of IPs in a subnet by status

* Type: Gauge
* Unit: Count of ips
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | status | available or used |
   [/details]

<a href="#heading--maas_net_subnet_ip_dynamic"><h3 id="heading--maas_net_subnet_ip_dynamic">maas_net_subnet_ip_dynamic</h3></a>

Number of used dynamic IPs in a subnet

* Type: Gauge
* Unit: Count of used dynamic ips
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | status | available or used |
   | cidr | subnet address |
   [/details]

<a href="#heading--maas_net_subnet_ip_reserved"><h3 id="heading--maas_net_subnet_ip_reserved">maas_net_subnet_ip_reserved</h3></a>

Number of used reserved IPs in a subnet

* Type: Gauge
* Unit: Count of used reserved ips
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | status | available or used |
   | cidr | subnet address |
   [/details]

<a href="#heading--maas_net_subnet_ip_static"><h3 id="heading--maas_net_subnet_ip_static">maas_net_subnet_ip_static</h3></a>

Number of used static IPs in a subnet

* Type: Gauge
* Unit: Count of used static ips
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | status | available or used |
   | cidr | subnet address |
   [/details]

<a href="#heading--maas_machines_total_mem"><h3 id="heading--maas_machines_total_mem">maas_machines_total_mem</h3></a>

Amount of combined memory for all machines

* Type: Gauge
* Unit: Megabytes of memory
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_machines_total_cpu"><h3 id="heading--maas_machines_total_cpu">maas_machines_total_cpu</h3></a>

Amount of combined CPU counts for all machines

* Type: Gauge
* Unit: Count of cpus
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_machines_total_storage"><h3 id="heading--maas_machines_total_storage">maas_machines_total_storage</h3></a>

Amount of combined storage space for all machines

* Type: Gauge
* Unit: Bytes of storage
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_kvm_pods"><h3 id="heading--maas_kvm_pods">maas_kvm_pods</h3></a>

Number of KVM hosts

* Type: Gauge
* Unit: Count of kvm hosts
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_kvm_machines"><h3 id="heading--maas_kvm_machines">maas_kvm_machines</h3></a>

Number of virtual machines allocated in KVM hosts

* Type: Gauge
* Unit: Count of virtual machines
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_kvm_cores"><h3 id="heading--maas_kvm_cores">maas_kvm_cores</h3></a>

Total number of CPU cores present on KVM hosts

* Type: Gauge
* Unit: Count of kvm cores
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | status | available or used |
   [/details]

<a href="#heading--maas_kvm_memory"><h3 id="heading--maas_kvm_memory">maas_kvm_memory</h3></a>

Total amount of RAM present on KVM hosts

* Type: Gauge
* Unit: Megabytes of memory
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | status | available or used |
   [/details]

<a href="#heading--maas_kvm_storage"><h3 id="heading--maas_kvm_storage">maas_kvm_storage</h3></a>

Total amount of storage space present on KVM hosts

* Type: Gauge
* Unit: Bytes of storage
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | status | available or used |
   [/details]

<a href="#heading--maas_kvm_overcommit_cores"><h3 id="heading--maas_kvm_overcommit_cores">maas_kvm_overcommit_cores</h3></a>

Total number of CPU cores present on KVM hosts adjusted by the overcommit setting

* Type: Gauge
* Unit: Overcommitted number of cores
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_kvm_overcommit_memory"><h3 id="heading--maas_kvm_overcommit_memory">maas_kvm_overcommit_memory</h3></a>

Total amount of RAM present on KVM hosts adjusted by the overcommit setting

* Type: Gauge
* Unit: Overcommitted megabytes of memory
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_machine_arches"><h3 id="heading--maas_machine_arches">maas_machine_arches</h3></a>

Total number of machines per architecture

* Type: Gauge
* Unit: Count of machines
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | arch | machine architecture |
   [/details]

<a href="#heading--maas_custom_static_images_uploaded"><h3 id="heading--maas_custom_static_images_uploaded">maas_custom_static_images_uploaded</h3></a>

Number of custom OS images present in MAAS

* Type: Gauge
* Unit: Count of images
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   | base_image | custom image base OS |
   | file_type | image file type |
   [/details]

<a href="#heading--maas_custom_static_images_deployed"><h3 id="heading--maas_custom_static_images_deployed">maas_custom_static_images_deployed</h3></a>

Number deployed machines running custom OS images

* Type: Gauge
* Unit: Count of images
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_vmcluster_projects"><h3 id="heading--maas_vmcluster_projects">maas_vmcluster_projects</h3></a>

Number of KVM clusters

* Type: Gauge
* Unit: Count of projects
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_vmcluster_hosts"><h3 id="heading--maas_vmcluster_hosts">maas_vmcluster_hosts</h3></a>

Total number of KVM hosts in clusters

* Type: Gauge
* Unit: Count of vm hosts
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_vmcluster_vms"><h3 id="heading--maas_vmcluster_vms">maas_vmcluster_vms</h3></a>

Total number of virtual machines in KVM clusters

* Type: Gauge
* Unit: Count of virtual machines
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--performance-metrics"><h2 id="heading--performance-metrics">Performance metrics</h2></a>

<a href="#heading--maas_http_request_latency"><h3 id="heading--maas_http_request_latency">maas_http_request_latency</h3></a>

The time MAAS takes to process a REST API call. It doesn't include any time associated with network, including proxy processing

* Type: Histogram
* Unit: Seconds
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   | method | HTTP method |
   | op | REST API operation name |
   | path | REST API endpoint |
   | status | HTTP response status code |
   [/details]

<a href="#heading--maas_http_response_size"><h3 id="heading--maas_http_response_size">maas_http_response_size</h3></a>

The size of REST API responses

* Type: Histogram
* Unit: Bytes
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   | method | HTTP method |
   | op | REST API operation name |
   | path | REST API endpoint |
   | status | HTTP response status code |
   [/details]

<a href="#heading--maas_http_request_query_count"><h3 id="heading--maas_http_request_query_count">maas_http_request_query_count</h3></a>

The number of database operations executed per REST API call

* Type: Histogram
* Unit: None
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   | method | HTTP method |
   | op | REST API operation name |
   | path | REST API endpoint |
   | status | HTTP response status code |
   [/details]

<a href="#heading--maas_http_request_query_latency"><h3 id="heading--maas_http_request_query_latency">maas_http_request_query_latency</h3></a>

The time required to perform a single database operation during a REST API call. The database latency is measured from the moment MAAS starts a transaction until it gets the reponse

* Type: Histogram
* Unit: Seconds
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   | method | HTTP method |
   | op | REST API operation name |
   | path | REST API endpoint |
   | status | HTTP response status code |
   [/details]

<a href="#heading--maas_rack_region_rpc_call_latency"><h3 id="heading--maas_rack_region_rpc_call_latency">maas_rack_region_rpc_call_latency</h3></a>

The time a Region controller takes to perform a RPC call to a Rack controller. The latency is measured from the request to the response.

* Type: Histogram
* Unit: Seconds
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | call | RPC operation |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_region_rack_rpc_call_latency"><h3 id="heading--maas_region_rack_rpc_call_latency">maas_region_rack_rpc_call_latency</h3></a>

The time a Rack controller takes to perform a RPC call to a Region controller. The latency is measured from the request to the response.

* Type: Histogram
* Unit: Seconds
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | call | RPC operation |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_websocket_call_query_count"><h3 id="heading--maas_websocket_call_query_count">maas_websocket_call_query_count</h3></a>

The number of database operations executed per WebSocket call

* Type: Histogram
* Unit: None
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | call | WS operation |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_websocket_call_query_latency"><h3 id="heading--maas_websocket_call_query_latency">maas_websocket_call_query_latency</h3></a>

The time required to perform a single database operation during a WebSocket call. The database latency is measured from the moment MAAS starts a transaction until it gets the reponse

* Type: Histogram
* Unit: Seconds
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | call | WS operation |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_websocket_call_latency"><h3 id="heading--maas_websocket_call_latency">maas_websocket_call_latency</h3></a>

The time MAAS takes to process a WebSocket call. It doesn't include any time associated with network, including proxy processing

* Type: Histogram
* Unit: Seconds
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | call | WS operation |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_dns_update_latency"><h3 id="heading--maas_dns_update_latency">maas_dns_update_latency</h3></a>

The time MAAS takes to setup all zones in the DNS service per update type, which can be 'reload' (cold-start) or 'dynamic' (RNDC operation)

* Type: Histogram
* Unit: Seconds
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   | update_type | reload or dynamic |
   [/details]

<a href="#heading--maas_dns_full_zonefile_write_count"><h3 id="heading--maas_dns_full_zonefile_write_count">maas_dns_full_zonefile_write_count</h3></a>

Count of full DNS zone rewrite operations

* Type: Counter
* Unit: None
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   | zone | DNS zone name |
   [/details]

<a href="#heading--maas_dns_dynamic_update_count"><h3 id="heading--maas_dns_dynamic_update_count">maas_dns_dynamic_update_count</h3></a>

Count of dynamic DNS zone update operations

* Type: Counter
* Unit: None
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   | zone | DNS zone name |
   [/details]

<a href="#heading--maas_rpc_pool_exhaustion_count"><h3 id="heading--maas_rpc_pool_exhaustion_count">maas_rpc_pool_exhaustion_count</h3></a>

number of occurances of the RPC connection pool allocate its maxmimum number of connections

* Type: Counter
* Unit: None
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_lxd_fetch_machine_failure"><h3 id="heading--maas_lxd_fetch_machine_failure">maas_lxd_fetch_machine_failure</h3></a>

Total number of failures for fetching LXD machines

* Type: Counter
* Unit: None
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_lxd_disk_creation_failure"><h3 id="heading--maas_lxd_disk_creation_failure">maas_lxd_disk_creation_failure</h3></a>

Total number of failures of LXD disk creation

* Type: Counter
* Unit: None
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_virsh_storage_pool_creation_failure"><h3 id="heading--maas_virsh_storage_pool_creation_failure">maas_virsh_storage_pool_creation_failure</h3></a>

Total number of failures of virsh storage pool creation

* Type: Counter
* Unit: None
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_virsh_fetch_mac_failure"><h3 id="heading--maas_virsh_fetch_mac_failure">maas_virsh_fetch_mac_failure</h3></a>

Total number of failures of virsh interfaces enumeration

* Type: Counter
* Unit: None
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_virsh_fetch_description_failure"><h3 id="heading--maas_virsh_fetch_description_failure">maas_virsh_fetch_description_failure</h3></a>

Total number of failures of virsh domain description

* Type: Counter
* Unit: None
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   [/details]

<a href="#heading--maas_tftp_file_transfer_latency"><h3 id="heading--maas_tftp_file_transfer_latency">maas_tftp_file_transfer_latency</h3></a>

Time required to transfer a file to a machine using TFTP

* Type: Histogram
* Unit: Seconds
* [details="Labels"]

   | Label | Description |
   | --- | --- |
   | host | controller IP address |
   | maas_id | MAAS cluster UUID |
   | filename | file requested |
   [/details]
