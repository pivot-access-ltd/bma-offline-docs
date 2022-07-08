<!-- "How to choose images" -->
Now that you've got your network configured, you'll want to choose or build some images to deploy.  This article catalogs all the explanations and how-to procedures related to images.  You can search for [big picture topics](#heading--images-the-big-picture), or consult the [image topical index](#heading--images-specific-topics).

<a href="#heading--images-the-big-picture"><h2 id="heading--images-the-big-picture">MAAS images: the big picture</h2></a>

If you're feeling uncertain about your understanding of MAAS images and how they work, you can pause to learn:

- [About images](/t/about-images/5076): MAAS provides supported images for stable Ubuntu releases, CentOS 7, and CentOS 8.0. In this article, you can learn about boot sources and why they matter.
- [About custom images](/t/about-creating-custom-images/6099): MAAS is much more useful when you can upload images that aren’t gathered from the MAAS image repository, deploy them to MAAS-managed machines, and count on them to work properly.  This article explains how MAAS images differ from a standard ISO, and what has to happen to make those off-the-shelf ISOs deployable and usable by MAAS.

When you're ready to start working with images, you can follow these procedures:

- [How to import images](/t/how-to-import-images/5124): MAAS is only useful once it has images available to provision its nodes. Therefore, one key post-install task is to select and import images from the boot source. Once MAAS imports images, it will update them on an hourly basis, via a default sync mechanism. This page explains how to select and import the images that MAAS requires to provision its nodes.
- [How to create custom images](/t/how-to-create-custom-images/5104): MAAS supports deploying custom OS images. Canonical provides both [lp:maas-image-builder](https://launchpad.net/maas-image-builder) and [gh:canonical/packer-maas](https://github.com/canonical/packer-maas) to support creating custom images. These custom images can include static Ubuntu images, created with whatever tool you choose, as well as other OS images.
- [How to mirror images locally](/t/how-to-mirror-images-locally/5927): Mirroring images is worthy of consideration. The SimpleStreams protocol delivers Images to MAAS, which is especially useful when your Internet link is slow or unreliable. In this mirrored configuration, images will be instantly available when MAAS requests them.
- [How to manage VMWare images](/t/how-to-manage-vmware-images/5144): MAAS 2.5 and above can deploy VMware ESXi as a custom image. MAAS cannot directly deploy the VMware ESXi ISO; you must create a specialised image from an official VMWare ISO. To automate the image creation process, Canonical [hosts a repository](https://github.com/canonical/packer-maas) with community-contributed [packer](https://www.packer.io/) templates.

<a href="#heading--images-specific-topics"><h2 id="heading--images-specific-topics">Image topical index</h2></a>

<a href="#heading--a-topics"><h3 id="heading--a-topics">A</h3></a>

[adding a boot source](/t/how-to-import-images/5124#heading--add-a-boot-source)

<a href="#heading--b-topics"><h3 id="heading--b-topics">B</h3></a>

[boot source, adding](/t/how-to-import-images/5124#heading--add-a-boot-source)
[boot source, default, recreating](/t/how-to-import-images/5124#heading--recreate-the-default-boot-source)
[boot source, deleting](/t/how-to-import-images/5124#heading--delete-a-boot-source)
[boot source, editing](/t/how-to-import-images/5124#heading--edit-a-boot-source)
[boot sources and why they matter](/t/about-images/5076#heading--boot-sources)
[boot sources, listing](/t/how-to-import-images/5124#heading--list-boot-sources)
[booting static Ubuntu images](/t/about-creating-custom-images/6099#heading--about-how-maas-boots-these-images)
[build a packer raw image](/t/how-to-create-custom-images/5104#heading--how-to-build-a-packer-raw-image)
[build a VMWare image (packer)](/t/how-to-manage-vmware-images/5144#heading--building-an-image)
[build images via a proxy](/t/how-to-create-custom-images/5104#heading--how-to-build-images-via-a-proxy)
[build MAAS images](/t/how-to-create-custom-images/5104#heading--how-to-build-maas-images)
[builder section (packer)](/t/about-creating-custom-images/6099#heading--builders)
[building MAAS images with packer](/t/how-to-create-custom-images/5104#heading--how-to-use-packer-to-build-maas-images)

<a href="#heading--c-topics"><h3 id="heading--c-topics">C</h3></a>

[candidate stream, importing](/t/how-to-import-images/5124#heading--candidate-stream)
[candidate stream, mirroring](/t/how-to-mirror-images-locally/5927#heading--candidate-stream)
[CentOS 7 image, packing for MAAS deployment](/t/how-to-create-custom-images/5104#heading--how-to-pack-a-centos7-image-for-maas-deployment)
[CentOS images, custom, creating](/t/how-to-create-custom-images/5104#heading--custom-centos-images)
[CentOS images, custom, uploading to MAAS](how-to-create-custom-images/5104#heading--centos-upload-images)
[CentOS images, customising](how-to-create-custom-images/5104#heading--centos-customize-images)
[change image stream with cli, when importing](/t/how-to-import-images/5124#heading--changing-stream-with-cli)
[change image stream with ui, when importing](/t/how-to-import-images/5124#heading--changing-the-stream)
[cloning VMWare images](/t/how-to-manage-vmware-images/5144#heading--no-cloning-support)
[configuring deployed machine networking](/t/about-creating-custom-images/6099#heading--about-configuring-deployed-machine-networking)
[configuring deployed machine storage](/t/about-creating-custom-images/6099#heading--about-configuring-deployed-machine-storage)
[create a custom Ubuntu image for MAAS](/t/how-to-create-custom-images/5104#heading--how-to-create-a-custom-ubuntu-image-for-maas)
[create and use packer images](/t/how-to-create-custom-images/5104#heading--how-to-create-a-packer-image)
[create custom CentOS images](/t/how-to-create-custom-images/5104#heading--custom-centos-images)
[create custom rhel images](/t/how-to-create-custom-images/5104#heading--custom-rhel-images)
[create other custom images](/t/how-to-create-custom-images/5104#heading--other-custom-images)
[create windows images](/t/how-to-create-custom-images/5104#heading--custom-windows-images)
[creating custom CentOS images](how-to-create-custom-images/5104#heading--centos-create-images)
[creating images behind a proxy](how-to-create-custom-images/5104#heading--images-behind-proxy)
[creating images](how-to-create-custom-images/5104#heading--rhel-create-images)
[creating other custom images](/t/how-to-create-custom-images/5104#heading--other-custom-images)
[currently available images, listing](/t/how-to-import-images/5124#heading--list-currently-available-images)
[custom CentOS images, creating](/t/how-to-create-custom-images/5104#heading--custom-centos-images)
[custom CentOS images, uploading to MAAS](how-to-create-custom-images/5104#heading--centos-upload-images)
[custom images, other (generic), creating](/t/how-to-create-custom-images/5104#heading--other-custom-images)
[custom rhel images, creating](/t/how-to-create-custom-images/5104#heading--custom-rhel-images)
[custom Ubuntu image for MAAS, creating](/t/how-to-create-custom-images/5104#heading--how-to-create-a-custom-ubuntu-image-for-maas)
[customise images](/t/how-to-create-custom-images/5104#heading--how-to-customise-images)
[customise VMWare images](/t/how-to-manage-vmware-images/5144#heading--customising-the-image)
[customising CentOS images](how-to-create-custom-images/5104#heading--centos-customize-images)
[customising images](/t/how-to-create-custom-images/5104#heading--how-to-customise-images)
[customising VMWare images](/t/how-to-manage-vmware-images/5144#heading--customising-the-image)

<a href="#heading--d-topics"><h3 id="heading--d-topics">D</h3></a>

[daily stream, retired](/t/how-to-import-images/5124#heading--daily-stream)
[debug custom windows images](how-to-create-custom-images/5104#heading--mib-debug-windows)
[default boot source, recreating](/t/how-to-import-images/5124#heading--recreate-the-default-boot-source)
[default image username](/t/how-to-create-custom-images/5104#heading--about-the-default-image-username)
[deleting a boot source](/t/how-to-import-images/5124#heading--delete-a-boot-source)
[deployed machine networking, configuring](/t/about-creating-custom-images/6099#heading--about-configuring-deployed-machine-networking)
[deployed machine storage, configuring](/t/about-creating-custom-images/6099#heading--about-configuring-deployed-machine-storage)
[deployment requirements, packer, verifying](/t/how-to-create-custom-images/5104#heading--how-to-verify-packer-deployment-requirements)
[downloading images with other image mirrors](/t/how-to-import-images/5124#heading--image-mirrors)

<a href="#heading--e-topics"><h3 id="heading--e-topics">E</h3></a>

[editing a boot source](/t/how-to-import-images/5124#heading--edit-a-boot-source)
[esxi hardware support](/t/how-to-manage-vmware-images/5144#heading--esxi-hardware-support)
[esxi image, packing for MAAS deployment](/t/how-to-create-custom-images/5104#heading--how-to-pack-an-exsi-image-for-maas-deployment)

<a href="#heading--f-topics"><h3 id="heading--f-topics">F</h3></a>

[features and limitations of VMWare images in MAAS](/t/how-to-manage-vmware-images/5144#heading--features-and-limitations)

<a href="#heading--h-topics"><h3 id="heading--h-topics">H</h3></a>

[hand-built Ubuntu images, uploading to MAAS](/t/about-creating-custom-images/6099#heading--about-uploading-hand-built-ubuntu-images)
[hardware enablement (hwe)](/t/how-to-import-images/5124#heading--hardware-enablement-hwe)

<a href="#heading--i-topics"><h3 id="heading--i-topics">I</h3></a>

[image builder, MAAS, using to build MAAS images](/t/how-to-create-custom-images/5104#heading--how-to-use-maas-image-builder-to-build-maas-images)
[image installation process](/t/about-creating-custom-images/6099#heading--about-the-image-installation-process)
[image metrics, static](/t/about-creating-custom-images/6099#heading--about-static-image-metrics)
[image selections, listing](/t/how-to-import-images/5124#heading--list-image-selections)
[image stream, changing with cli, when importing](/t/how-to-import-images/5124#heading--changing-stream-with-cli)
[image stream, changing with ui, when importing](/t/how-to-import-images/5124#heading--changing-the-stream)
[image streams, MAAS, using](/t/how-to-import-images/5124#heading--maas-image-streams)
[image username, default](/t/how-to-create-custom-images/5104#heading--about-the-default-image-username)
[images, selecting](/t/how-to-import-images/5124#heading--select-image)
[importing and provisioning non-Ubuntu images](/t/how-to-import-images/5124#heading--other-images)
[importing newly-selected images](/t/how-to-import-images/5124#heading--import-newly-selected-images)
[importing standard images from MAAS.io](/t/how-to-import-images/5124#heading--import-maasio-image-ui)
[install custom rhel images into MAAS](how-to-create-custom-images/5104#heading--rhel-install)
[install custom windows images into MAAS](how-to-create-custom-images/5104#heading--windows-image-install)
[install MAAS image builder](/t/how-to-create-custom-images/5104#heading--install-mib)
[install packer](/t/how-to-create-custom-images/5104#heading--how-to-install-packer)
[iso, transforming](/t/about-creating-custom-images/6099#heading--about-transforming-an-iso)

<a href="#heading--l-topics"><h3 id="heading--l-topics">L</h3></a>

[listing boot sources](/t/how-to-import-images/5124#heading--list-boot-sources)
[listing currently available images](/t/how-to-import-images/5124#heading--list-currently-available-images)
[listing image selections](/t/how-to-import-images/5124#heading--list-image-selections)
[local image mirror, setting up](/t/how-to-mirror-images-locally/5927#heading--set-up-local-mirror)

<a href="#heading--m-topics"><h3 id="heading--m-topics">M</h3></a>

[MAAS image builder, using to build MAAS images](/t/how-to-create-custom-images/5104#heading--how-to-use-maas-image-builder-to-build-maas-images)
[MAAS image streams, using](/t/how-to-import-images/5124#heading--maas-image-streams)
[maas.io, importing standard images from](/t/how-to-import-images/5124#heading--import-maasio-image-ui)
[metrics, images, static](/t/about-creating-custom-images/6099#heading--about-static-image-metrics)

<a href="#heading--n-topics"><h3 id="heading--n-topics">N</h3></a>

[network requirements for custom CentOS images](how-to-create-custom-images/5104#heading--centos-nw-rqmts)
[networking, deployed machine, configuring](/t/about-creating-custom-images/6099#heading--about-configuring-deployed-machine-networking)
[newly-selected images, importing](/t/how-to-import-images/5124#heading--import-newly-selected-images)
[non-Ubuntu images, importing and provisioning](/t/how-to-import-images/5124#heading--other-images)
[non-Ubuntu images, provisioning after importing](/t/how-to-import-images/5124#heading--other-images)

<a href="#heading--o-topics"><h3 id="heading--o-topics">O</h3></a>

[obtaining templates](/t/how-to-create-custom-images/5104#heading--how-to-obtain-templates)
[other custom images, creating](/t/how-to-create-custom-images/5104#heading--other-custom-images)
[other image mirrors, downloading images with](/t/how-to-import-images/5124#heading--image-mirrors)

<a href="#heading--p-topics"><h3 id="heading--p-topics">P</h3></a>

[pack a CentOS 7 image for MAAS deployment](/t/how-to-create-custom-images/5104#heading--how-to-pack-a-centos7-image-for-maas-deployment)
[pack a rhel7 image for MAAS deployment](/t/how-to-create-custom-images/5104#heading--how-to-pack-a-rhel7-image-for-maas-deployment)
[pack a rhel8 image for MAAS deployment](/t/how-to-create-custom-images/5104#heading--how-to-pack-a-rhel8-image-for-maas-deployment)
[pack an esxi image for MAAS deployment](/t/how-to-create-custom-images/5104#heading--how-to-pack-an-exsi-image-for-maas-deployment)
[pack an Ubuntu image for MAAS deployment](/t/how-to-create-custom-images/5104#heading--how-to-pack-an-ubuntu-image-for-maas-deployment)
[packer builder section](/t/about-creating-custom-images/6099#heading--builders)
[packer dependencies](/t/about-creating-custom-images/6099#heading--about-packer-dependencies)
[packer deployment requirements, verifying](/t/how-to-create-custom-images/5104#heading--how-to-verify-packer-deployment-requirements)
[packer images, creating and using](/t/how-to-create-custom-images/5104#heading--how-to-create-a-packer-image)
[packer images, uploading to MAAS](/t/how-to-create-custom-images/5104#heading--how-to-upload-packer-images-to-maas)
[packer prequisites, verifying](/t/how-to-create-custom-images/5104#heading--how-to-verify-packer-prequisites)
[packer raw image, build](/t/how-to-create-custom-images/5104#heading--how-to-build-a-packer-raw-image)
[packer templates](/t/about-creating-custom-images/6099#heading--about-packer-templates)
[packer variables (declaration section)](/t/about-creating-custom-images/6099#heading--variables)
[packer-created images](/t/about-creating-custom-images/6099#heading--about-packer-created-images)
[packer](/t/about-creating-custom-images/6099#heading--about-packer)
[post-processing section (packer)](/t/about-creating-custom-images/6099#heading--post-processing)
[prequisites, packer, verifying](/t/how-to-create-custom-images/5104#heading--how-to-verify-packer-prequisites)
[prerequisites for creating a VMWare image](/t/how-to-manage-vmware-images/5144#heading--prerequisites-to-create-the-images)
[provisioner section (packer)](/t/about-creating-custom-images/6099#heading--provisioners)
[provisioning non-Ubuntu images after importing them](/t/how-to-import-images/5124#heading--other-images)
[proxy, build images via, how to](/t/how-to-create-custom-images/5104#heading--how-to-build-images-via-a-proxy)

<a href="#heading--r-topics"><h3 id="heading--r-topics">R</h3></a>

[raw image, packer, build](/t/how-to-create-custom-images/5104#heading--how-to-build-a-packer-raw-image)
[recreate default boot source](/t/how-to-import-images/5124#heading--recreate-the-default-boot-source)
[requirements, deployment, packer, verifying](/t/how-to-create-custom-images/5104#heading--how-to-verify-packer-deployment-requirements)
[rhel custom image requirements](how-to-create-custom-images/5104#heading--rhel-requirements)
[rhel images, custom, creating](/t/how-to-create-custom-images/5104#heading--custom-rhel-images)
[rhel7 image, packing for MAAS deployment](/t/how-to-create-custom-images/5104#heading--how-to-pack-a-rhel7-image-for-maas-deployment)
[rhel8 image, packing for MAAS deployment](/t/how-to-create-custom-images/5104#heading--how-to-pack-a-rhel8-image-for-maas-deployment)

<a href="#heading--s-topics"><h3 id="heading--s-topics">S</h3></a>

[selecting images](/t/how-to-import-images/5124#heading--select-image)
[setting up a local image mirror](/t/how-to-mirror-images-locally/5927#heading--set-up-local-mirror)
[stable stream](/t/how-to-import-images/5124#heading--stable-stream)
[standard images, importing from maas.io](/t/how-to-import-images/5124#heading--import-maasio-image-ui)
[static image metrics](/t/about-creating-custom-images/6099#heading--about-static-image-metrics)
[static Ubuntu images, MAAS handling of](/t/about-creating-custom-images/6099#heading--about-how-maas-handles-these-images)
[static Ubuntu images](/t/about-creating-custom-images/6099#heading--about-static-ubuntu-images)
[storage, deployed machine, configuring](/t/about-creating-custom-images/6099#heading--about-configuring-deployed-machine-storage)

<a href="#heading--t-topics"><h3 id="heading--t-topics">T</h3></a>

[templates, obtaining](/t/how-to-create-custom-images/5104#heading--how-to-obtain-templates)
[transforming an iso](/t/about-creating-custom-images/6099#heading--about-transforming-an-iso)

<a href="#heading--u-topics"><h3 id="heading--u-topics">U</h3></a>

[Ubuntu image for MAAS deployment](/t/how-to-create-custom-images/5104#heading--how-to-pack-an-ubuntu-image-for-maas-deployment)
[Ubuntu images, hand-built, uploading to MAAS](/t/about-creating-custom-images/6099#heading--about-uploading-hand-built-ubuntu-images)
[uploading a VMWare image](/t/how-to-manage-vmware-images/5144#heading--uploading-an-image)
[uploading custom CentOS images to MAAS](how-to-create-custom-images/5104#heading--centos-upload-images)
[uploading hand-built Ubuntu images to MAAS](/t/about-creating-custom-images/6099#heading--about-uploading-hand-built-ubuntu-images)
[uploading packer images to MAAS](/t/how-to-create-custom-images/5104#heading--how-to-upload-packer-images-to-maas)
[use a local image mirror](/t/how-to-import-images/5124#heading--using-a-local-image-mirror)
[use other image mirrors to download images](/t/how-to-import-images/5124#heading--image-mirrors)
[use packer to build MAAS images](/t/how-to-create-custom-images/5104#heading--how-to-use-packer-to-build-maas-images)
[username, image, default](/t/how-to-create-custom-images/5104#heading--about-the-default-image-username)
[using image builder to create custom windows images](how-to-create-custom-images/5104#heading--mib-windows)
[using MAAS image builder to build MAAS images](/t/how-to-create-custom-images/5104#heading--how-to-use-maas-image-builder-to-build-maas-images)
[using MAAS image streams](/t/how-to-import-images/5124#heading--maas-image-streams)

<a href="#heading--v-topics"><h3 id="heading--v-topics">V</h3></a>

[variables, packer (declaration section)](/t/about-creating-custom-images/6099#heading--variables)
[verify packer deployment requirements](/t/how-to-create-custom-images/5104#heading--how-to-verify-packer-deployment-requirements)
[verify packer prequisites](/t/how-to-create-custom-images/5104#heading--how-to-verify-packer-prequisites)
[VMWare image, build with packer](/t/how-to-manage-vmware-images/5144#heading--building-an-image)
[VMWare image, packer, build](/t/how-to-manage-vmware-images/5144#heading--building-an-image)
[VMWare image, prerequisites for creating](/t/how-to-manage-vmware-images/5144#heading--prerequisites-to-create-the-images)
[VMWare image, uploading](/t/how-to-manage-vmware-images/5144#heading--uploading-an-image)
[VMWare images and MAAS networking](/t/how-to-manage-vmware-images/5144#heading--networking)
[VMWare images and MAAS storage](/t/how-to-manage-vmware-images/5144#heading--storage)
[VMWare images, cloning](/t/how-to-manage-vmware-images/5144#heading--no-cloning-support)
[VMWare images, customising](/t/how-to-manage-vmware-images/5144#heading--customising-the-image)
[VMWare images, features and limitations in MAAS](/t/how-to-manage-vmware-images/5144#heading--features-and-limitations)

<a href="#heading--w-topics"><h3 id="heading--w-topics">W</h3></a>

[warnings on creating a custom Ubuntu image](/t/how-to-create-custom-images/5104#heading--warnings-on-creating-a-custom-ubuntu-image)
[why customised Ubuntu deployments aren't supported](/t/how-to-create-custom-images/5104#heading--why-customised-ubuntu-deployments-arent-supported)
[windows images, custom, debugging](how-to-create-custom-images/5104#heading--mib-debug-windows)