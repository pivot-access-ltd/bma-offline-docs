<!-- "How to enable high availability" -->
High availability is built into MAAS: region and rack controllers balance the load and execute failover as part of normal operations. This article will help you understand how to take advantage of these built-in features.

<a href="#heading--rack-controller-ha"><h2 id="heading--rack-controller-ha">How to put MAAS in HA mode</h2></a>

You only need to [install multiple rack controllers](/t/how-to-adjust-your-controllers/5172#heading--install-a-rack-controller) to achieve real high availability.  Once that's done, you automatically gain highly-available BMC control and highly-available DHCP.  MAAS is constantly trying to answer three questions:

- How many racks is each region managing?
- How many connections does a given rack controller have?
- How many regions -- and region "worker processes" are running right now?

With just one rack, most of the logic can't function.  On the other hand, when you have multiple racks (and especially multiple regions), MAAS will continuously balance the load.

Every time a rack controller connects to a region controller to do something, MAAS checks whether racks and regions are balanced.  If the ratio for one rack-region connection is above a moderate threshold, compared to other connections, MAAS will re-balance.  This activity includes balancing not only discrete region controllers, but also re-distributing connections so that no single worker process has an uneven share of the load.

Re-balancing is also done at various other opportune times.  For example, if a network change happens (like toggling DHCP or changing a VLAN), MAAS will also re-balance the load.  And MAAS can maintain primary and secondary rack designations, so that faster, more nuanced load-balancing can occur.

<a href="#heading--bmc-ha"><h3 id="heading--bmc-ha">How to enable highly-available BMC</h3></a>

You can also enable HA for BMC control (node power cycling) just by adding a second rack controller. MAAS will automatically identify which rack controller is responsible for a BMC, continuously balancing the connections.

<a href="#heading--dhcp-ha"><h3 id="heading--dhcp-ha">How to enable highly-available DHCP services</h3></a>

You can enable highly-available DHCP services by using MAAS-managed DHCP, and adding rack controllers.  This DHCP HA affects the way MAAS manages nodes, including enlistment, commissioning and deployment. It enables primary and secondary DHCP instances to serve the same VLAN. This VLAN replicates all lease information is between rack controllers, so there's a bit of performance boost for large networks.

MAAS DHCP automatically creates failover peers, using mostly standard parameters:

```nohighlight
failover peer "failover-partner" {
     primary;
     address dhcp-primary.example.com;
     peer address dhcp-secondary.example.com;
     max-response-delay 60;
     max-unacked-updates 10;
     mclt 3600;
     split 255;
     load balance max seconds 3;
}
failover peer "failover-partner" {
     secondary;
     address dhcp-secondary.example.com;
     peer address dhcp-primary.example.com;
     max-response-delay 60;
     max-unacked-updates 10;
     load balance max seconds 3;
}
```
Note that the only difference from a standard 50/50 split (`split 128`) is that the primary DHCP server answers any requests that it can (`split 255`), within the maximum response delay of 60 seconds and an unacknowledged update count of 10.  In this sense, highly-available MAAS DHCP fails over only when absolutely necessary.

If you are enabling DHCP for the first time after adding a second rack controller, please read [Enabling DHCP](/t/how-to-enable-dhcp/5132#heading--enabling-dhcp).  On the other hand, if you have already enabled DHCP on your initial rack controller, you'll need to reconfigure DHCP to get optimum results.

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To reconfigure DHCP after adding a new rack controller:

1. Select *Subnets*.

2. Select the appropriate VLAN.

3. Choose *Reconfigure DHCP*.

4. Confirm that you can see the second rack controller under *Secondary controller*.

5. Select *Reconfigure DHCP*.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To reconfigure DHCP after adding a new rack controller, use the following sequence of commands:

```
vid=$(maas maas subnets read | jq -r '.[] | select(.cidr == "10.0.0.0/24") | .vlan.vid')
fabric_name=$(maas maas subnets read | jq -r '.[] | select(.cidr == "10.0.0.0/24") | .vlan.fabric')
query=".[] | select(.name == \"$fabric_name\") | .id"
fabric_id=$(maas maas fabrics read | jq "$query")
maas maas ipranges create type=reserved start_ip=10.0.0.3 end_ip=10.0.0.49
maas maas ipranges create type=dynamic start_ip=10.0.0.50 end_ip=10.0.0.99
maas maas vlan update ${fabric_id} ${vid} primary_rack=$(hostname) dhcp_on=true
```

Be sure to substitute the sample values for those of your own environment.
[/tab]
[/tabs]

<a href="#heading--multiple-region-endpoints"><h3 id="heading--multiple-region-endpoints">How to configure multiple region endpoints</h3></a>

[tabs]
[tab version="v3.3 Snap,v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap"]
MAAS will automatically discover and track all reachable region controllers in a single cluster of rack controllers  It will also attempt to automatically connect to them if the one in use becomes inaccessible.  Administrators can alternatively specify multiple region-controller endpoints for a single rack controller by adding entries to `/var/snap/maas/current/rackd.conf`.  For example:
[/tab]
[tab version="v3.3 Packages,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages"]
MAAS will automatically discover and track all reachable region controllers in a single cluster of rack controllers  It will also attempt to automatically connect to them if the one in use becomes inaccessible.  Administrators can alternatively specify multiple region-controller endpoints for a single rack controller by adding entries to `/etc/maas/rackd.conf`.  For example:
[/tab]
[/tabs]
    .
    .
    .
    maas_url:
      - http://<ip 1>:<port>/MAAS/
      - http://<ip 2>:<port>/MAAS/
    .
    .
    .

The setup of highly-available DHCP is now complete.  Note that, for HA purposes, DHCP provisioning will take into account multiple DNS services when there is more than one region controller on a single region.

<a href="#heading--region-controller-ha"><h2 id="heading--region-controller-ha">How to make region controllers highly available</h2></a>

Implementing highly-available region control is possible when you learn:

- [How to enable highly-available PostgreSQL](#heading--postgresql-ha)
- [How to enable highly-available API services](#heading--secondary-api-servers)
- [How to set up load balancing with HAProxy (optional)](#heading--load-balancing-with-haproxy-optional)

Load balancing is optional, but is highly recommended.

<a href="#heading--postgresql-ha"><h3 id="heading--postgresql-ha">How to enable highly-available PostgreSQL</h3></a>

MAAS stores all state information in the PostgreSQL database. It is therefore recommended to run it in HA mode. Configuring HA for PostgreSQL is external to MAAS. You will, therefore, need to study the [PostgreSQL documentation](https://www.postgresql.org/docs/9.5/static/high-availability.html)`↗` and implement the variant of HA that makes you feel most comfortable.

Each region controller uses up to 40 connections to PostgreSQL in high load situations. Running two region controllers requires no modifications to the `max_connections` in `postgresql.conf`. More than two region controllers require that `max_connections` be adjusted to add 40 more connections per added region controller.

<a href="#heading--secondary-api-servers"><h3 id="heading--secondary-api-servers">How to enable highly-available API services</h3></a>

[tabs]
[tab version="v3.3 Snap"]
Setting up high-availability using snaps is relatively easy:

1.  Set up PostgreSQL for high-availability as [explained above](#heading--postgresql-ha). PostgreSQL should run outside of the snap.
2.  [Install](/t/how-to-install-maas/5128#heading--install-from-snap) the MAAS snap on each machine you intend to use as a rack or region controller. You'll need the MAAS shared secret, located here, `/var/snap/maas/common/maas/secret`, on the first region controller you set up.
3.  [Initialise the snap](/t/how-to-install-maas/5128#heading--initialisation) as a `rack` or `region` controller.

Note that if you intend to use a machine as a region controller, you'll need to tell MAAS how to access your PostgreSQL database host with the following arguments:

- `--database-host DATABASE_HOST`
- `--database-name DATABASE_NAME`
- `--database-user DATABASE_USER`
- `--database-pass DATABASE_PASS`
[/tab]
[tab version="v3.3 Packages"]
Please see [Region controllers](/t/how-to-manage-controllers/5172) and [Multiple region endpoints](#heading--multiple-region-endpoints) for more information about how to install and configure rack controllers for multiple region controllers.
[/tab]
[tab version="v3.2 Snap"]
Setting up high-availability using snaps is relatively easy:

1.  Set up PostgreSQL for high-availability as [explained above](#heading--postgresql-ha). PostgreSQL should run outside of the snap.
2.  [Install](/t/how-to-install-maas/5128#heading--install-from-snap) the MAAS snap on each machine you intend to use as a rack or region controller. You'll need the MAAS shared secret, located here, `/var/snap/maas/common/maas/secret`, on the first region controller you set up.
3.  [Initialise the snap](/t/how-to-install-maas/5128#heading--initialisation) as a `rack` or `region` controller.

Note that if you intend to use a machine as a region controller, you'll need to tell MAAS how to access your PostgreSQL database host with the following arguments:

- `--database-host DATABASE_HOST`
- `--database-name DATABASE_NAME`
- `--database-user DATABASE_USER`
- `--database-pass DATABASE_PASS`
[/tab]
[tab version="v3.2 Packages"]
Please see [Region controllers](/t/how-to-manage-controllers/5172) and [Multiple region endpoints](#heading--multiple-region-endpoints) for more information about how to install and configure rack controllers for multiple region controllers.
[/tab]
[tab version="v3.1 Snap"]
Setting up high-availability using snaps is relatively easy:

1.  Set up PostgreSQL for high-availability as [explained above](#heading--postgresql-ha). PostgreSQL should run outside of the snap.
2.  [Install](/t/how-to-install-maas/5128#heading--install-from-snap) the MAAS snap on each machine you intend to use as a rack or region controller. You'll need the MAAS shared secret, located here, `/var/snap/maas/common/maas/secret`, on the first region controller you set up.
3.  [Initialise the snap](/t/how-to-install-maas/5128#heading--initialisation) as a `rack` or `region` controller.

Note that if you intend to use a machine as a region controller, you'll need to tell MAAS how to access your PostgreSQL database host with the following arguments:

- `--database-host DATABASE_HOST`
- `--database-name DATABASE_NAME`
- `--database-user DATABASE_USER`
- `--database-pass DATABASE_PASS`
[/tab]
[tab version="v3.1 Packages"]
Please see [Region controllers](/t/how-to-manage-controllers/5172) and [Multiple region endpoints](#heading--multiple-region-endpoints) for more information about how to install and configure rack controllers for multiple region controllers.
[/tab]
[tab version="v3.0 Snap"]
Setting up high-availability using snaps is relatively easy:

1.  Set up PostgreSQL for high-availability as [explained above](#heading--postgresql-ha). PostgreSQL should run outside of the snap.
2.  [Install](/t/how-to-install-maas/5128#heading--install-from-snap) the MAAS snap on each machine you intend to use as a rack or region controller. You'll need the MAAS shared secret, located here, `/var/snap/maas/common/maas/secret`, on the first region controller you set up.
3.  [Initialise the snap](/t/how-to-install-maas/5128#heading--initialisation) as a `rack` or `region` controller.

Note that if you intend to use a machine as a region controller, you'll need to tell MAAS how to access your PostgreSQL database host with the following arguments:

- `--database-host DATABASE_HOST`
- `--database-name DATABASE_NAME`
- `--database-user DATABASE_USER`
- `--database-pass DATABASE_PASS`
[/tab]
[tab version="v3.0 Packages"]
Please see [Region controllers](/t/how-to-manage-controllers/5172) and [Multiple region endpoints](#heading--multiple-region-endpoints) for more information about how to install and configure rack controllers for multiple region controllers.
[/tab]
[tab version="v2.9 Snap"]
Setting up high-availability using snaps is relatively easy:

1.  Set up PostgreSQL for high-availability as [explained above](#heading--postgresql-ha). PostgreSQL should run outside of the snap.
2.  [Install](/t/how-to-install-maas/5128#heading--install-from-snap) the MAAS snap on each machine you intend to use as a rack or region controller. You'll need the MAAS shared secret, located here, `/var/snap/maas/common/maas/secret`, on the first region controller you set up.
3.  [Initialise the snap](/t/how-to-install-maas/5128#heading--initialisation) as a `rack` or `region` controller.

Note that if you intend to use a machine as a region controller, you'll need to tell MAAS how to access your PostgreSQL database host with the following arguments:

- `--database-host DATABASE_HOST`
- `--database-name DATABASE_NAME`
- `--database-user DATABASE_USER`
- `--database-pass DATABASE_PASS`
[/tab]
[tab version="v2.9 Packages"]
Please see [Region controllers](/t/how-to-manage-controllers/5172) and [Multiple region endpoints](#heading--multiple-region-endpoints) for more information about how to install and configure rack controllers for multiple region controllers.
[/tab]
[/tabs]

<a href="#heading--load-balancing-with-haproxy-optional"><h3 id="heading--load-balancing-with-haproxy-optional">How to enable load balancing for API services</h3></a>

You can add load balancing with [HAProxy](http://www.haproxy.org/)`↗` load-balancing software to support multiple API servers. In this setup, HAProxy provides access to the MAAS web UI and API.

[note]
If you happen to have Apache running on the same server where you intend to install HAProxy, you will need to stop and disable `apache2`, because HAProxy binds to port 80.
[/note]

<a href="#heading--install"><h4 id="heading--install">How to install HAProxy</h4></a>

``` bash
sudo apt install haproxy
```

<a href="#heading--configure"><h4 id="heading--configure">How to configure HAProxy</h4></a>

Configure each API server's load balancer by copying the following into `/etc/haproxy/haproxy.cfg` (see the [upstream configuration manual (external link)](http://cbonte.github.io/haproxy-dconv/1.6/configuration.html)`↗` as a reference). Replace $PRIMARY_API_SERVER_IP and $SECONDARY_API_SERVER_IP with their respective IP addresses:

``` yaml
frontend maas
    bind    *:80
    retries 3
    option  redispatch
    option  http-server-close
    default_backend maas

backend maas
    timeout server 90s
    balance source
    hash-type consistent
    server localhost localhost:5240 check
    server maas-api-1 $PRIMARY_API_SERVER_IP:5240 check
    server maas-api-2 $SECONDARY_API_SERVER_IP:5240 check
```

where `maas-api-1` and `maas-api-2` are arbitrary server labels.

Now restart the load balancer to have these changes take effect:

``` bash
sudo systemctl restart haproxy
```

The configuration of region controller HA is now complete.

**The API server(s) must be now be referenced (e.g. web UI, MAAS CLI) using port 80 (as opposed to port 5240).**

<a href="#heading--move-rack-controller"><h2 id="heading--move-rack-controller">Move a rack controller from one MAAS instance to another</h2></a>

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
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas-rack register --url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/lib/maas/secret`.

Note that in the UI, if you go to the "Controllers" tab and press the button entitled, "Add rack controller," at the top of the Controllers screen, MAAS will give you a complete command string, including the correct URL and secret values.  Simply cut and paste that string to move the rack controller, paying attention to whether you are using snap or package build modes.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
For this exercise, we're assuming you are using the already installed rack controller code that was previously running on the "from" MAAS instance.  All that's necessary is that you register a new rack controller with the "to" MAAS instance, like this:

```
sudo maas init rack --maas-url $MAAS_URL_OF_NEW_MAAS --secret $SECRET_FOR_NEW_MAAS
```

where the secret is found in `/var/snap/maas/common/maas/secret`.
[/tab]
[/tabs]

<a href="#heading--move-rack-controller"><h3 id="heading--dangers-moving-rack-controller">How to avoid the potential pitfalls of moving a rack controller</h3></a>

There are dangers associate with moving a rack controller -- dangers that may generate errors, get you into a non-working state, or cause you significant data loss.  These dangers are precipitated by one caveat and two potential mistakes:

* **Using the same system as a rack controller and a VM host:** While not forbidden or inherently dangerous, using the same machine as both a rack controller and a VM host may cause resource contention and poor performance.  If the resources on the system are not more than adequate to cover both tasks, you may see slowdowns (or even apparent "freeze" events) on the system.

* **Moving a rack controller from one version of MAAS to another:** MAAS rack controller software is an integral part of each version of MAAS.  If you delete a rack controller from, say, a 2.6 version of MAAS, and attempt to register that 2.6 version of the rack controller code to, say, a 2.9 version of MAAS, you may experience errors and potential data loss.  Using the above example, if you are running both a VM host and a rack controller for MAAS 2.6 on one system, and you suddenly decide to delete that rack controller from 2.6 and attempt to register the same code to a 2.9 MAAS, the VM host may fail or disappear.  This will possibly delete all the VMs you have created or connected to that VM host -- which may result in data loss.  This action is not supported.

* **Connecting one instance of a rack controller to two instances of MAAS, regardless of version:** Trying to connect a single rack controller to two different instances of MAAS can result in all sorts of unpredictable (and potentially catastrophic) behaviour.  It is not a supported configuration.

Take these warnings to heart.  It may seem like a faster approach to "bridge" your existing rack controllers from one MAAS to another -- or from one version of MAAS to another -- while they're running.  Ultimately, though, it will probably result in more work than just following the recommended approach.
