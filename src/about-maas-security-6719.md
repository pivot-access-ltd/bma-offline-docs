<!-- "About MAAS security" -->
As a MAAS administrator, you do not want secrets associated with a MAAS instance to be stored in the database, since it often doesn’t comply with security regulations.  Examples of the MAAS settings which contain secrets are the OMAPI key and the RPC secret. 

[tabs]
[tab version="v3.3 Snap,v3.3 Packages"]
Other examples of such secrets are:

- Database connection credentials
- BMC power credentials (password, keys and certificates) for machines
- VMhost credentials
- Macaroon keys

Beginning with version 3.3, MAAS secrets should instead be stored in [HashiCorp Vault](https://www.hashicorp.com/products/vault)`↗`.

<a href="#heading--Summary-of-Hashicorp-Vault"><h2 id="heading--Summary-of-Hashicorp-Vault">Summary of Hashicorp Vault</h2></a>

Ideally, you should consult the [Vault documentation](https://developer.hashicorp.com/vault/docs)`↗`, but for convenience, we will provide a brief summary here.

Vault uses identity to protect secrets and encryption keys.  The core component is the `kv` secrets engine, which uses key-value pairs to store arbitrary secrets within an encrypted storage extent managed by Vault.  It's similar to the full-disk-encryption tools that you'd use to protect your hard drive, but limited to a specific path assigned to the secrets engine(s).  

If you're interested, you can [read more about secrets engines](https://developer.hashicorp.com/vault/docs/secrets)`↗` at your leisure.

Vault protects the secrets engine with a sort of upscale `chroot jail`, called a [barrier view](https://developer.hashicorp.com/vault/docs/secrets#barrier-view)`↗`.  This barrier view consists of a folder, named to a randomly-generated UUID, which forms the abolute root directory for that engine.  Secrets engines cannot, for example, `cd ..` above their UUID folder, which becomes an effective barrier for what that engine can view.  

Aside from this short overview, we won't repeat all of the Vault documentation.  Instead, we recommend that you [study the Vault documentation carefully](https://developer.hashicorp.com/vault/docs)`↗`, or even consider [getting certified](https://developer.hashicorp.com/vault/tutorials/associate-cert)`↗` on the Vault product.

[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
Beginning with version 3.3, MAAS secrets can be stored in [HashiCorp Vault](https://www.hashicorp.com/products/vault)`↗`.  To use Vault to protect your secrets, please upgrade to MAAS 3.3.
[/tab]
[/tabs]

<a href="#heading--multi-tenancy-in-maas"><h2 id="heading--multi-tenancy-in-maas">Multi-tenancy in MAAS</h2></a>

Likewise, you want to grant fine-grained access-controls to different users, based on assigned roles.  Working in concert with RBAC and Candid, MAAS can restrict user access and actions based on four roles:

- Administrator: can access all settings and perform any operation on any machine in any resource pool; equivalent to a MAAS administrator.
- Operator: can act as a MAAS administrator, but only within an assigned resource pool.  Machines in other resource pools -- and system settings -- are not accessible.
- User: can access and manipulate machines that are not currently allocated to other users, within the confines of an assigned resource pool; equivalent to a MAAS user, but only over the resource pool.  Users cannot access any settings.
- Auditor: can view information for all machines within an assigned resource pool; cannot make any changes or alter any settings.

MAAS controls access with the help of RBAC (Role-Based Access Control), Candid (Canonical Identity Manager), and an identity service of your choice, such as SSO (Single Sign-On).  From this point on, we'll refer to this solution as MAAS/RBAC, even though it uses more than two tools.  You can design and deploy a carefully-controlled MAAS environment using MAAS/RBAC.

As a MAAS/RBAC administrator or designer, you should understand the concept of multi-tenancy.  Multi-tenancy means that groups of users own a group of resources (machines), but without knowing about other groups of users -- or their machines.  A common multi-tenancy use case provides different sets of machines for different users or groups of users. 

MAAS alone can achieve this, to some degree, by allowing users to allocate machines, but this approach has some drawbacks:

- Other administrative users can still see the allocated machines, as well as release and reallocate someone else's machines for themselves.
- Other administrative users can take administrative actions on someone else's machines (e.g., deployment).

With MAAS/RBAC, an operator can act as administrator for one resource pool, without the ability to manipulate someone else's machines. Users can only operate within the confines of their resource pool, and auditors can review actions without making any changes.

<a href="#heading--how-resource-pools-link-to-rbac"><h3 id="heading--how-resource-pools-link-to-rbac">How resource pools are integrated into MAAS/RBAC</h3></a>

Resource pools are just a way of grouping machines.  Any given machine can be assigned to exactly one resource pool.  If you control access to resource pools, and you assign roles properly, you can effectively control user access.

Note that just using resource pools to hide machines is a flawed access control approach, known as "security by obscurity."  What users don't know will hurt you when the users figure it out. More often than not, users figure these things out entirely by accident, and hurt you unintentionally while trying to do the right thing.

Consequently, there must also be some means of active authorisation that allows access to a resource pool.  That authorisation must be based on user identity. There must be some way of controlling what the user can do with that resource pool.  In the parlance of standard security model, "what the user can do" would be called "privilege", but for the purposes of MAAS, we simply call them "permissions."  

<a href="#heading--about-identity-services"><h3 id="heading--about-identity-services">About identity services</h3></a>

MAAS/RBAC will interface with many identity services, using Candid as a mediator.  While the choice of identity service is up to you, we should cover some general principles of identity servers as they relate to MAAS/RBAC.  Let's take a closer look at [Ubuntu Single Sign-On (SSO)](https://help.ubuntu.com/community/SingleSignOn)`↗`

SSO permits users to log in once to access many network services.  SSO centralises authentication (via Kerberos), account management (via LDAP), resource-sharing (via `pam_mount`), and limited authorisation through group memberships in LDAP, coupled with file system permissions.

RBAC (Role-based access control) does not authenticate users or verify their identity; that function is assigned to the identity service you choose.  RBAC does receive an identity token or "macaroon" (via Candid) that RBAC uses to assign user roles.  MAAS uses these roles, in turn, to control user access and actions.

<a href="#heading--about-candid"><h2 id="heading--about-candid">How Candid fits into the picture</h2></a>

Direct authentication involves a user entering something unique in response to a challenge, in order to gain access.  "Something unique" means "something you know, something you have, or something you are", e.g., a password, a hardware key, or a fingerprint, respectively.  Authentication can be automated with private/public key exchanges, protected with a password on the first exchange.  Adding another access point (another trusted client) usually means providing a public key, setting a password, or registering some biometric data.  Direct authentication works well when there are a limited number of clients and not a lot of user turnover.

Increase the number of users and services that need to authenticate, and direct authentication becomes an IT nightmare: generating access requests; validating requests; setting up authentication; and then managing access as users move around the organisation.  [Candid](https://github.com/canonical/candid)`↗`, the Canonical identity service, was designed to meet this need.  Candid acts as an authentication gateway that connects a service like RBAC to your chosen identity service.

Candid manages authenticated users via special access tokens ([macaroons](https://askubuntu.com/questions/940640/what-is-a-macaroon))`↗` that confirm user identity.  Unlike standard access tokens, macaroons can be verified independently, in a standard way, so they reduce the network traffic and delays of repeatedly querying the identity server.  Traditional access tokens must be short-lived; macaroons are valid for much longer and they can be refreshed easily.  Macaroons can also be bound to TLS certificates.  And macaroons can be used by multiple clients and services with no loss of security.

Candid can do the following things:

- find users by various identity parameters, such as e-mail, full name, last login time, etc.
- show details for a user, based on e-mail or username.
- add or remove users from ACLs (access control lists), or list members of an ACL.
- add or remove users from arbitrary groups.
- clear the multi-factor authentication (MFA) credentials for a specific user.
- manage Candid agents.

Candid can use certificates and agents, if desired.  You specify the identity provider by URL when instantiating the program.

When a user tries to log into a MAAS which is working with RBAC, MAAS redirects that login to the RBAC server.  RBAC, in turn, requests authentication via Candid, which then consults the specified identity server (at the URL provided on startup).  If the user is authenticated, Candid constructs a macaroon, which is then passed to RBAC and on to MAAS.  This macaroon serves as the user's authentication token until it expires.

<a href="#heading--about-rbac"><h2 id="heading--about-rbac">About RBAC</h2></a>

RBAC uses a database to associate a given role with a properly-authenticated user identity.  With RBAC, permissions are associated with roles, not individual users. Within a given resource pool, the role assigned to a properly authenticated user controls what they can and cannot do within that pool.

In the parlance of RBAC, MAAS would be a service, while each resource pool would be considered a separate scope. RBAC/MAAS also recognises scopes that are not tied to machines, including:

- DNS
- Availability zones
- Images
- System settings

RBAC can help MAAS also control access to these "non-machine resources".

Note that it is possible for a given user to be an operator for one resource pool, a user for another, and an auditor for still another, but have no ability to change system settings or manipulate images.  Nothing about RBAC prohibits this arrangement.

<a href="#heading--the-rbac-permissions-model"><h3 id="heading--the-rbac-permissions-model">The MAAS/RBAC permissions model</h3></a>

Here is a thumbnail sketch of the permissions model:

- MAAS maintains resource pools, which are a machine attribute.  Every machine can be assigned to one and only one resource pool.  
- RBAC maintains roles, which are associated with user identities.  For a given user identity to carry out a particular operation in MAAS, that user identity must correspond to a role that has permission to carry out that operation in a given resource pool.
- Candid vouches for the user with a macaroon.
- Some identity service (e.g., SSO) authenticates the user to Candid, so that macaroons are not generated for unrecognised users.

Relationships between roles, resource pools, and users is maintained by RBAC as a source of truth.  MAAS mediates access to resource pools, based on user roles, using information obtained from RBAC. 

<a href="#heading--the-rbac-maas-security-architecture"><h3 id="heading--the-rbac-maas-security-architecture">The MAAS/RBAC security architecture</h3></a>

The following diagram will give you a graphical view of how MAAS, RBAC, Candid, and an identity provider work together to control access to MAAS resources:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/4433c6995c342efebe565f4888a46d7107d1525f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/4433c6995c342efebe565f4888a46d7107d1525f.png"></a>

The step-by-step walk-through of the MAAS/RBAC relationship goes like this:

- When MAAS is initiated with RBAC connected, MAAS pushes a list of resource pools and a global resource key to RBAC.  The global resource key covers things that are not added to resource pools, such as devices or settings.
- When a user tries to login, MAAS redirects that login request to RBAC.
- RBAC, in turn, requests an authentication check from Candid.
- Candid attempts to authenticate the user via whatever identity provider was configured when Candid was started (e.g., SSO).
- If Candid successfully authenticates the user, Candid creates a macaroon as a temporary identity token for the user.
- Candid passes the macaroon back to RBAC.
- RBAC passes the macaroon, in turn, to MAAS, along with a dictionary of groups, role(s) and resource pools corresponding to that user.
- As needed, MAAS then mediates access to resource pools, using the macaroon to recognise the user and their group(s), and using the role/resource pool pairs to adjudicate access.

Note that RBAC does not adjudicate individual permissions against resource pools. RBAC only sends MAAS the combination of users, roles, and related resource pools to MAAS when requested.  The MAAS code has a built-in understanding of the four roles (user, administrator, operator, and auditor) and what those roles can and cannot do with a given item.  

<a href="#heading--how-the-four-maas-roles-protect-maas-resources"><h3 id="heading--how-the-four-maas-roles-protect-maas-resource">How the four MAAS RBAC roles protect MAAS resources</h3></a>

The most important thing to understand about MAAS RBAC roles is that restricted users cannot see or interact with machines in resource pools that aren't permitted for them. This is more than just "security by obscurity," because even if a user knows the name or system ID of a machine in a non-permitted resource pool, that user can't access it.  Removing non-permitted machines from view, though, prevents confusion about what the user can and can't do.

Here is a quick breakdown of how the four roles experience MAAS:

- Administrator: an administrator can do anything that a normal MAAS administrator can do in the absence of RBAC.  This means an admin can see all resource pools, take any action against any machine, and change any MAAS settings.

- Operator: an operator can do almost anything that a normal MAAS administrator can do, but only against machines in their permitted resource pools.  An operator cannot see or change system settings.

- User: a user can do just what a normal MAAS user can do.  They can only view and allocate machines that aren't allocated to someone else, even if that someone else is another user in the same resource pool.  Users can't change or access settings at all.

- Auditor: an auditor can view anything about machines in the resource pool(s) for which they are permitted.  Auditors cannot change or access settings.

MAAS makes no assumptions about how these roles might be used in the day-to-day operation of your MAAS instance.  The capabilities listed above form the complete set of what these roles can do.

[tabs]
[tab version="v2.9 Snap,v2.9 Packages,v3.0 Snap,v3.0 Packages,v3.1 Snap,v3.1 Packages"]
To obtain MAAS native TLS, upgrade to MAAS v3.2 or higher.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.3 Snap,v3.3 Packages"]
<a href="#heading--about-maas-native-tls"><h2 id="heading--about-maas-native-tls">About MAAS Native TLS</h2></a>

MAAS version 3.2 has built-in TLS support for communicating with the UI and API over HTTPS. This eliminates the need to deploy a separate TLS-terminating reverse-proxy solution in front of MAAS to provide secure access to API and UI.

TLS versions 1.2 and 1.3 are supported by MAAS. For TLSv1.2, the following ciphers are accepted:

- AES256+EECDH
- AES256+EDH

You will need to obtain your own certificates via some provider, e.g., [small step](https://smallstep.com/docs/step-ca)`↗`.

<a href="#heading--about-auto-renewal-for-certificates"><h3 id="heading--about-auto-renewal-for-certificates">About certificate auto-renewal</h3></a>

At the moment we don’t support automatic certificate renewal, because it depends on the PKI used at the organisation level.  We [do provide some examples](#heading--how-to-auto-renew-certificates) of how to set this up, as long as you understand that these are just gratuitous helps, not supported configurations.
[/tabs]