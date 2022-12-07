<!-- "API authentication reference" -->
The MAAS API uses [OAuth](http://en.wikipedia.org/wiki/OAuth) as its authentication mechanism. This isn't third-party (3-legged) OAuth, so the process used is what's commonly referred to as 0-legged OAuth: the consumer accesses protected resources by submitting OAuth signed requests.

Note that some API endpoints support unauthenticated requests (i.e. anonymous access). This article will help you learn:

- [How to perform authenticated requests in Python](#heading--python)
- [How to perform authenticated requests in Ruby](#heading--ruby)

Here are two examples on how to perform an authenticated GET request to retrieve the list of nodes. The &lt;consumer_key&gt;, &lt;consumer_token&gt;, &lt;secret&gt; tokens are the three elements that compose the API key (API key = '&lt;consumer_key&gt;:&lt;consumer_token&gt;:&lt;secret&gt;').

<a href="#heading--python"><h2 id="heading--python">How to perform authenticated requests in Python</h2></a>

Note: the below example uses [fades](https://fades.readthedocs.io/)`↗`, but you can also install the `requests_oauthlib` ([pypi link](https://pypi.org/project/requests-oauthlib/)`↗`) and `oauthlib` ([pypi link](https://pypi.org/project/oauthlib/)`↗`) packages with `pip`. Replace `<MAAS_SERVER_IP>` with your server's IP address, and `<API-KEY>` with your API key.

``` python
from oauthlib.oauth1 import SIGNATURE_PLAINTEXT # fades
from requests_oauthlib import OAuth1Session # fades

MAAS_HOST = "http://<MAAS_SERVER_IP>:5240/MAAS"
CONSUMER_KEY, CONSUMER_TOKEN, SECRET = "<API-KEY>".split(":")

maas = OAuth1Session(CONSUMER_KEY, resource_owner_key=CONSUMER_TOKEN, resource_owner_secret=SECRET, signature_method=SIGNATURE_PLAINTEXT)

nodes = maas.get(f"{MAAS_HOST}/api/2.0/machines/", params={"op": "list_allocated"})
nodes.raise_for_status()

print(nodes.json())
```

<a href="#heading--ruby"><h2 id="heading--ruby">How to perform authenticated requests in Ruby</h2></a>

``` ruby
require 'oauth'
require 'oauth/signature/plaintext'

def perform_API_request(site, uri, key, secret, consumer_key)
    consumer = OAuth::Consumer.new(
        consumer_key, "",
        { :site => "http://localhost:5240/MAAS/api/2.0",
          :scheme => :header, :signature_method => "PLAINTEXT"})
    access_token = OAuth::AccessToken.new(consumer, key, secret)
    return access_token.request(:get, "/nodes/?op=list")
end

# API key = "<consumer_key>:<key>:<secret>"
response = perform_API_request(
     "http://server:5240/MAAS/api/2.0", "/nodes/?op=list", "<key>", "<secret>",
     "consumer_key>")
```
