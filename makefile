# targets

TARGET := originals/about-maas.html
TARGET += originals/adding-a-vm-host.md
TARGET += originals/add-machines.md
TARGET += originals/api-authentication.md
TARGET += originals/api.md
TARGET += originals/audit-event-logs.md
TARGET += originals/availability-zones.md
TARGET += originals/backup.md
TARGET += originals/block-devices.md
TARGET += originals/candid-tutorial.md
TARGET += originals/cli-advanced-tasks.md
TARGET += originals/cli-composable-hardware.md
TARGET += originals/cli-image-management.md
TARGET += originals/cli-interface-management.md
TARGET += originals/cli-kernel-management.md
TARGET += originals/commissioning-and-hardware-testing-scripts.md
TARGET += originals/commissioning-logs.md
TARGET += originals/commission-machines.md
TARGET += originals/common-cli-tasks.md
TARGET += originals/concepts-and-terms.md
TARGET += originals/configuration-journey.md
TARGET += originals/configuring-tls-encryption.md
TARGET += originals/contact-us.md
TARGET += originals/controllers.md
TARGET += originals/creating-a-custom-ubuntu-image.md
TARGET += originals/creating-and-deleting-vms.md
TARGET += originals/custom-machine-setup.md
TARGET += originals/deploy-machines.md
TARGET += originals/disk-erasure.md
TARGET += originals/event-logs.md
TARGET += originals/getting-help.md
TARGET += originals/give-me-an-example-of-maas.md
TARGET += originals/hardening-your-maas-installation.md
TARGET += originals/hardware-testing.md
TARGET += originals/high-availability.md
TARGET += originals/images.md
TARGET += originals/interactive-search.md
TARGET += originals/ip-ranges.md
TARGET += originals/ipv6-addressing.md
TARGET += originals/kernel-boot-options.md
TARGET += originals/language-details-contributing-to-maas-docs.md
TARGET += originals/local-image-mirror.md
TARGET += originals/maas-cli.md
TARGET += originals/maas-communication.md
TARGET += originals/maas-documentation.md
TARGET += originals/maas-image-builder.md
TARGET += originals/maas-installation.md
TARGET += originals/maas-logging.md
TARGET += originals/maas-requirements.md
TARGET += originals/maas-tags.md
TARGET += originals/machine-logs.md
TARGET += originals/machines.md
TARGET += originals/managing-dhcp.md
TARGET += originals/managing-stp.md
TARGET += originals/network-discovery.md
TARGET += originals/networking.md
TARGET += originals/network-testing.md
TARGET += originals/ntp-services.md
TARGET += originals/package-repositories.md
TARGET += originals/partitions.md
TARGET += originals/postgresql-ha-hot-standby.md
TARGET += originals/power-management.md
TARGET += originals/prometheus-metrics.md
TARGET += originals/proxy.md
TARGET += originals/python-api-client.md
TARGET += originals/rack-controllers.md
TARGET += originals/region-controllers.md
TARGET += originals/resource-pools.md
TARGET += originals/select-and-import-images.md
TARGET += originals/storage.md
TARGET += originals/subnet-management.md
TARGET += originals/test-logs.md
TARGET += originals/the-cli-cookbook.md
TARGET += originals/tips-tricks-and-traps.md
TARGET += originals/troubleshooting.md
TARGET += originals/ubuntu-kernels.md
TARGET += originals/user-accounts.md
TARGET += originals/using-image-streams.md
TARGET += originals/using-maas-in-an-air-gapped-environment.md
TARGET += originals/using-rbac-with-maas.md
TARGET += originals/vm-hosting.md
TARGET += originals/vm-host-networking.md
TARGET += originals/vm-host-storage-pools.md
TARGET += originals/vmware-images.md
TARGET += originals/vmware-vmfs-datastores.md
TARGET += originals/whats-new-in-maas.md
TARGET += originals/writing-guide.md
TARGET += originals/zone-examples.md

# tag variables; enables changing more easily later
D27 := deb/2.7
D28 := deb/2.8
D29 := deb/2.9
S27 := snap/2.7
S28 := snap/2.8
S29 := snap/2.9
D27C := deb/2.7/cli
D27U := deb/2.7/ui
D28C := deb/2.8/cli
D28U := deb/2.8/ui
D29C := deb/2.9/cli
D29U := deb/2.9/ui
S27C := snap/2.7/cli
S27U := snap/2.7/ui
S28C := snap/2.8/cli
S28U := snap/2.8/ui
S29C := snap/2.9/cli
S29U := snap/2.9/ui
D27CT := deb-2-7-cli
D27UT := deb-2-7-ui
D28CT := deb-2-8-cli
D28UT := deb-2-8-ui
D29CT := deb-2-9-cli
D29UT := deb-2-9-ui
S27CT := snap-2-7-cli
S27UT := snap-2-7-ui
S28CT := snap-2-8-cli
S28UT := snap-2-8-ui
S29CT := snap-2-9-cli
S29UT := snap-2-9-ui

# production version - all versions get built, but this variable
#  controls which ones get copied to production dirs on build complete
PROD_VSN := 2.9

# where to find templates
TEMP := templates

# staging directory
STAGING := staging

# production HTML directories
PROD_DEB := production-html-deb
PROD_SNAP := production-html-snap

# phone header for all and clean
.PHONY: all clean

all: post-build

pre-build:
	mkdir -p backup
	mkdir -p staging
	mkdir -p staging/deb/2.7/ui
	mkdir -p staging/snap/2.7/ui
	mkdir -p staging/deb/2.8/ui
	mkdir -p staging/snap/2.8/ui
	mkdir -p staging/deb/2.9/ui
	mkdir -p staging/snap/2.9/ui
	mkdir -p staging/deb/2.7/cli
	mkdir -p staging/snap/2.7/cli
	mkdir -p staging/deb/2.8/cli
	mkdir -p staging/snap/2.8/cli
	mkdir -p staging/deb/2.9/cli
	mkdir -p staging/snap/2.9/cli

