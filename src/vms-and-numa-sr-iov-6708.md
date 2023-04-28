<!-- "VMs and NUMA/SR-IOV" -->

MAAS provides extensive optimisation tools for using NUMA with virtual machines. Earlier versions of MAAS guarantee that machines are assigned to a single NUMA node that contains all the machine's resources. As of 2.9, MAAS now allows you to see how many VMs are allocated to each NUMA node, along with the allocations of cores, storage, and memory. You can quickly spot a VM running in multiple NUMA nodes, and optimise accordingly, with instant updates on pinning and allocations. You can also tell which VMs are currently running.

In addition, you can get a bird's-eye view of network configuration:

- You can see which VM NIC/bond is connected to which NUMA node.
- You can tell when a NIC is connected to a different NUMA node.
- You can tell if one of multiple NICs is not in the correct node.
- You can confirm the subnet and space connecting to a VM.
- You can confirm that a VM has the desired network properties, such as latency and throughput.
- You can identify NICs that support SR-IOV and tell how many VFs are available.

MAAS also shows hugepages information (if they are in use) and prevents overcommit when using them. Hugepages essentially allow a much larger memory cache associated with the core. This obviously reduces the number of times a core has to access memory, but because the core must swap entire hugepages, optimising usage of them can be complex. MAAS helps you create these optimisations by giving you a discrete view of hugepages associated with your VM, helping you decide whether you need to use them or not.

<a href="#heading--about-support-for-numa-et-al"><h2 id="heading--about-support-for-numa-et-al">About support for NUMA, SR-IOV, and hugepages</h2></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
VM host management has been redesigned to support NUMA/SR-IOV configurations and hugepages from the API/CLI. Users can:

- See resources per NUMA node.
- See resources for VM hosts bearing NUMA nodes.
- See the alignment between VM host interfaces and NUMA nodes.

Via the CLI, users can see more details about NUMA-bearing VM host resources and configure hugepages. Select the relevant "CLI" link in the top menu to access this information.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
VM host management has been redesigned to support NUMA/SR-IOV configurations and hugepages from the API/CLI. Users can:

- See resources per NUMA node.
- See resources for VM hosts bearing NUMA nodes.
- See the alignment between VM host interfaces and NUMA nodes.
- Configure and use hugepages.

[/tab]
[/tabs]

<a href="#heading--overcommit-resources"><h2 id="heading--overcommit-resources">About over-committed resources</h2></a>

Over-committed resources are those allocated beyond what's available in the physical resource. Using sliders on the configuration page, you can limit whether MAAS will attempt to overcommit CPU and memory. The input fields to the right of the sliders accept floating-point values from 0 to 10, with a default value of 1.

The following shows four theoretical examples of these ratios and how they affect physical resource allocation:

1.  `8 physical CPU cores  * 1 multiplier     = 8 virtual CPU cores`
2.  `8 physical CPU cores  * 0.5 multiplier   = 4 virtual CPU cores`
3.  `32 physical CPU cores * 10.0 multiplier  = 320 virtual CPU cores`
4.  `128GB physical memory  * 5.5 multiplier  = 704G virtual Memory`

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="https://discourse.maas.io/uploads/default/original/1X/27a8f21392af3d29a500e33f99e1f79c578cf29c.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/27a8f21392af3d29a500e33f99e1f79c578cf29c.jpeg"></a> 
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
Please use the MAAS UI to view overcommit ratios for NUMA resources.
[/tab]
[/tabs]

Over-committing resources allows a user to compose many MAAS-managed machines without worrying about the physical limitations of the host. For example, on a physical host with four cores and 12 GB of memory, you could compose four libvirt machines, each using two cores and 4 GB of memory.  This arrangement over commits the available physical resources. Provided you never run all four VMs simultaneously, you would have all the benefits of MAAS-managed VMs without over-taxing your host.

