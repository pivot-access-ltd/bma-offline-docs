MAAS provides a way for its managed machines to use a proxy server when they need to access HTTP/HTTPS-based resources, such as the Ubuntu package archive.

There are three possible options:

-   internal proxy (default)
-   external proxy
-   no proxy

Configuring a proxy with MAAS consists of enabling/disabling one of the above three options and enabling/disabling proxying on a specific subnet.

#### Quick questions you may have:

* [How and why should I create an internal proxy?](#heading--internal-proxy-maas-proxy)
* [How and why should I create an external proxy?](#heading--configure-proxy)

<h2 id="heading--internal-proxy-maas-proxy">Internal proxy (MAAS proxy)</h2>

MAAS provides an internal proxy server. Although it is set up to work well with APT/package requests, it is effectively an HTTP caching proxy server. If you configure the MAAS region controller as the default gateway for the machines it manages then the proxy will work transparently (on TCP port 3128). Otherwise, machines will need to access it on TCP port 8000.

By default, the proxy is available to all hosts residing in any subnet detected by MAAS, not just MAAS-managed machines. It is therefore recommended to disable access to those subnets that represent untrusted networks.

<!-- deb-2-7-ui deb-2-7-cli deb-2-8-ui deb-2-8-cli deb-2-9-ui deb-2-9-cli
MAAS manages its proxy. So although the active configuration, located in file `/var/lib/maas/maas-proxy.conf`, can be inspected, it is not to be hand-edited.

You must install the proxy on the same host as the region controller (via the 'maas-proxy' package).
deb-2-7-ui deb-2-7-cli deb-2-8-ui deb-2-8-cli deb-2-9-ui deb-2-9-cli -->

<!-- snap-2-7-ui snap-2-7-cli snap-2-8-ui snap-2-8-cli snap-2-9-ui snap-2-9-cli
MAAS manages its proxy. So although the active configuration, located in file `/var/snap/maas/current/proxy`, can be inspected, it is not to be hand-edited. The proxy is automatically installed with the MAAS snap.
snap-2-7-ui snap-2-7-cli snap-2-8-ui snap-2-8-cli snap-2-9-ui snap-2-9-cli -->

<h2 id="heading--configure-proxy">Configure proxy</h2>

<!-- snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli
Enabling and disabling proxying, in general, is done via a boolean option ('true' or 'false'). The following command will disable proxying completely:

``` bash
maas $PROFILE maas set-config name=enable_http_proxy value=false
```

To set an external proxy, ensure proxying is enabled (see above) and then define it:

``` bash
maas $PROFILE maas set-config name=http_proxy value=$EXTERNAL_PROXY
```

For example,

``` bash
maas $PROFILE maas set-config name=enable_http_proxy value=true
maas $PROFILE maas set-config name=http_proxy value=http://squid.example.com:3128/
```

Enabling and disabling proxying per subnet is done via a boolean option ('true' or 'false'). Here is how you can disable proxying on a per-subnet basis:

``` bash
maas $PROFILE subnet update $SUBNET_CIDR allow_proxy=false
```

For example,

``` bash
maas $PROFILE subnet update 192.168.0.0/22 allow_proxy=false
```

snap-2-7-cli snap-2-8-cli snap-2-9-cli deb-2-7-cli deb-2-8-cli deb-2-9-cli -->

<!-- snap-2-7-ui snap-2-8-ui snap-2-9-ui deb-2-7-ui deb-2-8-ui deb-2-9-ui
In the web UI, visit the 'Settings' page and select the 'Network services' tab. The 'Proxy' section is at the top. You can apply your changes by pressing the 'Save' button.

<a href="https://assets.ubuntu.com/v1/55800a33-installconfig-network-proxy__2.4_configure-proxy.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/55800a33-installconfig-network-proxy__2.4_configure-proxy.png"></a>

To enable the internal proxy, ensure that the checkbox adjacent to 'MAAS Built-in' is selected. This internal proxy is the default configuration.

To enable an external proxy, activate the 'External' checkbox and use the new field that is displayed to define the proxy's URL (and port if necessary).

An upstream cache peer can be defined by enabling the 'Peer' checkbox and entering the external proxy URL into the field. With this enabled, machines will be configured to use the MAAS built-in proxy to download cached APT packages.

To prevent MAAS machines from using a proxy, enable the 'Don't use a proxy' checkbox.
snap-2-7-ui snap-2-8-ui snap-2-9-ui deb-2-7-ui deb-2-8-ui deb-2-9-ui -->

[note type="caution"]Note that the proxy service will still be running[/note]
