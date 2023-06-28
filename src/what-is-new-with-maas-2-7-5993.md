<!-- What is new with MAAS 2 7 -->

<a href="#heading--MAAS-2-7-3-released"><h2 id="heading--MAAS-2-7-3-released">MAAS 2.7.3 released</h2></a>

On 24 August 2020, MAAS 2.7.3 was released, replacing the `2.7/stable` channel in snap and the [ppa:maas/2.7](https://launchpad.net/~maas/+archive/ubuntu/2.7)`↗`.  You can update your 2.7 release to 2.7.3 by with:

    snap refresh --channel=2.7/stable

or by using the aforementioned PPA.  The focus for this release has been [bugfixing](https://launchpad.net/maas/+milestone/2.7.3rc1)`↗` -- there were no changes to MAAS since RC1.

Thanks to everyone who reported the issues with previous 2.7 releases and helped us with the logs.

<a href="#heading--MAAS-2-7-2-released"><h2 id="heading--MAAS-2-7-2-released">MAAS 2.7.2 released</h2></a>

On 30 July 2020, MAAS 2.7.2 was released, replacing the `2.7/stable` channel in snap and the [ppa:maas/2.7](https://launchpad.net/~maas/+archive/ubuntu/2.7)`↗`.  You can update your 2.7 release to 2.7.2 by with:

    snap refresh --channel=2.7/stable

or by using the aforementioned PPA.  The focus for this release has been [bugfixing](https://launchpad.net/maas/+milestone/2.7.2rc1)`↗` -- there were no changes to MAAS since RC1.

Thanks to everyone who reported the issues with previous 2.7 releases and helped us with the logs.

<a href="#heading--upgrade-2-6-to-2-7-snap"><h2 id="heading--upgrade-2-6-to-2-7-snap">Upgrading from MAAS 2.6 snap</h2></a> 

If you are using the MAAS 2.6 snap, which had to be installed with `--devmode`, you can update to 2.7 with the following parameters:

    snap refresh maas --devmode --channel=2.7

Be aware that you will still be in `--devmode`, which means the snap won't automatically upgrade.  You'll have to check manually for updates (via `snap refresh`).  Once you’re upgraded to MAAS 2.7 using this method, future snap updates won’t require the devmode parameter. So, for example, when a later version of 2.7 (or even 2.8) is released, you will be able to `snap refresh` to those channels and get out of devmode.  Once refreshed out of devmode in this way, you'll get updates for point releases automatically.

An alternative to avoid devmode would be to do a clean install of MAAS 2.7, that is, removing 2.6 with `snap remove maas` and reinstalling MAAS 2.7 with:

    snap install --channel=2.7 maas

Note that you can check the devmode status of your snap with:

    snap list maas


---

<a href="#heading--MAAS-2-7-released"><h2 id="heading--MAAS-2-7-released">MAAS 2.7 released</h2></a>

Following on from MAAS 2.6.2, we are happy to announce that MAAS 2.7 is now available. This release features some critical bug fixes, along with some exciting new features:

<a href="#heading--CentOS-8-image-support"><h3 id="heading--CentOS-8-image-support">CentOS 8 image support</h3></a>

Users can now deploy CentOS 8 images in MAAS. The Images page in the MAAS UI will now offer a choice to select and download CentOS 8. Note that users of previous versions may see CentOS 8 as an available option, but cannot download or deploy it.

<a href="#heading--Network-testing-features"><h3 id="heading--Network-testing-features">Network testing features</h3></a>

MAAS 2.7 brings a slate of new network testing and link detection features, as detailed below.

<a href="#heading--Network-link-disconnect-detection"><h4 id="heading--Network-link-disconnect-detection">Network link disconnect detection</h4></a>

MAAS 2.7 can check whether links are connected or disconnected. Previously, when commissioning, you couldn’t detect unplugged cables. Now you can. You will have to take a couple of steps for existing MAAS deployments: First, you will have to upgrade to 2.7, then run commissioning again to see if a link is disconnected. But you no longer have to puzzle over what’s broken when this happens.

MAAS will report disconnected network cables, and users will receive a warning when trying to configure a disconnected interface. Administrators will be able to change cable connection status through both API and UI after manually rectifying the situation.

<a href="#heading--Slow-network-link-detection"><h4 id="heading--Slow-network-link-detection">Slow network link detection</h4></a>

MAAS 2.7 makes sure you’re getting the most out of your link speed. As servers and hardware get faster — 10G, 40G, even 100G NICS — the chances increase that you might plug your 10G NIC into a 1G switch, for example. Previously, with MAAS, you’d be stuck with the speed of the slowest link, but there wasn’t a way to verify your link speed without recommissioning. Depending on your physical hardware, that might still be an issue, but the MAAS UI can now warn you if your interface is connected to a link slower than what the interface supports. And all information shown in the UI is available via the API, as well. You can still replace a slow switch without recommissioning.

MAAS will automatically detect link and interface speed during commissioning and report them via the API/UI. Administrators will be able to change or update the link and interface speeds via the API/UI after manual changes to the connection. MAAS 2.7 will also report link speed, allowing users to filter and list machines by their link speed in the UI. Users can also employ this information to allocate machines by their link speed in the API.

<a href="#heading--Network-validation-scripts-and-testing"><h4 id="heading--Network-validation-scripts-and-testing">Network validation scripts and testing</h4></a>

MAAS 2.7 allows you to configure network connectivity testing in a number of ways. If you’ve used MAAS, you know that if it can’t connect to the rack controller, deployment can’t complete. Now MAAS can check connectivity to the rack controller and warn you if there’s no link, long before you have to try and debug it. For example, if you can’t connect to your gateway controller, traffic can’t leave your network. MAAS can now check this link and recognise that there’s no connectivity, which alleviates a lot of annoying (and sometimes hard-to-detect) network issues.

Users can now test their network configuration to check for:

- Interfaces which have a broken network configuration
- Bonds that are not fully operational
- Broken gateways, rack controllers, and Internet links

In addition, Internet connectivity testing has been greatly expanded. Previously, MAAS gave a yes/no link check during network testing. Now you can give a list of URLs or IP addresses to check. In the ephemeral environment, standard DHCP is still applied, but when network testing runs, we can apply your specific configuration for the duration of the test. While all URLs / IPs are tested with all interfaces, we do test each of your interfaces individually, including breaking apart bonded NICS and testing each side of your redundant interfaces. You can also run different tests on each pass, e.g., a different set of URLs, although each run would be a different testing cycle. For testing individual interfaces, you can use the API.

Of course, the main network feature available in 2.7 is improved — and customisable — network testing. You can now create your own commissioning scripts and tests related to networking. You can create your own network tests (e.g., a network throughput test) and run them during the network testing portion of the MAAS workflow. There are no particular restrictions on these scripts, so you can test a wide variety of possible conditions and situations.

Administrators can upload network tests and test scripts, as well as create tests which accept an interface parameter, or scripts which apply custom network configurations. Users can then specify (unique) parameters using the API, override machines which fail network testing (allowing their use), and suppress individual failed network tests. All users benefit from enhanced reporting, as they are now able to see the overall status of all interfaces via the API, the UI Machine list, and the UI Interfaces tab; review the health status from all interface tests; and view the interface test results by interface name and MAC.

<a href="#heading--Live-IP-address-detection-to-prevent-address-conflicts"><h4 id="heading--Live-IP-address-detection-to-prevent-address-conflicts">Live IP address detection to prevent address conflicts</h4></a>

In some cases, MAAS connects with subnet which are not empty. Normally, the user has to tell MAAS about IP addresses which are already assigned on that subnet, and if that step is skipped, MAAS may assign and in-use IP address to one of the machines under its control, leading to an IP conflict.

MAAS 2.7 alleviates this problem by detecting IPs in use on a subnet, so that it can avoid assigning that IP to a MAAS-managed machine. The system is not perfect; for example, if NIC on a subnet-connected machine is in a quiescent state -- or turned off -- MAAS may not detect it before duplicating the IP. Note that at least one rack controller must have access to the previously-assigned machine in order for this feature to work. MAAS 2.7 will also recognise when the subnet ARP cache is full and re-check the oldest IPs added to the cache to search for free IP addresses.

<a href="#heading--Introductory-NUMA-/-SR-IOV-support"><h3 id="heading--Introductory-NUMA-/-SR-IOV-support">Introductory NUMA / SR-IOV support</h3></a>

NUMA (Non-Uniform Memory Access) is a useful way of achieving high-efficiency computing, by pairing a CPU core with a very fast connection to RAM and PCI buses. Typically the CPU socket and the closest banks of DIMM constitute a NUMA node. Obviously, if you’re deploying a MAAS machine under NUMA to get maximum performance, you would like for that machine to be confined to a single NUMA node. MAAS 2.7 introduces this capability.

MAAS will display the NUMA node index and details. Users can also see the count of available NUMA nodes, along with CPU cores, memory, NICS, and node spans for bonds and block devices (although node-spanning may not produce suitable performance). From a reporting standpoint, users can filter machines by CPU cores, memory, subnet, VLAN, fabric, space, storage, and RAID.

Similarly, the SR-IOV (Single Root I/O Virtualisation) allows a PCIe device (e.g, a NIC) to appear to be multiple separate devices. A network adaptor can be subdivided into multiple adaptors by adding a Virtual Function (VF). MAAS 2.7 supports the use of multiple VF adaptors to intelligently use SR-IOV edge clouds, by allowing users to see that a NIC supports SR-IOV, along with the supported VF counts.

The goal of this feature is to help users choose the right machine to deploy an edge cloud.

<a href="#heading--Settings-and-user-preferences-redesign"><h3 id="heading--Settings-and-user-preferences-redesign">Settings and user preferences redesign</h3></a>

As part of our efforts to make the UI faster and more responsive, we have completely redesigned the Settings and User preferences within the MAAS UI.

<a href="#heading--Strictly-confined-Snap-support"><h3 id="heading--Strictly-confined-Snap-support">Strictly-confined Snap support</h3></a>

With 2.7, MAAS is fully confined within the Snap container. No need for installation qualifiers (such as “--devmode”) to permit use of external resources, i.e., outside the Snap container. This means that we will begin to transition to recommending the Snap install as the default (and primary) MAAS install method. This also means that MAAS now gains the benefit of confined snap security features.

<a href="#heading--Update-to-hardware-information-gathering-methods"><h3 id="heading--Update-to-hardware-information-gathering-methods">Update to hardware information gathering methods</h3></a>

MAAS has switched hardware information gathering from lshw/lsblk to lxd output during commissioning, because it more easily provides the information needed to complete resource discovery. Note that this information may not be particularly reliable for your use, so you may need to create your own commissioning scripts if you need something more detailed or specific.

<a href="#heading--Bug-fixes"><h3 id="heading--Bug-fixes">Bug fixes</h3></a>

A number of bug fixes (see the [list in Launchpad](https://bugs.launchpad.net/maas/+bugs?field.milestone%3Alist=87757&field.milestone%3Alist=89662&field.milestone%3Alist=89714&field.milestone%3Alist=89840&field.milestone%3Alist=89954&field.milestone%3Alist=89682&field.status%3Alist=FIXRELEASED))`↗`.
