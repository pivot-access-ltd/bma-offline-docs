<!-- "How to manage user accounts" -->
Presumably, you have already created an administrative user, but MAAS can also have regular users (who log in to the interface or use the CLI). What users you create depends on how you intend to use MAAS.  An administrator can manage all aspects of MAAS, whereas a non-administrator user can perform a subset of tasks on machines they acquire and deploy.  MAAS limits the details a non-admin user can view, such as nodes allocated to other users. Also, non-admin users cannot access the global settings page in the web UI, nor any of the equivalent API calls from the command line.

Additionally, in order for a user to log into a MAAS-deployed machine that user must have their public SSH key installed on it.  This article explains how to create users and add their public SSH keys to MAAS, so that every deployed machine will automatically have that key installed.  This article will help you learn:

* [How to add a user](#heading--add-a-user)
* [How to change a user's preferences](#heading--user-preferences)
* [How to add an SSH key for a user](#heading--ssh-keys)
* [How to add an API key for a user](#heading--api-key)
* [How users can change their password](#heading--change-password)

[tabs]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="UI"]
You can manage user accounts from the 'Users' tab of the 'Settings' page.

<a href="https://assets.ubuntu.com/v1/76402e4b-manage-user-accounts__2.4_current-users.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/76402e4b-manage-user-accounts__2.4_current-users.png"></a>

[note]
A currently logged in user cannot delete themselves from the web UI.
[/note]
[/tab]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="CLI"]
```
USERNAME        EMAIL                     ADMIN?
--------        -----                     ------
admin           admin@admin.com           true
billwear        bwear@stormrider.io       true
MAAS            maas@localhost            false
maas-init-node  node-init-user@localhost  false
```

You can generate a list like this with the command:

```
maas admin users read \
| jq -r '(["USERNAME", "EMAIL", "ADMIN?"]
| (., map(length*"-"))), (.[]
| [.username, .email, .is_superuser]) | @tsv' \
| column -t
```

Note that you do not need line continuations within the `jq` command because it's quoted for the shell.
[/tab]
[/tabs]

<a href="#heading--add-a-user"><h2 id="heading--add-a-user">How to add a user</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="UI"]
Clicking the 'Add user' button will result in a form to be displayed:

<a href="https://assets.ubuntu.com/v1/1c59c2c5-manage-user-accounts__2.4_add-user.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/1c59c2c5-manage-user-accounts__2.4_add-user.png"></a>

Fill in the fields and hit 'Add user' when done.

<a href="#heading--user-preferences"><h2 id="heading--user-preferences">How to change a user's preferences</h2></a>

Clicking the MAAS username in the top right corner will show that user's preferences.
[/tab]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="CLI"]
To add a regular user, enter the following command:

```
maas $PROFILE users create username=$USERNAME \
    email=$EMAIL_ADDRESS password=$PASSWORD is_superuser=0
```

All the options are necessary. Note that stipulating a password on the CLI may be a security hazard, depending on your environment.
[/tab]
[/tabs]

<a href="#heading--ssh-keys"><h3 id="heading--ssh-keys">How to add an SSH key for a user</h3></a>

Before a user can deploy a machine, they must import at least one public SSH key into MAAS. This key allows the user to access the deployed machine with the corresponding private key, which the user must possess. See [Public key authentication](https://www.ssh.com/ssh/public-key-authentication) (ssh.com) if you're not familiar with SSH keys.

Assuming a public key exists in `/home/ubuntu/.ssh/id_rsa.pub` - add a key with the following command:
```
ubuntu@maas:~$ maas $PROFILE sshkeys create key="$(cat /home/ubuntu/.ssh/id_rsa.pub)"
Success.
```

[note]
The user normally imports their initial SSH key on the first login to the web UI.
[/note]

[tabs]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="UI"]
To add a locally-generated public key, select 'Upload' from the 'Source' menu and paste the complete contents of your key file, usually called `id_rsa.pub`, into the 'Public key' field. Click 'Import' to add the key to MAAS.

Public keys residing on either [Launchpad](https://help.launchpad.net/YourAccount) or [GitHub](https://help.github.com/articles/connecting-to-github-with-ssh/) can also be added. Select either from the 'Source' menu and specify the user ID associated with the key(s). Press the 'Import' button to add any keys MAAS discovers to the current user's MAAS account.

<a href="https://assets.ubuntu.com/v1/fc95765e-manage-user-accounts__2.4_add-user-ssh-key.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/fc95765e-manage-user-accounts__2.4_add-user-ssh-key.png"></a>

<a href="#heading--api-key"><h3 id="heading--api-key">How to add an API key for a user</h3></a>

The user preferences page includes an API key for the currently active user. This key can be copied and regenerated as needed. The API key is used to login to the API from the [MAAS CLI](/t/how-to-use-the-maas-cli/5236).  Other services connecting to MAAS such as Juju will also need this key.
[/tab]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="CLI"]
We recommend that you use the web UI to set or change a user's API key.  To see how, select the "UI" choice in the dropdown above.
[/tab]
[/tabs]

<a href="#heading--change-password"><h3 id="heading--change-password">How users can change their password</h3></a>

[tabs]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="UI"]
The current user can change their password at the bottom of the page by entering the old password and entering the new password twice. Click 'Save password' to finish.

<a href="https://assets.ubuntu.com/v1/289ef578-manage-user-accounts__2.4_change-user-password.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/289ef578-manage-user-accounts__2.4_change-user-password.png"></a>

[note]
An administrator can change any user's password from within the 'Users' tab of the 'Settings' page.
[/note]
[/tab]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="CLI"]
We recommend that you use the web UI to change user passwords.  To see how, select the "UI" choice in the dropdown above.
[/tab]
[/tabs]