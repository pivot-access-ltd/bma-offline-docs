<!-- "How to enable TLS encryption" -->
[tabs]
[tab version="v3.2 Snap,v3.2 Packages"]
<a href="#heading--about-maas-native-tls"><h2 id="heading--about-maas-native-tls">About MAAS Native TLS</h2></a>

MAAS version 3.2 has built-in TLS support for communicating with the UI and API over HTTPS. This eliminates the need to deploy a separate TLS-terminating reverse-proxy solution in front of MAAS to provide secure access to API and UI.

TLS versions 1.2 and 1.3 are supported by MAAS. For TLSv1.2, the following ciphers are accepted:

- AES256+EECDH
- AES256+EDH

You will need to obtain your own certificates via some provider, e.g., [small step](https://smallstep.com/docs/step-ca).

<a href="#heading--about-auto-renewal-for-certificates"><h3 id="heading--about-auto-renewal-for-certificates">About certificate auto-renewal</h3></a>

At the moment we don’t support automatic certificate renewal, because it depends on the PKI used at the organisation level.  We [do provide some examples](#heading--how-to-auto-renew-certificates) of how to set this up, as long as you understand that these are just gratuitous helps, not supported configurations.

<a href="#heading--how-to-use-maas-native-tls"><h2 id="heading--how-to-use-maas-native-tls">How to use MAAS native TLS</h2></a>

TLS can be enabled/disabled with the new `maas config-tls` command:

```nohighlight
usage: maas config-tls [-h] COMMAND ...

Configure MAAS Region TLS.

optional arguments:
  -h, --help  show this help message and exit

drill down:
  COMMAND
    enable    Enable TLS and switch to a secured mode (https).
    disable   Disable TLS and switch to a non-secured mode (http).

the following arguments are required: COMMAND
```

<a href="#heading--how-to-enable-tls"><h3 id="heading--how-to-enable-tls">How to enable TLS</h3></a>

To enable TLS in MAAS, a private key and a X509 certificate containing the corresponding public key are required. Both key and certificate must be encoded in PEM format.

```nohighlight
usage: maas config-tls enable [-h] [--cacert CACERT] [-p PORT] key cert

positional arguments:
  key                   path to the private key
  cert                  path to certificate in PEM format

optional arguments:
  -h, --help            show this help message and exit
  --cacert CACERT       path to CA certificates chain in PEM format (default: None)
  -p PORT, --port PORT  HTTPS port (default: 5443)

the following arguments are required: key, cert
```

By default, the port for HTTPS traffic will be 5443. It’s possible to specify a different one via the `–port` option.  If your certificate is not self-signed, you can pass a cacert.pem, so that the full chain will be included in the certificate served by MAAS.

If you have HA setup, please note that every MAAS instance will use the same certificate, so you need to create one certificate with multiple domain names or IP addresses; for example:

```nohighlight
X509v3 Subject Alternative Name:
                DNS:example.com, IP Address:10.211.55.9
```

<a href="#heading--how-to-disable-tls"><h3 id="heading--how-to-disable-tls">How to disable TLS</h3></a>

If for some reason you want to disable TLS, you can do it using the following command:

```nohighlight
usage: maas config-tls disable [-h]

optional arguments:
  -h, --help  show this help message and exit
```

After this, MAAS API and UI will be again reachable on port 5240, over plain HTTP.

<a href="#heading--using-the-cli-with-a-tls-enabled-maas"><h2 id="heading--using-the-cli-with-a-tls-enabled-maas">Using the CLI with a TLS-enabled MAAS</h2></a>

To connect to the MAAS API when TLS is enabled, an https URL must be provided to the maas login command, e.g.:

```nohighlight
maas login <profile_name> https://mymaas:5443/MAAS <api_key>

usage: maas login [-h] [--cacerts CACERTS] [-k] profile-name url [credentials]

Log in to a remote API, and remember its description and credentials.

positional arguments:
  profile-name       The name with which you will later refer to this remote server and credentials within this tool.
  url                The URL of the remote API, e.g. http://example.com/MAAS/ or http://example.com/MAAS/api/2.0/ if you wish to specify the API
                     version.
  credentials        The credentials, also known as the API key, for the remote MAAS server. These can be found in the user preferences page in
                     the web UI; they take the form of a long random-looking string composed of three parts, separated by colons.

optional arguments:
  -h, --help         show this help message and exit
  --cacerts CACERTS  Certificate CA file in PEM format
  -k, --insecure     Disable SSL certificate check

If credentials are not provided on the command-line, they will be prompted
for interactively.

the following arguments are required: profile-name, url
```

Certificates provided via `--cacerts` will be stored as a part of your profile and used for next CLI commands invocations.

<a href="#heading--certificate-renewal"><h2 id="heading--certificate-renewal">Certificate renewal</h2></a>

Once a certificate has expired, you can update it by running the same command used for enabling TLS:

``` nohighlight
$ ​​sudo maas config-tls enable new-server-key.pem new-server.pem --port 5443
```

If you’re using the snap, the certificate and key must be placed in a directory that’s readable by the CLI, such as `/var/snap/maas/common` (e.g., if you're using the snap version).

<a href="#heading--ui-changes"><h2 id="#heading--ui-changes">UI Changes</h2></a>

There is a new "Security" subsection under "Configuration" that will indicate the status of TLS in the specific server (enabled or disabled).

<a href="#heading--tls-enabled"><h3 id="heading--tls-enabled">TLS enabled</h3></a>

When TLS is enabled, the following certificate information is displayed:

- CN 
- Expiration date
- Fingerprint
- Certificate

It is also possible to download certificate and configure notification reminder settings. Once the notification reminder is enabled, MAAS administrators will be notified about certificate expiration.

<a href="https://discourse.maas.io/uploads/default/original/2X/3/34053a14fbf38b96f8a70886e8fac3d120323a29.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/34053a14fbf38b96f8a70886e8fac3d120323a29.jpeg"></a>

<a href="#heading--tls-disabled"><h3 id="heading--tls-disabled">TLS disabled</h3></a>

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f27c091d2335ecbb1db65193891e8d24b7e94715.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f27c091d2335ecbb1db65193891e8d24b7e94715.png"></a>

We recommend that you enable TLS for secure communication.

<a href="#heading--notifications"><h3 id="heading--notifications">Notifications</h3></a>

When the specified number of days remain until certificate expiration (as defined in the notification reminder), all administrators will see the certificate expiration notification. This notification is dismissible, but once it is dismissed, it won't appear again.

<a href="https://discourse.maas.io/uploads/default/original/2X/e/ea8d6c4a84adb581d4eb664b1d6d917bea9ed783.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/e/ea8d6c4a84adb581d4eb664b1d6d917bea9ed783.png"></a>

A certificate expiration check runs every twelve hours.  When the certificate has expired, the notification will change to “certificate has expired”.

<a href="https://discourse.maas.io/uploads/default/original/2X/6/6dd9ff4905bd256f53557d1828192bc5459ea7b6.jpeg" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/6/6dd9ff4905bd256f53557d1828192bc5459ea7b6.jpeg"></a>

<a href="#heading--how-to-auto-renew-certificates"><h3 id="heading--how-to-auto-renew-certificates">How to auto-renew certificates</h3></a>

MAAS does not auto-renew certificates, but there's no reason why we cannot provide a gratuitous example.  Use at your own risk.

<a href="#heading--set-up-your-own-certificate-authority"><h4 id="heading--set-up-your-own-certificate-authority">Set up your own certificate authority</h4></a>

You can setup your own Certificate Authority (CA) server that supports the ACME protocol with these components:

- [step-ca from Smallstep](https://smallstep.com/docs/step-ca)
- [Caddy server with ACME support](https://caddyserver.com/docs/caddyfile/directives/acme_server)  (available since version 2.5)

If you have a CA server with ACME protocol support, you can use any ACME client for an automated certificate renewal and use crontab to renew on a desired time interval.  Consider [acme.sh](https://github.com/acmesh-official/acme.sh): 

```nohighlight
$> acme.sh --issue -d mymaas.internal --standalone --server https://ca.internal/acme/acme/directory

Your cert is in: /root/.acme.sh/mymaas.internal/mymaas.internal.cer
Your cert key is in: /root/.acme.sh/mymaas.internal/mymaas.internal.key
The intermediate CA cert is in: /root/.acme.sh/mymaas.internal/ca.cer
And the full chain certs is there: /root/.acme.sh/foo/fullchain.cer
```

Once the certificate is issued, you can install it. 

```nohighlight
$> acme.sh --installcert -d maas.internal \
   --certpath /var/snap/maas/certs/server.pem \
   --keypath /var/snap/maas/certs/server-key.pem  \
   --capath  /var/snap/maas/certs/cacerts.pem  \
   --reloadcmd  "(echo y) | maas config-tls enable /var/snap/maas/certs/server-key.pem /var/snap/maas/certs/server.pem --port 5443"
```

Please note that if you have MAAS installed via snap, you need to run above command as root, in order to place cert and key under `/var/snap/maas`.

Another approach would be to write a bash script and pass it to a [`--renew-hook`](https://github.com/acmesh-official/acme.sh/wiki/Using-pre-hook-post-hook-renew-hook-reloadcmd).

<a href="#heading--using-certbot"><h4 id="heading--using-certbot">Using certbot</h4></a>

[certbot](https://certbot.eff.org) can be used to renew certificates and execute a post-renewal hook.  We can use this hook to re-configure MAAS to use fresh certificates.

To create a post-renewal hook, you can put this sample script under `/etc/letsencrypt/renewal-hooks/post/001-update-maas.sh`.

```nohighlight
#!/bin/bash -e

DOMAIN="maas.internal"
CERTSDIR="/etc/letsencrypt/live/$DOMAIN"

cd /var/snap/maas/common

# need to copy certs where the snap can read them
cp "$CERTSDIR"/{privkey,cert,chain}.pem .
yes | maas config-tls enable privkey.pem cert.pem --cacert chain.pem --port 5443

# we don’t want to keep private key and certs around
rm {privkey,cert,chain}.pem
```

Don’t forget to make the script executable:

```nohighlight
chmod +x /etc/letsencrypt/renewal-hooks/post/001-update-maas.sh
```

Of course, you'll first need to obtain a new certificate.  

```nohighlight
sudo REQUESTS_CA_BUNDLE=ca.pem certbot certonly --standalone -d maas.internal     --server https://ca.internal/acme/acme/directory
```

Don't worry, new certs will not run the hook, since hooks are run only on renewal.

To test the renewal process and verify that the hook is executed correctly, you can use the following command with a `--dry-run flag`. Please note, that the hook will be executed and existing certificates will be removed (if you are using an example hook script):

```nohighlight
sudo REQUESTS_CA_BUNDLE=ca.pem certbot renew --standalone --server https://ca.internal/acme/acme/directory --dry-run
```

Please refer to the [cerbot documentation](https://certbot.eff.org/instructions?ws=other&os=ubuntufocal) for more information.

[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
MAAS doesn't support TLS encryption natively.  If you are not interested in [setting up an HAProxy](/t/how-to-enable-high-availability/5120#heading--load-balancing-with-haproxy-optional), you can enable TLS independently in the web server software (e.g. Apache, Nginx) which users access directly.  The examples below explain how to create this configuration.

Note that MAAS doesn't bind to port 80; instead, MAAS binds to port 5240.

<a href="#heading--nginx"><h2 id="heading--nginx">nginx example config</h2></a>

    server {
     listen 443 SQL;

     server_name _;
     ssl_certificate /etc/nginx/ssl/nginx.crt;
     ssl_certificate_key /etc/nginx/ssl/nginx.key;

     location / {
      proxy_pass http://localhost:5240;
      include /etc/nginx/proxy_params;
     }

     location /MAAS/ws {
      proxy_pass http://localhost:5240/MAAS/ws;
                    proxy_http_version 1.1;
                    proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "Upgrade";
     }
    }

<a href="#heading--apache2"><h2 id="heading--apache2">apache2 example config</h2></a>

    <VirtualHost *:443>
     SSLEngine On

     SSLCertificateFile /etc/apache2/ssl/apache2.crt
     SSLCertificateKeyFile /etc/apache2/ssl/apache2.key

     RewriteEngine On
            RewriteCond %{REQUEST_URI} ^/MAAS/ws [NC]
            RewriteRule /(.*) ws://localhost:5240/MAAS/ws [P,L]

            ProxyPreserveHost On
            ProxyPass / http://localhost:5240/
            ProxyPassReverse / http://localhost:5240/
    </VirtualHost>
[/tab]
[/tabs]
