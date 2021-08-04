Once a machine has been commissioned (see [Commission machines](/t/commission-machines/nnnn)) the next logical step is to deploy it. Deploying a machine means, effectively, to install an operating system on it.

#### Two questions you may have:

1. [How and why do I acquire a machine?](#heading--acquire)
2. [How do I deploy a machine?](#heading--deploy)

The agent that triggers deployment may vary. For instance, if the machines are destined to run complex, inter-related services that scale up or down frequently, like a "cloud" resource, then [Juju](https://jaas.ai/) is the recommended deployment agent. Juju will also install and configure services on the deployed machines. If you want to use MAAS to install a base operating system and work on the machines manually, then you can deploy a machine directly with MAAS.

Machines deployed with MAAS will also be ready to accept connections via SSH, to the 'ubuntu' user account.  This connection assumes that you have imported an SSH key has to your MAAS account. This is explained in [SSH keys](/t/user-accounts/nnnn#heading--ssh-keys).

[note]
Juju adds SSH keys to machines under its control.
[/note]

MAAS also supports machine customisation with a process called "preseeding." For more information about customising machines, see [Custom machine setup](/t/custom-machine-setup/nnnn).

<a href="#heading--acquire"><h2 id="heading--acquire">Acquire</h2></a>

Acquiring ("allocating") a machine reserves the machine for the exclusive use of the acquiring process. The machine is no longer available to any other process, including another MAAS instance, or a process such as Juju.

Before deploying a machine, MAAS must acquire it (status 'Allocated'). When deploying from the web UI, this action is performed automatically (and invisibly).

The action remains useful in terms of reserving a machine for later use. To acquire a machine explicitly select the machine and apply the 'Acquire' action.

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
To acquire/allocate a node with the web UI, select a machine which is in the "Ready" state, and drop down the "Take action" menu:

<a href="https://discourse.maas.io/uploads/default/original/1X/3724346e052c865f4e865d1caf2778b115f0798f.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/3724346e052c865f4e865d1caf2778b115f0798f.jpeg"></a>

Select "Acquire" from the drop-down menu, which will bring you to a confirmation screen:

<a href="https://discourse.maas.io/uploads/default/original/1X/a0ece8bf58c03db3c89ad71afcaeb9101bd34e24.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a0ece8bf58c03db3c89ad71afcaeb9101bd34e24.jpeg"></a>

MAAS will acquire the selected machine; you can now find it in the list of "Allocated" machines:

<a href="https://discourse.maas.io/uploads/default/original/1X/a2bdb8b7b7c5705daee14bdea5caed223537917d.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a2bdb8b7b7c5705daee14bdea5caed223537917d.jpeg"></a>
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 

To acquire/allocate a random node:

``` bash
maas $PROFILE machines allocate
```

To acquire/allocate a specific node:

``` bash
maas $PROFILE machines allocate system_id=$SYSTEM_ID
```

rad-end

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

[note]
The curtin installer uses an image-based method and is now the only installer used by MAAS. Although the older debian-installer method has been removed, curtin continues to support preseed files. For more information about customising machines see [Custom machine setup](/t/custom-machine-setup/nnnn).
[/note]

Before deploying, you should take two key actions:

1.   review and possibly set the [Ubuntu kernels](/t/ubuntu-kernels/nnnn) and the [Kernel boot options](/t/kernel-boot-options/nnnn) that will get used by deployed machines.
2.   ensure any pertinent SSH keys are imported (see [SSH keys](/t/user-accounts/nnnn#heading--ssh-keys)) to MAAS so it can connect to deployed machines.

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
To deploy directly from MAAS, select one or more machine(s) and press the 'Deploy' button.

<a href="https://assets.ubuntu.com/v1/56958753-nodes-deploy__2.4_deploy.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/56958753-nodes-deploy__2.4_deploy.png"></a>

You then have the option of deviating from the default OS, release, and kernel. When ready, press 'Deploy X machine(s)' (where 'X' is the number of machines selected).

<a href="https://assets.ubuntu.com/v1/d65b9884-nodes-deploy__2.6-deploy-confirm.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/d65b9884-nodes-deploy__2.6-deploy-confirm.png"></a>

While a machine is deploying its status will change to Deploying to 'OS', where 'OS' is the name of the OS being deployed (e.g. 'Deploying to Ubuntu 16.04 LTS').

Once a machine has finished deploying its status will change to just the name of the OS (e.g. 'Ubuntu 18.04 LTS').
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
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
rad-end
