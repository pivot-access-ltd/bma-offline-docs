<!-- How to mirror images locally -->
Mirroring images is worthy of consideration.  The SimpleStreams protocol delivers Images to MAAS, which is especially useful when your Internet link is slow or unreliable. In this mirrored configuration, images will be instantly available when MAAS requests them.

Canonical provides two SimpleStreams for MAAS images: candidate and stable. Both streams contain Ubuntu images, CentOS images, bootloaders extracted from the Ubuntu archive, and release notifications. Either stream can be used in any version of MAAS greater than 2.1, but not all images are supported in older versions.

This article will tell you:

- [How to change the stream with the UI](#heading--changing-the-stream)
- [How to change the stream with the CLI](#heading--changing-stream-with-cli)
- [How to set up a local image mirror](#heading--set-up-local-mirror)

<a href="#heading--changing-the-stream"><h2 id="heading--changing-the-stream">How to change the stream with the UI</h2></a>

To switch to the candidate stream:

1. Select *Images*.

2. Select *Change source*.

3. Select *Custom*.

4. Set the *URL* to `http://images.maas.io/ephemeral-v3/candidate`.

5. Select *Connect*.

MAAS uses the stable stream by default. To switch back to the stable stream, simply repeat the above procedure, but set the *URL* to `maas.io`.

<a href="#heading--changing-stream-with-cli"><h2 id="heading--changing-stream-with-cli">How to change the stream with the CLI</h2></a>

To switch to a stream with the CLI, enter the following commands:

```
BOOT_SOURCE_ID=$(maas $PROFILE boot-sources read | jq '.[] | select(.url | contains("images.maas.io/ephemeral-v3")) | .id')
maas $PROFILE boot-source update $BOOT_SOURCE_ID url=$STREAM_URL
```
<a href="#heading--set-up-local-mirror"><h2 id="heading--set-up-local-mirror">How to set up a local mirror</h2></a>

To use mirroring, you begin by installing the necessary software on the host that will house the mirror:

``` bash
sudo apt install simplestreams
```

First define some variables to unclutter eventual CLI commands:

``` bash
KEYRING_FILE=/usr/share/keyrings/ubuntu-cloudimage-keyring.gpg
IMAGE_SRC=https://images.maas.io/ephemeral-v3/stable
IMAGE_DIR=/var/www/html/maas/images/ephemeral-v3/stable
```

The below example selects all available kernels that are compatible with either Ubuntu 18.04 (Bionic) and Ubuntu 20.04 (Focal) for the amd64 architecture, resulting in a download of approximately 3.1 GB. The second command mirrors the bootloaders.

``` bash
sudo sstream-mirror --keyring=$KEYRING_FILE $IMAGE_SRC $IMAGE_DIR \
    'arch=amd64' 'release~(bionic|focal)' --max=1 --progress
sudo sstream-mirror --keyring=$KEYRING_FILE $IMAGE_SRC $IMAGE_DIR \
    'os~(grub*|pxelinux)' --max=1 --progress
```

To know in advance what the `sstream-mirror` command will grab, or if you want to save bandwidth and time by avoiding bad selections, include the `--dry-run` option. When you are satisfied, remove that option to initiate the download.

MAAS will write the images to disk in the directory defined by the variable 'IMAGE_DIR' above, and the 'location' of the new boot source will be:

`URL=http://<myserver>/maas/images/ephemeral-v3/stable/`

Where `<myserver>` identifies your server's hostname or IP address.

Verify the availability of the images by visiting the above URL.

The final `sstream-mirror` command should be invoked at regular intervals (i.e. with `cron`) to ensure the mirror contains the latest images.
