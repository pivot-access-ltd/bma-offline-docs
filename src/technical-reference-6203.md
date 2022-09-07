<!-- "MAAS technical reference" -->

<a href="#heading--Technical-reference-topics"><h2 id="heading--Technical-reference-topics">Technical reference topics</h2></a>

The following technical topics may be useful as you operate and administer MAAS:

- [Audit event logs](/t/-/5256): Audit events are a subset of the MAAS event logs. This article will provide reference material for those who want to review and report on events designated as MAAS audit events.
- [Commissioning scripts](/t/-/5375): This article provides technical details about commissioning scripts. 
- [Hardware test scripts](/t/-/5392): This article enumerates and describes the various hardware tests you can engage when commissioning a machine.
- [Log files](/t/-/5240): MAAS has a robust logging capability, which presents several different views, including a number of node-specific log files and several syslogd-style text logs. Each of these logs provides different information, or at the very least, different views of the same information. MAAS gathers logging information about the various MAAS states and records both automated and user-driven actions.
- [MAAS performance](/t/-/6178): The MAAS engineering team actively works to improve the performance of MAAS.  This article documents those efforts and provides benchmarks.
- [Power management](/t/-/5246): To manage a machine, MAAS must be able to power cycle it, usually through the machine’s BMC card. Until you configure the power type, a newly-added machine can’t be enlisted and used by MAAS. Often, choosing the right power driver is half the battle; this article can help.
- [Storage layouts](/t/-/5973): There are several possible MAAS storage layouts, including flat, LVM, bcache, VMFS6, and the generic "blank" layout.  This article provides details and technical specifications on these layouts.

You may also wish to consult the permuted index, below.

<a href="#heading--Technical-reference-permuted-index"><h2 id="heading--Technical-reference-permuted-index">Technical reference permuted index</h2></a>

