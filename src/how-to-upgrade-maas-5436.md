<!-- How to upgrade MAAS -->
[tabs]
[tab version="v3.3 Snap"]
[note]
PostgreSQL 12 is deprecated with the release of MAAS 3.3, in favour of PostgreSQL 14. Support for PostgreSQL 12 will be discontinued in MAAS 3.4.
[/note]

<a href="#heading--upgrade-from-earlier-version-to-snap-3-3"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-3">How to upgrade a snap to MAAS 3.3</h2></a>

To upgrade from a earlier snap version to the 3.3 snap (using a `region+rack` configuration):

1. Enter the following command:

```nohighlight
sudo snap refresh --channel=3.3 maas
```

2. Enter your account password.

The snap will refresh from the 3.3 channel.  You will not need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.
[/tab]
[tab version="v3.3 Packages"] 
<a href="#heading--How-to-upgrade-from-3-2-through-MAAS-2-9-to-MAAS-3-3"><h2 id="heading--How-to-upgrade-from-3-2-through-MAAS-2-9-to-MAAS-3-3">How to upgrade MAAS 2.9++ to MAAS 3.3</h2></a>

If you are running MAAS 3.2 through MAAS 2.9, you can upgrade directly to MAAS 3.3 with the following procedure:

1. Check whether the target system is running Ubuntu 22.04 LTS:

```nohighlight
lsb_release -a
```

The response should look something like this:

```nohighlight
Distributor ID:	Ubuntu
Description:	Ubuntu xx.yy
Release:	xx.yy
Codename:	$RELEASE_NAME
```

The required “xx.yy” for MAAS 3.3 is “22.04,” code-named “Jammy”.

2. If you are currently running Ubuntu focal 20.04 LTS, Upgrade to Jammy 22.04 LTS:

```nohighlight
sudo do-release-upgrade --allow-third-party
```

3. Accept the defaults for any questions asked by the upgrade script.

4. Reboot the machine when requested.

5. Check whether the upgrade was successful:

```nohighlight
lsb_release -a
```

A successful upgrade should respond with output similar to the following:

```nohighlight
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04(.nn) LTS
Release:	22.04
Codename:	jammy
```

<a href="#heading--How-to-upgrade-from-2-8-or-lower-to-MAAS-3-3"><h2 id="heading--How-to-upgrade-from-2-8-or-lower-to-MAAS-3-3">How to upgrade MAAS 2.8-- to MAAS 3.3</h2></a>

If you’re upgrading from MAAS version 2.8 or lower to version 3.3, try the fooling procedure.  While the this procedure should work, note that they it's untested. Use at your own risk. 

1. Back up your MAAS server completely with your favorite tools and media.

2. Add the MAAS 3.3 PPA to your repository list; ignore any apparent error messages:

```nohighlight
sudo apt-add-repository ppa:maas/3.3
```

3. Upgrade the release; answer any questions with the default values:

```nohighlight
sudo do-release-upgrade --allow-third-party
```

4. Check whether your upgrade has been successful:

```nohighlight
lsb_release -a
```

If the ugprade was successful, this command should yield output similar to the following:

```nohighlight
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04(.nn) LTS
Release:	22.04
Codename:	jammy
```

5. Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you’re running the 3.3 release.

If this didn’t work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.3.
[/tab]
[tab version="v3.2 Snap"] 
<a href="#heading--upgrade-from-earlier-version-to-snap-3-2"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-2">How to upgrade a snap to MAAS 3.2</h2></a>

To upgrade from a earlier snap version to the 3.2 snap (using a `region+rack` configuration):

1. Enter the following command:

```nohighlight
sudo snap refresh --channel=3.2 maas
```

2. Enter your account password.

The snap will refresh from the 3.2 channel; you will not need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.
[/tab]
[tab version="v3.2 Packages"] 
<a href="#heading--upgrade-to-3-2"><h2 id="heading--upgrade-to-3-2">How to ugprade MAAS 2.9++ to MAAS 3.2</h2></a>

To upgrade from MAAS 2.9 - 3.1 to MAAS 3.2, follow these steps:

1. Back up your MAAS server completely; the tools and media are left entirely to your discretion.

