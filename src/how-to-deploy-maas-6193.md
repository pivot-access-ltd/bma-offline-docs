<!-- "How to deploy MAAS" -->

With your network properly configured, and suitable images selected and downloaded, you're ready to enlist, commission, and deploy machines.  This major section will help you sort out the theoretical aspects and procedures regarding the MAAS machine life-cycle.  You can search for the [big picture topics](#heading--the-big-picture-of-deploying-machines), or consult the [life-cycle permuted index](#heading--life-cycle-permuted-index).

<a href="#heading--the-big-picture-of-deploying-machines"><h2 id="heading--the-big-picture-of-deploying-machines">The big picture of deploying machines</h2></a>

Here are some theoretical aspects of machines to consider:

- [About controllers](/t/about-controllers/5072): Most of the functionality of MAAS is contained in a series of controllers. There are two basic types: a region controller and one or more rack controllers. The region controller deals with operator requests, while the rack controller(s) provides high-bandwidth services to the individual machines. In essence, the region controller interacts with the user, while the rack controllers manage the bare metal.  Knowing how these controllers communicate -- and divvy up the workload -- can be very useful when operating MAAS.
- [About machines](/t/about-machines/5080): Machines are the heart of MAAS. They are the backbone of your data centre application(s), providing the functions that are relevant to your customers.
- [About customising machines](/t/about-customising-machines/5976): Prior to deployment, MAAS machines can be customised in a number of ways. Machines can also be customised post-deployment, while running, either by changing out the physical hardware, or by altering the VM from the VM host side.
- [About VM hosting](/t/about-vm-hosting/5068): MAAS VM hosts allow for the dynamic composition of nodes from a pool of available hardware resources (e.g. disk space, memory, cores). You can create virtual machines (VMs) as needed within the limits of your resources, without concern for physical hardware.

On the other hand, if you need to get machines deployed, you can consult these practical guides:

- [How to manage controllers](/t/how-to-manage-controllers/5172): Managing region and rack controllers -- how many and how they're arranged -- is a critical skill for designing and managing larger MAAS instances.
- [How to manage machines](/t/how-to-manage-machines/5160): Most of the day-to-day work of managing machines is covered here.  
- [How to deploy machines](/t/how-to-deploy-machines/5112): The ultimate purpose of MAAS is to enlist, commission, and deploy machines.  This article covers these core operations.
- [How to customise machines](/t/how-to-customise-machines/5108): MAAS provides the capability to customise machines in many different ways: resources, images, pre-deployment scripting, and much more.
- [How to manage VM hosts](/t/how-to-manage-vm-hosts/5140): Virtual machine hosts provide a way to extend machines to users without having large racks of individual machines.  This article details the steps required to make this happen with MAAS.
- [How to manage VMs](/t/how-to-manage-vms/5148): This article covers a few rudimentary procedures for managing generic virtual machines.  
- [How to use LXD](/t/how-to-use-lxd/5208): The LXD container system provides much greater flexibility in deploying virtual machines. LXD and MAAS are separate products, and it’s useful to allow them to interact as equals, covering a much wider range of use cases.  This article devotes quite a bit of detailed instruction to this useful topic.

<a href="#heading--life-cycle-permuted-index"><h2 id="heading--life-cycle-permuted-index">Permuted index</h2></a>

