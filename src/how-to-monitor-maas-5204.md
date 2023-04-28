<!-- "How to observe a live MAAS" -->
[tabs]
[tab version="v3.3 Snap,v3.3 Packages,v3.2 Snap,v3.2 Packages"]
We aim to make MAAS observable, a system in which the internal state can be estimated using only telemetry data. We now offer easier integration with Prometheus and Loki, which are the data ingestion components of the popular Grafana / Prometheus / Loki / AlarmManager stack. This data should be consumed by a stack composed of off-the-shelf open source software, provided by either Juju (for example with the Canonical Observability Stack) or third-parties (SaaS, self-managed).

In this document, you will learn:

- [About MAAS observability](#heading--about-maas-observability)
- [How to configure and use MAAS observability features](#heading--how-to-use-maas-observability-features)
 
<a href="#heading--about-maas-observability"><h2 id="heading--about-maas-observability">About MAAS observability</h2></a>

Depicted below we have a reference observability stack composed of Prometheus (metrics ingestion and alerting based on metrics), Loki (log ingestion and alerting based on logs), Grafana (visualisation), Alertmanager (notification routing and dispatching) and Grafana Agent (telemetry collector).

<a href="https://discourse.maas.io/uploads/default/optimized/2X/d/d6f66cbb3ea314818894b4f07ca8037628993ae2_2_690x437.png" target = "_blank">![](upload://eGnGAB4W9qzA8wgGzGaWozgmMTl.png)</a>

This document shows how to configure this stack to consume telemetry and to raise alerts of failures.

<a href="#heading--maas-observability-requirements"><h3 id="heading--maas-observability-requirements">MAAS observability requirements</h3></a>

- a Ubuntu host with MAAS 3.2+ running
- a Ubuntu host with enough storage capacity to hold logs and metrics' time-series

Both hosts require Internet access during the install process. We use LXD to create this setup in a single host, but it's optional. When configuring the stack for a production environment, we advise you to read the Prometheus and Loki documentation to improve security and performance.

<a href="#heading--how-to-use-maas-observability-features"><h2 id="heading--how-to-use-maas-observability-features">How to use MAAS observability features</h2></a>

Observing MAAS requires three steps: configuring the tool stack, exporting the telemetry, and then verifying that everything is working properly.  This section will show you:

- [How to configure the observability stack](#heading--configuring-the--observability-stack)
- [How to export MAAS controller telemetry](#heading--how-to-export-maas-controller-telemetry)
- [How to verify correct operation](#heading--how-to-verify-correct-operation)

<a href="#heading--configuring-the--observability-stack"><h3 id="heading--configuring-the--observability-stack">How to configure the observability stack</h3></a>

Create a VM with the following script to install all required software.

```bash
export LXD_NET=virbr0
export GRAFANA_REPOS=https://packages.grafana.com/oss/deb
export GRAFANA_KEY=https://packages.grafana.com/gpg.key
export LOKI_PKG=https://github.com/grafana/loki/releases/download/v2.4.2/loki-linux-amd64.zip
export PROM_PKG=https://github.com/prometheus/prometheus/releases/download/v2.31.1/prometheus-2.31.1.linux-amd64.tar.gz
export PROM_ALERT_PKG=https://github.com/prometheus/alertmanager/releases/download/v0.23.0/alertmanager-0.23.0.linux-amd64.tar.gz

cat <<EOF | lxc launch ubuntu: o11y
config:
    user.user-data: |
        #cloud-config
        apt:
            sources:
                grafana:
                    source: 'deb ${GRAFANA_REPOS} stable main'
                    key: |
$(wget -qO- ${GRAFANA_KEY} | sed 's/^/                        /')
        packages:
        - unzip
        - grafana
        - make
        - git
        - python3-pip
        runcmd:
        - mkdir -p /opt/prometheus /opt/loki /opt/alertmanager
        - wget -q "${LOKI_PKG}" -O /tmp/loki-linux-amd64.zip
        - unzip /tmp/loki-linux-amd64.zip -d /opt/loki
        - chmod a+x /opt/loki/loki-linux-amd64
        - wget -qO- "${PROM_PKG}" | tar xz --strip-components=1 -C /opt/prometheus
        - wget -qO- "${PROM_ALERT_PKG}" | tar xz --strip-components=1 -C /opt/alertmanager
        - cat /dev/zero | sudo -u ubuntu -- ssh-keygen -q -N ""
        ssh_authorized_keys:
        - $(cat ${HOME}/.ssh/id_rsa.pub | cut -d' ' -f1-2)
description: O11y stack
devices:
    eth0:
        type: nic
        name: eth0
        network: ${LXD_NET}
EOF

# log into the VM
lxc shell 011y
```

Next, you have to configure and start four services, include Prometheus, Loki, AlertManager, and Grafana.  This subsection will teach you:

- [How to configure and start the Prometheus service](#heading--how-to-configure-and-start-the-prometheus-service)
- [How to configure and start the Loki service](#heading--how-to-configure-and-start-the-loki-service)
- [How to start the AlertManager](#heading--how-to-start-the-alertmanager)
- [How to start Grafana](#heading--how-to-start-grafana)

Once these services are started, you can proceed to export telemetry data and see how your observability tools are working.

<a href="#heading--how-to-configure-and-start-the-prometheus-service"><h4 id="heading--how-to-configure-and-start-the-prometheus-service">How to configure and start the Prometheus service</h4></a>

Create the Prometheus configuration.

```bash
cat > /opt/prometheus/prometheus.yaml <<EOF
global:
  evaluation_interval: 1m
rule_files:
  - /var/lib/prometheus/rules/maas/*.yml
alerting:
  alertmanagers:
    - static_configs:
      - targets:
        - localhost:9093
EOF
```

MAAS has a git repository of curated alert rules for Prometheus. Checkout this repository, compile the rules and copy them to prometheus directory.

```bash
git clone https://github.com/canonical/maas-prometheus-alert-rules.git
cd maas-prometheus-alert-rules
make python-deps groups

mkdir -p /var/lib/prometheus/rules/maas
cp group.yml /var/lib/prometheus/rules/maas/
```

Start the Prometheus service. You should enable the *Remote-Write Receiver* function.

```bash
systemd-run -u prometheus /opt/prometheus/prometheus \
    --config.file=/opt/prometheus/prometheus.yaml \
    --enable-feature=remote-write-receiver
```

<a href="#heading--how-to-configure-and-start-the-loki-service"><h4 id="heading--how-to-configure-and-start-the-loki-service">How to configure and start the Loki service</h4></a>

Create the Loki configuration.

```bash
cat > /opt/loki/loki.yaml <<EOF
auth_enabled: false
server:
  http_listen_port: 3100
  grpc_listen_port: 9096
common:
  path_prefix: /var/lib/loki/
  storage:
    filesystem:
      chunks_directory: /var/lib/loki/chunks
      rules_directory: /var/lib/loki/rules
  replication_factor: 1
  ring:
    instance_addr: 127.0.0.1
    kvstore:
      store: inmemory
schema_config:
  configs:
    - from: 2020-10-24
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h
ruler:
  alertmanager_url: http://localhost:9093
  evaluation_interval: 15s
  poll_interval: 1m
  storage:
    type: local
    local:
      directory: /var/lib/loki/rules
  enable_api: true
EOF
```

MAAS has a git repository of curated alert rules for Loki. Checkout this repository, compile the rules and copy them to Loki directory.

```bash
git clone https://github.com/canonical/maas-loki-alert-rules.git
cd maas-loki-alert-rules
make groups

mkdir -p /var/lib/loki/rules/fake
cp rules/bundle.yml /var/lib/loki/rules/fake/
```

Start the Loki service.

```bash
systemd-run -u loki /opt/loki/loki-linux-amd64 \
    --config.file=/opt/loki/loki.yaml
```

<a href="#heading--how-to-start-the-alertmanager"><h4 id="heading--how-to-start-the-alertmanager">How to start the AlertManager</h4></a>

The default configuration is enough for receiving alerts from Prometheus and Loki. You should read the project documentation to change it to forward notifications to somewhere useful.

```bash
systemd-run -u alertmanager /opt/alertmanager/alertmanager \
    --config.file=/opt/alertmanager/alertmanager.yml
```

You can access the AlertManager dashboard at `http://<VM_IP>:9093`

<a href="#heading--how-to-start-grafana"><h4 id="heading--how-to-start-grafana">How to start Grafana</h4></a>

Grafana works out-of-the-box with the default configuration.

```bash
systemctl enable grafana-server
systemctl start grafana-server
```

You can access the dashboard at `http://<VM_IP>:3000`, the default user/password is "admin".

<a href="#heading--how-to-export-maas-controller-telemetry"><h3 id="heading--how-to-export-maas-controller-telemetry">How to export MAAS controller telemetry</h3></a>

The Grafana Agent should be installed in the same host as MAAS.

```bash
# Set this to the address of the VM running Loki and Prometheus
export O11y_IP=<VM_IP>
export GRAFANA_AGENT_PKG=https://github.com/grafana/agent/releases/download/v0.22.0/agent-linux-amd64.zip

wget -q "${GRAFANA_AGENT_PKG}" -O /tmp/agent.zip
unzip /tmp/agent.zip -d /opt/agent
chmod a+x /opt/agent/agent-linux-amd64
```

Copy the agent example configuration from MAAS and start the agent. Adapt the environment variable values to your setup.  For example, if you're using a snap, the `MAAS_LOGS` variable would be as shown (`/var/snap/maas/common/log`):

```bash
mkdir -p /var/lib/grafana-agent/positions \
         /var/lib/grafana-agent/wal
cp /snap/maas/current/usr/share/maas/grafana_agent/agent.yaml.example /opt/agent/agent.yml

systemd-run -u telemetry \
    -E HOSTNAME="$(hostname)" \
    -E AGENT_WAL_DIR="/var/lib/grafana-agent/wal" \
    -E AGENT_POS_DIR="/var/lib/grafana-agent/positions" \
    -E PROMETHEUS_REMOTE_WRITE_URL="http://${O11y_IP}:9090/api/v1/write" \
    -E LOKI_API_URL="http://${O11y_IP}:3100/loki/api/v1/push" \
    -E MAAS_LOGS="/var/snap/maas/common/log/" \
    -E MAAS_IS_REGION="true" \
    -E MAAS_IS_RACK="true" \
    -E MAAS_AZ="default" \
    /opt/agent/agent-linux-amd64 \
        -config.expand-env \
        -config.file=/opt/agent/agent.yml
```

On the other hand, if you're using packages, the `MAAS_LOGS` would be `/var/log/maas`, as shown below:

```bash
    ...
    -E MAAS_LOGS="/var/log/maas" \
    ...
```

Be sure to adjust the values of the other environment variables to suit your situation, where applicable.

Next, enable log forwarding in MAAS.

```bash
# set the TCP port the Grafana Agent is listening for syslog messages
# this port must match the one in /opt/agent/agent.yml
maas $ADMIN maas set-config name=promtail_port value=5238

# enable syslog forwarding
maas $ADMIN maas set-config name=promtail_enabled value=true
```

<a href="#heading--how-to-verify-correct-operation"><h3 id="heading--how-to-verify-correct-operation">How to verify correct operation</h3></a>

You should be able to add Loki and Prometheus as datasources in Grafana and to create dashboards for visualising MAAS metrics, and to receive alerts through Alertmanager.
[/tab]
[tab version="v3.1 Snap,v3.1 Packages,v3.0 Snap,v3.0 Packages,v2.9 Snap,v2.9 Packages"]
MAAS services can provide [Prometheus](https://prometheus.io/)`↗` endpoints for collecting performance metrics.

<a href="#heading--how-to-set-up-prometheus-for-maas"><h2 id="heading--how-to-set-up-prometheus-for-maas">How to set up Prometheus for MAAS</h2></a>

MAAS can provide five endpoints of particular interest to MAAS users:

1.   TFTP server file transfer latency
2.   HTTP requests latency
3.   Websocket requests latency
4.   RPC calls (between MAAS services) latency
5.   Per request DB queries counts

All available metrics are prefixed with `maas_`, to make it easier to look them up in Prometheus and Grafana UIs.

#### This article will help you learn:

- [How do I enable Prometheus endpoints?](#heading--enabling-prometheus-endpoints)
- [How do I configure Prometheus endpoints?](#heading--configuring-prometheus)
- [How can I deploy Prometheus and Grafana?](#heading--deploying-prometheus-and-grafana)

<a href="#heading--enabling-prometheus-endpoints"><h3 id="heading--enabling-prometheus-endpoints">Enabling Prometheus endpoints</h3></a>

Whenever you install the `python3-prometheus-client` library, Prometheus endpoints are exposed over HTTP by the `rackd` and `regiond` processes under the default `/metrics` path.

[note]
Currently, prometheus metrics are shared when rack and region controllers are running on the same machine, even though each service provides its own port.  You can safely only query one of the two ports if you're running both controllers.
[/note]

[tabs]
[tab version="v3.1 Snap,v3.0 Snap,v2.9 Snap"]
For a vb Snap-based MAAS installation, the libraries already included in the snap so that metrics will be available out of the box.
[/tab]
[tab version="v3.1 Packages,v3.0 Packages,v2.9 Packages"]
For a Debian-based MAAS installation, install the library and restart MAAS services as follows:

    sudo apt install python3-prometheus-client
    sudo systemctl restart maas-rackd
    sudo systemctl restart maas-regiond

MAAS also provides optional stats about resources registered with the MAAS server itself.  These include four broad categories of information:

1.   The number of nodes by type, arch, ...
2.   Number of networks, spaces, fabrics, VLANs and subnets
3.   Total counts for machines CPU cores, memory and storage
4.   Counters for VM host resources

After installing the `python3-prometheus-client` library as describe above, run the following to enable stats:

    maas $PROFILE maas set-config name=prometheus_enabled value=true
[/tab]
[/tabs]

<a href="#heading--configuring-prometheus"><h3 id="heading--configuring-prometheus">Configuring Prometheus</h3></a>

Once the `/metrics` endpoint is available in MAAS services, Prometheus can be configured to scrape metric values from these. You can configure this by adding a stanza like the following to the [prometheus configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration/)`↗`:

``` yaml
    - job_name: maas
      static_configs:
        - targets:
          - <maas-host1-IP>:5239  # for regiond
          - <maas-host1-IP>:5249  # for rackd
          - <maas-host2-IP>:5239  # regiond-only
          - <maas-host3-IP>:5249  # rackd-only
```

If the MAAS installation includes multiple nodes, the `targets` entries must be adjusted accordingly, to match services deployed on each node.

If  you have enabled MAAS stats,  you must add an additional Prometheus job to the config:

``` yaml
    - job_name: maas
      metrics_path: /MAAS/metrics
      static_configs:
        - targets:
          - <maas-host-IP>:5240
```

In case of a multi-host deploy, adding a single IP for any of the MAAS hosts running `regiond` will suffice.

<a href="#heading--deploying-prometheus-and-grafana"><h3 id="heading--deploying-prometheus-and-grafana">Deploying Prometheus and Grafana</h3></a>

[Grafana](https://grafana.com/)`↗` and Prometheus can be easily deployed using Juju.

The [MAAS performance repo](https://git.launchpad.net/~maas-committers/maas/+git/maas-performance)`↗` repository provides a sample `deploy-stack` script that will deploy and configure the stack on LXD containers.

First, you must install juju via:

    sudo snap install --classic juju

Then you can run the script from the repo:

    grafana/deploy-stack <MAAS-IP>

To follow the progress of the deployment, run the following:

    watch -c juju status --color

Once you deploy everything, the Grafana UI is accessible on port `3000` with the credentials `admin`/`grafana`. The Prometheus UI will be available on port `9090`.

The repository also provides some sample dashboard covering the most common use cases for graphs. These are available under `grafana/dashboards`.  You can import them from the Grafana UI or API.
[/tab]
[/tabs]