|object|audited action | event type | message |
|---|---|---|---|
| __init__ | creation of SSH key | AUTHORISATION | "Created SSH key {for 'username'}." |
| __init__ | creation of SSL key | AUTHORISATION | "Created SSL key." |
| accounts | deletion of token |AUTHORISATION| "Deleted token" |
| bcache | creation | NODE | "Created bcache" |
| bcache | deletion | NODE |  "Deleted bcache" |
| bcache | update | NODE | "Updated bcache" |
| bcache_cacheset | creation | NODE | "Created bcache cache set" |
| bcache_cacheset | deletion | NODE | "Deleted bcache cache set" |
| bcache_cacheset | update | NODE | "Updated bcache cache set" |
| commissioning_scripts | deletion | SETTINGS | "Deleted script 'script name'" |
| config | update | SETTINGS | "Updated configuration setting ''setting name'' to ''updated value''" |
| config_tls | update | SETTINGS | "Update configuration seting '{tls_key_name}'" |
| dhcpsnippet | creation/update | SETTINGS | "{Created/updated} DHCP snippet ''dhcp_snippet_name''" |
| dhcpsnippets | deletion | SETTINGS | "Deleted DHCP snippet ''dhcp snippet name''" |
| dhcpsnippets | reversion | SETTINGS | "Reverted DHCP snippet ''dhcp snippet name'' to revision ''revision number''" |
| node actions | various | NODE | varies by action |
| packagerepositories |deletion| SETTINGS | "Deleted package repository ''package repo name''" |
| packagerepository | creation/update | SETTINGS | "{Created/updated} package repository ''package_repo_name''" |
| scripts | reversion | SETTINGS | "Reverted script ''script name'' to revision ''revision number''" |
| scripts | save | SETTINGS | "Saved script ''script name''" |
| scripts | tagging | SETTINGS | "Added tag '{tag}' to script '{script.name}'." |
| scripts | un-tagging | SETTINGS | "Removed tag '{tag}' from script '{script.name}'." |
| ssh_keys | deletion | AUTHORISATION | "Deleted SSH key id=''ssh_key_id''." |
| ssh_keys | import | AUTHORISATION | "Imported SSH keys." |
| ssl_keys | import | AUTHORISATION, | "Imported SSH keys." |
| tags | creation | TAG | "Tag '{tag.name}' created." |
| tags | definition | TAG | "Tag '{name}' {action}." |
| tags | deletion | TAG | "Tag '{tag.name}' deleted." |
| test | various | NODE_PXE_REQUEST | varies |
| test | various | SETTINGS | varies |
| users | creation | AUTHORISATION | "Created {admin/user} 'username'" |
| users | deletion | AUTHORISATION | "Deleted {admin/user} 'username'" |
