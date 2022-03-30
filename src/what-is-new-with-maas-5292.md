[tabs]
[tab version="v3.2 Snap,v3.2 Packages"]
<h2>MAAS 3.2 Beta 1 release notes</h2>
We are happy to announce that MAAS 3.2 Beta 1 is soon to be available.  This release provides new features and critical bug fixes.

<a href="#heading--cumulative-summary"><h3 id="heading--cumulative-summary">Cumulative summary of MAAS 3.2 features and fixes</h3></a>

 - [Support for observability (O11y) in MAAS](/t/how-to-set-up-maas-metrics/5204): MAAS now supports integration with FOSS Observability stacks.

 - [Ability for user to specify IPMI cipher suite](/t/power-management-reference/5246): You can explicitly select which cipher suite to use when interacting with a BMC.

 - Roll-out of our new tabbed Reader Adaptive Documentation (incremental across the release cycle).

[note]
This is a Beta release, so you may encounter bugs and incomplete features.  We strongly recommend that you take the necessary precautions, which include (but are not limited to) the following steps:

 - Install Beta versions on a system specifically designated for testing; Beta is not recommended for production.
 - Take a backup of any unrecoverable data on your test system prior to installing Beta versions.
 - More specifically, if you use a system for testing MAAS releases, back up the MAAS database and any unique configuration files related to your use of MAAS prior to installing Beta versions.

