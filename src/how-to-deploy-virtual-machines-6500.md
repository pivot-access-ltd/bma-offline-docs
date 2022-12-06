<!-- "How to deploy virtual machines" -->
Virtual machines bring tremendous advantages to MAAS.  We use [LXD](https://linuxcontainers.org/lxd/introduction/) as our primary VM host, so everything about MAAS VMs is optimised for LXD VMs.  For reference, VM hosts are called "KVMs" in the MAAS Web UI.

If KVMs and LXD VMs are not new to you, feel free to go ahead and [set up LXD](/t/how-to-set-up-lxd/5208), create one or more [VM hosts](/t/how-to-create-vm-hosts/5140), and start [deploying virtual machines](/t/how-to-create-and-manage-vms/5148) to cover your workload.  The rest of this article provides a little theory about MAAS VM hosts, just in case you need to catch up.

<a href="#heading--MAAS-VM-hosting"><h2 id="heading--MAAS-VM-hosting">MAAS VM hosting</h2></a>

MAAS VM hosts allow for the dynamic composition of nodes from a pool of available hardware resources (e.g. disk space, memory, cores). You can create virtual machines (VMs) as needed within the limits of your resources, without concern for physical hardware.

This theory section will help you learn:

[tabs]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages" view="UI"]
- [About VM hosts](#heading--about-vm-hosts)
- [About VM host storage pools](#heading--about-vm-host-storage-pools)
- [About LXD VM hosts](#heading--about-lxd-vm-hosts)
- [About LXD VM host project summaries](#heading--vm-host-project-summary)
- [About LXD VM host resource details](#heading--vm-host-resource-details)
- [About VM host settings](#heading--configuration)
- [About VMs and NUMA](#heading--about-vms-and-numa)
- [About support for NUMA, SR-IOV, and hugepages](#heading--about-support-for-numa-et-al)
- [About over-committed resources](#heading--overcommit-resources)
[/tab]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages" view="CLI"]
- [About VM hosts](#heading--about-vm-hosts)
- [About VM host storage pools](#heading--about-vm-host-storage-pools)
- [About VMs and NUMA](#heading--about-vms-and-numa)
- [About support for NUMA, SR-IOV, and hugepages](#heading--about-support-for-numa-et-al)
- [About over-committed resources](#heading--overcommit-resources)
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
- [About VM hosts](#heading--about-vm-hosts)
- [About VM host storage pools](#heading--about-vm-host-storage-pools)
- [About LXD vs. libvirt](#heading--about-lxd-vs-libvirt)
- [About VMs and NUMA](#heading--about-vms-and-numa)
- [About support for NUMA, SR-IOV, and hugepages](#heading--about-support-for-numa-et-al)
- [About over-committed resources](#heading--overcommit-resources)
[/tab]
[/tabs]

[tabs]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
MAAS currently supports VM hosts and VMs created with LXD VMs and VM hosts as the preferred VM hosting method. As a legacy offering, MAAS still supports VM hosts and VMs created via [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt).
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
MAAS currently supports VM hosts and VMs created via [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt). MAAS also supports LXD VMs and VM hosts as a Beta feature.
[/tab]
[/tabs]

<a href="#heading--about-vm-hosts"><h3 id="heading--about-vm-hosts">About VM hosts</h3></a>

A VM host is simply a machine which can run virtual machines (VMs) by allocating  resources across the VMs you want to create.  If needed, you can over-commit resources, allocating more resources than actually available, so long as you don't try to use more than the VM host has available at any one time. Once MAAS has enlisted, commissioned, and allocated a newly-added machine, you can deploy it as a VM host.  Alternatively, you can create a VM host from a machine you've already got running.

VM hosts are particularly useful for Juju integration, allowing for dynamic allocation of VMs with custom interface constraints. Alternatively, if you would like to use MAAS to manage a collection of VMs, the robust web UI allows you to easily create and manage VMs, logically grouped by VM host. Six conspicuous features include:

- Juju integration
- At-a-glance visual tools for easy resource management
- Set overcommit ratios for physical resources such as CPU and RAM
- Assign VMs to resource pools to segregate your VMs into logical groupings
- Track VM host storage pool usage and assign default storage pools
- Create VMs on multiple networks, specified by space, subnet, VLAN, or IP address

Simply put, a VM host is a machine which is designated to run virtual machines (VMs). A VM host divides its resources (CPU cores, RAM, storage) among the number of VMs you want to create, based on choices that you make when creating each VM. It is also possible to overcommit resources – that is, use more resources than the VM host actually has available – as long as you use the VMs carefully. Once MAAS has enlisted, commissioned, and allocated a newly-added machine, you can deploy it as a VM host.


<a href="#heading--about-vm-host-storage-pools"><h3 id="heading--about-vm-host-storage-pools">About VM host storage pools</h3></a>

"Storage pools” are storage resources managed by a VM host. A storage pool is a given amount of storage set aside for use by VMs. A pool can be organised into storage volumes, assigned to VMs as individual block devices.

[note]
For LXD VM hosts, each VM can be assigned a single block device from the storage pool.
[/note]

[tabs]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
The MAAS web UI displays information about each VM host's storage pools so you can understand your resource usage at a glance:

<a href="https://discourse.maas.io/uploads/default/original/1X/3387f256f9bd02f7fc2079f119377305256973c8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/3387f256f9bd02f7fc2079f119377305256973c8.jpeg"></a>
[/tab]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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

[/tab]
[/tabs]

<a href="#heading--about-lxd-vm-hosts"><h3 id="heading--about-lxd-vm-hosts">About LXD VM hosts</h3></a>

[tabs]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages" view="UI"]
<a href="#heading--about-lxd-vm-host-auth"><h4 id="heading--about-lxd-vm-host-auth">About LXD VM host authentication</h4></a>

MAAS 3.1 provides a smoother experience when connecting an existing LXD server to MAAS, guiding the user through manual steps and providing increased connection security with use of certificates. Currently, each MAAS region/rack controller has its own certificate. To add a LXD VM host to MAAS, the user needs to either add the certificate for each controller that can reach the LXD server to the trust list in LXD, or use the trust_password (in which case the controller talking to LXD will automatically add its certificate to the trust).

This doesn’t provide a great user experience, as the former process is cumbersome, and the latter is not suggested for production use for security reasons.  To improve this, MAAS 3.1 manages per-LXD keys/certificates, and provide a way for users to get the content of certificates, to authorise MAAS in LXD.

#### About on-the-spot certificate creation

As a MAAS user, you want to register a LXD host into MAAS using certificates for authentication -- to follow LXD production deployment best practices.  The standard way for clients to authenticate with LXD servers is through certificates. The use of trust_password is *only* meant as a way to interact for initial setup.

While prior versions of MAAS support both ways of authentication (and automatically adds the certificate for the rack talking to LXD when registering the VM host), the user experience is lacking, since there's no control over the certificate being used.  In addition, each rack uses a different certificate, making it hard to manage scenarios where multiple racks can connect to a LXD server.

For these reasons, when adding a LXD host, MAAS 3.1 provides a way to generate a secret key and certificate pair to use specifically for that server, and show the certificate to the user, so that they can add it to the LXD server trust list.  The user experience changes to something like the following:

- MAAS generates a secret key and certificate pair for use with a LXD server.
- The user can see the certificate and is guided to add it to the LXD server trust list.
- The user can easily complete the registration of the LXD server once the certificate is trusted in LXD.
- All racks use the same key when talking to the LXD server. 
- If a new rack controller is added, it can communicate with the LXD server out of the box.
- If the trust password is used, it’s not stored in MAAS persistently.
- It’s possible to get the certificate for a LXD server from a URL (e.g. for curl use).

#### About bringing your own certificates

As a MAAS user, you may want to register a LXD host into MAAS by providing a private key for a certificate that’s already trusted by the LXD server.  For example, you may already have set up certificates in the server trust for MAAS to use, MAAS should provide a way to import it, instead of generating a new one.

With MAAS 3.1, it’s possible to import an existing key/certificate pair for use with a LXD server when registering it with MAAS.  MAAS stores the key/certificate instead of generating new ones.

[note]
The imported key must not have a passphrase; otherwise, MAAS will not be able to use it.
[/note]

<a href="#heading--vm-host-project-summary"><h3 id="heading--vm-host-project-summary">About LXD VM host project summaries</h3></a>

Each LXD VM host provides a "Project" tab that summarises the current state of the LXD KVM:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e0cc264a17d67f9530ff8c2ef2bb9522fed0749a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e0cc264a17d67f9530ff8c2ef2bb9522fed0749a.png"></a>

This tab identifies the project, shows its current resource state, and provides the ability to select existing VM hosts and perform specific actions on them -- as well as being able to compose new VMs on the spot.

<a href="#heading--vm-host-resource-details"><h3 id="heading--vm-host-resource-details">About LXD VM host resource details</h3></a>

This tab presents a summary of the LXD VM host's resource usage:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d67cf384d6fe903274893eb50a098518d2c1295d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d67cf384d6fe903274893eb50a098518d2c1295d.png"></a>

The only interactive option on this tab allows you to map or unmap resource usage to NUMA nodes.

<a href="#heading--configuration"><h3 id="heading--configuration">About VM host settings</h3></a>

VM hosts have several settings. Modify these by selecting the 'Settings' tab and editing items directly. Options include a VM host's address, password, network zone, resource pool, and memory and CPU overcommit sliders.

<a href="https://discourse.maas.io/uploads/default/original/2X/2/253afc122d61145be656bb5c3811f9b6c6caa708.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/253afc122d61145be656bb5c3811f9b6c6caa708.png"></a>
[/tab]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages" view="CLI"]
Please use the UI interface to interact with LXD VM hosts, by selecting "UI" from the dropdown above.
[/tab]
[tab version="v2.9 Snap,v2.9 Packages view="UI,CLI"]
LXD VM hosts are not available in MAAS version 2.9.  Please upgrade to MAAS version 3.0 or greater to access this functionality.

<a href="#heading--about-lxd-vs-libvirt"><h3 id="heading--about-lxd-vs-libvirt">About LXD (Beta) vs. libvirt</h3></a>

Libvirt KVMs and LXD VMs are both based on the same underlying virtualisation technology, QEMU. Unlike libvirt KVMs, though, LXD VMs can be managed without requiring SSH access to the VM host. LXD are remotely accessed via secure HTTP transport, which provides better security for LXD-based VMs. In addition, LXD has a better API, and is part of a much larger constellation of enterprise software, offering a wider range of future features and use cases.
[/tab]
[/tabs]

<a href="#heading--about-vms-and-numa"><h3 id="heading--about-vms-and-numa">About VMs and NUMA</h3></a>

MAAS provides extensive optimisation tools for using NUMA with virtual machines. Earlier versions of MAAS guarantee that machines are assigned to a single NUMA node that contains all the machine's resources. As of 2.9, MAAS now allows you to see how many VMs are allocated to each NUMA node, along with the allocations of cores, storage, and memory. You can quickly spot a VM running in multiple NUMA nodes, and optimise accordingly, with instant updates on pinning and allocations. You can also tell which VMs are currently running.

In addition, you can get a bird's-eye view of network configuration:

- You can see which VM NIC/bond is connected to which NUMA node.
- You can tell when a NIC is connected to a different NUMA node.
- You can tell if one of multiple NICs is not in the correct node.
- You can confirm the subnet and space connecting to a VM.
- You can confirm that a VM has the desired network properties, such as latency and throughput.
- You can identify NICs that support SR-IOV and tell how many VFs are available.

MAAS also shows hugepages information (if they are in use) and prevents overcommit when using them. Hugepages essentially allow a much larger memory cache associated with the core. This obviously reduces the number of times a core has to access memory, but because the core must swap entire hugepages, optimising usage of them can be complex. MAAS helps you create these optimisations by giving you a discrete view of hugepages associated with your VM, helping you decide whether you need to use them or not.

<a href="#heading--about-support-for-numa-et-al"><h3 id="heading--about-support-for-numa-et-al">About support for NUMA, SR-IOV, and hugepages</h3></a>

[tabs]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
VM host management has been redesigned to support NUMA/SR-IOV configurations and hugepages from the API/CLI. Users can:

- See resources per NUMA node.
- See resources for VM hosts bearing NUMA nodes.
- See the alignment between VM host interfaces and NUMA nodes.

Via the CLI, users can see more details about NUMA-bearing VM host resources and configure hugepages. Select the relevant "CLI" link in the top menu to access this information.
[/tab]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
VM host management has been redesigned to support NUMA/SR-IOV configurations and hugepages from the API/CLI. Users can:

- See resources per NUMA node.
- See resources for VM hosts bearing NUMA nodes.
- See the alignment between VM host interfaces and NUMA nodes.
- Configure and use hugepages.

[/tab]
[/tabs]

<a href="#heading--overcommit-resources"><h4 id="heading--overcommit-resources">About over-committed resources</h4></a>

Over-committed resources are those allocated beyond what's available in the physical resource. Using sliders on the configuration page, you can limit whether MAAS will attempt to overcommit CPU and memory. The input fields to the right of the sliders accept floating-point values from 0 to 10, with a default value of 1.

The following shows four theoretical examples of these ratios and how they affect physical resource allocation:

1.  `8 physical CPU cores  * 1 multiplier     = 8 virtual CPU cores`
2.  `8 physical CPU cores  * 0.5 multiplier   = 4 virtual CPU cores`
3.  `32 physical CPU cores * 10.0 multiplier  = 320 virtual CPU cores`
4.  `128GB physical memory  * 5.5 multiplier  = 704G virtual Memory`

[tabs]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="https://discourse.maas.io/uploads/default/original/1X/27a8f21392af3d29a500e33f99e1f79c578cf29c.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/27a8f21392af3d29a500e33f99e1f79c578cf29c.jpeg"></a> 
[/tab]
[tab version="v3.2 Snap,v3.3 Snap,v3.2 Packages,v3.3 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
Please use the MAAS UI to view overcommit ratios for NUMA resources.
[/tab]
[/tabs]

Over-committing resources allows a user to compose many MAAS-managed machines without worrying about the physical limitations of the host. For example, on a physical host with four cores and 12 GB of memory, you could compose four libvirt machines, each using two cores and 4 GB of memory.  This arrangement over commits the available physical resources. Provided you never run all four VMs simultaneously, you would have all the benefits of MAAS-managed VMs without over-taxing your host.


