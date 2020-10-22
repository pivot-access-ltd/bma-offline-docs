<!-- deb-2-7-cli
 deb-2-7-cli -->

<!-- deb-2-7-ui
 deb-2-7-ui -->

<!-- deb-2-8-cli
 deb-2-8-cli -->

<!-- deb-2-8-ui
 deb-2-8-ui -->

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

Most of the functionality of MAAS is contained in a series of controllers.  There are two basic types: a region controller and one or more rack controllers. The region controller deals with operator requests, while the rack controller(s) provides high-bandwidth services to the individual machines.  In essence, the region controller interacts with the user, while the rack controllers manage the bare metal.

<!-- deb-2-7-cli
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/-/2688).

deb-2-7-cli -->

<!-- deb-2-7-ui
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/-/2689).

deb-2-7-ui -->

<!-- deb-2-8-cli
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/high-availability/2690).

deb-2-8-cli -->

<!-- deb-2-8-ui
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/high-availability/2691).

deb-2-8-ui -->

<!-- deb-2-9-cli
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/high-availability/2692).

deb-2-9-cli -->

<!-- deb-2-9-ui
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/high-availability/2693).

deb-2-9-ui -->

<!-- snap-2-7-cli
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/high-availability/2682).

snap-2-7-cli -->

<!-- snap-2-7-ui
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/high-availability/2683).

snap-2-7-ui -->

<!-- snap-2-8-cli
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/high-availability/2684).

snap-2-8-cli -->

<!-- snap-2-8-ui
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/high-availability/2685).

snap-2-8-ui -->

<!-- snap-2-9-cli
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/high-availability/2686).

snap-2-9-cli -->

<!-- snap-2-9-ui
<strong>NOTE:</strong> 
Note that both region and rack controllers can be scaled out, as well as made [highly available](/t/high-availability/2687).

snap-2-9-ui -->

#### Quick questions you might have:

* [What does a region controller do?](#heading--region-controller)
* [What does a rack controller do?](#heading--rack-controllers)

<h2 id="heading--region-controller">What a region controller does</h2>

A region controller consists of:

-   REST API server (TCP port 5240)
-   PostgreSQL database
-   DNS
-   caching HTTP proxy
-   web UI

Region controllers are responsible for either a data centre or a single region. Multiple fabrics are used by MAAS to accommodate subdivisions within a single region, such as multiple floors in a data centre.

<h2 id="heading--rack-controllers">What a rack controller does</h2>

A rack controller provides:

-   DHCP
-   TFTP
-   HTTP (for images)
-   power management

A rack controller is attached to each "fabric". As the name implies, a typical setup is to have a rack controller in each data centre server rack. The rack controller will cache large items for performance, such as operating system install images, but maintains no independent state other than the credentials required to talk to the region controller.

<details><summary>Tell me about fabrics</summary>

A fabric is simply a way of linking [VLANs](/t/concepts-and-terms/785#heading--vlans) (Virtual LANs) together.  If you're familiar with a VLAN, you know that it's designed to limit network traffic to specific ports (e.g., on a [switch](/t/concepts-and-terms/785#heading--switch)) or by evaluating labels called "tags" (unrelated to MAAS tags).  By definition, this would mean that two VLANs can't communicate with each other -- it would defeat the purpose of the VLAN -- unless you implement some extraordinary measures.

<!-- deb-2-7-cli
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2652) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
deb-2-7-cli -->

<!-- deb-2-7-ui
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2653) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
deb-2-7-ui -->

<!-- deb-2-8-cli
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2654) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
deb-2-8-cli -->

<!-- deb-2-8-ui
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2655) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
deb-2-9-ui -->

<!-- deb-2-9-cli
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2656) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
deb-2-9-cli -->

<!-- deb-2-9-ui
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2657) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
deb-2-9-ui -->

<!-- snap-2-7-cli
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2646) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
snap-2-7-cli -->

<!-- snap-2-7-ui
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2647) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
snap-2-7-ui -->

<!-- snap-2-8-cli
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2648) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
snap-2-8-cli -->

<!-- snap-2-8-ui
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2649) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
snap-2-8-ui -->

<!-- snap-2-9-cli
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2650) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
snap-2-9-cli -->

<!-- snap-2-9-ui
For example, let's say that your [hospital](/t/give-me-an-example-of-maas/2651) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.
snap-2-9-ui -->


You can learn more about fabrics in the [Concepts and terms](/t/concepts-and-terms/785#heading--fabrics) section of this documentation.