Also, you should make sure that you are using the latest version of PostgreSQL.  [Here's how you can upgrade that](https://discourse.maas.io/t/upgrading-postgresql-to-version-12/5913).

Essentially, expect that the Beta may not function properly under all conditions, possibly overwriting data and configuration information on the test machine.  Beta versions usually behave fairly well, but be warned that across-the-board, error-free performance isn't something we expect from Beta releases.
 
As you encounter failures, please take the time to [file a bug](https://maas.io/docs/report-a-bug) or let us know your thoughts [on the discourse user forum](https://discourse.maas.io/c/users/8).
[/note]

<a href="#heading--how-to-install-maas-3-2"><h2 id="heading--how-to-install-maas-3-2">How to install MAAS 3.2</h2></a>

[tabs]
[tab version="v3.2 Snap"]
MAAS 3.2 can be installed fresh (recommended) with:

```
sudo snap install --channel=3.2/beta maas
```

[/tab]
[tab version="v3.2 Packages"]
MAAS 3.2 can be installed by adding the `TBD` PPA:

```
sudo add-apt-repository ppa:maas/3.2-next
sudo apt update
sudo apt install maas
```

You can then install MAAS 3.2 fresh (recommended) with:

```
sudo apt-get -y install maas
```

Or, if you prefer to upgrade, you can:

```
sudo apt upgrade maas
```

[/tab]
[/tabs]
At this point, proceed with a normal installation.

<a href="#heading--bugs-fixed-in-maas-3-2"><h2 id="heading--bugs-fixed-in-maas-3-2">Bugs fixed in MAAS 3.2</h2></a>

Here is the breakdown of bugs fixed across the MAAS 3.2 release:

 * [MAAS 3.2 Beta 1](https://launchpad.net/maas/3.2/3.2.0-beta1)
 

[/tab]
[tab version="v3.1 Snap,v3.1 Packages"]
<h2>MAAS 3.1 release notes</h2>

We are happy to announce that MAAS 3.1 is now available. This release provides new features and critical bug fixes.

<a href="#heading--cumulative-summary"><h3 id="heading--cumulative-summary">Cumulative summary of MAAS 3.1 features and fixes</h3></a>

 - [Support for LXD clusters](#heading--lxd-clusters): MAAS 3.1 can use LXD clusters with MAAS KVMs.
 
 - [Improved image sync performance](#heading--image-sync-performance): After images are downloaded, rack controllers sync new images more quickly.
 
 - [Ability to enlist deployed machines](#heading--enlist-deployed-machines): Users can enlist deployed machines, a top feature poll request.

 - [Static Ubuntu image upload and reuse](#heading--static-ubuntu-images): Users can upload, deploy and reuse a bootable ubuntu image

 - [Machine configuration cloning UI](#heading--machine-cloning-ui): We have xtended machine cloning to the UI.

 - [LXD authentication UX improvements](#heading--lxd-auth-ux-improvements): LXD certificates are easier to use.

 - [MAAS 3.1 cumulative bug fixes](#heading--maas-3-1-cumulative-bug-fixes)

Critical and high-priority fixes also extend or repair MAAS features:

 - [Expanded proxies](https://bugs.launchpad.net/maas/+bug/1867394): Some proxies require authentication; MAAS now respects peer proxy username and password

 - [Accurate storage pool sizes](https://bugs.launchpad.net/bugs/1949410): The UI now calculates storage pool sizes correctly for CEPH pools; shared pools are no longer stacked

 - [Refresh wipeout bug](https://bugs.launchpad.net/bugs/1949485): MAAS does not destroy existing VMs on a refresh, or when the memory overcommit ratio is changed
 
 - [Cloning issue fixed](https://bugs.launchpad.net/bugs/1948500): UI cloning has been repaired to prevent "unsuccessful cloning" of storage

<a href="#heading--installing-3-1-0"><h3 id="heading--installing-3-1-0">How to install MAAS 3.1</h3></a>

[tabs]
[tab version="v3.1 Snap"]
MAAS 3.0 can be installed fresh (recommended) with:

```
sudo snap install --channel=3.1 maas
```

[/tab]
[tab version="v3.1 Packages"]
MAAS 3.1 can be installed by adding the `3.1` PPA:

```
sudo add-apt-repository ppa:maas/3.1
sudo apt update
sudo apt install maas
```

You can then install MAAS 3.1 fresh (recommended) with:

```
sudo apt-get -y install maas
```

Or, if you prefer to upgrade, you can:

```
sudo apt upgrade maas
```

[/tab]
[/tabs]
At this point, proceed with a normal installation.

<a href="#heading--lxd-clusters"><h3 id="heading--lxd-clusters">LXD clusters</h3></a>

MAAS 3.1 takes advantage of the existing LXD clustering capability.

<a href="#heading--about-lxd-clusters"><h4 id="heading--about-lxd-clusters">About LXD clusters</h4></a>

LXD clusters in MAAS allow you to view and manage existing VM host clusters and compose VMs within clusters.  MAAS will not create a cluster, but it will discover existing clusters.

<a href="#heading--how-to-add-lxd-clusters"><h4 id="heading--how-to-add-lxd-clusters">How to add LXD clusters</h4></a>

MAAS assumes you have already configured an LXD cluster. You then need to configure the cluster with a single trust which MAAS uses to communicate it. Adding a LXD cluster is like adding a single LXD host: you provide authentication in a similar way, and then select a project. MAAS then connects to the provided host to discover other hosts within the cluster, renaming the cluster host with a name you supply.

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3aba7d6e30eda61623f66cb162ca85814128864a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3aba7d6e30eda61623f66cb162ca85814128864a.png"></a>

First, add an LXD KVM:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c7d35ad0d8e1d9038dd39a8965307a49f57d453a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c7d35ad0d8e1d9038dd39a8965307a49f57d453a.png"></a>

Next, set up credentials and let LXD trust your MAAS certificate:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b3ea7559edc066e899e41f41846a268b2459b1a5.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b3ea7559edc066e899e41f41846a268b2459b1a5.png"></a>

Once connected, you can select the project in that cluster:

<a href="https://discourse.maas.io/uploads/default/original/2X/b/ba798351c1c2b37d0aa79bca8c44def38d4ab839.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/ba798351c1c2b37d0aa79bca8c44def38d4ab839.png"></a>

If the KVM host address is part of a cluster, it will show as a cluster on the listing page. 

<a href="https://discourse.maas.io/uploads/default/original/2X/0/069bae193cbb09ead3c811fd1a1d28582b946ff4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/0/069bae193cbb09ead3c811fd1a1d28582b946ff4.png"></a>

<a href="#heading--how-to-compose-vms-in-lxd-clusters"><h4 id="heading--how-to-compose-vms-in-lxd-clusters">How to compose VMs in LXD clusters</h4></a>

Composing a VM in a LXD cluster via MAAS is similar to composing a VM for a single VM host. MAAS does not provide any sort of scheduling of said VM, and will instead target the host you select for composing the VM.

From the KVM host listing page, click on the `+` icon to add a VM to a specific host:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/219a302c245992a390cd44ada341cfe5a93a7b5a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/219a302c245992a390cd44ada341cfe5a93a7b5a.png"></a>

If you are in a specific KVM host page, you can click `+ add virtual machine`:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/219a302c245992a390cd44ada341cfe5a93a7b5a.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/219a302c245992a390cd44ada341cfe5a93a7b5a.png"></a>

<a href="#heading--how-to-delete-lxd-clusters"><h3 id="heading--how-to-delete-lxd-clusters">How to delete LXD clusters</h3></a>

To delete an LXD cluster, simply delete any VM host within the cluster:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/ea7cd2476ae8cafe6d8e78f2b029d0cd41afa592.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/ea7cd2476ae8cafe6d8e78f2b029d0cd41afa592.png"></a>

<a href="#heading--enlist-deployed-machines"><h3 id="heading--enlist-deployed-machines">Ability to enlist deployed machines</h3></a>

#### Ten words or fewer
Users can enlist deployed machines, a top feature poll request.

#### About this feature
When adding machines to MAAS, MAAS (non-destructively) boots them into an ephemeral environment to gather hardware information.  Previously, this didn't work for deployed machines, since you don't want to disrupt deployed workloads or mark deployed machines as ready.

Now you may add deployed machines, without normal commissioning process or relabeling the machine. In order to update the information, a script is provided to run minimal commissioning scripts and update to MAAS.

#### How to enlist a machine that’s already running a workload
In order to enlist a deployed machine, you have two options:

Via the API/CLI, you can create a machine, passing the deployed flag:

```
$ maas $profile machines create deployed=true hostname=mymachine \   
architecture=amd64 mac_addresses=00:16:3e:df:35:bb power_type=manual
```

On the machine itself (the recommended way, if the machine is running Ubuntu), you can download and run a helper script from MAAS:

```
$ wget http://$MAAS_IP:5240/MAAS/maas-run-scripts
$ chmod 755 maas-run-scripts
$ ./maas-run-scripts register-machine --hostname mymachine \
 > http://$MAAS_IP:5240/MAAS $MAAS_API_TOKEN
```

Now you have enlisted a deployed machine, with no hardware information yet.

#### How to update hardware information for a deployed machine

To update hardware information for a deployed machine, we recommend that you download and run the maas-run-scripts script on the machine:

```
$ wget http://$MAAS_IP:5240/MAAS/maas-run-scripts
$ chmod 755 maas-run-scripts
$ ./maas-run-scripts report-results --config mymachine-creds.yaml
```

If you created the machine with the maas-run-scripts, you should have such a mymachine-creds.yaml file already. If not, it should look like this:

```
reporting:
          maas:
            consumer_key: $CONSUMER_KEY
            endpoint: http://$MAAS_IP:5240/MAAS/metadata/status/$SYSTEM_ID
            token_key: $TOKEN_KEY
            token_secret: $TOKEN_SECRET
```

You may get the needed credentials from the MAAS API, for example:

```
$ maas $profile machine get-token wxwwga
Success.
Machine-readable output follows:
{
        "token_key": "Lyy9BS4tKsQakDQScy",
        "token_secret": "V8vta8Azwn6FZVkfHnuTvLGLScAvEufB",
        "consumer_key": "YGT6QKSH65aap4tGnw"
}
```

<a href="#heading--static-ubuntu-images"><h3 id="heading--static-ubuntu-images">Static Ubuntu image upload and reuse</h3></a>

#### Ten words or fewer

Users can upload, deploy and reuse a bootable ubuntu image

#### About this feature

MAAS supports deploying custom OS images.  Canonical provides both [lp:maas-image-builder](https://launchpad.net/maas-image-builder) and [gh:canonical/packer-maas](https://github.com/canonical/packer-maas) to create custom images. With 3.1, these custom images can include static Ubuntu images, created with whatever tool you choose, deployed as described below. Canonical still suggests customising Ubuntu using cloud-init user_data or Curtin preseed data, if possible.

#### About static Ubuntu images

MAAS allows you to build an Ubuntu image to deploy with MAAS, using any chosen image-building tool.  You can create the image with a fixed configuration and deploy it to many machines.  This fixed configuration can contain anything a normal image would contain: users, packages, etc.

#### About uploading hand-built Ubuntu images

You can upload and deploy hand-built Ubuntu images, containing kernel, bootloader, and fixed configuration.  The image can be built by tool, e.g., [packer](https://github.com/canonical/packer-maas), or by scripts. You can upload these images to the boot-resources endpoint, where they will be available for deployment.

The minimum image must contain a kernel, bootloader, and `/curtin/curtin-hooks` script that configures the network. Samples can be found in the [packer-maas repos](https://github.com/canonical/packer-maas/tree/master/ubuntu/scripts). The image must be in raw img file format so MAAS will accept the upload.  When built, you will upload this img file to the boot-resources endpoint, specifying the image architecture.

#### About how MAAS handles these images

MAAS will save the image as a `tar.gz` file in the database.  MAAS can differentiate between image types and generate appropriate pre-seed configurations.  MAAS also recognises the base Ubuntu version, so it can apply the correct ephemeral OS for installation.  Custom images are always deployed with the ephemeral OS, where the `base_image` field indicates the appropriate ephemeral version to avoid errors, ensuring smooth deployment later.

#### About how MAAS boots these images

When you deploy a machine with your custom image, MAAS ensures that the machine receives the kernel, bootloader and root file system provided in the image. The initial boot loader then boots an ephemeral OS matching the Ubuntu version of the custom image, reducing compatibility issues.  Curtin then writes your entire custom image to disk, after which it is not modified by MAAS.

Note that custom non-Ubuntu images still use a standard Ubuntu ephemeral OS to boot.

#### About configuring deployed machine networking

If you deploy a machine with a custom Ubuntu image, MAAS allows you to configure the deployed machine's networks just like any other MAAS machine.  If you create an interface and assign it to a subnet or static address, this will be reflected in the deployed machine.

For this reason, MAAS also does some initial diagnostics while installing the custom image.  MAAS will warn you about a missing network configuration, by checking for `cloud-init` and `netplan` in the `curtin` images. MAAS won't deploy machine with such images.

#### About configuring deployed machine storage

If you deploy a machine with a custom Ubuntu image, you will also want to be able to configure storage, just like any other machine.  MAAS facilitates changes to the storage configuration, such as resizing `/root`, attaching and formatting block devices, etc.

#### About static image metrics

As a user, you want to track of deployed static images. The standard MAAS dashboard now reflects these metrics.

#### How to upload a custom Ubuntu image

Custom Ubuntu images can be uploaded with the MAAS CLI by creating a boot-resource:

```nohighlight                                                                                                        	 
	maas $PROFILE boot-resources create \
        name='custom/ubuntu-custom'  \
        architecture=amd64/generic \
        title=’custom ubuntu’ \
        base_image=ubuntu/focal \
        filetype=ddraw \
        content@=./custom-ubuntu.img
 ```	 

[note]
When uploading a custom image, there is a new required field: `base_image`. This is not required for non-custom images; any image with the `custom` prefix will require it.
[/note]

<a href="#heading--machine-cloning-ui"><h3 id="heading--machine-cloning-ui">Machine configuration cloning UI</h3></a>

#### Ten words or fewer

Extend machine cloning to UI, moving toward machine profile templates.

#### About this feature 

MAAS 3.1 allows you to quickly clone or copy a configurationbetween machines, via the MAAS UI -- a step towards machine templating. 

Creating a machine profile is repetitive. We've learned that most users create multiple machines of the same configuration in batches. Some users loop a template through the API, while others rely on scripts. MAAS API cloning functionality is now being exposed in the UI.

#### About copying machine configurations

As a MAAS user, you may want to copy a machine configuration to multiple existing machines. Assuming that at least one machine is already configur3d, you should be able to apply these settings to a list of machines.  This means that a user should be able to:

 - select the source machine to copy from.
 - validate that the source machine exists.
 - select at least 1 destination machine.
 - validate that the destination machine(s) exist.
 - edit the source machine or destination machines, if needed.
 - know at all times which machines are affected.
 - see the cloned machines when cloning is successful, or
 - get clear failure information, if cloning fails. 

#### About choosing configuration items to copy

As a MAAS user, you likely want to select whether storage, network, or both configurations should be cloned. The cloning API allows users to choose interfaces and storage separately.  Thus, this new feature also allows you to:

 - clone only the interface (network) configuration.
 - clone only the storage configuration.
 - clone both colnfigurations.

#### About cloning restrictions

In order for cloning to succeed, a few restrictions must be met:

1. The destination interface names must be the same source.
2. The destination drive must be equal to or larger than the source drive.
3. For static IPs, a new IP will be allocated to the interface on the destination machine

#### How to clone a machine from the UI

Assume you have two machines available, like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/6/6f662618011e3eb1f8e0bfe85748825db4a6ac25.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/6f662618011e3eb1f8e0bfe85748825db4a6ac25.png">

Select the machine *to which you want to clone configuration*, and select "Clone from..."

<a href="https://discourse.maas.io/uploads/default/original/2X/b/b4e42a59f1d4bc6d63f2cd24d77316eea3aada1b.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/b/b4e42a59f1d4bc6d63f2cd24d77316eea3aada1b.png">

Under "1. Select the source machine" -- choose a machine from the attached list:

<a href="https://discourse.maas.io/uploads/default/original/2X/2/287bbf3db4bbc3253a976ecde8965c341fc1bee3.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/287bbf3db4bbc3253a976ecde8965c341fc1bee3.png">

Under "2. Select what to clone", choose "Network", "Storage", or both (here, we've chosen "Storage"):

<a href="https://discourse.maas.io/uploads/default/original/2X/6/622afe3c0bcd4775ef4c19460cf0f1f480c11efb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/622afe3c0bcd4775ef4c19460cf0f1f480c11efb.png">

Click "Clone to machine". MAAS will report the status of the attempt.

<a href="#heading--lxd-auth-ux-improvements"><h3 id="heading--lxd-auth-ux-improvements">LXD authentication UX improvements</h3></a>

#### Ten words or fewer

Easier MAAS to LXD connection that uses certificates for authentication.

#### About this feature

MAAS 3.1 provides a smoother experience when connecting an existing LXD server to MAAS, guiding the user through manual steps and providing increased connection security with use of certificates. Currently, each MAAS region/rack controller has its own certificate. To add a LXD VM host to MAAS, the user needs to either add the certificate for each controller that can reach the LXD server to the trust list in LXD, or use the trust_password (in which case the controller talking to LXD will automatically add its certificate to the trust).

This doesn’t provide a great user experience, as the former process is cumbersome, and the latter is not suggested for production use for security reasons.  To improve this, MAAS 3.1 manages per-LXD keys/certificates, and provide a way for users to get the content of certificates, to authorize MAAS in LXD.

#### About on-the-spot certificate creation

As a MAAS user, you want to register a LXD host into MAAS using certificates for authentication -- to follow LXD production deployment best practices.  The standard way for clients to authenticate with LXD servers is through certificates. The use of trust_password is *only* meant as a way to interact for initial setup.

While prior versions of MAAS support both ways of authentication (and automatically adds the certificate for the rack talking to LXD when registering the VM host), the user experience is lacking, since there's no control over the certificate being used.  In addition, each rack uses a different certificate, making it hard to manage scenarios where multiple racks can connect to a LXD server.

For these reasons, when adding a LXD host, MAAS 3.1 provides a way to generate a secret key and certificate pair to use specifically for that server, and show the certificate to the user, so that they can add it to the LXD server trust list.  The user experience changes to something like the following:

 - MAAS generates a secret key and certificate pair for use with a LXD server.
 - The user can see the certificate and is guided to add it to the LXD server trust list.
 - The user can easily complete the registration of the LXD server once the certificate is trusted in LXD.
 - All racks use the same key when talking to the LXD server. 
 - If a new rack controller is added, it can communicate with the LXD server out of the box.
 - If the trust password is used, it’s not stored in MAAS persistently.
 - It’s possible to get the certificate for a LXD server from a URL (e.g. for curl use).

#### About bringing your own certificates

As a MAAS user, you may want to register a LXD host into MAAS by providing a private key for a certificate that’s already trusted by the LXD server.  For example, you may already have set up certificates in the server trust for MAAS to use, MAAS should provide a way to import it, instead of generating a new one.

With MAAS 3.1, it’s possible to import an existing key/certificate pair for use with a LXD server when registering it with MAAS.  MAAS stores the key/certificate instead of generating new ones.

[note]
The imported key must not have a passphrase; otherwise, MAAS will not be able to use it.
[/note]

#### How to get started

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

<a href="#heading--image-sync-performance"><h3 id="heading--image-sync-performance">Improved image sync performance</h3></a>

#### Ten words or fewer

After downloading images, the rack controller syncs them much faster.

#### About this feature

Downloading and syncing images is a known delay element in MAAS.  While images aren't small, and do take some time to download, we decided to try to speed up the process as much as possible.  After the region has downloaded new images, the rack controllers are now much quicker at syncing the new images.

#### How to take advantage of this new feature

There is nothing required of our users to experience this improved sync performance, other than upgrading to 3.1.

<a href="#heading--maas-3-1-cumulative-bug-fixes"><h3 id="heading--maas-3-1-cumulative-bug-fixes">MAAS 3.1 cumulative bug fixes</h3></a>

MAAS 3.1 bug fixes can be found in the following milestones:

 - [MAAS 3.1 Beta5 bug fixes](https://launchpad.net/maas/+milestone/3.1.0-beta5)
 - [MAAS 3.1 Beta4 bug fixes](https://launchpad.net/maas/+milestone/3.1.0-beta4)
 - [MAAS 3.1 Beta3 bug fixes](https://launchpad.net/maas/+milestone/3.1.0-beta3)
 - [MAAS 3.1 Beta2 bug fixes](https://launchpad.net/maas/+milestone/3.1.0-beta2)
 - [MAAS 3.1 Beta1 bug fixes](https://launchpad.net/maas/+milestone/3.1.0-beta1)
 
[/tab]
[tab version="v3.0 Snap,v3.0 Packages"] 
<h2>MAAS 3.0 release notes</h2>

We are happy to announce the release of MAAS 3.0. This release provides new features, along with critical and high-priority [bug fixes](#heading--maas-3-bug-fixes).

#### Cumulative summary of new features in MAAS 3.0
1. [PCI and USB devices are now modelled in MAAS](#heading--pci-usb-devices)
2. [IBM Z DPM partition support](#heading--ibm-z-dpm)
3. [Proxmox support](#heading--proxmox-support)
4. [LXD projects support](#heading--lxd-projects-support)
5. [PCI and USB device tabs in machine details](#heading--pci-usb-device-tabs)
6. [Workload annotations](#heading--workload-annotations)
7. [Fixed status bar](#heading--fixed-status-bar)
8. [Registering a machine as a VM host during deployment](#heading--machine-register-vm-host-on-deployment)
9. [Improvements to MAAS CLI help UX](#heading--maas-cli-ux-improved-help)
10. [Disabling boot methods](#heading--disabling-boot-methods)
11. [Consolidation of logs and events](#heading--log-consolidation)

[tabs]
[tab version="v3.0 Snap"]
MAAS 3.0 can be installed fresh (recommended) with:

```
sudo snap install --channel=3.0/stable maas
```
[/tab]
[tab version="v3.0 Packages"]
MAAS 3.0 can be installed by adding the `3.0` PPA:

```
sudo add-apt-repository ppa:maas/3.0
sudo apt update
sudo apt install maas
```

You can then either install MAAS 3.0 fresh (recommended) with:

```
sudo apt-get -y install maas
```

Or, if you prefer to upgrade, you can do so with:

```
sudo apt upgrade maas
```
[/tab]
[/tabs]

At this point, you may proceed with a normal installation.

<h2>Significant changes</h2>

With the advent of MAAS 3.0, we are removing support for RSD pods.  Registered pods and their machines will be removed by MAAS upon upgrading to MAAS 3.0.

Note that new features are categorized by the level of release at which they became accessible to users.

<h2>New features in MAAS 3.0 RC1</h2>

<h3 id="heading--log-consolidation">Consolidation of logs and events</h3>

The logs and events tabs have combined and now live under "Logs". In addition to a number of small improvements, navigating and displaying events has been made easier.

<a href="https://discourse.maas.io/uploads/default/optimized/2X/4/497fd5d03ece0308648db33cf144f4cfefc6e5ed_2_690x465.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/2X/4/497fd5d03ece0308648db33cf144f4cfefc6e5ed_2_690x465.png"></a>

#### Downloading logs

A helpful new feature is the ability to download the machine and installation output, and if a machine has failed deployment you can now download a full tar of the curtain logs.

<a href="https://discourse.maas.io/uploads/default/optimized/2X/f/fe9df81b810fa3dd502b303b08978d1c60bff933_2_690x465.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/2X/f/fe9df81b810fa3dd502b303b08978d1c60bff933_2_690x465.png"></a>

<h3 id="heading--disabling-boot-methods">Disabling boot methods</h3>

Individual boot methods may now be disabled. When a boot method is disabled MAAS will configure MAAS controlled isc-dhcpd to not respond to the associated [boot architecture code](https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml#processor-architecture). External DHCP servers must be configured manually.

To allow different boot methods to be in different states on separate physical networks using the same VLAN ID configuration is done on the subnet in the UI or API. When using the API boot methods to be disabled may be specified using the MAAS internal name or [boot architecture code](https://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xhtml#processor-architecture) in octet or hex form. For example the following disabled i386/AMD64 PXE, AMD64 UEFI TFTP, and AMD64 UEFI HTTP

```
maas $PROFILE subnet update $SUBNET disabled_boot_architectures="0x00 uefi_amd64_tftp 00:10"
```

#### GRUB

* UEFI AMD64 HTTP(00:10) has been re-enabled.
* UEFI ARM64 HTTP(00:13) has been enabled.
* UEFI ARM64 TFTP(00:0B) and UEFI ARM64 HTTP(00:13) will now provide a shim and GRUB signed with the Microsoft boot loader keys.
* grub.cfg for all UEFI platforms has been updated to replace the deprecated `linuxefi` and `initrdefi` commands with the standard `linux` and `initrd` commands.
* GRUB debug may now be enabled by enabling [rackd debug logging](https://discourse.maas.io/t/running-installed-maas-in-debug-logging-mode/168).

<h2>New feature in MAAS 3.0 Beta 4</h2>

<h3 id="heading--maas-cli-ux-improved-help">Improvements to MAAS CLI help UX</h3>

The MAAS CLI will now give you help in more places, supporting a more exploration-based interaction. Specifically, we now show `help` for cases where the required arguments are not met.

Say you're trying to find out how to list the details of a machine in MAAS e.g.

 ```bash
$ PROFILE=foo
$ maas login $PROFILE http://$MY_MAAS:5240/MAAS/ $APIKEY
$ maas $PROFILE
usage: maas $PROFILE [-h] COMMAND ...

Issue commands to the MAAS region controller at http://$MY_MAAS:5240/MAAS/api/2.0/.

optional arguments:
  -h, --help            show this help message and exit

drill down:
  COMMAND
    account             Manage the current logged-in user.
    bcache-cache-set    Manage bcache cache set on a machine.
    bcache-cache-sets   Manage bcache cache sets on a machine.
 
✂️--cut for brevity--✂️
    machine             Manage an individual machine.
    machines            Manage the collection of all the machines in the MAAS.
    node                Manage an individual Node.
    nodes               Manage the collection of all the nodes in the MAAS.
✂️--cut for brevity--✂️

too few arguments
$ maas $PROFILE node 
usage: maas $PROFILE node [-h] COMMAND ...

Manage an individual Node.

optional arguments:
  -h, --help        show this help message and exit

drill down:
  COMMAND
    details         Get system details
    power-parameters
                    Get power parameters
    read            Read a node
    delete          Delete a node

The Node is identified by its system_id.

too few arguments

$ maas $PROFILE node read
usage: maas $PROFILE node read [--help] [-d] [-k] system_id [data [data ...]]

Read a node

positional arguments:
  system_id
  data

optional arguments:
  --help, -h      Show this help message and exit.
  -d, --debug     Display more information about API responses.
  -k, --insecure  Disable SSL certificate check

Reads a node with the given system_id.

the following arguments are required: system_id, data
$ maas $PROFILE node read $SYSTEM_ID
{
    "system_id": "$SYSTEM_ID",
    "domain": {
        "authoritative": true,
        "ttl": null,
        "is_default": true,
        "id": 0,
        "name": "maas",
        "resource_record_count": 200,
        "resource_uri": "/MAAS/api/2.0/domains/0/"
✂️--cut for brevity--✂️
```

We can see at each stage `help` which gives us clues as to what the next step is, finally arriving at a complete CLI command.

<h2>New feature in MAAS 3.0 Beta 2</h2>

<h3 id="heading--machine-register-vm-host-on-deployment">Registering a machine as a VM host during deployment</h3>

When deploying a machine through the API, it’s now possible to specify `register_vmhost=True` to have LXD configured on the machine and registered as a VM host in MAAS (similar to what happens with virsh if `install_kvm=True` is provided).

<h2>New features in MAAS 3.0 Beta 1</h2>

<h3 id="heading--pci-usb-devices">PCI and USB devices are now modelled in MAAS</h3>

MAAS 3.0 models all PCI and USB devices detected during commissioning:

* Existing machines will have to be recommissioned to have PCI and USB devices modelled
* PCI and USB devices are shown in the UI and on the API using the node-devices endpoint
* Node devices may be deleted on the API only

On the API using the allocate operation on the machines endpoint a machine may allocated by a device vendor_id, product_id, vendor_name, product_name, or commissioning_driver.

<h3 id="heading--ibm-z-dpm">IBM Z DPM partition support</h3>

IBM Z14 GA2 (LinuxOne II) and above mainframe partitions are supported in MAAS 3.0.  Note that partitions (LPARS) must pre-configured and use qeth-based network devices (use HyperV sockets and properly-defined storage groupslike Hipersockets or OSA adapters) and properly-defined (FCP) storage groups..  IBM Z DPM Partitions can be added as a chassis, which allows you to add all partitions at once.

<h3 id="heading--proxmox-support">Proxmox support</h3>

MAAS 3.0 supports Proxmox as a power driver:

* Only Proxmox VMs are supported
* You may authenticate with Proxmox using a username and password or a username and API token
* If an API token is used, it must be given permission to query, start and stop VMs.
* Proxmox VMs can be added as a chassis; this allows you to add all VMs in Proxmox at once.

Note that proxmox support has also been back-ported to MAAS 2.9

<h3 id="heading--lxd-projects-support">LXD projects support</h3>

MAAS 3.0 supports the use of LXD projects:

* LXD VM hosts registered in MAAS are now tied to a specific LXD project which MAAS uses to manage VMs
* MAAS doesn’t create or manage machines for VMs in other projects
* MAAS creates the specified project when the VM host is registered, if it doesn't exist
* All existing VMs in the specified project are commissioned on registration
* Resource usage is reported at both project and global levels

<h3 id="heading--pci-usb-device-tabs">PCI and USB device tabs in UI machine details</h3>

Tables for detected PCI and USB devices have been added to the machine details page for MAAS 3.0:

<a  href="https://discourse.maas.io/uploads/default/original/2X/8/87f42bafe321d45af94d73216f933a9067f01df2.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/8/87f42bafe321d45af94d73216f933a9067f01df2.png"></a>

These tables include a new skeleton loading state while node devices are being fetched:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/4faa1d8cd996a25ee5089ada924b405bc8903aa4.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/4faa1d8cd996a25ee5089ada924b405bc8903aa4.png"></a>

The user is prompted to commission the machine if no devices are detected.

<h3 id="heading--workload-annotations">Workload annotations</h3>

Workload annotations have been added to the machine summary page in MAAS 3.0.  These allow you to apply `owner_data` to a machine and make it visible while the machine is in allocated or deployed state:

<a href="https://discourse.maas.io/uploads/default/original/2X/5/54682ae5f9c7bb449a1ad222679be0156f27d109.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/5/54682ae5f9c7bb449a1ad222679be0156f27d109.png"></a>

This data is cleared once the machine state changes to something other than "allocated" or "deployed."  The machine list can be filtered by these workload annotations.  MAAS will warn you on the release page to remind you that workload annotations will be cleared upon releasing the machine.

<h3 id="heading--fixed-status-bar">Fixed status bar</h3>

In MAAS 3.0, a fixed status bar has been added to the bottom of the screen, which will always display the MAAS name and version on the left.  The right side of the status bar is intended to show contextual data, depending on the UI panel currently displayed. For now, the only data shown is a “last commissioned” timestamp when the user is on a machine details page:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3a15d7e1d7251f3e928e3054a2aab71f414503bd.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3a15d7e1d7251f3e928e3054a2aab71f414503bd.png"></a>


<h2 id="heading--maas-3-bug-fixes">MAAS 3.0 bug fixes</h2>

MAAS 3.0 incorporates a large number of bug fixes, summarised in the sections below. Please feel free to validate these fixes at your convenience and give us feedback if anything doesn't seem to work as presented in the bug request.

One particular bug, [#1916860](https://bugs.launchpad.net/maas/+bug/1916860), involves failures in the IPMI cipher suite in MAAS 2.9.2 and up, on the Lenovo x3650 M5 (and others).  This particular bug is a not a MAAS bug, but a firmware issue with the subject machines.  While the MAAS team can't fix this (hence the assignment of "Won't Fix"), the team did provide a easy [workaround](https://bugs.launchpad.net/maas/+bug/1916860/comments/27) which helps circumvent this issue.

<h3 id="heading--maas-3-0-bug-fixes">MAAS 3.0 bug fixes</h3>

Here are the bugs that were 'Fix Released' for the MAAS 3.0 release:

|Number | Description | Importance |
|:------|:------------|:-----------|
|[#1932136](https://bugs.launchpad.net/bugs/1932136)|interface with a warning is not configured properly| Critical|
|[#1896771](https://bugs.launchpad.net/bugs/1896771)|interfaces that are not connected are detected as 'connected to slow interface'|Medium|

<h3 id="heading--maas-3-rc-2-bug-fixes">MAAS 3.0 RC2 bug fixes</h3>

Here are the bugs that have been 'Fix Released' in MAAS 3.0 RC2:

| Number | Description | Importance |
|:-------|:------------|:-----------|
|[#1929552](https://bugs.launchpad.net/bugs/1929552)|Deb-based controller fails to run machine-resources|Critical|
|[#1929576](https://bugs.launchpad.net/bugs/1929576)|Machines fail to commission using the 3.0 snap due to possible? DNS issue|Critical|
|[#1930227](https://bugs.launchpad.net/bugs/1930227)|Failure to commission when interfaces has a /32 IP |Critical|  
|[#1930554](https://bugs.launchpad.net/bugs/1930554)|vm-host CLI command is now named vmhosts  |Critical| 
|[#1930587](https://bugs.launchpad.net/bugs/1930587)|Different disks with same LUN detected as multipath  |Critical|  
|[#1931215](https://bugs.launchpad.net/bugs/1931215)|[.0~rc2-10023 testing] two IPs assigned to one interface  |Critical| 
|[#1931838](https://bugs.launchpad.net/bugs/1931838)|Reverse DNS lookup fails for subnets smaller than /24  |Critical| 
|[#1835292](https://bugs.launchpad.net/bugs/1835292)|UI should add button to download curtin-logs.tar on deployment failure MAAS |High| 
|[#1908552](https://bugs.launchpad.net/bugs/1908552)|maas init fails; 'relation "maasserver_routable_pairs" does not exist'  |High|  
|[#1929086](https://bugs.launchpad.net/bugs/1929086)|LXD VM hosts can't be refreshed if VLANs interfaces aren't named $parent.$vid  |High| 
|[#1929643](https://bugs.launchpad.net/bugs/1929643)|MAAS often fails and and returns a Pickled object if request header is set to Accept: */*  |Medium|  
|[#1924820](https://bugs.launchpad.net/bugs/1924820)|Trying to edit a disconnected NIC, then cancelling the edit and connecting the NIC via its drop-down menu, many drop-down menu options then disappear|Undecided| 
<h3 id="heading--maas-3-rc-1-bug-fixes">MAAS 3.0 RC1 bug fixes</h3>

Here are the bugs that have been 'Fix Released' in MAAS 3.0 RC1:

| Number | Description |Importance|
|:-----|:-----|:-----:|
[#1774529](https://bugs.launchpad.net/bugs/1774529)|Cannot delete some instances of model 'Domain' because they are referenced through a protected foreign key|High|
[#1919001](https://bugs.launchpad.net/bugs/1919001)|Unable to network boot VM on IBM Z DPM Partition|High|
[#1925249](https://bugs.launchpad.net/bugs/1925249)|MAAS detects 0 cores, RAM available for KVM host, reports negative availability on pod compose|High|
[#1927292](https://bugs.launchpad.net/bugs/1927292)|Updating controller has vlan_ids error|High|
[#1927657](https://bugs.launchpad.net/bugs/1927657)|Global kernel command line options not passed with tags|High|
[#1928098](https://bugs.launchpad.net/bugs/1928098)|If a workload annotation has a key with spaces in it, filtering doesn't work|High|
[#1926140](https://bugs.launchpad.net/bugs/1926140)|maas_url not returned to the UI|Medium|
[#1926171](https://bugs.launchpad.net/bugs/1926171)|Failure processing network information when adding a rack|Medium|
[#1927036](https://bugs.launchpad.net/bugs/1927036)|Incorrect value "accept_ra" in interface definition|Medium|
[#1927340](https://bugs.launchpad.net/bugs/1927340)|Deb to snap migration script should support remote Postgres|Medium|
[#1928104](https://bugs.launchpad.net/bugs/1928104)|New workload annotations don't show up without a reload|Medium|
[#1928115](https://bugs.launchpad.net/bugs/1928115)|API still refers to "owner data" rather than "workload annotations"|Medium|
[#1922891](https://bugs.launchpad.net/bugs/1922891)|MAAS configures nodes with incorrect DNS server addresses when using multiple IP addresses|Undecided|
[#1923268](https://bugs.launchpad.net/bugs/1923268)|grubnet default grub.cfg should try /grub/grub.cfg-${net_default_mac} before /grub/grub.cfg|Undecided|
[#1926164](https://bugs.launchpad.net/bugs/1926164)|VLAN page shows odd "Rack controllers" value|Undecided|
[#1926510](https://bugs.launchpad.net/bugs/1926510)|dhcp subnet snippets are NOT inside the pool block|Undecided|
[#1927559](https://bugs.launchpad.net/bugs/1927559)|Default logical volume size too big in UI|Undecided|
[#1928024](https://bugs.launchpad.net/bugs/1928024)|UI states commissioning/testing scripts were never uploaded|Undecided|
[#1928226](https://bugs.launchpad.net/bugs/1928226)|Information "not available" indicates that it''s an error of some sort|Undecided|
[#1928235](https://bugs.launchpad.net/bugs/1928235)|notes field won't update properly: MAAS 3.0 RC]()|Undecided|
[#1928324](https://bugs.launchpad.net/bugs/1928324)|updating a machine zone or resource pool doesn't refresh details|Undecided|
<h3 id="heading--maas-3-beta-5-bug-fixes">MAAS 3.0 Beta 5 bug fixes</h3>

Here are the bugs that have been `Fix Released` in MAAS 3.0 Beta 5:

| Number | Description |Importance|
|:-----|:-----|:-----:|
|[#1925784](https://bugs.launchpad.net/bugs/1925784)|Processing LXD results failure with loopback|Critical|
|[#1923871](https://bugs.launchpad.net/bugs/1923871)|LXD vmhost project usage includes usage for other projects|High|
|[#1815084](https://bugs.launchpad.net/bugs/1815084)|MAAS web ui should perform Save action when Enter/Return is pressed|Medium|
|[#1923867](https://bugs.launchpad.net/bugs/1923867)|Commissioning fails if NIC gets different PCI address|Medium|

<h3 id="heading--maas-3-beta-4-bug-fixes">MAAS 3.0 Beta 4 bug fixes</h3>

Here are the bugs that have been `Fix Released` in MAAS 3.0 Beta 4:

| Number | Description |Importance|
|:-----|:-----|:-----:|
|[#1923246](https://bugs.launchpad.net/bugs/1923246)|Unable to compose LXD VM with multiple NICs |High |
|[#1918963](https://bugs.launchpad.net/bugs/1918963)|Controllers page out of sync with nodes |Undecided |
|[#1923685](https://bugs.launchpad.net/bugs/1923685)|Unable to deploy LXD VM host on S390X |Undecided |
|[#1923687](https://bugs.launchpad.net/bugs/1923687)|LXD VM host refresh failure is ignored |Undecided |
|[#1774529](https://bugs.launchpad.net/bugs/1774529)|Cannot delete some instances of model 'Domain' because they are referenced through a protected foreign key |High |
|[#1914762](https://bugs.launchpad.net/bugs/1914762)|test network configuration broken with openvswitch bridge |High |
|[#1919001](https://bugs.launchpad.net/bugs/1919001)|Unable to network boot VM on IBM Z DPM Partition |High |
|[#1917963](https://bugs.launchpad.net/bugs/1917963)|Add chassis lowers the case of added machines |Low |
|[#1915087](https://bugs.launchpad.net/bugs/1915087)|2.9 UI is broken, seems to loop between user intro and machines pages endlessly |High |
|[#1923842](https://bugs.launchpad.net/bugs/1923842)|Can't use action menu on machine details page |High |
|[#1917667](https://bugs.launchpad.net/bugs/1917669)|Commissioning/testing scripts no longer show ETA or progress |Undecided |
|[#1917669](https://bugs.launchpad.net/bugs/1917669)|No way to view previous commissioning or testing script results |Undecided |
|[#1917670](https://bugs.launchpad.net/bugs/1917670)|Storage and interface tests not assoicated with a device |Undecided |
|[#1917671](https://bugs.launchpad.net/bugs/1917671)|Commissioning/testing scripts not updated after starting commissioning or testing |Undecided |
|[#1917794](https://bugs.launchpad.net/bugs/1917794)|Unable to view full history of events in UI |Undecided |
|[#1918964](https://bugs.launchpad.net/bugs/1918964)|UI shows action unavailable after performing action |Undecided |
|[#1918966](https://bugs.launchpad.net/bugs/1918966)|Tabs aren't always underscorred |Undecided |
|[#1918971](https://bugs.launchpad.net/bugs/1918971)|UI does not autofill size on storage tab |Undecided |
|[#1923524](https://bugs.launchpad.net/bugs/1923524)|Unable to delete LXD composed machine on KVM page |Undecided |

<h3 id="heading--maas-3-beta-3-bug-fixes">MAAS 3.0 Beta 3 bug fixes</h3>

Here are the bugs that have been `Fix Released` in MAAS 3.0 Beta 3:

| Number | Description |Importance|
|:-----|:-----|:-----:|
|[#1922569](https://bugs.launchpad.net/bugs/1922569)| Create KVM fails in MAAS 3.0 Beta with a project error |High|
|[#1923251](https://bugs.launchpad.net/bugs/1923251)| Creating an LXD VM host now requires a project name |High|
|[#1809939](https://bugs.launchpad.net/bugs/1809939)| dhcp snippet create fail when dhcp subnet is relayed |Medium|
|[#1913460](https://bugs.launchpad.net/bugs/1913460)| Add option to pick whether to keep or decompose machines in a VM host |Undecided|
|[#1922787](https://bugs.launchpad.net/bugs/1922787)| make "LXD" the default VM host in MAAS UI (rather than virsh) |Undecided|
|[#1922876](https://bugs.launchpad.net/bugs/1922876)| Deploy KVM hosts with LXD by default |Undecided|
|[#1922972](https://bugs.launchpad.net/bugs/1922972)| MAAS 3.0 Beta2 UI says "machine cannot be deployed" while successfully deploying machine |Undecided|
|[#1923719](https://bugs.launchpad.net/bugs/1923719)| MAAS 3.0 : snap refresh maas from 3.0.0~beta2-9826-g.13cc184d5 |Undecided|

<h3 id="heading--maas-3-beta-2-bug-fixes">MAAS 3.0 Beta 2 bug fixes</h3>

Here are the bugs that have been `Fix Released` in MAAS 3.0 Beta 2:

| Number | Description |Importance|
|:-----|:-----|:-----:|
|[#1922107](https://bugs.launchpad.net/bugs/1922107)| Hugepages/pinning available for virsh and lack validation |High|
|[#1922433](https://bugs.launchpad.net/bugs/1922433)| Machine resources path set incorrectly in rackd when using snap |High|

<h3 id="heading--maas-3-beta-1-bug-fixes">MAAS 3.0 Beta 1 bug fixes</h3>

Here are the bugs that have been `Fix Released` in MAAS 3.0 Beta 1:

| Number | Description |Importance|
|:-----|:-----|:-----:|
|[#1896199](https://bugs.launchpad.net/maas/+bug/1896199) |API docs link is not offline|Critical|
|[#1904245](https://bugs.launchpad.net/bugs/1904245)|MAAS Snap fails to build on PPC64 on Launchpad |Critical|
|[#1912727](https://bugs.launchpad.net/bugs/1912727)|KVM Page Fails to load with error "An unexpected error has occurred, please try refreshing your browser window." |Critical|
|[#1915869](https://bugs.launchpad.net/bugs/1915869)| maas snap cli renders SyntaxWarning in the stderr |Critical|
|[#1916093](https://bugs.launchpad.net/bugs/1916093)|Unable to add more than 3 Promox VMs |Critical| 
|[#1883824](https://bugs.launchpad.net/bugs/1883824)|Support LXD projects in power control |High| 
|[#1884276](https://bugs.launchpad.net/bugs/1884276)|Terrible user experience adding existing LXD host |High| 
|[#1902425](https://bugs.launchpad.net/bugs/1902425)|Failed to allocate the required AUTO IP addresses after 2 retries |High| 
|[#1908087](https://bugs.launchpad.net/bugs/1908087)|Reverse DNS for non-maas RFC1918 zones fails inside maas |High| 
|[#1908356](https://bugs.launchpad.net/bugs/1908356)|Owner data websocket methods are not working |High|
|[#1908434](https://bugs.launchpad.net/bugs/1908434)|Can't delete LXD VM in offline state |High| 
|[#1913323](https://bugs.launchpad.net/bugs/1913323)|/MAAS/docs/ leads to 404 page |High| 
|[#1914588](https://bugs.launchpad.net/bugs/1914588)|Enabling debug from snap traceback |High| 
|[#1915021](https://bugs.launchpad.net/bugs/1915021)|Mapping subnet doesn't work from the MAAS snap |High| 
|[#1915022](https://bugs.launchpad.net/bugs/1915022)|The MAAS snap doesn't include nmap |High| 
|[#1915715](https://bugs.launchpad.net/bugs/1915715)|LXD VM additional disks all show 10Gb size |High| 
|[#1915970](https://bugs.launchpad.net/bugs/1915970)|Facebook Wedge BMC detection fails on non-x86 architectures |High| 
|[#1918997](https://bugs.launchpad.net/bugs/1918997)|MAAS does not set snap proxy |High| 
|[#1919000](https://bugs.launchpad.net/bugs/1919000)|Unable to connect MAAS to an LXD VM host |High| 
|[#1887797](https://bugs.launchpad.net/bugs/1887797)|Impossible to delete zombie LXD VM |Medium| 
|[#1894116](https://bugs.launchpad.net/bugs/1894116)|Machines can't be deployed after deselecting all archs in the "Ubuntu extra architectures" package repo |Medium| 
|[#1897946](https://bugs.launchpad.net/bugs/1897946)|hi1620-based ARM Servers are shown as "Unknown model" |Medium| 
|[#1906212](https://bugs.launchpad.net/bugs/1906212)|timeout in testing scripts ignores the days if set to greater than 24 hours |Medium| Hemanth Nakkina 
|[#1911825](https://bugs.launchpad.net/bugs/1911825)|Unable to use FQDN as power_address |Medium| 
|[#1914165](https://bugs.launchpad.net/bugs/1914165)|Proxmox does not allow custom port |Medium| 
|[#1917652](https://bugs.launchpad.net/bugs/1917652)|30-maas-01-bmc-config failing on commissioning Cisco UCSC-C220-M4L |Medium| 
|[#1335175](https://bugs.launchpad.net/bugs/1335175)|maas does not combine kernel_opts when nodes have multiple tags with kernel options |Low| 
|[#1915359](https://bugs.launchpad.net/bugs/1915359)|make sampledata can't find machine-resources |Low| 
|[#1916844](https://bugs.launchpad.net/bugs/1916844)|Removing a machine that is a vm host tells you to remove the "pod" |Low| 
|[#1920019](https://bugs.launchpad.net/bugs/1920019)|maas_remote_syslog_compress is unnecessarily chatty |Low| 
|[#1887558](https://bugs.launchpad.net/bugs/1887558)|Multipath JBOD storage devices are not shown via /dev/mapper but each path as a single device. |Wishlist| 
|[#1901944](https://bugs.launchpad.net/bugs/1901944)|tags field in machine edit page overtakes other fields |Undecided| 
|[#1909985](https://bugs.launchpad.net/bugs/1909985)|Add commission timestamp to machine websocket api |Undecided| 
|[#1913464](https://bugs.launchpad.net/bugs/1913464)|Drop RSD pods UI |Undecided| 
|[#1914590](https://bugs.launchpad.net/bugs/1914590)|Support composing LXD VMs with multiple disks in the UI |Undecided| 
|[#1915970](https://bugs.launchpad.net/bugs/1915970)|Facebook Wedge BMC detection fails on non-x86 architectures |Undecided| 
|[#1916073](https://bugs.launchpad.net/bugs/1916073)|MAAS should install qemu-efi-aarch64 on arm64 KVM pods |Undecided| 
|[#1916317](https://bugs.launchpad.net/bugs/1916317)|UI is using API to request scripts with full content |Undecided| 
|[#1919381](https://bugs.launchpad.net/bugs/1919381)|typo "veryiying" in info message in smartctl-validate |Undecided|
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"] 
<h2>MAAS 2.9.2 release notes</h2>

We have released MAAS 2.9.2, which contains two new features, and some notable [bug fixes](https://launchpad.net/maas/+milestone/2.9.2). The two new features are:

1. Proxmox driver: A driver has been added to MAAS 2.9.2 which intereacts with the Proxmox API.  Only one URL is needed, though a username and credentials are required.  Credentials can be either a password or an API token.  Note that if you use a token, you have to configure the permissions for the token.  Newly-created Proxmox tokens don't assign any permissions by default, so you must add `power on`, `power off`, and `query power` permissions to the token before using it.

2. Power driver Webhook:  A webhook was added to 2.9.2, which allows MAAS to interface with another web service that's running the power commands.  This webhook is provided for interacting with objects that MAAS does not support, that is, the MAAS team supports the driver itself, but whatever is interfacing to the driver is not supported.  This webhook as three URLs, one each for power on, power off, and power query.  Optionally, this webhook also supports a power user and password or token (RFC 6717).  This gives you a way to add your own power drivers without waiting for the driver to be added to MAAS.  There is a [video tutorial](https://discourse.maas.io/t/maas-show-and-tell-proxmox-and-webhook/3754/3) available on this new feature.

You can also find a [digest](#heading--bug-fixes-2-9-2) of the 2.9.2 bug fixes below.

<h2>MAAS 2.9.1 release notes</h2>

Building upon MAAS 2.9, we have released 2.9.1, which contains some notable [bug fixes](https://launchpad.net/maas/+milestone/2.9.1).  You can find a [digest](#heading--bug-fixes-2-9-1) of these fixes below.

<h2>MAAS 2.9 release notes</h2>

Following on from MAAS 2.8, we are happy to announce that MAAS 2.9 is now available.

#### What are the new features & fixes for MAAS 2.9 and MAAS 2.9.1?

1. [Focal Fossa (20.04) as default commissioning/deployment release](#heading--focal-default)
2. [Support for OpenVswitch bridge type](#heading--openvswitch)
3. [Support for NUMA, SR-IOV, and hugepages](#heading--numa)
4. [Improved performance for large MAAS installations](#heading--improved-perf-large-maas)
5. [New release notifications](#heading--new-release-notifications)
6. [IPMI configuration screens](#heading--ipmi-config-screens)
7. [Descriptions when marking machines broken](#heading--descrip-mark-mach-broken)
8. [Curtin 20.2 now included](#heading--curtin-20-2-included)
9. [HTTP boot disabled](#heading--http-boot-disabled)
10. [BMC/IPMI default parameter additions](#heading--bmc-param-additions)
11. [New global IPMI configuration options](#heading--new-config-options)
12. [Addition of IPMI config options to UI](#heading--global-config-settings)
13. [New MAAS CLI power command](#heading--maas-power)
14. [Commissioning speed improvements](#heading--commissioning-speed)
15. [BMC improvements](#heading--bmc-improve)
16. [IPMI power driver upgrades](#heading--ipmi-driver)
17. [Enlistment script improvements](#heading--enlistment-scripts)
18. [Commissioning script improvements](#heading--commissioning-scripts)
19. [Commissioning script reordering](#heading--commissioning-reorder)
20. [Reader Adaptive Documentation](#heading--rad)
21. [Offline documentation](#heading--offline-docs)

<h4>Six other questions you may have:</h4>

1. [What known issues should I be aware of?](#heading--known-issues)
2. [How do I install MAAS 2.9?](/t/how-to-install-maas/3323)
3. [How do I upgrade my MAAS 2.8 snap to a MAAS 2.9 snap?](/t/how-to-install-maas/3323#heading--upgrade-maas-snap)
4. [How do I install MAAS 2.9 from packages?](/t/how-to-install-maas/3329#heading--install-from-packages)
5. [How do I upgrade MAAS 2.8 to MAAS 2.9 using packages?](/t/how-to-install-maas/3329#heading--upgrade-via-packages)
6. [What bugs are fixed so far in this release?](#heading--bug-fixes)

<h2 id="heading--focal-default">Focal Fossa (Ubuntu 20.04 LTS) as default release</h2>

Ubuntu 20.04 LTS (Focal Fossa) is now the default commissioning and deployment release for new MAAS installations.  Machines deployed with Focal may now be registered as KVM hosts.

<h2 id="heading--openvswitch">Support for OpenVswitch bridge type</h2>

MAAS 2.9 allows you to create an OpenVswitch bridge type when creating a bridge.

<h2 id="heading--numa">Support for NUMA, SR-IOV, and hugepages</h2>

MAAS 2.9 adds extensive optimisation tools for using NUMA with virtual machines. You can now see how many VMs are allocated to each NUMA node, along with the allocations of cores, storage, and memory. You can quickly spot a VM running in multiple NUMA nodes, and optimise accordingly, with instant updates on pinning and allocations. You can also tell which VMs are currently running.  Using the CLI, you can also pin nodes to specific cores, and configure hugepages for use by VMs.

Specifically, there are five new features available to support NUMA, SR-IOV, and hugepages:

1. You can examine resources on a per-NUMA-node basis.
2. You can pin nodes to specific cores (CLI only).
3. You can see resources for VM hosts supporting NUMA nodes.
4. You can see the alignment between VM host interfaces and NUMA nodes.
5. You can configure and use hugepages (configurable in CLI only).

This functionality comes with an enhanced panel in the "KVM" details section:

<a href="https://discourse.maas.io/uploads/default/optimized/1X/57245bbbfe6d28e83c9b7fb30e52caf05714eb00_2_485x500.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/1X/57245bbbfe6d28e83c9b7fb30e52caf05714eb00_2_485x500.png"></a>

See the [VM hosting](/t/about-vm-hosting/2747) page for more details, and be sure to use the menu at the top of that page to select your desired build method and interface, so that you'll see the most relevant instructions.

<h2 id="heading--improved-perf-large-maas">Improved performance for large MAAS installations</h2>

MAAS 2.9 includes changes to the machine batch size that the UI loads. Previously the UI loaded machines in batches of 25; it now pulls in 25 for the first call, then 100 at a time in subsequent batches.

You can see the results of the investigation in [this video podcast](https://discourse.maas.io/t/maas-show-and-tell-improving-ui-performance-for-large-maas-installs/3515).

<h2 id="heading--new-release-notifications">New release notifications</h2>

MAAS now includes new release notifications for users and administrators.  These appear when a new release is available:

<a href="https://discourse.maas.io/uploads/default/original/1X/c4f426b9f493a970efcc59c4d948d24fa5f12860.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c4f426b9f493a970efcc59c4d948d24fa5f12860.png"></a>

Both regular and administrative users can snooze these notifications for two weeks at a time.  Administrative users can opt out of new release notifications completely, preventing notifications for any user of that MAAS.

<h2 id="heading--ipmi-config-screens">IPMI configuration screens</h2>

MAAS now includes UI panels corresponding to the [IPMI power driver upgrades](#heading--ipmi-driver) mentioned earlier:

<a href="https://discourse.maas.io/uploads/default/original/1X/433b28f5dd807caef7c7382f9a877607c2ea2dac.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/433b28f5dd807caef7c7382f9a877607c2ea2dac.png"></a>

This screen can be reached from `Settings | Configuration | Commissioning`.

<h2 id="heading--descrip-mark-mach-broken">Descriptions when marking machines broken</h2>

When marking a machine broken, a description can now be included:

<a href="https://discourse.maas.io/uploads/default/original/1X/69df48044c964d27caf59b60dcf5bf5210894c15.png?" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/69df48044c964d27caf59b60dcf5bf5210894c15.png?"></a>

This description appears in that machine's row on the machine list.

<h2 id="heading--curtin-20-2-included">Curtin 20.2 now included</h2>

A number of MAAS issues have actually been issues with an older version of Curtin.  MAAS now includes Curtin 20.2, which fixes many of these issues, including [MAAS is changing my boot order!](https://discourse.maas.io/t/maas-is-changing-my-boot-order/3491).

<h2 id="heading--http-boot-disabled">HTTP boot disabled</h2>

MAAS 2.9 disables HTTP boot. There are known issues with HTTP boot in MAAS, as well as known issues for HTTP boot with grub (e.g. https://bugs.launchpad.net/maas/+bug/1899581)  This shouldn’t affect machine boot, as machines will normally try PXE as a fallback boot method if HTTP boot fails.  Be aware, though, that machine boot will fail if the BIOS is configured to boot only over HTTP; those machines need to be reconfigured to use PXE.

<h2 id="heading--bmc-param-additions">30-maas-01-bmc-config parameter additions</h2>

Four new parameters have been added for IPMI BMC configuration.  These parameters will pull from the global defaults, eliminating the need to set the corresponding parameter in each instance.

1. maas_auto_ipmi_user - The username for the MAAS created IPMI user. Default comes from the global configuration setting.
2. maas_auto_ipmi_user_password - The password for the MAAS created IPMI user, by default a random password is generated.
3. maas_auto_ipmi_k_g_bmc_key - he IPMI K_g pre-shared encryption key to be set when adding the MAAS IPMI user. Note not all IPMI BMCs support setting the k_g key, if MAAS is unable to set the key commissioning will fail. Default comes from the global configuration setting. If an IPMI K_g key is set but the key is rejected by the BMC MAAS will automatically retry without the K_g key. This works around an edge case where some BMCs will allow you to set an K_g key but don’t allow it to be used.
4. maas_auto_ipmi_user_privilege_level - The IPMI user privilege level to use when adding the MAAS IPMI user. Possible options are USER, OPERATOR, or ADMIN. Default comes from the global configuration setting.

Note that MAAS will not capture the BMC MAC address when detecting IPMI BMCs.

<h2 id="heading--new-config-options">New global IPMI configuration options</h2>

Two new global IPMI configuration options have been added:

1. maas_auto_ipmi_k_g_bmc_key - sets a global default IPMI BMC key.
2. maas_auto_ipmi_user_privilege_level - sets a global default IPMI BMC user privilege level.
    
<h2 id="heading--global-config-settings">Addition of IPMI config options to UI</h2>

You may now set the global configuration options `maas_auto_ipmi_user`, `maas_auto_ipmi_k_g_bmc_key`, and `maas_auto_ipmi_user_privilege_level` on the "Settings" page in the UI under "Commissioning."

<h2 id="heading--maas-power">New maas.power CLI command</h2>

Available in all MAAS 2.9 releases is the new `maas.power` CLI command. This command interfaces directly with the supported MAAS power drivers. This command can be used to control the power on a machine before it has been added to MAAS, for all maas supported power drivers.  You can get power status, turn machines on or off, and cycle power.  The `maas.power --help` shows usage details, including syntax for naming each power type (consistent with other MAAS CLI commands).

<h2 id="heading--rad">IPMI BMC detection improvements (RAD)</h2>

This release adds two improvements to IPMI BMC detection capability:

1. The IPMI cipher suite ID will now be automatically detected. MAAS tries to find the most secure cipher suite available. Preference order is 17, 3, 8, 12. If detection fails MAAS will fall back to using freeipmi-tool default, 3, which is what previous versions of MAAS use.
2. The IPMI K_g BMC key will now be automatically detected if previously set. 

<h3 id="heading--rad">Reader Adaptive Documentation (RAD)</h3>

This release features Reader Adaptive Documentation, which allows you to adapt individual pages to your install method (Snap vs. Deb), version (2.7/2.8/2.9), and preferred interface (CLI/UI). 

<h2 id="heading--offline-docs">Offline documentation</h2>

This release will include offline documentation for those users whose MAAS installations reside behind firewalls, unable to access the online documentation.

<h2 id="heading--bmc-improve">BMC improvements</h2>

Three substantial improvements to BMC usage have been released:

1. IPMI, HP Moonshot, and Facebook Wedge BMC detection and configuration scripts have been migrated to the commissioning script `30-maas-01-bmc-config `.
2. BMC detection and configuration are now logged to commissioning results.
3. If BMC configuration is skipped a ScriptResult will log this result, and indicate which user chose to skip the configuration step.

<h3 id="heading--ipmi-driver">IPMI power driver upgrades</h3>

Three new configuration options have been added to the IPMI power driver:

1. K_g - The BMC Key of the IPMI device. Used to encrypt all traffic to and from the device during communication.
2. Cipher Suite ID - The cipher suite to use when communicating with the IPMI BMC. Only 3, 8, 12, and 17 are available as only those enable ciphers for authentication, integrity, and confidentiality. Defaults to 3, freeipmi-tools default. See http://fish2.com/ipmi/bp.pdf for more information.
3. Privilege Level - The IPMI privilege level to use when communicating with the BMC. Defaults to OPERATOR.

See the [2.9 UI](https://maas.io/docsv2.9 Snap#ui,/power-management#heading--ipmi) or [2.9 CLI](https://maas.io/docsv2.9 Snap#cli,/power-management#heading--ipmi) power management pages for details.

<h2 id="heading--enlistment-scripts">Improvements in enlistment scripting</h2>

Script flow and capabilities have been improved in three ways:

<ol>
<li>`maas-run-remote-scripts` can now enlist machines.</li>
<li>Enlistment `user_data` scripts have been removed.</li>
<li> The metadata endpoints `http://<MAAS>:5240/<latest or 2012-03-01>/` and `http://<MAAS>:5240/<latest or 2012-03-01>/meta-data/` are now available anonymously for use during enlistment.</li>
</ol>

<h2 id="heading--commissioning-scripts">Major improvements to commissioning script capabilities</h2>

Seven major improvements were made to commissioning script flow and capabilities:

<ol>
<li>Commissioning scripts can now send BMC configuration data</li>
<li>Commissioning scripts can now be used to configure BMC data. </li>
<li>The environment variable BMC_CONFIG_PATH is passed to serially run commissioning scripts. </li>
<li>These scripts may write BMC power credentials to BMC_CONFIG_PATH in a YAML format where each key is the power parameter. </li>
<li>If the commissioning script returns 0, it will be sent to MAAS. </li>
<li>The first script to write BMC_CONFIG_PATH is the only script that may configure the BMC, allowing you to override MAAS's builtin BMC detection.</li>
<li>All builtin commissioning scripts have been migrated into the database.</li>
</ol>

<h2 id="heading--commissioning-reorder">Commissioning script reordering</h2>

Commissioning scripts have been reordered and some are now set to run in parallel. You can now easily set a script to run before the builtin MAAS commissioning scripts. There are nine significant changes:

<ol>
<li>00-maas-03-install-lldpd -> 20-maas-01-install-lldpd</li>

<li>00-maas-05-dhcp-unconfigured-ifaces -> 20-maas-02-dhcp-unconfigured-ifaces</li>

<li>99-maas-05-kernel-cmdline -> maas -kernel-cmdline</li>

<li>00-maas-00-support-info -> maas-support-info(now runs in parallel)</li>

<li>00-maas-01-lshw -> maas-lshw(now runs in parallel)</li>

<li>00-maas-04-list-modaliases -> maas-list-modaliases(now runs in parallel)</li>

<li>00-maas-06-get-fruid-api-data -> maas-get-fruid-api-data(now runs in parallel)</li>

<li>00-maas-08-serial-ports -> maas-serial-ports(now runs in parallel)</li>

<li>99-maas-01-capture-lldp -> maas-capture-lldp(now runs in parallel)</li>
</ol>

See the [commissioning logs page](https://maas.io/docsv2.9 Snap#ui,/commissioning-logs) for more details on these changes.

<h2 id="heading--commissioning-speed">Improvements in commissioning speed and logging</h2>

Four improvements have been made to speed up the commissioning process, mostly by running scripts in parallel (see above):

<ol>
<li>Commissioning should now take 60s.</li>
<li>Logging has been added to 20-maas-01-install-lldpd  (commissioning log output).</li>
<li>Logging added to 20-maas-02-dhcp-unconfigured-ifaces (commissioning log output).</li>
<li>`user_data` can now be input directly into the UI.</li>
</ol>

<a href="#heading--bug-fixes"><h2 id="heading--bug-fixes">Bug fixes</h2></a>

<a href="#heading--bug-fixes-2-9-2"><h3 id="heading--bug-fixes-2-9-2">Bugs fixed in 2.9.2 release</h3></a>

1. In the MAAS UI, ARM servers based on the [Hi1620 ARM SoC appear as an "Unknown model"](https://bugs.launchpad.net/maas/+bug/1897946).  A fix was added to [lxd-4.11]( https://discuss.linuxcontainers.org/t/lxd-4-11-has-been-released/10135), released 2021-02-05.

2. Debian package installs of MAAS [reached an "impossible situation"](https://bugs.launchpad.net/maas/+bug/1910910) trying to install the MAAS region controller. This is caused because of an unsupported move from the transitional MAAS PPA to the latest PPA.  The workaround is to purge the MAAS packages (and the snap, if installed), and install clean with the latest PPA enabled, which will install the correct versions.

3. CentOS/RHEL 7+ ship with an unsigned version of GRUB [which breaks UEFI secure boot](https://bugs.launchpad.net/curtin/+bug/1895067).  This bug is believed to be fixed in curtin version 21.1, which is now supported by MAAS 2.9.2.

4. Debug [could not be properly enabled for MAAS snap version 2.9.1](https://bugs.launchpad.net/maas/+bug/1914588).  This has been remedied.

5. The MAAS [Backup doc article](https://maas.io/docsv2.9 Snap#ui,/backup) [was not clearly written with respect to stopping critical services](https://bugs.launchpad.net/maas/+bug/1892998).  The article has been reworked to make clear in what order steps should be performed so that services are not stopped before appropriate data has been retrieved for backup.

6. Deselecting all architectures in the Ubuntu extra architectures repo [blocks all deployments](https://bugs.launchpad.net/maas/+bug/1894116).  The default architectures have been changed to prevent this issue.

7. MAAS does not allow [FQDNs to be used in place of IPs](https://bugs.launchpad.net/maas/+bug/1911825) when a BMC extracts the address from the `power_address`.  This incorrect behaviour was changed in 2.9.2.

8. The Proxmox driver [uses a hard-coded port that cannot be customised](https://bugs.launchpad.net/maas/+bug/1914165).  This port is now customisable in 2.9.2.

<a href="#heading--bug-fixes-2-9-1"><h3 id="heading--bug-fixes-2-9-1">Bugs fixed in 2.9.1 release</h3></a>

1. It is now possible to [delete an LXD VM in an offline state](https://bugs.launchpad.net/maas/+bug/1908434).
2. MAAS now handles multiple NUMA nodes even when there are [gaps in the numbering](https://bugs.launchpad.net/maas/+bug/1910473).
3. A [snap install issue](https://bugs.launchpad.net/maas/+bug/1910909) was fixed.
4. The way MAAS handles [gateways WRT DHCP](https://bugs.launchpad.net/maas/+bug/1910909) was adjusted.
5. A majority of the document [headings have been converted to links](https://bugs.launchpad.net/maas/+bug/1900010) for easy bookmarking.

<a href="#heading--bug-fixes-2-9"><h3 id="heading--bug-fixes-2-9">Bugs fixed in 2.9 release</h3></a>

1. MAAS 2.9 includes a fix for [Bug #1894727: Admin uses cannot change other user's passwords via the UI](https://bugs.launchpad.net/maas/+bug/1894727).

<h2>MAAS 2.9.2 release notes</h2>

We have released MAAS 2.9.2, which contains two new features, and some notable [bug fixes](https://launchpad.net/maas/+milestone/2.9.2). The two new features are:

1. Proxmox driver: A driver has been added to MAAS 2.9.2 which intereacts with the Proxmox API.  Only one URL is needed, though a username and credentials are required.  Credentials can be either a password or an API token.  Note that if you use a token, you have to configure the permissions for the token.  Newly-created Proxmox tokens don't assign any permissions by default, so you must add `power on`, `power off`, and `query power` permissions to the token before using it.

2. Power driver Webhook:  A webhook was added to 2.9.2, which allows MAAS to interface with another web service that's running the power commands.  This webhook is provided for interacting with objects that MAAS does not support, that is, the MAAS team supports the driver itself, but whatever is interfacing to the driver is not supported.  This webhook as three URLs, one each for power on, power off, and power query.  Optionally, this webhook also supports a power user and password or token (RFC 6717).  This gives you a way to add your own power drivers without waiting for the driver to be added to MAAS.  There is a [video tutorial](https://discourse.maas.io/t/maas-show-and-tell-proxmox-and-webhook/3754/3) available on this new feature.

You can also find a [digest](#heading--bug-fixes-2-9-2) of the 2.9.2 bug fixes below.

<h2>MAAS 2.9.1 release notes</h2>

Building upon MAAS 2.9, we have released 2.9.1, which contains some notable [bug fixes](https://launchpad.net/maas/+milestone/2.9.1).  You can find a [digest](#heading--bug-fixes-2-9-1) of these fixes below.

<h2>MAAS 2.9 release notes</h2>

Following on from MAAS 2.8, we are happy to announce that MAAS 2.9 is now available.

#### What are the new features & fixes for MAAS 2.9 and MAAS 2.9.1?

1. [Focal Fossa (20.04) as default commissioning/deployment release](#heading--focal-default)
2. [Support for OpenVswitch bridge type](#heading--openvswitch)
3. [Support for NUMA, SR-IOV, and hugepages](#heading--numa)
4. [Improved performance for large MAAS installations](#heading--improved-perf-large-maas)
5. [New release notifications](#heading--new-release-notifications)
6. [IPMI configuration screens](#heading--ipmi-config-screens)
7. [Descriptions when marking machines broken](#heading--descrip-mark-mach-broken)
8. [Curtin 20.2 now included](#heading--curtin-20-2-included)
9. [HTTP boot disabled](#heading--http-boot-disabled)
10. [BMC/IPMI default parameter additions](#heading--bmc-param-additions)
11. [New global IPMI configuration options](#heading--new-config-options)
12. [Addition of IPMI config options to UI](#heading--global-config-settings)
13. [New MAAS CLI power command](#heading--maas-power)
14. [Commissioning speed improvements](#heading--commissioning-speed)
15. [BMC improvements](#heading--bmc-improve)
16. [IPMI power driver upgrades](#heading--ipmi-driver)
17. [Enlistment script improvements](#heading--enlistment-scripts)
18. [Commissioning script improvements](#heading--commissioning-scripts)
19. [Commissioning script reordering](#heading--commissioning-reorder)
20. [Reader Adaptive Documentation](#heading--rad)
21. [Offline documentation](#heading--offline-docs)

<h4>Six other questions you may have:</h4>

1. [What known issues should I be aware of?](#heading--known-issues)
2. [How do I install MAAS 2.9?](/t/how-to-install-maas/3323)
3. [How do I upgrade my MAAS 2.8 snap to a MAAS 2.9 snap?](/t/how-to-install-maas/3323#heading--upgrade-maas-snap)
4. [How do I install MAAS 2.9 from packages?](/t/how-to-install-maas/3329#heading--install-from-packages)
5. [How do I upgrade MAAS 2.8 to MAAS 2.9 using packages?](/t/how-to-install-maas/3329#heading--upgrade-via-packages)
6. [What bugs are fixed so far in this release?](#heading--bug-fixes)

<h2 id="heading--focal-default">Focal Fossa (Ubuntu 20.04 LTS) as default release</h2>

Ubuntu 20.04 LTS (Focal Fossa) is now the default commissioning and deployment release for new MAAS installations.  Machines deployed with Focal may now be registered as KVM hosts.

<h2 id="heading--openvswitch">Support for OpenVswitch bridge type</h2>

MAAS 2.9 allows you to create an OpenVswitch bridge type when creating a bridge.

<h2 id="heading--numa">Support for NUMA, SR-IOV, and hugepages</h2>

MAAS 2.9 adds extensive optimisation tools for using NUMA with virtual machines. You can now see how many VMs are allocated to each NUMA node, along with the allocations of cores, storage, and memory. You can quickly spot a VM running in multiple NUMA nodes, and optimise accordingly, with instant updates on pinning and allocations. You can also tell which VMs are currently running.  Using the CLI, you can also pin nodes to specific cores, and configure hugepages for use by VMs.

Specifically, there are five new features available to support NUMA, SR-IOV, and hugepages:

1. You can examine resources on a per-NUMA-node basis.
2. You can pin nodes to specific cores (CLI only).
3. You can see resources for VM hosts supporting NUMA nodes.
4. You can see the alignment between VM host interfaces and NUMA nodes.
5. You can configure and use hugepages (configurable in CLI only).

This functionality comes with an enhanced panel in the "KVM" details section:

<a href="https://discourse.maas.io/uploads/default/optimized/1X/57245bbbfe6d28e83c9b7fb30e52caf05714eb00_2_485x500.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/1X/57245bbbfe6d28e83c9b7fb30e52caf05714eb00_2_485x500.png"></a>

See the [VM hosting](/t/about-vm-hosting/2747) page for more details, and be sure to use the menu at the top of that page to select your desired build method and interface, so that you'll see the most relevant instructions.

<h2 id="heading--improved-perf-large-maas">Improved performance for large MAAS installations</h2>

MAAS 2.9 includes changes to the machine batch size that the UI loads. Previously the UI loaded machines in batches of 25; it now pulls in 25 for the first call, then 100 at a time in subsequent batches.

You can see the results of the investigation in [this video podcast](https://discourse.maas.io/t/maas-show-and-tell-improving-ui-performance-for-large-maas-installs/3515).

<h2 id="heading--new-release-notifications">New release notifications</h2>

MAAS now includes new release notifications for users and administrators.  These appear when a new release is available:

<a href="https://discourse.maas.io/uploads/default/original/1X/c4f426b9f493a970efcc59c4d948d24fa5f12860.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c4f426b9f493a970efcc59c4d948d24fa5f12860.png"></a>

Both regular and administrative users can snooze these notifications for two weeks at a time.  Administrative users can opt out of new release notifications completely, preventing notifications for any user of that MAAS.

<h2 id="heading--ipmi-config-screens">IPMI configuration screens</h2>

MAAS now includes UI panels corresponding to the [IPMI power driver upgrades](#heading--ipmi-driver) mentioned earlier:

<a href="https://discourse.maas.io/uploads/default/original/1X/433b28f5dd807caef7c7382f9a877607c2ea2dac.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/433b28f5dd807caef7c7382f9a877607c2ea2dac.png"></a>

This screen can be reached from `Settings | Configuration | Commissioning`.

<h2 id="heading--descrip-mark-mach-broken">Descriptions when marking machines broken</h2>

When marking a machine broken, a description can now be included:

<a href="https://discourse.maas.io/uploads/default/original/1X/69df48044c964d27caf59b60dcf5bf5210894c15.png?" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/69df48044c964d27caf59b60dcf5bf5210894c15.png?"></a>

This description appears in that machine's row on the machine list.

<h2 id="heading--curtin-20-2-included">Curtin 20.2 now included</h2>

A number of MAAS issues have actually been issues with an older version of Curtin.  MAAS now includes Curtin 20.2, which fixes many of these issues, including [MAAS is changing my boot order!](https://discourse.maas.io/t/maas-is-changing-my-boot-order/3491).

<h2 id="heading--http-boot-disabled">HTTP boot disabled</h2>

MAAS 2.9 disables HTTP boot. There are known issues with HTTP boot in MAAS, as well as known issues for HTTP boot with grub (e.g. https://bugs.launchpad.net/maas/+bug/1899581)  This shouldn’t affect machine boot, as machines will normally try PXE as a fallback boot method if HTTP boot fails.  Be aware, though, that machine boot will fail if the BIOS is configured to boot only over HTTP; those machines need to be reconfigured to use PXE.

<h2 id="heading--bmc-param-additions">30-maas-01-bmc-config parameter additions</h2>

Four new parameters have been added for IPMI BMC configuration.  These parameters will pull from the global defaults, eliminating the need to set the corresponding parameter in each instance.

1. maas_auto_ipmi_user - The username for the MAAS created IPMI user. Default comes from the global configuration setting.
2. maas_auto_ipmi_user_password - The password for the MAAS created IPMI user, by default a random password is generated.
3. maas_auto_ipmi_k_g_bmc_key - he IPMI K_g pre-shared encryption key to be set when adding the MAAS IPMI user. Note not all IPMI BMCs support setting the k_g key, if MAAS is unable to set the key commissioning will fail. Default comes from the global configuration setting. If an IPMI K_g key is set but the key is rejected by the BMC MAAS will automatically retry without the K_g key. This works around an edge case where some BMCs will allow you to set an K_g key but don’t allow it to be used.
4. maas_auto_ipmi_user_privilege_level - The IPMI user privilege level to use when adding the MAAS IPMI user. Possible options are USER, OPERATOR, or ADMIN. Default comes from the global configuration setting.

Note that MAAS will not capture the BMC MAC address when detecting IPMI BMCs.

<h2 id="heading--new-config-options">New global IPMI configuration options</h2>

Two new global IPMI configuration options have been added:

1. maas_auto_ipmi_k_g_bmc_key - sets a global default IPMI BMC key.
2. maas_auto_ipmi_user_privilege_level - sets a global default IPMI BMC user privilege level.
    
<h2 id="heading--global-config-settings">Addition of IPMI config options to UI</h2>

You may now set the global configuration options `maas_auto_ipmi_user`, `maas_auto_ipmi_k_g_bmc_key`, and `maas_auto_ipmi_user_privilege_level` on the "Settings" page in the UI under "Commissioning."

<h2 id="heading--maas-power">New maas.power CLI command</h2>

Available in all MAAS 2.9 releases is the new `maas.power` CLI command. This command interfaces directly with the supported MAAS power drivers. This command can be used to control the power on a machine before it has been added to MAAS, for all maas supported power drivers.  You can get power status, turn machines on or off, and cycle power.  The `maas.power --help` shows usage details, including syntax for naming each power type (consistent with other MAAS CLI commands).

<h2 id="heading--rad">IPMI BMC detection improvements (RAD)</h2>

This release adds two improvements to IPMI BMC detection capability:

1. The IPMI cipher suite ID will now be automatically detected. MAAS tries to find the most secure cipher suite available. Preference order is 17, 3, 8, 12. If detection fails MAAS will fall back to using freeipmi-tool default, 3, which is what previous versions of MAAS use.
2. The IPMI K_g BMC key will now be automatically detected if previously set. 

<h3 id="heading--rad">Reader Adaptive Documentation (RAD)</h3>

This release features Reader Adaptive Documentation, which allows you to adapt individual pages to your install method (Snap vs. Deb), version (2.7/2.8/2.9), and preferred interface (CLI/UI). 

<h2 id="heading--offline-docs">Offline documentation</h2>

This release will include offline documentation for those users whose MAAS installations reside behind firewalls, unable to access the online documentation.

<h2 id="heading--bmc-improve">BMC improvements</h2>

Three substantial improvements to BMC usage have been released:

1. IPMI, HP Moonshot, and Facebook Wedge BMC detection and configuration scripts have been migrated to the commissioning script `30-maas-01-bmc-config `.
2. BMC detection and configuration are now logged to commissioning results.
3. If BMC configuration is skipped a ScriptResult will log this result, and indicate which user chose to skip the configuration step.

<h3 id="heading--ipmi-driver">IPMI power driver upgrades</h3>

Three new configuration options have been added to the IPMI power driver:

1. K_g - The BMC Key of the IPMI device. Used to encrypt all traffic to and from the device during communication.
2. Cipher Suite ID - The cipher suite to use when communicating with the IPMI BMC. Only 3, 8, 12, and 17 are available as only those enable ciphers for authentication, integrity, and confidentiality. Defaults to 3, freeipmi-tools default. See http://fish2.com/ipmi/bp.pdf for more information.
3. Privilege Level - The IPMI privilege level to use when communicating with the BMC. Defaults to OPERATOR.

See the [2.9 UI](https://maas.io/docsv2.9 Snap#ui,/power-management#heading--ipmi) or [2.9 CLI](https://maas.io/docsv2.9 Snap#cli,/power-management#heading--ipmi) power management pages for details.

<h2 id="heading--enlistment-scripts">Improvements in enlistment scripting</h2>

Script flow and capabilities have been improved in three ways:

<ol>
<li>`maas-run-remote-scripts` can now enlist machines.</li>
<li>Enlistment `user_data` scripts have been removed.</li>
<li> The metadata endpoints `http://<MAAS>:5240/<latest or 2012-03-01>/` and `http://<MAAS>:5240/<latest or 2012-03-01>/meta-data/` are now available anonymously for use during enlistment.</li>
</ol>

<h2 id="heading--commissioning-scripts">Major improvements to commissioning script capabilities</h2>

Seven major improvements were made to commissioning script flow and capabilities:

<ol>
<li>Commissioning scripts can now send BMC configuration data</li>
<li>Commissioning scripts can now be used to configure BMC data. </li>
<li>The environment variable BMC_CONFIG_PATH is passed to serially run commissioning scripts. </li>
<li>These scripts may write BMC power credentials to BMC_CONFIG_PATH in a YAML format where each key is the power parameter. </li>
<li>If the commissioning script returns 0, it will be sent to MAAS. </li>
<li>The first script to write BMC_CONFIG_PATH is the only script that may configure the BMC, allowing you to override MAAS's builtin BMC detection.</li>
<li>All builtin commissioning scripts have been migrated into the database.</li>
</ol>

<h2 id="heading--commissioning-reorder">Commissioning script reordering</h2>

Commissioning scripts have been reordered and some are now set to run in parallel. You can now easily set a script to run before the builtin MAAS commissioning scripts. There are nine significant changes:

<ol>
<li>00-maas-03-install-lldpd -> 20-maas-01-install-lldpd</li>

<li>00-maas-05-dhcp-unconfigured-ifaces -> 20-maas-02-dhcp-unconfigured-ifaces</li>

<li>99-maas-05-kernel-cmdline -> maas -kernel-cmdline</li>

<li>00-maas-00-support-info -> maas-support-info(now runs in parallel)</li>

<li>00-maas-01-lshw -> maas-lshw(now runs in parallel)</li>

<li>00-maas-04-list-modaliases -> maas-list-modaliases(now runs in parallel)</li>

<li>00-maas-06-get-fruid-api-data -> maas-get-fruid-api-data(now runs in parallel)</li>

<li>00-maas-08-serial-ports -> maas-serial-ports(now runs in parallel)</li>

<li>99-maas-01-capture-lldp -> maas-capture-lldp(now runs in parallel)</li>
</ol>

See the [commissioning logs page](https://maas.io/docsv2.9 Snap#ui,/commissioning-logs) for more details on these changes.

<h2 id="heading--commissioning-speed">Improvements in commissioning speed and logging</h2>

Four improvements have been made to speed up the commissioning process, mostly by running scripts in parallel (see above):

<ol>
<li>Commissioning should now take 60s.</li>
<li>Logging has been added to 20-maas-01-install-lldpd  (commissioning log output).</li>
<li>Logging added to 20-maas-02-dhcp-unconfigured-ifaces (commissioning log output).</li>
<li>`user_data` can now be input directly into the UI.</li>
</ol>

<a href="#heading--bug-fixes"><h2 id="heading--bug-fixes">Bug fixes</h2></a>

<a href="#heading--bug-fixes-2-9-2"><h3 id="heading--bug-fixes-2-9-2">Bugs fixed in 2.9.2 release</h3></a>

1. In the MAAS UI, ARM servers based on the [Hi1620 ARM SoC appear as an "Unknown model"](https://bugs.launchpad.net/maas/+bug/1897946).  A fix was added to [lxd-4.11]( https://discuss.linuxcontainers.org/t/lxd-4-11-has-been-released/10135), released 2021-02-05.

2. Debian package installs of MAAS [reached an "impossible situation"](https://bugs.launchpad.net/maas/+bug/1910910) trying to install the MAAS region controller. This is caused because of an unsupported move from the transitional MAAS PPA to the latest PPA.  The workaround is to purge the MAAS packages (and the snap, if installed), and install clean with the latest PPA enabled, which will install the correct versions.

3. CentOS/RHEL 7+ ship with an unsigned version of GRUB [which breaks UEFI secure boot](https://bugs.launchpad.net/curtin/+bug/1895067).  This bug is believed to be fixed in curtin version 21.1, which is now supported by MAAS 2.9.2.

4. Debug [could not be properly enabled for MAAS snap version 2.9.1](https://bugs.launchpad.net/maas/+bug/1914588).  This has been remedied.

5. The MAAS [Backup doc article](https://maas.io/docsv2.9 Snap#ui,/backup) [was not clearly written with respect to stopping critical services](https://bugs.launchpad.net/maas/+bug/1892998).  The article has been reworked to make clear in what order steps should be performed so that services are not stopped before appropriate data has been retrieved for backup.

6. Deselecting all architectures in the Ubuntu extra architectures repo [blocks all deployments](https://bugs.launchpad.net/maas/+bug/1894116).  The default architectures have been changed to prevent this issue.

7. MAAS does not allow [FQDNs to be used in place of IPs](https://bugs.launchpad.net/maas/+bug/1911825) when a BMC extracts the address from the `power_address`.  This incorrect behaviour was changed in 2.9.2.

8. The Proxmox driver [uses a hard-coded port that cannot be customised](https://bugs.launchpad.net/maas/+bug/1914165).  This port is now customisable in 2.9.2.

<a href="#heading--bug-fixes-2-9-1"><h3 id="heading--bug-fixes-2-9-1">Bugs fixed in 2.9.1 release</h3></a>

1. It is now possible to [delete an LXD VM in an offline state](https://bugs.launchpad.net/maas/+bug/1908434).
2. MAAS now handles multiple NUMA nodes even when there are [gaps in the numbering](https://bugs.launchpad.net/maas/+bug/1910473).
3. A [snap install issue](https://bugs.launchpad.net/maas/+bug/1910909) was fixed.
4. The way MAAS handles [gateways WRT DHCP](https://bugs.launchpad.net/maas/+bug/1910909) was adjusted.
5. A majority of the document [headings have been converted to links](https://bugs.launchpad.net/maas/+bug/1900010) for easy bookmarking.

<a href="#heading--bug-fixes-2-9"><h3 id="heading--bug-fixes-2-9">Bugs fixed in 2.9 release</h3></a>

1. MAAS 2.9 includes a fix for [Bug #1894727: Admin uses cannot change other user's passwords via the UI](https://bugs.launchpad.net/maas/+bug/1894727).

<h2 id="heading--known-issues">Known issues</h2>

### RAD LHS menu

There is a known issue with the Reader Adaptive Documentation left-hand-side menu (navigation), in that the menu links cannot currently be adapted to the RAD parameters.  This means that selecting a different page in the LHS menu will take you the the RAD for the current recommended version.  Every page that is different in RAD, though, should present you with a top menu, so that you can choose the RAD parameters matching your own preferences.

### Erroneous message about "missing migration"

When upgrading to any release above 2.8, using packages, you may receive a warning about missing migration(s) -- specifically something that looks like this:

```
Setting up maas-common (2.8.3~rc1-8583-g.9ddc8051f-0ubuntu1~18.04.1) ...
Setting up maas-region-api (2.8.3~rc1-8583-g.9ddc8051f-0ubuntu1~18.04.1) ...
Setting up maas-region-controller (2.8.3~rc1-8583-g.9ddc8051f-0ubuntu1~18.04.1) ...
Operations to perform:
  Apply all migrations: auth, contenttypes, maasserver, metadataserver, piston3, sessions, sites
Running migrations:
  No migrations to apply.
  Your models have changes that are not yet reflected in a migration, and so won't be applied.
  Run 'manage.py makemigrations' to make new migrations, and then re-run 'manage.py migrate' to apply them.
```

This warning message has no effect on the installation or operation of MAAS, so it can be safely ignored.
[/tab]
[/tabs]
