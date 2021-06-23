||2.9|3.0|
|-----:|:-----:|:-----:|
Snap|[CLI](/t/configuring-tls-encryption-snap-2-9-cli/2542) ~ [UI](/t/configuring-tls-encryption-snap-2-9-ui/2543)|[CLI](/t/configuring-tls-encryption-snap-3-0-cli/3889) ~ [UI](/t/configuring-tls-encryption-snap-3-0-ui/3890)|
Packages|[CLI](/t/configuring-tls-encryption-deb-2-9-cli/2548) ~ [UI](/t/configuring-tls-encryption-deb-2-9-ui/2549)|[CLI](/t/configuring-tls-encryption-deb-3-0-cli/3891) ~ [UI](/t/configuring-tls-encryption-deb-3-0-ui/3892)|

<!-- deb-2-9-cli
MAAS doesn't support TLS encryption natively.  If you are not interested in [setting up an HAProxy](/t/high-availability/2692#heading--load-balancing-with-haproxy-optional), you can enable TLS independently in the web server software (e.g. Apache, Nginx) which users access directly.  The examples below explain how to create this configuration.
 deb-2-9-cli -->

<!-- deb-2-9-ui
MAAS doesn't support TLS encryption natively.  If you are not interested in [setting up an HAProxy](/t/high-availability/2693#heading--load-balancing-with-haproxy-optional), you can enable TLS independently in the web server software (e.g. Apache, Nginx) which users access directly.  The examples below explain how to create this configuration.
 deb-2-9-ui -->

<!-- deb-3-0-cli
MAAS doesn't support TLS encryption natively.  If you are not interested in [setting up an HAProxy](/t/high-availability/3947#heading--load-balancing-with-haproxy-optional), you can enable TLS independently in the web server software (e.g. Apache, Nginx) which users access directly.  The examples below explain how to create this configuration.
 deb-3-0-cli -->

<!-- deb-3-0-ui
MAAS doesn't support TLS encryption natively.  If you are not interested in [setting up an HAProxy](/t/high-availability/3948#heading--load-balancing-with-haproxy-optional), you can enable TLS independently in the web server software (e.g. Apache, Nginx) which users access directly.  The examples below explain how to create this configuration.
 deb-3-0-ui -->

<!-- snap-2-9-cli
MAAS doesn't support TLS encryption natively.  If you are not interested in [setting up an HAProxy](/t/high-availability/2686#heading--load-balancing-with-haproxy-optional), you can enable TLS independently in the web server software (e.g. Apache, Nginx) which users access directly.  The examples below explain how to create this configuration.
 snap-2-9-cli -->

<!-- snap-2-9-ui
MAAS doesn't support TLS encryption natively.  If you are not interested in [setting up an HAProxy](/t/high-availability/2687#heading--load-balancing-with-haproxy-optional), you can enable TLS independently in the web server software (e.g. Apache, Nginx) which users access directly.  The examples below explain how to create this configuration.
 snap-2-9-ui -->

<!-- snap-3-0-cli
MAAS doesn't support TLS encryption natively.  If you are not interested in [setting up an HAProxy](/t/high-availability/3945#heading--load-balancing-with-haproxy-optional), you can enable TLS independently in the web server software (e.g. Apache, Nginx) which users access directly.  The examples below explain how to create this configuration.
 snap-3-0-cli -->

MAAS doesn't support TLS encryption natively.  If you are not interested in [setting up an HAProxy](/t/high-availability/3946#heading--load-balancing-with-haproxy-optional), you can enable TLS independently in the web server software (e.g. Apache, Nginx) which users access directly.  The examples below explain how to create this configuration.

Note that MAAS doesn't bind to port 80; instead, MAAS binds to port 5240.

<a href="#heading--nginx"><h2 id="heading--nginx">nginx example config</h2></a>

    server {
     listen 443 ssl;

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