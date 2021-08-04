<a href="#heading--upload-test-scripts"><h2 id="heading--upload-test-scripts">How to upload hardware test scripts</h2></a>

To upload a hardware testing script to MAAS, enter the following:

``` bash
maas $PROFILE node-scripts create name=$SCRIPT_NAME name> \
 script=$PATH_TO_SCRIPT type=testing
```

Changing the type to commissioning adds the test script to the commissioning process.

You can list all uploaded scripts with the following command:

``` bash
maas $PROFILE node-scripts read type=testing filters=$TAG
```

The optional filters argument lets you search for tags assigned to a script, such as using `TAG=cpu` with the above example.

A script's metadata, and even the script itself, can be updated from the command line:

``` bash
maas $PROFILE node-script update \
 $SCRIPT_NAME script=$PATH_TO_SCRIPT comment=$COMMENT
```

The JSON formatted output to the above command will include 'history' dictionary entries, detailing script modification times and associated comments:

``` json
"history": [
    {
        "id": 40,
        "created": "Tue, 12 Sep 2017 12:12:08 -0000",
        "comment": "Updated version"
    },
    {
        "id": 34,
        "created": "Fri, 08 Sep 2017 17:07:46 -0000",
        "comment": null
    }
]
```

MAAS keeps a history of all uploaded script versions, allowing you to easily revert to a previous version using the `id` of the version you wish to revert to:

``` bash
maas $PROFILE node-script revert $SCRIPT_NAME to=$VERSION_ID
```

[note type="negative" status="Warning"]
The history for later modifications will be lost when reverting to an earlier version of the script.
[/note]

To download a script, enter the following:

``` bash
maas $PROFILE node-script download $SCRIPT_NAME > $LOCAL_FILENAME
```

To delete a script, use `delete`:

``` bash
maas $PROFILE node-script delete $SCRIPT_NAME
```

<a href="#heading--tags-group-scripts"><h2 id="heading--tags-group-scripts">How to use tags to group commissioning and testing scripts</h2></a>

Tags make scripts easier to manage; grouping scripts together for commissioning and testing, for example:

``` bash
maas $PROFILE node-script add-tag $SCRIPT_NAME tag=$TAG
maas $PROFILE node-script remove-tag $SCRIPT_NAME tag=$TAG
```

MAAS runs all commissioning scripts by default. However, you can select which custom scripts to run during commissioning by name or tag:

``` bash
maas $PROFILE machine commission \
 commissioning_scripts=$SCRIPT_NAME,$SCRIPT_TAG
```

You can also select which testing scripts to run by name or tag:

``` bash
maas $PROFILE machine commission \
 testing_scripts=$SCRIPT_NAME,$SCRIPT_TAG
```

Any testing scripts tagged with commissioning will also run during commissioning.

<a href="#heading--results"><h2 id="heading--results">How to view testing results</h2></a>

The command line allows you to not only view the current script's progress but also retrieve the verbatim output from any previous runs too.

If you only want to see the latest or currently-running result, you can use `current-commissioning`, `current-testing`, or `current-installation` instead of an id:

``` bash
maas $PROFILE node-script-result read $SYSTEM_ID $RESULTS
```

You can also limit which results are returned by type (commissioning, testing, or installation), script name, or script run:

``` bash
maas $PROFILE node-script-results read \
 $SYSTEM_ID type=$SCRIPT_TYPE filters=$SCRIPT_NAME,$TAGS
```

You can also suppress failed results, which is useful if you want to ignore a known failure:

``` bash
maas $PROFILE node-script-results update \
 $SYSTEM_ID type=$SCRIPT_TYPE filters=$SCRIPT_NAME,$TAGS suppressed=$SUPPRESSED
```

where `$SUPPRESSED` is either `True` or `False`. The JSON formatted output to the above command will include 'results' dictionary with an entry for `suppressed`:

``` json
"results": [
    {
        "id": 21,
        "created": "Tue, 02 Apr 2019 17:00:36 -0000",
        "updated": "Tue, 02 Apr 2019 20:56:41 -0000",
        "name": "smartctl-validate",
        "status": 5,
        "status_name": "Aborted",
        "exit_status": null,
        "started": "Tue, 02 Apr 2019 20:56:41 -0000",
        "ended": "Tue, 02 Apr 2019 20:56:41 -0000",
        "runtime": "0:00:00",
        "starttime": 1554238601.765214,
        "endtime": 1554238601.765214,
        "estimated_runtime": "0:00:00",
        "parameters": {
            "storage": {
                "argument_format": "{path}",
                "type": "storage",
                "value": {
                    "id_path": "/dev/vda",
                    "model": "",
                    "name": "sda",
                    "physical_blockdevice_id": 1,
                    "serial": ""
                }
            }
        },
        "script_id": 1,
        "script_revision_id": null,
        "suppressed": true
    }
]
```

