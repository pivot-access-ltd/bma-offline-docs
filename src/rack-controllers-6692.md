<!-- Rack controllers -->

A rack controller provides four services:

- DHCP
- TFTP
- HTTP (for images)
- power management

A rack controller is attached to each "fabric". As the name implies, a typical setup is to have a rack controller in each data centre server rack. The rack controller will cache large items for performance, such as operating system install images, but maintains no independent state other than the credentials required to talk to the region controller.

## Tell me about fabrics

A fabric is simply a way of linking [VLANs](/t/maas-glossary/5416#heading--vlans) (Virtual LANs) together.  If you're familiar with a VLAN, you know that it's designed to limit network traffic to specific ports (e.g., on a [switch](/t/maas-glossary/5416#heading--switch)) or by evaluating labels called "tags" (unrelated to MAAS tags).  By definition, this would mean that two VLANs can't communicate with each other -- it would defeat the purpose of the VLAN -- unless you implement some extraordinary measures.

For example, let's say that your [hospital](/t/bootstrap-maas/5092) has three key functions: Patient management, Accounting, and Facilities, each on their own VLAN.  Let's say that there are some situations in which you need to share data between all three of these functions.  To accomplish this, you can create a fabric that joins these three VLANS.  Since this fabric just makes it possible for these VLANs to communicate, you can manage the cross-VLAN access with additional software, or permissions, depending on your application software architecture.

You can learn more about fabrics in the [Concepts and terms](/t/maas-glossary/5416#heading--fabrics) section of this documentation.

