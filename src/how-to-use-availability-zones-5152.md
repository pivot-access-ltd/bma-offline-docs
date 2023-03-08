<!-- "How to use availability zones" -->
This article will help you learn:

- [How to list availability zones](#heading--list-zones)
- [How to add an availability zone](#heading--add-a-zone)
- [How to edit an existing availability zone](#heading--edit-a-zone)
- [How to delete an existing availability zone](#heading--delete-a-zone)
- [How to assign a machine to an availability zone](#heading--assign-a-node-to-a-zone)
- [How to allocate a machine in a particular zone](#heading--allocate-a-node-in-a-zone)

You can find more theory about availability zones [elsewhere in this documentation set](/t/about-networking/6680#heading--about-availability-zones).

[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="UI"]
<a href="#heading--list-zones"><h2 id="heading--list-zones">How to list availability zones</h2></a>

To see a list of availability zones, select *AZs* from the top tab bar.

<a href="#heading--add-a-zone"><h2 id="heading--add-a-zone">How to add an availability zone</h2></a>

To create a zone:

1. Select *AZs*.

2. Select *Add AZ*.

3. Enter a *Name* for the zone.

4. Optionally enter a *Description* for the zone.

5. Select *Add AZ* to register your changes.

<a href="#heading--edit-a-zone"><h2 id="heading--edit-a-zone">How to edit an existing availability zone</h2></a>

To edit a zone:

1. Select *AZs*.

2. Select an AZ by clicking on its name.

3. Select *Edit* on the far right.

4. Update the *Name* for the zone, if desired.

5. Optionally update the *Description* for the zone, if desired.

6. Select *Update AZ* to register your changes.

<a href="#heading--delete-a-zone"><h2 id="heading--delete-a-zone">How to delete an existing availability zone</h2></a>

To delete a zone:

1. Select *AZs*.

2. Select an AZ by clicking on its name.

3. Select *Delete AZ* in the top right corner.

4. Update the *Name* for the zone, if desired.

5. Confirm by selecting the red *Delete AZ* button which appears.  Once you make this selection, the AZ will be deleted and no undo is possible.

<a href="#heading--assign-a-node-to-a-zone"><h2 id="heading--assign-a-node-to-a-zone">How to assign a machine to an availability zone</h2></a>

To assign a machine to a zone:

1. Select *Machines*.

2. Select one or more machines by clicking their checkboxes.

3. Select *Take action >> Set zone**.

4. In the popup dialogue, choose the *Zone* from the dropdown.

5. Select *Set zone for machine* to register your changes.

You can also change the zone for a machine under *Machines >> "machine-name" >> Configuration >> Edit*.

<a href="#heading--allocate-a-node-in-a-zone"><h2 id="heading--allocate-a-node-in-a-zone">How to allocate a machine in a particular zone</h2></a>

Allocating a machine in a particular zone can only be done via the MAAS CLI.
[/tab]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages" view="CLI"]

<a href="#heading--list-zones"><h2 id="heading--list-zones">How to list availability zones</h2></a>

To see a list of availability zones, enter the following command:

```
maas $PROFILE zones read \
| jq -r '(["ZONE","NAME","DESCRIPTION"]
| (., map(length*"-"))), (.[] | [.id, .name, .description])
| @tsv' | column -t
```

which produces output similar to:

```
ZONE  NAME         DESCRIPTION
----  ----         -----------
5     BizOffice
1     default
4     Inventory
2     Medications
3     Payroll
6     ProServ
```

<a href="#heading--add-a-zone"><h2 id="heading--add-a-zone">How to add an availability zone</h2></a>

To create a zone, enter the following command:

```
maas $PROFILE zones create name=$ZONE_NAME description=$ZONE_DESCRIPTION
```

<a href="#heading--edit-a-zone"><h2 id="heading--edit-a-zone">How to edit an existing availability zone</h2></a>

To edit a zone, enter a command similar to the following:

```
maas $PROFILE zone update $OLD_ZONE_NAME name=$NEW_ZONE_NAME \
description=$ZONE_DESCRIPTION
```

<a href="#heading--delete-a-zone"><h2 id="heading--delete-a-zone">How to delete an existing availability zone</h2></a>

To delete a zone, enter a command like this:

```
maas $PROFILE zone delete $ZONE_NAME
```

<a href="#heading--assign-a-node-to-a-zone"><h2 id="heading--assign-a-node-to-a-zone">How to assign a machine to an availability zone</h2></a>

To assign a machine to a zone, first retrieve the machine's system ID like this:

```
maas PROFILE machines read | jq '.[] | .hostname, .system_id'
```

Then enter the following command, using the system ID you just retrieved:

```
maas admin machine update $SYSTEM_ID zone=$ZONE_NAME
```

<a href="#heading--How-to-deploy-a-machine-in-a-particular-zone"><h2 id="heading--How-to-deploy-a-machine-in-a-particular-zone">How to deploy a machine in a particular zone</h2></a>

To deploy in a particular zone:

1. First acquire the machine, assigning it to the particular zone:

```nohighlight
maas $PROFILE machines allocate zone=$ZONE_NAME system_id=$SYSTEM_ID 
```

2. Then deploy the machine as normal:

```nohighlight
maas $PROFILE machine deploy system_id=$SYSTEM_ID
```
[/tab]
[/tabs]
