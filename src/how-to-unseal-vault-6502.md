<!-- "How to unseal Vault" -->

<a href="#heading--When-the-Vault-is-sealed"><h2 id="heading--When-the-Vault-is-sealed">When the Vault is sealed</h2></a>

There are two conditions that may cause secrets to become unavailable: when the Vault is sealed (using `vault operator seal` -- see the [Vault documentation](https://www.hashicorp.com/products/vault) and when the Vault is unreachable through misconfiguration or other failure.

When the Vault is sealed, all queries involving secrets will fail with a user error mentioning that the Vault has been sealed.  Unsealing the Vault requires operator intervention, via the `vault operator unseal` command (again, see the [Vault documentation](https://www.hashicorp.com/products/vault).  MAAS will indicate when this is needed.

Vault may become unreachable due to a network failure, due to incorrect configuration of a region controller, or other unintentional situations.  When the Vault is unreachable, MAAS will inform the users that interactions with Vault will fail.

MAAS will make every attempt to present a meaningful error if Vault is not functional.  This includes related authentication errors when attempting to login to MAAS.
