<!-- Create custom images -->
Custom OS image creation is often viewed as a complex task, but with `packer-maas`, the process can be simplified significantly. The `packer-maas` tool provides a robust interface for creating and deploying custom Ubuntu images on MAAS. With `packer-maas`, you can easily create and customize your own Ubuntu images with just a few simple commands.

Creating a custom Ubuntu image with `packer-maas` is a straightforward process. With `packer-maas`, you can create a new image from scratch or use an existing Ubuntu image as a base. You can then customize the image with any software packages, configuration files, or other modifications that you require. By simplifying the process of image creation and deployment, `packer-maas` makes it relatively easy to create customized images (Ubuntu and others) that meet your requirements.

Let's walk through the process, using a simple example, to get comfortable with the process.

<a href="#heading--install-maas"><h2 id="heading--install-maas">First, install MAAS</h2></a>

If we're going to create custom images for MAAS, then first, we'll need MAAS!  You can use [these instructions](/t/how-to-do-a-fresh-install-of-maas/5128) to accomplish that, and get a feel for MAAS while you're at it.

<a href="#heading--install-packer"><h2 id="heading--install-packer">Install packer</h2></a>

The next step is to install the tool `packer`, which will do the heavy lifting for us.  Packer is easily installed from its Debian package:

```nohighlight
sudo apt install packer
```

This should install with no additional prompts.

<a href="#heading--install-dependencies"><h2 id="heading--install-dependencies">Install dependencies</h2></a>

We're going to create a "custom" Ubuntu image for this build, so we'll want to install a few dependencies.  Enter the following commands.  Don't worry about any output between commands:

```nohighlight
sudo apt install qemu-utils
sudo apt install qemu-system
sudo apt install ovmf
sudo apt install cloud-image-utils
```

<a href="#heading--get-the-packer-templates"><h2 id="heading--get-the-packer-templates">Get the packer templates</h2></a>

Packer uses "templates", which are very much like scripts that build your custom image.  You can obtain the packer templates by cloning the [packer-maas github repository](https://github.com/canonical/packer-maas.git)`↗`, like this:

```nohighlight
cd ~
mkdir -p tmp/git
cd tmp/git
git clone https://github.com/canonical/packer-maas.git
```

Make sure to pay attention to where the repository is cloned, in this case, `tmp/git` in your home directory.  The packer template in this cloned repository creates a Ubuntu AMD64 image for use with MAAS.

<a href="#heading--build-an-image"><h2 id="heading--build-an-image">Build an Ubuntu image</h2></a>

Now that we have that, let's build a custom Ubuntu image that we can deploy with MAAS.  Use these commands to do that:

```nohighlight
cd ~/tmp/git/packer-maas/ubuntu
make custom-ubuntu-lvm.dd.gz
```

This `make` will run for a couple of minutes before attempting to boot the image.  While waiting for the image to boot, you will see terminal messages similar to this one for upwards of three to five minutes:

```nohighlight
2022/05/09 15:50:46 packer-builder-qemu plugin: [DEBUG] handshaking with SSH
2022/05/09 15:50:50 packer-builder-qemu plugin: [DEBUG] SSH handshake err: ssh: handshake failed: ssh: unable to authenticate, attempted methods [none password], no supported methods remain
2022/05/09 15:50:50 packer-builder-qemu plugin: [DEBUG] Detected authentication error. Increasing handshake attempts.
```

That's expected.  Eventually, you should see a successful SSH connection:

```nohighlight
2022/05/09 15:50:57 packer-builder-qemu plugin: [INFO] Attempting SSH connection to 127.0.0.1:2351...
2022/05/09 15:50:57 packer-builder-qemu plugin: [DEBUG] reconnecting to TCP connection for SSH
2022/05/09 15:50:57 packer-builder-qemu plugin: [DEBUG] handshaking with SSH
2022/05/09 15:51:17 packer-builder-qemu plugin: [DEBUG] handshake complete!
```

After this, a few more commands will run.  Eventually the terminal screen will clear and show just one line, as follows:

```nohighlight
rm OVMF_VARS.fd
```

That means you've successfully built the image!  Just to prove it to ourselves, let's take a couple of additional steps.

<a href="#heading--validate-the-build"><h2 id="heading--validate-the-build">Validate the build</h2></a>

You can check the validity of the operation with a simple `ls` command in `~/tmp/git/packer-maas/ubuntu` (where you ran the `make` command), like this:

```nohighlight
stormrider@neuromancer:~/mnt/Dropbox/src/git/packer-maas/ubuntu$ ls
custom-ubuntu-lvm.dd.gz  packages      seeds-lvm.iso     user-data-lvm
http                     packer_cache  ubuntu-flat.json
Makefile                 README.md     ubuntu-lvm.json
meta-data                scripts       user-data-flat
```

See the `custom-ubuntu-lvm.dd.gz` file?  That's our image, ready to try out.

<a href="#heading--upload-to-maas"><h2 id="heading--upload-to-maas">Upload the image to MAAS</h2></a>

You can upload your newly-created image with the following command:

```nohighlight
$ maas admin boot-resources create \
    name='custom/ubuntu-raw' \
    title='Ubuntu Custom RAW' \
    architecture='amd64/generic' \
    filetype='ddgz' \
    content@=custom-ubuntu-lvm.dd.gz
```

<a href="#heading--deploy-your-image"><h2 id="heading--deploy-your-image">Deploy the image in MAAS</h2></a>

What good is an image if we can't deploy it?  Pick one of the VMs you created in the [last tutorial](/t/try-out-the-maas-cli/5236) and deploy your new OS image to it.  Then use a command like this one to see it running:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "OS", "DISTRO"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-",
.osystem, .distro_series]) | @tsv' | column -t

HOSTNAME     SYSID   POWER  STATUS    OWNER  OS      DISTRO
--------     -----   -----  ------    -----  --      ------
valued-moth  e86c7h  on     Deployed  admin  ubuntu  focal
open-gannet  nk7x8y  on     Deployed  admin  custom  ubuntu-raw
```

It's the machine named `open-gannet` in the listing above, but your machine name and $SYSID will be unique to your instance.

<a href="#heading--thats-all-there-is-to-it"><h2 id="heading--thats-all-there-is-to-it">That's all there is to it!</h2></a>

In a few simple steps, you've used packer to create a custom Ubuntu image, upload it to a running MAAS, and deploy it.  There are many different custom images that can be deployed with MAAS -- check [this guide](/t/how-to-customise-images/5104) to learn more.
