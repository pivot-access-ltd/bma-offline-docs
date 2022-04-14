<!-- "How to use image streams" -->
Canonical provides two SimpleStreams for MAAS images: candidate and stable. Both streams contain Ubuntu images, CentOS images, bootloaders extracted from the Ubuntu archive, and release notifications. Either stream can be used in any version of MAAS greater than 2.1 -- but not all images are supported in older versions.

#### This article will tell you:

* [About the candidate stream](#heading--candidate-stream)
* [About the stable stream](#heading--stable-stream)
* [About the retired daily stream](#heading--daily-stream)
* [How to change the stream with the UI](#heading--changing-the-stream)
* [How to change the stream with the CLI](#heading--changing-stream-with-cli)

<a href="#heading--candidate-stream"><h2 id="heading--candidate-stream">About the candidate stream</h2></a>

The candidate stream contains images and bootloaders which have not been explicitly tested with MAAS. Canonical's automated build process dumps all images and bootloaders here before they are tested with MAAS. This stream is useful when testing a bug fix before an image or bootloader has been promoted to stable. Think of the candidate stream as a preview: it should never be used in a production environment; and users are encouraged to provide feedback on any issues they find with this stream.

This stream is available [here](http://images.maas.io/ephemeral-v3/candidate).

<a href="#heading--stable-stream"><h2 id="heading--stable-stream">About the stable stream</h2></a>

The stable stream contains images and bootloaders which have been tested with the latest version of MAAS. This is the default stream which should be used in production environments.  This stream is available [here](http://images.maas.io/ephemeral-v3/stable).

<a href="#heading--daily-stream"><h2 id="heading--daily-stream">About the retired daily stream</h2></a>

Previously there was only one MAAS stream available, daily. This stream has been replaced by the stable stream. Any client using this stream will be automatically redirected to the stable stream.

<a href="#heading--changing-the-stream"><h2 id="heading--changing-the-stream">How to change the stream with the UI</h2></a>

To switch to the candidate stream simply select "custom" on the images page, set the URL to `http://images.maas.io/ephemeral-v3/candidate`, and click "Connect"

<a href="https://discourse.maas.io/uploads/default/original/1X/0588c8d2e5792edad3f53e90e38e9990a6d86d9a.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0588c8d2e5792edad3f53e90e38e9990a6d86d9a.jpeg"></a>

MAAS uses the stable stream by default. To switch back to it simply select `maas.io` on the images page

<a href="https://discourse.maas.io/uploads/default/original/1X/5e20342f04e30f96ac0e29a5bd3117aa71dacd40.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/5e20342f04e30f96ac0e29a5bd3117aa71dacd40.jpeg"></a>

<a href="#heading--changing-stream-with-cli"><h2 id="heading--changing-stream-with-cli">How to change the stream with the CLI</h2></a>

To switch to a stream with the CLI, enter the following commands:

```
BOOT_SOURCE_ID=$(maas $PROFILE boot-sources read | jq '.[] | select(.url | contains("images.maas.io/ephemeral-v3")) | .id')
maas $PROFILE boot-source update $BOOT_SOURCE_ID url=$STREAM_URL
```