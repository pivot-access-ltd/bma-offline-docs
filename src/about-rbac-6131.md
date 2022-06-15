<!-- "About RBAC" -->

# Work in progress
This work is not yet published, and thus cannot be relied upon by MAAS users.

<a href="#heading--multi-tenancy-in-maas"><h2 id="heading--multi-tenancy-in-maas">Multi-tenancy in MAAS</h2></a>

As a MAAS RBAC administrator, you need to understand multi-tenancy, because it will help you design and maintain useful and functional MAAS RBAC instances.  This means that you need an understanding of groups, roles, and resource pools – and how they connect via RBAC.

<a href="#heading--how-resource-pools-link-to-rbac"><h3 id="heading--how-resource-pools-link-to-rbac">How resource pools are integrated into RBAC</h3></a>

Explain why resource pools form the basis of the MAAS privilege model.

<a href="#heading--the-rbac-permissions-model"><h3 id="heading--the-rbac-permissions-model">The RBAC permissions model</h3></a>

Explain the permissions model across MAAS, RBAC, and Candid, 

<a href="#heading--the-rbac-maas-security-architecture"><h3 id="heading--the-rbac-maas-security-architecture">The MAAS/RBAC security architecture</h3></a>

Explain clearly, with graphics, the joint architecture of MAAS, Candid, and RBAC, including the specific function of each piece and any limitations introduced by the fact that MAAS use of RBAC is hard-coded to resource pools (thus not infinitely flexible).

<a href="#heading--rbac-users-and-groups"><h3 id="heading--rbac-users-and-groups">RBAC users and groups vs. MAAS resource pools</h3></a>

Explain clearly how RBAC users and groups are managed across the MAAS/RBAC architecture, and how these attributes control access to resource pools.

<a href="#heading--maas-rbac-roles"><h3 id="heading--maas-rbac-roles">MAAS RBAC roles</h3></a>

A user needs to understand the MAAS RBAC roles (user, administrator, operator, and auditor).  Explain clearly how each of these roles work; what actions each role is capable of performing; and how these roles are limited by the MAAS RBAC architecture.

<a href="#heading--how-the-four-maas-roles-protect-maas-resources"><h3 id="heading--how-the-four-maas-roles-protect-maas-resource">How the four MAAS RBAC roles protect MAAS resources</h3></a>

Users need to understanding how the four MAAS RBAC roles manage the correspondence of users, groups, and resource pools to protect MAAS resources.  Explain clearly, with graphics, the typical experience of each of the four MAAS RBAC groups over a range of typical scenarios.

<a href="#heading--about-candid"><h2 id="heading--about-candid">About Candid</h2></a>

In order to properly design your MAAS/RBAC instance, you need to understand Candid -- not only what it provides, but how it works.  Knowing the underlying features and operational parameters of Candid will help you better plan your use of RBAC with MAAS.

<a href="#heading--what-candid-does-and-doesnt-do"><h3 id="heading--what-candid-does-and-doesnt-do">What Candid does and doesn't do</h3></a>

Users need a clear understanding of what Candid does (e.g., creates macaroons) and doesn’t do (e.g., provide identity, authenticate users).  Explain, with graphics, a more detailed view of how Candid fits into the MAAS RBAC ecosystem, specifically which services it does and doesn’t provide.

<a href="#heading--how-candid-interfaces-to-security-tools"><h3 id="heading--how-candid-interfaces-to-security-tools">How Candid interfaces with authentication and identity tools</h3></a>

A user needs a clear understanding of how Candid supports integration with underlying authentication systems and identity providers, including conspicuous examples related to using Candid with RBAC and MAAS.  Explain clearly, in simple terms, how Candid integrates with underlying auth systems and identity provides, and what Candid generates for RBAC.

<a href="#heading--the-candid-api"><h3 id="heading--the-candid-api">The Candid API</h3></a>

A user needs a clear understanding of the Candid API, what it does, and how it assists RBAC in managing user actions for MAAS.  Explain clearly how the Candid API works, what services it provides, and how RBAC accesses this API to integrate Candid into the MAAS ecosystem.

<a href="#heading--about-designing-maas-security-with-rbac"><h2 id="heading--about-designing-maas-security-with-rbac">Designing MAAS security with RBAC</h2></a>

As a MAAS RBAC administrator, you need to design strong, properly-configured, role-based access controls for MAAS, using RBAC.  Understanding the gap that RBAC fills – and how it fills it – will better equip you to do this.

<a href="#heading--the-unique-function-of-rbac"><h3 id="heading--the-unique-function-of-rbac">The unique function of RBAC</h3></a>

Users need clear understanding of what RBAC does that Candid and MAAS do not do, and how it is integrated with both Candid and MAAS to fill these gaps.  Explain, with graphics, a more detailed view of how RBAC fits into the MAAS RBAC ecosystem, specifically which services it does and doesn’t provide, and how it interfaces with Candid and MAAS to provide these services.  

<a href="#heading--roles-permissions-and-domains"><h3 id="heading--roles-permissions-and-domains">Roles, permissions, and domains</h3></a>

Users should have a clear understanding of RBAC roles, permissions, and domains, and the way in which they are implemented in MAAS (resource pools, users, etc).  Explain clearly, in simple terms, how RBAC accesses and manages roles, permissions, and domains (resource pools), and how it mediates access by role.

<a href="#heading--permissions-and-permitted-actions"><h3 id="heading--permissions-and-permitted-actions">Permissions and permitted actions</h3></a>

A user must have a clear understanding of the various defined roles, permissions, rights, and permitted actions when using RBAC with MAAS.  Explain clearly how RBAC controls the actions (access) of each role across normal MAAS operations, using a suitable example (Navy fleet management, example MAAS already created).

<a href="#heading--rbac-logging"><h3 id="heading--rbac-logging">RBAC logging</h3></a>

Users should understand logging and how it helps to audit and review actions taken by MAAS users. Explain clearly how RBAC logs help to establish an audit trail across the MAAS instance over time.