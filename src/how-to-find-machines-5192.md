<!-- "How to find machines" -->
The Machines and Devices pages contain a powerful interactive search bar that lets you filter machines and devices.  This article is designed to help you understand how to use this resource. 

#### This article will explain:

- [How to do simple searches](#heading--simple-searches)
- [How to do filtered searches](#heading--filtered-searches)
- [How to create manual filters](#heading--manual-filters)
- [How to set up exact matching](#heading--exact-matching)
- [How to set up partial matching](#heading--partial-matching)
- [How to include multiple search terms](#heading--multiple-search-terms)

This article also includes a [filter properties reference](#heading--filter-properties)

<a href="#heading--How-to-construct-a-MAAS-search-parameter"><h2 id="heading--How-to-construct-a-MAAS-search-parameter">How to construct a MAAS search parameter</h2></a>

A valid MAAS search parameter looks like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dcf5037cdd886eb85a2d305fd3df111b38865cea.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dcf5037cdd886eb85a2d305fd3df111b38865cea.png"></a>

Each search attribute is placed in the Search box, separated by spaces (if it's an "AND" search operation), or by parentheses and commas (if's it's an "OR" operation).  Specific search parameters use the notation "parameter-name" followed by a colon (":").  For example, here we're searching for "pod:", which equates to the pod name (VM name).  

You can match exactly by using the equals sign ("=") with a filter fragment, or make a partial match by excluding the "=".  You can get an idea how these parameters work by using the filter dropdowns in the UI, which generate a valid search expression in the "Search" box.  There is also a "not" operator ("!") which can be applied to partial or exact matches.

<a href="#heading--simple-searches"><h2 id="heading--simple-searches">How to do simple searches</h2></a>

To begin searching, enter your search text. As you type, MAAS will update search results in real time. You can search across virtually every parameter, including domain, name, tag, power type, IP, status, zone, and so on.

<a href="https://assets.ubuntu.com/v1/ccb90c91-manage-search__2.5_searchbar.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/ccb90c91-manage-search__2.5_searchbar.png"></a>

<a href="#heading--filtered-searches"><h2 id="heading--filtered-searches">How to do filtered searches</h2></a>

Filter your searches to major categories by selecting one from the Filters drop-down menu next to the search bar.

<a href="https://assets.ubuntu.com/v1/6ac5b4ec-manage-search__2.5_filters.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/6ac5b4ec-manage-search__2.5_filters.png"></a>

For example, to find all "New" machines containing the name or tag 'quail', select Status/New from the drop-down Filters menu, and then type the word 'quail' next to it:

<a href="https://assets.ubuntu.com/v1/7b5d8e86-manage-search__2.5_filtered-search.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/7b5d8e86-manage-search__2.5_filtered-search.png"></a>

<a href="#heading--manual-filters"><h3 id="heading--manual-filters">How to create manual filters</h3></a>

Enter filters manually in the search bar to more precisely control your searches:

``` no-highlight
filter-name:([=]val1,...,[=]val2)
```

**Note:** Surround search terms with parentheses when they must occur together, e.g., `status:(failed testing)`.

<a href="#heading--How-to-set-up-exact-matching"><h3 id="heading--How-to-set-up-exact-matching">How to set up exact matching</h3></a>

If you need an exact match, preface the search value with an equal sign. For example, to find machines belonging to a pod named `able-cattle`:

``` no-highlight
pod:=able-cattle
```

<a href="#heading--partial-matching"><h3 id="heading--partial-matching">How to set up partial matching</h3></a>

Without an equal sign, MAAS returns partial matches. For example, the following will display all machines belonging to pods with names containing `able` or `cattle`:

``` no-highlight
pod:able,cattle
```

<a href="#heading--multiple-search-terms"><h3 id="heading--multiple-search-terms">Multiple search terms</h3></a>

MAAS uses Boolean AND logic to evaluate multiple search terms. For example, when you type `pod:able,cattle cpu:=5`, MAAS displays machines that belong to pods with names containing `able` OR `cattle` AND having 5 CPU cores. Similarly, if you enter multiple words into the search tool, e.g., `steady able`, MAAS will display machines matching both terms (e.g., `steady` AND `able`).

<a href="#heading--filter-properties"><h2 id="heading--filter-properties">Filter properties reference</h2></a>

The following table describes the expanded filter set for the MAAS machine list:

- Items marked "Dyn" are dynamic, populated based on existing data, that is, the "Tags" filter only shows tags that currently exist.  
- Items which are not dynamic present the entire range of possible values, regardless of whether that value currently exists in MAAS; for example, all machine status values are available to be filtered, even if no machines currently have that status.
- Items marked "Grp" can be used to group machines, instead of the default machine status.
- Items marked "Man" must be manually entered, i.e., they are not in the UI filter dropdown, but can be entered in the "Search" box if properly formatted (as in the examples given).

See [How to search MAAS](/t/how-to-search-maas/5192) for more details on how to use these parameters.


| Parameter (bold) w/example           | Shows nodes...                   | Dyn | Grp | Man |
|--------------------------------------|----------------------------------|-----|-----|-----|
| **arch**:(=architecture)             | with "architecture"              |     | Grp |     |
| arch:(!=architecture)                | NOT with "architecture"          | Dyn |     |     |
| **zone**:(=zone-name)                | in "zone-name"                   | Dyn | Grp |     |
| zone:(!=zone-name)                   | NOT in "zone-name"               | Dyn |     |     |
| **pool**:(=resource-pool)            | in "resource-pool"               | Dyn | Grp |     |
| pool:(!=resource-pool)               | NOT in "resource-pool"           | Dyn |     |     |
| **pod**:(=pod-name)                  | with "pod-name"                  | Dyn | Grp |     |
| pod:(!=pod-name)                     | NOT with "pod-name"              | Dyn |     |     |
| **pod_type**:(=pod-type)             | with power type "pod-type"       | Dyn | Grp | Man |
| pod_type:(!=pod-type)                | NOT with power type "pod-type"   | Dyn |     | Man |
| **domain**:(=domain-name)            | with "domain-name"               | Dyn | Grp | Man |
| domain:(!=domain-name)               | NOT with "domain-name"           | Dyn |     | Man |
| **status**:(=op-status)              | having "op-status"               |     | Grp |     |
| status:(!=op-status)                 | NOT having "op-status"           | Dyn |     |     |
| **owner**:(=user)                    | owned by "user"                  | Dyn | Grp |     |
| owner:(!=user)                       | NOT owned by "user"              | Dyn |     |     |
| **power_state**:(=power-state)       | having "power-state"             |     | Grp | Man |
| power_state:(!=power-state)          | NOT having "power-state"         | Dyn |     | Man |
| **tags**:(=tag-name)                 | with tag "tag-name"              | Dyn |     |     |
| tags:(!=tag-name)                    | NOT with tag "tag-name"          | Dyn |     |     |
| **fabrics**:(=fabric-name)           | in "fabric-name"                 | Dyn |     |     |
| fabrics:(!=fabric-name)              | NOT in "fabric-name"             | Dyn |     |     |
| **fabric_classes**:(=fabric-class)   | in "fabric-class"                | Dyn |     | Man |
| fabric_classes:(!=fabric-class)      | NOT in "fabric-class"            | Dyn |     | Man |
| **fabric_name**:(=fabric-name)       | in "boot-interface-fabric"       | Dyn |     | Man |
| fabric_name:(!=fabric-name)          | NOT in "boot-interface-fabric"   | Dyn |     | Man |
| **subnets**:(=subnet-name)           | attached to "subnet-name"        | Dyn |     |     |
| subnets:(!=subnet-name)              | Not attached to "subnet-name"    | Dyn |     |     |
| **link_speed**:(link-speed)          | having "link-speed"              | Dyn |     | Man |
| link_speed:(!link-speed)             | NOT having "link-speed"          | Dyn |     | Man |
| **vlans**:(=vlan-name)               | attached to "vlan-name"          | Dyn |     |     |
| vlans:(!=vlan-name)                  | NOT attached to "vlan-name"      | Dyn |     |     |
| **storage**:(storage-MB)             | having "storage-MB"              | Dyn |     | Man |
| **total_storage**:(total-stg-MB)     | having "total-stg-MB"            | Dyn |     | Man |
| total_storage:(!total-stg-MB)        | NOT having "total-stg-MB"        | Dyn |     | Man |
| **cpu_count**:(cpu-count)            | having "cpu-count"               | Dyn |     | Man |
| cpu_count:(!cpu-count)               | NOT having "cpu-count"           | Dyn |     | Man |
| **mem**:(ram-in-MB)                  | having "ram-in-MB"               | Dyn |     | Man |
| mem:(!ram-in-MB)                     | NOT having "ram-in-MB"           | Dyn |     | Man |
| **mac_address**:(=MAC)               | having MAC address "MAC"         | Dyn |     | Man |
| mac_address:(!=MAC)                  | NOT having                       | Dyn |     | Man |
| **agent_name**:(=agent-name)         | Include nodes with agent-name    | Dyn |     | Man |
| agent_name:(!=agent-name)            | Exclude nodes with agent-name    | Dyn |     | Man |
| **cpu_speed**:(cpu-speed-GHz)        | CPU speed                        | Dyn |     | Man |
| cpu_speed:(!cpu-speed-GHz)           | CPU speed                        | Dyn |     | Man |
| **osystem**:(=os-name)               | The OS of the desired node       | Dyn |     | Man |
| osystem:(!=os-name)                  | OS to ignore                     | Dyn |     | Man |
| **distro_series**:(=distro-name)     | Include nodes using distro       | Dyn |     | Man |
| distro_series:(!=distro-name)        | Exclude ndoes using distro       | Dyn |     | Man |
| **ip_addresses**:(=ip-address)       | Node's IP address                | Dyn |     | Man |
| ip_addresses:(!=ip-address)          | IP address to ignore             | Dyn |     | Man |
| **spaces**:(=space-name)             | Node's spaces                    | Dyn |     |     |
| spaces:(!=space-name)                | Node's spaces                    | Dyn |     |     |
| **workloads**:(=annotation-text)     | Node's workload annotations      | Dyn |     |     |
| workloads:(!=annotation-text)        | Node's workload annotations      | Dyn |     |     |
| **physical_disk_count**:(disk-count) | Physical disk Count              | Dyn |     | Man |
| physical_disk_count:(!disk-count)    | Physical disk Count              | Dyn |     | Man |
| **pxe_mac**:(=PXE-MAC)               | Boot interface MAC address       | Dyn |     | Man |
| pxe_mac:(!=PXE-MAC)                  | Boot interface MAC address       | Dyn |     | Man |
| **fqdn**:(=fqdn-value)               | Node FQDN                        | Dyn |     | Man |
| fqdn:(!=fqdn-value)                  | Node FQDN                        | Dyn |     | Man |
| **simple_status**:(=status-val)      | Include nodes with simple-status | Dyn |     | Man |
| simple_status:(!=status-val)         | Exclude nodes with simple-status | Dyn |     | Man |
| **devices**:(=)                      | Devices                          | Dyn |     | Man |
| **interfaces**:(=)                   | Interfaces                       | Dyn |     | Man |
| **parent**:(=)                       | Parent node                      | Dyn | Grp | Man |

