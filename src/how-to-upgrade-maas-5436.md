<!-- "How to upgrade MAAS" -->
[tabs]
[tab version="v3.2 Snap"] 
<a href="#heading--upgrade-from-earlier-version-to-snap-3-2"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-2">How to upgrade a snap to MAAS 3.2</h2></a>

If you want to upgrade from a earlier snap version to the 3.2 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=3.2 maas

After entering your password, the snap will refresh from the 3.1 channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.
[/tab]
[tab version="v3.2 Packages"] 
<a href="#heading--upgrade-from-v3-1-packages-to-3-2"><h2 id="heading--upgrade-from-v3-1-packages-to-3-2">How to ugprade from MAAS 3.1 to MAAS 3.2</h2></a>

To upgrade from MAAS 3.1 to MAAS 3.2:

- Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

- Add the MAAS 3.2 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.2
```

- Run the MAAS upgrade like this:

```
sudo apt update
sudo apt upgrade maas
```

- Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.2 release.

- If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.2.

<a href="#heading--upgrade-from-v2-8-packages-to-3-2"><h2 id="heading--upgrade-from-v2-8-packages-to-3-2">How to upgrade from 2.8 or lower to MAAS 3.2</h2></a>

If you are running MAAS 2.8 or lower, you can upgrade directly to MAAS 3.2. You must first make sure that the target system is running Ubuntu 20.04 LTS or higher, by executing the following command:

```
lsb_release -a
```

The response should look something like this:

```
Distributor ID:	Ubuntu
Description:	Ubuntu xx.yy
Release:	xx.yy
Codename:	$RELEASE_NAME
```

The minimum "xx.yy" required for MAAS 3.2 is "20.04," code-named "focal."

If you are currently running Ubuntu bionic 18.04 LTS, you can upgrade to focal 20.04 LTS with the following procedure:

- Upgrade the release:

```
sudo do-release-upgrade --allow-third-party
```

- Accept the defaults for any questions asked by the upgrade script.

- Reboot the machine when requested.

- Check whether the upgrade was successful:

```
lsb_release -a
```

A successful upgrade should respond with output similar to the following:

```
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

[note]
If you're upgrading from MAAS version 2.8 or lower to version 3.2: While the following procedures should work, note that they are untested.  Use at your own risk.  Start by making a verifiable backup; see step 1, below.
[/note]

- Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

- Add the MAAS 3.2 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.2
```

- Run the release upgrade like this, answering any questions with the given default values:

```
sudo do-release-upgrade --allow-third-party
```

- Check whether your upgrade has been successful by entering:

```
lsb_release -a
```

If the ugprade was successful, this command should yield output similar to the following:

```
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

- Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.2 release.

- If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.2.
[/tab]
[tab version="v3.1 Snap"] 
<a href="#heading--upgrade-from-earlier-version-to-snap-3-1"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-1">How to upgrade a snap to MAAS 3.1</h2></a>

If you want to upgrade from a earlier snap version to the 3.1 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=3.1/stable maas

After entering your password, the snap will refresh from the 3.1 channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.
[/tab]
[tab version="v3.1 Packages"] 
<a href="#heading--upgrade-from-v3-0-packages-to-3-1"><h2 id="heading--upgrade-from-v3-0-packages-to-3-1">How to ugprade from MAAS 3.0 to MAAS 3.1</h2></a>

To upgrade from MAAS 3.0 to MAAS 3.1:

- Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

- Add the MAAS 3.1 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.1
```

- Run the MAAS upgrade like this:

```
sudo apt update
sudo apt upgrade maas
```

- Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.1 release.

- If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.1.

<a href="#heading--upgrade-from-v2- Packages8-to-3-1"><h2 id="heading--upgrade-from-v2- Packages8-to-3-1">How to upgrade from 2.8 or lower to MAAS 3.1</h2></a>

If you are running MAAS 2.8 or lower, you can upgrade directly to MAAS 3.1. You must first make sure that the target system is running Ubuntu 20.04 LTS or higher, by executing the following command:

```
lsb_release -a
```

The response should look something like this:

```
Distributor ID:	Ubuntu
Description:	Ubuntu xx.yy
Release:	xx.yy
Codename:	$RELEASE_NAME
```

The minimum "xx.yy" required for MAAS 3.0 is "20.04," code-named "focal."

If you are currently running Ubuntu bionic 18.04 LTS, you can upgrade to focal 20.04 LTS with the following procedure:

- Upgrade the release:

```
sudo do-release-upgrade --allow-third-party
```

- Accept the defaults for any questions asked by the upgrade script.

- Reboot the machine when requested.

- Check whether the upgrade was successful:

```
lsb_release -a
```

A successful upgrade should respond with output similar to the following:

```
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

[note]
If you're upgrading from MAAS version 2.8 or lower to version 3.1: While the following procedures should work, note that they are untested.  Use at your own risk.  Start by making a verifiable backup; see step 1, below.
[/note]

- Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

- Add the MAAS 3.1 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.1
```

- Run the release upgrade like this, answering any questions with the given default values:

```
sudo do-release-upgrade --allow-third-party
```

- Check whether your upgrade has been successful by entering:

```
lsb_release -a
```

If the ugprade was successful, this command should yield output similar to the following:

```
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

- Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.1 release.

- If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.1.
[/tab]
[tab version="v3.0 Snap"] 
<a href="#heading--upgrade-from-earlier-version-to-snap-3-0"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-0">How to upgrade a snap to MAAS 3.0</h2></a>

 If you want to upgrade from a earlier snap version to the 3.0 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=3.0/stable maas

