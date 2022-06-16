<!-- "About RBAC" -->

# Work in progress
This work is not yet published, and thus cannot be relied upon by MAAS users.

<a href="#heading--multi-tenancy-in-maas"><h2 id="heading--multi-tenancy-in-maas">Multi-tenancy in MAAS</h2></a>

As a MAAS RBAC administrator, you need to understand multi-tenancy, because it will help you design and maintain useful and functional MAAS RBAC instances.  This means that you need an understanding of groups, roles, and resource pools – and how they connect via RBAC.

<a href="#heading--what-is-multi-tenancy"><h3 id="heading--what-is-multi-tenancy">What is multi-tenancy?</h3></a>

Multi-tenancy means that groups of users own a group of resources (machines) without knowing about other groups of users -- or their machines.  A common multi-tenancy use case provides different sets of machines for different users or groups of users. MAAS can achieve this, to some degree, by allowing users to allocate machines, but this approach has some drawbacks:

- Other administrative users can still see the allocated machines, as well as release and reallocate someone else's machines for themselves.
- Other administrative users can take administrative actions on someone else's machines (e.g., deployment).

To allow better machine access control, MAAS version 2.4 created resource pools.  By themselves, resource pools don't prevent one administrative user from manipulating someone else's machines.  Resource pools are integrated into the Canonical RBAC tool, making separation of privilege possible.

<a href="#heading--how-resource-pools-link-to-rbac"><h3 id="heading--how-resource-pools-link-to-rbac">How resource pools are integrated into RBAC</h3></a>

Resource pools are just a way of grouping machines.  Any given machine can be in exactly one resource pool.  This means that if you can control access to (and visibility of) resource pools, you can effectively control user access.

Note that just using resource pools to hide machines is a flawed access control approach, known as "security by obscurity."  What users don't know will hurt you when the users figure it out, and more often than not, they figure these things out entirely by accident.  There must also be some means of active authorisation that allows access to a resource pool, based on user identity, and there must be some way of controlling what the user can do with that resource pool.  In the parlance of standard security model, "what the user can do" would be called "privileges", but for the purposes of MAAS, we simply call them "permissions."  

<a href="#heading--the-rbac-permissions-model"><h3 id="heading--the-rbac-permissions-model">The RBAC permissions model</h3></a>

RBAC (Role-based access control) does not authenticate users or verify their identity; that depends on upstream tools.  RBAC does associate a given role with a properly-authenticated user identity.  With RBAC, permissions are associated with roles, not individual users, so the role assigned to a user when they authenticate controls what they can and cannot do.

This may seem like an unnecessary distinction, but it some key advantages:

- should a user wish to downgrade their privileges, e.g., so they won't accidentally do something destructive, this is possible without change the user's identity information.
- should a user's role change, requiring a change in privilege, the user account does not have to be modified to make this change.

From the point of view of MAAS, here is a thumbnail sketch of the permissions model:

- MAAS maintains resource pools, which are a machine attribute.  Every machine can be in one and only one resource pool.  Control access to a resource pool, and you control access to a machine.
- RBAC maintains roles, which are associated with user identities and permissions.  For a given user identity to carry out a particular operation in MAAS, that user identity must correspond to a role that has permission to carry out that operation.
- Some other tool (in this case, Candid) verifies the user identity.  If roles are to be effective, the user identity must be correct, and that identity must be verified before reaching RBAC.

The relationship between permissions and MAAS operations is mediated by RBAC.  If RBAC is used, the code controlling each operation will verify with RBAC that the requesting user has the correct combination of roles and permissions.

RBAC maintains a database that maps users to roles and resources; there are four roles:

- Administrator: all permissions for all resource pools.
- Operator: all permissions for a specific resource pool, but not others.
- User: limited permissions, corresponding to the normal rights of a MAAS users.
- Auditor: permission to view data, only (i.e., read-only access).

MAAS code and RBAC code must work together to ensure that only users with the correct permissions are able to perform a specific operation.

<a href="#heading--a-little-about-candid"><h3 id="heading--a-little-about-candid">A little about Candid</h3></a>

