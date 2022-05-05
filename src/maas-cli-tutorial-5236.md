<!-- "MAAS Zero to Sixty" -->

Let's install MAAS and get some machines up and running, using the MAAS CLI.

## Installation

Begin by installing (but not initialising) the MAAS snap:

```nohighlight
sudo snap install maas --channel=3.1
maas (3.1/stable) <some-build-string> from Canonical installed
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

## Initialisation

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

### Creating an admin user

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

## Configuring MAAS

The first step in the config journey is logging in.  In the CLI, that's a two-stepper:

```nohighlight
sudo maas apikey --username=admin > api-key-file
```

You can make sure you got a valid API key by displaying the contents of api-key-file:

```nohighlight
cat api-key-file
XXEjkeeqM:zXb7LkuPY7VxShFNhCFDaD8WnP8gLVL8V64GbSn:tTKdwWV64GbSn:tTKdwW
```

[note]
You need to run the `apikey` command to get an API key.  You can't cut and paste the one above, it won't work.
[/note]

Anyway, we can now login to MAAS.  But first, let's try "maas --help" -- there's an important distinction that you'll want to remember:

```nohighlight
maas --help
usage: maas [-h] COMMAND ...

optional arguments:
   -h, --help      show this help message and exit

drill down:
   COMMAND
      login         Log in to a remote API, and remember its description and credentials.
      logout        Log out of a remote API, purging any stored credentials.
      list          List remote APIs that have been logged-in to.
      refresh       Refresh the API descriptions of all profiles.
      init          Initialise MAAS in the specified run mode.
      config        View or change controller configuration.
      status        Status of controller services.
      migrate       Perform migrations on connected database.
      apikey        Used to manage a user's API keys. Shows existing keys unless --generate or --delete is passed.
      configauth    Configure external authentication.
      createadmin   Create a MAAS administrator account.
      changepassword
		    Change a MAAS user's password.
      admin         Interact with http://192.168.43.251:5240/MAAS/api/2.0/


```

This is the help you get (a) if you're not logged in, or (b) if you don't type a logged-in username (called a "profile") after "maas". What you see above isn't even half of what MAAS can do, but it's all you get as an unrecognized user.

So now, let's login and try that help again:

[note]
Your MAAS address will probably not be the same as the one I'm using; cutting and pasting won't work.
[/note]

```nohighlight
maas login admin http://192.168.43.251:5240/MAAS/api/2.0/ < api-key-file

You are now logged in to the MAAS server at
http://192.168.43.251:5240/MAAS/api/2.0/ with the profile name 'admin'.

For help with the available commands, try:

maas admin --help
```

Now, having done that, we can get a much better idea what MAAS will do:

```nohighlight
maas admin --help

usage: maas admin [-h] COMMAND ...

Issue commands to the MAAS region controller at http://192.168.43.251:5240/MAAS/api/2.0/.

optional arguments:
   -h, --help            show this help message and exit

drill down:
   COMMAND
      account             Manage the current logged-in user.
      bcache-cache-set    Manage bcache cache set on a machine.
      bcache-cache-sets   Manage bcache cache sets on a machine.
      bcache              Manage bcache device on a machine.
      bcaches             Manage bcache devices on a machine.
      block-device        Manage a block device on a machine.
      block-devices       Manage block devices on a machine.
      boot-resource       Manage a boot resource.
      boot-resources      Manage the boot resources.
      boot-source         Manage a boot source.
      boot-source-selection
			  Manage a boot source selection.
      boot-source-selections
			  Manage the collection of boot source selections.
      boot-sources        Manage the collection of boot sources.
      commissioning-script
			  Manage a custom commissioning script.
      commissioning-scripts
			  Manage custom commissioning scripts.
      dhcpsnippet         Manage an individual DHCP snippet.
      dhcpsnippets        Manage the collection of all DHCP snippets in MAAS.
      dnsresource         Manage dnsresource.
      dnsresource-record  Manage dnsresourcerecord.
      dnsresource-records
			  Manage DNS resource records (e.g. CNAME, MX, NS, SRV, TXT)
      dnsresources        Manage dnsresources.
      device              Manage an individual device.
      devices             Manage the collection of all the devices in the MAAS.
      discoveries         Query observed discoveries.
      discovery           Read or delete an observed discovery.
      domain              Manage domain.
      domains             Manage domains.
      events              Retrieve filtered node events.
      fabric              Manage fabric.
      fabrics             Manage fabrics.
      fan-network         Manage Fan Network.
      fan-networks        Manage Fan Networks.
      file                Manage a FileStorage object.
      files               Manage the collection of all the files in this MAAS.
      ipaddresses         Manage IP addresses allocated by MAAS.
      iprange             Manage IP range.
      ipranges            Manage IP ranges.
      interface           Manage a node's or device's interface.
      interfaces          Manage interfaces on a node.
      license-key         Manage a license key.
      license-keys        Manage the license keys.
      maas                Manage the MAAS server.
      machine             Manage an individual machine.
      machines            Manage the collection of all the machines in the MAAS.
      network             Manage a network.
      networks            Manage the networks.
      node                Manage an individual Node.
      node-results        Read the collection of commissioning script results.
      node-script         Manage or view a custom script.
      node-script-result  Manage node script results.
      node-script-results
			  Manage node script results.
      node-scripts        Manage custom scripts.
      nodes               Manage the collection of all the nodes in the MAAS.
      notification        Manage an individual notification.
      notifications       Manage the collection of all the notifications in MAAS.
      package-repositories
			  Manage the collection of all Package Repositories in MAAS.
      package-repository  Manage an individual package repository.
      partition           Manage partition on a block device.
      partitions          Manage partitions on a block device.
      pod                 Manage an individual pod.
      pods                Manage the collection of all the pod in the MAAS.
      rack-controller     Manage an individual rack controller.
      rack-controllers    Manage the collection of all rack controllers in MAAS.
      raid                Manage a specific RAID (Redundant Array of Independent
			  Disks) on a machine.
      raids               Manage all RAIDs (Redundant Array of Independent Disks) on
			  a machine.
      region-controller   Manage an individual region controller.
      region-controllers  Manage the collection of all region controllers in MAAS.
      resource-pool       Manage a resource pool.
      resource-pools      Manage resource pools.
      sshkey              Manage an SSH key.
      sshkeys             Manage the collection of all the SSH keys in this MAAS.
      sslkey              Manage an SSL key.
      sslkeys             Operations on multiple keys.
      space               Manage space.
      spaces              Manage spaces.
      static-route        Manage static route.
      static-routes       Manage static routes.
      subnet              Manage subnet.
      subnets             Manage subnets.
      tag                 Tags are properties that can be associated with a Node and
			  serve as criteria for selecting and allocating nodes.
      tags                Manage all tags known to MAAS.
      user                Manage a user account.
      users               Manage the user accounts of this MAAS.
      version             Information about this MAAS instance.
      virtual-machine     Manage individual virtual machines.
      virtual-machines    Manage a collection of virtual machines.
      vlan                Manage a VLAN on a fabric.
      vlans               Manage VLANs on a fabric.
      vm-host             Manage an individual vm-host.
      vm-hosts            Manage the collection of all the vm-hosts in the MAAS.
      vmfs-datastore      Manage VMFS datastore on a machine.
      vmfs-datastores     Manage VMFS datastores on a machine.
      volume-group        Manage volume group on a machine.
      volume-groups       Manage volume groups on a machine.
      zone                Manage a physical zone.
      zones               Manage physical zones.

      This is a profile.  Any commands you issue on this profile will
      operate on the MAAS region server.

      The command information you see here comes from the region server's
      API; it may differ for different profiles.  If you believe the API may
      have changed, use the command's 'refresh' sub-command to fetch the
      latest version of this help information from the server.
```

The next step?  Set the DNS server IP address.  You can do this by issuing the CLI subcommand called "dnsresource".  Let's look at the help for that command:

```nohighlight
maas admin dnsresource --help
Usage: maas admin dnsresource [-h] COMMAND ...

Manage dnsresource.

optional arguments:
   -h, --help  show this help message and exit

drill down:
   COMMAND
      read      Read a DNS resource
      update    Update a DNS resource
      delete    Delete a DNS resource
```

That looks like what we want; let's be naive and try that:

```nohighlight
maas admin dnsresource read
Usage: maas admin dnsresource read [--help] [-d] [-k] id [data [data ...]]

Read a DNS resource

positional arguments:
   id
   data

optional arguments:
   --help, -h      Show this help message and exit.
   -d, --debug     Display more information about API responses.
   -k, --insecure  Disable SSL certificate check

Read a DNS resource by id.
   the following arguments are required: id, data
