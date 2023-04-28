<!-- "How to use images" -->
When using MAAS, it's important to understand how to manage images. By default, every deployed machine runs an image provided by MAAS. These images can be either standard or custom and are downloaded from a stream or local mirror.

- [Standard images](/t/how-to-use-standard-images/5124): Standard images include a broad inventory of Ubuntu versions for different architectures. However, if you need to deploy other types of images, such as CentOS, RHEL, Rocky, SLES, or even Windows, MAAS also supports [custom images](/t/how-to-customise-images/5104).

- [VMWare images](/t/how-to-employ-vmware-images/5144): Additionally, MAAS also supports deploying VMWare images to appropriate virtual machine configurations.

- [Local image mirroring](/t/how-to-mirror-images-locally/5927): To speed up image downloads, MAAS allows for local image mirroring. This feature allows for faster downloads by storing images locally rather than downloading them from the internet.

- [RT kernel](/t/how-to-deploy-a-real-time-kernel/6658): For those who need a real-time kernel, MAAS makes it simple to deploy one with cloud-init. 

Whether you're deploying standard or custom images, from remote or local sources, MAAS offers a wide range of options, along with tools to streamline the process.
