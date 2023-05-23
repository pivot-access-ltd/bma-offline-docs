<!-- "How to change MAAS settings" -->

[tabs]
[tab version="v3.4 Snap,v3.4 Packages" view="UI"]
*Settings* is available near the bottom of the left navigation panel.

<a href="#heading--MAAS-name"><h2 id="heading--MAAS-name">MAAS name</h2></a>

You can assign a unique name to each MAAS instance, along with one or more Unicode emojis. To do so:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Configuration > General*.

3. Use the MAAS name field and Unicode emoji(s) to describe your MAAS instance. 

4. Save the changes.

This will help differentiate and identify your instance easily, for example:

```
US-west-2 🇺🇸 MAAS-prod
my-maas ❗ no-deploys
```

<a href="#heading--MAAS-theme-main-colour"><h2 id="heading--MAAS-theme-main-colour">MAAS theme main colour</h2></a>

In addition to a unique name and emoji (see above), you can differentiate MAAS instances by changing the theme color.  You can do so like this:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Configuration > General*.

3. Choose the main colour theme for your MAAS instance. Options include:

- Default
- Bark
- Sage
- Olive
- Viridian
- Prussian green
- Blue
- Purple
- Magenta
- Red

4. Save the changes.

This will determine the overall visual appearance of the interface.

<a href="#heading--Data-analytics"><h2 id="heading--Data-analytics">Data analytics</h2></a>

You can enable analytics to shape improvements to the user experience. The analytics used in MAAS include Google Analytics, Usabilla, and Sentry Error Tracking. To do so:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Configuration > General*.

3. Check the box entitled, "Enable analytics to shape improvements to user experience".

4. Save the changes.

This data is handled with privacy in mind.

<a href="#heading--Notifications"><h2 id="heading--Notifications">Notifications</h2></a>

You can also enable notifications for new releases, like this:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Configuration > General*.

3. Check the box entitled, "Enable new release notifications".

4. Save the changes.

This feature applies to all MAAS users, allowing you to receive dismissable notifications regarding the availability of new releases.

<a href="#heading--Default-Ubuntu-release-used-for-commissioning"><h2 id="heading--Default-Ubuntu-release-used-for-commissioning">Default Ubuntu release used for commissioning</h2></a>

The default Ubuntu release used for commissioning determines the version of Ubuntu that is installed on newly commissioned machines. By default, the Ubuntu 20.04 LTS "Focal Fossa" release is used. This is the recommended and supported release for commissioning.

If you have synced other release images using *Configuration > Images*, they will appear in the dropdown entitled, "Default Ubuntu release used for commissioning".  You can access this dropdown and change the default commissioning release like this:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Configuration > Commissioning*.

3. Select your desired default commissioning release from the "Default Ubuntu release used for commissioning" dropdown.

4. Save the changes.

[note]
Unless you have synced images other than the default Ubuntu 20.04, no other choices will be available in this dropdown.
[/note]

<a href="#heading--Default-minimum-kernel-version"><h2 id="heading--Default-minimum-kernel-version">Default minimum kernel version</h2></a>

The default minimum kernel version is the lowest kernel version allowed on all new and commissioned nodes.  To set this kernel:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Configuration > Commissioning*.

3. Select your desired kernel from the "Default minimum kernel version" dropdown.

4. Save the changes.

Currently, there is no minimum kernel version set. This means that any kernel version can be used on the machines.

[note]
Please note that while the absence of a minimum kernel version provides flexibility, it's important to ensure compatibility with your specific system requirements.
[/note]

<a href="#heading--Default-operating-system-used-for-deployment"><h2 id="heading--Default-operating-system-used-for-deployment">Default operating system used for deployment</h2></a>

The default operating system used for deployment determines the OS that will be deployed on machines in the absence of any configuration changes.

Only the OS images you have synced using *Configuration > Images* will appear in the dropdown entitled, "Default operating system used for deployment".  You can access this dropdown and change the default OS like this:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Configuration > Deploy*.

3. Select your desired default OS from the "Default OS release used for deployment" dropdown.

4. Save the changes.

[note]
Unless you have synced custom images, only "Ubuntu" will be available in this dropdown.
[/note]

<a href="#heading--Default-OS-release-used-for-deployment"><h2 id="heading--Default-OS-release-used-for-deployment">Default OS release used for deployment</h2></a>

The default OS release used for deployment specifies the release of your chosen OS that is automatically installed on machines.

