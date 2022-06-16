<!-- "How to install and use RBAC with MAAS" -->

Prologue text that explains what this document is about.

* How to set up identity management for RBAC 
[4] As a MAAS RBAC administrator, I want to properly set up the environment for Candid and RBAC to be used.
As an RBAC administrator, I need step-by-step procedures that guide me through pre-installation configuration.
** How to set up and install identity management
** How to install and enable Candid
A user has detailed instructions for installing and enabling Candid.
Provide detailed instructions about Candid installation.
** How to configure and load Candid
A user has detailed instructions for configuring and loading Candid.
Provide detailed instructions for configuring Candid via /var/snap/candid/current/config.yaml, starting Candid, editing /root/admin.keys to have the correct URL for Candid, and creating the necessary credentials, including a self-signed certificate for Candid.
** How to verify that ID server and Candid are working properly
A user has detailed procedures for verifying that a compatible authentication system is installed and working.
Provide detailed instructions about which authentication systems are compatible with RBAC, how they must be configured, and how to verify that they are properly configured.  
** How to ensure that Candid has proper certificates
A user has detailed instructions for ensuring that valid certificates can be generated and used as needed for Candid to communicate over HTTPS.
Provide detailed instructions regarding the CA and certificates needed, as well as instructions for verifying that they are properly configured.

* How to install and configure RBAC
[5] As a MAAS RBAC administrator, I want to properly install and configure RBAC and Candid.
As an RBAC administrator, I need step-by-step procedures that guide me through the process of installing RBAC and Candid.
** How to obtain PPA credentials and install RBAC
Provide detailed instructions for obtaining PPA credentials, including necessary contact information and/or links.
** How to set up, configure, and load RBAC
Provide indirect instructions on how to login to Launchpad, visit your private PPA, set the necessary credentials, add your private PPA, and install the RBAC package.
** How to log into RBAC and verify correct setup and operation
Provide detailed instructions about how to pass the Candid cert to RBAC; define RBAC cert, public key, and CA via SSL; create the appropriate credentials; configure RBAC to use these credentials; verify correct operation of the service-URL; and create an RBAC administrative user.

* How to connect MAAS and RBAC
[6] As a MAAS RBAC administrator, I want to properly connect MAAS to RBAC and establish baseline test users.
As an RBAC administrator, I need step-by-step procedures that guide me through the process of making MAAS talk to RBAC successfully.
Acceptance criteria
** How to configure MAAS to use RBAC and log in
Provide detailed instructions about how to configure MAAS to use RBAC, including defining the service name and URL of the RBAC service, along with a login procedure that verifies that the RBAC-MAAS connection is working correctly.

** How to create (or use existing) resource pools
Provide detailed instructions for creating new resource pools, or provide a procedure for using existing resource pools.

** How to create test users
Provide detailed instructions for creating test users, or provide a procedure for using existing test users already established.

** How to assign test users to resource pools
Provide instructions on how to associate test users with resource pools.

** How to verify that RBAC is working correctly with MAAS
Provide detailed instructions for using the RBAC test cases created thus far to verify that RBAC is working correctly with MAAS.

* How to operate and maintain RBAC
[7] As a MAAS RBAC administrator, I want to understand how to operate and maintain RBAC.
As an RBAC administrator, I need step-by-step procedures that guide me through the various day-to-day aspects of RBAC components, services, groups, roles, and permissions.
** How to use and configure services 
Provide detailed instructions about MAAS services, as exposed in RBAC, and how they can be manipulated and configured

** How to use and configure scopes 
Provide detailed instructions about scopes, and how they should be configured and applied

** How to assign roles to users
Provide detailed instructions about the way RBAC tabulates roles, services, etc, including the way the hierarchy flows from left to right, how to change views, and how to manipulate items in those views

** How to properly match permissions with roles, scopes, and services 
Provide detailed instructions about the way RBAC tabulates roles, services, etc, including the way the hierarchy flows from left to right, how to change views, and how to manipulate items in those views

** How to navigate and change the views in RBAC
Provide detailed instructions about the way RBAC tabulates roles, services, etc, including the way the hierarchy flows from left to right, how to change views, and how to manipulate items in those views

** How to add, edit, remove, and reassign various user aspects of RBAC wrt MAAS, includ an understand of when changes are actually applied (eg, the way that some of the screens operate like rollback buffers)
Provide detailed procedures for managing the relationships between roles, permissions, users, groups, and resource pools, including how to add, edit, remove, and reassign them; explain how changes are “buffered”, ie, not implemented until a separate choice is made

** How to deal with non-machine-related attributes, such as DNS, availability zones, setts, and images use RBAC
Provide detailed instructions for address the various non-machine-related components of MAAS that are exposed in RBAC

* How to audit user actions
[8] As a MAAS RBAC administrator, operator, or auditor, I want to understand how to use RBAC logging to review user actions
As an RBAC administrator, operator, or auditor, I need step-by-step procedures that guide me through the process of reviewing, analyzing, and correlating log entries
** How to access RBAC logs 
Provide detailed instructions about RBAC logs, how to find them, how to access them, and how to export them

** How to post-process RBAC logs, including built-in filter tools and command-line process of exported logs
Provide detailed instructions for RBAC logs use built-in filter capability
Provide suggestions and examples for analyz RBAC logs us command line tools on exported log files

** How to correlate actions and events with users, roles, and permissions
Provide detailed procedures for correlating user actions and events with the correct users, roles, and permissions