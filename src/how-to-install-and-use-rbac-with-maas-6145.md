<!-- "How to install and use RBAC with MAAS" -->

Prologue text that explains what this document is about.

* How to set up identity management for RBAC 
[4] As a MAAS RBAC administrator, I want to properly set up the environment for Candid and RBAC to be used.
As an RBAC administrator, I need step-by-step procedures that guide me through pre-installation configuration.
Acceptance criteria
A user has detailed procedures for verifying that a compatible authentication system is installed and working.
A user has detailed instructions for ensuring that valid certificates can be generated and used as needed for Candid to communicate over HTTPS.
Work items:
Provide detailed instructions about which authentication systems are compatible with RBAC, how they must be configured, and how to verify that they are properly configured.  
Provide detailed instructions regarding the CA and certificates needed, as well as instructions for verifying that they are properly configured.

* How to install and configure RBAC
[5] As a MAAS RBAC administrator, I want to properly install and configure RBAC and Candid.
As an RBAC administrator, I need step-by-step procedures that guide me through the process of installing RBAC and Candid.
Acceptance criteria
A user has detailed instructions for installing and enabling Candid. 
A user has detailed instructions for configuring and loading Candid.
A user has detailed procedures for obtaining PPA credentials and installing RBAC.
A user has detailed instructions for setting up, configuring, and loading RBAC.
A user has detailed instructions for logging into RBAC and verifying correct setup and operation.
Work items:
Provide detailed instructions about Candid installation.
Provide detailed instructions for configuring Candid via /var/snap/candid/current/config.yaml, starting Candid, editing /root/admin.keys to have the correct URL for Candid, and creating the necessary credentials, including a self-signed certificate for Candid.
Provide detailed instructions for obtaining PPA credentials, including necessary contact information and/or links.
Provide indirect instructions on how to login to Launchpad, visit your private PPA, set the necessary credentials, add your private PPA, and install the RBAC package.
Provide detailed instructions about how to pass the Candid cert to RBAC; define RBAC cert, public key, and CA via SSL; create the appropriate credentials; configure RBAC to use these credentials; verify correct operation of the service-URL; and create an RBAC administrative user.

* How to connect MAAS and RBAC
[6] As a MAAS RBAC administrator, I want to properly connect MAAS to RBAC and establish baseline test users.
As an RBAC administrator, I need step-by-step procedures that guide me through the process of making MAAS talk to RBAC successfully.
Acceptance criteria
A user has detailed instructions for configuring MAAS to use RBAC, and logging in. 
A user has detailed instructions for creating (or using existing) resource pools.
A user has detailed procedures for creating test users.
A user has detailed instructions for assigning test users to resource pools.
A user has detailed procedures for verifying that RBAC is working correctly with MAAS.
Work items:
Provide detailed instructions about how to configure MAAS to use RBAC, including defining the service name and URL of the RBAC service, along with a login procedure that verifies that the RBAC-MAAS connection is working correctly.
Provide detailed instructions for creating new resource pools, or provide a procedure for using existing resource pools.
Provide detailed instructions for creating test users, or provide a procedure for using existing test users already established.
Provide instructions on how to associate test users with resource pools.
Provide detailed instructions for using the RBAC test cases created thus far to verify that RBAC is working correctly with MAAS.

* How to operate and maintain RBAC
[7] As a MAAS RBAC administrator, I want to understand how to operate and maintain RBAC.
As an RBAC administrator, I need step-by-step procedures that guide me through the various day-to-day aspects of RBAC components, services, groups, roles, and permissions.
Acceptance criteria
A user has detailed instructions for using and configuring services. 
A user has detailed instructions for using and configuring scopes. 
A user has detailed instructions for assigning roles to users.
A user has a detailed procedure for properly matching permissions with roles, scopes, and services. 
A user has detailed instructions for navigating and changing the views in RBAC.
A user has detailed procedures for adding, editing, removing, and reassigning various user aspects of RBAC wrt MAAS, including an understanding of when changes are actually applied (e.g., the way that some of the screens operate like rollback buffers).
A user has detailed instructions for dealing with non-machine-related attributes, such as DNS, availability zones, settings, and images using RBAC.
Work items:
Provide detailed instructions about MAAS services, as exposed in RBAC, and how they can be manipulated and configured.
Provide detailed instructions about scopes, and how they should be configured and applied.
Provide detailed instructions about the way RBAC tabulates roles, services, etc., including the way the hierarchy flows from left to right, how to change views, and how to manipulate items in those views.
Provide detailed procedures for managing the relationships between roles, permissions, users, groups, and resource pools, including how to add, edit, remove, and reassign them; explain how changes are “buffered”, i.e., not implemented until a separate choice is made.
Provide detailed instructions for addressing the various non-machine-related components of MAAS that are exposed in RBAC.

* How to audit user actions
[8] As a MAAS RBAC administrator, operator, or auditor, I want to understand how to use RBAC logging to review user actions.
As an RBAC administrator, operator, or auditor, I need step-by-step procedures that guide me through the process of reviewing, analyzing, and correlating log entries.
Acceptance criteria
A user has detailed instructions for accessing RBAC logs. 
A user has detailed instructions for post-processing RBAC logs, including built-in filtering tools and command-line processing of exported logs. 
A user has detailed instructions for correlating actions and events with users, roles, and permissions.
Work items:
Provide detailed instructions about RBAC logs, how to find them, how to access them, and how to export them.
Provide detailed instructions for RBAC logs using built-in filtering capability.
Provide suggestions and examples for analyzing RBAC logs using command line tools on exported log files.
Provide detailed procedures for correlating user actions and events with the correct users, roles, and permissions.