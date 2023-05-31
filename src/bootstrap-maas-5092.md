<!-- "Bootstrap MAAS" -->
Welcome to MAAS, the powerful tool for managing physical servers and data centres. This tutorial will help you get MAAS up and running, so that you can create, commission, and deploy some virtual machines in later tutorials. Let's jump right in and start doing things.

<a href="#heading--Step-1-Install-MAAS"><h2 id="heading--Step-1-Install-MAAS">Step 1: Install MAAS</h2></a>

To kickstart your MAAS journey, we'll begin with a simple and easy installation process.

1. Install the MAAS snap:

```nohighlight
sudo snap install maas
```

2. Install PostgreSQL and update necessary packages:

```nohighlight
sudo apt update -y
sudo apt install -y postgresql
```

3. Create a PostgreSQL user and a secure password:

```nohighlight
sudo -u postgres psql -c "CREATE USER \"maascli\" WITH ENCRYPTED PASSWORD 'maascli'"
```

4. Create a MAAS database:

```nohighlight
sudo -u postgres createdb -O "maascli" "maasclidb"
```

5. Edit the pg_hba.conf file to enhance security and connectivity:

```nohighlight
sudo vi /etc/postgresql/12/main/pg_hba.conf
```

6. Initialise MAAS using the command line:

```nohighlight
sudo maas init region+rack --database-uri "postgres://maascli:maascli@localhost/maasclidb"
```

7. Note the URL that is returned by the action above; you'll need that shortly.

8. Create your admin user for MAAS:

```nohighlight
sudo maas createadmin
```

Congratulations! Your MAAS installation is complete. Next up? MAAS configuration.

<a href="#heading--Step-2-Configure-MAAS"><h2 id="heading--Step-2-Configure-MAAS">Step 2: Configure MAAS</h2></a>

To configure MAAS for first-time use:

1. Access MAAS at this address, where `$API_HOST` is the hostname or IP address of the region API server, which was set during installation:

```nohighlight
http://${API_HOST}:5240/MAAS
```

2. Log in using the login information you created when initialising MAAS.

3. Set the DNS forwarder to a suitable value, e.g., 8.8.8.8.

4. Select an Ubuntu image to import; you may be required to select at least one LTS version.

<a href="#heading--Step-3-Set-up-SSH-access"><h2 id="heading--Step-3-Set-up-SSH-access">Step 3: Set up SSH access</h2></a>

Set up your SSH keys for admin users like this:

1. Import your SSH public key from Launchpad, GitHub, or upload your existing public key.

2. Click "Import" to import the SSH key.

Congratulations! MAAS has been successfully set up. Now, let's install and set up a LXD virtual machine host.

<a href="#heading--Step-4-Install-LXD"><h2 id="heading--Step-4-Install-LXD">Step 4: Install LXD</h2></a>

Here's how to install LXD for use with MAAS:

1. If you're on a version of Ubuntu older than 20.04 or have the Debian version of LXD, initiate the uninstall process; otherwise, skip this step:

```nohighlight
sudo apt-get purge -y *lxd* *lxc*
```

2. Free up disk space by running the autoremove command:

```nohighlight
sudo apt-get autoremove -y
```

3. Check if LXD is already installed and up to date; if so, skip to major step 4, below:

```nohighlight
sudo snap refresh
```

4. If LXD needs to be updated, run the following command to install or update it:

```nohighlight
sudo snap install lxd
```

5. Run the initialisation command, follow the interactive prompts to configure LXD based on your requirements:

```nohighlight
sudo lxd init
```

6. Check the LXD network configuration:

```nohighlight
lxc network show lxdbr0
```

7. If you need to turn off LXD-provided DHCP, change the following settings:

```nohighlight
lxc network set lxdbr0 dns.mode=none
lxc network set lxdbr0 ipv4.dhcp=false
lxc network set lxdbr0 ipv6.dhcp=false
```

8. Verify the changes by running the show command again:

```nohighlight
lxc network show lxdbr0
```

Once these steps are completed, your LXD installation will be updated, and any DHCP provided by LXD will be disabled. You can now proceed to add the LXD host to MAAS and utilise LXD for building an example configuration.

<a href="#heading--Step-5-Enable-DHCP-for-LXD"><h2 id="heading--Step-5-Enable-DHCP-for-LXD">Step 5: Enable DHCP for LXD</h2></a>

To enable DHCP to communicate with the LXD bridge you just created:

1. Open a terminal and type the following command:

```nohighlight
ip addr
```

2. Note the IP address of the bridge lxdbr0 (or whatever you named your LXD bridge).

3. In the MAAS UI, select *Networking > Subnets*.

4. In the table, find the Fabric which contains the IP address of the lxdbr0 bridge, and select the associated VLAN.

5. Select *Configure DHCP*.

6. In the dropdown *Select rack controller*, select a rack controller.  For this example, there should only be one.

7. In the dropdown *Select subnet*, select a suitable subnet.

8. Select *Configure DHCP*.  

<a href="#heading--Step-6-Create-a-LXD-KVM-host"><h2 id="heading--Step-6-Create-a-LXD-KVM-host">Step 6: Create a LXD KVM host</h2></a>

To create VMs, you'll need to create a VM host, like this:

1. Open the MAAS web interface and select the "KVM > LXD" option.

2. Click on "Add KVM" and provide a descriptive Name for the KVM host.

3. Optionally, choose a specific Zone and Resource pool if needed.

4. Enter the LXD address as the gateway address of the bridge for that LXD instance. For example, if `lxdbr0` has the address `10.4.241.0`, the default gateway address would be `10.4.241.1`.

5. Select "Generate new certificate" and proceed by clicking "Next".

6. To establish trust with LXD, select "Add trust to LXD via command line".

7. Copy the provided bash command and certificate from the text box.

8. Open a terminal and paste the copied command, ensuring it runs successfully (i.e., returns nothing but another prompt).

9. Click on "Check authentication". You will switch screens, and if everything goes well, you'll see a "Connected" message with a green check-mark.

10. Choose to "Add new project" or "Select existing project". Note that selecting an existing project will commission any VMs already in that project.

11. Proceed by clicking "Next". You will be taken to a dashboard for the VM host.

Now you can start adding virtual machines to this new VM host as desired.  Check this tutorial to learn how to do so.