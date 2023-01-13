<!-- "MAAS technical reference" -->

<a href="#heading--Technical-reference-topics"><h2 id="heading--Technical-reference-topics">Technical reference topics</h2></a>

The following technical topics may be useful as you operate and administer MAAS:

- [Commissioning scripts](/t/-/5375): This article provides technical details about commissioning scripts. 
- [Hardware test scripts](/t/-/5392): This article enumerates and describes the various hardware tests you can engage when commissioning a machine.
- [Audit event logs](/t/-/5256): Audit events are a subset of the MAAS event logs. This article will provide reference material for those who want to review and report on events designated as MAAS audit events.
- [MAAS performance](/t/-/6178): The MAAS engineering team actively works to improve the performance of MAAS.  This article documents those efforts and provides benchmarks.
- [Power management](/t/-/5246): To manage a machine, MAAS must be able to power cycle it, usually through the machine’s BMC card. Until you configure the power type, a newly-added machine can’t be enlisted and used by MAAS. Often, choosing the right power driver is half the battle; this article can help.
- [Storage layouts](/t/-/5973): There are several possible MAAS storage layouts, including flat, LVM, bcache, VMFS6, and the generic "blank" layout.  This article provides details and technical specifications on these layouts.
- [MAAS Terraform provider](/t/-/6327): This article provides a pure reference on the MAAS Terraform provider, in terms of data sources and resources available through that provider, along with HCL examples culled from the source.