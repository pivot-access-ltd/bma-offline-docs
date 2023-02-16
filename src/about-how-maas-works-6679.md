<!-- "How MAAS works" -->
<a href="#heading--how-maas-works"><h3 id="heading--how-maas-works">How MAAS works</h3></a>

When you [add a new machine](/t/how-to-make-machines-available/5160#heading--how-to-add-a-machine-manually) to MAAS, or elect to add a machine that MAAS has [enlisted](/t/how-to-deploy-physical-machines/6193#heading--about-enlistment), MAAS [commissions](/t/how-to-deploy-physical-machines/6193#heading--about-commissioning-machines) it for service and adds it to the pool.  At that point, the machine is ready for use. MAAS keeps things simple, marking machines as "New," "Commissioning," "Ready," and so on.

<details><summary>Tell me, quickly, about enlistment and commissioning.</summary>

There are two ways to add a machine to MAAS.  Assuming it's on the network and capable of PXE-booting, you can add it explicitly -- or MAAS can simply discover it when you turn it on.

Enlistment just means that MAAS discovers a machine when you turn it on, and presents it to the MAAS administrator, so that they can choose whether or not to commission it.  Machines that have only been enlisted will show up in the machine list as "New."

Commissioning means that MAAS has successfully booted the machine, scanned and recorded its resources, and prepared it for eventual deployment.  Machines that you explicitly add are automatically commissioned.  MAAS marks a successfully-commissioned machine as "Ready" in the machine list.

</details>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="https://discourse.maas.io/uploads/default/original/1X/605019de31078dd70df72ff199d812de13a30d00.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/605019de31078dd70df72ff199d812de13a30d00.jpeg"></a>
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
<a href="https://discourse.maas.io/uploads/default/original/1X/6aec9b567022216d80596411e689a14e1f594674.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/6aec9b567022216d80596411e689a14e1f594674.jpeg"></a>
[/tab]
[/tabs]

MAAS controls machines through IPMI (or another BMC). It can also manage machines through a converged chassis controller, such as Cisco UCS.  You can choose how you want to control power on your machines based on what is available.  MAAS overwrites the machine's disk space with your chosen, pre-cached OS images.

[note]
*The above comment about disk space bears repeating: MAAS will overwrite the disk space of all machines it enlists. All pool machines are under the control of MAAS; you should provision them using other methods.*
[/note]

MAAS users allocate machines for use when needed. The web UI also allows you to allocate machines manually, such as when you are reserving specific hardware for certain users. You can remotely access and customise the installed operating system via SSH.

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="https://discourse.maas.io/uploads/default/original/1X/8101d641c55d912cd66646bd99bbee9bb8f196ab.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8101d641c55d912cd66646bd99bbee9bb8f196ab.jpeg"></a>
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
<a href="https://discourse.maas.io/uploads/default/original/1X/ac3b251a916bb18a7e7e463d7fa3c57ef32628da.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/ac3b251a916bb18a7e7e463d7fa3c57ef32628da.jpeg"></a>

When allocating machines from the API/CLI, you can specify requirements ("constraints"). Common constraints are memory, CPU cores, connected networks, and assigned physical zone.
[/tab]
[/tabs]

An allocated MAAS machine is more flexible than a virtual instance in a cloud. You have complete control, including hardware drivers and root access. If you want to upgrade the BIOS, for example, you can allocate a machine to yourself and complete the upgrade.  Once you have completed the upgrade, you can send the machine back to the pool.

Note that [Juju](https://juju.is/docs/olm/maas)`↗` is designed to work with MAAS. MAAS becomes a back-end Juju resource pool with all functionality fully available. For instance, if Juju removes a machine, then MAAS will release that machine to the pool.  With Juju, MAAS can become an integral part of your data centre strategy and operations.
