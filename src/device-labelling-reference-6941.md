<!-- "Devcie labelling reference" -->
<a href="#heading--tag-definition-reference"><h2 id="heading--tag-definition-reference">Tag definition reference examples</h2></a>

Here are some examples of tag definitions -- [more examples are available](https://github.com/canonical/mxt)`↗`.

Commonly used Xpath functions usually include:

* contains
* starts-with
* ends-with

### Example 1

This definition will identify machines with proper CPU tags, cores, and RAM, and tag them as a hypervisor:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d1c8e2674445045ee9c8c9f1d14f3fa413af9be8.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d1c8e2674445045ee9c8c9f1d14f3fa413af9be8.png"></a>

This example looks for at least 40 cores and 256 GB of RAM and has all the required CPU features for being a hypervisor for both Intel and AMD.

[note]
Don't forget to adjust cores and RAM (in bytes) to suit your particular needs and available resources.
[/note]

You can also define this tag with the CLI:

```nohighlight
maas ${MAAS_PROFILE} tags create name=hypervisor \
definition='//node[@id="memory"]/size >= "274877906944" and \
//node[@id="cpu"]/configuration/setting/id="cores" >= 40 and \
//node[@id="cpu"]//capabilities/capability/@id = "vmx" or @id="svm" and \
//node[@id="cpu"]//capabilities/capability/@id = "aes" and 
//node[@id="cpu"]//capabilities/capability/@id = "flexpriority" and 
//node[@id="cpu"]//capabilities/capability/@id = "tpr_shadow" and 
//node[@id="cpu"]//capabilities/capability/@id = "ept" and 
//node[@id="cpu"]//capabilities/capability/@id = "vpid" and 
//node[@id="cpu"]//capabilities/capability/@id = "vnmi"'
```

### Example 2

This will tag UEFI enabled KVM VMs running on AMD-based servers:

<a href="https://discourse.maas.io/uploads/default/original/2X/a/adde5f51e396a3a2d2f70daad7787fe087723664.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/a/adde5f51e396a3a2d2f70daad7787fe087723664.png"></a>

You can also do this with the CLI:

```nohighlight
maas ${MAAS_PROFILE} tags create \
name=kvm-amd-uefi \
definition='//node[@class="system"]/vendor = "QEMU" and //node[@id="firmware"]/capabilities/capability/@id = "virtualmachine" and //node[@id="firmware"]/capabilities/capability/@id = "uefi" and //node[@class="processor"]/vendor[starts-with(.,"Advanced Micro Devices")]' \
kernel_opts='nomodeset console=tty0 console=ttyS0,115200n8 amd_iommu=on kvm-amd.nested=1 kvm-amd.enable_apicv=n kvm.ignore_msrs=1' \
comment='Tag for automatically identifying AMD-based KVM vms (UEFI BIOS)'
```

### Example 3

This will automatically tag servers that have NVME controllers:

<a href="https://discourse.maas.io/uploads/default/original/2X/1/166cd775669610ba454b5f2883e7729b79770bd0.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/1/166cd775669610ba454b5f2883e7729b79770bd0.png"></a>

To accomplish the same thing in the CLI:

```nohighlight
maas ${MAAS_PROFILE} tags create name=NVME comment="xpath tag for automatically tagging servers that have NVME controllers" definition='//node[@id="storage" and @class="storage"]/description = "Non-Volatile memory controller"'
```

### Example 4

This will tag servers with Mellanox ConnectX-5 NICs:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/34ed75cf40ded49ac5eb8d76467817b5618b11a9.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/34ed75cf40ded49ac5eb8d76467817b5618b11a9.png"></a>

And you can also do this in the CLI:

```nohighlight
maas ${MAAS_PROFILE} tags create \
name=connectx-5 \
definition='//node[@class="network"]/vendor[starts-with(.,"Mellanox")] and //node[@class="network"]/product[contains(.,"ConnectX-5")]' \
comment='Tag for automatically identifying servers with Mellanox Technologies ConnectX-5 cards'
```

### Example 5

This will enable GPU passthrough for Nvidia Quadro K series GPUs on AMD:

<a href="https://discourse.maas.io/uploads/default/original/2X/3/3f258d7e98c0adc7b605b8d2846b76737d46a27e.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/3/3f258d7e98c0adc7b605b8d2846b76737d46a27e.png"></a>

You can also duplicate this example in the CLI:

```nohighlight
maas ${MAAS_PROFILE} tags create \
name=gpgpu-quadro-k-a \
comment="Enable passthrough for Nvidia Quadro K series GPUs on AMD" \
definition='//node[@id="cpu:0"]/capabilities/capability/@id = "svm" and //node[@id="display"]/vendor[contains(.,"NVIDIA")] and //node[@id="display"]/description[contains(.,"3D")] and //node[@id="display"]/product[contains(.,"Quadro K")]'
```
