<!-- "How to unseal Vault" -->

[tabs]
[tab version="v3.3 Snap,v3.3 Packages"]
There are two conditions that may cause Vault-protected secrets to become unavailable: when the Vault is sealed (using `vault operator seal` -- see the [Vault documentation](https://www.hashicorp.com/products/vault) and when the Vault is unreachable through misconfiguration or other failure.

When the Vault is sealed, all queries involving secrets will fail with a user error mentioning that the Vault has been sealed.  Unsealing the Vault requires operator intervention, via the `vault operator unseal` command (again, see the [Vault documentation](https://www.hashicorp.com/products/vault).  MAAS will indicate when this is needed.

Vault may become unreachable due to a network failure, due to incorrect configuration of a region controller, or other unintentional situations.  When the Vault is unreachable, MAAS will inform the users that interactions with Vault will fail.

MAAS will make every attempt to present a meaningful error if Vault is not functional.  This includes related authentication errors when attempting to login to MAAS.
[/tab]
[tab version="v3.2 Snap,v3.2 Packages,v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
[Hashicorp Vault](https://www.vaultproject.io/) is integrated with MAAS version 3.3.  To enable Vault for use with your MAAS, please upgrade to MAAS 3.3.
[/tab]
[/tabs]