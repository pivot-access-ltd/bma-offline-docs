<!-- "MAAS bootstrap tutorial" -->
An evolving example may be useful to introduce you to MAAS, and it doesn't have to be comprehensive --  just coherent and plausible.  For this example, we'll use the latest MAAS snap from the UI.

<a href="#heading--Installation"><h2 id="heading--Installation">Installation</h2></a>

Begin by installing (but not initialising) the MAAS snap:

```nohighlight
sudo snap install maas
maas (3.2/stable) <some-build-string> from Canonical installed
```

The MAAS initialisation mode "region+rack" will do fine for this install.  No need to add the complexity of separate rack controllers just yet.  It's not quite time to initialise, though; we need to choose production vs. proof-of-concept. For now, let's go with the production configuration, since there's more to see and do.

A production setup starts with a local PostgreSQL install, from packages.  And, like most Debian installs, that starts with an update, to grab any packages that might be needed for the install to succeed:

```nohighlight
sudo apt update -y

[sudo] password for stormrider: 
Hit:1 http://dl.google.com/linux/chrome/deb stable InRelease
Hit:2 http://us.archive.ubuntu.com/ubuntu focal InRelease                                      
Get:3 http://security.ubuntu.com/ubuntu focal-security InRelease [107 kB]
Get:4 http://us.archive.ubuntu.com/ubuntu focal-updates InRelease [111 kB]
Get:5 http://us.archive.ubuntu.com/ubuntu focal-backports InRelease [98.3 kB]
Get:6 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [310 kB]
Get:7 http://security.ubuntu.com/ubuntu focal-security/main amd64 DEP-11 Metadata [21.2 kB]
Get:8 http://us.archive.ubuntu.com/ubuntu focal-updates/main i386 Packages [187 kB]     
Get:9 http://us.archive.ubuntu.com/ubuntu focal-updates/main amd64 DEP-11 Metadata [196 kB]
Get:10 http://us.archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [142 kB]
Get:11 http://us.archive.ubuntu.com/ubuntu focal-updates/universe i386 Packages [77.6 kB]
Get:12 http://security.ubuntu.com/ubuntu focal-security/universe amd64 DEP-11 Metadata [35.8 kB]
Get:13 http://us.archive.ubuntu.com/ubuntu focal-updates/universe Translation-en [71.7 kB]
Get:14 http://us.archive.ubuntu.com/ubuntu focal-updates/universe amd64 DEP-11 Metadata [176 kB]
Get:15 http://us.archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 DEP-11 Metadata [2,468 B]
Get:16 http://us.archive.ubuntu.com/ubuntu focal-backports/universe amd64 DEP-11 Metadata [1,972 B]
Fetched 1,538 kB in 2s (827 kB/s)                                             
Reading package lists... Done
Building dependency tree       
Reading state information... Done
325 packages can be upgraded. Run 'apt list --upgradable' to see them.
```

Then I can install PostgreSQL, probably version 12:

```nohighlight
sudo apt install -y postgresql

Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages were automatically installed and are no longer required:
enchant geoip-database gir1.2-mutter-5 gsfonts libbind9-161 libcroco3 libdns-export1107
libdns1107 libdns1109 libenchant1c2a libfprint0 libgeoip1 libgnome-desktop-3-18 libirs161
libisc-export1104 libisc1104 libisc1105 libisccc161 libisccfg163 liblwres161 libmicrodns0
libmutter-5-0 liboauth0 libpoppler90 libpython3.7 libpython3.7-minimal libpython3.7-stdlib
linux-image-5.3.0-40-generic linux-modules-5.3.0-40-generic
linux-modules-extra-5.3.0-40-generic ubuntu-software ubuntu-system-service
Use 'sudo apt autoremove' to remove them.
Suggested packages:
postgresql-doc
The following NEW packages will be installed:
postgresql
0 upgraded, 1 newly installed, 0 to remove and 325 not upgraded.
Need to get 4,004 B of archives.
After this operation, 67.6 kB of additional disk space will be used.
Get:1 http://us.archive.ubuntu.com/ubuntu focal/main amd64 postgresql all 12+214 [4,004 B]
Fetched 4,004 B in 0s (13.2 kB/s)     
Selecting previously unselected package postgresql.
(Reading database ... 227326 files and directories currently installed.)
Preparing to unpack .../postgresql_12+214_all.deb ...
Unpacking postgresql (12+214) ...
Setting up postgresql (12+214) ...
```

