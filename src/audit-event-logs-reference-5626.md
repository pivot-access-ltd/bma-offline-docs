hello everyone



I have newly deployed a set of Maas 3.1. When adding an IPMI host through the UI, I will prompt "failed to query node's BMC - incorrect username. Check BMC configuration and try again"



It's strange that the user, password and IP are correct (I can log in to IPMI normally through IE to restart the server), but Maas just prompts failure


Attached log:

| Thu, 23 Dec. 2021 16:08:48|Failed to power on node - Power on for the node failed: Could not authenticate to node's BMC: Incorrect username. Check BMC configuration and try again.|
|---|---|
| Thu, 23 Dec. 2021 16:08:48|Node changed status - From 'Commissioning' to 'Failed commissioning'|
| Thu, 23 Dec. 2021 16:08:48|Marking node failed - Power on for the node failed: Could not authenticate to node's BMC: Incorrect username. Check BMC configuration and try again.|
| Thu, 23 Dec. 2021 16:08:48|Powering on|
| Thu, 23 Dec. 2021 16:08:48|Node changed status - From 'New' to 'Commissioning'|
| Thu, 23 Dec. 2021 16:08:48|Commissioning|