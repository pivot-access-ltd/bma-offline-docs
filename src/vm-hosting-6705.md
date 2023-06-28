<!-- Vm hosting -->

A VM host is simply a machine which can run virtual machines (VMs) by allocating  resources across the VMs you want to create.  If needed, you can over-commit resources, allocating more resources than actually available, so long as you don't try to use more than the VM host has available at any one time. Once MAAS has enlisted, commissioned, and allocated a newly-added machine, you can deploy it as a VM host.  Alternatively, you can create a VM host from a machine you've already got running.

VM hosts are particularly useful for Juju integration, allowing for dynamic allocation of VMs with custom interface constraints. Alternatively, if you would like to use MAAS to manage a collection of VMs, the robust web UI allows you to easily create and manage VMs, logically grouped by VM host. Six conspicuous features include:

- Juju integration
- At-a-glance visual tools for easy resource management
- Set overcommit ratios for physical resources such as CPU and RAM
- Assign VMs to resource pools to segregate your VMs into logical groupings
- Track VM host storage pool usage and assign default storage pools
- Create VMs on multiple networks, specified by space, subnet, VLAN, or IP address

Simply put, a VM host is a machine which is designated to run virtual machines (VMs). A VM host divides its resources (CPU cores, RAM, storage) among the number of VMs you want to create, based on choices that you make when creating each VM. It is also possible to overcommit resources – that is, use more resources than the VM host actually has available – as long as you use the VMs carefully. Once MAAS has enlisted, commissioned, and allocated a newly-added machine, you can deploy it as a VM host.


<a href="#heading--about-vm-host-storage-pools"><h2 id="heading--about-vm-host-storage-pools">About VM host storage pools</h2></a>

"Storage pools” are storage resources managed by a VM host. A storage pool is a given amount of storage set aside for use by VMs. A pool can be organised into storage volumes, assigned to VMs as individual block devices.

[note]
For LXD VM hosts, each VM can be assigned a single block device from the storage pool.
[/note]

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
The MAAS web UI displays information about each VM host's storage pools so you can understand your resource usage at a glance:

<a href="https://discourse.maas.io/uploads/default/original/1X/3387f256f9bd02f7fc2079f119377305256973c8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/3387f256f9bd02f7fc2079f119377305256973c8.jpeg"></a>
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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