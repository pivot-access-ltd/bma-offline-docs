
Annotations are descriptive, searchable phrases that apply only to machines.  There are two types of annotations: static (always present in any machine state), and dynamic (only present in allocated or deployed states).  Annotations help you identify, characterise, and inform others about your machines.

<a href="#heading--work-with-annotations"><h2 id="heading--work-with-annotations">Work with annotations</h2></a>

[tabs]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages"]
This section will explain how to:

- [Work with static annotations](#heading--work-with-static-annotations)
- [Work with dynamic (workload) annotations](#heading--work-with-dynamic-workload-annotations)
[/tab]
[tab version="v2.9 Snap,v2.9 Packages"]
This section explains how to work with notes, also known as "static annotations".  MAAS 2.9 does not support dynamic annotations; you must upgrade to MAAS version 3.0 or greater to obtain that capability.
[/tab]
[/tabs]

<a href="#heading--work-with-static-annotations"><h3 id="heading--work-with-static-annotations">Work with static annotations</h3></a>

This subsection will show you how to:

[tab version="v2.9 Snap,v2.9 Packages" view="UI"]
- [Create and assign static annotations](#heading--create-and-assign-static-annotations)
- [Delete static annotations](#heading--delete-static-annotations)
- [View static annotations](#heading--view-static-annotations)

<a href="#heading--create-and-assign-static-annotations"><h4 id="heading--create-and-assign-static-annotations">Create and assign static annotations</h4></a>

To create and assign static annotations (a note) to a machine, follow this procedure:

1. Go to the machine list and click on the machine of interest:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. This will bring up a machine summary for that machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png"></a>

3. Select "Configuration" and click the "Edit" button to the right of the "Machine configuration" section:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png"></a>

4. Add free-form notes in the "Note" field, as desired.

5. Click "Save changes" to update the machine's configuration.

<a href="#heading--delete-static-annotations"><h4 id="heading--delete-static-annotations">Delete static annotations</h4></a>

To delete static annotations (a note) from a machine, follow this procedure:

1. Go to the machine list and click on the machine of interest:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. This will bring up a machine summary for that machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png"></a>

3. Select "Configuration" and click the "Edit" button to the right of the "Machine configuration" section:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png"></a>

4. Edit the free-form notes in the "Note" field, as desired.

5. Click "Save changes" to update the machine's configuration.

<a href="#heading--view-static-annotations"><h4 id="heading--view-static-annotations">View static annotations</h4></a>

To view static annotations, you can follow this procedure:

1. Go to the machine list and look at the machine of interest; you should see the first few characters of a note in the bottom half of the column marked "POOL/NOTE:"

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3286feef733f4b56a94708d3af044c1523e78369.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3286feef733f4b56a94708d3af044c1523e78369.png"></a>

2. Click on the machine, which will bring up a machine summary for that machine. Switch to the configuration tab to see the full note:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e9a324a428a3374b616b2986ee5f56d13eb1e07d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e9a324a428a3374b616b2986ee5f56d13eb1e07d.png"></a>

[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages" view="UI"]
- [Create and assign static annotations](#heading--create-and-assign-static-annotations)
- [Delete static annotations](#heading--delete-static-annotations)
- [View static annotations](#heading--view-static-annotations)
- [Work with dynamic (workload) annotations](#heading--work-with-dynamic-workload-annotations)

<a href="#heading--create-and-assign-static-annotations"><h4 id="heading--create-and-assign-static-annotations">Create and assign static annotations</h4></a>

To create and assign static annotations (a note) to a machine, follow this procedure:

1. Go to the machine list and click on the machine of interest:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. This will bring up a machine summary for that machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png"></a>

3. Select "Configuration" and click the "Edit" button to the right of the "Machine configuration" section:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png"></a>

4. Add free-form notes in the "Note" field, as desired.

5. Click "Save changes" to update the machine's configuration.

<a href="#heading--delete-static-annotations"><h4 id="heading--delete-static-annotations">Delete static annotations</h4></a>

To delete static annotations (a note) from a machine, follow this procedure:

1. Go to the machine list and click on the machine of interest:

<a href="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/c/c4069963ad134416ba8fe9e436317f48b8fa2f46.png"></a>

2. This will bring up a machine summary for that machine:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/a083bd0b3253839df3a57fc21e26439ce2e114dd.png"></a>

3. Select "Configuration" and click the "Edit" button to the right of the "Machine configuration" section:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e9fda18183c567e62dea80fce01497227727e7bb.png"></a>

4. Edit the free-form notes in the "Note" field, as desired.

5. Click "Save changes" to update the machine's configuration.

<a href="#heading--view-static-annotations"><h4 id="heading--view-static-annotations">View static annotations</h4></a>

To view static annotations, you can follow this procedure:

1. Go to the machine list and look at the machine of interest; you should see the first few characters of a note in the bottom half of the column marked "POOL/NOTE:"

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3286feef733f4b56a94708d3af044c1523e78369.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3286feef733f4b56a94708d3af044c1523e78369.png"></a>

2. Click on the machine, which will bring up a machine summary for that machine. Switch to the configuration tab to see the full note:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e9a324a428a3374b616b2986ee5f56d13eb1e07d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e9a324a428a3374b616b2986ee5f56d13eb1e07d.png"></a>

<a href="#heading--work-with-dynamic-workload-annotations"><h3 id="heading--work-with-dynamic-workload-annotations">Work with dynamic (workload) annotations</h3></a>
 
This subsection will show you how to:

- [View dynamic (workload) annotations for one machine](#heading--view-dynamic-workload-annotations-for-one-machine)
- [Filter on dynamic (workload) annotations](#heading--filter-on-dynamic-workload-annotations)

<a href="#heading--view-dynamic-workload-annotations-for-one-machine"><h4 id="heading--view-dynamic-workload-annotations-for-one-machine">View dynamic (workload) annotations for one machine</h4></a>

To view the dynamic (workload) annotations for one machine, do the following:

1. Go to the machine list and select the machine of interest by clicking on its hyperlinked name.

2. In the machine summary that comes up, look for the "Workload Annotations" card, in the lower, right-hand corner:

<a href="https://discourse.maas.io/uploads/default/original/2X/e/e7def7a50f9c854f7aae0efc34897338c46c32c0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/e7def7a50f9c854f7aae0efc34897338c46c32c0.png"></a>

<a href="#heading--filter-on-dynamic-workload-annotations"><h4 id="heading--filter-on-dynamic-workload-annotations">Filter on dynamic (workload) annotations</h4></a>

To filter machines by dynamic (workload) annotations, use the following procedure:

1. Go to the machine list and select the "Filter" drop-down; open the "Workload" segment:

<a href="https://discourse.maas.io/uploads/default/original/2X/9/946fb41e9cefb10a0b59787ce22b70a91b248d01.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/9/946fb41e9cefb10a0b59787ce22b70a91b248d01.jpeg"></a>

2. Select one or more values from this list to filter the machine list by these workload annotations.

[/tab]
[tab version="v3.2 Snap,v3.1 Snap,v3.0 Snap,v2.9 Snap,v3.2 Packages,v3.1 Packages,v3.0 Packages,v2.9 Packages" view="CLI"]
This section will show you how to:

- [Work with static annotations](#heading--work-with-static-annotations)
- [Work with dynamic (workload) annotations](#heading--work-with-dynamic-workload-annotations)

<a href="#heading--work-with-static-annotations"><h3 id="heading--work-with-static-annotations">Work with static annotations</h3></a>

This subsection will show you how to:

- [Identify your machines](#heading--identify-your-machines)
- [Set a static annotation for a machine](#heading--set-a-static-annotation-for-a-machine)
- [Change or clear a static annotation for a machine](#heading--change-or-clear-a-static-annotation-for-a-machine)
- [List static annotations for all machines](#heading--list-static-annotations-for-all-machines)
- [View a static annotation for one machine](#heading--view-a-static-annotation-for-one-machine)


<a href="#heading--identify-your-machines"><h4 id="heading--identify-your-machines">Identify your machines</h4></a>

To identify your available machines, use a command like this one:

```bash
maas $PROFILE machines read \
| jq -r '(["hostname","system_id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
|@tsv' | column -t
```

For example:

```bash
maas admin machines read \
| jq -r '(["hostname","system_id"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id])
|@tsv' | column -t
```

Typical output might look something like this:

```nohighlight
hostname       system_id
--------       ---------
divine-stork   8b3ypp
casual-prawn   4end6r
driven-teal    tgaat6
immune-beetle  43xand
good-osprey    napfxk
smart-hen      c4rwq7
boss-satyr     xn8taa
golden-martin  8fxery
crack-guinea   qk4b3g
finer-leech    cy3dtr
free-mouse     gxtbq4
humble-bunny   srqnnb
wanted-muskox  ekw7fh
one-boa        by477d
great-urchin   srnx4g
ace-frog       g6arwg
alive-marlin   gbwnfb
picked-parrot  am77wn
tough-kit      ke3wc7
legal-whale    8nq3mt
game-sponge    76pdc6
fun-ghoul      qxfm7k
aware-earwig   8m8hs7
chief-crane    7fapx7
select-tapir   4ascbr
on-slug        snfs8d
polite-llama   dbqd4m
frank-coyote   wcmk48
usable-condor  ed8hmy
still-imp      h6ra6d
```

<a href="#heading--set-a-static-annotation-for-a-machine"><h4 id="heading--set-a-static-annotation-for-a-machine">Set a static annotation for a machine</h4></a>

If you want to set the static annotation for a given machine, you can do so with a command that looks like this:

```bash
maas $PROFILE machine update $SYSTEM_ID description="$STATIC_ANNOTATION"
```

For example:

```bash
maas admin machine update ke3wc7 description="kilo-echo-3-whisky-charlie-7"
```

You can check your work by [viewing the static annotations for one machine](#heading--view-a-static-annotation-for-one-machine).

<a href="#heading--change-or-clear-a-static-annotation-for-a-machine"><h4 id="heading--change-or-clear-a-static-annotation-for-a-machine">Change or clear a static annotation for a machine</h4></a>

If you want to set the static annotation for a given machine, use the same command you'd use to set a static annotation:

```bash
maas $PROFILE machine update $SYSTEM_ID description="$STATIC_ANNOTATION"
```

The existing annotation will be overwritten by the new one you enter.  For example:

```bash
maas admin machine update ke3wc7 description=""
```

You can check your work by [viewing the static annotations for one machine](#heading--view-a-static-annotation-for-one-machine).


<a href="#heading--list-static-annotations-for-all-machines"><h4 id="heading--list-static-annotations-for-all-machines">List static annotations for all machines</h4></a>

To list static annotations for all machines, enter a command similar to this one:

```bash
maas $PROFILE machines read \
| jq -r '(["hostname","system_id","description"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.description])
|@tsv' | column -t
```

For example:

```bash
maas admin machines read \
| jq -r '(["hostname","system_id","description"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.description])
|@tsv' | column -t
```

Output might look something like this:

```nohighlight
hostname       system_id  description
--------       ---------  -----------
driven-teal    tgaat6     tango-golf
humble-bunny   srqnnb     sierra-romeo
tough-kit      ke3wc7     kilo-echo
```

<a href="#heading--view-a-static-annotation-for-one-machine"><h4 id="heading--view-a-static-annotation-for-one-machine">View a static annotation for one machine</h4></a>

To view a static annotation for one machine, try a command like this:

```bash
 maas $PROFILE machine read $SYSTEM_ID \
| jq -r '(["hostname","system_id","description"]
|(.,map(length*"-"))),([.hostname,.system_id,.description])
|@tsv' | column -t
```

For example:

```bash
 maas admin machine read tgaat6 \
| jq -r '(["hostname","system_id","description"]
|(.,map(length*"-"))),([.hostname,.system_id,.description])
|@tsv' | column -t
```

A command like this might produce output as follows:

```nohighlight
hostname     system_id  description
--------     ---------  -----------
driven-teal  tgaat6     tango-golf
```

<a href="#heading--work-with-dynamic-workload-annotations"><h3 id="heading--work-with-dynamic-workload-annotations">Work with dynamic (workload) annotations</h3></a>

This section will show you how to:

- [Identify machines that can receive dynamic annotations](#heading--identify-machines-that-can-receive-dynamic-annotations)
- [Set dynamic annotations for a machine](#heading--set-dynamic-annotations-for-a-machine)
- [Clear and change dynamic annotations for a machine](#heading--clear-and-change-dynamic-annotations-for-a-machine)
- [List dynamic annotations for all machines](#heading--list-dynamic-annotations-for-all-machines)
- [List dynamic allocations for one machine](#heading--list-dynamic-annotations-for-one-machine)

<a href="#heading--identify-machines-that-can-receive-dynamic-annotations"><h4 id="heading--identify-machines-that-can-receive-dynamic-annotations">Identify machines that can receive dynamic annotations</h4></a>

You can only set dynamic annotations for machines that are in the "Allocated" or "Deployed" state.  To identify which of your machines are in these states, you can execute the following command:

```bash
maas $PROFILE machines read \
| jq -r '(["hostname","system_id","status"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.status_name])
|@tsv' | column -t
```

For example:

```bash
maas admin machines read \
| jq -r '(["hostname","system_id","status"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.status_name])
|@tsv' | column -t
```

Output should look something like this:

```nohighlight
hostname       system_id  status
--------       ---------  ------
divine-stork   8b3ypp     Deployed
casual-prawn   4end6r     Ready
driven-teal    tgaat6     Allocated
immune-beetle  43xand     Allocated
good-osprey    napfxk     Allocated
smart-hen      c4rwq7     Allocated
boss-satyr     xn8taa     Ready
golden-martin  8fxery     Allocated
crack-guinea   qk4b3g     Allocated
finer-leech    cy3dtr     Deployed
free-mouse     gxtbq4     Allocated
humble-bunny   srqnnb     Allocated
wanted-muskox  ekw7fh     Deployed
one-boa        by477d     Allocated
great-urchin   srnx4g     Allocated
ace-frog       g6arwg     Ready
alive-marlin   gbwnfb     Deployed
picked-parrot  am77wn     Allocated
tough-kit      ke3wc7     Deployed
legal-whale    8nq3mt     Allocated
game-sponge    76pdc6     Allocated
fun-ghoul      qxfm7k     Allocated
aware-earwig   8m8hs7     Deployed
chief-crane    7fapx7     Ready
select-tapir   4ascbr     Allocated
on-slug        snfs8d     Allocated
polite-llama   dbqd4m     Allocated
frank-coyote   wcmk48     Allocated
usable-condor  ed8hmy     Deployed
still-imp      h6ra6d     Allocated
```

<a href="#heading--set-dynamic-annotations-for-a-machine"><h4 id="heading--set-dynamic-annotations-for-a-machine">Set dynamic annotations for a machine</h4></a>

Dynamic annotations, otherwise known as "workload annotations" or "owner data," can be used to keep track of the runtime status of machines that are acquired or deployed.  These annotations are set using `key=value` pairs.  You can set any `key=value` pair that you wish for any machine, although it's probably more useful if you standardise your key names.

To set a dynamic annotation for a machine, you can enter a command like this:

```bash
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=$VALUE
```

For example:

```bash
maas admin machine set-owner-data tgaat6 owner=gsmith@zorko.com
```

This command will return a JSON string representative of the machine's new configuration, including the dynamic annotations you've added. You can check your work by [listing the dynamic annotations for the one machine](#heading--list-dynamic-annotations-for-one-machine) you just edited, or by [listing dynamic annotations for all machines](#heading--list-dynamic-annotations-for-all-machines).

<a href="#heading--clear-and-change-dynamic-annotations-for-a-machine"><h4 id="heading--clear-and-change-dynamic-annotations-for-a-machine">Clear and change dynamic annotations for a machine</h4></a>

You can change dynamic annotations for a machine simply by executing a new `set-owner-data` command:

```bash
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=$NEW_VALUE
```

You can clear a dynamic annotation by entering the empty string (`""`) as the $VALUE:

```bash
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=""
```

These commands will return a JSON string representative of the machine's new configuration, including the dynamic annotations you've changed or cleared. You can check your work by [listing the dynamic annotations for the one machine](#heading--list-dynamic-annotations-for-one-machine) you just edited, or by [listing dynamic annotations for all machines](#heading--list-dynamic-annotations-for-all-machines).

<a href="#heading--list-dynamic-annotations-for-all-machines"><h4 id="heading--list-dynamic-annotations-for-all-machines">List dynamic annotations for all machines</h4></a>

You can list the current dynamic annotations for all machines with a command like this:

```bash
maas $PROFILE machines read \
| jq -r '(["hostname","system_id","owner_data"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.owner_data[]])
|@tsv' | column -t
```

For example:

```bash
maas admin machines read \
| jq -r '(["hostname","system_id","owner_data"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.owner_data[]])
|@tsv' | column -t
```

This command output might look something like this:

```nohighlight
hostname       system_id  owner_data
--------       ---------  ----------
divine-stork   8b3ypp
casual-prawn   4end6r
driven-teal    tgaat6     farquar     foobar
immune-beetle  43xand
good-osprey    napfxk
smart-hen      c4rwq7
```

<a href="#heading--list-dynamic-annotations-for-one-machine"><h4 id="heading--list-dynamic-annotations-for-one-machine">List dynamic allocations for one machine</h4></a>

You can list the dynamic annotations for one machine by entering a command of the form:

```bash
maas $PROFILE machine read $SYSTEM_ID \
| jq -r '(["hostname","system_id","owner_data"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.owner_data[]])
|@tsv' | column -t
```

For example:

```bash
maas admin machine read tgaat6 \
| jq -r '(["hostname","system_id","owner_data"]
|(.,map(length*"-"))),(.[]|[.hostname,.system_id,.owner_data[]])
|@tsv' | column -t
```

This will produce output similar to the following:

```nohighlight
hostname     system_id  owner_data
--------     ---------  ----------
driven-teal  tgaat6     farquar     foobar
```
[/tab]