```

Well, that's weird, and not what we want.  But wait -- the CLI follows the "collection-instance" rule.  Listing DNS resources would be part of a collection, so they would be pluralized.  Let's try `dnsresources` (plural):

```nohighlight
maas admin dnsresources read
Success.
Machine-readable output follows:
[]
```

That isn't it either, but in the `maas set-config` command there is a parameter named `upstream_dns` for which we can set a value.  Let's try that:

```nohighlight
maas admin maas set-config name=upstream_dns value="8.8.8.8"
Success.
Machine-readable output follows:
OK
```

Yep, that's it. It isn't obvious whether we needed to type the IP address with quotes.  In fact, it doesn't matter; whatever makes you feel more comfortable:

```nohighlight
maas admin maas set-config name=upstream_dns value=8.8.8.8
Success.
Machine-readable output follows:
OK
```

## Importing images

Next, we need to import images.  Some images automatically sync, so let's bring in some other image (like Ubuntu 16.04 LTS) just to see how that works.

Reading the help, it says we can discover the images we've already downloaded, using the following command:

```nohighlight
maas admin boot-resources read
```

The JSON resulting from this command is rather lengthy, so we've collapsed it to a pop-down.  You can click the arrow to see the JSON returns.  Incidentally, we'll do that from now on with long listings:

<details><summary>Success.</summary>

```nohighlight
Success.
Machine-readable output follows:
[
    {
	"id": 7,
	"type": "Synced",
	"name": "grub-efi-signed/uefi",
	"architecture": "amd64/generic",
	"resource_uri": "/MAAS/api/2.0/boot-resources/7/"
    },
    {
	"id": 8,
	"type": "Synced",
	"name": "grub-efi/uefi",
	"architecture": "arm64/generic",
	"resource_uri": "/MAAS/api/2.0/boot-resources/8/"
    },
    {
	"id": 9,
	"type": "Synced",
	"name": "grub-ieee1275/open-firmware",
	"architecture": "ppc64el/generic",
	"resource_uri": "/MAAS/api/2.0/boot-resources/9/"
    },
    {
	"id": 10,
	"type": "Synced",
	"name": "pxelinux/pxe",
	"architecture": "i386/generic",
	"resource_uri": "/MAAS/api/2.0/boot-resources/10/"
    },
    {
	"id": 1,
	"type": "Synced",
	"name": "ubuntu/bionic",
	"architecture": "amd64/ga-18.04",
	"resource_uri": "/MAAS/api/2.0/boot-resources/1/",
	"subarches": "generic,hwe-p,hwe-q,hwe-r,hwe-s,hwe-t,hwe-u,hwe-v,hwe-w,ga-16.04,ga-16.10,ga-17.04,ga-17.10,ga-18.04"
    },
    {
	"id": 2,
	"type": "Synced",
	"name": "ubuntu/bionic",
	"architecture": "amd64/ga-18.04-lowlatency",
	"resource_uri": "/MAAS/api/2.0/boot-resources/2/",
	"subarches": "generic,hwe-p,hwe-q,hwe-r,hwe-s,hwe-t,hwe-u,hwe-v,hwe-w,ga-16.04,ga-16.10,ga-17.04,ga-17.10,ga-18.04"
    },
    {
	"id": 3,
	"type": "Synced",
	"name": "ubuntu/bionic",
	"architecture": "amd64/hwe-18.04",
	"resource_uri": "/MAAS/api/2.0/boot-resources/3/",
	"subarches": "generic,hwe-p,hwe-q,hwe-r,hwe-s,hwe-t,hwe-u,hwe-v,hwe-w,ga-16.04,ga-16.10,ga-17.04,ga-17.10,ga-18.04"
    },
    {
	"id": 4,
	"type": "Synced",
	"name": "ubuntu/bionic",
	"architecture": "amd64/hwe-18.04-edge",
	"resource_uri": "/MAAS/api/2.0/boot-resources/4/",
	"subarches": "generic,hwe-p,hwe-q,hwe-r,hwe-s,hwe-t,hwe-u,hwe-v,hwe-w,ga-16.04,ga-16.10,ga-17.04,ga-17.10,ga-18.04,hwe-18.10,hwe-19.04"
    },
    {
	"id": 5,
	"type": "Synced",
	"name": "ubuntu/bionic",
	"architecture": "amd64/hwe-18.04-lowlatency",
	"resource_uri": "/MAAS/api/2.0/boot-resources/5/",
	"subarches": "generic,hwe-p,hwe-q,hwe-r,hwe-s,hwe-t,hwe-u,hwe-v,hwe-w,ga-16.04,ga-16.10,ga-17.04,ga-17.10,ga-18.04"
    },
    {
	"id": 6,
	"type": "Synced",
	"name": "ubuntu/bionic",
	"architecture": "amd64/hwe-18.04-lowlatency-edge",
	"resource_uri": "/MAAS/api/2.0/boot-resources/6/",
	"subarches": "generic,hwe-p,hwe-q,hwe-r,hwe-s,hwe-t,hwe-u,hwe-v,hwe-w,ga-16.04,ga-16.10,ga-17.04,ga-17.10,ga-18.04,hwe-18.10,hwe-19.04"
    }
]
```
</details>

Okay, that's a lot of information, but it looks like we have a bunch of 18.04 images downloaded and synched.  Depending on what version of MAAS you're using, your list could be a lot different, and that doesn't matter here.

Let's try to get a little fancy with  `grep` and see if we can make that list shorter:

```nohighlight
maas admin boot-resources read | grep architecture
```

This produces a quick list of the images we've successfully downloaded:<br />

```nohighlight
"architecture": "amd64/generic",
"architecture": "arm64/generic",
"architecture": "ppc64el/generic",
"architecture": "i386/generic",
"architecture": "amd64/ga-18.04",
"architecture": "amd64/ga-18.04-lowlatency",
"architecture": "amd64/hwe-18.04",
"architecture": "amd64/hwe-18.04-edge",
"architecture": "amd64/hwe-18.04-lowlatency",
"architecture": "amd64/hwe-18.04-lowlatency-edge",
```

That definitely confirms that we have some images.  But what are those three or four on top?  Looking at the massive JSON output, notice that they have names like "open-firmware," "uefi," and "pxe."  Those are images that can PXE-boot machines, basically.  But how can we sort this information out in a neat way?

Well, if you're going to use anything with JSON-based output, you'll want to consider learning the command line tool [[https://stedolan.github.io/jq/][jq]].  It's quite handy for parsing the JSON output of the MAAS CLI.  So, for example, if we want a lightly formatted table of names and architectures, we can run that last command through `jq` like this:

```nohighlight
maas admin boot-resources read | jq -r '.[] | "\(.name)\t\(.architecture)"'
```

This gives us a cleaner image list that looks something like this:

```nohighlight
grub-efi-signed/uefi         amd64/generic
grub-efi/uefi                arm64/generic
grub-ieee1275/open-firmware  ppc64el/generic
pxelinux/pxe                 i386/generic
ubuntu/bionic                amd64/ga-18.04
ubuntu/bionic                amd64/ga-18.04-lowlatency
ubuntu/bionic                amd64/hwe-18.04
ubuntu/bionic                amd64/hwe-18.04-edge
ubuntu/bionic                amd64/hwe-18.04-lowlatency
ubuntu/bionic                amd64/hwe-18.04-lowlatency-edge
```

So basically, we have images needed to boot and deloy machines.  That's a good start, but let's pull down another image for the practice.

We can select images with the `boot-source-selections` command, so let's try that with old "Trusty" (Xenial Xerus, aka 16.04):

```nohighlight
maas admin boot-source-selections create 1 \
  > os="ubuntu" release="trusty" arches="amd64" subarches="*" \
  > labels="*"
```

The results look like this:

```nohighlight
Success.
Machine-readable output follows:
{
    "os": "ubuntu",
    "release": "trusty",
    "arches": [
	"amd64"
    ],
    "subarches": [
	"*"
    ],
    "labels": [
	"*"
    ],
    "boot_source_id": 1,
    "id": 2,
    "resource_uri": "/MAAS/api/2.0/boot-sources/1/selections/2/"
}
```

And that worked, which is good, because that was a long command to type correctly.  Luckily, downloading (importing) them is a fairly simple command:

```nohighlight
maas admin boot-resources import
Success.
Machine-readable output follows:
Import of boot resources started
```

## Configuring DHCP
The whole point here is to get machines deployed, so the next step is to get DHCP working.  We have to find the right VLAN, which isn't too hard, since at this point there's only one.

In order to turn on DHCP, we need to know two things besides the VLAN name ("untagged"): we need to know the fabric ID and the primary rack controller name. Actually, to start with, all the fabrics will be on the same untagged VLAN, so any fabric will do. We can find a usable fabric by picking a valid bridge IP address like this:


```nohighlight
maas admin subnet read 192.168.123.0/24 | grep fabric_id
"fabric_id": 2,
```

Then we need to find the name of the primary rack controller:

```nohighlight
 maas admin rack-controllers read | grep hostname | cut -d '"' -f 4
wintermute
```

So we should be able to turn on DHCP like this:

```nohighlight
maas admin vlan update 2 untagged dhcp_on=True primary_rack=wintermute
{"dhcp_on": ["dhcp can only be turned on when a dynamic IP range is defined."]}
```

Wait. We need to define a dynamic IP range for this to work.  Well, my virtual bridge is on 192.168.123.0/24. Yours will be in a different place, most likely.  We want to use that subnet, so let's choose a reasonable IP range, like, say, 192.168.123.190 to 192.168.123.253:

```nohighlight
 maas admin ipranges create type=dynamic start_ip=192.168.123.190 end_ip=192.168.123.253
```

Remember that your subnet address will probably be different, so you'll need to create a range within that subnet.  The result of this command is:

<details><summary>Success.</summary>

```nohighlight
Success.
Machine-readable output follows:
{
    "subnet": {
	"name": "192.168.123.0/24",
	"description": "",
	"vlan": {
	    "vid": 0,
	    "mtu": 1500,
	    "dhcp_on": false,
	    "external_dhcp": null,
	    "relay_vlan": null,
	    "fabric": "fabric-2",
	    "primary_rack": null,
	    "name": "untagged",
	    "id": 5003,
	    "space": "undefined",
	    "secondary_rack": null,
	    "fabric_id": 2,
	    "resource_uri": "/MAAS/api/2.0/vlans/5003/"
	},
	"cidr": "192.168.123.0/24",
	"rdns_mode": 2,
	"gateway_ip": null,
	"dns_servers": [],
	"allow_dns": true,
	"allow_proxy": true,
	"active_discovery": false,
	"managed": true,
	"id": 4,
	"space": "undefined",
	"resource_uri": "/MAAS/api/2.0/subnets/4/"
    },
    "type": "dynamic",
    "start_ip": "192.168.123.190",
    "end_ip": "192.168.123.253",
    "user": {
	"is_superuser": true,
	"username": "admin",
	"email": "admin@admin.com",
	"is_local": true,
	"resource_uri": "/MAAS/api/2.0/users/admin/"
    },
    "comment": "",
    "id": 1,
    "resource_uri": "/MAAS/api/2.0/ipranges/1/"
}
```
</details>

Okay, now let's try that DHCP switch-on one more time:

```nohighlight
 maas admin vlan update 2 untagged dhcp_on=True primary_rack=wintermute
```

Now it works:

```nohighlight
Success.
Machine-readable output follows:
{
    "vid": 0,
    "mtu": 1500,
    "dhcp_on": true,
    "external_dhcp": null,
    "relay_vlan": null,
    "fabric": "fabric-2",
    "space": "undefined",
    "primary_rack": "8dwnne",
    "secondary_rack": null,
    "name": "untagged",
    "fabric_id": 2,
    "id": 5003,
    "resource_uri": "/MAAS/api/2.0/vlans/5003/"
}
```

## Commissioning machines

In order to deploy machines, we've got to create some, plain and simple, and then commission them.  We're using `virsh` for this example, but you can use LXD or any VM hosting tool you're comfortable with:

```nohighlight
 maas admin machines create
  > architecture=amd64
  > mac_addresses=52:54:00:15:36:f2
  > power_type=virsh
  > power_parameters_power_id=f677a842-571c-4e65-adc9-11e2cf92d363
  > power_parameters_power_address=qemu+ssh://stormrider@192.168.123.1/system
  > power_parameters_power_pass=xxxxxxxx

