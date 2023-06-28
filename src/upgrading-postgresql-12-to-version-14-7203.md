# Upgrade Postgresql from v12 to v14

## BACKUP EXISTING DATA

Optional but highly recommended step

```bash
sudo -u postgres pg_dumpall > backup.sql
```

## Upgrade the service
Install new packages

```bash
sudo apt-get update
sudo apt-get install postgresql-14 postgresql-server-dev-14
```

Stop the existing server

```bash
sudo systemctl stop postgresql.service
```

Convert configuration files
```bash
sudo -u postgres /usr/lib/postgresql/14/bin/pg_upgrade \
--old-datadir=/var/lib/postgresql/12/main \
--new-datadir=/var/lib/postgresql/14/main \
--old-bindir=/usr/lib/postgresql/12/bin \
--new-bindir=/usr/lib/postgresql/14/bin \
--old-options '-c config_file=/etc/postgresql/12/main/postgresql.conf' \
--new-options '-c config_file=/etc/postgresql/14/main/postgresql.conf'
```

Move the new server to the default Postgresql port

```bash
# change 'port' to 5432
sudo vim /etc/postgresql/14/main/postgresql.conf

# change 'port' to 5433
sudo vim /etc/postgresql/12/main/postgresql.conf
```

Start the new server and check the version

```bash
sudo systemctl start postgresql.service
sudo -u postgres psql -c "SELECT version();"
```

Run the generated new cluster script

```bash
sudo -u postgres ./analyze_new_cluster.sh
```

Postgresql v14 uses `scram-sha-256` as default password hash function. You **must** redefine all existing passwords

```plain
$ sudo -u postgres psql
postgres=# \password $USER
Enter new password for user "$USER": 
Enter it again: 
```

Alternatively, you can edit `/etc/postgresql/14/main/pg_hba.conf` and revert this change, setting the hash function to `md5` and restarting the server. Be aware that future versions of Postgresql might drop the MD5 support, so this is only a temporary solution.

Clean-up up the old version

```bash
#uninstalls postgres packages
sudo apt-get remove postgresql-12 postgresql-server-dev-12

#removes the old postgresql directory
sudo rm -rf /etc/postgresql/12/

#delete the old cluster data
sudo -u postgres ./delete_old_cluster.sh
```