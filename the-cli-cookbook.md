The following recipes may help you make better use of the [MAAS CLI](/t/maas-cli/802).  Each recipe includes the relevant CLI command sequence, with the results processed through `jq` and other relevant command-line utilities to produce cleaner output.  Understand that this material isn't meant to replace the CLI, just to give you some hints about using it.

#### Catalogue of recipes:

* [Basic machine list](/t/the-cli-cookbook/2218#heading--basic-machine-list)
  * [sorted by machine name](/t/the-cli-cookbook/2218#heading--sorted-by-machine-name)
  * [sorted by system ID](/t/the-cli-cookbook/2218#heading--sorted-by-system-id)
  * [sorted by power state](/t/the-cli-cookbook/2218#heading--sorted-by-power-state)
  * [sorted by machine status](/t/the-cli-cookbook/2218#heading--sorted-by-machine-status)
  * [sorted by first tag](/t/the-cli-cookbook/2218#heading--sorted-by-first-tag)
  * [sorted by pool](/t/the-cli-cookbook/2218#heading--sorted-by-pool)
  * [sorted by VLAN](/t/the-cli-cookbook/2218#heading--sorted-by-vlan)
  * [sorted by fabric](/t/the-cli-cookbook/2218#heading--sorted-by-fabric)
  * [sorted by subnet](/t/the-cli-cookbook/2218#heading--sorted-by-subnet)
* [Make machines](/t/the-cli-cookbook/2218#heading--make-machines)
* [VM host list](/t/the-cli-cookbook/2218#heading--vm-host-list)
* [Creating KVMs & getting feedback](/t/the-cli-cookbook/2218#heading--create-kvm)

<h2 id="heading--basic-machine-list">Basic machine list</h2>

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t
```

<h3 id="heading--sorted-by-machine-name">Machine list sorted by machine name</h3>

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t \
| sort -k 1
```

<h3 id="heading--sorted-by-system-id">Machine list sorted by system ID</h3>

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t \
| sort -k 1
```

<h3 id="heading--sorted-by-power-state">Machine list sorted by power state</h3>

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t \
| sort -k 1
```

<h3 id="heading--sorted-by-machine-status">Machine list sorted by machine status</h3>

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t \
| sort -k 1
```

<h3 id="heading--sorted-by-first-tag">Machine list sorted by first tag</h3>

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t \
| sort -k 1
```

<h3 id="heading--sorted-by-pool">Machine list sorted by pool</h3>

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t \
| sort -k 1
```

<h3 id="heading--sorted-by-vlan">Machine list sorted by VLAN</h3>

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t \
| sort -k 1
```

<h3 id="heading--sorted-by-fabric">Machine list sorted by fabric</h3>

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t \
| sort -k 1
```

<h3 id="heading--sorted-by-subnet">Machine list sorted by subnet</h3>

```
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t \
| sort -k 1
```

<h2 id="heading--vm-host-list">List of VM hosts</h2>

```
maas admin vm-hosts read | jq -r '(["ID","VM-HOST","SYSID","CORES","USED","RAM",
"USED","STORAGE", "USED"] | (., map(length*"-"))), (.[]| [.id,.name,.host.system_id,
.total.cores, .used.cores, .total.memory, .used.memory,.total.local_storage,
.used.local_storage]) | @tsv' | column -t
```

<h2 id="heading--create-kvm">Creating a KVM with confirmation</h2>

Note that most of these can be entered directly at the command line using copy/paste -- even the `#!/bin/bash` won't hurt, as it will be ignored by the shell.

[note]
Remember to:
1. login to the MAAS CLI before using these commands.
2. substitute your administrator profile for "admin" if you've assigned a different admin username.
[/note]

<details><summary>Also, be aware of how multiple lines are parsed by the shell:</summary>

* Quoted sections, such as the long command generally following `jq`, need no special accommodations to break lines.  You can break the lines anywhere that's convenient for you, as long as you maintain at least a single space between "words."  

* Any non-quoted section (i.e., part of a shell command) must have a `\` at the end of each line, before a continuation line.

For example, this configuration works fine:

    | jq -r '(["HOSTNAME",
    "SYSID",....
    ....' | column -t

But this one will produce an error:

    | jq
    -r '(["HOSTNAME",....

We've tried to break them so that they fit on an average terminal line, but your mileage may vary.
</details>


<h2>lsmm series: Listing MAAS machines</h2>

The `lsmm` script, defined below, is something we use to quickly get machine information from the command line.  For those of us who prefer the CLI, it's an easy way to gather the same information you'd get in the web UI machine list, but more focused in each option.

<h3 id="heading--lsmm">lsmm: List MAAS machines</h3>

This recipe prints a basic machine list.  Here's the command to paste into the command line:

    maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
    "OWNER", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
    (.[] | [.hostname, .system_id, .power_state, .status_name, .owner, .pool.name,
    .boot_interface.vlan.name, .boot_interface.vlan.fabric,
    .boot_interface.links[0].subnet.name]) | @tsv' | column -t

And here's the command as part of the `lsmm` shellscript:

    #!/bin/bash
    # lsmm - list maas machines
    # make sure to chmod this file so it can execute
    #
    maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
    "OWNER", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
    (.[] | [.hostname, .system_id, .power_state, .status_name, .owner, .pool.name,
    .boot_interface.vlan.name, .boot_interface.vlan.fabric,
    .boot_interface.links[0].subnet.name]) | @tsv' | column -t

If you save this to a file, make sure to `chmod` the file so it will execute.  You might also add it to your path, or perhaps even place it in `/usr/bin` if desired.

<h3 id="heading--lsmm-t">lsmm -t: List MAAS machines with first tag</h3>

It's a good idea to keep your most important machine tag first, as it's the first one you'll see.  It makes scanning your list (UI or CLI/jq) much more efficient.  Here's a recipe that adds the first tag to the console-printed machine list:

    maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
    "OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
    (.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
    .tag_names[0] // "-", .pool.name,
    .boot_interface.vlan.name, .boot_interface.vlan.fabric,
    .boot_interface.links[0].subnet.name]) | @tsv' | column -t

And here's an expanded version of `lsmm` that takes a `-t` options, for "tags:"

    #!/bin/bash
    # lsmm - list maas machines
    # make sure to chmod this file so it can execute
    # and make sure it's in the path (if you're not typing "./")
    #
    if [ -z "$1" ]
       then
    maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
    "OWNER", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
    (.[] | [.hostname, .system_id, .power_state, .status_name, .owner, .pool.name,
    .boot_interface.vlan.name, .boot_interface.vlan.fabric,
    .boot_interface.links[0].subnet.name]) | @tsv' | column -t
    fi

    if [ "$1" == "-t" ]
       then
    maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
    "OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
    (.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
    .tag_names[0] // "-", .pool.name,
    .boot_interface.vlan.name, .boot_interface.vlan.fabric,
    .boot_interface.links[0].subnet.name]) | @tsv' | column -t
    fi

Note that with no option (e.g., just `lsmm` on the command line), this script will print the basic machine list from the previous recipe.

<h3 id="heading--lsmm-vmh">lsmm --vmhost: List VM hosts</h3>

Here's a recipe that gives a quick overview of your existing VM hosts:

    maas admin vm-hosts read | jq -r '(["ID","VM-HOST","SYSID","CORES","USED","RAM",
    "USED","STORAGE", "USED"] | (., map(length*"-"))), (.[]| [.id,.name,.host.system_id,
    .total.cores, .used.cores, .total.memory, .used.memory,.total.local_storage,
    .used.local_storage]) | @tsv' | column -t

And here it is as part of an expanded `lsmm` script, under the new option `-vmh`:

    #!/bin/bash
    # lsmm - list maas machines
    # make sure to chmod this file so it can execute
    # and make sure it's in the path (if you're not typing "./")
    #
    if [ -z "$1" ]
       then
    maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
    "OWNER", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
    (.[] | [.hostname, .system_id, .power_state, .status_name, .owner, .pool.name,
    .boot_interface.vlan.name, .boot_interface.vlan.fabric,
    .boot_interface.links[0].subnet.name]) | @tsv' | column -t
    fi

    if [ "$1" == "-t" ]
       then
    maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
    "OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
    (.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
    .tag_names[0] // "-", .pool.name,
    .boot_interface.vlan.name, .boot_interface.vlan.fabric,
    .boot_interface.links[0].subnet.name]) | @tsv' | column -t
    fi

    if [ "$1" == "--vmhost" ]
       then
    maas admin vm-hosts read | jq -r '(["ID","VM-HOST","SYSID","CORES","USED","RAM",
    "USED","STORAGE", "USED"] | (., map(length*"-"))), (.[]| [.id,.name,.host.system_id,
    .total.cores, .used.cores, .total.memory, .used.memory,.total.local_storage,
    .used.local_storage]) | @tsv' | column -t
    fi

Remember to chmod and path the script so it will run.

<h3 id="heading--lsmm-vmhc">lsmm --vmhost -c: List VM host configurable parameters</h3>

Here's a command line recipe to list the configurable parameters of a specific host:

```
maas admin vm-host read $ID | jq -r '(["ID","NAME","POOL","ZONE",
"CPU-O/C", "RAM-O/C", "TAGS"] | (., map(length*"-"))), (.| [.id,.name,
.pool.name, .zone.name,.cpu_over_commit_ratio, 
.memory_over_commit_ratio, .tags[]]) | @tsv' | column -t
```

where $ID is the VM host ID (not the System ID; run `lsmm --vmhost` if you're not sure).  Here's an updated version of `lsmm` with the `-vmhost -c` options:

```
#!/bin/bash 
# lsmm - list maas machines 
# make sure to chmod this file so it can execute 
# and make sure it's in the path (if you're not typing "./") 
# 
# for the "-vmhost -c" option, don't forget to type $3 as the ID of the VM host 
# 
if [ -z "$1" ] 
   then 
   	maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS", 
	"OWNER", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))), 
	(.[] | [.hostname, .system_id, .power_state, .status_name, .owner, .pool.name, 
	.boot_interface.vlan.name, .boot_interface.vlan.fabric, 
	.boot_interface.links[0].subnet.name]) | @tsv' | column -t 
elif [ "$1" == "-t" ] 
     then 
	maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS", 
	"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))), 
	(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
	.tag_names[0] // "-", .pool.name, 
	.boot_interface.vlan.name, .boot_interface.vlan.fabric, 
	.boot_interface.links[0].subnet.name]) | @tsv' | column -t 
elif [ "$1" == "--vmhost" -a -z "$2" ]
     then 
	maas admin vm-hosts read | jq -r '(["ID","VM-HOST","SYSID","CORES","USED","RAM", 
	"USED","STORAGE", "USED"] | (., map(length*"-"))), (.[]| [.id,.name,.host.system_id, 
	.total.cores, .used.cores, .total.memory, .used.memory,.total.local_storage, 
	.used.local_storage]) | @tsv' | column -t 
elif [ "$1" == "--vmhost" -a "$2" == "-c" ]
     then 
	maas admin vm-host read $3 | jq -r '(["ID","NAME","POOL","ZONE", 
	"CPU-O/C", "RAM-O/C", "TAGS"] | (., map(length*"-"))), (.| [.id,.name, 
	.pool.name, .zone.name,.cpu_over_commit_ratio, 
	.memory_over_commit_ratio, .tags[]]) | @tsv' | column -t
fi 
```

Don't forget to invoke this script with two parameters, like this:

```
lsmm --vmhost -c $ID
```

So if your desired VM host is ID 4, you'd type:

```
lsmm --vmhost -c 4
```

<h2>Recipes for creating MAAS machines</h2>

The following scripts walk you through creating MAAS machines of various types.  In these simple recipes, there's **no validation** of input, so use at your own risk -- although it would be trivial to add validation for your favourite machine types.

<h3 id="heading--make-machines">Make a libvirt VM</h3>

This very basic recipe creates a libvirt virtual machine.  The parameters can be entered interactively (`<scriptname> --kvm -i`) or in "batch" mode (for scripting commands in a batch shellscript) by using `<scriptname> --kvm -b`, where <scriptname> is up to you:

```
#!/bin/bash
#
# MAAS CLI make machines recipe
#  --kvm = create a libvirt KVM
#
# -i = interactive mode
# -b = batch mode

if [ "$1" == "--kvm" -a "$2" == "-i" ]
   then
	read -p "architecture? " arch
	read -p "MAC address? " macaddr
	read -p "power ID? " powerid
	read -p "power address? " poweraddr
	read -p "power password? " powerpw
	maas admin machines create \
	architecture=$arch \
	mac_addresses=$macaddr \
	power_type=virsh \
	power_parameters_power_id=$powerid \
	power_parameters_power_address=$poweraddr \
	power_parameters_power_pass=$powerpw
elif [ "$1" == "--kvm" -a "$2" == "-b" ]
	then
	maas admin machines create \
	architecture=$3 \
	mac_addresses=$4 \
	power_type=virsh \
	power_parameters_power_id=$5 \
	power_parameters_power_address=$6 \
	power_parameters_power_pass=$7
fi
```

In interactive mode, the script prompts you for all needed parameters; note that the power type isn't needed, because it's "virsh" in this case.  Interactive mode looks like this:

```
stormrider@wintermute:tmp$ foo --kvm -i
architecture? amd64
MAC address? 52:54:00:1e:a5:7e
power ID? e9f84356-5106-40ee-9088-3e35ec7d50cf
power address? qemu+ssh://stormrider@192.168.123.1/system
power password? xxxxxxx
```

If you prefer to batch your machine creation in shellscripts, you can use the `-b` option instead, like this:

```
#!/bin/bash
foo --kvm -b amd64 52:54:00:1e:a5:7e e9f84356-5106-40ee-9088-3e35ec7d50cf qemu+ssh://stormrider@192.168.123.1/system xxxxxxx
```

This mode allows you to add a number of lines to a longer shellscript, facilitating automatic creation or even the use of a makefile (if you're creative).