```

That seemed to work:

<details><summary>Success.</summary>

```nohighlight
Success.
Machine-readable output follows:
{
    "storage": 0.0,
    "tag_names": [],
    "special_filesystems": [],
    "memory": 0,
    "boot_disk": null,
    "virtualblockdevice_set": [],
    "hardware_info": {
	"system_vendor": "Unknown",
	"system_product": "Unknown",
	"system_family": "Unknown",
	"system_version": "Unknown",
	"system_sku": "Unknown",
	"system_serial": "Unknown",
	"cpu_model": "Unknown",
	"mainboard_vendor": "Unknown",
	"mainboard_product": "Unknown",
	"mainboard_serial": "Unknown",
	"mainboard_version": "Unknown",
	"mainboard_firmware_vendor": "Unknown",
	"mainboard_firmware_date": "Unknown",
	"mainboard_firmware_version": "Unknown",
	"chassis_vendor": "Unknown",
	"chassis_type": "Unknown",
	"chassis_serial": "Unknown",
	"chassis_version": "Unknown"
    },
    "address_ttl": null,
    "memory_test_status": -1,
    "other_test_status_name": "Unknown",
    "osystem": "",
    "status_message": "Commissioning",
    "netboot": true,
    "physicalblockdevice_set": [],
    "node_type": 0,
    "cpu_test_status": -1,
    "memory_test_status_name": "Unknown",
    "bcaches": [],
    "storage_test_status": 0,
    "system_id": "bhxws3",
    "status": 1,
    "commissioning_status": 0,
    "power_type": "virsh",
    "locked": false,
    "numanode_set": [
	{
	    "index": 0,
	    "memory": 0,
	    "cores": []
	}
    ],
    "bios_boot_method": null,
    "fqdn": "ace-swan.maas",
    "node_type_name": "Machine",
    "hostname": "ace-swan",
    "volume_groups": [],
    "testing_status": 0,
    "network_test_status": -1,
    "other_test_status": -1,
    "interface_test_status": -1,
    "hwe_kernel": null,
    "blockdevice_set": [],
    "testing_status_name": "Pending",
    "power_state": "unknown",
    "min_hwe_kernel": "",
    "owner": "admin",
    "distro_series": "",
    "storage_test_status_name": "Pending",
    "cpu_speed": 0,
    "swap_size": null,
    "cpu_test_status_name": "Unknown",
    "hardware_uuid": null,
    "architecture": "amd64/generic",
    "pool": {
	"name": "default",
	"description": "Default pool",
	"id": 0,
	"resource_uri": "/MAAS/api/2.0/resourcepool/0/"
    },
    "cache_sets": [],
    "pod": null,
    "iscsiblockdevice_set": [],
    "disable_ipv4": false,
    "status_action": "",
    "boot_interface": {
	"name": "eth0",
	"id": 10,
	"product": null,
	"system_id": "bhxws3",
	"effective_mtu": 1500,
	"children": [],
	"link_connected": true,
	"enabled": true,
	"interface_speed": 0,
	"numa_node": 0,
	"firmware_version": null,
	"parents": [],
	"discovered": null,
	"params": "",
	"links": [],
	"sriov_max_vf": 0,
	"tags": [],
	"type": "physical",
	"vlan": null,
	"vendor": null,
	"link_speed": 0,
	"mac_address": "52:54:00:15:36:f2",
	"resource_uri": "/MAAS/api/2.0/nodes/bhxws3/interfaces/10/"
    },
    "cpu_count": 0,
    "domain": {
	"authoritative": true,
	"ttl": null,
	"resource_record_count": 0,
	"name": "maas",
	"is_default": true,
	"id": 0,
	"resource_uri": "/MAAS/api/2.0/domains/0/"
    },
    "current_testing_result_id": 7,
    "default_gateways": {
	"ipv4": {
	    "gateway_ip": null,
	    "link_id": null
	},
	"ipv6": {
	    "gateway_ip": null,
	    "link_id": null
	}
    },
    "interface_set": [
	{
	    "name": "eth0",
	    "id": 10,
	    "product": null,
	    "system_id": "bhxws3",
	    "effective_mtu": 1500,
	    "children": [],
	    "link_connected": true,
	    "enabled": true,
	    "interface_speed": 0,
	    "numa_node": 0,
	    "firmware_version": null,
	    "parents": [],
	    "discovered": null,
	    "params": "",
	    "links": [],
	    "sriov_max_vf": 0,
	    "tags": [],
	    "type": "physical",
	    "vlan": null,
	    "vendor": null,
	    "link_speed": 0,
	    "mac_address": "52:54:00:15:36:f2",
	    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/interfaces/10/"
	}
    ],
    "status_name": "Commissioning",
    "commissioning_status_name": "Pending",
    "owner_data": {},
    "ip_addresses": [],
    "raids": [],
    "network_test_status_name": "Unknown",
    "description": "",
    "current_commissioning_result_id": 6,
    "interface_test_status_name": "Unknown",
    "current_installation_result_id": null,
    "zone": {
	"name": "default",
	"description": "",
	"id": 1,
	"resource_uri": "/MAAS/api/2.0/zones/default/"
    },
    "resource_uri": "/MAAS/api/2.0/machines/bhxws3/"
}
```
</details>

And just like that, it's already commissioning (MAAS does that if it can).

### Commissioning by CLI

So now we have a machine in the "Ready" state, but let's also get familiar with commanding MAAS to commission it via the CLI.  All we really need for that is the system ID, which is the last parameter in the "resource uri" above.  But just for grins, let's go ahead and retrieve the system ID using the CLI.

There's only one in this example, so we don't have to worry about any other cross-referencing on this machine:

```nohighlight
 maas admin machines read | jq '.[] | .hostname, .system_id'
"ace-swan"
"bhxws3"
```

Okay, now we can use that system ID to commission the machine via the CLI:

```nohighlight
 maas admin machine commission bhxws3
