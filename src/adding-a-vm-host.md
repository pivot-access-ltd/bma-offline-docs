<a href="#heading--about-vm-hosts"><h2 id="heading--about-vm-hosts">About VM hosts</h2></a>

A VM host is simply a machine which can run virtual machines (VMs) by allocating  resources across the VMs you want to create.  If needed, you can over-commit resources, allocating more resources than actually available, so long as you don't try to use more than the VM host has available at any one time. Once MAAS has enlisted, commissioned, and acquired a newly-added machine, you can deploy it as a VM host.  Alternatively, you can create a VM host from a machine you've already got running.

[note type="caution" status="Warning"]
You **must** [configure your network](/t/vm-host-networking/nnnn) to support a VM host before following the procedures in this section.  You will also want to make sure that you have [set up SSH](/t/vm-host-networking/nnnn#heading--set-up-ssh) (if needed) before you follow any procedures in this section. 
[/note]

<a href="#heading--adding-a-vm-host"><h2 id="heading--adding-a-vm-host">How to add a VM host</h2></a>

rad-begin  /deb/2.9/ui /snap/2.9/ui /snap/3.0/ui /deb/3.0/ui
After installing MAAS, the 'KVM' page is typically empty:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/883a61d38dea2c04010bf9286f0c68700b14975c.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/883a61d38dea2c04010bf9286f0c68700b14975c.png"></a>

rad-end
 
rad-begin /snap/3.0/ui /deb/3.0/ui 
If you want to add a LXD (or [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt)) KVM host to a machine which is already installed, you can do so with the 'Add KVM' button:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/93fcb7aecee3eeea31f3939a884c12fe89f790ba.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/93fcb7aecee3eeea31f3939a884c12fe89f790ba.jpeg"></a>

Upon selecting "Authenticate" (assuming successful authentication), you will recieve a project selection screen similar to this:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/346c8e29fc8d4b74507843a956865ebd254aad57.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/346c8e29fc8d4b74507843a956865ebd254aad57.jpeg"></a>

You must either enter a new project name (which cannot contain spaces or special characters), or you must select an existing project.  If you're not really planning on using projects, selecting the "default" project will allow you to continue working as you have in the past.
rad-end
 
rad-begin  /deb/2.9/ui  /snap/2.9/ui 
If you want to add a [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt) or LXD VM host to a machine which is already installed, you can do so with the 'Add KVM' button:

<a href="https://discourse.maas.io/uploads/default/original/1X/197ae57b89b32546cf054fff49452f9025354af8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/197ae57b89b32546cf054fff49452f9025354af8.jpeg"></a> 

Here, 'Virsh address' typically looks like the following for libvirt:

    qemu+ssh://<vm host IP>/system

of like this for LXD (Beta):

    https://10.0.0.100:8443
rad-end
    
rad-begin /snap/3.0/cli /deb/3.0/cli
To add a VM host:

``` bash
maas $PROFILE vm-host create type=$VM_HOST_TYPE power_address=$POWER_ADDRESS \
    [power_user=$USERNAME] power_pass=$PASSWORD {project=$PROJECT} \
    [zone=$ZONE] [tags=$TAG1,$TAG2,...]
```

$VM_HOST_TYPE can currently take two values: `virsh` and `lxd`.

$POWER_ADDRESS typically looks like the following for libvirt:

    qemu+ssh://<vm host IP>/system

of like this for LXD (Beta):

    https://10.0.0.100:8443

Both $USERNAME and $PASSWORD are optional for the virsh power type. $ZONE and $TAGS are optional for all VM hosts.

The `power_...` parameters will vary with power type.  See the [API reference](/docs/api#power-types) for a listing of available power types.

For example, to create a LXD VM host, enter the following:

``` bash
maas $PROFILE vm-hosts create type=lxd power_address=$LXD_BRIDGE_ADDRESS \
   power_pass=$LXD_TRUST_PASSWORD project=$PROJECT_NAME
```

Note that for LXD VM hosts, a project name is not optional.  Project names cannot contain spaces or special characters. If you enter a project name which doesn't exist, MAAS will create the LXD project for you.
rad-end
 
rad-begin  /deb/2.9/cli  /snap/2.9/cli 
To add a VM host:

``` bash
maas $PROFILE vm-host create type=$VM_HOST_TYPE power_address=$POWER_ADDRESS \
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
rad-end

[note]
MAAS will automatically discover and store the resources your VM host contains. Any existing machines will also appear on the 'Machines' page, and MAAS will automatically attempt to commission them.
[/note]

rad-begin  /deb/2.9/ui  /snap/2.9/ui

<a href="#heading--configuration"><h2 id="heading--configuration">How to configure a VM host</h2></a>

VM hosts have several configuration options. Modify these by selecting the 'Configuration' tab and eidting options directly.  These options include a VM host's location, password, network zone, resource pool, and memory and CPU overcommit sliders.

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8b3fc96a8f1a1e4b25413a9f60388dc04dd886c9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8b3fc96a8f1a1e4b25413a9f60388dc04dd886c9.png"></a>
rad-end

rad-begin /snap/3.0/ui /deb/3.0/ui

<a href="#heading--vm-host-project-summary"><h2 id="heading--vm-host-project-summary">About LXD VM host project summaries</h2></a>

Each LXD VM host provides a "Project" tab that summarizes the current state of the LXD KVM:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e0cc264a17d67f9530ff8c2ef2bb9522fed0749a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e0cc264a17d67f9530ff8c2ef2bb9522fed0749a.png"></a>

This tab identifies the project, shows its current resource state, and provides the ability to select existing VM hosts and perform specific actions on them -- as well as being able to compose new VMs on the spot.

<a href="#heading--vm-host-resource-details"><h2 id="heading--vm-host-resource-details">About LXD VM host resource details</h2></a>

This tab presents a summary of the LXD VM host's resource usage:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d67cf384d6fe903274893eb50a098518d2c1295d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d67cf384d6fe903274893eb50a098518d2c1295d.png"></a>

The only interactive option on this tab allows you to map or unmap resource usage to NUMA nodes.

<a href="#heading--configuration"><h2 id="heading--configuration">About VM host settings</h2></a>

VM hosts have several settings. Modify these by selecting the 'Settings' tab and editing items directly. Options include a VM host's address, password, network zone, resource pool, and memory and CPU overcommit sliders.

<a href="https://discourse.maas.io/uploads/default/original/2X/2/253afc122d61145be656bb5c3811f9b6c6caa708.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/253afc122d61145be656bb5c3811f9b6c6caa708.png"></a>
rad-end

rad-begin  /deb/2.9/cli  /snap/2.9/cli /snap/3.0/cli /deb/3.0/cli 
Using the CLI, it's possible to update the configuration of a VM host.  You can change these configurable parameters with an `update` command -- but first, you'll want to know how to check the values of configurable parameters, both before and after the change.

<a href="#heading--list-vm-hosts"><h3 id="heading--list-vm-hosts">How to list VM-hosts</h3></a>

To begin, you can list your available KVM-hosts with the following command:

```
maas admin vm-hosts read | jq -r '(["ID, "VM-HOST","SYSID","CORES",
"USED","RAM", "USED","STORAGE", "USED"] | (., map(length*"-"))),
(.[]| [.id,.name,.host.system_id,.total.cores, .used.cores, .total.memory, .used.memory,.total.local_storage, .used.local_storage])
| @tsv' | column -t
```

<a href="#heading--list-config-params"><h3 id="heading--list-config-params">How to list configurable VM host parameters</h3></a>

There are just a few parameters that you can change for a VM host.  You can list these, on a per-host basis, using the following two-step procedure:

1. Run the command above to get the VM host ID (different from the System ID, see the first column in the listing).

2. Enter the following command to list configurable parameters:

```
maas admin vm-host read $ID | jq -r '(["ID","NAME","POOL","ZONE",
"CPU-O/C", "RAM-O/C", "TAGS"] | (., map(length*"-"))), (.| [.id,.name,
.pool.name, .zone.name,.cpu_over_commit_ratio, 
.memory_over_commit_ratio, .tags[]]) | @tsv' | column -t
```

where $ID is the ID (not System ID) of the VM-host.

<a href="#heading--change-vm-host-name"><h3 id="heading--change-vm-host-name">How to change a VM host's name</h3></a>

You can change the VM host's name very simply, with this command:

    maas admin vm-host update $ID name=$NEW_NAME

where $ID is the VM host's ID (not System ID), and $NEW_NAME is the new name you want to assign.  You can check that the change was successful by just printing out the ID and name, like this:

```
maas admin vm-host read $ID | jq -r '(["ID","NAME"] 
| (., map(length*"-"))), (.| [.id,.name]) 
| @tsv' | column -t
```

<a href="#heading--change-vm-host-pool"><h3 id="heading--change-vm-host-pool">How to change a VM host's pool</h3></a>

You can also change the VM host's pool with a simple command:

    maas admin vm-host update $ID pool=$VALID_POOL

where $ID is the VM host's ID (not System ID), and $VALID_POOL is the name of a pool that already exists.  If you mention a pool you haven't created yet, you'll get an error like this:

```
{"pool": ["Select a valid choice. That choice is not one of the available choices."]}
```

    maas admin resource-pools read | jq -r '.[] | (.name)'

If you really want to set your VM host to a new one, you just need to create a new one with this command:

    maas admin resource-pools create name=$NEW_POOL_NAME

Then double-check it with `catvmpools`, and assign your VM host to it using the earlier command. 
rad-end

<a href="#heading--overcommit-resources"><h3 id="heading--overcommit-resources">About over-committed resources</h3></a>

Over-committed resources are those allocated beyond what's available in the physical resource. Using sliders on the configuration page, you can limit whether MAAS will attempt to overcommit CPU and memory. The input fields to the right of the sliders accept floating-point values from 0 to 10, with a default value of 1.

The following shows four theoretical examples of these ratios and how they affect physical resource allocation:

1.  `8 physical CPU cores  * 1 multiplier     = 8 virtual CPU cores`
2.  `8 physical CPU cores  * 0.5 multiplier   = 4 virtual CPU cores`
3.  `32 physical CPU cores * 10.0 multiplier  = 320 virtual CPU cores`
4.  `128GB physical memory  * 5.5 multiplier  = 704G virtual Memory`

rad-begin   /snap/2.9/ui   /deb/2.9/ui  /snap/3.0/ui /deb/3.0/ui 
<a href="https://discourse.maas.io/uploads/default/original/1X/27a8f21392af3d29a500e33f99e1f79c578cf29c.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/27a8f21392af3d29a500e33f99e1f79c578cf29c.jpeg"></a> 
rad-end

Over-committing resources allows a user to compose many MAAS-managed machines without worrying about the physical limitations of the host. For example, on a physical host with four cores and 12 GB of memory, you could compose four libvirt machines, each using two cores and 4 GB of memory.  This arrangement over commits the available physical resources. Provided you never run all four VMs simultaneously, you would have all the benefits of MAAS-managed VMs without over-taxing your host.

rad-begin /snap/2.9/cli /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli
<a href="#heading--list-resources-of-all-vm-hosts"><h2 id="heading--list-resources-of-all-vm-hosts">How to list the resources of all VM hosts</h2></a>

``` bash
maas $PROFILE vm-hosts read
```

A portion of the sample output:

``` no-highlight
        "id": 93,
        "capabilities": [
            "composable",
            "fixed_local_storage",
            "iscsi_storage"
        ],
        "name": "civil-hermit",
