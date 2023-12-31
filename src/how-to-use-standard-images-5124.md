<!-- "How to use standard images" -->
MAAS is only useful once it has images available to provision its nodes. Therefore, one key post-install task is to select and import images from the boot source. Once MAAS imports images, it will update them on an hourly basis, via a default sync mechanism.  This page explains how to select and import the images that MAAS requires to provision its nodes.

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]

This article will help you learn:

- [How to use image streams](#heading--maas-image-streams)
- [How to import standard images from maas.io](#heading--import-maasio-image-ui)
- [How to use other image mirrors to download images](#heading--image-mirrors)
- [How to import and provision non-Ubuntu images](#heading--other-images)

You can also [mirror images locally](/t/how-to-mirror-images-locally/5927), build your own [custom images](/t/how-to-customise-images/5104), or even work with [VMWare images](/t/how-to-employ-vmware-images/5144).  And there's some [background info on images](/t/how-to-acquire-images/6192) available if you need it.

<a href="#heading--maas-image-streams"><h2 id="heading--maas-image-streams">How to use MAAS image streams</h2></a>

Canonical provides two SimpleStreams for MAAS images: candidate and stable. Both streams contain Ubuntu images, CentOS images, bootloaders extracted from the Ubuntu archive, and release notifications. Either stream can be used in any version of MAAS greater than 2.1 -- but not all images are supported in older versions.

<a href="#heading--changing-the-stream"><h3 id="heading--changing-the-stream">How to change the stream with the UI</h3></a>

To switch to the candidate stream: 

1. Select *Images*.

2. Select *Change source*.

3. Select *Custom*.

4. Set the *URL* to `http://images.maas.io/ephemeral-v3/candidate`.

5. Select *Connect*.

MAAS uses the stable stream by default. To switch back to it, simply repeat the above procedure, but set the *URL* to `maas.io`.

<a href="#heading--changing-stream-with-cli"><h3 id="heading--changing-stream-with-cli">How to change the stream with the CLI</h3></a>

To switch to a stream with the CLI, enter the following commands:

```
BOOT_SOURCE_ID=$(maas $PROFILE boot-sources read | jq '.[] | select(.url | contains("images.maas.io/ephemeral-v3")) | .id')
maas $PROFILE boot-source update $BOOT_SOURCE_ID url=$STREAM_URL
```
<a href="#heading--import-maasio-image-ui"><h2 id="heading--import-maasio-image-ui">How to import standard images from maas.io</h2></a>

The *Images* page shows what images and architectures have been selected and downloaded. By default, MAAS will automatically grab the most recent Ubuntu LTS releases (and amd64 architecture). 

You can tell MAAS to sync images hourly, at the region level, using a toggle switch in the top-right corner of the screen.  See [Boot image sources](/t/how-to-acquire-images/6192#boot-image-sources)) for more details. We highly recommended syncing images hourly. Syncing at the rack controller level (from regiond) occurs every 5 min and cannot be disabled.

To remove an image, simply un-select it and click *Save selection*.

<a href="#heading--image-mirrors"><h2 id="heading--image-mirrors">How to use other image mirrors to download images</h2></a>

You can also host Ubuntu images on a mirror. To use these mirrors:

1. Select *Images*.

2. Select *Change source*.

3. Select *Custom*.

4. Enter the mirror *URL*. 

5. Select *Connect* to bring the mirror online.

Advanced options, such as using a GPG key or keyring to validate the mirror path (snap installation location: /snap/maas/current/usr/share/keyrings/ubuntu-cloudimage-keyring.gpg), are revealed by Selecting *Show advanced options*.

Optionally, a local mirror can be set up as the boot source. MAAS will then use it instead of the standard internet-based server. Local mirroring significantly reduces the time required import images. See [Local image mirror](/t/how-to-mirror-images-locally/5927) for instructions.

<a href="#heading--other-images"><h2 id="heading--other-images">How to import and provision non-Ubuntu images</h2></a>

It is also possible to import and provision images other than Ubuntu. Images supported and provided by MAAS will appear in *Images >> Other Images*. These images can be imported and used just like the Ubuntu images above.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
You can tell MAAS to sync images hourly, at the region level.  See [Boot image sources](/t/how-to-acquire-images/6192#boot-image-sources)) for more details. We highly recommended syncing images hourly. Syncing at the rack controller level (from regiond) occurs every 5 min and cannot be disabled.

This article will help you learn:

- [How to get started with the MAAS CLI](/t/try-out-the-maas-cli/5236)
- [How to list boot sources](#heading--list-boot-sources)
- [How to select images](#heading--select-image)
- [How to list image selections](#heading--list-image-selections)
- [How to import newly-selected images](#heading--import-newly-selected-images)
- [How to list currently available images](#heading--list-currently-available-images)
- [How to delete a boot source](#heading--delete-a-boot-source)
- [How to edit a boot source](#heading--edit-a-boot-source)

You can also [mirror images locally](/t/how-to-mirror-images-locally/5927), build your own [custom images](/t/how-to-customise-images/5104), or even work with [VMWare images](/t/how-to-employ-vmware-images/5144).  And there's some [background info on images](/t/how-to-acquire-images/6192) available if you need it.

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