```

And commissioning should start and return success:

<details><summary>Success.</summary>

```nohighlight
Success.
Machine-readable output follows:
{
    "storage_test_status_name": "Pending",
    "bcaches": [],
    "cpu_count": 1,
    "interface_set": [
	{
	    "params": "",
	    "numa_node": 0,
	    "tags": [],
	    "id": 10,
	    "mac_address": "52:54:00:15:36:f2",
	    "vendor": "Red Hat, Inc.",
	    "children": [],
	    "effective_mtu": 1500,
	    "discovered": [],
	    "links": [],
	    "link_speed": 0,
	    "link_connected": true,
	    "system_id": "bhxws3",
	    "enabled": true,
	    "interface_speed": 0,
	    "firmware_version": null,
	    "name": "ens3",
	    "sriov_max_vf": 0,
	    "product": null,
	    "vlan": {
		"vid": 0,
		"mtu": 1500,
		"dhcp_on": true,
		"external_dhcp": null,
		"relay_vlan": null,
		"fabric": "fabric-2",
		"primary_rack": "8dwnne",
		"name": "untagged",
		"id": 5003,
		"space": "undefined",
		"secondary_rack": null,
		"fabric_id": 2,
		"resource_uri": "/MAAS/api/2.0/vlans/5003/"
	    },
	    "parents": [],
	    "type": "physical",
	    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/interfaces/10/"
	}
    ],
    "network_test_status_name": "Unknown",
    "numanode_set": [
	{
	    "index": 0,
	    "memory": 985,
	    "cores": [
		0
	    ]
	}
    ],
    "locked": false,
    "hardware_uuid": "F677A842-571C-4E65-ADC9-11E2CF92D363",
    "default_gateways": {
	"ipv4": {
	    "gateway_ip": null,
	    "link_id": null
	},
	"ipv6": {
	    "gateway_ip": null,
	    "link_id": null
	}
    },
    "status_action": "",
    "status_message": "Commissioning",
    "cpu_test_status_name": "Unknown",
    "memory_test_status": -1,
    "virtualblockdevice_set": [],
    "pool": {
	"name": "default",
	"description": "Default pool",
	"id": 0,
	"resource_uri": "/MAAS/api/2.0/resourcepool/0/"
    },
    "current_testing_result_id": 9,
    "current_installation_result_id": null,
    "netboot": true,
    "description": "",
    "special_filesystems": [],
    "testing_status": 0,
    "memory": 1024,
    "current_commissioning_result_id": 8,
    "storage": 5368.70912,
    "commissioning_status": 0,
    "cpu_test_status": -1,
    "tag_names": [
	"virtual"
    ],
    "memory_test_status_name": "Unknown",
    "swap_size": null,
    "status_name": "Commissioning",
    "other_test_status": -1,
    "pod": null,
    "storage_test_status": 0,
    "blockdevice_set": [
	{
	    "id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
	    "size": 5368709120,
	    "block_size": 512,
	    "tags": [
		"ssd"
	    ],
	    "serial": "QM00001",
	    "uuid": null,
	    "numa_node": 0,
	    "available_size": 5368709120,
	    "id": 3,
	    "partition_table_type": null,
	    "model": "QEMU HARDDISK",
	    "path": "/dev/disk/by-dname/sda",
	    "storage_pool": null,
	    "used_for": "Unused",
	    "filesystem": null,
	    "system_id": "bhxws3",
	    "used_size": 0,
	    "partitions": [],
	    "name": "sda",
	    "type": "physical",
	    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
	}
    ],
    "other_test_status_name": "Unknown",
    "distro_series": "",
    "testing_status_name": "Pending",
    "ip_addresses": [],
    "address_ttl": null,
    "system_id": "bhxws3",
    "physicalblockdevice_set": [
	{
	    "firmware_version": "2.5+",
	    "serial": "QM00001",
	    "uuid": null,
	    "numa_node": 0,
	    "available_size": 5368709120,
	    "size": 5368709120,
	    "tags": [
		"ssd"
	    ],
	    "id": 3,
	    "partition_table_type": null,
	    "id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
	    "model": "QEMU HARDDISK",
	    "path": "/dev/disk/by-dname/sda",
	    "storage_pool": null,
	    "used_for": "Unused",
	    "filesystem": null,
	    "system_id": "bhxws3",
	    "used_size": 0,
	    "partitions": [],
	    "name": "sda",
	    "block_size": 512,
	    "type": "physical",
	    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
	}
    ],
    "fqdn": "ace-swan.maas",
    "osystem": "",
    "domain": {
	"authoritative": true,
	"ttl": null,
	"resource_record_count": 0,
	"name": "maas",
	"id": 0,
	"is_default": true,
	"resource_uri": "/MAAS/api/2.0/domains/0/"
    },
    "boot_interface": {
	"params": "",
	"numa_node": 0,
	"tags": [],
	"id": 10,
	"mac_address": "52:54:00:15:36:f2",
	"vendor": "Red Hat, Inc.",
	"children": [],
	"effective_mtu": 1500,
	"discovered": [],
	"links": [],
	"link_speed": 0,
	"link_connected": true,
	"system_id": "bhxws3",
	"enabled": true,
	"interface_speed": 0,
	"firmware_version": null,
	"name": "ens3",
	"sriov_max_vf": 0,
	"product": null,
	"vlan": {
	    "vid": 0,
	    "mtu": 1500,
	    "dhcp_on": true,
	    "external_dhcp": null,
	    "relay_vlan": null,
	    "fabric": "fabric-2",
	    "primary_rack": "8dwnne",
	    "name": "untagged",
	    "id": 5003,
	    "space": "undefined",
	    "secondary_rack": null,
	    "fabric_id": 2,
	    "resource_uri": "/MAAS/api/2.0/vlans/5003/"
	},
	"parents": [],
	"type": "physical",
	"resource_uri": "/MAAS/api/2.0/nodes/bhxws3/interfaces/10/"
    },
    "hostname": "ace-swan",
    "network_test_status": -1,
    "min_hwe_kernel": "",
    "power_state": "off",
    "interface_test_status_name": "Unknown",
    "owner_data": {},
    "volume_groups": [],
    "power_type": "virsh",
    "node_type": 0,
    "owner": "admin",
    "cache_sets": [],
    "architecture": "amd64/generic",
    "hwe_kernel": null,
    "zone": {
	"name": "default",
	"description": "",
	"id": 1,
	"resource_uri": "/MAAS/api/2.0/zones/default/"
    },
    "disable_ipv4": false,
    "boot_disk": {
	"firmware_version": "2.5+",
	"serial": "QM00001",
	"uuid": null,
	"numa_node": 0,
	"available_size": 5368709120,
	"size": 5368709120,
	"tags": [
	    "ssd"
	],
	"id": 3,
	"partition_table_type": null,
	"id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
	"model": "QEMU HARDDISK",
	"path": "/dev/disk/by-dname/sda",
	"storage_pool": null,
	"used_for": "Unused",
	"filesystem": null,
	"system_id": "bhxws3",
	"used_size": 0,
	"partitions": [],
	"name": "sda",
	"block_size": 512,
	"type": "physical",
	"resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
    },
    "status": 1,
    "iscsiblockdevice_set": [],
    "raids": [],
    "node_type_name": "Machine",
    "hardware_info": {
	"system_vendor": "QEMU",
	"system_product": "Standard PC (i440FX + PIIX, 1996)",
	"system_family": "Unknown",
	"system_version": "pc-i440fx-focal",
	"system_sku": "Unknown",
	"system_serial": "Unknown",
	"cpu_model": "Intel Core Processor (Skylake, IBRS)",
	"mainboard_vendor": "Unknown",
	"mainboard_product": "Unknown",
	"mainboard_serial": "Unknown",
	"mainboard_version": "Unknown",
	"mainboard_firmware_vendor": "SeaBIOS",
	"mainboard_firmware_date": "04/01/2014",
	"mainboard_firmware_version": "1.13.0-1ubuntu1",
	"chassis_vendor": "QEMU",
	"chassis_type": "Other",
	"chassis_serial": "Unknown",
	"chassis_version": "pc-i440fx-focal"
    },
    "commissioning_status_name": "Pending",
    "bios_boot_method": "pxe",
    "interface_test_status": -1,
    "cpu_speed": 0,
    "resource_uri": "/MAAS/api/2.0/machines/bhxws3/"
}
```
</details>

And that's it, it's that easy. It takes a minute to get all the parameters together to create a new machine, but it isn't that difficult.  

## Deploying machines

The real value of MAAS, of course, is deploying machines without having to be there.  That's what we're going to do next.

### Allocating a machine

When it's finished commissioning, we can allocate a machine like this:

```nohighlight
maas admin machines allocate system_id=bhxws3
```

Allocating assigns ownership of that machine to the requesting user, which prevents others from changing the state of your machine you aren't expecting it.  When successful, you'll get a return like this:

<details><summary>Success.</summary>

```nohighlight
Success.
Machine-readable output follows:
{
    "raids": [],
    "zone": {
	"name": "default",
	"description": "",
	"id": 1,
	"resource_uri": "/MAAS/api/2.0/zones/default/"
    },
    "current_commissioning_result_id": 8,
    "storage_test_status": 2,
    "current_testing_result_id": 9,
    "bcaches": [],
    "ip_addresses": [
	"192.168.123.190"
    ],
    "pool": {
	"name": "default",
	"description": "Default pool",
	"id": 0,
	"resource_uri": "/MAAS/api/2.0/resourcepool/0/"
    },
    "physicalblockdevice_set": [
	{
	    "firmware_version": "2.5+",
	    "id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
	    "system_id": "bhxws3",
	    "partition_table_type": "GPT",
	    "type": "physical",
	    "block_size": 512,
	    "id": 3,
	    "numa_node": 0,
	    "partitions": [
		{
		    "uuid": "8aa1164c-8a91-41d7-92e3-c411634355bb",
		    "size": 5360320512,
		    "bootable": false,
		    "tags": [],
		    "id": 3,
		    "used_for": "ext4 formatted filesystem mounted at /",
		    "device_id": 3,
		    "system_id": "bhxws3",
		    "path": "/dev/disk/by-dname/sda-part2",
		    "type": "partition",
		    "filesystem": {
			"fstype": "ext4",
			"label": "root",
			"uuid": "68487852-7e38-4605-a84e-d787532fd443",
			"mount_point": "/",
			"mount_options": null
		    },
		    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/partition/3"
		}
	    ],
	    "filesystem": null,
	    "available_size": 0,
	    "size": 5368709120,
	    "storage_pool": null,
	    "model": "QEMU HARDDISK",
	    "used_size": 5366611968,
	    "tags": [
		"ssd"
	    ],
	    "used_for": "GPT partitioned with 1 partition",
	    "uuid": null,
	    "name": "sda",
	    "path": "/dev/disk/by-dname/sda",
	    "serial": "QM00001",
	    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
	}
    ],
    "swap_size": null,
    "storage": 5368.70912,
    "node_type_name": "Machine",
    "system_id": "bhxws3",
    "owner_data": {},
    "special_filesystems": [],
    "tag_names": [
	"virtual"
    ],
    "cpu_test_status_name": "Unknown",
    "locked": false,
    "cpu_count": 1,
    "volume_groups": [],
    "storage_test_status_name": "Passed",
    "hardware_info": {
	"system_vendor": "QEMU",
	"system_product": "Standard PC (i440FX + PIIX, 1996)",
	"system_family": "Unknown",
	"system_version": "pc-i440fx-focal",
	"system_sku": "Unknown",
	"system_serial": "Unknown",
	"cpu_model": "Intel Core Processor (Skylake, IBRS)",
	"mainboard_vendor": "Unknown",
	"mainboard_product": "Unknown",
	"mainboard_serial": "Unknown",
	"mainboard_version": "Unknown",
	"mainboard_firmware_vendor": "SeaBIOS",
	"mainboard_firmware_date": "04/01/2014",
	"mainboard_firmware_version": "1.13.0-1ubuntu1",
	"chassis_vendor": "QEMU",
	"chassis_type": "Other",
	"chassis_serial": "Unknown",
	"chassis_version": "pc-i440fx-focal"
    },
    "node_type": 0,
    "other_test_status": -1,
    "hostname": "ace-swan",
    "interface_test_status": -1,
    "boot_interface": {
	"link_speed": 0,
	"params": "",
	"vendor": "Red Hat, Inc.",
	"firmware_version": null,
	"system_id": "bhxws3",
	"enabled": true,
	"type": "physical",
	"links": [
	    {
		"id": 15,
		"mode": "auto",
		"subnet": {
		    "name": "192.168.123.0/24",
		    "description": "",
		    "vlan": {
			"vid": 0,
			"mtu": 1500,
			"dhcp_on": true,
			"external_dhcp": null,
			"relay_vlan": null,
			"fabric": "fabric-2",
			"id": 5003,
			"secondary_rack": null,
			"primary_rack": "8dwnne",
			"name": "untagged",
			"fabric_id": 2,
			"space": "undefined",
			"resource_uri": "/MAAS/api/2.0/vlans/5003/"
		    },
		    "cidr": "192.168.123.0/24",
		    "rdns_mode": 2,
		    "gateway_ip": null,
		    "dns_servers": [],
		    "allow_dns": true,
		    "allow_proxy": true,
		    "active_discovery": false,
		    "managed": true,
		    "id": 4,
		    "space": "undefined",
		    "resource_uri": "/MAAS/api/2.0/subnets/4/"
		}
	    }
	],
	"id": 10,
	"discovered": [
	    {
		"subnet": {
		    "name": "192.168.123.0/24",
		    "description": "",
		    "vlan": {
			"vid": 0,
			"mtu": 1500,
			"dhcp_on": true,
			"external_dhcp": null,
			"relay_vlan": null,
			"fabric": "fabric-2",
			"id": 5003,
			"secondary_rack": null,
			"primary_rack": "8dwnne",
			"name": "untagged",
			"fabric_id": 2,
			"space": "undefined",
			"resource_uri": "/MAAS/api/2.0/vlans/5003/"
		    },
		    "cidr": "192.168.123.0/24",
		    "rdns_mode": 2,
		    "gateway_ip": null,
		    "dns_servers": [],
		    "allow_dns": true,
		    "allow_proxy": true,
		    "active_discovery": false,
		    "managed": true,
		    "id": 4,
		    "space": "undefined",
		    "resource_uri": "/MAAS/api/2.0/subnets/4/"
		},
		"ip_address": "192.168.123.190"
	    }
	],
	"numa_node": 0,
	"children": [],
	"parents": [],
	"link_connected": true,
	"effective_mtu": 1500,
	"tags": [],
	"sriov_max_vf": 0,
	"interface_speed": 0,
	"name": "ens3",
	"mac_address": "52:54:00:15:36:f2",
	"product": null,
	"vlan": {
	    "vid": 0,
	    "mtu": 1500,
	    "dhcp_on": true,
	    "external_dhcp": null,
	    "relay_vlan": null,
	    "fabric": "fabric-2",
	    "id": 5003,
	    "secondary_rack": null,
	    "primary_rack": "8dwnne",
	    "name": "untagged",
	    "fabric_id": 2,
	    "space": "undefined",
	    "resource_uri": "/MAAS/api/2.0/vlans/5003/"
	},
	"resource_uri": "/MAAS/api/2.0/nodes/bhxws3/interfaces/10/"
    },
    "memory": 1024,
    "memory_test_status_name": "Unknown",
    "default_gateways": {
	"ipv4": {
	    "gateway_ip": null,
	    "link_id": null
	},
	"ipv6": {
	    "gateway_ip": null,
	    "link_id": null
	}
    },
    "blockdevice_set": [
	{
	    "id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
	    "size": 5368709120,
	    "block_size": 512,
	    "tags": [
		"ssd"
	    ],
	    "system_id": "bhxws3",
	    "partition_table_type": "GPT",
	    "type": "physical",
	    "id": 3,
	    "numa_node": 0,
	    "partitions": [
		{
		    "uuid": "8aa1164c-8a91-41d7-92e3-c411634355bb",
		    "size": 5360320512,
		    "bootable": false,
		    "tags": [],
		    "id": 3,
		    "used_for": "ext4 formatted filesystem mounted at /",
		    "device_id": 3,
		    "system_id": "bhxws3",
		    "path": "/dev/disk/by-dname/sda-part2",
		    "type": "partition",
		    "filesystem": {
			"fstype": "ext4",
			"label": "root",
			"uuid": "68487852-7e38-4605-a84e-d787532fd443",
			"mount_point": "/",
			"mount_options": null
		    },
		    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/partition/3"
		}
	    ],
	    "filesystem": null,
	    "available_size": 0,
	    "storage_pool": null,
	    "model": "QEMU HARDDISK",
	    "used_size": 5366611968,
	    "used_for": "GPT partitioned with 1 partition",
	    "uuid": null,
	    "name": "sda",
	    "path": "/dev/disk/by-dname/sda",
	    "serial": "QM00001",
	    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
	}
    ],
    "interface_set": [
	{
	    "link_speed": 0,
	    "params": "",
	    "vendor": "Red Hat, Inc.",
	    "firmware_version": null,
	    "system_id": "bhxws3",
	    "enabled": true,
	    "type": "physical",
	    "links": [
		{
		    "id": 15,
		    "mode": "auto",
		    "subnet": {
			"name": "192.168.123.0/24",
			"description": "",
			"vlan": {
			    "vid": 0,
			    "mtu": 1500,
			    "dhcp_on": true,
			    "external_dhcp": null,
			    "relay_vlan": null,
			    "fabric": "fabric-2",
			    "id": 5003,
			    "secondary_rack": null,
			    "primary_rack": "8dwnne",
			    "name": "untagged",
			    "fabric_id": 2,
			    "space": "undefined",
			    "resource_uri": "/MAAS/api/2.0/vlans/5003/"
			},
			"cidr": "192.168.123.0/24",
			"rdns_mode": 2,
			"gateway_ip": null,
			"dns_servers": [],
			"allow_dns": true,
			"allow_proxy": true,
			"active_discovery": false,
			"managed": true,
			"id": 4,
			"space": "undefined",
			"resource_uri": "/MAAS/api/2.0/subnets/4/"
		    }
		}
	    ],
	    "id": 10,
	    "discovered": [
		{
		    "subnet": {
			"name": "192.168.123.0/24",
			"description": "",
			"vlan": {
			    "vid": 0,
			    "mtu": 1500,
			    "dhcp_on": true,
			    "external_dhcp": null,
			    "relay_vlan": null,
			    "fabric": "fabric-2",
			    "id": 5003,
			    "secondary_rack": null,
			    "primary_rack": "8dwnne",
			    "name": "untagged",
			    "fabric_id": 2,
			    "space": "undefined",
			    "resource_uri": "/MAAS/api/2.0/vlans/5003/"
			},
			"cidr": "192.168.123.0/24",
			"rdns_mode": 2,
			"gateway_ip": null,
			"dns_servers": [],
			"allow_dns": true,
			"allow_proxy": true,
			"active_discovery": false,
			"managed": true,
			"id": 4,
			"space": "undefined",
			"resource_uri": "/MAAS/api/2.0/subnets/4/"
		    },
		    "ip_address": "192.168.123.190"
		}
	    ],
	    "numa_node": 0,
	    "children": [],
	    "parents": [],
	    "link_connected": true,
	    "effective_mtu": 1500,
	    "tags": [],
	    "sriov_max_vf": 0,
	    "interface_speed": 0,
	    "name": "ens3",
	    "mac_address": "52:54:00:15:36:f2",
	    "product": null,
	    "vlan": {
		"vid": 0,
		"mtu": 1500,
		"dhcp_on": true,
		"external_dhcp": null,
		"relay_vlan": null,
		"fabric": "fabric-2",
		"id": 5003,
		"secondary_rack": null,
		"primary_rack": "8dwnne",
		"name": "untagged",
		"fabric_id": 2,
		"space": "undefined",
		"resource_uri": "/MAAS/api/2.0/vlans/5003/"
	    },
	    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/interfaces/10/"
	}
    ],
    "numanode_set": [
	{
	    "index": 0,
	    "memory": 985,
	    "cores": [
		0
	    ]
	}
    ],
    "min_hwe_kernel": "",
    "memory_test_status": -1,
    "power_type": "virsh",
    "power_state": "off",
    "status": 10,
    "testing_status_name": "Passed",
    "interface_test_status_name": "Unknown",
    "cache_sets": [],
    "constraints_by_type": {},
    "domain": {
	"authoritative": true,
	"ttl": null,
	"id": 0,
	"resource_record_count": 0,
	"name": "maas",
	"is_default": true,
	"resource_uri": "/MAAS/api/2.0/domains/0/"
    },
    "network_test_status": -1,
    "current_installation_result_id": null,
    "bios_boot_method": "pxe",
    "status_name": "Allocated",
    "address_ttl": null,
    "fqdn": "ace-swan.maas",
    "cpu_speed": 0,
    "hwe_kernel": null,
    "description": "",
    "commissioning_status_name": "Passed",
    "pod": null,
    "network_test_status_name": "Unknown",
    "hardware_uuid": "F677A842-571C-4E65-ADC9-11E2CF92D363",
    "commissioning_status": 2,
    "status_message": "Ready",
    "owner": "admin",
    "distro_series": "",
    "status_action": "",
    "testing_status": 2,
    "cpu_test_status": -1,
    "architecture": "amd64/generic",
    "netboot": true,
    "iscsiblockdevice_set": [],
    "disable_ipv4": false,
    "virtualblockdevice_set": [],
    "osystem": "",
    "boot_disk": {
	"firmware_version": "2.5+",
	"id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
	"system_id": "bhxws3",
	"partition_table_type": "GPT",
	"type": "physical",
	"block_size": 512,
	"id": 3,
	"numa_node": 0,
	"partitions": [
	    {
		"uuid": "8aa1164c-8a91-41d7-92e3-c411634355bb",
		"size": 5360320512,
		"bootable": false,
		"tags": [],
		"id": 3,
		"used_for": "ext4 formatted filesystem mounted at /",
		"device_id": 3,
		"system_id": "bhxws3",
		"path": "/dev/disk/by-dname/sda-part2",
		"type": "partition",
		"filesystem": {
		    "fstype": "ext4",
		    "label": "root",
		    "uuid": "68487852-7e38-4605-a84e-d787532fd443",
		    "mount_point": "/",
		    "mount_options": null
		},
		"resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/partition/3"
	    }
	],
	"filesystem": null,
	"available_size": 0,
	"size": 5368709120,
	"storage_pool": null,
	"model": "QEMU HARDDISK",
	"used_size": 5366611968,
	"tags": [
	    "ssd"
	],
	"used_for": "GPT partitioned with 1 partition",
	"uuid": null,
	"name": "sda",
	"path": "/dev/disk/by-dname/sda",
	"serial": "QM00001",
	"resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
    },
    "other_test_status_name": "Unknown",
    "resource_uri": "/MAAS/api/2.0/machines/bhxws3/"
}
```
</details>

## Deploying a machine with the CLI
Finally, let's deploy that machine this way:

```nohighlight
maas admin machine deploy bhxws3
```

<details><summary>Success.</summary>

```nohighlight
Success.
Machine-readable output follows:
{
    "architecture": "amd64/generic",
    "cpu_speed": 0,
    "tag_names": [
	"virtual"
    ],
    "boot_interface": {
	"mac_address": "52:54:00:15:36:f2",
	"links": [
	    {
		"id": 15,
		"mode": "auto",
		"subnet": {
		    "name": "192.168.123.0/24",
		    "description": "",
		    "vlan": {
			"vid": 0,
			"mtu": 1500,
			"dhcp_on": true,
			"external_dhcp": null,
			"relay_vlan": null,
			"fabric_id": 2,
			"id": 5003,
			"fabric": "fabric-2",
			"secondary_rack": null,
			"name": "untagged",
			"space": "undefined",
			"primary_rack": "8dwnne",
			"resource_uri": "/MAAS/api/2.0/vlans/5003/"
		    },
		    "cidr": "192.168.123.0/24",
		    "rdns_mode": 2,
		    "gateway_ip": null,
		    "dns_servers": [],
		    "allow_dns": true,
		    "allow_proxy": true,
		    "active_discovery": false,
		    "managed": true,
		    "id": 4,
		    "space": "undefined",
		    "resource_uri": "/MAAS/api/2.0/subnets/4/"
		}
	    }
	],
	"numa_node": 0,
	"enabled": true,
	"params": "",
	"firmware_version": null,
	"sriov_max_vf": 0,
	"type": "physical",
	"children": [],
	"vendor": "Red Hat, Inc.",
	"system_id": "bhxws3",
	"parents": [],
	"vlan": {
	    "vid": 0,
	    "mtu": 1500,
	    "dhcp_on": true,
	    "external_dhcp": null,
	    "relay_vlan": null,
	    "fabric_id": 2,
	    "id": 5003,
	    "fabric": "fabric-2",
	    "secondary_rack": null,
	    "name": "untagged",
	    "space": "undefined",
	    "primary_rack": "8dwnne",
	    "resource_uri": "/MAAS/api/2.0/vlans/5003/"
	},
	"link_connected": true,
	"id": 10,
	"effective_mtu": 1500,
	"discovered": [
	    {
		"subnet": {
		    "name": "192.168.123.0/24",
		    "description": "",
		    "vlan": {
			"vid": 0,
			"mtu": 1500,
			"dhcp_on": true,
			"external_dhcp": null,
			"relay_vlan": null,
			"fabric_id": 2,
			"id": 5003,
			"fabric": "fabric-2",
			"secondary_rack": null,
			"name": "untagged",
			"space": "undefined",
			"primary_rack": "8dwnne",
			"resource_uri": "/MAAS/api/2.0/vlans/5003/"
		    },
		    "cidr": "192.168.123.0/24",
		    "rdns_mode": 2,
		    "gateway_ip": null,
		    "dns_servers": [],
		    "allow_dns": true,
		    "allow_proxy": true,
		    "active_discovery": false,
		    "managed": true,
		    "id": 4,
		    "space": "undefined",
		    "resource_uri": "/MAAS/api/2.0/subnets/4/"
		},
		"ip_address": "192.168.123.190"
	    }
	],
	"link_speed": 0,
	"name": "ens3",
	"product": null,
	"interface_speed": 0,
	"tags": [],
	"resource_uri": "/MAAS/api/2.0/nodes/bhxws3/interfaces/10/"
    },
    "ip_addresses": [
	"192.168.123.190"
    ],
    "testing_status_name": "Passed",
    "osystem": "ubuntu",
    "bcaches": [],
    "owner": "admin",
    "special_filesystems": [],
    "numanode_set": [
	{
	    "index": 0,
	    "memory": 985,
	    "cores": [
		0
	    ]
	}
    ],
    "node_type": 0,
    "cpu_test_status": -1,
    "storage_test_status_name": "Passed",
    "locked": false,
    "disable_ipv4": false,
    "status_message": "Deploying",
    "other_test_status_name": "Unknown",
    "interface_test_status_name": "Unknown",
    "status_name": "Deploying",
    "commissioning_status": 2,
    "hardware_uuid": "F677A842-571C-4E65-ADC9-11E2CF92D363",
    "fqdn": "ace-swan.maas",
    "min_hwe_kernel": "",
    "network_test_status": -1,
    "iscsiblockdevice_set": [],
    "current_testing_result_id": 9,
    "interface_test_status": -1,
    "status_action": "",
    "pool": {
	"name": "default",
	"description": "Default pool",
	"id": 0,
	"resource_uri": "/MAAS/api/2.0/resourcepool/0/"
    },
    "netboot": true,
    "distro_series": "bionic",
    "current_installation_result_id": 10,
    "memory_test_status_name": "Unknown",
    "cpu_count": 1,
    "hwe_kernel": "ga-18.04",
    "description": "",
    "current_commissioning_result_id": 8,
    "cpu_test_status_name": "Unknown",
    "storage_test_status": 2,
    "hardware_info": {
	"system_vendor": "QEMU",
	"system_product": "Standard PC (i440FX + PIIX, 1996)",
	"system_family": "Unknown",
	"system_version": "pc-i440fx-focal",
	"system_sku": "Unknown",
	"system_serial": "Unknown",
	"cpu_model": "Intel Core Processor (Skylake, IBRS)",
	"mainboard_vendor": "Unknown",
	"mainboard_product": "Unknown",
	"mainboard_serial": "Unknown",
	"mainboard_version": "Unknown",
	"mainboard_firmware_vendor": "SeaBIOS",
	"mainboard_firmware_date": "04/01/2014",
	"mainboard_firmware_version": "1.13.0-1ubuntu1",
	"chassis_vendor": "QEMU",
	"chassis_type": "Other",
	"chassis_serial": "Unknown",
	"chassis_version": "pc-i440fx-focal"
    },
    "bios_boot_method": "pxe",
    "storage": 5368.70912,
    "blockdevice_set": [
	{
	    "id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
	    "size": 5368709120,
	    "block_size": 512,
	    "tags": [
		"ssd"
	    ],
	    "numa_node": 0,
	    "partition_table_type": "GPT",
	    "storage_pool": null,
	    "type": "physical",
	    "filesystem": null,
	    "model": "QEMU HARDDISK",
	    "used_size": 5366611968,
	    "serial": "QM00001",
	    "system_id": "bhxws3",
	    "uuid": null,
	    "available_size": 0,
	    "path": "/dev/disk/by-dname/sda",
	    "id": 3,
	    "name": "sda",
	    "partitions": [
		{
		    "uuid": "8aa1164c-8a91-41d7-92e3-c411634355bb",
		    "size": 5360320512,
		    "bootable": false,
		    "tags": [],
		    "path": "/dev/disk/by-dname/sda-part2",
		    "device_id": 3,
		    "type": "partition",
		    "id": 3,
		    "system_id": "bhxws3",
		    "filesystem": {
			"fstype": "ext4",
			"label": "root",
			"uuid": "68487852-7e38-4605-a84e-d787532fd443",
			"mount_point": "/",
			"mount_options": null
		    },
		    "used_for": "ext4 formatted filesystem mounted at /",
		    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/partition/3"
		}
	    ],
	    "used_for": "GPT partitioned with 1 partition",
	    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
	}
    ],
    "system_id": "bhxws3",
    "boot_disk": {
	"firmware_version": "2.5+",
	"tags": [
	    "ssd"
	],
	"numa_node": 0,
	"partition_table_type": "GPT",
	"size": 5368709120,
	"storage_pool": null,
	"type": "physical",
	"block_size": 512,
	"filesystem": null,
	"model": "QEMU HARDDISK",
	"used_size": 5366611968,
	"serial": "QM00001",
	"system_id": "bhxws3",
	"uuid": null,
	"available_size": 0,
	"path": "/dev/disk/by-dname/sda",
	"id": 3,
	"id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
	"name": "sda",
	"partitions": [
	    {
		"uuid": "8aa1164c-8a91-41d7-92e3-c411634355bb",
		"size": 5360320512,
		"bootable": false,
		"tags": [],
		"path": "/dev/disk/by-dname/sda-part2",
		"device_id": 3,
		"type": "partition",
		"id": 3,
		"system_id": "bhxws3",
		"filesystem": {
		    "fstype": "ext4",
		    "label": "root",
		    "uuid": "68487852-7e38-4605-a84e-d787532fd443",
		    "mount_point": "/",
		    "mount_options": null
		},
		"used_for": "ext4 formatted filesystem mounted at /",
		"resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/partition/3"
	    }
	],
	"used_for": "GPT partitioned with 1 partition",
	"resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
    },
    "default_gateways": {
	"ipv4": {
	    "gateway_ip": null,
	    "link_id": null
	},
	"ipv6": {
	    "gateway_ip": null,
	    "link_id": null
	}
    },
    "raids": [],
    "cache_sets": [],
    "domain": {
	"authoritative": true,
	"ttl": null,
	"is_default": true,
	"id": 0,
	"name": "maas",
	"resource_record_count": 0,
	"resource_uri": "/MAAS/api/2.0/domains/0/"
    },
    "hostname": "ace-swan",
    "virtualblockdevice_set": [],
    "memory": 1024,
    "owner_data": {},
    "zone": {
	"name": "default",
	"description": "",
	"id": 1,
	"resource_uri": "/MAAS/api/2.0/zones/default/"
    },
    "power_state": "off",
    "status": 9,
    "address_ttl": null,
    "other_test_status": -1,
    "volume_groups": [],
    "power_type": "virsh",
    "pod": null,
    "testing_status": 2,
    "physicalblockdevice_set": [
	{
	    "firmware_version": "2.5+",
	    "tags": [
		"ssd"
	    ],
	    "numa_node": 0,
	    "partition_table_type": "GPT",
	    "size": 5368709120,
	    "storage_pool": null,
	    "type": "physical",
	    "block_size": 512,
	    "filesystem": null,
	    "model": "QEMU HARDDISK",
	    "used_size": 5366611968,
	    "serial": "QM00001",
	    "system_id": "bhxws3",
	    "uuid": null,
	    "available_size": 0,
	    "path": "/dev/disk/by-dname/sda",
	    "id": 3,
	    "id_path": "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00001",
	    "name": "sda",
	    "partitions": [
		{
		    "uuid": "8aa1164c-8a91-41d7-92e3-c411634355bb",
		    "size": 5360320512,
		    "bootable": false,
		    "tags": [],
		    "path": "/dev/disk/by-dname/sda-part2",
		    "device_id": 3,
		    "type": "partition",
		    "id": 3,
		    "system_id": "bhxws3",
		    "filesystem": {
			"fstype": "ext4",
			"label": "root",
			"uuid": "68487852-7e38-4605-a84e-d787532fd443",
			"mount_point": "/",
			"mount_options": null
		    },
		    "used_for": "ext4 formatted filesystem mounted at /",
		    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/partition/3"
		}
	    ],
	    "used_for": "GPT partitioned with 1 partition",
	    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/blockdevices/3/"
	}
    ],
    "interface_set": [
	{
	    "mac_address": "52:54:00:15:36:f2",
	    "links": [
		{
		    "id": 15,
		    "mode": "auto",
		    "subnet": {
			"name": "192.168.123.0/24",
			"description": "",
			"vlan": {
			    "vid": 0,
			    "mtu": 1500,
			    "dhcp_on": true,
			    "external_dhcp": null,
			    "relay_vlan": null,
			    "fabric_id": 2,
			    "id": 5003,
			    "fabric": "fabric-2",
			    "secondary_rack": null,
			    "name": "untagged",
			    "space": "undefined",
			    "primary_rack": "8dwnne",
			    "resource_uri": "/MAAS/api/2.0/vlans/5003/"
			},
			"cidr": "192.168.123.0/24",
			"rdns_mode": 2,
			"gateway_ip": null,
			"dns_servers": [],
			"allow_dns": true,
			"allow_proxy": true,
			"active_discovery": false,
			"managed": true,
			"id": 4,
			"space": "undefined",
			"resource_uri": "/MAAS/api/2.0/subnets/4/"
		    }
		}
	    ],
	    "numa_node": 0,
	    "enabled": true,
	    "params": "",
	    "firmware_version": null,
	    "sriov_max_vf": 0,
	    "type": "physical",
	    "children": [],
	    "vendor": "Red Hat, Inc.",
	    "system_id": "bhxws3",
	    "parents": [],
	    "vlan": {
		"vid": 0,
		"mtu": 1500,
		"dhcp_on": true,
		"external_dhcp": null,
		"relay_vlan": null,
		"fabric_id": 2,
		"id": 5003,
		"fabric": "fabric-2",
		"secondary_rack": null,
		"name": "untagged",
		"space": "undefined",
		"primary_rack": "8dwnne",
		"resource_uri": "/MAAS/api/2.0/vlans/5003/"
	    },
	    "link_connected": true,
	    "id": 10,
	    "effective_mtu": 1500,
	    "discovered": [
		{
		    "subnet": {
			"name": "192.168.123.0/24",
			"description": "",
			"vlan": {
			    "vid": 0,
			    "mtu": 1500,
			    "dhcp_on": true,
			    "external_dhcp": null,
			    "relay_vlan": null,
			    "fabric_id": 2,
			    "id": 5003,
			    "fabric": "fabric-2",
			    "secondary_rack": null,
			    "name": "untagged",
			    "space": "undefined",
			    "primary_rack": "8dwnne",
			    "resource_uri": "/MAAS/api/2.0/vlans/5003/"
			},
			"cidr": "192.168.123.0/24",
			"rdns_mode": 2,
			"gateway_ip": null,
			"dns_servers": [],
			"allow_dns": true,
			"allow_proxy": true,
			"active_discovery": false,
			"managed": true,
			"id": 4,
			"space": "undefined",
			"resource_uri": "/MAAS/api/2.0/subnets/4/"
		    },
		    "ip_address": "192.168.123.190"
		}
	    ],
	    "link_speed": 0,
	    "name": "ens3",
	    "product": null,
	    "interface_speed": 0,
	    "tags": [],
	    "resource_uri": "/MAAS/api/2.0/nodes/bhxws3/interfaces/10/"
	}
    ],
    "node_type_name": "Machine",
    "commissioning_status_name": "Passed",
    "network_test_status_name": "Unknown",
    "memory_test_status": -1,
    "swap_size": null,
    "resource_uri": "/MAAS/api/2.0/machines/bhxws3/"
}
```
</details>

Okay then. We've installed and configured MAAS, started DHCP, created a machine, commissioned it, acquired it, and deployed it, with minimal hassle.  There's just one more useful thing to experience before diving into MAAS head-first.

## SSH/SCP to running machines

What if we just set ourselves up to SSH into our MAAS machines?  Making this work will also allow us to `scp` files in -- and I'm sure you can see how we'd provision a machine from there.  We can also do the provisioning with MAAS, but that's a more complex topic for later.

First things first: we need to build the MAAS infrastructure necessary to play with this feature.

### Create a KVM

We start by creating a vm-host.  Let's play dumb and walk our way through this; first, we'll just try creating a vm-host, like this:

```nohighlight
maas admin vm-host create
```

This doesn't give anything like the expected result:

```nohighlight
usage: maas admin vm-host [-h] COMMAND ...

