<!-- "How to install and use RBAC with MAAS" -->

Prologue text that explains what this document is about.

<a href="#heading--how-to-set-up-id-mgmt-for-rbac"><h2 id="heading--how-to-set-up-id-mgmt-for-rbac">How to set up identity management for RBAC </h2></a>

As a MAAS RBAC administrator, you want to properly set up the environment for Candid and RBAC to be used. As an RBAC administrator, you need step-by-step procedures that guide you through pre-installation configuration.

<a href="#heading--how-to-set-up-n-install-id-mgmt"><h3 id="heading--how-to-set-up-n-install-id-mgmt">How to set up and install identity management</h3></a>

<a href="#heading--how-to-install-n-enable-candid"><h3 id="heading--how-to-install-n-enable-candid">How to install and enable Candid</h3></a>

A user has detailed instructions for installing and enabling Candid. Provide detailed instructions about Candid installation.

<a href="#heading--how-to-configure-n-load-candid"><h3 id="heading--how-to-configure-n-load-candid">How to configure and load Candid</h3></a>

A user has detailed instructions for configuring and loading Candid. Provide detailed instructions for configuring Candid via /var/snap/candid/current/config.yaml, starting Candid, editing /root/admin.keys to have the correct URL for Candid, and creating the necessary credentials, including a self-signed certificate for Candid.

<a href="#heading--how-to-verify-candid-operation"><h3 id="heading--how-to-verify-candid-operation">How to verify Candid operation</h3></a>

A user has detailed procedures for verifying that a compatible authentication system is installed and working. Provide detailed instructions about which authentication systems are compatible with RBAC, how they must be configured, and how to verify that they are properly configured.  

<a href="#heading--how-to-ensure-proper-certificates"><h3 id="heading--how-to-ensure-proper-certificates">How to ensure proper certificates</h3></a>

A user has detailed instructions for ensuring that valid certificates can be generated and used as needed for Candid to communicate over HTTPS. Provide detailed instructions regarding the CA and certificates needed, as well as instructions for verifying that they are properly configured.

<a href="#heading--how-to-install-n-configure-rbac"><h2 id="heading--how-to-install-n-configure-rbac">How to install and configure RBAC</h2></a>

As a MAAS RBAC administrator, you want to properly install and configure RBAC and Candid. As an RBAC administrator, you need step-by-step procedures that guide you through the process of installing RBAC and Candid.

<a href="#heading--how-to-install-rbac"><h3 id="heading--how-to-install-rbac">How to install RBAC</h3></a>

Provide detailed instructions for obtaining PPA credentials, including necessary contact information and/or links.

<a href="#heading--how-to-set-up-rbac"><h3 id="heading--how-to-set-up-rbac">How to set up RBAC</h3></a>

Provide indirect instructions on how to login to Launchpad, visit your private PPA, set the necessary credentials, add your private PPA, and install the RBAC package.

<a href="#heading--how-to-verify-rbac-setup"><h3 id="heading--how-to-verify-rbac-setup">How to log into RBAC and verify RBAC setup</h3></a>

Provide detailed instructions about how to pass the Candid cert to RBAC; define RBAC cert, public key, and CA via SSL; create the appropriate credentials; configure RBAC to use these credentials; verify correct operation of the service-URL; and create an RBAC administrative user.

<a href="#heading--how-to-connect-maas-n-rbac"><h2 id="heading--how-to-connect-maas-n-rbac">How to connect MAAS and RBAC</h2></a>

As a MAAS RBAC administrator, you want to properly connect MAAS to RBAC and establish baseline test users. As an RBAC administrator, you need step-by-step procedures that guide you through the process of making MAAS talk to RBAC successfully.

<a href="#heading--how-to-configure-maas-with-rbac"><h3 id="heading--how-to-configure-maas-with-rbac">How to configure MAAS with RBAC</h3></a>

Provide detailed instructions about how to configure MAAS to use RBAC, including defining the service name and URL of the RBAC service, along with a login procedure that verifies that the RBAC-maas connection is working correctly.

<a href="#heading--how-to-use-resource-pools"><h3 id="heading--how-to-use-resource-pools">How to use resource pools</h3></a>

