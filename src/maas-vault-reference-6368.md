<!-- "MAAS Vault reference" -->

As a MAAS administrator, you do not want secrets associated with a MAAS instance to be stored in the database, since it often doesn’t comply with security regulations.  Examples of the MAAS settings which contain secrets are the OMAPI key and the RPC secret. MAAS secrets should instead be stored in Vault (**appropriate link?**).

Beginning with MAAS 3.3, MAAS secrets that are currently stored elswhere are stored in Vault, including but not limited to:

- Macaroon root keys
- The database password 
- The shared RPC secret
- User passwords
- API tokens
- User session keys 
- BMC credentials for nodes
- Node keys
- VMhost credentials
- VM credentials

<a href="#heading--Integrating-Vault-with-MAAS"><h2 id="heading--Integrating-Vault-with-MAAS">Integrating Vault with MAAS</h2></a>

MAAS provides an easy way to integrate Vault and move all secrets there, that is, secrets will be created in Vault and removed from other locations in MAAS, via the MAAS CLI:

```nohighlight
$  sudo maas ($PROFILE?) config-vault enable  $vault_url $token --secrets-mount-point $mount_point
```

This command will automatically configure necessary policies and roles for MAAS to function with Vault, link roles as necessary, and store the appropriate Vault credentials in the MAAS region controller.  Should you inadvertently run the command twice, MAAS will respond with this error message:

```nohighlight
This region is configured to use Vault. Generate a new token to connect with Vault on other controllers.
```

<a href="#heading--Linking-existing-region-controllers-with-Vault"><h2 id="heading--Linking-existing-region-controllers-with-Vault">Linking existing region controllers with Vault</h2></a>

You can use the first Vault-integrated controller to generate tokens for additional (existing) controllers:

```nohighlight
$ sudo maas ($PROFILE?) config-vault generate-controller-token $controller-name (or $controller-id)
```

MAAS will respond with a `$wrapped_token` and a command to connect the next controller:

```nohighlight
$ sudo maas config-vault connect-controller $vault_url $wrapped_token --secrets-mount-point $mount_point
```

A prototype of this command is printed to the terminal following the successful execution of the `maas config-vault enable` command.  Note that any new regions added after Vault integration will automatically be integrated with Vault.  No action is necessary on your part for these newly-added region controllers to work with Vault seamlessly.

<a href="#heading--Reverting-from-Vault-back-to-the-MAAS-DB"><h2 id="heading--Reverting-from-Vault-back-to-the-MAAS-DB">Reverting from Vault back to the MAAS DB</h2></a>

MAAS also provides a simple way to revert secrets from Vault to the MAAS DB, should you desire to do so:

```nohighlight
$ maas $PROFILE config-vault disable $vault_url $secret_path_prefix $token
```

<a href="#heading--When-the-Vault-is-sealed"><h2 id="heading--When-the-Vault-is-sealed">When the Vault is unreachable</h2></a>

**link about Vault and sealing, please?  I get it, but have no links to external doc**

There are two conditions that may cause secrets to become unavailable: when the Vault is sealed, and when the Vault is unreachable through misconfiguration or other failure:

- When the Vault is sealed, all queries involving secrets will fail with a user error mentioning that the Vault has been sealed.  Unsealing the Vault requires operator intervention.  MAAS will indicate when this is needed.

- Vault may become unreachable due to a network failure, due to incorrect configuration of a region controller, or other unintentional situations.  When the Vault is unreachable, MAAS will inform the users that interactions with Vault will fail.

MAAS will make every attempt to present a meaningful error if Vault is not functional.  This includes related authentication errors when attempting to login to MAAS.

<a href="#heading--Updating-secrets-directly"><h2 id="heading--Updating-secrets-directly">Updating secrets directly</h2></a>

Secrets related to MAAS stored in Vault could be changed outside of MAAS, directly in Vault. If this happens, MAAS automatically uses the new value, as MAAS elements do not cache secrets -- they are fetched every time they're needed.


**NOTE: i need some assurances as to the stability of the stuff in the [Vault meeting notes](https://docs.google.com/document/d/1lj5MpbhM0omMWClko7lY79_i-DO3R5cxwn0XBwAPaPw/edit#heading=h.r46zltfjohff) before i use it.  who can assist?**