Manage an individual vm-host.

optional arguments:
  -h, --help  show this help message and exit

drill down:
  COMMAND
    refresh   Refresh a pod
    parameters
	      Obtain pod parameters
    compose   Compose a pod machine
    add-tag   Add a tag to a pod
    remove-tag
	      Remove a tag from a pod
    read
    update    Update a specific pod
    delete    Deletes a pod

A vm-host is identified by its id.

argument COMMAND: invalid choice: 'create' (choose from 'refresh', 'parameters', 'compose', 'add-tag', 'remove-tag', 'read', 'update', 'delete')
```

We forgot about the collective pluralism of the MAAS CLI. We need to use `vm-hosts` to create one, because we're adding to the collection, so the correct command should look something like this:

```nohighlight
maas admin vm-hosts create
```

Still not quite what we expected, but we're failing forward fast, which is a great way to learn.  MAAS tells us we need to specify a `type`:

```nohighlight
{"type": ["This field is required."]}
```

We have to specify what kind of `vm-host` we want; in this case, it's going to be an LXD `vm-host`, so we modify our previous command like this:

```nohighlight
maas admin vm-hosts create type=lxd
```

Hmm, still one more thing to enter: the `power_address`:

```nohighlight
{"power_address": ["This field is required."]}
```

We need to update our command to tell MAAS what LXD instance we're going to use.  The `power_address` for an LXD vm-host is of the form `https://<gateway-ip-address>:8443`.  The `8443` is the default port when you ran `lxd init` to get LXD started, after installing it.  In my case, the LXD gateway is `10.38.31.1` at the moment, so my modified command would be:

