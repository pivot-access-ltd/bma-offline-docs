<!-- deb-2-7-cli
 deb-2-7-cli -->

<!-- deb-2-7-ui
 deb-2-7-ui -->

<!-- deb-2-8-cli
 deb-2-8-cli -->


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

This page provides several useful examples of MAAS zone usage.

<a href="#heading--fault-tolerance"><h2 id="heading--fault-tolerance">Fault tolerance</h2></a>

Fault tolerance is "the property that enables a system to continue operating properly in the event of the failure of (or one or more faults within) some of its components". To help create better fault tolerance, multiple MAAS zones can be employed.

For this, a zone can be defined in different ways. It can be based on power supply for instance, or it can represent a portion of your network or an entire data centre location.

Machines that work in tandem in order to provide an instance of a service should be allocated in the same zone. The entire service should be replicated in another zone.

<a href="#heading--service-performance"><h2 id="heading--service-performance">Service performance</h2></a>

Service performance is the ability of your service to operate in the most efficient manner possible where the typical criteria used is speed. Multiple MAAS zones can be used to help.

Nodes should be allocated in the zone closest to the performance-critical resources they need.

For example, for applications that are highly sensitive to network latency, it may make sense to design a network topology consisting of several smaller networks, and have each of those represented as a zone. The zones can then be used to allocate nodes that have the best performance depending on the service offered.

<a href="#heading--power-management"><h2 id="heading--power-management">Power management</h2></a>

Power management is concerned with power usage density and cooling. This topic can be addressed with the use of several MAAS zones.

Nodes can be distributed in such a way that power-hungry and/or "hot" systems are located in different zones. This can help mitigate power consumption and heat problems.