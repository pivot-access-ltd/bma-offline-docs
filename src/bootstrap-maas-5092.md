<!-- "Bootstrap MAAS" -->
This guide will take you through getting MAAS set up to manage your physical servers and data centers.

- **Installation**: We'll install the MAAS software on your target server along with any needed dependencies. 

- **Database setup**: Next, we'll configure a PostgreSQL database and user account for MAAS to use.

- **Security and connectivity enhancements**: We'll lock things down by enabling SSL encryption for the web UI and setting up VLAN connections to your servers. 

- **Tweaking the MAAS configuration**: Once that foundation is in place, we can customize the MAAS config. We'll point it to the Ubuntu images you want, configure DNS and proxy settings, and so forth.

- **Enabling SSH access**: We'll also enable SSH access so admin users can securely manage MAAS and the nodes.

- **LXD installation**: Finally, we'll install LXD containers and integrate them with MAAS. This lets you manage containers right next to physical boxes. We'll make sure LXD networking syncs up with MAAS DHCP too.

When we're done, you'll have a full MAAS deployment ready for provisioning resources, and hopefully a pretty good overview of what it takes to get MAAS running.

<a href="#heading--Activity-0-Preparing-the-Host-System"><h2 id="heading--Activity-0-Preparing-the-Host-System">Activity 0: Preparing the Host System</h2></a>

Before we begin, make sure you have an Ubuntu system installed. Since we're using snaps for this tutorial, the specific version of Ubuntu is less important, but we recommend Ubuntu 22.04 LTS or higher.  Ensure that your system is in a safe environment, and if UFW (Uncomplicated Firewall) is enabled, consider disabling it or implementing a workaround for LXD.

<a href="#heading--Activity-1-Install-MAAS"><h2 id="heading--Activity-1-Install-MAAS">Activity 1: Install MAAS</h2></a>

To kickstart your MAAS journey, we’ll begin with the installation process. Follow the steps below to get MAAS up and running on your system:

1. Install the MAAS snap:<br>  
`sudo snap install maas`<br>  
This command will install the MAAS snap package, which contains all the necessary components for MAAS.

2. Install PostgreSQL and update necessary packages:<br>  
`sudo apt update -y`
`sudo apt install -y postgresql`<br>  
These commands will update your system’s package information and install PostgreSQL, a required dependency for MAAS.

3. Create a secure PostgreSQL user and a secure password:<br>  
`sudo -u postgres psql -c \`
`"CREATE USER \"maascli\" WITH PASSWORD 'md5$PASSWORD_HASH'"`<br>  
This command will create a PostgreSQL user named "maascli" with a secure password. You can create a secure password with the following command:<br>  
`openssl passwd -6 -salt maascli $USER_PASSWORD`<br>  
By doing so, the password won't show up as plain text in the process listing and PostgreSQL log files.

4. Create a MAAS database:<br>  
`sudo -u postgres createdb -O "maascli" "maasclidb"`<br>  
This command will create a MAAS database named "maasclidb" and assign ownership to the "maascli" user.

5. Edit the pg_hba.conf file to enhance security and connectivity:<br>  
`sudo vi /etc/postgresql/12/main/pg_hba.conf`<br>  
Use a text editor, such as vi, to open the pg_hba.conf file. Inside the file, you should add the following line to the end of teh file; this will help secure the MAAS database:<br>  
`host    $MAAS_DBNAME    $MAAS_DBUSER    0/0     md5`

6. Initialize MAAS using the command line:<br>__
`sudo maas init region+rack --database-uri \`
`"postgres://maascli:md5$PASSWORD_HASH@localhost/maasclidb"`<br>__
This command will initialize MAAS and set up the region and rack controllers. It will also provide you with a URL that you’ll need for future steps.

7. Create your admin user for MAAS:<br>  
`sudo maas createadmin`<br>  
By running this command, you will create an admin user for MAAS, allowing you to manage and configure MAAS effectively.

Congratulations! You’ve taken the first step towards efficient infrastructure management. In the next section, we’ll guide you through the MAAS configuration process.

<a href="#heading--Activity-2-Configure-MAAS"><h2 id="heading--Activity-2-Configure-MAAS">Activity 2: Configure MAAS</h2></a>

Next up, you’ll want to configure MAAS for first-time use, following these steps:

1. Access MAAS at this address, where `$API_HOST` is the MAAS URL which was generated during [Activity 1](#heading--Activity-1-Install-MAAS):<br>  
`http://${API_HOST}:5240/MAAS`<br>  
Log in using the login information you created when initializing MAAS.