post-build: main-build
	cp -R $(STAGING)/deb/$(PROD_VSN)/ui $(PROD_DEB)
	cp -R $(STAGING)/deb/$(PROD_VSN)/cli $(PROD_DEB)
	cp -R $(STAGING)/snap/$(PROD_VSN)/ui $(PROD_SNAP)
	cp -R $(STAGING)/snap/$(PROD_VSN)/cli $(PROD_SNAP)
	cp -R $(STAGING)/snap/$(PROD_VSN)/* $(PROD_SNAP)
	cp -R $(STAGING)/deb/$(PROD_VSN)/* $(PROD_DEB)
	cp -R images $(PROD_DEB)/ui
	cp -R images $(PROD_DEB)/cli
	cp -R images $(PROD_SNAP)/ui
	cp -R images $(PROD_SNAP)/cli
	cp -R css $(PROD_DEB)/ui
	cp -R css $(PROD_DEB)/cli
	cp -R css $(PROD_SNAP)/ui
	cp -R css $(PROD_SNAP)/cli

main-build: pre-build $(TARGET)

originals/%.html: originals/%.md
	# base computation
	$(eval BASE = $(notdir $<))
	echo $(BASE) 
	# base must be changed to make, so copy current base
	#   to a /tmp, which also won't break the timestamp
	cp -p $(BASE) /tmp/$(BASE)
	cp scripts/strip-navigation.sh /tmp
	# strip navigation & RAD menus
	cd /tmp && ./strip-navigation.sh $(BASE)
	cd /tmp && sed -i "/|| 2.7/d" $(BASE)
	cd /tmp && sed -i "/||2.7/d" $(BASE)
	cd /tmp && sed -i "/|-----:|:-----:/d" $(BASE)
	cd /tmp && sed -i "/\[CLI\]/d" $(BASE)
	cd /tmp && sed -i 's/\[note.*\]/<strong>NOTE:<\/strong> /g' $(BASE)
	cd /tmp && sed -i 's/\[\/note.*\]//g' $(BASE)
	# compute HTML filename
	$(eval HTML = $(basename $(notdir $@)).html)
	# run deb-2-7-cli version of html
	cp templates/$(D27C)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(D27CT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(D27CT)//g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(D27C)
	# run deb-2-7-ui version of html
	cp templates/$(D27U)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(D27UT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(D27UT)//g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(D27U)
	# run deb-2-8-cli version of html
	cp templates/$(D28C)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(D28CT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-/-$(D28T)/g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(D28C)
	# run deb-2-8-ui version of html
	cp templates/$(D28U)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(D28UT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(D28UT)//g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(D28U)
	# run deb-2-9-cli version of html
	cp templates/$(D29C)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(D29CT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(D29CT)//g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(D29C)
	# run deb-2-9-ui version of html
	cp templates/$(D29U)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(D28UT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(D28UT)//g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(D28U)
	# run snap-2-7-cli version of html
	cp templates/$(S27C)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(S27CT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(S27CT)//g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(S27CU)
	# run snap-2-7-ui version of html
	cp templates/$(S27U)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(S27UT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(S27UT)//g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(S27U)
	# run snap-2-8-cli version of html
	cp templates/$(S28C)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(S28CT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(S28CT)//g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(S28C)
	# run snap-2-8-ui version of html
	cp templates/$(S28U)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(S28UT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(S28UT)//g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(S28U)
	# run snap-2-9-cli version of html
	cp templates/$(S29C)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(S29CT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(S29CT)//g' $(HTML)
	mv /tmp/$(HTML) $(STAGING)/$(S29C)
	# run snap-2-9-ui version of html
	cp templates/$(S29U)/template.html /tmp
	cd /tmp && sed -i "s|zork|$(HTML)|g" ./template.html
	cd /tmp && xpub convert dc2html -t $(S29UT) $(BASE)
	cd /tmp && sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cd /tmp && sed -i 's/-$(S29UT)//g' $(HTML)
	cp /tmp/$(HTML) $(STAGING)/$(S29U)
	# copy last html file to originals as makefile reference
	mv /tmp/$(HTML) ./originals

#a

originals/about-maas.md: about-maas.md
	cp about-maas.md about-maas-deb-2-7-cli-2268.md
	cp about-maas.md about-maas-deb-2-7-ui-2269.md
	cp about-maas.md about-maas-deb-2-8-cli-2270.md
	cp about-maas.md about-maas-deb-2-8-ui-2271.md
	cp about-maas.md about-maas-deb-2-9-cli-2272.md
	cp about-maas.md about-maas-deb-2-9-ui-2273.md
	cp about-maas.md about-maas-snap-2-7-cli-2262.md
	cp about-maas.md about-maas-snap-2-7-ui-2263.md
	cp about-maas.md about-maas-snap-2-8-cli-2264.md
	cp about-maas.md about-maas-snap-2-8-ui-2265.md
	cp about-maas.md about-maas-snap-2-9-cli-2266.md
	cp about-maas.md about-maas-snap-2-9-ui-2267.md
	xpub push discourse -t deb-2-7-cli about-maas-deb-2-7-cli-2268.md
	xpub push discourse -t deb-2-7-ui about-maas-deb-2-7-ui-2269.md
	xpub push discourse -t deb-2-8-cli about-maas-deb-2-8-cli-2270.md
	xpub push discourse -t deb-2-8-ui about-maas-deb-2-8-ui-2271.md
	xpub push discourse -t deb-2-9-cli about-maas-deb-2-9-cli-2272.md
	xpub push discourse -t deb-2-9-ui about-maas-deb-2-9-ui-2273.md
	xpub push discourse -t snap-2-7-cli about-maas-snap-2-7-cli-2262.md
	xpub push discourse -t snap-2-7-ui about-maas-snap-2-7-ui-2263.md
	xpub push discourse -t snap-2-8-cli about-maas-snap-2-8-cli-2264.md
	xpub push discourse -t snap-2-8-ui about-maas-snap-2-8-ui-2265.md
	xpub push discourse -t snap-2-9-cli about-maas-snap-2-9-cli-2266.md
	xpub push discourse -t snap-2-9-ui about-maas-snap-2-9-ui-2267.md
	xpub pull discourse 2273 2273
	cp -p about-maas-deb-2-9-ui-2273.md originals/about-maas.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
adding-a-vm-host.md: ../adding-a-vm-host.md
	cp ../adding-a-vm-host.md adding-a-vm-host-deb-2-7-cli-2292.md
	cp ../adding-a-vm-host.md adding-a-vm-host-deb-2-7-ui-2293.md
	cp ../adding-a-vm-host.md adding-a-vm-host-deb-2-8-cli-2294.md
	cp ../adding-a-vm-host.md adding-a-vm-host-deb-2-8-ui-2295.md
	cp ../adding-a-vm-host.md adding-a-vm-host-deb-2-9-cli-2296.md
	cp ../adding-a-vm-host.md adding-a-vm-host-deb-2-9-ui-2297.md
	cp ../adding-a-vm-host.md adding-a-vm-host-snap-2-7-cli-2286.md
	cp ../adding-a-vm-host.md adding-a-vm-host-snap-2-7-ui-2287.md
	cp ../adding-a-vm-host.md adding-a-vm-host-snap-2-8-cli-2288.md
	cp ../adding-a-vm-host.md adding-a-vm-host-snap-2-8-ui-2289.md
	cp ../adding-a-vm-host.md adding-a-vm-host-snap-2-9-cli-2290.md
	cp ../adding-a-vm-host.md adding-a-vm-host-snap-2-9-ui-2291.md
	xpub push discourse -t deb-2-7-cli adding-a-vm-host-deb-2-7-cli-2292.md
	xpub push discourse -t deb-2-7-ui adding-a-vm-host-deb-2-7-ui-2293.md
	xpub push discourse -t deb-2-8-cli adding-a-vm-host-deb-2-8-cli-2294.md
	xpub push discourse -t deb-2-8-ui adding-a-vm-host-deb-2-8-ui-2295.md
	xpub push discourse -t deb-2-9-cli adding-a-vm-host-deb-2-9-cli-2296.md
	xpub push discourse -t deb-2-9-ui adding-a-vm-host-deb-2-9-ui-2297.md
	xpub push discourse -t snap-2-7-cli adding-a-vm-host-snap-2-7-cli-2286.md
	xpub push discourse -t snap-2-7-ui adding-a-vm-host-snap-2-7-ui-2287.md
	xpub push discourse -t snap-2-8-cli adding-a-vm-host-snap-2-8-cli-2288.md
	xpub push discourse -t snap-2-8-ui adding-a-vm-host-snap-2-8-ui-2289.md
	xpub push discourse -t snap-2-9-cli adding-a-vm-host-snap-2-9-cli-2290.md
	xpub push discourse -t snap-2-9-ui adding-a-vm-host-snap-2-9-ui-2291.md
	xpub pull discourse 2297 2297
	cp -p adding-a-vm-host-deb-2-9-ui-2297.md adding-a-vm-host.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
add-machines.md: ../add-machines.md
	cp ../add-machines.md add-machines-deb-2-7-cli-2280.md
	cp ../add-machines.md add-machines-deb-2-7-ui-2281.md
	cp ../add-machines.md add-machines-deb-2-8-cli-2282.md
	cp ../add-machines.md add-machines-deb-2-8-ui-2283.md
	cp ../add-machines.md add-machines-deb-2-9-cli-2284.md
	cp ../add-machines.md add-machines-deb-2-9-ui-2285.md
	cp ../add-machines.md add-machines-snap-2-7-cli-2274.md
	cp ../add-machines.md add-machines-snap-2-7-ui-2275.md
	cp ../add-machines.md add-machines-snap-2-8-cli-2276.md
	cp ../add-machines.md add-machines-snap-2-8-ui-2277.md
	cp ../add-machines.md add-machines-snap-2-9-cli-2278.md
	cp ../add-machines.md add-machines-snap-2-9-ui-2279.md
	xpub push discourse -t deb-2-7-cli add-machines-deb-2-7-cli-2280.md
	xpub push discourse -t deb-2-7-ui add-machines-deb-2-7-ui-2281.md
	xpub push discourse -t deb-2-8-cli add-machines-deb-2-8-cli-2282.md
	xpub push discourse -t deb-2-8-ui add-machines-deb-2-8-ui-2283.md
	xpub push discourse -t deb-2-9-cli add-machines-deb-2-9-cli-2284.md
	xpub push discourse -t deb-2-9-ui add-machines-deb-2-9-ui-2285.md
	xpub push discourse -t snap-2-7-cli add-machines-snap-2-7-cli-2274.md
	xpub push discourse -t snap-2-7-ui add-machines-snap-2-7-ui-2275.md
	xpub push discourse -t snap-2-8-cli add-machines-snap-2-8-cli-2276.md
	xpub push discourse -t snap-2-8-ui add-machines-snap-2-8-ui-2277.md
	xpub push discourse -t snap-2-9-cli add-machines-snap-2-9-cli-2278.md
	xpub push discourse -t snap-2-9-ui add-machines-snap-2-9-ui-2279.md
	xpub pull discourse 2285 2285
	cp -p add-machines-deb-2-9-ui-2285.md add-machines.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
api-authentication.md: ../api-authentication.md
	cp ../api-authentication.md api-authentication-742.md
	xpub push discourse api-authentication-742.md
	xpub pull discourse 742 742
	cp -p api-authentication-742.md api-authentication.md
	mv api-authentication-742.md ./rad-versions

audit-event-logs.md: ../audit-event-logs.md
	cp ../audit-event-logs.md audit-event-logs-791.md
	xpub push discourse audit-event-logs-791.md
	xpub pull discourse 791 791
	cp -p audit-event-logs-791.md audit-event-logs.md
	mv audit-event-logs-791.md ./rad-versions

availability-zones.md: ../availability-zones.md
	cp ../availability-zones.md availability-zones-deb-2-7-cli-2328.md
	cp ../availability-zones.md availability-zones-deb-2-7-ui-2329.md
	cp ../availability-zones.md availability-zones-deb-2-8-cli-2330.md
	cp ../availability-zones.md availability-zones-deb-2-8-ui-2331.md
	cp ../availability-zones.md availability-zones-deb-2-9-cli-2332.md
	cp ../availability-zones.md availability-zones-deb-2-9-ui-2333.md
	cp ../availability-zones.md availability-zones-snap-2-7-cli-2322.md
	cp ../availability-zones.md availability-zones-snap-2-7-ui-2323.md
	cp ../availability-zones.md availability-zones-snap-2-8-cli-2324.md
	cp ../availability-zones.md availability-zones-snap-2-8-ui-2325.md
	cp ../availability-zones.md availability-zones-snap-2-9-cli-2326.md
	cp ../availability-zones.md availability-zones-snap-2-9-ui-2327.md
	xpub push discourse -t deb-2-7-cli availability-zones-deb-2-7-cli-2328.md
	xpub push discourse -t deb-2-7-ui availability-zones-deb-2-7-ui-2329.md
	xpub push discourse -t deb-2-8-cli availability-zones-deb-2-8-cli-2330.md
	xpub push discourse -t deb-2-8-ui availability-zones-deb-2-8-ui-2331.md
	xpub push discourse -t deb-2-9-cli availability-zones-deb-2-9-cli-2332.md
	xpub push discourse -t deb-2-9-ui availability-zones-deb-2-9-ui-2333.md
	xpub push discourse -t snap-2-7-cli availability-zones-snap-2-7-cli-2322.md
	xpub push discourse -t snap-2-7-ui availability-zones-snap-2-7-ui-2323.md
	xpub push discourse -t snap-2-8-cli availability-zones-snap-2-8-cli-2324.md
	xpub push discourse -t snap-2-8-ui availability-zones-snap-2-8-ui-2325.md
	xpub push discourse -t snap-2-9-cli availability-zones-snap-2-9-cli-2326.md
	xpub push discourse -t snap-2-9-ui availability-zones-snap-2-9-ui-2327.md
	xpub pull discourse 2333 2333
	cp -p availability-zones-deb-2-9-ui-2333.md availability-zones.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#b

backup.md: ../backup.md
	cp ../backup.md backup-deb-2-7-cli-2340.md
	cp ../backup.md backup-deb-2-7-ui-2341.md
	cp ../backup.md backup-deb-2-8-cli-2342.md
	cp ../backup.md backup-deb-2-8-ui-2343.md
	cp ../backup.md backup-deb-2-9-cli-2344.md
	cp ../backup.md backup-deb-2-9-ui-2345.md
	cp ../backup.md backup-snap-2-7-cli-2334.md
	cp ../backup.md backup-snap-2-7-ui-2335.md
	cp ../backup.md backup-snap-2-8-cli-2352.md
	cp ../backup.md backup-snap-2-8-ui-2337.md
	cp ../backup.md backup-snap-2-9-cli-2338.md
	cp ../backup.md backup-snap-2-9-ui-2339.md
	xpub push discourse -t deb-2-7-cli backup-deb-2-7-cli-2340.md
	xpub push discourse -t deb-2-7-ui backup-deb-2-7-ui-2341.md
	xpub push discourse -t deb-2-8-cli backup-deb-2-8-cli-2342.md
	xpub push discourse -t deb-2-8-ui backup-deb-2-8-ui-2343.md
	xpub push discourse -t deb-2-9-cli backup-deb-2-9-cli-2344.md
	xpub push discourse -t deb-2-9-ui backup-deb-2-9-ui-2345.md
	xpub push discourse -t snap-2-7-cli backup-snap-2-7-cli-2334.md
	xpub push discourse -t snap-2-7-ui backup-snap-2-7-ui-2335.md
	xpub push discourse -t snap-2-8-cli backup-snap-2-8-cli-2352.md
	xpub push discourse -t snap-2-8-ui backup-snap-2-8-ui-2337.md
	xpub push discourse -t snap-2-9-cli backup-snap-2-9-cli-2338.md
	xpub push discourse -t snap-2-9-ui backup-snap-2-9-ui-2339.md
	xpub pull discourse 2345 2345
	cp -p backup-deb-2-9-ui-2345.md backup.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
block-devices.md: ../block-devices.md
	cp ../block-devices.md block-devices-deb-2-7-cli-2352.md
	cp ../block-devices.md block-devices-deb-2-7-ui-2353.md
	cp ../block-devices.md block-devices-deb-2-8-cli-2354.md
	cp ../block-devices.md block-devices-deb-2-8-ui-2355.md
	cp ../block-devices.md block-devices-deb-2-9-cli-2356.md
	cp ../block-devices.md block-devices-deb-2-9-ui-2357.md
	cp ../block-devices.md block-devices-snap-2-7-cli-2346.md
	cp ../block-devices.md block-devices-snap-2-7-ui-2347.md
	cp ../block-devices.md block-devices-snap-2-8-cli-2348.md
	cp ../block-devices.md block-devices-snap-2-8-ui-2349.md
	cp ../block-devices.md block-devices-snap-2-9-cli-2350.md
	cp ../block-devices.md block-devices-snap-2-9-ui-2351.md
	xpub push discourse -t deb-2-7-cli block-devices-deb-2-7-cli-2352.md
	xpub push discourse -t deb-2-7-ui block-devices-deb-2-7-ui-2353.md
	xpub push discourse -t deb-2-8-cli block-devices-deb-2-8-cli-2354.md
	xpub push discourse -t deb-2-8-ui block-devices-deb-2-8-ui-2355.md
	xpub push discourse -t deb-2-9-cli block-devices-deb-2-9-cli-2356.md
	xpub push discourse -t deb-2-9-ui block-devices-deb-2-9-ui-2357.md
	xpub push discourse -t snap-2-7-cli block-devices-snap-2-7-cli-2346.md
	xpub push discourse -t snap-2-7-ui block-devices-snap-2-7-ui-2347.md
	xpub push discourse -t snap-2-8-cli block-devices-snap-2-8-cli-2348.md
	xpub push discourse -t snap-2-8-ui block-devices-snap-2-8-ui-2349.md
	xpub push discourse -t snap-2-9-cli block-devices-snap-2-9-cli-2350.md
	xpub push discourse -t snap-2-9-ui block-devices-snap-2-9-ui-2351.md
	xpub pull discourse 2357 2357
	cp -p block-devices-deb-2-9-ui-2357.md block-devices.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#c

candid-tutorial.md: ../candid-tutorial.md
	cp ../candid-tutorial.md candid-tutorial-3610.md
	xpub push discourse candid-tutorial-3610.md
	xpub pull discourse 3610 3610
	cp -p candid-tutorial-3610.md candid-tutorial.md
	mv candid-tutorial-3510.md ./rad-versions

cli-advanced-tasks.md: ../cli-advanced-tasks.md
	cp ../cli-advanced-tasks.md cli-advanced-tasks-793.md
	xpub push discourse cli-advanced-tasks-793.md
	xpub pull discourse 793 793
	cp -p cli-advanced-tasks-793.md cli-advanced-tasks.md
	mv cli-advanced-tasks-793.md ./rad-versions

cli-composable-hardware.md: ../cli-composable-hardware.md
	cp ../cli-composable-hardware.md cli-composable-hardware-795.md
	xpub push discourse cli-composable-hardware-795.md
	xpub pull discourse 795 795
	cp -p cli-composable-hardware-795.md cli-composable-hardware.md
	mv cli-composable-hardware-795.md ./rad-versions
 
cli-image-management.md: ../cli-image-management.md
	cp ../cli-image-management.md cli-image-management-797.md
	xpub push discourse cli-image-management-797.md
	xpub pull discourse 797 797
	cp -p cli-image-management-797.md cli-image-management.md
	mv cli-image-management-797.md ./rad-versions

cli-interface-management.md: ../cli-interface-management.md
	cp ../cli-interface-management.md cli-interface-management-798.md
	xpub push discourse cli-interface-management-798.md
	xpub pull discourse 798 798
	cp -p cli-interface-management-798.md cli-interface-management.md
	mv cli-interface-management-798.md ./rad-versions
 
cli-kernel-management.md: ../cli-kernel-management.md
	cp ../cli-kernel-management.md cli-kernel-management-799.md
	xpub push discourse cli-kernel-management-799.md
	xpub pull discourse 799 799
	cp -p cli-kernel-management-799.md cli-kernel-management.md
	mv cli-kernel-management-799.md ./rad-versions
 
commissioning-and-hardware-testing-scripts.md: ../commissioning-and-hardware-testing-scripts.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-deb-2-7-cli-2484.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-deb-2-7-ui-2485.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-deb-2-8-cli-2486.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-deb-2-8-ui-2487.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-deb-2-9-cli-2488.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-deb-2-9-ui-2489.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-snap-2-7-cli-2478.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-snap-2-7-ui-2479.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-snap-2-8-cli-2480.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-snap-2-8-ui-2481.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-snap-2-9-cli-2482.md
	cp ../commissioning-and-hardware-testing-scripts.md commissioning-and-hardware-testing-scripts-snap-2-9-ui-2483.md
	xpub push discourse -t deb-2-7-cli commissioning-and-hardware-testing-scripts-deb-2-7-cli-2484.md
	xpub push discourse -t deb-2-7-ui commissioning-and-hardware-testing-scripts-deb-2-7-ui-2485.md
	xpub push discourse -t deb-2-8-cli commissioning-and-hardware-testing-scripts-deb-2-8-cli-2486.md
	xpub push discourse -t deb-2-8-ui commissioning-and-hardware-testing-scripts-deb-2-8-ui-2487.md
	xpub push discourse -t deb-2-9-cli commissioning-and-hardware-testing-scripts-deb-2-9-cli-2488.md
	xpub push discourse -t deb-2-9-ui commissioning-and-hardware-testing-scripts-deb-2-9-ui-2489.md
	xpub push discourse -t snap-2-7-cli commissioning-and-hardware-testing-scripts-snap-2-7-cli-2478.md
	xpub push discourse -t snap-2-7-ui commissioning-and-hardware-testing-scripts-snap-2-7-ui-2479.md
	xpub push discourse -t snap-2-8-cli commissioning-and-hardware-testing-scripts-snap-2-8-cli-2480.md
	xpub push discourse -t snap-2-8-ui commissioning-and-hardware-testing-scripts-snap-2-8-ui-2481.md
	xpub push discourse -t snap-2-9-cli commissioning-and-hardware-testing-scripts-snap-2-9-cli-2482.md
	xpub push discourse -t snap-2-9-ui commissioning-and-hardware-testing-scripts-snap-2-9-ui-2483.md
	xpub pull discourse 2489 2489
	cp -p commissioning-and-hardware-testing-scripts-deb-2-9-ui-2489.md commissioning-and-hardware-testing-scripts.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
commissioning-logs.md: ../commissioning-logs.md
	cp ../commissioning-logs.md commissioning-logs-deb-2-7-cli-2496.md
	cp ../commissioning-logs.md commissioning-logs-deb-2-7-ui-2497.md
	cp ../commissioning-logs.md commissioning-logs-deb-2-8-cli-2498.md
	cp ../commissioning-logs.md commissioning-logs-deb-2-8-ui-2499.md
	cp ../commissioning-logs.md commissioning-logs-deb-2-9-cli-2500.md
	cp ../commissioning-logs.md commissioning-logs-deb-2-9-ui-2501.md
	cp ../commissioning-logs.md commissioning-logs-snap-2-7-cli-2490.md
	cp ../commissioning-logs.md commissioning-logs-snap-2-7-ui-2491.md
	cp ../commissioning-logs.md commissioning-logs-snap-2-8-cli-2492.md
	cp ../commissioning-logs.md commissioning-logs-snap-2-8-ui-2493.md
	cp ../commissioning-logs.md commissioning-logs-snap-2-9-cli-2494.md
	cp ../commissioning-logs.md commissioning-logs-snap-2-9-ui-2495.md
	xpub push discourse -t deb-2-7-cli commissioning-logs-deb-2-7-cli-2496.md
	xpub push discourse -t deb-2-7-ui commissioning-logs-deb-2-7-ui-2497.md
	xpub push discourse -t deb-2-8-cli commissioning-logs-deb-2-8-cli-2498.md
	xpub push discourse -t deb-2-8-ui commissioning-logs-deb-2-8-ui-2499.md
	xpub push discourse -t deb-2-9-cli commissioning-logs-deb-2-9-cli-2500.md
	xpub push discourse -t deb-2-9-ui commissioning-logs-deb-2-9-ui-2501.md
	xpub push discourse -t snap-2-7-cli commissioning-logs-snap-2-7-cli-2490.md
	xpub push discourse -t snap-2-7-ui commissioning-logs-snap-2-7-ui-2491.md
	xpub push discourse -t snap-2-8-cli commissioning-logs-snap-2-8-cli-2492.md
	xpub push discourse -t snap-2-8-ui commissioning-logs-snap-2-8-ui-2493.md
	xpub push discourse -t snap-2-9-cli commissioning-logs-snap-2-9-cli-2494.md
	xpub push discourse -t snap-2-9-ui commissioning-logs-snap-2-9-ui-2495.md
	xpub pull discourse 2501 2501
	cp -p commissioning-logs-deb-2-9-ui-2501.md commissioning-logs.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
commission-machines.md: ../commission-machines.md
	cp ../commission-machines.md commission-machines-deb-2-7-cli-2472.md
	cp ../commission-machines.md commission-machines-deb-2-7-ui-2473.md
	cp ../commission-machines.md commission-machines-deb-2-8-cli-2474.md
	cp ../commission-machines.md commission-machines-deb-2-8-ui-2475.md
	cp ../commission-machines.md commission-machines-deb-2-9-cli-2476.md
	cp ../commission-machines.md commission-machines-deb-2-9-ui-2477.md
	cp ../commission-machines.md commission-machines-snap-2-7-cli-2466.md
	cp ../commission-machines.md commission-machines-snap-2-7-ui-2467.md
	cp ../commission-machines.md commission-machines-snap-2-8-cli-2468.md
	cp ../commission-machines.md commission-machines-snap-2-8-ui-2469.md
	cp ../commission-machines.md commission-machines-snap-2-9-cli-2470.md
	cp ../commission-machines.md commission-machines-snap-2-9-ui-2471.md
	xpub push discourse -t deb-2-7-cli commission-machines-deb-2-7-cli-2472.md
	xpub push discourse -t deb-2-7-ui commission-machines-deb-2-7-ui-2473.md
	xpub push discourse -t deb-2-8-cli commission-machines-deb-2-8-cli-2474.md
	xpub push discourse -t deb-2-8-ui commission-machines-deb-2-8-ui-2475.md
	xpub push discourse -t deb-2-9-cli commission-machines-deb-2-9-cli-2476.md
	xpub push discourse -t deb-2-9-ui commission-machines-deb-2-9-ui-2477.md
	xpub push discourse -t snap-2-7-cli commission-machines-snap-2-7-cli-2466.md
	xpub push discourse -t snap-2-7-ui commission-machines-snap-2-7-ui-2467.md
	xpub push discourse -t snap-2-8-cli commission-machines-snap-2-8-cli-2468.md
	xpub push discourse -t snap-2-8-ui commission-machines-snap-2-8-ui-2469.md
	xpub push discourse -t snap-2-9-cli commission-machines-snap-2-9-cli-2470.md
	xpub push discourse -t snap-2-9-ui commission-machines-snap-2-9-ui-2471.md
	xpub pull discourse 2477 2477
	cp -p commission-machines-deb-2-9-ui-2477.md commission-machines.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
common-cli-tasks.md: ../common-cli-tasks.md
	cp ../common-cli-tasks.md common-cli-tasks-794.md
	xpub push discourse common-cli-tasks-794.md
	xpub pull discourse 794 794
	cp -p common-cli-tasks-794.md common-cli-tasks.md
	mv common-cli-tasks-794.md ./rad-versions
 
concepts-and-terms.md: ../concepts-and-terms.md
	cp ../concepts-and-terms.md concepts-and-terms-785.md
	xpub push discourse concepts-and-terms-785.md
	xpub pull discourse 785 785
	cp -p concepts-and-terms-785.md concepts-and-terms.md
	mv concepts-and-terms-785.md ./rad-versions
 
configuration-journey.md: ../configuration-journey.md
	cp ../configuration-journey.md configuration-journey-deb-2-7-cli-2532.md
	cp ../configuration-journey.md configuration-journey-deb-2-7-ui-2533.md
	cp ../configuration-journey.md configuration-journey-deb-2-8-cli-2534.md
	cp ../configuration-journey.md configuration-journey-deb-2-8-ui-2535.md
	cp ../configuration-journey.md configuration-journey-deb-2-9-cli-2536.md
	cp ../configuration-journey.md configuration-journey-deb-2-9-ui-2537.md
	cp ../configuration-journey.md configuration-journey-snap-2-7-cli-2526.md
	cp ../configuration-journey.md configuration-journey-snap-2-7-ui-2527.md
	cp ../configuration-journey.md configuration-journey-snap-2-8-cli-2528.md
	cp ../configuration-journey.md configuration-journey-snap-2-8-ui-2529.md
	cp ../configuration-journey.md configuration-journey-snap-2-9-cli-2530.md
	cp ../configuration-journey.md configuration-journey-snap-2-9-ui-2531.md
	xpub push discourse -t deb-2-7-cli configuration-journey-deb-2-7-cli-2532.md
	xpub push discourse -t deb-2-7-ui configuration-journey-deb-2-7-ui-2533.md
	xpub push discourse -t deb-2-8-cli configuration-journey-deb-2-8-cli-2534.md
	xpub push discourse -t deb-2-8-ui configuration-journey-deb-2-8-ui-2535.md
	xpub push discourse -t deb-2-9-cli configuration-journey-deb-2-9-cli-2536.md
	xpub push discourse -t deb-2-9-ui configuration-journey-deb-2-9-ui-2537.md
	xpub push discourse -t snap-2-7-cli configuration-journey-snap-2-7-cli-2526.md
	xpub push discourse -t snap-2-7-ui configuration-journey-snap-2-7-ui-2527.md
	xpub push discourse -t snap-2-8-cli configuration-journey-snap-2-8-cli-2528.md
	xpub push discourse -t snap-2-8-ui configuration-journey-snap-2-8-ui-2529.md
	xpub push discourse -t snap-2-9-cli configuration-journey-snap-2-9-cli-2530.md
	xpub push discourse -t snap-2-9-ui configuration-journey-snap-2-9-ui-2531.md
	xpub pull discourse 2537 2537
	cp -p configuration-journey-deb-2-9-ui-2537.md configuration-journey.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
configuring-tls-encryption.md: ../configuring-tls-encryption.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-deb-2-7-cli-2544.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-deb-2-7-ui-2545.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-deb-2-8-cli-2546.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-deb-2-8-ui-2547.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-deb-2-9-cli-2548.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-deb-2-9-ui-2549.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-snap-2-7-cli-2538.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-snap-2-7-ui-2539.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-snap-2-8-cli-2540.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-snap-2-8-ui-2541.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-snap-2-9-cli-2542.md
	cp ../configuring-tls-encryption.md configuring-tls-encryption-snap-2-9-ui-2543.md
	xpub push discourse -t deb-2-7-cli configuring-tls-encryption-deb-2-7-cli-2544.md
	xpub push discourse -t deb-2-7-ui configuring-tls-encryption-deb-2-7-ui-2545.md
	xpub push discourse -t deb-2-8-cli configuring-tls-encryption-deb-2-8-cli-2546.md
	xpub push discourse -t deb-2-8-ui configuring-tls-encryption-deb-2-8-ui-2547.md
	xpub push discourse -t deb-2-9-cli configuring-tls-encryption-deb-2-9-cli-2548.md
	xpub push discourse -t deb-2-9-ui configuring-tls-encryption-deb-2-9-ui-2549.md
	xpub push discourse -t snap-2-7-cli configuring-tls-encryption-snap-2-7-cli-2538.md
	xpub push discourse -t snap-2-7-ui configuring-tls-encryption-snap-2-7-ui-2539.md
	xpub push discourse -t snap-2-8-cli configuring-tls-encryption-snap-2-8-cli-2540.md
	xpub push discourse -t snap-2-8-ui configuring-tls-encryption-snap-2-8-ui-2541.md
	xpub push discourse -t snap-2-9-cli configuring-tls-encryption-snap-2-9-cli-2542.md
	xpub push discourse -t snap-2-9-ui configuring-tls-encryption-snap-2-9-ui-2543.md
	xpub pull discourse 2549 2549
	cp -p configuring-tls-encryption-deb-2-9-ui-2549.md configuring-tls-encryption.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
contact-us.md: ../contact-us.md
	cp ../contact-us.md contact-us-743.md
	xpub push discourse contact-us-743.md
	xpub pull discourse 743 743
	cp -p contact-us-743.md contact-us.md
	mv contact-us-743.md ./rad-versions

controllers.md: ../controllers.md
	cp ../controllers.md controllers-deb-2-7-cli-2724.md
	cp ../controllers.md controllers-deb-2-7-ui-2725.md
	cp ../controllers.md controllers-deb-2-8-cli-2726.md
	cp ../controllers.md controllers-deb-2-8-ui-2727.md
	cp ../controllers.md controllers-deb-2-9-cli-2728.md
	cp ../controllers.md controllers-deb-2-9-ui-2729.md
	cp ../controllers.md controllers-snap-2-7-cli-2718.md
	cp ../controllers.md controllers-snap-2-7-ui-2719.md
	cp ../controllers.md controllers-snap-2-8-cli-2720.md
	cp ../controllers.md controllers-snap-2-8-ui-2721.md
	cp ../controllers.md controllers-snap-2-9-cli-2722.md
	cp ../controllers.md controllers-snap-2-9-ui-2723.md
	xpub push discourse -t deb-2-7-cli controllers-deb-2-7-cli-2724.md
	xpub push discourse -t deb-2-7-ui controllers-deb-2-7-ui-2725.md
	xpub push discourse -t deb-2-8-cli controllers-deb-2-8-cli-2726.md
	xpub push discourse -t deb-2-8-ui controllers-deb-2-8-ui-2727.md
	xpub push discourse -t deb-2-9-cli controllers-deb-2-9-cli-2728.md
	xpub push discourse -t deb-2-9-ui controllers-deb-2-9-ui-2729.md
	xpub push discourse -t snap-2-7-cli controllers-snap-2-7-cli-2718.md
	xpub push discourse -t snap-2-7-ui controllers-snap-2-7-ui-2719.md
	xpub push discourse -t snap-2-8-cli controllers-snap-2-8-cli-2720.md
	xpub push discourse -t snap-2-8-ui controllers-snap-2-8-ui-2721.md
	xpub push discourse -t snap-2-9-cli controllers-snap-2-9-cli-2722.md
	xpub push discourse -t snap-2-9-ui controllers-snap-2-9-ui-2723.md
	xpub pull discourse 2729 2729
	cp -p controllers-deb-2-9-ui-2729.md controllers.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
creating-a-custom-ubuntu-image.md: ../creating-a-custom-ubuntu-image.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-deb-2-7-cli-2568.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-deb-2-7-ui-2569.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-deb-2-8-cli-2570.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-deb-2-8-ui-2571.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-deb-2-9-cli-2572.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-deb-2-9-ui-2573.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-snap-2-7-cli-2562.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-snap-2-7-ui-2563.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-snap-2-8-cli-2564.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-snap-2-8-ui-2565.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-snap-2-9-cli-2566.md
	cp ../creating-a-custom-ubuntu-image.md creating-a-custom-ubuntu-image-snap-2-9-ui-2567.md
	xpub push discourse -t deb-2-7-cli creating-a-custom-ubuntu-image-deb-2-7-cli-2568.md
	xpub push discourse -t deb-2-7-ui creating-a-custom-ubuntu-image-deb-2-7-ui-2569.md
	xpub push discourse -t deb-2-8-cli creating-a-custom-ubuntu-image-deb-2-8-cli-2570.md
	xpub push discourse -t deb-2-8-ui creating-a-custom-ubuntu-image-deb-2-8-ui-2571.md
	xpub push discourse -t deb-2-9-cli creating-a-custom-ubuntu-image-deb-2-9-cli-2572.md
	xpub push discourse -t deb-2-9-ui creating-a-custom-ubuntu-image-deb-2-9-ui-2573.md
	xpub push discourse -t snap-2-7-cli creating-a-custom-ubuntu-image-snap-2-7-cli-2562.md
	xpub push discourse -t snap-2-7-ui creating-a-custom-ubuntu-image-snap-2-7-ui-2563.md
	xpub push discourse -t snap-2-8-cli creating-a-custom-ubuntu-image-snap-2-8-cli-2564.md
	xpub push discourse -t snap-2-8-ui creating-a-custom-ubuntu-image-snap-2-8-ui-2565.md
	xpub push discourse -t snap-2-9-cli creating-a-custom-ubuntu-image-snap-2-9-cli-2566.md
	xpub push discourse -t snap-2-9-ui creating-a-custom-ubuntu-image-snap-2-9-ui-2567.md
	xpub pull discourse 2573 2573
	cp -p creating-a-custom-ubuntu-image-deb-2-9-ui-2573.md creating-a-custom-ubuntu-image.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
creating-and-deleting-vms.md: ../creating-and-deleting-vms.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-deb-2-7-cli-2580.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-deb-2-7-ui-2581.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-deb-2-8-cli-2582.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-deb-2-8-ui-2583.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-deb-2-9-cli-2584.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-deb-2-9-ui-2585.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-snap-2-7-cli-2574.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-snap-2-7-ui-2575.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-snap-2-8-cli-2576.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-snap-2-8-ui-2577.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-snap-2-9-cli-2578.md
	cp ../creating-and-deleting-vms.md creating-and-deleting-vms-snap-2-9-ui-2579.md
	xpub push discourse -t deb-2-7-cli creating-and-deleting-vms-deb-2-7-cli-2580.md
	xpub push discourse -t deb-2-7-ui creating-and-deleting-vms-deb-2-7-ui-2581.md
	xpub push discourse -t deb-2-8-cli creating-and-deleting-vms-deb-2-8-cli-2582.md
	xpub push discourse -t deb-2-8-ui creating-and-deleting-vms-deb-2-8-ui-2583.md
	xpub push discourse -t deb-2-9-cli creating-and-deleting-vms-deb-2-9-cli-2584.md
	xpub push discourse -t deb-2-9-ui creating-and-deleting-vms-deb-2-9-ui-2585.md
	xpub push discourse -t snap-2-7-cli creating-and-deleting-vms-snap-2-7-cli-2574.md
	xpub push discourse -t snap-2-7-ui creating-and-deleting-vms-snap-2-7-ui-2575.md
	xpub push discourse -t snap-2-8-cli creating-and-deleting-vms-snap-2-8-cli-2576.md
	xpub push discourse -t snap-2-8-ui creating-and-deleting-vms-snap-2-8-ui-2577.md
	xpub push discourse -t snap-2-9-cli creating-and-deleting-vms-snap-2-9-cli-2578.md
	xpub push discourse -t snap-2-9-ui creating-and-deleting-vms-snap-2-9-ui-2579.md
	xpub pull discourse 2585 2585
	cp -p creating-and-deleting-vms-deb-2-9-ui-2585.md creating-and-deleting-vms.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
custom-machine-setup.md: ../custom-machine-setup.md
	cp ../custom-machine-setup.md custom-machine-setup-deb-2-7-cli-2592.md
	cp ../custom-machine-setup.md custom-machine-setup-deb-2-7-ui-2593.md
	cp ../custom-machine-setup.md custom-machine-setup-deb-2-8-cli-2594.md
	cp ../custom-machine-setup.md custom-machine-setup-deb-2-8-ui-2595.md
	cp ../custom-machine-setup.md custom-machine-setup-deb-2-9-cli-2596.md
	cp ../custom-machine-setup.md custom-machine-setup-deb-2-9-ui-2597.md
	cp ../custom-machine-setup.md custom-machine-setup-snap-2-7-cli-2586.md
	cp ../custom-machine-setup.md custom-machine-setup-snap-2-7-ui-2587.md
	cp ../custom-machine-setup.md custom-machine-setup-snap-2-8-cli-2588.md
	cp ../custom-machine-setup.md custom-machine-setup-snap-2-8-ui-2589.md
	cp ../custom-machine-setup.md custom-machine-setup-snap-2-9-cli-2590.md
	cp ../custom-machine-setup.md custom-machine-setup-snap-2-9-ui-2591.md
	xpub push discourse -t deb-2-7-cli custom-machine-setup-deb-2-7-cli-2592.md
	xpub push discourse -t deb-2-7-ui custom-machine-setup-deb-2-7-ui-2593.md
	xpub push discourse -t deb-2-8-cli custom-machine-setup-deb-2-8-cli-2594.md
	xpub push discourse -t deb-2-8-ui custom-machine-setup-deb-2-8-ui-2595.md
	xpub push discourse -t deb-2-9-cli custom-machine-setup-deb-2-9-cli-2596.md
	xpub push discourse -t deb-2-9-ui custom-machine-setup-deb-2-9-ui-2597.md
	xpub push discourse -t snap-2-7-cli custom-machine-setup-snap-2-7-cli-2586.md
	xpub push discourse -t snap-2-7-ui custom-machine-setup-snap-2-7-ui-2587.md
	xpub push discourse -t snap-2-8-cli custom-machine-setup-snap-2-8-cli-2588.md
	xpub push discourse -t snap-2-8-ui custom-machine-setup-snap-2-8-ui-2589.md
	xpub push discourse -t snap-2-9-cli custom-machine-setup-snap-2-9-cli-2590.md
	xpub push discourse -t snap-2-9-ui custom-machine-setup-snap-2-9-ui-2591.md
	xpub pull discourse 2597 2597
	cp -p custom-machine-setup-deb-2-9-ui-2597.md custom-machine-setup.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#d

deploy-machines.md: ../deploy-machines.md
	cp ../deploy-machines.md deploy-machines-deb-2-7-cli-2604.md
	cp ../deploy-machines.md deploy-machines-deb-2-7-ui-2605.md
	cp ../deploy-machines.md deploy-machines-deb-2-8-cli-2606.md
	cp ../deploy-machines.md deploy-machines-deb-2-8-ui-2607.md
	cp ../deploy-machines.md deploy-machines-deb-2-9-cli-2608.md
	cp ../deploy-machines.md deploy-machines-deb-2-9-ui-2609.md
	cp ../deploy-machines.md deploy-machines-snap-2-7-cli-2598.md
	cp ../deploy-machines.md deploy-machines-snap-2-7-ui-2599.md
	cp ../deploy-machines.md deploy-machines-snap-2-8-cli-2600.md
	cp ../deploy-machines.md deploy-machines-snap-2-8-ui-2601.md
	cp ../deploy-machines.md deploy-machines-snap-2-9-cli-2602.md
	cp ../deploy-machines.md deploy-machines-snap-2-9-ui-2603.md
	xpub push discourse -t deb-2-7-cli deploy-machines-deb-2-7-cli-2604.md
	xpub push discourse -t deb-2-7-ui deploy-machines-deb-2-7-ui-2605.md
	xpub push discourse -t deb-2-8-cli deploy-machines-deb-2-8-cli-2606.md
	xpub push discourse -t deb-2-8-ui deploy-machines-deb-2-8-ui-2607.md
	xpub push discourse -t deb-2-9-cli deploy-machines-deb-2-9-cli-2608.md
	xpub push discourse -t deb-2-9-ui deploy-machines-deb-2-9-ui-2609.md
	xpub push discourse -t snap-2-7-cli deploy-machines-snap-2-7-cli-2598.md
	xpub push discourse -t snap-2-7-ui deploy-machines-snap-2-7-ui-2599.md
	xpub push discourse -t snap-2-8-cli deploy-machines-snap-2-8-cli-2600.md
	xpub push discourse -t snap-2-8-ui deploy-machines-snap-2-8-ui-2601.md
	xpub push discourse -t snap-2-9-cli deploy-machines-snap-2-9-cli-2602.md
	xpub push discourse -t snap-2-9-ui deploy-machines-snap-2-9-ui-2603.md
	xpub pull discourse 2609 2609
	cp -p deploy-machines-deb-2-9-ui-2609.md deploy-machines.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
disk-erasure.md: ../disk-erasure.md
	cp ../disk-erasure.md disk-erasure-deb-2-7-cli-2616.md
	cp ../disk-erasure.md disk-erasure-deb-2-7-ui-2617.md
	cp ../disk-erasure.md disk-erasure-deb-2-8-cli-2618.md
	cp ../disk-erasure.md disk-erasure-deb-2-8-ui-2619.md
	cp ../disk-erasure.md disk-erasure-deb-2-9-cli-2620.md
	cp ../disk-erasure.md disk-erasure-deb-2-9-ui-2621.md
	cp ../disk-erasure.md disk-erasure-snap-2-7-cli-2610.md
	cp ../disk-erasure.md disk-erasure-snap-2-7-ui-2611.md
	cp ../disk-erasure.md disk-erasure-snap-2-8-cli-2612.md
	cp ../disk-erasure.md disk-erasure-snap-2-8-ui-2613.md
	cp ../disk-erasure.md disk-erasure-snap-2-9-cli-2614.md
	cp ../disk-erasure.md disk-erasure-snap-2-9-ui-2615.md
	xpub push discourse -t deb-2-7-cli disk-erasure-deb-2-7-cli-2616.md
	xpub push discourse -t deb-2-7-ui disk-erasure-deb-2-7-ui-2617.md
	xpub push discourse -t deb-2-8-cli disk-erasure-deb-2-8-cli-2618.md
	xpub push discourse -t deb-2-8-ui disk-erasure-deb-2-8-ui-2619.md
	xpub push discourse -t deb-2-9-cli disk-erasure-deb-2-9-cli-2620.md
	xpub push discourse -t deb-2-9-ui disk-erasure-deb-2-9-ui-2621.md
	xpub push discourse -t snap-2-7-cli disk-erasure-snap-2-7-cli-2610.md
	xpub push discourse -t snap-2-7-ui disk-erasure-snap-2-7-ui-2611.md
	xpub push discourse -t snap-2-8-cli disk-erasure-snap-2-8-cli-2612.md
	xpub push discourse -t snap-2-8-ui disk-erasure-snap-2-8-ui-2613.md
	xpub push discourse -t snap-2-9-cli disk-erasure-snap-2-9-cli-2614.md
	xpub push discourse -t snap-2-9-ui disk-erasure-snap-2-9-ui-2615.md
	xpub pull discourse 2621 2621
	cp -p disk-erasure-deb-2-9-ui-2621.md disk-erasure.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions


#e

event-logs.md: ../event-logs.md
	cp ../event-logs.md event-logs-deb-2-7-cli-3388.md
	cp ../event-logs.md event-logs-deb-2-7-ui-3389.md
	cp ../event-logs.md event-logs-deb-2-8-cli-3390.md
	cp ../event-logs.md event-logs-deb-2-8-ui-3391.md
	cp ../event-logs.md event-logs-deb-2-9-cli-3382.md
	cp ../event-logs.md event-logs-deb-2-9-ui-3392.md
	cp ../event-logs.md event-logs-snap-2-7-cli-3382.md
	cp ../event-logs.md event-logs-snap-2-7-ui-3383.md
	cp ../event-logs.md event-logs-snap-2-8-cli-3384.md
	cp ../event-logs.md event-logs-snap-2-8-ui-3385.md
	cp ../event-logs.md event-logs-snap-2-9-cli-3386.md
	cp ../event-logs.md event-logs-snap-2-9-ui-3387.md
	xpub push discourse -t deb-2-7-cli event-logs-deb-2-7-cli-3388.md
	xpub push discourse -t deb-2-7-ui event-logs-deb-2-7-ui-3389.md
	xpub push discourse -t deb-2-8-cli event-logs-deb-2-8-cli-3390.md
	xpub push discourse -t deb-2-8-ui event-logs-deb-2-8-ui-3391.md
	xpub push discourse -t deb-2-9-cli event-logs-deb-2-9-cli-3382.md
	xpub push discourse -t deb-2-9-ui event-logs-deb-2-9-ui-3392.md
	xpub push discourse -t snap-2-7-cli event-logs-snap-2-7-cli-3382.md
	xpub push discourse -t snap-2-7-ui event-logs-snap-2-7-ui-3383.md
	xpub push discourse -t snap-2-8-cli event-logs-snap-2-8-cli-3384.md
	xpub push discourse -t snap-2-8-ui event-logs-snap-2-8-ui-3385.md
	xpub push discourse -t snap-2-9-cli event-logs-snap-2-9-cli-3386.md
	xpub push discourse -t snap-2-9-ui event-logs-snap-2-9-ui-3387.md
	xpub pull discourse 3392 3392
	cp -p event-logs-deb-2-9-ui-3392.md event-logs.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#g

getting-help.md: ../getting-help.md
	cp ../getting-help.md getting-help-838.md
	xpub push discourse getting-help-838.md
	xpub pull discourse 838 838
	cp -p getting-help-838.md getting-help.md
	mv getting-help-838.md ./rad-versions

give-me-an-example-of-maas.md: ../give-me-an-example-of-maas.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-deb-2-7-cli-2652.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-deb-2-7-ui-2653.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-deb-2-8-cli-2654.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-deb-2-8-ui-2655.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-deb-2-9-cli-2656.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-deb-2-9-ui-2657.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-snap-2-7-cli-2646.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-snap-2-7-ui-2647.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-snap-2-8-cli-2648.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-snap-2-8-ui-2649.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-snap-2-9-cli-2650.md
	cp ../give-me-an-example-of-maas.md give-me-an-example-of-maas-snap-2-9-ui-2651.md
	xpub push discourse -t deb-2-7-cli give-me-an-example-of-maas-deb-2-7-cli-2652.md
	xpub push discourse -t deb-2-7-ui give-me-an-example-of-maas-deb-2-7-ui-2653.md
	xpub push discourse -t deb-2-8-cli give-me-an-example-of-maas-deb-2-8-cli-2654.md
	xpub push discourse -t deb-2-8-ui give-me-an-example-of-maas-deb-2-8-ui-2655.md
	xpub push discourse -t deb-2-9-cli give-me-an-example-of-maas-deb-2-9-cli-2656.md
	xpub push discourse -t deb-2-9-ui give-me-an-example-of-maas-deb-2-9-ui-2657.md
	xpub push discourse -t snap-2-7-cli give-me-an-example-of-maas-snap-2-7-cli-2646.md
	xpub push discourse -t snap-2-7-ui give-me-an-example-of-maas-snap-2-7-ui-2647.md
	xpub push discourse -t snap-2-8-cli give-me-an-example-of-maas-snap-2-8-cli-2648.md
	xpub push discourse -t snap-2-8-ui give-me-an-example-of-maas-snap-2-8-ui-2649.md
	xpub push discourse -t snap-2-9-cli give-me-an-example-of-maas-snap-2-9-cli-2650.md
	xpub push discourse -t snap-2-9-ui give-me-an-example-of-maas-snap-2-9-ui-2651.md
	xpub pull discourse 2657 2657
	cp -p give-me-an-example-of-maas-deb-2-9-ui-2657.md give-me-an-example-of-maas.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#h

hardening-your-maas-installation.md: ../hardening-your-maas-installation.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-deb-2-7-cli-2664.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-deb-2-7-ui-2665.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-deb-2-8-cli-2666.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-deb-2-8-ui-2667.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-deb-2-9-cli-2668.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-deb-2-9-ui-2669.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-snap-2-7-cli-2658.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-snap-2-7-ui-2659.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-snap-2-8-cli-2660.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-snap-2-8-ui-2661.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-snap-2-9-cli-2662.md
	cp ../hardening-your-maas-installation.md hardening-your-maas-installation-snap-2-9-ui-2663.md
	xpub push discourse -t deb-2-7-ui hardening-your-maas-installation-deb-2-7-ui-2665.md
	xpub push discourse -t deb-2-8-cli hardening-your-maas-installation-deb-2-8-cli-2666.md
	xpub push discourse -t deb-2-8-ui hardening-your-maas-installation-deb-2-8-ui-2667.md
	xpub push discourse -t deb-2-9-cli hardening-your-maas-installation-deb-2-9-cli-2668.md
	xpub push discourse -t deb-2-9-ui hardening-your-maas-installation-deb-2-9-ui-2669.md
	xpub push discourse -t snap-2-7-cli hardening-your-maas-installation-snap-2-7-cli-2658.md
	xpub push discourse -t snap-2-7-ui hardening-your-maas-installation-snap-2-7-ui-2659.md
	xpub push discourse -t snap-2-8-cli hardening-your-maas-installation-snap-2-8-cli-2660.md
	xpub push discourse -t snap-2-8-ui hardening-your-maas-installation-snap-2-8-ui-2661.md
	xpub push discourse -t snap-2-9-cli hardening-your-maas-installation-snap-2-9-cli-2662.md
	xpub push discourse -t snap-2-9-ui hardening-your-maas-installation-snap-2-9-ui-2663.md
	xpub pull discourse 2669 2669
	cp -p hardening-your-maas-installation-deb-2-9-ui-2669.md hardening-your-maas-installation.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
hardware-testing.md: ../hardware-testing.md
	cp ../hardware-testing.md hardware-testing-deb-2-7-cli-2676.md
	cp ../hardware-testing.md hardware-testing-deb-2-7-ui-2677.md
	cp ../hardware-testing.md hardware-testing-deb-2-8-cli-2678.md
	cp ../hardware-testing.md hardware-testing-deb-2-8-ui-2679.md
	cp ../hardware-testing.md hardware-testing-deb-2-9-cli-2680.md
	cp ../hardware-testing.md hardware-testing-deb-2-9-ui-2681.md
	cp ../hardware-testing.md hardware-testing-snap-2-7-cli-2670.md
	cp ../hardware-testing.md hardware-testing-snap-2-7-ui-2671.md
	cp ../hardware-testing.md hardware-testing-snap-2-8-cli-2672.md
	cp ../hardware-testing.md hardware-testing-snap-2-8-ui-2673.md
	cp ../hardware-testing.md hardware-testing-snap-2-9-cli-2674.md
	cp ../hardware-testing.md hardware-testing-snap-2-9-ui-2675.md
	xpub push discourse -t deb-2-7-cli hardware-testing-deb-2-7-cli-2676.md
	xpub push discourse -t deb-2-7-ui hardware-testing-deb-2-7-ui-2677.md
	xpub push discourse -t deb-2-8-cli hardware-testing-deb-2-8-cli-2678.md
	xpub push discourse -t deb-2-8-ui hardware-testing-deb-2-8-ui-2679.md
	xpub push discourse -t deb-2-9-cli hardware-testing-deb-2-9-cli-2680.md
	xpub push discourse -t deb-2-9-ui hardware-testing-deb-2-9-ui-2681.md
	xpub push discourse -t snap-2-7-cli hardware-testing-snap-2-7-cli-2670.md
	xpub push discourse -t snap-2-7-ui hardware-testing-snap-2-7-ui-2671.md
	xpub push discourse -t snap-2-8-cli hardware-testing-snap-2-8-cli-2672.md
	xpub push discourse -t snap-2-8-ui hardware-testing-snap-2-8-ui-2673.md
	xpub push discourse -t snap-2-9-cli hardware-testing-snap-2-9-cli-2674.md
	xpub push discourse -t snap-2-9-ui hardware-testing-snap-2-9-ui-2675.md
	xpub pull discourse 2681 2681
	cp -p hardware-testing-deb-2-9-ui-2681.md hardware-testing.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
high-availability.md: ../high-availability.md
	cp ../high-availability.md high-availability-deb-2-7-cli-2688.md
	cp ../high-availability.md high-availability-deb-2-7-ui-2689.md
	cp ../high-availability.md high-availability-deb-2-8-cli-2690.md
	cp ../high-availability.md high-availability-deb-2-8-ui-2691.md
	cp ../high-availability.md high-availability-deb-2-9-cli-2692.md
	cp ../high-availability.md high-availability-deb-2-9-ui-2693.md
	cp ../high-availability.md high-availability-snap-2-7-cli-2682.md
	cp ../high-availability.md high-availability-snap-2-7-ui-2683.md
	cp ../high-availability.md high-availability-snap-2-8-cli-2684.md
	cp ../high-availability.md high-availability-snap-2-8-ui-2685.md
	cp ../high-availability.md high-availability-snap-2-9-cli-2686.md
	cp ../high-availability.md high-availability-snap-2-9-ui-2687.md
	xpub push discourse -t deb-2-7-cli high-availability-deb-2-7-cli-2688.md
	xpub push discourse -t deb-2-7-ui high-availability-deb-2-7-ui-2689.md
	xpub push discourse -t deb-2-8-cli high-availability-deb-2-8-cli-2690.md
	xpub push discourse -t deb-2-8-ui high-availability-deb-2-8-ui-2691.md
	xpub push discourse -t deb-2-9-cli high-availability-deb-2-9-cli-2692.md
	xpub push discourse -t deb-2-9-ui high-availability-deb-2-9-ui-2693.md
	xpub push discourse -t snap-2-7-cli high-availability-snap-2-7-cli-2682.md
	xpub push discourse -t snap-2-7-ui high-availability-snap-2-7-ui-2683.md
	xpub push discourse -t snap-2-8-cli high-availability-snap-2-8-cli-2684.md
	xpub push discourse -t snap-2-8-ui high-availability-snap-2-8-ui-2685.md
	xpub push discourse -t snap-2-9-cli high-availability-snap-2-9-cli-2686.md
	xpub push discourse -t snap-2-9-ui high-availability-snap-2-9-ui-2687.md
	xpub pull discourse 2693 2693
	cp -p high-availability-deb-2-9-ui-2693.md high-availability.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#i

images.md: ../images.md
	cp ../images.md images-deb-2-7-cli-2700.md
	cp ../images.md images-deb-2-7-ui-2701.md
	cp ../images.md images-deb-2-8-cli-2702.md
	cp ../images.md images-deb-2-8-ui-2703.md
	cp ../images.md images-deb-2-9-cli-2704.md
	cp ../images.md images-deb-2-9-ui-2705.md
	cp ../images.md images-snap-2-7-cli-2694.md
	cp ../images.md images-snap-2-7-ui-2695.md
	cp ../images.md images-snap-2-8-cli-2696.md
	cp ../images.md images-snap-2-8-ui-2697.md
	cp ../images.md images-snap-2-9-cli-2698.md
	cp ../images.md images-snap-2-9-ui-2699.md
	xpub push discourse -t deb-2-7-cli images-deb-2-7-cli-2700.md
	xpub push discourse -t deb-2-7-ui images-deb-2-7-ui-2701.md
	xpub push discourse -t deb-2-8-cli images-deb-2-8-cli-2702.md
	xpub push discourse -t deb-2-8-ui images-deb-2-8-ui-2703.md
	xpub push discourse -t deb-2-9-cli images-deb-2-9-cli-2704.md
	xpub push discourse -t deb-2-9-ui images-deb-2-9-ui-2705.md
	xpub push discourse -t snap-2-7-cli images-snap-2-7-cli-2694.md
	xpub push discourse -t snap-2-7-ui images-snap-2-7-ui-2695.md
	xpub push discourse -t snap-2-8-cli images-snap-2-8-cli-2696.md
	xpub push discourse -t snap-2-8-ui images-snap-2-8-ui-2697.md
	xpub push discourse -t snap-2-9-cli images-snap-2-9-cli-2698.md
	xpub push discourse -t snap-2-9-ui images-snap-2-9-ui-2699.md
	xpub pull discourse 2705 2705
	cp -p images-deb-2-9-ui-2705.md images.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
interactive-search.md: ../interactive-search.md
	cp ../interactive-search.md interactive-search-deb-2-7-cli-2712.md
	cp ../interactive-search.md interactive-search-deb-2-7-ui-2713.md
	cp ../interactive-search.md interactive-search-deb-2-8-cli-2714.md
	cp ../interactive-search.md interactive-search-deb-2-8-ui-2715.md
	cp ../interactive-search.md interactive-search-deb-2-9-cli-2716.md
	cp ../interactive-search.md interactive-search-deb-2-9-ui-2717.md
	cp ../interactive-search.md interactive-search-snap-2-7-cli-2706.md
	cp ../interactive-search.md interactive-search-snap-2-7-ui-2707.md
	cp ../interactive-search.md interactive-search-snap-2-8-cli-2708.md
	cp ../interactive-search.md interactive-search-snap-2-8-ui-2709.md
	cp ../interactive-search.md interactive-search-snap-2-9-cli-2710.md
	cp ../interactive-search.md interactive-search-snap-2-9-ui-2711.md
	xpub push discourse -t deb-2-7-cli interactive-search-deb-2-7-cli-2712.md
	xpub push discourse -t deb-2-7-ui interactive-search-deb-2-7-ui-2713.md
	xpub push discourse -t deb-2-8-cli interactive-search-deb-2-8-cli-2714.md
	xpub push discourse -t deb-2-8-ui interactive-search-deb-2-8-ui-2715.md
	xpub push discourse -t deb-2-9-cli interactive-search-deb-2-9-cli-2716.md
	xpub push discourse -t deb-2-9-ui interactive-search-deb-2-9-ui-2717.md
	xpub push discourse -t snap-2-7-cli interactive-search-snap-2-7-cli-2706.md
	xpub push discourse -t snap-2-7-ui interactive-search-snap-2-7-ui-2707.md
	xpub push discourse -t snap-2-8-cli interactive-search-snap-2-8-cli-2708.md
	xpub push discourse -t snap-2-8-ui interactive-search-snap-2-8-ui-2709.md
	xpub push discourse -t snap-2-9-cli interactive-search-snap-2-9-cli-2710.md
	xpub push discourse -t snap-2-9-ui interactive-search-snap-2-9-ui-2711.md
	xpub pull discourse 2717 2717
	cp -p interactive-search-deb-2-9-ui-2717.md interactive-search.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
ip-ranges.md: ../ip-ranges.md
	cp ../ip-ranges.md ip-ranges-deb-2-7-cli-2760.md
	cp ../ip-ranges.md ip-ranges-deb-2-7-ui-2761.md
	cp ../ip-ranges.md ip-ranges-deb-2-8-cli-2762.md
	cp ../ip-ranges.md ip-ranges-deb-2-8-ui-2763.md
	cp ../ip-ranges.md ip-ranges-deb-2-9-cli-2764.md
	cp ../ip-ranges.md ip-ranges-deb-2-9-ui-2765.md
	cp ../ip-ranges.md ip-ranges-snap-2-7-cli-2754.md
	cp ../ip-ranges.md ip-ranges-snap-2-7-ui-2755.md
	cp ../ip-ranges.md ip-ranges-snap-2-8-cli-2756.md
	cp ../ip-ranges.md ip-ranges-snap-2-8-ui-2757.md
	cp ../ip-ranges.md ip-ranges-snap-2-9-cli-2758.md
	cp ../ip-ranges.md ip-ranges-snap-2-9-ui-2759.md
	xpub push discourse -t deb-2-7-cli ip-ranges-deb-2-7-cli-2760.md
	xpub push discourse -t deb-2-7-ui ip-ranges-deb-2-7-ui-2761.md
	xpub push discourse -t deb-2-8-cli ip-ranges-deb-2-8-cli-2762.md
	xpub push discourse -t deb-2-8-ui ip-ranges-deb-2-8-ui-2763.md
	xpub push discourse -t deb-2-9-cli ip-ranges-deb-2-9-cli-2764.md
	xpub push discourse -t deb-2-9-ui ip-ranges-deb-2-9-ui-2765.md
	xpub push discourse -t snap-2-7-cli ip-ranges-snap-2-7-cli-2754.md
	xpub push discourse -t snap-2-7-ui ip-ranges-snap-2-7-ui-2755.md
	xpub push discourse -t snap-2-8-cli ip-ranges-snap-2-8-cli-2756.md
	xpub push discourse -t snap-2-8-ui ip-ranges-snap-2-8-ui-2757.md
	xpub push discourse -t snap-2-9-cli ip-ranges-snap-2-9-cli-2758.md
	xpub push discourse -t snap-2-9-ui ip-ranges-snap-2-9-ui-2759.md
	xpub pull discourse 2765 2765
	cp -p ip-ranges-deb-2-9-ui-2765.md ip-ranges.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
ipv6-addressing.md: ../ipv6-addressing.md
	cp ../ipv6-addressing.md ipv6-addressing-deb-2-7-cli-2772.md
	cp ../ipv6-addressing.md ipv6-addressing-deb-2-7-ui-2773.md
	cp ../ipv6-addressing.md ipv6-addressing-deb-2-8-cli-2774.md
	cp ../ipv6-addressing.md ipv6-addressing-deb-2-8-ui-2775.md
	cp ../ipv6-addressing.md ipv6-addressing-deb-2-9-cli-2776.md
	cp ../ipv6-addressing.md ipv6-addressing-deb-2-9-ui-2777.md
	cp ../ipv6-addressing.md ipv6-addressing-snap-2-7-cli-2766.md
	cp ../ipv6-addressing.md ipv6-addressing-snap-2-7-ui-2767.md
	cp ../ipv6-addressing.md ipv6-addressing-snap-2-8-cli-2768.md
	cp ../ipv6-addressing.md ipv6-addressing-snap-2-8-ui-2769.md
	cp ../ipv6-addressing.md ipv6-addressing-snap-2-9-cli-2770.md
	cp ../ipv6-addressing.md ipv6-addressing-snap-2-9-ui-2771.md
	xpub push discourse -t deb-2-7-cli ipv6-addressing-deb-2-7-cli-2772.md
	xpub push discourse -t deb-2-7-ui ipv6-addressing-deb-2-7-ui-2773.md
	xpub push discourse -t deb-2-8-cli ipv6-addressing-deb-2-8-cli-2774.md
	xpub push discourse -t deb-2-8-ui ipv6-addressing-deb-2-8-ui-2775.md
	xpub push discourse -t deb-2-9-cli ipv6-addressing-deb-2-9-cli-2776.md
	xpub push discourse -t deb-2-9-ui ipv6-addressing-deb-2-9-ui-2777.md
	xpub push discourse -t snap-2-7-cli ipv6-addressing-snap-2-7-cli-2766.md
	xpub push discourse -t snap-2-7-ui ipv6-addressing-snap-2-7-ui-2767.md
	xpub push discourse -t snap-2-8-cli ipv6-addressing-snap-2-8-cli-2768.md
	xpub push discourse -t snap-2-8-ui ipv6-addressing-snap-2-8-ui-2769.md
	xpub push discourse -t snap-2-9-cli ipv6-addressing-snap-2-9-cli-2770.md
	xpub push discourse -t snap-2-9-ui ipv6-addressing-snap-2-9-ui-2771.md
	xpub pull discourse 2777 2777
	cp -p ipv6-addressing-deb-2-9-ui-2777.md ipv6-addressing.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#k

kernel-boot-options.md: ../kernel-boot-options.md
	cp ../kernel-boot-options.md kernel-boot-options-deb-2-7-cli-2784.md
	cp ../kernel-boot-options.md kernel-boot-options-deb-2-7-ui-2785.md
	cp ../kernel-boot-options.md kernel-boot-options-deb-2-8-cli-2786.md
	cp ../kernel-boot-options.md kernel-boot-options-deb-2-8-ui-2787.md
	cp ../kernel-boot-options.md kernel-boot-options-deb-2-9-cli-2788.md
	cp ../kernel-boot-options.md kernel-boot-options-deb-2-9-ui-2789.md
	cp ../kernel-boot-options.md kernel-boot-options-snap-2-7-cli-2778.md
	cp ../kernel-boot-options.md kernel-boot-options-snap-2-7-ui-2779.md
	cp ../kernel-boot-options.md kernel-boot-options-snap-2-8-cli-2780.md
	cp ../kernel-boot-options.md kernel-boot-options-snap-2-8-ui-2781.md
	cp ../kernel-boot-options.md kernel-boot-options-snap-2-9-cli-2782.md
	cp ../kernel-boot-options.md kernel-boot-options-snap-2-9-ui-2783.md
	xpub push discourse -t deb-2-7-cli kernel-boot-options-deb-2-7-cli-2784.md
	xpub push discourse -t deb-2-7-ui kernel-boot-options-deb-2-7-ui-2785.md
	xpub push discourse -t deb-2-8-cli kernel-boot-options-deb-2-8-cli-2786.md
	xpub push discourse -t deb-2-8-ui kernel-boot-options-deb-2-8-ui-2787.md
	xpub push discourse -t deb-2-9-cli kernel-boot-options-deb-2-9-cli-2788.md
	xpub push discourse -t deb-2-9-ui kernel-boot-options-deb-2-9-ui-2789.md
	xpub push discourse -t snap-2-7-cli kernel-boot-options-snap-2-7-cli-2778.md
	xpub push discourse -t snap-2-7-ui kernel-boot-options-snap-2-7-ui-2779.md
	xpub push discourse -t snap-2-8-cli kernel-boot-options-snap-2-8-cli-2780.md
	xpub push discourse -t snap-2-8-ui kernel-boot-options-snap-2-8-ui-2781.md
	xpub push discourse -t snap-2-9-cli kernel-boot-options-snap-2-9-cli-2782.md
	xpub push discourse -t snap-2-9-ui kernel-boot-options-snap-2-9-ui-2783.md
	xpub pull discourse 2789 2789
	cp -p kernel-boot-options-deb-2-9-ui-2789.md kernel-boot-options.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#l

language-details-contributing-to-maas-docs.md: ../language-details-contributing-to-maas-docs.md
	cp ../language-details-contributing-to-maas-docs.md language-details-contributing-to-maas-docs-745.md
	xpub push discourse language-details-contributing-to-maas-docs-745.md
	xpub pull discourse 745 745
	cp -p language-details-contributing-to-maas-docs-745.md language-details-contributing-to-maas-docs.md
	mv language-details-contributing-to-maas-docs-745.md ./rad-versions

local-image-mirror.md: ../local-image-mirror.md
	cp ../local-image-mirror.md local-image-mirror-deb-2-7-cli-2808.md
	cp ../local-image-mirror.md local-image-mirror-deb-2-7-ui-2809.md
	cp ../local-image-mirror.md local-image-mirror-deb-2-8-cli-2810.md
	cp ../local-image-mirror.md local-image-mirror-deb-2-8-ui-2811.md
	cp ../local-image-mirror.md local-image-mirror-deb-2-9-cli-2812.md
	cp ../local-image-mirror.md local-image-mirror-deb-2-9-ui-2813.md
	cp ../local-image-mirror.md local-image-mirror-snap-2-7-cli-2802.md
	cp ../local-image-mirror.md local-image-mirror-snap-2-7-ui-2803.md
	cp ../local-image-mirror.md local-image-mirror-snap-2-8-cli-2804.md
	cp ../local-image-mirror.md local-image-mirror-snap-2-8-ui-2805.md
	cp ../local-image-mirror.md local-image-mirror-snap-2-9-cli-2806.md
	cp ../local-image-mirror.md local-image-mirror-snap-2-9-ui-2807.md
	xpub push discourse -t deb-2-7-cli local-image-mirror-deb-2-7-cli-2808.md
	xpub push discourse -t deb-2-7-ui local-image-mirror-deb-2-7-ui-2809.md
	xpub push discourse -t deb-2-8-cli local-image-mirror-deb-2-8-cli-2810.md
	xpub push discourse -t deb-2-8-ui local-image-mirror-deb-2-8-ui-2811.md
	xpub push discourse -t deb-2-9-cli local-image-mirror-deb-2-9-cli-2812.md
	xpub push discourse -t deb-2-9-ui local-image-mirror-deb-2-9-ui-2813.md
	xpub push discourse -t snap-2-7-cli local-image-mirror-snap-2-7-cli-2802.md
	xpub push discourse -t snap-2-7-ui local-image-mirror-snap-2-7-ui-2803.md
	xpub push discourse -t snap-2-8-cli local-image-mirror-snap-2-8-cli-2804.md
	xpub push discourse -t snap-2-8-ui local-image-mirror-snap-2-8-ui-2805.md
	xpub push discourse -t snap-2-9-cli local-image-mirror-snap-2-9-cli-2806.md
	xpub push discourse -t snap-2-9-ui local-image-mirror-snap-2-9-ui-2807.md
	xpub pull discourse 2813 2813
	cp -p local-image-mirror-deb-2-9-ui-2813.md local-image-mirror.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#m

maas-cli.md: ../maas-cli.md
	cp ../maas-cli.md maas-cli-802.md
	xpub push discourse maas-cli-802.md
	xpub pull discourse 802 802
	cp -p maas-cli-802.md maas-cli.md
	mv maas-cli-802.md ./rad-versions
 
maas-communication.md: ../maas-communication.md
	cp ../maas-communication.md maas-communication-deb-2-7-cli-2832.md
	cp ../maas-communication.md maas-communication-deb-2-7-ui-2833.md
	cp ../maas-communication.md maas-communication-deb-2-8-cli-2834.md
	cp ../maas-communication.md maas-communication-deb-2-8-ui-2835.md
	cp ../maas-communication.md maas-communication-deb-2-9-cli-2836.md
	cp ../maas-communication.md maas-communication-deb-2-9-ui-2837.md
	cp ../maas-communication.md maas-communication-snap-2-7-cli-2826.md
	cp ../maas-communication.md maas-communication-snap-2-7-ui-2827.md
	cp ../maas-communication.md maas-communication-snap-2-8-cli-2828.md
	cp ../maas-communication.md maas-communication-snap-2-8-ui-2829.md
	cp ../maas-communication.md maas-communication-snap-2-9-cli-2830.md
	cp ../maas-communication.md maas-communication-snap-2-9-ui-2831.md
	xpub push discourse -t deb-2-7-cli maas-communication-deb-2-7-cli-2832.md
	xpub push discourse -t deb-2-7-ui maas-communication-deb-2-7-ui-2833.md
	xpub push discourse -t deb-2-8-cli maas-communication-deb-2-8-cli-2834.md
	xpub push discourse -t deb-2-8-ui maas-communication-deb-2-8-ui-2835.md
	xpub push discourse -t deb-2-9-cli maas-communication-deb-2-9-cli-2836.md
	xpub push discourse -t deb-2-9-ui maas-communication-deb-2-9-ui-2837.md
	xpub push discourse -t snap-2-7-cli maas-communication-snap-2-7-cli-2826.md
	xpub push discourse -t snap-2-7-ui maas-communication-snap-2-7-ui-2827.md
	xpub push discourse -t snap-2-8-cli maas-communication-snap-2-8-cli-2828.md
	xpub push discourse -t snap-2-8-ui maas-communication-snap-2-8-ui-2829.md
	xpub push discourse -t snap-2-9-cli maas-communication-snap-2-9-cli-2830.md
	xpub push discourse -t snap-2-9-ui maas-communication-snap-2-9-ui-2831.md
	xpub pull discourse 2837 2837
	cp -p maas-communication-deb-2-9-ui-2837.md maas-communication.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
maas-documentation.md: ../maas-documentation.md
	cp ../maas-documentation.md maas-documentation-25.md
	cp ../maas-documentation.md maas-documentation-deb-2-7-cli-2844.md
	cp ../maas-documentation.md maas-documentation-deb-2-7-ui-2845.md
	cp ../maas-documentation.md maas-documentation-deb-2-8-cli-2846.md
	cp ../maas-documentation.md maas-documentation-deb-2-8-ui-2847.md
	cp ../maas-documentation.md maas-documentation-deb-2-9-cli-2848.md
	cp ../maas-documentation.md maas-documentation-deb-2-9-ui-2849.md
	cp ../maas-documentation.md maas-documentation-snap-2-7-cli-2838.md
	cp ../maas-documentation.md maas-documentation-snap-2-7-ui-2839.md
	cp ../maas-documentation.md maas-documentation-snap-2-8-cli-2840.md
	cp ../maas-documentation.md maas-documentation-snap-2-8-ui-2841.md
	cp ../maas-documentation.md maas-documentation-snap-2-9-cli-2842.md
	./scripts/strip-navigation.sh maas-documentation-deb-2-7-cli-2844.md
	./scripts/strip-navigation.sh maas-documentation-deb-2-7-ui-2845.md
	./scripts/strip-navigation.sh maas-documentation-deb-2-8-cli-2846.md
	./scripts/strip-navigation.sh maas-documentation-deb-2-8-ui-2847.md
	./scripts/strip-navigation.sh maas-documentation-deb-2-9-cli-2848.md
	./scripts/strip-navigation.sh maas-documentation-deb-2-9-ui-2849.md
	./scripts/strip-navigation.sh maas-documentation-snap-2-7-cli-2838.md
	./scripts/strip-navigation.sh maas-documentation-snap-2-7-ui-2839.md
	./scripts/strip-navigation.sh maas-documentation-snap-2-8-cli-2840.md
	./scripts/strip-navigation.sh maas-documentation-snap-2-8-ui-2841.md
	./scripts/strip-navigation.sh maas-documentation-snap-2-9-cli-2842.md
	xpub push discourse -t deb-2-7-cli maas-documentation-deb-2-7-cli-2844.md
	xpub push discourse -t deb-2-7-ui maas-documentation-deb-2-7-ui-2845.md
	xpub push discourse -t deb-2-8-cli maas-documentation-deb-2-8-cli-2846.md
	xpub push discourse -t deb-2-8-ui maas-documentation-deb-2-8-ui-2847.md
	xpub push discourse -t deb-2-9-cli maas-documentation-deb-2-9-cli-2848.md
	xpub push discourse -t deb-2-9-ui maas-documentation-deb-2-9-ui-2849.md
	xpub push discourse -t snap-2-7-cli maas-documentation-snap-2-7-cli-2838.md
	xpub push discourse -t snap-2-7-ui maas-documentation-snap-2-7-ui-2839.md
	xpub push discourse -t snap-2-8-cli maas-documentation-snap-2-8-cli-2840.md
	xpub push discourse -t snap-2-8-ui maas-documentation-snap-2-8-ui-2841.md
	xpub push discourse -t snap-2-9-ui maas-documentation-25.md
	xpub push discourse -t snap-2-9-cli maas-documentation-snap-2-9-cli-2842.md
	xpub pull discourse 25 25
	xpub pull discourse 2838 2842
	xpub pull discourse 2844 2849
	cp -p maas-documentation-25.md maas-documentation.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
maas-image-builder.md: ../maas-image-builder.md
	cp ../maas-image-builder.md maas-image-builder-deb-2-7-cli-2856.md
	cp ../maas-image-builder.md maas-image-builder-deb-2-7-ui-2857.md
	cp ../maas-image-builder.md maas-image-builder-deb-2-8-cli-2858.md
	cp ../maas-image-builder.md maas-image-builder-deb-2-8-ui-2859.md
	cp ../maas-image-builder.md maas-image-builder-deb-2-9-cli-2860.md
	cp ../maas-image-builder.md maas-image-builder-deb-2-9-ui-2861.md
	cp ../maas-image-builder.md maas-image-builder-snap-2-7-cli-2850.md
	cp ../maas-image-builder.md maas-image-builder-snap-2-7-ui-2851.md
	cp ../maas-image-builder.md maas-image-builder-snap-2-8-cli-2852.md
	cp ../maas-image-builder.md maas-image-builder-snap-2-8-ui-2853.md
	cp ../maas-image-builder.md maas-image-builder-snap-2-9-cli-2854.md
	cp ../maas-image-builder.md maas-image-builder-snap-2-9-ui-2855.md
	xpub push discourse -t deb-2-7-cli maas-image-builder-deb-2-7-cli-2856.md
	xpub push discourse -t deb-2-7-ui maas-image-builder-deb-2-7-ui-2857.md
	xpub push discourse -t deb-2-8-cli maas-image-builder-deb-2-8-cli-2858.md
	xpub push discourse -t deb-2-8-ui maas-image-builder-deb-2-8-ui-2859.md
	xpub push discourse -t deb-2-9-cli maas-image-builder-deb-2-9-cli-2860.md
	xpub push discourse -t deb-2-9-ui maas-image-builder-deb-2-9-ui-2861.md
	xpub push discourse -t snap-2-7-cli maas-image-builder-snap-2-7-cli-2850.md
	xpub push discourse -t snap-2-7-ui maas-image-builder-snap-2-7-ui-2851.md
	xpub push discourse -t snap-2-8-cli maas-image-builder-snap-2-8-cli-2852.md
	xpub push discourse -t snap-2-8-ui maas-image-builder-snap-2-8-ui-2853.md
	xpub push discourse -t snap-2-9-cli maas-image-builder-snap-2-9-cli-2854.md
	xpub push discourse -t snap-2-9-ui maas-image-builder-snap-2-9-ui-2855.md
	xpub pull discourse 2861 2861
	cp -p maas-image-builder-deb-2-9-ui-2861.md maas-image-builder.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
maas-installation.md: ../maas-installation.md
	cp ../maas-installation.md maas-installation-deb-2-7-cli-3324.md
	cp ../maas-installation.md maas-installation-deb-2-7-ui-3325.md
	cp ../maas-installation.md maas-installation-deb-2-8-cli-3326.md
	cp ../maas-installation.md maas-installation-deb-2-8-ui-3327.md
	cp ../maas-installation.md maas-installation-deb-2-9-cli-3328.md
	cp ../maas-installation.md maas-installation-deb-2-9-ui-3329.md
	cp ../maas-installation.md maas-installation-snap-2-7-cli-3318.md
	cp ../maas-installation.md maas-installation-snap-2-7-ui-3319.md
	cp ../maas-installation.md maas-installation-snap-2-8-cli-3320.md
	cp ../maas-installation.md maas-installation-snap-2-8-ui-3321.md
	cp ../maas-installation.md maas-installation-snap-2-9-cli-3322.md
	cp ../maas-installation.md maas-installation-snap-2-9-ui-3323.md
	xpub push discourse -t deb-2-7-cli maas-installation-deb-2-7-cli-3324.md
	xpub push discourse -t deb-2-7-ui maas-installation-deb-2-7-ui-3325.md
	xpub push discourse -t deb-2-8-cli maas-installation-deb-2-8-cli-3326.md
	xpub push discourse -t deb-2-8-ui maas-installation-deb-2-8-ui-3327.md
	xpub push discourse -t deb-2-9-cli maas-installation-deb-2-9-cli-3328.md
	xpub push discourse -t deb-2-9-ui maas-installation-deb-2-9-ui-3329.md
	xpub push discourse -t snap-2-7-cli maas-installation-snap-2-7-cli-3318.md
	xpub push discourse -t snap-2-7-ui maas-installation-snap-2-7-ui-3319.md
	xpub push discourse -t snap-2-8-cli maas-installation-snap-2-8-cli-3320.md
	xpub push discourse -t snap-2-8-ui maas-installation-snap-2-8-ui-3321.md
	xpub push discourse -t snap-2-9-cli maas-installation-snap-2-9-cli-3322.md
	xpub push discourse -t snap-2-9-ui maas-installation-snap-2-9-ui-3323.md
	xpub pull discourse 3329 3329
	cp -p maas-installation-deb-2-9-ui-3329.md maas-installation.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

maas-logging.md: ../maas-logging.md
	cp ../maas-logging.md maas-logging-deb-2-7-cli-2868.md
	cp ../maas-logging.md maas-logging-deb-2-7-ui-2869.md
	cp ../maas-logging.md maas-logging-deb-2-8-cli-2870.md
	cp ../maas-logging.md maas-logging-deb-2-8-ui-2871.md
	cp ../maas-logging.md maas-logging-deb-2-9-cli-2872.md
	cp ../maas-logging.md maas-logging-deb-2-9-ui-2873.md
	cp ../maas-logging.md maas-logging-snap-2-7-cli-2862.md
	cp ../maas-logging.md maas-logging-snap-2-7-ui-2863.md
	cp ../maas-logging.md maas-logging-snap-2-8-cli-2864.md
	cp ../maas-logging.md maas-logging-snap-2-8-ui-2865.md
	cp ../maas-logging.md maas-logging-snap-2-9-cli-2866.md
	cp ../maas-logging.md maas-logging-snap-2-9-ui-2867.md
	xpub push discourse -t deb-2-7-cli maas-logging-deb-2-7-cli-2868.md
	xpub push discourse -t deb-2-7-ui maas-logging-deb-2-7-ui-2869.md
	xpub push discourse -t deb-2-8-cli maas-logging-deb-2-8-cli-2870.md
	xpub push discourse -t deb-2-8-ui maas-logging-deb-2-8-ui-2871.md
	xpub push discourse -t deb-2-9-cli maas-logging-deb-2-9-cli-2872.md
	xpub push discourse -t deb-2-9-ui maas-logging-deb-2-9-ui-2873.md
	xpub push discourse -t snap-2-7-cli maas-logging-snap-2-7-cli-2862.md
	xpub push discourse -t snap-2-7-ui maas-logging-snap-2-7-ui-2863.md
	xpub push discourse -t snap-2-8-cli maas-logging-snap-2-8-cli-2864.md
	xpub push discourse -t snap-2-8-ui maas-logging-snap-2-8-ui-2865.md
	xpub push discourse -t snap-2-9-cli maas-logging-snap-2-9-cli-2866.md
	xpub push discourse -t snap-2-9-ui maas-logging-snap-2-9-ui-2867.md
	xpub pull discourse 2873 2873
	cp -p maas-logging-deb-2-9-ui-2873.md maas-logging.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
maas-requirements.md: ../maas-requirements.md
	cp ../maas-requirements.md maas-requirements-deb-2-7-cli-2880.md
	cp ../maas-requirements.md maas-requirements-deb-2-7-ui-2881.md
	cp ../maas-requirements.md maas-requirements-deb-2-8-cli-2882.md
	cp ../maas-requirements.md maas-requirements-deb-2-8-ui-2883.md
	cp ../maas-requirements.md maas-requirements-deb-2-9-cli-2884.md
	cp ../maas-requirements.md maas-requirements-deb-2-9-ui-2885.md
	cp ../maas-requirements.md maas-requirements-snap-2-7-cli-2874.md
	cp ../maas-requirements.md maas-requirements-snap-2-7-ui-2875.md
	cp ../maas-requirements.md maas-requirements-snap-2-8-cli-2876.md
	cp ../maas-requirements.md maas-requirements-snap-2-8-ui-2877.md
	cp ../maas-requirements.md maas-requirements-snap-2-9-cli-2878.md
	cp ../maas-requirements.md maas-requirements-snap-2-9-ui-2879.md
	xpub push discourse -t deb-2-7-cli maas-requirements-deb-2-7-cli-2880.md
	xpub push discourse -t deb-2-7-ui maas-requirements-deb-2-7-ui-2881.md
	xpub push discourse -t deb-2-8-cli maas-requirements-deb-2-8-cli-2882.md
	xpub push discourse -t deb-2-8-ui maas-requirements-deb-2-8-ui-2883.md
	xpub push discourse -t deb-2-9-cli maas-requirements-deb-2-9-cli-2884.md
	xpub push discourse -t deb-2-9-ui maas-requirements-deb-2-9-ui-2885.md
	xpub push discourse -t snap-2-7-cli maas-requirements-snap-2-7-cli-2874.md
	xpub push discourse -t snap-2-7-ui maas-requirements-snap-2-7-ui-2875.md
	xpub push discourse -t snap-2-8-cli maas-requirements-snap-2-8-cli-2876.md
	xpub push discourse -t snap-2-8-ui maas-requirements-snap-2-8-ui-2877.md
	xpub push discourse -t snap-2-9-cli maas-requirements-snap-2-9-cli-2878.md
	xpub push discourse -t snap-2-9-ui maas-requirements-snap-2-9-ui-2879.md
	xpub pull discourse 2885 2885
	cp -p maas-requirements-deb-2-9-ui-2885.md maas-requirements.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

maas-tags.md: ../maas-tags.md
	cp ../maas-tags.md maas-tags-deb-2-7-cli-2892.md
	cp ../maas-tags.md maas-tags-deb-2-7-ui-2893.md
	cp ../maas-tags.md maas-tags-deb-2-8-cli-2894.md
	cp ../maas-tags.md maas-tags-deb-2-8-ui-2895.md
	cp ../maas-tags.md maas-tags-deb-2-9-cli-2896.md
	cp ../maas-tags.md maas-tags-deb-2-9-ui-2897.md
	cp ../maas-tags.md maas-tags-snap-2-7-cli-2886.md
	cp ../maas-tags.md maas-tags-snap-2-7-ui-2887.md
	cp ../maas-tags.md maas-tags-snap-2-8-cli-2888.md
	cp ../maas-tags.md maas-tags-snap-2-8-ui-2889.md
	cp ../maas-tags.md maas-tags-snap-2-9-cli-2890.md
	cp ../maas-tags.md maas-tags-snap-2-9-ui-2891.md
	xpub push discourse -t deb-2-7-cli maas-tags-deb-2-7-cli-2892.md
	xpub push discourse -t deb-2-7-ui maas-tags-deb-2-7-ui-2893.md
	xpub push discourse -t deb-2-8-cli maas-tags-deb-2-8-cli-2894.md
	xpub push discourse -t deb-2-8-ui maas-tags-deb-2-8-ui-2895.md
	xpub push discourse -t deb-2-9-cli maas-tags-deb-2-9-cli-2896.md
	xpub push discourse -t deb-2-9-ui maas-tags-deb-2-9-ui-2897.md
	xpub push discourse -t snap-2-7-cli maas-tags-snap-2-7-cli-2886.md
	xpub push discourse -t snap-2-7-ui maas-tags-snap-2-7-ui-2887.md
	xpub push discourse -t snap-2-8-cli maas-tags-snap-2-8-cli-2888.md
	xpub push discourse -t snap-2-8-ui maas-tags-snap-2-8-ui-2889.md
	xpub push discourse -t snap-2-9-cli maas-tags-snap-2-9-cli-2890.md
	xpub push discourse -t snap-2-9-ui maas-tags-snap-2-9-ui-2891.md
	xpub pull discourse 2897 2897
	cp -p maas-tags-deb-2-9-ui-2897.md maas-tags.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
machine-logs.md: ../machine-logs.md
	cp ../machine-logs.md machine-logs-deb-2-7-cli-3448.md
	cp ../machine-logs.md machine-logs-deb-2-7-ui-3449.md
	cp ../machine-logs.md machine-logs-deb-2-8-cli-3450.md
	cp ../machine-logs.md machine-logs-deb-2-8-ui-3451.md
	cp ../machine-logs.md machine-logs-deb-2-9-cli-3453.md
	cp ../machine-logs.md machine-logs-deb-2-9-ui-3452.md
	cp ../machine-logs.md machine-logs-snap-2-7-cli-3442.md
	cp ../machine-logs.md machine-logs-snap-2-7-ui-3443.md
	cp ../machine-logs.md machine-logs-snap-2-8-cli-3444.md
	cp ../machine-logs.md machine-logs-snap-2-8-ui-3445.md
	cp ../machine-logs.md machine-logs-snap-2-9-cli-3446.md
	cp ../machine-logs.md machine-logs-snap-2-9-ui-3447.md
	xpub push discourse -t deb-2-7-cli machine-logs-deb-2-7-cli-3448.md
	xpub push discourse -t deb-2-7-ui machine-logs-deb-2-7-ui-3449.md
	xpub push discourse -t deb-2-8-cli machine-logs-deb-2-8-cli-3450.md
	xpub push discourse -t deb-2-8-ui machine-logs-deb-2-8-ui-3451.md
	xpub push discourse -t deb-2-9-cli machine-logs-deb-2-9-cli-3453.md
	xpub push discourse -t deb-2-9-ui machine-logs-deb-2-9-ui-3452.md
	xpub push discourse -t snap-2-7-cli machine-logs-snap-2-7-cli-3442.md
	xpub push discourse -t snap-2-7-ui machine-logs-snap-2-7-ui-3443.md
	xpub push discourse -t snap-2-8-cli machine-logs-snap-2-8-cli-3444.md
	xpub push discourse -t snap-2-8-ui machine-logs-snap-2-8-ui-3445.md
	xpub push discourse -t snap-2-9-cli machine-logs-snap-2-9-cli-3446.md
	xpub push discourse -t snap-2-9-ui machine-logs-snap-2-9-ui-3447.md
	xpub pull discourse 3453 3453
	cp -p machine-logs-deb-2-9-ui-3452.md machine-logs.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

machines.md: ../machines.md
	cp ../machines.md machines-deb-2-7-cli-2736.md
	cp ../machines.md machines-deb-2-7-ui-2737.md
	cp ../machines.md machines-deb-2-8-cli-2738.md
	cp ../machines.md machines-deb-2-8-ui-2739.md
	cp ../machines.md machines-deb-2-9-cli-2740.md
	cp ../machines.md machines-deb-2-9-ui-2741.md
	cp ../machines.md machines-snap-2-7-cli-2730.md
	cp ../machines.md machines-snap-2-7-ui-2731.md
	cp ../machines.md machines-snap-2-8-cli-2732.md
	cp ../machines.md machines-snap-2-8-ui-2733.md
	cp ../machines.md machines-snap-2-9-cli-2734.md
	cp ../machines.md machines-snap-2-9-ui-2735.md
	xpub push discourse -t deb-2-7-cli machines-deb-2-7-cli-2736.md
	xpub push discourse -t deb-2-7-ui machines-deb-2-7-ui-2737.md
	xpub push discourse -t deb-2-8-cli machines-deb-2-8-cli-2738.md
	xpub push discourse -t deb-2-8-ui machines-deb-2-8-ui-2739.md
	xpub push discourse -t deb-2-9-cli machines-deb-2-9-cli-2740.md
	xpub push discourse -t deb-2-9-ui machines-deb-2-9-ui-2741.md
	xpub push discourse -t snap-2-7-cli machines-snap-2-7-cli-2730.md
	xpub push discourse -t snap-2-7-ui machines-snap-2-7-ui-2731.md
	xpub push discourse -t snap-2-8-cli machines-snap-2-8-cli-2732.md
	xpub push discourse -t snap-2-8-ui machines-snap-2-8-ui-2733.md
	xpub push discourse -t snap-2-9-cli machines-snap-2-9-cli-2734.md
	xpub push discourse -t snap-2-9-ui machines-snap-2-9-ui-2735.md
	xpub pull discourse 2741 2741
	cp -p machines-deb-2-9-ui-2741.md machines.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
managing-dhcp.md: ../managing-dhcp.md
	cp ../managing-dhcp.md managing-dhcp-deb-2-7-cli-2904.md
	cp ../managing-dhcp.md managing-dhcp-deb-2-7-ui-2905.md
	cp ../managing-dhcp.md managing-dhcp-deb-2-8-cli-2906.md
	cp ../managing-dhcp.md managing-dhcp-deb-2-8-ui-2907.md
	cp ../managing-dhcp.md managing-dhcp-deb-2-9-cli-2908.md
	cp ../managing-dhcp.md managing-dhcp-deb-2-9-ui-2909.md
	cp ../managing-dhcp.md managing-dhcp-snap-2-7-cli-2898.md
	cp ../managing-dhcp.md managing-dhcp-snap-2-7-ui-2899.md
	cp ../managing-dhcp.md managing-dhcp-snap-2-8-cli-2900.md
	cp ../managing-dhcp.md managing-dhcp-snap-2-8-ui-2901.md
	cp ../managing-dhcp.md managing-dhcp-snap-2-9-cli-2902.md
	cp ../managing-dhcp.md managing-dhcp-snap-2-9-ui-2903.md
	xpub push discourse -t deb-2-7-cli managing-dhcp-deb-2-7-cli-2904.md
	xpub push discourse -t deb-2-7-ui managing-dhcp-deb-2-7-ui-2905.md
	xpub push discourse -t deb-2-8-cli managing-dhcp-deb-2-8-cli-2906.md
	xpub push discourse -t deb-2-8-ui managing-dhcp-deb-2-8-ui-2907.md
	xpub push discourse -t deb-2-9-cli managing-dhcp-deb-2-9-cli-2908.md
	xpub push discourse -t deb-2-9-ui managing-dhcp-deb-2-9-ui-2909.md
	xpub push discourse -t snap-2-7-cli managing-dhcp-snap-2-7-cli-2898.md
	xpub push discourse -t snap-2-7-ui managing-dhcp-snap-2-7-ui-2899.md
	xpub push discourse -t snap-2-8-cli managing-dhcp-snap-2-8-cli-2900.md
	xpub push discourse -t snap-2-8-ui managing-dhcp-snap-2-8-ui-2901.md
	xpub push discourse -t snap-2-9-cli managing-dhcp-snap-2-9-cli-2902.md
	xpub push discourse -t snap-2-9-ui managing-dhcp-snap-2-9-ui-2903.md
	xpub pull discourse 2909 2909
	cp -p managing-dhcp-deb-2-9-ui-2909.md managing-dhcp.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
managing-stp.md: ../managing-stp.md
	cp ../managing-stp.md managing-stp-deb-2-7-cli-2916.md
	cp ../managing-stp.md managing-stp-deb-2-7-ui-2917.md
	cp ../managing-stp.md managing-stp-deb-2-8-cli-2918.md
	cp ../managing-stp.md managing-stp-deb-2-8-ui-2919.md
	cp ../managing-stp.md managing-stp-deb-2-9-cli-2920.md
	cp ../managing-stp.md managing-stp-deb-2-9-ui-2921.md
	cp ../managing-stp.md managing-stp-snap-2-7-cli-2910.md
	cp ../managing-stp.md managing-stp-snap-2-7-ui-2911.md
	cp ../managing-stp.md managing-stp-snap-2-8-cli-2912.md
	cp ../managing-stp.md managing-stp-snap-2-8-ui-2913.md
	cp ../managing-stp.md managing-stp-snap-2-9-cli-2914.md
	cp ../managing-stp.md managing-stp-snap-2-9-ui-2915.md
	xpub push discourse -t deb-2-7-cli managing-stp-deb-2-7-cli-2916.md
	xpub push discourse -t deb-2-7-ui managing-stp-deb-2-7-ui-2917.md
	xpub push discourse -t deb-2-8-cli managing-stp-deb-2-8-cli-2918.md
	xpub push discourse -t deb-2-8-ui managing-stp-deb-2-8-ui-2919.md
	xpub push discourse -t deb-2-9-cli managing-stp-deb-2-9-cli-2920.md
	xpub push discourse -t deb-2-9-ui managing-stp-deb-2-9-ui-2921.md
	xpub push discourse -t snap-2-7-cli managing-stp-snap-2-7-cli-2910.md
	xpub push discourse -t snap-2-7-ui managing-stp-snap-2-7-ui-2911.md
	xpub push discourse -t snap-2-8-cli managing-stp-snap-2-8-cli-2912.md
	xpub push discourse -t snap-2-8-ui managing-stp-snap-2-8-ui-2913.md
	xpub push discourse -t snap-2-9-cli managing-stp-snap-2-9-cli-2914.md
	xpub push discourse -t snap-2-9-ui managing-stp-snap-2-9-ui-2915.md
	xpub pull discourse 2921 2921
	cp -p managing-stp-deb-2-9-ui-2921.md managing-stp.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#n

network-discovery.md: ../network-discovery.md
	cp ../network-discovery.md network-discovery-deb-2-7-cli-2928.md
	cp ../network-discovery.md network-discovery-deb-2-7-ui-2929.md
	cp ../network-discovery.md network-discovery-deb-2-8-cli-2930.md
	cp ../network-discovery.md network-discovery-deb-2-8-ui-2931.md
	cp ../network-discovery.md network-discovery-deb-2-9-cli-2932.md
	cp ../network-discovery.md network-discovery-deb-2-9-ui-2933.md
	cp ../network-discovery.md network-discovery-snap-2-7-cli-2922.md
	cp ../network-discovery.md network-discovery-snap-2-7-ui-2923.md
	cp ../network-discovery.md network-discovery-snap-2-8-cli-2924.md
	cp ../network-discovery.md network-discovery-snap-2-8-ui-2925.md
	cp ../network-discovery.md network-discovery-snap-2-9-cli-2926.md
	cp ../network-discovery.md network-discovery-snap-2-9-ui-2927.md
	xpub push discourse -t deb-2-7-cli network-discovery-deb-2-7-cli-2928.md
	xpub push discourse -t deb-2-7-ui network-discovery-deb-2-7-ui-2929.md
	xpub push discourse -t deb-2-8-cli network-discovery-deb-2-8-cli-2930.md
	xpub push discourse -t deb-2-8-ui network-discovery-deb-2-8-ui-2931.md
	xpub push discourse -t deb-2-9-cli network-discovery-deb-2-9-cli-2932.md
	xpub push discourse -t deb-2-9-ui network-discovery-deb-2-9-ui-2933.md
	xpub push discourse -t snap-2-7-cli network-discovery-snap-2-7-cli-2922.md
	xpub push discourse -t snap-2-7-ui network-discovery-snap-2-7-ui-2923.md
	xpub push discourse -t snap-2-8-cli network-discovery-snap-2-8-cli-2924.md
	xpub push discourse -t snap-2-8-ui network-discovery-snap-2-8-ui-2925.md
	xpub push discourse -t snap-2-9-cli network-discovery-snap-2-9-cli-2926.md
	xpub push discourse -t snap-2-9-ui network-discovery-snap-2-9-ui-2927.md
	xpub pull discourse 2933 2933
	cp -p network-discovery-deb-2-9-ui-2933.md network-discovery.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
networking.md: ../networking.md
	cp ../networking.md networking-deb-2-7-cli-2952.md
	cp ../networking.md networking-deb-2-7-ui-2953.md
	cp ../networking.md networking-deb-2-8-cli-2954.md
	cp ../networking.md networking-deb-2-8-ui-2955.md
	cp ../networking.md networking-deb-2-9-cli-2956.md
	cp ../networking.md networking-deb-2-9-ui-2957.md
	cp ../networking.md networking-snap-2-7-cli-2946.md
	cp ../networking.md networking-snap-2-7-ui-2947.md
	cp ../networking.md networking-snap-2-8-cli-2948.md
	cp ../networking.md networking-snap-2-8-ui-2949.md
	cp ../networking.md networking-snap-2-9-cli-2950.md
	cp ../networking.md networking-snap-2-9-ui-2951.md
	xpub push discourse -t deb-2-7-cli networking-deb-2-7-cli-2952.md
	xpub push discourse -t deb-2-7-ui networking-deb-2-7-ui-2953.md
	xpub push discourse -t deb-2-8-cli networking-deb-2-8-cli-2954.md
	xpub push discourse -t deb-2-8-ui networking-deb-2-8-ui-2955.md
	xpub push discourse -t deb-2-9-cli networking-deb-2-9-cli-2956.md
	xpub push discourse -t deb-2-9-ui networking-deb-2-9-ui-2957.md
	xpub push discourse -t snap-2-7-cli networking-snap-2-7-cli-2946.md
	xpub push discourse -t snap-2-7-ui networking-snap-2-7-ui-2947.md
	xpub push discourse -t snap-2-8-cli networking-snap-2-8-cli-2948.md
	xpub push discourse -t snap-2-8-ui networking-snap-2-8-ui-2949.md
	xpub push discourse -t snap-2-9-cli networking-snap-2-9-cli-2950.md
	xpub push discourse -t snap-2-9-ui networking-snap-2-9-ui-2951.md
	xpub pull discourse 2957 2957
	cp -p networking-deb-2-9-ui-2957.md networking.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
network-testing.md: ../network-testing.md
	cp ../network-testing.md network-testing-deb-2-7-cli-2940.md
	cp ../network-testing.md network-testing-deb-2-7-ui-2941.md
	cp ../network-testing.md network-testing-deb-2-8-cli-2942.md
	cp ../network-testing.md network-testing-deb-2-8-ui-2943.md
	cp ../network-testing.md network-testing-deb-2-9-cli-2944.md
	cp ../network-testing.md network-testing-deb-2-9-ui-2945.md
	cp ../network-testing.md network-testing-snap-2-7-cli-2934.md
	cp ../network-testing.md network-testing-snap-2-7-ui-2935.md
	cp ../network-testing.md network-testing-snap-2-8-cli-2936.md
	cp ../network-testing.md network-testing-snap-2-8-ui-2937.md
	cp ../network-testing.md network-testing-snap-2-9-cli-2938.md
	cp ../network-testing.md network-testing-snap-2-9-ui-2939.md
	xpub push discourse -t deb-2-7-cli network-testing-deb-2-7-cli-2940.md
	xpub push discourse -t deb-2-7-ui network-testing-deb-2-7-ui-2941.md
	xpub push discourse -t deb-2-8-cli network-testing-deb-2-8-cli-2942.md
	xpub push discourse -t deb-2-8-ui network-testing-deb-2-8-ui-2943.md
	xpub push discourse -t deb-2-9-cli network-testing-deb-2-9-cli-2944.md
	xpub push discourse -t deb-2-9-ui network-testing-deb-2-9-ui-2945.md
	xpub push discourse -t snap-2-7-cli network-testing-snap-2-7-cli-2934.md
	xpub push discourse -t snap-2-7-ui network-testing-snap-2-7-ui-2935.md
	xpub push discourse -t snap-2-8-cli network-testing-snap-2-8-cli-2936.md
	xpub push discourse -t snap-2-8-ui network-testing-snap-2-8-ui-2937.md
	xpub push discourse -t snap-2-9-cli network-testing-snap-2-9-cli-2938.md
	xpub push discourse -t snap-2-9-ui network-testing-snap-2-9-ui-2939.md
	xpub pull discourse 2945 2945
	cp -p network-testing-deb-2-9-ui-2945.md network-testing.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
ntp-services.md: ../ntp-services.md
	cp ../ntp-services.md ntp-services-deb-2-7-cli-2964.md
	cp ../ntp-services.md ntp-services-deb-2-7-ui-2965.md
	cp ../ntp-services.md ntp-services-deb-2-8-cli-2966.md
	cp ../ntp-services.md ntp-services-deb-2-8-ui-2967.md
	cp ../ntp-services.md ntp-services-deb-2-9-cli-2968.md
	cp ../ntp-services.md ntp-services-deb-2-9-ui-2969.md
	cp ../ntp-services.md ntp-services-snap-2-7-cli-2958.md
	cp ../ntp-services.md ntp-services-snap-2-7-ui-2959.md
	cp ../ntp-services.md ntp-services-snap-2-8-cli-2960.md
	cp ../ntp-services.md ntp-services-snap-2-8-ui-2961.md
	cp ../ntp-services.md ntp-services-snap-2-9-cli-2962.md
	cp ../ntp-services.md ntp-services-snap-2-9-ui-2963.md
	xpub push discourse -t deb-2-7-cli ntp-services-deb-2-7-cli-2964.md
	xpub push discourse -t deb-2-7-ui ntp-services-deb-2-7-ui-2965.md
	xpub push discourse -t deb-2-8-cli ntp-services-deb-2-8-cli-2966.md
	xpub push discourse -t deb-2-8-ui ntp-services-deb-2-8-ui-2967.md
	xpub push discourse -t deb-2-9-cli ntp-services-deb-2-9-cli-2968.md
	xpub push discourse -t deb-2-9-ui ntp-services-deb-2-9-ui-2969.md
	xpub push discourse -t snap-2-7-cli ntp-services-snap-2-7-cli-2958.md
	xpub push discourse -t snap-2-7-ui ntp-services-snap-2-7-ui-2959.md
	xpub push discourse -t snap-2-8-cli ntp-services-snap-2-8-cli-2960.md
	xpub push discourse -t snap-2-8-ui ntp-services-snap-2-8-ui-2961.md
	xpub push discourse -t snap-2-9-cli ntp-services-snap-2-9-cli-2962.md
	xpub push discourse -t snap-2-9-ui ntp-services-snap-2-9-ui-2963.md
	xpub pull discourse 2969 2969
	cp -p ntp-services-deb-2-9-ui-2969.md ntp-services.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#p

package-repositories.md: ../package-repositories.md
	cp ../package-repositories.md package-repositories-deb-2-7-cli-2976.md
	cp ../package-repositories.md package-repositories-deb-2-7-ui-2977.md
	cp ../package-repositories.md package-repositories-deb-2-8-cli-2978.md
	cp ../package-repositories.md package-repositories-deb-2-8-ui-2979.md
	cp ../package-repositories.md package-repositories-deb-2-9-cli-2980.md
	cp ../package-repositories.md package-repositories-deb-2-9-ui-2981.md
	xpub push discourse -t deb-2-7-cli package-repositories-deb-2-7-cli-2976.md
	xpub push discourse -t deb-2-7-ui package-repositories-deb-2-7-ui-2977.md
	xpub push discourse -t deb-2-8-cli package-repositories-deb-2-8-cli-2978.md
	xpub push discourse -t deb-2-8-ui package-repositories-deb-2-8-ui-2979.md
	xpub push discourse -t deb-2-9-cli package-repositories-deb-2-9-cli-2980.md
	xpub push discourse -t deb-2-9-ui package-repositories-deb-2-9-ui-2981.md
	xpub pull discourse 2993 2993
	cp -p package-repositpackage-deb-2-9-ui-repositories.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

partitions.md: ../partitions.md
	cp ../partitions.md partitions-deb-2-7-cli-2988.md
	cp ../partitions.md partitions-deb-2-7-ui-2989.md
	cp ../partitions.md partitions-deb-2-8-cli-2990.md
	cp ../partitions.md partitions-deb-2-8-ui-2991.md
	cp ../partitions.md partitions-deb-2-9-cli-2992.md
	cp ../partitions.md partitions-deb-2-9-ui-2993.md
	cp ../partitions.md partitions-snap-2-7-cli-2982.md
	cp ../partitions.md partitions-snap-2-7-ui-2983.md
	cp ../partitions.md partitions-snap-2-8-cli-2984.md
	cp ../partitions.md partitions-snap-2-8-ui-2985.md
	cp ../partitions.md partitions-snap-2-9-cli-2986.md
	cp ../partitions.md partitions-snap-2-9-ui-2987.md
	xpub push discourse -t deb-2-7-cli partitions-deb-2-7-cli-2988.md
	xpub push discourse -t deb-2-7-ui partitions-deb-2-7-ui-2989.md
	xpub push discourse -t deb-2-8-cli partitions-deb-2-8-cli-2990.md
	xpub push discourse -t deb-2-8-ui partitions-deb-2-8-ui-2991.md
	xpub push discourse -t deb-2-9-cli partitions-deb-2-9-cli-2992.md
	xpub push discourse -t deb-2-9-ui partitions-deb-2-9-ui-2993.md
	xpub push discourse -t snap-2-7-cli partitions-snap-2-7-cli-2982.md
	xpub push discourse -t snap-2-7-ui partitions-snap-2-7-ui-2983.md
	xpub push discourse -t snap-2-8-cli partitions-snap-2-8-cli-2984.md
	xpub push discourse -t snap-2-8-ui partitions-snap-2-8-ui-2985.md
	xpub push discourse -t snap-2-9-cli partitions-snap-2-9-cli-2986.md
	xpub push discourse -t snap-2-9-ui partitions-snap-2-9-ui-2987.md
	xpub pull discourse 2993 2993
	cp -p partitions-deb-2-9-ui-2993.md partitions.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
postgresql-ha-hot-standby.md: ../postgresql-ha-hot-standby.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-deb-2-7-cli-3000.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-deb-2-7-ui-3001.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-deb-2-8-cli-3002.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-deb-2-8-ui-3003.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-deb-2-9-cli-3004.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-deb-2-9-ui-3005.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-snap-2-7-cli-2994.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-snap-2-7-ui-2995.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-snap-2-8-cli-2996.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-snap-2-8-ui-2997.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-snap-2-9-cli-2998.md
	cp ../postgresql-ha-hot-standby.md postgresql-ha-hot-standby-snap-2-9-ui-2999.md
	xpub push discourse -t deb-2-7-cli postgresql-ha-hot-standby-deb-2-7-cli-3000.md
	xpub push discourse -t deb-2-7-ui postgresql-ha-hot-standby-deb-2-7-ui-3001.md
	xpub push discourse -t deb-2-8-cli postgresql-ha-hot-standby-deb-2-8-cli-3002.md
	xpub push discourse -t deb-2-8-ui postgresql-ha-hot-standby-deb-2-8-ui-3003.md
	xpub push discourse -t deb-2-9-cli postgresql-ha-hot-standby-deb-2-9-cli-3004.md
	xpub push discourse -t deb-2-9-ui postgresql-ha-hot-standby-deb-2-9-ui-3005.md
	xpub push discourse -t snap-2-7-cli postgresql-ha-hot-standby-snap-2-7-cli-2994.md
	xpub push discourse -t snap-2-7-ui postgresql-ha-hot-standby-snap-2-7-ui-2995.md
	xpub push discourse -t snap-2-8-cli postgresql-ha-hot-standby-snap-2-8-cli-2996.md
	xpub push discourse -t snap-2-8-ui postgresql-ha-hot-standby-snap-2-8-ui-2997.md
	xpub push discourse -t snap-2-9-cli postgresql-ha-hot-standby-snap-2-9-cli-2998.md
	xpub push discourse -t snap-2-9-ui postgresql-ha-hot-standby-snap-2-9-ui-2999.md
	xpub pull discourse 3005 3005
	cp -p postgresql-ha-hot-standby-deb-2-9-ui-3005.md postgresql-ha-hot-standby.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
power-management.md: ../power-management.md
	cp ../power-management.md power-management-deb-2-7-cli-3012.md
	cp ../power-management.md power-management-deb-2-7-ui-3013.md
	cp ../power-management.md power-management-deb-2-8-cli-3014.md
	cp ../power-management.md power-management-deb-2-8-ui-3015.md
	cp ../power-management.md power-management-deb-2-9-cli-3016.md
	cp ../power-management.md power-management-deb-2-9-ui-3017.md
	cp ../power-management.md power-management-snap-2-7-cli-3006.md
	cp ../power-management.md power-management-snap-2-7-ui-3007.md
	cp ../power-management.md power-management-snap-2-8-cli-3008.md
	cp ../power-management.md power-management-snap-2-8-ui-3009.md
	cp ../power-management.md power-management-snap-2-9-cli-3010.md
	cp ../power-management.md power-management-snap-2-9-ui-3011.md
	xpub push discourse -t deb-2-7-cli power-management-deb-2-7-cli-3012.md
	xpub push discourse -t deb-2-7-ui power-management-deb-2-7-ui-3013.md
	xpub push discourse -t deb-2-8-cli power-management-deb-2-8-cli-3014.md
	xpub push discourse -t deb-2-8-ui power-management-deb-2-8-ui-3015.md
	xpub push discourse -t deb-2-9-cli power-management-deb-2-9-cli-3016.md
	xpub push discourse -t deb-2-9-ui power-management-deb-2-9-ui-3017.md
	xpub push discourse -t snap-2-7-cli power-management-snap-2-7-cli-3006.md
	xpub push discourse -t snap-2-7-ui power-management-snap-2-7-ui-3007.md
	xpub push discourse -t snap-2-8-cli power-management-snap-2-8-cli-3008.md
	xpub push discourse -t snap-2-8-ui power-management-snap-2-8-ui-3009.md
	xpub push discourse -t snap-2-9-cli power-management-snap-2-9-cli-3010.md
	xpub push discourse -t snap-2-9-ui power-management-snap-2-9-ui-3011.md
	xpub pull discourse 3017 3017
	cp -p power-management-deb-2-9-ui-3017.md power-management.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
prometheus-metrics.md: ../prometheus-metrics.md
	cp ../prometheus-metrics.md prometheus-metrics-deb-2-7-cli-3024.md
	cp ../prometheus-metrics.md prometheus-metrics-deb-2-7-ui-3025.md
	cp ../prometheus-metrics.md prometheus-metrics-deb-2-8-cli-3026.md
	cp ../prometheus-metrics.md prometheus-metrics-deb-2-8-ui-3027.md
	cp ../prometheus-metrics.md prometheus-metrics-deb-2-9-cli-3028.md
	cp ../prometheus-metrics.md prometheus-metrics-deb-2-9-ui-3029.md
	cp ../prometheus-metrics.md prometheus-metrics-snap-2-7-cli-3018.md
	cp ../prometheus-metrics.md prometheus-metrics-snap-2-7-ui-3019.md
	cp ../prometheus-metrics.md prometheus-metrics-snap-2-8-cli-3020.md
	cp ../prometheus-metrics.md prometheus-metrics-snap-2-8-ui-3021.md
	cp ../prometheus-metrics.md prometheus-metrics-snap-2-9-cli-3022.md
	cp ../prometheus-metrics.md prometheus-metrics-snap-2-9-ui-3023.md
	xpub push discourse -t deb-2-7-cli prometheus-metrics-deb-2-7-cli-3024.md
	xpub push discourse -t deb-2-7-ui prometheus-metrics-deb-2-7-ui-3025.md
	xpub push discourse -t deb-2-8-cli prometheus-metrics-deb-2-8-cli-3026.md
	xpub push discourse -t deb-2-8-ui prometheus-metrics-deb-2-8-ui-3027.md
	xpub push discourse -t deb-2-9-cli prometheus-metrics-deb-2-9-cli-3028.md
	xpub push discourse -t deb-2-9-ui prometheus-metrics-deb-2-9-ui-3029.md
	xpub push discourse -t snap-2-7-cli prometheus-metrics-snap-2-7-cli-3018.md
	xpub push discourse -t snap-2-7-ui prometheus-metrics-snap-2-7-ui-3019.md
	xpub push discourse -t snap-2-8-cli prometheus-metrics-snap-2-8-cli-3020.md
	xpub push discourse -t snap-2-8-ui prometheus-metrics-snap-2-8-ui-3021.md
	xpub push discourse -t snap-2-9-cli prometheus-metrics-snap-2-9-cli-3022.md
	xpub push discourse -t snap-2-9-ui prometheus-metrics-snap-2-9-ui-3023.md
	xpub pull discourse 3029 3029
	cp -p prometheus-metrics-deb-2-9-ui-3029.md prometheus-metrics.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
proxy.md: ../proxy.md
	cp ../proxy.md proxy-deb-2-7-cli-3036.md
	cp ../proxy.md proxy-deb-2-7-ui-3037.md
	cp ../proxy.md proxy-deb-2-8-cli-3038.md
	cp ../proxy.md proxy-deb-2-8-ui-3039.md
	cp ../proxy.md proxy-deb-2-9-cli-3040.md
	cp ../proxy.md proxy-deb-2-9-ui-3041.md
	cp ../proxy.md proxy-snap-2-7-cli-3030.md
	cp ../proxy.md proxy-snap-2-7-ui-3031.md
	cp ../proxy.md proxy-snap-2-8-cli-3032.md
	cp ../proxy.md proxy-snap-2-8-ui-3033.md
	cp ../proxy.md proxy-snap-2-9-cli-3034.md
	cp ../proxy.md proxy-snap-2-9-ui-3035.md
	xpub push discourse -t deb-2-7-cli proxy-deb-2-7-cli-3036.md
	xpub push discourse -t deb-2-7-ui proxy-deb-2-7-ui-3037.md
	xpub push discourse -t deb-2-8-cli proxy-deb-2-8-cli-3038.md
	xpub push discourse -t deb-2-8-ui proxy-deb-2-8-ui-3039.md
	xpub push discourse -t deb-2-9-cli proxy-deb-2-9-cli-3040.md
	xpub push discourse -t deb-2-9-ui proxy-deb-2-9-ui-3041.md
	xpub push discourse -t snap-2-7-cli proxy-snap-2-7-cli-3030.md
	xpub push discourse -t snap-2-7-ui proxy-snap-2-7-ui-3031.md
	xpub push discourse -t snap-2-8-cli proxy-snap-2-8-cli-3032.md
	xpub push discourse -t snap-2-8-ui proxy-snap-2-8-ui-3033.md
	xpub push discourse -t snap-2-9-cli proxy-snap-2-9-cli-3034.md
	xpub push discourse -t snap-2-9-ui proxy-snap-2-9-ui-3035.md
	xpub pull discourse 3041 3041
	cp -p proxy-deb-2-9-ui-deb-2-9-ui-3041.md proxy.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

proxy-log.md: ../proxy-log.md
	cp ../proxy-log.md proxy-log-deb-2-7-cli-3460.md
	cp ../proxy-log.md proxy-log-deb-2-7-ui-3461.md
	cp ../proxy-log.md proxy-log-deb-2-8-cli-3462.md
	cp ../proxy-log.md proxy-log-deb-2-8-ui-3463.md
	cp ../proxy-log.md proxy-log-deb-2-9-cli-3465.md
	cp ../proxy-log.md proxy-log-deb-2-9-ui-3464.md
	cp ../proxy-log.md proxy-log-snap-2-7-cli-3454.md
	cp ../proxy-log.md proxy-log-snap-2-7-ui-3455.md
	cp ../proxy-log.md proxy-log-snap-2-8-cli-3456.md
	cp ../proxy-log.md proxy-log-snap-2-8-ui-3457.md
	cp ../proxy-log.md proxy-log-snap-2-9-cli-3458.md
	cp ../proxy-log.md proxy-log-snap-2-9-ui-3459.md
	xpub push discourse -t deb-2-7-cli proxy-log-deb-2-7-cli-3460.md
	xpub push discourse -t deb-2-7-ui proxy-log-deb-2-7-ui-3461.md
	xpub push discourse -t deb-2-8-cli proxy-log-deb-2-8-cli-3462.md
	xpub push discourse -t deb-2-8-ui proxy-log-deb-2-8-ui-3463.md
	xpub push discourse -t deb-2-9-cli proxy-log-deb-2-9-cli-3465.md
	xpub push discourse -t deb-2-9-ui proxy-log-deb-2-9-ui-3464.md
	xpub push discourse -t snap-2-7-cli proxy-log-snap-2-7-cli-3454.md
	xpub push discourse -t snap-2-7-ui proxy-log-snap-2-7-ui-3455.md
	xpub push discourse -t snap-2-8-cli proxy-log-snap-2-8-cli-3456.md
	xpub push discourse -t snap-2-8-ui proxy-log-snap-2-8-ui-3457.md
	xpub push discourse -t snap-2-9-cli proxy-log-snap-2-9-cli-3458.md
	xpub push discourse -t snap-2-9-ui proxy-log-snap-2-9-ui-3459.md
	xpub pull discourse 3465 3465
	cp -p proxy-log-deb-2-9-ui-3465.md proxy-log.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

python-api-client.md: ../python-api-client.md
	cp ../python-api-client.md python-api-client-810.md
	xpub push discourse python-api-client-810.md
	xpub pull discourse 810 810
	cp -p python-api-client-810.md python-api-client.md
	mv python-api-client-810.md ./rad-versions

#r

rack-controllers.md: ../rack-controllers.md
	cp ../rack-controllers.md rack-controllers-snap-2-7-cli-3054.md
	cp ../rack-controllers.md rack-controllers-snap-2-7-ui-3055.md
	cp ../rack-controllers.md rack-controllers-snap-2-8-cli-3056.md
	cp ../rack-controllers.md rack-controllers-snap-2-8-ui-3057.md
	cp ../rack-controllers.md rack-controllers-snap-2-9-cli-3058.md
	cp ../rack-controllers.md rack-controllers-snap-2-9-ui-3059.md
	cp ../rack-controllers.md rack-controllers-deb-2-7-cli-3060.md
	cp ../rack-controllers.md rack-controllers-deb-2-7-ui-3061.md
	cp ../rack-controllers.md rack-controllers-deb-2-8-cli-3062.md
	cp ../rack-controllers.md rack-controllers-deb-2-8-ui-3063.md
	cp ../rack-controllers.md rack-controllers-deb-2-9-cli-3064.md
	cp ../rack-controllers.md rack-controllers-deb-2-9-ui-3065.md
	xpub push discourse -t snap-2-7-cli rack-controllers-snap-2-7-cli-3054.md
	xpub push discourse -t snap-2-7-ui rack-controllers-snap-2-7-ui-3055.md
	xpub push discourse -t snap-2-8-cli rack-controllers-snap-2-8-cli-3056.md
	xpub push discourse -t snap-2-8-ui rack-controllers-snap-2-8-ui-3057.md
	xpub push discourse -t snap-2-9-cli rack-controllers-snap-2-9-cli-3058.md
	xpub push discourse -t snap-2-9-ui rack-controllers-snap-2-9-ui-3059.md
	xpub push discourse -t deb-2-7-cli rack-controllers-deb-2-7-cli-3060.md
	xpub push discourse -t deb-2-7-ui rack-controllers-deb-2-7-ui-3061.md
	xpub push discourse -t deb-2-8-cli rack-controllers-deb-2-8-cli-3062.md
	xpub push discourse -t deb-2-8-ui rack-controllers-deb-2-8-ui-3063.md
	xpub push discourse -t deb-2-9-cli rack-controllers-deb-2-9-cli-3064.md
	xpub push discourse -t deb-2-9-ui rack-controllers-deb-2-9-ui-3065.md
	xpub pull discourse 3065 3065
	cp -p rack-controllers-deb-2-9-ui-3065.md rack-controllers.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

region-controllers.md: ../region-controllers.md
	cp ../region-controllers.md region-controllers-deb-2-7-cli-3072.md
	cp ../region-controllers.md region-controllers-deb-2-7-ui-3073.md
	cp ../region-controllers.md region-controllers-deb-2-8-cli-3074.md
	cp ../region-controllers.md region-controllers-deb-2-8-ui-3075.md
	cp ../region-controllers.md region-controllers-deb-2-9-cli-3076.md
	cp ../region-controllers.md region-controllers-deb-2-9-ui-3077.md
	cp ../region-controllers.md region-controllers-snap-2-7-cli-3066.md
	cp ../region-controllers.md region-controllers-snap-2-7-ui-3067.md
	cp ../region-controllers.md region-controllers-snap-2-8-cli-3068.md
	cp ../region-controllers.md region-controllers-snap-2-8-ui-3069.md
	cp ../region-controllers.md region-controllers-snap-2-9-cli-3070.md
	cp ../region-controllers.md region-controllers-snap-2-9-ui-3071.md
	xpub push discourse -t deb-2-7-cli region-controllers-deb-2-7-cli-3072.md
	xpub push discourse -t deb-2-7-ui region-controllers-deb-2-7-ui-3073.md
	xpub push discourse -t deb-2-8-cli region-controllers-deb-2-8-cli-3074.md
	xpub push discourse -t deb-2-8-ui region-controllers-deb-2-8-ui-3075.md
	xpub push discourse -t deb-2-9-cli region-controllers-deb-2-9-cli-3076.md
	xpub push discourse -t deb-2-9-ui region-controllers-deb-2-9-ui-3077.md
	xpub push discourse -t snap-2-7-cli region-controllers-snap-2-7-cli-3066.md
	xpub push discourse -t snap-2-7-ui region-controllers-snap-2-7-ui-3067.md
	xpub push discourse -t snap-2-8-cli region-controllers-snap-2-8-cli-3068.md
	xpub push discourse -t snap-2-8-ui region-controllers-snap-2-8-ui-3069.md
	xpub push discourse -t snap-2-9-cli region-controllers-snap-2-9-cli-3070.md
	xpub push discourse -t snap-2-9-ui region-controllers-snap-2-9-ui-3071.md
	xpub pull discourse 3077 3077
	cp -p region-controllers-deb-2-9-ui-3077.md region-controllers.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
resource-pools.md: ../resource-pools.md
	cp ../resource-pools.md resource-pools-deb-2-7-cli-3084.md
	cp ../resource-pools.md resource-pools-deb-2-7-ui-3085.md
	cp ../resource-pools.md resource-pools-deb-2-8-cli-3086.md
	cp ../resource-pools.md resource-pools-deb-2-8-ui-3087.md
	cp ../resource-pools.md resource-pools-deb-2-9-cli-3088.md
	cp ../resource-pools.md resource-pools-deb-2-9-ui-3089.md
	cp ../resource-pools.md resource-pools-snap-2-7-cli-3078.md
	cp ../resource-pools.md resource-pools-snap-2-7-ui-3079.md
	cp ../resource-pools.md resource-pools-snap-2-8-cli-3080.md
	cp ../resource-pools.md resource-pools-snap-2-8-ui-3081.md
	cp ../resource-pools.md resource-pools-snap-2-9-cli-3082.md
	cp ../resource-pools.md resource-pools-snap-2-9-ui-3083.md
	xpub push discourse -t deb-2-7-cli resource-pools-deb-2-7-cli-3084.md
	xpub push discourse -t deb-2-7-ui resource-pools-deb-2-7-ui-3085.md
	xpub push discourse -t deb-2-8-cli resource-pools-deb-2-8-cli-3086.md
	xpub push discourse -t deb-2-8-ui resource-pools-deb-2-8-ui-3087.md
	xpub push discourse -t deb-2-9-cli resource-pools-deb-2-9-cli-3088.md
	xpub push discourse -t deb-2-9-ui resource-pools-deb-2-9-ui-3089.md
	xpub push discourse -t snap-2-7-cli resource-pools-snap-2-7-cli-3078.md
	xpub push discourse -t snap-2-7-ui resource-pools-snap-2-7-ui-3079.md
	xpub push discourse -t snap-2-8-cli resource-pools-snap-2-8-cli-3080.md
	xpub push discourse -t snap-2-8-ui resource-pools-snap-2-8-ui-3081.md
	xpub push discourse -t snap-2-9-cli resource-pools-snap-2-9-cli-3082.md
	xpub push discourse -t snap-2-9-ui resource-pools-snap-2-9-ui-3083.md
	xpub pull discourse 3089 3089
	cp -p resource-pools-deb-2-9-ui-3089.md resource-pools.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#s

select-and-import-images.md: ../select-and-import-images.md
	cp ../select-and-import-images.md select-and-import-images-deb-2-7-cli-3096.md
	cp ../select-and-import-images.md select-and-import-images-deb-2-7-ui-3097.md
	cp ../select-and-import-images.md select-and-import-images-deb-2-8-cli-3098.md
	cp ../select-and-import-images.md select-and-import-images-deb-2-8-ui-3099.md
	cp ../select-and-import-images.md select-and-import-images-deb-2-9-cli-3100.md
	cp ../select-and-import-images.md select-and-import-images-deb-2-9-ui-3101.md
	cp ../select-and-import-images.md select-and-import-images-snap-2-7-cli-3090.md
	cp ../select-and-import-images.md select-and-import-images-snap-2-7-ui-3091.md
	cp ../select-and-import-images.md select-and-import-images-snap-2-8-cli-3092.md
	cp ../select-and-import-images.md select-and-import-images-snap-2-8-ui-3093.md
	cp ../select-and-import-images.md select-and-import-images-snap-2-9-cli-3094.md
	cp ../select-and-import-images.md select-and-import-images-snap-2-9-ui-3095.md
	xpub push discourse -t deb-2-7-cli select-and-import-images-deb-2-7-cli-3096.md
	xpub push discourse -t deb-2-7-ui select-and-import-images-deb-2-7-ui-3097.md
	xpub push discourse -t deb-2-8-cli select-and-import-images-deb-2-8-cli-3098.md
	xpub push discourse -t deb-2-8-ui select-and-import-images-deb-2-8-ui-3099.md
	xpub push discourse -t deb-2-9-cli select-and-import-images-deb-2-9-cli-3100.md
	xpub push discourse -t deb-2-9-ui select-and-import-images-deb-2-9-ui-3101.md
	xpub push discourse -t snap-2-7-cli select-and-import-images-snap-2-7-cli-3090.md
	xpub push discourse -t snap-2-7-ui select-and-import-images-snap-2-7-ui-3091.md
	xpub push discourse -t snap-2-8-cli select-and-import-images-snap-2-8-cli-3092.md
	xpub push discourse -t snap-2-8-ui select-and-import-images-snap-2-8-ui-3093.md
	xpub push discourse -t snap-2-9-cli select-and-import-images-snap-2-9-cli-3094.md
	xpub push discourse -t snap-2-9-ui select-and-import-images-snap-2-9-ui-3095.md
	xpub pull discourse 3101 3101
	cp -p select-and-import-images-deb-2-9-ui-3101.md select-and-import-images.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
storage.md: ../storage.md
	cp ../storage.md storage-deb-2-7-cli-3108.md
	cp ../storage.md storage-deb-2-7-ui-3109.md
	cp ../storage.md storage-deb-2-8-cli-3110.md
	cp ../storage.md storage-deb-2-8-ui-3111.md
	cp ../storage.md storage-deb-2-9-cli-3112.md
	cp ../storage.md storage-deb-2-9-ui-3113.md
	cp ../storage.md storage-snap-2-7-cli-3102.md
	cp ../storage.md storage-snap-2-7-ui-3103.md
	cp ../storage.md storage-snap-2-8-cli-3104.md
	cp ../storage.md storage-snap-2-8-ui-3105.md
	cp ../storage.md storage-snap-2-9-cli-3106.md
	cp ../storage.md storage-snap-2-9-ui-3107.md
	xpub push discourse -t deb-2-7-cli storage-deb-2-7-cli-3108.md
	xpub push discourse -t deb-2-7-ui storage-deb-2-7-ui-3109.md
	xpub push discourse -t deb-2-8-cli storage-deb-2-8-cli-3110.md
	xpub push discourse -t deb-2-8-ui storage-deb-2-8-ui-3111.md
	xpub push discourse -t deb-2-9-cli storage-deb-2-9-cli-3112.md
	xpub push discourse -t deb-2-9-ui storage-deb-2-9-ui-3113.md
	xpub push discourse -t snap-2-7-cli storage-snap-2-7-cli-3102.md
	xpub push discourse -t snap-2-7-ui storage-snap-2-7-ui-3103.md
	xpub push discourse -t snap-2-8-cli storage-snap-2-8-cli-3104.md
	xpub push discourse -t snap-2-8-ui storage-snap-2-8-ui-3105.md
	xpub push discourse -t snap-2-9-cli storage-snap-2-9-cli-3106.md
	xpub push discourse -t snap-2-9-ui storage-snap-2-9-ui-3107.md
	xpub pull discourse 3113 3113
	cp -p storage-deb-2-9-ui-3113.md storage.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

subnet-management.md: ../subnet-management.md
	cp ../subnet-management.md subnet-management-deb-2-7-cli-3120.md
	cp ../subnet-management.md subnet-management-deb-2-7-ui-3121.md
	cp ../subnet-management.md subnet-management-deb-2-8-cli-3122.md
	cp ../subnet-management.md subnet-management-deb-2-8-ui-3123.md
	cp ../subnet-management.md subnet-management-deb-2-9-cli-3124.md
	cp ../subnet-management.md subnet-management-deb-2-9-ui-3125.md
	cp ../subnet-management.md subnet-management-snap-2-7-cli-3114.md
	cp ../subnet-management.md subnet-management-snap-2-7-ui-3115.md
	cp ../subnet-management.md subnet-management-snap-2-8-cli-3116.md
	cp ../subnet-management.md subnet-management-snap-2-8-ui-3117.md
	cp ../subnet-management.md subnet-management-snap-2-9-cli-3118.md
	cp ../subnet-management.md subnet-management-snap-2-9-ui-3119.md
	xpub push discourse -t deb-2-7-cli subnet-management-deb-2-7-cli-3120.md
	xpub push discourse -t deb-2-7-ui subnet-management-deb-2-7-ui-3121.md
	xpub push discourse -t deb-2-8-cli subnet-management-deb-2-8-cli-3122.md
	xpub push discourse -t deb-2-8-ui subnet-management-deb-2-8-ui-3123.md
	xpub push discourse -t deb-2-9-cli subnet-management-deb-2-9-cli-3124.md
	xpub push discourse -t deb-2-9-ui subnet-management-deb-2-9-ui-3125.md
	xpub push discourse -t snap-2-7-cli subnet-management-snap-2-7-cli-3114.md
	xpub push discourse -t snap-2-7-ui subnet-management-snap-2-7-ui-3115.md
	xpub push discourse -t snap-2-8-cli subnet-management-snap-2-8-cli-3116.md
	xpub push discourse -t snap-2-8-ui subnet-management-snap-2-8-ui-3117.md
	xpub push discourse -t snap-2-9-cli subnet-management-snap-2-9-cli-3118.md
	xpub push discourse -t snap-2-9-ui subnet-management-snap-2-9-ui-3119.md
	xpub pull discourse 3125 3125
	cp -p subnet-management-deb-2-9-ui-3125.md subnet-management.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
#t

test-logs.md: ../test-logs.md
	cp ../test-logs.md test-logs-deb-2-7-cli-3132.md
	cp ../test-logs.md test-logs-deb-2-7-ui-3133.md
	cp ../test-logs.md test-logs-deb-2-8-cli-3134.md
	cp ../test-logs.md test-logs-deb-2-8-ui-3135.md
	cp ../test-logs.md test-logs-deb-2-9-cli-3136.md
	cp ../test-logs.md test-logs-deb-2-9-ui-3137.md
	cp ../test-logs.md test-logs-snap-2-7-cli-3126.md
	cp ../test-logs.md test-logs-snap-2-7-ui-3127.md
	cp ../test-logs.md test-logs-snap-2-8-cli-3128.md
	cp ../test-logs.md test-logs-snap-2-8-ui-3129.md
	cp ../test-logs.md test-logs-snap-2-9-cli-3130.md
	cp ../test-logs.md test-logs-snap-2-9-ui-3131.md
	xpub push discourse -t deb-2-7-cli test-logs-deb-2-7-cli-3132.md
	xpub push discourse -t deb-2-7-ui test-logs-deb-2-7-ui-3133.md
	xpub push discourse -t deb-2-8-cli test-logs-deb-2-8-cli-3134.md
	xpub push discourse -t deb-2-8-ui test-logs-deb-2-8-ui-3135.md
	xpub push discourse -t deb-2-9-cli test-logs-deb-2-9-cli-3136.md
	xpub push discourse -t deb-2-9-ui test-logs-deb-2-9-ui-3137.md
	xpub push discourse -t snap-2-7-cli test-logs-snap-2-7-cli-3126.md
	xpub push discourse -t snap-2-7-ui test-logs-snap-2-7-ui-3127.md
	xpub push discourse -t snap-2-8-cli test-logs-snap-2-8-cli-3128.md
	xpub push discourse -t snap-2-8-ui test-logs-snap-2-8-ui-3129.md
	xpub push discourse -t snap-2-9-cli test-logs-snap-2-9-cli-3130.md
	xpub push discourse -t snap-2-9-ui test-logs-snap-2-9-ui-3131.md
	xpub pull discourse 3137 3137
	cp -p test-logs-deb-2-9-ui-3137.md test-logs.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

the-cli-cookbook.md: ../the-cli-cookbook.md
	cp ../the-cli-cookbook.md the-cli-cookbook-2218.md
	xpub push discourse the-cli-cookbook-2218.md
	xpub pull discourse 2218 2218
	cp -p the-cli-cookbook-2218.md the-cli-cookbook.md
	mv the-cli-cookbook-2218.md ./rad-versions
  
tips-tricks-and-traps.md: ../tips-tricks-and-traps.md
	cp ../tips-tricks-and-traps.md tips-tricks-and-traps-1506.md
	xpub push discourse tips-tricks-and-traps-1506.md
	xpub pull discourse 1506 1506
	cp -p tips-tricks-and-traps-1506.md tips-tricks-and-traps.md
	mv tips-tricks-and-traps-1506.md ./rad-versions
 
troubleshooting.md: ../troubleshooting.md
	cp ../troubleshooting.md troubleshooting-837.md
	xpub push discourse troubleshooting-837.md
	xpub pull discourse 837 837
	cp -p troubleshooting-837.md troubleshooting.md
	mv troubleshooting-837.md ./rad-versions
 
#u

ubuntu-kernels.md: ../ubuntu-kernels.md
	cp ../ubuntu-kernels.md ubuntu-kernels-deb-2-7-cli-3180.md
	cp ../ubuntu-kernels.md ubuntu-kernels-deb-2-7-ui-3181.md
	cp ../ubuntu-kernels.md ubuntu-kernels-deb-2-8-cli-3182.md
	cp ../ubuntu-kernels.md ubuntu-kernels-deb-2-8-ui-3183.md
	cp ../ubuntu-kernels.md ubuntu-kernels-deb-2-9-cli-3184.md
	cp ../ubuntu-kernels.md ubuntu-kernels-deb-2-9-ui-3185.md
	cp ../ubuntu-kernels.md ubuntu-kernels-snap-2-7-cli-3174.md
	cp ../ubuntu-kernels.md ubuntu-kernels-snap-2-7-ui-3175.md
	cp ../ubuntu-kernels.md ubuntu-kernels-snap-2-8-cli-3176.md
	cp ../ubuntu-kernels.md ubuntu-kernels-snap-2-8-ui-3177.md
	cp ../ubuntu-kernels.md ubuntu-kernels-snap-2-9-cli-3178.md
	cp ../ubuntu-kernels.md ubuntu-kernels-snap-2-9-ui-3179.md
	xpub push discourse -t deb-2-7-cli ubuntu-kernels-deb-2-7-cli-3180.md
	xpub push discourse -t deb-2-7-ui ubuntu-kernels-deb-2-7-ui-3181.md
	xpub push discourse -t deb-2-8-cli ubuntu-kernels-deb-2-8-cli-3182.md
	xpub push discourse -t deb-2-8-ui ubuntu-kernels-deb-2-8-ui-3183.md
	xpub push discourse -t deb-2-9-cli ubuntu-kernels-deb-2-9-cli-3184.md
	xpub push discourse -t deb-2-9-ui ubuntu-kernels-deb-2-9-ui-3185.md
	xpub push discourse -t snap-2-7-cli ubuntu-kernels-snap-2-7-cli-3174.md
	xpub push discourse -t snap-2-7-ui ubuntu-kernels-snap-2-7-ui-3175.md
	xpub push discourse -t snap-2-8-cli ubuntu-kernels-snap-2-8-cli-3176.md
	xpub push discourse -t snap-2-8-ui ubuntu-kernels-snap-2-8-ui-3177.md
	xpub push discourse -t snap-2-9-cli ubuntu-kernels-snap-2-9-cli-3178.md
	xpub push discourse -t snap-2-9-ui ubuntu-kernels-snap-2-9-ui-3179.md
	xpub pull discourse 3185 3185
	cp -p ubuntu-kernels-deb-2-9-ui-3185.md ubuntu-kernels.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
upgrading-maas.md: ../upgrading-maas.md
	cp ../upgrading-maas.md upgrading-maas-deb-2-7-cli-3192.md
	cp ../upgrading-maas.md upgrading-maas-deb-2-7-ui-3193.md
	cp ../upgrading-maas.md upgrading-maas-deb-2-8-cli-3194.md
	cp ../upgrading-maas.md upgrading-maas-deb-2-8-ui-3195.md
	cp ../upgrading-maas.md upgrading-maas-deb-2-9-cli-3196.md
	cp ../upgrading-maas.md upgrading-maas-deb-2-9-ui-3197.md
	cp ../upgrading-maas.md upgrading-maas-snap-2-7-cli-3186.md
	cp ../upgrading-maas.md upgrading-maas-snap-2-7-ui-3187.md
	cp ../upgrading-maas.md upgrading-maas-snap-2-8-cli-3188.md
	cp ../upgrading-maas.md upgrading-maas-snap-2-8-ui-3189.md
	cp ../upgrading-maas.md upgrading-maas-snap-2-9-cli-3190.md
	cp ../upgrading-maas.md upgrading-maas-snap-2-9-ui-3191.md
	xpub push discourse -t deb-2-7-cli upgrading-maas-deb-2-7-cli-3192.md
	xpub push discourse -t deb-2-7-ui upgrading-maas-deb-2-7-ui-3193.md
	xpub push discourse -t deb-2-8-cli upgrading-maas-deb-2-8-cli-3194.md
	xpub push discourse -t deb-2-8-ui upgrading-maas-deb-2-8-ui-3195.md
	xpub push discourse -t deb-2-9-cli upgrading-maas-deb-2-9-cli-3196.md
	xpub push discourse -t deb-2-9-ui upgrading-maas-deb-2-9-ui-3197.md
	xpub push discourse -t snap-2-7-cli upgrading-maas-snap-2-7-cli-3186.md
	xpub push discourse -t snap-2-7-ui upgrading-maas-snap-2-7-ui-3187.md
	xpub push discourse -t snap-2-8-cli upgrading-maas-snap-2-8-cli-3188.md
	xpub push discourse -t snap-2-8-ui upgrading-maas-snap-2-8-ui-3189.md
	xpub push discourse -t snap-2-9-cli upgrading-maas-snap-2-9-cli-3190.md
	xpub push discourse -t snap-2-9-ui upgrading-maas-snap-2-9-ui-3191.md
	xpub pull discourse 3197 3197
	cp -p upgrading-maas-deb-2-9-ui-3197.md upgrading-maas.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

user-accounts.md: ../user-accounts.md
	cp ../user-accounts.md user-accounts-deb-2-7-cli-3204.md
	cp ../user-accounts.md user-accounts-deb-2-7-ui-3205.md
	cp ../user-accounts.md user-accounts-deb-2-8-cli-3206.md
	cp ../user-accounts.md user-accounts-deb-2-8-ui-3207.md
	cp ../user-accounts.md user-accounts-deb-2-9-cli-3208.md
	cp ../user-accounts.md user-accounts-deb-2-9-ui-3209.md
	cp ../user-accounts.md user-accounts-snap-2-7-cli-3198.md
	cp ../user-accounts.md user-accounts-snap-2-7-ui-3199.md
	cp ../user-accounts.md user-accounts-snap-2-8-cli-3200.md
	cp ../user-accounts.md user-accounts-snap-2-8-ui-3201.md
	cp ../user-accounts.md user-accounts-snap-2-9-cli-3202.md
	cp ../user-accounts.md user-accounts-snap-2-9-ui-3203.md
	xpub push discourse -t deb-2-7-cli user-accounts-deb-2-7-cli-3204.md
	xpub push discourse -t deb-2-7-ui user-accounts-deb-2-7-ui-3205.md
	xpub push discourse -t deb-2-8-cli user-accounts-deb-2-8-cli-3206.md
	xpub push discourse -t deb-2-8-ui user-accounts-deb-2-8-ui-3207.md
	xpub push discourse -t deb-2-9-cli user-accounts-deb-2-9-cli-3208.md
	xpub push discourse -t deb-2-9-ui user-accounts-deb-2-9-ui-3209.md
	xpub push discourse -t snap-2-7-cli user-accounts-snap-2-7-cli-3198.md
	xpub push discourse -t snap-2-7-ui user-accounts-snap-2-7-ui-3199.md
	xpub push discourse -t snap-2-8-cli user-accounts-snap-2-8-cli-3200.md
	xpub push discourse -t snap-2-8-ui user-accounts-snap-2-8-ui-3201.md
	xpub push discourse -t snap-2-9-cli user-accounts-snap-2-9-cli-3202.md
	xpub push discourse -t snap-2-9-ui user-accounts-snap-2-9-ui-3203.md
	xpub pull discourse 3209 3209
	cp -p user-accounts-deb-2-9-ui-3209.md user-accounts.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

using-maas-in-an-air-gapped-environment.md: ../using-maas-in-an-air-gapped-environment.md
	cp ../using-maas-in-an-air-gapped-environment.md using-maas-in-an-air-gapped-environment-3539.md
	xpub push discourse using-maas-in-an-air-gapped-environment-3539.md
	xpub pull discourse 3539 3539
	cp -p using-maas-in-an-air-gapped-environment-3539.md using-maas-in-an-air-gapped-environment.md
	mv using-maas-in-an-air-gapped-environment-3539.md ./rad-versions

using-rbac-with-maas.md: ../using-rbac-with-maas.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-snap-2-7-cli-3592.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-snap-2-7-ui-3593.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-snap-2-8-cli-3594.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-snap-2-8-ui-3595.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-snap-2-9-cli-3596.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-snap-2-9-ui-3597.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-deb-2-7-cli-3598.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-deb-2-7-ui-3599.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-deb-2-8-cli-3600.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-deb-2-8-ui-3601.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-deb-2-9-cli-3602.md
	cp ../using-rbac-with-maas.md using-rbac-with-maas-deb-2-9-ui-3603.md
	xpub push discourse -t snap-2-7-cli using-rbac-with-maas-snap-2-7-cli-3592.md
	xpub push discourse -t snap-2-7-ui using-rbac-with-maas-snap-2-7-ui-3593.md
	xpub push discourse -t snap-2-8-cli using-rbac-with-maas-snap-2-8-cli-3594.md
	xpub push discourse -t snap-2-8-ui using-rbac-with-maas-snap-2-8-ui-3595.md
	xpub push discourse -t snap-2-9-cli using-rbac-with-maas-snap-2-9-cli-3596.md
	xpub push discourse -t snap-2-9-ui using-rbac-with-maas-snap-2-9-ui-3597.md
	xpub push discourse -t deb-2-7-cli using-rbac-with-maas-deb-2-7-cli-3598.md
	xpub push discourse -t deb-2-7-ui using-rbac-with-maas-deb-2-7-ui-3599.md
	xpub push discourse -t deb-2-8-cli using-rbac-with-maas-deb-2-8-cli-3600.md
	xpub push discourse -t deb-2-8-ui using-rbac-with-maas-deb-2-8-ui-3601.md
	xpub push discourse -t deb-2-9-cli using-rbac-with-maas-deb-2-9-cli-3602.md
	xpub push discourse -t deb-2-9-ui using-rbac-with-maas-deb-2-9-ui-3603.md
	xpub pull discourse 3603 3603
	cp -p using-rbac-with-maas-deb-2-9-ui-3603.md using-rbac-with-maas.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions

#v

vm-hosting.md: ../vm-hosting.md
	cp ../vm-hosting.md vm-hosting-deb-2-7-cli-2748.md
	cp ../vm-hosting.md vm-hosting-deb-2-7-ui-2749.md
	cp ../vm-hosting.md vm-hosting-deb-2-8-cli-2750.md
	cp ../vm-hosting.md vm-hosting-deb-2-8-ui-2751.md
	cp ../vm-hosting.md vm-hosting-deb-2-9-cli-2752.md
	cp ../vm-hosting.md vm-hosting-deb-2-9-ui-2753.md
	cp ../vm-hosting.md vm-hosting-snap-2-7-cli-2742.md
	cp ../vm-hosting.md vm-hosting-snap-2-7-ui-2743.md
	cp ../vm-hosting.md vm-hosting-snap-2-8-cli-2744.md
	cp ../vm-hosting.md vm-hosting-snap-2-8-ui-2745.md
	cp ../vm-hosting.md vm-hosting-snap-2-9-cli-2746.md
	cp ../vm-hosting.md vm-hosting-snap-2-9-ui-2747.md
	xpub push discourse -t deb-2-7-cli vm-hosting-deb-2-7-cli-2748.md
	xpub push discourse -t deb-2-7-ui vm-hosting-deb-2-7-ui-2749.md
	xpub push discourse -t deb-2-8-cli vm-hosting-deb-2-8-cli-2750.md
	xpub push discourse -t deb-2-8-ui vm-hosting-deb-2-8-ui-2751.md
	xpub push discourse -t deb-2-9-cli vm-hosting-deb-2-9-cli-2752.md
	xpub push discourse -t deb-2-9-ui vm-hosting-deb-2-9-ui-2753.md
	xpub push discourse -t snap-2-7-cli vm-hosting-snap-2-7-cli-2742.md
	xpub push discourse -t snap-2-7-ui vm-hosting-snap-2-7-ui-2743.md
	xpub push discourse -t snap-2-8-cli vm-hosting-snap-2-8-cli-2744.md
	xpub push discourse -t snap-2-8-ui vm-hosting-snap-2-8-ui-2745.md
	xpub push discourse -t snap-2-9-cli vm-hosting-snap-2-9-cli-2746.md
	xpub push discourse -t snap-2-9-ui vm-hosting-snap-2-9-ui-2747.md
	xpub pull discourse 2753 2753
	cp -p vm-hosting-deb-2-9-ui-2753.md vm-hosting.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
vm-host-networking.md: ../vm-host-networking.md
	cp ../vm-host-networking.md vm-host-networking-deb-2-7-cli-3216.md
	cp ../vm-host-networking.md vm-host-networking-deb-2-7-ui-3217.md
	cp ../vm-host-networking.md vm-host-networking-deb-2-8-cli-3218.md
	cp ../vm-host-networking.md vm-host-networking-deb-2-8-ui-3219.md
	cp ../vm-host-networking.md vm-host-networking-deb-2-9-cli-3220.md
	cp ../vm-host-networking.md vm-host-networking-deb-2-9-ui-3221.md
	cp ../vm-host-networking.md vm-host-networking-snap-2-7-cli-3210.md
	cp ../vm-host-networking.md vm-host-networking-snap-2-7-ui-3211.md
	cp ../vm-host-networking.md vm-host-networking-snap-2-8-cli-3212.md
	cp ../vm-host-networking.md vm-host-networking-snap-2-8-ui-3213.md
	cp ../vm-host-networking.md vm-host-networking-snap-2-9-cli-3214.md
	cp ../vm-host-networking.md vm-host-networking-snap-2-9-ui-3215.md
	xpub push discourse -t deb-2-7-cli vm-host-networking-deb-2-7-cli-3216.md
	xpub push discourse -t deb-2-7-ui vm-host-networking-deb-2-7-ui-3217.md
	xpub push discourse -t deb-2-8-cli vm-host-networking-deb-2-8-cli-3218.md
	xpub push discourse -t deb-2-8-ui vm-host-networking-deb-2-8-ui-3219.md
	xpub push discourse -t deb-2-9-cli vm-host-networking-deb-2-9-cli-3220.md
	xpub push discourse -t deb-2-9-ui vm-host-networking-deb-2-9-ui-3221.md
	xpub push discourse -t snap-2-7-cli vm-host-networking-snap-2-7-cli-3210.md
	xpub push discourse -t snap-2-7-ui vm-host-networking-snap-2-7-ui-3211.md
	xpub push discourse -t snap-2-8-cli vm-host-networking-snap-2-8-cli-3212.md
	xpub push discourse -t snap-2-8-ui vm-host-networking-snap-2-8-ui-3213.md
	xpub push discourse -t snap-2-9-cli vm-host-networking-snap-2-9-cli-3214.md
	xpub push discourse -t snap-2-9-ui vm-host-networking-snap-2-9-ui-3215.md
	xpub pull discourse 3221 3221
	cp -p vm-host-networking-deb-2-9-ui-3221.md vm-host-networking.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
vm-host-storage-pools.md: ../vm-host-storage-pools.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-deb-2-7-cli-3228.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-deb-2-7-ui-3229.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-deb-2-8-cli-3230.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-deb-2-8-ui-3231.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-deb-2-9-cli-3232.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-deb-2-9-ui-3233.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-snap-2-7-cli-3222.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-snap-2-7-ui-3223.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-snap-2-8-cli-3224.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-snap-2-8-ui-3225.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-snap-2-9-cli-3226.md
	cp ../vm-host-storage-pools.md vm-host-storage-pools-snap-2-9-ui-3227.md
	xpub push discourse -t deb-2-7-cli vm-host-storage-pools-deb-2-7-cli-3228.md
	xpub push discourse -t deb-2-7-ui vm-host-storage-pools-deb-2-7-ui-3229.md
	xpub push discourse -t deb-2-8-cli vm-host-storage-pools-deb-2-8-cli-3230.md
	xpub push discourse -t deb-2-8-ui vm-host-storage-pools-deb-2-8-ui-3231.md
	xpub push discourse -t deb-2-9-cli vm-host-storage-pools-deb-2-9-cli-3232.md
	xpub push discourse -t deb-2-9-ui vm-host-storage-pools-deb-2-9-ui-3233.md
	xpub push discourse -t snap-2-7-cli vm-host-storage-pools-snap-2-7-cli-3222.md
	xpub push discourse -t snap-2-7-ui vm-host-storage-pools-snap-2-7-ui-3223.md
	xpub push discourse -t snap-2-8-cli vm-host-storage-pools-snap-2-8-cli-3224.md
	xpub push discourse -t snap-2-8-ui vm-host-storage-pools-snap-2-8-ui-3225.md
	xpub push discourse -t snap-2-9-cli vm-host-storage-pools-snap-2-9-cli-3226.md
	xpub push discourse -t snap-2-9-ui vm-host-storage-pools-snap-2-9-ui-3227.md
	xpub pull discourse 3233 3233
	cp -p vm-host-storage-pools-deb-2-9-ui-3233.md vm-host-storage-pools.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
vmware-images.md: ../vmware-images.md
	cp ../vmware-images.md vmware-images-deb-2-7-cli-3240.md
	cp ../vmware-images.md vmware-images-deb-2-7-ui-3241.md
	cp ../vmware-images.md vmware-images-deb-2-8-cli-3242.md
	cp ../vmware-images.md vmware-images-deb-2-8-ui-3243.md
	cp ../vmware-images.md vmware-images-deb-2-9-cli-3244.md
	cp ../vmware-images.md vmware-images-deb-2-9-ui-3245.md
	cp ../vmware-images.md vmware-images-snap-2-7-cli-3234.md
	cp ../vmware-images.md vmware-images-snap-2-7-ui-3235.md
	cp ../vmware-images.md vmware-images-snap-2-8-cli-3236.md
	cp ../vmware-images.md vmware-images-snap-2-8-ui-3237.md
	cp ../vmware-images.md vmware-images-snap-2-9-cli-3238.md
	cp ../vmware-images.md vmware-images-snap-2-9-ui-3239.md
	xpub push discourse -t deb-2-7-cli vmware-images-deb-2-7-cli-3240.md
	xpub push discourse -t deb-2-7-ui vmware-images-deb-2-7-ui-3241.md
	xpub push discourse -t deb-2-8-cli vmware-images-deb-2-8-cli-3242.md
	xpub push discourse -t deb-2-8-ui vmware-images-deb-2-8-ui-3243.md
	xpub push discourse -t deb-2-9-cli vmware-images-deb-2-9-cli-3244.md
	xpub push discourse -t deb-2-9-ui vmware-images-deb-2-9-ui-3245.md
	xpub push discourse -t snap-2-7-cli vmware-images-snap-2-7-cli-3234.md
	xpub push discourse -t snap-2-7-ui vmware-images-snap-2-7-ui-3235.md
	xpub push discourse -t snap-2-8-cli vmware-images-snap-2-8-cli-3236.md
	xpub push discourse -t snap-2-8-ui vmware-images-snap-2-8-ui-3237.md
	xpub push discourse -t snap-2-9-cli vmware-images-snap-2-9-cli-3238.md
	xpub push discourse -t snap-2-9-ui vmware-images-snap-2-9-ui-3239.md
	xpub pull discourse 3245 3245
	cp -p vmware-images-deb-2-9-ui-3245.md vmware-images.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 
vmware-vmfs-datastores.md: ../vmware-vmfs-datastores.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-deb-2-7-cli-3252.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-deb-2-7-ui-3253.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-deb-2-8-cli-3254.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-deb-2-8-ui-3255.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-deb-2-9-cli-3256.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-deb-2-9-ui-3257.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-snap-2-7-cli-3246.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-snap-2-7-ui-3247.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-snap-2-8-cli-3248.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-snap-2-8-ui-3249.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-snap-2-9-cli-3250.md
	cp ../vmware-vmfs-datastores.md vmware-vmfs-datastores-snap-2-9-ui-3251.md
	xpub push discourse -t deb-2-7-cli vmware-vmfs-datastores-deb-2-7-cli-3252.md
	xpub push discourse -t deb-2-7-ui vmware-vmfs-datastores-deb-2-7-ui-3253.md
	xpub push discourse -t deb-2-8-cli vmware-vmfs-datastores-deb-2-8-cli-3254.md
	xpub push discourse -t deb-2-8-ui vmware-vmfs-datastores-deb-2-8-ui-3255.md
	xpub push discourse -t deb-2-9-cli vmware-vmfs-datastores-deb-2-9-cli-3256.md
	xpub push discourse -t deb-2-9-ui vmware-vmfs-datastores-deb-2-9-ui-3257.md
	xpub push discourse -t snap-2-7-cli vmware-vmfs-datastores-snap-2-7-cli-3246.md
	xpub push discourse -t snap-2-7-ui vmware-vmfs-datastores-snap-2-7-ui-3247.md
	xpub push discourse -t snap-2-8-cli vmware-vmfs-datastores-snap-2-8-cli-3248.md
	xpub push discourse -t snap-2-8-ui vmware-vmfs-datastores-snap-2-8-ui-3249.md
	xpub push discourse -t snap-2-9-cli vmware-vmfs-datastores-snap-2-9-cli-3250.md
	xpub push discourse -t snap-2-9-ui vmware-vmfs-datastores-snap-2-9-ui-3251.md
	xpub pull discourse 3257 3257
	cp -p vmware-vmfs-datastores-deb-2-9-ui-3257.md vmware-vmfs-datastores.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions


#w

whats-new-in-maas.md: ../whats-new-in-maas.md
	cp ../whats-new-in-maas.md whats-new-in-maas-2-7-3335.md
	cp ../whats-new-in-maas.md whats-new-in-maas-2-8-3334.md
	cp ../whats-new-in-maas.md whats-new-in-maas-2-9-3336.md
	xpub push discourse -t deb-2-7-ui whats-new-in-maas-2-7-3335.md
	xpub push discourse -t deb-2-8-cli whats-new-in-maas-2-8-3334.md
	xpub push discourse -t deb-2-9-cli whats-new-in-maas-2-9-3336.md
	xpub pull discourse 3336 3336
	cp -p whats-new-in-maas-2-9-3336.md whats-new-in-maas.md
	mv whats-new-in-maas-* ./rad-versions

writing-guide.md: ../writing-guide.md
	cp ../writing-guide.md writing-guide-747.md
	xpub push discourse writing-guide-747.md
	xpub pull discourse 747 747
	cp -p writing-guide-747.md writing-guide.md
	mv writing-guide-747.md ./rad-versions
 
#z

zone-examples.md: ../zone-examples.md
	cp ../zone-examples.md zone-examples-deb-2-7-cli-3276.md
	cp ../zone-examples.md zone-examples-deb-2-7-ui-3277.md
	cp ../zone-examples.md zone-examples-deb-2-8-cli-3278.md
	cp ../zone-examples.md zone-examples-deb-2-8-ui-3279.md
	cp ../zone-examples.md zone-examples-deb-2-9-cli-3280.md
	cp ../zone-examples.md zone-examples-deb-2-9-ui-3281.md
	cp ../zone-examples.md zone-examples-snap-2-7-cli-3270.md
	cp ../zone-examples.md zone-examples-snap-2-7-ui-3271.md
	cp ../zone-examples.md zone-examples-snap-2-8-cli-3272.md
	cp ../zone-examples.md zone-examples-snap-2-8-ui-3273.md
	cp ../zone-examples.md zone-examples-snap-2-9-cli-3274.md
	cp ../zone-examples.md zone-examples-snap-2-9-ui-3275.md
	xpub push discourse -t deb-2-7-cli zone-examples-deb-2-7-cli-3276.md
	xpub push discourse -t deb-2-7-ui zone-examples-deb-2-7-ui-3277.md
	xpub push discourse -t deb-2-8-cli zone-examples-deb-2-8-cli-3278.md
	xpub push discourse -t deb-2-8-ui zone-examples-deb-2-8-ui-3279.md
	xpub push discourse -t deb-2-9-cli zone-examples-deb-2-9-cli-3280.md
	xpub push discourse -t deb-2-9-ui zone-examples-deb-2-9-ui-3281.md
	xpub push discourse -t snap-2-7-cli zone-examples-snap-2-7-cli-3270.md
	xpub push discourse -t snap-2-7-ui zone-examples-snap-2-7-ui-3271.md
	xpub push discourse -t snap-2-8-cli zone-examples-snap-2-8-cli-3272.md
	xpub push discourse -t snap-2-8-ui zone-examples-snap-2-8-ui-3273.md
	xpub push discourse -t snap-2-9-cli zone-examples-snap-2-9-cli-3274.md
	xpub push discourse -t snap-2-9-ui zone-examples-snap-2-9-ui-3275.md
	xpub pull discourse 3281 3281
	cp -p zone-examples-deb-2-9-ui-3281.md zone-examples.md
	mv *-deb-* ./rad-versions
	mv *-snap-* ./rad-versions
 

# originals/%.md: %.md
# 	echo "i can see this one, too"
# 	# $(eval BASE = $(notdir $@))
	# cp $(BASE) backup/$(BASE)
	# scripts/strip-navigation.sh $(BASE)
	# sed -i "/|| 2.7/d" $(BASE)
	# sed -i "/||2.7/d" $(BASE)
	# sed -i "/|-----:|:-----:/d" $(BASE)
	# sed -i "/\[CLI\]/d" $(BASE)
	# sed -i 's/\[note.*\]/<strong>NOTE:<\/strong> /g' $(BASE)
	# sed -i 's/\[\/note.*\]//g' $(BASE)
	# $(eval HTML = $(basename $(notdir $@)).html)
	# cp templates/$(D27C)/template.html ./template.html
	# sed -i "s|zork|$(HTML)|g" ./template.html
	# xpub convert dc2html -t $(D27CT) $(BASE)
	# sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	# sed -i 's/-deb-2-7-cli//g' $(BASE)
