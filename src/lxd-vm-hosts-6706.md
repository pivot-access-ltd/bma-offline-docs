<!-- "LXD VM hosts" -->

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages" view="UI"]
<a href="#heading--about-lxd-vm-host-auth"><h2 id="heading--about-lxd-vm-host-auth">About LXD VM host authentication</h2></a>

MAAS 3.1 provides a smoother experience when connecting an existing LXD server to MAAS, guiding the user through manual steps and providing increased connection security with use of certificates. Currently, each MAAS region/rack controller has its own certificate. To add a LXD VM host to MAAS, the user needs to either add the certificate for each controller that can reach the LXD server to the trust list in LXD, or use the trust_password (in which case the controller talking to LXD will automatically add its certificate to the trust).

This doesn’t provide a great user experience, as the former process is cumbersome, and the latter is not suggested for production use for security reasons.  To improve this, MAAS 3.1 manages per-LXD keys/certificates, and provide a way for users to get the content of certificates, to authorise MAAS in LXD.

<a href="#heading--About-on-the-spot-certificate-creation"><h2 id="heading--About-on-the-spot-certificate-creation">About on-the-spot certificate creation</h2></a>

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

<a href="#heading--About-bringing-your-own-certificates"><h2 id="heading--About-bringing-your-own-certificates">About bringing your own certificates</h2></a>

As a MAAS user, you may want to register a LXD host into MAAS by providing a private key for a certificate that’s already trusted by the LXD server.  For example, you may already have set up certificates in the server trust for MAAS to use, MAAS should provide a way to import it, instead of generating a new one.

With MAAS 3.1, it’s possible to import an existing key/certificate pair for use with a LXD server when registering it with MAAS.  MAAS stores the key/certificate instead of generating new ones.

[note]
The imported key must not have a passphrase; otherwise, MAAS will not be able to use it.
[/note]

<a href="#heading--vm-host-project-summary"><h2 id="heading--vm-host-project-summary">About LXD VM host project summaries</h2></a>

Each LXD VM host provides a "Project" tab that summarises the current state of the LXD KVM:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e0cc264a17d67f9530ff8c2ef2bb9522fed0749a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e0cc264a17d67f9530ff8c2ef2bb9522fed0749a.png"></a>

This tab identifies the project, shows its current resource state, and provides the ability to select existing VM hosts and perform specific actions on them -- as well as being able to compose new VMs on the spot.

<a href="#heading--vm-host-resource-details"><h2 id="heading--vm-host-resource-details">About LXD VM host resource details</h2></a>

This tab presents a summary of the LXD VM host's resource usage:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d67cf384d6fe903274893eb50a098518d2c1295d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d67cf384d6fe903274893eb50a098518d2c1295d.png"></a>

The only interactive option on this tab allows you to map or unmap resource usage to NUMA nodes.

<a href="#heading--configuration"><h2 id="heading--configuration">About VM host settings</h2></a>

VM hosts have several settings. Modify these by selecting the 'Settings' tab and editing items directly. Options include a VM host's address, password, network zone, resource pool, and memory and CPU overcommit sliders.

<a href="https://discourse.maas.io/uploads/default/original/2X/2/253afc122d61145be656bb5c3811f9b6c6caa708.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/253afc122d61145be656bb5c3811f9b6c6caa708.png"></a>
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages" view="CLI"]
Please use the UI interface to interact with LXD VM hosts, by selecting "UI" from the dropdown above.
[/tab]
[tab version="v2.9 Snap,v2.9 Packages view="UI,CLI"]
LXD VM hosts are not available in MAAS version 2.9.  Please upgrade to MAAS version 3.0 or greater to access this functionality.

<a href="#heading--about-lxd-vs-libvirt"><h2 id="heading--about-lxd-vs-libvirt">About LXD (Beta) vs. libvirt</h2></a>

Libvirt KVMs and LXD VMs are both based on the same underlying virtualisation technology, QEMU. Unlike libvirt KVMs, though, LXD VMs can be managed without requiring SSH access to the VM host. LXD are remotely accessed via secure HTTP transport, which provides better security for LXD-based VMs. In addition, LXD has a better API, and is part of a much larger constellation of enterprise software, offering a wider range of future features and use cases.
[/tab]
[/tabs]