Provide detailed instructions for creating new resource pools, or provide a procedure for using existing resource pools.

<a href="#heading--how-to-create-test-users"><h3 id="heading--how-to-create-test-users">How to create test users</h3></a>

Provide detailed instructions for creating test users, or provide a procedure for using existing test users already established.

<a href="#heading--how-to-assign-test-users"><h3 id="heading--how-to-assign-test-users">How to assign test users</h3></a>

Provide instructions on how to associate test users with resource pools.

<a href="#heading--how-to-verify-rbac-with-maas"><h3 id="heading--how-to-verify-rbac-with-maas">How to verify RBAC with MAAS</h3></a>

Provide detailed instructions for using the RBAC test cases created thus far to verify that RBAC is working correctly with MAAS.

<a href="#heading--how-to-operate-rbac"><h2 id="heading--how-to-operate-rbac">How to operate RBAC</h2></a>

As a MAAS RBAC administrator, you want to understand how to operate and maintain RBAC. As an RBAC administrator, you need step-by-step procedures that guide you through the various day-to-day aspects of RBAC components, services, groups, roles, and permissions.

<a href="#heading--how-to-configure-services"><h3 id="heading--how-to-configure-services">How to configure services</h3></a>

Provide detailed instructions about MAAS services, as exposed in RBAC, and how they can be manipulated and configured

<a href="#heading--how-to-configure-scopes"><h3 id="heading--how-to-configure-scopes">How to configure scopes</h3></a>

Provide detailed instructions about scopes, and how they should be configured and applied

<a href="#heading--how-to-assign-roles"><h3 id="heading--how-to-assign-roles">How to assign roles</h3></a>

Provide detailed instructions about the way RBAC tabulates roles, services, etc, including the way the hierarchy flows from left to right, how to change views, and how to manipulate items in those views

<a href="#heading--how-to-set-perms"><h3 id="heading--how-to-properly-set-perms">How to set permissions</h3></a>

Provide detailed instructions about the way RBAC tabulates roles, services, etc, including the way the hierarchy flows from left to right, how to change views, and how to manipulate items in those views

<a href="#heading--how-to-navigate-rbac"><h3 id="heading--how-to-navigate-rbac">How to navigate RBAC</h3></a>

Provide detailed instructions about the way RBAC tabulates roles, services, etc, including the way the hierarchy flows from left to right, how to change views, and how to manipulate items in those views

<a href="#heading--how-to-modify-rbac-users"><h3 id="heading--how-to-modify-rbac-users">How to modify RBAC users</h3></a>

Provide detailed procedures for managing the relationships between roles, permissions, users, groups, and resource pools, including how to add, edit, remove, and reassign them; explain how changes are “buffered”, ie, not implemented until a separate choice is made

<a href="#heading--how-to-deal-with-non-machine-related-attributes"><h3 id="heading--how-to-deal-with-non-machine-related-attributes">How to deal with non-machine-related attributes</h3></a>

Provide detailed instructions for address the various non-machine-related components of MAAS that are exposed in RBAC

<a href="#heading--how-to-audit-user-actions"><h2 id="heading--how-to-audit-user-actions">How to audit user actions</h2></a>

As a MAAS RBAC administrator, operator, or auditor, you want to understand how to use RBAC logging to review user actions As an RBAC administrator, operator, or auditor, you need step-by-step procedures that guide you through the process of reviewing, analyzing, and correlating log entries

<a href="#heading--how-to-access-rbac-logs"><h3 id="heading--how-to-access-rbac-logs">How to access RBAC logs </h3></a>

Provide detailed instructions about RBAC logs, how to find them, how to access them, and how to export them

<a href="#heading--how-to-post-process-rbac-logs"><h3 id="heading--how-to-post-process-rbac-logs">How to post-process RBAC logs</h3></a>

Provide detailed instructions for RBAC logs use built-in filter capability. Provide suggestions and examples for analyz RBAC logs us command line tools on exported log files

<a href="#heading--how-to-correlate-actions-events-n-users"><h3 id="heading--how-to-correlate-actions-events-n-users">How to correlate actions, events, and users</h3></a>

Provide detailed procedures for correlating user actions and events with the correct users, roles, and permissions