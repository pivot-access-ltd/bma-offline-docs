<!-- "How to manage VM hosts" -->
In order to  deploy a VM host in your MAAS network, you first need to set up a bridge to connect between your VM host and MAAS itself. Once that's done, you can add and manage VM hosts -- and subsequently, create VMs to act as MAAS machines.  This article explains:

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages" view="UI"]
- [How to set up a VM host bridge with the web UI](#heading--maas-bridge-web-ui)
- [How to set up a VM host bridge with netplan](#heading--maas-bridge-netplan)
- [How to set up a VM host bridge with libvirt](#heading--maas-bridge-libvirt)
- [How to set up SSH for use by libvirt](#heading--set-up-ssh)
- [How to add a VM host](#heading--adding-a-vm-host)
- [How to configure a VM host](#heading--configuration)
 - [How to use LXD clusters](#heading--lxd-clusters)
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages" view="CLI"]
- [How to set up a VM host bridge with the MAAS CLI/API](#heading--maas-bridge-cli)
- [How to set up a VM host bridge with netplan](#heading--maas-bridge-netplan)
- [How to set up a VM host bridge with libvirt](#heading--maas-bridge-libvirt)
- [How to set up SSH for use by libvirt](#heading--set-up-ssh)
- [How to add a VM host](#heading--adding-a-vm-host)
- [How to configure a VM host](#heading--configuration)
- [How to list VM-hosts](#heading--list-vm-hosts)
- [How to list configurable VM host parameters](#heading--list-config-params)
- [How to change a VM host's name](#heading--change-vm-host-name)
- [How to change a VM host's pool](#heading--change-vm-host-pool)
- [How to list the resources of all VM hosts](#heading--list-resources-of-all-vm-hosts)
- [How to list the resources of a single VM host](#heading--list-resources-of-a-vm-host)
- [How to update a VM host's configuration](#heading--update-vm-host-configuration)
- [How to list a VM host's connection parameters](#heading--list-vm-host-connection-parameters)
 - [How to use LXD clusters](#heading--lxd-clusters)
[/tab]
[tab version="v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
- [How to set up a VM host bridge with the web UI](#heading--maas-bridge-web-ui)
- [How to set up a VM host bridge with netplan](#heading--maas-bridge-netplan)
- [How to set up a VM host bridge with libvirt](#heading--maas-bridge-libvirt)
- [How to set up SSH for use by libvirt](#heading--set-up-ssh)
- [How to add a VM host](#heading--adding-a-vm-host)
- [How to configure a VM host](#heading--configuration)
[/tab]
[tab version="v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
- [How to set up a VM host bridge with the MAAS CLI/API](#heading--maas-bridge-cli)
- [How to set up a VM host bridge with netplan](#heading--maas-bridge-netplan)
- [How to set up a VM host bridge with libvirt](#heading--maas-bridge-libvirt)
- [How to set up SSH for use by libvirt](#heading--set-up-ssh)
- [How to add a VM host](#heading--adding-a-vm-host)
- [How to configure a VM host](#heading--configuration)
- [How to list VM-hosts](#heading--list-vm-hosts)
- [How to list configurable VM host parameters](#heading--list-config-params)
- [How to change a VM host's name](#heading--change-vm-host-name)
- [How to change a VM host's pool](#heading--change-vm-host-pool)
- [How to list the resources of all VM hosts](#heading--list-resources-of-all-vm-hosts)
- [How to list the resources of a single VM host](#heading--list-resources-of-a-vm-host)
- [How to update a VM host's configuration](#heading--update-vm-host-configuration)
- [How to list a VM host's connection parameters](#heading--list-vm-host-connection-parameters)
[/tab]
[/tabs]

To enable VM host networking features, MAAS must match the VM host IP address of a potential VM host with a known device (a machine or controller). For example, if a machine not known to MAAS is set up as a VM host, enhanced interface selection features will not be available.

[note]
It's essential to enforce usage of IP addresses to avoid domain name conflicts, should different controllers resolve the same domain name with different IP addresses. You should also avoid using 127.0.0.1 when running multiple controllers, as it would confuse MAAS.
[/note]

[tabs]
[tab version="v3.2 Snap,v3.2 Packages.v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--maas-bridge-web-ui"><h2 id="heading--maas-bridge-web-ui">How to set up a VM host bridge with the web UI</h2></a>

You can use the MAAS UI to configure a bridge to connect a VM host to MAAS:

Select the machine you want to use as a VM host, switch to the "Network" tab. Select the network where you want to create the bridge and click "Create bridge:"

<a href="https://discourse.maas.io/uploads/default/original/1X/29624d737106c5bad777aee9d2c8cad9c3de7151.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/29624d737106c5bad777aee9d2c8cad9c3de7151.jpeg"></a> 

Configure the bridge on a subnet MAAS controls.  You may use any IP mode for the bridge:

<a href="https://discourse.maas.io/uploads/default/original/1X/dd8567ff1cd76606c5ce1751e606fcfab2bc7ce2.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/dd8567ff1cd76606c5ce1751e606fcfab2bc7ce2.jpeg"></a> 

When you're done, it should look something like this:

<a href="https://discourse.maas.io/uploads/default/original/1X/e392d638f0acecb9d54c81bbca4ee17cbcd05445.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e392d638f0acecb9d54c81bbca4ee17cbcd05445.jpeg"></a> 

Then you can deploy Ubuntu.

[/tab]
[tab version="v3.2 Snap,v3.2 Packages.v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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

[/tab]
[/tabs]

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

It is also possible to use [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt) to configure a virtual bridge.  This method will also work for LXD VM hosts running on Ubuntu.  Be aware that other methods may be required if you are configuring LXD on an OS other than Ubuntu.

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

[tabs]
[tab version="v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages"]
<a href="#heading--libvirt-ssh"><h3 id="heading--libvirt-ssh">How to set up SSH (libvirt only)</h3></a>

The `maas` user on your rack controllers will issue all libvirt commands. Therefore, you'll need to set up SSH public keys on every rack controller for user `maas`.  First create SSH keys on all rack controllers:

```nohighlight
$ sudo -i
root@maas:~$ mkdir -p /var/snap/maas/current/root/.ssh
root@maas:~$ cd /var/snap/maas/current/root/.ssh
root@maas:~$ ssh-keygen -f id_rsa
```

Next, add the contents of `~maas/.ssh/id_rsa.pub` to the VM host user's `~$USER/.ssh/authorized_keys`. To accomplish this, log into your VM host node, via SSH, from a host for which MAAS has a matching public SSH key.
[/tab]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap"]
<a href="#heading--set-up-ssah-lv"><h3 id="heading--set-up-ssah-lv">How to set up SSH (libvirt only)</h3></a>

If you installed MAAS via snap, then create the needed SSH keys this way:

```nohighlight
sudo mkdir -p /var/snap/maas/current/root/.ssh
cd /var/snap/maas/current/root/.ssh
sudo ssh-keygen -f id_rsa
```

Finally, on the VM host, you'll need to add `id_rsa.pub` to the `authorized_keys` file in `/home/<vm-host-user-homedir-name>/.ssh/`,  where `<vm-host-user-homedir-name>` is the name of your VM host user.
[/tab]
[/tabs]

<a href="#heading--adding-a-vm-host"><h2 id="heading--adding-a-vm-host">How to add a VM host</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages" view="UI"]
After installing MAAS, the 'KVM' page is typically empty:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/883a61d38dea2c04010bf9286f0c68700b14975c.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/883a61d38dea2c04010bf9286f0c68700b14975c.png"></a>

If you want to add a LXD (or [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt)) KVM host to a machine which is already installed, you can do so with the 'Add KVM' button:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/93fcb7aecee3eeea31f3939a884c12fe89f790ba.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/93fcb7aecee3eeea31f3939a884c12fe89f790ba.jpeg"></a>

### How to authenticate LXD VM hosts via certificates

Suppose that you're creating a new LXD KVM, beginning from the top tab in MAAS:

<a href="https://discourse.maas.io/uploads/default/optimized/2X/b/b7048c83a7d6e4dbca69a060a7b4bf8bc07e1953_2_690x165.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/2X/b/b7048c83a7d6e4dbca69a060a7b4bf8bc07e1953_2_690x165.png"></a>

Select "Add KVM", which brings you to the definition screen:

<a href="https://discourse.maas.io/uploads/default/optimized/2X/8/806d3577b11ed415574fd06de5f643f26ffb7928_2_690x257.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/2X/8/806d3577b11ed415574fd06de5f643f26ffb7928_2_690x257.png"></a>

From here, you'll continue by choosing your authentication method.

#### How to let MAAS create a certificate for you

If you choose "Generate new certificate", as shown above, you'll come to a screen like this one:

<a href="https://discourse.maas.io/uploads/default/optimized/2X/0/08a32d9221a73f0d6f84580ab9ebeeaaf84aeb65_2_690x325.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/2X/0/08a32d9221a73f0d6f84580ab9ebeeaaf84aeb65_2_690x325.png"></a>

You can still choose to use the LXD trust password (entered when you ran `lxd init` during LXD installation).  You can also, though, choose to use the certificate MAAS has just generated for you.  To do that, select the entire contents of the text box, copy it, and paste it into a terminal window -- then hit "Enter":

```
$ lxc config trust add - <<EOF
> -----BEGIN CERTIFICATE-----
> MIIErTCCApUCEQCGa86XdjYUGm8h8YOh4HAEMA0GCSqGSIb3DQEBDQUAMAAwHhcN
> MjEwOTI0MjE1NDQ4WhcNMzEwOTIyMjE1NDQ4WjApMScwJQYDVQQDDB5teTBuZXh0
> LTMuMS4wLWJldGExLWt2bUB3YWxkZW4wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
> ggIKAoICAQC1tmJbSYx3Jb5JcuqLvyO6P0RtYWCbjVYOSAIM1PKHZJRvako6QhjR
> 6wWNcVLAjDJIMuEBysrI8mcAv9D/AfT2qLQ/5mg7anbxfrd3YXG2nc70QJazpFaw
> INDc85wrdJD5NEd50iaka+PztIAWzoZWQr/pLb7hUDnArzSHp5J+w0dRCUh54SyW
> Du4mLpDks5UqMeONO1o7lbaQuBdzGtR4btdmvOkJfg/Pu3i/rzFZ1vvn1JhZTX96
> +xH7tJQiqOk0SXG7F2RmbYiYDhAkiysbMoyOHBCf/qFWq4Vtd/VMxOAT1WERrgWn
> 8nL5kRBozV94QocJaOe+GUSWLHsRpsVa8jiAj3LS2CFQfpaEsrzLSlQOeN2rNB9z
> DO9yGXGql4tUpgtyEvxB/zVrIGd04iTC3D4S9b1KyzTbSsyjTc/XJhUStnn49ySW
> Iwv1eHa2jMvIjRVm5sRfpf0EOZW27HLI1AqDOXR0DmlM2mWvndjvfacX+41I8vuG
> +RPq0ZjDhwfRmUaLiebzcExwPmSHAxqiaV+t0n6ivDWTNk6cNc38rZBh3x6I7JMR
> /85Rc1blLSF7QBMA1HxheCUYzBPTKsdE2btygq9vShRXCdSekV0jGoL1g0n6T59r
> +9nHShgc/Bzk42kcddQySlrqWWHrXX6Z2N1R3eYpuvSEaKsnsjqjwwIDAQABMA0G
> CSqGSIb3DQEBDQUAA4ICAQA4d1Xqi941ssyJoiovTzBgMDSp9kqjpB83BRqbF9oZ
> fQGkezn2jF7SnaXbTyR/K+nir5Rms8OZfUxyZJwYh/YCdnIF8hzC32mLJbP6jcJV
> LS0OD+EipwyRLSe9g2it68TtAhhVXKPx3tGQWWiXtJOF631sJRcRUZATc9nco5H2
> 91GKog4LdFeKD3ArOq1GkE9r95WauTV37x0c474XBt2mVcEvFW50oZbIBPaWLt8E
> q8NG0KYkfIHkhXDGqPDkUtdPJlkiGwqXdaqghuG31a4Or9IKcNmDlli47apaWWJW
> /gqZfFALbOrSJHg10PCqNsfoKmQr2YZzPlTjG39RA7sA1XR6y+lQZqwcXnXk2iAE
> n62OkRUrYVXzBo99zk5jQJVEg6zhfPH9zl6Jmn/vBu0p6RqmqNLTTlMOio8VOp9e
> 9Gyb9uRwzwZ9zgydgI4bHMvcIAq+46wTruOfXBNATWLC2YqXbc+9QqemJebcXULW
> Wf7Sc+SHHx2cVb4OUvUD8keZN37No/2vfZ9NI2SJOI4SxlV2yf6ZRyb7MYIwpm1h
> YTzyS+ywUN4C8p1PsU5iT8DGdcg7Kcso4/DDZeZkLKNeCKizkdMreF7qV0qHTW8z
> PyfZHcR/xWMkjxYZoFu4rVyxpsUJYItJNUNk6vZvSnSDfC2e2JJFfMws+fntNy14
> /w==
> -----END CERTIFICATE-----
> EOF
$ 
```

The certificate will be created for you.  When you click the "Check authentication" button, you will be brought to this screen:

<a href="https://discourse.maas.io/uploads/default/optimized/2X/a/ad3f6fd06fdef3ce5be467816b2fc3667550f397_2_690x204.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/2X/a/ad3f6fd06fdef3ce5be467816b2fc3667550f397_2_690x204.png"></a>

from which you can continue with normal LXD KVM setup.

#### How to use your own, existing certificate

Suppose that, after identifying your LXD KVM, you choose "Provide certificate and private key".  When you do so, the screen will extend to allow you to upload these items:

<a href="https://discourse.maas.io/uploads/default/optimized/2X/f/fa0bf04654e495ff1233defba4fc8768c06dd25f_2_690x443.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/2X/f/fa0bf04654e495ff1233defba4fc8768c06dd25f_2_690x443.png"></a>

Paste or upload your certificate and private key, then click "Next" to validate your authentication criteria, before continuing through the normal LXD KVM creation process.  If your certificate and/or key aren't usable for some reason, MAAS will return an error (in this case, the private key was entered as gibberish, to produce an error output):

<a href="https://discourse.maas.io/uploads/default/original/2X/2/286e648de20c9db3bb6c56c5855647c23a5d9e2e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/286e648de20c9db3bb6c56c5855647c23a5d9e2e.png"></a>

Upon selecting "Authenticate" (assuming successful authentication), you will receive a project selection screen similar to this:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/346c8e29fc8d4b74507843a956865ebd254aad57.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/346c8e29fc8d4b74507843a956865ebd254aad57.jpeg"></a>

You must either enter a new project name (which cannot contain spaces or special characters), or you must select an existing project.  If you're not really planning on using projects, selecting the "default" project will allow you to continue working as you have in the past.
[/tab]
[tab version="v3.0 Snap,v3.0 Packages" view="UI"]
After installing MAAS, the 'KVM' page is typically empty:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/883a61d38dea2c04010bf9286f0c68700b14975c.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/883a61d38dea2c04010bf9286f0c68700b14975c.png"></a>

If you want to add a LXD (or [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt)) KVM host to a machine which is already installed, you can do so with the 'Add KVM' button:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/93fcb7aecee3eeea31f3939a884c12fe89f790ba.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/93fcb7aecee3eeea31f3939a884c12fe89f790ba.jpeg"></a>

[/tab]
[tab version="v2.9 Snap,v2.9 Packages" view="UI"]
After installing MAAS, the 'KVM' page is typically empty:

<a href="https://discourse.maas.io/uploads/default/original/2X/8/883a61d38dea2c04010bf9286f0c68700b14975c.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/883a61d38dea2c04010bf9286f0c68700b14975c.png"></a>

If you want to add a [libvirt](https://ubuntu.com/server/docs/virtualization-libvirt) or LXD VM host to a machine which is already installed, you can do so with the 'Add KVM' button:

<a href="https://discourse.maas.io/uploads/default/original/1X/197ae57b89b32546cf054fff49452f9025354af8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/197ae57b89b32546cf054fff49452f9025354af8.jpeg"></a> 

Here, 'Virsh address' typically looks like the following for libvirt:

    qemu+ssh://<vm host IP>/system

of like this for LXD (Beta):

    https://10.0.0.100:8443

[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages" view="CLI"]
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
[/tab]
[tab version="v2.9 Snap,v2.9 Packages" view="CLI"]
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
[/tab]
[/tabs]

[note]
MAAS will automatically discover and store the resources your VM host contains. Any existing machines will also appear on the 'Machines' page, and MAAS will automatically attempt to commission them.
[/note]

<a href="#heading--configuration"><h2 id="heading--configuration">How to configure a VM host</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages.v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
VM hosts have several configuration options. Modify these by selecting the 'Configuration' tab and editing options directly.  These options include a VM host's location, password, network zone, resource pool, and memory and CPU overcommit sliders.

<a href="https://discourse.maas.io/uploads/default/original/2X/8/8b3fc96a8f1a1e4b25413a9f60388dc04dd886c9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/8b3fc96a8f1a1e4b25413a9f60388dc04dd886c9.png"></a>
[/tab]
[tab version="v3.2 Snap,v3.2 Packages.v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
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
[/tab]
[/tabs]

<a href="#heading--lxd-clusters"><h3 id="heading--lxd-clusters">LXD clusters</h3></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages"]
MAAS 3.1 allows MAAS to take advantage of the existing LXD clustering capability.

<a href="#heading--about-lxd-clusters"><h4 id="heading--about-lxd-clusters">About LXD clusters</h4></a>

LXD clusters within the context of MAAS are a way of viewing and managing existing VM host clusters and composing VMs within said cluster.  MAAS will not create a new cluster, but will discover an existing cluster when you provide the info for adding a single clustered host.

<a href="#heading--how-to-add-lxd-clusters"><h4 id="heading--how-to-add-lxd-clusters">How to add LXD clusters</h4></a>

MAAS assumes you have already configured a cluster within the context of LXD. You then need to configure said cluster with a single trust MAAS will use to communicate with said cluster. Adding a LXD cluster is similar to adding a single LXD host, in that you provide authentication the same way for a single host within the cluster, and then select a project. The only difference is the name you provide will be used for the cluster instead of the individual host. MAAS will then connect to the provided host and discover the other hosts within the cluster, and rename the initially defined host with the cluster member name configured in LXD.

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3aba7d6e30eda61623f66cb162ca85814128864a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3aba7d6e30eda61623f66cb162ca85814128864a.png"></a>

First, add an LXD KVM:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c7d35ad0d8e1d9038dd39a8965307a49f57d453a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c7d35ad0d8e1d9038dd39a8965307a49f57d453a.png"></a>

Next, set up credentials and get your MAAS certificate trusted by LXD:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b3ea7559edc066e899e41f41846a268b2459b1a5.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b3ea7559edc066e899e41f41846a268b2459b1a5.png"></a>

Once it is connected, you can select the project in that cluster:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/ba798351c1c2b37d0aa79bca8c44def38d4ab839.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/ba798351c1c2b37d0aa79bca8c44def38d4ab839.png"></a>

If the KVM host address is part of a cluster, it will show as a Cluster on the listing page. 

<a href="https://discourse.maas.io/uploads/default/original/2X/0/069bae193cbb09ead3c811fd1a1d28582b946ff4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/069bae193cbb09ead3c811fd1a1d28582b946ff4.png"></a>

<a href="#heading--how-to-compose-vms-in-lxd-clusters"><h4 id="heading--how-to-compose-vms-in-lxd-clusters">How to compose VMs in LXD clusters</h4></a>

Composing a VM in a LXD cluster via MAAS is similar to composing a VM for a single VM host. MAAS does not provide any sort of scheduling of said VM, and will instead target the host you select for composing the VM.

From the KVM host listing page, click on the `+` icon to add a VM to a specific host:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/219a302c245992a390cd44ada341cfe5a93a7b5a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/219a302c245992a390cd44ada341cfe5a93a7b5a.png"></a>

If you are in a specific KVM host page, you can click `+ add virtual machine`:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/219a302c245992a390cd44ada341cfe5a93a7b5a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/219a302c245992a390cd44ada341cfe5a93a7b5a.png"></a>

<a href="#heading--how-to-delete-lxd-clusters"><h3 id="heading--how-to-delete-lxd-clusters">How to delete LXD clusters</h3></a>

To delete a LXD cluster, delete any one VM host within the cluster, this will delete the cluster and all members within the cluster:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/ea7cd2476ae8cafe6d8e78f2b029d0cd41afa592.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/ea7cd2476ae8cafe6d8e78f2b029d0cd41afa592.png"></a>

[/tab]
[tab version="v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
LXD clusters are available to MAAS starting with MAAS version 3.1.
[/tab]
[/tabs]