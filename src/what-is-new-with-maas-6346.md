<!-- "MAAS 3.2 release notes" -->

Here you will find release notes for:

- [The current version of MAAS](#heading--current-maas-release-notes)
- [Other MAAS versions](#heading--other-maas-versions)

<a href="#heading--3-3-0-maas-release-notes"><h2 id="heading--3-3-0-maas-release-notes">MAAS 3.3 release notes</h2></a>

We are happy to announce that MAAS 3.3 has been released, with concerted efforts to improve MAAS on multiple fronts. New features include:

- [Ansible playbooks for HA MAAS, PostgreSQL, and other MAAS configurations](#heading--ansible-playbooks)
- [Integratation of Vault for credential storage](#heading--vault-integration)

Improved capabilities include the following:

- [Native support for 22.04 LTS and core22](#heading--22-04-support)
- [Reliability improvements for simultaneous machine deployments](#heading--simultaneous-deployment-improvements)
- [The first phase of Nvidia DPU support](#heading--nvidia-dpu-support)

Greatly expanded documentation includes:

- [Shifting the MAAS API documentation to OpenAPI standards](#heading--openapi-support)
- [MAAS Configuration settings reference](#heading--maas-config-settings-ref)

Read on to catch up with what we've done this cycle.

<a href="#heading--ansible-playbooks"><h3 id="heading--ansible-playbooks">Ansible playbooks for HA MAAS, PostgreSQL, and other MAAS configurations</h3></a>

[Ansible](https://www.redhat.com/en/technologies/management/ansible/what-is-ansible) [playbooks](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html) are now available for MAAS.  These extended YAML files automate various routine aspects of MAAS setup and configuration.  Playbooks are available to:

- install and configure a MAAS region on a targeted host; running the playbook on hosts with a MAAS region will upgrade it.
- install and configure a MAAS rack.
- setup the postgres primary role.
- setup the postgres secondary role.
- setup firewall rules.

MAAS Playbooks are available from a [repository](https://github.com/maas/MAAS-ansible-playbook).  They will eventually be available through Ansible Galaxy.

There is also a set of groups that will automate setting up specific sections of MAAS.  For example, there is a PostgreSQL group that sets up the primary and secondary PostgreSQL roles, bypassing the need to run both playbooks individually.

After installing ansible, running each of the playbooks on a blank machine will have a fresh install of MAAS ready to go. For example, running the region+rack will setup a region+rack on the host machine.

Read the [Ansible playbooks reference](/t/ansible-playbooks-reference/6367) document to learn more.

<a href="#heading--vault-integration"><h3 id="heading--vault-integration">Integratation of Vault for credential storage</h3></a>

MAAS deals with a number of secrets (user password, certificates and keys, API tokens, …), currently stored in the database -- which is insecure by default. This configuration may not meet everyone's security requirements or regulations. For this reason, we've integrated MAAS with Hashicorp Vault, a well-established solution for secure, centralised credential storage.

You can read the [MAAS Vault reference](/t/maas-vault-reference/6368) documentation to learn more.

<a href="#heading--22-04-support"><h3 id="heading--22-04-support">Native support for 22.04 LTS and core22</h3></a>

MAAS users want to install MAAS on a 22.04 LTS system via deb packages, as well as upgrade machines currently running MAAS on Ubuntu 20.04 LTS to 22.04 LTS.  With the advent of MAAS 3.3, we have created an appropriate PPA with all required dependencies.  This PPA can be directly installed on Ubuntu 22.04, Jammy Jellyfish, with no requirement to use snaps.

Note that the upgrade procedure will require a release upgrade from previous Ubuntu versions to Ubuntu 22.04.  Also note that, with this version of MAAS, PostgreSQL 12 is deprecated and should be upgraded to PostgreSQL 14.  The [installation guide](/t/how-to-install-maas/5128) provides the necessary details.

<a href="#heading--simultaneous-deployment-improvements"><h3 id="heading--simultaneous-deployment-improvements">Reliability improvements for simultaneous machine deployments</h3></a>

[1] As a MAAS operator, I want to deploy many machines and have them all deploy reliably
Currently when selecting and deploying a large number (around 30 or more)  of machines at the same time in the UI, not all will transition to Deploying. Some will end up in a Failed Deployment state without the machines even being turned on.

This story is to make sure that all machines will transition to Deploying, and eventually Deployed. It’s OK if it takes a while to get there. The most important thing is not to error out for no good reason.
Acceptance Criteria
MAAS can deploy large amounts of machines simultaneously
Work Items
Add system tests for deploying a large amount of machines simultaneously
Investigate using mock machines
Provide metrics around the failure points being addressed to count failures
[2] As a MAAS operator, when I deploy many machines, I want MAAS to allocate IPs in bulk
As machines receive a lease from dhcpd, dhcpd sends a report of the lease to MAAS. From there, the Rack Controller’s LeaseSocketService processes the message and sends it to the Region Controller via RPC. Currently, there is a lock when handling this, allowing some machines to allocate IPs, but some may timeout waiting. We can circumvent this issue by queuing up lease reports in the Rack Controller and processing a batch of leases rather than individual reports as we receive them. This queue would be part of the LeaseSocketService, and make a single RPC call when flushing the queue.

Similarly, when MAAS is responsible for allocating the IP, there is a Postgres advisory lock creating contention for IPs. This lock is currently in place to prevent allocating the same IP concurrently, however we can also accomplish this while reducing contention by allocating IPs in bulk in a given request.  In this case, we would need to modify how MAAS attempts to create StaticIPAddress’s such that MAAS will hit the lock only to allocate a set of IPs.
Acceptance Criteria
We track the latency of reporting a single lease over the LeaseSocketService
We track the latency of reporting 100 leases over the LeaseSocketService
We track the latency of reporting 1000 leases over the LeaseSocketService
MAAS allocates IPs for machines in bulk (not from a DHCP standpoint, but in the data layer)
Work Items
Add performance tests testing lease reporting before changes to IP allocation
Add graphs to the performance test dashboard
Provide before and after the change test results
Modify MAAS’ handling of LeaseSocketService’s messages to queue up leases and allocate in a batch, with a timer to flush the queue when less than the batch size has been received
Modify MAAS’ StaticIPAddress allocation behaviour to attempt multiple allocations in a single transaction
[3] As a MAAS operator, when I deploy many machines, I want DNS updates to interrupt answering queries as minimally as possible
As machines receive a lease, MAAS creates a new DNS entry for them. This causes BIND to reload on each record update. While BIND stays online when updating, it locks internally and many successive updates can overload BIND. While handling IP allocation in bulk will assist with this as well, we can further optimise this by queuing the updates to BIND specifically and sending an update of many records and many zones using nsupdate.  Nsupdate is a cli tool packaged with BIND for dynamic updates.  MAAS will serialize changes to its set of records for a given batch to a call to nsupdate in nsupdate’s DSL format of “update <add/delete> <name> <ttl> <rtype> <answer>”. The “send” command then transactionally commits all updates, all the while, BIND continues to answer queries. The command nsupdate should prevent these reloads, though this command is specific to record updates and not full zones or other configuration.
Acceptance Criteria
We track the time it takes to update BIND with a new record
We track the time it takes to update BIND with 100 new records
We track the time it takes to update BIND with 1000 new records
We test that BIND can answer queries while receiving these updates
MAAS queues DNS updates for BIND’s reload
Work Items
Add performance tests testing updating BIND with new records
Add tests asserting BIND can answer queries while receiving these updates
Add graphs to the performance test dashboard
Provide before and after the change test results
In the provisioningserver portion of the DNS code, queue BIND updates
Update DNS records in BIND using nsupdate
[4] As a MAAS operator, when I deploy many machines, I want the RPC connection pool to not get exhausted, such that calls do not timeout waiting for a connection
When observing the simultaneous deployment of many machines, one can see tracebacks regarding no RPC connections available currently. While the previously mentioned batch processing of lease reports will assist in addressing this issue, we will modify MAAS’ RPC connection pool to have its standard number of connections at idle, but be able to “burst” to add more connections.

<a href="#heading--nvidia-dpu-support"><h3 id="heading--nvidia-dpu-support">The first phase of Nvidia DPU support</h3></a>

[1] As a MAAS Admin, I want to enlist a DPU in MAAS
If a machine has a DPU, we want to identify it and enlist as a machine, so we can network boot and configure it later.

In this story the DPU and the host are treated as two separate machines and there is no relationship between them in MAAS. Power management of the DPU will be Manual. The admin has to manually arrange for the DPU to do the network boot (given Bluefield 2 devices have no BMC).
Acceptance criteria
If a DPU network boots on a MAAS network, it runs all commissioning scripts successfully and is added as a regular machine in MAAS
I can deploy Ubuntu to a DPU with a custom network configuration
Network and storage configuration are reported correctly
Check that only allowed actions are available for the DPU (since we treat DPU as machine)
An enlisted DPU has the “dpu” tag set
Work items:
Check if we DPU can network booted from MAAS and complete commissioning
Determine DPU machine properties that can be used for an automated tag assignment
Notes:
Platform devices don't show up when commissioning with Focal. With Jammy everything works well. Expected to be fine for 3.3

[2] As a MAAS admin, I want to use the linux-bluefield kernel when deploying
We need to support custom OS images, but the current process requires manual BFB image creation (using a custom kernel). 
Acceptance criteria
When a Bluefield DPU is commissioned following the documentation, all the network ports (inc. management port) are shown in MAAS
A Bluefield DPU can be identified as such (e.g. via sub-architecture or a tag)
Work items:
Provide a Packer template for a custom Ubuntu image using linux-bluefield kernel
Provide documentation on how to make an image / kernel that can be used for Bluefield DPUs
Notes:
To fully use a DPU, one should use linux-bluefield kernel and DOCA libraries installed. Is it just for Focal or will the Kernel team maintain this for Jammy?

Similar to a Pi maybe - some things will work but not everything.

What differences are there in the image besides the kernel? Ubuntu-server + linux-bluefield or NVidia produced image.

Suspect vanilla Ubuntu Server for the starting point - meshes well with consumers of MAAS e.g. Juju.

Enlist and (enlist-commission) as generic arm64; then set sub-arch to bluefield and Commission which will use the special kernel + associated packages.

Focal: generic + drivers - main ports work (don't see management port). NVidia's kernel + drivers work (see main ports and management port)

linux-bluefield in focal-updates doesn't include drivers for the DPU so you lose networking

Questions:
What does Kernel team suggest we use for commissioning Bluefield?
What about OVS packages? Nvidia repo or Jammy?
Why do we have a special image for Bluefield? What should we use?

[3] As a MAAS admin, I want to be able to identify child-parent relationships between machines in the Machine List and API

<a href="#heading--openapi-support"><h3 id="heading--openapi-support">Shifting the MAAS API documentation to OpenAPI standards</h3></a>

[1] As a MAAS API User, I want to discover the OpenAPI definition of a running MAAS server knowing only the API base URL

In the OpenAPI world tools can rely on the link relations described in RFC8631 [2] to download the definition of a server. The API landing page currently return a generic unknown endpoint message, and should be updated to return a JSON or YAML encoded page with pointers to the human-readable documentation (service-doc) and API definition (service-desc):

{
  "title": "MAAS API",
  "description": "...",
  "links": [
    {
      "href": "http://MAAS_CONTROLLER/MAAS/api",
      "rel": "self",
      "type": "application/json",
      "title": "this document"
    },
    {
      "href": "http://MAAS_CONTROLLER/MAAS/api/2/openapi.yaml",
      "rel": "service-desc",
      "type": "application/openapi+yaml",
      "title": "the API definition"
    },
    {
      "href": "http://MAAS_CONTROLLER/MAAS/docs/api.html",
      "rel": "service-doc",
      "type": "text/html",
      "title": "the API documentation"
    }
  ]
}


Acceptance criteria
A user can discover the location of the OpenAPI definition accessing the API landing page
Work items:
Add a landing page
[3] As a MAAS API User, I want to configure my client using the OpenAPI definition

My client implementation should be able to connect to my MAAS controller after loading the OpenAPI definition, either manually supplied or discovered through the service-desc link. The OAS uses the servers section to implement this feature.

servers:
- url: $MAAS_URL/api/2
  description: $MAAS_NAME API 


The definition should contain a list of URLs where this API can be accessed. The MAAS knows only one public-facing address, which is stored in the maas_url config setting. 
Acceptance criteria
OAD contains a servers section 
The base URL and name matches the Controller configuration
Work items:
Add servers section to OpenAPI definition
[4] As a MAAS API User, I want a structured description of the operations available in the API

The main section of an OpenAPI definition is the paths, where all operations available in the API are described. Each API URL path is enumerated, with the valid operations described in terms of HTTP method, parameters, responses and security scope. For example:

paths:
  /users/{id}:
    get:
      summary: Gets a user by ID.
      description: >
        A detailed description of the operation.
      operationId: getUserById
      security:
        - oAuthMAAS: [maas_user]
      parameters:
        - name: id
          in: path
          description: User ID
          required: true
          schema:
            type: integer
            format: int64
      responses:
        '200':
          description: Successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
    put:
      summary: Edit a user
      operationId: upUser
      security:
        - oAuthMAAS: [maas_admin]
      requestBody:
        description: Optional description in *Markdown*
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/User'
      responses:
        '200':
          description: Successful operation
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'


MAAS is currently capable of generating ReST documentation from the code. We should leverage this metadata to produce the OpenAPI definition. The following properties mapping is proposed:

OpenAPI
MAAS
HTTP Method
GET 
read() operation
@operation(idempotent=True)
POST 
create() operation
@operation(idempotent=False)
PUT 
update() operation
DELETE 
delete() operation
Summary


Docstring @description-title
Description


Docstring @description
operationId


<resource_name>_<funcname>
Security scope
maas_admin
@admin_method
maas_user
default scope
Parameters 
path
Extract from func signature
requestBody


Docstring @param
Responses
code
Success -> Infer from HTTP method
Errors -> Docstring @error (http-status-code)


The schema of the content of a requestBody or response might be hard to extract from the code, so we can resort to a free-form object in some cases (see below). This is not regarded as good practice and should be used as a stopgap until we have better ways of generating the schemas (see related story).

type: object
additionalProperties: true


Although most of the content of the definition is static, we should generate the OAD at runtime because it has dynamic content (the servers section). 
Acceptance criteria
OAD contains a paths section describing all operations available in the MAAS API
Operations have path parameters correctly typed
Security scope reflects whether this operations requires Administrator rights 
operationIDs are unique in a OAD and stable between API versions
Error codes are correctly described
When an operation expects a request body, it has a schema describing it
When an operation returns data, it uses a free-form object schema to describe it
Work items:
Create an OpenAPI version of  src/maasserver/api/doc.py:_describe_api() 
Create an OpenAPI version of  src/maasserver/api/doc.py:_describe_resource() 
Create an OpenAPI version of  src/maasserver/api/doc.py:_describe_handler() 
Create an OpenAPI version of  src/maasserver/api/doc.py:_describe_actions()
Add /api/2/openapi.yaml endpoint
[5] As a MAAS API User, I want operations to be logically grouped with tags

Tags are used by OpenAPI to group related operations together, usually for documentation purposes. A common practice is to create global tags with links to external help resources, for example:

tags:
  - name: user
    description: MAAS user management
    externalDocs:
      url: http://docs.my-api.com/users.htm
paths:
    put:
      summary: Edit a user
      operationId: upUser
      tags:
        - user
      … 

 
The link to external resources is optional.
Acceptance criteria
OAD contains a tags section 
Each resource is a tag
Operations are tagged by resource
Work items:
Enumerate resources and add to the tags section
Add tag to each operation
[9] As a MAAS API User, I want to consume a human-readable version of the OpenAPI definition

<a href="#heading--maas-config-settings-ref"><h3 id="heading--maas-config-settings-ref">MAAS Configuration settings reference</h3></a>

[Configuration settings reference](https://maas.io/docs/configuration-settings-reference).

<a href="#heading--other-maas-versions"><h2 id="heading--other-maas-versions">Release notes for other MAAS versions</h2></a>

Here are release notes for other relatively recent MAAS versions:

- [MAAS 3.2](/t/what-is-new-with-maas-3-2/5962)
- [MAAS 3.1](/t/what-is-new-with-maas-3-1/5964)
- [MAAS 3.0](/t/what-is-new-with-maas-3-0/5963)
- [MAAS 2.9](/t/what-is-new-with-maas-2-9/5961)
- [MAAS 2.8](/t/what-is-new-with-maas-2-8/5994)
- [MAAS 2.7](/t/what-is-new-with-maas-2-7/5993)
