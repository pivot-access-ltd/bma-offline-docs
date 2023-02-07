This howto shows how to deploy a machine with Ubuntu and configure it to use a [real-time kernel](https://ubuntu.com/blog/real-time-linux-qa).

The real-time kernel is included in all [Ubuntu Pro](https://ubuntu.com/pro) subscriptions for Ubuntu 22.04 LTS.

[note]
The RT kernel is currently in Beta and scheduled for general availability in the near future.
[/note]

## Understanding how the RT kernel is deployed

While the real-time kernel isn't included in MAAS as a kernel to use, we use cloud-init to first deploy the machine with a generic kernel. The cloud-init kicks in and installs the real-time kernel, and then finally reboots the machine in order to make use of the newly installed kernel.

This means that after the machine has been marked as DEPLOYED in MAAS, there will be a delay until cloud-init has finished running and the machine finishes rebooting.

If you execute the steps in the previous section, MAAS is going to execute the tasks:

1. Deploy this machine with `Ubuntu 22.04 LTS` and a stock kernel
2. Reboot the machine
3. Tell the machine's bootloader to boot from disk
4. The host initialises and asks MAAS for its configuration
5. MAAS builds and sends the host cloud-init configuration, combining the base options with the snippet above
6. Cloud-init enables Ubuntu Pro in this machine
7. Ubuntu Pro agent downloads and installs the RT kernel.
8. Cloud-init reboots the machine again to enable the new kernel
9. The system is ready

## Requirements

1. A valid Ubuntu Pro token (go to https://ubuntu.com/pro/dashboard to find your token)
2. MAAS 3.2 or later with Ubuntu 22.04 LTS images synchronized
3. A host compatible with Ubuntu RT kernel
4. Internet connection

At this moment it's not possible to install the RT kernel without Internet access in the host.

## How to deploy a machine with RT kernel enabled

All steps should be performed in MAAS UI.

To deploy an RT kernel:

1. Enlist/Commission the host as usual

2. Select the host and click `Deploy`

3. Select `Ubuntu` and `Ubuntu 22.04 LTS "Jammy Jellyfish"` as OS and Release respectively

4. Select `Cloud-init user-data`

5. Use the following snippet as template, remember to replace `YOUR_TOKEN` with a valid value

    ```
    #cloud-config
    power_state:
    mode: reboot
    ubuntu_advantage:
    token: YOUR_TOKEN
    enable:
    - esm-infra
    - realtime-kernel
    ```

6. Click `Start deployment for machine`

## How to verify the deployment

The following command can be executed in the host to check if the RT kernel was enabled with success

1. `pro status`
   ```text
    SERVICE          ENTITLED  STATUS    DESCRIPTION
    esm-infra        yes       enabled   Expanded Security Maintenance for Infrastructure
    realtime-kernel  yes       enabled   Ubuntu kernel with PREEMPT_RT patches integrated
   ```

2. `uname -a`
    ```
    Linux vm01 5.15.0-1030-realtime #33-Ubuntu SMP PREEMPT_RT Mon Jan 9 17:28:40 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
    ```