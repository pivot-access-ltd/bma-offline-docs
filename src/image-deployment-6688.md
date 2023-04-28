<!-- "Image deployment" -->

Here's a conceptual view of the way that images get deployed to create a running MAAS machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/4bcb44d49eae1238d6cbd3724f2ec7cab6b8acab.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/4bcb44d49eae1238d6cbd3724f2ec7cab6b8acab.jpeg"></a>

This is a good place to explain how images work, including the nuances of `cloud-init` and `curtin` configurations.  Let's take it from the top.

Before a machine can be deployed, it must be added to MAAS, commissioned, and allocated.  Machines can be added to MAAS either by [enlistment](/t/machines/6695#heading--about-enlistment) or by direct user action.  This machine must then be [commissioned](/t/machines/6695#heading--about-commissioning-machines), which establishes the configuration and resources of the machine.  Finally, that machine must be allocated, that is, assigned to the control of one and only one user, so that conflicting commands to the same machine are not possible.  This aggregate step is represented by the green lines in the above diagram.

When MAAS receives the "deploy" command from the user (blue lines), it must first retrieve (from the MAAS DB) the machine info that was gathered about the machine during commissioning (red lines).  MAAS then boots the machine and waits for the machine's firmware to request a bootable "ephemeral" OS.  This ephemeral OS must be one of the images supplied by [the MAAS simplestreams](https://images.maas.io)`↗` and cannot be a custom OS image.

At the point that MAAS must send the ephemeral OS to the machine, MAAS needs to have this OS downloaded to the rack controller, based on earlier selections made by the user (yellow lines).  Assuming that the a suitable simplestreams image is available, MAAS can send it to the machine.  This ephemeral OS is not deployed, but it is used to download and deploy the image you've chosen for the machine.

When the ephemeral OS boots, it immediately spawns [curtin](https://curtin.readthedocs.io/en/latest/topics/overview.html)`↗`.  Curtin's deployment of the target image can be customised with pre-seeds, shown by the brown lines in the diagram.  These pre-seeds control things which are difficult to change once the target OS has been installed (such as [partitioning](http://caribou.kamikamamak.com/2015/06/26/custom-partitioning-with-maas-and-curtin-2/)`↗`.  Things which can be customized after the target image is running are generally configured with [cloud-init](https://cloudinit.readthedocs.io/en/latest/)`↗`, represented by the pink lines.

To continue with the deployment flow, curtin retrieves the target image, either from the rack controller's cache (if the image is standard) or from the MAAS DB (if the image is custom).  Curtin then installs the target image and reboots the machine.  When the target image boots, it retrieves cloud-init configuration either from the MAAS metadata server (proxied by the region controller), or from cloud-init configuration data packed with the target image -- whichever is "closer".

Once cloud-init has finished, the machine is deployed, that is, up and running, ready to perform whatever functions have been assigned to it.

<a href="#heading--key-takeaways"><h2 id="heading--key-takeaways">Key takeaways from this flowchart</h2></a>

The flowchart above is a bit complicated, but there are few key takeaways you should remember:

1. Machines have to be added, either by enlistment or direct user action, before they can be deployed.

2. Machines must be commissioned before deployment, so that MAAS knows what resources the machine has available.

3. Machines must be allocated before deployment, to lock out all other users (so that no command deadlock can occur).

4. You must have selected and downloaded at least one suitable image from the MAAS simplestreams before you can deploy a machine, because this simplestreams image is used to boot the machine from the network, so that the target OS can then be installed on the machine.

5. If you need to customize things about the machine that can't be changed after the target OS is installed (like partitioning drives), you must use curtin pre-seeds to do this.  You must specify these pre-seeds before you start deployment.

6. If you want to customize things about the machine that can be changed after the target OS is installed (like downloading and installing an application),  you must use cloud-init to do this.  You must specify this cloud-init configuration, at the very least, before deployment begins.

7. If you wish to deploy a custom image, you must pack it and upload it to MAAS before deployment begins.

<a href="#heading--boot-sources"><h2 id="heading--boot-sources">About boot sources and why they matter</h2></a>

A region controller downloads its images from a boot source. The main characteristics of a boot source are location (URL) and an associated GPG public keyring.

[note]
A boot resource is another name for an image. So boot resources are found within a boot source.
[/note]

MAAS stores images in the region controller's database, from where the rack controller proxies them to the individual machines.  It's important to note that for ESXi images, network configuration includes only these five parameters:

1.   DHCP
2.   Static/auto IP assignments
3.   Aliases
4.   VLANs
5.   Bonds

Bonds are mapped to NIC teaming in only three ways:

1.   balance-rr -- portid
2.   active-backup -- explicit
3.   802.3ad -- iphash, LACP rate and XMIT hash policy settings ignored

MAAS comes configured with a boot source that should suffice for most users:

[`https://images.maas.io/ephemeral-v3/stable/`](https://images.maas.io/ephemeral-v3/stable/)`↗`

The above URL points to the 'stable' stream (for the v3 format). See [Local image mirror](/t/how-to-mirror-images-locally/5927) for some explanation regarding the availability of other streams.

Although the backend supports multiple boot sources, MAAS itself uses a single source. If multiple sources are detected, the web UI will print a warning and will be unable to manage images.
