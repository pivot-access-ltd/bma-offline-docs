<!-- "About RBAC" -->

# Work in progress
This work is not yet published, and thus cannot be relied upon by MAAS users.

Role-based access control (RBAC) restricts user actions based on four roles:

- Administrator: can access all settings and perform any operation on any machine in any resource pool; equivalent to a MAAS administrator.
- Operator: can act as a MAAS administrator, but only within an assigned resource pool.  Machines in other resource pools -- and system settings -- are not accessible.
- User: can access and manipulate machines that are not currently allocated to other users, within the confines of an assigned resource pool; equivalent to a MAAS user, but only over the resource pool.  Users cannot access any settings.
- Auditor: can view information for all machines within an assigned resource pool; cannot make any changes or alter any settings.

You can design a carefully-controlled MAAS environment using RBAC.

<a href="#heading--multi-tenancy-in-maas"><h2 id="heading--multi-tenancy-in-maas">Multi-tenancy in MAAS</h2></a>

As a MAAS RBAC administrator or designer, you should understand the concept of multi-tenancy.

Multi-tenancy means that groups of users own a group of resources (machines), but without knowing about other groups of users -- or their machines.  A common multi-tenancy use case provides different sets of machines for different users or groups of users. MAAS can achieve this, to some degree, by allowing users to allocate machines, but this approach has some drawbacks:

- Other administrative users can still see the allocated machines, as well as release and reallocate someone else's machines for themselves.
- Other administrative users can take administrative actions on someone else's machines (e.g., deployment).

With RBAC, an operator can act as administrator for one resource pool, without the ability to manipulate someone else's machines. Resource pools are integrated into the Canonical RBAC tool, making separation of privilege possible.

<a href="#heading--how-resource-pools-link-to-rbac"><h3 id="heading--how-resource-pools-link-to-rbac">How resource pools are integrated into RBAC</h3></a>

Resource pools are just a way of grouping machines.  Any given machine can be assigned to exactly one resource pool.  If you control access to resource pools, and you assign roles properly, you can effectively control user access.

Note that just using resource pools to hide machines is a flawed access control approach, known as "security by obscurity."  What users don't know will hurt you when the users figure it out. More often than not, users figure these things out entirely by accident, and hurt you unintentionally while trying to do the right thing.

Consequently, there must also be some means of active authorisation that allows access to a resource pool.  That authorisation must be based on user identity. There must be some way of controlling what the user can do with that resource pool.  In the parlance of standard security model, "what the user can do" would be called "privilege", but for the purposes of MAAS, we simply call them "permissions."  

<a href="#heading--the-rbac-permissions-model"><h3 id="heading--the-rbac-permissions-model">The RBAC permissions model</h3></a>

RBAC (Role-based access control) does not authenticate users or verify their identity; that depends on upstream tools.  RBAC does associate a given role with a properly-authenticated user identity.  With RBAC, permissions are associated with roles, not individual users. Within a given resource pool, the role assigned to a user when they authenticate controls what they can and cannot do within that pool.

It is possible for a given user to be an operator for one resource pool, a user for another, and an auditor for still another.  Nothing about RBAC prohibits this arrangement.

Here is a thumbnail sketch of the permissions model:

- MAAS maintains resource pools, which are a machine attribute.  Every machine can be assigned to one and only one resource pool.  
- RBAC maintains roles, which are associated with user identities.  For a given user identity to carry out a particular operation in MAAS, that user identity must correspond to a role that has permission to carry out that operation in a given resource pool.
- Some other tool (in this case, Candid) verifies the user identity.  If roles are to be effective, the user identity must be correct, and that identity must be verified before reaching RBAC.

Relationships between roles, resource pools, and users is maintained by RBAC as a source of truth.  MAAS mediates access to resource pools, based on user roles, using information obtained from RBAC. 

<a href="#heading--a-little-about-candid"><h3 id="heading--a-little-about-candid">A little about Candid</h3></a>

Candid is the [Canonical Identity service](https://github.com/mhilton/canonical-candid), an open-source [macaroon](https://en.wikipedia.org/wiki/Macaroons_(computer_science))-based authentication service. Candid is not an [identity server](https://en.wikipedia.org/wiki/Identity_provider), it just manages the users on a specified identity server.

Candid can do the following things:

- find users by various identity parameters, such as e-mail, full name, last login time, etc.
- show details for a user, based on e-mail or username.
- add or remove users from ACLs (access control lists), or list members of an ACL.
- add or remove users from arbitrary groups.
- clear the multi-factor authentication (MFA) credentials for a specific user.
- manage Candid agents.

Candid can use certificates and agents, if desired.  You specify the identity provider by URL when instantiating the program.

When a user tries to log into a MAAS which is working with RBAC, MAAS redirects that login to the RBAC server.  RBAC, in turn, requests authentication via Candid, which then consults the specified identity server (at the URL provided on startup).  If the user is authenticated, Candid constructs a macaroon, which is then passed to RBAC and on to MAAS.  This macaroon serves as the user's authentication token until it expires.

<a href="#heading--the-rbac-maas-security-architecture"><h3 id="heading--the-rbac-maas-security-architecture">The MAAS/RBAC security architecture</h3></a>

The following diagram will give you a graphical view of how MAAS, RBAC, and Candid work together to control access to MAAS resources:

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

- Auditor: an auditor can view anything about machines in the resource pool(s) for which they are permitted.  Auditors cannot or access settings.

MAAS makes no assumptions about how these roles might be used in the day-to-day operation of your MAAS instance.  The capabilities listed above form the complete set of what these roles can do.