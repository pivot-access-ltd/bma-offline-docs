## About static Ubuntu images

MAAS provides the capability for you to build an Ubuntu OS image to
deploy with MAAS, using any image-building method you choose.  You can
create the image once, with a fixed configuration,and deploy it to
many machines.  This fixed configuration can consist of anything that
a normal image would contain: users, packages, etc.

### About uploading hand-built Ubuntu images

You can upload hand-built Ubuntu images, containing a kernel,
bootloader, and a fixed configuration, for deployment to multiple
machines.  The image can be build via a tool, such as packer, or build
with scripts. You can upload these images to the boot-resources
endpoint, where it will then be available for deployment to machines.

At a minimum, this image must contain a kernel and a bootloader. The
image must be in raw img file format, since that is the format MAAS
accepts for upload.  This is the most portable format, and the format
most builders support. Upon completing the image build, you will
upload this img file to the boot-resources endpoint, specifying the
architecture for the image.

### About how MAAS handles these images

MAAS will save the image -- in the same way it would save a `tar.gz`
file -- in the database.  MAAS can differentiate between custom Ubuntu
images and custom non-Ubuntu images, generating appropriate pre-seed
configurations for each image type.

MAAS will also recognise the base Ubuntu version, so it can apply the
correct ephemeral OS version for installation.  This ensures a smooth
deployment later.

### About how MAAS boots these images

When you decide to deploy a machine with your uploaded, custom image,
MAAS ensures that the machine receives the kernel, bootloader and root
file system provided in the image. The initial boot loader takes over,
and boots an ephemeral OS of the same Ubuntu version as the custom
image, to reduce the chances of incompatibilities.  Curtin then writes
your entire custom image to disk.  Once the custom image is written to
disk, it is not modified by MAAS.

Note that custom non-Ubuntu images still use a standard Ubuntu
ephemeral OS to boot, prior to installing the non-Ubuntu OS.

### About configuring deployed machine networking

If you deploy a machine with a custom Ubuntu image, MAAS allows you to
configure the deployed machine's networks just like you would for any
other MAAS machine.  If you create an interface and assign it to a
subnet or static address, this will be reflected in the deployed
machine.

For this reason, MAAS also does some initial diagnostics while
installing the custom image.  MAAS will detect when a network
configuration is not present and abort the installation with a
warning.  Essentially, MAAS checks to be sure that `cloud-init` and
`netplan` are present in the images written by `curtin`.  If not, MAAS
won't deploy the machine with the image.

### About configuring deployed machine storage

If you deploy a machine with a custom Ubuntu image, you will also want
to be able to configure storage, just like you would do with any other
machine.  MAAS facilitates changes to the storage configuration.  You
can resize the root partition, as well as attaching and formatting any
additional block devices you may desire.

### About static image metrics

As a user, you want to keep track of how many static images are being
used, and how many deployed machines are using static images.  The
standard MAAS dashboard reflects both of these metrics.

## How to upload a custom Ubuntu image

Currently, custom Ubuntu images can be uploaded using the MAAS CLI,
by creating a boot-resource, with a command similar to this one:

```nohighlight                                                            	 
maas $PROFILE boot-resources create \
   name='custom/ubuntu-custom'  \
   architecture=amd64/generic \
   title=’custom ubuntu’ \
   base_image=ubuntu/focal \
   content@=./custom-ubuntu.img
 ```	 

 When uploading a custom image, there is a new required field:
`base_image`. This is not required for non-custom images to be
uploaded, but any image with the `custom` prefix will require it.
