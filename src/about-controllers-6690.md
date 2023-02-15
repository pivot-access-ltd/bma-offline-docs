Controllers are the backbone of MAAS.  Depending on your network configuration and your machine count, you may want to [adjust your controllers](/t/how-to-adjust-your-controllers/5172) a bit at this point.  You might even want to set up a [high availability](/t/how-to-enable-high-availability/5120) configuration.

It helps to have a baseline understanding of controllers.  You can find that explained in the rest of this article.

<a href="#heading--MAAS-controller-fundamentals"><h2 id="heading--MAAS-controller-fundamentals">MAAS controller fundamentals</h2></a>

Most of the functionality of MAAS is contained in a series of controllers.  There are two basic types: a region controller and one or more rack controllers. The region controller deals with operator requests, while the rack controller(s) provides high-bandwidth services to the individual machines.  In essence, the region controller interacts with the user, while the rack controllers manage the bare metal.

