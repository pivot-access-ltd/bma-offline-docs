<!-- "About high availability" -->
High availability is built into MAAS: region and rack controllers balance the load and execute failover as part of normal operations.

<a href="#heading--High-availability-mode"><h2 id="heading--High-availability-mode">High availability mode</h2></a>

You only need to install multiple rack controllers to achieve real high availability. Once that’s done, you automatically gain highly-available BMC control and highly-available DHCP. MAAS is constantly trying to answer three questions:

1. How many racks is each region managing?
2. How many connections does a given rack controller have?
3. How many regions – and region “worker processes” are running right now?

With just one rack, most of the logic can’t function. On the other hand, when you have multiple racks (and especially multiple regions), MAAS will continuously balance the load.

Every time a rack controller connects to a region controller to do something, MAAS checks whether racks and regions are balanced. If the ratio for one rack-region connection is above a moderate threshold, compared to other connections, MAAS will re-balance. This activity includes balancing not only discrete region controllers, but also re-distributing connections so that no single worker process has an uneven share of the load.

Re-balancing is also done at various other opportune times. For example, if a network change happens (like toggling DHCP or changing a VLAN), MAAS will also re-balance the load. And MAAS can maintain primary and secondary rack designations, so that faster, more nuanced load-balancing can occur.

<a href="#heading--BMC-control-node-power-cycling"><h2 id="heading--BMC-control-node-power-cycling">BMC control (node power cycling)</h2></a>

You can also enable HA for BMC control (node power cycling) just by adding a second rack controller. MAAS will automatically identify which rack controller is responsible for a BMC, continuously balancing the connections.

<a href="#heading--HA-DHCP"><h2 id="heading--HA-DHCP">HA DHCP</h2></a>

You can enable highly-available DHCP services by using MAAS-managed DHCP, and adding rack controllers. This DHCP HA affects the way MAAS manages nodes, including enlistment, commissioning and deployment. It enables primary and secondary DHCP instances to serve the same VLAN. This VLAN replicates all lease information is between rack controllers, so there’s a bit of performance boost for large networks.

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

Note that the only difference from a standard 50/50 split (split 128) is that the primary DHCP server answers any requests that it can (split 255), within the maximum response delay of 60 seconds and an unacknowledged update count of 10. In this sense, highly-available MAAS DHCP fails over only when absolutely necessary.

If you are enabling DHCP for the first time after adding a second rack controller, please read about [enabling DHCP](/t/how-to-enable-dhcp/5132). On the other hand, if you have already enabled DHCP on your initial rack controller, you’ll need to reconfigure DHCP to get optimum results.

MAAS will automatically discover and track all reachable region controllers in a single cluster of rack controllers. It will also attempt to automatically connect to them if the one in use becomes inaccessible. Administrators can alternatively specify multiple region-controller endpoints for a single rack controller by adding entries to `rackd.conf`.

 This article will help you understand how to take advantage of these built-in features.

<a href="#heading--rack-controller-ha"><h2 id="heading--rack-controller-ha">How to put MAAS in HA mode</h2></a>

You only need to [install multiple rack controllers](/t/how-to-configure-controllers/5172#heading--install-a-rack-controller) to achieve real high availability.  Once that's done, you automatically gain highly-available BMC control and highly-available DHCP.  MAAS is constantly trying to answer three questions:

- How many racks is each region managing?
- How many connections does a given rack controller have?
- How many regions -- and region "worker processes" are running right now?

With just one rack, most of the logic can't function.  On the other hand, when you have multiple racks (and especially multiple regions), MAAS will continuously balance the load.

Every time a rack controller connects to a region controller to do something, MAAS checks whether racks and regions are balanced.  If the ratio for one rack-region connection is above a moderate threshold, compared to other connections, MAAS will re-balance.  This activity includes balancing not only discrete region controllers, but also re-distributing connections so that no single worker process has an uneven share of the load.

Rebalancing is also done at various other opportune times.  For example, if a network change happens (like toggling DHCP or changing a VLAN), MAAS will also re-balance the load.  And MAAS can maintain primary and secondary rack designations, so that faster, more nuanced load-balancing can occur.

<a href="#heading--bmc-ha"><h3 id="heading--bmc-ha">How to enable highly-available BMC</h3></a>

You can also enable HA for BMC control (node power cycling) just by adding a second rack controller. MAAS will automatically identify which rack controller is responsible for a BMC, continuously balancing the connections.

<a href="#heading--dhcp-ha"><h3 id="heading--dhcp-ha">How to enable highly-available DHCP services</h3></a>

You can enable highly-availalbe DHCP services by using MAAS-managed DHCP, and adding rack controllers.  This DHCP HA affects the way MAAS manages nodes, including enlistment, commissioning and deployment. It enables primary and secondary DHCP instances to serve the same VLAN. This VLAN replicates all lease information is between rack controllers, so there's a bit of performance boost for large networks.

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

If you are enabling DHCP for the first time after adding a second rack controller, please read about [enabling DHCP](/t/how-to-enable-dhcp/5132#heading--enabling-dhcp).  On the other hand, if you have already enabled DHCP on your initial rack controller, you'll need to reconfigure DHCP to get optimum results.

