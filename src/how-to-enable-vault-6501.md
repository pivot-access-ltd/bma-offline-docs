<!-- "How to enable Vault" -->

[tabs]
[tab version="v3.3 Snap,v3.3 Packages"]
For MAAS to be able to integrate with Vault, a few steps are required.  Specifically, you must get a role_id and wrapped_token via Vault CLI (follow the instructions from [Hashicorp Vault](https://learn.hashicorp.com/tutorials/vault/approle-best-practices?in=vault/auth-methods#approle-response-wrapping)).

As an example only, MAAS can be configured by a Vault admin using the `vault` CLI.

1) The `approle` engine must be enabled. This can be checked with:

```nohighlight
$ vault auth list
```

You should verify that it's mounted under `approle/`.  If not, it can be enabled via:

```nohighlight
$ vault auth enable approle
```

2) The KV v2 engine is mounted under the desired path (`secret/` by default, but can be configured as desired). A new KV engine can be mounted with:

```nohighlight
$ vault secrets enable -path $SECRETS_MOUNT kv-v2
```

3) An appropriate policy that can be assigned to approles configured in MAAS should be configured, providing read/write access to the secrets paths that MAAS will use.  As an example, here is a minimal policy:

```nohighlight
path "$SECRETS_MOUNT/metadata/$SECRETS_PATH/" {
	capabilities = ["list"]
}

path "$SECRETS_MOUNT/metadata/$SECRETS_PATH/*" {
	capabilities = ["read", "update", "delete", "list"]
}

path "$SECRETS_MOUNT/data/${SECRETS_PATH}/*" {
	capabilities = ["read", "create", "update", "delete"]
}
```
Here, `$SECRETS_PATH` is the desired path prefix under which MAAS will store secrets. This, together with `$SECRETS_MOUNT`, will be used when configuring MAAS later. Such a policy can be created in Vault as follows (assuming it was written to `$POLICY_FILE`):

```nohighlight
$ vault policy write $MAAS_POLICY $POLICY_FILE
```

4) For each MAAS region controller, create a role using the policy created above:

```nohighlight
$ vault write auth/approle/role/$ROLE_NAME \
policies=$MAAS_POLICY token_ttl=5m
```

Tthe TTL for tokens can be tweaked as desired.

While it's technically possible to use the same approle for all controllers, it's suggested to use different ones for each.  This increases security and reduces exposure in case credentials are leaked from one controller.

Fetch the role ID for the created role with the following command:

```nohighlight
$ vault read auth/approle/role/$ROLE_NAME/role-id
```

5) For each created role, create a secret ID, returned with a wrapping token. This, together with the role ID, will be provided to the MAAS controller:

```nohighlight
$ vault write -wrap-ttl=5m auth/approle/role/$ROLE_NAME/secret-id
```

<a href="#heading--Integrating-Vault-with-MAAS"><h2 id="heading--Integrating-Vault-with-MAAS">Integrating Vault with MAAS</h2></a>

Once MAAS is installed and configured, it's possible to integrate it with Vault with a few steps, using the CLI:

```nohighlight
sudo maas config-vault configure $URL $APPROLE_ID $WRAPPED_TOKEN $SECRETS_PATH --secrets-mount $SECRET_MOUNT
```
where the `$APPROLE_ID` and `$WRAPPED_TOKEN` are the ones obtained by Vault in the previous steps.

[note]
This operation must be performed on each region controller before the integration process can continue.
[/note]

Once this operation has been performed on all region controllers, it's possible to migrate secrets to Vault and complete the integration process, with the following command:

```nohighlight
$ sudo maas config-vault migrate
```
During migration, MAAS might be offline for a few seconds, but it will refresh quickly.  After this command, MAAS will be fully integrated and functional with Vault. You can confirm success in the UI by checking **Settings --> Configuration --> Security**:

![|649x586](https://lh3.googleusercontent.com/6huwJZKrnraNHM3hiiVGcrTgOSHD_b0KJOLL1N4s05rKnhQ09UYgMdQHuo5MT_N3lqKn02C_Qg7RQmfrELC4Xjj1pOjIo-N4mMBB8oRj1mfPLbyuw5oKO6jNvvAtUQxwrnKww5DDT1IYDfh9jFCwIoy6MLnOR831kzYHVsgDASfUNEMAW-dwJNdSAt_xTA)

[note] 
If you try to migrate secrets before all region controllers are configured with Vault, the migrate command will fail with an error message.
[/note]

If you've configured all region controllers with Vault, but haven't yet migrated the secrets, the integration process will simply remain incomplete.  The UI will remind you:

![|670x338](https://lh3.googleusercontent.com/v2_glOaBx8hTy7TmhD3Y5qe34iFePJN5Z46ZeY6UvGXF7eD4m7chplXtbKIKZMchs2D5WAJSit0tlH27onPV1oUnLZVKwyVOncje3QaZ0n4d-1sjTV5sfuQFopuql_COE0FfvDSFTcKeElnThC3_gKIg6YlNQ-JKvLH6t9sgp6UwrTPAnHzoGpQ6eSmeBQ)

<a href="#heading--Updating-secrets-directly"><h2 id="heading--Updating-secrets-directly">Updating secrets directly</h2></a>

Secrets related to MAAS stored in Vault could be changed outside of MAAS, directly in Vault. If this happens, MAAS automatically uses the new value, as MAAS elements do not cache secrets -- they are fetched every time they're needed.

MAAS deals with a number of secrets (user password, certificates and keys, API tokens, …). Those are currently stored in the database, which is not secure by default.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
[Hashicorp Vault](https://www.vaultproject.io/) is integrated with MAAS version 3.3.  To enable Vault for use with your MAAS, please upgrade to MAAS 3.3.
[/tab]
[/tabs]
