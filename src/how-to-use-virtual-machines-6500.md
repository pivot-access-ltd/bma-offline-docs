<!-- "How to use virtual machines" -->
Virtual machines have become valuable tools in modern computing due to their ability to mimic the functionality of physical machines. These virtual machines run on a single physical machine, each with its own operating system and applications. As a result, they are great for saving both time and money, as they enable users to run multiple operating systems and applications on a single physical machine, leading to more efficient use of resources.

MAAS supports various types of virtual machines, with [LXD being the recommended virtual machine host](/t/how-to-set-up-lxd/5208). LXD is a container hypervisor that provides a simple and efficient way to deploy and manage virtual machines. MAAS also supports libvirt and VMWare, offering users the flexibility to choose the virtualization platform that best suits their needs.

To use virtual machines with MAAS, it is important to properly [set up and configure the VM host](/t/how-to-manage-vm-hosts/5140). MAAS provides detailed instructions on how to set up LXD, and users can also use libvirt or VMWare if they prefer. Once the VM host is set up, virtual machines can be created, customized, and deleted using the MAAS UI. With the CLI, users can perform more nuanced tasks such as controlling resource allocation and network configuration.

With the ability to easily [create and manage virtual machines](/t/how-to-manage-virtual-machines/5148), MAAS enables users to run multiple operating systems and applications on a single physical machine. This, in turn, can lead to significant cost and labor savings by optimizing the use of resources, and better overall coverage because of the relative speed with which virtual machines can be re-purposed.

