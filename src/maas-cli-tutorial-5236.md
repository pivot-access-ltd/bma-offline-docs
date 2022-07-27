<!-- "MAAS CLI tutorial" -->
Hopefully, you've had a chance to [get started with MAAS](/t/get-started-with-maas/5092); if not, you may want to back up and start there, since this tutorial picks up where that one left off.

A real-world example might help you learn more about MAAS. Luckily, it doesn't have to be comprehensive -- just coherent and plausible.  Just to give you a sneak peek, we'll be building a hospital data centre that ultimately looks something like this:

```
FQDN               POWER  STATUS     OWNER  TAGS     POOL       NOTE     ZONE
----               -----  ------     -----  ----     ----       ----     ----
52-54-00-15-36-f2  off    Ready      -      Orders   Prescrbr   @md-all  Medications
52-54-00-17-64-c8  off    Ready      -      HRMgmt   StaffComp  @tmclck  Payroll
52-54-00-1d-47-95  off    Ready      -      MedSupp  SuppServ   @storag  Inventory
52-54-00-1e-06-41  off    Ready      -      PatPrtl  BusOfc     @bzstns  BizOffice
52-54-00-1e-a5-7e  off    Ready      -      Pharm    Prescrbr   @rxonly  Pharmacy
52-54-00-2e-b7-1e  off    Allocated  admin  NursOrd  NurServ    @nstns   Nursing
52-54-00-2e-c4-40  off    Allocated  admin  MedAdmn  NurServ    @rxonly  Nursing
52-54-00-2e-ee-17  off    Deployed   admin  Charts   ProServ    @md-all  Physician
```

We'll be using the command line interface (CLI) for most of this example, but you can do the same things with the UI -- as we'll demonstrate near the end.  Also, we'll be collapsing a lot of peripheral learning opportunities into little detail sections, like this one:

<details><summary>Using `jq` to make pretty listings</summary>
You can generate a list similar to this for your machines with the `jq` command:

```
maas admin machines read | jq -r '(["FQDN","POWER","STATUS",
"OWNER", "TAGS", "POOL", "NOTE", "ZONE"] | (., map(length*"-"))),
(.[] | [.hostname, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name, .description // "-", .zone.name]) | @tsv' | column -t
```
</details>

So imagine that you're the IT administrator for a new, 100-bed hospital that's under construction, intended to serve a suburban community of 5,000 people.  Call it "Metaphorical General Hospital" (MGH).   Your job is to design a flexible data centre for this facility.  You've decided to start with MAAS as your tool of choice, and for this planning exercise, you'll use VMs in a VM host.

<a href="#heading--machines"><h2 id="heading--machines">Machines</h2></a>

You'll need to start with a little network thinking (and design).  Talking through requirements with the staff, you come up with a random list of functions:
<table width="100%">
<tr><td>Charts</td><td>Provider orders</td><td>Provider documentation</td></tr>
<tr><td>Pharmacy</td><td>Narcotics control</td><td>Insurance collections</td></tr>
<tr><td>Housekeeping</td><td>Nursing orders</td><td>Med reconciliation</td></tr>
<tr><td>Timeclock</td><td>Patient collections</td><td>Med/surgical supplies</td></tr>
<tr><td>Office supplies</td><td>Patient registration</td><td>Insurance reconciliation</td></tr>
<tr><td>Payroll</td><td>Medication admin</td><td>Continuing education</td></tr>
<tr><td>Food service</td><td>Instrumentation</td><td>Information technology</td></tr>
</table>

You can handle this lowest level with individual [machines](/t/about-machines/5080).  With MAAS, you'll be able to modify how many machines are performing which functions, somewhat on-the-fly, but let's assume that you start by creating (at least) one VM for each function.  Since you can reassign machines at will, you aren't going to name them for their functions; instead, you're just going to use the MAC address of each machine to uniquely identify it (the "cattle, not pets" cloud model of server naming).

<h3>Creating some sample VMs</h3>

