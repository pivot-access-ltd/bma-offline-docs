The MAAS CLI can do everything that the web UI can do, and more. The CLI uses the `maas` command exclusively which, in turn, connects to the API.  This page explains what is needed to get started with the CLI.

Note that this article does not provide complete coverage of the MAAS CLI. For an exhaustive treatment, you may want to check the API documentation.  Also note that this page represents user-entered values as uppercase variables preceded with the '$' character (e.g. $PROFILE and $EMAIL_ADDRESS). You should replace these placeholders with actual values.

#### Six questions you may have:

1. [How do I access the MAAS CLI?](/t/maas-cli/802#heading--the-maas-command)
2. [How do I create an administrator account?](/t/maas-cli/802#heading--create-an-administrator)
3. [How do I complete the required login?](/t/maas-cli/802#heading--log-in-required)
4. [How do I get help via the CLI?](/t/maas-cli/802#heading--get-help)
5. [How do I log out?](/t/maas-cli/802#heading--log-out)
6. [What are some the next steps I can take with the CLI?](/t/maas-cli/802#heading--next-steps)

<a href="#heading--the-maas-command"><h2 id="heading--the-maas-command">The maas command</h2></a>

You can obtain the `maas` command via the `maas-cli` Ubuntu package installed on every region API server and rack controller. To manage MAAS at the CLI level from a remote workstation, you will need to install this package:

``` bash
sudo apt install maas-cli
```

<a href="#heading--create-an-administrator"><h2 id="heading--create-an-administrator">Create an administrator</h2></a>

MAAS requires an initial administrator, sometimes called a MAAS "superuser". When you access the web UI for the first time, you will be prompted to create this user:

``` bash
sudo maas createadmin --username=$PROFILE --email=$EMAIL_ADDRESS
```

You can create extra administrators in the same way. See [MAAS CLI - common tasks](/t/common-cli-tasks/794#heading--create-a-regular-user) for instructions on creating regular users with the CLI.

<a href="#heading--log-in-required"><h2 id="heading--log-in-required">Log in (required)</h2></a>

To use the CLI you must first log in to the API server (region controller).

You will need the API key that MAAS generated when creating your MAAS account. To obtain it, run this command on the region controller (i.e. wherever you installed the 'maas-region-controller' package):

``` bash
sudo maas-region apikey --username=$PROFILE > $API_KEY_FILE
```

[note]
You can obtain a user's API key from the web interface. Click on 'username' in the top right corner, and select 'Account'.
[/note]

Log in. MAAS will prompt you for the API key:

``` bash
maas login $PROFILE $MAAS_URL
```

For example, to log in with the account whose username is 'admin' and where the region controller is on the localhost:

``` bash
maas login admin http://localhost:5240/MAAS/api/2.0
```

To log in by referring to the API key file created earlier:

``` bash
maas login $PROFILE $MAAS_URL - < $API_KEY_FILE
```

A handy shell script, say `maas-login.sh`, is provided:

``` no-highlight
#!/bin/sh

# Change these 3 values as required 
PROFILE=admin
API_KEY_FILE=/home/ubuntu/tmp/api_key
API_SERVER=localhost

MAAS_URL=http://$API_SERVER/MAAS/api/2.0

maas login $PROFILE $MAAS_URL - < $API_KEY_FILE
```

<a href="#heading--get-help"><h2 id="heading--get-help">Get help</h2></a>

MAAS has a thorough built-in help reference, which you can access in stages to understand how to build commands.

The `maas` command accepts the `-h` or `--help` argument after every keyword and will display results with increasing detail.

For example, suppose you were interested in tag management but didn't know where to start. You might try this:

``` bash
maas $PROFILE --help
```

At this stage, you'll see all available MAAS commands, including the `tag` and `tags` commands, along with a brief explanation of what each command does. To see what the `tag` and `tags` commands have to offer, try:

``` bash
maas $PROFILE tag --help
```

And:

``` bash
maas $PROFILE tags --help
```

Suppose you want to create a new rudimentary tag. Find the next level of help like this:

``` bash
maas admin tags create --help
```

In this way, you can discover all that the MAAS CLI has to offer.

<a href="#heading--log-out"><h2 id="heading--log-out">Log out</h2></a>

Once you finish with the CLI, you can log out from the given profile, flushing the stored credentials.

``` bash
maas logout $PROFILE
```

<a href="#heading--next-steps"><h2 id="heading--next-steps">Next steps</h2></a>

The following five categories are now available to be explored:

1.   [Common tasks](/t/common-cli-tasks/794)
2.   [Kernel management](/t/cli-kernel-management/799)
3.   [Image management](/t/cli-image-management/797)
4.   [Advanced tasks](/t/cli-advanced-tasks/793)
5.   [Composable hardware](/t/cli-composable-hardware/795)



------
**source verified**
------