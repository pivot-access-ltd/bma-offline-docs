<!-- "About RBAC" -->

# Work in progress
This work is not yet published, and thus cannot be relied upon by MAAS users.

[1] As a MAAS RBAC administrator, I want to sufficiently understand multi-tenancy in a way that helps me design and maintain my MAAS RBAC instances.

As an RBAC administrator, an understanding of groups, roles, and resource pools – and how they connect via RBAC – is essential for administering and designing my own RBAC instance. 
Acceptance criteria
A user has a clear understanding of the way resource pools are integrated into RBAC.
A user has a clear understanding of RBAC users and groups, and how they help to manage access to resource pools.
A user has a clear understanding of roles, such as user, administrator, operator, and auditor.
A user has a clear understanding of how the correspondence of users, groups, and resource pools helps to restrict user actions in MAAS.
Work items:
Explain the permissions model across MAAS, RBAC, and Candid, 
Explain clearly, with graphics, the joint architecture of MAAS,Candid, and RBAC, including the specific function of each piece and any limitations introduced by the fact that MAAS use of RBAC is hard-coded (thus not infinitely flexible).
Explain clearly how RBAC users and groups are managed across the MAAS RBAC architecture.
Explain clearly how roles work; what actions each role is capable of performing; and how these roles are limited by the MAAS RBAC architecture.
Explain clearly, with graphics, the typical experience of each of the four MAAS RBAC groups over a range of typical situations.
[2] As a MAAS RBAC administrator, I want to sufficiently understand Candid in a way that helps me properly design my MAAS RBAC instances.

As an RBAC administrator, knowing the underlying features of Candid and how they control my design choices can help me better plan my RBAC instance.
Acceptance criteria
A user has a clear understanding of what Candid does (e.g., creates macaroons) and doesn’t do (e.g., provide identity, authenticate users).
A user has a clear understanding of how Candid supports integration with underlying authentication systems and identity providers, including conspicuous examples related to using Candid with RBAC and MAAS.
A user has a clear understanding of the Candid API, what it does, and how it assists RBAC in managing user actions for MAAS.
Work items:
Explain, with graphics, a more detailed view of how Candid fits into the MAAS RBAC ecosystem, specifically which services it does and doesn’t provide.  
Explain clearly, in simple terms, how Candid integrates with underlying auth systems and identity provides, and what Candid generates for RBAC.
Explain clearly how the Candid API works, what services it provides, and how RBAC accesses this API to integrate Candid into the MAAS ecosystem.
[3] As a MAAS RBAC administrator, I want to sufficiently understand RBAC in a way that helps me design strong, properly-configured, role-based access controls.
As an RBAC administrator, understanding the gap that RBAC fills – and how it fills it – will better equip me to design and manage proper access controls for my MAAS instance.
Acceptance criteria
A user has a clear understanding of what RBAC does that Candid and MAAS do not do, and how it is integrated with both Candid and MAAS to fill these gaps.
A user has a clear understanding of RBAC roles, permissions, and domains, and the way in which they are implemented in MAAS (resource pools, users, etc).
A user has a clear understanding of the various defined roles, permissions, rights, and permitted actions when using RBAC with MAAS.
Work items:
Explain, with graphics, a more detailed view of how RBAC fits into the MAAS RBAC ecosystem, specifically which services it does and doesn’t provide, and how it interfaces with Candid and MAAS to provide these services.  
Explain clearly, in simple terms, how RBAC accesses and manages roles, permissions, and domains (resource pools), and how it mediates access by role.
Explain clearly how RBAC controls the actions (access) of each role across normal MAAS operations, using a suitable example (Navy fleet management, example MAAS already created).
Explain clearly how RBAC logs help to establish an audit trail across the MAAS instance over time.
