<!-- MAAS installation requirements -->
Before installing MAAS for the first time, you should make sure that the target system meets the minimum requirements for the machines that run MAAS, which vary widely depending on local implementation and usage.  Below, you will find resource estimates based on MAAS components and operating system (Ubuntu Server). We consider both a test configuration (for proof of concept) and a production environment.

<a href="#heading--maas-ntp-and-chrony"><h2 id="heading--maas-ntp-and-chrony">MAAS, NTP, and chrony</h2></a>

When installing MAAS on Ubuntu, there can be conflicts between the existing NTP client, `systemd-timesyncd`, and the NTP client/server provided by MAAS, `chrony`. This can lead to time synchronization issues, especially if MAAS is configured with different upstream NTP servers than the ones used by `systemd-timesyncd`.  Appropriate instructions are provided in the MAAS [installation guide](/t/how-to-do-a-fresh-install-of-maas/5128#heading--installation-notes).

<a href="#heading--test-environment"><h2 id="heading--test-environment">Requirements for a test environment</h2></a>

Here is a proof-of-concept scenario, with all MAAS components installed on a single host. This scenario assumes two complete sets of images (latest two Ubuntu LTS releases) for a single architecture (amd64).

| | Memory (MB) | CPU (GHz) | Disk (GB) |
|:---|----:|----:|----:|
| [Region controller](/t/maas-glossary/5416#heading--controllers) (minus PostgreSQL) | 512 | 0.5 | 5 |
| PostgreSQL | 512 | 0.5 | 5 |
| [Rack controller](/t/maas-glossary/5416#heading--controllers") | 512 | 0.5 | 5 |
| Ubuntu Server (including logs)| 512 | 0.5 | 5 |

Based on this table, the approximate requirements for this scenario are 2 GB memory, 2 GHz CPU, and 20 GB of disk space.

<a href="#heading--production-environment"><h2 id="heading--production-environment">Requirements for a production environment</h2></a>

Here is a production scenario designed to handle a high number of sustained client connections. This scenario implements both high availability (region and rack) and load balancing (region). MAAS reserves extra space for images (database and rack controller), while some images, such as those for Microsoft Windows, may require a lot more -- so plan accordingly.

| | Memory (MB) | CPU (GHz) | Disk (GB) |
|:---|----:|----:|----:|
| [Region controller](/t/maas-glossary/5416#heading--controllers) (minus PostgreSQL) | 2048 | 2.0 | 5 |
| PostgreSQL | 2048 | 2.0 | 20 |
| [Rack controller](/t/maas-glossary/5416#heading--controllers") | 2048 | 2.0 | 20 |
| Ubuntu Server (including logs)| 512 | 0.5 | 5 |

So, based on the above, the approximate requirements for this scenario are:

- A region controller (including PostgreSQL) installed on one host, with 4.5 GB memory, 4.5 GHz CPU, and 45 GB of disk space.
- A duplicate region controller (including PostgreSQL) on a second host, also with 4.5 GB memory, 4.5 GHz CPU, and 45 GB of disk space.
- A rack controller installed on a third host, with 2.5 GB memory, 2.5 GHz CPU, and 40 GB of disk space.
- A duplicate rack controller on a fourth host, also with 2.5 GB memory, 2.5 GHz CPU, and 40 GB of disk space.

The tables above refer to MAAS infrastructure only. They do not cover the resources needed by subsequently-added nodes. Note that machines should have IPMI-based BMC controllers for power cycling, see [Power management](/t/power-drivers-reference/5246) for more details.

Some examples of factors that influence hardware specifications include:

- the number of connecting clients (client activity)
- how you decide to distribute services
- whether or not you use [high availability/load balancing](/t/how-to-enable-high-availability/5120).
- the number of images that you choose to store (disk space affecting PostgreSQL and the rack controller)

Also, this discussion does not take into account a possible local image mirror, which would be a large consumer of disk space.

One rack controller should only service 1000 machines or less, regardless of how you distribute them across subnets. There is no load balancing at the rack level, so you will need additional, independent rack controllers. Each controller must service its own subnet(s).