2. Add the MAAS 3.2 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.2
```

3. Run the MAAS upgrade:

```
sudo apt update
sudo apt upgrade maas
```

4. Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.2 release.

5. If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.2.

<a href="#heading--upgrade-from-2-8-to-3-2"><h2 id="heading--upgrade-from-2-8-to-3-2">How to upgrade MAAS 2.8-- to MAAS 3.2</h2></a>

If you are running MAAS 2.8 or lower, you can't upgrade directly to MAAS 3.2: 

1. Make sure that the target system is running Ubuntu 20.04 LTS or higher:

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

2. If you're not running focal, pgrade the release:

```
sudo do-release-upgrade --allow-third-party
```

3. Accept the defaults for any questions asked by the upgrade script.

4. Reboot the machine when requested.

5. Check whether the upgrade was successful:

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
[/tab]
[tab version="v3.1 Snap"] 
<a href="#heading--upgrade-from-earlier-version-to-snap-3-1"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-1">How to upgrade a snap to MAAS 3.1</h2></a>

To upgrade from a earlier snap version to the 3.1 snap (using a `region+rack` configuration):

1. Refresh the snap:

```nohighlight
sudo snap refresh --channel=3.1 maas
```
2. Enter your account password.

The snap will refresh from the 3.1 channel.  You will not need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.
[/tab]
[tab version="v3.1 Packages"] 
<a href="#heading--upgrade-from-3-0-to-3-1"><h2 id="heading--upgrade-from-3-0-to-3-1">How to ugprade MAAS 2.9++ to MAAS 3.1</h2></a>

You can upgrade from MAAS 2.9 or MAAS 3.0 to MAAS 3.1:

1. Back up your MAAS server completely; the tools and media are left entirely to your discretion.  Just be sure that you can definitely restore your previous configuration, should this procedure fail to work correctly.

2. Add the MAAS 3.1 PPA to your repository list with the following command, ignoring any apparent error messages:

```
sudo apt-add-repository ppa:maas/3.1
```

3. Run the MAAS upgrade like this:

```
sudo apt update
sudo apt upgrade maas
```

4. Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.1 release.

5. If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.1.

<a href="#heading--upgrade-from-2-8-to-3-1"><h2 id="heading--upgrade-from-2-8-to-3-1">How to upgrade MAAS 2.8-- to MAAS 3.1</h2></a>

If you are running MAAS 2.8 or lower, you can also upgrade directly to MAAS 3.1, but it requires some extra steps.  You must first make sure that the target system is running Ubuntu 20.04 LTS or higher, by executing the following command:

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

1. Upgrade the release:

```
sudo do-release-upgrade --allow-third-party
```

2. Accept the defaults for any questions asked by the upgrade script.

3. Reboot the machine when requested.

4. Check whether the upgrade was successful:

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
[/tab]
[tab version="v3.0 Snap"] 
<a href="#heading--upgrade-from-earlier-version-to-snap-3-0"><h2 id="heading--upgrade-from-earlier-version-to-snap-3-0">How to upgrade a snap to MAAS 3.0</h2></a>

To upgrade from a earlier snap version to the 3.0 snap (using a `region+rack` configuration), do the following:

1. Refresh the snap:

```nohighlight
sudo snap refresh --channel=3.0 maas
```

2. Enter your user password.

The snap will refresh from the 3.0 channel.  You will not need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.
[/tab]
[tab version="v3.0 Packages"] 
<a href="#heading--upgrade-from-2-9-to-3-0"><h2 id="heading--upgrade-from-2-9-to-3-0">How to ugprade MAAS 2.9 to MAAS 3.0</h2></a>

To upgrade a working MAAS 2.9 instance to MAAS 3.0, follow these steps:

1. Back up your MAAS server completely; the tools and media are left entirely to your discretion.

2. Add the MAAS 3.0 PPA to your repository list:

```
sudo apt-add-repository ppa:maas/3.0
```

3. Run the MAAS upgrade:

```
sudo apt update
sudo apt upgrade maas
```

4. Check your running MAAS install (by looking at the information on the bottom of the machine list) to make sure you're running the 3.0 release.

5. If this didn't work, you will need to restore from the backup you made in step 1, and consider obtaining separate hardware to install MAAS 3.0.

<a href="#heading--upgrade-from-2-8-to-3-0"><h2 id="heading--upgrade-from-2-8-to-3-0">How to upgrade MAAS 2.8-- to MAAS 3.0</h2></a>

If you are running MAAS 2.8, you can upgrade directly to MAAS 3.0 with the following procedure:

1. Check your release:

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

2. Upgrade the release:

```
sudo do-release-upgrade --allow-third-party
```

3. Accept the defaults for any questions asked by the upgrade script.

4. Reboot the machine when requested.

5. Check whether the upgrade was successful:

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
[/tab]
[tab version="v2.9 Snap"] 
<a href="#heading--upgrade-from-earlier-version-to-snap-2-9"><h2 id="heading--upgrade-from-earlier-version-to-snap-2-9">How to upgrade a snap to MAAS 2.9</h2></a>

To upgrade from an earlier snap version to the 2.9 snap (using a `region+rack` configuration), do the following:

1. Refresh the snap:

```nohighlight
sudo snap refresh --channel=3.0/stable maas
```

2. Enter your user password.

The snap will refresh from the 3.0 channel.  You will not need to re-initialise MAAS.

If you are using a multi-node maas deployment with separate regions and racks, you should first run the upgrade command above for rack nodes, then for region nodes.
[/tab]
[tab version="v2.9 Packages"] 
<a href="#heading--upgrade-from-2-8-to-2-9"><h2 id="heading--upgrade-from-2-8-to-2-9">How to upgrade MAAS 2.8-- to MAAS 2.9</h2></a>

MAAS 2.8 is the last supported version for Ubuntu 18.04 LTS.  Newer versions of MAAS will not be back-portable, and consequently, to upgrade to MAAS 2.9 and all future versions, you will also need to upgrade the base operating system to Ubuntu 20.04.  

You do these two operations all at once, with the following procedure:

1. Add the 2.9 PPA to your repository path list:

```
sudo add-apt-repository ppa:maas/2.9
```

2. Run the release upgrade:

```
sudo do-release-upgrade --allow-third-party
```

3. Reboot your machine (requested by the upgrade script).

4. Check that your upgrade was successful:

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

You have now upgraded to the Ubuntu 20.04 LTS base, and if you check your running MAAS install, you should see that the version has been updated to the latest stable 2.9 release.
[/tab]
[/tabs]