<!-- "How to annotate machines" -->
Annotations are descriptive, searchable phrases that apply only to machines.  There are two types of annotations: notes (always present in any machine state), and dynamic annotations (only present in allocated or deployed states).  Annotations help you identify, characterise, and inform others about your machines.

[note]
Dynamic annotations are not available in MAAS version 2.9.
[/note]

<a href="#heading--How-to-use-notes"><h2 id="heading--How-to-use-notes">How to use notes</h2></a>

Notes persist throughout the life-cycle of a machine -- or until you change them.

<a href="#heading--How-to-work-with-notes-in-the-MAAS-UI"><h3 id="heading--How-to-work-with-notes-in-the-MAAS-UI">How to work with notes in the MAAS UI</h3></a>

To work with notes for a given machine, using the MAAS UI:201

1. Select *Machines > Machine name > Configuration > Edit*.

2. Existing notes are displayed in the *Note* block.

2. Add notes to *Note*.

3. Alternatively, edit notes by changing the text in the *Note* block.

4. Delete any notes no longer needed by removing them from the *Note* block.

5. Be sure to *Save changes* to register your updates.

<a href="#heading--How-to-work-with-notes-in-the-MAAS-CLI"><h3 id="heading--How-to-work-with-notes-in-the-MAAS-CLI">How to work with notes in the MAAS CLI</h3></a>

It's also possible to manage notes in the MAAS CLI.

<a href="#heading--identify-your-machines"><h4 id="heading--identify-your-machines">How to identify your machines</h4></a>

The MAAS CLI refers to machines by their system ID, which can be obtained in this way:

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
```

<a href="#heading--How-to-manage-machine-notes-in-the-MAAS-CLI"><h4 id="heading--How-to-manage-machine-notes-in-the-MAAS-CLI">How to manage machine notes in the MAAS CLI</h4></a>

Add a note to a given machine like this:

```bash
maas $PROFILE machine update $SYSTEM_ID description="$NOTE"
```

For example:

```bash
maas admin machine update ke3wc7 description="kilo-echo-3-whisky-charlie-7"
```

The same command can be used to change the note, like this:

```bash
maas $PROFILE machine update $SYSTEM_ID description="$A_DIFFERENT_NOTE"
```

The existing note will be overwritten by the new one you enter.  You can also remove a note by entering and empty description, like this:

```bash
maas admin machine update ke3wc7 description=""
```

<a href="#heading--How-to-list-notes-for-all-machines"><h4 id="heading--How-to-list-notes-for-all-machines">How to list notes for all machines</h4></a>

List notes for all machines like this:

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

You can also check the note for one machine like this -- note the use of the *singular* "machine" versus "machines":

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

<a href="#heading--work-with-dynamic-workload-annotations"><h2 id="heading--work-with-dynamic-workload-annotations">How to work with dynamic (workload) annotations</h2></a>

Dynamic annotations persist only as long as a machine is allocated or deployed.  They help alert others to the status of your running workloads.  Dynamic annotations are managed in the MAAS CLI, but can be viewed and filtered using the MAAS UI.

<a href="#heading--How-to-identify-machines-that-can-receive-dynamic-annotations"><h3 id="heading--How-to-identify-machines-that-can-receive-dynamic-annotations">How to identify machines that can receive dynamic annotations</h3></a>

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

Output might look something like this:

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

<a href="#heading--How-to-set-dynamic-annotations"><h3 id="heading--How-to-set-dynamic-annotations">How to set dynamic annotations</h3></a>

Dynamic annotations, otherwise known as "workload annotations" or "owner data," can be used to keep track of the runtime status of machines that are allocated or deployed.  These annotations are set using `key=value` pairs.  You can set any `key=value` pair that you wish for any machine, although it's probably more useful if you standardise your key names.

To set a dynamic annotation for a machine, you can enter a command like this:

```bash
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=$VALUE
```

For example:

```bash
maas admin machine set-owner-data tgaat6 owner=gsmith@zorko.com
```

This command will return a JSON string representative of the machine's new configuration, including the dynamic annotations you've added. 

<a href="#heading--How-to-clear-or-change-dynamic-annotations"><h3 id="heading--How-to-clear-or-change-dynamic-annotations">How to clear or change dynamic annotations</h3></a>

You can change dynamic annotations for a machine simply by executing a new `set-owner-data` command:

```bash
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=$NEW_VALUE
```

You can clear a dynamic annotation by entering the empty string (`""`) as the $VALUE:

```bash
maas $PROFILE machine set-owner-data $SYSTEM_ID $KEY=""
```

<a href="#heading--list-dynamic-annotations-for-all-machines"><h3 id="heading--list-dynamic-annotations-for-all-machines">How to list dynamic annotations for all machines</h3></a>

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

<a href="#heading--list-dynamic-annotations-for-one-machine"><h3 id="heading--list-dynamic-annotations-for-one-machine">How to list dynamic annotations for one machine</h3></a>

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

<a href="#heading--How-to-view-dynamic-annotations-via-the-MAAS-UI"><h3 id="heading--How-to-view-dynamic-annotations-via-the-MAAS-UI">How to view dynamic annotations via the MAAS UI</h3></a>

To view the dynamic (workload) annotations for one machine -- via the MAAS UI -- do the following:

1. Select *Machines*.

2. Select the machine of interest by clicking on its hyperlinked name.

3. In the machine summary that comes up, look for the *Workload Annotations* card.

<a href="#heading--filter-on-dynamic-workload-annotations"><h3 id="heading--filter-on-dynamic-workload-annotations">How to filter on dynamic annotations via the MAAS UI</h3></a>

To filter machines by dynamic (workload) annotations, use the following procedure:

1. Select *Machines*.

2. Select the *Filters* dropdown.

3. Select *Workload*.

4. Select one or more values from the *Workload* list to filter the machine list.