```

<a href="#heading--list-resources-of-a-vm-host"><h2 id="heading--list-resources-of-a-vm-host">How to list the resources of a single VM host</h2></a>

To list an individual VM host's resources:

``` bash
maas $PROFILE vm-host read $VM_HOST_ID
```

<a href="#heading--update-vm-host-configuration"><h2 id="heading--update-vm-host-configuration">How to update a VM host's configuration</h2></a>

Update overcommit ratios for a KVM host:

``` bash
maas $PROFILE vm-host update $VM_HOST_ID power_address=qemu+ssh://ubuntu@192.168.1.2/system \
        power_pass=example cpu_over_commit_ratio=2.5 memory_over_commit_ratio=10.0
```

Update the default storage pool used by a KVM host:

``` bash
maas $PROFILE vm-host update $VM_HOST_ID power_address=qemu+ssh://ubuntu@192.168.1.2/system \
        power_pass=example default_storage_pool=pool2
```

<a href="#heading--list-vm-host-connection-parameters"><h2 id="heading--list-vm-host-connection-parameters">How to list a VM host's connection parameters</h2></a>

To list a VM host's connection parameters:

``` bash
maas $PROFILE vm-host parameters $VM_HOST_ID
```

Example output:

``` no-highlight
{
    "power_address": "10.3.0.1:8443",
    "power_pass": "admin",
    "power_user": "admin"
}
```

rad-end

<!-- comment -->