Assuming you've [installed libvirt](https://help.ubuntu.com/lts/serverguide/libvirt.html) on the machine where you'll be running MAAS, you can create virtual machines like this:

Open the Virtual Machine Manager application.  You'll see a screen that looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/1X/f66940a21313a27734bcaef6c539d36a720a6834.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/f66940a21313a27734bcaef6c539d36a720a6834.jpeg"></a> 

Click on "New Virtual Machine," which brings you to a corresponding dialog:

<a href="https://discourse.maas.io/uploads/default/original/1X/0702d9f2ab4c3659d13be553449093548a9e2f10.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0702d9f2ab4c3659d13be553449093548a9e2f10.jpeg"></a> 

Select the "Network Boot (PXE)" option and click the "Forward" button:

<a href="https://discourse.maas.io/uploads/default/original/1X/0000fb5f072f2b3668465753ae6a713859d8a444.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0000fb5f072f2b3668465753ae6a713859d8a444.jpeg"></a>

Choose the "Generic..." operating system by typing the first letters of "Generic" in the text box and selecting the relevant choice when it becomes available, then go Forward:

<a href="https://discourse.maas.io/uploads/default/original/1X/041914a0718633fce685ac7919e2478da0e62c1b.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/041914a0718633fce685ac7919e2478da0e62c1b.jpeg"></a> 

For CPU and memory, you can usually accept the defaults:

<a href="https://discourse.maas.io/uploads/default/original/1X/5a46262e3573aae7252951b3331ac9e3f3ef69c4.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/5a46262e3573aae7252951b3331ac9e3f3ef69c4.jpeg"></a> 

The storage values have a noticeable effect on local disk usage, so note that, generally, a VM only requires about 5.0 GiB, given an example exercise like this:

<a href="https://discourse.maas.io/uploads/default/original/1X/15f5e344c03bd1469c00333d466027e403c00ee8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/15f5e344c03bd1469c00333d466027e403c00ee8.jpeg"></a> 

In the next screen, you'll have the chance to set a name; here, we've used a pseudo-MAC address, although you can name the machine whatever you want (and then return later to set the name to match the MAC address, if desired):

<a href="https://discourse.maas.io/uploads/default/original/1X/d4191b100d963032d47fed1f198aea76e8de273e.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/d4191b100d963032d47fed1f198aea76e8de273e.jpeg"></a> 

