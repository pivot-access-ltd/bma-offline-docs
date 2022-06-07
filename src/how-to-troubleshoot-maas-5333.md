<!-- "How to troubleshoot MAAS" -->
This article may help you deal with some common problems.  It is organized by topic:

- [Networking issues](#heading--networking-issues)
- [Machine life-cycle failures](#headiing--machine-life-cycle-failures)
- [Custom image creation problems](#heading--custom-image-creation-problems)

<a href="#heading--networking-issues"><h2 id="heading--networking-issues">Networking issues</h2></a>

The following networking issues may be creating problems for you:

- [Adding overlapping subnets in fabric can break deployments](#heading--overlapping-subnets-can-break-deployments)
- [Need to reconfigure server IP address](#heading--need-to-reconfigure-server-ip-address)
- [Network boot an IBM Power server](#heading--ibm-power-server-pxe-boot)
- [Resolve MAAS/LXD DNS & DHCP conflicts/network issues](#heading--maas-lxd-network-conflicts)

Please feel free to add other issues and solutions, if you have them.

<a href="#heading--overlapping-subnets-can-break-deployments"><h3 id="heading--overlapping-subnets-can-break-deployments">Adding overlapping subnets in fabric can break deployments</h3></a>

**Characteristic failure**: A machine performs PXE boot, then gets trapped in a boot loop, causing deployment to fail.

MAAS does not currently prevent you from creating overlapping subnets, for example:

- subnet 1 = 192.168.48.0/24
- subnet 2 = 192.168.48.0/22

This can break deployments, because the controllers can't reliably determine which subnet should get a packet destined for one of the overlapping addresses. The IP range of one subnet should be unique compared to every other subnet on the same segment.

At least one way to cause this error is to edit a subnet in the `netplan` file.  MAAS will add the updated subnet, but may not drop the existing subnet, causing overlap.  You can fix this by deleting the subnet you do not want from the Web UI.

If you have a machine that PXE boots, but then fails deployment, either in an infinite boot loop or some unspecified failure, check your subnets to be sure you do not have overlap.  If so, delete the outdated subnet.

<a href="#heading--need-to-reconfigure-server-ip-address"><h3 id="heading--need-to-reconfigure-server-ip-address">Need to reconfigure server IP address</h3></a>

If you made a mistake during setup or you just need to reconfigure your MAAS server, you can simply run the setup again:

``` bash
sudo dpkg-reconfigure maas-region-controller
```

<h3 id="heading--ibm-power-server-pxe-boot">Network booting IBM Power servers</h3>

Some IBM Power server servers have OPAL firmware which uses an embedded Linux distribution as the boot environment. All the PXE interactions are handled by **Petitboot**, which runs in the user space of this embedded Linux rather than a PXE ROM on the NIC itself.

When no specific interface is assigned as the network boot device, petitboot has a known issue which is detailed in [LP#1852678](https://bugs.launchpad.net/ubuntu-power-systems/+bug/1852678), specifically comment #24, that can cause issues when deploying systems using MAAS, since in this case all active NICs are used for PXE boot with the same address.

So, when using IBM Power servers with multiple NICs that can network boot, it's strongly recommended to configure just a single <specific> NIC as the network boot device via **Petitboot**.

<h3 id="heading--maas-lxd-network-conflicts">Resolve DNS conflicts between LXD and MAAS</h3>

If you get into a situation where MAAS and LXD are both managing DNS on your MAAS network, there's a simple fix. You can turn off LXD's DNS management with the following command:

````bash
lxc network set $LXD_BRIDGE_NAME dns.mode=none
````

You should also disable DHCP on IPv4 and IPv6 withing LXD:

````bash
lxc network set $LXD_BRIDGE_NAME ipv4.dncp=false
lxc network set $LXD_BRIDGE_NAME ipv6.dhcp=false
````

Once you've done this, you can check your work with the following command:

````bash
lxc network show $LXD_BRIDGE_NAME
````

<a href="#heading--machine-life-cycle-failures"><h2 id="heading--machine-life-cycle-failures">Machine life-cycle failures</h2></a>

When attempting to run a machine through its life-cycle, you may have encountered one of these issues:

- [Nodes hang on "Commissioning"](#heading--nodes-hang-on-commissioning)
- [Node deployment fails](#heading--node-deployment-fails)
- [Nodes fail to PXE boot](#heading--nodes-fail-to-pxe-boot)
- [Can't log in to node](#heading--cant-log-in-to-node)
- [\"File not found\" when creating commissioning or node script with MAAS CLI](#heading--commissioning-script-file-not-found)
- [Can't login to machine after deployment](#heading--machine-login-issues)

Please feel free to add other issues and solutions, if you have them.

<a href="#heading--nodes-hang-on-commissioning"><h3 id="heading--nodes-hang-on-commissioning">Nodes hang on "Commissioning"</h3></a>

<a href="#heading--possible-cause-timing-issues"><h4 id="heading--possible-cause-timing-issues">Possible Cause: Timing issues</h4></a>

Various parts of MAAS rely on OAuth to negotiate a connection to nodes. If the current time reported by the hardware clock on your node differs significantly from that on the MAAS server, the connection will not be made.

**SOLUTION:** Check that the hardware clocks are consistent, and if necessary, adjust them. This can usually be done from within the system BIOS, without needing to install an OS.

<a href="#heading--possible-cause-network-drivers"><h4 id="heading--possible-cause-network-drivers">Possible Cause: Network drivers</h4></a>

Sometimes the hardware can boot from PXE, but fail to load correct drivers when booting the received image. This is sometimes the case when no open source drivers are available for the network hardware.

**SOLUTION:** The best fix for this problem is to install a Linux-friendly network adaptor. It *is* theoretically possible to modify the boot image to include proprietary drivers, but it is not a straightforward task.

<a href="#heading--node-deployment-fails"><h3 id="heading--node-deployment-fails">Node deployment fails</h3></a>

When deployment fails the [Rescue mode](/t/maas-concepts-and-terms-reference/5416#heading--rescue-mode) action can be used to boot ephemerally into the node, followed by an investigation.

As an example, an improperly configured PPA was added to MAAS which caused nodes to fail deployment. After entering Rescue mode and connecting via SSH, the following was discovered in file `/var/log/cloud-init-output.log`:

``` no-highlight
2016-11-28 18:21:48,982 - cc_apt_configure.py[ERROR]: failed to add apt GPG Key
to apt keyring
Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/cloudinit/config/cc_apt_configure.py",
line 540, in add_apt_key_raw
    util.subp(['apt-key', 'add', '-'], data=key.encode(), target=target)
  File "/usr/lib/python3/dist-packages/cloudinit/util.py", line 1836, in subp
    cmd=args)
cloudinit.util.ProcessExecutionError: Unexpected error while running command.
Command: ['apt-key', 'add', '-']
Exit code: 2
Reason: -
Stdout: ''
Stderr: 'gpg: no valid OpenPGP data found.\n'
```

In this instance, the GPG fingerprint was used instead of the GPG key. After rectifying this oversight, nodes were again able to successfully deploy.

<a href="#heading--nodes-fail-to-pxe-boot"><h3 id="heading--nodes-fail-to-pxe-boot">Nodes fail to PXE boot</h3></a>

<a href="#heading--possible-cause-using-an-incorrectly-configured-vm"><h4 id="heading--possible-cause-using-an-incorrectly-configured-vm">Possible Cause: Using an incorrectly</a> configured VM</h4>

Some virtual machine setups include emulation of network hardware that does not support PXE booting, and in most setups, you will need to explicitly set the VM to boot via PXE.

**SOLUTION**: Consult the VM docs for details on PXE booting.

<a href="#heading--possible-cause-dhcp-conflict"><h4 id="heading--possible-cause-dhcp-conflict">Possible Cause: DHCP conflict</h4></a>

If you are using MAAS in a setup with an existing DHCP, *DO NOT SET UP THE MAAS DHCP SERVER* as this will cause no end of confusion to the rest of your network and most likely won't discover any nodes either.

**SOLUTION**: You will need to configure your existing DHCP server to point to the MAAS server.

<a href="#heading--cant-log-in-to-node"><h3 id="heading--cant-log-in-to-node">Can't log in to node</h3></a>

Sometimes you may wish to log in directly to a node on your system. If you have set up Juju and MAAS, the node will automatically have SSH authentication enabled (and public keys installed) allowing you to log in. There is also an option in the MAAS web interface to add new SSH keys to the nodes (via Preferences in the drop down menu which appears when clicking your username in the top-right of the page).

<a href="#heading--commissioning-script-file-not-found"><h3 id="heading--commissioning-script-file-not-found">\"File not found\" when creating commissioning or node script with MAAS CLI</h3></a>

When creating a commissioning script with the MAAS CLI, like this:

```nohighlight
maas $PROFILE commissioning-scripts create name=scriptname content@=/tmp/filename
```

you may receive a "file not found" error:

```nohighlight
[Errno 2] No such file or directory: '/tmp/filename'
```

There are two possible sources of the error:

- You did not actually type the filename correctly, or the file does not exist in `/tmp`.  Check the spelling and make sure the file is actually present in `/tmp` (for example).

- You are using the snap version of MAAS.  When using the MAAS snap, you may not use `/tmp` due to confinement rules.  Move the file to `/opt` or `/home/myhomdir` and try again.

In fact, trying to upload the script from any directory owned by `root` will give a similar error.

Also note that `commissioning-scripts` is deprecated and may be removed at some future time.  Use the form `node-scripts` instead; consult the MAAS CLI built-in help for details.

<a href="#heading--machine-login-issues"><h3 id="heading--machine-login-issues">Can't login to machine after deployment</h3></a>

When everything seems to be right about your machine deployment, but you can't login, there's a chance you might not be using the right username.  You may have added your personal SSH key to MAAS, but your corresponding login doesn't seem to work; that's because the logins for the machines are generally related to the operating system, e.g.:

- For machines deploying Ubuntu, the username is `ubuntu`, and the login would be `ubuntu@$MACHINE_IP`.

- For machines deploying CentOS 7, the username is `centos`, and the login would be `centos@$MACHINE_IP`.

- For machines deploying CentOS 8, the username is `cloud-user`, and the login would be `cloud-user@$MACHINE_IP`.

Note there is a trick for determining the correct machine login, which works on many different versions of Linux.  If you attempt to `ssh root@$MACHINE_IP`, this will fail, but often tells you which user you should be using. 

<a href="#heading--custom-image-creation-problems"><h2 id="heading--custom-image-creation-problems">Custom image creation problems</h2></a>

You may have experienced these errors when trying to create custom images for MAAS:

<a href="#heading--packer-not-found"><h3 id="heading--packer-not-found">Command 'packer' not found</h3></a>
<a href="#heading--no-rule-for-ovmf"><h3 id="heading--no-rule-for-ovmf">No rule to make target ...OVMF_VARS.fd</h3></a>
<a href="#heading--failed-creating-qemu-driver"><h3 id="heading--failed-creating-qemu-driver">Failure to create QEMU driver</h3></a>

Please feel free to add other issues and solutions, if you have them.

<a href="#heading--packer-not-found"><h3 id="heading--packer-not-found">Command 'packer' not found</h3></a>

You might attempt to run `packer` and receive the following error:

```nohighlight
stormrider@neuromancer:~$ packer
Command 'packer' not found, but can be installed with:
sudo snap install packer  # version 1.0.0-2, or
sudo apt  install packer  # version 1.6.6+ds1-4
See 'snap info packer' for additional versions.
```

More likely, you attempt a `make` and receive this error:

```nohighlight
stormrider@neuromancer:~/mnt/Dropbox/src/git/packer-maas/ubuntu$ make
sudo rm -f -rf output-qemu custom-ubuntu*.gz
cp -v /usr/share/OVMF/OVMF_VARS.fd OVMF_VARS.fd
'/usr/share/OVMF/OVMF_VARS.fd' -> 'OVMF_VARS.fd'
sudo PACKER_LOG=1 packer build ubuntu-lvm.json && reset
sudo: packer: command not found
make: *** [Makefile:21: custom-ubuntu-lvm.dd.gz] Error 1
rm OVMF_VARS.fd
```

In both cases, the problem is the same: `packer` has not been installed. You can fix it by [following these instructions](https://maas.io/docs/how-to-create-custom-images#heading--how-to-install-packer).

<a href="#heading--no-rule-for-ovmf"><h3 id="heading--no-rule-for-ovmf">No rule to make target ...OVMF_VARS.fd</h3></a>

If you encounter an error like this:

```nohighlight
stormrider@neuromancer:~/mnt/Dropbox/src/git/packer-maas/ubuntu$ make
sudo rm -f -rf output-qemu custom-ubuntu*.gz
make: *** No rule to make target '/usr/share/OVMF/OVMF_VARS.fd', needed by 'OVMF_VARS.fd'.  Stop.
```

then you have forgotten to [install a needed dependency](https://maas.io/docs/how-to-create-custom-images#heading--how-to-install-packer).

<a href="#heading--failed-creating-qemu-driver"><h3 id="heading--failed-creating-qemu-driver">Failure to create QEMU driver</h3></a>

If you encounter an error such as this one:

```nohighlight
2022/06/04 17:04:47 machine readable: error-count []string{"1"}
==> Some builds didn't complete successfully and had errors:
2022/06/04 17:04:47 machine readable: qemu,error []string{"Failed creating Qemu driver: exec: \"qemu-img\": executable file not found in $PATH"}
==> Builds finished but no artifacts were created.
Build 'qemu' errored after 880 microseconds: Failed creating Qemu driver: exec: "qemu-img": executable file not found in $PATH
```

then you have forgotten to [install a needed dependency](https://maas.io/docs/how-to-create-custom-images#heading--how-to-install-packer).

<a href="#heading--misc-problems"><h2 id="heading--misc-problems">Miscellaneous issues</h2></a>

Finally, you may be facing an issue which doesn't fit into any category, such as one of these:

- [Subarchitecture error thrown by django](#heading--django-subarch-error)
- [Forgot MAAS administrator password](#heading--forgot-maas-administrator-password)
- [Can't find MAAS web UI](#heading--cant-find-maas-web-ui)
- [Backdoor image login](#heading--backdoor-image-login)
- [Migrate an existing snap installation to use a local PostgreSQL server](#heading--migrating-maas)
- [Manually export the MAAS database](#heading--manual-export)
- [Try jq recipes using the CLI](#heading--jq-machine-list)

Please feel free to add other issues and solutions, if you have them.

<a href="#heading--django-subarch-error"><h3 id="heading--django-subarch-error">Subarchitecture error thrown by django</h3></a>

Occassionally, you may encounter an error similar to this one:

```
django.core.exceptions.ValidationError: ['Subarchitecture(<value>) must be generic when setting hwe_kernel.']
```

One potential solution for this problem is to specify a different commissioning kernel, such as upgrading from Xenial to Focal, etc.  

<a href="#heading--forgot-maas-administrator-password"><h3 id="heading--forgot-maas-administrator-password">Forgot MAAS administrator password</h3></a>

As long as you have sudo privileges the `maas` command can be used to change the password for a MAAS administrator on the MAAS region controller:

``` bash
sudo maas changepassword $PROFILE
```

where $PROFILE is the name of the user.


<a href="#heading--cant-find-maas-web-ui"><h3 id="heading--cant-find-maas-web-ui">Can't find MAAS web UI</h3></a>

By default, the web UI is located at `http://<hostname>:5240/MAAS/`. If you can't access it, there are a few things to try:

- Check that the webserver is running - By default the web interface uses Apache, which runs under the service name *apache2*. To check it, on the MAAS server box you can run `sudo /etc/init.d/apache2 status`.
- Check that the hostname is correct - It may seem obvious, but check that the hostname is being resolved properly. Try running a browser (even a text mode one like `elinks`) on the same box as the MAAS server and navigating to the page. If that doesn't work, try `http://127.0.0.1:5240/MAAS/`, which will always point at the local server.
- If you are still getting "404 - Page not found" errors, check that the MAAS web interface has been installed in the right place. There should be a file present called `/usr/share/maas/maas/urls.py`.

<a href="#heading--backdoor-image-login"><h3 id="heading--backdoor-image-login">Backdoor image login</h3></a>

Ephemeral images are used by MAAS to boot nodes during commissioning, as well as during deployment. By design, these images are not built to be edited or tampered with, instead they're used to probe the hardware and launch [cloud-init](https://launchpad.net/cloud-init).

However, if you find yourself with no other way to access a node, especially if a node fails during commissioning, Linux-based ephemeral images can be modified to enable a *backdoor* that adds or resets a user's password. You can then login to check the **cloud-init** logs, for example, and troubleshoot the problem.

As images are constantly updated and refreshed, the backdoor will only ever be temporary, but it should help you login to see what may be going wrong with your node.

<a href="#heading--extract-the-cloud-image"><h4 id="heading--extract-the-cloud-image">Extract the cloud image</h4></a>

First, download the cloud image that corresponds to the architecture of your node. The *Images* page of the web UI lists the images currently being cached by MAAS:

<a href="https://assets.ubuntu.com/v1/130aa580-troulbeshoot-faq__2.3_images.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/130aa580-troulbeshoot-faq__2.3_images.png"></a>

Images can be downloaded from [https://cloud-images.ubuntu.com/](https://cloud-images.ubuntu.com/).

For example:

``` bash
wget https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-root.tar.gz
```

With the image downloaded, extract its contents so that the *shadow* password file can be edited:

``` bash
mkdir xenial
sudo tar -C xenial -xpSf xenial-server-cloudimg-amd64-root.tar.gz --numeric-owner --xattrs "--xattrs-include=*"
```

[note]
`sudo` is required when extracting the image filesystem and when making changes to the files extracted from the image filesystem.
[/note]

<a href="#heading--generate-password-hash"><h4 id="heading--generate-password-hash">Generate password hash</h4></a>

Now generate a hashed password. Use the following Python 3 command, replacing **ubuntu** with the password you wish to use:

``` bash
python3 -c 'import crypt; print(crypt.crypt("ubuntu", crypt.mksalt(crypt.METHOD_SHA512)))'
```

Output from the previous command looks like the following:

``` no-highlight
$6$AaHblHl5KGrWBmPV$20ssynyY0EhcT9AwZgA2sTdYt4Bvd97bX7PjeyqVLKun2Hk3NBa8r7efM2duK7pi2dlnd5tG76I0dTUvjb6hx0
```

Open the `xenial/etc/shadow` file extracted from the image with a text editor and insert the password hash into the *root* user line of `etc/shadow`, between the first and second colons:

``` no-highlight
root:$6$AaHblHl5KGrWBmPV$20ssynyY0EhcT9AwZgA2sTdYt4Bvd97bX7PjeyqVLKun2Hk3NBa8r7efM2duK7pi2dlnd5tG76I0dTUvjb6hx0:17445:0:99999:7:::
```

Save the file and exit the text editor.

<a href="#heading--rebuild-squashfs-image"><h4 id="heading--rebuild-squashfs-image">Rebuild SquashFS image</h4></a>

Recent versions of MAAS use SquashFS to hold the ephemeral image filesystem. The final step is to use the following command to create a SquashFS file called `xenial-customized.squashfs` that contains the modified shadow file:

``` bash
sudo mksquashfs xenial/ xenial-customized.squashfs -xattrs -comp xz
```

The output should look like the following:

``` no-highlight
Parallel mksquashfs: Using 2 processors
Creating 4.0 filesystem on xenial-customized.squashfs, block size 131072.
[=======]  2516/26975   9%
```

You now have an ephemeral image with a working root login that can replace an image locally cached by MAAS.

<a href="#heading--use-the-custom-image"><h4 id="heading--use-the-custom-image">Use the custom image</h4></a>

Images are synchronised by the region controller and stored on the rack controller in `/var/lib/maas/boot-resources/`, with the *current* directory linking to the latest synchronised images.

For example, the latest low-latency Ubuntu 16.04 image can be found in the following directory:

``` bash
cd /var/lib/maas/boot-resources/current/ubuntu/amd64/ga-16.04-lowlatency/xenial/stable
```

To replace the original, substitute the *squashfs* file with the custom image generated earlier, making sure the new owner is *maas*:

``` bash
mv squashfs squashfs_original
cp /home/ubuntu/xenial-customized.squashfs .
chown maas:maas squashfs
```

You can now use this image to commission or deploy a node and access the root account with the backdoor password, such as by deploying the same specific image from the web UI to the node you wish to troubleshoot.

<a href="https://assets.ubuntu.com/v1/f622d104-troulbeshoot-faq__2.3_deploy.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/f622d104-troulbeshoot-faq__2.3_deploy.png"></a>

<h3 id="heading--migrating-maas">Migrating an existing snap installation</h3>

If you're currently running MAAS from a snap in `all` mode, you can easily migrate your database to a local PostgreSQL server with the following command:

    sudo /snap/maas/current/helpers/migrate-vd Snapatabase

This will install PostgreSQL from the archive and migrate the MAAS database to it. 

**Note** that if PostgreSQL is already installed on the machine, the script will move the current datadir out of the way and replace it with the one from the snap, after  confirmation with the user. If you want to keep the current database set and just import the MAAS database, you'll need to perform a manual dump/restore of the MAAS database, explained below.

The migration script will automatically adjust the snap configuration to use the new database.  Note, though, that the target database must be at least the same version level as the one currently used in the snap (PostgreSQL 10).  Consequently, the migration script only supports Ubuntu 18.04 (bionic) or later.

<h3 id="heading--manual-export">Manually exporting the MAAS database</h3>

If you want to export the database from the snap to an already setup PostgreSQL server, possibly on a different machine, you can manually export it from MAAS as follows. With MAAS running (as this ensures access to the database), run:

    export PGPASS=$(sudo awk -F':\\s+' '$1 == "database_pass" {print $2}' \
        /var/snap/maas/current/regiond.conf)
    sudo pg_dump -U maas -h /var/snap/maas/common/postgres/sockets \
        -d maasdb -F t -f maasdb-dump.tar

This will produce a binary dump in `maasdb-dump.tar`.  You can then stop the MAAS snap via

    sudo snap stop maas

Before importing it to the new database server, you need to create a user and database for MAAS:

``` nohighlight
sudo -u postgres \
    psql -c "CREATE USER maas WITH ENCRYPTED PASSWORD '<password>'"
sudo -u postgres createdb maasdb -O maas
```

Also, make sure that remote access is set up for the newly created `maas` user in `/etc/postgresql/10/main/pg_hba.conf`.  The file should contain a line similar to:

    host    maasdb  maas    0/0     md5

Be sure to replace `0/0`, above, with the proper CIDR to restrict access to a specific subnet.  Finally, you can import the database dump with:

    sudo -u postgres pg_restore -d maasdb maasdb-dump.tar

To finish the process, you'll need to update the MAAS snap config to:

- update the database config in `/var/snap/maas/current/regiond.conf` with the proper `database_host` and `database_pass`
- change the content of `/var/snap/maas/common/snap_mode` from `all` to `region+rack`

Using a local PostgreSQL server is a little bit of work, but it provides great benefits in terms of MAAS scalability and performance.


<h3 id="heading--jq-machine-list">jq recipes using the CLI</h3>

Here are some `jq` recipes to get some human-readable output from the MAAS CLI.

<h4 id="heading--jqml-sh">Basic machine list</h4>

This recipe, which we keep in a file called `jqml.sh`, prints a basic machine list

    #!/bin/bash
    maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
    "OWNER", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
    (.[] | [.hostname, .system_id, .power_state, .status_name, .owner, .pool.name,
    .boot_interface.vlan.name, .boot_interface.vlan.fabric,
    .boot_interface.links[0].subnet.name]) | @tsv' | column -t

For this to work, you need to **only** break lines in the jq string ('...') or add backslashes if you break outside that boundary.

<h4 id="heading--jqmltag-sh">Machine list with first tag added</h4>

It's a good idea to keep your most important machine tag first, as it's the first one you'll see.  It makes scanning your list (UI or CLI/jq) much more efficient.  Here's a recipe that adds the first tag to the console-printed machine list.  We keep it in `jqmltag.sh`, but of course, you can call it whatever you want.

     #!/bin/bash
     maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
     "OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
     (.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
     .tag_names[0] // "-", .pool.name,
     .boot_interface.vlan.name, .boot_interface.vlan.fabric,
     .boot_interface.links[0].subnet.name]) | @tsv' | column -t