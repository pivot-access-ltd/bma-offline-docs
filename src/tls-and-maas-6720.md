<!-- Tls and MAAS -->
[tabs]
[tab version="v3.4 Snap,v3.4 Packages,v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages"]
<a href="#heading--about-maas-native-tls"><h2 id="heading--about-maas-native-tls">About MAAS Native TLS</h2></a>

MAAS version 3.2 has built-in TLS support for communicating with the UI and API over HTTPS. This eliminates the need to deploy a separate TLS-terminating reverse-proxy solution in front of MAAS to provide secure access to API and UI.

TLS versions 1.2 and 1.3 are supported by MAAS. For TLSv1.2, the following ciphers are accepted:

- AES256+EECDH
- AES256+EDH

You will need to obtain your own certificates via some provider, e.g., [small step](https://smallstep.com/docs/step-ca)`↗`.

<a href="#heading--about-auto-renewal-for-certificates"><h3 id="heading--about-auto-renewal-for-certificates">About certificate auto-renewal</h3></a>

At the moment we don’t support automatic certificate renewal, because it depends on the PKI used at the organisation level.  We [do provide some examples](#heading--how-to-auto-renew-certificates) of how to set this up, as long as you understand that these are just gratuitous helps, not supported configurations.
[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
To obtain MAAS native TLS, upgrade to MAAS v3.2 or higher.
[/tab]
[/tabs]