```nohighlight
maas admin vm-hosts create type=lxd power_address=https://10.38.31.1:8443
```

Within seconds, we get a success message and JSON output.  From now on, I'll leave the JSON output for you to generate and view on your own, unless it bears specifically on the discussion.  In this case, all that we'll need is the last non-bracket line of the JSON return, which is:

```nohighlight
"resource_uri": "/MAAS/api/2.0/pods/7/"
```

Your address will vary, so check carefully.

What we'll need in the next step is the `vm-host ID`, which is the number on the end of the `resource_uri`. In this case that's "7".

### Compose a machine

Having a VM host is great, but we can't demonstrate `ssh/scp` machine actions without a virtual machine running on that host.  Let's create one.  This may get tricky, so let's start by looking at the MAAS CLI help:

```nohighlight
maas admin --help
```

This gives us the following, very long command list:

```nohighlight
usage: maas admin [-h] COMMAND ...

Issue commands to the MAAS region controller at http://192.168.56.91:5240/MAAS/api/2.0/.

optional arguments:
  -h, --help            show this help message and exit

drill down:
  COMMAND
    account             Manage the current logged-in user.
    bcache-cache-set    Manage bcache cache set on a machine.
    bcache-cache-sets   Manage bcache cache sets on a machine.
    bcache              Manage bcache device on a machine.
    bcaches             Manage bcache devices on a machine.
    block-device        Manage a block device on a machine.
    block-devices       Manage block devices on a machine.
    boot-resource       Manage a boot resource.
    boot-resources      Manage the boot resources.
    boot-source         Manage a boot source.
    boot-source-selection
			Manage a boot source selection.
    boot-source-selections
			Manage the collection of boot source selections.
    boot-sources        Manage the collection of boot sources.
    commissioning-script
			Manage a custom commissioning script.
    commissioning-scripts
			Manage custom commissioning scripts.
    dhcpsnippet         Manage an individual DHCP snippet.
    dhcpsnippets        Manage the collection of all DHCP snippets in MAAS.
    dnsresource         Manage dnsresource.
    dnsresource-record  Manage dnsresourcerecord.
    dnsresource-records
			Manage DNS resource records (e.g. CNAME, MX, NS, SRV,
			TXT)
    dnsresources        Manage dnsresources.
    device              Manage an individual device.
    devices             Manage the collection of all the devices in the MAAS.
    discoveries         Query observed discoveries.
    discovery           Read or delete an observed discovery.
    domain              Manage domain.
    domains             Manage domains.
    events              Retrieve filtered node events.
    fabric              Manage fabric.
    fabrics             Manage fabrics.
    fan-network         Manage Fan Network.
    fan-networks        Manage Fan Networks.
    file                Manage a FileStorage object.
    files               Manage the collection of all the files in this MAAS.
    ipaddresses         Manage IP addresses allocated by MAAS.
    iprange             Manage IP range.
    ipranges            Manage IP ranges.
    interface           Manage a node's or device's interface.
    interfaces          Manage interfaces on a node.
    license-key         Manage a license key.
    license-keys        Manage the license keys.
    maas                Manage the MAAS server.
    machine             Manage an individual machine.
    machines            Manage the collection of all the machines in the MAAS.
    network             Manage a network.
    networks            Manage the networks.
    node                Manage an individual Node.
    node-results        Read the collection of commissioning script results.
    node-script         Manage or view a custom script.
    node-script-result  Manage node script results.
    node-script-results
			Manage node script results.
    node-scripts        Manage custom scripts.
    nodes               Manage the collection of all the nodes in the MAAS.
    notification        Manage an individual notification.
    notifications       Manage the collection of all the notifications in
			MAAS.
    package-repositories
			Manage the collection of all Package Repositories in
			MAAS.
    package-repository  Manage an individual package repository.
    partition           Manage partition on a block device.
    partitions          Manage partitions on a block device.
    pod                 Manage an individual pod.
    pods                Manage the collection of all the pod in the MAAS.
    rack-controller     Manage an individual rack controller.
    rack-controllers    Manage the collection of all rack controllers in MAAS.
    raid                Manage a specific RAID (Redundant Array of Independent
			Disks) on a machine.
    raids               Manage all RAIDs (Redundant Array of Independent
			Disks) on a machine.
    region-controller   Manage an individual region controller.
    region-controllers  Manage the collection of all region controllers in
			MAAS.
    resource-pool       Manage a resource pool.
    resource-pools      Manage resource pools.
    sshkey              Manage an SSH key.
    sshkeys             Manage the collection of all the SSH keys in this
			MAAS.
    sslkey              Manage an SSL key.
    sslkeys             Operations on multiple keys.
    space               Manage space.
    spaces              Manage spaces.
    static-route        Manage static route.
    static-routes       Manage static routes.
    subnet              Manage subnet.
    subnets             Manage subnets.
    tag                 Tags are properties that can be associated with a Node
			and serve as criteria for selecting and allocating
			nodes.
    tags                Manage all tags known to MAAS.
    user                Manage a user account.
    users               Manage the user accounts of this MAAS.
    version             Information about this MAAS instance.
    virtual-machine     Manage individual virtual machines.
    virtual-machines    Manage a collection of virtual machines.
    vlan                Manage a VLAN on a fabric.
    vlans               Manage VLANs on a fabric.
    vm-host             Manage an individual vm-host.
    vm-hosts            Manage the collection of all the vm-hosts in the MAAS.
    vmfs-datastore      Manage VMFS datastore on a machine.
    vmfs-datastores     Manage VMFS datastores on a machine.
    volume-group        Manage volume group on a machine.
    volume-groups       Manage volume groups on a machine.
    zone                Manage a physical zone.
    zones               Manage physical zones.

This is a profile.  Any commands you issue on this profile will
operate on the MAAS region server.

The command information you see here comes from the region server's
API; it may differ for different profiles.  If you believe the API may
have changed, use the command's 'refresh' sub-command to fetch the
latest version of this help information from the server.
```

