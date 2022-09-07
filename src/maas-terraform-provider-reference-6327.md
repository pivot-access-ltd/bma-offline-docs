<!-- "MAAS Terraform provider reference" -->
If you wish to use MAAS with [Terraform](https://www.terraform.io/), there is a [provider avaiable](https://github.com/maas/terraform-provider-maas), supplied by a third party.  This article provides reference information about the data sources and resources available through the provider.  It does not attempt to explain the mechanics or usage of Terraform or offer any tutorial information related to this MAAS Terraform provider.

<a href="#heading--what-is-this"><h1 id="heading--what-is-this">The MAAS Terraform provider</h1></a>

The MAAS provider is a Terraform provider that allows you to manage MAAS resources using the Terraform (CRUD) tool. This provider can be used to manage many aspects of a MAAS environment, including networking, users, machines, and VM hosts.

These aspects can be divided into three categories of Terraform-compliant HCL:

- [API linkages](#heading--terraform-api-linkage)
- [Data sources](#heading--data-sources)
- [Resources](#heading--resources)

We will deal with each of these categories in turn.  For each data source and resource, we will offer a brief definition and description of how that item is employed in MAAS.  If you are new to [Terraform](https://www.terraform.io/), or want to explore what terraforming may provide for your MAAS instance, you may wish to consult the [Terraform documentation](https://www.terraform.io/intro) or one of the many [tutorials available](https://learn.hashicorp.com/collections/terraform/aws-get-started?utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS).

<a href="#heading--terraform-api-linkage"><h2 id="heading--terraform-api-linkage">API linkages</h2></a>

The schema that provides an API linkage to MAAS from Terraform consists of a standard HCL provider block and a provider API block.  As with all Terraform providers, the provider block contains at least two items:

- a source element, which in this case is "maas/maas".
- a version element, which can be sufficiently specified by "~>1.0".

The provider block would look something like this:

```nohighlight
terraform {
  required_providers {
    maas = {
      source  = "maas/maas"
      version = "~>1.0"
    }
  }
}
```

The provider API block contains the necessary credentials to allow Terraform to access your MAAS instance, which include three things:

- an API version.
- an API key.
- an API URL.

A typical provider API block might look like this:

```nohighlight
provider "maas" {
  api_version = "2.0"
  api_key = "<YOUR API KEY>"
  api_url = "http://127.0.0.1:5240/MAAS"
}
```

A completed definition would also include some data sources and resources, like this typical example:

```nohighlight
terraform {
  required_providers {
    maas = {
      source  = "maas/maas"
      version = "~>1.0"
    }
  }
}

provider "maas" {
  api_version = "2.0"
  api_key = "<YOUR API KEY>"
  api_url = "<YOUR API URL>"
}

resource "maas_space" "tf_space" {
  name = "tf-space"
}

resource "maas_fabric" "tf_fabric" {
  name = "tf-fabric"
}

resource "maas_vlan" "tf_vlan" {
  fabric = maas_fabric.tf_fabric.id
  vid = 14
  name = "tf-vlan14"
  space = maas_space.tf_space.name
}
resource "maas_subnet" "tf_subnet" {
  cidr = "10.88.88.0/24"
  fabric = maas_fabric.tf_fabric.id
  vlan = maas_vlan.tf_vlan.vid
  name = "tf_subnet"
  gateway_ip = "10.88.88.1"
  dns_servers = [
    "1.1.1.1",
  ]
  ip_ranges {
    type = "reserved"
    start_ip = "10.88.88.1"
    end_ip = "10.88.88.50"
  }
  ip_ranges {
    type = "dynamic"
    start_ip = "10.88.88.200"
    end_ip = "10.88.88.254"
  }
}
```

See the [Terraform HCL documentation](https://www.terraform.io/language) for more details about these blocks.

<a href="#heading--data-sources"><h2 id="heading--data-sources">Data sources</h2></a>

<a href="#heading--resources"><h2 id="heading--resources">Resources</h2></a>