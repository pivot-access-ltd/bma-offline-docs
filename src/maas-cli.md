<a href="#heading--about-the-maas-cli"><h2 id="heading--about-the-maas-cli">About the MAAS CLI</h2></a>

The MAAS CLI can do everything that the web UI can do, and more. The CLI uses the `maas` command exclusively which, in turn, connects to the API.  This page explains what is needed to get started with the CLI. You can obtain the MAAS CLI from the `maas-cli` Ubuntu package installed on every region API server and rack controller.

Immediately after installing the MAAS CLI, you will need to create an administrator account, in order to access most of the CLI features.  You can also create [regular users](/t/user-accounts/nnnn#heading--add-a-user), as desired.
As a security measure, MAAS generates an API key when creating your MAAS account, which you must use when logging in.  This API key can be obtained via a special command to the MAAS CLI.  You can obtain a user's API key from the web interface. 
[/note]

For additional MAAS CLI commands, you can consult the MAAS CLI help or access the CLI versions of the pages listed in the left-hand navigation. MAAS has a thorough built-in help reference, which you can access in stages to understand how to build commands. The `maas` command accepts the `-h` or `--help` argument after every keyword and will display results with increasing detail as you add elements to the help request.


#### This article will show you:

* [How to install the MAAS CLI?](#heading--install-the-maas-cli)
* [How to create an administrator account](#heading--create-an-administrator)
* [How to obtain the administrator's API key](#heading--obtain-an-api-key)
* [How to obtain a user's API key](#heading--obtain-a-users-api-key)
* [How to login to the MAAS CLI](#heading--log-in)
* [How to create a MAAS CLI login shellscript](#heading--cli-login-shellscript)
* [How to get help from the MAAS CLI](#heading--get-help)
* [How to log out of the MAAS CLI](#heading--log-out)

<a href="#heading--the-maas-command"><h2 id="heading--install-the-maas-cli">How do install the MAAS CLI</h2></a>

To install the MAAS CLI, execute this command:

``` nohighlight
sudo apt install maas-cli
```

<a href="#heading--create-an-administrator"><h2 id="heading--create-an-administrator">How to create an administrator account</h2></a>

You can create one or more MAAS CLI administrator accounts like this:

``` nohighlight
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

Be sure to substitute your desired administrative username for $PROFILE, and substitute an email address from $EMAIL_ADDRESS.  Note that the $EMAIL_ADDRESS, while required to create an administrator, is not currently used by MAAS.

<a href="#heading--obtain-an-api-key"><h2 id="heading--obtain-an-api-key">How to obtain the administrator's API key</h2></a>

To obtain the API key needed by an administrator, run this command on the region controller:

``` nohighlight
sudo maas apikey --username=$PROFILE > $API_KEY_FILE
```

$PROFILE should be replaced with the administrator username you created; substitute a filename for $API_KEY_FILE.

<a href="#heading--obtain-a-users-api-key"><h2 id="heading--obtain-a-users-api-key">How to obtain a user's API key</h2></a>

To obtain a user's API key, click on 'username' in the top right corner of any MAAS screen (when logged in), and select 'Account'.

<a href="#heading--log-in"><h2 id="heading--log-in">How to log into the MAAS CLI </h2></a>

To log in to the MAAS CLI, execute the following command on the API server (the region controller):

``` nohighlight
maas login $PROFILE $MAAS_URL - < $API_KEY_FILE
```

$PROFILE is the administrator username you're using to log in.  The $MAAS_URL is the URL shared with you when you initialised MAAS (e.g., http://localhost:5240/MAAS/api/2.0).  $API_KEY_FILE is the name of the file where you stored the API KEY when you requested it from the CLI.

<a href="#heading--cli-login-shellscript"><h2 id="heading--cli-login-shellscript">How to create a MAAS CLI login shellscript</h2></a>

To create a MAAS login shellscript, say `maas-login.sh`, enter the following into a file with your favorite text editor:

``` no-highlight
#!/bin/sh

# Change these 3 values as required 
PROFILE=admin
API_KEY_FILE=/home/ubuntu/tmp/api_key
API_SERVER=localhost

MAAS_URL=http://$API_SERVER/MAAS/api/2.0

maas login $PROFILE $MAAS_URL - < $API_KEY_FILE
```

You must change the permissions on this file to make it executable with the `chmod` command.  Also, for best results, make sure to place the script in directory that's part of your `$PATH`.

<a href="#heading--get-help"><h2 id="heading--get-help">How to get help from the MAAS CLI</h2></a>

To get help from the MAAS CLI, enter the following command:

``` nohighlight
maas $PROFILE --help
```

Substitute your administrator username for $PROFILE.  You will receive a list of all commands.

Add more elements to the help request to receive more detailed help.  For example, to get help on the `tags` command, enter:

``` nohighlight
maas $PROFILE tags --help
```

To get help on creating a tag, enter:

``` nohighlight
maas admin tags create --help
```

To continue refining your help request, keep adding more elements as they become visible in the latest help output.

<a href="#heading--log-out"><h2 id="heading--log-out">How to log out of the MAAS CLI</h2></a>

You can log out of the MAAS CLI with the following command:

``` nohighlight
maas logout $PROFILE
```

Substitute $PROFILE for the name of the administrative user who is logging off.

