<!-- Power drivers -->
To manage a machine, MAAS must be able to power cycle it, usually through the machine's [BMC](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface#Baseboard_management_controller)`↗` card.  Until you configure the power type, a newly-added machine can't be enlisted and used by MAAS.

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages"]
<a href="#heading--about-ipmi-cipher-suites"><h2 id="heading--about-ipmi-cipher-suites">About IPMI cipher suites</h2></a>

We require the user to explicitly set the cipher suite due to the fact that one BMC’s order is different from another, leading to erroneous discovery. You can explicitly select which cipher suite to use when interacting with a BMC. You do this by selecting the cipher suite in power configuration.  By default, the cipher suite is 3. This is the least secure suite. It is up to you to select a more secure suite if supported and desired.
[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
<a href="#heading--about-ipmi-cipher-suites"><h2 id="heading--about-ipmi-cipher-suites">About IPMI cipher suites</h2></a>

When using IPMI, MAAS will attempt to automatically detect the correct cipher suite. MAAS tries to find the most secure cipher suite available. Preference order is 17, 3, 8, 12. If auto-detection fails MAAS will fall back to using freeipmi-tool default, 3, which is what previous versions of MAAS use.

<a href="#heading--about-redfish-support"><h2 id="heading--about-redfish-support">About better Redfish support in MAAS 3.2</h2></a>

MAAS 3.2 enhances support for Redfish as a BMC protocol by preferring Redfish over IPMI, provided that:

- The BMC has a Redfish Host Interface enabled
- That host interface can be accessed by the MAAS host

MAAS has already supported Redfish for some time.  MAAS 3.2 adds the capability to auto-detect Redfish and prefer it as the BMC protocol, if it's present and enabled.

<a href="#heading--about-redfish"><h3 id="heading--about-redfish">About Redfish</h3></a>

Redfish is an [alternative to the IPMI protocol](https://www.dmtf.org/sites/default/files/Redfish_Tech_Note-November_2018.pdf)`↗` for connecting with machine BMCs.  It provides additional features above and beyond those provided by IPMI; eventually, Redfish should supplant IPMI as the default BMC interface.

<a href="#heading--about-redfish-with-maas"><h3 id="heading--about-redfish-with-maas">About the MAAS implementation of Redfish</h3></a>

A machine that isn’t registered in MAAS – but connected to the MAAS PXE network – can be powered on manually and made to network boot. The machine boots into an ephemeral environment to gather information about the machine. A script inside that environment registers the machine in MAAS.

Prior to MAAS 3.2, all such BMC connections were made via IPMI.  With the release of 3.2, if the machine uses either IPMI or Redfish for its BMC, the ephemeral environment will automatically detect it, create a separate user for MAAS and configure the machine, so that MAAS may check and control the machine’s power status.

Redfish can be detected and configured only if the BMC has a Redfish Host Interface enabled and exposed to the host. Redfish is preferred if the machine supports both Redfish and IPMI.

[note]
The name of the user that MAAS creates in the BMC is controlled by the maas_auto_ipmi_user config setting both for IPMI and Redfish; nothing has changed in this regard with the addition of Redfish support.
[/note]

<a href="#heading--about-enabling-redfish"><h3 id="heading--about-enabling-redfish">About enabling Redfish</h3></a>

There are ways to check whether Redfish is properly enabled.  You can check whether or not a machine can communicate via Redfish with the command: 

```nohighlight
dmidecode -t 42
```

If the machine has been enlisted by MAAS, you can also check the output of the `30-maas-01-bmc-config` commissioning script to discover this.
[/tab]
[/tabs]

