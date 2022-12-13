<!-- "How to set up an air-gapped MAAS" -->
Many MAAS users maintain their data centres in an air-gapped environment that does not have an external Internet connection. MAAS runs well in this configuration, though keeping MAAS supplied with updates and images requires a bit of extra effort.

There are essentially four things that must be available to an air-gapped MAAS for smooth operation:

1. Snap updates (via the snap proxy)
2. Packages (via a local repo, possibly with a transparent proxy)
3. MAAS-maintained images (via  local mirror, possibly with a transparent proxy)
4. Other OS images (various methods)

There is at least one way to make each of these things available in an air-gapped environment.  Some of these can be set up to use a transparent proxy, which minimises changes to other components of the MAAS environment.

#### This article will help you learn:

- [How to use the snap proxy to refresh snaps in an air-gapped environment](#heading--How-to-use-the-snap-proxy-to-refresh-snaps-in-an-air-gapped-environment)
- [How to make package updates available in an air-gapped environment](#heading--apt-mirror)
- [How to retrieve or update MAAS images in an air-gapped environment](#heading--local-image-mirroring)
- [How to retrieve or update non-MAAS-maintained images in an air-gapped environment](#heading--non-maas-images)
- [How to use user_data to access non-MAAS-maintained images](#heading--other-os-user-data)
- [How to set up a transparent proxy](#heading--transparent-proxy)

<a href="#heading--How-to-use-the-snap-proxy-to-refresh-snaps-in-an-air-gapped-environment"><h2 id="heading--How-to-use-the-snap-proxy-to-refresh-snaps-in-an-air-gapped-environment">How to use the snap proxy to refresh snaps in an air-gapped environment</h2></a>

Using snaps in an air-gapped environment is possible with the Snap Store Proxy, which can be deployed in networks that are disconnected from the Internet.  Currently, the features required to use this proxy in an [air-gapped](https://docs.ubuntu.com/snap-store-proxy/en/airgap)`↗` mode are part of a password-protected internal Beta.  

Client devices connect to the air-gapped proxy and never contact the general Snap Store nor the Internet.  Proxy operators will need to side-load all needed snaps and updates into the proxy. 

There are three main steps to setting up this proxy:

1. Register an offline Snap Store Proxy on an Internet-connected machine.
2. Set up HTTPS access to ensure adequate security.
3. Fetch the necessary snaps as needed by your MAAS environment (on the Internet-connected machine).

This proxy requires a properly configured PostgreSQL database -- see the [setup instructions](https://docs.ubuntu.com/snap-store-proxy/en/airgap)`↗` for the Snap Store Proxy for more details.

<a href="#heading--apt-mirror"><h2 id="heading--apt-mirror">How to make package updates available in an air-gapped environment</h2></a>

The simplest way to use local package repos is via the [reprepro](https://manpages.ubuntu.com/manpages/focal/man1/reprepro.1.html)`↗` command.  There is an older command, `apt-mirror`, which is no longer maintained; it's not recommended.

The `reprepro` command manages a local repository of Debian packages.  You can add files manually or download them from some other repository.  It does not require an external database.  This command also handles signatures of mirrored repos, and can create signatures for the generated package indices, if desired.  

You may wish to create a [transparent proxy](#heading--transparent-proxy) to make using your local repo easier.

<a href="#heading--local-image-mirroring"><h2 id="heading--local-image-mirroring">How to retrieve or update MAAS images in an air-gapped environment</h2></a>
 
MAAS has an [established process](/t/how-to-mirror-images-locally/5927) for mirroring images locally.   The steps are relatively simple:

1. Install the `simplestreams` package.
2. Define some variables to simplify CLI usage.
3. Create the desired mirrors, specifying where you want your images stored.
4. Set up a new boot source on your local server, referring to the local mirror.

See the [local image mirror](/t/how-to-mirror-images-locally/5927) for details.  Note that you can use the menu at the top of that page to switch to specific instructions for the version, build-type, and interface you prefer.

<a href="#heading--non-maas-images"><h2 id="heading--non-maas-images">How to retrieve or update non-MAAS-maintained images in an air-gapped environment</h2></a>

MAAS allows you to deploy many types of OSes, and, once deployed, install specific software.  MAAS can configure a user specified repository for Ubuntu, so a user can mirror the Ubuntu apt repositories and point MAAS at those repos. When Ubuntu deploys apt will automatically be configured to use the user defined apt mirrors. 

MAAS only does this for Ubuntu, not CentOS or RHEL. If you deploy CentOS or RHEL with MAAS, the repos that built the image will be deployed.  But this won't work in an air \-gapped environment. To access non-MAAS-maintained images in an air-gapped environment, you will need to use one of two methods:

- Use `user_data`.
- Create custom images and store them in your local mirror.

Here's a thumbnail sketch of both of these methods.

<a href="#heading--other-os-user-data"><h3 id="heading--other-os-user-data">How to use user_data to access non-MAAS-maintained images</h3></a>

A user can create custom `user_data` which will configure CentOS or RHEL to use a specific mirror.  Check out the [machine customisation](/t/how-to-customise-machines/5108) page for details on how to make this work.

<a href="#heading--store-custom-images"><h3 id="heading--store-custom-images">Storing customer images for non-MAAS-maintained images</h3></a>

You can also [create custom images](/t/how-to-build-custom-images/5104) and store them in your local mirror.  Once you have the image built, consult the page on [local image mirrors](/t/how-to-mirror-images-locally/5927) to see how to incorporate your newly-built image into the local stash.

<a href="#heading--transparent-proxy"><h2 id="heading--transparent-proxy">How to set up a transparent proxy</h2></a>

If you don't wish to disturb the default configurations for Ubuntu and MAAS, you can create a transparent proxy for Debian packages and images, via the following general steps:

1. Configure Ubuntu to get packages via HTTP.
2. Configure MAAS to get packages via HTTP.
3. Create a local mirror repo for `archive.ubuntu.com`.
4. Create a local image mirror for `images.maas.io`.
5. Configure DNS to point to the local mirrors for both of those URLs.

This avoids any need to change the default settings for MAAS or Ubuntu.