Selecting "Finish" will create the virtual machine and attempt to boot it -- which will fail, since no device currently knows about this VM (and hence can't boot it).  Not to worry; you're not done yet:

<a href="https://discourse.maas.io/uploads/default/original/1X/09b4e50049c2a251d100113e50a241d0c4a06f51.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/09b4e50049c2a251d100113e50a241d0c4a06f51.jpeg"></a> 

Select the "information" button (blue circle, white lowercase "i") to switch to the VM configuration screens, then select the "Boot Options" choice from the left-hand menu:

<a href="https://discourse.maas.io/uploads/default/original/1X/7b6cd37f7663db53571845da0159977092898fa4.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/7b6cd37f7663db53571845da0159977092898fa4.jpeg"></a> 

Turn off the "IDE" item under "Boot device order:"

<a href="https://discourse.maas.io/uploads/default/original/1X/54a8d6a77d9660e13aa1c0e278048ed1c751d65e.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/54a8d6a77d9660e13aa1c0e278048ed1c751d65e.jpeg"></a> 

When you select "Apply," a dialog will pop up to remind you that you need to restart this VM for changes to take effect:

<a href="https://discourse.maas.io/uploads/default/original/1X/6f4ab26216cc2951a202851869f7c7efc5691129.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/6f4ab26216cc2951a202851869f7c7efc5691129.jpeg"></a> 

Switch to the "NIC..." option and set the "Network source" and "Device model" as shown, then select "Apply" and respond to the dialog:

<a href="https://discourse.maas.io/uploads/default/original/1X/26fe981020c03e46c81e2bceed840bea7b2f14d6.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/26fe981020c03e46c81e2bceed840bea7b2f14d6.jpeg"></a> 

You'll next select the drop-down arrow next to the "on/off" menu bar option and select "Force reset," then answer the prompt in the affirmative:

<a href="https://discourse.maas.io/uploads/default/original/1X/537a485f0ff014aeb82afc71bc09b2988bf5cb56.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/537a485f0ff014aeb82afc71bc09b2988bf5cb56.jpeg"></a> 

You now have a VM that you can add to MAAS.  If you want more than one, you can simply right-click on the one you've just created and select "Clone:"

[note]
**Pro Tip**: Cloned VMs tend to use considerably less host disk space than newly-created ones.
[/note]

<a href="https://discourse.maas.io/uploads/default/original/1X/2348efd7dbf17ba445e3c4e6b3926fdc8cfbc888.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/2348efd7dbf17ba445e3c4e6b3926fdc8cfbc888.jpeg"></a> 

Another VM will instantiate, using the name of the cloned VM with an added "-clone" suffix:

<a href="https://discourse.maas.io/uploads/default/original/1X/a14b17602c2ad2465197a77c302080ca2eb59fc8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a14b17602c2ad2465197a77c302080ca2eb59fc8.jpeg"></a> 

You can create VMs as desired, remembering to mind your overall disk usage on your host system.  Let's assume that once you're done, you have around 20 machines up and ready, all named after their assigned MAC address:

<a href="https://discourse.maas.io/uploads/default/original/1X/f9f302d8de9344908758a433dae9abfada0b0db3.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/f9f302d8de9344908758a433dae9abfada0b0db3.jpeg"></a> 

No need to create a lot of VMs for this example (unless you just want to do so).  

<a href="#heading--manually-add-machines"><h3 id="heading--manually-add-machines">Manually adding machines</h3></a>

Once you've created the necessary VMs, you'll want to [manually add machines](/t/how-to-manage-machines/5160#heading--how-to-add-a-machine-manually) to MAAS that correspond to your VMs.

```
FQDN               POWER  STATUS  OWNER  TAGS     POOL     NOTE  ZONE
----               -----  ------  -----  ----     ----     ----  ----
52-54-00-15-36-f2  off    Ready   -      virtual  default  -     default
52-54-00-17-64-c8  off    Ready   -      virtual  default  -     default
52-54-00-1d-47-95  off    Ready   -      virtual  default  -     default
52-54-00-1e-06-41  off    Ready   -      virtual  default  -     default
52-54-00-1e-a5-7e  off    Ready   -      virtual  default  -     default
52-54-00-2e-b7-1e  off    Ready   -      virtual  default  -     default
52-54-00-2e-c4-40  off    Ready   -      virtual  default  -     default
52-54-00-2e-eke-17  off    Ready   -      virtual  default  -     default
52-54-00-2f-6d-3c  off    Ready   -      virtual  default  -     default
52-54-00-4a-2a-30  off    Ready   -      virtual  default  -     default
52-54-00-4e-60-b2  off    Ready   -      virtual  default  -     default
52-54-00-52-93-10  off    Ready   -      virtual  default  -     default
52-54-00-5d-b5-a1  off    Ready   -      virtual  default  -     default
52-54-00-60-1e-6f  off    Ready   -      virtual  default  -     default
52-54-00-60-8d-4b  off    Ready   -      virtual  default  -     default
52-54-00-62-22-e3  off    Ready   -      virtual  default  -     default
52-54-00-65-2e-20  off    Ready   -      virtual  default  -     default
52-54-00-6a-ac-23  off    Ready   -      virtual  default  -     default
52-54-00-6f-b4-af  off    Ready   -      virtual  default  -     default
52-54-00-71-0c-53  off    Ready   -      virtual  default  -     default
52-54-00-77-4e-53  off    Ready   -      virtual  default  -     default
52-54-00-98-42-ef  off    Broken  -      -        default  -     default
52-54-00-9b-e4-9a  off    Ready   -      virtual  default  -     default
52-54-00-9c-51-00  off    Ready   -      virtual  default  -     default
```

Creating a machine from a VM requires six pieces of information:

1. the machine architecture (e.g., amd64)
2. the machine's MAC address
3. the power type (in this case, "virsh")
4. the power ID
5. the power address (which also contains a username)
6. the power password

Once you've collected this information, you'll want to create a new KVM like this:

```
maas admin machines create \
architecture=amd64 hostname=52-54-00-15-36-f2 \ 
mac_addresses=52:54:00:15:36:f2 \
power_type=virsh power_parameters_power_id=f677a842-571c-4e65-adc9-11e2cf92d363 \
power_parameters_power_address=qemu+ssh://stormrider@192.168.123.1/system \
power_parameters_power_pass=xxxxxxxx
```

Here, we've assigned a variant of the MAC address as the machine name.  Note that the machine name cannot include colons (":"), we've substituted dashes.  You can gather most of this information from the KVM itself:

<a href="https://discourse.maas.io/uploads/default/original/1X/79e135e48576bb6f455dd42fd7a09a2c7448d221.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/79e135e48576bb6f455dd42fd7a09a2c7448d221.jpeg"></a> 
</details>

For default configurations, the Virsh Address is "qemu+ssh://[your-login-id]@192.168.122.1/system;" replace "[your-login-id]" with your username or login ID on the machine where you're hosting MAAS and the Virtual Machine Manager.  Likewise, the password is your normal login password for the same host.  Finally, you can retrieve the Virsh VM ID from the "Overview" screen of the VM itself:

<a href="https://discourse.maas.io/uploads/default/original/1X/79e135e48576bb6f455dd42fd7a09a2c7448d221.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/79e135e48576bb6f455dd42fd7a09a2c7448d221.jpeg"></a> 
</details>

As you add machines, they automatically commission.

<a href="#heading--tags"><h2 id="heading--tags">Tags</h2></a>

Assigning machines to specific functions is something you can do after you [commission](/t/how-to-deploy-machines/5112#heading--how-to-commission-a-machine) and [deploy](/t/how-to-deploy-machines/5112) them.  (Later on, we'll discuss ways to load user apps and data onto the machines using the MAAS API.) Once you've got machines running apps, you want to keep up-to-date about which machine is doing what, when you're looking at the machine list.  You'll want to assign [tags](/t/about-tags-and-annotations/5088) to machines.  

```
FQDN               POWER  STATUS  OWNER  TAGS     POOL     NOTE  ZONE
----               -----  ------  -----  ----     ----     ----  ----
52-54-00-15-36-f2  off    Ready   -      Orders   default  -     default
52-54-00-17-64-c8  off    Ready   -      HRMgmt   default  -     default
52-54-00-1d-47-95  off    Ready   -      MedSupp  default  -     default
52-54-00-1e-06-41  off    Ready   -      PatPrtl  default  -     default
52-54-00-1e-a5-7e  off    Ready   -      Pharm    default  -     default
52-54-00-2e-b7-1e  off    Ready   admin  NursOrd  default  -     default
52-54-00-2e-c4-40  off    Ready   admin  MedAdmn  default  -     default
52-54-00-2e-ee-17  off    Ready   admin  Charts   default  -     default
```

Adding a tag to a machine is simple.  First, you must create the tag:

```
maas $PROFILE tags create name=$TAG_NAME comment='$TAG_COMMENT'
```

Next you add the tag to a machine with the following command:

```
maas $PROFILE tag update-nodes $TAG_NAME add=$SYSTEM_ID
```

If you need to find the $SYSTEM_ID of your machines, you can use this command:

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID"]
| (., map(length*"-"))),
(.[] | [.hostname, .system_id]) | @tsv' | column -t
```

Tags can will help you keep up with which machine(s) are covering which functions as you apply your apps.  You can search and filter by tags, and you can utilise tags from within the API, as well.

<a href="#heading--resource-pools"><h2 id="heading--resource-pools">Resource pools</h2></a>

As you look at the list of functions you've created, and talk more with the staff, you discover that some of these functions fit together more closely than others.  With some effort, you work out the following update to your network design:

<table width="100%">
<tr><td><strong>Provider services</strong></td><td></td><td></td></tr>
<tr><td>Charts</td><td>Provider orders</td><td>Provider documentation</td></tr>
<tr><td><strong>Nursing services</strong></td><td></td><td></td></tr>
<tr><td>Nursing orders</td><td>Continuing education</td><td></td></tr>
<tr><td><strong>Nursing meds</strong></td><td></td><td></td></tr>
<tr><td>Medication administration</td><td>Narcotics control</td><td></td></tr>
<tr><td><strong>Prescriber controls</strong></td><td></td><td></td></tr>
<tr><td>Pharmacy</td><td>Narcotics control</td><td>Medication reconciliation</td></tr>
<tr><td><strong>Staff compensation</strong></td><td></td><td></td></tr>
<tr><td>Timeclock</td><td>Payroll</td><td></td></tr>
<tr><td><strong>Supplies & services</strong></td><td></td><td></td></tr>
<tr><td>Medical and surgical supplies</td><td>Office and general supplies</td><td></td></tr>
<tr><td><strong>Business office</strong></td><td></td><td></td></tr>
<tr><td>Patient registration</td><td>Insurance reconciliation</td><td></td></tr>
<tr><td><strong>Collections</strong></td><td></td><td></td></tr>
<tr><td>Patient collections</td><td>Insurance collections</td><td></td></tr>
<tr><td><strong>Patient support</strong></td><td></td><td></td></tr>
<tr><td>Housekeeping</td><td>Food service</td><td></td></tr>
<tr><td><strong>Staff support</strong></td><td></td><td></td></tr>
<tr><td>Instrumentation</td><td>Information technology</td><td></td></tr>
</table>

You're aware that the number of machines you'll need use for each of the individual functions with vary according to real-world events in the hospital.  Still, you'd prefer to budget machines for these different functions, so that you know you can meet the needs of each.  The easiest way to handle this?  Creating [resource pools](/t/about-machines/5080#heading--about-resource-pools) and naming them after the (new) top-level headings in your outline.  That way, you can reserve some number of machines for those functions, learning over time the right number of machines to allocate to each activity.

Just like tags, you must first create a resource pool before assigning a machine to it.
Here’s an example that demonstrates how to create a new resource pool named "myresource" in a single command; note that the description field is optional, but often very helpful:

```
maas $PROFILE resource-pools create name=myresource description="A new resource pool."
```

Once you've created the pool you want, you can add a machine that pool with the following command:

```
maas $PROFILE machine update $SYSTEM_ID pool=$POOL_NAME
```

Here's a snippet of your updated machine list, with all machines added to the appropriate resource pool:

```
FQDN               POWER  STATUS  OWNER  TAGS     POOL       NOTE  ZONE
----               -----  ------  -----  ----     ----       ----  ----
52-54-00-15-36-f2  off    Ready   -      Orders   Prescrbr   -     default
52-54-00-17-64-c8  off    Ready   -      HRMgmt   StaffComp  -     default
52-54-00-1d-47-95  off    Ready   -      MedSupp  SuppServ   -     default
52-54-00-1e-06-41  off    Ready   -      PatPrtl  BusOfc     -     default
52-54-00-1e-a5-7e  off    Ready   -      Pharm    Prescrbr   -     default
52-54-00-2e-b7-1e  off    Ready   admin  NursOrd  NurServ    -     default
52-54-00-2e-c4-40  off    Ready   admin  MedAdmn  NurServ    -     default
52-54-00-2e-ee-17  off    Ready   admin  Charts   ProServ    -     default
```
Resource pools are mostly for your use, helping you to budget servers within a given category.  Untagged servers can be in a pool, so if you've got five servers in the "Prescriber controls" resource pool, you can tag them with "Pharmacy," "Medication reconciliation," etc., as you use them.  It will also be obvious when you're running low on servers for that pool, and need to either provision more or move some unused ones from another pool.

<a href="#heading--notes"><h2 id="heading--notes">Notes</h2></a>

Another optional identifier for machines is the "Note" field.  While it can be long, a portion of it shows up on the machine list, which makes it useful for adding special identifiers or groupings.  In this example, we've added a vague identifier which might help an IT admin remember server locations or access rights.

```
FQDN               POWER  STATUS  OWNER  TAGS     POOL       NOTE     ZONE
----               -----  ------  -----  ----     ----       ----     ----
52-54-00-15-36-f2  off    Ready   -      Orders   Prescrbr   @md-all  default
52-54-00-17-64-c8  off    Ready   -      HRMgmt   StaffComp  @tmclck  default
52-54-00-1d-47-95  off    Ready   -      MedSupp  SuppServ   @storag  default
52-54-00-1e-06-41  off    Ready   -      PatPrtl  BusOfc     @bzstns  default
52-54-00-1e-a5-7e  off    Ready   -      Pharm    Prescrbr   @rxonly  default
52-54-00-2e-b7-1e  off    Ready   admin  NursOrd  NurServ    @nstns   default
52-54-00-2e-c4-40  off    Ready   admin  MedAdmn  NurServ    @rxonly  default
52-54-00-2e-ee-17  off    Ready   admin  Charts   ProServ    @md-all  default
```

To add a note to a machine, you'll first need to determine its system ID (see above).  Once you have that, you can add or change a note like this:

```
maas $PROFILE machine update $SYSTEM_ID description="note"
```

It helps very much to keep your notes short, since only a few characters are visible on the machine list.

<a href="#heading--vlans"><h2 id="heading--vlans">VLANs</h2></a>

Looking over your design, you notice that some of these resource pools must have their network traffic "fire-walled" from others -- for example, Provider services and Nursing services shouldn't be readily visible to Staff compensation or Food service.  Likewise, the relevant monitoring agencies require that facilities manage medications as a separate activity. The traditional way to separate these networks (other than creating entirely *separate* networks) would be a VLAN.  Luckily, MAAS supports multiple VLANS.  Adding one higher level to your design, you find yourself with this updated network topology:

<table width="100%">
<tr><td><strong>Caregiver services</strong></td><td></td></tr>
<tr><td>Provider services</td><td>Nursing services</td></tr>
<tr><td><strong>Medication management</strong></td><td></td></tr>
<tr><td>Nursing meds</td><td>Prescriber controls</td></tr>
<tr><td><strong>Accounts payable</strong></td><td></td></tr>
<tr><td>Staff compensation</td><td>Supplies & services</td></tr>
<tr><td><strong>Accounts receivable</strong></td><td></td></tr>
<tr><td>Business office</td><td>Collections</td></tr>
<tr><td><strong>Patient support</strong></td><td></td></tr>
<tr><td>Housekeeping</td><td>Food service</td></tr>
<tr><td><strong>Staff support</strong></td><td></td></tr>
<tr><td>Instrumentation</td><td>Information technology</td></tr>
</table>

Each of these higher-level groupings is ideal for a VLAN, so you create six of them, one for each division:

```
FABRIC    VLAN                   DHCP
------    ----                   ----
fabric-0  Accounts_Receivable    false
fabric-0  Staff_Support          false
fabric-0  Patient_Support        false
fabric-0  Accounts_Payable       false
fabric-0  Medication_Management  false
fabric-0  Caregiver_Services     false
fabric-0  untagged               false
```

<details><summary>`jq` magic</summary></details>

You can generate this list with the command:

```
maas admin vlans read $FABRIC_ID | jq -r '(["FABRIC","VLAN","DHCP"] | (., map(length*"-"))), (.[] | [.fabric, .name, .dhcp_on]) | @tsv' | column -t
```
</details>

Adding a functional VLAN requires some additional (common) networking aspects, which we'll cover later.  In the meantime, though, here's the short version of adding and naming the VLAN itself.  

To create additional VLANs, choose the fabric where you want them to be added, and enter the following command, once for each new VLAN:

```
maas admin vlans create $FABRIC_ID name=$VLAN_NAME vid=$VLAN_ID
```

For example, to create the "Caregiver Services" VLAN with VID 100 on fabric 0, enter the following command:

```
maas admin vlans create 0 name="Caregiver_Services" vid=100
```

Ignoring the networking aspects (for now), these VLANs should help isolate major functions and provide a level of data integrity and access control for your new hospital network.

<a href="#heading--fabrics"><h2 id="heading--fabrics">Fabrics</h2></a>

Considering your network design so far, you notice that some of the VLANs need to be able to communicate with each other some of the time.  In fact, you decide on three pairs of VLANs to cover this new networking situation:

<table>
<tr><td><strong>Patient management</strong></td><td></td></tr>
<tr><td>Caregiver services</td><td>Medication management</td></tr>
<tr><td><strong>Accounting</strong></td><td></td></tr>
<tr><td>Accounts payable</td><td>Accounts receivable</td></tr>
<tr><td><strong>Facilities</strong></td><td></td></tr>
<tr><td>Patient support</td><td>Staff support</td></tr>
</table>

You want to incorporate these highest-level groupings into your network, but how?  MAAS provides the answer with fabrics.  A fabric is a set of interconnected VLANs that can communicate, so you simply create three fabrics, each covering one of these top-level categories.

This is also a good opportunity to try out the MAAS UI.  In your browser, go to the [MAAS URL](/t/get-started-with-maas/5092#heading--maas-url) that you generated when you installed MAAS.  Login as your defiend user, and select the "Subnets" tab.  You can add a fabric by clicking on the "Add" drop-down, and choosing "Fabric:"

<a href="https://discourse.maas.io/uploads/default/original/1X/509e9696919e69cfc57602a6228425a472b3ac1d.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/509e9696919e69cfc57602a6228425a472b3ac1d.jpeg"></a> 

You'll see the "Add fabric" dialog appear.  Enter the desired fabric name and click "Add fabric:"

<a href="https://discourse.maas.io/uploads/default/original/1X/7873e6a97212673ab08c8c3c33f9d63d7069b8e8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/7873e6a97212673ab08c8c3c33f9d63d7069b8e8.jpeg"></a> 

Here you'll notice three new fabrics, one for each of the top-level groupings in your example network design:

<a href="https://discourse.maas.io/uploads/default/original/1X/4f787bc5d57c7f811641e32b42c96bb2a2792356.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/4f787bc5d57c7f811641e32b42c96bb2a2792356.jpeg"></a> 

Next, you'll want to assign your VLANs to this fabric.  Begin by clicking on any VLAN you want to move, which will bring you to a summary screen for that VLAN:

<a href="https://discourse.maas.io/uploads/default/original/1X/ecca590663b90106b144c003851732a16acd5220.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/ecca590663b90106b144c003851732a16acd5220.jpeg"></a> 

You can click "Edit" and choose the desired fabric from the drop-down list:

<a href="https://discourse.maas.io/uploads/default/original/1X/6f6e2bff0d67dc02d33800e5cc1d60db24fb398a.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/6f6e2bff0d67dc02d33800e5cc1d60db24fb398a.jpeg"></a> 

Finally, click "Save summary" to move this VLAN to the desired fabric.  The end result of assigning our example VLANs to the three fabrics is shown below.

</details>

<a href="https://discourse.maas.io/uploads/default/original/1X/23c214cd6836dd783347f050f2cdba04da7bcaa1.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/23c214cd6836dd783347f050f2cdba04da7bcaa1.jpeg"></a>