Only OS releases you have synced using *Configuration > Images* will appear in the dropdown entitled, "Default operating system used for deployment".  In order to access a release from a given OS, you must first select that OS as [described above](#heading--Default-operating-system-used-for-deployment).

Once you have done so, you can select the default deployment OS release as follows:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Configuration > Deploy*.

3. Select your desired default OS from the "Default operating system used for deployment" dropdown.

4. Save the changes.

<a href="#heading--Default-hardware-sync-interval-minutes"><h2 id="heading--Default-hardware-sync-interval-minutes">Default hardware sync interval (minutes)</h2></a>

The default hardware sync interval refers to the frequency at which hardware information is synchronized between the MAAS server and the deployed machines.  To change it:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Configuration > Deploy*.

3. Set your desired sync interval in the field entitled, "Default hardware sync interval (minutes)".

4. Save the changes.

By default, the hardware sync interval is set to 15 minutes. This means that every 15 minutes, the MAAS server will update and synchronize the hardware information of the deployed machines.

You can adjust this interval according to your specific needs and requirements, but it's recommended to maintain a reasonable interval for efficient synchronization.

<a href="#heading--Configuration-Kernel-parameters"><h2 id="heading--Configuration-Kernel-parameters">Configuration > Kernel parameters</h2></a>

Global kernel parameters are settings that are consistently passed to the kernel during the boot process for all machines in your MAAS instance. These parameters can be used to configure specific behaviors or enable certain features in the kernel.

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Configuration > Kernel parameters*.

3. Set your kernel parameters in the field entitled, "Global boot parameters always passed to the kernel".

4. Save the changes.

Ensure that the boot parameters you specify are compatible with the kernel and any specific requirements of your system.

[note]
Please note that changes to the global boot parameters will affect all machines in your MAAS instance during the boot process. Make sure to review and test the parameters thoroughly before applying them to your production environment.
[/note]

<a href="#heading--Security-Security-protocols"><h2 id="heading--Security-Security-protocols">Security > Security protocols</h2></a>

By default, TLS (Transport Layer Security) is disabled in MAAS. However, if you want to enable TLS to ensure secure communication, you can follow these instructions:

1. Open the command-line interface (CLI) on the machine running MAAS.

2. Run the following command as a superuser (sudo):

```
sudo maas config-tls enable $key $cert --port YYYY
```

This command will enable TLS for the MAAS instance.  More information about MAAS native TLS can be found [here](/t/how-to-enable-maas-native-tls/5116)

<a href="#heading--Security-Secret-storage"><h2 id="heading--Security-Secret-storage">Security > Secret storage</h2></a>

To integrate MAAS with Vault, use the following procedure.

<a href="#heading--Obtain-the-necessary-information-from-Vault"><h3 id="heading--Obtain-the-necessary-information-from-Vault">Obtain the necessary information from Vault</h3></a>

Get the $wrapped_token and $role_id from Vault. Refer to the documentation provided by Hashicorp Vault for more details on retrieving these values.

<a href="#heading--Configure-Vault-on-each-region-controller"><h3 id="heading--Configure-Vault-on-each-region-controller">Configure Vault on each region controller</h3></a>

1. SSH into each region controller.

2. Run the following command, replacing the variables with the appropriate values:

```
sudo maas config-vault configure $url $approle_id $wrapped_token $secrets_path --secrets-mount $secret_mount
```

This command configures Vault on the region controller using the provided parameters.

<a href="#heading--Migrate-secrets-on-one-of-the-region-controllers"><h3 id="heading--Migrate-secrets-on-one-of-the-region-controllers">Migrate secrets on one of the region controllers</h3></a>

After configuring Vault on all region controllers, select one of the region controllers. Run the following command on that controller to migrate the secrets:

```
sudo maas config-vault migrate
```

For more information on Vault integration with MAAS, refer to the [additional documentation](/t/maas-security/6719) provided.

<a href="#heading--Security-Session-timeout"><h2 id="heading--Security-Session-timeout">Security > Session timeout</h2></a>

MAAS allows you to configure the session timeout, which determines the length of time a user session can remain active before requiring reauthentication. Follow these instructions to manage the session timeout:

1. Determine the desired session timeout duration:

 - The maximum session length is 14 days or 2 weeks.
 - You can specify the duration in weeks, days, hours, and/or minutes.
 - Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Security > Session timeout*.

3. Enter the desired duration for the session timeout. Use the appropriate format options (e.g., "2 weeks," "14 days," "336 hours," or "20,160 minutes").

4. Be sure to save the changes.

[note]
Please note that after changing the session expiration time, MAAS will automatically log out all users. The new session timeout will apply for subsequent logins.
[/note]

<a href="#heading--Security-IPMI-settings"><h2 id="heading--Security-IPMI-settings">Security > IPMI settings</h2></a>

MAAS provides options to configure the IPMI (Intelligent Platform Management Interface) settings for your systems. 

<a href="#heading--MAAS-generated-IPMI-username"><h3 id="heading--MAAS-generated-IPMI-username">MAAS-generated IPMI username</h3></a>

The MAAS-generated IPMI username is set to "maas" by default. This username is used for IPMI authentication.

<a href="#heading--K-g-BMC-Key"><h3 id="heading--K-g-BMC-Key">K_g BMC key</h3></a>

The K_g BMC key is used to encrypt all communication between IPMI clients and the BMC (Baseboard Management Controller). If you wish to enable encryption, specify the key in this field. Leave the field blank for no encryption.

<a href="#heading--MAAS-generated-IPMI-user-privilege-level"><h3 id="heading--MAAS-generated-IPMI-user-privilege-level">MAAS-generated IPMI user privilege level</h3></a>

MAAS provides three user privilege levels for the MAAS-generated IPMI user:

- Admin: This privilege level grants full access to all IPMI features and controls.
- Operator: This privilege level allows access to most IPMI features but restricts certain critical functions.
- User: This privilege level provides limited access to IPMI features.

Choose the appropriate privilege level for the MAAS-generated IPMI user based on your requirements.

<a href="#heading--Configuring-IPMI-security"><h3 id="heading--Configuring-IPMI-security">Configuring IPMI security</h3></a>

To configure these settings:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Security > IPMI settings*.

3. Locate the fields for the MAAS-generated IPMI username, K_g BMC key, and IPMI user privilege level.

4. Enter the desired values for each setting, based on the discussion above.

5. Save the changes.

[note]
Please note that these settings are specific to the MAAS-generated IPMI user and apply to the IPMI communication for your systems.
[/note]

<a href="#heading--User-management"><h2 id="heading--User-management">User management</h2></a>

MAAS provides basic functionality to manage users, as described in this section.

<a href="#heading--Search"><h3 id="heading--Search">Search</h3></a>

The search feature allows you to find specific users in the MAAS system based on different criteria. You can search by username, real name, email, machines, type, last seen, role, or MAAS keys.

The search results will display a table with relevant information for each user, including their username, real name, email, number of machines, user type, last seen date and time, role, and MAAS keys. Additionally, actions such as editing or deleting users can be performed using the respective buttons under the "Actions" column.

<a href="#heading--Add-User"><h3 id="heading--Add-User">Add User</h3></a>

To add a new user to the MAAS system:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Users*.

3. Click on the "Add user" button. This will open a new user creation form.

4. Fill in the required information for the new user:

- Username: Enter the desired username for the new user.
- Full name: Provide the real name of the user.
- Email address: Enter the email address associated with the user.
- Password: Enter a password for the new user and confirm it.

5. Save your changes.

<a href="#heading--Editing-a-user-entry"><h3 id="heading--Editing-a-user-entry">Editing a user entry</h3></a>

To edit an existing user:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Users*.

3. If you have a large number of users, use the [Search function described above](#heading--Search) to filter the list.

4. Click on the pencil icon at the end of a given user's row. This will open an editing creation form.

5. Fill in the required information for the new user:

- Username: Update the username for this user.
- Full name: Provide or update the real name of the user.
- Email address: Update the email address associated with the user.
- Change password: Expand the box and update the user password; you will need to provide the current password for this change to be successful.

6. Save your work.

<a href="#heading--Use-proprietary-drivers"><h2 id="heading--Use-proprietary-drivers">Use proprietary drivers</h2></a>

To enable the installation of proprietary drivers, follow these instructions:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Images > Ubuntu*.

3. Locate the switch or toggle button labeled "Enable the Installation of Proprietary Drivers" under *Images > Ubuntu* on the settings page.

4. Move the switch to the "On" or "Enabled" position to allow the installation of proprietary drivers.

5. Save your changes.

Enabling this option will allow the system to install proprietary drivers, such as HPVSA (High-Performance Virtual Storage Architecture), when necessary or desired.

[note]
Please note that the availability and functionality of proprietary drivers may vary depending on your specific system and hardware configuration.  It may also be necessary for you to load the needed drivers onto your system.
[/note]

<a href="#heading--Windows-KMS-host"><h2 id="heading--Windows-KMS-host">Windows KMS host</h2></a>

The Windows KMS (Key Management Service) activation host is used for activating Windows deployments through KMS activation. Follow these instructions to configure the KMS activation host:

1. Obtain the FQDN (Fully Qualified Domain Name) or IP address of the host that provides the KMS Windows activation service. You may need to consult with your network or system administrator to obtain this information.

2. Navigate to *Settings > Images > Windows*.

3. Under *Windows KMS activation host*, enter the FQDN or IP address of the KMS activation host in the provided field.

4. Save the changes to apply the configuration.

[note]
Please note that this configuration is only necessary for Windows deployments that use KMS activation. If you are not using KMS activation or have already configured a different activation method, you can leave this field blank.
[/note]

<a href="#heading--VMware-vCenter-server-configuration"><h2 id="heading--VMware-vCenter-server-configuration">VMware vCenter server configuration</h2></a>

To configure the VMware vCenter server settings in MAAS, follow these steps:

1. Obtain the necessary information related to your VMware vCenter server:

- VMware vCenter server FQDN or IP address: This is the Fully Qualified Domain Name (FQDN) or IP address of your VMware vCenter server, which will be passed to the deployed VMware ESXi host.
- VMware vCenter username: This is the username for your VMware vCenter server, which will be passed to the deployed VMware ESXi host.
- VMware vCenter password: This is the password for your VMware vCenter server, which will be passed to the deployed VMware ESXi host.
- VMware vCenter datacenter: This is the datacenter in your VMware vCenter environment, which will be passed to the deployed VMware ESXi host.

2. Access the MAAS web interface and log in with your credentials.

3. Navigate to *Settings > Images > VMware*.

4. Locate the configuration options for the above parameters, and enter the respective information into the provided fields.

5. Save the changes to apply the configuration.

Please ensure that the provided information is accurate and corresponds to your VMware vCenter server environment. This configuration will be passed to the deployed VMware ESXi hosts for proper integration.

<a href="#heading--License-keys"><h2 id="heading--License-keys">License keys</h2></a>

*Settings > License keys* gives you the ability to manage your product licenses in a tabular format:

- *Add license key button*: This button can be used to add a new license key.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Actions column*: These action buttons allow you to delete or edit the information in that row.  Note that the delete and/or edit buttons may be greyed out (unavailable) based on your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular license key in a longer list.

<a href="#heading--Default-storage-layout"><h2 id="heading--Default-storage-layout">Default storage layout</h2></a>

The default storage layout determines the layout that is applied to a node when it is commissioned. Follow these instructions to configure the default storage layout:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Storage*.

3. Locate the option labeled "Default Storage Layout" or similar.

4. Choose the desired storage layout from the available options. For example, you may select the "Flat layout" as the default storage layout.

5. Save the changes to apply the configuration.

Please note that the selected default storage layout will be applied to nodes during the commissioning process.

<a href="#heading--Erasing-disks-prior-to-releasing"><h2 id="heading--Erasing-disks-prior-to-releasing">Erasing disks prior to releasing</h2></a>

The option "Erase nodes' disks prior to releasing" forces users to always erase disks when releasing nodes. Follow these instructions to configure this option:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Storage*.

3. Locate the option labeled "Erase nodes' disks prior to releasing" or similar.

4. Enable or select this option to ensure that disks are always erased before releasing nodes.

5. Save the changes to apply the configuration.

Please note that enabling this option ensures that disks are properly wiped before releasing nodes.

<a href="#heading--Disk-erasure-options"><h2 id="heading--Disk-erasure-options">Disk erasure options </h2></a>

MAAS provides different disk erasure options depending on the capabilities of the devices. Follow these instructions to configure the disk erasure options:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Storage*.

3. Locate the options labeled "Use secure erase by default when erasing disks" and "Use quick erase by default when erasing disks."

4. Choose the desired option based on your requirements:

- "Use secure erase by default when erasing disks": This option will be used on devices that support secure erase. Other devices will fall back to full wipe or quick erase depending on the selected options.
- "Use quick erase by default when erasing disks": This option performs a non-secure erase by wiping only the beginning and end of each disk.
Save the changes to apply the configuration.

Please note that the disk erasure options define the default behavior when erasing disks in the MAAS environment.

<a href="#heading--HTTP-proxy-configuration"><h2 id="heading--HTTP-proxy-configuration">HTTP proxy configuration</h2></a>

MAAS allows you to configure an HTTP proxy for image downloads and for provisioned machines to access APT and YUM packages. Follow these instructions to configure the HTTP proxy:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Network > Proxy*.

3. Choose the appropriate option based on your requirements:

- Don't use a proxy: Select this option if you do not want to use an HTTP proxy for MAAS image downloads or for APT/YUM package access by provisioned machines.

- MAAS built-in: Select this option if you want to use the built-in HTTP proxy provided by MAAS. This is the default option and requires no additional configuration.

- External: Enter the URL of the external proxy that MAAS will use to download images, and the machines will use to download APT packages for provisioned machines.  Be sure to provide the complete URL of the external proxy server, including the protocol (e.g., http:// or https://), the hostname or IP address, and the port number.

- Peer: Enter the URL of an external proxy that will serve as an upstream cache peer for the MAAS built-in proxy. Machines provisioned by MAAS will be configured to use the MAAS built-in proxy to download APT packages, and this external proxy will be used as a peer for caching.  By configuring an upstream cache peer, MAAS can leverage caching functionality to improve APT package download performance for provisioned machines.  Be sure to provide the complete URL of the external proxy server, including the protocol (e.g., http:// or https://), the hostname or IP address, and the port number.

4. Save the changes to apply the configuration.

[note]
Please note that configuring an HTTP proxy is optional and depends on your network setup and requirements.
[/note]

<a href="#heading--Upstream-DNS-configuration"><h2 id="heading--Upstream-DNS-configuration">Upstream DNS configuration</h2></a>

MAAS allows you to configure the upstream DNS settings for resolving domains not managed by MAAS. Follow these instructions to configure the upstream DNS:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Network > DNS*.

3. Locate the option labeled "Upstream DNS" or similar.

4. Enter the IP addresses of the upstream DNS servers. Separate multiple IP addresses with a space. For example, you can enter 8.8.8.8 to use Google's public DNS server.

5. Save the changes to apply the configuration.

[note]
Please note that the upstream DNS configuration is only used when MAAS is running its own DNS server. The provided IP addresses will be used as the value of 'forwarders' in the DNS server configuration.
[/note]

<a href="#heading--Enable-DNSSEC-validation-of-upstream-zones"><h2 id="heading--Enable-DNSSEC-validation-of-upstream-zones">Enable DNSSEC validation of upstream zones</h2></a>

MAAS provides the option to enable DNSSEC (Domain Name System Security Extensions) validation for upstream zones. Follow these instructions to configure DNSSEC validation:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Network > DNS*.

3. Locate the option labeled "Enable DNSSEC validation of upstream zones" or similar.

4. Choose the desired option based on your requirements:

- Automatic (use default root key): Select this option to enable DNSSEC validation using the default root key. This is the recommended option as it simplifies the configuration and maintenance of DNSSEC.

- Yes (manually configured root key): Select this option if you have a specific root key that you want to use for DNSSEC validation. This allows you to manually configure and manage the root key used for validation.

- No (Disable DNSSEC; useful when upstream DNS is misconfigured): Select this option to disable DNSSEC validation. This option is useful when the upstream DNS is misconfigured or does not support DNSSEC properly.Automatic (use default root key): Select this option to enable DNSSEC validation using the default root key.

4. Save the changes to apply the configuration.

[note]
Please note that DNSSEC validation is only used when MAAS is running its own DNS server. The selected option will be used as the value of 'dnssec_validation' in the DNS server configuration.
[/note]

<a href="#heading--List-of-external-networks-allowed-to-use-MAAS-for-DNS-resolution"><h2 id="heading--List-of-external-networks-allowed-to-use-MAAS-for-DNS-resolution">List of external networks allowed to use MAAS for DNS resolution</h2></a>

MAAS maintains a list of networks that are allowed to use MAAS for DNS resolution. You can add extra networks to this trusted ACL list, specifically networks that were not previously known. Follow these instructions to add extra networks:

1. Access the MAAS web interface and log in with your credentials.

2. Navigate to *Settings > Network > DNS*.

3. Locate the option labeled "List of external networks (not previously known) that will be allowed to use MAAS for DNS resolution" or similar.

4. Enter the IP addresses or ACL (Access Control List) names of the extra networks that should be allowed to use MAAS for DNS resolution. Separate multiple entries with a space.

5. Save the changes to apply the configuration.

[note]
Please note that this option allows you to add networks that were not previously known to the trusted ACL list maintained by MAAS.
[/note]

<a href="#heading--Configuring-NTP-servers"><h2 id="heading--Configuring-NTP-servers">Configuring NTP servers</h2></a>

To configure NTP servers in MAAS settings:

1. Access the MAAS web interface by opening a web browser and entering the URL or IP address of your MAAS server. Log in with appropriate credentials.

2. In the MAAS web interface, navigate to the "Settings" section. This is typically located in the left navigation bar.

3. Within the "Settings" popout, locate and click on the "NTP" tab or option. This will take you to the NTP server configuration page.

On the NTP configuration page, you will see a text field or an area where you can enter the addresses of the desired NTP servers.

Enter the addresses of the NTP servers you want to use as time references for MAAS itself, the machines deployed by MAAS, and devices utilizing MAAS's DHCP services. Separate multiple NTP servers by commas and/or spaces.

If you want to ensure that all region controller hosts, rack controller hosts, and subsequently deployed machines use only the external NTP servers specified, look for a checkbox or toggle option labeled "Use external NTP servers only" or a similar phrase. Enable this option to enforce the use of external NTP servers exclusively.

Once you have entered the NTP server addresses and configured the desired option, click on the "Save" or "Apply" button to save the changes.

MAAS will apply the new NTP server configuration, and all associated hosts and subsequently deployed machines will use the specified external NTP servers for time synchronization.

It is recommended to verify that the chosen NTP servers are reliable and accessible from the MAAS infrastructure and the deployed machines to ensure accurate time synchronization.

[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages" view="UI"]
A *Settings* tab is available at the top of the MAAS interface.

<a href="#heading--General-items"><h2 id="heading--General-items">General</h2></a>

The following options are found in *Settings* > *Configuration* > *General*.

Managing MAAS site identity is useful when you are running more than one MAAS instance - say,  *Test* and *Production* environments.  This section also provides data collection and version notification options. 

- *MAAS name*: The "* MAAS name" is a text box that sets the text which appears at the bottom of every MAAS screen, in front of the version descriptor.

- *Google Analytics*: MAAS uses Google Analytics, Usabilla and Sentry Error Tracking to improve user experience.  You can opt in or out of this service by setting or clearing this checkbox.

- *Release notification*: If you select this checkbox, MAAS will notify all users when new releases are available.

<a href="#heading--Security"><h2 id="heading--Security">Security</h2></a>

Choosing *Settings* > *Configuration* > *Security* provides instructions for enabling TLS with a certificate and a private key.  This is a CLI-operation; use the listed command at the command line, after logging into your MAAS instance.

<a href="#heading--Commissioning"><h2 id="heading--Commissioning">Commissioning</h2></a>

The parameters under *Settings* > *Configuration* > *Commissioning* allow you to change the way machines are commissioned:

- *Default commissioning release*: You can choose the default Ubuntu release that will be used for commissioning from a dropdown menu.

- *Default minimum kernel version*: The default minimum kernel version used on all new and commissioned nodes.  You can also choose this default from a dropdown menu.

- *IPMI username*: You can set the default IPMI username, which will control IPMI access to machines.

- *K_g BMC key*: Specify this key to encrypt all communication between IPMI clients and the BMC. Leave this blank for no encryption. 

- *IPMI privilege level*: You can choose the privilege level for IPMI access from a set of radio buttons (admin, operator, user).

<a href="#heading--Deployment"><h2 id="heading--Deployment">Deployment</h2></a>

*Settings* > *Configuration* > *Deployment* lets you configure machine deployment:

- *Default deployment OS*: You can choose the default operating system used for deployment from a dropdown list.

- *Default deployment OS release*: You can also choose the default OS release used for deployment, also from a dropdown.

- *Default hardware sync interval*: You can set the default hardware sync interval, in minutes.

<a href="#heading--Kernel-parameters"><h2 id="heading--Kernel-parameters">Kernel parameters</h2></a>

Under *Configuration* > *General* > *Kernel parameters*, you can set global boot that are always passed to the machine kernel.

<a href="#heading--Users"><h2 id="heading--Users">Users</h2></a>

*Settings* > *Users* MAAS gives you the ability to manage your users in a tabular format:

- *Add user button*: This button can be used to add a new user.

- *Sortable columns*: some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Actions column*: Each table row also has an "Actions" column, which allows you to delete or edit the information in that row.  Note that the delete and/or edit buttons may be greyed out (unavailable) based on your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen.  A search bar is also provided to help you locate a particular user in a longer list.

<a href="#heading--Images"><h2 id="heading--Images">Images</h2></a>

*Settings* > *Images* allows you to specify parameters that control different types of MAAS images.

<a href="#heading--Ubuntu-images"><h3 id="heading--Ubuntu-images">Ubuntu images</h3></a>

Under *Settings* > *Images* > *Ubuntu*, you can enable the installation of proprietary drives by selecting the appropriate checkbox.

<a href="#heading--Windows-images"><h3 id="heading--Windows-images">Windows images</h3></a>

*Settings* > *Images* > *Windows* allows you to specify the Windows KMS activation host.  This is the FQDN or IP address of the host that provides the KMS Windows activation service, which is needed for Windows deployments that use KMS activation.

<a href="#heading--VMWare-images"><h3 id="heading--VMWare-images">VMWare images</h3></a>

If you are using VMWare images, *Settings* > *Images* > *VMware* offers several parameters that you can adjust:

- *VMware vCenter server FQDN or IP address*: the VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.

- *VMware vCenter username*: the VMware vCenter server username which is passed to a deployed VMware ESXi host.

- *VMware vCenter password*: the VMware vCenter server password which is passed to a deployed VMware ESXi host.

- *VMware vCenter datacenter*: the VMware vCenter datacenter which is passed to a deployed VMware ESXi host.

<a href="#heading--License-keys"><h2 id="heading--License-keys">License keys</h2></a>

*Settings* > *License keys* gives you the ability to manage your product licenses in a tabular format:

- *Add license key button*: This button can be used to add a new license key.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Actions column*: These action buttons allow you to delete or edit the information in that row.  Note that the delete and/or edit buttons may be greyed out (unavailable) based on your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular license key in a longer list.

<a href="#heading--Storage"><h2 id="heading--Storage">Storage</h2></a>

Under *Settings* > *Storage*, you can set some parameters related to machine disks:

- *Default storage layout*: The default storage layout that is applied to a machine when it is commissioned.

- *Erase before releasing*: Checking this box forces users to always erase disks when releasing machines.

- *Use secure erase*: Check this box to use secure erase by default when erasing disks. This will only be used on devices that support secure erase. Other devices will fall back to full wipe or quick erase depending on the selected options.

- *Use quick erase*: Check this box to use quick erase by default when erasing disks.  This box is selected separately to provide a fallback for devices that do not support secure erase, should you have selected secure erase as the default method.  Note that this is not a secure erase; it wipes only the beginning and end of each disk.

<a href="#heading--Network"><h2 id="heading--Network">Network</h2></a>

*Settings* > *Network* allows you to set several network defaults for MAAS machines.

<a href="#heading--HTTP-proxy"><h3 id="heading--HTTP-proxy">HTTP proxy</h3></a>

By choosing *Settings* > *Network* > *Proxy*, you can define the HTTP proxy used by MAAS to download images, and used by provisioned machines for APT and YUM packages. Your choices are (1) no proxy, (2) MAAS built-in proxy, (3) external proxy, or (4) peer proxy.  If you choose external or peer proxy, you will be presented with a text box to specify the external proxy URL that the MAAS built-in proxy will use as an upstream cache peer.  Note that machines will be configured to use MAAS' built-in proxy to download APT packages when external or peer proxies are specified.

<a href="#heading--Upstream-DNS"><h3 id="heading--Upstream-DNS">Upstream DNS</h3></a>

*Settings* > *Network* > *DNS* lets you set DNS parameters for your MAAS.  Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses).  This only applies when MAAS is running its own DNS server, since this value is used to define forwarding in the DNS server config.  You can set the following parameters:

- *Enable DNSSEC validation*: If you wish to enable DNSSEC validation of upstream zones, you can choose the method from this dropdown list.  This is only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.

- *List of external networks*: You can also provide a list of external networks to be used for MAAS DNS resolution. MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows you to add extra, previously-unknown networks to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.

<a href="#heading--NTP-service"><h3 id="heading--NTP-service">NTP service</h3></a>

Access the NTP service is controlled using *Settings* > *Network* > *NTP*. You can enter the address of NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS DHCP services.  

You can also instruct MAAS to *Use external NTP only*, so that all daemons and machines refer directly to the external NTP server (and not to each other). If this is not set, only region controller hosts will be configured to use those external NTP servers; rack controller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.

<a href="#heading--Syslog-configuration"><h3 id="heading--Syslog-configuration">Syslog configuration</h3></a>

You can use *Settings* > *Network* > *Syslog* to specify a remote syslog server to which machine logs should be forwarded.  MAAS will use this remote syslog server for all log messages when enlisting, commissioning, testing, and deploying machines. Conversely, clearing this value will restore the default behaviour of forwarding syslog entries to MAAS.

<a href="#heading--Network-discovery"><h3 id="heading--Network-discovery">Network discovery</h3></a>

*Settings* > *Network* > *Network discovery*, when enabled, will cause MAAS to use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.  You can set the *Active subnet mapping interval* by choosing a desired interval from a dropdown.  When network discovery is enabled, each rack will scan subnets enabled for active mapping, which helps to ensure that discovery information is accurate and complete.

<a href="#heading--Scripts"><h2 id="heading--Scripts">Scripts</h2></a>

Under the section *Settings* > *Scripts*, MAAS provides a great deal of flexibility when dealing with commissioning and testing scripts.

<a href="#heading--Commissioning-scripts"><h3 id="heading--Commissioning-scripts">Commissioning scripts</h3></a>

*Settings* > *Scripts* > *Commissioning scripts* gives you the ability to manage machine commissioning scripts in a tabular format:

- *Upload script button*: This button can be used to upload a new commissioning script.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Expandable script contents*: Also note that individual script names are clickable, allowing you to expand that row to see the contents of the script.

- *Actions column*: Each table row has an "Actions" column, which allows you to delete the script in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular commissioning script in a longer list.

<a href="#heading--Testing-scripts"><h3 id="heading--Testing-scripts">Testing scripts</h3></a>

Similar to *Commissioning scripts*, the choices *Settings* > *Scripts* > *Testing scripts* give you the ability to manage your machines testing scripts in a tabular format:

- *Upload script button*: This button can be used to upload a new test script.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Expandable script contents*: Also note that individual script names are clickable, allowing you to expand that row to see the contents of the script.

- *Actions column*: Each table row has an "Actions" column, which allows you to delete the script in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular test script in a longer list.

<a href="#heading--DHCP-snippets"><h2 id="heading--DHCP-snippets">DHCP snippets</h2></a>

*Settings* > *DHCP snippets* lets you manage your DHCP snippets in a table:

- *Add snippet button*: This button can be used to add a new DHCP snippet.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Expandable snippets*: Also note that individual snippets are clickable, allowing you to expand that row to see the contents of that snippet.

- *Actions column*: Each table row has an "Actions" column, which allows you to edit delete the snippet in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular snippet in a longer list.

<a href="#heading--Package-repos"><h2 id="heading--Package-repos">Package repos</h2></a>

You can manage your MAAS repositories with the *Settings* > *Package repos* option.  Referenced repos are listed in a table:

- *Add PPA button*: This button can be used to add a new PPA to the search path.

- *Add repository button*: This button can be used to add a new repository to the search path.

- *Sortable columns*: Note that some of the column headings are clickable, allowing you to sort those columns.  These are "three click" sorts: ascending, descending, and none.

- *Actions column*: Each table row also has an "Actions" column, which allows you to edit or delete the repository information in that row, depending upon your role.

Note that if the table becomes longer than one screen will accommodate, paging buttons will appear at the bottom of the screen. A search bar is also provided to help you locate a particular test script in a longer list.
[/tab]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages" view="CLI"]

<a href="#heading--changing-settings-with-the-cli"><h2 id="heading--changing-settings-with-the-cli">Changing MAAS settings via the MAAS CLI</h2></a>

Assuming you have successfully logged into the MAAS CLI, you can access configuration values using the `maas $PROFILE maas set-config` command.  This command is used to set MAAS configuration values.

This command accepts keyword arguments.  You must pass each argument as a key-value pair, with an equals sign between the key and the value, like this:

```nohighlight
maas $PROFILE maas set-config key1=value1 key2=value key3=value3 ...
```

These keyword arguments must come after any positional arguments required by a specific command.  The following configuration keywords are currently available:

- *active_discovery_interval*: Active subnet mapping interval. When enabled, each rack will scan subnets enabled for active mapping. This helps ensure discovery information is accurate and complete.
- *boot_images_auto_import*: Automatically import/refresh the boot images every 60 minutes.
- *boot_images_no_proxy*: Set no_proxy with the image repository address when MAAS is behind (or set with) a proxy. By default, when MAAS is behind (and set with) a proxy, it is used to download images from the image repository. In some situations (e.g. when using a local image repository) it doesn't make sense for MAAS to use the proxy to download images because it can access them directly. Setting this option allows MAAS to access the (local) image repository directly by setting the no_proxy variable for the MAAS env with the address of the image repository.
- *commissioning_distro_series*: Default Ubuntu release used for commissioning.
- *completed_intro*: Marks if the initial intro has been completed.
- *curtin_verbose*: Run the fast-path installer with higher verbosity. This provides more detail in the installation logs.
- *default_distro_series*: Default OS release used for deployment.
- *default_dns_ttl*: Default Time-To-Live for the DNS.         If no TTL value is specified at a more specific point this is how long DNS responses are valid, in seconds.
- *default_min_hwe_kernel*: Default Minimum Kernel Version.         The default minimum kernel version used on all new and commissioned nodes.
- *default_osystem*: Default operating system used for deployment.
- *default_storage_layout*: Default storage layout.         Storage layout that is applied to a node when it is commissioned.        Available choices are*: 'bcache' (Bcache layout), 'blank' (No storage (blank) layout), 'custom' (Custom layout (from commissioning storage config)), 'flat' (Flat layout), 'lvm' (LVM layout), 'vmfs6' (VMFS6 layout), 'vmfs7' (VMFS7 layout).
- *disk_erase_with_quick_erase*: Use quick erase by default when erasing disks..         This is not a secure erase; it wipes only the beginning and end of each disk.
- *disk_erase_with_secure_erase*: Use secure erase by default when erasing disks.         Will only be used on devices that support secure erase.  Other devices will fall back to full wipe or quick erase depending on the selected options.
- *dns_trusted_acl*: List of external networks (not previously known), that will be allowed to use MAAS for DNS resolution..         MAAS keeps a list of networks that are allowed to use MAAS for DNS resolution. This option allows to add extra networks (not previously known) to the trusted ACL where this list of networks is kept. It also supports specifying IPs or ACL names.
- *dnssec_validation*: Enable DNSSEC validation of upstream zones.         Only used when MAAS is running its own DNS server. This value is used as the value of 'dnssec_validation' in the DNS server config.
- *enable_analytics*: Enable Google Analytics in MAAS UI to shape improvements in user experience.
- *enable_disk_erasing_on_release*: Erase node disks prior to releasing.         Forces users to always erase disks when releasing.
- *enable_http_proxy*: Enable the use of an APT or YUM and HTTP/HTTPS proxy.         Provision nodes to use the built-in HTTP proxy (or user specified proxy) for APT or YUM. MAAS also uses the proxy for downloading boot images.
- *enable_third_party_drivers*: Enable the installation of proprietary drivers (i.e. HPVSA).
- *enlist_commissioning*: Whether to run commissioning during enlistment..         Enables running all built-in commissioning scripts during enlistment.
- *force_v1_network_yaml*: Always use the legacy v1 YAML (rather than Netplan format, also known as v2 YAML) when composing the network configuration for a machine..
- *hardware_sync_interval*: Hardware Sync Interval.         The interval to send hardware info to MAAS from hardware sync enabled machines, in systemd time span syntax.
- *http_proxy*: Proxy for APT or YUM and HTTP/HTTPS.         This will be passed onto provisioned nodes to use as a proxy for APT or YUM traffic. MAAS also uses the proxy for downloading boot images. If no URL is provided, the built-in MAAS proxy will be used.
- *kernel_opts*: Boot parameters to pass to the kernel by default.
- *maas_auto_ipmi_cipher_suite_id*: MAAS IPMI Default Cipher Suite ID.         The default IPMI cipher suite ID to use when connecting to the BMC via ipmitools        Available choices are*: '' (freeipmi-tools default), '12' (12 - HMAC-MD5::MD5-128::AES-CBC-128), '17' (17 - HMAC-SHA256::HMAC_SHA256_128::AES-CBC-128), '3' (3 - HMAC-SHA1::HMAC-SHA1-96::AES-CBC-128), '8' (8 - HMAC-MD5::HMAC-MD5-128::AES-CBC-128).
- *maas_auto_ipmi_k_g_bmc_key*: The IPMI K_g key to set during BMC configuration..         This IPMI K_g BMC key is used to encrypt all IPMI traffic to a BMC. Once set, all clients will REQUIRE this key upon being commissioned. Any current machines that were previously commissioned will not require this key until they are recommissioned.
- *maas_auto_ipmi_user*: MAAS IPMI user..         The name of the IPMI user that MAAS automatically creates during enlistment/commissioning.
- *maas_auto_ipmi_user_privilege_level*: MAAS IPMI privilege level.         The default IPMI privilege level to use when creating the MAAS user and talking IPMI BMCs        Available choices are*: 'ADMIN' (Administrator), 'OPERATOR' (Operator), 'USER' (User).
- *maas_auto_ipmi_workaround_flags*: IPMI Workaround Flags.         The default workaround flag (-W options) to use for ipmipower commands        Available choices are*: '' (None), 'authcap' (Authcap), 'endianseq' (Endianseq), 'forcepermsg' (Forcepermsg), 'idzero' (Idzero), 'integritycheckvalue' (Integritycheckvalue), 'intel20' (Intel20), 'ipmiping' (Ipmiping), 'nochecksumcheck' (Nochecksumcheck), 'opensesspriv' (Opensesspriv), 'sun20' (Sun20), 'supermicro20' (Supermicro20), 'unexpectedauth' (Unexpectedauth).
- *maas_internal_domain*: Domain name used by MAAS for internal mapping of MAAS provided services..         This domain should not collide with an upstream domain provided by the set upstream DNS.
- *maas_name*: MAAS name.
- *maas_proxy_port*: Port to bind the MAAS built-in proxy (default*: 8000).         Defines the port used to bind the built-in proxy. The default port is 8000.
- *maas_syslog_port*: Port to bind the MAAS built-in syslog (default*: 5247).         Defines the port used to bind the built-in syslog. The default port is 5247.
- *max_node_commissioning_results*: The maximum number of commissioning results runs which are stored.
- *max_node_installation_results*: The maximum number of installation result runs which are stored.
- *max_node_testing_results*: The maximum number of testing results runs which are stored.
- *network_discovery*: .         When enabled, MAAS will use passive techniques (such as listening to ARP requests and mDNS advertisements) to observe networks attached to rack controllers. Active subnet mapping will also be available to be enabled on the configured subnets.
- *node_timeout*: Time, in minutes, until the node times out during commissioning, testing, deploying, or entering rescue mode..         Commissioning, testing, deploying, and entering rescue mode all set a timeout when beginning. If MAAS does not hear from the node within the specified number of minutes the node is powered off and set into a failed status.
- *ntp_external_only*: Use external NTP servers only.         Configure all region controller hosts, rack controller hosts, and subsequently deployed machines to refer directly to the configured external NTP servers. Otherwise only region controller hosts will be configured to use those external NTP servers, rack controller hosts will in turn refer to the regions' NTP servers, and deployed machines will refer to the racks' NTP servers.
- *ntp_servers*: Addresses of NTP servers.         NTP servers, specified as IP addresses or hostnames delimited by commas and/or spaces, to be used as time references for MAAS itself, the machines MAAS deploys, and devices that make use of MAAS DHCP services.
- *prefer_v4_proxy*: Sets IPv4 DNS resolution before IPv6.         If prefer_v4_proxy is set, the proxy will be set to prefer IPv4 DNS resolution before it attempts to perform IPv6 DNS resolution.
- *prometheus_enabled*: Enable sending stats to a prometheus gateway..         Allows MAAS to send statistics to Prometheus. This requires the 'prometheus_push_gateway' to be set.
- *prometheus_push_gateway*: Address or hostname of the Prometheus push gateway..         Defines the address or hostname of the Prometheus push gateway where MAAS will send data to.
- *prometheus_push_interval*: Interval of how often to send data to Prometheus (default*: to 60 minutes)..         The internal of how often MAAS will send stats to Prometheus in minutes.
- *promtail_enabled*: Enable streaming logs to Promtail..         Whether to stream logs to Promtail
- *promtail_port*: TCP port of the Promtail Push API..         Defines the TCP port of the Promtail push API where MAAS will stream logs to.
- *release_notifications*: Enable or disable notifications for new MAAS releases..
- *remote_syslog*: Remote syslog server to forward machine logs.         A remote syslog server that MAAS will set on enlisting, commissioning, testing, and deploying machines to send all log messages. Clearing this value will restore the default behaviour of forwarding syslog to MAAS.
- *subnet_ip_exhaustion_threshold_count*: If the number of free IP addresses on a subnet becomes less than or equal to this threshold, an IP exhaustion warning will appear for that subnet.
- *tls_cert_expiration_notification_enabled*: Notify when the certificate is due to expire.         Enable/Disable notification about certificate expiration.
- *tls_cert_expiration_notification_interval*: Certificate expiration reminder (days).         Configure notification when certificate is due to expire in (days).
- *upstream_dns*: Upstream DNS used to resolve domains not managed by this MAAS (space-separated IP addresses).         Only used when MAAS is running its own DNS server. This value is used as the value of 'forwarders' in the DNS server config.
- *use_peer_proxy*: Use the built-in proxy with an external proxy as a peer.         If enable_http_proxy is set, the built-in proxy will be configured to use http_proxy as a peer proxy. The deployed machines will be configured to use the built-in proxy.
- *use_rack_proxy*: Use DNS and HTTP metadata proxy on the rack controllers when a machine is booted..         All DNS and HTTP metadata traffic will flow through the rack controller that a machine is booting from. This isolated region controllers from machines.
- *vcenter_datacenter*: VMware vCenter datacenter.         VMware vCenter datacenter which is passed to a deployed VMware ESXi host.
- *vcenter_password*: VMware vCenter password.         VMware vCenter server password which is passed to a deployed VMware ESXi host.
- *vcenter_server*: VMware vCenter server FQDN or IP address.         VMware vCenter server FQDN or IP address which is passed to a deployed VMware ESXi host.
- *vcenter_username*: VMware vCenter username.         VMware vCenter server username which is passed to a deployed VMware ESXi host.
- *windows_kms_host*: Windows KMS activation host.         FQDN or IP address of the host that provides the KMS Windows activation service. (Only needed for Windows deployments using KMS activation.)
[/tab]
[/tabs]