|  |  |
|------:|:------|
| [20.04](/t/how-to-use-lxd/5208#heading--newer-lxd) | How to refresh LXD on |
| [add a machine manually](/t/how-to-manage-machines/5160#heading--how-to-add-a-machine-manually) |How to |
| [add a machine to a resource pool](/t/how-to-manage-machines/5160#heading--add-a-machine-to-a-resource-pool) |How to |
| [add a new region host](/t/how-to-manage-controllers/5172#heading--adding-a-new-region-host) |How to |
| [add a resource pool](/t/how-to-manage-machines/5160#heading--add-a-resource-pool) |How to |
| [add a VM host](/t/how-to-manage-vm-hosts/5140#heading--adding-a-vm-host) |How to |
| [add a VM host to a resource pool](/t/how-to-manage-machines/5160#heading--add-a-vm-host-to-a-resource-pool) |How to |
| [add a VM (CLI)](/t/how-to-manage-vms/5148#heading--adding-a-vm-from-the-cli) |How to |
| [add a VM (UI)](/t/how-to-manage-vms/5148#heading--add-vm-from-ui) |How to |
| [adding a VM](/t/how-to-manage-vms/5148#heading--architecture) |How to set the architecture while |
| [adding a VM](/t/how-to-manage-vms/5148#heading--interfaces) |How to specify interfaces while |
| [adding a VM](/t/how-to-manage-vms/5148#heading--set-resources) |How to set resources while |
| [adding a VM](/t/how-to-manage-vms/5148#heading--storage) |How to set storage parameters while |
| [adding machines](/t/about-machines/5080#heading--about-adding-machines) |About |
| [add LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-add-lxd-clusters) |How to |
| [add machines via a chassis](/t/how-to-manage-machines/5160#heading--how-to-add-machines-via-a-chassis) |How to |
| [allocate machines](/t/how-to-deploy-machines/5112#heading--allocate-machines) |How to |
| [allocation and deployment](/t/about-machines/5080#heading--about-allocation-and-deployment) |About |
| [allocations for one machine](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-one-machine) |How to list dynamic |
| [already running a workload](/t/how-to-deploy-machines/5112#heading--enlisted-deployed-machines) |How to enlist a machine that’s |
| [alternatives to LXD projects in MAAS](/t/how-to-use-lxd/5208#heading--projects-big-picture) |About |
| [annotation for a machine](/t/how-to-manage-machines/5160#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or clear a static |
| [annotation for a machine](/t/how-to-manage-machines/5160#heading--set-a-static-annotation-for-a-machine) |How to set a static |
| [annotation for one machine](/t/how-to-manage-machines/5160#heading--view-a-static-annotation-for-one-machine) |How to view a static |
| [annotations for all machines](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-all-machines) |How to list dynamic |
| [annotations for all machines](/t/how-to-manage-machines/5160#heading--list-static-annotations-for-all-machines) |How to list static |
| [annotations for a machine](/t/how-to-manage-machines/5160#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear and change dynamic |
| [annotations for a machine](/t/how-to-manage-machines/5160#heading--set-dynamic-annotations-for-a-machine) |How to set dynamic |
| [annotations](/t/about-machines/5080#heading--about-annotations) |About |
| [annotations](/t/how-to-manage-machines/5160#heading--how-to-use-annotations) |How to use |
| [annotations](/t/how-to-manage-machines/5160#heading--identify-machines-that-can-receive-dynamic-annotations) |How to identify machines that can receive dynamic |
| [annotations](/t/how-to-manage-machines/5160#heading--work-with-dynamic-workload-annotations) |How to use dynamic (workload) |
| [annotations](/t/how-to-manage-machines/5160#heading--work-with-static-annotations) |How to use static |
| [another project to hide them from MAAS](/t/how-to-use-lxd/5208#heading--projects-s2-move-non-maas-items) |How to move LXD entities to |
| [API to configure a bridge](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-cli) |How to use the MAAS |
| [apply a hardware test](/t/how-to-deploy-machines/5112#heading--apply-a-hardware-test) |How to |
| [architecture while adding a VM](/t/how-to-manage-vms/5148#heading--architecture) |How to set the |
| [associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-vm-in-vm-host-project) |How to create a new VM in the LXD project |
| [associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-move-vm-into-vm-host-project) |How to move an existing VM into the LXD project |
| [attached USB and PCI devices](/t/about-machines/5080#heading--usb-pci-devices) |Handling |
| [attached USB and PCI devices](/t/how-to-manage-machines/5160#heading--usb-pci-devices) |How to manage |
| [authentication](/t/about-vm-hosting/5068#heading--about-lxd-vm-host-auth) |About LXD VM host |
| [automatic script selection by hardware type](/t/about-machines/5080#heading--about-automatic-script-selection-by-hardware-type) |About |
| [availability kernels](/t/about-customising-machines/5976#heading--general-availability-kernels) |About general |
| [available for VM hosting](/t/how-to-use-lxd/5208#heading--lxd-setup) |How to make LXD |
| [available resource pools](/t/how-to-customise-machines/5108#heading--list-available-resource-pools) |How to list |
| [available resource pools](/t/how-to-manage-machines/5160#heading--list-available-resource-pools) |How to list |
| [bcache storage layout reference](/t/how-to-manage-machines/5160#heading--bcache-storage-layout-reference) | |
| [Blank storage layout reference](/t/how-to-manage-machines/5160#heading--blank-storage-layout-reference) | |
| [block device as a boot disk](/t/how-to-customise-machines/5108#heading--how-to-set-a-block-device-as-a-boot-disk) |How to set a |
| [block device as a boot disk](/t/how-to-manage-machines/5160#heading--how-to-set-a-block-device-as-a-boot-disk) |How to set a |
| [block devices](/t/about-customising-machines/5976#heading--about-block-devices) |About |
| [block devices](/t/about-machines/5080#heading--about-block-devices) |About |
| [block devices](/t/how-to-customise-machines/5108#heading--how-to-list-block-devices) |How to list |
| [block devices](/t/how-to-manage-machines/5160#heading--how-to-list-block-devices) |How to list |
| [block devices](/t/how-to-manage-machines/5160#heading--how-to-manage-block-devices) |How to manage |
| [block device](/t/how-to-manage-machines/5160#heading--format-block-device) |How to format a |
| [block device](/t/how-to-manage-machines/5160#heading--how-to-create-a-block-device) |How to create a |
| [block device](/t/how-to-manage-machines/5160#heading--how-to-delete-a-block-device) |How to delete a |
| [block device](/t/how-to-manage-machines/5160#heading--how-to-mount-a-block-device) |How to mount a |
| [block device](/t/how-to-manage-machines/5160#heading--how-to-read-a-block-device) |How to read a |
| [block device](/t/how-to-manage-machines/5160#heading--how-to-unformat-a-block-device) |How to unformat a |
| [block device](/t/how-to-manage-machines/5160#heading--how-to-unmount-a-block-device) |How to unmount a |
| [block device](/t/how-to-manage-machines/5160#heading--how-to-update-a-block-device) |How to update a |
| [BMC enlistment](/t/about-machines/5080#heading--about-bmc-enlistment) |About |
| [boot disk](/t/how-to-customise-machines/5108#heading--how-to-set-a-block-device-as-a-boot-disk) |How to set a block device as a |
| [boot disk](/t/how-to-manage-machines/5160#heading--how-to-set-a-block-device-as-a-boot-disk) |How to set a block device as a |
| [booting](/t/about-customising-machines/5976#heading--about-uefi-booting) |About UEFI |
| [booting](/t/about-machines/5080#heading--about-uefi-booting) |About UEFI |
| [boot methods](/t/about-machines/5080#heading--about-disabling-individual-boot-methods) |About disabling individual |
| [boot options](/t/about-customising-machines/5976#heading--about-kernel-boot-options) |About kernel |
| [boot options](/t/how-to-customise-machines/5108#heading--how-to-set-global-kernel-boot-options) |How to set global kernel |
| [bridge](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-cli) |How to use the MAAS API to configure a |
| [bridge with libvirt](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-libvirt) |How to set up a VM host |
| [bridge with netplan](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-netplan) |How to set up a VM host |
| [bridge with the web UI](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-web-ui) |How to set up a VM host |
| [built-in kernel options](/t/how-to-customise-machines/5108#heading--create-tags-with-built-in-kernel-options) |How to create tags with |
| [built-in scripts](/t/how-to-deploy-machines/5112#heading--how-to-download-built-in-scripts) |How to download |
| [change a VM host's name](/t/how-to-manage-vm-hosts/5140#heading--change-vm-host-name) |How to |
| [change a VM host's pool](/t/how-to-manage-vm-hosts/5140#heading--change-vm-host-pool) |How to |
| [change dynamic annotations for a machine](/t/how-to-manage-machines/5160#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear and |
| [change or clear a static annotation for a machine](/t/how-to-manage-machines/5160#heading--change-or-clear-a-static-annotation-for-a-machine) |How to |
| [chassis](/t/how-to-manage-machines/5160#heading--how-to-add-machines-via-a-chassis) |How to add machines via a |
| [choose Ubuntu kernels](/t/how-to-customise-machines/5108#heading--how-to-choose-ubuntu-kernels) |How to |
| [choosing a kernel](/t/about-customising-machines/5976#heading--using-kernels) |About |
| [clear and change dynamic annotations for a machine](/t/how-to-manage-machines/5160#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to |
| [clear a static annotation for a machine](/t/how-to-manage-machines/5160#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or |
| [clone machines](/t/how-to-manage-machines/5160#heading--how-to-clone-machines) |How to |
| [cloning machines](/t/about-machines/5080#heading--about-cloning-machines) |About |
| [cloud-init](/t/how-to-customise-machines/5108#heading--cloud-init) |How to pre-seed with |
| [clusters](/t/how-to-manage-vm-hosts/5140#heading--about-lxd-clusters) |About LXD |
| [clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-add-lxd-clusters) |How to add LXD |
| [clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-compose-vms-in-lxd-clusters) |How to compose VMs in LXD |
| [clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-delete-lxd-clusters) |How to delete LXD |
| [clusters](/t/how-to-manage-vm-hosts/5140#heading--lxd-clusters) |LXD |
| [commission a machine](/t/how-to-deploy-machines/5112#heading--how-to-commission-a-machine) |How to |
| [commissioning and testing scripts](/t/how-to-deploy-machines/5112#heading--tags-group-scripts) |How to use tags to group |
| [commissioning logs](/t/about-machines/5080#heading--commissioning-log) |About machine |
| [commissioning logs](/t/how-to-manage-machines/5160#heading--commissioning-log) |How to find |
| [commissioning machines](/t/about-machines/5080#heading--about-commissioning-machines) |About |
| [commissioning NUMA and SR-IOV nodes](/t/about-machines/5080#heading--about-numa-sriov-commissioning) |About |
| [commissioning scripts](/t/about-machines/5080#heading--about-maas-commissioning-scripts) |About MAAS |
| [commissioning](/t/how-to-customise-machines/5108#heading--set-a-default-minimum-kernel-for-enlistment-and-commissioning) |How to set a default minimum kernel for enlistment and |
| [communicate](/t/about-controllers/5072#heading--rackregion) |How region and rack controllers |
| [communicate with the rack controller](/t/about-controllers/5072#heading--machinerack) |How machines |
| [communication](/t/about-controllers/5072#heading--about-contr-comm) |About controller |
| [compose VMs in LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-compose-vms-in-lxd-clusters) |How to |
| [conditional erasure types](/t/how-to-customise-machines/5108#heading--how-to-specify-conditional-erasure-types) |How to specify |
| [conditional erasure types](/t/how-to-manage-machines/5160#heading--how-to-specify-conditional-erasure-types) |How to specify |
| [configurable VM host parameters](/t/how-to-manage-vm-hosts/5140#heading--list-config-params) |How to list |
| [configuration info](/t/about-machines/5080#heading--machine-config) |About machine |
| [configuration info](/t/how-to-manage-machines/5160#heading--machine-config) |How to find machine |
| [configuration](/t/about-machines/5080#heading--about-post-commission-configuration) |About post-commission |
| [configuration](/t/how-to-customise-machines/5108#heading--how-to-set-default-erasure-configuration) |How to set the default erasure |
| [configuration](/t/how-to-manage-machines/5160#heading--how-to-set-default-erasure-configuration) |How to set the default erasure |
| [configuration](/t/how-to-manage-vm-hosts/5140#heading--update-vm-host-configuration) |How to update a VM host's |
| [configure a bridge](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-cli) |How to use the MAAS API to |
| [configure a VM host](/t/how-to-manage-vm-hosts/5140#heading--configuration) |How to |
| [Configure deployment timeout](/t/how-to-deploy-machines/5112#heading--configure-deployment-timeout) | |
| [configure hardware sync interval](/t/how-to-customise-machines/5108#heading--how-to-configure-hardware-sync-interval) |How to |
| [configure machines](/t/how-to-manage-machines/5160#heading--how-to-create-delete-and-configure-machines) |How to create, delete, and |
| [configure network validation and testing scripts](/t/how-to-deploy-machines/5112#heading--network-validation-scripts-and-testing) |How to |
| [connection parameters](/t/how-to-manage-vm-hosts/5140#heading--list-vm-host-connection-parameters) |How to list a VM host's |
| [controller communication](/t/about-controllers/5072#heading--about-contr-comm) |About |
| [controller from one MAAS instance to another](/t/how-to-manage-controllers/5172#heading--about-moving-rack-controller) |About moving a rack |
| [controller from one MAAS instance to another](/t/how-to-manage-controllers/5172#heading--move-rack-controller) |How to move a rack |
| [controller performance](/t/how-to-manage-controllers/5172#heading--increasing-regiond-daemon-workers) |How to improve region |
| [controllers communicate](/t/about-controllers/5072#heading--rackregion) |How region and rack |
| [controllers](/t/about-controllers/5072#heading--rack-controllers) |About rack |
| [controllers](/t/about-controllers/5072#heading--region-controller) |About region |
| [controllers](/t/how-to-manage-controllers/5172#heading--list-rack-controllers) |How to list rack |
| [controller](/t/about-controllers/5072#heading--machinerack) |How machines communicate with the rack |
| [controller](/t/how-to-manage-controllers/5172#heading--dangers-moving-rack-controller) |About the potential dangers of moving a rack |
| [controller](/t/how-to-manage-controllers/5172#heading--install-a-rack-controller) |How to install a rack |
| [controller](/t/how-to-manage-controllers/5172#heading--unregister-a-rack-controller) |How to unregister a rack |
| [controls VMs at a project level](/t/how-to-use-lxd/5208#heading--maas-control-at-project-level) |MAAS now |
| [create a block device](/t/how-to-customise-machines/5108#heading--how-to-create-a-block-device) |How to |
| [create a block device](/t/how-to-manage-machines/5160#heading--how-to-create-a-block-device) |How to |
| [create a LXD project](/t/how-to-use-lxd/5208#heading--projects-s1-create) |How to |
| [create a new project for MAAS when instantiating a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-with-vm-host) |How to |
| [create a new VM in the LXD project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-vm-in-vm-host-project) |How to |
| [create a partition](/t/how-to-customise-machines/5108#heading--how-to-create-a-partition) |How to |
| [create a partition](/t/how-to-manage-machines/5160#heading--how-to-create-a-partition) |How to |
| [create a resource pool](/t/how-to-customise-machines/5108#heading--creating-a-resource-pool) |How to |
| [create a resource pool](/t/how-to-manage-machines/5160#heading--creating-a-resource-pool) |How to |
| [create a VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-create-a-vmfs-datastore) |How to |
| [create a VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-create-a-vmfs-datastore) |How to |
| [create, delete, and configure machines](/t/how-to-manage-machines/5160#heading--how-to-create-delete-and-configure-machines) |How to |
| [create tags with built-in kernel options](/t/how-to-customise-machines/5108#heading--create-tags-with-built-in-kernel-options) |How to |
| [curtin](/t/how-to-customise-machines/5108#heading--how-to-pre-seed-with-curtin) |How to pre-seed with |
| [customise machine storage](/t/how-to-customise-machines/5108#heading--how-to-customise-machine-storage) |How to |
| [customise network testing](/t/how-to-deploy-machines/5112#heading--customisable-network-testing) |How to |
| [customising deployed machines](/t/about-customising-machines/5976#heading--about-customising-deployed-machines) |About |
| [customising machines prior to deployment](/t/about-customising-machines/5976#heading--about-customising-machines-prior-to-deployment) |About |
| [customising machine storage](/t/about-customising-machines/5976#heading--about-customising-machine-storage) |About |
| [custom storage layouts](/t/how-to-manage-machines/5160#heading--how-to-define-custom-storage-layouts) |How to define |
| [dangers of moving a rack controller](/t/how-to-manage-controllers/5172#heading--dangers-moving-rack-controller) |About the potential |
| [datastores](/t/about-customising-machines/5976#heading--about-vmfs-datastores) |About VMFS |
| [datastores](/t/about-machines/5080#heading--about-vmfs-datastores) |About VMFS |
| [datastores](/t/how-to-customise-machines/5108#heading--how-to-list-vmfs-datastores) |How to list VMFS |
| [datastores](/t/how-to-manage-machines/5160#heading--how-to-list-vmfs-datastores) |How to list VMFS |
| [datastores](/t/how-to-manage-machines/5160#heading--how-to-manage-vmfs-datastores) |How to manage VMFS |
| [datastore](/t/how-to-customise-machines/5108#heading--how-to-create-a-vmfs-datastore) |How to create a VMFS |
| [datastore](/t/how-to-customise-machines/5108#heading--how-to-delete-a-vmfs-datastore) |How to delete a VMFS |
| [datastore](/t/how-to-customise-machines/5108#heading--how-to-edit-a-vmfs-datastore) |How to edit a VMFS |
| [datastore](/t/how-to-customise-machines/5108#heading--how-to-view-a-vmfs-datastore) |How to view a VMFS |
| [datastore](/t/how-to-manage-machines/5160#heading--how-to-create-a-vmfs-datastore) |How to create a VMFS |
| [datastore](/t/how-to-manage-machines/5160#heading--how-to-delete-a-vmfs-datastore) |How to delete a VMFS |
| [datastore](/t/how-to-manage-machines/5160#heading--how-to-edit-a-vmfs-datastore) |How to edit a VMFS |
| [datastore](/t/how-to-manage-machines/5160#heading--how-to-view-a-vmfs-datastore) |How to view a VMFS |
| [debugging script failures](/t/about-machines/5080#heading--about-debugging-script-failures) |About |
| [debug script failures](/t/how-to-deploy-machines/5112#heading--how-to-debug-script-failures) |How to |
| [default erasure configuration](/t/how-to-customise-machines/5108#heading--how-to-set-default-erasure-configuration) |How to set the |
| [default erasure configuration](/t/how-to-manage-machines/5160#heading--how-to-set-default-erasure-configuration) |How to set the |
| [default minimum kernel for enlistment and commissioning](/t/how-to-customise-machines/5108#heading--set-a-default-minimum-kernel-for-enlistment-and-commissioning) |How to set a |
| [define custom storage layouts](/t/how-to-manage-machines/5160#heading--how-to-define-custom-storage-layouts) |How to |
| [delete a block device](/t/how-to-customise-machines/5108#heading--how-to-delete-a-block-device) |How to |
| [delete a block device](/t/how-to-manage-machines/5160#heading--how-to-delete-a-block-device) |How to |
| [delete a LXD project](/t/how-to-use-lxd/5208#heading--projects-s1-delete) |How to |
| [delete, and configure machines](/t/how-to-manage-machines/5160#heading--how-to-create-delete-and-configure-machines) |How to create, |
| [delete a partition](/t/how-to-customise-machines/5108#heading--how-to-delete-a-partition) |How to |
| [delete a partition](/t/how-to-manage-machines/5160#heading--how-to-delete-a-partition) |How to |
| [delete a resource pool](/t/how-to-customise-machines/5108#heading--delete-a-resource-pool) |How to |
| [delete a resource pool](/t/how-to-customise-machines/5108#heading--deleting-a-resource-pool) |How to |
| [delete a resource pool](/t/how-to-manage-machines/5160#heading--delete-a-resource-pool) |How to |
| [delete a resource pool](/t/how-to-manage-machines/5160#heading--deleting-a-resource-pool) |How to |
| [delete a script](/t/how-to-deploy-machines/5112#heading--how-to-delete-a-script) |How to |
| [delete a VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-delete-a-vmfs-datastore) |How to |
| [delete a VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-delete-a-vmfs-datastore) |How to |
| [delete a VM](/t/how-to-manage-vms/5148#heading--delete-a-machine) |How to |
| [delete a VM](/t/how-to-manage-vms/5148#heading--delete-a-vm) |How to |
| [delete LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-delete-lxd-clusters) |How to |
| [delete the VM host](/t/how-to-use-lxd/5208#heading--projects-s2-delete-vm-host) |How to |
| [deployed machines](/t/about-customising-machines/5976#heading--about-customising-deployed-machines) |About customising |
| [deployed machines](/t/about-machines/5080#heading--enlisting-deployed-machines) |About enlisting |
| [deployed machine](/t/how-to-deploy-machines/5112#heading--update-deployed-hw-info) |How to update hardware information for a |
| [deploy machines](/t/how-to-deploy-machines/5112#heading--deploy) |How to |
| [deployment kernel for a machine](/t/how-to-customise-machines/5108#heading--set-a-minimum-deploy-kernel-for-a-machine) |How to set a minimum |
| [deployment](/t/about-customising-machines/5976#heading--about-customising-machines-prior-to-deployment) |About customising machines prior to |
| [deployment](/t/about-machines/5080#heading--about-allocation-and-deployment) |About allocation and |
| [deployment](/t/how-to-customise-machines/5108#heading--set-a-specific-kernel-during-machine-deployment) |How to set a specific kernel during machine |
| [deployment timeout](/t/how-to-deploy-machines/5112#heading--configure-deployment-timeout) |Configure |
| [design choices](/t/how-to-use-lxd/5208#heading--projects-history) |About |
| [details](/t/about-vm-hosting/5068#heading--vm-host-resource-details) |About LXD VM host resource |
| [details](/t/how-to-manage-machines/5160#heading--how-to-examine-machines-and-machine-details) |How to examine machines and machine |
| [details](/t/how-to-manage-machines/5160#heading--how-to-view-machine-details) |How to view machine |
| [detect slow network links](/t/how-to-deploy-machines/5112#heading--slow-link-detection) |How to |
| [device as a boot disk](/t/how-to-customise-machines/5108#heading--how-to-set-a-block-device-as-a-boot-disk) |How to set a block |
| [device as a boot disk](/t/how-to-manage-machines/5160#heading--how-to-set-a-block-device-as-a-boot-disk) |How to set a block |
| [devices](/t/about-customising-machines/5976#heading--about-block-devices) |About block |
| [devices](/t/about-machines/5080#heading--about-block-devices) |About block |
| [devices](/t/about-machines/5080#heading--usb-pci-devices) |Handling attached USB and PCI |
| [devices](/t/how-to-customise-machines/5108#heading--how-to-list-block-devices) |How to list block |
| [devices](/t/how-to-manage-machines/5160#heading--how-to-list-block-devices) |How to list block |
| [devices](/t/how-to-manage-machines/5160#heading--how-to-manage-block-devices) |How to manage block |
| [devices](/t/how-to-manage-machines/5160#heading--usb-pci-devices) |How to manage attached USB and PCI |
| [device](/t/how-to-customise-machines/5108#heading--format-block-device) |How to format a block |
| [device](/t/how-to-customise-machines/5108#heading--how-to-create-a-block-device) |How to create a block |
| [device](/t/how-to-customise-machines/5108#heading--how-to-delete-a-block-device) |How to delete a block |
| [device](/t/how-to-customise-machines/5108#heading--how-to-mount-a-block-device) |How to mount a block |
| [device](/t/how-to-customise-machines/5108#heading--how-to-read-a-block-device) |How to read a block |
| [device](/t/how-to-customise-machines/5108#heading--how-to-unformat-a-block-device) |How to unformat a block |
| [device](/t/how-to-customise-machines/5108#heading--how-to-unmount-a-block-device) |How to unmount a block |
| [device](/t/how-to-customise-machines/5108#heading--how-to-update-a-block-device) |How to update a block |
| [device](/t/how-to-manage-machines/5160#heading--format-block-device) |How to format a block |
| [device](/t/how-to-manage-machines/5160#heading--how-to-create-a-block-device) |How to create a block |
| [device](/t/how-to-manage-machines/5160#heading--how-to-delete-a-block-device) |How to delete a block |
| [device](/t/how-to-manage-machines/5160#heading--how-to-mount-a-block-device) |How to mount a block |
| [device](/t/how-to-manage-machines/5160#heading--how-to-read-a-block-device) |How to read a block |
| [device](/t/how-to-manage-machines/5160#heading--how-to-unformat-a-block-device) |How to unformat a block |
| [device](/t/how-to-manage-machines/5160#heading--how-to-unmount-a-block-device) |How to unmount a block |
| [device](/t/how-to-manage-machines/5160#heading--how-to-update-a-block-device) |How to update a block |
| [disabling individual boot methods](/t/about-machines/5080#heading--about-disabling-individual-boot-methods) |About |
| [disk erasure](/t/about-machines/5080#heading--about-disk-erasure) |About |
| [disk erasure types](/t/about-machines/5080#heading--about-disk-erasure-types) |About |
| [disks](/t/how-to-manage-machines/5160#heading--how-to-erase-disks) |How to erase |
| [disk](/t/how-to-manage-machines/5160#heading--how-to-set-a-block-device-as-a-boot-disk) |How to set a block device as a boot |
| [download a script](/t/how-to-deploy-machines/5112#heading--how-to-download-a-script) |How to |
| [download built-in scripts](/t/how-to-deploy-machines/5112#heading--how-to-download-built-in-scripts) |How to |
| [dynamic allocations for one machine](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-one-machine) |How to list |
| [dynamic annotations for all machines](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-all-machines) |How to list |
| [dynamic annotations for a machine](/t/how-to-manage-machines/5160#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear and change |
| [dynamic annotations for a machine](/t/how-to-manage-machines/5160#heading--set-dynamic-annotations-for-a-machine) |How to set |
| [dynamic annotations](/t/how-to-manage-machines/5160#heading--identify-machines-that-can-receive-dynamic-annotations) |How to identify machines that can receive |
| [dynamic (workload) annotations](/t/how-to-manage-machines/5160#heading--work-with-dynamic-workload-annotations) |How to use |
| [edit a VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-edit-a-vmfs-datastore) |How to |
| [edit a VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-edit-a-vmfs-datastore) |How to |
| [enable hardware sync on a machine](/t/how-to-customise-machines/5108#heading--how-to-enable-hardware-sync-on-a-machine) |How to |
| [enablement kernels](/t/about-customising-machines/5976#heading--hardware-enablement-kernels) |About hardware |
| [enablement kernels](/t/about-customising-machines/5976#heading--hardware-enablement-kernels-pre-release) |About pre-release hardware |
| [enlist a machine that’s already running a workload](/t/how-to-deploy-machines/5112#heading--enlisted-deployed-machines) |How to |
| [enlisting deployed machines](/t/about-machines/5080#heading--enlisting-deployed-machines) |About |
| [enlistment and commissioning](/t/how-to-customise-machines/5108#heading--set-a-default-minimum-kernel-for-enlistment-and-commissioning) |How to set a default minimum kernel for |
| [enlistment process](/t/about-machines/5080#heading--about-the-enlistment-process) |About the |
| [enlistment](/t/about-machines/5080#heading--about-bmc-enlistment) |About BMC |
| [enlistment](/t/about-machines/5080#heading--about-enlistment) |About |
| [entities to another project to hide them from MAAS](/t/how-to-use-lxd/5208#heading--projects-s2-move-non-maas-items) |How to move LXD |
| [erase disks](/t/how-to-manage-machines/5160#heading--how-to-erase-disks) |How to |
| [erasure configuration](/t/how-to-manage-machines/5160#heading--how-to-set-default-erasure-configuration) |How to set the default |
| [erasure order of preference](/t/about-machines/5080#heading--about-erasure-order-of-preference) |About |
| [erasure](/t/about-machines/5080#heading--about-disk-erasure) |About disk |
| [erasure](/t/about-machines/5080#heading--about-quick-erasure) |About quick |
| [erasure](/t/about-machines/5080#heading--about-secure-erasure) |About secure |
| [erasure](/t/about-machines/5080#heading--about-standard-erase) |About standard |
| [erasure types](/t/about-machines/5080#heading--about-disk-erasure-types) |About disk |
| [erasure types](/t/how-to-customise-machines/5108#heading--how-to-specify-conditional-erasure-types) |How to specify conditional |
| [erasure types](/t/how-to-manage-machines/5160#heading--how-to-specify-conditional-erasure-types) |How to specify conditional |
| [event logs](/t/about-machines/5080#heading--event-logs) |About machine |
| [event logs](/t/how-to-manage-machines/5160#heading--event-logs) |How to find a machine's |
| [examine machines and machine details](/t/how-to-manage-machines/5160#heading--how-to-examine-machines-and-machine-details) |How to |
| [existing VM into the LXD project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-move-vm-into-vm-host-project) |How to move an |
| [failed results](/t/how-to-deploy-machines/5112#heading--how-to-suppress-failed-results) |How to suppress |
| [failures](/t/about-machines/5080#heading--about-debugging-script-failures) |About debugging script |
| [failures](/t/how-to-deploy-machines/5112#heading--how-to-debug-script-failures) |How to debug script |
| [filter script results](/t/how-to-deploy-machines/5112#heading--how-to-filter-script-results) |How to |
| [final storage modifications](/t/about-customising-machines/5976#heading--final-storage-modifications) |About |
| [final storage modifications](/t/about-machines/5080#heading--final-storage-modifications) |About |
| [find a machine's event logs](/t/how-to-manage-machines/5160#heading--event-logs) |How to |
| [find a VM host ID](/t/how-to-manage-vms/5148#heading--find-vm-host-ids) |How to |
| [find commissioning logs](/t/how-to-manage-machines/5160#heading--commissioning-log) |How to |
| [find machine configuration info](/t/how-to-manage-machines/5160#heading--machine-config) |How to |
| [find machine hardware & test logs](/t/how-to-manage-machines/5160#heading--hardware-tests) |How to |
| [find machine storage info](/t/how-to-manage-machines/5160#heading--how-to-find-machine-storage-info) |How to |
| [find network info for a machine](/t/how-to-manage-machines/5160#heading--machine-interfaces) |How to |
| [find raw log output for a machine](/t/how-to-manage-machines/5160#heading--raw-log-output) |How to |
| [Flat layout storage reference](/t/how-to-manage-machines/5160#heading--flat-storage-layout-reference) | |
| [format a block device](/t/how-to-manage-machines/5160#heading--format-block-device) |How to |
| [format a partition](/t/how-to-manage-machines/5160#heading--how-to-format-a-partition) |How to |
| [general availability kernels](/t/about-customising-machines/5976#heading--general-availability-kernels) |About |
| [get a summary of LXD project resources](/t/how-to-use-lxd/5208#heading--projects-s1-resource) |How to |
| [global kernel boot options](/t/how-to-customise-machines/5108#heading--how-to-set-global-kernel-boot-options) |How to set |
| [global storage layouts](/t/how-to-manage-machines/5160#heading--how-to-set-global-storage-layouts) |How to set |
| [group commissioning and testing scripts](/t/how-to-deploy-machines/5112#heading--tags-group-scripts) |How to use tags to |
| [Handling attached USB and PCI devices](/t/about-machines/5080#heading--usb-pci-devices) | |
| [hardware enablement kernels](/t/about-customising-machines/5976#heading--hardware-enablement-kernels) |About |
| [hardware enablement kernels](/t/about-customising-machines/5976#heading--hardware-enablement-kernels-pre-release) |About pre-release |
| [hardware information for a deployed machine](/t/how-to-deploy-machines/5112#heading--update-deployed-hw-info) |How to update |
| [hardware sync interval](/t/how-to-customise-machines/5108#heading--how-to-configure-hardware-sync-interval) |How to configure |
| [hardware sync on a machine](/t/how-to-customise-machines/5108#heading--how-to-enable-hardware-sync-on-a-machine) |How to enable |
| [hardware sync](/t/about-customising-machines/5976#heading--about-hardware-sync) |About |
| [hardware sync](/t/how-to-customise-machines/5108#heading--how-to-view-updates-from-hardware-sync) |How to view updates from |
| [hardware](/t/about-customising-machines/5976#heading--about-updating-hardware) |About updating |
| [hardware](/t/about-machines/5080#heading--about-testing-hardware) |About testing |
| [hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-list-all-uploaded-hardware-testing-scripts) |How to list all uploaded |
| [hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-revert-hardware-testing-scripts) |How to revert |
| [hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-update-hardware-testing-scripts) |How to update |
| [hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-upload-hardware-testing-scripts) |How to upload |
| [hardware & test logs](/t/about-machines/5080#heading--hardware-tests) |About machine |
| [hardware & test logs](/t/how-to-manage-machines/5160#heading--hardware-tests) |How to find machine |
| [hardware test scripts](/t/how-to-deploy-machines/5112#heading--upload-test-scripts) |How to upload |
| [hardware test](/t/how-to-deploy-machines/5112#heading--apply-a-hardware-test) |How to apply a |
| [hardware type](/t/about-machines/5080#heading--about-automatic-script-selection-by-hardware-type) |About automatic script selection by |
| [hide them from MAAS](/t/how-to-use-lxd/5208#heading--projects-s2-move-non-maas-items) |How to move LXD entities to another project to |
| [host authentication](/t/about-vm-hosting/5068#heading--about-lxd-vm-host-auth) |About LXD VM |
| [host bridge with libvirt](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-libvirt) |How to set up a VM |
| [host bridge with netplan](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-netplan) |How to set up a VM |
| [host bridge with the web UI](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-web-ui) |How to set up a VM |
| [host from a resource pool](/t/how-to-customise-machines/5108#heading--removing-a-vm-host-from-a-resource-pool) |How to remove a VM |
| [host from a resource pool](/t/how-to-manage-machines/5160#heading--removing-a-vm-host-from-a-resource-pool) |How to remove a VM |
| [host ID](/t/how-to-manage-vms/5148#heading--find-vm-host-ids) |How to find a VM |
| [hosting](/t/how-to-use-lxd/5208#heading--lxd-setup) |How to make LXD available for VM |
| [host parameters](/t/how-to-manage-vm-hosts/5140#heading--list-config-params) |How to list configurable VM |
| [host project summaries](/t/about-vm-hosting/5068#heading--vm-host-project-summary) |About LXD VM |
| [host resource details](/t/about-vm-hosting/5068#heading--vm-host-resource-details) |About LXD VM |
| [host's configuration](/t/how-to-manage-vm-hosts/5140#heading--update-vm-host-configuration) |How to update a VM |
| [host's connection parameters](/t/how-to-manage-vm-hosts/5140#heading--list-vm-host-connection-parameters) |How to list a VM |
| [host settings](/t/about-vm-hosting/5068#heading--configuration) |About VM |
| [host's name](/t/how-to-manage-vm-hosts/5140#heading--change-vm-host-name) |How to change a VM |
| [host's pool](/t/how-to-manage-vm-hosts/5140#heading--change-vm-host-pool) |How to change a VM |
| [hosts](/t/about-vm-hosting/5068#heading--about-lxd-vm-hosts) |About LXD VM |
| [hosts](/t/about-vm-hosting/5068#heading--about-vm-hosts) |About VM |
| [hosts](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-all-vm-hosts) |How to list the resources of all VM |
| [host storage pools](/t/about-vm-hosting/5068#heading--about-vm-host-storage-pools) |About VM |
| [host](/t/how-to-manage-controllers/5172#heading--adding-a-new-region-host) |How to add a new region |
| [host](/t/how-to-manage-vm-hosts/5140#heading--adding-a-vm-host) |How to add a VM |
| [host](/t/how-to-manage-vm-hosts/5140#heading--configuration) |How to configure a VM |
| [host](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-a-vm-host) |How to list the resources of a single VM |
| [host](/t/how-to-use-lxd/5208#heading--projects-s2-create-vm-in-vm-host-project) |How to create a new VM in the LXD project associated with a VM |
| [host](/t/how-to-use-lxd/5208#heading--projects-s2-create-with-vm-host) |How to create a new project for MAAS when instantiating a VM |
| [host](/t/how-to-use-lxd/5208#heading--projects-s2-delete-vm-host) |How to delete the VM |
| [host](/t/how-to-use-lxd/5208#heading--projects-s2-move-vm-into-vm-host-project) |How to move an existing VM into the LXD project associated with a VM |
| [host to a resource pool](/t/how-to-customise-machines/5108#heading--add-a-vm-host-to-a-resource-pool) |How to add a VM |
| [host to a resource pool](/t/how-to-manage-machines/5160#heading--add-a-vm-host-to-a-resource-pool) |How to add a VM |
| [How machines communicate with the rack controller](/t/about-controllers/5072#heading--machinerack) | |
| [How region and rack controllers communicate](/t/about-controllers/5072#heading--rackregion) | |
| [How to add a machine manually](/t/how-to-manage-machines/5160#heading--how-to-add-a-machine-manually) | |
| [How to add a machine to a resource pool](/t/how-to-customise-machines/5108#heading--add-a-machine-to-a-resource-pool) | |
| [How to add a machine to a resource pool](/t/how-to-customise-machines/5108#heading--add-a-node-to-a-resource-pool) | |
| [How to add a machine to a resource pool](/t/how-to-manage-machines/5160#heading--add-a-machine-to-a-resource-pool) | |
| [How to add a machine to a resource pool](/t/how-to-manage-machines/5160#heading--add-a-node-to-a-resource-pool) | |
| [How to add a new region host](/t/how-to-manage-controllers/5172#heading--adding-a-new-region-host) | |
| [How to add a resource pool](/t/how-to-customise-machines/5108#heading--add-a-resource-pool) | |
| [How to add a resource pool](/t/how-to-manage-machines/5160#heading--add-a-resource-pool) | |
| [How to add a VM host](/t/how-to-manage-vm-hosts/5140#heading--adding-a-vm-host) | |
| [How to add a VM host to a resource pool](/t/how-to-customise-machines/5108#heading--add-a-vm-host-to-a-resource-pool) | |
| [How to add a VM host to a resource pool](/t/how-to-manage-machines/5160#heading--add-a-vm-host-to-a-resource-pool) | |
| [How to add a VM](/t/how-to-manage-vms/5148#heading--adding-a-vm-from-the-cli) | |
| [How to add a VM](/t/how-to-manage-vms/5148#heading--add-vm-from-ui) | |
| [How to add LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-add-lxd-clusters) | |
| [How to add machines via a chassis](/t/how-to-manage-machines/5160#heading--how-to-add-machines-via-a-chassis) | |
| [How to allocate machines](/t/how-to-deploy-machines/5112#heading--allocate-machines) | |
| [How to apply a hardware test](/t/how-to-deploy-machines/5112#heading--apply-a-hardware-test) | |
| [How to change a VM host's name](/t/how-to-manage-vm-hosts/5140#heading--change-vm-host-name) | |
| [How to change a VM host's pool](/t/how-to-manage-vm-hosts/5140#heading--change-vm-host-pool) | |
| [How to change or clear a static annotation for a machine](/t/how-to-manage-machines/5160#heading--change-or-clear-a-static-annotation-for-a-machine) | |
| [How to choose Ubuntu kernels](/t/how-to-customise-machines/5108#heading--how-to-choose-ubuntu-kernels) | |
| [How to clear and change dynamic annotations for a machine](/t/how-to-manage-machines/5160#heading--clear-and-change-dynamic-annotations-for-a-machine) | |
| [How to clone machines](/t/how-to-manage-machines/5160#heading--how-to-clone-machines) | |
| [How to commission a machine](/t/how-to-deploy-machines/5112#heading--how-to-commission-a-machine) | |
| [How to compose VMs in LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-compose-vms-in-lxd-clusters) | |
| [How to configure a VM host](/t/how-to-manage-vm-hosts/5140#heading--configuration) | |
| [How to configure hardware sync interval](/t/how-to-customise-machines/5108#heading--how-to-configure-hardware-sync-interval) | |
| [How to configure network validation and testing scripts](/t/how-to-deploy-machines/5112#heading--network-validation-scripts-and-testing) | |
| [How to create a block device](/t/how-to-customise-machines/5108#heading--how-to-create-a-block-device) | |
| [How to create a block device](/t/how-to-manage-machines/5160#heading--how-to-create-a-block-device) | |
| [How to create a LXD project](/t/how-to-use-lxd/5208#heading--projects-s1-create) | |
| [How to create a new project for MAAS when instantiating a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-with-vm-host) | |
| [How to create a new VM in the LXD project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-vm-in-vm-host-project) | |
| [How to create a partition](/t/how-to-customise-machines/5108#heading--how-to-create-a-partition) | |
| [How to create a partition](/t/how-to-manage-machines/5160#heading--how-to-create-a-partition) | |
| [How to create a resource pool](/t/how-to-customise-machines/5108#heading--creating-a-resource-pool) | |
| [How to create a resource pool](/t/how-to-manage-machines/5160#heading--creating-a-resource-pool) | |
| [How to create a VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-create-a-vmfs-datastore) | |
| [How to create a VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-create-a-vmfs-datastore) | |
| [How to create, delete, and configure machines](/t/how-to-manage-machines/5160#heading--how-to-create-delete-and-configure-machines) | |
| [How to create tags with built-in kernel options](/t/how-to-customise-machines/5108#heading--create-tags-with-built-in-kernel-options) | |
| [How to customise machine storage](/t/how-to-customise-machines/5108#heading--how-to-customise-machine-storage) | |
| [How to customise network testing](/t/how-to-deploy-machines/5112#heading--customisable-network-testing) | |
| [How to debug script failures](/t/how-to-deploy-machines/5112#heading--how-to-debug-script-failures) | |
| [How to define custom storage layouts](/t/how-to-manage-machines/5160#heading--how-to-define-custom-storage-layouts) | |
| [How to delete a block device](/t/how-to-customise-machines/5108#heading--how-to-delete-a-block-device) | |
| [How to delete a block device](/t/how-to-manage-machines/5160#heading--how-to-delete-a-block-device) | |
| [How to delete a LXD project](/t/how-to-use-lxd/5208#heading--projects-s1-delete) | |
| [How to delete a partition](/t/how-to-customise-machines/5108#heading--how-to-delete-a-partition) | |
| [How to delete a partition](/t/how-to-manage-machines/5160#heading--how-to-delete-a-partition) | |
| [How to delete a resource pool](/t/how-to-customise-machines/5108#heading--delete-a-resource-pool) | |
| [How to delete a resource pool](/t/how-to-customise-machines/5108#heading--deleting-a-resource-pool) | |
| [How to delete a resource pool](/t/how-to-manage-machines/5160#heading--delete-a-resource-pool) | |
| [How to delete a resource pool](/t/how-to-manage-machines/5160#heading--deleting-a-resource-pool) | |
| [How to delete a script](/t/how-to-deploy-machines/5112#heading--how-to-delete-a-script) | |
| [How to delete a VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-delete-a-vmfs-datastore) | |
| [How to delete a VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-delete-a-vmfs-datastore) | |
| [How to delete a VM](/t/how-to-manage-vms/5148#heading--delete-a-machine) | |
| [How to delete a VM](/t/how-to-manage-vms/5148#heading--delete-a-vm) | |
| [How to delete LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-delete-lxd-clusters) | |
| [How to delete the VM host](/t/how-to-use-lxd/5208#heading--projects-s2-delete-vm-host) | |
| [How to deploy machines](/t/how-to-deploy-machines/5112#heading--deploy) | |
| [How to detect slow network links](/t/how-to-deploy-machines/5112#heading--slow-link-detection) | |
| [How to download a script](/t/how-to-deploy-machines/5112#heading--how-to-download-a-script) | |
| [How to download built-in scripts](/t/how-to-deploy-machines/5112#heading--how-to-download-built-in-scripts) | |
| [How to edit a VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-edit-a-vmfs-datastore) | |
| [How to edit a VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-edit-a-vmfs-datastore) | |
| [How to enable hardware sync on a machine](/t/how-to-customise-machines/5108#heading--how-to-enable-hardware-sync-on-a-machine) | |
| [How to enlist a machine that’s already running a workload](/t/how-to-deploy-machines/5112#heading--enlisted-deployed-machines) | |
| [How to erase disks](/t/how-to-customise-machines/5108#heading--how-to-erase-disks) | |
| [How to erase disks](/t/how-to-manage-machines/5160#heading--how-to-erase-disks) | |
| [How to examine machines and machine details](/t/how-to-manage-machines/5160#heading--how-to-examine-machines-and-machine-details) | |
| [How to filter script results](/t/how-to-deploy-machines/5112#heading--how-to-filter-script-results) | |
| [How to find a machine's event logs](/t/how-to-manage-machines/5160#heading--event-logs) | |
| [How to find a VM host ID](/t/how-to-manage-vms/5148#heading--find-vm-host-ids) | |
| [How to find commissioning logs](/t/how-to-manage-machines/5160#heading--commissioning-log) | |
| [How to find machine configuration info](/t/how-to-manage-machines/5160#heading--machine-config) | |
| [How to find machine hardware & test logs](/t/how-to-manage-machines/5160#heading--hardware-tests) | |
| [How to find machine storage info](/t/how-to-manage-machines/5160#heading--how-to-find-machine-storage-info) | |
| [How to find network info for a machine](/t/how-to-manage-machines/5160#heading--machine-interfaces) | |
| [How to find raw log output for a machine](/t/how-to-manage-machines/5160#heading--raw-log-output) | |
| [How to format a block device](/t/how-to-customise-machines/5108#heading--format-block-device) | |
| [How to format a block device](/t/how-to-manage-machines/5160#heading--format-block-device) | |
| [How to format a partition](/t/how-to-customise-machines/5108#heading--how-to-format-a-partition) | |
| [How to format a partition](/t/how-to-manage-machines/5160#heading--how-to-format-a-partition) | |
| [How to get a summary of LXD project resources](/t/how-to-use-lxd/5208#heading--projects-s1-resource) | |
| [How to identify machines that can receive dynamic annotations](/t/how-to-manage-machines/5160#heading--identify-machines-that-can-receive-dynamic-annotations) | |
| [How to identify your machines](/t/how-to-manage-machines/5160#heading--identify-your-machines) | |
| [How to improve region controller performance](/t/how-to-manage-controllers/5172#heading--increasing-regiond-daemon-workers) | |
| [How to initialise LXD prior to use](/t/how-to-use-lxd/5208#heading--lxd-init) | |
| [How to install a rack controller](/t/how-to-manage-controllers/5172#heading--install-a-rack-controller) | |
| [How to list all uploaded hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-list-all-uploaded-hardware-testing-scripts) | |
| [How to list a single resource pool](/t/how-to-customise-machines/5108#heading--list-a-single-resource-pool) | |
| [How to list a single resource pool](/t/how-to-manage-machines/5160#heading--list-a-single-resource-pool) | |
| [How to list available resource pools](/t/how-to-customise-machines/5108#heading--list-available-resource-pools) | |
| [How to list available resource pools](/t/how-to-manage-machines/5160#heading--list-available-resource-pools) | |
| [How to list a VM host's connection parameters](/t/how-to-manage-vm-hosts/5140#heading--list-vm-host-connection-parameters) | |
| [How to list block devices](/t/how-to-customise-machines/5108#heading--how-to-list-block-devices) | |
| [How to list block devices](/t/how-to-manage-machines/5160#heading--how-to-list-block-devices) | |
| [How to list configurable VM host parameters](/t/how-to-manage-vm-hosts/5140#heading--list-config-params) | |
| [How to list dynamic allocations for one machine](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-one-machine) | |
| [How to list dynamic annotations for all machines](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-all-machines) | |
| [How to list LXD projects](/t/how-to-use-lxd/5208#heading--projects-s1-list) | |
| [How to list partitions](/t/how-to-customise-machines/5108#heading--how-to-list-partitions) | |
| [How to list partitions](/t/how-to-manage-machines/5160#heading--how-to-list-partitions) | |
| [How to list rack controllers](/t/how-to-manage-controllers/5172#heading--list-rack-controllers) | |
| [How to list static annotations for all machines](/t/how-to-manage-machines/5160#heading--list-static-annotations-for-all-machines) | |
| [How to list the resources of all VM hosts](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-all-vm-hosts) | |
| [How to list the resources of a single VM host](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-a-vm-host) | |
| [How to list VMFS datastores](/t/how-to-customise-machines/5108#heading--how-to-list-vmfs-datastores) | |
| [How to list VMFS datastores](/t/how-to-manage-machines/5160#heading--how-to-list-vmfs-datastores) | |
| [How to list VM-hosts](/t/how-to-manage-vm-hosts/5140#heading--list-vm-hosts) | |
| [How to locate log files](/t/how-to-deploy-machines/5112#heading--how-to-locate-log-files) | |
| [How to locate script files](/t/how-to-deploy-machines/5112#heading--how-to-locate-script-files) | |
| [How to make LXD available for VM hosting](/t/how-to-use-lxd/5208#heading--lxd-setup) | |
| [How to manage attached USB and PCI devices](/t/how-to-manage-machines/5160#heading--usb-pci-devices) | |
| [How to manage block devices](/t/how-to-manage-machines/5160#heading--how-to-manage-block-devices) | |
| [How to manage partitions](/t/how-to-manage-machines/5160#heading--how-to-manage-partitions) | |
| [How to manage VMFS datastores](/t/how-to-manage-machines/5160#heading--how-to-manage-vmfs-datastores) | |
| [How to mount a block device](/t/how-to-customise-machines/5108#heading--how-to-mount-a-block-device) | |
| [How to mount a block device](/t/how-to-manage-machines/5160#heading--how-to-mount-a-block-device) | |
| [How to mount a partition](/t/how-to-customise-machines/5108#heading--how-to-mount-a-partition) | |
| [How to mount a partition](/t/how-to-manage-machines/5160#heading--how-to-mount-a-partition) | |
| [How to move an existing VM into the LXD project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-move-vm-into-vm-host-project) | |
| [How to move a rack controller from one MAAS instance to another](/t/how-to-manage-controllers/5172#heading--move-rack-controller) | |
| [How to move LXD entities to another project to hide them from MAAS](/t/how-to-use-lxd/5208#heading--projects-s2-move-non-maas-items) | |
| [How to pre-seed with cloud-init](/t/how-to-customise-machines/5108#heading--cloud-init) | |
| [How to pre-seed with curtin](/t/how-to-customise-machines/5108#heading--how-to-pre-seed-with-curtin) | |
| [How to read a block device](/t/how-to-customise-machines/5108#heading--how-to-read-a-block-device) | |
| [How to read a block device](/t/how-to-manage-machines/5160#heading--how-to-read-a-block-device) | |
| [How to refresh LXD on 20.04](/t/how-to-use-lxd/5208#heading--newer-lxd) | |
| [How to remove a machine from a resource pool](/t/how-to-customise-machines/5108#heading--removing-a-node-from-a-resource-pool) | |
| [How to remove a machine from a resource pool](/t/how-to-manage-machines/5160#heading--removing-a-node-from-a-resource-pool) | |
| [How to remove a VM host from a resource pool](/t/how-to-customise-machines/5108#heading--removing-a-vm-host-from-a-resource-pool) | |
| [How to remove a VM host from a resource pool](/t/how-to-manage-machines/5160#heading--removing-a-vm-host-from-a-resource-pool) | |
| [How to remove older versions of LXD](/t/how-to-use-lxd/5208#heading--reinstalling-lxd) | |
| [How to rename a LXD project](/t/how-to-use-lxd/5208#heading--projects-s1-rename) | |
| [How to revert hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-revert-hardware-testing-scripts) | |
| [How to run all scripts manually](/t/how-to-deploy-machines/5112#heading--how-to-run-all-scripts-manually) | |
| [How to set a block device as a boot disk](/t/how-to-customise-machines/5108#heading--how-to-set-a-block-device-as-a-boot-disk) | |
| [How to set a block device as a boot disk](/t/how-to-manage-machines/5160#heading--how-to-set-a-block-device-as-a-boot-disk) | |
| [How to set a default minimum kernel for enlistment and commissioning](/t/how-to-customise-machines/5108#heading--set-a-default-minimum-kernel-for-enlistment-and-commissioning) | |
| [How to set a minimum deployment kernel for a machine](/t/how-to-customise-machines/5108#heading--set-a-minimum-deploy-kernel-for-a-machine) | |
| [How to set a specific kernel during machine deployment](/t/how-to-customise-machines/5108#heading--set-a-specific-kernel-during-machine-deployment) | |
| [How to set a static annotation for a machine](/t/how-to-manage-machines/5160#heading--set-a-static-annotation-for-a-machine) | |
| [How to set dynamic annotations for a machine](/t/how-to-manage-machines/5160#heading--set-dynamic-annotations-for-a-machine) | |
| [How to set global kernel boot options](/t/how-to-customise-machines/5108#heading--how-to-set-global-kernel-boot-options) | |
| [How to set global storage layouts](/t/how-to-customise-machines/5108#heading--how-to-set-global-storage-layouts) | |
| [How to set global storage layouts](/t/how-to-manage-machines/5160#heading--how-to-set-global-storage-layouts) | |
| [How to set per-machine storage layouts](/t/how-to-customise-machines/5108#heading--how-to-set-per-machine-storage-layouts) | |
| [How to set per-machine storage layouts](/t/how-to-manage-machines/5160#heading--how-to-set-per-machine-storage-layouts) | |
| [How to set resources while adding a VM](/t/how-to-manage-vms/5148#heading--set-resources) | |
| [How to set storage parameters while adding a VM](/t/how-to-manage-vms/5148#heading--storage) | |
| [How to set the architecture while adding a VM](/t/how-to-manage-vms/5148#heading--architecture) | |
| [How to set the default erasure configuration](/t/how-to-customise-machines/5108#heading--how-to-set-default-erasure-configuration) | |
| [How to set the default erasure configuration](/t/how-to-manage-machines/5160#heading--how-to-set-default-erasure-configuration) | |
| [How to set up a VM host bridge with libvirt](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-libvirt) | |
| [How to set up a VM host bridge with netplan](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-netplan) | |
| [How to set up a VM host bridge with the web UI](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-web-ui) | |
| [How to set up PostgreSQL for the region](/t/how-to-manage-controllers/5172#heading--postgresql-setup) | |
| [How to set up SSH for use by libvirt](/t/how-to-manage-vm-hosts/5140#heading--set-up-ssh) | |
| [How to set up SSH (libvirt only)](/t/how-to-manage-vm-hosts/5140#heading--libvirt-ssh) | |
| [How to set up SSH (libvirt only)](/t/how-to-manage-vm-hosts/5140#heading--set-up-ssah-lv) | |
| [How to show LXD project options](/t/how-to-use-lxd/5208#heading--projects-s1-optionste) | |
| [How to specify conditional erasure types](/t/how-to-customise-machines/5108#heading--how-to-specify-conditional-erasure-types) | |
| [How to specify conditional erasure types](/t/how-to-manage-machines/5160#heading--how-to-specify-conditional-erasure-types) | |
| [How to specify interfaces while adding a VM](/t/how-to-manage-vms/5148#heading--interfaces) | |
| [How to suppress failed results](/t/how-to-deploy-machines/5112#heading--how-to-suppress-failed-results) | |
| [How to switch between LXD projects](/t/how-to-use-lxd/5208#heading--projects-s1-switch) | |
| [How to test machines](/t/how-to-deploy-machines/5112#heading--how-to-test-machines) | |
| [How to test network links](/t/how-to-deploy-machines/5112#heading--network-link-testing) | |
| [How to unformat a block device](/t/how-to-customise-machines/5108#heading--how-to-unformat-a-block-device) | |
| [How to unformat a block device](/t/how-to-manage-machines/5160#heading--how-to-unformat-a-block-device) | |
| [How to unformat a partition](/t/how-to-customise-machines/5108#heading--how-to-unformat-a-partition) | |
| [How to unformat a partition](/t/how-to-manage-machines/5160#heading--how-to-unformat-a-partition) | |
| [How to unmount a block device](/t/how-to-customise-machines/5108#heading--how-to-unmount-a-block-device) | |
| [How to unmount a block device](/t/how-to-manage-machines/5160#heading--how-to-unmount-a-block-device) | |
| [How to unmount a partition](/t/how-to-customise-machines/5108#heading--how-to-unmount-a-partition) | |
| [How to unmount a partition](/t/how-to-manage-machines/5160#heading--how-to-unmount-a-partition) | |
| [How to unregister a rack controller](/t/how-to-manage-controllers/5172#heading--unregister-a-rack-controller) | |
| [How to update a block device](/t/how-to-customise-machines/5108#heading--how-to-update-a-block-device) | |
| [How to update a block device](/t/how-to-manage-machines/5160#heading--how-to-update-a-block-device) | |
| [How to update a resource pool](/t/how-to-customise-machines/5108#heading--update-a-resource-pool) | |
| [How to update a resource pool](/t/how-to-manage-machines/5160#heading--update-a-resource-pool) | |
| [How to update a VM host's configuration](/t/how-to-manage-vm-hosts/5140#heading--update-vm-host-configuration) | |
| [How to update hardware information for a deployed machine](/t/how-to-deploy-machines/5112#heading--update-deployed-hw-info) | |
| [How to update hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-update-hardware-testing-scripts) | |
| [How to upload hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-upload-hardware-testing-scripts) | |
| [How to upload hardware test scripts](/t/how-to-deploy-machines/5112#heading--upload-test-scripts) | |
| [How to upload scripts](/t/how-to-deploy-machines/5112#heading--how-to-upload-scripts) | |
| [How to use annotations](/t/how-to-manage-machines/5160#heading--how-to-use-annotations) | |
| [How to use dynamic (workload) annotations](/t/how-to-manage-machines/5160#heading--work-with-dynamic-workload-annotations) | |
| [How to use LXD projects with MAAS](/t/how-to-use-lxd/5208#heading--projects-step-2-lxd-and-maas) | |
| [How to use machine storage](/t/how-to-manage-machines/5160#heading--how-to-use-machine-storage) | |
| [How to use resource pools](/t/how-to-customise-machines/5108#heading--how-to-use-resource-pools) | |
| [How to use resource pools](/t/how-to-manage-machines/5160#heading--how-to-use-resource-pools) | |
| [How to use static annotations](/t/how-to-manage-machines/5160#heading--work-with-static-annotations) | |
| [How to use tags to group commissioning and testing scripts](/t/how-to-deploy-machines/5112#heading--tags-group-scripts) | |
| [How to use the MAAS API to configure a bridge](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-cli) | |
| [How to view a static annotation for one machine](/t/how-to-manage-machines/5160#heading--view-a-static-annotation-for-one-machine) | |
| [How to view a VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-view-a-vmfs-datastore) | |
| [How to view a VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-view-a-vmfs-datastore) | |
| [How to view machine details](/t/how-to-manage-machines/5160#heading--how-to-view-machine-details) | |
| [How to view script results](/t/how-to-deploy-machines/5112#heading--how-to-view-script-results) | |
| [How to view testing results](/t/how-to-deploy-machines/5112#heading--results) | |
| [How to view the machine list](/t/how-to-manage-machines/5160#heading--how-to-view-the-machine-list) | |
| [How to view updates from hardware sync](/t/how-to-customise-machines/5108#heading--how-to-view-updates-from-hardware-sync) | |
| [hugepages](/t/about-vm-hosting/5068#heading--about-support-for-numa-et-al) |About support for NUMA, SR-IOV, and |
| [identify machines that can receive dynamic annotations](/t/how-to-manage-machines/5160#heading--identify-machines-that-can-receive-dynamic-annotations) |How to |
| [identify your machines](/t/how-to-manage-machines/5160#heading--identify-your-machines) |How to |
| [ID](/t/how-to-manage-vms/5148#heading--find-vm-host-ids) |How to find a VM host |
| [improve region controller performance](/t/how-to-manage-controllers/5172#heading--increasing-regiond-daemon-workers) |How to |
| [individual boot methods](/t/about-machines/5080#heading--about-disabling-individual-boot-methods) |About disabling |
| [information for a deployed machine](/t/how-to-deploy-machines/5112#heading--update-deployed-hw-info) |How to update hardware |
| [initialise LXD prior to use](/t/how-to-use-lxd/5208#heading--lxd-init) |How to |
| [install a rack controller](/t/how-to-manage-controllers/5172#heading--install-a-rack-controller) |How to |
| [instantiating a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-with-vm-host) |How to create a new project for MAAS when |
| [kernel boot options](/t/about-customising-machines/5976#heading--about-kernel-boot-options) |About |
| [kernel boot options](/t/how-to-customise-machines/5108#heading--how-to-set-global-kernel-boot-options) |How to set global |
| [kernel during machine deployment](/t/how-to-customise-machines/5108#heading--set-a-specific-kernel-during-machine-deployment) |How to set a specific |
| [kernel for a machine](/t/how-to-customise-machines/5108#heading--set-a-minimum-deploy-kernel-for-a-machine) |How to set a minimum deployment |
| [kernel for enlistment and commissioning](/t/how-to-customise-machines/5108#heading--set-a-default-minimum-kernel-for-enlistment-and-commissioning) |How to set a default minimum |
| [kernel options](/t/how-to-customise-machines/5108#heading--create-tags-with-built-in-kernel-options) |How to create tags with built-in |
| [kernels](/t/about-customising-machines/5976#heading--about-ubuntu-kernels) |About Ubuntu |
| [kernels](/t/about-customising-machines/5976#heading--general-availability-kernels) |About general availability |
| [kernels](/t/about-customising-machines/5976#heading--hardware-enablement-kernels) |About hardware enablement |
| [kernels](/t/about-customising-machines/5976#heading--hardware-enablement-kernels-pre-release) |About pre-release hardware enablement |
| [kernels](/t/about-customising-machines/5976#heading--low-latency-kernels) |About low latency |
| [kernels](/t/how-to-customise-machines/5108#heading--how-to-choose-ubuntu-kernels) |How to choose Ubuntu |
| [kernel](/t/about-customising-machines/5976#heading--using-kernels) |About choosing a |
| [latency kernels](/t/about-customising-machines/5976#heading--low-latency-kernels) |About low |
| [libvirt](/t/about-vm-hosting/5068#heading--about-lxd-vs-libvirt) |About LXD (Beta) vs. |
| [libvirt](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-libvirt) |How to set up a VM host bridge with |
| [libvirt](/t/how-to-manage-vm-hosts/5140#heading--set-up-ssh) |How to set up SSH for use by |
| [life-cycle](/t/about-machines/5080#heading--about-the-machine-life-cycle) |About the machine |
| [links](/t/how-to-deploy-machines/5112#heading--network-link-testing) |How to test network |
| [links](/t/how-to-deploy-machines/5112#heading--slow-link-detection) |How to detect slow network |
| [list all uploaded hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-list-all-uploaded-hardware-testing-scripts) |How to |
| [list a single resource pool](/t/how-to-customise-machines/5108#heading--list-a-single-resource-pool) |How to |
| [list a single resource pool](/t/how-to-manage-machines/5160#heading--list-a-single-resource-pool) |How to |
| [list available resource pools](/t/how-to-customise-machines/5108#heading--list-available-resource-pools) |How to |
| [list available resource pools](/t/how-to-manage-machines/5160#heading--list-available-resource-pools) |How to |
| [list a VM host's connection parameters](/t/how-to-manage-vm-hosts/5140#heading--list-vm-host-connection-parameters) |How to |
| [list block devices](/t/how-to-customise-machines/5108#heading--how-to-list-block-devices) |How to |
| [list block devices](/t/how-to-manage-machines/5160#heading--how-to-list-block-devices) |How to |
| [list configurable VM host parameters](/t/how-to-manage-vm-hosts/5140#heading--list-config-params) |How to |
| [list dynamic allocations for one machine](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-one-machine) |How to |
| [list dynamic annotations for all machines](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-all-machines) |How to |
| [list LXD projects](/t/how-to-use-lxd/5208#heading--projects-s1-list) |How to |
| [list partitions](/t/how-to-customise-machines/5108#heading--how-to-list-partitions) |How to |
| [list partitions](/t/how-to-manage-machines/5160#heading--how-to-list-partitions) |How to |
| [list rack controllers](/t/how-to-manage-controllers/5172#heading--list-rack-controllers) |How to |
| [list static annotations for all machines](/t/how-to-manage-machines/5160#heading--list-static-annotations-for-all-machines) |How to |
| [list](/t/about-machines/5080#heading--about-the-machine-list) |About the machine |
| [list the resources of all VM hosts](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-all-vm-hosts) |How to |
| [list the resources of a single VM host](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-a-vm-host) |How to |
| [list](/t/how-to-manage-machines/5160#heading--how-to-view-the-machine-list) |How to view the machine |
| [list VMFS datastores](/t/how-to-customise-machines/5108#heading--how-to-list-vmfs-datastores) |How to |
| [list VMFS datastores](/t/how-to-manage-machines/5160#heading--how-to-list-vmfs-datastores) |How to |
| [list VM-hosts](/t/how-to-manage-vm-hosts/5140#heading--list-vm-hosts) |How to |
| [locate log files](/t/how-to-deploy-machines/5112#heading--how-to-locate-log-files) |How to |
| [locate script files](/t/how-to-deploy-machines/5112#heading--how-to-locate-script-files) |How to |
| [log files](/t/how-to-deploy-machines/5112#heading--how-to-locate-log-files) |How to locate |
| [log output for a machine](/t/how-to-manage-machines/5160#heading--raw-log-output) |How to find raw |
| [logs](/t/about-machines/5080#heading--commissioning-log) |About machine commissioning |
| [logs](/t/about-machines/5080#heading--event-logs) |About machine event |
| [logs](/t/about-machines/5080#heading--hardware-tests) |About machine hardware & test |
| [logs](/t/how-to-manage-machines/5160#heading--commissioning-log) |How to find commissioning |
| [logs](/t/how-to-manage-machines/5160#heading--event-logs) |How to find a machine's event |
| [logs](/t/how-to-manage-machines/5160#heading--hardware-tests) |How to find machine hardware & test |
| [low latency kernels](/t/about-customising-machines/5976#heading--low-latency-kernels) |About |
| [LVM storage layout reference](/t/how-to-manage-machines/5160#heading--lvm-storage-layout-reference) | |
| [LXD available for VM hosting](/t/how-to-use-lxd/5208#heading--lxd-setup) |How to make |
| [LXD (Beta) vs. libvirt](/t/about-vm-hosting/5068#heading--about-lxd-vs-libvirt) |About |
| [LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--about-lxd-clusters) |About |
| [LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-add-lxd-clusters) |How to add |
| [LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-compose-vms-in-lxd-clusters) |How to compose VMs in |
| [LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-delete-lxd-clusters) |How to delete |
| [LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--lxd-clusters) | |
| [LXD entities to another project to hide them from MAAS](/t/how-to-use-lxd/5208#heading--projects-s2-move-non-maas-items) |How to move |
| [LXD on 20.04](/t/how-to-use-lxd/5208#heading--newer-lxd) |How to refresh |
| [LXD prior to use](/t/how-to-use-lxd/5208#heading--lxd-init) |How to initialise |
| [LXD project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-vm-in-vm-host-project) |How to create a new VM in the |
| [LXD project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-move-vm-into-vm-host-project) |How to move an existing VM into the |
| [LXD project options](/t/how-to-use-lxd/5208#heading--projects-s1-optionste) |How to show |
| [LXD project resources](/t/how-to-use-lxd/5208#heading--projects-s1-resource) |How to get a summary of |
| [LXD projects and MAAS](/t/how-to-use-lxd/5208#heading--projects-explanation) |About |
| [LXD projects in MAAS](/t/how-to-use-lxd/5208#heading--projects-big-picture) |About alternatives to |
| [LXD projects](/t/how-to-use-lxd/5208#heading--projects-big-picture) |About |
| [LXD projects](/t/how-to-use-lxd/5208#heading--projects-s1-list) |How to list |
| [LXD projects](/t/how-to-use-lxd/5208#heading--projects-s1-switch) |How to switch between |
| [LXD projects with MAAS](/t/how-to-use-lxd/5208#heading--projects-step-2-lxd-and-maas) |How to use |
| [LXD project](/t/how-to-use-lxd/5208#heading--projects-s1-create) |How to create a |
| [LXD project](/t/how-to-use-lxd/5208#heading--projects-s1-delete) |How to delete a |
| [LXD project](/t/how-to-use-lxd/5208#heading--projects-s1-rename) |How to rename a |
| [LXD project tutorial](/t/how-to-use-lxd/5208#heading--projects-tutorial) |An |
| [LXD](/t/how-to-use-lxd/5208#heading--reinstalling-lxd) |How to remove older versions of |
| [LXD VM host authentication](/t/about-vm-hosting/5068#heading--about-lxd-vm-host-auth) |About |
| [LXD VM host project summaries](/t/about-vm-hosting/5068#heading--vm-host-project-summary) |About |
| [LXD VM host resource details](/t/about-vm-hosting/5068#heading--vm-host-resource-details) |About |
| [LXD VM hosts](/t/about-vm-hosting/5068#heading--about-lxd-vm-hosts) |About |
| [MAAS API to configure a bridge](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-cli) |How to use the |
| [MAAS commissioning scripts](/t/about-machines/5080#heading--about-maas-commissioning-scripts) |About |
| [MAAS instance to another](/t/how-to-manage-controllers/5172#heading--about-moving-rack-controller) |About moving a rack controller from one |
| [MAAS instance to another](/t/how-to-manage-controllers/5172#heading--move-rack-controller) |How to move a rack controller from one |
| [MAAS now controls VMs at a project level](/t/how-to-use-lxd/5208#heading--maas-control-at-project-level) | |
| [MAAS](/t/how-to-use-lxd/5208#heading--projects-big-picture) |About alternatives to LXD projects in |
| [MAAS](/t/how-to-use-lxd/5208#heading--projects-explanation) |About LXD projects and |
| [MAAS](/t/how-to-use-lxd/5208#heading--projects-s2-move-non-maas-items) |How to move LXD entities to another project to hide them from |
| [MAAS](/t/how-to-use-lxd/5208#heading--projects-step-2-lxd-and-maas) |How to use LXD projects with |
| [MAAS when instantiating a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-with-vm-host) |How to create a new project for |
| [machine commissioning logs](/t/about-machines/5080#heading--commissioning-log) |About |
| [machine configuration info](/t/about-machines/5080#heading--machine-config) |About |
| [machine configuration info](/t/how-to-manage-machines/5160#heading--machine-config) |How to find |
| [machine deployment](/t/how-to-customise-machines/5108#heading--set-a-specific-kernel-during-machine-deployment) |How to set a specific kernel during |
| [machine details](/t/how-to-manage-machines/5160#heading--how-to-examine-machines-and-machine-details) |How to examine machines and |
| [machine details](/t/how-to-manage-machines/5160#heading--how-to-view-machine-details) |How to view |
| [machine event logs](/t/about-machines/5080#heading--event-logs) |About |
| [machine from a resource pool](/t/how-to-customise-machines/5108#heading--removing-a-node-from-a-resource-pool) |How to remove a |
| [machine from a resource pool](/t/how-to-manage-machines/5160#heading--removing-a-node-from-a-resource-pool) |How to remove a |
| [machine hardware & test logs](/t/about-machines/5080#heading--hardware-tests) |About |
| [machine hardware & test logs](/t/how-to-manage-machines/5160#heading--hardware-tests) |How to find |
| [machine life-cycle](/t/about-machines/5080#heading--about-the-machine-life-cycle) |About the |
| [machine list](/t/about-machines/5080#heading--about-the-machine-list) |About the |
| [machine list](/t/how-to-manage-machines/5160#heading--how-to-view-the-machine-list) |How to view the |
| [machine manually](/t/how-to-manage-machines/5160#heading--how-to-add-a-machine-manually) |How to add a |
| [machine network info](/t/about-machines/5080#heading--about-machine-interfaces) |About |
| [machine networking](/t/about-machines/5080#heading--about-testing-machine-networking) |About testing |
| [machines and machine details](/t/how-to-manage-machines/5160#heading--how-to-examine-machines-and-machine-details) |How to examine |
| [machines communicate with the rack controller](/t/about-controllers/5072#heading--machinerack) |How |
| [machine's event logs](/t/how-to-manage-machines/5160#heading--event-logs) |How to find a |
| [machines prior to deployment](/t/about-customising-machines/5976#heading--about-customising-machines-prior-to-deployment) |About customising |
| [machines](/t/about-customising-machines/5976#heading--about-customising-deployed-machines) |About customising deployed |
| [machines](/t/about-machines/5080#heading--about-adding-machines) |About adding |
| [machines](/t/about-machines/5080#heading--about-cloning-machines) |About cloning |
| [machines](/t/about-machines/5080#heading--about-commissioning-machines) |About commissioning |
| [machines](/t/about-machines/5080#heading--enlisting-deployed-machines) |About enlisting deployed |
| [machine states](/t/about-machines/5080#heading--about-machine-states) |About |
| [machines that can receive dynamic annotations](/t/how-to-manage-machines/5160#heading--identify-machines-that-can-receive-dynamic-annotations) |How to identify |
| [machines](/t/how-to-deploy-machines/5112#heading--allocate-machines) |How to allocate |
| [machines](/t/how-to-deploy-machines/5112#heading--deploy) |How to deploy |
| [machines](/t/how-to-deploy-machines/5112#heading--how-to-test-machines) |How to test |
| [machines](/t/how-to-manage-machines/5160#heading--how-to-clone-machines) |How to clone |
| [machines](/t/how-to-manage-machines/5160#heading--how-to-create-delete-and-configure-machines) |How to create, delete, and configure |
| [machines](/t/how-to-manage-machines/5160#heading--identify-your-machines) |How to identify your |
| [machines](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-all-machines) |How to list dynamic annotations for all |
| [machines](/t/how-to-manage-machines/5160#heading--list-static-annotations-for-all-machines) |How to list static annotations for all |
| [machine storage info](/t/about-machines/5080#heading--machine-storage) |About |
| [machine storage info](/t/how-to-manage-machines/5160#heading--how-to-find-machine-storage-info) |How to find |
| [machine storage](/t/about-customising-machines/5976#heading--about-customising-machine-storage) |About customising |
| [machine storage](/t/how-to-customise-machines/5108#heading--how-to-customise-machine-storage) |How to customise |
| [machine storage](/t/how-to-manage-machines/5160#heading--how-to-use-machine-storage) |How to use |
| [machine summary](/t/about-machines/5080#heading--about-the-machine-summary) |About the |
| [machines via a chassis](/t/how-to-manage-machines/5160#heading--how-to-add-machines-via-a-chassis) |How to add |
| [machine that’s already running a workload](/t/how-to-deploy-machines/5112#heading--enlisted-deployed-machines) |How to enlist a |
| [machine](/t/how-to-customise-machines/5108#heading--how-to-enable-hardware-sync-on-a-machine) |How to enable hardware sync on a |
| [machine](/t/how-to-customise-machines/5108#heading--set-a-minimum-deploy-kernel-for-a-machine) |How to set a minimum deployment kernel for a |
| [machine](/t/how-to-deploy-machines/5112#heading--how-to-commission-a-machine) |How to commission a |
| [machine](/t/how-to-deploy-machines/5112#heading--update-deployed-hw-info) |How to update hardware information for a deployed |
| [machine](/t/how-to-manage-machines/5160#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or clear a static annotation for a |
| [machine](/t/how-to-manage-machines/5160#heading--clear-and-change-dynamic-annotations-for-a-machine) |How to clear and change dynamic annotations for a |
| [machine](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-one-machine) |How to list dynamic allocations for one |
| [machine](/t/how-to-manage-machines/5160#heading--machine-interfaces) |How to find network info for a |
| [machine](/t/how-to-manage-machines/5160#heading--raw-log-output) |How to find raw log output for a |
| [machine](/t/how-to-manage-machines/5160#heading--set-a-static-annotation-for-a-machine) |How to set a static annotation for a |
| [machine](/t/how-to-manage-machines/5160#heading--set-dynamic-annotations-for-a-machine) |How to set dynamic annotations for a |
| [machine](/t/how-to-manage-machines/5160#heading--view-a-static-annotation-for-one-machine) |How to view a static annotation for one |
| [machine to a resource pool](/t/how-to-customise-machines/5108#heading--add-a-machine-to-a-resource-pool) |How to add a |
| [machine to a resource pool](/t/how-to-customise-machines/5108#heading--add-a-node-to-a-resource-pool) |How to add a |
| [machine to a resource pool](/t/how-to-manage-machines/5160#heading--add-a-machine-to-a-resource-pool) |How to add a |
| [machine to a resource pool](/t/how-to-manage-machines/5160#heading--add-a-node-to-a-resource-pool) |How to add a |
| [make LXD available for VM hosting](/t/how-to-use-lxd/5208#heading--lxd-setup) |How to |
| [manage attached USB and PCI devices](/t/how-to-manage-machines/5160#heading--usb-pci-devices) |How to |
| [manage block devices](/t/how-to-manage-machines/5160#heading--how-to-manage-block-devices) |How to |
| [manage partitions](/t/how-to-manage-machines/5160#heading--how-to-manage-partitions) |How to |
| [manage VMFS datastores](/t/how-to-manage-machines/5160#heading--how-to-manage-vmfs-datastores) |How to |
| [manually](/t/how-to-deploy-machines/5112#heading--how-to-run-all-scripts-manually) |How to run all scripts |
| [manually](/t/how-to-manage-machines/5160#heading--how-to-add-a-machine-manually) |How to add a machine |
| [methods](/t/about-machines/5080#heading--about-disabling-individual-boot-methods) |About disabling individual boot |
| [minimum deployment kernel for a machine](/t/how-to-customise-machines/5108#heading--set-a-minimum-deploy-kernel-for-a-machine) |How to set a |
| [minimum kernel for enlistment and commissioning](/t/how-to-customise-machines/5108#heading--set-a-default-minimum-kernel-for-enlistment-and-commissioning) |How to set a default |
| [modifications](/t/about-customising-machines/5976#heading--final-storage-modifications) |About final storage |
| [modifications](/t/about-machines/5080#heading--final-storage-modifications) |About final storage |
| [mount a block device](/t/how-to-customise-machines/5108#heading--how-to-mount-a-block-device) |How to |
| [mount a block device](/t/how-to-manage-machines/5160#heading--how-to-mount-a-block-device) |How to |
| [mount a partition](/t/how-to-customise-machines/5108#heading--how-to-mount-a-partition) |How to |
| [mount a partition](/t/how-to-manage-machines/5160#heading--how-to-mount-a-partition) |How to |
| [move an existing VM into the LXD project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-move-vm-into-vm-host-project) |How to |
| [move a rack controller from one MAAS instance to another](/t/how-to-manage-controllers/5172#heading--move-rack-controller) |How to |
| [move LXD entities to another project to hide them from MAAS](/t/how-to-use-lxd/5208#heading--projects-s2-move-non-maas-items) |How to |
| [moving a rack controller from one MAAS instance to another](/t/how-to-manage-controllers/5172#heading--about-moving-rack-controller) |About |
| [moving a rack controller](/t/how-to-manage-controllers/5172#heading--dangers-moving-rack-controller) |About the potential dangers of |
| [naming](/t/about-customising-machines/5976#heading--template-naming) |About template |
| [netplan](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-netplan) |How to set up a VM host bridge with |
| [network info for a machine](/t/how-to-manage-machines/5160#heading--machine-interfaces) |How to find |
| [network info](/t/about-machines/5080#heading--about-machine-interfaces) |About machine |
| [networking](/t/about-machines/5080#heading--about-testing-machine-networking) |About testing machine |
| [network links](/t/how-to-deploy-machines/5112#heading--network-link-testing) |How to test |
| [network links](/t/how-to-deploy-machines/5112#heading--slow-link-detection) |How to detect slow |
| [network testing](/t/how-to-deploy-machines/5112#heading--customisable-network-testing) |How to customise |
| [network validation and testing scripts](/t/how-to-deploy-machines/5112#heading--network-validation-scripts-and-testing) |How to configure |
| [new project for MAAS when instantiating a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-with-vm-host) |How to create a |
| [new region host](/t/how-to-manage-controllers/5172#heading--adding-a-new-region-host) |How to add a |
| [new VM in the LXD project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-vm-in-vm-host-project) |How to create a |
| [nodes](/t/about-machines/5080#heading--about-numa-sriov-commissioning) |About commissioning NUMA and SR-IOV |
| [now controls VMs at a project level](/t/how-to-use-lxd/5208#heading--maas-control-at-project-level) |MAAS |
| [NUMA and SR-IOV nodes](/t/about-machines/5080#heading--about-numa-sriov-commissioning) |About commissioning |
| [NUMA, SR-IOV, and hugepages](/t/about-vm-hosting/5068#heading--about-support-for-numa-et-al) |About support for |
| [NUMA](/t/about-vm-hosting/5068#heading--about-vms-and-numa) |About VMs and |
| [older versions of LXD](/t/how-to-use-lxd/5208#heading--reinstalling-lxd) |How to remove |
| [one MAAS instance to another](/t/how-to-manage-controllers/5172#heading--about-moving-rack-controller) |About moving a rack controller from |
| [one MAAS instance to another](/t/how-to-manage-controllers/5172#heading--move-rack-controller) |How to move a rack controller from |
| [one machine](/t/how-to-manage-machines/5160#heading--list-dynamic-annotations-for-one-machine) |How to list dynamic allocations for |
| [one machine](/t/how-to-manage-machines/5160#heading--view-a-static-annotation-for-one-machine) |How to view a static annotation for |
| [options](/t/about-customising-machines/5976#heading--about-kernel-boot-options) |About kernel boot |
| [options](/t/how-to-customise-machines/5108#heading--create-tags-with-built-in-kernel-options) |How to create tags with built-in kernel |
| [options](/t/how-to-customise-machines/5108#heading--how-to-set-global-kernel-boot-options) |How to set global kernel boot |
| [options](/t/how-to-use-lxd/5208#heading--projects-s1-optionste) |How to show LXD project |
| [order of preference](/t/about-machines/5080#heading--about-erasure-order-of-preference) |About erasure |
| [output for a machine](/t/how-to-manage-machines/5160#heading--raw-log-output) |How to find raw log |
| [over-committed resources](/t/about-vm-hosting/5068#heading--overcommit-resources) |About |
| [parameters](/t/how-to-manage-vm-hosts/5140#heading--list-config-params) |How to list configurable VM host |
| [parameters](/t/how-to-manage-vm-hosts/5140#heading--list-vm-host-connection-parameters) |How to list a VM host's connection |
| [parameters while adding a VM](/t/how-to-manage-vms/5148#heading--storage) |How to set storage |
| [partitions](/t/about-customising-machines/5976#heading--about-partitions) |About |
| [partitions](/t/about-machines/5080#heading--about-partitions) |About |
| [partitions](/t/how-to-customise-machines/5108#heading--how-to-list-partitions) |How to list |
| [partitions](/t/how-to-manage-machines/5160#heading--how-to-list-partitions) |How to list |
| [partitions](/t/how-to-manage-machines/5160#heading--how-to-manage-partitions) |How to manage |
| [partition](/t/how-to-customise-machines/5108#heading--how-to-create-a-partition) |How to create a |
| [partition](/t/how-to-customise-machines/5108#heading--how-to-delete-a-partition) |How to delete a |
| [partition](/t/how-to-customise-machines/5108#heading--how-to-format-a-partition) |How to format a |
| [partition](/t/how-to-customise-machines/5108#heading--how-to-mount-a-partition) |How to mount a |
| [partition](/t/how-to-customise-machines/5108#heading--how-to-unformat-a-partition) |How to unformat a |
| [partition](/t/how-to-customise-machines/5108#heading--how-to-unmount-a-partition) |How to unmount a |
| [partition](/t/how-to-manage-machines/5160#heading--how-to-create-a-partition) |How to create a |
| [partition](/t/how-to-manage-machines/5160#heading--how-to-delete-a-partition) |How to delete a |
| [partition](/t/how-to-manage-machines/5160#heading--how-to-format-a-partition) |How to format a |
| [partition](/t/how-to-manage-machines/5160#heading--how-to-mount-a-partition) |How to mount a |
| [partition](/t/how-to-manage-machines/5160#heading--how-to-unformat-a-partition) |How to unformat a |
| [partition](/t/how-to-manage-machines/5160#heading--how-to-unmount-a-partition) |How to unmount a |
| [PCI devices](/t/about-machines/5080#heading--usb-pci-devices) |Handling attached USB and |
| [PCI devices](/t/how-to-manage-machines/5160#heading--usb-pci-devices) |How to manage attached USB and |
| [performance](/t/how-to-manage-controllers/5172#heading--increasing-regiond-daemon-workers) |How to improve region controller |
| [per-machine storage layouts](/t/how-to-customise-machines/5108#heading--how-to-set-per-machine-storage-layouts) |How to set |
| [per-machine storage layouts](/t/how-to-manage-machines/5160#heading--how-to-set-per-machine-storage-layouts) |How to set |
| [pools](/t/about-customising-machines/5976#heading--about-resource-pools) |About resource |
| [pools](/t/about-machines/5080#heading--about-resource-pools) |About resource |
| [pools](/t/about-vm-hosting/5068#heading--about-vm-host-storage-pools) |About VM host storage |
| [pools](/t/how-to-customise-machines/5108#heading--how-to-use-resource-pools) |How to use resource |
| [pools](/t/how-to-customise-machines/5108#heading--list-available-resource-pools) |How to list available resource |
| [pools](/t/how-to-manage-machines/5160#heading--how-to-use-resource-pools) |How to use resource |
| [pools](/t/how-to-manage-machines/5160#heading--list-available-resource-pools) |How to list available resource |
| [pool](/t/how-to-customise-machines/5108#heading--add-a-machine-to-a-resource-pool) |How to add a machine to a resource |
| [pool](/t/how-to-customise-machines/5108#heading--add-a-node-to-a-resource-pool) |How to add a machine to a resource |
| [pool](/t/how-to-customise-machines/5108#heading--add-a-resource-pool) |How to add a resource |
| [pool](/t/how-to-customise-machines/5108#heading--add-a-vm-host-to-a-resource-pool) |How to add a VM host to a resource |
| [pool](/t/how-to-customise-machines/5108#heading--creating-a-resource-pool) |How to create a resource |
| [pool](/t/how-to-customise-machines/5108#heading--delete-a-resource-pool) |How to delete a resource |
| [pool](/t/how-to-customise-machines/5108#heading--deleting-a-resource-pool) |How to delete a resource |
| [pool](/t/how-to-customise-machines/5108#heading--list-a-single-resource-pool) |How to list a single resource |
| [pool](/t/how-to-customise-machines/5108#heading--removing-a-node-from-a-resource-pool) |How to remove a machine from a resource |
| [pool](/t/how-to-customise-machines/5108#heading--removing-a-vm-host-from-a-resource-pool) |How to remove a VM host from a resource |
| [pool](/t/how-to-customise-machines/5108#heading--update-a-resource-pool) |How to update a resource |
| [pool](/t/how-to-manage-machines/5160#heading--add-a-machine-to-a-resource-pool) |How to add a machine to a resource |
| [pool](/t/how-to-manage-machines/5160#heading--add-a-node-to-a-resource-pool) |How to add a machine to a resource |
| [pool](/t/how-to-manage-machines/5160#heading--add-a-resource-pool) |How to add a resource |
| [pool](/t/how-to-manage-machines/5160#heading--add-a-vm-host-to-a-resource-pool) |How to add a VM host to a resource |
| [pool](/t/how-to-manage-machines/5160#heading--creating-a-resource-pool) |How to create a resource |
| [pool](/t/how-to-manage-machines/5160#heading--delete-a-resource-pool) |How to delete a resource |
| [pool](/t/how-to-manage-machines/5160#heading--deleting-a-resource-pool) |How to delete a resource |
| [pool](/t/how-to-manage-machines/5160#heading--list-a-single-resource-pool) |How to list a single resource |
| [pool](/t/how-to-manage-machines/5160#heading--removing-a-node-from-a-resource-pool) |How to remove a machine from a resource |
| [pool](/t/how-to-manage-machines/5160#heading--removing-a-vm-host-from-a-resource-pool) |How to remove a VM host from a resource |
| [pool](/t/how-to-manage-machines/5160#heading--update-a-resource-pool) |How to update a resource |
| [pool](/t/how-to-manage-vm-hosts/5140#heading--change-vm-host-pool) |How to change a VM host's |
| [post-commission configuration](/t/about-machines/5080#heading--about-post-commission-configuration) |About |
| [PostgreSQL for the region](/t/how-to-manage-controllers/5172#heading--postgresql-setup) |How to set up |
| [potential dangers of moving a rack controller](/t/how-to-manage-controllers/5172#heading--dangers-moving-rack-controller) |About the |
| [preference](/t/about-machines/5080#heading--about-erasure-order-of-preference) |About erasure order of |
| [pre-release hardware enablement kernels](/t/about-customising-machines/5976#heading--hardware-enablement-kernels-pre-release) |About |
| [pre-seeding](/t/about-customising-machines/5976#heading--about-pre-seeding) |About |
| [pre-seed with cloud-init](/t/how-to-customise-machines/5108#heading--cloud-init) |How to |
| [pre-seed with curtin](/t/how-to-customise-machines/5108#heading--how-to-pre-seed-with-curtin) |How to |
| [project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-vm-in-vm-host-project) |How to create a new VM in the LXD |
| [project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-move-vm-into-vm-host-project) |How to move an existing VM into the LXD |
| [project for MAAS when instantiating a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-with-vm-host) |How to create a new |
| [project level](/t/how-to-use-lxd/5208#heading--maas-control-at-project-level) |MAAS now controls VMs at a |
| [project options](/t/how-to-use-lxd/5208#heading--projects-s1-optionste) |How to show LXD |
| [project resources](/t/how-to-use-lxd/5208#heading--projects-s1-resource) |How to get a summary of LXD |
| [projects and MAAS](/t/how-to-use-lxd/5208#heading--projects-explanation) |About LXD |
| [projects in MAAS](/t/how-to-use-lxd/5208#heading--projects-big-picture) |About alternatives to LXD |
| [projects](/t/how-to-use-lxd/5208#heading--projects-big-picture) |About LXD |
| [projects](/t/how-to-use-lxd/5208#heading--projects-s1-list) |How to list LXD |
| [projects](/t/how-to-use-lxd/5208#heading--projects-s1-switch) |How to switch between LXD |
| [project summaries](/t/about-vm-hosting/5068#heading--vm-host-project-summary) |About LXD VM host |
| [projects with MAAS](/t/how-to-use-lxd/5208#heading--projects-step-2-lxd-and-maas) |How to use LXD |
| [project](/t/how-to-use-lxd/5208#heading--projects-s1-create) |How to create a LXD |
| [project](/t/how-to-use-lxd/5208#heading--projects-s1-delete) |How to delete a LXD |
| [project](/t/how-to-use-lxd/5208#heading--projects-s1-rename) |How to rename a LXD |
| [project to hide them from MAAS](/t/how-to-use-lxd/5208#heading--projects-s2-move-non-maas-items) |How to move LXD entities to another |
| [project tutorial](/t/how-to-use-lxd/5208#heading--projects-tutorial) |An LXD |
| [quick erasure](/t/about-machines/5080#heading--about-quick-erasure) |About |
| [rack controller from one MAAS instance to another](/t/how-to-manage-controllers/5172#heading--about-moving-rack-controller) |About moving a |
| [rack controller from one MAAS instance to another](/t/how-to-manage-controllers/5172#heading--move-rack-controller) |How to move a |
| [rack controllers communicate](/t/about-controllers/5072#heading--rackregion) |How region and |
| [rack controllers](/t/about-controllers/5072#heading--rack-controllers) |About |
| [rack controllers](/t/how-to-manage-controllers/5172#heading--list-rack-controllers) |How to list |
| [rack controller](/t/about-controllers/5072#heading--machinerack) |How machines communicate with the |
| [rack controller](/t/how-to-manage-controllers/5172#heading--dangers-moving-rack-controller) |About the potential dangers of moving a |
| [rack controller](/t/how-to-manage-controllers/5172#heading--install-a-rack-controller) |How to install a |
| [rack controller](/t/how-to-manage-controllers/5172#heading--unregister-a-rack-controller) |How to unregister a |
| [raw log output for a machine](/t/how-to-manage-machines/5160#heading--raw-log-output) |How to find |
| [read a block device](/t/how-to-customise-machines/5108#heading--how-to-read-a-block-device) |How to |
| [read a block device](/t/how-to-manage-machines/5160#heading--how-to-read-a-block-device) |How to |
| [receive dynamic annotations](/t/how-to-manage-machines/5160#heading--identify-machines-that-can-receive-dynamic-annotations) |How to identify machines that can |
| [refresh LXD on 20.04](/t/how-to-use-lxd/5208#heading--newer-lxd) |How to |
| [region and rack controllers communicate](/t/about-controllers/5072#heading--rackregion) |How |
| [region controller performance](/t/how-to-manage-controllers/5172#heading--increasing-regiond-daemon-workers) |How to improve |
| [region controllers](/t/about-controllers/5072#heading--region-controller) |About |
| [region host](/t/how-to-manage-controllers/5172#heading--adding-a-new-region-host) |How to add a new |
| [region](/t/how-to-manage-controllers/5172#heading--postgresql-setup) |How to set up PostgreSQL for the |
| [remove a machine from a resource pool](/t/how-to-customise-machines/5108#heading--removing-a-node-from-a-resource-pool) |How to |
| [remove a machine from a resource pool](/t/how-to-manage-machines/5160#heading--removing-a-node-from-a-resource-pool) |How to |
| [remove a VM host from a resource pool](/t/how-to-customise-machines/5108#heading--removing-a-vm-host-from-a-resource-pool) |How to |
| [remove a VM host from a resource pool](/t/how-to-manage-machines/5160#heading--removing-a-vm-host-from-a-resource-pool) |How to |
| [remove older versions of LXD](/t/how-to-use-lxd/5208#heading--reinstalling-lxd) |How to |
| [rename a LXD project](/t/how-to-use-lxd/5208#heading--projects-s1-rename) |How to |
| [resource details](/t/about-vm-hosting/5068#heading--vm-host-resource-details) |About LXD VM host |
| [resource pools](/t/about-customising-machines/5976#heading--about-resource-pools) |About |
| [resource pools](/t/about-machines/5080#heading--about-resource-pools) |About |
| [resource pools](/t/how-to-customise-machines/5108#heading--how-to-use-resource-pools) |How to use |
| [resource pools](/t/how-to-customise-machines/5108#heading--list-available-resource-pools) |How to list available |
| [resource pools](/t/how-to-manage-machines/5160#heading--how-to-use-resource-pools) |How to use |
| [resource pools](/t/how-to-manage-machines/5160#heading--list-available-resource-pools) |How to list available |
| [resource pool](/t/how-to-manage-machines/5160#heading--add-a-machine-to-a-resource-pool) |How to add a machine to a |
| [resource pool](/t/how-to-manage-machines/5160#heading--add-a-node-to-a-resource-pool) |How to add a machine to a |
| [resource pool](/t/how-to-manage-machines/5160#heading--add-a-resource-pool) |How to add a |
| [resource pool](/t/how-to-manage-machines/5160#heading--add-a-vm-host-to-a-resource-pool) |How to add a VM host to a |
| [resource pool](/t/how-to-manage-machines/5160#heading--creating-a-resource-pool) |How to create a |
| [resource pool](/t/how-to-manage-machines/5160#heading--delete-a-resource-pool) |How to delete a |
| [resource pool](/t/how-to-manage-machines/5160#heading--deleting-a-resource-pool) |How to delete a |
| [resource pool](/t/how-to-manage-machines/5160#heading--list-a-single-resource-pool) |How to list a single |
| [resource pool](/t/how-to-manage-machines/5160#heading--removing-a-node-from-a-resource-pool) |How to remove a machine from a |
| [resource pool](/t/how-to-manage-machines/5160#heading--removing-a-vm-host-from-a-resource-pool) |How to remove a VM host from a |
| [resource pool](/t/how-to-manage-machines/5160#heading--update-a-resource-pool) |How to update a |
| [resources of all VM hosts](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-all-vm-hosts) |How to list the |
| [resources of a single VM host](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-a-vm-host) |How to list the |
| [resources](/t/about-vm-hosting/5068#heading--overcommit-resources) |About over-committed |
| [resources](/t/how-to-use-lxd/5208#heading--projects-s1-resource) |How to get a summary of LXD project |
| [resources while adding a VM](/t/how-to-manage-vms/5148#heading--set-resources) |How to set |
| [revert hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-revert-hardware-testing-scripts) |How to |
| [run all scripts manually](/t/how-to-deploy-machines/5112#heading--how-to-run-all-scripts-manually) |How to |
| [running a workload](/t/how-to-deploy-machines/5112#heading--enlisted-deployed-machines) |How to enlist a machine that’s already |
| [script failures](/t/about-machines/5080#heading--about-debugging-script-failures) |About debugging |
| [script failures](/t/how-to-deploy-machines/5112#heading--how-to-debug-script-failures) |How to debug |
| [script files](/t/how-to-deploy-machines/5112#heading--how-to-locate-script-files) |How to locate |
| [script results](/t/about-machines/5080#heading--about-script-results) |About |
| [script results](/t/how-to-deploy-machines/5112#heading--how-to-filter-script-results) |How to filter |
| [script results](/t/how-to-deploy-machines/5112#heading--how-to-view-script-results) |How to view |
| [script selection by hardware type](/t/about-machines/5080#heading--about-automatic-script-selection-by-hardware-type) |About automatic |
| [scripts manually](/t/how-to-deploy-machines/5112#heading--how-to-run-all-scripts-manually) |How to run all |
| [scripts](/t/about-machines/5080#heading--about-maas-commissioning-scripts) |About MAAS commissioning |
| [scripts](/t/about-machines/5080#heading--about-tags-and-scripts) |About tags and |
| [scripts](/t/how-to-deploy-machines/5112#heading--how-to-download-built-in-scripts) |How to download built-in |
| [scripts](/t/how-to-deploy-machines/5112#heading--how-to-list-all-uploaded-hardware-testing-scripts) |How to list all uploaded hardware testing |
| [scripts](/t/how-to-deploy-machines/5112#heading--how-to-revert-hardware-testing-scripts) |How to revert hardware testing |
| [scripts](/t/how-to-deploy-machines/5112#heading--how-to-update-hardware-testing-scripts) |How to update hardware testing |
| [scripts](/t/how-to-deploy-machines/5112#heading--how-to-upload-hardware-testing-scripts) |How to upload hardware testing |
| [scripts](/t/how-to-deploy-machines/5112#heading--how-to-upload-scripts) |How to upload |
| [scripts](/t/how-to-deploy-machines/5112#heading--network-validation-scripts-and-testing) |How to configure network validation and testing |
| [scripts](/t/how-to-deploy-machines/5112#heading--tags-group-scripts) |How to use tags to group commissioning and testing |
| [scripts](/t/how-to-deploy-machines/5112#heading--upload-test-scripts) |How to upload hardware test |
| [script](/t/how-to-deploy-machines/5112#heading--how-to-delete-a-script) |How to delete a |
| [script](/t/how-to-deploy-machines/5112#heading--how-to-download-a-script) |How to download a |
| [secure erasure](/t/about-machines/5080#heading--about-secure-erasure) |About |
| [selection by hardware type](/t/about-machines/5080#heading--about-automatic-script-selection-by-hardware-type) |About automatic script |
| [set a block device as a boot disk](/t/how-to-customise-machines/5108#heading--how-to-set-a-block-device-as-a-boot-disk) |How to |
| [set a block device as a boot disk](/t/how-to-manage-machines/5160#heading--how-to-set-a-block-device-as-a-boot-disk) |How to |
| [set a default minimum kernel for enlistment and commissioning](/t/how-to-customise-machines/5108#heading--set-a-default-minimum-kernel-for-enlistment-and-commissioning) |How to |
| [set a minimum deployment kernel for a machine](/t/how-to-customise-machines/5108#heading--set-a-minimum-deploy-kernel-for-a-machine) |How to |
| [set a specific kernel during machine deployment](/t/how-to-customise-machines/5108#heading--set-a-specific-kernel-during-machine-deployment) |How to |
| [set a static annotation for a machine](/t/how-to-manage-machines/5160#heading--set-a-static-annotation-for-a-machine) |How to |
| [set dynamic annotations for a machine](/t/how-to-manage-machines/5160#heading--set-dynamic-annotations-for-a-machine) |How to |
| [set global kernel boot options](/t/how-to-customise-machines/5108#heading--how-to-set-global-kernel-boot-options) |How to |
| [set global storage layouts](/t/how-to-customise-machines/5108#heading--how-to-set-global-storage-layouts) |How to |
| [set global storage layouts](/t/how-to-manage-machines/5160#heading--how-to-set-global-storage-layouts) |How to |
| [set per-machine storage layouts](/t/how-to-customise-machines/5108#heading--how-to-set-per-machine-storage-layouts) |How to |
| [set per-machine storage layouts](/t/how-to-manage-machines/5160#heading--how-to-set-per-machine-storage-layouts) |How to |
| [set resources while adding a VM](/t/how-to-manage-vms/5148#heading--set-resources) |How to |
| [set storage parameters while adding a VM](/t/how-to-manage-vms/5148#heading--storage) |How to |
| [set the architecture while adding a VM](/t/how-to-manage-vms/5148#heading--architecture) |How to |
| [set the default erasure configuration](/t/how-to-customise-machines/5108#heading--how-to-set-default-erasure-configuration) |How to |
| [set the default erasure configuration](/t/how-to-manage-machines/5160#heading--how-to-set-default-erasure-configuration) |How to |
| [set up a VM host bridge with libvirt](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-libvirt) |How to |
| [set up a VM host bridge with netplan](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-netplan) |How to |
| [set up a VM host bridge with the web UI](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-web-ui) |How to |
| [set up PostgreSQL for the region](/t/how-to-manage-controllers/5172#heading--postgresql-setup) |How to |
| [set up SSH for use by libvirt](/t/how-to-manage-vm-hosts/5140#heading--set-up-ssh) |How to |
| [set up SSH (libvirt only)](/t/how-to-manage-vm-hosts/5140#heading--libvirt-ssh) |How to |
| [set up SSH (libvirt only)](/t/how-to-manage-vm-hosts/5140#heading--set-up-ssah-lv) |How to |
| [show LXD project options](/t/how-to-use-lxd/5208#heading--projects-s1-optionste) |How to |
| [single resource pool](/t/how-to-customise-machines/5108#heading--list-a-single-resource-pool) |How to list a |
| [single resource pool](/t/how-to-manage-machines/5160#heading--list-a-single-resource-pool) |How to list a |
| [single VM host](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-a-vm-host) |How to list the resources of a |
| [slow network links](/t/how-to-deploy-machines/5112#heading--slow-link-detection) |How to detect |
| [specific kernel during machine deployment](/t/how-to-customise-machines/5108#heading--set-a-specific-kernel-during-machine-deployment) |How to set a |
| [specify conditional erasure types](/t/how-to-customise-machines/5108#heading--how-to-specify-conditional-erasure-types) |How to |
| [specify conditional erasure types](/t/how-to-manage-machines/5160#heading--how-to-specify-conditional-erasure-types) |How to |
| [specify interfaces while adding a VM](/t/how-to-manage-vms/5148#heading--interfaces) |How to |
| [SR-IOV, and hugepages](/t/about-vm-hosting/5068#heading--about-support-for-numa-et-al) |About support for NUMA, |
| [SR-IOV nodes](/t/about-machines/5080#heading--about-numa-sriov-commissioning) |About commissioning NUMA and |
| [SSH for use by libvirt](/t/how-to-manage-vm-hosts/5140#heading--set-up-ssh) |How to set up |
| [SSH (libvirt only)](/t/how-to-manage-vm-hosts/5140#heading--libvirt-ssh) |How to set up |
| [SSH (libvirt only)](/t/how-to-manage-vm-hosts/5140#heading--set-up-ssah-lv) |How to set up |
| [standard erasure](/t/about-machines/5080#heading--about-standard-erase) |About |
| [states](/t/about-machines/5080#heading--about-machine-states) |About machine |
| [static annotation for a machine](/t/how-to-manage-machines/5160#heading--change-or-clear-a-static-annotation-for-a-machine) |How to change or clear a |
| [static annotation for a machine](/t/how-to-manage-machines/5160#heading--set-a-static-annotation-for-a-machine) |How to set a |
| [static annotation for one machine](/t/how-to-manage-machines/5160#heading--view-a-static-annotation-for-one-machine) |How to view a |
| [static annotations for all machines](/t/how-to-manage-machines/5160#heading--list-static-annotations-for-all-machines) |How to list |
| [static annotations](/t/how-to-manage-machines/5160#heading--work-with-static-annotations) |How to use |
| [storage info](/t/about-machines/5080#heading--machine-storage) |About machine |
| [storage info](/t/how-to-manage-machines/5160#heading--how-to-find-machine-storage-info) |How to find machine |
| [storage layout reference](/t/how-to-manage-machines/5160#heading--bcache-storage-layout-reference) |bcache |
| [storage layout reference](/t/how-to-manage-machines/5160#heading--blank-storage-layout-reference) |Blank |
| [storage layout reference](/t/how-to-manage-machines/5160#heading--lvm-storage-layout-reference) |LVM |
| [storage layout reference](/t/how-to-manage-machines/5160#heading--vmfs6-storage-layout-reference) |VMFS6 |
| [Storage layouts reference](/t/how-to-manage-machines/5160#heading--storage-layouts-reference) | |
| [storage layouts](/t/how-to-customise-machines/5108#heading--how-to-set-global-storage-layouts) |How to set global |
| [storage layouts](/t/how-to-customise-machines/5108#heading--how-to-set-per-machine-storage-layouts) |How to set per-machine |
| [storage layouts](/t/how-to-manage-machines/5160#heading--how-to-define-custom-storage-layouts) |How to define custom |
| [storage layouts](/t/how-to-manage-machines/5160#heading--how-to-set-global-storage-layouts) |How to set global |
| [storage layouts](/t/how-to-manage-machines/5160#heading--how-to-set-per-machine-storage-layouts) |How to set per-machine |
| [storage modifications](/t/about-customising-machines/5976#heading--final-storage-modifications) |About final |
| [storage modifications](/t/about-machines/5080#heading--final-storage-modifications) |About final |
| [storage parameters while adding a VM](/t/how-to-manage-vms/5148#heading--storage) |How to set |
| [storage pools](/t/about-vm-hosting/5068#heading--about-vm-host-storage-pools) |About VM host |
| [storage reference](/t/how-to-manage-machines/5160#heading--flat-storage-layout-reference) |Flat layout |
| [storage restrictions](/t/about-customising-machines/5976#heading--about-storage-restrictions) |About |
| [storage restrictions](/t/about-machines/5080#heading--about-storage-restrictions) |About |
| [storage](/t/about-customising-machines/5976#heading--about-customising-machine-storage) |About customising machine |
| [storage](/t/about-machines/5080#heading--about-storage) |About |
| [storage](/t/how-to-customise-machines/5108#heading--how-to-customise-machine-storage) |How to customise machine |
| [storage](/t/how-to-manage-machines/5160#heading--how-to-use-machine-storage) |How to use machine |
| [summary of LXD project resources](/t/how-to-use-lxd/5208#heading--projects-s1-resource) |How to get a |
| [support for NUMA, SR-IOV, and hugepages](/t/about-vm-hosting/5068#heading--about-support-for-numa-et-al) |About |
| [suppress failed results](/t/how-to-deploy-machines/5112#heading--how-to-suppress-failed-results) |How to |
| [switch between LXD projects](/t/how-to-use-lxd/5208#heading--projects-s1-switch) |How to |
| [sync interval](/t/how-to-customise-machines/5108#heading--how-to-configure-hardware-sync-interval) |How to configure hardware |
| [sync on a machine](/t/how-to-customise-machines/5108#heading--how-to-enable-hardware-sync-on-a-machine) |How to enable hardware |
| [sync](/t/about-customising-machines/5976#heading--about-hardware-sync) |About hardware |
| [sync](/t/how-to-customise-machines/5108#heading--how-to-view-updates-from-hardware-sync) |How to view updates from hardware |
| [tags and scripts](/t/about-machines/5080#heading--about-tags-and-scripts) |About |
| [tags](/t/about-machines/5080#heading--about-tags) |About |
| [tags to group commissioning and testing scripts](/t/how-to-deploy-machines/5112#heading--tags-group-scripts) |How to use |
| [tags with built-in kernel options](/t/how-to-customise-machines/5108#heading--create-tags-with-built-in-kernel-options) |How to create |
| [template naming](/t/about-customising-machines/5976#heading--template-naming) |About |
| [templates](/t/about-customising-machines/5976#heading--templates) |About |
| [testing hardware](/t/about-machines/5080#heading--about-testing-hardware) |About |
| [testing machine networking](/t/about-machines/5080#heading--about-testing-machine-networking) |About |
| [testing results](/t/how-to-deploy-machines/5112#heading--results) |How to view |
| [testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-list-all-uploaded-hardware-testing-scripts) |How to list all uploaded hardware |
| [testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-revert-hardware-testing-scripts) |How to revert hardware |
| [testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-update-hardware-testing-scripts) |How to update hardware |
| [testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-upload-hardware-testing-scripts) |How to upload hardware |
| [testing scripts](/t/how-to-deploy-machines/5112#heading--network-validation-scripts-and-testing) |How to configure network validation and |
| [testing scripts](/t/how-to-deploy-machines/5112#heading--tags-group-scripts) |How to use tags to group commissioning and |
| [testing](/t/how-to-deploy-machines/5112#heading--customisable-network-testing) |How to customise network |
| [test logs](/t/about-machines/5080#heading--hardware-tests) |About machine hardware & |
| [test logs](/t/how-to-manage-machines/5160#heading--hardware-tests) |How to find machine hardware & |
| [test machines](/t/how-to-deploy-machines/5112#heading--how-to-test-machines) |How to |
| [test network links](/t/how-to-deploy-machines/5112#heading--network-link-testing) |How to |
| [timeout](/t/how-to-deploy-machines/5112#heading--configure-deployment-timeout) |Configure deployment |
| [tutorial](/t/how-to-use-lxd/5208#heading--projects-tutorial) |An LXD project |
| [types](/t/about-customising-machines/5976#heading--about-disk-erasure-types) |About disk erasure |
| [types](/t/about-machines/5080#heading--about-disk-erasure-types) |About disk erasure |
| [types](/t/how-to-customise-machines/5108#heading--how-to-specify-conditional-erasure-types) |How to specify conditional erasure |
| [types](/t/how-to-manage-machines/5160#heading--how-to-specify-conditional-erasure-types) |How to specify conditional erasure |
| [type](/t/about-machines/5080#heading--about-automatic-script-selection-by-hardware-type) |About automatic script selection by hardware |
| [Ubuntu kernels](/t/about-customising-machines/5976#heading--about-ubuntu-kernels) |About |
| [Ubuntu kernels](/t/how-to-customise-machines/5108#heading--how-to-choose-ubuntu-kernels) |How to choose |
| [UEFI booting](/t/about-customising-machines/5976#heading--about-uefi-booting) |About |
| [UEFI booting](/t/about-machines/5080#heading--about-uefi-booting) |About |
| [unformat a block device](/t/how-to-customise-machines/5108#heading--how-to-unformat-a-block-device) |How to |
| [unformat a block device](/t/how-to-manage-machines/5160#heading--how-to-unformat-a-block-device) |How to |
| [unformat a partition](/t/how-to-customise-machines/5108#heading--how-to-unformat-a-partition) |How to |
| [unformat a partition](/t/how-to-manage-machines/5160#heading--how-to-unformat-a-partition) |How to |
| [unmount a block device](/t/how-to-customise-machines/5108#heading--how-to-unmount-a-block-device) |How to |
| [unmount a block device](/t/how-to-manage-machines/5160#heading--how-to-unmount-a-block-device) |How to |
| [unmount a partition](/t/how-to-customise-machines/5108#heading--how-to-unmount-a-partition) |How to |
| [unmount a partition](/t/how-to-manage-machines/5160#heading--how-to-unmount-a-partition) |How to |
| [unregister a rack controller](/t/how-to-manage-controllers/5172#heading--unregister-a-rack-controller) |How to |
| [update a block device](/t/how-to-customise-machines/5108#heading--how-to-update-a-block-device) |How to |
| [update a block device](/t/how-to-manage-machines/5160#heading--how-to-update-a-block-device) |How to |
| [update a resource pool](/t/how-to-customise-machines/5108#heading--update-a-resource-pool) |How to |
| [update a resource pool](/t/how-to-manage-machines/5160#heading--update-a-resource-pool) |How to |
| [update a VM host's configuration](/t/how-to-manage-vm-hosts/5140#heading--update-vm-host-configuration) |How to |
| [update hardware information for a deployed machine](/t/how-to-deploy-machines/5112#heading--update-deployed-hw-info) |How to |
| [update hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-update-hardware-testing-scripts) |How to |
| [updates from hardware sync](/t/how-to-customise-machines/5108#heading--how-to-view-updates-from-hardware-sync) |How to view |
| [updating hardware](/t/about-customising-machines/5976#heading--about-updating-hardware) |About |
| [uploaded hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-list-all-uploaded-hardware-testing-scripts) |How to list all |
| [upload hardware testing scripts](/t/how-to-deploy-machines/5112#heading--how-to-upload-hardware-testing-scripts) |How to |
| [upload hardware test scripts](/t/how-to-deploy-machines/5112#heading--upload-test-scripts) |How to |
| [upload scripts](/t/how-to-deploy-machines/5112#heading--how-to-upload-scripts) |How to |
| [USB and PCI devices](/t/about-machines/5080#heading--usb-pci-devices) |Handling attached |
| [USB and PCI devices](/t/how-to-manage-machines/5160#heading--usb-pci-devices) |How to manage attached |
| [use annotations](/t/how-to-manage-machines/5160#heading--how-to-use-annotations) |How to |
| [use by libvirt](/t/how-to-manage-vm-hosts/5140#heading--set-up-ssh) |How to set up SSH for |
| [use dynamic (workload) annotations](/t/how-to-manage-machines/5160#heading--work-with-dynamic-workload-annotations) |How to |
| [use LXD projects with MAAS](/t/how-to-use-lxd/5208#heading--projects-step-2-lxd-and-maas) |How to |
| [use machine storage](/t/how-to-manage-machines/5160#heading--how-to-use-machine-storage) |How to |
| [use resource pools](/t/how-to-customise-machines/5108#heading--how-to-use-resource-pools) |How to |
| [use resource pools](/t/how-to-manage-machines/5160#heading--how-to-use-resource-pools) |How to |
| [use static annotations](/t/how-to-manage-machines/5160#heading--work-with-static-annotations) |How to |
| [use tags to group commissioning and testing scripts](/t/how-to-deploy-machines/5112#heading--tags-group-scripts) |How to |
| [use the MAAS API to configure a bridge](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-cli) |How to |
| [validation and testing scripts](/t/how-to-deploy-machines/5112#heading--network-validation-scripts-and-testing) |How to configure network |
| [versions of LXD](/t/how-to-use-lxd/5208#heading--reinstalling-lxd) |How to remove older |
| [via a chassis](/t/how-to-manage-machines/5160#heading--how-to-add-machines-via-a-chassis) |How to add machines |
| [view a static annotation for one machine](/t/how-to-manage-machines/5160#heading--view-a-static-annotation-for-one-machine) |How to |
| [view a VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-view-a-vmfs-datastore) |How to |
| [view a VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-view-a-vmfs-datastore) |How to |
| [view machine details](/t/how-to-manage-machines/5160#heading--how-to-view-machine-details) |How to |
| [view script results](/t/how-to-deploy-machines/5112#heading--how-to-view-script-results) |How to |
| [view testing results](/t/how-to-deploy-machines/5112#heading--results) |How to |
| [view the machine list](/t/how-to-manage-machines/5160#heading--how-to-view-the-machine-list) |How to |
| [view updates from hardware sync](/t/how-to-customise-machines/5108#heading--how-to-view-updates-from-hardware-sync) |How to |
| [VMFS6 storage layout reference](/t/how-to-manage-machines/5160#heading--vmfs6-storage-layout-reference) | |
| [VMFS datastores](/t/about-customising-machines/5976#heading--about-vmfs-datastores) |About |
| [VMFS datastores](/t/about-machines/5080#heading--about-vmfs-datastores) |About |
| [VMFS datastores](/t/how-to-customise-machines/5108#heading--how-to-list-vmfs-datastores) |How to list |
| [VMFS datastores](/t/how-to-manage-machines/5160#heading--how-to-list-vmfs-datastores) |How to list |
| [VMFS datastores](/t/how-to-manage-machines/5160#heading--how-to-manage-vmfs-datastores) |How to manage |
| [VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-create-a-vmfs-datastore) |How to create a |
| [VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-delete-a-vmfs-datastore) |How to delete a |
| [VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-edit-a-vmfs-datastore) |How to edit a |
| [VMFS datastore](/t/how-to-customise-machines/5108#heading--how-to-view-a-vmfs-datastore) |How to view a |
| [VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-create-a-vmfs-datastore) |How to create a |
| [VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-delete-a-vmfs-datastore) |How to delete a |
| [VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-edit-a-vmfs-datastore) |How to edit a |
| [VMFS datastore](/t/how-to-manage-machines/5160#heading--how-to-view-a-vmfs-datastore) |How to view a |
| [VM host authentication](/t/about-vm-hosting/5068#heading--about-lxd-vm-host-auth) |About LXD |
| [VM host bridge with libvirt](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-libvirt) |How to set up a |
| [VM host bridge with netplan](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-netplan) |How to set up a |
| [VM host bridge with the web UI](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-web-ui) |How to set up a |
| [VM host from a resource pool](/t/how-to-customise-machines/5108#heading--removing-a-vm-host-from-a-resource-pool) |How to remove a |
| [VM host from a resource pool](/t/how-to-manage-machines/5160#heading--removing-a-vm-host-from-a-resource-pool) |How to remove a |
| [VM host ID](/t/how-to-manage-vms/5148#heading--find-vm-host-ids) |How to find a |
| [VM hosting](/t/how-to-use-lxd/5208#heading--lxd-setup) |How to make LXD available for |
| [VM host parameters](/t/how-to-manage-vm-hosts/5140#heading--list-config-params) |How to list configurable |
| [VM host project summaries](/t/about-vm-hosting/5068#heading--vm-host-project-summary) |About LXD |
| [VM host resource details](/t/about-vm-hosting/5068#heading--vm-host-resource-details) |About LXD |
| [VM host's configuration](/t/how-to-manage-vm-hosts/5140#heading--update-vm-host-configuration) |How to update a |
| [VM host's connection parameters](/t/how-to-manage-vm-hosts/5140#heading--list-vm-host-connection-parameters) |How to list a |
| [VM host settings](/t/about-vm-hosting/5068#heading--configuration) |About |
| [VM host's name](/t/how-to-manage-vm-hosts/5140#heading--change-vm-host-name) |How to change a |
| [VM host's pool](/t/how-to-manage-vm-hosts/5140#heading--change-vm-host-pool) |How to change a |
| [VM hosts](/t/about-vm-hosting/5068#heading--about-lxd-vm-hosts) |About LXD |
| [VM hosts](/t/about-vm-hosting/5068#heading--about-vm-hosts) |About |
| [VM hosts](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-all-vm-hosts) |How to list the resources of all |
| [VM-hosts](/t/how-to-manage-vm-hosts/5140#heading--list-vm-hosts) |How to list |
| [VM host storage pools](/t/about-vm-hosting/5068#heading--about-vm-host-storage-pools) |About |
| [VM host](/t/how-to-manage-vm-hosts/5140#heading--adding-a-vm-host) |How to add a |
| [VM host](/t/how-to-manage-vm-hosts/5140#heading--configuration) |How to configure a |
| [VM host](/t/how-to-manage-vm-hosts/5140#heading--list-resources-of-a-vm-host) |How to list the resources of a single |
| [VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-vm-in-vm-host-project) |How to create a new VM in the LXD project associated with a |
| [VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-with-vm-host) |How to create a new project for MAAS when instantiating a |
| [VM host](/t/how-to-use-lxd/5208#heading--projects-s2-delete-vm-host) |How to delete the |
| [VM host](/t/how-to-use-lxd/5208#heading--projects-s2-move-vm-into-vm-host-project) |How to move an existing VM into the LXD project associated with a |
| [VM host to a resource pool](/t/how-to-customise-machines/5108#heading--add-a-vm-host-to-a-resource-pool) |How to add a |
| [VM host to a resource pool](/t/how-to-manage-machines/5160#heading--add-a-vm-host-to-a-resource-pool) |How to add a |
| [VM in the LXD project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-create-vm-in-vm-host-project) |How to create a new |
| [VM into the LXD project associated with a VM host](/t/how-to-use-lxd/5208#heading--projects-s2-move-vm-into-vm-host-project) |How to move an existing |
| [VMs and NUMA](/t/about-vm-hosting/5068#heading--about-vms-and-numa) |About |
| [VMs at a project level](/t/how-to-use-lxd/5208#heading--maas-control-at-project-level) |MAAS now controls |
| [VMs in LXD clusters](/t/how-to-manage-vm-hosts/5140#heading--how-to-compose-vms-in-lxd-clusters) |How to compose |
| [VM](/t/how-to-manage-vms/5148#heading--adding-a-vm-from-the-cli) |How to add a |
| [VM](/t/how-to-manage-vms/5148#heading--add-vm-from-ui) |How to add a |
| [VM](/t/how-to-manage-vms/5148#heading--architecture) |How to set the architecture while adding a |
| [VM](/t/how-to-manage-vms/5148#heading--delete-a-machine) |How to delete a |
| [VM](/t/how-to-manage-vms/5148#heading--delete-a-vm) |How to delete a |
| [VM](/t/how-to-manage-vms/5148#heading--interfaces) |How to specify interfaces while adding a |
| [VM](/t/how-to-manage-vms/5148#heading--set-resources) |How to set resources while adding a |
| [VM](/t/how-to-manage-vms/5148#heading--storage) |How to set storage parameters while adding a |
| [web UI](/t/how-to-manage-vm-hosts/5140#heading--maas-bridge-web-ui) |How to set up a VM host bridge with the |
| [(workload) annotations](/t/how-to-manage-machines/5160#heading--work-with-dynamic-workload-annotations) |How to use dynamic |
| [workload](/t/how-to-deploy-machines/5112#heading--enlisted-deployed-machines) |How to enlist a machine that’s already running a |
| [your machines](/t/how-to-manage-machines/5160#heading--identify-your-machines) |How to identify |