## How to enable Vault?

1. Get the role_id and wrapped_token via Vault CLI (follow the instructions from [Hashicorp Vault](https://learn.hashicorp.com/tutorials/vault/approle-best-practices?in=vault/auth-methods#approle-response-wrapping))
2. Configure all controllers using the command below

>$ sudo maas config-vault configure $url $approle_id $wrapped_token $secrets_path --secrets-mount $secret_mount

3. Once all region controllers are configured with Vault, migrate all secrets from any controller using the command below. (During migration, MAAS might be offline for a few seconds and it will refresh.)

>$ sudo maas config-vault migrate

![|649x586](https://lh3.googleusercontent.com/6huwJZKrnraNHM3hiiVGcrTgOSHD_b0KJOLL1N4s05rKnhQ09UYgMdQHuo5MT_N3lqKn02C_Qg7RQmfrELC4Xjj1pOjIo-N4mMBB8oRj1mfPLbyuw5oKO6jNvvAtUQxwrnKww5DDT1IYDfh9jFCwIoy6MLnOR831kzYHVsgDASfUNEMAW-dwJNdSAt_xTA)

What happens if you migrate all secrets before all region controllers are configured with Vault?

* The migrate command will not work and it will return an error message.

What happens when you configured all region controllers with Vault but didn’t migrate the secrets?

* The integration process will remain incomplete, the UI will show this message.

![|670x338](https://lh3.googleusercontent.com/v2_glOaBx8hTy7TmhD3Y5qe34iFePJN5Z46ZeY6UvGXF7eD4m7chplXtbKIKZMchs2D5WAJSit0tlH27onPV1oUnLZVKwyVOncje3QaZ0n4d-1sjTV5sfuQFopuql_COE0FfvDSFTcKeElnThC3_gKIg6YlNQ-JKvLH6t9sgp6UwrTPAnHzoGpQ6eSmeBQ)

## How to unseal Vault?

When Vault is sealed, the user will get logged out of the UI because MAAS cannot access Vault. The user needs to unseal the vault and they will have access to MAAS again.

![|974x255](https://lh4.googleusercontent.com/Sf49gilbeLRTYIch19bZvsYMgWXDbqMFJjKIVRocblIddQ0k5PsprW_M5MJkpCy9YfydNAuS_qzevcPputSJJ8odOxnACOq5wuLQHFPoS8Ak0UK4San-q6qw1v0bkluPXxnS8oELl4yaphI95enJR4iWs9X0g6nkeWcqPM7VILs55YngTfm2VG68GxRSpw)

## How to protect your secrets?

MAAS deals with a number of secrets (user password, certificates and keys, API tokens, …). Those are currently stored in the database, which is not secure by default.

While it’s possible to keep the database on encrypted storage, this is possibly not suitable for environments that need to adhere to strict security requirements/regulations.

One solution to protect your secret is to integrate with [Hashicorp Vault](https://www.vaultproject.io/).