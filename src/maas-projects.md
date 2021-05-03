MAAS has the built-in capability to create and manage machine-related projects along several different dimensions.  There are ways to group, tag, and annotate machines, both persistent and runtime-only, including the capability of filtering machines to both limit the views and restrict actions to a specified subset of machines.  Also included is the capability to limit access against some of these project parameters with the RBAC tool.

This article will provide a technical explanation of projects and how they fit into the MAAS ecosystem. For a gentler slope, try the [MAAS project tutorial](/t/maas-project-tutorial/4478).

<!-- commented out until finished
  If you need just the technical details on these features, see the MAAS project technical reference.  To help you find what you need, there is also a permuted index of relevant project topics.
 commented out until finished -->

#### Topics you may want to pursue:

[What are the characteristics of a project, in this context?](#heading--projects)
[What are resource pools, and how do they work?](#heading--resource-pools)
[What are tags, and how do they work?](#heading--tags)
[What are workload annotations, and how do they work?](#heading--wla)
[What are static annotations (notes), and how do they work?](#heading--notes)
[What are LXD projects, and how do they work?](#heading--lxd-projects)
[Can you tie this all together with an example?](#heading--maas-project-example)

<a href="#heading--projects"><h2 id="heading--projects">Projects in the context of MAAS</h2></a>

In general, a project is an activity, system, or procedural control that is carefully planned, in advance, to satisfy a particular goal or aim.  Taken in the context of MAAS, that goal might be satisfying a Service-Level Agreement (SLA), meeting throughput requirements, or budgeting limited seats to a large organisation by quotas.  Essentially, the goal of a MAAS "project" is to budget resources that are finite and generally interchangeable to a series of user needs over a fixed period of time.  The success of a MAAS project can be measured against performance constraints, cost management goals, per-project limitations, or any other externally verifiable criteria.

To that extent, a MAAS project must be an organised effort, with a defined structure, driven by a clearly-defined opportunity, corporate goal, key performance indicator, need, or even a specific source of discomfort.  Organisation is especially important in large MAAS installations -- those with 100 to 1000+ machines -- where the idea of a closed structure with finite resources and limited time may seem so amorphous and malleable that machines can simply be created and destroyed at will.  Even in the largest MAAS instantiation, particular care must be taken to budget machines, to avoid unexpected conflicts and delays.

<a href="#heading--machines-vs-functions"><h3 id="heading--machines-vs-functions">Machines vs. functions</h3></a>

Matching machine functions to corporate needs is a balancing act, regardless of the apparent surplus of machines at any given moment.  Machines can be re-commissioned with different cloud-init scripts and deployed to any corporate function that their resources allow.  Machine functions, though, are driven by definite and specified requirements, over limited or prescribed life-cycles, to mutually-exclusive needs.  Once deployed, machines may not be interchangeable, and probably aren't available to be re-commissioned on a whim.

Using project thinking, it's possible to create an environment that delivers one or more services against business cases, uses cases, essential corporate functions, or SLAs.  This project environment can assure that well-separated services will match authorization levels, skill sets, access times, workload demand, and a large set of other factors that define a successful operation.  None of the elements of this environment are inherent in MAAS, but MAAS does provide some annotation tools that can help you create this environment:

* Resource pools are mutually-exclusive, one-to-one, persistent groups that can filter views and restrict actions, including limiting authorisations using RBAC.
* Tags are short, many-to-many, persistent markers that can filter views and restrict actions, but which do not influence authorisations.
* Workload annotations are volatile (runtime-only), unlimited, per-machine, key-value pairs that can filter views.
* Static annotations (notes) are persistent markers that can be visible in machine listings, and, if structured properly, can alert administrators and users to deeper information that may need review.

Together, these four elements combine to make a robust MAAS project-management toolbox.  This article will give you the theory behind these elements, and provide an example around which to discuss best practices.

<a href="#heading--resource-pools"><h2 id="heading--resource-pools">Resource pools</h2></a>

Resource pools are a designation, independent of machines, that can be used to logically group machine resources -- that is, machines and VM hosts -- around some particular category or characteristic.  These characteristics do not have to be parallel constructs, but they must be applied in a mutually-exclusive way.  Resource pools have a one-to-one relationship with machines: At any given time, a single machine can only be assigned to a single resource pool, although any number of machines can be assigned to the same resource pool.

Resource pools are persistent, in that a machine remains in its assigned resource pool until the pool is dissolved or the machine is moved to a different pool.  Pools can be reassigned at will. Machines which do not have an assigned resource pool belong to the "default" pool.  Resource pools have a name and a description.  RBAC authorization tools use resource pools to assign users, groups, and privileges.  

Resource pools are used to budget machines in whatever way makes sense to your organisation.  For example, resource pools could be assigned by function, by user population, by usage parameters, or whatever way you need to slice things up.  They can be used to filter machines, either for viewing or for applying bulk actions, making them an extremely flexible and powerful project management tool.

<a href="#heading--tags"><h2 id="heading--tags">Tags</h2></a>

Tags are short, descriptive, persistent labels that have a many-to-many relationship to machines.  Any tag can be assigned to any machine at any time.  Tags are similar to resource pools, in that they persist until changed or removed, but they differ in that they are intentionally short and have no ancillary description to explain their purpose.

Tags also differ from resource pools because they can be applied not just to machines, but also to interfaces and storage devices.  Like resource pools, tags can be used to filter views and action selections.  Tags are generally useful in representing metadata, that is, characteristics of the machine that might be important to some of your resource pools, but not unique.  For example, typical tags might include "in-the-clinic," "has_printer," or "requiresHardwareKey."  The possibilities are limited only by your imagination and needs.

<a href="#heading--tags-and-kernel-boot-options"><h3 id="heading--tags-and-kernel-boot-options">Tags can carry kernel options</h3></a>

Per-machine kernel boot options can be set, via tags, using the CLI. Per-machine boot options take precedence to global ones. Please also note that, even though a deployed machine has a `kernel_opt` tag applied, MAAS won't apply the `kernel_opt` associated with that tag until the next deployment.  This means that a machine that has been deployed for a long time can (possibly) inherit kernel options that were applied in the distant past.  If multiple tags attached to a machine have the `kernel_opts` defined, MAAS uses the first one found, in alphabetical order.

<a href="#heading--tags-and-xpath-entries"><h3 id="heading--tags-and-xpath-entries">Tags can bind XPATH entries</h3></a>

MAAS supports binding an XPath expressions to a tag using *tag definitions* (see below). This makes auto-assigning tags to matching hardware possible. For instance, you could tag machines that possess fast GPUs and then deploy software that used GPU-accelerated CUDA or OpenCL libraries.

A *tag definition* is the criteria by which machines are auto-labelled by the corresponding tag. During machine enlistment, MAAS collects hardware information (using the [lshw](http://ezix.org/project/wiki/HardwareLiSter) utility). The definition used in creating a tag is then constructed using an *XPath expression* based on that information. See [w3schools documentation](https://www.w3schools.com/xml/xpath_intro.asp) for details on XPath.

The collected data for each machine, viewable (in both XML and YAML) in the web UI, is inspected by you for the desired property. Building on the example alluded to above, a property can be a GPU with a clock speed greater than 1GHz. In this case, the following excerpt from a machine's data (in XML format) is pertinent:

``` nohighlight
      <lshw:node id="display" class="display" handle="PCI:0000:00:02.0">
       <lshw:description>VGA compatible controller</lshw:description>
       <lshw:product>GD 5446</lshw:product>
       <lshw:vendor>Cirrus Logic</lshw:vendor>
       <lshw:physid>2</lshw:physid>
       <lshw:businfo>pci@0000:00:02.0</lshw:businfo>
       <lshw:version>00</lshw:version>
       <lshw:width units="bits">32</lshw:width>
       <lshw:clock units="Hz">33000000</lshw:clock>
       <lshw:configuration>
        <lshw:setting id="latency" value="0"/>
       </lshw:configuration>
       <lshw:capabilities>
        <lshw:capability id="vga_controller"/>
       </lshw:capabilities>
       <lshw:resources>
        <lshw:resource type="memory" value="fc000000-fdffffff"/>
        <lshw:resource type="memory" value="febd0000-febd0fff"/>
        <lshw:resource type="memory" value="febc0000-febcffff"/>
       </lshw:resources>
      </lshw:node>
```

MAAS machines will be selected based on these four XPath *predicates*:

1.   *element* of 'node'
2.   with an *attribute* of 'id'
3.   whose *value* is 'display'
4.   and has a *child element* of 'clock units="Hz"'

After adding the speed criteria via an XPath *operator* we end up with this as our tag definition:

``` nohighlight
//node[@id="display"]/'clock units="Hz"' > 1000000000
```

<a href="#heading--tags-and-juju"><h3 id="heading--tags-and-juju">Juju support for tags</h3></a>

Because Juju is the recommended way to deploy services on machines managed by MAAS, it supports MAAS tags for application deployments. By specifying MAAS tags as Juju “constraints”, services can be deployed to machines that have particular user-defined characteristics.

<a href="#heading--wla"><h2 id="heading--wla">Workload annotations</h2></a>

Workload annotations are volatile, key-value pairs that can be assigned to operating machines (e.g., machines in the "deployed" state).  The can be used to group and potentially protect operating machines, independent of tags or resource pool assigned.

For example, a workload annotation might be something like, "owned by john smith, do not release without permission," "part of the Bismuth, ND, remote location," or "currently used for critical hurricane operations."  Workload annotations are many-to-many with machines, and, although volatile, can be used to filter views and actions on deployed machines.

[note]
Note that workload annotations are only available in MAAS versions 3.0 and above.
[/note]

<a href="#heading--notes"><h2 id="heading--notes">Static annotations (notes)</h2></a>

Static annotations, referred to as "notes" by MAAS, are persistent, in that they remain associated with a machine until changed.  They have a one-to-one relationship with machines: There can only be one note for a given machine, although the same note could be applied to other machines as well.  Notes can be lengthy, if desired, but only the first 10 characters or so will show up in the machine list.  For this reason, notes are best used for alerts, warnings, or other status notes (e.g., "WARNING: Do not use this machine for purpose X as it does not have enough disk space to support that application.")  In this example, "WARNING: Do..." would show up in the machine list, on the line for the machine in question.

<a href="#heading--lxd-projects"><h2 id="heading--lxd-projects">LXD projects</h2></em>

[LXD projects](https://ubuntu.com/tutorials/introduction-to-lxd-projects#1-overview) are a feature of the [LXD lightweight container hypervisor](https://ubuntu.com/server/docs/containers-lxd) -- a next-generation container manager which makes containers as easy to manage as virtual machines.  With LXD, you can create lots of containers, providing different services across many different use cases.  As a result of this flexibility, it can become confusing to keep track of exactly which containers are providing what services to answer which use case.

To help with this potential confusion, LXD provides a "projects" feature, which allows you to group one or more containers together into related projects.  These projects can be manipulated and managed with the same `lxc` tool used to manage the containers and virtual machines themselves.

Since MAAS makes use of LXD as a VM host, it's useful to be able to manipulate and manage projects not only through MAAS, but also directly through LXD.  In fact, to properly scope MAAS access to your LXD resources, it's essential that you understand how to use LXD projects in some detail.

[note]
Note that only MAAS versions 3.0 and above are aware of LXD projects.  Prior versions of MAAS do not work with LXD projects, and will commission all the available machines in your LXD instance.  The following section explains this in some detail.
[/note]

<a href="#heading--projects-history"><h3 id="heading--projects-history">How did we get here?</h3></a>

Prior to MAAS version 3.0, MAAS implemented LXD VM hosts, but did so in a strongly-coupled way; that is, MAAS essentially took control of the VMs, disallowing or overriding some direct LXD controls.  In a sense, MAAS became the owner, rather than simply a separate program, communicating interdependently with LXD to accomplish user purposes.

This was less than ideal.  For example, MAAS would discover all running LXD VMs and immediately commission them, essentially performing a "clean install" and wiping out their contents.  This behaviour isn't suitable when MAAS is connected to a deployed LXD with VMs already running services that may not have been targeted for enlistment by MAAS.

<a href="#heading--maas-control-at-project-level"><h4 id="heading--maas-control-at-project-level">MAAS now controls VMs at a project level</h4></a>

With the release of MAAS 3.0 version, MAAS now becomes a LXD tenant, rather than an owner. Essentially, MAAS 3.0 still commissions any VMs it discovers within a VM host, but the scope of the discovery is now limited to a single project.  That project can contain any subset of the existing VMs, from zero to all of them.  Any VM that's already in a project assigned to MAAS will still be re-commissioned, which is the normal behaviour of MAAS upon network discovery.

Here are the criteria which drove this decision:

* It should be possible for an administrator to select which project(s) MAAS manages, and thus which machines will be automatically enlisted and commissioned.
* It should be possible for MAAS to create and self-assign a new (empty) project, so that the user can compose new VMs within LXD from within the MAAS interface.
* No per-project features should be enabled by default in MAAS-created projects.
* The project must be explicitly specified when creating the LXD VM host.
* When a LXD VM host is added, only the existing VMs assigned to the selected project (if any) should be visible to MAAS (and thus, automatically commissioned), and VMs in non-MAAS projects are not affected in any way.
* When a LXD VM host is deleted, the default behaviour should be for MAAS to leave existing VMs, rather than automatically deleting them; VMs in non-MAAS projects are not affected in any way.
* MAAS will not create VMs in projects that it doesn't own.
* When a VM is composed in MAAS, it's created in the target LXD project.

In addition, a MAAS administrator should be able to:

* refresh information about a specific LXD VM host, and receive correct, up-to-date, and timely status.
* explicitly specify connections between networks and VM interfaces.
* deploy a machine directly as an LXD VM host, connected to MAAS from the outset.

These criteria were fully met in the MAAS LXD tenant implementation released as part of MAAS 3.0.

<a href="#heading--project-example"><h2 id="heading--project-example">A MAAS project example</h2></a>

MAAS fits into many different industries, applications, and situations, so trying to come up with a single set of "best practices" just isn't practical.  We can, though, give you an understanding of how to use these project tools using a real-world example.  For the purposes of this explanatory section, we'll cover both CLI and UI approaches in the same document, since seeing both may serve to speed your understanding.

Consider a new, 100-bed hospital which is being planned.  The plan must allow for flexible use of a limited number of machines, since budgets aren't infinite.

<a href="#heading--defining-resource-pools"><h2 id="heading--defining-resource-pools">Defining resource pools</h2></a>

Before defining machines, networks, interfaces, or anything else about this new project, the first step is to identify and label the resource pools.  Resource pools are, by nature, mutually exclusive, so a project plan might start with a random list of functions that the machines must cover:

* Provider documentation
* Insurance collections
* Med reconciliation
* Provider orders
* Narcotics control
* Nursing orders
* Patient collections
* Medical supplies
* Patient registration
* Insurance reconciliation
* Medication administration
* Continuing education
* Food service
* Office supplies
* Charts
* Pharmacy
* Housekeeping
* Time clock
* Instrumentation
* Information technology

This list isn't comprehensive, but it's more than long enough to create a good example.

It isn't clear that all of these would be independent resource pools, since there's commonality (and thus some implied connectivity) between some of these functions.  There's more than one way to group them, but one of the simplest for this example is to group functions that are likely to be performed -- or at least touched -- by the same people, or by people with identical or similar skill-sets.

Here's a preliminary attempt at grouping these functions:

* Providers
  * Provider documentation
  * Provider orders
  * Charts

* Medications
  * Med reconciliation
  * Pharmacy
  * Narcotics control
  * Medication administration

* Nursing operations
  * Nursing orders
  * Shift scheduling
  * Shift loading
  * Continuing education

* Business office
  * Patient registration
  * Insurance collections
  * Insurance reconciliation
  * Patient collections

* Purchasing
  * Office supplies
  * Medical supplies

* Accounting
  * Payroll
  * Timeclock
  * Accounts receivable
  * Accounts payable

* Support functions
  * Instrumentation
  * Information technology
  * Housekeeping
  * Food service

Note that this exercise added a few more functions that were recognised while categorising.

<a href="#heading--roles"><h3 id="heading--roles">Assigning roles</h3></a>

Now let's assign some roles, so that we can work out who can write or modify data within these functions, and who has a responsibility to read and act on the data.  This will help us develop RBAC authorization structures.  Even if you don't use RBAC, defining these roles will help create better resource pool assignments.

To verify this last statement, first consider what would happen if you simple assign resource pools at the top level:

* Providers
* Medications
* Nursing operations
* Business office
* Purchasing
* Accounting
* Support functions

Without considering the subordinate functions, mistakes can be made, and inappropriate access granted.  For example, "Charts" was listed under "Providers" (i.e., physicians, nurse practitioners, and physician's assistants).  But much of the charting doesn't come from the providers themselves, but from nurses who monitor the patients daily -- so nurses need write access to charts.  But the providers category also includes provider documentation, which nurses aren't supposed to read or write (in most cases), and provider orders, which are usually read-only for nurses.

Under medications, providers and pharmacists can both write to the medication reconciliation records, but nurses normally have no access.  On the other hand, nurses administer a lot of the medicines, so they need write access to that particular function.  Again, "Medications" isn't a great category to assign a resource pool, because different roles have different levels of access to different components of that function.

This is where the categorisation instinct breaks down: A logical, bottom-up approach seems instinctive, but it won't work in practice.  Instead, we need to take each of the second level functions, assign roles to them, and determine who can read, who can write, and who shouldn't have access.  To do that, we would need to create a few roles, or job categories, something like this:

* Provider
* Nurse
* Nursing Supervisor
* Pharmacist
* Insurance specialist
* Collections specialist
* Patient registrar
* Purchasing agent
* Accountant
* Payroll clerk
* Instrumentation specialist
* IT administrator
* Housekeeper
* Food service specialist

Again, this is a simple example; in reality, there would be many more roles, and many more nuances.  The result of assigning these roles to these different functions would look something like this:

* Providers
  * Provider documentation
    * Provider writes
    * Insurance specialist reads
    * Accountant reads
  * Provider orders
    * Provider writes
    * Nurse reads
    * Pharmacist reads
  * Charts
    * Provider writes
    * Nurse writes
    * Pharmacist writes
    * Insurance specialist reads

* Medications
  * Med reconciliation
    * Provider writes
    * Pharmacist writes
  * Pharmacy
    * Pharmacist writes
    * Provider reads
    * Nurse reads
  * Narcotics control
    * Provider writes
    * Pharmacist writes
    * Nurse reads (charts are the mechanism for nurses to feed back to these records)
  * Medication administration
    * Provider reads
    * Pharmacist reads
    * Nurse writes

* Nursing operations
  * Nursing orders
    * Provider writes
    * Pharmacist writes
    * Nursing supervisor writes
     Nurse reads
  * Shift scheduling
    * Nursing supervisor writes
    * Payroll clerk reads
    * Nurse reads
  * Shift loading
    * Nursing supervisor writes
    * Accountant reads
  * Continuing education
    * Nurse read

* Business office
  * Patient registration
    * Patient registrar writes
    * Nurse reads
    * Nursing supervisor reads
  * Insurance collections
    * Insurance specialist writes
    * Collections specialist reads
  * Insurance reconciliation
    * Insurance specialist writes
    * Collections specialist reads
  * Patient collections
    * Insurance specialist reads
    * Collections specialist writes

* Purchasing
  * Office supplies
    * Purchasing agent writes
    * Nursing supervisor writes
    * Pharmacist writes
    * Provider writes
  * Medical supplies
    * Purchasing agent writes
    * Nursing supervisor writes
    * Pharmacist writes
    * Provider writes

* Accounting
  * Payroll
    * Payroll clerk writes
    * All staff reads
  * Timeclock
    * All staff writes
    * Payroll clerk reads
  * Accounts receivable
    * Accountant writes
    * Nursing supervisor reads
  * Accounts payable
    * Accountant reads
    * Nursing supervisor writes

* Support functions
  * Instrumentation
    * Nurse writes
    * Nursing supervisor writes
    * Pharmacist writes
    * Instrumentation specialist writes
  * Information technology
    * All staff writes
  * Housekeeping
    * Nurses write
    * Nursing supervisor writes
    * Housekeeping reads
  * Food service
    * Provider writes
    * Nursing supervisor writes
    * Food service reads

It's possible to try different permutations, such as inverting the above list by roles, but as you can see, we won't come up with any more clarity or a better set of divisions.  It's obvious that the resource pools need to be assigned to the secondary functions, not the primary ones:

|Business category | Resource pool | Pool name | Read/write roles | Read-only roles |
|:------|:-------|:-----|:----------|:----------------|
| Providers | Provider documentation | ProvDoc | Provider | Insurance specialist|
|           |                        |         |          | Accountant          |
|           | Provider orders        | ProvOrd | Provider | Nurse               |
|           |                        |         |          | Pharmacist          |
|           | Charts                 | Charts  | Provider | Insurance specialist |
|           |                        |         | Nurse    |                     |
|           |                        |         |Pharmacist |                    |
| Medications | Med reconciliation   | MedRec  |Provider  | |
|           |                        |         |Pharmacist | |
|           | Narcotics control      | DEACon  |Provider | Nurse |
||||Pharmacist||
||Pharmacy | Pharmacy | Pharmacist | Provider |
||||| Nurse |
|| Medication Admin | MedAdmin | Nurse | Provider |
||||Pharmacist||
| Nursing Ops | Nursing orders | NurseOrd | Provider | Nurse |
||||Nursing supervisor ||
|| Shift Scheduling | NurseShift |Nursing supervisor | Nurse |
||||| Payroll clerk |
|| Shift loading | ShiftLoad | Nursing supervisor | Accountant |
|| Continuing education | CE |  | Nurse |
| Business office | Patient Registration | PatReg | Patient registrar | Nurse |
||||| Nursing supervisor |
||Insurance collections|InsColl| Insurance specialist | Collections specialist |
||Insurance reconciliation| InsRec | Insurance specialist | Collections specialist |
||Patient collections| PatColl | Collections specialist | Insurance specialist |
|Purchasing|Office Supplies | OfcSup| Purchasing agent | |
||||Nursing supervisor||
||||Pharmacist||
||||Provider||
||Medical supplies|MedSup|Purchasing agent||
||||Nursing supervisor||
||||Pharmacist||
||||Provider||
|Accounting|Payroll|Payroll|Payroll clerk|All staff (with ID limitations)|
||Timeclock|Timeclock|All Staff|Payroll clerk|
||Accounts receivable| AR |Accountant|Nursing supervisor|
||Accounts payable| AP |Accountant|Nursing supervisor|
|Support functions|Instrumentation| Inst| Nurse ||
||||Nursing supervisor||
||||Pharmacist||
||||Instrumentation specialist||
||Information technology|IT|All staff||
||Housekeeping|HK|Nurses|Housekeeping|
||||Nursing supervisor||
||Food service|FS|Provider|Food service staff|
||||Nursing supervisor||

<a href="#heading--adding-tags"><h3 id="heading--adding-tags">Adding tags and annotations</h3></a>

Since the Business Category is important, but not unique, we can assign it to tags.  That will allow us to filter and operate on machines by category.  The only thing left to add, then, would be workload annotations, and we can build a completed MAAS project from the table above.

Giving it some thought, we can see that machines in the same resource pool can perform identical functions, but those functions may be spread across the hospital by department.  For example, there are various wards, subdivided by type of illness, and speciality units like ICU, CCU, maternity, isolation, and rehabilitation.  Since the machines in each resource pool won't differ, they can be swapped in and out of these areas as needed, based on the patient load.  The correct element to track these would be workload annotations, which can be assigned when the machine is brought up in a particular department.  Remember that you can filter and operate by workload annotations, also.

Returning to our table above, we can quickly document our finished project layout by changing some column headings and make the names more system-friendly, like this:

|Tag       | Pool description       | Pool name | RW roles   | RO roles   | Workload annotations by |
|:---------|:-----------------------|:----------|:-----------|:-----------|:------------------------|
| Provider | Provider documentation | ProvDoc   | Provider   | InsSpec    | Department              |
|          |                        |           |            | Accountant |                         |
|          | Provider orders        | ProvOrd   | Provider   | Nurse      | Department              |
|          |                        |           |            | Pharmacist |                         |
|          | Charts                 | Charts    | Provider   | InsSpec    | Department              |
|          |                        |           | Nurse      |            |                         |
|          |                        |           | Pharmacist |            |                         |
| Meds     | Med reconciliation     | MedRec    | Provider   |            | Department/Pharmacy Loc |
|          |                        |           | Pharmacist |            |                         |
|          | Narcotics control      | DEACon    | Provider   | Nurse      | Department/Pharmacy Loc |
|          |                        |           | Pharmacist |            |                         |
|          | Pharmacy               | Pharmacy  | Pharmacist | Provider   | Pharmacy                |
|          |                        |           |            | Nurse      |                         |
|          | Medication Admin       | MedAdmin  | Nurse      | Provider   | Department/Pharmacy Loc |
|          |                        |           | Pharmacist |            |                         |
| NursOps  | Nursing orders         | NurseOrd  | Provider   | Nurse      | Nursing Desk            |
|          |                        |           | Supervisor |            |                         |
|          | Shift Scheduling       | NurseShift| Supervisor | Nurse      | Supervisor              |
|          |                        |           |            | PayClerk   |                         |
|          | Shift loading          | ShiftLoad | Supervisor | Accountant | Supervisor              |
|          | Continuing education   | CE        |            | Nurse      | Department              |
| BusOfc   | Patient Registration   | PatReg    | Registrar  | Nurse      | Registration Point      |
|          |                        |           |            | Supervisor |                         |
|          | Insurance collections  |InsColl    | InsSpec    | CollSpec   | Business Office Loc     |
|          |Insurance reconciliation| InsRec    | InsSpec    | CollSpec   | Business Office Loc     |
|          | Patient collections    | PatColl   | CollSpec   | InsSpec    | Business Office Loc     |
| Purch    | Office Supplies        | OfcSup    | PurchAgent |            | Purchasing Loc          |
|          |                        |           | Supervisor |            |                         |
|          |                        |           | Pharmacist |            |                         |
|          |                        |           | Provider   |            |                         |
|          | Medical supplies       | MedSup    | PurchAgent |            | Purchasing Loc          |
|          |                        |           | Supervisor |            |                         |
|          |                        |           | Pharmacist |            |                         |
|          |                        |           | Provider   |            |                         |
| Accts    | Payroll                | Payroll   | PayClerk   | (All staff)| Business Office Loc     |
|          | Timeclock              | Timeclock | (All Staff)| PayClerk   | Timeclock               |
|          | Accounts receivable    | AR        | Accountant | Supervisor | Business Office Loc     |
|          | Accounts payable       | AP        | Accountant | Supervisor | Business Office Loc     |
| Support  | Instrumentation        | Inst      | Nurse      |            | Instrumentation Loc      |
|          |                        |           | Supervisor |            |                         |
|          |                        |           | Pharmacist |            |                         |
|          |                        |           | Technician |            |                         |
|          | Information technology | IT        | (All staff)|            | IT Location             |
|          | Housekeeping           | HK        | Nurse      | Housekeeper| Housekeeping Location   |
|          |                        |           | Supervisor |            |                         |
|          | Food service           | FS        | Provider   | FSE        | Food Service Location   |
|          |                        |           | Supervisor |            |                         |


Obviously, this example makes some assumptions.  The real project would require more access nuances, which would likely be driven -- at least partly -- by the software being used in the various locations.  Nevertheless, this gives a clear picture of how MAAS projects can be used to construct a usable framework for a data centre.  After gathering some initial data on the parameters of the business, a framework such as this one could serve as a strong starting point for discussion with other organisations and ongoing design.
