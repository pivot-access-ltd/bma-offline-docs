#!/bin/bash

tabstage1 about-cloud-networks-5808.md 3.2
tabstage1 about-controllers-5072.md 3.2
tabstage1 about-dhcp-5807.md 3.2
tabstage1 about-images-5076.md 3.2
tabstage1 about-maas-5064.md 3.2
tabstage1 about-machines-5080.md 3.2
tabstage1 about-networking-5084.md 3.2
tabstage1 about-tcp-ip-networks-5806.md 3.2
tabstage1 about-vm-hosting-5068.md 3.2
tabstage1 api-authentication-reference-5060.md 3.2
tabstage1 audit-event-log-reference-5256.md 3.2
tabstage1 commissioning-log-reference-5248.md 3.2
tabstage1 commissioning-scripts-reference-5375.md 3.2
tabstage1 event-log-reference-5252.md 3.2
tabstage1 get-started-with-maas-5092.md 3.2
tabstage1 hardware-test-scripts-reference-5392.md 3.2
tabstage1 how-to-back-up-maas-5096.md 3.2
tabstage1 how-to-build-maas-images-5100.md 3.2
tabstage1 how-to-contact-us-5448.md 3.2
tabstage1 how-to-create-a-custom-ubuntu-image-5104.md 3.2
tabstage1 how-to-customise-machines-5108.md 3.2
tabstage1 how-to-deploy-machines-5112.md 3.2
tabstage1 how-to-enable-high-availability-5120.md 3.2
tabstage1 how-to-enable-tls-encryption-5116.md 3.2
tabstage1 how-to-get-help-5428.md 3.2
tabstage1 how-to-help-improve-the-doc-4186.md 3.2
tabstage1 how-to-import-images-5124.md 3.2
tabstage1 how-to-install-maas-5128.md 3.2
tabstage1 how-to-manage-availability-zones-5152.md 3.2
tabstage1 how-to-manage-dhcp-5132.md 3.2
tabstage1 how-to-manage-ip-ranges-5136.md 3.2
tabstage1 how-to-manage-machine-interfaces-5156.md 3.2
tabstage1 how-to-manage-machines-5160.md 3.2
tabstage1 how-to-manage-networks-5164.md 3.2
tabstage1 how-to-manage-proxies-5168.md 3.2
tabstage1 how-to-manage-racks-5172.md 3.2
tabstage1 how-to-manage-regions-5176.md 3.2
tabstage1 how-to-manage-user-accounts-5184.md 3.2
tabstage1 how-to-manage-vm-hosts-5140.md 3.2
tabstage1 how-to-manage-vms-5148.md 3.2
tabstage1 how-to-manage-vmware-images-5144.md 3.2
tabstage1 how-to-mirror-images-locally-5188.md 3.2
tabstage1 how-to-search-maas-5192.md 3.2
tabstage1 how-to-secure-maas-5196.md 3.2
tabstage1 how-to-set-up-maas-metrics-5204.md 3.2
tabstage1 how-to-set-up-ntp-5200.md 3.2
tabstage1 how-to-set-up-postgresql-ha-hot-standby.md 3.2
tabstage1 how-to-troubleshoot-maas-5333.md 3.2
tabstage1 how-to-upgrade-maas-5436.md 3.2
tabstage1 how-to-use-controller-tags-5216.md 3.2
tabstage1 how-to-use-image-streams-5220.md 3.2
tabstage1 how-to-use-lxd-5208.md 3.2
tabstage1 how-to-use-maas-in-an-air-gapped-environment-5212.md 3.2
tabstage1 how-to-use-machine-tags-5224.md 3.2
tabstage1 how-to-use-network-tags-5228.md 3.2
tabstage1 how-to-use-storage-tags-5232.md 3.2
tabstage1 how-to-use-the-maas-cli-5236.md 3.2
tabstage1 how-to-work-with-annotations-5929.md 3.2
tabstage1 how-to-work-with-tags-5928.md 3.2
tabstage1 maas-concepts-and-terms-reference-5416.md 3.2
tabstage1 maas-logging-reference-5240.md 3.2
tabstage1 power-management-reference-5246.md 3.2
tabstage1 python-api-client-reference-5404.md 3.2
tabstage1 test-log-reference-5314.md 3.2
tabstage1 tips-and-tricks-5329.md 3.2
tabstage1 what-is-new-with-maas-5292.md 3.2
cat ./src/maas-documentation-25.md > /tmp/staging/maas-documentation-25.md
tab2html "v3.2 Snap" "UI" "MAAS Documentation" -i ./src/maas-documentation-25.md -l -L /tmp/staging/log/tab2html.log -o /tmp/staging/production-html-snap/ui/maas-documentation-25.html -t ./html-support/templates/3.2/snap/ui/template.html
tab2html "v3.2 Packages" "UI" "MAAS Documentation" -i ./src/maas-documentation-25.md -l -L /tmp/staging/log/tab2html.log -o /tmp/staging/production-html-deb/ui/maas-documentation-25.html -t ./html-support/templates/3.2/deb/ui/template.html
tab2html "v3.2 Snap" "CLI" "MAAS Documentation" -i ./src/maas-documentation-25.md -l -L /tmp/staging/log/tab2html.log -o /tmp/staging/production-html-snap/cli/maas-documentation-25.html -t ./html-support/templates/3.2/snap/cli/template.html
tab2html "v3.2 Packages" "CLI" "MAAS Documentation" -i ./src/maas-documentation-25.md -l -L /tmp/staging/log/tab2html.log -o /tmp/staging/production-html-deb/cli/maas-documentation-25.html -t ./html-support/templates/3.2/deb/cli/template.html

