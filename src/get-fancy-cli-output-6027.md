<!-- "Get fancy CLI output" -->
The JSON output from the MAAS CLI can be very lengthy for even one machine. You can imagine how large a listing 10 or 12 or 600 machines might present. Traditional JSON output is both consistent and comprehensive, but it's sometimes hard for humans to process.

Enter `jq`, a command-line tool dedicated to filtering and formatting JSON output, so that you can more easily summarise data. For instance, consider a small MAAS install with 12 virtual machines. Six of these machines are LXD VMs, and six are libvirt VMs. Suppose we enter the MAAS command to list all those machines:

```nohighlight
maas admin machines read
```

The listing would be many pages long, and likely very time-consuming to pick through, so we'll just skip it here. On the other hand, I can apply the jq command, a couple of other Ubuntu CLI commands, and just a little bit of finesse to get something more useful:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID",
"POWER","STATUS","OWNER", "TAGS", "POOL","VLAN","FABRIC",
"SUBNET"] | (., map(length*"-"))),(.[] | [.hostname, .system_id, 
.power_state, .status_name, .owner // "-",.tag_names[0] // "-", 
.pool.name,.boot_interface.vlan.name,.boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t
```

In fact, with this command, we can produce an useful and compact machine listing that serves about 99% of our routine MAAS information needs:

```nohighlight
HOSTNAME      SYSID   POWER  STATUS     OWNER  TAGS                 POOL     VLAN      FABRIC    SUBNET
 --------      -----   -----  ------     -----  ----                 ----     ----      ------    ------
 lxd-vm-1      r8d6yp  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 lxd-vm-2      tfftrx  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 lxd-vm-3      grwpwc  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 lxd-vm-4      6s8dt4  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 lxd-vm-5      pyebgm  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 lxd-vm-6      ebnww6  off    New        -      pod-console-logging  default  untagged  fabric-1  
 libvirt-vm-1  m7ffsg  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 libvirt-vm-2  kpawad  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 libvirt-vm-3  r44hr6  error  Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 libvirt-vm-4  s3sdkw  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 libvirt-vm-5  48dg8m  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
 libvirt-vm-6  bacx77  on     Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
```

Here we have a clean text table listing the machine hostnames, along with the system IDs, power states, machines statuses, tags, pools, and networking information. These parameters represent only a small fraction of the available JSON output, of course. Let's break this command down, piece by piece, and see how it works.

<a href="#heading--Basic-jq-usage"><h2 id="heading--Basic-jq-usage">Basic jq usage</h2></a>

First, we'll just pull the hostnames from these machines, with no qualifiers or formatting rules, like this:


```nohighlight
maas admin machines read | jq '(.[] | [.hostname])'
```

This command returns output that looks something like this:

```nohighlight
[
  "lxd-vm-1"
]
[
  "lxd-vm-2"
]
[
  "lxd-vm-3"
]
[
  "lxd-vm-4"
]
[
  "lxd-vm-5"
]
[
  "lxd-vm-6"
]
[
  "libvirt-vm-1"
]
[
  "libvirt-vm-2"
]
[
  "libvirt-vm-3"
]
[
  "libvirt-vm-4"
]
[
  "libvirt-vm-5"
]
[
  "libvirt-vm-6"
]
```

Note a couple of things about this command:

```nohighlight
maas admin machines read | jq '(.[] | [.hostname])'
```

First, the `jq` instructions are enclosed in single quotes. As such, they can span lines if necessary, without any line continuations (\), like this:

```nohighlight
maas admin machines read | jq '(.[]
| [.hostname])'
```

Second, notice the structure of the jq instructions. The .[] tells jq that it's decoding an array of data sets — in this case, an array of machine data sets — and that it should iterate through each of the outer data sets (each machine) individually. The pipe symbol (|) completes the “for each” construct, so this command basically says, “for each set of machine data you get, pull out (and return) the value associated with the JSON key hostname". The return value reflects this structure:

```nohighlight

[
   "libvirt-vm-5"
]
[
   "libvirt-vm-6"
]
```

The outer square brackets represent the boundaries of each machine's data set, and the value in quotes corresponds to the value of the key hostname in successive machine data sets. It can get a little complicated sometimes, but that's basically the way to parse JSON with jq.

For practice let's try pulling the value of the key that holds machine status, again with no qualifiers or special formatting:

```nohighlight
maas admin machines read | jq '(.[] | [.hostname, .status_name])'
```

This command essentially tells jq to do the same thing as last time, but also collect the value of the key “status_name” for each machine. The results looks something like this:

```nohighlight

[
  "lxd-vm-1",
  "Deployed"
]
[
  "lxd-vm-2",
  "Allocated"
]
[
  "lxd-vm-3",
  "Ready"
]
[
  "lxd-vm-4",
  "Deployed"
]
[
  "lxd-vm-5",
  "Allocated"
]
[
  "lxd-vm-6",
  "New"
]
[
  "libvirt-vm-1",
  "Ready"
]
[
  "libvirt-vm-2",
  "Ready"
]
[
  "libvirt-vm-3",
  "Ready"
]
[
  "libvirt-vm-4",
  "Ready"
]
[
  "libvirt-vm-5",
  "Ready"
]
[
  "libvirt-vm-6",
  "Deployed"
]
```

So much for printing the values of JSON keys. There are still some nuances (arrays, nested keys, …), but this is the lion's share of the syntax. Let's divert for a minute and look at how to format the output in a more human-readable way.

<a href="#heading--Improved-formatting"><h2 id="heading--Improved-formatting">Improved formatting</h2></a>

Most of the Ubuntu text-processing commands use tabs as field delimiters, which is a trait inherited from grandfather UNIX. Currently, the output is clean, but relatively hard to format into lines. Luckily jq has a filter for this: the “tab-separated values” filter, known as @tsv. This filter transforms the output records into individual lines with values separated by tabs.

Adding @tsv to the mix:

```nohighlight
maas admin machines read | jq '(.[] | [.hostname, .status_name]) | @tsv'
```

we get something like this:

```nohighlight
"lxd-vm-1\tDeployed"
"lxd-vm-2\tAllocated"
"lxd-vm-3\tReady"
"lxd-vm-4\tDeployed"
"lxd-vm-5\tAllocated"
"lxd-vm-6\tNew"
"libvirt-vm-1\tReady"
"libvirt-vm-2\tReady"
"libvirt-vm-3\tReady"
"libvirt-vm-4\tReady"
"libvirt-vm-5\tReady"
"libvirt-vm-6\tDeployed"
```

That's a step in the right direction, but it's still pretty far from human-readable output. If only there were some way to get rid of the quotes and just do the tab, instead of representing it as a regex character. In fact, the jq “raw” output option (-r) takes care of this:

```nohighlight
maas admin machines read | jq -r '(.[] | [.hostname, .status_name]) | @tsv'
```

Feeding the raw output into our three-filter set gives us a more readable result:

```nohighlight
lxd-vm-1	Deployed
lxd-vm-2	Allocated
lxd-vm-3	Ready
lxd-vm-4	Deployed
lxd-vm-5	Allocated
lxd-vm-6	New
libvirt-vm-1	Ready
libvirt-vm-2	Ready
libvirt-vm-3	Ready
libvirt-vm-4	Ready
libvirt-vm-5	Ready
libvirt-vm-6	Deployed
```

This is tabulated, but the number of spaces between the columns is a little big, and, if there's an unusually long value in one of the fields, it may throw the tabulation off for that line. Something could have been added to jq for that, but there is no need, since Ubuntu already has the column utility. Piping the output of the command so far to column -t (-t for “tabs”) will normalise the tab spacing to the data and ensure that each column is exactly long enough for the longest value in that column:

```nohighlight
maas admin machines read | jq -r '(.[] | [.hostname, .status_name]) | @tsv' | column -t
```

This command result is very similar to the previous output, though you'll notice that the field spacing is neatly optimised to the data itself:

```nohighlight
lxd-vm-1      Deployed
lxd-vm-2      Allocated
lxd-vm-3      Ready
lxd-vm-4      Deployed
lxd-vm-5      Allocated
lxd-vm-6      New
libvirt-vm-1  Ready
libvirt-vm-2  Ready
libvirt-vm-3  Ready
libvirt-vm-4  Ready
libvirt-vm-5  Ready
libvirt-vm-6  Deployed
```

<a href="#heading--Making-real-tables"><h2 id="heading--Making-real-tables">Making real tables</h2></a>

So far, so good, but this still isn't a presentable data table. First of all, there are no headings. These can be added by passing a literal row to jq, like this:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","STATUS"]), (.[] | [.hostname, .status_name]) | @tsv' | column -t
```

You'll note that there are two expressions in parenthesis (representing individual lines or rows). The first just contains the two column headings, while the second contains the “for each” construct that pulls the hostname and status out of the JSON. In essence, the first expression evaluates to just one row, since there's nothing to tell it to iterate. The second expression evaluates to one row per machine, since that's the level of data we're reading. Here's what we get from this command:

```nohighlight
HOSTNAME      STATUS
lxd-vm-1      Deployed
lxd-vm-2      Allocated
lxd-vm-3      Ready
lxd-vm-4      Deployed
lxd-vm-5      Allocated
lxd-vm-6      New
libvirt-vm-1  Ready
libvirt-vm-2  Ready
libvirt-vm-3  Ready
libvirt-vm-4  Ready
libvirt-vm-5  Ready
libvirt-vm-6  Deployed
```

Nice, but it needs a horizontal rule, like a line of dashes, to separate the headings from the data. We can do this by essentially turning the one header row into two, using some jq macros to generate dashes lines of appropriate length:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","STATUS"] | 
(.,map(length*"-"))), (.[] | [.hostname, .status_name]) | @tsv' | column -t
```

The expression | (.,) tells jq to convert the foregoing header row into two rows: the first contains the two headers, as in the previous row, and the second contains the result of a couple of macros (map and length). We won't detail those here, but the use of this construct produces the following output:

```nohighlight
HOSTNAME      STATUS
--------      ------
lxd-vm-1      Deployed
lxd-vm-2      Allocated
lxd-vm-3      Ready
lxd-vm-4      Deployed
lxd-vm-5      Allocated
lxd-vm-6      New
libvirt-vm-1  Ready
libvirt-vm-2  Ready
libvirt-vm-3  Ready
libvirt-vm-4  Ready
libvirt-vm-5  Ready
libvirt-vm-6  Deployed
```

<a href="#heading--Extending-the-list"><h2 id="heading--Extending-the-list">Extending the list</h2></a>

Let's add a couple more fields, owner (which is sometimes blank), and system_id (which is never blank), to the output:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","STATUS", "OWNER", "SYSTEM-ID"] 
| (.,map(length*"-"))), (.[] | [.hostname, .status_name,.owner,.system_id]) 
| @tsv' | column -t
```