We're looking to compose a machine here, so where would you look instinctively?  Well, the first thought might be `machines`, so we can give that help screen a try:

```nohighlight
maas admin machines --help
```

This produces a few commands:

```nohighlight
sage: maas admin machines [-h] COMMAND ...

Manage the collection of all the machines in the MAAS.

optional arguments:
  -h, --help            show this help message and exit

drill down:
  COMMAND
    is-registered       MAC address registered
    set-zone            Assign nodes to a zone
    power-parameters    Get power parameters
    accept              Accept declared machines
    accept-all          Accept all declared machines
    release             Release machines
    list-allocated      List allocated
    allocate            Allocate a machine
    add-chassis         Add special hardware
    clone               Clone storage and/or interface configurations
    read                List Nodes visible to the user
    create              Create a new machine
    is-action-in-progress
			MAC address of deploying or commissioning node
```

This list is interesting, but there isn't a specific `compose` command here.  We could go down the garden path with `maas admin machines create`, but first, let's see if the vm-host command has anything we're seeking:

```nohighlight
maas admin vm-host --help
```

Bingo. Found the command; do you see it in this list?

```nohighlight
usage: maas admin vm-host [-h] COMMAND ...

Manage an individual vm-host.

optional arguments:
  -h, --help  show this help message and exit

drill down:
  COMMAND
    refresh   Refresh a pod
    parameters
	      Obtain pod parameters
    compose   Compose a pod machine
    add-tag   Add a tag to a pod
    remove-tag
	      Remove a tag from a pod
    read
    update    Update a specific pod
    delete    Deletes a pod

A vm-host is identified by its id.
```

Okay, so `maas admin vm-host compose` is the root command; let's see what it requires:

```nohighlight
maas admin vm-host compose --help
```

This command is robust:

```nohighlight
usage: maas admin vm-host compose [--help] [-d] [-k] id [data [data ...]]

Compose a pod machine


Positional arguments:
	id


This method accepts keyword arguments.  Pass each argument as a
key-value pair with an equals sign between the key and the value:
key1=value1 key2=value key3=value3.  Keyword arguments must come after
any positional arguments.

Compose a new machine from a pod.

:param cores: Optional.  The minimum number of CPU cores.
:type cores: Int

 :param memory: Optional.  The minimum amount of memory,
specified in MiB (e.g. 2 MiB == 2*1024*1024).
:type memory: Int

 :param hugepages_backed: Optional.  Whether to request
hugepages backing for the machine.
:type hugepages_backed: Boolean

 :param pinned_cores: Optional.  List of host CPU cores
to pin the VM to. If this is passed, the "cores" parameter is ignored.
:type pinned_cores: Int

 :param cpu_speed: Optional.  The minimum CPU speed,
specified in MHz.
:type cpu_speed: Int

 :param architecture: Optional.  The architecture of
the new machine (e.g. amd64). This must be an architecture the pod
supports.
:type architecture: String

 :param storage: Optional.  A list of storage
constraint identifiers in the form ``label:size(tag,tag,...),
label:size(tag,tag,...)``. For more information please see the CLI
pod management page of the official MAAS documentation.
:type storage: String

 :param interfaces: Optional.  A
labeled constraint map associating constraint labels with desired
interface properties. MAAS will assign interfaces that match the
given interface properties.

Format: ``label:key=value,key=value,...``

Keys:

- ``id``: Matches an interface with the specific id
- ``fabric``: Matches an interface attached to the specified fabric.
- ``fabric_class``: Matches an interface attached to a fabric
  with the specified class.
- ``ip``: Matches an interface whose VLAN is on the subnet implied by
  the given IP address, and allocates the specified IP address for
  the machine on that interface (if it is available).
- ``mode``: Matches an interface with the specified mode. (Currently,
  the only supported mode is "unconfigured".)
- ``name``: Matches an interface with the specified name.
  (For example, "eth0".)
- ``hostname``: Matches an interface attached to the node with
  the specified hostname.
- ``subnet``: Matches an interface attached to the specified subnet.
- ``space``: Matches an interface attached to the specified space.
- ``subnet_cidr``: Matches an interface attached to the specified
  subnet CIDR. (For example, "192.168.0.0/24".)
- ``type``: Matches an interface of the specified type. (Valid
  types: "physical", "vlan", "bond", "bridge", or "unknown".)
- ``vlan``: Matches an interface on the specified VLAN.
- ``vid``: Matches an interface on a VLAN with the specified VID.
- ``tag``: Matches an interface tagged with the specified tag.
:type interfaces: String

 :param hostname: Optional.  The hostname of the newly
composed machine.
:type hostname: String

 :param domain: Optional.  The ID of the domain in which
to put the newly composed machine.
:type domain: Int

 :param zone: Optional.  The ID of the zone in which to
put the newly composed machine.
:type zone: Int

 :param pool: Optional.  The ID of the pool in which to
put the newly composed machine.
:type pool: Int


Common command-line options:
    --help, -h
	Show this help message and exit.
    -d, --debug
	Display more information about API responses.
    -k, --insecure
	Disable SSL certificate check
```

We could get fancy, but for these purposes, we just need a machine.  The only thing that's absolutely required is the vm-host ID.  Remember that line of JSON from above?  In this example, the ID is "7"; remember to check your own machine for the correct ID.  We'll enter this command:

```nohighlight
maas admin vm-host compose 7
```

We got some feedback with a machine `system_id`:

```nohighlight
Success.
Machine-readable output follows:
{
    "system_id": "xttpfx",
    "resource_uri": "/MAAS/api/2.0/machines/xttpfx/"
}
```