After entering your password, the snap will refresh from the 3.0 channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.
[/tab]
[tab version="v3.0 Packages"] 
<a href="#heading--upgrade-from-v2-9-packages-to-3-0"><h2 id="heading--upgrade-from-v2-9-packages-to-3-0">How to ugprade from MAAS 2.9 to MAAS 3.0</h2></a>

- Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

- Add the MAAS 3.0 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.0
```

- Run the MAAS upgrade like this:

```
sudo apt update
sudo apt upgrade maas
```

- Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.0 release.

- If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.0.

<a href="#heading--upgrade-from-v2- Packages8-to-3-0"><h2 id="heading--upgrade-from-v2- Packages8-to-3-0">How to upgrade from 2.8 or lower to MAAS 3.0</h2></a>

If you are running MAAS 2.8 or lower, you must also make sure that the target system is running Ubuntu 20.04 LTS or higher, by executing the following command:

```
lsb_release -a
```

The response should look something like this:

```
Distributor ID:	Ubuntu
Description:	Ubuntu xx.yy
Release:	xx.yy
Codename:	$RELEASE_NAME
```

The minimum "xx.yy" required for MAAS 3.0 is "20.04," code-named "focal."

If you are currently running Ubuntu bionic 18.04 LTS, you can upgrade to focal 20.04 LTS with the following procedure:

- Upgrade the release:

```
sudo do-release-upgrade --allow-third-party
```

- Accept the defaults for any questions asked by the upgrade script.

- Reboot the machine when requested.

- Check whether the upgrade was successful:

```
lsb_release -a
```

A successful upgrade should respond with output similar to the following:

```
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

[note]
If you're upgrading from MAAS version 2.8 or lower to version 3.0: While the following procedures should work, note that they are untested.  Use at your own risk.  Start by making a verifiable backup; see step 1, below.
[/note]

- Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

- Add the MAAS 3.0 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.0
```

- Run the release upgrade like this, answering any questions with the given default values:

```
sudo do-release-upgrade --allow-third-party
```

- Check whether your upgrade has been successful by entering:

```
lsb_release -a
```

If the ugprade was successful, this command should yield output similar to the following:

```
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04(.nn) LTS
Release:	20.04
Codename:	focal
```

- Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.0 release.

- If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.0.
[/tab]
[tab version="v2.9 Snap"] 
<a href="#heading--upgrade-from-earlier-version-to-snap-2-9"><h2 id="heading--upgrade-from-earlier-version-to-snap-2-9">How to upgrade from a snap to MAAS 2.9</h2></a>

If you want to upgrade from a earlier snap version to the 2.9 snap, and you are using a `region+rack` configuration, use this command:

    $ sudo snap refresh --channel=3.0/stable maas

After entering your password, the snap will refresh from the 3.0 channel.  You will **not** need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.
[/tab]
[tab version="v2.9 Packages"] 
<a href="#heading--upgrade-from-v2- Packages8-to-2-9"><h2 id="heading--upgrade-from-v2- Packages8-to-2-9">How to upgrade from MAAS 2.8 or lower to MAAS 2.9</h2></a>

MAAS 2.8 is the last supported version for Ubuntu 18.04 LTS.  Newer versions of MAAS will not be back-portable, and consequently, to upgrade to MAAS 2.9 and all future versions, you will also need to upgrade the base operating system to Ubuntu 20.04.  You do these two operations all at once, with the following procedure:

```
sudo add-apt-repository ppa:maas/2.9
```

You will get a message similar to this:

```
 For stable releases of 2.9.x
 More info: https://launchpad.net/~maas/+archive/ubuntu/2.9
Press [ENTER] to continue or Ctrl-c to cancel adding it.

Hit:1 http://security.ubuntu.com/ubuntu bionic-security InRelease
Hit:2 http://ppa.launchpad.net/maas/2.8/ubuntu bionic InRelease          
Hit:3 http://archive.ubuntu.com/ubuntu bionic InRelease                  
Hit:4 http://archive.ubuntu.com/ubuntu bionic-updates InRelease                                     
Ign:5 http://ppa.launchpad.net/maas/2.9/ubuntu bionic InRelease          
Hit:6 http://archive.ubuntu.com/ubuntu bionic-backports InRelease        
Err:7 http://ppa.launchpad.net/maas/2.9/ubuntu bionic Release                 
  404  Not Found [IP: 91.189.95.85 80]
Reading package lists... Done
E: The repository 'http://ppa.launchpad.net/maas/2.9/ubuntu bionic Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
```

This message seems to indicate that nothing happened, but, in fact, this command still creates the file:

```
/etc/apt/sources.list.d/maas-ubuntu-2_9-bionic.list
```

This file identifies the path to the 2.9 PPA, even though it incorrectly implies there's a Bionic release there:

```
deb http://ppa.launchpad.net/maas/2.9/ubuntu bionic main
```

Still, that's enough for `do-release-upgrade` to figure out that there is a 2.9 PPA, and when it checks, it will find a Focal version of MAAS, which it will bring over and install in place of 2.8.  It isn't necessary to stop MAAS or do anything else, except go ahead and run the upgrade:

```
sudo do-release-upgrade --allow-third-party
```

This command will produce a lot of output, ask you a few questions (for which the defaults are usually fine), and eventually ask you to reboot.  Once your machine has come back up, you can check whether your upgrade has been successful by entering:

```
lsb_release -a
```

If the ugprade was successful, this command should yield output similar to the following:

```
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
```

You have now upgraded to the Ubuntu 20.04 LTS base, and if you check your running MAAS install, you should see that the version has been updated to the latest stable 2.9 release
[/tab]
[/tabs]