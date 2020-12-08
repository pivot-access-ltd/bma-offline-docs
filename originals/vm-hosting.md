<!-- deb-2-7-cli
 deb-2-7-cli -->

<!-- deb-2-7-ui
 deb-2-7-ui -->

<!-- deb-2-8-cli
 deb-2-8-cli -->

<!-- deb-2-8-ui
 deb-2-8-ui -->

<!-- deb-2-9-cli
 deb-2-9-cli -->

<!-- deb-2-9-ui
 deb-2-9-ui -->

<!-- snap-2-7-cli
 snap-2-7-cli -->

<!-- snap-2-7-ui
 snap-2-7-ui -->

<!-- snap-2-8-cli
 snap-2-8-cli -->

<!-- snap-2-8-ui
 snap-2-8-ui -->

<!-- snap-2-9-cli
 snap-2-9-cli -->

<!-- snap-2-9-ui
 snap-2-9-ui -->

MAAS VM hosts allow for the dynamic composition of nodes from a pool of available hardware resources (e.g. disk space, memory, cores).  You can create virtual machines (VMs) as needed within the limits of your resources, without concern for physical hardware.  MAAS currently supports VM hosts and VMs created via [libvirt^](https://ubuntu.com/server/docs/virtualization-libvirt).  As part of MAAS 2.8, we also support LXD VMs and VM hosts as a Beta feature.

VM hosts are particularly useful for Juju integration, allowing for dynamic allocation of VMs with custom interface constraints. Alternatively, if you would like to use MAAS to manage a collection of VMs, the robust web UI allows you to easily create and manage VMs, logically grouped by VM host.  Six conspicuous features include:

1.   Juju integration
2.   At-a-glance visual tools for easy resource management
3.   Set overcommit ratios for physical resources such as CPU and RAM
4.   Assign VMs to resource pools to segregate your VMs into logical groupings
5.   Track VM host storage pool usage and assign default storage pools
6.   Create VMs on multiple networks, specified by space, subnet, VLAN, or IP address

This section will lead you through the creation, usage, and management of VM hosts.  Note that, as LXD VM hosts are still in Beta, some screen terminology has not yet been changed to reflect "VM host" instead of "KVM."  You will still use the "KVM" tab on the top of the MAAS dashboard to reach the VM host functionality, and you may see buttons which refer to "Add KVM," for example, instead of "Add VM host."  Rest assured that the Beta LXD VM host functionality is fully available through these channels.

<!-- deb-2-7-cli
#### Four questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3216#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2292)
 deb-2-7-cli -->

<!-- deb-2-7-ui
#### Four questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3217#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2293)
 deb-2-7-ui -->

<!-- deb-2-8-cli
#### Four questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3218#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2294)
 deb-2-8-cli -->

<!-- deb-2-8-ui
#### Four questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3219#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2295)
 deb-2-8-ui -->

<!-- deb-2-9-cli
#### Nine questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3220#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2296)
5. [How do I see resources for a specific NUMA node?](#heading--numa-node-resources)
6. [How do I pin NUMA nodes to specific cores?](#heading--pin-numa-nodes)
7. [How do I see resources for NUMA-node-bearing VM hosts?](#heading--numa-vm-host-resources)
8. [How do I see the alignment between VM host interfaces and NUMA nodes?](#heading--numa-alignment)
9. [How do I configure and use hugepages on my VMs?](#heading--configure-hugepages)
 deb-2-9-cli -->

<!-- deb-2-9-ui
#### Seven questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3221#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2297)
5. [How do I see resources for a specific NUMA node?](#heading--numa-node-resources)
6. [How do I see resources for NUMA-node-bearing VM hosts?](#heading--numa-vm-host-resources)
7. [How do I see the alignment between VM host interfaces and NUMA nodes?](#heading--numa-alignment)
 deb-2-9-ui -->

<!-- snap-2-7-cli
#### Four questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3210#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2286)
 snap-2-7-cli -->

<!-- snap-2-7-ui
#### Four questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3211#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2287)
 snap-2-7-ui -->

<!-- snap-2-8-cli
#### Four questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3212#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2288)
 snap-2-8-cli -->

<!-- snap-2-8-ui
#### Four questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3213#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2289)
 snap-2-8-ui -->

<!-- snap-2-9-cli
#### Nine questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3220#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2296)
5. [How do I see resources for a specific NUMA node?](#heading--numa-node-resources)
6. [How do I pin NUMA nodes to specific cores?](#heading--pin-numa-nodes)
7. [How do I see resources for NUMA-node-bearing VM hosts?](#heading--numa-vm-host-resources)
8. [How do I see the alignment between VM host interfaces and NUMA nodes?](#heading--numa-alignment)
9. [How do I configure and use hugepages on my VMs?](#heading--configure-hugepages)
 snap-2-9-cli -->

<!-- snap-2-9-ui
#### Seven questions you may have:

1. [What is a VM host?](#heading--what-is-a-vm-host)
2. [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
3. [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3221#heading--set-up-ssh)
4. [How do I add a VM host?](/t/adding-a-vm-host/2297)
5. [How do I see resources for a specific NUMA node?](#heading--numa-node-resources)
6. [How do I see the alignment between VM host interfaces and NUMA nodes?](#heading--numa-alignment)
 snap-2-9-ui -->

<a href="#heading--what-is-a-vm-host"><h2 id="heading--what-is-a-vm-host">What is a VM host?</h2></a>

Simply put, a VM host is a machine which is designated to run virtual machines (VMs).  A VM host divides its resources (CPU cores, RAM, storage) among the number of VMs you want to create, based on choices that you make when creating each VM.  It is also possible to overcommit resources -- that is, use more resources than the VM host actually has available -- as long as you use the VMs carefully. Once MAAS has enlisted, commissioned, and acquired a newly-added machine, you can deploy it as a VM host.

<a href="#heading--choosing-vm-host-type"><h2 id="heading--choosing-vm-host-type">LXD VM host  (Beta) vs. libvirt</h2></a>

Libvirt KVMs and LXD VMs are both based on the same underlying virtualisation technology, QEMU.  Unlike libvirt KVMs, though, LXD VMs can be managed without requiring SSH access to the VM host. LXD are remotely accessed via secure HTTP transport, which provides better security for LXD-based VMs.  In addition, LXD has a better API, and is part of a much larger constellation of enterprise software, offering a wider range of future features and use cases.

<!-- snap-2-9-ui snap-2-9-cli deb-2-9-ui deb-2-9-cli

<a href="#heading--vnuma"><h2 id="heading--vnuma">VMs and NUMA</h2></a>

MAAS provides extensive optimisation tools for using NUMA with virtual machines. Earlier versions of MAAS guarantee that machines are assigned to a single NUMA node that contains all the machine's resources.  As of 2.9, MAAS now allows you to see how many VMs are allocated to each NUMA node, along with the allocations of cores, storage, and memory.  You can quickly spot a VM running in multiple NUMA nodes, and optimise accordingly, with instant updates on pinning and allocations.  You can also tell which VMs are currently running.

In addition, you can get a bird's-eye view of network configuration:

1. You can see which VM NIC/bond is connected to which NUMA node.
2. You can tell when a NIC is connected to a different NUMA node.
3. You can tell if one of multiple NICs is not in the correct node.
4. You can confirm the subnet and space connecting to a VM.
5. You can confirm that a VM has the desired network properties, such as latency and throughput.
6. You can identify NICs that support SR-IOV and tell how many VFs are available.

MAAS also shows hugepages information (if they are in use) and prevents overcommit when using them.  Hugepages essentially allow a much larger memory cache associated with the core.  This obviously reduces the number of times a core has to access memory, but because the core must swap entire hugepages, optimising usage of them can be complex. MAAS helps you create these optimisations by giving you a discrete view of hugepages associated with your VM, helping you decide whether you need to use them or not.
snap-2-9-ui snap-2-9-cli deb-2-9-ui deb-2-9-cli -->

<!-- snap-2-9-cli deb-2-9-cli
<a href="#heading--numa-nodes"><h2 id="heading--numa-nodes">Support for NUMA, SR-IOV, and hugepages</h2></a>

VM host management has been redesigned to support NUMA/SR-IOV configurations and hugepages from the API/CLI.  Users can:

1. See resources per NUMA node.
2. Pin nodes to specific cores.
3. See resources for VM hosts bearing NUMA nodes.
4. See the alignment between VM host interfaces and NUMA nodes.
5. Configure and use hugepages.

This section explains how to access this new functionality.
 snap-2-9-cli deb-2-9-cli -->

<!-- snap-2-9-ui deb-2-9-ui
<a href="#heading--numa-nodes"><h3 id="heading--numa-nodes">Support for NUMA, SR-IOV, and hugepages</h3></a>

VM host management has been redesigned to support NUMA/SR-IOV configurations and hugepages from the API/CLI.  Users can:

1. See resources per NUMA node.
2. See resources for VM hosts bearing NUMA nodes.
3. See the alignment between VM host interfaces and NUMA nodes.

Via the CLI, users can also pin nodes to specific cores, see more details about NUMA-bearing VM host resources, and configure hugepages; select the relevant "CLI" link in the top menu to access this information.

This section explains how to access this new functionality.
 snap-2-9-ui deb-2-9-ui -->

<!-- snap-2-9-cli deb-2-9-cli
<a href="#heading--numa-node-resources"><h3 id="heading--numa-node-resources">Examine NUMA node resources</h3></a>

You can examine the resources of a NUMA node with the MAAS CLI.  A very basic way to do so is to enter the following command for a configured VM:

```
maas $PROFILE machine read $SYSTEM_ID
```

In the resulting JSON output, look for the array entry ```numanode_set```, which will show the NUMA details for that specific VM:

```
"numanode_set": [
     {
          "index": 0,
	  "memory": 16384,
	  "cores": [
	      0,
	      2,
	      1,
	      3,
	  ],
	  "hugepages_set": [
	      {
	          "page_size": 2097152,
		  "total": 0
              }
	  ]
     }
]
```

<a href="#heading--pin-numa-nodes"><h3 id="heading--pin-numa-nodes">Pin NUMA nodes to specific cores</h3></a>

With the MAAS CLI, you can pin NUMA nodes to specific cores when composing a virtual machine.  For example, you can enter a command like this for a VM host you've already created:

```
maas $PROFILE vm-host compose $VM_HOST_ID pinned_cores=1 pinned_cores=2
```

<a href="#heading--numa-vm-host-resources"><h3 id="heading--numa-vm-host-resources">Examine resources for NUMA-node-bearing VM hosts</h3></a>

With the MAAS CLI, you can get an overview of resource usage for an LXD host that's running NUMA VMs with the following command:

```
maas $PROFILE virtual-machines read
```

Currently, the API does not give you an aggregated usage, as provided in the UI; hence you'll have to look at the VMs and sum up the usage data yourself.  You can see a list of pinned cores via this method, and we do show alignment of machines and NUMA nodes.

<a href="#heading--numa-alignment"><h3 id="heading--numa-alignment">Examine the alignment between VM host interfaces and NUMA nodes</h3></a>

To see an alignment of VM host interfaces and NUMA nodes via the CLI, you can use the command mentioned above:

```
maas $PROFILE machine read $SYSTEM_ID
```

and focus on the `interface_block` section in the resulting JSON.  This will give you the alignment information you're seeking.

<a href="#heading--configure-hugepages"><h3 id="heading--configure-hugepages">Configure and use hugepages on my VMs</h3></a>

Configuring hugepages for VM use consists of two steps:

1. Creating a tag which includes a kernel option to use hugepages.
2. Composing a VM backed with hugepages, tagged with the newly-created tag.

Here are the specific commands:

```
maas $PROFILE tags create name=use-hugepages kernel_opts=default_hugepagesz=1G hugepages=20"

maas $PROFILE vm-host compose $VM_HOST_ID pinned_cores=$CORE_NUMBER hugepages_backed=true
```
 snap-2-9-cli deb-2-9-cli -->

<!-- snap-2-9-ui deb-2-9-ui
<a href="#heading--numa-node-resources"><h3 id="heading--numa-node-resources">Examine NUMA node resources</h3></a>

Within the MAAS UI, it is possible to view NUMA node resources for VM-host-composed machines:

<a href="https://discourse.maas.io/uploads/default/optimized/1X/57245bbbfe6d28e83c9b7fb30e52caf05714eb00_2_485x500.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/1X/57245bbbfe6d28e83c9b7fb30e52caf05714eb00_2_485x500.png"></a> 

To reach this view, simply select the "KVM" item at the menu along the top, select a specific VM host, and select the "View by NUMA node" switch near the top right.

<a href="#heading--numa-alignment"><h3 id="heading--numa-alignment">Examine the alignment between VM host interfaces and NUMA nodes</h3></a>

To examine the alignment between VM host interfaces and NUMA nodes -- that is, the SR-IOV configuration -- simply consult the "Virtual Functions" section of the NUMA resources diagram shown above, noting which network interfaces are mentioned.

 snap-2-9-ui deb-2-9-ui -->