<a href="#heading--Initialisation"><h2 id="heading--Initialisation">Initialisation</h2></a>

Yep, version 12.  Now we need to set up a PostgreSQL user:

```nohighlight
sudo -u postgres psql -c "CREATE USER \"maascli\" WITH ENCRYPTED PASSWORD 'maascli'"
CREATE ROLE
```

We also need a suitable MAAS database:

```nohighlight
sudo -u postgres createdb -O "maascli" "maasclidb"
```

Note that there's no system response (the old UNIX rule of "no news is good news").  Next, we need to add the database to the PostgreSQL HBA configuration, by editing `/etc/postgres/12/main/pg_hba.conf`, adding a line to the bottom of the file:

```nohighlight
sudo vi /etc/postgresql/12/main/pg_hba.conf
host    maasclidb       maascli         0/0                     md5
```

Finally, we can initialise MAAS, like this:

```nohighlight
sudo maas init region+rack --database-uri "postgres://maascli:maascli@localhost/maasclidb"
MAAS URL [default=http://192.168.43.251:5240/MAAS]:
```

This command offers me a bit of important feedback, the MAAS URL, which will be needed for the CLI login.  That's followed by a running commentary on the steps MAAS is taking to start up.

It all ends with the following admonition:

```nohighlight
MAAS has been set up.

If you want to configure external authentication or use
MAAS with Canonical RBAC, please run

sudo maas configauth

To create admins when not using external authentication, run

sudo maas createadmin
```

<a href="#heading--Creating-an-admin-user"><h3 id="heading--Creating-an-admin-user">Creating an admin user</h3></a>

Well, that's an easy call.  Let's just run "createadmin" real quick:


```nohighlight
sudo maas createadmin
[sudo] password for stormrider: 
Username: admin
Password: 
Again: 
Email: admin@admin.com
Import SSH keys [] (lp:user-id or gh:user-id): xxxxxxxxxxx
```

<a href="#heading--What-we-are-trying-to-achieve"><h2 id="heading--What-we-are-trying-to-achieve">What we are trying to achieve</h2></a>

So imagine that you're the IT administrator for a new, 100-bed hospital that's under construction, intended to serve a suburban community of 5,000 people.  Call it "Metaphorical General Hospital" (MGH).   Your job is to design a flexible data centre for this facility.  You've decided to start with MAAS as your tool of choice, and for this planning exercise, you'll use VMs in a VM host.  You're trying to get to this setup:

<a href="https://discourse.maas.io/uploads/default/original/1X/18456dbd3fbfec14eddd044816fd0719692282da.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/18456dbd3fbfec14eddd044816fd0719692282da.jpeg"></a> 

First, there's some planning work do to.

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

You can handle this lowest level with individual [machines](/t/how-to-deploy-physical-machines/6192).  With MAAS, you'll be able to modify how many machines are performing which functions, somewhat on-the-fly, but let's assume that you start by creating (at least) one VM for each function.  Since you can reassign machines at will, you aren't going to name them for their functions; instead, you're just going to use the MAC address of each machine to uniquely identify it.

<details>
<summary>
<em>Try it!</em>
</summary>

<a href="#heading--Creating-some-sample-VMs"><h3 id="heading--Creating-some-sample-VMs">Creating some sample VMs</h3></a>

Assuming you've [installed libvirt](https://help.ubuntu.com/lts/serverguide/libvirt.html)`↗` on the machine where you'll be running MAAS, you can create virtual machines like this:

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

You can create VMs as desired, remembering to mind your overall disk usage on your host system.

</details>

Let's assume that once you're done adding VMs, you have around 20 up and ready, all named after their assigned MAC address:

<a href="https://discourse.maas.io/uploads/default/original/1X/f9f302d8de9344908758a433dae9abfada0b0db3.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/f9f302d8de9344908758a433dae9abfada0b0db3.jpeg"></a> 

No need to create a lot of VMs for this example (unless you just want to do so).  

<a href="#heading--manually-add-machines"><h3 id="heading--manually-add-machines">Manually adding machines</h3></a>

Once you've created the necessary VMs, you'll want to [manually add machines](/t/how-to-make-machines-available/5160#heading--how-to-add-a-machine-manually) to MAAS that correspond to your VMs.

<a href="https://discourse.maas.io/uploads/default/original/1X/91679cd615868eda4654541a68e59de57328ddfa.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/91679cd615868eda4654541a68e59de57328ddfa.jpeg"></a> 

<details>
<summary><em>Try it!</em></summary>

Creating a machine from a VM requires about a dozen pieces of information, most of which you can gather from the VM itself:

<a href="https://discourse.maas.io/uploads/default/original/1X/bc6c18c0fd31367bd4a9909fb7d954dc06f15c40.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/bc6c18c0fd31367bd4a9909fb7d954dc06f15c40.jpeg"></a> 

In the left column, you're only required to enter a machine name and the machine's MAC address:  

<a href="https://discourse.maas.io/uploads/default/original/1X/1de8d7afae996292d71e9787641bf0317b2327c9.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/1de8d7afae996292d71e9787641bf0317b2327c9.jpeg"></a> 

Here, we've assigned a variant of the MAC address as the machine name.  Note that the machine name cannot include colons (":"), we've substituted dashes.  In the right column, it's necessary to choose the power type.  When enlisting VMs, the correct power type is "Virsh," as shown below:

<a href="https://discourse.maas.io/uploads/default/original/1X/aa076ee437ce481808bb5f41320a45e60f3676de.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/aa076ee437ce481808bb5f41320a45e60f3676de.jpeg"></a> 

For default configurations, the Virsh Address is "qemu+ssh://[your-login-id]@192.168.122.1/system;" replace "[your-login-id]" with your username or login ID on the machine where you're hosting MAAS and the Virtual Machine Manager.  Likewise, the password is your normal login password for the same host.  Finally, you can retrieve the Virsh VM ID from the "Overview" screen of the VM itself:

<a href="https://discourse.maas.io/uploads/default/original/1X/79e135e48576bb6f455dd42fd7a09a2c7448d221.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/79e135e48576bb6f455dd42fd7a09a2c7448d221.jpeg"></a> 
</details>

As you add machines, they automatically commission:

<a href="https://discourse.maas.io/uploads/default/original/1X/37f1df9e4072b29c7183d4ae8ec1768504c4f66f.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/37f1df9e4072b29c7183d4ae8ec1768504c4f66f.jpeg"></a> 

When finished, the commissioned machines with be at the "Ready" state.

<a href="#heading--tags"><h2 id="heading--tags">Tags</h2></a>

Assigning machines to specific functions is something you can do after you [commission](/t/how-to-put-machines-to-work/5112#heading--how-to-commission-a-machine) and [deploy](/t/how-to-put-machines-to-work/5112) them.  (Later on, we'll discuss ways to load user apps and data onto the machines using the MAAS API.) Once you've got machines running apps, you want to keep up-to-date about which machine is doing what, when you're looking at the machine list.  You'll want to assign [tags](/t/how-to-tag-machines/6200) to machines.  

<a href="https://discourse.maas.io/uploads/default/original/1X/2ea0827b9ef327b59ad722215d556969218cc22f.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/2ea0827b9ef327b59ad722215d556969218cc22f.jpeg"></a> 

<details>
<summary><em>Try it!</em></summary>
Adding a tag to a machine is simple.  Just decide which machine you want to tag:

<a href="https://discourse.maas.io/uploads/default/original/1X/4f32fb8105ecee30afd0f3ca226b265dffe6e11b.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/4f32fb8105ecee30afd0f3ca226b265dffe6e11b.jpeg"></a> 

You'll want to click on the machine name (in this case, the MAC address), and then choose "Configuration" on the next screen that comes up.  This will bring you to a screen from which you can edit some parameters about the machine:

<a href="https://discourse.maas.io/uploads/default/original/1X/c31a50cebf68c8c5fbfbbe0115bb5c1daeb84ae8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c31a50cebf68c8c5fbfbbe0115bb5c1daeb84ae8.jpeg"></a> 

Click on "Edit," and then add a tag name to the "Tags" field.  Tags are automatically remembered by MAAS, so the next time you want to enter the same tag, an auto-complete field will appear, as shown below:

<a href="https://discourse.maas.io/uploads/default/original/1X/39a0e2f01ba7f3dc141bcf57c09b4e62f737525d.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/39a0e2f01ba7f3dc141bcf57c09b4e62f737525d.jpeg"></a> 

Select "Save changes" to add the tag(s) to the machine.  When you return to the machine list, you'll note that the tag is now associated with that machine:

<a href="https://discourse.maas.io/uploads/default/original/1X/8a21ca291aa800440d9074270ab9d9108cff9be1.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8a21ca291aa800440d9074270ab9d9108cff9be1.jpeg"></a> 

</details>

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

You're aware that the number of machines you'll need use for each of the individual functions with vary according to real-world events in the hospital.  Still, you'd prefer to budget machines for these different functions, so that you know you can meet the needs of each.  The easiest way to handle this?  Creating [resource pools](/t/how-to-deploy-physical-machines/6193#heading--about-resource-pools) and naming them after the (new) top-level headings in your outline.  That way, you can reserve some number of machines for those functions, learning over time the right number of machines to allocate to each activity.

<details>
<summary><em>Try it!</em></summary>

Notice at the top of the machine list, there is a tab labelled, "Resource pools:"

<a href="https://discourse.maas.io/uploads/default/original/1X/f7d4c52a176f53f29a0c1ac3190e7abb563dc993.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/f7d4c52a176f53f29a0c1ac3190e7abb563dc993.jpeg"></a> 

In this example, there are already some resource pools defined to match the different functions above, except for one: Provider services.  Click the "Resource pools" tab to go there:

<a href="https://discourse.maas.io/uploads/default/original/1X/c05804c1f1bba45439d8894698b4dcefd64e7a5a.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c05804c1f1bba45439d8894698b4dcefd64e7a5a.jpeg"></a> 

To add the "Provider services" (ProServ) pool, click on "Add pool:"

<a href="https://discourse.maas.io/uploads/default/original/1X/bebf192974683dde6cb21407f6db299f1e407925.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/bebf192974683dde6cb21407f6db299f1e407925.jpeg"></a> 

Fill in the fields for "Name" (which is a required field, with no spaces), and for "Description."  In this case, we've filled them in with "ProServ" and "Provider services:"

<a href="https://discourse.maas.io/uploads/default/original/1X/9da1e1c703818ac133db81082e1f3b01a72fb3e9.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/9da1e1c703818ac133db81082e1f3b01a72fb3e9.jpeg"></a> 

Click on "Add pool" to add this resource pool to the list, then click on "Machines" to return to the machine list.  Once there, it's simple to add machines to a particular pool.   In the column marked "POOL/NOTE," you'll see that your machines are in the "default" pool when created.  If you click on "default" there, you'll bring up a drop-down of already-created resource pools:

<a href="https://discourse.maas.io/uploads/default/original/1X/f373606dcd50c96a35af932379830f101d4a77e0.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/f373606dcd50c96a35af932379830f101d4a77e0.jpeg"></a> 

Just choose the one you want for this machine (in our example, ProServ) and you're done:

<a href="https://discourse.maas.io/uploads/default/original/1X/0cff1cf26f28236dbabc89b14a92c69435934933.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0cff1cf26f28236dbabc89b14a92c69435934933.jpeg"></a> 

</details>

Here's a snippet of the updated machine list, with all machines added to the appropriate resource pool:

<a href="https://discourse.maas.io/uploads/default/original/1X/704b6d1603f6f90fca42891d98c3bb418458b94a.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/704b6d1603f6f90fca42891d98c3bb418458b94a.jpeg"></a> 

Resource pools are mostly for your use, helping you to budget servers within a given category.  Untagged servers can be in a pool, so if you've got five servers in the "Prescriber controls" resource pool, you can tag them with "Pharmacy," "Medication reconciliation," etc., as you use them.  It will also be obvious when you're running low on servers for that pool, and need to either provision more or move some unused ones from another pool.

<a href="#heading--notes"><h2 id="heading--notes">Notes</h2></a>

Another optional identifier for machines is the "Note" field.  While it can be long, a portion of it shows up on the machine list, which makes it useful for adding special identifiers or groupings.  In this example, we've added a vague identifier which might help an IT admin remember server locations or access rights.

<a href="https://discourse.maas.io/uploads/default/original/1X/8724395dfe9fc4d3f4a10a05687c33c6a3dded07.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/8724395dfe9fc4d3f4a10a05687c33c6a3dded07.jpeg"></a> 

<details>
<summary><em>Try it!</em></summary>

You can edit notes by clicking on a machine name in the machine list, switching to the "Configuration" tab, and selecting the "Edit" button.  These choices will bring you to a screen like this one:

<a href="https://discourse.maas.io/uploads/default/original/1X/a9d61f28a4ada7d97ff6f896d2f1e8e719ad680b.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/a9d61f28a4ada7d97ff6f896d2f1e8e719ad680b.jpeg"></a> 

From here, you can add free-form text into the "Note" field:

<a href="https://discourse.maas.io/uploads/default/original/1X/f8d647daffa9b3210fb99d440107a58e539a6c35.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/f8d647daffa9b3210fb99d440107a58e539a6c35.jpeg"></a> 

When you save the changes and return to the machine list, you'll notice that the NOTE field for that machine now contains your changes: 

<a href="https://discourse.maas.io/uploads/default/original/1X/46cf42808ef44829f1c610e479d6dfb62af2d898.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/46cf42808ef44829f1c610e479d6dfb62af2d898.jpeg"></a> 
</details>

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

<a href="https://discourse.maas.io/uploads/default/original/1X/7245ed378ce0b9000aaf6f15b16ea16dbde2fccf.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/7245ed378ce0b9000aaf6f15b16ea16dbde2fccf.jpeg"></a> 

<details>
<summary><em>Try it!</em></summary>

Adding a functional VLAN requires some additional (common) networking aspects, which we'll cover later.  In the meantime, though, here's the short version of adding and naming the VLAN itself.  

From anywhere on the MAAS page, select "Subnets" from the top menu-bar, which brings you to this screen:

<a href="https://discourse.maas.io/uploads/default/original/1X/befd3a3eb5987d412477d0a076d16a50e81dae30.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/befd3a3eb5987d412477d0a076d16a50e81dae30.jpeg"></a> 

Using the "Add" drop-down, select "VLAN:"

<a href="https://discourse.maas.io/uploads/default/original/1X/dbdea7bec608d14e89da82cfdea87df3f93855dd.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/dbdea7bec608d14e89da82cfdea87df3f93855dd.jpeg"></a> 

You'll arrive at this screen, which allows you to specify the VLAN:

<a href="https://discourse.maas.io/uploads/default/original/1X/e371011171ba18839f96788fefa40a04af3e79bb.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e371011171ba18839f96788fefa40a04af3e79bb.jpeg"></a> 

Enter the Name and ID of the VLAN, and select the fabric to enclose it (in this case, the "default" fabric):

<a href="https://discourse.maas.io/uploads/default/original/1X/961d5cae7119db1c3fb7e8d6ae6ce7015d9263d1.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/961d5cae7119db1c3fb7e8d6ae6ce7015d9263d1.jpeg"></a> 

When you're satisfied with your choices, select "Add VLAN" to complete the operation.

</details>

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

<details>
<summary><em>Try it!</em></summary>

You can add a fabric by selecting the "Subnets" tab, clicking on the "Add" drop-down, and choosing "Fabric:"

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
