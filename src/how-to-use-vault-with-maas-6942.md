<!-- "How to enable Vault" -->

[tabs]
[tab version="v3.3 Snap,v3.3 Packages"]
For MAAS to be able to integrate with Vault, a few steps are required.  Specifically, you must get a role_id and wrapped_token via Vault CLI (follow the instructions from [Hashicorp Vault](https://learn.hashicorp.com/tutorials/vault/approle-best-practices?in=vault/auth-methods#approle-response-wrapping)`↗`).

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

The TTL for tokens can be tweaked as desired.

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
sudo maas config-vault configure $URL $APPROLE_ID $WRAPPED_TOKEN $SECRETS_PATH --mount $SECRET_MOUNT
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

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dadf8cb6b03710ab19868b77c23d3d2062afb22d.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dadf8cb6b03710ab19868b77c23d3d2062afb22d.png"></a>

[note] 
If you try to migrate secrets before all region controllers are configured with Vault, the migrate command will fail with an error message.
[/note]

If you've configured all region controllers with Vault, but haven't yet migrated the secrets, the integration process will simply remain incomplete.  The UI will remind you:

<a href="https://discourse.maas.io/uploads/default/original/2X/5/558b495841536f38600bbe67c4d4293a3e94bd0b.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/5/558b495841536f38600bbe67c4d4293a3e94bd0b.png"></a>

[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
[Hashicorp Vault](https://www.vaultproject.io/)`↗` is integrated with MAAS version 3.3.  To enable Vault for use with your MAAS, please upgrade to MAAS 3.3.
[/tab]
[/tabs]