<!-- deb-2-7-cli
 deb-2-7-cli -->

<!-- deb-2-7-ui
 deb-2-7-ui -->

<!-- deb-2-8-cli
 deb-2-8-cli -->

<!-- deb-2-8-ui
 deb-2-8-ui -->

<!-- deb-2-9-cli
 deb-2-9-cli -->

<!-- deb-2-9-ui
 deb-2-9-ui -->

<!-- snap-2-7-cli
 snap-2-7-cli -->

<!-- snap-2-7-ui
 snap-2-7-ui -->

<!-- snap-2-8-cli
 snap-2-8-cli -->

<!-- snap-2-8-ui
 snap-2-8-ui -->

<!-- snap-2-9-cli
 snap-2-9-cli -->

<!-- snap-2-9-ui
 snap-2-9-ui -->

Mirroring images is worthy of consideration.  The SimpleStreams protocol delivers Images to MAAS, which is especially useful when your Internet link is slow or unreliable. In this mirrored configuration, images will be instantly available when MAAS requests them.

<h2 id="heading--set-up-local-mirror">Setting up a local mirror</h2>

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
