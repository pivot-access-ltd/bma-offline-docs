<!-- "How to adjust your controllers" -->
A rack controller can connect to multiple VLANs, each from a different network interface. A rack controller can only connect to one MAAS instance at any given time, and must connect to an instance that matches its MAAS version (major and minor).  This configuration provides a scaling factor that can help as a network architecture grows in size.

By contrast, a region controller manages communication with the user, via the Web UI/API, as well as managing the rack controller(s) in your system.  The MAAS postgres database is also managed by the region controller.  Typical region-level responsibilities include requesting that a rack controller boot a machine, and providing the ephemeral Ubuntu image needed to commission or enlist a machine.  

This article will help you learn:

- [How to install a rack controller](#heading--install-a-rack-controller)
- [How to list rack controllers](#heading--list-rack-controllers)
- [How to configure MAAS for multiple API servers](/t/how-to-enable-high-availability/5120#heading--multiple-region-endpoints)
- [How to unregister a rack controller](#heading--unregister-a-rack-controller)
- [About the potential dangers of moving a rack controller](#heading--dangers-moving-rack-controller)
- [How to move a rack controller from one MAAS instance to another](#heading--move-rack-controller)
- [How to set up PostgreSQL for the region](#heading--postgresql-setup)
- [How to add a new region host](#heading--adding-a-new-region-host)
- [How to improve region controller performance](#heading--increasing-regiond-daemon-workers)

<a href="#heading--install-a-rack-controller"><h2 id="heading--install-a-rack-controller">How to install a rack controller</h2></a>

[tabs]
[tab version="v3.3 Snap"]
To install and register a rack controller with the MAAS:

``` bash
sudo snap install maas
sudo maas init rack --maas-url $MAAS_URL --secret $SECRET
```

The $SECRET is stored in file `/var/snap/maas/common/maas/secret` on the API server.
[/tab]
[tab version="v3.3 Packages"]
To install and register a rack controller with the MAAS:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register --url $MAAS_URL --secret $SECRET
```

[note]
The register command is not required when you are adding a rack controller to a system that already houses an API server.
[/note]

The $SECRET is stored in file `/var/lib/maas/secret` on the API server.
[/tab]
[tab version="v3.2 Snap"]
To install and register a rack controller with the MAAS:

``` bash
sudo snap install maas
sudo maas init rack --maas-url $MAAS_URL --secret $SECRET
```

The $SECRET is stored in file `/var/snap/maas/common/maas/secret` on the API server.
[/tab]
[tab version="v3.2 Packages"]
To install and register a rack controller with the MAAS:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register --url $MAAS_URL --secret $SECRET
```

[note]
The register command is not required when you are adding a rack controller to a system that already houses an API server.
[/note]

The $SECRET is stored in file `/var/lib/maas/secret` on the API server.
[/tab]
[tab version="v3.1 Snap"]
To install and register a rack controller with the MAAS:

``` bash
sudo snap install maas
sudo maas init rack --maas-url $MAAS_URL --secret $SECRET
```

The $SECRET is stored in file `/var/snap/maas/common/maas/secret` on the API server.
[/tab]
[tab version="v3.1 Packages"]
To install and register a rack controller with the MAAS:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register --url $MAAS_URL --secret $SECRET
```

[note]
The register command is not required when you are adding a rack controller to a system that already houses an API server.
[/note]

The $SECRET is stored in file `/var/lib/maas/secret` on the API server.
[/tab]
[tab version="v3.0 Snap"]
To install and register a rack controller with the MAAS:

``` bash
sudo snap install maas
sudo maas init rack --maas-url $MAAS_URL --secret $SECRET
```

The $SECRET is stored in file `/var/snap/maas/common/maas/secret` on the API server.
[/tab]
[tab version="v3.0 Packages"]
To install and register a rack controller with the MAAS:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register --url $MAAS_URL --secret $SECRET
```

[note]
The register command is not required when you are adding a rack controller to a system that already houses an API server.
[/note]

The $SECRET is stored in file `/var/lib/maas/secret` on the API server.
[/tab]
[tab version="v2.9 Snap"]
To install and register a rack controller with the MAAS:

``` bash
sudo snap install maas
sudo maas init rack --maas-url $MAAS_URL --secret $SECRET
```

The $SECRET is stored in file `/var/snap/maas/common/maas/secret` on the API server.
[/tab]
[tab version="v2.9 Packages"]
To install and register a rack controller with the MAAS:

``` bash
sudo apt install maas-rack-controller
sudo maas-rack register --url $MAAS_URL --secret $SECRET
```

[note]
The register command is not required when you are adding a rack controller to a system that already houses an API server.
[/note]

The $SECRET is stored in file `/var/lib/maas/secret` on the API server.
[/tab]
[/tabs]

Note that on the UI, you can find complete instructions for adding a rack controller under the "Controllers" tab.  Simply click on the button labelled, "Add rack controller" and choose the instructions relevant to your build model (snap or packages).  The commands there will already include the correct MAAS URL and secret, so you can cut and paste them at the command line.

<a href="#heading--list-rack-controllers"><h2 id="heading--list-rack-controllers">How to list rack controllers</h2></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
You can also list and confirm all registered rack controllers via the CLI; select the link at the top of the page to find out how.  Note that you will need multiple rack controllers to achieve specific [high availability](/t/how-to-enable-high-availability/5120) configurations.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
You can also list and confirm all registered rack controllers:

``` bash
maas $PROFILE rack-controllers read | grep hostname | cut -d '"' -f 4
```

Note that you will need multiple rack controllers to achieve specific [high availability](/t/how-to-enable-high-availability/5120) configurations.
[/tab]
[/tabs]

<div class="p-notification">
<p class="p-notification__response">If you are using VM nodes, you must ensure that the new rack controller can communicate with the VM host.</p>
</div>

<a href="#heading--unregister-a-rack-controller"><h2 id="heading--unregister-a-rack-controller">How to unregister a rack controller</h2></a>

Most likely, you would only “unregister” an extra, unnecessary rack controller.  In this case, you need to <em>delete</em> it from the region API server; there is no ‘unregister’ command.

To do so, navigate to the ‘Controllers’ page of the web UI. Enter the controller’s page by clicking on the machine you want to delete and select ‘Delete’ from the drop-down (and then ‘Delete controller’). MAAS will do the right thing if the controller is used for DHCP HA; that is, the DHCP HA needs to be disabled.

Although similar, this is not the same as deletion. Here, you are deleting a machine that is a part of MAAS itself.

<div class="p-notification">
<p class="p-notification__response">Unless you remove the software on this machine, rebooting it will cause the machine to re-instate itself as a rack controller. This behaviour may change with future versions of MAAS.</p>
</div>

<a href="#heading--dangers-moving-rack-controller"><h2 id="heading--dangers-moving-rack-controller">About the potential dangers of moving a rack controller</h2></a>

There are dangers associate with moving a rack controller -- dangers that may generate errors, get you into a non-working state, or cause you significant data loss.  These dangers are precipitated by one caveat and two potential mistakes:

* **Using the same system as a rack controller and a VM host:** While not forbidden or inherently dangerous, using the same machine as both a rack controller and a VM host may cause resource contention and poor performance.  If the resources on the system are not more than adequate to cover both tasks, you may see slowdowns (or even apparent "freeze" events) on the system.

* **Moving a rack controller from one version of MAAS to another:** MAAS rack controller software is an integral part of each version of MAAS.  If you delete a rack controller from, say, a 2.6 version of MAAS, and attempt to register that 2.6 version of the rack controller code to, say, a 2.9 version of MAAS, you may experience errors and potential data loss.  Using the above example, if you are running both a VM host and a rack controller for MAAS 2.6 on one system, and you suddenly decide to delete that rack controller from 2.6 and attempt to register the same code to a 2.9 MAAS, the VM host may fail or disappear.  This will possibly delete all the VMs you have created or connected to that VM host -- which may result in data loss.  This action is not supported.

* **Connecting one instance of a rack controller to two instances of MAAS, regardless of version:** Trying to connect a single rack controller to two different instances of MAAS can result in all sorts of unpredictable (and potentially catastrophic) behaviour.  It is not a supported configuration.

Take these warnings to heart.  It may seem like a faster approach to "bridge" your existing rack controllers from one MAAS to another -- or from one version of MAAS to another -- while they're running.  Ultimately, though, it will probably result in more work than just following the recommended approach.

<a href="#heading--move-rack-controller"><h2 id="heading--move-rack-controller">How to move a rack controller from one MAAS instance to another</h2></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
In effect, there is no such action as moving a rack controller, although you can delete a rack controller from one MAAS and reinstantiate the same controller (binary-wise) on another MAAS instance.  First, delete the rack controller.  In the "Controllers" tab in the UI, select the rack controller you with to delete, choose "Take action" and select "Delete."  You will be asked to confirm with a red button, entitled "Delete 1 controller."
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
In effect, there is no such action as moving a rack controller, although you can delete a rack controller from one MAAS and reinstantiate the same controller (binary-wise) on another MAAS instance.  First, delete the rack controller, with the command:

```
maas $PROFILE rack-controller delete $SYSTEM_ID
```

where `$PROFILE` is your admin profile name, and `$SYSTEM_ID` can be found by examining the output of the command:

```
maas $PROFILE rack-controllers read
```

There is no confirmation step, so make sure you have the right rack controller before proceeding.
[/tab]
[/tabs]

Next, you must register a new rack controller, which is always done from the command line.

[tabs]
[tab version="v3.3 Snap"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[tab version="v3.3 Packages"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.
[/tab]
[tab version="v3.2 Snap"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[tab version="v3.2 Packages"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.
[/tab]
[tab version="v3.1 Snap"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[tab version="v3.1 Packages"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.
[/tab]
[tab version="v3.0 Snap"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[tab version="v3.0 Packages"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.
[/tab]
[tab version="v2.9 Snap"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[tab version="v2.9 Packages"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.
[/tab]
[/tabs]

Note that in the UI, if you go to the "Controllers" tab and press the button entitled, "Add rack controller," at the top of the Controllers screen, MAAS will give you a complete command string, including the correct URL and secret values.  Simply cut and paste that string to move the rack controller, paying attention to whether you are using snap or package build modes.

<a href="#heading--about-moving-rack-controller"><h3 id="heading--about-moving-rack-controller">About moving a rack controller from one MAAS instance to another</h3></a>

In the course of normal operations, you may wish to move a device acting as a rack controller from one MAAS instance to another.  From the point of view of MAAS, there is no such action as moving a rack controller, although you can delete a rack controller from one MAAS and reinstantiate the same controller (binary-wise) on another MAAS instance. From your perspective, of course, you are moving one box performing rack controller functions, either physically or network-wise, from one MAAS to another. 

<a href="#heading--How-to-move-the-controller"><h3 id="heading--How-to-move-the-controller">How to move the controller</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To move a rack controller using the MAAS UI, first, delete the rack controller.  In the "Controllers" tab in the UI, select the rack controller you with to delete, choose "Take action" and select "Delete."  You will be asked to confirm with a red button, entitled "Delete 1 controller."
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
In effect, there is no such action as moving a rack controller, although you can delete a rack controller from one MAAS and reinstantiate the same controller (binary-wise) on another MAAS instance.  First, delete the rack controller, with the command:

```
maas $PROFILE rack-controller delete $SYSTEM_ID
```

where `$PROFILE` is your admin profile name, and `$SYSTEM_ID` can be found by examining the output of the command:

```
maas $PROFILE rack-controllers read
```

There is no confirmation step, so make sure you have the right rack controller before proceeding.
[/tab]
[/tabs]

Next, you must register a new rack controller, which is always done from the command line.

[tabs]
[tab version="v3.3 Snap"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[tab version="v3.3 Packages"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.
[/tab]
[tab version="v3.2 Snap"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[tab version="v3.2 Packages"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.
[/tab]
[tab version="v3.1 Snap"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[tab version="v3.1 Packages"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.
[/tab]
[tab version="v3.0 Snap"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[tab version="v3.0 Packages"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.
[/tab]
[tab version="v2.9 Snap"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[tab version="v2.9 Packages"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.
[/tab]
[/tabs]

Note that in the UI, if you go to the "Controllers" tab and press the button entitled, "Add rack controller," at the top of the Controllers screen, MAAS will give you a complete command string, including the correct URL and secret values.  Simply cut and paste that string to move the rack controller, paying attention to whether you are using snap or package build modes.

<a href="#heading--postgresql-setup"><h2 id="heading--postgresql-setup">How to set up PostgreSQL for the region</h2></a>

Any number of API servers (region controllers) can be present as long as each connects to the same PostgreSQL database and allows the required number of connections.

On the primary database host, edit file <code>/etc/postgresql/9.5/main/pg_hba.conf</code> to allow the eventual secondary API server to contact the primary PostgreSQL database. Include the below line, replacing
<code>$SECONDARY_API_SERVER_IP</code> with the IP address of the host that will contain the secondary API server:

    host maasdb maas $SECONDARY_API_SERVER_IP/32 md5

[note]
The primary database and API servers often reside on the same host.
[/note]

Apply this change by restarting the database:

    sudo systemctl restart postgresql

<a href="#heading--adding-a-new-region-host"><h2 id="heading--adding-a-new-region-host">How to add a new region host</h2></a>

On a secondary host, add the new region controller by installing <code>maas-region-api</code>:

    sudo apt install maas-region-api

You will need the <code>/etc/maas/regiond.conf</code> file from the primary API server. Below, we assume it can be copied (scp) from the ‘ubuntu’ account home directory using password authentication (adjust otherwise). The <code>local_config_set</code> command will edit that file by pointing to the host that contains the primary PostgreSQL database. Do not worry: MAAS will rationalise the DNS (<code>bind9</code>) configuration options so that they match those used within MAAS:

    sudo systemctl stop maas-regiond
    sudo scp ubuntu@$PRIMARY_API_SERVER:regiond.conf /etc/maas/regiond.conf
    sudo chown root:maas /etc/maas/regiond.conf
    sudo chmod 640 /etc/maas/regiond.conf
    sudo maas-region local_config_set --database-host $PRIMARY_PG_SERVER
    sudo systemctl restart bind9
    sudo systemctl start maas-regiond

Check three log files for any errors:

[tabs]
[tab version="v3.3 Snap"]
1. <code>/var/snap/maas/common/log/regiond.log</code>
2. <code>/var/snap/maas/common/log/maas.log</code>
3. <code>/var/snap/maas/common/log/rsyslog/</code>
[/tab]
[tab version="v3.3 Packages"]
1. <code>/var/log/maas/regiond.log</code>
2. <code>/var/log/maas/maas.log</code>
3. <code>/var/log/syslog</code>
[/tab]
[tab version="v3.2 Snap"]
1. <code>/var/snap/maas/common/log/regiond.log</code>
2. <code>/var/snap/maas/common/log/maas.log</code>
3. <code>/var/snap/maas/common/log/rsyslog/</code>
[/tab]
[tab version="v3.2 Packages"]
1. <code>/var/log/maas/regiond.log</code>
2. <code>/var/log/maas/maas.log</code>
3. <code>/var/log/syslog</code>
[/tab]
[tab version="v3.1 Snap"]
1. <code>/var/snap/maas/common/log/regiond.log</code>
2. <code>/var/snap/maas/common/log/maas.log</code>
3. <code>/var/snap/maas/common/log/rsyslog/</code>
[/tab]
[tab version="v3.1 Packages"]
1. <code>/var/log/maas/regiond.log</code>
2. <code>/var/log/maas/maas.log</code>
3. <code>/var/log/syslog</code>
[/tab]
[tab version="v3.0 Snap"]
1. <code>/var/snap/maas/common/log/regiond.log</code>
2. <code>/var/snap/maas/common/log/maas.log</code>
3. <code>/var/snap/maas/common/log/rsyslog/</code>
[/tab]
[tab version="v3.0 Packages"]
1. <code>/var/log/maas/regiond.log</code>
2. <code>/var/log/maas/maas.log</code>
3. <code>/var/log/syslog</code>
[/tab]
[tab version="v2.9 Snap"]
1. <code>/var/snap/maas/common/log/regiond.log</code>
2. <code>/var/snap/maas/common/log/maas.log</code>
3. <code>/var/snap/maas/common/log/rsyslog/</code>
[/tab]
[tab version="v2.9 Packages"]
1. <code>/var/log/maas/regiond.log</code>
2. <code>/var/log/maas/maas.log</code>
3. <code>/var/log/syslog</code>
[/tab]
[/tabs]

<a href="#heading--increasing-regiond-daemon-workers"><h2 id="heading--increasing-regiond-daemon-workers">How to improve region controller performance</h2></a>

[note]
This functionality is available starting from MAAS 2.4.
[/note]

The MAAS Region Controller is a daemon collection of 4 workers that are in charge of handling all the internals of MAAS. The regiond workers handle the UI, API and the internal communication between Region and Rack controllers.

In larger environments, which multiple rack controllers, you can easily improve performance within a region.  You can increase the number of workers, which allows faster (parallel) handling of internal communication between region and rack controllers.

Increasing the number of workers will also increase the number of required database connections by 11 per extra worker. This may required PostgreSQL to have an increased number of allowed connections; please see [the high availability article](/t/how-to-enable-high-availability/5120#heading--region-controller-ha) for more information on increasing the connections.

To increase the number of workers, simply edit <code>regiond.conf (/etc/maas/regiond.conf)</code> and set <code>num_workers</code>. For example:

    [...]
    num_workers: 8

Keep in mind that adding too many workers may <em>reduce</em> performance. We recommended one worker per CPU, up to eight workers in total. Increasing beyond that is possible but use at your own risk.