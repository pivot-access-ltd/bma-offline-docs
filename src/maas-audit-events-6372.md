<!-- "MAAS audit events" -->

An audit event is a [MAAS event](/t/understanding-maas-events/6373) tagged with `AUDIT`. It captures changes to the MAAS configuration and machine states. These events provide valuable oversight of user actions and automated updates -- and their effects -- especially when multiple users are interacting with multiple machines.  See [Understanding MAAS events](/t/understanding-maas-events/6373) for basic usage of the CLI `events query` command.

<a href="#heading--Viewing-events"><h2 id="heading--Viewing-events">Viewing events</h2></a>

Audit events are examined using the MAAS CLI with the `level=AUDIT` parameter set:

```nohighlight
$ maas $PROFILE events query level=AUDIT
```

You can use `jq` to prettify the output:

```nohighlight
$ maas $PROFILE events query level=AUDIT after=0 limit=20 \
| jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.hostname,.created,.description]) 
| @tsv' | column -t -s$'\t'
```

This command might produce output similar to this:

```nohighlight
USERNAME  HOSTNAME     DATE                        EVENT
--------  --------     ----                        -----
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 2 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 1 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  pci device 0 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  block device sda was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  interface enp5s0 was updated on node 8wmfx3
unknown   valued-moth  Thu, 21 Apr. 2022 19:45:14  0 bytes of memory was removed on node 8wmfx3
admin     valued-moth  Thu, 21 Apr. 2022 19:36:48  Started deploying 'valued-moth'.
admin     valued-moth  Thu, 21 Apr. 2022 19:36:21  Acquired 'valued-moth'.
admin     unknown      Thu, 21 Apr. 2022 19:21:46  Updated configuration setting 'completed_intro' to 'True'.
admin     unknown      Thu, 21 Apr. 2022 19:20:49  Updated configuration setting 'upstream_dns' to '8.8.8.8'.
admin     unknown      Thu, 21 Apr. 2022 19:20:49  Updated configuration setting 'maas_name' to 'neuromancer'.
admin     unknown      Thu, 21 Apr. 2022 19:20:47  Updated configuration setting 'http_proxy' to ''.
admin     unknown      Thu, 21 Apr. 2022 19:20:24  Logged in admin.
```

