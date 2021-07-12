
This is the placeholder for the MAAS installation tutorial.

rad-begin /snap/3.0/cli /snap/3.0/ui
<a href="#heading--example"><h3 id="heading--example">Example of MAAS initialisation</h3></a>

The following demonstrates the `region+rack` mode, a popular initialisation choice for MAAS:

    sudo maas init region+rack

`maas` will ask for the MAAS URL:

    MAAS URL [default=http://10.55.60.1:5240/MAAS]: http://192.168.122.1:5240/MAAS

If you also need to create an admin user, you can use:

    sudo maas createadmin

which takes you through the following exchange:

    Create first admin account:       
    Username: admin
    Password: ******
    Again: ******
    Email: admin@example.com
    Import SSH keys [] (lp:user-id or gh:user-id): lp:petermatulis

[note]
You will use the username and password created above to access the web UI.  If you enter a [Launchpad](https://launchpad.net/) or [GitHub](https://github.com) account name with associated SSH key, MAAS will import them automatically.
[/note]
