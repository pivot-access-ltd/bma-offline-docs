MAAS is only useful once it has images available to provision its nodes. Therefore, one key post-install task is to select and import images from the boot source. Once MAAS imports images, it will update them on an hourly basis, via a default sync mechanism.  This page explains how to select and import the images that MAAS requires to provision its nodes.

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]

This article will help you learn:

- [How to use image streams](#heading--maas-image-streams)
- [How to import standard images from maas.io](#heading--import-maasio-image-ui)
- [How to use other image mirrors to download images](#heading--image-mirrors)
- [How to import and provision non-Ubuntu images](#heading--other-images)

You can also [mirror images locally](/t/how-to-mirror-images-locally/5927), build your own [custom images](/t/how-to-build-custom-images/5104), or even work with [VMWare images](/t/how-to-employ-vmware-images/5144).  And there's some [background info on images](/t/how-to-acquire-images/6192) available if you need it.

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

This stream is available [here](http://images.maas.io/ephemeral-v3/candidate)`↗`.

<a href="#heading--stable-stream"><h3 id="heading--stable-stream">About the stable stream</h3></a>

The stable stream contains images and bootloaders which have been tested with the latest version of MAAS. This is the default stream which should be used in production environments.  This stream is available [here](http://images.maas.io/ephemeral-v3/stable)`↗`.

<a href="#heading--daily-stream"><h3 id="heading--daily-stream">About the retired daily stream</h3></a>

Previously there was only one MAAS stream available, daily. This stream has been replaced by the stable stream. Any client using this stream will be automatically redirected to the stable stream.