You can also use the [various event filters](/t/understanding-maas-events/6373#heading--filter-parameters) with `level=AUDIT` to further restrict your output.

<a href="#heading--The-meaning-of-audit-events"><h3 id="heading--The-meaning-of-audit-events">The meaning of audit events</h3></a>

Let's walk through a sample of, say, eighteen audit events and see how to interpret and use them.  

```nohighlight
maas $PROFILE events query level=AUDIT limit=18 after=0 | jq -r '(["USERNAME","NODE","HOSTNAME","LEVEL","DATE","TYPE","EVENT"] | 
(., map(length*"-"))),
(.events[] | [.username,.node,.hostname,.level,.created,.type,.description]) 
| @tsv' | column -t -s$'\t'
```

Consider the resulting `jq` output:

```nohighlight
USERNAME     NODE    HOSTNAME       LEVEL  DATE                        TYPE  EVENT
--------     ----    --------       -----  ----                        ----  -----
admin        mm3tc8  fair-marten    AUDIT  Tue, 30 Nov. 2021 09:14:02  Node  Set the zone to 'danger' on 'fair-marten'.
admin        ebd7dc  new-name       AUDIT  Tue, 30 Nov. 2021 09:14:02  Node  Set the zone to 'danger' on 'new-name'.
admin        pbpncx  ruling-bobcat  AUDIT  Tue, 30 Nov. 2021 09:13:52  Node  Set the zone to 'default' on 'ruling-bobcat'.
admin        mm3tc8  fair-marten    AUDIT  Tue, 30 Nov. 2021 09:13:52  Node  Set the zone to 'default' on 'fair-marten'.
admin        ebd7dc  new-name       AUDIT  Tue, 30 Nov. 2021 09:13:52  Node  Set the zone to 'default' on 'new-name'.
admin        mm3tc8  fair-marten    AUDIT  Tue, 30 Nov. 2021 09:11:56  Node  Started commissioning on 'fair-marten'.
admin        ebd7dc  new-name       AUDIT  Tue, 30 Nov. 2021 09:11:55  Node  Started commissioning on 'new-name'.
admin        ebd7dc  new-name       AUDIT  Tue, 30 Nov. 2021 09:09:06  Node  Marked 'new-name' broken.
admin        ebd7dc  new-name       AUDIT  Tue, 30 Nov. 2021 07:51:31  Node  Started commissioning on 'new-name'.
admin        mm3tc8  fair-marten    AUDIT  Tue, 30 Nov. 2021 06:07:03  Node  Started commissioning on 'fair-marten'.
admin        ebd7dc  active-amoeba  AUDIT  Tue, 23 Nov. 2021 08:01:10  Node  Started commissioning on 'active-amoeba'.
admin        ebd7dc  active-amoeba  AUDIT  Tue, 23 Nov. 2021 08:00:47  Node  Marked 'active-amoeba' broken.
admin        pbpncx  ruling-bobcat  AUDIT  Wed, 17 Nov. 2021 00:04:51  Node  Started deploying 'ruling-bobcat'.
admin        ebd7dc  active-amoeba  AUDIT  Mon, 15 Nov. 2021 05:39:48  Node  Set the resource pool to 'default' on 'active-amoeba'.
admin        ebd7dc  active-amoeba  AUDIT  Mon, 08 Nov. 2021 04:07:44  Node  Started testing on 'active-amoeba'.
admin        ebd7dc  active-amoeba  AUDIT  Mon, 08 Nov. 2021 04:05:40  Node  Marked 'active-amoeba' broken.
admin        knpge8  bolla          AUDIT  Wed, 16 Jun. 2021 04:35:50  Node  Started importing images on 'bolla'.
admin        knpge8  bolla          AUDIT  Wed, 10 Jun. 2020 21:07:40  Node  Set the zone to 'danger' on 'bolla'.
```

All of these example events are type `Node`, referring to a machine actions.  Node events are probably the most important audit events, because they capture machine life-cycle changes.  When auditing your MAAS, life-cycle events are often the most useful.

Take a moment to consider the MAAS life-cycle, which can be depicted with this state table:

| Machine state | Cm | Aq | Dp | Rl | Ab | Cl | PC | Ts | Rsq | Bk | Lk | Fx | Tg | RP | SZ | Del |
|---------------|----|----|----|----|----|----|----|----|-----|----|----|----|----|----|----|-----|
| New           | Y  |    |    |    |    |    | Y  | Y  | Y   |    |    |    | Y  | Y  | Y  | Y   |
| Failed        | Y  |    |    |    |    |    |    | Y  | Y   | Y  |    |    | Y  | Y  | Y  | Y   |
| Commissioning |    |    |    |    | Y  |    |    |    |     | Y  |    |    | Y  | Y  | Y  |     |
| Ready         | Y  | Y  | Y  |    |    | Y  |    | Y  | Y   | Y  |    |    | Y  | Y  | Y  | Y   |
| Acquired      | Y  |    | Y  | Y  |    |    |    | Y  | Y   | Y  |    |    | Y  | Y  | Y  | Y   |
| Deploying     |    |    |    | Y  | Y  |    | Y  |    |     |    | Y  |    | Y  | Y  | Y  | Y   |
| Deployed      |    |    |    | Y  |    |    | Y  | Y  | Y   | Y  | Y  |    | Y  | Y  | Y  | Y   |
| Broken        | Y  |    |    |    |    |    | Y  | Y  | Y   |    |    | Y  | Y  | Y  | Y  | Y   |
| Rescue mode   |    |    |    |    |    |    |    |    | X   |    |    |    | Y  | Y  | Y  | Y   |

The key for the table columns is as follows:

- *Cm* - can commission.
- *Aq* - can acquire.
- *Dp* - can deploy.
- *Rl* - can release.
- *Ab* - can abort an operation in progress.
- *Cl* - can clone the machine.
- *PC* - can power-cycle the machine (turn in on or off).
- *Ts* - can run tests on the machine.
- *Rsq* - can put the machine in Rescue Mode.
- *Bk* - can mark the machine as broken.
- *Lk* - can lock the machine, preventing others from accessing it.
- *Fx* - can move a broken machine to a fixed state.
- *Tg* - can set tags for a machine.
- *RP* - can set the resource pool for a machine.
- *SZ* - can set the zone for a machine.
- *Del* - can delete the machine.

<a href="#heading--Using-audit-events-to-find-out-what-happened"><h3 id="heading--Using-audit-events-to-find-out-what-happened">Using audit events to find out what happened</h3></a>

Consider these example events that audit state changes:

```nohighlight
ID      LEVEL  TYPE           USERNAME  DESCRIPTION
=================================================================================================
589317  AUDIT  Node           bruce     Marked 'ruling-bobcat' broken.
583324  AUDIT  Node           clark     Tagging 'fair-marten'.
583313  AUDIT  Node           clark     Untagging 'fair-marten'.
584190  AUDIT  Node           diana     Overrode failed testing on 'new-name'.
529870  AUDIT  Node           kara      Powered on 'karura'.
529868  AUDIT  Node           kara      Powered off 'karura'.
435099  AUDIT  Node           barry     Set the zone to 'twilight' on 'fair-marten'.
435097  AUDIT  Node           hal       Acquired 'fair-marten'.
430453  AUDIT  Node           jonn      Started testing on 'fair-marten'.
430449  AUDIT  Node           jonn      Marked 'fair-marten' broken.
430445  AUDIT  Node           clark     Aborted 'testing' on 'fair-marten'.
427583  AUDIT  Node           diana     Set the resource pool to 'default' on 'fair-marten'.
426354  AUDIT  Node           bruce     Started commissioning on 'fair-marten'.
423257  AUDIT  Node           kara      Aborted 'commissioning' on 'fair-marten'.
421915  AUDIT  Node           joanna    Started releasing 'ruling-bobcat'.
28471   AUDIT  Settings       natasha   Updated DHCP snippet 'foo'.
28470   AUDIT  Settings       tony      Created DHCP snippet 'foo'.
28465   AUDIT  Settings       bruce2    Saved script 'setup.sh'.
28464   AUDIT  Settings       hank      Updated configuration setting 'enable_third_party_drivers' to 'False'.
8518    AUDIT  Node           kitty     Acquired 'sweet-krill'.
7615    AUDIT  Node           barry     Deleted the 'machine' 'new-bedbug'.
6238    AUDIT  Node           jonn      Started rescue mode on 'fleet-calf'.
5920    AUDIT  Node           diana     Started deploying 'comic-muskox'.
5907    AUDIT  Authorisation  admin     Logged out admin.
5906    AUDIT  Authorisation  admin     Logged in admin.
5896    AUDIT  Authorisation  hank      Created user 'zorko'.
3944    AUDIT  Node           clark     Deleted the 'machine' 'sweet-urchin'.
```

This is a long (but varied) listing, so there are many questions you might be able to answer:

1. Who deployed `comic-muskox`? 

2. What happened to `sweet-urchin`?

3. Why is `fleet-calf` in rescue mode?

4. Where did these changes come from in `setup.sh`?

5. What caused `ruling-bobcat` to be marked as broken?

6. Who's responsible for the DHCP snippet called `foo`?

Audit events don't answer all questions, but they help you discover whom to ask.

<a href="#heading--Auditing-with-finesse"><h3 id="heading--Auditing-with-finesse">Auditing with finesse</h3></a>

You can use the MAAS CLI, `jq`, and command line text tools to finesse your auditing.  First, you'll have to get a feel for how MAAS describes audit events:

- Set the resource pool to 
- Started commissioning 
- Aborted 'commissioning'
- Started releasing 
- Created DHCP snippet
- Saved script 
- Updated configuration setting 
- Deleted the 'machine' 
- Created user

You can use these snippets as search keys.  Say you walk into the data centre one day and a couple of machines just aren't there any more.  You could run this command:

```nohighlight
$ maas $PROFILE events query limit=1000 after=0 level=AUDIT \
hostname=new-bedbug hostname=sweet-urchin \
| jq -r '(.events[] | [.id,.level,.type,.username,.description]) 
| @tsv' | column -t -s$'\t' \
| grep "Deleted the"
```

Within 30 seconds, you'd know whom to ask:

```nohighlight
7615    AUDIT  Node  barry     Deleted the 'machine' 'new-bedbug'.
3944    AUDIT  Node  clark     Deleted the 'machine' 'sweet-urchin'.
```
Or, you could just check to see what's been deleted:

```nohighlight
33315  AUDIT  Node           Deleted the 'machine' 'keen-lab'.
33314  AUDIT  Node           Deleted the 'machine' 'helloooo'.
31179  AUDIT  Node           Deleted the 'machine' 'firm-ghost'.
31178  AUDIT  Node           Deleted the 'machine' 'proper-troll'.
31177  AUDIT  Node           Deleted the 'machine' 'steady-mammal'.
31176  AUDIT  Node           Deleted the 'machine' 'wired-dove'.
31175  AUDIT  Node           Deleted the 'machine' 'wanted-fox'.
31174  AUDIT  Node           Deleted the 'machine' 'picked-cub'.
31173  AUDIT  Node           Deleted the 'machine' 'claudio'.
31172  AUDIT  Node           Deleted the 'machine' 'next-mullet'.
31171  AUDIT  Node           Deleted the 'machine' 'happy-bengal'.
31170  AUDIT  Node           Deleted the 'machine' 'grown-hawk'.
31169  AUDIT  Node           Deleted the 'machine' 'new-bedbug'.
31168  AUDIT  Node           Deleted the 'machine' 'native-moray'.
31167  AUDIT  Node           Deleted the 'machine' 'fleet-calf'.
31166  AUDIT  Node           Deleted the 'machine' 'daring-ewe'.
31165  AUDIT  Node           Deleted the 'machine' 'sweet-urchin'.
31164  AUDIT  Node           Deleted the 'machine' 'new-chimp'.
31163  AUDIT  Node           Deleted the 'machine' 'humble-bug'.
31162  AUDIT  Node           Deleted the 'machine' 'modern-mutt'.
31161  AUDIT  Node           Deleted the 'machine' 'nice-skink'.
31160  AUDIT  Node           Deleted the 'machine' 'choice-worm'.
31159  AUDIT  Node           Deleted the 'machine' 'wanted-turtle'.
31158  AUDIT  Node           Deleted the 'machine' 'neat-yak'.
31157  AUDIT  Node           Deleted the 'machine' 'superb-piglet'.
31156  AUDIT  Node           Deleted the 'machine' 'rare-ghost'.
31155  AUDIT  Node           Deleted the 'machine' 'unique-weevil'.
31154  AUDIT  Node           Deleted the 'machine' 'finer-akita'.
31153  AUDIT  Node           Deleted the 'machine' 'cool-dog'.
31152  AUDIT  Node           Deleted the 'machine' 'meet-snake'.
31151  AUDIT  Node           Deleted the 'machine' 'native-civet'.
31150  AUDIT  Node           Deleted the 'machine' 'top-burro'.
31149  AUDIT  Node           Deleted the 'machine' 'pro-boa'.
31148  AUDIT  Node           Deleted the 'machine' 'fine-dane'.
31147  AUDIT  Node           Deleted the 'machine' 'clean-ocelot'.
31146  AUDIT  Node           Deleted the 'machine' 'boss-crab'.
31145  AUDIT  Node           Deleted the 'machine' 'crisp-mammal'.
31144  AUDIT  Node           Deleted the 'machine' 'active-panda'.
31143  AUDIT  Node           Deleted the 'machine' 'fit-ram'.
31142  AUDIT  Node           Deleted the 'machine' 'strong-prawn'.
31141  AUDIT  Node           Deleted the 'machine' 'equal-dog'.
31140  AUDIT  Node           Deleted the 'machine' 'sure-kid'.
31139  AUDIT  Node           Deleted the 'machine' 'choice-wren'.
31138  AUDIT  Node           Deleted the 'machine' 'eager-whale'.
31137  AUDIT  Node           Deleted the 'machine' 'fun-boxer'.
31136  AUDIT  Node           Deleted the 'machine' 'clean-filly'.
31135  AUDIT  Node           Deleted the 'machine' 'thingthing'.
31134  AUDIT  Node           Deleted the 'machine' 'prime-walrus'.
28073  AUDIT  Node           Deleted the 'machine' 'ace-boxer'.
28072  AUDIT  Node           Deleted the 'machine' 'active-panda'.
28071  AUDIT  Node           Deleted the 'machine' 'boss-crab'.
24724  AUDIT  Node           Deleted the 'machine' 'ruling-marlin'.
24723  AUDIT  Node           Deleted the 'machine' 'sweet-urchin'.
24722  AUDIT  Node           Deleted the 'machine' 'new-chimp'.
24721  AUDIT  Node           Deleted the 'machine' 'humble-bug'.
24720  AUDIT  Node           Deleted the 'machine' 'next-mullet'.
24719  AUDIT  Node           Deleted the 'machine' 'native-moray'.
24718  AUDIT  Node           Deleted the 'machine' 'grown-hawk'.
24717  AUDIT  Node           Deleted the 'machine' 'happy-bengal'.
24716  AUDIT  Node           Deleted the 'machine' 'picked-cub'.
24715  AUDIT  Node           Deleted the 'machine' 'claudio'.
24714  AUDIT  Node           Deleted the 'machine' 'fleet-calf'.
24713  AUDIT  Node           Deleted the 'machine' 'new-bedbug'.
24712  AUDIT  Node           Deleted the 'machine' 'daring-ewe'.
24711  AUDIT  Node           Deleted the 'machine' 'huge-yeti'.
24502  AUDIT  Node           Deleted the 'machine' 'guided-joey'.
24501  AUDIT  Node           Deleted the 'machine' 'active-adder'.
24500  AUDIT  Node           Deleted the 'machine' 'crisp-chow'.
24499  AUDIT  Node           Deleted the 'machine' 'holy-hippo'.
24498  AUDIT  Node           Deleted the 'machine' 'eager-kid'.
24497  AUDIT  Node           Deleted the 'machine' 'mighty-finch'.
24496  AUDIT  Node           Deleted the 'machine' 'native-koala'.
24415  AUDIT  Node           Deleted the 'machine' 'me'.
24410  AUDIT  Node           Deleted the 'machine' 'you'.
17934  AUDIT  Node           Deleted the 'machine' 'carol'.
17933  AUDIT  Node           Deleted the 'machine' 'bob'.
17932  AUDIT  Node           Deleted the 'machine' 'aaa'.
17931  AUDIT  Node           Deleted the 'machine' 'alice'.
17604  AUDIT  Node           Deleted the 'machine' 'subtle-lark'.
17603  AUDIT  Node           Deleted the 'machine' 'brief-beetle'.
17602  AUDIT  Node           Deleted the 'machine' 'fit-earwig'.
12508  AUDIT  Node           Deleted the 'machine' 'asdf'.
12507  AUDIT  Node           Deleted the 'machine' 'gfd'.
12506  AUDIT  Node           Deleted the 'machine' 'sadasd'.
12505  AUDIT  Node           Deleted the 'machine' 'vocal-krill'.
12504  AUDIT  Node           Deleted the 'machine' 'epic-robin'.
12503  AUDIT  Node           Deleted the 'machine' 'secret-maas'.
12502  AUDIT  Node           Deleted the 'machine' 'thingthing'.
12501  AUDIT  Node           Deleted the 'machine' 'worthy-ray'.
12500  AUDIT  Node           Deleted the 'machine' 'brief-pika'.
12499  AUDIT  Node           Deleted the 'machine' 'sweet-krill'.
12498  AUDIT  Node           Deleted the 'machine' 'awake-dog'.
12497  AUDIT  Node           Deleted the 'machine' 'living-crab'.
12496  AUDIT  Node           Deleted the 'machine' 'quiet-caiman'.
12495  AUDIT  Node           Deleted the 'machine' 'known-kodiak'.
10975  AUDIT  Node           Deleted the 'machine' 'rested-egret'.
10974  AUDIT  Node           Deleted the 'machine' 'good-martin'.
10973  AUDIT  Node           Deleted the 'machine' 'game-elk'.
10972  AUDIT  Node           Deleted the 'machine' 'asda'.
10971  AUDIT  Node           Deleted the 'machine' 'cuddly-eft'.
10970  AUDIT  Node           Deleted the 'machine' 'asdas'.
9423   AUDIT  Node           Deleted the 'machine' 'hostname'.
7615   AUDIT  Node           Deleted the 'machine' 'new-bedbug'.
7614   AUDIT  Node           Deleted the 'machine' 'happy-bengal'.
7613   AUDIT  Node           Deleted the 'machine' 'fleet-calf'.
7612   AUDIT  Node           Deleted the 'machine' 'claudio'.
7611   AUDIT  Node           Deleted the 'machine' 'sweet-urchin'.
7610   AUDIT  Node           Deleted the 'machine' 'picked-cub'.
7609   AUDIT  Node           Deleted the 'machine' 'new-chimp'.
7608   AUDIT  Node           Deleted the 'machine' 'humble-bug'.
7607   AUDIT  Node           Deleted the 'machine' 'grown-hawk'.
7606   AUDIT  Node           Deleted the 'machine' 'native-moray'.
7605   AUDIT  Node           Deleted the 'machine' 'daring-ewe'.
7604   AUDIT  Node           Deleted the 'machine' 'fair-puma'.
7603   AUDIT  Node           Deleted the 'machine' 'funny-panda'.
7602   AUDIT  Node           Deleted the 'machine' 'ace-molly'.
7601   AUDIT  Node           Deleted the 'machine' 'big-locust'.
7600   AUDIT  Node           Deleted the 'machine' 'next-mullet'.
3944   AUDIT  Node           Deleted the 'machine' 'sweet-urchin'.
3943   AUDIT  Node           Deleted the 'machine' 'picked-cub'.
3942   AUDIT  Node           Deleted the 'machine' 'next-mullet'.
3941   AUDIT  Node           Deleted the 'machine' 'new-chimp'.
3940   AUDIT  Node           Deleted the 'machine' 'new-bedbug'.
3939   AUDIT  Node           Deleted the 'machine' 'native-moray'.
3938   AUDIT  Node           Deleted the 'machine' 'humble-bug'.
3937   AUDIT  Node           Deleted the 'machine' 'happy-bengal'.
3936   AUDIT  Node           Deleted the 'machine' 'claudio'.
3935   AUDIT  Node           Deleted the 'machine' 'daring-ewe'.
3934   AUDIT  Node           Deleted the 'machine' 'grown-hawk'.
3933   AUDIT  Node           Deleted the 'machine' 'fleet-calf'.
2685   AUDIT  Node           Deleted the 'machine' 'test-lab'.
2684   AUDIT  Node           Deleted the 'machine' 'test'.
2683   AUDIT  Node           Deleted the 'machine' 'Sootie'.
2682   AUDIT  Node           Deleted the 'machine' 'Tigger'.
```

Of course, that's a complex list, so could simplify, sort, remove any duplicates, and prettify the list a bit with already-available tools:

```nohighlight
$ maas $PROFILE events query limit=1000 after=0 level=AUDIT \
| jq -r '(.events[] | [.description]) | @tsv' \
| column -t -s$'\t' \
| grep "Deleted the" \
| cut -f 4 -d" " \
| sort -u | sed -e"s/'//g" | sed -e"s/\.//g"
```

This would give you a list of machines that have been deleted at least once:

```nohighlight
aaa
ace-boxer
ace-molly
active-adder
active-panda
alice
asda
asdas
asdf
awake-dog
big-locust
bob
boss-crab
brief-beetle
brief-pika
carol
choice-worm
choice-wren
claudio
clean-filly
clean-ocelot
cool-dog
crisp-chow
crisp-mammal
cuddly-eft
daring-ewe
eager-kid
eager-whale
epic-robin
equal-dog
fair-puma
fine-dane
finer-akita
firm-ghost
fit-earwig
fit-ram
fleet-calf
fun-boxer
funny-panda
game-elk
gfd
good-martin
grown-hawk
guided-joey
happy-bengal
helloooo
holy-hippo
hostname
huge-yeti
humble-bug
keen-lab
known-kodiak
living-crab
me
meet-snake
mighty-finch
modern-mutt
native-civet
native-koala
native-moray
neat-yak
new-bedbug
new-chimp
next-mullet
nice-skink
picked-cub
prime-walrus
pro-boa
proper-troll
quiet-caiman
rare-ghost
rested-egret
ruling-marlin
sadasd
secret-maas
Sootie
steady-mammal
strong-prawn
subtle-lark
superb-piglet
sure-kid
sweet-krill
sweet-urchin
test
test-lab
thingthing
Tigger
top-burro
unique-weevil
vocal-krill
wanted-fox
wanted-turtle
wired-dove
worthy-ray
you
```

Still a bit long, but using your imagination and additional command line utilities, you could pare this down even more.

The important points for working with audit data are:

- there are filters available to pinpoint several event attributes, limit the number of records, and focus on a specific set of records.
- the native output of `events query` is JSON; if you have good JSON tools handy, you can use those tools to parse the data further.
- if you don't have JSON tools handy, you can always use `jq` to produce workable text output, which you can then manipulate using standard CLI text tools.

There's probably no limit to what you can figure out if you use audit events properly.