Finally, results can be downloaded, either to stdout, stderr, as combined output or as a tar.xz:

``` bash
maas $PROFILE node-script-result download $SYSTEM_ID $RUN_ID output=all \
 filetype=tar.xz > $LOCAL_FILENAME
```

[note]
**$RUN_ID** is labelled `id` in the verbose result output.
[/note]
rad-end


rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
<a href="#heading--apply-a-hardware-test"><h2 id="heading--apply-a-hardware-test">How to apply a hardware test</h2></a>

To launch a test, select the target machine from the 'Machines' page and use the 'Take action' drop-down menu to select 'Test hardware'. When ready, hit the 'Test machine' button. Here, a test is applied to a deployed machine:

<a href="https://assets.ubuntu.com/v1/8e876889-nodes-hw-testing__2.4_deployed.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/8e876889-nodes-hw-testing__2.4_deployed.png"></a>

There is the option of not powering off the machine and to allow SSH access.

A default test will be selected (`smartctl-validate`, a hard drive test) but you can choose others by clicking the 'Select scripts' label. Doing so will reveal the following choices:

<a href="https://assets.ubuntu.com/v1/ccfefe25-nodes-hw-testing__2.4_deployed-choices.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/ccfefe25-nodes-hw-testing__2.4_deployed-choices.png"></a>

rad-end

See [Commissioning and Hardware Testing Scripts](/t/commissioning-and-hardware-testing-scripts/nnnn) for more details on how these scripts work and how you can write your own.

<a href="#heading--network-link-testing"><h2 id="heading--network-link-testing">How to test network links</h2></a>

MAAS can check whether links are connected or disconnected, so that you can detect unplugged cables.  If you are not running MAAS 2.7, you must first upgrade and then recommission your machines to find disconnected links.  MAAS not only reports unplugged cables, but also gives a warning when trying to configure a disconnected interface.  In addition, administrators can change the cable connection status after manually resolving the issue.

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
To check network testing results, enter the following command:

```
maas $PROFILE interfaces read $SYSTEM_ID \
| jq -r '(["LINK_NAME","LINK_CONNECTED?","LINK_SPEED", "I/F_SPEED"]
| (., map(length*"-"))), (.[] | [.name, .link_connected, .link_speed, .interface_speed])
| @tsv' | column -t
```

which produces an output similar to this:

```
LINK_NAME  LINK_CONNECTED?  LINK_SPEED  I/F_SPEED
---------  ---------------  ----------  ---------
ens3       false            -           1 Gpbs
```

From this screen, you can see that the `ens3` link is not connected (hence an unreported link speed). 
rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
When MAAS detects a broken network link, users will see a screen similar to this one: 

<a href="https://discourse.maas.io/uploads/default/original/1X/687feb2ddea8b317f0deba239bcb1779fd5f33d3.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/687feb2ddea8b317f0deba239bcb1779fd5f33d3.jpeg"></a> 

If you're already using a version of MAAS less than 2.7, you will want to upgrade and recommission your existing machines to check link status.  Note that you will also receive a warning from MAAS when trying to configure a disconnected interface.
rad-end

Once you have manually repaired the broken connection, an administrator can change cable connection status:

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
```
maas $PROFILE interface update $SYSTEM_ID $INTERFACE_ID link_connected=true
```
rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
<a href="https://discourse.maas.io/uploads/default/original/1X/b8b24a2e5fbc40b6469a24733a518b510cf0d955.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/b8b24a2e5fbc40b6469a24733a518b510cf0d955.jpeg"></a> 
rad-end

<a href="#heading--slow-link-detection"><h2 id="heading--slow-link-detection">How to detect slow network links</h2></a>

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
As servers and hardware get faster, the chances increase that you might encounter a speed mismatch when connecting your NIC to a network device.  MAAS can warn you if your interface is connected to a link slower than what the interface supports, when you run the above command:

```
maas $PROFILE interfaces read $SYSTEM_ID \
| jq -r '(["LINK_NAME","LINK_CONNECTED?","LINK_SPEED", "I/F_SPEED"]
| (., map(length*"-"))), (.[] | [.name, .link_connected, .link_speed, .interface_speed])
| @tsv' | column -t
```

From the resulting output, you can detect when your link/interface speeds are slower than expected. Depending on your physical hardware, the problem may not be repairable, but once you identify a slow link, you can replace a slow switch without recommissioning.  

rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
As servers and hardware get faster, the chances increase that you might encounter a speed mismatch when connecting your NIC to a network device.  MAAS can warn you if your interface is connected to a link slower than what the interface supports, by automatically detecting link and interface speed and reporting them via the UI:

<a href="https://discourse.maas.io/uploads/default/original/1X/e73a81df222f44c0b364eefcd0880e2a84c7303b.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/e73a81df222f44c0b364eefcd0880e2a84c7303b.jpeg"></a>  

Depending on your physical hardware, the problem may not be repairable, but once you identify a slow link, you can replace a slow switch without recommissioning.  
rad-end

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 

Administrators can change or update the link and interface speeds after manual changes
to the connection:

```
maas $PROFILE interface update $SYSTEM_ID $INTERFACE_ID link_speed=$NEW_LINK_SPEED \
interface_speed=$NEW_INTERFACE_SPEED
```

rad-end

<a href="#heading--network-validation-scripts-and-testing"><h2 id="heading--network-validation-scripts-and-testing">How to configure network validation and testing scripts</h2></a>

MAAS allows you to configure network connectivity testing in a number of ways. If MAAS can’t connect to the rack controller, deployment can’t complete.  MAAS can check connectivity to the rack controller and warn you if there’s no link, long before you have to try and debug it. For example, if you can’t connect to your gateway controller, traffic can’t leave your network. 

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
MAAS can check this link and recognise that there’s no connectivity, which alleviates hard-to-detect network issues:

<a href="https://discourse.maas.io/uploads/default/original/1X/c4f81cb3ef1a90f0a46fb62c893a4cc9f7e5f45a.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/c4f81cb3ef1a90f0a46fb62c893a4cc9f7e5f45a.jpeg"></a> 
rad-end

Users can now test their network configuration to check for:

1. Interfaces which have a broken network configuration
2. Bonds that are not fully operational
3. Broken gateways, rack controllers, and Internet links

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
In addition, MAAS can comprehensively test Internet connectivity testing. You can give a list of URLs or IP addresses to check:

<a href="https://discourse.maas.io/uploads/default/original/1X/b92a8ca1821bc1ccf60cf7fddcb57f3fbeda4408.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/b92a8ca1821bc1ccf60cf7fddcb57f3fbeda4408.jpeg"></a> 
rad-end

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
In addition, MAAS can comprehensively test Internet connectivity testing. You can give a list of URLs or IP addresses to check from the network testing screen:

<a href="https://discourse.maas.io/uploads/default/original/1X/12dd87ce0bffd54c2e459c4dea850af5fcbe14d0.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/12dd87ce0bffd54c2e459c4dea850af5fcbe14d0.jpeg"></a> 
rad-end

In the ephemeral environment, standard DHCP is still applied, but when network testing runs, MAAS can apply your specific configuration for the duration of the test.  While all URLs / IPs are tested with all interfaces, MAAS can test each of your interfaces individually, including breaking apart bonded NICS and testing each side of your redundant interfaces. You can also run different tests on each pass, e.g., a different set of URLs, although each run would be a different testing cycle.

rad-begin   /snap/2.9/cli   /deb/2.9/cli /snap/3.0/cli /deb/3.0/cli 
To test individual interfaces, for example, you could issue the following command:

<a href="https://discourse.maas.io/uploads/default/original/1X/7fadb56a2939f7a781510a55813141de03521e0d.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/7fadb56a2939f7a781510a55813141de03521e0d.jpeg"></a> 

Note that in this command, we are testing internet connectivity to the single interface "br0."
rad-end

<a href="#heading--customisable-network-testing"><h2 id="heading--customisable-network-testing">How to customise network testing</h2></a>

MAAS allow you to customise network testing according to your needs.  You can create your own commissioning scripts and tests related to networking, and you can run them during the network testing portion of the MAAS workflow.

rad-begin   /snap/2.9/ui   /deb/2.9/ui /snap/3.0/ui /deb/3.0/ui 
<a href="https://discourse.maas.io/uploads/default/original/1X/0dcf089dbd8efc2fc9d0782d3b15f47647e950b8.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/1X/0dcf089dbd8efc2fc9d0782d3b15f47647e950b8.jpeg"></a> 
rad-end

There are no particular restrictions on these scripts, so you can test a wide variety of possible conditions and situations.  Administrators can upload network tests and test scripts.  Administrators can also create tests which accept an interface parameter, or scripts which apply custom network configurations.  

Users can specify unique parameters using the API, override machines which fail network testing (allowing their use), and suppress individual failed network tests.  Users can also review the health status from all interface tests, even sorting them by interface name and MAC.  In addition, MAAS can report the overall status of all interfaces.


