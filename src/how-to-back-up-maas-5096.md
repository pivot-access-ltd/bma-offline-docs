<!-- "How to keep MAAS backed up" -->
MAAS currently does not provide specific tools to back up and restore a working MAAS configuration. MAAS servers are part of your data centre, just like other Linux-based servers, so your current backup and disaster recovery solution should be sufficient to back up your MAAS environment.  Even so, you should know which files and actions are critical -- to ensure that you get a clean backup, and further ensure that you can restore it cleanly.

[tabs]
[tab version="v3.4 Snap,v3.3 Snap,v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap"]
To back up your MAAS snap instance and restore it elsewhere, follow these steps:

1. Backup your PostgreSQL database to a file called `dump.sql` in your home directory:

``` bash
sudo -u postgres pg_dumpall -c > ~/dump.sql
```

2. Ensure this has completed and that there are no other established sessions with the following command:

``` bash
sudo -u postgres psql -c  "SELECT * FROM pg_stat_activity"
```
Running sessions, such as pg_dumpall, will appear in the `application_name` column of the output alongside `psql` running the above `pg_stat_activity` query.

3. Stop the PostgreSQL service:

```bash
sudo systemctl stop postgresql.service
```
4. Stop the MAAS snap service:

```bash
sudo snap stop maas
```

5. Take a snapshot of the snap service:

```bash
sudo snap save maas
```

Note the snapshot id (number) that this command returns.

5. Verify that the snapshot is valid:

```bash
sudo snap check-snapshot <snapshot-id>
```

6. Export the snapshot to some external media:

```bash
sudo snap export-snapshot <snapshot-id> <external-media-path/snapshot-filename>
```

Be sure to restart the MAAS service if you plan to continue to use the current configuration, with:

```bash
sudo snap restart maas
```

Otherwise, you can leave MAAS stopped.

7. If reinstalling MAAS on the same system, use the following command to completely remove the old MAAS instance from your system:

```bash
sudo snap remove --purge maas
```

8. Restore the PostgreSQL dump with the following command:

```bash
sudo -u postgres psql -f dump.sql postgres
```
8. Restart the PostgreSQL service:

```bash
sudo systemctl start postgresql.service
```

10. Install the MAAS snap (same version) on your target machine, using the standard installation instructions for the version you're (re)installing.

11. Import the snapshot onto your target machine:

```bash
sudo snap import-snapshot <external-media-path/snapshot-filename>
```

The import function should give you the same snapshot ID.  If an existing snapshot has the same number (shouldn't happen here), that snapshot is overwritten.

12. Restore the snapshot:

```bash
sudo snap restore <snapshot-id>
```

13. Reset the database triggers with the following command:

```bash
sudo maas-region dbupgrade
```
[note]
You only need to run this command on one of the Region Controllers in a multi-region MAAS cluster.
[/note]

At this point, you should be up and running with a restored MAAS backup.
[/tab]
[tab version="v3.4 Packages,v3.3 Packages,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages"]
To back up your MAAS snap instance and restore it elsewhere, follow these steps:

1. Backup your PostgreSQL database to a file called `dump.sql` in your home directory:

``` bash
sudo -u postgres pg_dumpall -c > ~/dump.sql
```

2. Ensure this has completed and that there are no other established sessions with the following command:

``` bash
sudo -u postgres psql -c  "SELECT * FROM pg_stat_activity"
```
Running sessions, such as pg_dumpall, will appear in the `application_name` column of the output alongside `psql` running the above `pg_stat_activity` query.

3. Stop MAAS-related services:

```bash
sudo systemctl stop postgresql.service
sudo systemctl stop maas-dhcpd.service
sudo systemctl stop maas-rackd.service
sudo systemctl stop maas-regiond.service
```

4. Archive the DB backup and the needed MAAS configuration files to an external drive with the following command:

``` bash
sudo tar cvpzf <some-external-path>/backup.tgz --exclude=/var/lib/maas/boot-resources /etc/maas /var/lib/maas ~/dump.sql
```

If you're not replacing the existing MAAS, make sure to restart the services you stopped prior to completing the backup.

<a href="#heading--restore-files"><h2 id="heading--restore-files">How to restore the system when needed</h2></a>

To restore the MAAS backup to a new machine:

1. Start with a freshly-updated installation of Ubuntu on identical hardware.

2. Reinstall MAAS via the standard installation procedure.

3. Stop the following services (note that PostgreSQL needs to keep running):

```bash
sudo systemctl stop maas-dhcpd.service
sudo systemctl stop maas-rackd.service
sudo systemctl stop maas-regiond.service
```

4. Copy the backup file to the new machine and untar its contents:

```bash
sudo tar xvzpf backup.tgz
```

5. Restore the database with the following command:

``` bash
sudo -u postgres psql -f dump.sql postgres
```

6. Copy across the old configuration files to their new locations, taking care to move the originals aside just in case:

```bash
sudo sh -c "mv /etc/maas /etc/_maas; mv /var/lib/maas /var/lib/_maas"
sudo sh -c "cp -prf etc/maas /etc/; cp -prf var/lib/maas /var/lib/"
```
Take care to preserve the correct permissions when restoring files and directories.

7. If your restore process regenerated the `/var/lib/maas/secret` file, make sure update this secret on any additional rack controllers.

8. Reset the database triggers:

``` bash
sudo maas-region dbupgrade
```

[note]
You only need to run this command on one of the Region Controllers in a multi-region MAAS cluster.
[/note]

9. Restart the stopped services:

```bash
sudo systemctl start maas-dhcpd.service
sudo systemctl start maas-rackd.service
sudo systemctl start maas-regiond.service
```

At this point, you should be up and running with a restored MAAS backup.
[/tab]
[/tabs]
