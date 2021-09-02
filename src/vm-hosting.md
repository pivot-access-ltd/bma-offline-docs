MAAS VM hosts allow for the dynamic composition of nodes from a pool of available hardware resources (e.g. disk space, memory, cores). You can create virtual machines (VMs) as needed within the limits of your resources, without concern for physical hardware.

This article will help you learn:

- [About VM hosts](#heading--about-vm-hosts)
- [About VM host storage pools](#heading--about-vm-host-storage-pools)
rad-begin /deb/2.9/cli /deb/2.9/ui /snap/2.9/cli /snap/2.9/ui
- [About LXD vs. libvirt](#heading--about-lxd-vs-libvirt)
rad-end
- [About VMs and NUMA](#heading--about-vms-and-numa)
- [About support for NUMA, SR-IOV, and hugepages](#heading--about-support-for-numa-et-al)

rad-begin /snap/2.9/cli /snap/2.9/ui /deb/2.9/cli /deb/2.9/ui
MAAS currently supports VM hosts and VMs created via [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt). MAAS also supports LXD VMs and VM hosts as a Beta feature.
rad-end
rad-begin /snap/3.0/ui /snap/3.0/cli /deb/3.0/cli /deb/3.0/ui
MAAS currently supports VM hosts and VMs created with LXD VMs and VM hosts as the preferred VM hosting method. As a legacy offering, MAAS still supports VM hosts and VMs created via [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt).
rad-end

<a href="#heading--about-vm-hosts"><h2 id="heading--about-vm-hosts">About VM hosts</h2></a>

VM hosts are particularly useful for Juju integration, allowing for dynamic allocation of VMs with custom interface constraints. Alternatively, if you would like to use MAAS to manage a collection of VMs, the robust web UI allows you to easily create and manage VMs, logically grouped by VM host. Six conspicuous features include:

-   Juju integration
-   At-a-glance visual tools for easy resource management
-   Set overcommit ratios for physical resources such as CPU and RAM
-   Assign VMs to resource pools to segregate your VMs into logical groupings
-   Track VM host storage pool usage and assign default storage pools
-   Create VMs on multiple networks, specified by space, subnet, VLAN, or IP address

Simply put, a VM host is a machine which is designated to run virtual machines (VMs). A VM host divides its resources (CPU cores, RAM, storage) among the number of VMs you want to create, based on choices that you make when creating each VM. It is also possible to overcommit resources – that is, use more resources than the VM host actually has available – as long as you use the VMs carefully. Once MAAS has enlisted, commissioned, and acquired a newly-added machine, you can deploy it as a VM host.


<a href="#heading--about-vm-host-storage-pools"><h2 id="heading--about-vm-host-storage-pools">About VM host storage pools</h2></a>

"Storage pools” are storage resources managed by a VM host. A storage pool is a given amount of storage set aside for use by VMs. A pool can be organised into storage volumes, assigned to VMs as individual block devices.

[note]
For LXD VM hosts, each VM can be assigned a single block device from the storage pool.
[/note]

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
The MAAS web UI displays information about each VM host's storage pools so you can understand your resource usage at a glance:

<a href="https://discourse.maas.io/uploads/default/original/1X/3387f256f9bd02f7fc2079f119377305256973c8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/3387f256f9bd02f7fc2079f119377305256973c8.jpeg"></a>
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
Retrieve VM host storage pool information with the following command:

```
maas $PROFILE vm-host read $VM_HOST_ID
```

or, to get tabular output, try:

```
maas admin vm-host read 5 \
| jq -r '(["NAME","TYPE","PATH","TOTAL","USED","AVAIL"]) 
| (,. map(length*"-"))), (.storage_pools[] 
| [.name, .type, .path, .total, used, .available]) | @tsv' \
| column -t
```

rad-end

rad-begin /deb/2.9/cli /deb/2.9/ui /snap/2.9/cli /snap/2.9/ui

<a href="#heading--about-lxd-vs-libvirt"><h2 id="heading--about-lxd-vs-libvirt">About LXD (Beta) vs. libvirt</h2></a>

Libvirt KVMs and LXD VMs are both based on the same underlying virtualisation technology, QEMU. Unlike libvirt KVMs, though, LXD VMs can be managed without requiring SSH access to the VM host. LXD are remotely accessed via secure HTTP transport, which provides better security for LXD-based VMs. In addition, LXD has a better API, and is part of a much larger constellation of enterprise software, offering a wider range of future features and use cases.
rad-end

<a href="#heading--about-vms-and-numa"><h2 id="heading--about-vms-and-numa">About VMs and NUMA</h2></a>

MAAS provides extensive optimisation tools for using NUMA with virtual machines. Earlier versions of MAAS guarantee that machines are assigned to a single NUMA node that contains all the machine's resources. As of 2.9, MAAS now allows you to see how many VMs are allocated to each NUMA node, along with the allocations of cores, storage, and memory. You can quickly spot a VM running in multiple NUMA nodes, and optimise accordingly, with instant updates on pinning and allocations. You can also tell which VMs are currently running.
In addition, you can get a bird's-eye view of network configuration:

1.  You can see which VM NIC/bond is connected to which NUMA node.
2.  You can tell when a NIC is connected to a different NUMA node.
3.  You can tell if one of multiple NICs is not in the correct node.
4.  You can confirm the subnet and space connecting to a VM.
5.  You can confirm that a VM has the desired network properties, such as latency and throughput.
6.  You can identify NICs that support SR-IOV and tell how many VFs are available.

MAAS also shows hugepages information (if they are in use) and prevents overcommit when using them. Hugepages essentially allow a much larger memory cache associated with the core. This obviously reduces the number of times a core has to access memory, but because the core must swap entire hugepages, optimising usage of them can be complex. MAAS helps you create these optimisations by giving you a discrete view of hugepages associated with your VM, helping you decide whether you need to use them or not.

<a href="#heading--about-support-for-numa-et-al"><h2 id="heading--about-support-for-numa-et-al">About support for NUMA, SR-IOV, and hugepages</h2></a>

rad-begin /snap/2.9/cli /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli
VM host management has been redesigned to support NUMA/SR-IOV configurations and hugepages from the API/CLI. Users can:

1.  See resources per NUMA node.
2.  See resources for VM hosts bearing NUMA nodes.
3.  See the alignment between VM host interfaces and NUMA nodes.
4.  Configure and use hugepages.

rad-end
rad-begin /snap/2.9/ui /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui
VM host management has been redesigned to support NUMA/SR-IOV configurations and hugepages from the API/CLI. Users can:

1.  See resources per NUMA node.
2.  See resources for VM hosts bearing NUMA nodes.
3.  See the alignment between VM host interfaces and NUMA nodes.

Via the CLI, users can see more details about NUMA-bearing VM host resources and configure hugepages. Select the relevant "CLI" link in the top menu to access this information.
rad-end
