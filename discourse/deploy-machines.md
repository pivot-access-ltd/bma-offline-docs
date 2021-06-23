||2.9|3.0|
|-----:|:-----:|:-----:|
Snap|[CLI](/t/deploy-machines-snap-2-9-cli/2602) ~ [UI](/t/deploy-machines-snap-2-9-ui/2603)|[CLI](/t/deploy-machines-snap-3-0-cli/3913) ~ [UI](/t/deploy-machines-snap-3-0-ui/3914)|
Packages|[CLI](/t/deploy-machines-deb-2-9-cli/2608) ~ [UI](/t/deploy-machines-deb-2-9-ui/2609)|[CLI](/t/deploy-machines-deb-3-0-cli/3915) ~ [UI](/t/deploy-machines-deb-3-0-ui/3916)|

<!-- deb-2-9-cli
Once a machine has been commissioned (see [Commission machines](/t/commission-machines/2476)) the next logical step is to deploy it. Deploying a machine means, effectively, to install an operating system on it.
 deb-2-9-cli -->

<!-- deb-2-9-ui
Once a machine has been commissioned (see [Commission machines](/t/commission-machines/2477)) the next logical step is to deploy it. Deploying a machine means, effectively, to install an operating system on it.
 deb-2-9-ui -->

<!-- deb-3-0-cli
Once a machine has been commissioned (see [Commission machines](/t/commission-machines/3875)) the next logical step is to deploy it. Deploying a machine means, effectively, to install an operating system on it.
 deb-3-0-cli -->

<!-- deb-3-0-ui
Once a machine has been commissioned (see [Commission machines](/t/commission-machines/3876)) the next logical step is to deploy it. Deploying a machine means, effectively, to install an operating system on it.
 deb-3-0-ui -->

<!-- snap-2-9-cli
Once a machine has been commissioned (see [Commission machines](/t/commission-machines/2470)) the next logical step is to deploy it. Deploying a machine means, effectively, to install an operating system on it.
 snap-2-9-cli -->

<!-- snap-2-9-ui
Once a machine has been commissioned (see [Commission machines](/t/commission-machines/2471)) the next logical step is to deploy it. Deploying a machine means, effectively, to install an operating system on it.
 snap-2-9-ui -->

<!-- snap-3-0-cli
Once a machine has been commissioned (see [Commission machines](/t/commission-machines/3873)) the next logical step is to deploy it. Deploying a machine means, effectively, to install an operating system on it.
 snap-3-0-cli -->

Once a machine has been commissioned (see [Commission machines](/t/commission-machines/3874)) the next logical step is to deploy it. Deploying a machine means, effectively, to install an operating system on it.

#### Two questions you may have:

