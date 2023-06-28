<!-- User accounts -->
Presumably, you have already created an administrative user, but MAAS can also have regular users (who log in to the interface or use the CLI). What users you create depends on how you intend to use MAAS.  An administrator can manage all aspects of MAAS, whereas a non-administrator user can perform a subset of tasks on machines they allocate and deploy.  MAAS limits the details a non-admin user can view, such as nodes allocated to other users. Also, non-admin users cannot access the global settings page in the web UI, nor any of the equivalent API calls from the command line.

Additionally, in order for a user to log into a MAAS-deployed machine that user must have their public SSH key installed on it.  This article explains how to create users and add their public SSH keys to MAAS, so that every deployed machine will automatically have that key installed. 

[note]
A currently logged in user cannot delete themselves from the web UI.
[/note]

The user preferences page includes an API key for the currently active user. This key can be copied and regenerated as needed. The API key is used to login to the API from the [MAAS CLI](/t/try-out-the-maas-cli/5236).  Other services connecting to MAAS such as Juju will also need this key.

Before a user can deploy a machine, they must import at least one public SSH key into MAAS. This key allows the user to access the deployed machine with the corresponding private key, which the user must possess. See [Public key authentication](https://www.ssh.com/ssh/public-key-authentication) (ssh.com)`↗` if you're not familiar with SSH keys.


