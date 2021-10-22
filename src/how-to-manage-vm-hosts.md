In order to  deploy a VM host in your MAAS network, you first need to set up a bridge to connect between your VM host and MAAS itself. Once that's done, you can add and manage VM hosts -- and subsequently, create VMs to act as MAAS machines.  This article explains:

rad-begin  /snap/2.9/ui  /deb/2.9/ui  /snap/3.0/ui /deb/3.0/ui /snap/3.1/ui /deb/3.1/ui 

- [How to set up a VM host bridge with the web UI](#heading--maas-bridge-web-ui)
rad-end
rad-begin  /snap/2.9/cli  /deb/2.9/cli  /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli
- [How to set up a VM host bridge with the MAAS CLI/API](#heading--maas-bridge-cli)
rad-end
- [How to set up a VM host bridge with netplan](#heading--maas-bridge-netplan)
- [How to set up a VM host bridge with libvirt](#heading--maas-bridge-libvirt)
- [How to set up SSH for use by libvirt](#heading--set-up-ssh)
- [How to add a VM host](#heading--adding-a-vm-host)
- [How to configure a VM host](#heading--configuration)
rad-begin  /deb/2.9/cli  /snap/2.9/cli /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli
- [How to list VM-hosts](#heading--list-vm-hosts)
- [How to list configurable VM host parameters](#heading--list-config-params)
- [How to change a VM host's name](#heading--change-vm-host-name)
- [How to change a VM host's pool](#heading--change-vm-host-pool)
- [How to list the resources of all VM hosts](#heading--list-resources-of-all-vm-hosts)
- [How to list the resources of a single VM host](#heading--list-resources-of-a-vm-host)
- [How to update a VM host's configuration](#heading--update-vm-host-configuration)
- [How to list a VM host's connection parameters](#heading--list-vm-host-connection-parameters)
rad-end

To enable VM host networking features, MAAS must match the VM host IP address of a potential VM host with a known device (a machine or controller). For example, if a machine not known to MAAS is set up as a VM host, enhanced interface selection features will not be available.

[note]
It's essential to enforce usage of IP addresses to avoid domain name conflicts, should different controllers resolve the same domain name with different IP addresses. You should also avoid using 127.0.0.1 when running multiple controllers, as it would confuse MAAS.
[/note]

rad-begin   /snap/2.9/ui   /deb/2.9/ui  /snap/3.0/ui /deb/3.0/ui /snap/3.1/ui /deb/3.1/ui
<a href="#heading--maas-bridge-web-ui"><h2 id="heading--maas-bridge-web-ui">How to set up a VM host bridge with the web UI</h2></a>

You can use the MAAS UI to configure a bridge to connect a VM host to MAAS:

Select the machine you want to use as a VM host, switch to the "Network" tab. Select the network where you want to create the bridge and click "Create bridge:"

<a href="https://discourse.maas.io/uploads/default/original/1X/29624d737106c5bad777aee9d2c8cad9c3de7151.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/29624d737106c5bad777aee9d2c8cad9c3de7151.jpeg"></a> 

Configure the bridge on a subnet MAAS controls.  You may use any IP mode for the bridge:

<a href="https://discourse.maas.io/uploads/default/original/1X/dd8567ff1cd76606c5ce1751e606fcfab2bc7ce2.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/dd8567ff1cd76606c5ce1751e606fcfab2bc7ce2.jpeg"></a> 

When you're done, it should look something like this:

<a href="https://discourse.maas.io/uploads/default/original/1X/e392d638f0acecb9d54c81bbca4ee17cbcd05445.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e392d638f0acecb9d54c81bbca4ee17cbcd05445.jpeg"></a> 

Then you can deploy Ubuntu.

rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli  /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli
<a href="#heading--maas-bridge-cli"><h2 id="heading--maas-bridge-cli">How to use the MAAS API to configure a bridge</h2></a>

You can also use the MAAS CLI/API to configure a VM host bridge, with the following procedure:

1. Select the interface you wish to configure the bridge on. This example uses the boot interface, since the boot interface must be connected to a MAAS controlled network -- but any interface is allowed:

        INTERFACE_ID=$(maas $PROFILE machine read $SYSTEM_ID | jq .boot_interface.id)

2. Create the bridge:

         BRIDGE_ID=$(maas $PROFILE interfaces create-bridge $SYSTEM_ID name=br0 parent=$INTERFACE_ID | jq .id)

3. Select the subnet where you want the bridge (this should be a MAAS controlled subnet):

        SUBNET_ID=$(maas $PROFILE subnets read | jq -r '.[] | select(.cidr == "10.0.0.0/24" and .managed == true).id')

4. Connect the bridge to the subnet:

          maas $PROFILE interface link-subnet $SYSTEM_ID $BRIDGE_ID subnet=$SUBNET_ID mode="STATIC" ip_address="10.0.0.101"

rad-end

<a href="#heading--maas-bridge-netplan"><h2 id="heading--maas-bridge-netplan">How to set up a VM host bridge with netplan</h2></a>

You can also use netplan to configure a VM host bridge:

Open your netplan configuration file.  This should be in `/etc/netplan`.  It could be called `50-cloud-init.yaml`, `netplan.yaml`, or something else.  Modify the file to add a bridge, using the example below to guide you:

```nohighlight
network:
    bridges:
        br0:
            addresses:
            - 10.0.0.101/24
            gateway4: 10.0.0.1
            interfaces:
            - enp1s0
            macaddress: 52:54:00:39:9d:f9
            mtu: 1500
            nameservers:
                addresses:
                - 10.0.0.2
                search:
                - maas
            parameters:
                forward-delay: 15
                stp: false
    ethernets:
        enp1s0:
            match:
                macaddress: 52:54:00:39:9d:f9
            mtu: 1500
            set-name: enp1s0
        enp2s0:
            match:
                macaddress: 52:54:00:df:87:ac
            mtu: 1500
            set-name: enp2s0
        enp3s0:
            match:
                macaddress: 52:54:00:a7:ac:46
            mtu: 1500
            set-name: enp3s0
    version: 2
```

Apply the new configuration with `netplan apply`.

<a href="#heading--maas-bridge-libvirt"><h2 id="heading--maas-bridge-libvirt">How to set up a VM host bridge with libvirt</h2></a>

It is also possible to use [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt) ![external-link-icon|15x15](upload://AsoQHBzEFT6NuSK3ZYyhp7S6BMi.png) to configure a virtual bridge.  This method will also work for LXD VM hosts running on Ubuntu.  Be aware that other methods may be required if you are configuring LXD on an OS other than Ubuntu.

By default, libvirt creates a virtual bridge, `virbr0`, through which VMs communicate with each other and the Internet. DHCP, supplied by libvirt, automatically assigns an IP address to each VM.  However, to enable network booting in MAAS, you’ll need to provide DHCP in MAAS and either:

1.  Disable DHCP on libvirt’s `default` network, or
2.  Create a new libvirt network `maas` with DHCP disabled.

You can set up such a `maas` network like this:

```nohighlight
cat << EOF > maas.xml
<network>
 <name>maas</name>
 <forward mode='nat'>
   <nat>
     <port start='1024' end='65535'/>
   </nat>
 </forward>
 <dns enable="no" />
 <bridge name='virbr1' stp='off' delay='0'/>
 <domain name='testnet'/>
 <ip address='172.16.99.1' netmask='255.255.255.0'>
 </ip>
</network>
EOF
virsh net-define maas.xml
```

Note that this network also has NAT port forwarding enabled to allow VMs to communicate with the Internet at large. Port forwarding is very useful in test environments.

<a href="#heading--set-up-ssh"><h2 id="heading--set-up-ssh">How to set up SSH for use by libvirt</h2></a>

For MAAS to successfully communicate with libvirt on your VM host machine -- whether you're running from snap or package, or running rack controllers in LXD containers or on localhost -- this example command must succeed from every rack controller:

```nohighlight
virsh -c qemu+ssh://$USER@$VM_HOST_IP/system list --all
```

Here, `$USER` is a user on your VM host who is a member of the `libvirtd` Unix group on the VM host, and `$VM_HOST_IP` is the IP of your VM host.  **Note** that insufficient permissions for `$USER` may cause the `virsh` command to fail with an error such as `failed to connect to the hypervisor`. Check the `$USER` group membership to make sure `$USER` is a member of the `libvirtd` group.

rad-begin     /deb/2.9/ui /deb/2.9/cli /deb/3.0/cli /deb/3.0/ui /deb/3.1/ui /deb/3.1/cli
<a href="#heading--libvirt-ssh"><h3 id="heading--libvirt-ssh">How to set up SSH (libvirt only)</h3></a>

The `maas` user on your rack controllers will issue all libvirt commands. Therefore, you'll need to set up SSH public keys on every rack controller for user `maas`.  First create SSH keys on all rack controllers:

```nohighlight
$ sudo -i
root@maas:~$ mkdir -p /var/snap/maas/current/root/.ssh
root@maas:~$ cd /var/snap/maas/current/root/.ssh
root@maas:~$ ssh-keygen -f id_rsa
```

Next, add the contents of `~maas/.ssh/id_rsa.pub` to the VM host user's `~$USER/.ssh/authorized_keys`. To accomplish this, log into your VM host node, via SSH, from a host for which MAAS has a matching public SSH key.
rad-end

rad-begin     /snap/2.9/ui /snap/2.9/cli /snap/3.0/ui /snap/3.0/cli /snap/3.1/ui /snap/3.1/cli 
<a href="#heading--set-up-ssah-lv"><h3 id="heading--set-up-ssah-lv">How to set up SSH (libvirt only)</h3></a>

If you installed MAAS via snap, then create the needed SSH keys this way:

```nohighlight
sudo mkdir -p /var/snap/maas/current/root/.ssh
cd /var/snap/maas/current/root/.ssh
sudo ssh-keygen -f id_rsa
```

Finally, on the VM host, you'll need to add `id_rsa.pub` to the `authorized_keys` file in `/home/<vm-host-user-homedir-name>/.ssh/`,  where `<vm-host-user-homedir-name>` is the name of your VM host user.
rad-end

<a href="#heading--adding-a-vm-host"><h2 id="heading--adding-a-vm-host">How to add a VM host</h2></a>

rad-begin  /deb/2.9/ui /snap/2.9/ui /snap/3.0/ui /deb/3.0/ui /snap/3.1/ui /deb/3.1/ui
After installing MAAS, the 'KVM' page is typically empty:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/883a61d38dea2c04010bf9286f0c68700b14975c.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/883a61d38dea2c04010bf9286f0c68700b14975c.png"></a>

rad-end
 
rad-begin /snap/3.0/ui /deb/3.0/ui /snap/3.1/ui /deb/3.1/ui
If you want to add a LXD (or [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt)) ![external-link-icon|15x15](upload://AsoQHBzEFT6NuSK3ZYyhp7S6BMi.png) KVM host to a machine which is already installed, you can do so with the 'Add KVM' button:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/93fcb7aecee3eeea31f3939a884c12fe89f790ba.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/93fcb7aecee3eeea31f3939a884c12fe89f790ba.jpeg"></a>

Upon selecting "Authenticate" (assuming successful authentication), you will receive a project selection screen similar to this:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/346c8e29fc8d4b74507843a956865ebd254aad57.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/346c8e29fc8d4b74507843a956865ebd254aad57.jpeg"></a>

You must either enter a new project name (which cannot contain spaces or special characters), or you must select an existing project.  If you're not really planning on using projects, selecting the "default" project will allow you to continue working as you have in the past.
rad-end
 
rad-begin  /deb/2.9/ui  /snap/2.9/ui 
If you want to add a [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt) ![external-link-icon|15x15](upload://AsoQHBzEFT6NuSK3ZYyhp7S6BMi.png) or LXD VM host to a machine which is already installed, you can do so with the 'Add KVM' button:

<a href="https://discourse.maas.io/uploads/default/original/1X/197ae57b89b32546cf054fff49452f9025354af8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/197ae57b89b32546cf054fff49452f9025354af8.jpeg"></a> 

Here, 'Virsh address' typically looks like the following for libvirt:

    qemu+ssh://<vm host IP>/system

of like this for LXD (Beta):

    https://10.0.0.100:8443
rad-end
    
rad-begin /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli
To add a VM host:

```nohighlight
maas $PROFILE vm-host create type=$VM_HOST_TYPE power_address=$POWER_ADDRESS \
    [power_user=$USERNAME] power_pass=$PASSWORD {project=$PROJECT} \
    [zone=$ZONE] [tags=$TAG1,$TAG2,...]
```

$VM_HOST_TYPE can currently take two values: `virsh` and `lxd`.

$POWER_ADDRESS typically looks like the following for libvirt:

    qemu+ssh://<vm host IP>/system

of like this for LXD (Beta):

    https://10.0.0.100:8443

Both $USERNAME and $PASSWORD are optional for the virsh power type. $ZONE and $TAGS are optional for all VM hosts.

The `power_...` parameters will vary with power type.  See the [API reference](/docs/api#power-types) for a listing of available power types.

For example, to create a LXD VM host, enter the following:

```nohighlight
maas $PROFILE vm-hosts create type=lxd power_address=$LXD_BRIDGE_ADDRESS \
   power_pass=$LXD_TRUST_PASSWORD project=$PROJECT_NAME
```

Note that for LXD VM hosts, a project name is not optional.  Project names cannot contain spaces or special characters. If you enter a project name which doesn't exist, MAAS will create the LXD project for you.
rad-end
 
rad-begin  /deb/2.9/cli  /snap/2.9/cli 
To add a VM host:

```nohighlight
maas $PROFILE vm-host create type=$VM_HOST_TYPE power_address=$POWER_ADDRESS \
    [power_user=$USERNAME] [power_pass=$PASSWORD] [zone=$ZONE] \
    [tags=$TAG1,$TAG2,...]
```

$VM_HOST_TYPE can currently take three values: `rsd`, `virsh`, and `lxd`.

$POWER_ADDRESS typically looks like the following for libvirt:

    qemu+ssh://<vm host IP>/system

of like this for LXD (Beta):

    https://10.0.0.100:8443

Both $USERNAME and $PASSWORD are optional for the virsh power type. $ZONE and $TAGS are optional for all VM hosts.

The `power_...` parameters will vary with power type.  See the [API reference](/docs/api#power-types) for a listing of available power types.

<h3>Some examples</h3>

For example, to create an RSD VM host, enter:

```nohighlight
maas $PROFILE vm-hosts create type=rsd power_address=10.3.0.1:8443 \
    power_user=admin power_pass=admin
```

To create a KVM host, enter the following:

```nohighlight
maas $PROFILE vm-hosts create type=virsh power_address=qemu+ssh://ubuntu@192.168.1.2/system
```
rad-end

[note]
MAAS will automatically discover and store the resources your VM host contains. Any existing machines will also appear on the 'Machines' page, and MAAS will automatically attempt to commission them.
[/note]


<a href="#heading--configuration"><h2 id="heading--configuration">How to configure a VM host</h2></a>

rad-begin  /deb/2.9/ui  /snap/2.9/ui /snap/3.0/ui /deb/3.0/ui /snap/3.1/ui /deb/3.1/ui

VM hosts have several configuration options. Modify these by selecting the 'Configuration' tab and editing options directly.  These options include a VM host's location, password, network zone, resource pool, and memory and CPU overcommit sliders.

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8b3fc96a8f1a1e4b25413a9f60388dc04dd886c9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8b3fc96a8f1a1e4b25413a9f60388dc04dd886c9.png"></a>
rad-end

rad-begin  /deb/2.9/cli  /snap/2.9/cli /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli
Using the CLI, it's possible to update the configuration of a VM host.  You can change these configurable parameters with an `update` command -- but first, you'll want to know how to check the values of configurable parameters, both before and after the change.

<a href="#heading--list-vm-hosts"><h3 id="heading--list-vm-hosts">How to list VM-hosts</h3></a>

To begin, you can list your available KVM-hosts with the following command:

```nohighlight
maas admin vm-hosts read | jq -r '(["ID, "VM-HOST","SYSID","CORES",
"USED","RAM", "USED","STORAGE", "USED"] | (., map(length*"-"))),
(.[]| [.id,.name,.host.system_id,.total.cores, .used.cores, .total.memory, .used.memory,.total.local_storage, .used.local_storage])
| @tsv' | column -t
```

<a href="#heading--list-config-params"><h3 id="heading--list-config-params">How to list configurable VM host parameters</h3></a>

There are just a few parameters that you can change for a VM host.  You can list these, on a per-host basis, using the following two-step procedure:

1. Run the command above to get the VM host ID (different from the System ID, see the first column in the listing).

2. Enter the following command to list configurable parameters:

```nohighlight
maas admin vm-host read $ID | jq -r '(["ID","NAME","POOL","ZONE",
"CPU-O/C", "RAM-O/C", "TAGS"] | (., map(length*"-"))), (.| [.id,.name,
.pool.name, .zone.name,.cpu_over_commit_ratio, 
.memory_over_commit_ratio, .tags[]]) | @tsv' | column -t
```

where $ID is the ID (not System ID) of the VM-host.

<a href="#heading--change-vm-host-name"><h3 id="heading--change-vm-host-name">How to change a VM host's name</h3></a>

You can change the VM host's name very simply, with this command:

    maas admin vm-host update $ID name=$NEW_NAME

where $ID is the VM host's ID (not System ID), and $NEW_NAME is the new name you want to assign.  You can check that the change was successful by just printing out the ID and name, like this:

```nohighlight
maas admin vm-host read $ID | jq -r '(["ID","NAME"] 
| (., map(length*"-"))), (.| [.id,.name]) 
| @tsv' | column -t
```

<a href="#heading--change-vm-host-pool"><h3 id="heading--change-vm-host-pool">How to change a VM host's pool</h3></a>

You can also change the VM host's pool with a simple command:

```nohighlight
maas admin vm-host update $ID pool=$VALID_POOL
```

where $ID is the VM host's ID (not System ID), and $VALID_POOL is the name of a pool that already exists.  If you mention a pool you haven't created yet, you'll get an error like this:

```nohighlight
{"pool": ["Select a valid choice. That choice is not one of the available choices."]}
```

```nohighlight
maas admin resource-pools read | jq -r '.[] | (.name)'
```

If you really want to set your VM host to a new one, you just need to create a new one with this command:

```nohighlight
maas admin resource-pools create name=$NEW_POOL_NAME
```

Then double-check it with `catvmpools`, and assign your VM host to it using the earlier command. 
rad-end

rad-begin /snap/2.9/cli /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli /snap/3.1/cli /deb/3.1/cli
<a href="#heading--list-resources-of-all-vm-hosts"><h2 id="heading--list-resources-of-all-vm-hosts">How to list the resources of all VM hosts</h2></a>

```nohighlight
maas $PROFILE vm-hosts read
```

A portion of the sample output:

``` no-highlight
        "id": 93,
        "capabilities": [
            "composable",
            "fixed_local_storage",
            "iscsi_storage"
        ],
        "name": "civil-hermit",
```

<a href="#heading--list-resources-of-a-vm-host"><h2 id="heading--list-resources-of-a-vm-host">How to list the resources of a single VM host</h2></a>

To list an individual VM host's resources:

```nohighlight
maas $PROFILE vm-host read $VM_HOST_ID
```

<a href="#heading--update-vm-host-configuration"><h2 id="heading--update-vm-host-configuration">How to update a VM host's configuration</h2></a>

Update overcommit ratios for a KVM host:

```nohighlight
maas $PROFILE vm-host update $VM_HOST_ID power_address=qemu+ssh://ubuntu@192.168.1.2/system \
        power_pass=example cpu_over_commit_ratio=2.5 memory_over_commit_ratio=10.0
```

Update the default storage pool used by a KVM host:

```nohighlight
maas $PROFILE vm-host update $VM_HOST_ID power_address=qemu+ssh://ubuntu@192.168.1.2/system \
        power_pass=example default_storage_pool=pool2
```

<a href="#heading--list-vm-host-connection-parameters"><h2 id="heading--list-vm-host-connection-parameters">How to list a VM host's connection parameters</h2></a>

To list a VM host's connection parameters:

```nohighlight
maas $PROFILE vm-host parameters $VM_HOST_ID
```

Example output:

```no-highlight
{
    "power_address": "10.3.0.1:8443",
    "power_pass": "admin",
    "power_user": "admin"
}
```

rad-end

