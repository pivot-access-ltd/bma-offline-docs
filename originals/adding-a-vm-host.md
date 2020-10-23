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

A VM host is simply a machine which can run virtual machines (VMs) by allocating  resources across the VMs you want to create.  If needed, you can over-commit resources, allocating more resources than actually available, so long as you don't try to use more than the VM host has available at any one time. Once MAAS has enlisted, commissioned, and acquired a newly-added machine, you can deploy it as a VM host.  Alternatively, you can create a VM host from a machine you've already got running.

<!-- deb-2-7-cli
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3216) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3216#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3216)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3216#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4. [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 deb-2-7-cli -->

<!-- deb-2-7-ui
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3217) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3217#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3217)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3217#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4. [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 deb-2-7-ui -->

<!-- deb-2-8-cli
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3218) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3218#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3218)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3218#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4. [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 deb-2-8-cli -->

<!-- deb-2-8-ui
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3219) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3219#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3219)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3219#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4.  [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 deb-2-8-ui -->

<!-- deb-2-9-cli
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3220) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3220#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3220)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3220#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4.  [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 deb-2-9-cli -->

<!-- deb-2-9-ui
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3221) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3221#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3221)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3221#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4.  [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 deb-2-9-ui -->

<!-- snap-2-7-cli
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3210) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3210#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3210)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3210#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4.  [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 snap-2-7-cli -->

<!-- snap-2-7-ui
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3211) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3211#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3211)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3211#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4.  [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 snap-2-7-ui -->

<!-- snap-2-8-cli
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3212) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3212#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3212)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3212#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4.  [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 snap-2-8-cli -->

<!-- snap-2-8-ui
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3213) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3213#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3213)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3213#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4.  [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 snap-2-8-ui -->

<!-- snap-2-9-cli
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3214) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3214#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3214)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3214#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4.  [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 snap-2-9-cli -->

<!-- snap-2-9-ui
<strong>NOTE:</strong> 
You **must** [configure your network](/t/vm-host-networking/3215) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/3215#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 


#### Quick questions you may have:

