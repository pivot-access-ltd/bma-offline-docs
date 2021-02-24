
Candid is an identity service which extends macaroon-based authentication. The candid service is important in configuring RBAC for MAAS, so you may want to review this [brief tutorial].

<a href="#heading--installing-candid"><h3 id="heading--installing-candid">Installing candid</h3></a>

The easiest way to start using the service is with the snap:

```
snap install candid
```

<a href="#heading--candid-login"><h3 id="heading--candid-login">Candid login</h3></a>

IdM supports these following three login methods:

1. Interactive
2. Agent
3. UbuntuSSO OAuth

Interactive is used by default and does not require any special handling by the client software, it does require interaction with the user so is not suitable for all situations.

All of these login methods are initiated as part of the macaroon handling and need to be handled in the VisitWebPage function provided to httpbakery.Client.

<a href="#heading--interactive-login"><h4 id="heading--interactive-login">Interactive login</h4></a>

Interactive login is the default. For the client to use interactive login it needs to arrange for the user to visit the provided web address.

Interactive login currently uses UbuntuSSO OpenID login. It is anticipated this will be expanded in the future.

<a href="#heading--agent-login"><h4 id="heading--agent-login">Agent login</h4></a>

Agents are users in the system that represents services rather than people. Agents must have been pre-registered with the identity manager.

<a href="#heading--login-method-discovery"><h4 id="heading--login-method-discovery">Login method discovery<h4></a>

When a client makes a discharge request and Candid doesn't know about the client, it will return an *interaction-required* error containing information about the available login methods. For example:

```
   {
       "Code": "interaction required",
       "Message": "interaction required",
       "Info": {
           "InteractionMethods": {
               "agent": {
                   "login-url": "https://candid-address/login/agent"
               },
               "browser-window": {
                   "VisitURL": "https://candid-address/login",
                   "WaitURL": "https://candid-address/wait"
               }
           }
       }
   }

```

For agent login use the `login-url` field. Each entry in the `InteractionMethods` object specifies a different protocol to follow. All the protocols result in the client gaining a *discharge token*. The client can make the original discharge again with that discharge token to obtain the discharge macaroon.

<a href="#heading--agent-login-request"><h3 id="heading--agent-login-request">Agent login request<h3></a>

To perform the agent login the client POSTs a JSON object like the following to the specified agent URL:

```
   {
      "username": "...",
      "public_key": "...",
   }
```

The parameter `username` contains the username of the identity agent that is logging in. The parameter `public_key` contains a base64 encoding of the public key that will be used to authenticate the agent.

When identity discharges a third-party caveat for the agent, an additional third-party caveat is added forcing the agent to prove it has the private key associated with the public key. This part is handled by httpbakery.

<a href="#heading--code-example"><h3 id="heading--code-example">Code example</h3></a>

```
   func AgentDo(req *http.Request, username string, key *bakery.KeyPair) (*http.Response, error) {
      client = httpbakery.NewClient()
      client.Key = key
      client.VisitWebPage = func(u *url.URL) error {
         req, err := http.NewRequest("GET", u.String(), nil)
         if err != nil {
            return err
         }
         resp, err := client.Do(req)
         if err != nil {
            return err
         }
         defer resp.Close()
         body, err := ioutil.ReadAll(resp.Body)
         if err != nil {
            return err
         }
         var methods params.LoginMethods
         if err := json.Unmarshal(body, &methods); err != nil {
            return err
         }
         if methods.Agent == "" {
            return errors.New("agent login not supported")
         }
         body, err := json.Marshal(params.AgentLoginRequest{
            Username:  username,
            PublicKey: key.Public,
         })
         if err != nil {
            return err
         }
         req, err = http.NewRequest("POST", methods.Agent, nil)
         if err != nil {
            return err
         }
         resp, err = client.DoWithBody(req, bytes.NewReader(body))
         if err != nil {
            return err
         }
         defer resp.Close()
         if resp.StatusCode != http.StatusOK {
            return errors.New("login failed")
         }
         return nil
      }
      return client.Do(req)
   }
```

<a href="#heading--ubuntusso-oauth-login"><h2 id="heading--ubuntusso-oauth-login">UbuntuSSO OAuth login<h2></a>

