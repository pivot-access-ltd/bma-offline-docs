LXD and MAAS are separate products, and it's useful to allow them to interact as equals, covering a much wider range of use cases.  To allow each of them to follow their own operational models, but still allow them to work together, we've taken advantage of LXD projects.

* [About LXD projects and MAAS](#heading--projects-explanation)
* [An LXD project tutorial](#heading--projects-tutorial)
* [How to use LXD projects with MAAS](#heading--projects-step-2-lxd-and-maas)

<a href="#heading--projects-explanation"><h2 id="heading--projects-explanation">About LXD projects and MAAS</h2></a>

It may be beneficial to understand how LXD projects fit into the overall MAAS ecosystem.  LXD projects are not intended to be MAAS projects; they are only intended to limit which LXD containers and VMs are available to MAAS. This section will tell you:

* [About LXD projects](#heading--projects-big-picture)
* [About design choices](#heading--projects-history)
* [About alternatives to LXD projects in MAAS](#heading--projects-alternatives)

<a href="#heading--projects-big-picture"><h3 id="heading--projects-big-picture">About LXD projects</h3></a>

[LXD projects](https://ubuntu.com/tutorials/introduction-to-lxd-projects#1-overview) are a feature of the [LXD lightweight container hypervisor](https://ubuntu.com/server/docs/containers-lxd) -- a next-generation container manager which makes containers as easy to manage as virtual machines.  With LXD, you can create lots of containers, providing different services across many different use cases.  As a result of this flexibility, it can become confusing to keep track of exactly which containers are providing what services to answer which use case.

To help with this potential confusion, LXD provides a "projects" feature, which allows you to group one or more containers together into related projects.  These projects can be manipulated and managed with the same `lxc` tool used to manage the containers and virtual machines themselves.

Since MAAS makes use of LXD as a VM host, it's useful to be able to manipulate and manage projects not only through MAAS, but also directly through LXD.  In fact, to properly scope MAAS access to your LXD resources, it's essential that you understand how to use LXD projects in some detail.

<a href="#heading--projects-history"><h3 id="heading--projects-history">About design choices</h3></a>

Prior versions of MAAS implemented LXD VM hosts, but did so in a strongly-coupled way; that is, MAAS essentially took control of the VMs, disallowing or overriding some direct LXD controls.  In a sense, MAAS became the owner, rather than simply a separate program, communicating interdependently with LXD to accomplish user purposes.

This was less than ideal.  For example, MAAS would discover all running LXD VMs and immediately commission them, essentially performing a "clean install" and wiping out their contents.  This behaviour isn't suitable when MAAS is connected to a deployed LXD with VMs already running services that may not have been targeted for enlistment by MAAS.

With the release of MAAS 3.0 version, MAAS now becomes a LXD tenant, rather than an owner.

As you can infer from some of the discussion above, MAAS and LXD are separate products.  It's beneficial for them to interact, but not if one product cannot be controlled and managed independently of the other.  The combination of MAAS and LXD can cover a much broader set of use cases between them if they act as independent tools.  While the most loosely-coupled model would have MAAS selecting individual VMs, that model isn't compatible with how MAAS works with other networks and devices, so we chose to implement projects as a way to section off LXD VMs for normal use by MAAS.

<a href="#heading--maas-control-at-project-level"><h4 id="heading--maas-control-at-project-level">MAAS now controls VMs at a project level</h4></a>

Essentially, MAAS still commissions any VMs it discovers within a VM host, but the scope of the discovery is now limited to a single project.  That project can contain any subset of the existing VMs, from zero to all of them.  Any VM that's already in a project assigned to MAAS will still be re-commissioned, which is the normal behaviour of MAAS upon network discovery.

Here are the criteria which drove this decision:

* It should be possible for an administrator to select which project(s) MAAS manages, and thus which machines will be automatically enlisted and commissioned.
* It should be possible for MAAS to create and self-assign a new (empty) project, so that the user can compose new VMs within LXD from within the MAAS interface.
* No per-project features should be enabled by default in MAAS-created projects.
* The project must be explicitly specified when creating the LXD VM host.
* When a LXD VM host is added, only the existing VMs assigned to the selected project (if any) should be visible to MAAS (and thus, automatically commissioned), and VMs in non-MAAS projects are not affected in any way.
* When a LXD VM host is deleted, the default behaviour should be for MAAS to leave existing VMs, rather than automatically deleting them; VMs in non-MAAS projects are not affected in any way.
* MAAS will not create VMs in projects that it doesn't own.
* When a VM is composed in MAAS, it's created in the target LXD project.

In addition, a MAAS administrator should be able to:

* refresh information about a specific LXD VM host, and receive correct, up-to-date, and timely status.
* explicitly specify connections between networks and VM interfaces.
* deploy a machine directly as an LXD VM host, connected to MAAS from the outset.

These criteria were fully met in the MAAS LXD tenant implementation released as part of MAAS 3.0.

<a href="#heading--projects-big-picture"><h3 id="heading--projects-alternatives">About alternatives to LXD projects in MAAS</h3></a>

You can see from the discussion above that LXD projects were used primarily to cordon off some LXD VMs from MAAS, to avoid them from being enlisted and commissioned by MAAS (and thus, essentially, destroyed, from an operational perspective).  These LXD project features provide some limited capabilities to group machines. Because LXD projects only deal with LXD VMs and VM hosts, they are not a complete or comprehensive set of project tools.  MAAS already has those machine grouping capabilities in the form of [resource pools](LINKS).

We realised, though, as we were working with LXD projects, that we could vastly improve the documentation for resource pools in the area of projects and project management.  You'll find significant new material in the [resource pools](LINKS) section of the doc.  We also realised that it would be helpful to have "real-time tags" for machines, that is, annotations that persist only while a machine is allocated or deployed.  These new "tags" are known as [workload annotations](LINK), and they have also been given a thorough treatment, also with their own page in the left-hand navigation.

<a href="#heading--projects-tutorial"><h2 id="heading--projects-tutorial">An LXD project tutorial</h2></a>

A good understanding of LXD projects is essential for those using LXD VM hosts, especially if you plan to include non-MAAS-controlled VMs in your LXD instance.  Normally, we wouldn't revisit instructions [found elsewhere](https://ubuntu.com/tutorials/introduction-to-lxd-projects#1-overview), but because the discussion flows quickly and naturally into MAAS-related usage, it seemed prudent to give a light overview of some basic feature information.

<a href="#heading--projects-s1-list"><h3 id="heading--projects-s1-list">How to list LXD projects</h3></a>

Before you try to manipulate projects, it's useful to understand how to list them, so that you can check your results as you go.  If you've successfully [installed and initialised lxd](https://linuxcontainers.org/lxd/getting-started-cli/), you should be able to list projects.  A basic project list can be obtained with the following command:

```nohighlight
lxd project list
```

You should get a listing something like this:

```nohighlight
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
|        NAME         | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default (current)   | YES    | YES      | YES             | YES      | Default LXD project     | 7       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

Note that this particular instantiation of LXD has two projects: the default project (which generally always exists in LXD), and a project called `pg-basebackup-tests` which is already managed by MAAS.

There is a column labelled `USED BY`, which tabulates the number of entities contained within the project. There isn't a project-related command to get a list of the containers and VMs within a project.  Instead, you use the LXC command `lxc list`:

```text
lxc list
```

which yields something like the following tabulated listing:

```nohighlight
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
|      NAME       |  STATE  | IPV4 |                    IPV6                     |      TYPE       | SNAPSHOTS |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| trusty-drake    | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| upward-stallion | RUNNING |      | fd42:ec:5a53:59d2:216:3eff:febf:7fa7 (eth0) | CONTAINER       | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| witty-lizard    | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| crazy-goose     | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| dirty-horse     | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| confused-mouse  | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| uplifting-dog   | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
```

How do you know which project you're listing?  The most reliable way is to first list projects and see which one is marked `(current)`, like this:

```nohighlight
lxc project list
```

As you see in the sample output, the currently visible and accessible project is listed as `(current)` in the project listing:

```text
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
|        NAME         | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default (current)   | YES    | YES      | YES             | YES      | Default LXD project     | 7       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

We'll show you how to switch to a different project further along in this tutorial.

<a href="#heading--projects-s1-create"><h3 id="heading--projects-s1-create">How to create a LXD project</h3></a>

Suppose that you're about to create a MAAS VM host, and you want a specific project named "maas-vm-host-1" for this particular situation.  You can create that project with the following command:

```nohighlight
$ lxc project create maas-vm-host-1
Project maas-vm-host-1 created
```

When you check your work with `lxc project list`, you'll see that LXD did not automatically switch to the new project:

```nohighlight
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
|        NAME         | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default (current)   | YES    | YES      | YES             | YES      | Default LXD project     | 7       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| maas-vm-host-1      | YES    | YES      | YES             | NO       |                         | 1       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

The `lxc` tool generally does only what you ask, nothing more.  

<a href="#heading--projects-s1-delete"><h3 id="heading--projects-s1-delete">How to delete a LXD project</h3></a>

Now, suppose that you decide you don't need this project yet.  No worries: you can easily delete it like this:

```nohighlight
$ lxc project delete maas-vm-host-1
Project maas-vm-host-1 deleted
```

You can check that it was successfully deleted with the `lxc project list` command:

```text
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
|        NAME         | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default (current)   | YES    | YES      | YES             | YES      | Default LXD project     | 7       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

<a href="#heading--projects-s1-rename"><h3 id="heading--projects-s1-rename">How to rename a LXD project</h3></a>

On the other hand, maybe you didn't need to actually delete that project, just change the name to `maas-vm-host-001`, which is what you really wanted in the first place.  Consider your original project name, `maas-vm-host-1`:

```nohighlight
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
|        NAME         | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default (current)   | YES    | YES      | YES             | YES      | Default LXD project     | 7       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| maas-vm-host-1      | YES    | YES      | YES             | NO       |                         | 1       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

You can quickly and easily change the project name like this:

```nohighlight
$ lxc project rename maas-vm-host-1 maas-vm-host-001
Project maas-vm-host-1 renamed to maas-vm-host-001
$ lxc project list
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
|        NAME         | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default (current)   | YES    | YES      | YES             | YES      | Default LXD project     | 7       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| maas-vm-host-001    | YES    | YES      | YES             | NO       |                         | 1       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

From now on, we'll be combining command output with the command invocation, most of the time.

<a href="#heading--projects-s1-switch"><h3 id="heading--projects-s1-switch">How to switch between LXD projects</h3></a>

You can choose which LXD project is currently visible and accessible, that is, you can choose which project will be acted on by most of the other project commands.  Let's begin by listing the current projects:

```nohighlight
$ lxc project list
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
|        NAME         | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default (current)   | YES    | YES      | YES             | YES      | Default LXD project     | 7       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| maas-vm-host-001    | YES    | YES      | YES             | NO       |                         | 1       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

Only the project marked `(current)` in the project listing can be manipulated, for the most part, with the obvious exceptions of command that take project names (like "create," "delete," and so forth).  For example, using `lxc list` to enumerate the names of containers and VMs limits its scope to the current project, which is till "default" at this point:

```nohighlight
$ lxc list
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
|      NAME       |  STATE  | IPV4 |                    IPV6                     |      TYPE       | SNAPSHOTS |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| trusty-drake    | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| upward-stallion | RUNNING |      | fd42:ec:5a53:59d2:216:3eff:febf:7fa7 (eth0) | CONTAINER       | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| witty-lizard    | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| crazy-goose     | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| dirty-horse     | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| confused-mouse  | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| uplifting-dog   | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
```

Suppose I want to know what all those "USE BY" things are in that `pg-basebackup-tests` project?  Well, the most straightforward way to get that list is to first switch projects, like this:

```nohighlight
lxc project switch pg-basebackup-tests
```

This command returns nothing if successful (following the old UNIX rule of "no news is good news").  If you now repeat the project list command, like this:

```nohighlight
$ lxc project list
+-------------------------------+--------+----------+-----------------+----------+-------------------------+---------+
|             NAME              | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+-------------------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default                       | YES    | YES      | YES             | YES      | Default LXD project     | 7       |
+-------------------------------+--------+----------+-----------------+----------+-------------------------+---------+
| maas-vm-host-001              | YES    | YES      | YES             | NO       |                         | 1       |
+-------------------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests (current) | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+-------------------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

You can see in the above listing that we've switched to the "...-tests" project.  Now when we do a container list, we'll see a different set:

```nohighlight
$ lxc list
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
|      NAME       |  STATE  | IPV4 |                    IPV6                     |      TYPE       | SNAPSHOTS |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| whacky-moose    | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| peeved-gerbil   | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| hairy-nutria    | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| mad-crocodile   | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| flirty-possum   | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| angry-armadillo | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| sneaky-snake    | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| happy-catfish   | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| cute-kitten     | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| bombastic-dog   | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| articulate-eel  | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| mobid-owl       | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| drunk-crow      | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| spicy-alligator | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
| nice-crawfish   | STOPPED |      |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+---------------------------------------------+-----------------+-----------+
```

It's good practice to always switch projects carefully, so you're not operating in some other project and creating chaos by accident.

<a href="#heading--projects-s1-resource"><h3 id="heading--projects-s1-resource">How to et a summary of LXD project resources</h3></a>

We said that `lxc` commands operate on the current project most of the time.  We gave that caveat because of commands like `lxc project info`, which requires a project name to get any usable output.  For example, if you just type `lxc project info`, you'll just get some "help" output:

```nohighlight
$ lxc project info
Description:
  Get a summary of resource allocations

Usage:
  lxc project info [<remote>:]<project> <key> [flags]

Flags:
      --format   Format (csv|json|table|yaml) (default "table")

Global Flags:
      --debug            Show all debug messages
      --force-local      Force using the local unix socket
  -h, --help             Print help
      --project string   Override the source project
  -q, --quiet            Don't show progress information
  -v, --verbose          Show all information messages
      --version          Print version number
```

You can see from the help listing that a project name is required.  Let's try that again with a fairly large project:

```nohighlight
$ lxc project info pg-basebackup-tests
+------------------+-----------+----------+
|     RESOURCE     |   LIMIT   |  USAGE   |
+------------------+-----------+----------+
| CONTAINERS       | UNLIMITED | 0        |
+------------------+-----------+----------+
| CPU              | UNLIMITED | 15       |
+------------------+-----------+----------+
| DISK             | UNLIMITED | 120.00GB |
+------------------+-----------+----------+
| INSTANCES        | UNLIMITED | 15       |
+------------------+-----------+----------+
| MEMORY           | UNLIMITED | 32.21GB  |
+------------------+-----------+----------+
| NETWORKS         | UNLIMITED | 0        |
+------------------+-----------+----------+
| PROCESSES        | UNLIMITED | 0        |
+------------------+-----------+----------+
| VIRTUAL-MACHINES | UNLIMITED | 15       |
+------------------+-----------+----------+
```

Here we see that the `pg-basebackup-tests` file has no containers, 15 VMs, 120GB of disk space used, etc.  You can do this for any project, even if it's not the current project, so from where we are here (in the `pg-basebackup-tests` project), we can still check resources in the `default` project:

```nohighlight
$ lxc project info default
+------------------+-----------+---------+
|     RESOURCE     |   LIMIT   |  USAGE  |
+------------------+-----------+---------+
| CONTAINERS       | UNLIMITED | 1       |
+------------------+-----------+---------+
| CPU              | UNLIMITED | 2       |
+------------------+-----------+---------+
| DISK             | UNLIMITED | 16.00GB |
+------------------+-----------+---------+
| INSTANCES        | UNLIMITED | 3       |
+------------------+-----------+---------+
| MEMORY           | UNLIMITED | 4.29GB  |
+------------------+-----------+---------+
| NETWORKS         | UNLIMITED | 2       |
+------------------+-----------+---------+
| PROCESSES        | UNLIMITED | 0       |
+------------------+-----------+---------+
| VIRTUAL-MACHINES | UNLIMITED | 2       |
+------------------+-----------+---------+
```

Note that `lxc project info` requires a project name.  As mentioned earlier, typing the command without a project name just gives you a help message, not the stats for the default or current projects.

<a href="#heading--projects-s1-optionste"><h3 id="heading--projects-s1-options">How to show LXD project options</h3></a>

You'll remember that the "USED BY" column seemed to list more entities than there were containers or VMs.  For example, the `default` project is "USED BY" seven entities, but only shows three containers or VMs:

```nohighlight
$ lxc project list
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
|        NAME         | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default (current)   | YES    | YES      | YES             | YES      | Default LXD project     | 7       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| maas-vm-host-001    | YES    | YES      | YES             | NO       |                         | 1       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

You can make more sense of the "USED BY" column, and get a lot more information about your project, by using the `lxc project show` command:

```nohighlight
$ lxc project show default
config:
  features.images: "true"
  features.networks: "true"
  features.profiles: "true"
  features.storage.volumes: "true"
description: Default LXD project
name: default
used_by:
- /1.0/images/9a30ffb2faeea61cce6012c63071a1f1504a76e1dbbe03e575cc313170fdaf43
- /1.0/instances/trusty-drake
- /1.0/instances/upward-stallion
- /1.0/instances/witty-lizard
- /1.0/networks/lxdbr0
- /1.0/networks/lxdbr1
- /1.0/profiles/default
```

Here you'll see several categories of information, notably as list of entities that are using this project.  For example, there are three VMs/containers, two networks, one image, and the default profile.

What's really interesting, though, is that the `pg-basebackup-tests` project is only used by 16 entities -- but there are 15 VMs in that project.  What's that discrepancy about?  Well, we can find out by showing the options for that project:

```text
$ lxc project show pg-basebackup-tests
config:
  features.images: "false"
  features.profiles: "true"
  features.storage.volumes: "false"
description: Project managed by MAAS
name: pg-basebackup-tests
used_by:
- /1.0/instances/whacky-moose?project=pg-basebackup-tests
- /1.0/instances/peeved-gerbil?project=pg-basebackup-tests
- /1.0/instances/hairy-nutria?project=pg-basebackup-tests
- /1.0/instances/mad-crocodile?project=pg-basebackup-tests
- /1.0/instances/flirty-possum?project=pg-basebackup-tests
- /1.0/instances/angry-armadillo?project=pg-basebackup-tests
- /1.0/instances/sneaky-snake?project=pg-basebackup-tests
- /1.0/instances/happy-catfish?project=pg-basebackup-tests
- /1.0/instances/cute-kitten?project=pg-basebackup-tests
- /1.0/instances/bombastic-dog?project=pg-basebackup-tests
- /1.0/instances/articulate-eel?project=pg-basebackup-tests
- /1.0/instances/morbid-owl?project=pg-basebackup-tests
- /1.0/instances/drunk-crow?project=pg-basebackup-tests
- /1.0/instances/spicy-alligator?project=pg-basebackup-tests
- /1.0/instances/nice-crawfish?project=pg-basebackup-tests
- /1.0/profiles/default?project=pg-basebackup-tests
```

Here you can see that the non-default project contains only a default profile for itself, and the 15 VMs added there.  The other entities aren't needed here, or can be accessed in the	`default` project if required.

<a href="#heading--projects-step-2-lxd-and-maas"><h3 id="heading--projects-step-2-lxd-and-maas">How to use LXD projects with MAAS</h3></a>

This subsection will show you:

* [How to create a new project for MAAS when instantiating a VM host](#heading--projects-s2-create-with-vm-host)
* [How to create a new VM in the LXD project associated with a VM host](#heading--projects-s2-create-vm-in-vm-host-project)
* [How to move an existing VM into the LXD project associated with a VM host](#heading--projects-s2-move-vm-into-vm-host-project)
* [How to delete the VM host](#heading--projects-s2-delete-vm-host)
* [How to move LXD entities to another project to hide them from MAAS](#heading--projects-s2-move-non-maas-items)

<a href="#heading--projects-s2-create-with-vm-host"><h3 id="heading--projects-s2-create-with-vm-host">How to create a new project for MAAS when instantiating a VM host</h3></a>

If you're using MAAS from the CLI, you'll want to make sure you've generated an API key and logged in before you attempt to create a VM host.  These steps are fairly simple; first, you'll need the MAAS URL, which for this example, is `http://192.168.33.91:5240/MAAS`.   You can find this URL by typing:

```nohighlight
$ maas --help
```

This will return a help string.  The correct MAAS API URL is shown in the last entry, "admin:"

```nohighlight
usage: maas [-h] COMMAND ...

optional arguments:
  -h, --help      show this help message and exit

drill down:
  COMMAND
    login         Log in to a remote API, and remember its description and credentials.
    logout        Log out of a remote API, purging any stored credentials.
    list          List remote APIs that have been logged-in to.
    refresh       Refresh the API descriptions of all profiles.
    init          Initialise MAAS in the specified run mode.
    config        View or change controller configuration.
    status        Status of controller services.
    migrate       Perform migrations on connected database.
    apikey        Used to manage a user's API keys. Shows existing keys unless --generate or --delete
                  is passed.
    configauth    Configure external authentication.
    createadmin   Create a MAAS administrator account.
    changepassword
                  Change a MAAS user's password.
    admin         Interact with http://192.168.33.91:5240/MAAS/api/2.0/
```

Next, you'll need to generate the API key for your administrative user.  You can this by entering the following at the command line:

```nohighlight
$ sudo maas apikey --generate --username admin
[sudo] password for $USERNAME:
```

This will return only the API key, which looks something like this:

```nohighlight
PPWQWHs75G6rRmhgdQ:mskfQUYsSqBQnfCYC8:ZruUD3EmnQyhRLapR5whY4bV4h8n7zr7
```

Having both of these, you can login with the following command:

```nohighlight
$ maas login admin http://192.168.33.91:5240/MAAS/api/2.0
API key (leave empty for anonymous access): PPWQWHs75G6rRmhgdQ:mskfQUYsSqBQnfCYC8:ZruUD3EmnQyhRLapR5whY4bV4h8n7zr7
```

Note in this example, you could cut and paste both the MAAS API URL and the API key into the command, at appropriate points.  When you log in successfully, you will obtain a help listing something like this:

```nohighlight

You are now logged in to the MAAS server at
http://192.168.33.91:5240/MAAS/api/2.0/ with the profile name 'admin'.

For help with the available commands, try:

  maas admin --help
```

Now that you're logged in, you can create a new KVM with the following `maas $PROFILE vmhosts create` command:

```nohighlight
$ maas admin vmhosts create --help
usage: maas admin vmhosts create [--help] [-d] [-k] [data [data ...]]

Create a VM host


This method accepts keyword arguments.  Pass each argument as a
key-value pair with an equals sign between the key and the value:
key1=value1 key2=value key3=value3.  Keyword arguments must come after
any positional arguments.

Create or discover a new VM host.

:param type: Required.  The type of VM host to create:
``lxd`` or ``virsh``.
:type type: String

 :param power_address: Required.  Address that gives
MAAS access to the VM host power control. For example, for virsh
``qemu+ssh://172.16.99.2/system``
For ``lxd``, this is just the address of the host.
:type power_address: String

 :param power_user: Required.  Username to use for
power control of the VM host. Required for ``virsh``
VM hosts that do not have SSH set up for public-key authentication.
:type power_user: String

 :param power_pass: Required.  Password to use for
power control of the VM host. Required ``virsh`` VM hosts that do
not have SSH set up for public-key authentication and for ``lxd``
if the MAAS certificate is not registered already in the LXD server.
:type power_pass: String

 :param name: Optional.  The new VM host's name.
:type name: String

 :param zone: Optional.  The new VM host's zone.
:type zone: String

 :param pool: Optional.  The name of the resource
pool the new VM host will belong to. Machines composed from this VM host
will be assigned to this resource pool by default.
:type pool: String

 :param tags: Optional.  A tag or list of tags (
comma delimited) to assign to the new VM host.
:type tags: String

 :param project: Optional.  For ``lxd`` VM hosts, the
project that MAAS will manage. If not provided, the ``default`` project
will be used. If a nonexistent name is given, a new project with that
name will be created.
:type project: String


Common command-line options:
    --help, -h
	Show this help message and exit.
    -d, --debug
	Display more information about API responses.
    -k, --insecure
	Disable SSL certificate check
stormrider@wintermute:~$ maas admin vmho
```

In the case of our example server, you'd type:

```nohighlight
$ maas admin vmhosts create type=lxd power_address=10.196.199.1:8443 project=keystone name=foo
```

You'd be greeted with a success result that looks something like this:

```nohighlight
Success.
Machine-readable output follows:
{
    "host": {
        "system_id": "hybned",
        "__incomplete__": true
    },
    "storage_pools": [
        {
            "id": "default",
            "name": "default",
            "type": "dir",
            "path": "/var/snap/lxd/common/lxd/storage-pools/default",
            "total": 248618848256,
            "used": 0,
            "available": 248618848256,
            "default": true
        },
        {
            "id": "default2",
            "name": "default2",
            "type": "dir",
            "path": "/var/snap/lxd/common/lxd/storage-pools/default2",
            "total": 248618848256,
            "used": 0,
            "available": 248618848256,
            "default": false
        }
    ],
    "type": "lxd",
    "used": {
        "cores": 0,
        "memory": 0,
        "local_storage": 0
    },
    "zone": {
        "name": "default",
        "description": "",
        "id": 1,
        "resource_uri": "/MAAS/api/2.0/zones/default/"
    },
    "total": {
        "cores": 0,
        "memory": 0,
        "local_storage": 497237696512
    },
    "tags": [
        "pod-console-logging"
    ],
    "architectures": [
        "amd64/generic"
    ],
    "available": {
        "cores": 0,
        "memory": 0,
        "local_storage": 497237696512
    },
    "pool": {
        "name": "default",
        "description": "Default pool",
        "id": 0,
        "resource_uri": "/MAAS/api/2.0/resourcepool/0/"
    },
    "default_macvlan_mode": null,
    "name": "foo",
    "version": "4.13",
    "id": 26,
    "memory_over_commit_ratio": 1.0,
    "cpu_over_commit_ratio": 1.0,
    "capabilities": [
        "composable",
        "dynamic_local_storage",
        "over_commit",
        "storage_pools"
    ],
    "resource_uri": "/MAAS/api/2.0/vm-hosts/26/"
}
```

Note that we specified the project `keystone` as part of this creation step.  We can now check the LXD project list and see if we did, in fact, create that project:

```nohighlight
$ lxc project list
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
|        NAME         | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default             | YES    | YES      | YES             | YES      | Default LXD project     | 5       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| keystone            | NO     | YES      | NO              | NO       | Project managed by MAAS | 1       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| maas_vm_host_001    | YES    | YES      | YES             | NO       |                         | 1       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| new_project         | NO     | YES      | NO              | NO       | Project managed by MAAS | 1       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| not-maas (current)  | YES    | YES      | YES             | NO       |                         | 3       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

Finally, we can switch to the project to get a detailed look:

```nohighlight
$ lxc project switch keystone
$ lxc list
+------+-------+------+------+------+-----------+
| NAME | STATE | IPV4 | IPV6 | TYPE | SNAPSHOTS |
+------+-------+------+------+------+-----------+
```

You'll note that, since we just created the VM host, without adding any VMs, the `keystone` project will be empty.

<a href="#heading--projects-s2-create-vm-in-vm-host-project"><h3 id="heading--projects-s2-create-vm-in-vm-host-project">How to create a new VM in the LXD project associated with a VM host</h3></a>

Let's say that you have created your VM host (called `foo`, in this case) with a new, empty project called `keystone`.  Now you want to create (that is, compose) a VM is this project.  You can accomplish this with a command similar to the following:

```nohighlight
maas admin vmhost compose 26
```

The VM host ID is found from the `resource_uri` line of the JSON output that was returned when you created the VM host; in this case, that line looks like this, yielding the ID number `26`:

```nohighlight
    "resource_uri": "/MAAS/api/2.0/vm-hosts/26/"
```

MAAS will create (compose) the VM and immediately commission it.  You can see this by executing the following command:

```nohighlight
maas admin machines read wx8xcr | grep status_name
```

In this example, we're using the system ID returned as the `resource_uri` of the composed VM that was returned in the JSON from the `maas admin vmhost compose` command above.  We recieve output similar to the following:

```nohighlight
    "network_test_status_name": "Unknown",
    "testing_status_name": "Passed",
    "status_name": "Ready",
    "commissioning_status_name": "Passed",
    "other_test_status_name": "Unknown",
    "storage_test_status_name": "Passed",
    "interface_test_status_name": "Unknown",
    "cpu_test_status_name": "Unknown",
    "memory_test_status_name": "Unknown",
```

You can see by the several status messages that this machine was successfully commissioned, sitting now in the ready state.

So from this experiment, we can see that creating (composing) a VM in a VM host causes MAAS to automatically commission the VM.

<a href="#heading--projects-s2-move-vm-into-vm-host-project"><h3 id="heading--projects-s2-move-vm-into-vm-host-project">How to move an existing VM into the LXD project associated with a VM host</h3></a>

We've seen what happens if we compose a VM in a VM host -- it's automatically commissioned.  But what if we move an existing VM into a LXD project that's associated with a MAAS VM host?  Let's try it and see.

First, let's check on an existing VM in one of our other projects:

```nohighlight
$ lxc project switch not-maas
$ lxc list
+-----------------+---------+------+------+-----------------+-----------+
|      NAME       |  STATE  | IPV4 | IPV6 |      TYPE       | SNAPSHOTS |
+-----------------+---------+------+------+-----------------+-----------+
| trusty-drake    | STOPPED |      |      | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+------+-----------------+-----------+
| upward-stallion | STOPPED |      |      | CONTAINER       | 0         |
+-----------------+---------+------+------+-----------------+-----------+
$ lxc move trusty-drake trusty-drake --project not-maas --target-project keystone
$ lxc project switch keystone
$ lxc list
+--------------+---------+------+------+-----------------+-----------+
|     NAME     |  STATE  | IPV4 | IPV6 |      TYPE       | SNAPSHOTS |
+--------------+---------+------+------+-----------------+-----------+
| handy-sloth  | STOPPED |      |      | VIRTUAL-MACHINE | 0         |
+--------------+---------+------+------+-----------------+-----------+
| trusty-drake | STOPPED |      |      | VIRTUAL-MACHINE | 0         |
+--------------+---------+------+------+-----------------+-----------+
```

We can check the status with MAAS, but we'll find that the machine isn't recognized.  If we turn it on, it will be enlisted by MAAS.  Since MAAS doesn't know about it yet, we need to turn it on with the following command:

```nohighlight
lxc start trusty-drake
```

Nothing happens for a while, but eventually MAAS will discover the machine and attempt to commission it.  In fact, since MAAS doesn't know what power type to use, it completes all the commissioning scripts except `30-maas-01-bmc-config`:

| Name | Tags | Result | Date | Runtime |
|:-----|:----:|:------:|:-----|--------:|
| 20-maas-01-install-lldpd |	node|	Passed|	Mon, 19 Apr. 2021 21:42:22|	0:00:00|
| 20-maas-02-dhcp-unconfigured-ifaces|	node|	Passed|	Mon, 19 Apr. 2021 21:42:22|	0:00:00|
| 30-maas-01-bmc-config|	bmc-config, node|	Skipped|	Mon, 19 Apr. 2021 21:42:22|	0:00:00|
50-maas-01-commissioning| 	node|	Passed|	Mon, 19 Apr. 2021 21:42:23|	0:00:00|
maas-capture-lldpd| 	node|	Passed|	Mon, 19 Apr. 2021 21:43:17|	0:00:53|
maas-get-fruid-api-data| 	node|	Passed|	Mon, 19 Apr. 2021 21:42:26|	0:00:00|
maas-kernel-cmdline| 	node|	Passed|	Mon, 19 Apr. 2021 21:42:25|	0:00:01|
maas-list-modaliases| 	node|	Passed|	Mon, 19 Apr. 2021 21:42:25|	0:00:00|
maas-lshw| 	node|	Passed|	Mon, 19 Apr. 2021 21:42:26|	0:00:02|
maas-serial-ports| 	node|	Passed|	Mon, 19 Apr. 2021 21:42:24|	0:00:00|
maas-support-info| 	node|	Passed|	Mon, 19 Apr. 2021 21:42:25|	0:00:01|

This machine will sit in the "New" state until you assign it a power type, and enter the correct power parameters.

For example, to get this new (moved) VM ready to be fully commissioned, you'll need to first find it in the machine list:

```nohighlight
maas admin machines read
(lots of JSON output, down to the last line)
  "resource_uri": "/MAAS/api/2.0/machines/r3mmsh/"
'''

<a href="#heading--projects-s2-delete-vm-host"><h3 id="heading--projects-s2-delete-vm-host">How to delete the VM host</h3></a>

At some point, you may want to delete your MAAS VM host.  You can do so in the following way:

<a href="#heading--projects-s2-move-non-maas-items"><h3 id="heading--projects-s2-move-non-maas-items">How to move LXD entities to another project to hide them from MAAS</h3></a>

Suppose that want to use MAAS with your default LXD project, and that you have a couple of LXD entities in your default project that you don't want to use with MAAS:

```nohighlight
$ lxc list
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
|      NAME       |  STATE  |         IPV4          |                    IPV6                     |      TYPE       | SNAPSHOTS |
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
| trusty-drake    | STOPPED |                       |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
| upward-stallion | RUNNING | 10.196.199.194 (eth0) | fd42:ec:5a53:59d2:216:3eff:febf:7fa7 (eth0) | CONTAINER       | 0         |
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
| witty-lizard    | STOPPED |                       |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
```

In the above example, you want to use `witty-lizard` with MAAS, but you want to move the other two entities to a project called `not-maas`.  To accomplish this, you first need to create the `not-maas` project if it doesn't exist:

```nohighlight
$ lxc project create not-maas
Project not-maas created
$ lxc project list
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
|        NAME         | IMAGES | PROFILES | STORAGE VOLUMES | NETWORKS |       DESCRIPTION       | USED BY |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| default (current)   | YES    | YES      | YES             | YES      | Default LXD project     | 7       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| maas_vm_host_001    | YES    | YES      | YES             | NO       |                         | 1       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| not-maas            | YES    | YES      | YES             | NO       |                         | 1       |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
| pg-basebackup-tests | NO     | YES      | NO              | NO       | Project managed by MAAS | 16      |
+---------------------+--------+----------+-----------------+----------+-------------------------+---------+
```

Having done so, you now want to move `trusty-drake` and `upward-stallion` to a new project.  Let's tackle `trusty-drake` first:

```nohighlight
$ lxc move trusty-drake trusty-drake --project default --target-project not-maas --verbose
$ lxc list
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
|      NAME       |  STATE  |         IPV4          |                    IPV6                     |      TYPE       | SNAPSHOTS |
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
| upward-stallion | RUNNING | 10.196.199.194 (eth0) | fd42:ec:5a53:59d2:216:3eff:febf:7fa7 (eth0) | CONTAINER       | 0         |
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
| witty-lizard    | STOPPED |                       |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
$ lxc project switch not-maas
$ lxc list
+--------------+---------+------+------+-----------------+-----------+
|     NAME     |  STATE  | IPV4 | IPV6 |      TYPE       | SNAPSHOTS |
+--------------+---------+------+------+-----------------+-----------+
| trusty-drake | STOPPED |      |      | VIRTUAL-MACHINE | 0         |
+--------------+---------+------+------+-----------------+-----------+
```

It's important to note that the `move` step may take 30 seconds or more; that's normal.

Next, let's try moving `upward-stallion`, which is a running container:

```nohighlight
$ lxc move upward-stallion upward-stallion --project default --target-project not-maas --verbose
Error: Failed creating instance record: Failed initialising instance: Invalid devices: Failed detecting root disk device: No root device could be found
$ lxc list
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
|      NAME       |  STATE  |         IPV4          |                    IPV6                     |      TYPE       | SNAPSHOTS |
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
| upward-stallion | RUNNING | 10.196.199.216 (eth0) | fd42:ec:5a53:59d2:216:3eff:fe64:a206 (eth0) | CONTAINER       | 0         |
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
| witty-lizard    | STOPPED |                       |                                             | VIRTUAL-MACHINE | 0         |
+-----------------+---------+-----------------------+---------------------------------------------+-----------------+-----------+
```

Hmm, what's that error message about?  Well, you actually need to add the default storage pool to the mix, with this command:

```nohighlight
lxc profile device add default root disk path=/ pool=default
```

Having done so, you can try the move again:

```nohighlight
$ lxc move upward-stallion upward-stallion --project default --target-project not-maas --verbose
$ lxc list                            
+--------------+---------+------+------+-----------------+-----------+
|     NAME     |  STATE  | IPV4 | IPV6 |      TYPE       | SNAPSHOTS |
+--------------+---------+------+------+-----------------+-----------+
| witty-lizard | STOPPED |      |      | VIRTUAL-MACHINE | 0         |
+--------------+---------+------+------+-----------------+-----------+
$ lxc project switch not-maas
$ lxc list
+-----------------+---------+------+------+-----------------+-----------+
|      NAME       |  STATE  | IPV4 | IPV6 |      TYPE       | SNAPSHOTS |
+-----------------+---------+------+------+-----------------+-----------+
| trusty-drake    | STOPPED |      |      | VIRTUAL-MACHINE | 0         |
+-----------------+---------+------+------+-----------------+-----------+
| upward-stallion | STOPPED |      |      | CONTAINER       | 0         |
+-----------------+---------+------+------+-----------------+-----------+
```

The move succeeds this time -- with an important distinction: the compartment `upward-stallion` was `STOPPED` by `lxc` during the move.  This is an important planning consideration when you're trying to create MAAS VMs & VM hosts in an already-active LXD instantiation. 