We can use this, along with some jq tricks, to see if this machine is commissioning (as expected):

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID",
"POWER","STATUS","OWNER", "TAGS", "POOL","VLAN","FABRIC",
"SUBNET"] | (., map(length*"-"))),(.[] | [.hostname, .system_id, 
.power_state, .status_name, .owner // "-",.tag_names[0] // "-", 
.pool.name,.boot_interface.vlan.name,.boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t
```

This gives the following output on my machine:

```nohighlight
HOSTNAME    SYSID   POWER  STATUS   OWNER  TAGS     POOL     VLAN      FABRIC    SUBNET
--------    -----   -----  ------   -----  ----     ----     ----      ------    ------
native-cub  xttpfx  on     Testing  admin  virtual  default  untagged  fabric-1  10.38.31.0/24
```

By the time I got this command typed in, commissioning had already nearly finished, and the machine was in the "testing" phase.  If we run this command again now, we should see that it's in the "Ready" state:

```nohighlight
HOSTNAME    SYSID   POWER  STATUS  OWNER  TAGS     POOL     VLAN      FABRIC    SUBNET
--------    -----   -----  ------  -----  ----     ----     ----      ------    ------
native-cub  xttpfx  off    Ready   -      virtual  default  untagged  fabric-1  10.38.31.0/24
```

### Getting the machine to a login state

We can't SSH into it, because it automatically turned off after commissioning, and anyway, we didn't have a chance to ask for SSH keys to be loaded during the commissioning process.  Let's run that commissioning again, with SSH keys enabled, and making sure that it's left on after it's done.  For this operation, we just use the standard `machine` commands, because the `vm-host` is now hosting a MAAS machine:

```nohighlight
maas admin machine commission xttpfx enable_ssh=1
```

This will return a success message (be sure to substitute the "xttpfx" with whatever your composed machine `system_id` turns out to be; remember, your mileage may vary).  After a little while, the machine should return to a "Ready" state again, but this time, with the power left /on/, and with SSH keys passed to the machine, so that we can login to it.

We can check this again, with the above jq command:

```nohighlight
HOSTNAME    SYSID   POWER  STATUS  OWNER  TAGS     POOL     VLAN      FABRIC    SUBNET
--------    -----   -----  ------  -----  ----     ----     ----      ------    ------
native-cub  xttpfx  on     Ready   -      virtual  default  untagged  fabric-1  10.38.31.0/24
```

### Logging into a commissioned machine

So it's "Ready" and it's powered on, that's good.  In order to log in, we'll need to know the machine's IP address.  There are several ways to get this, but by far the easiest (with LXD VMs) is just using the `lxc` command:

```nohighlight
lxc list
```

This will give us the following output:

```nohighlight
+------------+---------+---------------------+-----------------------------------------------+-----------------+-----------+
|    NAME    |  STATE  |        IPV4         |                     IPV6                      |      TYPE       | SNAPSHOTS |
+------------+---------+---------------------+-----------------------------------------------+-----------------+-----------+
| first-one  | RUNNING | 10.38.31.193 (eth0) |                                               | CONTAINER       | 0         |
+------------+---------+---------------------+-----------------------------------------------+-----------------+-----------+
| native-cub | RUNNING | 10.38.31.202 (eth0) | fd42:fd4c:6ab9:19bc:216:3eff:fe9e:bc7b (eth0) | VIRTUAL-MACHINE | 0         |
+------------+---------+---------------------+-----------------------------------------------+-----------------+-----------+
```

This brings up some important nuances about the LXD list.  Note that there are two machines, one of which is a `CONTAINER`, not useful for this tutorial.  The other, "native-cub," is the `VIRTUAL-MACHINE` we just created, and that's the one whose IP address we want for SSH purposes: `10.38.31.202`.

Okay, so now we can try logging in via SSH, using the "ubuntu" user (always):

```nohighlight
ssh ubuntu@10.38.31.202
```

We get the expected first-login response:

```nohighlight
The authenticity of host '10.38.31.202 (10.38.31.202)' can't be established.
ECDSA key fingerprint is SHA256:hkKRDyRDG9JcsSmAQ0ir5jy0UKQ+PrU/FTJr36U3bvw.
Are you sure you want to continue connecting (yes/no/[fingerprint])? 
```

And if we say "yes," we should get this result:

```nohighlight
Warning: Permanently added '10.38.31.202' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-64-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon Feb  1 00:11:52 UTC 2021

  System load:    0.0       Processes:               127
  Usage of /home: unknown   Users logged in:         0
  Memory usage:   10%       IPv4 address for enp5s0: 10.38.31.202
  Swap usage:     0%

14 updates can be installed immediately.
2 of these updates are security updates.
To see these additional updates run: apt list --upgradable

tmpfs-root /media/root-rw tmpfs rw,relatime 0 0
overlayroot / overlay rw,relatime,lowerdir=/media/root-ro,upperdir=/media/root-rw/overlay,workdir=/media/root-rw/overlay-workdir/_ 0 0
/dev/loop0 /media/root-ro squashfs ro,relatime 0 0


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo &lt;command&gt;".
See "man sudo_root" for details.

ubuntu@native-cub:`$ 
```

###  Using SCP

We can jump out of this machine and use its IP address to copy files over to it.  First, let's make sure that there isn't anything in the local directory on the machine:

```nohighlight
ls
```

And we get what we'd expect:

```nohighlight
ubuntu@native-cub:`$ ls
ubuntu@native-cub:`$ 
```

So now, let's exit the machine with `exit`, and just `touch` a file called "zork" (a very uncommon filename) in the CWD on the local machine:

```nohighlight
ubuntu@native-cub:`$ exit
logout
Connection to 10.38.31.202 closed.
stormrider@wintermute:`$ touch zork
stormrider@wintermute:`$ ls
 api-key-file   Credentials   Dropbox   Pictures      snap            Templates
 Backups        Desktop       git       Public        stormrider.io   Videos
 BRF            Documents     mnt      '#scratch#'    temp            Websites
 Code           Downloads     Music     Show-n-Tell   temp`           zork
stormrider@wintermute:`$ 
```

Now, let's try to `scp` (secure copy) the file over to the machine, login, and see if the file made it:

```nohighlight
stormrider@wintermute:`$ scp ./zork ubuntu@10.38.31.202:
zork                                          100%    0     0.0KB/s   00:00    
stormrider@wintermute:`$ ssh ubuntu@10.38.31.202
Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-64-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon Feb  1 00:20:42 UTC 2021

  System load:    0.0       Processes:               123
  Usage of /home: unknown   Users logged in:         0
  Memory usage:   10%       IPv4 address for enp5s0: 10.38.31.202
  Swap usage:     0%


14 updates can be installed immediately.
2 of these updates are security updates.
To see these additional updates run: apt list --upgradable

tmpfs-root /media/root-rw tmpfs rw,relatime 0 0
overlayroot / overlay rw,relatime,lowerdir=/media/root-ro,upperdir=/media/root-rw/overlay,workdir=/media/root-rw/overlay-workdir/_ 0 0
/dev/loop0 /media/root-ro squashfs ro,relatime 0 0

Last login: Mon Feb  1 00:19:34 2021 from 10.38.31.1
To run a command as administrator (user "root"), use "sudo &lt;command&gt;".
See "man sudo_root" for details.

ubuntu@native-cub:`$ ls
zork
ubuntu@native-cub:`$ 
```

Good, we can copy files to a MAAS-managed machine.

### Copying files to a deployed machine

Copying files to a commissioned machine doesn't do us much good, of course, since the machine gets wiped out and reloaded on deployment.  Let's acquire and deploy that same machine, and then try logging in and copying files again.

First, we have to acquire and deploy the machine:

```nohighlight
maas admin machines allocate system_id=xttpfx
(Success message and JSON data stream)

maas admin machine deploy xttpfx
(Success message and JSON data stream)

maas admin machines read | jq -r '(["HOSTNAME","SYSID", 
"POWER","STATUS","OWNER", "TAGS", "POOL","VLAN","FABRIC",
"SUBNET"] | (., map(length*"-"))),(.[] | [.hostname, .system_id, 
.power_state, .status_name, .owner // "-",.tag_names[0] // "-", 
.pool.name,.boot_interface.vlan.name,.boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t

HOSTNAME    SYSID   POWER  STATUS     OWNER  TAGS     POOL     VLAN      FABRIC    SUBNET
--------    -----   -----  ------     -----  ----     ----     ----      ------    ------
native-cub  xttpfx  on     Deploying  admin  virtual  default  untagged  fabric-1  10.38.31.0/24
```

When it finally reaches the "Deployed" state, we can try and log into it:

```nohighlight
stormrider@wintermute:`$ ssh ubuntu@10.38.31.2
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:AsOdI357mZdmymQG/bmZzbtrDwZPKNYwdUDgCecHHhI.
Please contact your system administrator.
Add correct host key in /home/stormrider/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/stormrider/.ssh/known_hosts:20
  remove with:
  ssh-keygen -f "/home/stormrider/.ssh/known_hosts" -R "10.38.31.2"
ECDSA host key for 10.38.31.2 has changed and you have requested strict checking.
Host key verification failed.
```

No surprise.  On deployment, the SSH key just got updated, so just do what the message suggests, and you can SSH in normally:

```nohighlight
stormrider@wintermute:`$ ssh-keygen -f "/home/stormrider/.ssh/known_hosts" -R "10.38.31.2"
# Host 10.38.31.2 found: line 20
/home/stormrider/.ssh/known_hosts updated.
Original contents retained as /home/stormrider/.ssh/known_hosts.old
stormrider@wintermute:`$ ssh ubuntu@10.38.31.2
The authenticity of host '10.38.31.2 (10.38.31.2)' can't be established.
ECDSA key fingerprint is SHA256:AsOdI357mZdmymQG/bmZzbtrDwZPKNYwdUDgCecHHhI.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.38.31.2' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-65-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon Feb  1 00:34:27 UTC 2021

  System load:  0.08              Processes:               133
  Usage of /:   48.2% of 6.78GB   Users logged in:         0
  Memory usage: 10%               IPv4 address for enp5s0: 10.38.31.2
  Swap usage:   0%

14 updates can be installed immediately.
2 of these updates are security updates.
To see these additional updates run: apt list --upgradable



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo &lt;command&gt;".
See "man sudo_root" for details.

ubuntu@native-cub:`$ 
```

### Copying a script over there and running it

So first, let's verify that the script we want to copy over there isn't /already/ there.  In fact, to keep it simple, let's just create a simple and fun script to see what `scp` can get us.  First, we'll need to install a couple of software packages on the deployed machine:

```nohighlight
ubuntu@native-cub:`$ fortune

Command 'fortune' not found, but can be installed with:

sudo apt install fortune-mod

ubuntu@native-cub:`$ sudo apt install fortune-mod
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  fortunes-min librecode0
Suggested packages:
  fortunes x11-utils
The following NEW packages will be installed:
  fortune-mod fortunes-min librecode0
0 upgraded, 3 newly installed, 0 to remove and 17 not upgraded.
Need to get 615 kB of archives.
After this operation, 2135 kB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 librecode0 amd64 3.6-24 [523 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal/universe amd64 fortune-mod amd64 1:1.99.1-7build1 [37.3 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/universe amd64 fortunes-min all 1:1.99.1-7build1 [55.1 kB]
Fetched 615 kB in 3s (203 kB/s)    
Selecting previously unselected package librecode0:amd64.
(Reading database ... 71387 files and directories currently installed.)
Preparing to unpack .../librecode0_3.6-24_amd64.deb ...
Unpacking librecode0:amd64 (3.6-24) ...
Selecting previously unselected package fortune-mod.
Preparing to unpack .../fortune-mod_1%3a1.99.1-7build1_amd64.deb ...
Unpacking fortune-mod (1:1.99.1-7build1) ...
Selecting previously unselected package fortunes-min.
Preparing to unpack .../fortunes-min_1%3a1.99.1-7build1_all.deb ...
Unpacking fortunes-min (1:1.99.1-7build1) ...
Setting up librecode0:amd64 (3.6-24) ...
Setting up fortunes-min (1:1.99.1-7build1) ...
Setting up fortune-mod (1:1.99.1-7build1) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.1) ...
ubuntu@native-cub:`$ ddate

Command 'ddate' not found, but can be installed with:

sudo apt install ddate

ubuntu@native-cub:`$ sudo apt install ddate
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  ddate
0 upgraded, 1 newly installed, 0 to remove and 17 not upgraded.
Need to get 10.8 kB of archives.
After this operation, 34.8 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 ddate amd64 0.2.2-1build1 [10.8 kB]
Fetched 10.8 kB in 1s (20.0 kB/s)
Selecting previously unselected package ddate.
(Reading database ... 71424 files and directories currently installed.)
Preparing to unpack .../ddate_0.2.2-1build1_amd64.deb ...
Unpacking ddate (0.2.2-1build1) ...
Setting up ddate (0.2.2-1build1) ...
Processing triggers for man-db (2.9.1-1) ...
ubuntu@native-cub:`$ cowsay

Command 'cowsay' not found, but can be installed with:

sudo apt install cowsay

ubuntu@native-cub:`$ sudo apt install cowsay
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Suggested packages:
  filters cowsay-off
The following NEW packages will be installed:
  cowsay
0 upgraded, 1 newly installed, 0 to remove and 17 not upgraded.
Need to get 18.5 kB of archives.
After this operation, 93.2 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 cowsay all 3.03+dfsg2-7 [18.5 kB]
Fetched 18.5 kB in 2s (7603 B/s) 
Selecting previously unselected package cowsay.
(Reading database ... 71431 files and directories currently installed.)
Preparing to unpack .../cowsay_3.03+dfsg2-7_all.deb ...
Unpacking cowsay (3.03+dfsg2-7) ...
Setting up cowsay (3.03+dfsg2-7) ...
Processing triggers for man-db (2.9.1-1) ...
ubuntu@native-cub:`$ 
```

Now we can drop back and write a script that uses these three packages to produce an interesting result.  Here's what should be in the script:

```nohighlight
#!/bin/bash
ddate &gt; /tmp/foo
echo '   ' &gt;&gt; /tmp/foo
fortune -s &gt;&gt; /tmp/foo
cat /tmp/foo | cowsay
```

Add the text above to a script called `motd.sh`, and then `chmod 777 motd.sh`.  Then, use the following command to copy the script to the deployed machine:

```nohighlight
scp ./motd.sh ubuntu@10.38.31.2:
```

Then we can log back into the deployed machine and check the permissions on `motd.sh` in the arriving CWD:

```nohighlight
ssh ubuntu@10.38.31.2
...
ls -lsa motd.sh

ubuntu@native-cub:`$ ls -lsa motd.sh
4 -rwxrwxr-x 1 ubuntu ubuntu 97 Feb  1 00:49 motd.sh
ubuntu@native-cub:`$ 
```

On my machine, it didn't copy the permissions precisely, but it is executable by me, so I can run it and get the highly-important output:

```nohighlight
 ________________________________________
/ Today is Boomtime, the 32nd day of     \
| Chaos in the YOLD 3187                 |
|                                        |
| Water, taken in moderation cannot hurt |
| anybody.                               |
|                                        |
\ -- Mark Twain                          /
 ----------------------------------------
	\   ^__^
	 \  (oo)\_______
	    (__)\       )\/\
		||----w |
		||     ||
```

## Summary

As you see, it's not that difficult to install MAAS, deploy a machine, and then load usable software on it. Now you can go through the MAAS documenation to learn more about what you just did.