Candid is the [Canonical Identity service](https://github.com/mhilton/canonical-candid), an open-source [macaroon](https://en.wikipedia.org/wiki/Macaroons_(computer_science))-based authentication service. Candid is not an [identity server](https://en.wikipedia.org/wiki/Identity_provider), it just manages the users on a specified identity server.  An example of such an identity server could be LDAP, for example.

Candid can do the following things:

- find users by various identity parameters, such as e-mail, full name, last login time, etc.
- show details for a user, based on e-mail or username.
- add or remove users from ACLs (access control lists), or list members of an ACL.
- add or remove users from arbitrary groups.
- clear the multi-factor authentication (MFA) credentials for a specific user.
- manage Candid agents.

Candid can use certificates and agents, if desired.  You specify the identity provider by URL when instantiating the program.

When a user tries to log into a MAAS which is working with RBAC, MAAS redirects that login to the RBAC server.  RBAC, in turn, requests authentication via Candid, which then consults the specified identity server (at the URL provided on startup).  If the user is autenticated, Candid constructs a macaroon, which is then passed to RBAC and on to MAAS.  This macaroon serves as the user's authentication token until it expires.

<a href="#heading--the-rbac-maas-security-architecture"><h3 id="heading--the-rbac-maas-security-architecture">The MAAS/RBAC security architecture</h3></a>

The following diagram will give you a graphical view of how MAAS, RBAC, and Candid work together to control access to MAAS resources:

<a href="https://discourse.maas.io/uploads/default/original/2X/4/4433c6995c342efebe565f4888a46d7107d1525f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/4/4433c6995c342efebe565f4888a46d7107d1525f.png"></a>

The step-by-step walkthrough of the MAAS/RBAC realtionship goes like this:

- When MAAS is initiated with RBAC connected, MAAS pushes a list of resource pools and a global resource key to RBAC.  The global resource key covers things that are not added to resource pools, such as devices.
- When a user tries to login, MAAS redirects that login request to RBAC.
- RBAC, in turn, requests an auth check from Candid.
- Candid attempts to authenticate the user via whatever identity provider was configured when Candid was started (e.g., SSO).
- If Candid successfully authenticates the user, Candid creates a macaroon as a temporary identity token for the user.
- Candid passes the macaroon back to RBAC.
- RBAC passes the macaroon, in turn, the MAAS, along with a dictionary of groups, role(s) and resource pools corresponding to that user.
- As needed, MAAS then mediates access to resource pools, using the macaroon to recognize the user and their group(s), and the role/resource pool pairs to adjudicate access.

Though it sometimes sounds complicated, the process is fairly straightforward when viewed in this way.

Note that RBAC does not adjudicate individual permissions against resource pools. RBAC only sends MAAS the combination of users, roles, and related resource pools.  The MAAS code has a built-in understanding of the four roles (user, administrator, operator, and auditor) and what those roles can and cannot do with a given item.  

<a href="#heading--how-the-four-maas-roles-protect-maas-resources"><h3 id="heading--how-the-four-maas-roles-protect-maas-resource">How the four MAAS RBAC roles protect MAAS resources</h3></a>

The most important thing to understand about MAAS RBAC roles is that restricted users cannot see or interact with machines in resource pools that aren't permitted for them. This is more than just "security by obscurity," because even if a user knows the name or system ID of a machine in a non-permitted resource pool, that user can't access it.  Removing non-permitted machines from view, though, prevents confusion about what the user can and can't do.

Here is a quick breakdown of how the four users experience MAAS:

- Administrator: an administrator can do anything that a normal MAAS administrator can do in the absence of RBAC.  This means an admin can see all resource pools, take any action against any machine, and change any MAAS settings.

- Operator: an operator can do almost anything that a normal MAAS administrator can do, but only against machines in their permitted resource pools.  An operator cannot see or change system settings.

- User: a user can do just what a normal MAAS user can do.  They can only view and allocate machines that aren't allocated to someone else, even if that someone else is another user in the same resource pool.  Users can't change or access settings at all.

- Auditor: an auditor can view anything about machines in the resource pool(s) for which they are permitted.  Auditors cannot or access settings.

MAAS makes no assumptions about how these roles might be used in the day-to-day operation of your MAAS instance.  The capabilities listed above form the complete set of what these roles can do.