2. Set the DNS forwarder to a suitable value, e.g., `8.8.8.8`. This step ensures that MAAS can resolve domain names correctly by configuring the DNS forwarder.

3. Check the default image to see if it has synced yet. This ensures that you will have Ubuntu image that will correctly deploy in MAAS.

Good, now MAAS is able to perform its basic functions, with the exception of DHCP, which we will set up shortly.

<a href="#heading--Activity-3-Set-up-SSH-access"><h2 id="heading--Activity-3-Set-up-SSH-access">Activity 3: Set up SSH access</h2></a>

Once your machines deploy, you may want to log into them with SSH to monitor or configure them further. To set up SSH access for admin users, follow these steps:

1. Import your SSH public key from Launchpad, GitHub, or upload your existing public key, following the on-screen instructions. This step enables SSH authentication for admin users, providing secure access to the MAAS server.

2. Make sure to select "Import" to import the SSH key. By importing the SSH key, you authorize its use for SSH connections to MAAS.

Once you’ve done this, MAAS has been successfully set up. Now, let’s install and set up an LXD virtual machine host, so you can put MAAS through its paces.

<a href="#heading--Activity-4-Install-LXD"><h2 id="heading--Activity-4-Install-LXD">Activity 4: Install LXD</h2></a>

You can use any virtualization tool you like, but for this tutorial, we will use the recommended LXD product. To install and set up LXD for use with MAAS, follow these steps:

1. Check if LXD is already installed and up to date:<br>  
`sudo snap refresh lxd`<br>  
This command checks for updates to the LXD snap package and installs them if available.

2. If LXD isn’t installed at all (i.e., the above command fails), run the following command:<br>  
`sudo snap install lxd`<br>  
This command installs the most current LXD snap package.

3. Run the initialization command and follow the interactive prompts to configure LXD based on your requirements.  Note that you definitely want to configure the bridge (e.g., `lxdbr0`) when you come to that step:<br>  
`sudo lxd init`<br>  
This step initializes LXD and allows you to customize its configuration, such as network settings and storage pools. 

4. Make sure you turn off LXD-provided DHCP with the following commands:<br>  
`lxc network set lxdbr0 dns.mode=none`
`lxc network set lxdbr0 ipv4.dhcp=false`
`lxc network set lxdbr0 ipv6.dhcp=false`<br>  
These commands disable DHCP provided by LXD for the lxdbr0 bridge, giving you more control over network configuration.

5. Verify the changes by running the show command again:<br>  
`lxc network show lxdbr0`<br>  
This command confirms that the changes to the LXD network configuration were applied successfully.

Once these steps are completed, your LXD installation will be good to go – and any DHCP provided by LXD will be disabled. This is important because you'll need MAAS to provide DHCP in the next step.

<a href="#heading--Activity-5-Enable-DHCP-for-LXD"><h2 id="heading--Activity-5-Enable-DHCP-for-LXD">Activity 5: Enable DHCP for LXD</h2></a>

As a final configuration step, you need to enable DHCP to communicate with the LXD bridge you just created; follow these steps:

1. Open a terminal and type the following command:<br>  
`ip addr`<br>  
This command displays the network interfaces and their IP addresses.

2. Note the IP address of the bridge `lxdbr0` (or whatever you named your LXD bridge). You will need this IP address for the next steps.

3. In the MAAS UI, select *Networking > Subnets*. This navigates you to the Subnets page in the MAAS web interface.

4. In the table, find the Fabric which contains the IP address of the `lxdbr0` bridge, and select the associated VLAN.

5. In the configuration screen which appears, select *Configure DHCP*. This option allows you to configure DHCP settings for the selected VLAN.

6. In the dropdown *Select rack controller*, select a rack controller on which to configure DHCP. For this example, there should only be one, but you should choose the appropriate rack controller responsible for managing the VLAN.

7. In the dropdown *Select subnet*, select the desired subnet for the VLAN.

8. Select *Configure DHCP*. This action applies the DHCP configuration to the selected VLAN, enabling communication with the LXD bridge.

Congratulations! You now have MAAS in a fully operational state, ready to create and explore your first machines in the [next tutorial](/t/get-to-know-your-machines/7116).