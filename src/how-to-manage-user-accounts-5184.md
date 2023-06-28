<!-- How to manage user accounts -->
<a href="#heading--add-a-user"><h2 id="heading--add-a-user">How to add a user</h2></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages" view="UI"]
To add a user:

1. Go to *Settings >> Users*.

2. Select *Add user*.

3. Fill in the fields in the displayed form.

4. Optionally make the user a *MAAS administrator* by checking the box.

4. Select *Save user* to register your changes.

<a href="#heading--user-preferences"><h2 id="heading--user-preferences">How to change a user's preferences</h2></a>

1. Select the MAAS username near the bottom of the left-hand navigation panel.

2. Under *Details*, change the *Username*, *Full name*, or *Email address* as desired.

3. Under *Details*, select *Change password...* to change the user's password.

4. Under *API key*, edit, delete, or *Generate MAAS API keys* as desired.

5. Under *SSH keys*, delete or *Import SSH keys* as desired.

6. Under *SSL keys*, delete or *Add SSL keys* as desired.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To add a user:

1. Go to *Settings >> Users*.

2. Select *Add user*.

3. Fill in the fields in the displayed form.

4. Optionally make the user a *MAAS administrator* by checking the box.

4. Select *Add user* to register your changes.

<a href="#heading--user-preferences"><h2 id="heading--user-preferences">How to change a user's preferences</h2></a>

Clicking the MAAS username in the top right corner will show that user's preferences.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
To add a regular user, enter the following command:

```
maas $PROFILE users create username=$USERNAME \
    email=$EMAIL_ADDRESS password=$PASSWORD is_superuser=0
```

All the options are necessary. Note that stipulating a password on the CLI may be a security hazard, depending on your environment.
[/tab]
[/tabs]

<a href="#heading--ssh-keys"><h3 id="heading--ssh-keys">How to add an SSH key for a user</h3></a>

Assuming a public key exists in `/home/ubuntu/.ssh/id_rsa.pub` - add a key with the following command:
```
ubuntu@maas:~$ maas $PROFILE sshkeys create key="$(cat /home/ubuntu/.ssh/id_rsa.pub)"
Success.
```

[note]
The user normally imports their initial SSH key on the first login to the web UI.
[/note]

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
To add a locally-generated public key to a user:

1. Select *Settings > Users*.

2. Select the pencil icon to the right of the user that needs the additional key.

3. Select *Import SSH key*.

4. Select *Upload* from the *Source* dropdown and paste the complete contents of the key file, usually called `id_rsa.pub`.

5. Alternatively, you can select *Launcpad* or *GitHub*, if you want to load a SSH key from there.  You will need to enter the user ID associated with the key.

6. Select *Import SSH key* to register your changes.

<a href="#heading--api-key"><h3 id="heading--api-key">How to add an API key for a user</h3></a>

To add an API key for a user:

1. Select *Settings > Users*.

2. Select the pencil icon to the right of the user that needs an API key.

3. Select *API keys*.

4. Select *Generate MAAS API key*.

5. Optionally enter a name for the API key.

6. Select *Generate API key* to create the new key.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
We recommend that you use the web UI to set or change a user's API key.  To see how, select the "UI" choice in the dropdown above.
[/tab]
[/tabs]

<a href="#heading--change-password"><h3 id="heading--change-password">How users can change their password</h3></a>

[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
The current user can change their password with the following procedure:

1. Select *Settings > Users*.

2. Select the pencil icon to the far right of the username.  

3. Select *Details*.

3. Select *Change password...* at the bottom of the screen. The screen will extend.

4. Enter the *Current password*.

5. Enter the *New password*.

6. Enter the *New password (again)*.  Note that both new password entries must match.

7. Select *Save* to register the changes.

[note]
An administrator can change any user's password from *Settings > Users*.
[/note]
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]
We recommend that you use the web UI to change user passwords.  To see how, select the "UI" choice in the dropdown above.
[/tab]
[/tabs]