This gives us the following result:

```nohighlight
HOSTNAME      STATUS     OWNER   SYSTEM-ID
--------      ------     -----   ---------
lxd-vm-1      Deployed   admin   r8d6yp
lxd-vm-2      Allocated  admin   tfftrx
lxd-vm-3      Ready      grwpwc  
lxd-vm-4      Deployed   admin   6s8dt4
lxd-vm-5      Allocated  admin   pyebgm
lxd-vm-6      New        ebnww6  
libvirt-vm-1  Ready      m7ffsg  
libvirt-vm-2  Ready      kpawad  
libvirt-vm-3  Ready      r44hr6  
libvirt-vm-4  Ready      s3sdkw  
libvirt-vm-5  Ready      48dg8m  
libvirt-vm-6  Deployed   admin   bacx77
```

You'll notice right away there's a problem with the columns. Remember that only machines in the “Allocated” or “Deployed” state are owned by anyone, since that's what allocate/acquire means. The lines for the deployed and allocated machines lay out correctly, but the lines for the unowned machines are incorrectly formatted. We can fix this by using the jq “alternate value” construct (a // "b"), which can be loosely read, “if not a, then b.” We add it to the owner key like this:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","STATUS", "OWNER", "SYSTEM-ID"] 
| (.,map(length*"-"))), (.[] | [.hostname, .status_name,.owner // "-",.system_id]) 
| @tsv' | column -t
```

Then the results line up nicely, based on the longest value in each key column:

```nohighlight
HOSTNAME      STATUS     OWNER  SYSTEM-ID
--------      ------     -----  ---------
lxd-vm-1      Deployed   admin  r8d6yp
lxd-vm-2      Allocated  admin  tfftrx
lxd-vm-3      Ready      -      grwpwc
lxd-vm-4      Deployed   admin  6s8dt4
lxd-vm-5      Allocated  admin  pyebgm
lxd-vm-6      New        -      ebnww6
libvirt-vm-1  Ready      -      m7ffsg
libvirt-vm-2  Ready      -      kpawad
libvirt-vm-3  Ready      -      r44hr6
libvirt-vm-4  Ready      -      s3sdkw
libvirt-vm-5  Ready      -      48dg8m
libvirt-vm-6  Deployed   admin  bacx77
```


<a href="#heading--Nested-arrays"><h2 id="heading--Nested-arrays">Nested arrays</h2></a>

Machines have a nested array (of indeterminate length) for machine tags. In JSON terms, instead of having a single key-value pair at the top level, like this:

```nohighlight
"hostname": "libvirt-vm-6",
```

tags are represented by nested arrays, like this:

```nohighlight
"tag_names": [
    "pod-console-logging",
    "virtual"
],
```

Incorporating a random number of tags per machine into a neat table is beyond the scope of this particular post, but we can show the first tag in the table rows:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","STATUS", "OWNER", "SYSTEM-ID",
"FIRST TAG"] | (.,map(length*"-"))), (.[] | [.hostname, .status_name,
.owner // "-",.system_id,.tag_names[0] // "-"]) | @tsv' | column -t
```

Where we would use .json-key-name for a non-nested value, we need only use .json-key-name[0] to refer to the first element of the nested array. Doing this produces the following result:

```nohighlight
HOSTNAME      STATUS     OWNER  SYSTEM-ID  FIRST                TAG
--------      ------     -----  ---------  ---------            
lxd-vm-1      Deployed   admin  r8d6yp     pod-console-logging  
lxd-vm-2      Allocated  admin  tfftrx     pod-console-logging  
lxd-vm-3      Ready      -      grwpwc     pod-console-logging  
lxd-vm-4      Deployed   admin  6s8dt4     pod-console-logging  
lxd-vm-5      Allocated  admin  pyebgm     pod-console-logging  
lxd-vm-6      New        -      ebnww6     pod-console-logging  
libvirt-vm-1  Ready      -      m7ffsg     pod-console-logging  
libvirt-vm-2  Ready      -      kpawad     pod-console-logging  
libvirt-vm-3  Ready      -      r44hr6     pod-console-logging  
libvirt-vm-4  Ready      -      s3sdkw     pod-console-logging  
libvirt-vm-5  Ready      -      48dg8m     pod-console-logging  
libvirt-vm-6  Deployed   admin  bacx77     pod-console-logging
```

That's almost right, but notice that the heading separates on spaces between words. Let's try a better way, with an underscore:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","STATUS", "OWNER", "SYSTEM-ID",
"FIRST_TAG"] | (.,map(length*"-"))), (.[] | [.hostname, .status_name,
.owner // "-",.system_id,.tag_names[0] // "-"]) | @tsv' | column -t
```

This version of the command produces the expected output:

```nohighlight
HOSTNAME      STATUS     OWNER  SYSTEM-ID  FIRST_TAG
--------      ------     -----  ---------  ---------
lxd-vm-1      Deployed   admin  r8d6yp     pod-console-logging
lxd-vm-2      Allocated  admin  tfftrx     pod-console-logging
lxd-vm-3      Ready      -      grwpwc     pod-console-logging
lxd-vm-4      Deployed   admin  6s8dt4     pod-console-logging
lxd-vm-5      Allocated  admin  pyebgm     pod-console-logging
lxd-vm-6      New        -      ebnww6     pod-console-logging
libvirt-vm-1  Ready      -      m7ffsg     pod-console-logging
libvirt-vm-2  Ready      -      kpawad     pod-console-logging
libvirt-vm-3  Ready      -      r44hr6     pod-console-logging
libvirt-vm-4  Ready      -      s3sdkw     pod-console-logging
libvirt-vm-5  Ready      -      48dg8m     pod-console-logging
libvirt-vm-6  Deployed   admin  bacx77     pod-console-logging
```

<a href="#heading--Nested-keys"><h2 id="heading--Nested-keys">Nested keys</h2></a>

These aren't all the routine key-value pairs we want in the table, though. It would also be nice to print the pool to which each machine is assigned. Just asking for .pool as a single key-value pair:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","STATUS", "OWNER", "SYSTEM-ID",
"FIRST_TAG","POOL"] | (.,map(length*"-"))), (.[] | [.hostname, .status_name,
.owner // "-",.system_id,.tag_names[0] // "-", .pool]) | @tsv' | column -t
```

produces an error:

```nohighlight
jq: error (at &lt;stdin&gt;:5639): object ({"name":"de...") is not valid in a csv row
```

Looking at the JSON output, we see that .pool is a nested key, not a key-value pair:

```nohighlight
"pool": {
    "name": "default",
    "description": "Default pool",
    "id": 0,
    "resource_uri": "/MAAS/api/2.0/resourcepool/0/"
},
```

What we really want is the pool name, so we need to add one level of indirection to that particular key to reach the actual key-value pair, like this:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","STATUS", "OWNER", "SYSTEM-ID",
"FIRST_TAG","POOL"] | (.,map(length*"-"))), (.[] | [.hostname, .status_name,
.owner // "-",.system_id,.tag_names[0] // "-", .pool.name]) | @tsv' | column -t
```

which gives us what we want:

```nohighlight
HOSTNAME      STATUS     OWNER  SYSTEM-ID  FIRST_TAG            POOL
--------      ------     -----  ---------  ---------            ----
lxd-vm-1      Deployed   admin  r8d6yp     pod-console-logging  default
lxd-vm-2      Allocated  admin  tfftrx     pod-console-logging  default
lxd-vm-3      Ready      -      grwpwc     pod-console-logging  default
lxd-vm-4      Deployed   admin  6s8dt4     pod-console-logging  default
lxd-vm-5      Allocated  admin  pyebgm     pod-console-logging  default
lxd-vm-6      New        -      ebnww6     pod-console-logging  default
libvirt-vm-1  Ready      -      m7ffsg     pod-console-logging  default
libvirt-vm-2  Ready      -      kpawad     pod-console-logging  default
libvirt-vm-3  Ready      -      r44hr6     pod-console-logging  default
libvirt-vm-4  Ready      -      s3sdkw     pod-console-logging  default
libvirt-vm-5  Ready      -      48dg8m     pod-console-logging  default
libvirt-vm-6  Deployed   admin  bacx77     pod-console-logging  default
```

It's also useful to list the VLAN and fabric names in the output table. Looking at the JSON again, these values present like this:

```nohighlight
"boot_interface": {
	    "vlan": {
		"vid": 0,
		"mtu": 1500,
		"dhcp_on": true,
		"external_dhcp": null,
		"relay_vlan": null,
		"secondary_rack": null,
		"name": "untagged",
		"id": 5001,
		"fabric_id": 1,
		"space": "undefined",
		"fabric": "fabric-1",
		"primary_rack": "wnmkpn",
		"resource_uri": "/MAAS/api/2.0/vlans/5001/"
	     },
```

This means they are doubly-nested. No problem; just use double indirection (two levels of . separators) to retrieve them:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS","OWNER", 
"TAGS", "POOL", "VLAN","FABRIC"] | (., map(length*"-"))), (.[] | [.hostname, 
.system_id, .power_state, .status_name, .owner // "-", .tag_names[0] // "-", 
.pool.name, .boot_interface.vlan.name, .boot_interface.vlan.fabric]) 
| @tsv' | column -t
```

The modified command yields the desired results:

```nohighlight
HOSTNAME      SYSID   POWER  STATUS     OWNER  TAGS                 POOL     VLAN      FABRIC
--------      -----   -----  ------     -----  ----                 ----     ----      ------
lxd-vm-1      r8d6yp  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1
lxd-vm-2      tfftrx  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1
lxd-vm-3      grwpwc  off    Ready      -      pod-console-logging  default  untagged  fabric-1
lxd-vm-4      6s8dt4  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1
lxd-vm-5      pyebgm  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1
lxd-vm-6      ebnww6  off    New        -      pod-console-logging  default  untagged  fabric-1
libvirt-vm-1  m7ffsg  off    Ready      -      pod-console-logging  default  untagged  fabric-1
libvirt-vm-2  kpawad  off    Ready      -      pod-console-logging  default  untagged  fabric-1
libvirt-vm-3  r44hr6  error  Ready      -      pod-console-logging  default  untagged  fabric-1
libvirt-vm-4  s3sdkw  off    Ready      -      pod-console-logging  default  untagged  fabric-1
libvirt-vm-5  48dg8m  off    Ready      -      pod-console-logging  default  untagged  fabric-1
libvirt-vm-6  bacx77  on     Deployed   admin  pod-console-logging  default  untagged  fabric-1
```

There's just one more (deeply nested) value we want to retrieve, and that's the fully-qualified subnet address in CIDR form. That's a little trickier, because it's buried in JSON like this:

```nohighlight
"boot_interface": {
     "vlan": {
	 "vid": 0,
	 "mtu": 1500,
	 "dhcp_on": true,
	 ...
	 "resource_uri": "/MAAS/api/2.0/vlans/5001/"
     },
     "parents": [],
     "product": null,
     ...
     "link_connected": true,
     "type": "physical",
     "links": [
	 {
	     "id": 79,
	     "mode": "auto",
	     "ip_address": "10.124.141.4",
	     "subnet": {
		 "name": "10.124.141.0/24",
```

So the value we want is in the nested key boot_interface, in a nested array links[], which contains the doubly-nested key subnet.name. We can finish our basic CLI machine list — the one we started with — by adding this complex formulation to the command:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS",
"OWNER", "TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),
(.[] | [.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name,
.boot_interface.vlan.name, .boot_interface.vlan.fabric,
.boot_interface.links[0].subnet.name]) | @tsv' | column -t
```

Sure enough, this command gives us the same table we had at the beginning of this post:

```nohighlight
HOSTNAME      SYSID   POWER  STATUS     OWNER  TAGS                 POOL     VLAN      FABRIC    SUBNET
--------      -----   -----  ------     -----  ----                 ----     ----      ------    ------
lxd-vm-1      r8d6yp  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-2      tfftrx  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-3      grwpwc  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-4      6s8dt4  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-5      pyebgm  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-6      ebnww6  off    New        -      pod-console-logging  default  untagged  fabric-1  
libvirt-vm-1  m7ffsg  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-2  kpawad  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-3  r44hr6  error  Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-4  s3sdkw  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-5  48dg8m  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-6  bacx77  on     Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
```

<a href="#heading--Chaining-Ubuntu-CLI-commands"><h2 id="heading--Chaining-Ubuntu-CLI-commands">Chaining Ubuntu CLI commands</h2></a>

Although the machine list above looks fairly neat, it's actually not sorted by hostname, exactly. To accomplish this, we'd need to add a couple of Ubuntu CLI commands to the mix. Sorting on hostname means we want to sort on field 1 of the current command's output. We can try just feeding that to sort like this:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS", "OWNER", 
"TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))), (.[] | 
[.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name, .boot_interface.vlan.name, 
.boot_interface.vlan.fabric, .boot_interface.links[0].subnet.name]) 
| @tsv' | column -t | sort -k 1
```

This command does indeed sort by hostname:


```nohighlight
--------      -----   -----  ------     -----  ----                 ----     ----      ------    ------
HOSTNAME      SYSID   POWER  STATUS     OWNER  TAGS                 POOL     VLAN      FABRIC    SUBNET
libvirt-vm-1  m7ffsg  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-2  kpawad  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-3  r44hr6  error  Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-4  s3sdkw  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-5  48dg8m  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-6  bacx77  on     Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-1      r8d6yp  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-2      tfftrx  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-3      grwpwc  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-4      6s8dt4  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-5      pyebgm  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-6      ebnww6  off    New        -      pod-console-logging  default  untagged  fabric-1
```

but it has the unintended side-effect of sorting the header lines into the output. There are probably at least a dozen Ubuntu CLI solutions for this, so we'll just pick one of the most elegant here, using awk:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS","OWNER", 
"TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),(.[] | 
[.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name, .boot_interface.vlan.name, 
.boot_interface.vlan.fabric,.boot_interface.links[0].subnet.name]) 
| @tsv' | column -t | awk 'NR&lt;3{print $0;next}{print $0| "sort -k 1"}'
```

This command gives us the desired output:

```nohighlight
HOSTNAME      SYSID   POWER  STATUS     OWNER  TAGS                 POOL     VLAN      FABRIC    SUBNET
--------      -----   -----  ------     -----  ----                 ----     ----      ------    ------
libvirt-vm-1  m7ffsg  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-2  kpawad  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-3  r44hr6  error  Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-4  s3sdkw  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-5  48dg8m  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-6  bacx77  on     Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-1      r8d6yp  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-2      tfftrx  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-3      grwpwc  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-4      6s8dt4  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-5      pyebgm  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-6      ebnww6  off    New        -      pod-console-logging  default  untagged  fabric-1
```

Note that by changing the numerical “-k” argument to “sort,” you can change which field controls the sort:

```nohighlight
maas admin machines read | jq -r '(["HOSTNAME","SYSID","POWER","STATUS","OWNER", 
"TAGS", "POOL", "VLAN","FABRIC","SUBNET"] | (., map(length*"-"))),(.[] | 
[.hostname, .system_id, .power_state, .status_name, .owner // "-", 
.tag_names[0] // "-", .pool.name, .boot_interface.vlan.name, 
.boot_interface.vlan.fabric,.boot_interface.links[0].subnet.name]) 
| @tsv' | column -t | awk 'NR&lt;3{print $0;next}{print $0| "sort -k 4"}'
```

This command sorts by machine state, which is the fourth field:

```nohighlight
HOSTNAME      SYSID   POWER  STATUS     OWNER  TAGS                 POOL     VLAN      FABRIC    SUBNET
--------      -----   -----  ------     -----  ----                 ----     ----      ------    ------
lxd-vm-2      tfftrx  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-5      pyebgm  off    Allocated  admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-6  bacx77  on     Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-1      r8d6yp  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-4      6s8dt4  off    Deployed   admin  pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-6      ebnww6  off    New        -      pod-console-logging  default  untagged  fabric-1  
libvirt-vm-1  m7ffsg  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-2  kpawad  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-4  s3sdkw  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-5  48dg8m  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
lxd-vm-3      grwpwc  off    Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
libvirt-vm-3  r44hr6  error  Ready      -      pod-console-logging  default  untagged  fabric-1  10.124.141.0/24
```

<a href="#heading--Summary"><h2 id="heading--Summary">Summary</h2></a>

At this point, it should be clear that jq is a relatively simple, powerful tool for formatting output from the MAAS CLI. You should also remember that, like any Ubuntu CLI command, jq simply outputs text — so anything you can do with text output, you can do with the output from jq.