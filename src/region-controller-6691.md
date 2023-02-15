<a href="#heading--region-controller"><h3 id="heading--region-controller">About region controllers</h3></a>

A region controller consists of the following components:

- REST API server (TCP port 5240)
- PostgreSQL database
- DNS
- caching HTTP proxy
- web UI

Region controllers are responsible for either a data centre or a single region. Multiple fabrics are used by MAAS to accommodate subdivisions within a single region, such as multiple floors in a data centre.