1. [How and why do I acquire a machine?](#heading--acquire)
2. [How do I deploy a machine?](#heading--deploy)

The agent that triggers deployment may vary. For instance, if the machines are destined to run complex, inter-related services that scale up or down frequently, like a "cloud" resource, then [Juju](https://jaas.ai/) is the recommended deployment agent. Juju will also install and configure services on the deployed machines. If you want to use MAAS to install a base operating system and work on the machines manually, then you can deploy a machine directly with MAAS.

<!-- deb-2-9-cli
Machines deployed with MAAS will also be ready to accept connections via SSH, to the 'ubuntu' user account.  This connection assumes that you have imported an SSH key has to your MAAS account. This is explained in [SSH keys](/t/user-accounts/3208#heading--ssh-keys).
 deb-2-9-cli -->

<!-- deb-2-9-ui
Machines deployed with MAAS will also be ready to accept connections via SSH, to the 'ubuntu' user account.  This connection assumes that you have imported an SSH key has to your MAAS account. This is explained in [SSH keys](/t/user-accounts/3209#heading--ssh-keys).
 deb-2-9-ui -->

<!-- deb-3-0-cli
Machines deployed with MAAS will also be ready to accept connections via SSH, to the 'ubuntu' user account.  This connection assumes that you have imported an SSH key has to your MAAS account. This is explained in [SSH keys](/t/user-accounts/4147#heading--ssh-keys).
 deb-3-0-cli -->

<!-- deb-3-0-ui
Machines deployed with MAAS will also be ready to accept connections via SSH, to the 'ubuntu' user account.  This connection assumes that you have imported an SSH key has to your MAAS account. This is explained in [SSH keys](/t/user-accounts/4148#heading--ssh-keys).
 deb-3-0-ui -->

<!-- snap-2-9-cli
Machines deployed with MAAS will also be ready to accept connections via SSH, to the 'ubuntu' user account.  This connection assumes that you have imported an SSH key has to your MAAS account. This is explained in [SSH keys](/t/user-accounts/3202#heading--ssh-keys).
 snap-2-9-cli -->

<!-- snap-2-9-ui
Machines deployed with MAAS will also be ready to accept connections via SSH, to the 'ubuntu' user account.  This connection assumes that you have imported an SSH key has to your MAAS account. This is explained in [SSH keys](/t/user-accounts/3203#heading--ssh-keys).
 snap-2-9-ui -->

<!-- snap-3-0-cli
Machines deployed with MAAS will also be ready to accept connections via SSH, to the 'ubuntu' user account.  This connection assumes that you have imported an SSH key has to your MAAS account. This is explained in [SSH keys](/t/user-accounts/4145#heading--ssh-keys).
 snap-3-0-cli -->

Machines deployed with MAAS will also be ready to accept connections via SSH, to the 'ubuntu' user account.  This connection assumes that you have imported an SSH key has to your MAAS account. This is explained in [SSH keys](/t/user-accounts/4146#heading--ssh-keys).

[note]
Juju adds SSH keys to machines under its control.
[/note]

<!-- deb-2-9-cli
MAAS also supports machine customisation with a process called "preseeding." For more information about customising machines, see [Custom machine setup](/t/custom-machine-setup/2596).
 deb-2-9-cli -->

<!-- deb-2-9-ui
MAAS also supports machine customisation with a process called "preseeding." For more information about customising machines, see [Custom machine setup](/t/custom-machine-setup/2597).
 deb-2-9-ui -->

<!-- deb-3-0-cli
MAAS also supports machine customisation with a process called "preseeding." For more information about customising machines, see [Custom machine setup](/t/custom-machine-setup/3911).
 deb-3-0-cli -->

<!-- deb-3-0-ui
MAAS also supports machine customisation with a process called "preseeding." For more information about customising machines, see [Custom machine setup](/t/custom-machine-setup/3912).
 deb-3-0-ui -->

<!-- snap-2-9-cli
MAAS also supports machine customisation with a process called "preseeding." For more information about customising machines, see [Custom machine setup](/t/custom-machine-setup/2590).
 snap-2-9-cli -->

<!-- snap-2-9-ui
MAAS also supports machine customisation with a process called "preseeding." For more information about customising machines, see [Custom machine setup](/t/custom-machine-setup/2591).
 snap-2-9-ui -->

<!-- snap-3-0-cli
MAAS also supports machine customisation with a process called "preseeding." For more information about customising machines, see [Custom machine setup](/t/custom-machine-setup/3909).
 snap-3-0-cli -->

MAAS also supports machine customisation with a process called "preseeding." For more information about customising machines, see [Custom machine setup](/t/custom-machine-setup/3910).

<a href="#heading--acquire"><h2 id="heading--acquire">Acquire</h2></a>

Acquiring ("allocating") a machine reserves the machine for the exclusive use of the acquiring process. The machine is no longer available to any other process, including another MAAS instance, or a process such as Juju.

Before deploying a machine, MAAS must acquire it (status 'Allocated'). When deploying from the web UI, this action is performed automatically (and invisibly).

The action remains useful in terms of reserving a machine for later use. To acquire a machine explicitly select the machine and apply the 'Acquire' action.

To acquire/allocate a node with the web UI, select a machine which is in the "Ready" state, and drop down the "Take action" menu:

<a href="https://discourse.maas.io/uploads/default/original/1X/3724346e052c865f4e865d1caf2778b115f0798f.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/3724346e052c865f4e865d1caf2778b115f0798f.jpeg"></a>

Select "Acquire" from the drop-down menu, which will bring you to a confirmation screen:

<a href="https://discourse.maas.io/uploads/default/original/1X/a0ece8bf58c03db3c89ad71afcaeb9101bd34e24.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a0ece8bf58c03db3c89ad71afcaeb9101bd34e24.jpeg"></a>

MAAS will acquire the selected machine; you can now find it in the list of "Allocated" machines:

<a href="https://discourse.maas.io/uploads/default/original/1X/a2bdb8b7b7c5705daee14bdea5caed223537917d.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a2bdb8b7b7c5705daee14bdea5caed223537917d.jpeg"></a>

<!--   snap-2-9-cli   deb-2-9-cli snap-3-0-cli deb-3-0-cli 

To acquire/allocate a random node:

``` bash
maas $PROFILE machines allocate
```

To acquire/allocate a specific node:

``` bash
maas $PROFILE machines allocate system_id=$SYSTEM_ID
```

  snap-2-9-cli   deb-2-9-cli snap-3-0-cli deb-3-0-cli  -->

[note]
To acquire a node, it must have a status of 'Ready'.
[/note]

<a href="#heading--deploy"><h2 id="heading--deploy">Deploy</h2></a>

To deploy, you must configure the underlying machine to netboot.  Such a machine will undergo the following process:

1.  DHCP server is contacted
2.  kernel and initrd are received over TFTP
3.  machine boots
4.  initrd mounts a Squashfs image ephemerally over HTTP
5.  cloud-init triggers deployment process
6.  curtin installation script runs
7.  Squashfs image (same as above) is placed on disk

<!-- deb-2-9-cli
[note]
The curtin installer uses an image-based method and is now the only installer used by MAAS. Although the older debian-installer method has been removed, curtin continues to support preseed files. For more information about customising machines see [Custom machine setup](/t/custom-machine-setup/2596).
[/note]

Before deploying, you should take two key actions:

1.   review and possibly set the [Ubuntu kernels](/t/ubuntu-kernels/3184) and the [Kernel boot options](/t/kernel-boot-options/2788) that will get used by deployed machines.
2.   ensure any pertinent SSH keys are imported (see [SSH keys](/t/user-accounts/3208#heading--ssh-keys)) to MAAS so it can connect to deployed machines.
 deb-2-9-cli -->

<!-- deb-2-9-ui
[note]
The curtin installer uses an image-based method and is now the only installer used by MAAS. Although the older debian-installer method has been removed, curtin continues to support preseed files. For more information about customising machines see [Custom machine setup](/t/custom-machine-setup/2597).
[/note]

Before deploying, you should take two key actions:

1.   review and possibly set the [Ubuntu kernels](/t/ubuntu-kernels/3185) and the [Kernel boot options](/t/kernel-boot-options/2789) that will get used by deployed machines.
2.   ensure any pertinent SSH keys are imported (see [SSH keys](/t/user-accounts/3209#heading--ssh-keys)) to MAAS so it can connect to deployed machines.
 deb-2-9-ui -->

<!-- deb-3-0-cli
[note]
The curtin installer uses an image-based method and is now the only installer used by MAAS. Although the older debian-installer method has been removed, curtin continues to support preseed files. For more information about customising machines see [Custom machine setup](/t/custom-machine-setup/3911).
[/note]

Before deploying, you should take two key actions:

1.   review and possibly set the [Ubuntu kernels](/t/ubuntu-kernels/4139) and the [Kernel boot options](/t/kernel-boot-options/3975) that will get used by deployed machines.
2.   ensure any pertinent SSH keys are imported (see [SSH keys](/t/user-accounts/4147#heading--ssh-keys)) to MAAS so it can connect to deployed machines.
 deb-3-0-cli -->

<!-- deb-3-0-ui
[note]
The curtin installer uses an image-based method and is now the only installer used by MAAS. Although the older debian-installer method has been removed, curtin continues to support preseed files. For more information about customising machines see [Custom machine setup](/t/custom-machine-setup/3912).
[/note]

Before deploying, you should take two key actions:

1.   review and possibly set the [Ubuntu kernels](/t/ubuntu-kernels/4140) and the [Kernel boot options](/t/kernel-boot-options/3976) that will get used by deployed machines.
2.   ensure any pertinent SSH keys are imported (see [SSH keys](/t/user-accounts/4148#heading--ssh-keys)) to MAAS so it can connect to deployed machines.
 deb-3-0-ui -->

<!-- snap-2-9-cli
[note]
The curtin installer uses an image-based method and is now the only installer used by MAAS. Although the older debian-installer method has been removed, curtin continues to support preseed files. For more information about customising machines see [Custom machine setup](/t/custom-machine-setup/2590).
[/note]

Before deploying, you should take two key actions:

1.   review and possibly set the [Ubuntu kernels](/t/ubuntu-kernels/3178) and the [Kernel boot options](/t/kernel-boot-options/2782) that will get used by deployed machines.
2.   ensure any pertinent SSH keys are imported (see [SSH keys](/t/user-accounts/3202#heading--ssh-keys)) to MAAS so it can connect to deployed machines.
 snap-2-9-cli -->

<!-- snap-2-9-ui
[note]
The curtin installer uses an image-based method and is now the only installer used by MAAS. Although the older debian-installer method has been removed, curtin continues to support preseed files. For more information about customising machines see [Custom machine setup](/t/custom-machine-setup/2591).
[/note]

Before deploying, you should take two key actions:

1.   review and possibly set the [Ubuntu kernels](/t/ubuntu-kernels/3179) and the [Kernel boot options](/t/kernel-boot-options/2783) that will get used by deployed machines.
2.   ensure any pertinent SSH keys are imported (see [SSH keys](/t/user-accounts/3203#heading--ssh-keys)) to MAAS so it can connect to deployed machines.
 snap-2-9-ui -->

<!-- snap-3-0-cli
[note]
The curtin installer uses an image-based method and is now the only installer used by MAAS. Although the older debian-installer method has been removed, curtin continues to support preseed files. For more information about customising machines see [Custom machine setup](/t/custom-machine-setup/3909).
[/note]

Before deploying, you should take two key actions:

1.   review and possibly set the [Ubuntu kernels](/t/ubuntu-kernels/4137) and the [Kernel boot options](/t/kernel-boot-options/3973) that will get used by deployed machines.
2.   ensure any pertinent SSH keys are imported (see [SSH keys](/t/user-accounts/4145#heading--ssh-keys)) to MAAS so it can connect to deployed machines.
 snap-3-0-cli -->

[note]
The curtin installer uses an image-based method and is now the only installer used by MAAS. Although the older debian-installer method has been removed, curtin continues to support preseed files. For more information about customising machines see [Custom machine setup](/t/custom-machine-setup/3910).
[/note]

Before deploying, you should take two key actions:

1.   review and possibly set the [Ubuntu kernels](/t/ubuntu-kernels/4138) and the [Kernel boot options](/t/kernel-boot-options/3974) that will get used by deployed machines.
2.   ensure any pertinent SSH keys are imported (see [SSH keys](/t/user-accounts/4146#heading--ssh-keys)) to MAAS so it can connect to deployed machines.

To deploy directly from MAAS, select one or more machine(s) and press the 'Deploy' button.

<a href="https://assets.ubuntu.com/v1/56958753-nodes-deploy__2.4_deploy.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/56958753-nodes-deploy__2.4_deploy.png"></a>

You then have the option of deviating from the default OS, release, and kernel. When ready, press 'Deploy X machine(s)' (where 'X' is the number of machines selected).

<a href="https://assets.ubuntu.com/v1/d65b9884-nodes-deploy__2.6-deploy-confirm.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/d65b9884-nodes-deploy__2.6-deploy-confirm.png"></a>

While a machine is deploying its status will change to Deploying to 'OS', where 'OS' is the name of the OS being deployed (e.g. 'Deploying to Ubuntu 16.04 LTS').

Once a machine has finished deploying its status will change to just the name of the OS (e.g. 'Ubuntu 18.04 LTS').

<!--   snap-2-9-cli   deb-2-9-cli snap-3-0-cli deb-3-0-cli 
To deploy a node:

``` bash
maas $PROFILE machine deploy $SYSTEM_ID
```

To deploy a node as a KVM host:

``` bash
maas $PROFILE machine deploy $SYSTEM_ID install_kvm=True
```

[note]
To deploy with the CLI, the node must have a status of 'Allocated'. See 'Acquire a node' above.
[/note]

<a href="#heading--configure-deployment-timeout"><h3 id="heading--configure-deployment-timeout">Configure deployment timeout</h3></a>

By default, when you deploy a machine, MAAS will consider the deployment a failure if it doesn't complete within 30 minutes.  You can configure this timeout, if you wish, with the command:

```
maas $PROFILE maas set-config name=node-timeout value=$NUMBER_OF_MINUTES
```


   snap-2-9-cli   deb-2-9-cli  snap-3-0-cli deb-3-0-cli -->