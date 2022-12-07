<!-- "How to use standard images" -->
MAAS is only useful once it has images available to provision its nodes. Therefore, one key post-install task is to select and import images from the boot source. Once MAAS imports images, it will update them on an hourly basis, via a default sync mechanism.  This page explains how to select and import the images that MAAS requires to provision its nodes.

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]

This article will help you learn:

- [How to use image streams](#heading--maas-image-streams)
- [How to import standard images from maas.io](#heading--import-maasio-image-ui)
- [How to use other image mirrors to download images](#heading--image-mirrors)
- [How to import and provision non-Ubuntu images](#heading--other-images)

Note that it is possible to build your own images in a limited sense: see [MAAS Image Builder](/t/how-to-create-custom-images/5104#heading--how-to-build-maas-images).

<a href="#heading--maas-image-streams"><h2 id="heading--maas-image-streams">How to use MAAS image streams</h2></a>

Canonical provides two SimpleStreams for MAAS images: candidate and stable. Both streams contain Ubuntu images, CentOS images, bootloaders extracted from the Ubuntu archive, and release notifications. Either stream can be used in any version of MAAS greater than 2.1 -- but not all images are supported in older versions.

This subsection will help you learn:

- [About the candidate stream](#heading--candidate-stream)
- [About the stable stream](#heading--stable-stream)
- [About the retired daily stream](#heading--daily-stream)
- [How to change the stream with the UI](#heading--changing-the-stream)
- [How to change the stream with the CLI](#heading--changing-stream-with-cli)

<a href="#heading--candidate-stream"><h3 id="heading--candidate-stream">About the candidate stream</h3></a>

The candidate stream contains images and bootloaders which have not been explicitly tested with MAAS. Canonical's automated build process dumps all images and bootloaders here before they are tested with MAAS. This stream is useful when testing a bug fix before an image or bootloader has been promoted to stable. Think of the candidate stream as a preview: it should never be used in a production environment; and users are encouraged to provide feedback on any issues they find with this stream.

This stream is available [here](http://images.maas.io/ephemeral-v3/candidate).

<a href="#heading--stable-stream"><h3 id="heading--stable-stream">About the stable stream</h3></a>

The stable stream contains images and bootloaders which have been tested with the latest version of MAAS. This is the default stream which should be used in production environments.  This stream is available [here](http://images.maas.io/ephemeral-v3/stable).

<a href="#heading--daily-stream"><h3 id="heading--daily-stream">About the retired daily stream</h3></a>

Previously there was only one MAAS stream available, daily. This stream has been replaced by the stable stream. Any client using this stream will be automatically redirected to the stable stream.

<a href="#heading--changing-the-stream"><h3 id="heading--changing-the-stream">How to change the stream with the UI</h3></a>

To switch to the candidate stream simply select "custom" on the images page, set the URL to `http://images.maas.io/ephemeral-v3/candidate`, and click "Connect"

<a href="https://discourse.maas.io/uploads/default/original/1X/0588c8d2e5792edad3f53e90e38e9990a6d86d9a.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0588c8d2e5792edad3f53e90e38e9990a6d86d9a.jpeg"></a>

MAAS uses the stable stream by default. To switch back to it simply select `maas.io` on the images page

<a href="https://discourse.maas.io/uploads/default/original/1X/5e20342f04e30f96ac0e29a5bd3117aa71dacd40.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/5e20342f04e30f96ac0e29a5bd3117aa71dacd40.jpeg"></a>

<a href="#heading--changing-stream-with-cli"><h3 id="heading--changing-stream-with-cli">How to change the stream with the CLI</h3></a>

To switch to a stream with the CLI, enter the following commands:

```
BOOT_SOURCE_ID=$(maas $PROFILE boot-sources read | jq '.[] | select(.url | contains("images.maas.io/ephemeral-v3")) | .id')
maas $PROFILE boot-source update $BOOT_SOURCE_ID url=$STREAM_URL
```
<a href="#heading--import-maasio-image-ui"><h2 id="heading--import-maasio-image-ui">How to import standard images from maas.io</h2></a>

The 'Images' page shows what images and architectures have been selected and downloaded. By default, MAAS will automatically grab the most recent Ubuntu LTS releases (and amd64 architecture). Below, we have selected two additional releases:

<a href="https://discourse.maas.io/uploads/default/original/1X/d208922f1126ec92f6ef06cfaa5e16dbbfc613d0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/d208922f1126ec92f6ef06cfaa5e16dbbfc613d0.png"></a>

You can tell MAAS to sync images hourly, at the region level, using a toggle switch in the top-right corner of the screen.  See [Boot image sources](/t/about-images/5076#boot-image-sources)) for more details. We highly recommended syncing images hourly. Syncing at the rack controller level (from regiond) occurs every 5 min and cannot be disabled.

Click the 'Save selection' button to initiate the import. MAAS will present existing images along with the newly-selected ones. The latter will have their status updated as the import is processed:

<a href="https://discourse.maas.io/uploads/default/original/1X/f7daa92c97f1ada61c2172044d43856ed3e14b5f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/f7daa92c97f1ada61c2172044d43856ed3e14b5f.png"></a>

To remove an image, un-select it and click 'Save selection'.

<a href="#heading--image-mirrors"><h2 id="heading--image-mirrors">How to use other image mirrors to download images</h2></a>

You can also host Ubuntu images on a mirror. Configure this mirror by selecting 'Custom' beneath 'Choose source'. Enter the mirror URL and click 'Connect'.

Advanced options, such as using a GPG key or keyring to validate the mirror path (snap installation location: /snap/maas/current/usr/share/keyrings/ubuntu-cloudimage-keyring.gpg), are revealed by clicking 'Show advanced options':

<a href="https://discourse.maas.io/uploads/default/original/1X/dbe44a827e70e318a6139c3e335019a6a27c4374.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/dbe44a827e70e318a6139c3e335019a6a27c4374.png"></a>

Optionally, a local mirror can be set up as the boot source. MAAS will then use it instead of the standard internet-based server. Local mirroring significantly reduces the time required import images. See [Local image mirror](/t/how-to-mirror-images-locally/5927) for instructions.

<a href="#heading--other-images"><h2 id="heading--other-images">How to import and provision non-Ubuntu images</h2></a>

It is also possible to import and provision images other than Ubuntu. Images supported and provided by MAAS will appear beneath the 'Other Images' section. Currently, images for CentOS 6.6, CentOS 7.0, and CentOS 8.0 are available. These images can be imported and used just like the Ubuntu images above.

<a href="https://discourse.maas.io/uploads/default/original/1X/198aa78b2dd3a650f1b3909ae2c9269e159ca1dc.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/198aa78b2dd3a650f1b3909ae2c9269e159ca1dc.png"></a>
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
You can tell MAAS to sync images hourly, at the region level.  See [Boot image sources](/t/about-images/5076#boot-image-sources)) for more details. We highly recommended syncing images hourly. Syncing at the rack controller level (from regiond) occurs every 5 min and cannot be disabled.

This article will help you learn:

- [How to get started with the MAAS CLI](/t/how-to-use-the-maas-cli/5236)
- [How to list boot sources](#heading--list-boot-sources)
- [How to select images](#heading--select-image)
- [How to list image selections](#heading--list-image-selections)
- [How to import newly-selected images](#heading--import-newly-selected-images)
- [How to list currently available images](#heading--list-currently-available-images)
- [How to delete a boot source](#heading--delete-a-boot-source)
- [How to edit a boot source](#heading--edit-a-boot-source)

<a href="#heading--list-boot-sources"><h2 id="heading--list-boot-sources">How to list boot sources</h2></a>

If you want to download boot sources, i.e., the locations from which you may download images, try the following:

``` bash
maas $PROFILE boot-sources read
```

[note]
Although multiple boot sources may be listed, MAAS can only practically work with a single boot source.
[/note]

<a href="#heading--select-image"><h2 id="heading--select-image">How to select images</h2></a>

Use the `boot-source-selections` command to select images from a boot source. After selecting new images, you will need to [import](#heading--import-newly-selected-images) them.

``` bash
maas $PROFILE boot-source-selections create $SOURCE_ID \
    os="ubuntu" release="$SERIES" arches="$ARCH" \
    subarches="$KERNEL" labels="*"
```

For example, to select all kernels for 64-bit Trusty from a boot source with an id of '1':

``` bash
maas $PROFILE boot-source-selections create 1 \
    os="ubuntu" release="trusty" arches="amd64" \
    subarches="*" labels="*"
```

<a href="#heading--hardware-enablement-hwe"><h3 id="heading--hardware-enablement-hwe">Hardware enablement (HWE)</h3></a>

For example, to get just the latest amd64 HWE kernel available for Trusty, which, at time of writing, is from Xenial:

``` bash
maas $PROFILE boot-source-selections create 1 \
    os="ubuntu" release="trusty" arches="amd64" \
    subarches="hwe-x" labels="*"
```

For Xenial kernels (and starting with MAAS 2.1), notation has changed. To select the latest amd64 HWE kernel available for Xenial:

``` bash
maas $PROFILE boot-source-selections create 1 \
    os="ubuntu" release="xenial" arches="amd64" \
    subarches="hwe-16.04" labels="*"
```

<a href="#heading--list-image-selections"><h2 id="heading--list-image-selections">How to list image selections</h2></a>

To list image selections for a boot source:

``` bash
maas $PROFILE boot-source-selections read $SOURCE_ID
```

<a href="#heading--import-newly-selected-images"><h2 id="heading--import-newly-selected-images">How to import newly-selected images</h2></a>

To import newly-selected images (boot resources):

``` bash
maas $PROFILE boot-resources import
```

Once newly-selected images are imported, a sync mechanism is enabled (by default) to keep them up to date. The refresh time interval is 60 minutes.

Available images resulting from this action are reflected in the web UI.

<a href="#heading--list-currently-available-images"><h2 id="heading--list-currently-available-images">How to list currently available images</h2></a>

To list currently available/imported images (boot resources):

``` bash
maas $PROFILE boot-resources read
```

<a href="#heading--delete-a-boot-source"><h2 id="heading--delete-a-boot-source">How to delete a boot source</h2></a>

To delete a boot source (the location from which you can download images): 

``` bash
maas $PROFILE boot-source delete $SOURCE_ID
```

If you delete the sole boot source, then the fields 'Sync URL' and 'Keyring Path' in the web UI will take on null values.

<a href="#heading--edit-a-boot-source"><h2 id="heading--edit-a-boot-source">How to edit a boot source</h2></a>

You can edit an existing boot source by changing the GPG keyring file ($KEYRING_FILE) and the location ($URL).

Update the boot source:

``` bash
maas $PROFILE boot-source update $SOURCE_ID \
    url=$URL keyring_filename=$KEYRING_FILE
```

At this time MAAS only supports a boot source containing official MAAS images. As a result, you can only edit a boot source if you have set up a mirror of its images. The location can change, but the keyring remains constant:

KEYRING_FILE=/usr/share/keyrings/ubuntu-cloudimage-keyring.gpg

<a href="#heading--add-a-boot-source"><h2 id="heading--add-a-boot-source">How to add a boot source</h2></a>

[note]
To avoid unnecessary complexity, you should probably delete any existing boot sources before adding a new one.
[/note]

Presented below are a couple of use cases for adding a boot source:

- Use a local image mirror (official images)
- If you deleted the default image, recreate it

The general syntax is:

``` bash
maas $PROFILE boot-sources create \
    url=$URL keyring_filename=$KEYRING_FILE
```

The output will include a new numeric ID that identifies the boot source ($SOURCE_ID).

Since MAAS can only practically work with a single boot source, so you will need to delete any existing sources. Note that the location (URL) is the only variable. The only supported keyring is:

KEYRING_FILE=/usr/share/keyrings/ubuntu-cloudimage-keyring.gpg

If you added a sole boot source, then the fields 'Sync URL' and 'Keyring Path' in the web UI will reflect its values.

<a href="#heading--using-a-local-image-mirror"><h3 id="heading--using-a-local-image-mirror">How to use a local image mirror</h3></a>

Once the mirror is set up according to [Local image mirror](/t/how-to-mirror-images-locally/5927) it is just a matter of specifying the mirror location (URL). Since the images come from the default source, you should use the default keyring. If you are following the above mirror document, the variable values should be:

- URL=https://$MIRROR/maas/images/ephemeral-v3/stable/
- KEYRING_FILE=/usr/share/keyrings/ubuntu-cloudimage-keyring.gpg

Where $MIRROR is the mirror server's hostname or IP address.

<a href="#heading--recreate-the-default-boot-source"><h3 id="heading--recreate-the-default-boot-source">How to recreate the default boot source</h3></a>

Recreate the default boot source if it was ever deleted using the following variable values:

- URL=https://images.maas.io/ephemeral-v3/stable/
- KEYRING_FILE=/usr/share/keyrings/ubuntu-cloudimage-keyring.gpg
[/tab]
[/tabs]