UbuntuSSO OAuth login provides a non-interactive method for user logins. To use the oauth mechanism the client must have obtained an oauth token from UbuntuSSO to use with this mechanism.

For the login to work the user must have previously logged in using interactive login at least once.

<a href="#heading--login-method-discovery"><h3 id="heading--login-method-discovery">Login method discovery</h3></a>

Any client that wishes to use UbuntuSSO Oauth login must perform login method discovery (see above). The URL to use is "usso_oauth".

<a href="#heading--ubuntusso-login-request"><h3 id="heading--ubuntusso-login-request">UbuntuSSO login request<h3></a>

A client should then send a GET request to the "usso_oauth" URL that has been signed using the oauth token as specified in [RFC5849](http://tools.ietf.org/html/rfc5849).

<a href="#heading--sso-code-example"><h3 id="heading--sso-code-example">Code example</h3></a>

```
   func OAuthDo(req *http.Request, tok oauth.Token) (*http.Response, error) {
      client = httpbakery.NewClient()
      client.VisitWebPage = func(u *url.URL) error {
         req, err := http.NewRequest("GET", u.String(), nil)
         if err != nil {
            return err
         }
         resp, err := client.Do(req)
         if err != nil {
            return err
         }
         defer resp.Close()
         body, err := ioutil.ReadAll(resp.Body)
         if err != nil {
            return err
         }
         var methods params.LoginMethods
         if err := json.Unmarshal(body, &methods); err != nil {
            return err
         }
         if methods.UbuntuSSOOAuth == "" {
            return errors.New("UbuntuSSO OAuth login not supported")
         }
         req, err = http.NewRequest("GET", methods.UbuntuSSOOAuth, nil)
         if err != nil {
            return err
         }
         oauth.Sign(req, tok)
         resp, err = client.Do(req, bytes.NewReader(body))
         if err != nil {
            return err
         }
         defer resp.Close()
         if resp.StatusCode != http.StatusOK {
            return errors.New("login failed")
         }
         return nil
      }
      return client.Do(req)
   }
```

**Note** that the oauth handling in the above snippet is idealised and does not represent any known library.

<a href="#heading--candid-configuration"><h3 id="heading--candid-configuration">Candid configuration</h3></a>

This section describes the configuration options for the Candid identity server.

<a href="#heading--candid-config-file"><h4 id="heading--candid-config-file">Candid configuration file</h4></a>

Candid loads its configuration at startup from a YAML file. In a usual installation, this file is stored in `/etc/candid/config.yaml`. An example configuration file is:

```
listen-address: :8081
location: 'http://jujucharms.com/identity'
storage:
    type: mongodb
    address: localhost:27017
public-key: OAG9EVDFgXzWQKIk+MTxpLVO1Mp1Ws/pIkzhxv5Jk1M=
private-key: q2G3A2NjTe7MP9D8iugCH9XfBAyrnV8n8u8ACbNyNOY=
identity-providers:
- type: usso
```

Here is a description of the most commonly-used configuration options. Some less useful options are omitted from this section and documented [here](https://godoc.org/github.com/CanonicalLtd/candid/config#Config).

* **listen-address** (Required) - This is the address that the service will listen on. This consists of an optional host followed by a port. If the host is omitted then the server will listen on all interface addresses. The port may be a well known service name for example ":http".

* **location** (Required) - This is the externally addressable location of the Candid server API. Candid needs to know its own address so that it can add third-party caveats addressed to itself and to create response addresses for identity providers such as OpenID that use browser redirection for communication.

* **storage** (Optional) - Storage holds configuration for the storage backend used by the server. See below for documentation on the supported storage backends.

* **public-key** & **private-key** (Required) - Services wishing to discharge caveats against this identity manager encrypt their third party caveats using this public-key. The private key is needed for the identity manager to be able to discharge those caveats. You can use the bakery-keygen command (available with go install gopkg.in/macaroon-bakery.v2/cmd/bakery-keygen to generate a suitable key pair.

* **access-log** (Optional) - The access-log configures the name of a file used to record all accesses to the identity manager. If this is not configured then no logging will take place.

* **identity-providers** (Optional) - This is a list of the configured identity providers with their configuration. See below for the supported identity providers. If this is not configured then a default set of providers will be used containing the Ubuntu SSO and Agent identity providers.

* **api-macaroon-timeout** (Optional) - This is the maximum time a login to the /v1 API will remain logged in for. As candid uses itself as it's authentication provider, for all practical purpose the login time will be the minimum of api-macaroon-timeout and discharge-macaroon-timeout. The default value is 24 hours.

* **discharge-macaroon-timeout** (Optional) - This is the maximum time the discharge macaroon will be valid for on the target service. This is the maximum time the client will be able to access the target service without requiring re-authentication. Note that the target service may also have it's own maximum time.

* **discharge-token-timeout** (Optional) - This is the maximum time that the discharge token issued to the client can be used to discharge tokens without requiring re-authentication.

<a href="#heading--storage-backends"><h4 id="heading--storage-backends">Storage backends</h4></a>

The storage field holds an object containing a type field which names the storage backend to use; for example:

```
storage:
    type: mongodb
    address: localhost:1234
```

Currently supported backends are as follows:

* **memory** - The memory provider has no extra parameters. It stores all data ephemerally in RAM.

* **mongodb** - This uses MongoDB for the backend. It has two parameters:

  * *address* (required) is the address of the mongoDB server to connect to, in host:port form.
  
  * *database* holds the database name to use. If not specified, this will default to candid.

* **postgres** - This uses PostgresQL for the backend. It takes one parameter:

  * *connection-string* is the connection string to use when connecting to the database. This is added to connection string parameters already present as environment variables when making a connection. See [here](https://godoc.org/github.com/lib/pq#hdr-Connection_String_Parameters) for details.

<a href="#heading--identity-providers"><h4 id="heading--identity-providers">Identity providers</h4></a>

The identity manager can support a number of different identity providers. These can be broken loosely into two categories, interactive and custom. Interactive providers use html based forms in some way to authorize the user and are compatible with the most basic supported clients. Custom providers use a protocol not necessarily supported in the client to provide additional authentication methods that are not necessarily based around users interacting with web pages. While it is possible to configure more than one interactive identity provider in a given identity manager, in most case this does not make sense as the identity manager will only use the first one that is found.

<a href="#heading--iprov-agent"><h5 id="heading--iprov-agent">Agent</h5></a>

The agent identity provider is a custom provider that is always configured, and allows non-interactive logins to clients using public-key authentication. the agent protocol to log in. See above for details on the agent login protocol.

<a href="#heading--iprov-ubuntusso"><h5 id="heading--iprov-ubuntusso">UbuntuSSO</h5></a>

The UbuntuSSO identity provider is an interactive identity provider that uses OpenID with UbuntuSSO to log in.

- type: usso
  launchpad-teams:
    - group1pp
    - group2


The launchpad-teams contains any private launchpad teams that candid needs to know about.

<a href="#heading--iprov-ubuntusso-oauth"><h5 id="heading--iprov-ubuntusso-oauth">UbuntuSSO OAuth</h5></a>

The UbuntuSSO OAuth identity provider is an custom identity provider that uses a previously obtained UbuntuSSO OAuth token to log in.

- type: usso_oauth

Keystone

- type: keystone
  name: mydevstack
  domain: mydevstack
  description: Mydevstack
  url: https://keystone.mydevstack.somewhere.com:443/
  hidden: false

The Keystone identity provider is an interactive identity provider that uses a keystone service to log the user in using their openstack credentials.

The Keystone identity provider has a number of additional options.

The name parameter specifies the name of the provider, this should be a short name that reflects the name of the system being logged in to. The name is used in some URLS and is best if it consists only of lower-case letters.

The domain is a string added to the names of users logging in through this identity provider. The user jsmith for example would be changed to jsmith@mydevstack in the configuration above. If no domain is specified the username will remain unchanged.

The description is optional and will be used if the identity provider is presented in a human readable form, if this is not set the name will be used.

The url is the location of the keystone server that will be used to authenticate the user.

The hidden value is an optional value that can be used to not list this identity provider in the list of possible identity providers when performing an interactive login.
Keystone Token

- type: keystone_token
  name: jujugui
  domain: mydevstack
  description: Mydevstack
  url: https://keystone.mydevstack.somewhere.com:443/

The Keystone Token identity provider is a custom identity provider that uses a keystone service to authenticate a user that already has a keystone authentication token by logging in previously through some external means. It is designed to be used in jujugui system embedded in horizon services to prevent a user having to log in twice.

The Keystone Token identity provider has a number of additional options.

The name parameter specifies the name of the provider. The name is used in some URLS and is best if it consists only of lower-case letters. The name "jujugui" can be used to indicate to a jujugui instance that this provider can be used to log in with an existing token.

The domain is a string added to the names of users logging in through this identity provider. The user jsmith for example would be changed to jsmith@mydevstack in the configuration above. If no domain is specified the username will remain unchanged.

The description is optional and will be used if the identity provider is presented in a human readable form, if this is not set the name will be used.

The url is the location of the keystone server that will be used to authenticate the user.
Keystone Userpass

- type: keystone_userpass
  name: form
  domain: mydevstack
  description: Mydevstack
  url: https://keystone.mydevstack.somewhere.com:443/
  

The Keystone Userpass identity provider is a custom identity provider that uses a keystone service to authenticate users that have provided their username and password through a form mechanism in the client. It is designed to allow credentials to be provided through a CLI where web page access is not practical.

The Keystone Userpass identity provider has a number of additional options.

The name parameter specifies the name of the provider. The name is used in some URLS and is best if it consists only of lower-case letters. The name "form" can be used to indicate to clients that support the form protocol that the protocol can be used.

The domain is a string added to the names of users logging in through this identity provider. The user jsmith for example would be changed to jsmith@mydevstack in the configuration above. If no domain is specified the username will remain unchanged.

The description is optional and will be used if the identity provider is presented in a human readable form, if this is not set the name will be used.

The url is the location of the keystone server that will be used to authenticate the user.
Azure OpenID Connect

- type: azure
  client-id: 43444f68-3666-4f95-bd34-6fc24b108019
  client-secret: tXV2SRFflAGT9sUdxkdIi7mwfmQ=
  hidden: false

The Azure identity provider uses OpenID Connect to log in using Microsoft credentials via https://login.live.com. When a user first logs in with this IDP they will be prompted to create a new identity. The new identity must have a unique username and will be in the domain "@azure".

The client-id and client-secret parameters must be specified and are created by registering the candid instance as an application at https://apps.dev.microsoft.com. When registering the application the redirect URLs should include $CANDID_URL/login/azure/callback.

The hidden value is an optional value that can be used to not list this identity provider in the list of possible identity providers when performing an interactive login.
Google OpenID Connect

- type: google
  client-id: 483156874216-rh0j89ltslhuqirk7deh70d3mp49kdvq.apps.googleusercontent.com
  client-secret: 8aENrwCL/+PU87ROkXwMB+09xe0=
  hidden: false

The Google identity provider uses OpenID Connect to log in using Google credentials. When a user first logs in with this IDP they will be prompted to create a new identity. The new identity must have a unique username and will be in the domain "@google".

The client-id and client-secret parameters must be specified and are created by registering the candid instance as an application at https://console.developers.google.com/apis/credentials. When registering the application the authorized redirect URLs should include $CANDID_URL/login/google/callback.

The hidden value is an optional value that can be used to not list this identity provider in the list of possible identity providers when performing an interactive login.
Keycloak OpenID Connect

- type: keycloak
  domain: example
  client-id: 483156874216
  client-secret: 32hf3uhud23dS@#e
  keycloak-realm: https://example.com/auth/realms/example
  hidden: false

The Keycloak identity provider uses OpenID Connect to log in using configured credentials. When a user first logs in with this IDP they will be prompted to create a new identity. The new identity must have a unique username and will be in the domain specified "@domain", otherwise default to "@KEYCLOAK".

The 'keycloak-realm and client-id parameters must be specified and should be provided by the keycloak service administrator. An optional client-secret may also be required which the keycloak service administrator should provide.

When registering the application the authorized redirect URLs should include $CANDID_URL/login/keycloak/callback.

The hidden value is an optional value that can be used to not list this identity provider in the list of possible identity providers when performing an interactive login.


### LDAP
```yaml
- type: ldap
  name: ldap
  description: LDAP Login
  domain: example
  url: ldap://ldap.example.com/dc=example,dc=com
  ca-cert: |
    -----BEGIN CERTIFICATE-----
    MIIBWTCCAQOgAwIBAgIBADANBgkqhkiG9w0BAQsFADAbMRkwFwYDVQQDExBsZGFw
    LmV4YW1wbGUuY29tMB4XDTE4MDQxODEwMDUzMVoXDTI4MDQyMDEwMDUzMVowGzEZ
    MBcGA1UEAxMQbGRhcC5leGFtcGxlLmNvbTBcMA0GCSqGSIb3DQEBAQUAA0sAMEgC
    QQDN2tltcVwW0bs80ABocjSZrqBDnpuxnzq2DlrLL+hldwDxVZ0sqU+o768GB6bP
    8k3WVf81yYBRbfq7pD/MX0BhAgMBAAGjMjAwMA8GA1UdEwEB/wQFMAMBAf8wHQYD
    VR0OBBYEFEMAeAXsITzTXHDfJSzrezBkaSvwMA0GCSqGSIb3DQEBCwUAA0EAw6Rh
    RlR4L5mvvDaN4NP/aNOaWGe+x1Oa7V3L75MmD3DbwcUgDCn45EaUGofbOTrbYuzm
    mrVoMF002dpQoqc38w==
    -----END CERTIFICATE-----
  dn: cn=candid,dc=example,dc=com
  password: 6IaWWtW/aTN0CIVYwLgeOayyZW8o
  user-query-filter: (objectClass=account)
  user-query-attrs:
    id: uid
    email: mail
    display-name: displayName
  group-query-filter: (&(objectClass=groupOfNames)(member={{.User}}))
  hidden: false

The LDAP identity provider allows a user to login using an LDAP server. Candid will prompt for a username and password and attempt to use those to authenticate with the LDAP server.

name is the name to use for the LDAP IDP instance. It is possible to configure more than one LDAP IDP on a given candid server and this allows them to be identified. The name will be used in the login URL.

description (optional) provides a human readable description of the identity provider. If it is not set it will default to the value of name.

domain (optional) is the domain in which all identities will be created. If this is not set then no domain is used.

url contains the URL of the LDAP server being authenticated against. The path component of the URL is used as the base DN for the connection.

ca-cert (optional) contains the CA certificate that signed the LDAPs server certificate. If this is not set then the connection either has to be unauthenticated or the CA certificate has to be in the system's certificate pool.

dn (optional) contains the distinguished name that candid uses to bind to the LDAP server to perform searches. If this is not configured then candid binds anonymously and password is ignored.

password (optional) contains the password used when candid binds to the LDAP server.

user-query-filter contains the filter that candid uses when attempting to find the user that is authenticating.

user-query-attrs contains the attributes candid uses when searching for authenticating users. When authenticating a user candid will perform a search like ($id=$username) where the value of $id is specified in the id parameter and $username is the value entered by the authenticating user. email and display-name are used to populate the created identity.

group-query-filter contains the filter candid uses when finding group memberships for a user. The filter is specified as a template (see https://golang.org/pkg/text/template) where the value of .User will be replaced with the DN of the user for whom candid is attempting to find group memberships.

The hidden value is an optional value that can be used to not list this identity provider in the list of possible identity providers when performing an interactive login.
Static identity provider

- type: static
  name: static
  domain: mydomain
  description: Static Identity Provider
  users:
    user1:
      name: User One
      email: user1@example.com
      password: password1
      groups: [group1, group2]
    user2:
      name: User Two
      email: user2@example.com
      password: password2
      groups: [group3, group4]
  hidden: false

The static identity provider is meant for testing and allows defining a set of users that can authenticate, along with their passwords and a list of groups they are part of.

Note that this provider is not meant for production use as it's insecure.

name is the name to use for the LDAP IDP instance. It is possible to configure more than one LDAP IDP on a given candid server and this allows them to be identified. The name will be used in the login URL.

domain (optional) is the domain in which all identities will be created. If this is not set then no domain is used.

description (optional) provides a human readable description of the identity provider. If it is not set it will default to the value of name.

users contains a static mapping of username to user entries for all of the users defined by the identity provider.

The hidden value is an optional value that can be used to not list this identity provider in the list of possible identity providers when performing an interactive login.
Charm Configuration

If the candid charm is being used then most of the parameters will be set with sensible defaults.

The charm parameters that must be configured for each deployment are:

    password
    private-key
    public-key
    location

Most deployments will probably also want to configure the identity-providers unless the default ones are being used.
