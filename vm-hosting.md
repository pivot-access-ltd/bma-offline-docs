MAAS VM hosts allow for the dynamic composition of nodes from a pool of available hardware resources (e.g. disk space, memory, cores).  You can create virtual machines (VMs) as needed within the limits of your resources, without concern for physical hardware.  MAAS currently supports VM hosts and VMs created via [libvirt^](https://ubuntu.com/server/docs/virtualization-libvirt).  As part of MAAS 2.8, we also support LXD VMs and VM hosts as a Beta feature.

VM hosts are particularly useful for Juju integration, allowing for dynamic allocation of VMs with custom interface constraints. Alternatively, if you would like to use MAAS to manage a collection of VMs, the robust web UI allows you to easily create and manage VMs, logically grouped by VM host.  Conspicuous features include:

-   Juju integration
-   At-a-glance visual tools for easy resource management
-   Set overcommit ratios for physical resources such as CPU and RAM
-   Assign VMs to resource pools to segregate your VMs into logical groupings
-   Track VM host storage pool usage and assign default storage pools
-   Create VMs on multiple networks, specified by space, subnet, VLAN, or IP address

This section will lead you through the creation, usage, and management of VM hosts.  Note that, as LXD VM hosts are still in Beta, some screen terminology has not yet been changed to reflect "VM host" instead of "KVM."  You will still use the "KVM" tab on the top of the MAAS dashboard to reach the VM host functionality, and you may see buttons which refer to "Add KVM," for example, instead of "Add VM host."  Rest assured that the Beta LXD VM host functionality is fully available through these channels.

#### Quick questions you may have:

<!-- deb-2-7-cli
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3216#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2292)
 deb-2-7-cli -->

<!-- deb-2-7-ui
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3217#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2293)
 deb-2-7-ui -->

<!-- deb-2-8-cli
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3218#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2294)
 deb-2-8-cli -->

<!-- deb-2-8-ui
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3219#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2295)
 deb-2-8-ui -->

<!-- deb-2-9-cli
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3220#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2296)
 deb-2-9-cli -->

<!-- deb-2-9-ui
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3221#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2297)
 deb-2-9-ui -->

<!-- snap-2-7-cli
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3210#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2286)
 snap-2-7-cli -->

<!-- snap-2-7-ui
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3211#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2287)
 snap-2-7-ui -->

<!-- snap-2-8-cli
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3212#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2288)
 snap-2-8-cli -->

<!-- snap-2-8-ui
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3213#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2289)
 snap-2-8-ui -->

<!-- snap-2-9-cli
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [Tell me about VMs and NUMA.](#heading--vnuma)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3214#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2290)
 snap-2-9-cli -->

<!-- snap-2-9-ui
* [What is a VM host?](#heading--what-is-a-vm-host)
* [Which VM host should I use: LXD or KVM?](#heading--choosing-vm-host-type)
* [Tell me about VMs and NUMA.](#heading--vnuma)
* [How do I set up SSH for use by libvirt?](/t/vm-host-networking/3215#heading--set-up-ssh)
* [How do I add a VM host?](/t/adding-a-vm-host/2291)
 snap-2-9-ui -->

<h2 id="heading--what-is-a-vm-host">What is a VM host?</h2>

Simply put, a VM host is a machine which is designated to run virtual machines (VMs).  A VM host divides its resources (CPU cores, RAM, storage) among the number of VMs you want to create, based on choices that you make when creating each VM.  It is also possible to overcommit resources -- that is, use more resources than the VM host actually has available -- as long as you use the VMs carefully. Once MAAS has enlisted, commissioned, and acquired a newly-added machine, you can deploy it as a VM host.

<h2 id="heading--choosing-vm-host-type">LXD VM host  (Beta) vs. libvirt</h2>

Libvirt KVMs and LXD VMs are both based on the same underlying virtualisation technology, QEMU.  Unlike libvirt KVMs, though, LXD VMs can be managed without requiring SSH access to the VM host. LXD are remotely accessed via secure HTTP transport, which provides better security for LXD-based VMs.  In addition, LXD has a better API, and is part of a much larger constellation of enterprise software, offering a wider range of future features and use cases.

<!-- snap-2-9-ui snap-2-9-cli deb-2-9-ui deb-2-9-cli

<h2 id="heading--vnuma">VMs and NUMA</h2>

MAAS provides extensive optimization tools for using NUMA with virtual machines. Earlier versions of MAAS guarantee that machines are assigned to a single NUMA node that contains all the machine's resources.  As of 2.9, MAAS now allows you to see how many VMs are allocated to each NUMA node, along with the allocations of cores, storage, and memory.  You can quickly spot a VM running in multiple NUMA nodes, and optimize accordingly, with instant updates on pinning and allocations.  You can also tell which VMs are currently running.

In addition, you can get a bird's-eye view of network configuration:

* You can see which VM NIC/bond is connected to which NUMA node.
* You can tell when a NIC is connected to a different NUMA node.
* You can tell if one of multiple NICs is not in the correct node.
* You can confirm the subnet and space connecting to a VM.
* You can confirm that a VM has the desired network properties, such as latency and throughput.
* You can identify NICs that support SR-IOV and tell how many VFs are available.

This functionality also helps you identify cores which are have `isolcpus` set and guides you to those cores when specifying VMS, indicating when a non-isolcpus core might be unsuitable for pinning. MAAS also highlights when a VM is not pinned to a specific core.  Not using `isolcpus` cores, or using unpinned VMs, can have significant performance impacts, since those cores can be interrupted by the general scheduler and co-opted to perform non-node-related tasks, without warning.

Finally, MAAS also shows hugepages information (if they are in use) and prevents overcommit when using them.  Hugepages essentially allow a much larger memory cache associated with the core.  This obviously reduces the number of times a core has to access memory, but because the core must swap entire hugepages, optimizing usage of them can be complex. MAAS helps you create these optimizations by giving you a discrete view of hugepages associated with your VM, helping you decide whether you need to use them or not.
snap-2-9-ui snap-2-9-cli deb-2-9-ui deb-2-9-cli -->