| | |
|----:|:-----|
| [15000](/t/power-management-reference/5246#heading--sm15k) |SeaMicro |
| [3.2](/t/power-management-reference/5246#heading--about-redfish-support) |About better Redfish support in MAAS |
| [About better Redfish support in MAAS 3.2](/t/power-management-reference/5246#heading--about-redfish-support) | |
| [About enabling Redfish](/t/power-management-reference/5246#heading--about-enabling-redfish) | |
| [About IPMI cipher suites](/t/power-management-reference/5246#heading--about-ipmi-cipher-suites) | |
| [About MAAS audit events](/t/audit-event-log-reference/5256#heading--about-maas-audit-events) | |
| [About Redfish](/t/power-management-reference/5246#heading--about-redfish) | |
| [About the MAAS implementation of Redfish](/t/power-management-reference/5246#heading--about-redfish-with-maas) | |
| [About the syslog logging path](/t/maas-logging-reference/5240#heading--path) | |
| [Access the HMC and login to the IBM Z](/t/power-management-reference/5246#heading--ibm-z-login) | |
| [a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-networking) |Set up IBM Z networking for |
| [a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) |Set up a suitable IBM Z partition for |
| [a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-storage) |Set up IBM Z storage for |
| [a machine's power type](/t/power-management-reference/5246#heading--config-power-type) |How to configure |
| [American Power Conversion (APC) PDU](/t/power-management-reference/5246#heading--apc) | |
| [AMT](/t/power-management-reference/5246#heading--amt) |Intel |
| [and login to the IBM Z](/t/power-management-reference/5246#heading--ibm-z-login) |Access the HMC |
| [and use IBM Z with MAAS](/t/power-management-reference/5246#heading--configure-use-ibm-z) |How to configure |
| [(APC) PDU](/t/power-management-reference/5246#heading--apc) |American Power Conversion |
| [a remote syslog server](/t/maas-logging-reference/5240#heading--using-a-remote-syslog-server) |How to use |
| [are supported](/t/power-management-reference/5246#heading--bmc-driver-support) |Which BMC drivers |
| [a suitable IBM Z partition for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) |Set up |
| [audit events](/t/audit-event-log-reference/5256#heading--about-maas-audit-events) |About MAAS |
| [Available test scripts reference](/t/hardware-test-scripts-reference/5392#heading--included-scripts) | |
| [bcache storage layout reference](/t/storage-layouts-reference/5973#heading--bcache-storage-layout-reference) | |
| [better Redfish support in MAAS 3.2](/t/power-management-reference/5246#heading--about-redfish-support) |About |
| [Blank storage layout reference](/t/storage-layouts-reference/5973#heading--blank-storage-layout-reference) | |
| [BMC drivers are supported](/t/power-management-reference/5246#heading--bmc-driver-support) |Which |
| [boot parameters](/t/power-management-reference/5246#heading--set-the-boot-parameters) |Set the partition |
| [catalogue](/t/power-management-reference/5246#heading--power-catalogue) |Power |
| [Chassis Manager](/t/power-management-reference/5246#heading--mscm) |HP Moonshot - iLO |
| [- Chassis Manager](/t/power-management-reference/5246#heading--mscm) |Microsoft OCS |
| [Chassis Manager](/t/power-management-reference/5246#heading--mscm) |Microsoft OCS - |
| [Christmann RECS-Box Power Driver](/t/power-management-reference/5246#heading--recs_box) | |
| [cipher suites](/t/power-management-reference/5246#heading--about-ipmi-cipher-suites) |About IPMI |
| [Cisco UCS Manager](/t/power-management-reference/5246#heading--ucsm) | |
| [Commissioning script example: Configure HPA](/t/commissioning-scripts-reference/5375#heading--commissioning-script-example-configure-hpa) | |
| [Commissioning script example: Update firmware](/t/commissioning-scripts-reference/5375#heading--commissioning-script-example-update-firmware) | |
| [configuration](/t/power-management-reference/5246#heading--manual) |Manual power |
| [configure a machine's power type](/t/power-management-reference/5246#heading--config-power-type) |How to |
| [configure and use IBM Z with MAAS](/t/power-management-reference/5246#heading--configure-use-ibm-z) |How to |
| [Configure HPA](/t/commissioning-scripts-reference/5375#heading--commissioning-script-example-configure-hpa) |Commissioning script example: |
| [Console (HMC)](/t/power-management-reference/5246#heading--hmc) |IBM Hardware Management |
| [Conversion (APC) PDU](/t/power-management-reference/5246#heading--apc) |American Power |
| [CPU stress test](/t/hardware-test-scripts-reference/5392#heading--hardware-test-script-example-cpu-stress-test) |Hardware test script example: |
| [Digital Loggers, Inc. PDU](/t/power-management-reference/5246#heading--dli) | |
| [drivers are supported](/t/power-management-reference/5246#heading--bmc-driver-support) |Which BMC |
| [Driver](/t/power-management-reference/5246#heading--openbmc) |OpenBMC Power |
| [Driver](/t/power-management-reference/5246#heading--recs_box) |Christmann RECS-Box Power |
| [Eaton PDU](/t/power-management-reference/5246#heading--eaton) | |
| [enabling Redfish](/t/power-management-reference/5246#heading--about-enabling-redfish) |About |
| [enlistment](/t/power-management-reference/5246#heading--set-up-ibm-z-enlistment) |Set up your IBM Z virtual machine for |
| [Environment variable reference](/t/commissioning-scripts-reference/5375#heading--environment-variable-reference) | |
| [Evaluate IBM Z requirements](/t/power-management-reference/5246#heading--ibm-z-requirements) | |
| [events](/t/audit-event-log-reference/5256#heading--about-maas-audit-events) |About MAAS audit |
| [example: Configure HPA](/t/commissioning-scripts-reference/5375#heading--commissioning-script-example-configure-hpa) |Commissioning script |
| [example: CPU stress test](/t/hardware-test-scripts-reference/5392#heading--hardware-test-script-example-cpu-stress-test) |Hardware test script |
| [example: Update firmware](/t/commissioning-scripts-reference/5375#heading--commissioning-script-example-update-firmware) |Commissioning script |
| [Facebook's Wedge](/t/power-management-reference/5246#heading--wedge) | |
| [field reference](/t/commissioning-scripts-reference/5375#heading--metadata-field-reference) |Metadata |
| [firmware](/t/commissioning-scripts-reference/5375#heading--commissioning-script-example-update-firmware) |Commissioning script example: Update |
| [Flat layout storage reference](/t/storage-layouts-reference/5973#heading--flat-storage-layout-reference) | |
| [for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-networking) |Set up IBM Z networking |
| [for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) |Set up a suitable IBM Z partition |
| [for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-storage) |Set up IBM Z storage |
| [for enlistment](/t/power-management-reference/5246#heading--set-up-ibm-z-enlistment) |Set up your IBM Z virtual machine |
| [guide](/t/power-management-reference/5246#heading--power-management-reference) |Power management reference |
| [Hardware Management Console (HMC)](/t/power-management-reference/5246#heading--hmc) |IBM |
| [Hardware test script example: CPU stress test](/t/hardware-test-scripts-reference/5392#heading--hardware-test-script-example-cpu-stress-test) | |
| [HMC and login to the IBM Z](/t/power-management-reference/5246#heading--ibm-z-login) |Access the |
| [(HMC)](/t/power-management-reference/5246#heading--hmc) |IBM Hardware Management Console |
| [How to configure a machine's power type](/t/power-management-reference/5246#heading--config-power-type) | |
| [How to configure and use IBM Z with MAAS](/t/power-management-reference/5246#heading--configure-use-ibm-z) | |
| [How to use a remote syslog server](/t/maas-logging-reference/5240#heading--using-a-remote-syslog-server) | |
| [How to use the virsh power type](/t/power-management-reference/5246#heading--example-virsh-kvm-power-type) | |
| [HPA](/t/commissioning-scripts-reference/5375#heading--commissioning-script-example-configure-hpa) |Commissioning script example: Configure |
| [HP Moonshot - iLO4 (IPMI)](/t/power-management-reference/5246#heading--moonshot) | |
| [HP Moonshot - iLO Chassis Manager](/t/power-management-reference/5246#heading--mscm) | |
| [IBM Hardware Management Console (HMC)](/t/power-management-reference/5246#heading--hmc) | |
| [IBM Z networking for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-networking) |Set up |
| [IBM Z partition for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) |Set up a suitable |
| [IBM Z requirements](/t/power-management-reference/5246#heading--ibm-z-requirements) |Evaluate |
| [IBM Z storage for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-storage) |Set up |
| [IBM Z](/t/power-management-reference/5246#heading--ibm-z-login) |Access the HMC and login to the |
| [IBM Z virtual machine for enlistment](/t/power-management-reference/5246#heading--set-up-ibm-z-enlistment) |Set up your |
| [IBM Z with MAAS](/t/power-management-reference/5246#heading--configure-use-ibm-z) |How to configure and use |
| [- iLO4 (IPMI)](/t/power-management-reference/5246#heading--moonshot) |HP Moonshot |
| [iLO4 (IPMI)](/t/power-management-reference/5246#heading--moonshot) |HP Moonshot - |
| [- iLO Chassis Manager](/t/power-management-reference/5246#heading--mscm) |HP Moonshot |
| [iLO Chassis Manager](/t/power-management-reference/5246#heading--mscm) |HP Moonshot - |
| [implementation of Redfish](/t/power-management-reference/5246#heading--about-redfish-with-maas) |About the MAAS |
| [Inc. PDU](/t/power-management-reference/5246#heading--dli) |Digital Loggers, |
| [in MAAS 3.2](/t/power-management-reference/5246#heading--about-redfish-support) |About better Redfish support |
| [Intel AMT](/t/power-management-reference/5246#heading--amt) | |
| [IPMI cipher suites](/t/power-management-reference/5246#heading--about-ipmi-cipher-suites) |About |
| [IPMI](/t/power-management-reference/5246#heading--ipmi) | |
| [(IPMI)](/t/power-management-reference/5246#heading--moonshot) |HP Moonshot - iLO4 |
| [KVM](/t/power-management-reference/5246#heading--virsh) |virsh - libvirt |
| [layout reference](/t/storage-layouts-reference/5973#heading--bcache-storage-layout-reference) |bcache storage |
| [layout reference](/t/storage-layouts-reference/5973#heading--blank-storage-layout-reference) |Blank storage |
| [layout reference](/t/storage-layouts-reference/5973#heading--lvm-storage-layout-reference) |LVM storage |
| [layout reference](/t/storage-layouts-reference/5973#heading--vmfs6-storage-layout-reference) |VMFS6 storage |
| [layout storage reference](/t/storage-layouts-reference/5973#heading--flat-storage-layout-reference) |Flat |
| [- libvirt KVM](/t/power-management-reference/5246#heading--virsh) |virsh |
| [libvirt KVM](/t/power-management-reference/5246#heading--virsh) |virsh - |
| [Loggers, Inc. PDU](/t/power-management-reference/5246#heading--dli) |Digital |
| [logging path](/t/maas-logging-reference/5240#heading--path) |About the syslog |
| [login to the IBM Z](/t/power-management-reference/5246#heading--ibm-z-login) |Access the HMC and |
| [LVM storage layout reference](/t/storage-layouts-reference/5973#heading--lvm-storage-layout-reference) | |
| [LXD VMs](/t/power-management-reference/5246#heading--lxd) | |
| [MAAS 3.2](/t/power-management-reference/5246#heading--about-redfish-support) |About better Redfish support in |
| [MAAS audit events](/t/audit-event-log-reference/5256#heading--about-maas-audit-events) |About |
| [MAAS implementation of Redfish](/t/power-management-reference/5246#heading--about-redfish-with-maas) |About the |
| [MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-networking) |Set up IBM Z networking for a |
| [MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) |Set up a suitable IBM Z partition for a |
| [MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-storage) |Set up IBM Z storage for a |
| [MAAS](/t/power-management-reference/5246#heading--configure-use-ibm-z) |How to configure and use IBM Z with |
| [machine for enlistment](/t/power-management-reference/5246#heading--set-up-ibm-z-enlistment) |Set up your IBM Z virtual |
| [machine's power type](/t/power-management-reference/5246#heading--config-power-type) |How to configure a |
| [machine](/t/power-management-reference/5246#heading--set-up-ibm-z-networking) |Set up IBM Z networking for a MAAS |
| [machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) |Set up a suitable IBM Z partition for a MAAS |
| [machine](/t/power-management-reference/5246#heading--set-up-ibm-z-storage) |Set up IBM Z storage for a MAAS |
| [Management Console (HMC)](/t/power-management-reference/5246#heading--hmc) |IBM Hardware |
| [management reference guide](/t/power-management-reference/5246#heading--power-management-reference) |Power |
| [Manager](/t/power-management-reference/5246#heading--mscm) |HP Moonshot - iLO Chassis |
| [Manager](/t/power-management-reference/5246#heading--mscm) |Microsoft OCS - Chassis |
| [Manager](/t/power-management-reference/5246#heading--ucsm) |Cisco UCS |
| [Manual power configuration](/t/power-management-reference/5246#heading--manual) | |
| [Metadata field reference](/t/commissioning-scripts-reference/5375#heading--metadata-field-reference) | |
| [Microsoft OCS - Chassis Manager](/t/power-management-reference/5246#heading--mscm) | |
| [Moonshot - iLO4 (IPMI)](/t/power-management-reference/5246#heading--moonshot) |HP |
| [Moonshot - iLO Chassis Manager](/t/power-management-reference/5246#heading--mscm) |HP |
| [networking for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-networking) |Set up IBM Z |
| [Nova](/t/power-management-reference/5246#heading--nova) |OpenStack |
| [OCS - Chassis Manager](/t/power-management-reference/5246#heading--mscm) |Microsoft |
| [of Redfish](/t/power-management-reference/5246#heading--about-redfish-with-maas) |About the MAAS implementation |
| [OpenBMC Power Driver](/t/power-management-reference/5246#heading--openbmc) | |
| [OpenStack Nova](/t/power-management-reference/5246#heading--nova) | |
| [Parameter reference](/t/commissioning-scripts-reference/5375#heading--parameter-reference) | |
| [parameters](/t/power-management-reference/5246#heading--set-the-boot-parameters) |Set the partition boot |
| [partition boot parameters](/t/power-management-reference/5246#heading--set-the-boot-parameters) |Set the |
| [partition for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) |Set up a suitable IBM Z |
| [path](/t/maas-logging-reference/5240#heading--path) |About the syslog logging |
| [PDU](/t/power-management-reference/5246#heading--apc) |American Power Conversion (APC) |
| [PDU](/t/power-management-reference/5246#heading--dli) |Digital Loggers, Inc. |
| [PDU](/t/power-management-reference/5246#heading--eaton) |Eaton |
| [Power catalogue](/t/power-management-reference/5246#heading--power-catalogue) | |
| [power configuration](/t/power-management-reference/5246#heading--manual) |Manual |
| [Power Conversion (APC) PDU](/t/power-management-reference/5246#heading--apc) |American |
| [Power Driver](/t/power-management-reference/5246#heading--openbmc) |OpenBMC |
| [Power Driver](/t/power-management-reference/5246#heading--recs_box) |Christmann RECS-Box |
| [Power management reference guide](/t/power-management-reference/5246#heading--power-management-reference) | |
| [power type](/t/power-management-reference/5246#heading--config-power-type) |How to configure a machine's |
| [power type](/t/power-management-reference/5246#heading--example-virsh-kvm-power-type) |How to use the virsh |
| [Proxmox](/t/power-management-reference/5246#heading--proxmox) | |
| [RECS-Box Power Driver](/t/power-management-reference/5246#heading--recs_box) |Christmann |
| [Redfish support in MAAS 3.2](/t/power-management-reference/5246#heading--about-redfish-support) |About better |
| [Redfish](/t/power-management-reference/5246#heading--about-enabling-redfish) |About enabling |
| [Redfish](/t/power-management-reference/5246#heading--about-redfish) |About |
| [Redfish](/t/power-management-reference/5246#heading--about-redfish-with-maas) |About the MAAS implementation of |
| [Redfish](/t/power-management-reference/5246#heading--redfish) | |
| [reference guide](/t/power-management-reference/5246#heading--power-management-reference) |Power management |
| [reference](/t/commissioning-scripts-reference/5375#heading--environment-variable-reference) |Environment variable |
| [reference](/t/commissioning-scripts-reference/5375#heading--metadata-field-reference) |Metadata field |
| [reference](/t/commissioning-scripts-reference/5375#heading--parameter-reference) |Parameter |
| [reference](/t/hardware-test-scripts-reference/5392#heading--included-scripts) |Available test scripts |
| [reference](/t/storage-layouts-reference/5973#heading--bcache-storage-layout-reference) |bcache storage layout |
| [reference](/t/storage-layouts-reference/5973#heading--blank-storage-layout-reference) |Blank storage layout |
| [reference](/t/storage-layouts-reference/5973#heading--flat-storage-layout-reference) |Flat layout storage |
| [reference](/t/storage-layouts-reference/5973#heading--lvm-storage-layout-reference) |LVM storage layout |
| [reference](/t/storage-layouts-reference/5973#heading--vmfs6-storage-layout-reference) |VMFS6 storage layout |
| [remote syslog server](/t/maas-logging-reference/5240#heading--using-a-remote-syslog-server) |How to use a |
| [requirements](/t/power-management-reference/5246#heading--ibm-z-requirements) |Evaluate IBM Z |
| [script example: Configure HPA](/t/commissioning-scripts-reference/5375#heading--commissioning-script-example-configure-hpa) |Commissioning |
| [script example: CPU stress test](/t/hardware-test-scripts-reference/5392#heading--hardware-test-script-example-cpu-stress-test) |Hardware test |
| [script example: Update firmware](/t/commissioning-scripts-reference/5375#heading--commissioning-script-example-update-firmware) |Commissioning |
| [scripts reference](/t/hardware-test-scripts-reference/5392#heading--included-scripts) |Available test |
| [SeaMicro 15000](/t/power-management-reference/5246#heading--sm15k) | |
| [server](/t/maas-logging-reference/5240#heading--using-a-remote-syslog-server) |How to use a remote syslog |
| [Set the partition boot parameters](/t/power-management-reference/5246#heading--set-the-boot-parameters) | |
| [Set up a suitable IBM Z partition for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) | |
| [Set up IBM Z networking for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-networking) | |
| [Set up IBM Z storage for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-storage) | |
| [Set up your IBM Z virtual machine for enlistment](/t/power-management-reference/5246#heading--set-up-ibm-z-enlistment) | |
| [storage for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-storage) |Set up IBM Z |
| [storage layout reference](/t/storage-layouts-reference/5973#heading--bcache-storage-layout-reference) |bcache |
| [storage layout reference](/t/storage-layouts-reference/5973#heading--blank-storage-layout-reference) |Blank |
| [storage layout reference](/t/storage-layouts-reference/5973#heading--lvm-storage-layout-reference) |LVM |
| [storage layout reference](/t/storage-layouts-reference/5973#heading--vmfs6-storage-layout-reference) |VMFS6 |
| [storage reference](/t/storage-layouts-reference/5973#heading--flat-storage-layout-reference) |Flat layout |
| [stress test](/t/hardware-test-scripts-reference/5392#heading--hardware-test-script-example-cpu-stress-test) |Hardware test script example: CPU |
| [suitable IBM Z partition for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) |Set up a |
| [suites](/t/power-management-reference/5246#heading--about-ipmi-cipher-suites) |About IPMI cipher |
| [supported](/t/power-management-reference/5246#heading--bmc-driver-support) |Which BMC drivers are |
| [support in MAAS 3.2](/t/power-management-reference/5246#heading--about-redfish-support) |About better Redfish |
| [syslog logging path](/t/maas-logging-reference/5240#heading--path) |About the |
| [syslog server](/t/maas-logging-reference/5240#heading--using-a-remote-syslog-server) |How to use a remote |
| [test script example: CPU stress test](/t/hardware-test-scripts-reference/5392#heading--hardware-test-script-example-cpu-stress-test) |Hardware |
| [test scripts reference](/t/hardware-test-scripts-reference/5392#heading--included-scripts) |Available |
| [test](/t/hardware-test-scripts-reference/5392#heading--hardware-test-script-example-cpu-stress-test) |Hardware test script example: CPU stress |
| [the HMC and login to the IBM Z](/t/power-management-reference/5246#heading--ibm-z-login) |Access |
| [the IBM Z](/t/power-management-reference/5246#heading--ibm-z-login) |Access the HMC and login to |
| [the MAAS implementation of Redfish](/t/power-management-reference/5246#heading--about-redfish-with-maas) |About |
| [the partition boot parameters](/t/power-management-reference/5246#heading--set-the-boot-parameters) |Set |
| [the syslog logging path](/t/maas-logging-reference/5240#heading--path) |About |
| [the virsh power type](/t/power-management-reference/5246#heading--example-virsh-kvm-power-type) |How to use |
| [to configure a machine's power type](/t/power-management-reference/5246#heading--config-power-type) |How |
| [to configure and use IBM Z with MAAS](/t/power-management-reference/5246#heading--configure-use-ibm-z) |How |
| [to the IBM Z](/t/power-management-reference/5246#heading--ibm-z-login) |Access the HMC and login |
| [to use a remote syslog server](/t/maas-logging-reference/5240#heading--using-a-remote-syslog-server) |How |
| [to use the virsh power type](/t/power-management-reference/5246#heading--example-virsh-kvm-power-type) |How |
| [type](/t/power-management-reference/5246#heading--config-power-type) |How to configure a machine's power |
| [type](/t/power-management-reference/5246#heading--example-virsh-kvm-power-type) |How to use the virsh power |
| [UCS Manager](/t/power-management-reference/5246#heading--ucsm) |Cisco |
| [up a suitable IBM Z partition for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) |Set |
| [Update firmware](/t/commissioning-scripts-reference/5375#heading--commissioning-script-example-update-firmware) |Commissioning script example: |
| [up IBM Z networking for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-networking) |Set |
| [up IBM Z storage for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-storage) |Set |
| [up your IBM Z virtual machine for enlistment](/t/power-management-reference/5246#heading--set-up-ibm-z-enlistment) |Set |
| [use a remote syslog server](/t/maas-logging-reference/5240#heading--using-a-remote-syslog-server) |How to |
| [use IBM Z with MAAS](/t/power-management-reference/5246#heading--configure-use-ibm-z) |How to configure and |
| [use the virsh power type](/t/power-management-reference/5246#heading--example-virsh-kvm-power-type) |How to |
| [variable reference](/t/commissioning-scripts-reference/5375#heading--environment-variable-reference) |Environment |
| [virsh - libvirt KVM](/t/power-management-reference/5246#heading--virsh) | |
| [virsh power type](/t/power-management-reference/5246#heading--example-virsh-kvm-power-type) |How to use the |
| [virtual machine for enlistment](/t/power-management-reference/5246#heading--set-up-ibm-z-enlistment) |Set up your IBM Z |
| [VMFS6 storage layout reference](/t/storage-layouts-reference/5973#heading--vmfs6-storage-layout-reference) | |
| [VMs](/t/power-management-reference/5246#heading--lxd) |LXD |
| [VMware](/t/power-management-reference/5246#heading--vmware) | |
| [Webhook](/t/power-management-reference/5246#heading--webhook) | |
| [Wedge](/t/power-management-reference/5246#heading--wedge) |Facebook's |
| [Which BMC drivers are supported](/t/power-management-reference/5246#heading--bmc-driver-support) | |
| [with MAAS](/t/power-management-reference/5246#heading--configure-use-ibm-z) |How to configure and use IBM Z |
| [your IBM Z virtual machine for enlistment](/t/power-management-reference/5246#heading--set-up-ibm-z-enlistment) |Set up |
| [Z networking for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-networking) |Set up IBM |
| [Z partition for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-partition) |Set up a suitable IBM |
| [Z requirements](/t/power-management-reference/5246#heading--ibm-z-requirements) |Evaluate IBM |
| [Z storage for a MAAS machine](/t/power-management-reference/5246#heading--set-up-ibm-z-storage) |Set up IBM |
| [Z](/t/power-management-reference/5246#heading--ibm-z-login) |Access the HMC and login to the IBM |
| [Z virtual machine for enlistment](/t/power-management-reference/5246#heading--set-up-ibm-z-enlistment) |Set up your IBM |
| [Z with MAAS](/t/power-management-reference/5246#heading--configure-use-ibm-z) |How to configure and use IBM |