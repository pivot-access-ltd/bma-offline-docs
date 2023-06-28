<!-- "Upgrading PostgreSQL 12 to verion 14" -->
If you need to upgrade Postgresql from v12 to v14, you can follow the procedure given below.

[note]
You should turn off MAAS before performing this upgrade.  It doesn't matter whether it's installed or not, but it shouldn't be running during this procedure.
[/note]

<a href="#heading--back-up-your-existing-data"><h2 id="heading--back-up-your-existing-data">Back up your existing data</h2></a>

An optional but highly recommended first step is to back up your existing data, like this:

```bash
sudo -u postgres pg_dumpall > backup.sql
```

<a href="#heading--upgrade-the-service"><h2 id="heading--upgrade-the-service">Upgrade the service</h2></a>

Next, you'll want to upgrade the PostgreSQL service:

1. Install new packages

```bash
sudo apt-get update
sudo apt-get install postgresql-14 postgresql-server-dev-14
```

2. Stop the existing server

```bash
sudo systemctl stop postgresql.service
```

3. Convert the configuration files

```bash
sudo -u postgres /usr/lib/postgresql/14/bin/pg_upgrade \
--old-datadir=/var/lib/postgresql/12/main \
--new-datadir=/var/lib/postgresql/14/main \
--old-bindir=/usr/lib/postgresql/12/bin \
--new-bindir=/usr/lib/postgresql/14/bin \
--old-options '-c config_file=/etc/postgresql/12/main/postgresql.conf' \
--new-options '-c config_file=/etc/postgresql/14/main/postgresql.conf'
```

4. Move the new server to the default Postgresql port

```bash
# change 'port' to 5432
sudo vim /etc/postgresql/14/main/postgresql.conf

# change 'port' to 5433
sudo vim /etc/postgresql/12/main/postgresql.conf
```

5. Start the new server and check the version

```bash
sudo systemctl start postgresql.service
sudo -u postgres psql -c "SELECT version();"
```

6. Run the generated new cluster script

```bash
sudo -u postgres ./analyze_new_cluster.sh
```

<a href="#heading--reset-your-passwords"><h2 id="heading--reset-your-passwords">Reset your passwords</h2></a>

Postgresql v14 uses `scram-sha-256` as default password hash function. You **must** redefine all existing passwords

```plain
$ sudo -u postgres psql
postgres=# \password $USER
Enter new password for user "$USER": 
Enter it again: 
```

Alternatively, you can edit `/etc/postgresql/14/main/pg_hba.conf` and revert this change, setting the hash function to `md5` and restarting the server. Be aware that future versions of Postgresql might drop the MD5 support, so this is a temporary solution that carries some risk.

<a href="#heading--clean-up-the-old-version"><h2 id="heading--clean-up-the-old-version">Clean up the old version</h2></a>

Finally, you should clean up the old version:

```bash
#uninstalls postgres packages
sudo apt-get remove postgresql-12 postgresql-server-dev-12

#removes the old postgresql directory
sudo rm -rf /etc/postgresql/12/

#delete the old cluster data
sudo -u postgres ./delete_old_cluster.sh
```