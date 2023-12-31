<!-- "What is new with MAAS 3.1" -->

We are happy to announce that MAAS 3.1 is now available. This release provides new features and critical bug fixes.

<a href="#heading--cumulative-summary"><h3 id="heading--cumulative-summary">Cumulative summary of MAAS 3.1 features and fixes</h3></a>

- [Support for LXD clusters](#heading--lxd-clusters): MAAS 3.1 can use LXD clusters with MAAS KVMs.
 
- [Improved image sync performance](#heading--image-sync-performance): After images are downloaded, rack controllers sync new images more quickly.
 
- [Ability to enlist deployed machines](#heading--enlist-deployed-machines): Users can enlist deployed machines, a top feature poll request.

- [Static Ubuntu image upload and reuse](#heading--static-ubuntu-images): Users can upload, deploy and reuse a bootable ubuntu image

- [Machine configuration cloning UI](#heading--machine-cloning-ui): We have extended machine cloning to the UI.

- [LXD authentication UX improvements](#heading--lxd-auth-ux-improvements): LXD certificates are easier to use.

- [MAAS 3.1 cumulative bug fixes](#heading--maas-3-1-cumulative-bug-fixes)

Critical and high-priority fixes also extend or repair MAAS features:

- [Expanded proxies](https://bugs.launchpad.net/maas/+bug/1867394)`↗`: Some proxies require authentication; MAAS now respects peer proxy username and password

- [Accurate storage pool sizes](https://bugs.launchpad.net/bugs/1949410)`↗`: The UI now calculates storage pool sizes correctly for CEPH pools; shared pools are no longer stacked

- [Refresh wipeout bug](https://bugs.launchpad.net/bugs/1949485)`↗`: MAAS does not destroy existing VMs on a refresh, or when the memory overcommit ratio is changed
 
- [Cloning issue fixed](https://bugs.launchpad.net/bugs/1948500)`↗`: UI cloning has been repaired to prevent "unsuccessful cloning" of storage

<a href="#heading--installing-3-1-0"><h3 id="heading--installing-3-1-0">How to install MAAS 3.1</h3></a>

MAAS 3.1 can be installed fresh from snaps (recommended) with:

```
sudo snap install --channel=3.1 maas
```

MAAS 3.1 can also be installed via packages, by adding the `3.1` PPA:

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

<a href="#heading--Ten-words-or-fewer"><h4 id="heading--Ten-words-or-fewer">Ten words or fewer</h4></a>

Users can enlist deployed machines, a top feature poll request.

<a href="#heading--About-this-feature"><h4 id="heading--About-this-feature">About this feature</h4></a>

When adding machines to MAAS, MAAS (non-destructively) boots them into an ephemeral environment to gather hardware information.  Previously, this didn't work for deployed machines, since you don't want to disrupt deployed workloads or mark deployed machines as ready.

Now you may add deployed machines, without normal commissioning process or relabelling the machine. In order to update the information, a script is provided to run minimal commissioning scripts and update to MAAS.

<a href="#heading--How-to-enlist-a-machine-that’s-already-running-a-workload"><h4 id="heading--How-to-enlist-a-machine-that’s-already-running-a-workload">How to enlist a machine that’s already running a workload</h4></a>

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

<a href="#heading--How-to-update-hardware-information-for-a-deployed-machine"><h4 id="heading--How-to-update-hardware-information-for-a-deployed-machine">How to update hardware information for a deployed machine</h4></a>

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

<a href="#heading--Ten-words-or-fewer"><h4 id="heading--Ten-words-or-fewer">Ten words or fewer</h4></a>

Users can upload, deploy and reuse a bootable ubuntu image

<a href="#heading--About-this-feature"><h4 id="heading--About-this-feature">About this feature</h4></a>

MAAS supports deploying custom OS images.  Canonical provides both [lp:maas-image-builder](https://launchpad.net/maas-image-builder)`↗` and [gh:canonical/packer-maas](https://github.com/canonical/packer-maas)`↗` to create custom images. With 3.1, these custom images can include static Ubuntu images, created with whatever tool you choose, deployed as described below. Canonical still suggests customising Ubuntu using cloud-init user_data or Curtin preseed data, if possible.

<a href="#heading--About-static-Ubuntu-images"><h4 id="heading--About-static-Ubuntu-images">About static Ubuntu images</h4></a>

MAAS allows you to build an Ubuntu image to deploy with MAAS, using any chosen image-building tool.  You can create the image with a fixed configuration and deploy it to many machines.  This fixed configuration can contain anything a normal image would contain: users, packages, etc.

<a href="#heading--About-uploading-hand-built-Ubuntu-images"><h4 id="heading--About-uploading-hand-built-Ubuntu-images">About uploading hand-built Ubuntu images</h4></a>

You can upload and deploy hand-built Ubuntu images, containing kernel, bootloader, and fixed configuration.  The image can be built by tool, e.g., [packer](https://github.com/canonical/packer-maas)`↗`, or by scripts. You can upload these images to the boot-resources endpoint, where they will be available for deployment.

The minimum image must contain a kernel, bootloader, and `/curtin/curtin-hooks` script that configures the network. Samples can be found in the [packer-maas repos](https://github.com/canonical/packer-maas/tree/master/ubuntu/scripts)`↗`. The image must be in raw img file format so MAAS will accept the upload.  When built, you will upload this img file to the boot-resources endpoint, specifying the image architecture.

<a href="#heading--About-how-MAAS-handles-these-images"><h4 id="heading--About-how-MAAS-handles-these-images">About how MAAS handles these images</h4></a>

MAAS will save the image as a `tar.gz` file in the database.  MAAS can differentiate between image types and generate appropriate pre-seed configurations.  MAAS also recognises the base Ubuntu version, so it can apply the correct ephemeral OS for installation.  Custom images are always deployed with the ephemeral OS, where the `base_image` field indicates the appropriate ephemeral version to avoid errors, ensuring smooth deployment later.

<a href="#heading--About-how-MAAS-boots-these-images"><h4 id="heading--About-how-MAAS-boots-these-images">About how MAAS boots these images</h4></a>

When you deploy a machine with your custom image, MAAS ensures that the machine receives the kernel, bootloader and root file system provided in the image. The initial boot loader then boots an ephemeral OS matching the Ubuntu version of the custom image, reducing compatibility issues.  Curtin then writes your entire custom image to disk, after which it is not modified by MAAS.

Note that custom non-Ubuntu images still use a standard Ubuntu ephemeral OS to boot.

<a href="#heading--About-configuring-deployed-machine-networking"><h4 id="heading--About-configuring-deployed-machine-networking">About configuring deployed machine networking</h4></a>

If you deploy a machine with a custom Ubuntu image, MAAS allows you to configure the deployed machine's networks just like any other MAAS machine.  If you create an interface and assign it to a subnet or static address, this will be reflected in the deployed machine.

For this reason, MAAS also does some initial diagnostics while installing the custom image.  MAAS will warn you about a missing network configuration, by checking for `cloud-init` and `netplan` in the `curtin` images. MAAS won't deploy machine with such images.

<a href="#heading--About-configuring-deployed-machine-storage"><h4 id="heading--About-configuring-deployed-machine-storage">About configuring deployed machine storage</h4></a>

If you deploy a machine with a custom Ubuntu image, you will also want to be able to configure storage, just like any other machine.  MAAS facilitates changes to the storage configuration, such as resizing `/root`, attaching and formatting block devices, etc.

<a href="#heading--About-static-image-metrics"><h4 id="heading--About-static-image-metrics">About static image metrics</h4></a>

As a user, you want to track of deployed static images. The standard MAAS dashboard now reflects these metrics.

<a href="#heading--How-to-upload-a-custom-Ubuntu-image"><h4 id="heading--How-to-upload-a-custom-Ubuntu-image">How to upload a custom Ubuntu image</h4></a>

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

<a href="#heading--Ten-words-or-fewer"><h4 id="heading--Ten-words-or-fewer">Ten words or fewer</h4></a>

Extend machine cloning to UI, moving toward machine profile templates.

<a href="#heading--About-this-feature-"><h4 id="heading--About-this-feature-">About this feature </h4></a>

MAAS 3.1 allows you to quickly clone or copy a configuration between machines, via the MAAS UI -- a step towards machine templating. 

Creating a machine profile is repetitive. We've learned that most users create multiple machines of the same configuration in batches. Some users loop a template through the API, while others rely on scripts. MAAS API cloning functionality is now being exposed in the UI.

<a href="#heading--About-copying-machine-configurations"><h4 id="heading--About-copying-machine-configurations">About copying machine configurations</h4></a>

As a MAAS user, you may want to copy a machine configuration to multiple existing machines. Assuming that at least one machine is already configured, you should be able to apply these settings to a list of machines.  This means that a user should be able to:

 - select the source machine to copy from.
 - validate that the source machine exists.
 - select at least 1 destination machine.
 - validate that the destination machine(s) exist.
 - edit the source machine or destination machines, if needed.
 - know at all times which machines are affected.
 - see the cloned machines when cloning is successful, or
 - get clear failure information, if cloning fails. 

<a href="#heading--About-choosing-configuration-items-to-copy"><h4 id="heading--About-choosing-configuration-items-to-copy">About choosing configuration items to copy</h4></a>

As a MAAS user, you likely want to select whether storage, network, or both configurations should be cloned. The cloning API allows users to choose interfaces and storage separately.  Thus, this new feature also allows you to:

 - clone only the interface (network) configuration.
 - clone only the storage configuration.
 - clone both configurations.

<a href="#heading--About-cloning-restrictions"><h4 id="heading--About-cloning-restrictions">About cloning restrictions</h4></a>

In order for cloning to succeed, a few restrictions must be met:

1. The destination interface names must be the same source.
2. The destination drive must be equal to or larger than the source drive.
3. For static IPs, a new IP will be allocated to the interface on the destination machine

<a href="#heading--How-to-clone-a-machine-from-the-UI"><h4 id="heading--How-to-clone-a-machine-from-the-UI">How to clone a machine from the UI</h4></a>

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

<a href="#heading--Ten-words-or-fewer"><h4 id="heading--Ten-words-or-fewer">Ten words or fewer</h4></a>

Easier MAAS to LXD connection that uses certificates for authentication.

<a href="#heading--About-this-feature"><h4 id="heading--About-this-feature">About this feature</h4></a>

MAAS 3.1 provides a smoother experience when connecting an existing LXD server to MAAS, guiding the user through manual steps and providing increased connection security with use of certificates. Currently, each MAAS region/rack controller has its own certificate. To add a LXD VM host to MAAS, the user needs to either add the certificate for each controller that can reach the LXD server to the trust list in LXD, or use the trust_password (in which case the controller talking to LXD will automatically add its certificate to the trust).

This doesn’t provide a great user experience, as the former process is cumbersome, and the latter is not suggested for production use for security reasons.  To improve this, MAAS 3.1 manages per-LXD keys/certificates, and provide a way for users to get the content of certificates, to authorise MAAS in LXD.

<a href="#heading--About-on-the-spot-certificate-creation"><h4 id="heading--About-on-the-spot-certificate-creation">About on-the-spot certificate creation</h4></a>

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

<a href="#heading--About-bringing-your-own-certificates"><h4 id="heading--About-bringing-your-own-certificates">About bringing your own certificates</h4></a>

As a MAAS user, you may want to register a LXD host into MAAS by providing a private key for a certificate that’s already trusted by the LXD server.  For example, you may already have set up certificates in the server trust for MAAS to use, MAAS should provide a way to import it, instead of generating a new one.

With MAAS 3.1, it’s possible to import an existing key/certificate pair for use with a LXD server when registering it with MAAS.  MAAS stores the key/certificate instead of generating new ones.

[note]
The imported key must not have a passphrase; otherwise, MAAS will not be able to use it.
[/note]

<a href="#heading--How-to-get-started"><h4 id="heading--How-to-get-started">How to get started</h4></a>

Suppose that you're creating a new LXD KVM, beginning from the top tab in MAAS:

<a href="https://discourse.maas.io/uploads/default/optimized/2X/b/b7048c83a7d6e4dbca69a060a7b4bf8bc07e1953_2_690x165.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/2X/b/b7048c83a7d6e4dbca69a060a7b4bf8bc07e1953_2_690x165.png"></a>

Select "Add KVM", which brings you to the definition screen:

<a href="https://discourse.maas.io/uploads/default/optimized/2X/8/806d3577b11ed415574fd06de5f643f26ffb7928_2_690x257.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/2X/8/806d3577b11ed415574fd06de5f643f26ffb7928_2_690x257.png"></a>

From here, you'll continue by choosing your authentication method.

<a href="#heading--How-to-let-MAAS-create-a-certificate-for-you"><h4 id="heading--How-to-let-MAAS-create-a-certificate-for-you">How to let MAAS create a certificate for you</h4></a>

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

<a href="#heading--How-to-use-your-own,-existing-certificate"><h4 id="heading--How-to-use-your-own,-existing-certificate">How to use your own, existing certificate</h4></a>

Suppose that, after identifying your LXD KVM, you choose "Provide certificate and private key".  When you do so, the screen will extend to allow you to upload these items:

<a href="https://discourse.maas.io/uploads/default/optimized/2X/a/ad3f6fd06fdef3ce5be467816b2fc3667550f397_2_690x204.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/optimized/2X/a/ad3f6fd06fdef3ce5be467816b2fc3667550f397_2_690x204.png"></a>

Paste or upload your certificate and private key, then click "Next" to validate your authentication criteria, before continuing through the normal LXD KVM creation process.  If your certificate and/or key aren't usable for some reason, MAAS will return an error (in this case, the private key was entered as gibberish, to produce an error output):

<a href="https://discourse.maas.io/uploads/default/original/2X/2/286e648de20c9db3bb6c56c5855647c23a5d9e2e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/2/286e648de20c9db3bb6c56c5855647c23a5d9e2e.png"></a>

<a href="#heading--image-sync-performance"><h3 id="heading--image-sync-performance">Improved image sync performance</h3></a>

<a href="#heading--Ten-words-or-fewer"><h4 id="heading--Ten-words-or-fewer">Ten words or fewer</h4></a>

After downloading images, the rack controller syncs them much faster.

<a href="#heading--About-this-feature"><h4 id="heading--About-this-feature">About this feature</h4></a>

Downloading and syncing images is a known delay element in MAAS.  While images aren't small, and do take some time to download, we decided to try to speed up the process as much as possible.  After the region has downloaded new images, the rack controllers are now much quicker at syncing the new images.

<a href="#heading--How-to-take-advantage-of-this-new-feature"><h4 id="heading--How-to-take-advantage-of-this-new-feature">How to take advantage of this new feature</h4></a>

There is nothing required of our users to experience this improved sync performance, other than upgrading to 3.1.

<a href="#heading--maas-3-1-cumulative-bug-fixes"><h3 id="heading--maas-3-1-cumulative-bug-fixes">MAAS 3.1 cumulative bug fixes</h3></a>

MAAS 3.1 bug fixes can be found in the following milestones:

- [MAAS 3.1 Beta5 bug fixes](https://launchpad.net/maas/+milestone/3.1.0-beta5)`↗`
- [MAAS 3.1 Beta4 bug fixes](https://launchpad.net/maas/+milestone/3.1.0-beta4)`↗`
- [MAAS 3.1 Beta3 bug fixes](https://launchpad.net/maas/+milestone/3.1.0-beta3)`↗`
- [MAAS 3.1 Beta2 bug fixes](https://launchpad.net/maas/+milestone/3.1.0-beta2)`↗`
- [MAAS 3.1 Beta1 bug fixes](https://launchpad.net/maas/+milestone/3.1.0-beta1)`↗`
