<!-- "Bootstrap MAAS" -->
Welcome to the "Bootstrap MAAS" tutorial.  By following this comprehensive guide, you will successfully set up and configure MAAS, a powerful tool for managing physical servers and data centres. During this tutorial, you will achieve the following:

- **Installation**: You will learn how to install MAAS on your system, ensuring a solid foundation for managing your infrastructure.

- **Database Setup**: You will create a secure PostgreSQL user and set up the MAAS database, enabling efficient management of your resources.

- **Enhancing Security and Connectivity**: You will make necessary changes to enhance security and connectivity, ensuring a robust and protected environment.

- **MAAS Configuration**: You will configure MAAS according to your specific needs, including setting up DNS forwarders, selecting Ubuntu images, and more.

- **SSH Access**: You will set up SSH access for admin users, allowing secure communication and administration of your infrastructure.

- **LXD Installation**: You will install LXD, a container hypervisor, and configure it to work seamlessly with MAAS, providing additional flexibility and resource management capabilities.

- **DHCP Enablement**: You will enable DHCP communication with the LXD bridge, ensuring seamless networking for your virtual machines.

By the end of this tutorial, you will have a fully operational MAAS setup.  Let's dive in and get started.

<a href="#heading--Activity-1-Install-MAAS"><h2 id="heading--Activity-1-Install-MAAS">Activity 1: Install MAAS</h2></a>

To kickstart your MAAS journey, we'll begin with a simple and easy installation process. Follow the steps below to get MAAS up and running on your system:

1. Install the MAAS snap:<br><br>  
`sudo snap install maas`<br><br>  
This command will install the MAAS snap package, which contains all the necessary components for MAAS.

2. Install PostgreSQL and update necessary packages:<br><br>  
`sudo apt update -y`<br>  
`sudo apt install -y postgresql`<br><br>  
These commands will update your system's package information and install PostgreSQL, a required dependency for MAAS.

Create a PostgreSQL user and a secure password:

```nohighlight
sudo -u postgres psql -c "CREATE USER \"maascli\" WITH ENCRYPTED PASSWORD 'maascli'"
```

This command will create a PostgreSQL user named "maascli" with the password "maascli". Feel free to choose a different password for increased security.

Create a MAAS database:

```nohighlight
sudo -u postgres createdb -O "maascli" "maasclidb"
```

This command will create a MAAS database named "maasclidb" and assign the ownership to the "maascli" user.

Edit the pg_hba.conf file to enhance security and connectivity:

```nohighlight
sudo vi /etc/postgresql/12/main/pg_hba.conf
```

Use a text editor, such as vi, to open the pg_hba.conf file. Inside the file, you can make necessary changes to enhance security and ensure proper connectivity for MAAS.

Initialise MAAS using the command line:

```nohighlight
sudo maas init region+rack --database-uri "postgres://maascli:maascli@localhost/maasclidb"
```

This command will initialise MAAS and set up the region and rack controllers. It will also provide you with a URL that you'll need for future steps.

Create your admin user for MAAS:

```nohighlight
sudo maas createadmin
```

By running this command, you will create an admin user for MAAS, allowing you to manage and configure MAAS effectively.

Congratulations! Your MAAS installation is complete, and you've taken the first step towards efficient infrastructure management. In the next section, we'll guide you through the MAAS configuration process.