1. [How do I configure networking for VM hosts?](/t/vm-host-networking/3215)
2. [How do I set up SSH when manually adding a VM host?](/t/vm-host-networking/3215#heading--set-up-ssh)
3. [How do I add a VM host?](#heading--adding-a-vm-host)
4.  [How do I configure a VM host after I've added it?](#heading--configuration)
5. [How do I over-commit resources on a host?](#heading--overcommit-resources)
6. [How do I add a VM host using MAAS versions below 2.5?](https://old-docs.maas.io/2.5/en/manage-kvm-add-host)
 snap-2-9-ui -->

<h2 id="heading--adding-a-vm-host">Adding a VM host</h2>

<!-- deb-2-7-ui deb-2-8-ui deb-2-9-ui snap-2-8-ui snap-2-7-ui snap-2-9-ui
After installing MAAS, the 'KVM' page is typically empty:

<a href="https://discourse.maas.io/uploads/default/original/1X/fa0cc573f34cb23ca0ac026e97ef5b618ff1fed3.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/fa0cc573f34cb23ca0ac026e97ef5b618ff1fed3.jpeg"></a> 

If you want to add a [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt) or LXD VM host to a machine which is already installed, you can do so with the 'Add KVM' button:

<a href="https://discourse.maas.io/uploads/default/original/1X/197ae57b89b32546cf054fff49452f9025354af8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/197ae57b89b32546cf054fff49452f9025354af8.jpeg"></a> 

Here, 'Virsh address' typically looks like the following for libvirt:

    qemu+ssh://<vm host IP>/system

of like this for LXD (Beta):

    https://10.0.0.100:8443
deb-2-7-ui deb-2-8-ui deb-2-9-ui snap-2-8-ui snap-2-7-ui snap-2-9-ui -->

<!-- deb-2-7-cli deb-2-8-cli deb-2-9-cli snap-2-8-cli snap-2-7-cli snap-2-9-cli
To add a VM host:

``` bash
maas $PROFILE vm-hosts create type=$VM_HOST_TYPE power_address=$POWER_ADDRESS \
    [power_user=$USERNAME] [power_pass=$PASSWORD] [zone=$ZONE] \
    [tags=$TAG1,$TAG2,...]
```

$VM_HOST_TYPE can currently take three values: `rsd`, `virsh`, and `lxd`.

$POWER_ADDRESS typically looks like the following for libvirt:

    qemu+ssh://<vm host IP>/system

of like this for LXD (Beta):

    https://10.0.0.100:8443

Both $USERNAME and $PASSWORD are optional for the virsh power type. $ZONE and $TAGS are optional for all VM hosts.

The `power_...` parameters will vary with power type.  See the [API reference](/docs/api#power-types) for a listing of available power types.

<h3>Some examples</h3>

For example, to create an RSD VM host, enter:

``` bash
maas $PROFILE vm-hosts create type=rsd power_address=10.3.0.1:8443 \
    power_user=admin power_pass=admin
```

To create a KVM host, enter the following:

``` bash
maas $PROFILE vm-hosts create type=virsh power_address=qemu+ssh://ubuntu@192.168.1.2/system
```
deb-2-7-cli deb-2-8-cli deb-2-9-cli snap-2-8-cli snap-2-7-cli snap-2-9-cli -->

<strong>NOTE:</strong> 
MAAS will automatically discover and store the resources your VM host contains. Any existing machines will also appear on the 'Machines' page, and MAAS will automatically attempt to commission them.


<h2 id="heading--configuration">Configuration</h2>

<!-- deb-2-7-ui deb-2-8-ui deb-2-9-ui snap-2-8-ui snap-2-7-ui snap-2-9-ui
VM hosts have several configuration options. Modify these by selecting the 'Configuration' tab and clicking 'Edit'. Options include a VM host's location, password, network zone, and default resource pool.

<a href="https://discourse.maas.io/uploads/default/original/1X/e6f9b3effcc9e4f44a09836cf6185449410bae7f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e6f9b3effcc9e4f44a09836cf6185449410bae7f.png"></a>
deb-2-7-ui deb-2-8-ui deb-2-9-ui snap-2-8-ui snap-2-7-ui snap-2-9-ui -->

<!-- deb-2-7-cli deb-2-8-cli deb-2-9-cli snap-2-8-cli snap-2-7-cli snap-2-9-cli
Using the CLI, it's possible to update the configuration of a VM host.  You can change these configurable parameters with an `update` command -- but first, you'll want to know how to check the values of configurable parameters, both before and after the change.

<h3>List VM-hosts</h3>

To begin, you can list your available KVM-hosts with the following command:

```
maas admin vm-hosts read | jq -r '(["ID, "VM-HOST","SYSID","CORES",
"USED","RAM", "USED","STORAGE", "USED"] | (., map(length*"-"))),
(.[]| [.id,.name,.host.system_id,.total.cores, .used.cores, .total.memory, .used.memory,.total.local_storage, .used.local_storage])
| @tsv' | column -t
```

This command is in the [CLI cookbook](/t/the-cli-cookbook/2218) as [lsvmh](/t/the-cli-cookbook/2218#heading--vm-host-list)

<h3>List configurable VM host parameters</h3>

There are just a few parameters that you can change for a VM host.  You can list these, on a per-host basis, using the following procedure:

1. Run the command above[lsvmh](/t/the-cli-cookbook/2218#heading--vm-host-list)) to get the VM host ID (different from the System ID, see the first column in the listing).

2. Enter the following command ([lsvmhc](/t/the-cli-cookbook/2218#heading--vm-host-config) to list configurable parameters:

```
maas admin vm-host read $ID | jq -r '(["ID","NAME","POOL","ZONE",
"CPU-O/C", "RAM-O/C", "TAGS"] | (., map(length*"-"))), (.| [.id,.name,
.pool.name, .zone.name,.cpu_over_commit_ratio, 
.memory_over_commit_ratio, .tags[]]) | @tsv' | column -t
```

where $ID is the ID (not System ID) of the VM-host.

<h3>Change the VM host's name</h3>

You can change the VM host's name very simply, with this command:

    maas admin vm-host update $ID name=$NEW_NAME

where $ID is the VM host's ID (not System ID), and $NEW_NAME is the new name you want to assign.  You can check that the change was successful by just printing out the ID and name, like this:

```
maas admin vm-host read $ID | jq -r '(["ID","NAME"] 
| (., map(length*"-"))), (.| [.id,.name]) 
| @tsv' | column -t
```

You can find this script at [catvmname](/t/the-cli-cookbook-2218#heading--jq-check-vm-host-name).

<h3>Change the VM host's pool</h3>

You can also change the VM host's pool with a simple command:

    maas admin vm-host update $ID pool=$VALID_POOL

where $ID is the VM host's ID (not System ID), and $VALID_POOL is the name of a pool that already exists.  If you mention a pool you haven't created yet, you'll get an error like this:

```
{"pool": ["Select a valid choice. That choice is not one of the available choices."]}
```

If you want to see the available choices, you can list pools with [catvmpool](/t/the-cli-cookbook-2218#heading--list-pools):

    maas admin resource-pools read | jq -r '.[] | (.name)'

If you really want to set your VM host to a new one, you just need to create a new one with this command:

    maas admin resource-pools create name=$NEW_POOL_NAME

Then double-check it with `catvmpools`, and assign your VM host to it using the earlier command. 
deb-2-7-cli deb-2-8-cli deb-2-9-cli snap-2-8-cli snap-2-7-cli snap-2-9-cli -->

<h3 id="heading--overcommit-resources">Over-commit resources</h3>

Over-committed resources are those allocated beyond what's available in the physical resource. Using sliders on the configuration page, you can limit whether MAAS will attempt to overcommit CPU and memory. The input fields to the right of the sliders accept floating-point values from 0 to 10, with a default value of 1.

The following shows theoretical examples of these ratios and how they affect physical resource allocation:

1.  `8 physical CPU cores  * 1 multiplier     = 8 virtual CPU cores`
2.  `8 physical CPU cores  * 0.5 multiplier   = 4 virtual CPU cores`
3.  `32 physical CPU cores * 10.0 multiplier  = 320 virtual CPU cores`
4.  `128GB physical memory  * 5.5 multiplier  = 704G virtual Memory`

<!-- snap-2-7-ui snap-2-8-ui snap-2-9-ui deb-2-7-ui deb-2-8-ui deb-2-9-ui
<a href="https://discourse.maas.io/uploads/default/original/1X/27a8f21392af3d29a500e33f99e1f79c578cf29c.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/27a8f21392af3d29a500e33f99e1f79c578cf29c.jpeg"></a> 
snap-2-7-ui snap-2-8-ui snap-2-9-ui deb-2-7-ui deb-2-8-ui deb-2-9-ui -->

Over-committing resources allows a user to compose many MAAS-managed machines without worrying about the physical limitations of the host. For example, on a physical host with four cores and 12 GB of memory, you could compose four libvirt machines, each using two cores and 4 GB of memory.  This arrangement over commits the available physical resources. Provided you never run all four VMs simultaneously, you would have all the benefits of MAAS-managed VMs without over-taxing your host.