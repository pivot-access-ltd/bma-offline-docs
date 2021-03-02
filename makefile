########################################################################
##                 G L O B A L   S E T T I N G S                      ##
########################################################################
#
# PRODUCTION VERSION
# this is the HTML version that gets loaded into the production dirs
# for inclusion with the product builds; no other versions are built
# in the current makefile.  change this variable to build some other
# version, as needed.  ideally, this makefile will be customised for
# each branch of the documentation, hence the correct files would be
# created and loaded into the production directories for that build.
# this saves considerable time when building documentation.  do note
# that other RAD versions are currently built and pushed to the docs
# portal on discourse; this only affects the building of HTML docs.
#
PROD_VSN := 2.9
PROD_TAG := 2-9
#
########################################################################
##     P A T H I N G   A N D   T A G G I N G   V A R I A B L E S      ##
########################################################################
#
# RAD versions
#
V27  := 2.7
V28  := 2.8
V29  := 2.9
V210 := 2.10
#
# build methods
#
SNAP := snap
DEB  := deb
#
# interfaces
#
UI  := ui
CLI := cli
#
# html directory
#
HTML := html
#
# discourse
#
DISC := discourse
#
# source docs
#
SRC := source-docs
#
# templates
#
TMPL := $(HTML)/templates
#
# images
#
IMGS := $(HTML)/images
#
# css
#
CSS := $(HTML)/css
#
# scripts
#
SCRP := bin
#
# temporary html staging directory
#
STAGING := /tmp/mod/staging
#
# temporary working directory (avoids having to backup/replace master files)
#
MODWD := /tmp/mod/working
#
# production html directories (for MAAS builds to pull from)
#
PROD_DEB  := production-html-deb
PROD_SNAP := production-html-snap
#
########################################################################
##                          T A R G E T S                             ##
########################################################################
#
## html targets
#
HTARG := $(HTML)/about-maas.html
HTARG += $(HTML)/adding-a-vm-host.html
HTARG += $(HTML)/add-machines.html
HTARG += $(HTML)/api-authentication.html
HTARG += $(HTML)/api.html
HTARG += $(HTML)/audit-event-logs.html
HTARG += $(HTML)/availability-zones.html
HTARG += $(HTML)/backup.html
HTARG += $(HTML)/block-devices.html
HTARG += $(HTML)/candid-tutorial.html
HTARG += $(HTML)/cli-advanced-tasks.html
HTARG += $(HTML)/cli-composable-hardware.html
HTARG += $(HTML)/cli-image-management.html
HTARG += $(HTML)/cli-interface-management.html
HTARG += $(HTML)/cli-kernel-management.html
HTARG += $(HTML)/commissioning-and-hardware-testing-scripts.html
HTARG += $(HTML)/commissioning-logs.html
HTARG += $(HTML)/commission-machines.html
HTARG += $(HTML)/common-cli-tasks.html
HTARG += $(HTML)/concepts-and-terms.html
HTARG += $(HTML)/configuration-journey.html
HTARG += $(HTML)/configuring-tls-encryption.html
HTARG += $(HTML)/contact-us.html
HTARG += $(HTML)/controllers.html
HTARG += $(HTML)/creating-a-custom-ubuntu-image.html
HTARG += $(HTML)/creating-and-deleting-vms.html
HTARG += $(HTML)/custom-machine-setup.html
HTARG += $(HTML)/deploy-machines.html
HTARG += $(HTML)/disk-erasure.html
HTARG += $(HTML)/event-logs.html
HTARG += $(HTML)/getting-help.html
HTARG += $(HTML)/give-me-an-example-of-maas.html
HTARG += $(HTML)/hardening-your-maas-installation.html
HTARG += $(HTML)/hardware-testing.html
HTARG += $(HTML)/high-availability.html
HTARG += $(HTML)/images.html
HTARG += $(HTML)/interactive-search.html
HTARG += $(HTML)/ip-ranges.html
HTARG += $(HTML)/ipv6-addressing.html
HTARG += $(HTML)/kernel-boot-options.html
HTARG += $(HTML)/language-details-contributing-to-maas-docs.html
HTARG += $(HTML)/local-image-mirror.html
HTARG += $(HTML)/maas-cli.html
HTARG += $(HTML)/maas-communication.html
HTARG += $(HTML)/maas-documentation.html
HTARG += $(HTML)/maas-image-builder.html
HTARG += $(HTML)/maas-installation.html
HTARG += $(HTML)/maas-logging.html
HTARG += $(HTML)/maas-requirements.html
HTARG += $(HTML)/maas-tags.html
HTARG += $(HTML)/machine-logs.html
HTARG += $(HTML)/machines.html
HTARG += $(HTML)/managing-dhcp.html
HTARG += $(HTML)/managing-stp.html
HTARG += $(HTML)/network-discovery.html
HTARG += $(HTML)/networking.html
HTARG += $(HTML)/network-testing.html
HTARG += $(HTML)/ntp-services.html
HTARG += $(HTML)/package-repositories.html
HTARG += $(HTML)/partitions.html
HTARG += $(HTML)/postgresql-ha-hot-standby.html
HTARG += $(HTML)/power-management.html
HTARG += $(HTML)/prometheus-metrics.html
HTARG += $(HTML)/proxy.html
HTARG += $(HTML)/python-api-client.html
HTARG += $(HTML)/rack-controllers.html
HTARG += $(HTML)/region-controllers.html
HTARG += $(HTML)/resource-pools.html
HTARG += $(HTML)/select-and-import-images.html
HTARG += $(HTML)/storage.html
HTARG += $(HTML)/subnet-management.html
HTARG += $(HTML)/test-logs.html
HTARG += $(HTML)/the-cli-cookbook.html
HTARG += $(HTML)/tips-tricks-and-traps.html
HTARG += $(HTML)/troubleshooting.html
HTARG += $(HTML)/ubuntu-kernels.html
HTARG += $(HTML)/user-accounts.html
HTARG += $(HTML)/using-image-streams.html
HTARG += $(HTML)/using-maas-in-an-air-gapped-environment.html
HTARG += $(HTML)/using-rbac-with-maas.html
HTARG += $(HTML)/vm-hosting.html
HTARG += $(HTML)/vm-host-networking.html
HTARG += $(HTML)/vm-host-storage-pools.html
HTARG += $(HTML)/vmware-images.html
HTARG += $(HTML)/vmware-vmfs-datastores.html
HTARG += $(HTML)/whats-new-in-maas.html
HTARG += $(HTML)/writing-guide.html
HTARG += $(HTML)/zone-examples.html
#
## discourse targets
#
DTARG := $(DISC)/about-maas.md
DTARG += $(DISC)/adding-a-vm-host.md
DTARG += $(DISC)/add-machines.md
DTARG += $(DISC)/api-authentication.md
DTARG += $(DISC)/api.md
DTARG += $(DISC)/audit-event-logs.md
DTARG += $(DISC)/availability-zones.md
DTARG += $(DISC)/backup.md
DTARG += $(DISC)/block-devices.md
DTARG += $(DISC)/candid-tutorial.md
DTARG += $(DISC)/cli-advanced-tasks.md
DTARG += $(DISC)/cli-composable-hardware.md
DTARG += $(DISC)/cli-image-management.md
DTARG += $(DISC)/cli-interface-management.md
DTARG += $(DISC)/cli-kernel-management.md
DTARG += $(DISC)/commissioning-and-hardware-testing-scripts.md
DTARG += $(DISC)/commissioning-logs.md
DTARG += $(DISC)/commission-machines.md
DTARG += $(DISC)/common-cli-tasks.md
DTARG += $(DISC)/concepts-and-terms.md
DTARG += $(DISC)/configuration-journey.md
DTARG += $(DISC)/configuring-tls-encryption.md
DTARG += $(DISC)/contact-us.md
DTARG += $(DISC)/controllers.md
DTARG += $(DISC)/creating-a-custom-ubuntu-image.md
DTARG += $(DISC)/creating-and-deleting-vms.md
DTARG += $(DISC)/custom-machine-setup.md
DTARG += $(DISC)/deploy-machines.md
DTARG += $(DISC)/disk-erasure.md
DTARG += $(DISC)/event-logs.md
DTARG += $(DISC)/getting-help.md
DTARG += $(DISC)/give-me-an-example-of-maas.md
DTARG += $(DISC)/hardening-your-maas-installation.md
DTARG += $(DISC)/hardware-testing.md
DTARG += $(DISC)/high-availability.md
DTARG += $(DISC)/images.md
DTARG += $(DISC)/interactive-search.md
DTARG += $(DISC)/ip-ranges.md
DTARG += $(DISC)/ipv6-addressing.md
DTARG += $(DISC)/kernel-boot-options.md
DTARG += $(DISC)/language-details-contributing-to-maas-docs.md
DTARG += $(DISC)/local-image-mirror.md
DTARG += $(DISC)/maas-cli.md
DTARG += $(DISC)/maas-communication.md
DTARG += $(DISC)/maas-documentation.md
DTARG += $(DISC)/maas-image-builder.md
DTARG += $(DISC)/maas-installation.md
DTARG += $(DISC)/maas-logging.md
DTARG += $(DISC)/maas-requirements.md
DTARG += $(DISC)/maas-tags.md
DTARG += $(DISC)/machine-logs.md
DTARG += $(DISC)/machines.md
DTARG += $(DISC)/managing-dhcp.md
DTARG += $(DISC)/managing-stp.md
DTARG += $(DISC)/network-discovery.md
DTARG += $(DISC)/networking.md
DTARG += $(DISC)/network-testing.md
DTARG += $(DISC)/ntp-services.md
DTARG += $(DISC)/package-repositories.md
DTARG += $(DISC)/partitions.md
DTARG += $(DISC)/postgresql-ha-hot-standby.md
DTARG += $(DISC)/power-management.md
DTARG += $(DISC)/prometheus-metrics.md
DTARG += $(DISC)/proxy.md
DTARG += $(DISC)/python-api-client.md
DTARG += $(DISC)/rack-controllers.md
DTARG += $(DISC)/region-controllers.md
DTARG += $(DISC)/resource-pools.md
DTARG += $(DISC)/select-and-import-images.md
DTARG += $(DISC)/storage.md
DTARG += $(DISC)/subnet-management.md
DTARG += $(DISC)/test-logs.md
DTARG += $(DISC)/the-cli-cookbook.md
DTARG += $(DISC)/tips-tricks-and-traps.md
DTARG += $(DISC)/troubleshooting.md
DTARG += $(DISC)/ubuntu-kernels.md
DTARG += $(DISC)/user-accounts.md
DTARG += $(DISC)/using-image-streams.md
DTARG += $(DISC)/using-maas-in-an-air-gapped-environment.md
DTARG += $(DISC)/using-rbac-with-maas.md
DTARG += $(DISC)/vm-hosting.md
DTARG += $(DISC)/vm-host-networking.md
DTARG += $(DISC)/vm-host-storage-pools.md
DTARG += $(DISC)/vmware-images.md
DTARG += $(DISC)/vmware-vmfs-datastores.md
DTARG += $(DISC)/whats-new-in-maas.md
DTARG += $(DISC)/writing-guide.md
DTARG += $(DISC)/zone-examples.md
#
########################################################################
##                   B U I L D   R E C I P E S                        ##
########################################################################
#
# identify phony recipes
#
.PHONY: all clean discourse html
#
# build all
#
all: post-build-all
	@echo "\n*******************************************************"
	@echo "***           BUILD COMPLETE, NO ERRORS             ***"
	@echo "*******************************************************"
#
# build html only
#
html: post-build-html
#
# build discourse files only
#
discourse: post-build-discourse
#
# post-build-discourse
#
post-build-discourse: build-discourse
	@echo "\n*** Running discourse post-build recipe"
	@echo "\n***********************************************"
	@echo "***      discourse build complete           ***"
	@echo "***********************************************"
#
# build-discourse
#
build-discourse: pre-build-discourse $(DTARG)
	@echo "\n******************************************"
	@echo "*** discourse files built successfully ***"
	@echo "******************************************"
#
# pre-build-discourse
#
pre-build-discourse:
	@echo "\n******************************************"
	@echo "***       start discourse build        ***"
	@echo "******************************************"
	@echo "\n*** Running discourse pre-build recipe"
	cp -p $(SRC)/maas-documentation.msd $(SRC)/maas-documenation.md
	cp -p $(SRC)/maas-documentation.msd $(SRC)/index.md
	cp $(SCRP)/strip-navigation.sh $(MODWD)
#
# pre-build-html
#
pre-build-html:
	@echo "\n******************************************"
	@echo "***          start HTML build          ***"
	@echo "******************************************"
	@echo "\n*** Running HTML pre-build recipe"
	mkdir -p $(STAGING)
	mkdir -p $(MODWD)
	mkdir -p $(STAGING)/$(DEB)/$(PROD_VSN)/$(UI)
	mkdir -p $(STAGING)/$(DEB)/$(PROD_VSN)/$(CLI)
	mkdir -p $(STAGING)/$(SNAP)/$(PROD_VSN)/$(UI)
	mkdir -p $(STAGING)/$(SNAP)/$(PROD_VSN)/$(CLI)
#
# post-build-html
#
post-build-html: build-html
	@echo "\n*** Running HTML post-build recipe"
	cp -R $(STAGING)/$(DEB)/$(PROD_VSN)/$(UI) $(PROD_DEB)
	cp -R $(STAGING)/$(DEB)/$(PROD_VSN)/$(CLI) $(PROD_DEB)
	cp $(STAGING)/$(DEB)/$(PROD_VSN)/$(UI)/maas-documentation.html $(PROD_DEB)/index.html
	sed -i -e 's/href=\"https/hreg=\"https/g' $(PROD_DEB)/index.html
	sed -i -e 's/href=\"..\/cli/hreg=\"cli/g' $(PROD_DEB)/index.html
	sed -i -e 's/href=\"/href=\"ui\//g' $(PROD_DEB)/index.html
	sed -i -e 's/hreg/href/g' $(PROD_DEB)/index.html
	sed -i -e 's/<h1>Index<\/h1>/<h1>MAAS Documentation<\/h1>/g' $(PROD_DEB)/index.html
	cp -R $(STAGING)/$(SNAP)/$(PROD_VSN)/$(UI) $(PROD_SNAP)
	cp -R $(STAGING)/$(SNAP)/$(PROD_VSN)/$(CLI) $(PROD_SNAP)
	cp $(STAGING)/$(SNAP)/$(PROD_VSN)/$(UI)/index.html $(PROD_SNAP)/index.html
	sed -i -e 's/href=\"https/hreg=\"https/g' $(PROD_SNAP)/index.html
	sed -i -e 's/href=\"..\/cli/hreg=\"cli/g' $(PROD_SNAP)/index.html
	sed -i -e 's/href=\"/href=\"ui\//g' $(PROD_SNAP)/index.html
	sed -i -e 's/hreg/href/g' $(PROD_SNAP)/index.html
	sed -i -e 's/<h1>Index<\/h1>/<h1>MAAS Documentation<\/h1>/g' $(PROD_SNAP)/index.html
	@echo "\n***********************************************"
	@echo "***           HTML build complete           ***"
	@echo "***********************************************"
#
# build-html
#
build-html: pre-build-html $(HTARG)
	@echo "\n*************************************"
	@echo "*** HTML files built successfully ***"
	@echo "*************************************"
#
# post-build-all
#
post-build-all: post-build-discourse post-build-html
	@echo "\n*** Running post-build recipe for all"
#
## file-type recipes
#
# html (.html)
#
$(HTML)/%.html: $(SRC)/%.md
	@echo "\n*** Building" $(@F)
	$(eval BASE = $(notdir $<))
	@echo "identified" $(BASE)
	cp -p $(SRC)/$(BASE) $(MODWD)/$(BASE)
	cp $(SCRP)/strip-navigation.sh $(MODWD)
	cd $(MODWD) && ./strip-navigation.sh $(BASE)
	cd $(MODWD) && sed -i "/|| 2.7/d" $(BASE)
	cd $(MODWD) && sed -i "/||2.7/d" $(BASE)
	cd $(MODWD) && sed -i "/|-----:|:-----:/d" $(BASE)
	cd $(MODWD) && sed -i "/\[CLI\]/d" $(BASE)
	cd $(MODWD) && sed -i 's/\[note.*\]/<strong>NOTE:<\/strong> /g' $(BASE)
	cd $(MODWD) && sed -i 's/\[\/note.*\]//g' $(BASE)
	# run package CLI version of html
	cp $(TMPL)/$(DEB)/$(PROD_VSN)/$(CLI)/template.html $(MODWD)
	cd $(MODWD) && sed -i "s|zork|$(@F)|g" ./template.html
	cd $(MODWD) && xpub convert dc2html -t $(DEB)-$(PROD_TAG)-$(CLI) $(BASE)
	cd $(MODWD) && sed -i "s/-[0-9]*.html/.html/g" $(@F)
	cd $(MODWD) && sed -i 's/-$(DEB)-$(PROD_TAG)-$(CLI)//g' $(@F)
	mv $(MODWD)/$(@F) $(STAGING)/$(DEB)/$(PROD_VSN)/$(CLI)
	# run package UI version of html
	cp $(TMPL)/$(DEB)/$(PROD_VSN)/$(UI)/template.html $(MODWD)
	cd $(MODWD) && sed -i "s|zork|$(@F)|g" ./template.html
	cd $(MODWD) && xpub convert dc2html -t $(DEB)-$(PROD_TAG)-$(UI) $(BASE)
	cd $(MODWD) && sed -i "s/-[0-9]*.html/.html/g" $(@F)
	cd $(MODWD) && sed -i 's/-$(DEB)-$(PROD_TAG)-$(UI)//g' $(@F)
	mv $(MODWD)/$(@F) $(STAGING)/$(DEB)/$(PROD_VSN)/$(UI)
	# run snap CLI version of html
	cp $(TMPL)/$(SNAP)/$(PROD_VSN)/$(CLI)/template.html $(MODWD)
	cd $(MODWD) && sed -i "s|zork|$(@F)|g" ./template.html
	cd $(MODWD) && xpub convert dc2html -t $(SNAP)-$(PROD_TAG)-$(CLI) $(BASE)
	cd $(MODWD) && sed -i "s/-[0-9]*.html/.html/g" $(@F)
	cd $(MODWD) && sed -i 's/-$(SNAP)-$(PROD_TAG)-$(CLI)//g' $(@F)
	mv $(MODWD)/$(@F) $(STAGING)/$(SNAP)/$(PROD_VSN)/$(CLI)
	# run snap UI version of html
	cp $(TMPL)/$(SNAP)/$(PROD_VSN)/$(UI)/template.html $(MODWD)
	cd $(MODWD) && sed -i "s|zork|$(@F)|g" ./template.html
	cd $(MODWD) && xpub convert dc2html -t $(SNAP)-$(PROD_TAG)-$(UI) $(BASE)
	cd $(MODWD) && sed -i "s/-[0-9]*.html/.html/g" $(@F)
	cd $(MODWD) && sed -i 's/-$(SNAP)-$(PROD_TAG)-$(UI)//g' $(@F)
	cp $(MODWD)/$(@F) $(STAGING)/$(SNAP)/$(PROD_VSN)/$(UI)
	# mv last html file to html dir as makefile reference
	mv $(MODWD)/$(@F) $(HTML)

#
# discourse file recipes, alphabetical by file
#

# a

$(DISC)/about-maas.md: $(SRC)/about-maas.md
	@echo "\n*** Building about-maas.md"
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-7-cli-2268.md 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-7-cli about-maas-deb-2-7-cli-2268.md 
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-7-ui-2269.md	 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-7-ui about-maas-deb-2-7-ui-2269.md  
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-8-cli-2270.md 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-8-cli about-maas-deb-2-8-cli-2270.md 
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-8-ui-2271.md	 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-8-ui about-maas-deb-2-8-ui-2271.md  
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-9-cli-2272.md 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-9-cli about-maas-deb-2-9-cli-2272.md 
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-9-ui-2273.md	 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-9-ui about-maas-deb-2-9-ui-2273.md  
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-7-cli-2262.md
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-7-cli about-maas-snap-2-7-cli-2262.md
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-7-ui-2263.md 
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-7-ui about-maas-snap-2-7-ui-2263.md 
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-8-cli-2264.md
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-8-cli about-maas-snap-2-8-cli-2264.md
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-8-ui-2265.md 
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-8-ui about-maas-snap-2-8-ui-2265.md 
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-9-cli-2266.md
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-9-cli about-maas-snap-2-9-cli-2266.md
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-9-ui-2267.md 
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-9-ui about-maas-snap-2-9-ui-2267.md
	cd $(DISC) &&\
	xpub pull discourse 2273 2273
	cd $(DISC) &&\
	cp -p about-maas-deb-2-9-ui-2273.md about-maas.md
 
$(DISC)/adding-a-vm-host.md: $(SRC)/adding-a-vm-host.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-7-cli-2292.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-7-cli adding-a-vm-host-deb-2-7-cli-2292.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-7-ui-2293.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-7-ui adding-a-vm-host-deb-2-7-ui-2293.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-8-cli-2294.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-8-cli adding-a-vm-host-deb-2-8-cli-2294.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-8-ui-2295.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-8-ui adding-a-vm-host-deb-2-8-ui-2295.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-9-cli-2296.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-9-cli adding-a-vm-host-deb-2-9-cli-2296.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-9-ui-2297.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-9-ui adding-a-vm-host-deb-2-9-ui-2297.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-7-cli-2286.md
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-7-cli adding-a-vm-host-snap-2-7-cli-2286.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-7-ui-2287.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui adding-a-vm-host-snap-2-7-ui-2287.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-8-cli-2288.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli adding-a-vm-host-snap-2-8-cli-2288.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-8-ui-2289.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui adding-a-vm-host-snap-2-8-ui-2289.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-9-cli-2290.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli adding-a-vm-host-snap-2-9-cli-2290.md
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-9-ui-2291.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui adding-a-vm-host-snap-2-9-ui-2291.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2297 2297
	cd $(DISC) &&\
	cp -p adding-a-vm-host-deb-2-9-ui-2297.md adding-a-vm-host.md
 
$(DISC)/add-machines.md: $(SRC)/add-machines.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-7-cli-2280.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli add-machines-deb-2-7-cli-2280.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-7-ui-2281.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui add-machines-deb-2-7-ui-2281.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-8-cli-2282.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli add-machines-deb-2-8-cli-2282.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-8-ui-2283.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui add-machines-deb-2-8-ui-2283.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-9-cli-2284.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli add-machines-deb-2-9-cli-2284.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-9-ui-2285.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui add-machines-deb-2-9-ui-2285.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-7-cli-2274.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli add-machines-snap-2-7-cli-2274.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-7-ui-2275.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui add-machines-snap-2-7-ui-2275.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-8-cli-2276.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli add-machines-snap-2-8-cli-2276.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-8-ui-2277.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui add-machines-snap-2-8-ui-2277.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-9-cli-2278.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli add-machines-snap-2-9-cli-2278.md
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-9-ui-2279.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui add-machines-snap-2-9-ui-2279.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2285 2285
	cd $(DISC) &&\
	cp -p add-machines-deb-2-9-ui-2285.md add-machines.md
 
$(DISC)/api-authentication.md: $(SRC)/api-authentication.md
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-742.md
	cd $(MODWD) &&\
	xpub push $(DISC) api-authentication-742.md
	cd $(DISC) &&\
	xpub pull $(DISC) 742 742
	cd $(DISC) &&\
	cp -p api-authentication-742.md api-authentication.md

$(DISC)/audit-event-logs.md: $(SRC)/audit-event-logs.md
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-791.md
	cd $(MODWD) &&\
	xpub push $(DISC) audit-event-logs-791.md
	cd $(DISC) &&\
	xpub pull $(DISC) 791 791
	cd $(DISC) &&\
	cp -p audit-event-logs-791.md audit-event-logs.md

$(DISC)/availability-zones.md: $(SRC)/availability-zones.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-7-cli-2328.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli availability-zones-deb-2-7-cli-2328.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-7-ui-2329.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui availability-zones-deb-2-7-ui-2329.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-8-cli-2330.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli availability-zones-deb-2-8-cli-2330.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-8-ui-2331.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui availability-zones-deb-2-8-ui-2331.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-9-cli-2332.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli availability-zones-deb-2-9-cli-2332.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-9-ui-2333.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui availability-zones-deb-2-9-ui-2333.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-7-cli-2322.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli availability-zones-snap-2-7-cli-2322.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-7-ui-2323.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui availability-zones-snap-2-7-ui-2323.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-8-cli-2324.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli availability-zones-snap-2-8-cli-2324.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-8-ui-2325.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui availability-zones-snap-2-8-ui-2325.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-9-cli-2326.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli availability-zones-snap-2-9-cli-2326.md
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-9-ui-2327.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui availability-zones-snap-2-9-ui-2327.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2333 2333
	cd $(DISC) &&\
	cp -p availability-zones-deb-2-9-ui-2333.md availability-zones.md

#b

$(DISC)/backup.md: $(SRC)/backup.md
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-7-cli-2340.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli backup-deb-2-7-cli-2340.md
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-7-ui-2341.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui backup-deb-2-7-ui-2341.md
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-8-cli-2342.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli backup-deb-2-8-cli-2342.md
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-8-ui-2343.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui backup-deb-2-8-ui-2343.md
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-9-cli-2344.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli backup-deb-2-9-cli-2344.md
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-9-ui-2345.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui backup-deb-2-9-ui-2345.md
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-7-cli-2334.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli backup-snap-2-7-cli-2334.md
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-7-ui-2335.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui backup-snap-2-7-ui-2335.md
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-8-cli-2352.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli backup-snap-2-8-cli-2352.md
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-8-ui-2337.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui backup-snap-2-8-ui-2337.md
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-9-cli-2338.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli backup-snap-2-9-cli-2338.md
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-9-ui-2339.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui backup-snap-2-9-ui-2339.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2345 2345
	cd $(DISC) &&\
	cp -p backup-deb-2-9-ui-2345.md backup.md
 
$(DISC)/block-devices.md: $(SRC)/block-devices.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-7-cli-2352.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli block-devices-deb-2-7-cli-2352.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-7-ui-2353.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui block-devices-deb-2-7-ui-2353.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-8-cli-2354.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli block-devices-deb-2-8-cli-2354.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-8-ui-2355.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui block-devices-deb-2-8-ui-2355.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-9-cli-2356.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli block-devices-deb-2-9-cli-2356.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-9-ui-2357.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui block-devices-deb-2-9-ui-2357.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-7-cli-2346.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli block-devices-snap-2-7-cli-2346.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-7-ui-2347.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui block-devices-snap-2-7-ui-2347.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-8-cli-2348.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli block-devices-snap-2-8-cli-2348.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-8-ui-2349.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui block-devices-snap-2-8-ui-2349.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-9-cli-2350.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli block-devices-snap-2-9-cli-2350.md
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-9-ui-2351.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui block-devices-snap-2-9-ui-2351.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2357 2357
	cd $(DISC) &&\
	cp -p block-devices-deb-2-9-ui-2357.md block-devices.md

#c

$(DISC)/candid-tutorial.md: $(SRC)/candid-tutorial.md
	cp $(SRC)/candid-tutorial.md $(MODWD)/candid-tutorial-3610.md
	cd $(MODWD) &&\
	xpub push $(DISC) candid-tutorial-3610.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3610 3610
	cd $(DISC) &&\
	cp -p candid-tutorial-3610.md candid-tutorial.md

$(DISC)/cli-advanced-tasks.md: $(SRC)/cli-advanced-tasks.md
	cp $(SRC)/cli-advanced-tasks.md $(MODWD)/cli-advanced-tasks-793.md
	cd $(MODWD) &&\
	xpub push $(DISC) cli-advanced-tasks-793.md
	cd $(DISC) &&\
	xpub pull $(DISC) 793 793
	cd $(DISC) &&\
	cp -p cli-advanced-tasks-793.md cli-advanced-tasks.md

$(DISC)/cli-composable-hardware.md: $(SRC)/cli-composable-hardware.md
	cp $(SRC)/cli-composable-hardware.md $(MODWD)/cli-composable-hardware-795.md
	cd $(MODWD) &&\
	xpub push $(DISC) cli-composable-hardware-795.md
	cd $(DISC) &&\
	xpub pull $(DISC) 795 795
	cd $(DISC) &&\
	cp -p cli-composable-hardware-795.md cli-composable-hardware.md
 
$(DISC)/cli-image-management.md: $(SRC)/cli-image-management.md
	cp $(SRC)/cli-image-management.md $(MODWD)/cli-image-management-797.md
	cd $(MODWD) &&\
	xpub push $(DISC) cli-image-management-797.md
	cd $(DISC) &&\
	xpub pull $(DISC) 797 797
	cd $(DISC) &&\
	cp -p cli-image-management-797.md cli-image-management.md

$(DISC)/cli-interface-management.md: $(SRC)/cli-interface-management.md
	cp $(SRC)/cli-interface-management.md $(MODWD)/cli-interface-management-798.md
	cd $(MODWD) &&\
	xpub push $(DISC) cli-interface-management-798.md
	cd $(DISC) &&\
	xpub pull $(DISC) 798 798
	cd $(DISC) &&\
	cp -p cli-interface-management-798.md cli-interface-management.md
 
$(DISC)/cli-kernel-management.md: $(SRC)/cli-kernel-management.md
	cp $(SRC)/cli-kernel-management.md $(MODWD)/cli-kernel-management-799.md
	cd $(MODWD) &&\
	xpub push $(DISC) cli-kernel-management-799.md
	cd $(DISC) &&\
	xpub pull $(DISC) 799 799
	cd $(DISC) &&\
	cp -p cli-kernel-management-799.md cli-kernel-management.md
 
$(DISC)/commissioning-and-hardware-testing-scripts.md: $(SRC)/commissioning-and-hardware-testing-scripts.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-7-cli-2484.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli commissioning-and-hardware-testing-scripts-deb-2-7-cli-2484.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-7-ui-2485.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui commissioning-and-hardware-testing-scripts-deb-2-7-ui-2485.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-8-cli-2486.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli commissioning-and-hardware-testing-scripts-deb-2-8-cli-2486.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-8-ui-2487.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui commissioning-and-hardware-testing-scripts-deb-2-8-ui-2487.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-9-cli-2488.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli commissioning-and-hardware-testing-scripts-deb-2-9-cli-2488.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-9-ui-2489.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui commissioning-and-hardware-testing-scripts-deb-2-9-ui-2489.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-7-cli-2478.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli commissioning-and-hardware-testing-scripts-snap-2-7-cli-2478.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-7-ui-2479.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui commissioning-and-hardware-testing-scripts-snap-2-7-ui-2479.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-8-cli-2480.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli commissioning-and-hardware-testing-scripts-snap-2-8-cli-2480.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-8-ui-2481.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui commissioning-and-hardware-testing-scripts-snap-2-8-ui-2481.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-9-cli-2482.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli commissioning-and-hardware-testing-scripts-snap-2-9-cli-2482.md
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-9-ui-2483.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui commissioning-and-hardware-testing-scripts-snap-2-9-ui-2483.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2489 2489
	cd $(DISC) &&\
	cp -p commissioning-and-hardware-testing-scripts-deb-2-9-ui-2489.md commissioning-and-hardware-testing-scripts.md
 
$(DISC)/commissioning-logs.md: $(SRC)/commissioning-logs.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-7-cli-2496.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli commissioning-logs-deb-2-7-cli-2496.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-7-ui-2497.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui commissioning-logs-deb-2-7-ui-2497.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-8-cli-2498.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli commissioning-logs-deb-2-8-cli-2498.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-8-ui-2499.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui commissioning-logs-deb-2-8-ui-2499.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-9-cli-2500.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli commissioning-logs-deb-2-9-cli-2500.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-9-ui-2501.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui commissioning-logs-deb-2-9-ui-2501.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-7-cli-2490.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli commissioning-logs-snap-2-7-cli-2490.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-7-ui-2491.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui commissioning-logs-snap-2-7-ui-2491.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-8-cli-2492.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli commissioning-logs-snap-2-8-cli-2492.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-8-ui-2493.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui commissioning-logs-snap-2-8-ui-2493.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-9-cli-2494.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli commissioning-logs-snap-2-9-cli-2494.md
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-9-ui-2495.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui commissioning-logs-snap-2-9-ui-2495.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2501 2501
	cd $(DISC) &&\
	cp -p commissioning-logs-deb-2-9-ui-2501.md commissioning-logs.md

$(DISC)/commission-machines.md: $(SRC)/commission-machines.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-7-cli-2472.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli commission-machines-deb-2-7-cli-2472.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-7-ui-2473.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui commission-machines-deb-2-7-ui-2473.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-8-cli-2474.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli commission-machines-deb-2-8-cli-2474.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-8-ui-2475.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui commission-machines-deb-2-8-ui-2475.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-9-cli-2476.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli commission-machines-deb-2-9-cli-2476.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-9-ui-2477.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui commission-machines-deb-2-9-ui-2477.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-7-cli-2466.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli commission-machines-snap-2-7-cli-2466.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-7-ui-2467.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui commission-machines-snap-2-7-ui-2467.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-8-cli-2468.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli commission-machines-snap-2-8-cli-2468.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-8-ui-2469.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui commission-machines-snap-2-8-ui-2469.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-9-cli-2470.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli commission-machines-snap-2-9-cli-2470.md
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-9-ui-2471.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui commission-machines-snap-2-9-ui-2471.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2477 2477
	cd $(DISC) &&\
	cp -p commission-machines-deb-2-9-ui-2477.md commission-machines.md
 
$(DISC)/common-cli-tasks.md: $(SRC)/common-cli-tasks.md
	cp $(SRC)/common-cli-tasks.md $(MODWD)/common-cli-tasks-794.md
	cd $(MODWD) &&\
	xpub push $(DISC) common-cli-tasks-794.md
	cd $(DISC) &&\
	xpub pull $(DISC) 794 794
	cd $(DISC) &&\
	cp -p common-cli-tasks-794.md common-cli-tasks.md
 
$(DISC)/concepts-and-terms.md: $(SRC)/concepts-and-terms.md
	cp $(SRC)/concepts-and-terms.md $(MODWD)/concepts-and-terms-785.md
	cd $(MODWD) &&\
	xpub push $(DISC) concepts-and-terms-785.md
	cd $(DISC) &&\
	xpub pull $(DISC) 785 785
	cd $(DISC) &&\
	cp -p concepts-and-terms-785.md concepts-and-terms.md
 
$(DISC)/configuration-journey.md: $(SRC)/configuration-journey.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-7-cli-2532.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli configuration-journey-deb-2-7-cli-2532.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-7-ui-2533.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui configuration-journey-deb-2-7-ui-2533.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-8-cli-2534.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli configuration-journey-deb-2-8-cli-2534.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-8-ui-2535.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui configuration-journey-deb-2-8-ui-2535.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-9-cli-2536.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli configuration-journey-deb-2-9-cli-2536.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-9-ui-2537.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui configuration-journey-deb-2-9-ui-2537.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-7-cli-2526.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli configuration-journey-snap-2-7-cli-2526.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-7-ui-2527.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui configuration-journey-snap-2-7-ui-2527.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-8-cli-2528.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli configuration-journey-snap-2-8-cli-2528.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-8-ui-2529.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui configuration-journey-snap-2-8-ui-2529.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-9-cli-2530.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli configuration-journey-snap-2-9-cli-2530.md
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-9-ui-2531.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui configuration-journey-snap-2-9-ui-2531.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2537 2537
	cd $(DISC) &&\
	cp -p configuration-journey-deb-2-9-ui-2537.md configuration-journey.md
 
$(DISC)/configuring-tls-encryption.md: $(SRC)/configuring-tls-encryption.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-7-cli-2544.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli configuring-tls-encryption-deb-2-7-cli-2544.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-7-ui-2545.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui configuring-tls-encryption-deb-2-7-ui-2545.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-8-cli-2546.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli configuring-tls-encryption-deb-2-8-cli-2546.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-8-ui-2547.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui configuring-tls-encryption-deb-2-8-ui-2547.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-9-cli-2548.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli configuring-tls-encryption-deb-2-9-cli-2548.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-9-ui-2549.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui configuring-tls-encryption-deb-2-9-ui-2549.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-7-cli-2538.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli configuring-tls-encryption-snap-2-7-cli-2538.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-7-ui-2539.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui configuring-tls-encryption-snap-2-7-ui-2539.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-8-cli-2540.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli configuring-tls-encryption-snap-2-8-cli-2540.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-8-ui-2541.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui configuring-tls-encryption-snap-2-8-ui-2541.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-9-cli-2542.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli configuring-tls-encryption-snap-2-9-cli-2542.md
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-9-ui-2543.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui configuring-tls-encryption-snap-2-9-ui-2543.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2549 2549
	cd $(DISC) &&\
	cp -p configuring-tls-encryption-deb-2-9-ui-2549.md configuring-tls-encryption.md
 
$(DISC)/contact-us.md: $(SRC)/contact-us.md
	cp $(SRC)/contact-us.md $(MODWD)/contact-us-743.md
	cd $(MODWD) &&\
	xpub push $(DISC) contact-us-743.md
	cd $(DISC) &&\
	xpub pull $(DISC) 743 743
	cd $(DISC) &&\
	cp -p contact-us-743.md contact-us.md

$(DISC)/controllers.md: $(SRC)/controllers.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-7-cli-2724.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli controllers-deb-2-7-cli-2724.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-7-ui-2725.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui controllers-deb-2-7-ui-2725.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-8-cli-2726.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli controllers-deb-2-8-cli-2726.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-8-ui-2727.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui controllers-deb-2-8-ui-2727.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-9-cli-2728.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli controllers-deb-2-9-cli-2728.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-9-ui-2729.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui controllers-deb-2-9-ui-2729.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-7-cli-2718.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli controllers-snap-2-7-cli-2718.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-7-ui-2719.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui controllers-snap-2-7-ui-2719.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-8-cli-2720.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli controllers-snap-2-8-cli-2720.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-8-ui-2721.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui controllers-snap-2-8-ui-2721.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-9-cli-2722.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli controllers-snap-2-9-cli-2722.md
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-9-ui-2723.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui controllers-snap-2-9-ui-2723.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2729 2729
	cd $(DISC) &&\
	cp -p controllers-deb-2-9-ui-2729.md controllers.md
 
$(DISC)/creating-a-custom-ubuntu-image.md: $(SRC)/creating-a-custom-ubuntu-image.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-7-cli-2568.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli creating-a-custom-ubuntu-image-deb-2-7-cli-2568.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-7-ui-2569.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui creating-a-custom-ubuntu-image-deb-2-7-ui-2569.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-8-cli-2570.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli creating-a-custom-ubuntu-image-deb-2-8-cli-2570.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-8-ui-2571.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui creating-a-custom-ubuntu-image-deb-2-8-ui-2571.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-9-cli-2572.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli creating-a-custom-ubuntu-image-deb-2-9-cli-2572.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-9-ui-2573.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui creating-a-custom-ubuntu-image-deb-2-9-ui-2573.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-7-cli-2562.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli creating-a-custom-ubuntu-image-snap-2-7-cli-2562.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-7-ui-2563.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui creating-a-custom-ubuntu-image-snap-2-7-ui-2563.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-8-cli-2564.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli creating-a-custom-ubuntu-image-snap-2-8-cli-2564.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-8-ui-2565.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui creating-a-custom-ubuntu-image-snap-2-8-ui-2565.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-9-cli-2566.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli creating-a-custom-ubuntu-image-snap-2-9-cli-2566.md
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-9-ui-2567.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui creating-a-custom-ubuntu-image-snap-2-9-ui-2567.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2573 2573
	cd $(DISC) &&\
	cp -p creating-a-custom-ubuntu-image-deb-2-9-ui-2573.md creating-a-custom-ubuntu-image.md
 
$(DISC)/creating-and-deleting-vms.md: $(SRC)/creating-and-deleting-vms.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-7-cli-2580.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli creating-and-deleting-vms-deb-2-7-cli-2580.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-7-ui-2581.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui creating-and-deleting-vms-deb-2-7-ui-2581.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-8-cli-2582.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli creating-and-deleting-vms-deb-2-8-cli-2582.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-8-ui-2583.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui creating-and-deleting-vms-deb-2-8-ui-2583.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-9-cli-2584.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli creating-and-deleting-vms-deb-2-9-cli-2584.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-9-ui-2585.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui creating-and-deleting-vms-deb-2-9-ui-2585.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-7-cli-2574.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli creating-and-deleting-vms-snap-2-7-cli-2574.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-7-ui-2575.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui creating-and-deleting-vms-snap-2-7-ui-2575.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-8-cli-2576.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli creating-and-deleting-vms-snap-2-8-cli-2576.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-8-ui-2577.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui creating-and-deleting-vms-snap-2-8-ui-2577.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-9-cli-2578.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli creating-and-deleting-vms-snap-2-9-cli-2578.md
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-9-ui-2579.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui creating-and-deleting-vms-snap-2-9-ui-2579.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2585 2585
	cd $(DISC) &&\
	cp -p creating-and-deleting-vms-deb-2-9-ui-2585.md creating-and-deleting-vms.md
 
$(DISC)/custom-machine-setup.md: $(SRC)/custom-machine-setup.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-7-cli-2592.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli custom-machine-setup-deb-2-7-cli-2592.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-7-ui-2593.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui custom-machine-setup-deb-2-7-ui-2593.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-8-cli-2594.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli custom-machine-setup-deb-2-8-cli-2594.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-8-ui-2595.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui custom-machine-setup-deb-2-8-ui-2595.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-9-cli-2596.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli custom-machine-setup-deb-2-9-cli-2596.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-9-ui-2597.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui custom-machine-setup-deb-2-9-ui-2597.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-7-cli-2586.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli custom-machine-setup-snap-2-7-cli-2586.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-7-ui-2587.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui custom-machine-setup-snap-2-7-ui-2587.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-8-cli-2588.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli custom-machine-setup-snap-2-8-cli-2588.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-8-ui-2589.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui custom-machine-setup-snap-2-8-ui-2589.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-9-cli-2590.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli custom-machine-setup-snap-2-9-cli-2590.md
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-9-ui-2591.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui custom-machine-setup-snap-2-9-ui-2591.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2597 2597
	cd $(DISC) &&\
	cp -p custom-machine-setup-deb-2-9-ui-2597.md custom-machine-setup.md

#d

$(DISC)/deploy-machines.md: $(SRC)/deploy-machines.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-7-cli-2604.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli deploy-machines-deb-2-7-cli-2604.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-7-ui-2605.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui deploy-machines-deb-2-7-ui-2605.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-8-cli-2606.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli deploy-machines-deb-2-8-cli-2606.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-8-ui-2607.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui deploy-machines-deb-2-8-ui-2607.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-9-cli-2608.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli deploy-machines-deb-2-9-cli-2608.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-9-ui-2609.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui deploy-machines-deb-2-9-ui-2609.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-7-cli-2598.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli deploy-machines-snap-2-7-cli-2598.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-7-ui-2599.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui deploy-machines-snap-2-7-ui-2599.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-8-cli-2600.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli deploy-machines-snap-2-8-cli-2600.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-8-ui-2601.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui deploy-machines-snap-2-8-ui-2601.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-9-cli-2602.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli deploy-machines-snap-2-9-cli-2602.md
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-9-ui-2603.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui deploy-machines-snap-2-9-ui-2603.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2609 2609
	cd $(DISC) &&\
	cp -p deploy-machines-deb-2-9-ui-2609.md deploy-machines.md
 
$(DISC)/disk-erasure.md: $(SRC)/disk-erasure.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-7-cli-2616.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli disk-erasure-deb-2-7-cli-2616.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-7-ui-2617.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui disk-erasure-deb-2-7-ui-2617.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-8-cli-2618.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli disk-erasure-deb-2-8-cli-2618.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-8-ui-2619.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui disk-erasure-deb-2-8-ui-2619.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-9-cli-2620.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli disk-erasure-deb-2-9-cli-2620.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-9-ui-2621.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui disk-erasure-deb-2-9-ui-2621.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-7-cli-2610.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli disk-erasure-snap-2-7-cli-2610.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-7-ui-2611.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui disk-erasure-snap-2-7-ui-2611.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-8-cli-2612.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli disk-erasure-snap-2-8-cli-2612.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-8-ui-2613.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui disk-erasure-snap-2-8-ui-2613.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-9-cli-2614.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli disk-erasure-snap-2-9-cli-2614.md
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-9-ui-2615.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui disk-erasure-snap-2-9-ui-2615.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2621 2621
	cd $(DISC) &&\
	cp -p disk-erasure-deb-2-9-ui-2621.md disk-erasure.md


#e

$(DISC)/event-logs.md: $(SRC)/event-logs.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-7-cli-3388.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli event-logs-deb-2-7-cli-3388.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-7-ui-3389.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui event-logs-deb-2-7-ui-3389.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-8-cli-3390.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli event-logs-deb-2-8-cli-3390.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-8-ui-3391.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui event-logs-deb-2-8-ui-3391.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-9-cli-3382.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli event-logs-deb-2-9-cli-3382.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-9-ui-3392.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui event-logs-deb-2-9-ui-3392.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-7-cli-3382.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli event-logs-snap-2-7-cli-3382.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-7-ui-3383.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui event-logs-snap-2-7-ui-3383.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-8-cli-3384.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli event-logs-snap-2-8-cli-3384.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-8-ui-3385.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui event-logs-snap-2-8-ui-3385.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-9-cli-3386.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli event-logs-snap-2-9-cli-3386.md
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-9-ui-3387.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui event-logs-snap-2-9-ui-3387.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3392 3392
	cd $(DISC) &&\
	cp -p event-logs-deb-2-9-ui-3392.md event-logs.md

#g

$(DISC)/getting-help.md: $(SRC)/getting-help.md
	cp $(SRC)/getting-help.md $(MODWD)/getting-help-838.md
	cd $(MODWD) &&\
	xpub push $(DISC) getting-help-838.md
	cd $(DISC) &&\
	xpub pull $(DISC) 838 838
	cd $(DISC) &&\
	cp -p getting-help-838.md getting-help.md

$(DISC)/give-me-an-example-of-maas.md: $(SRC)/give-me-an-example-of-maas.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-7-cli-2652.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli give-me-an-example-of-maas-deb-2-7-cli-2652.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-7-ui-2653.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui give-me-an-example-of-maas-deb-2-7-ui-2653.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-8-cli-2654.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli give-me-an-example-of-maas-deb-2-8-cli-2654.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-8-ui-2655.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui give-me-an-example-of-maas-deb-2-8-ui-2655.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-9-cli-2656.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli give-me-an-example-of-maas-deb-2-9-cli-2656.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-9-ui-2657.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui give-me-an-example-of-maas-deb-2-9-ui-2657.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-7-cli-2646.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli give-me-an-example-of-maas-snap-2-7-cli-2646.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-7-ui-2647.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui give-me-an-example-of-maas-snap-2-7-ui-2647.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-8-cli-2648.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli give-me-an-example-of-maas-snap-2-8-cli-2648.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-8-ui-2649.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui give-me-an-example-of-maas-snap-2-8-ui-2649.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-9-cli-2650.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli give-me-an-example-of-maas-snap-2-9-cli-2650.md
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-9-ui-2651.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui give-me-an-example-of-maas-snap-2-9-ui-2651.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2657 2657
	cd $(DISC) &&\
	cp -p give-me-an-example-of-maas-deb-2-9-ui-2657.md give-me-an-example-of-maas.md

#h

$(DISC)/hardening-your-maas-installation.md: $(SRC)/hardening-your-maas-installation.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-7-cli-2664.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli hardening-your-maas-installation-deb-2-7-cli-2664.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-7-ui-2665.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui hardening-your-maas-installation-deb-2-7-ui-2665.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-8-cli-2666.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli hardening-your-maas-installation-deb-2-8-cli-2666.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-8-ui-2667.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui hardening-your-maas-installation-deb-2-8-ui-2667.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-9-cli-2668.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli hardening-your-maas-installation-deb-2-9-cli-2668.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-9-ui-2669.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui hardening-your-maas-installation-deb-2-9-ui-2669.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-7-cli-2658.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli hardening-your-maas-installation-snap-2-7-cli-2658.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-7-ui-2659.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui hardening-your-maas-installation-snap-2-7-ui-2659.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-8-cli-2660.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli hardening-your-maas-installation-snap-2-8-cli-2660.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-8-ui-2661.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui hardening-your-maas-installation-snap-2-8-ui-2661.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-9-cli-2662.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli hardening-your-maas-installation-snap-2-9-cli-2662.md
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-9-ui-2663.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui hardening-your-maas-installation-snap-2-9-ui-2663.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2669 2669
	cd $(DISC) &&\
	cp -p hardening-your-maas-installation-deb-2-9-ui-2669.md hardening-your-maas-installation.md
 
$(DISC)/hardware-testing.md: $(SRC)/hardware-testing.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-7-cli-2676.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli hardware-testing-deb-2-7-cli-2676.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-7-ui-2677.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui hardware-testing-deb-2-7-ui-2677.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-8-cli-2678.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli hardware-testing-deb-2-8-cli-2678.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-8-ui-2679.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui hardware-testing-deb-2-8-ui-2679.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-9-cli-2680.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli hardware-testing-deb-2-9-cli-2680.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-9-ui-2681.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui hardware-testing-deb-2-9-ui-2681.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-7-cli-2670.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli hardware-testing-snap-2-7-cli-2670.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-7-ui-2671.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui hardware-testing-snap-2-7-ui-2671.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-8-cli-2672.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli hardware-testing-snap-2-8-cli-2672.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-8-ui-2673.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui hardware-testing-snap-2-8-ui-2673.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-9-cli-2674.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli hardware-testing-snap-2-9-cli-2674.md
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-9-ui-2675.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui hardware-testing-snap-2-9-ui-2675.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2681 2681
	cd $(DISC) &&\
	cp -p hardware-testing-deb-2-9-ui-2681.md hardware-testing.md
 
$(DISC)/high-availability.md: $(SRC)/high-availability.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-7-cli-2688.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli high-availability-deb-2-7-cli-2688.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-7-ui-2689.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui high-availability-deb-2-7-ui-2689.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-8-cli-2690.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli high-availability-deb-2-8-cli-2690.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-8-ui-2691.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui high-availability-deb-2-8-ui-2691.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-9-cli-2692.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli high-availability-deb-2-9-cli-2692.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-9-ui-2693.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui high-availability-deb-2-9-ui-2693.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-7-cli-2682.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli high-availability-snap-2-7-cli-2682.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-7-ui-2683.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui high-availability-snap-2-7-ui-2683.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-8-cli-2684.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli high-availability-snap-2-8-cli-2684.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-8-ui-2685.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui high-availability-snap-2-8-ui-2685.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-9-cli-2686.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli high-availability-snap-2-9-cli-2686.md
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-9-ui-2687.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui high-availability-snap-2-9-ui-2687.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2693 2693
	cd $(DISC) &&\
	cp -p high-availability-deb-2-9-ui-2693.md high-availability.md

#i

$(DISC)/images.md: $(SRC)/images.md
	cp $(SRC)/images.md $(MODWD)/images-deb-2-7-cli-2700.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli images-deb-2-7-cli-2700.md
	cp $(SRC)/images.md $(MODWD)/images-deb-2-7-ui-2701.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui images-deb-2-7-ui-2701.md
	cp $(SRC)/images.md $(MODWD)/images-deb-2-8-cli-2702.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli images-deb-2-8-cli-2702.md
	cp $(SRC)/images.md $(MODWD)/images-deb-2-8-ui-2703.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui images-deb-2-8-ui-2703.md
	cp $(SRC)/images.md $(MODWD)/images-deb-2-9-cli-2704.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli images-deb-2-9-cli-2704.md
	cp $(SRC)/images.md $(MODWD)/images-deb-2-9-ui-2705.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui images-deb-2-9-ui-2705.md
	cp $(SRC)/images.md $(MODWD)/images-snap-2-7-cli-2694.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli images-snap-2-7-cli-2694.md
	cp $(SRC)/images.md $(MODWD)/images-snap-2-7-ui-2695.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui images-snap-2-7-ui-2695.md
	cp $(SRC)/images.md $(MODWD)/images-snap-2-8-cli-2696.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli images-snap-2-8-cli-2696.md
	cp $(SRC)/images.md $(MODWD)/images-snap-2-8-ui-2697.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui images-snap-2-8-ui-2697.md
	cp $(SRC)/images.md $(MODWD)/images-snap-2-9-cli-2698.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli images-snap-2-9-cli-2698.md
	cp $(SRC)/images.md $(MODWD)/images-snap-2-9-ui-2699.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui images-snap-2-9-ui-2699.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2705 2705
	cd $(DISC) &&\
	cp -p images-deb-2-9-ui-2705.md images.md
 
$(DISC)/interactive-search.md: $(SRC)/interactive-search.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-7-cli-2712.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli interactive-search-deb-2-7-cli-2712.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-7-ui-2713.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui interactive-search-deb-2-7-ui-2713.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-8-cli-2714.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli interactive-search-deb-2-8-cli-2714.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-8-ui-2715.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui interactive-search-deb-2-8-ui-2715.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-9-cli-2716.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli interactive-search-deb-2-9-cli-2716.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-9-ui-2717.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui interactive-search-deb-2-9-ui-2717.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-7-cli-2706.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli interactive-search-snap-2-7-cli-2706.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-7-ui-2707.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui interactive-search-snap-2-7-ui-2707.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-8-cli-2708.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli interactive-search-snap-2-8-cli-2708.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-8-ui-2709.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui interactive-search-snap-2-8-ui-2709.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-9-cli-2710.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli interactive-search-snap-2-9-cli-2710.md
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-9-ui-2711.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui interactive-search-snap-2-9-ui-2711.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2717 2717
	cd $(DISC) &&\
	cp -p interactive-search-deb-2-9-ui-2717.md interactive-search.md
 
$(DISC)/ip-ranges.md: $(SRC)/ip-ranges.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-7-cli-2760.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli ip-ranges-deb-2-7-cli-2760.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-7-ui-2761.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui ip-ranges-deb-2-7-ui-2761.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-8-cli-2762.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli ip-ranges-deb-2-8-cli-2762.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-8-ui-2763.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui ip-ranges-deb-2-8-ui-2763.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-9-cli-2764.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli ip-ranges-deb-2-9-cli-2764.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-9-ui-2765.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui ip-ranges-deb-2-9-ui-2765.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-7-cli-2754.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli ip-ranges-snap-2-7-cli-2754.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-7-ui-2755.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui ip-ranges-snap-2-7-ui-2755.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-8-cli-2756.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli ip-ranges-snap-2-8-cli-2756.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-8-ui-2757.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui ip-ranges-snap-2-8-ui-2757.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-9-cli-2758.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli ip-ranges-snap-2-9-cli-2758.md
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-9-ui-2759.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui ip-ranges-snap-2-9-ui-2759.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2765 2765
	cd $(DISC) &&\
	cp -p ip-ranges-deb-2-9-ui-2765.md ip-ranges.md
 
$(DISC)/ipv6-addressing.md: $(SRC)/ipv6-addressing.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-7-cli-2772.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli ipv6-addressing-deb-2-7-cli-2772.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-7-ui-2773.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui ipv6-addressing-deb-2-7-ui-2773.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-8-cli-2774.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli ipv6-addressing-deb-2-8-cli-2774.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-8-ui-2775.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui ipv6-addressing-deb-2-8-ui-2775.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-9-cli-2776.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli ipv6-addressing-deb-2-9-cli-2776.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-9-ui-2777.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui ipv6-addressing-deb-2-9-ui-2777.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-7-cli-2766.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli ipv6-addressing-snap-2-7-cli-2766.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-7-ui-2767.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui ipv6-addressing-snap-2-7-ui-2767.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-8-cli-2768.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli ipv6-addressing-snap-2-8-cli-2768.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-8-ui-2769.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui ipv6-addressing-snap-2-8-ui-2769.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-9-cli-2770.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli ipv6-addressing-snap-2-9-cli-2770.md
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-9-ui-2771.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui ipv6-addressing-snap-2-9-ui-2771.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2777 2777
	cd $(DISC) &&\
	cp -p ipv6-addressing-deb-2-9-ui-2777.md ipv6-addressing.md

#k

$(DISC)/kernel-boot-options.md: $(SRC)/kernel-boot-options.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-7-cli-2784.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli kernel-boot-options-deb-2-7-cli-2784.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-7-ui-2785.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui kernel-boot-options-deb-2-7-ui-2785.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-8-cli-2786.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli kernel-boot-options-deb-2-8-cli-2786.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-8-ui-2787.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui kernel-boot-options-deb-2-8-ui-2787.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-9-cli-2788.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli kernel-boot-options-deb-2-9-cli-2788.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-9-ui-2789.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui kernel-boot-options-deb-2-9-ui-2789.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-7-cli-2778.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli kernel-boot-options-snap-2-7-cli-2778.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-7-ui-2779.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui kernel-boot-options-snap-2-7-ui-2779.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-8-cli-2780.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli kernel-boot-options-snap-2-8-cli-2780.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-8-ui-2781.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui kernel-boot-options-snap-2-8-ui-2781.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-9-cli-2782.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli kernel-boot-options-snap-2-9-cli-2782.md
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-9-ui-2783.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui kernel-boot-options-snap-2-9-ui-2783.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2789 2789
	cd $(DISC) &&\
	cp -p kernel-boot-options-deb-2-9-ui-2789.md kernel-boot-options.md

#l

$(DISC)/language-details-contributing-to-maas-docs.md: $(SRC)/language-details-contributing-to-maas-docs.md
	cp $(SRC)/language-details-contributing-to-maas-docs.md $(MODWD)/language-details-contributing-to-maas-docs-745.md
	cd $(MODWD) &&\
	xpub push $(DISC) language-details-contributing-to-maas-docs-745.md
	cd $(DISC) &&\
	xpub pull $(DISC) 745 745
	cd $(DISC) &&\
	cp -p language-details-contributing-to-maas-docs-745.md language-details-contributing-to-maas-docs.md

$(DISC)/local-image-mirror.md: $(SRC)/local-image-mirror.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-7-cli-2808.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli local-image-mirror-deb-2-7-cli-2808.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-7-ui-2809.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui local-image-mirror-deb-2-7-ui-2809.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-8-cli-2810.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli local-image-mirror-deb-2-8-cli-2810.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-8-ui-2811.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui local-image-mirror-deb-2-8-ui-2811.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-9-cli-2812.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli local-image-mirror-deb-2-9-cli-2812.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-9-ui-2813.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui local-image-mirror-deb-2-9-ui-2813.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-7-cli-2802.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli local-image-mirror-snap-2-7-cli-2802.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-7-ui-2803.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui local-image-mirror-snap-2-7-ui-2803.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-8-cli-2804.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli local-image-mirror-snap-2-8-cli-2804.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-8-ui-2805.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui local-image-mirror-snap-2-8-ui-2805.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-9-cli-2806.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli local-image-mirror-snap-2-9-cli-2806.md
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-9-ui-2807.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui local-image-mirror-snap-2-9-ui-2807.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2813 2813
	cd $(DISC) &&\
	cp -p local-image-mirror-deb-2-9-ui-2813.md local-image-mirror.md

#m

$(DISC)/maas-cli.md: $(SRC)/maas-cli.md
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-802.md
	cd $(MODWD) &&\
	xpub push $(DISC) maas-cli-802.md
	cd $(DISC) &&\
	xpub pull $(DISC) 802 802
	cd $(DISC) &&\
	cp -p maas-cli-802.md maas-cli.md
 
$(DISC)/maas-communication.md: $(SRC)/maas-communication.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-7-cli-2832.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-communication-deb-2-7-cli-2832.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-7-ui-2833.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-communication-deb-2-7-ui-2833.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-8-cli-2834.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-communication-deb-2-8-cli-2834.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-8-ui-2835.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-communication-deb-2-8-ui-2835.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-9-cli-2836.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-communication-deb-2-9-cli-2836.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-9-ui-2837.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-communication-deb-2-9-ui-2837.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-7-cli-2826.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-communication-snap-2-7-cli-2826.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-7-ui-2827.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-communication-snap-2-7-ui-2827.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-8-cli-2828.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-communication-snap-2-8-cli-2828.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-8-ui-2829.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-communication-snap-2-8-ui-2829.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-9-cli-2830.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-communication-snap-2-9-cli-2830.md
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-9-ui-2831.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-communication-snap-2-9-ui-2831.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2837 2837
	cd $(DISC) &&\
	cp -p maas-communication-deb-2-9-ui-2837.md maas-communication.md
 
$(DISC)/maas-documentation.md: $(SRC)/maas-documentation.md
	cp $(SCRP)/strip-navigation.sh $(MODWD)
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-25.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-documentation-25.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-7-cli-2844.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-7-cli-2844.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-documentation-deb-2-7-cli-2844.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-7-ui-2845.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-7-ui-2845.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-documentation-deb-2-7-ui-2845.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-8-cli-2846.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-8-cli-2846.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-documentation-deb-2-8-cli-2846.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-8-ui-2847.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-8-ui-2847.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-documentation-deb-2-8-ui-2847.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-9-cli-2848.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-9-cli-2848.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-documentation-deb-2-9-cli-2848.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-9-ui-2849.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-9-ui-2849.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-documentation-deb-2-9-ui-2849.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-7-cli-2838.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-7-cli-2838.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-documentation-snap-2-7-cli-2838.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-7-ui-2839.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-7-ui-2839.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-documentation-snap-2-7-ui-2839.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-8-cli-2840.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-8-cli-2840.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-documentation-snap-2-8-cli-2840.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-8-ui-2841.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-8-ui-2841.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-documentation-snap-2-8-ui-2841.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-9-cli-2842.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-9-cli-2842.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-documentation-snap-2-9-cli-2842.md
	cd $(DISC) &&\
	xpub pull $(DISC) 25 25
	cd $(DISC) &&\
	cp -p maas-documentation-25.md maas-documentation.md

$(DISC)/maas-image-builder.md: $(SRC)/maas-image-builder.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-7-cli-2856.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-image-builder-deb-2-7-cli-2856.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-7-ui-2857.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-image-builder-deb-2-7-ui-2857.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-8-cli-2858.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-image-builder-deb-2-8-cli-2858.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-8-ui-2859.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-image-builder-deb-2-8-ui-2859.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-9-cli-2860.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-image-builder-deb-2-9-cli-2860.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-9-ui-2861.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-image-builder-deb-2-9-ui-2861.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-7-cli-2850.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-image-builder-snap-2-7-cli-2850.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-7-ui-2851.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-image-builder-snap-2-7-ui-2851.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-8-cli-2852.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-image-builder-snap-2-8-cli-2852.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-8-ui-2853.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-image-builder-snap-2-8-ui-2853.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-9-cli-2854.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-image-builder-snap-2-9-cli-2854.md
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-9-ui-2855.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-image-builder-snap-2-9-ui-2855.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2861 2861
	cd $(DISC) &&\
	cp -p maas-image-builder-deb-2-9-ui-2861.md maas-image-builder.md
 
$(DISC)/maas-installation.md: $(SRC)/maas-installation.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-7-cli-3324.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-installation-deb-2-7-cli-3324.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-7-ui-3325.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-installation-deb-2-7-ui-3325.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-8-cli-3326.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-installation-deb-2-8-cli-3326.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-8-ui-3327.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-installation-deb-2-8-ui-3327.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-9-cli-3328.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-installation-deb-2-9-cli-3328.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-9-ui-3329.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-installation-deb-2-9-ui-3329.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-7-cli-3318.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-installation-snap-2-7-cli-3318.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-7-ui-3319.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-installation-snap-2-7-ui-3319.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-8-cli-3320.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-installation-snap-2-8-cli-3320.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-8-ui-3321.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-installation-snap-2-8-ui-3321.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-9-cli-3322.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-installation-snap-2-9-cli-3322.md
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-9-ui-3323.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-installation-snap-2-9-ui-3323.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3329 3329
	cd $(DISC) &&\
	cp -p maas-installation-deb-2-9-ui-3329.md maas-installation.md

$(DISC)/maas-logging.md: $(SRC)/maas-logging.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-7-cli-2868.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-logging-deb-2-7-cli-2868.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-7-ui-2869.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-logging-deb-2-7-ui-2869.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-8-cli-2870.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-logging-deb-2-8-cli-2870.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-8-ui-2871.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-logging-deb-2-8-ui-2871.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-9-cli-2872.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-logging-deb-2-9-cli-2872.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-9-ui-2873.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-logging-deb-2-9-ui-2873.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-7-cli-2862.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-logging-snap-2-7-cli-2862.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-7-ui-2863.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-logging-snap-2-7-ui-2863.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-8-cli-2864.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-logging-snap-2-8-cli-2864.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-8-ui-2865.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-logging-snap-2-8-ui-2865.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-9-cli-2866.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-logging-snap-2-9-cli-2866.md
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-9-ui-2867.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-logging-snap-2-9-ui-2867.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2873 2873
	cd $(DISC) &&\
	cp -p maas-logging-deb-2-9-ui-2873.md maas-logging.md
 
$(DISC)/maas-requirements.md: $(SRC)/maas-requirements.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-7-cli-2880.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-requirements-deb-2-7-cli-2880.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-7-ui-2881.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-requirements-deb-2-7-ui-2881.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-8-cli-2882.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-requirements-deb-2-8-cli-2882.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-8-ui-2883.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-requirements-deb-2-8-ui-2883.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-9-cli-2884.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-requirements-deb-2-9-cli-2884.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-9-ui-2885.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-requirements-deb-2-9-ui-2885.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-7-cli-2874.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-requirements-snap-2-7-cli-2874.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-7-ui-2875.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-requirements-snap-2-7-ui-2875.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-8-cli-2876.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-requirements-snap-2-8-cli-2876.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-8-ui-2877.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-requirements-snap-2-8-ui-2877.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-9-cli-2878.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-requirements-snap-2-9-cli-2878.md
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-9-ui-2879.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-requirements-snap-2-9-ui-2879.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2885 2885
	cd $(DISC) &&\
	cp -p maas-requirements-deb-2-9-ui-2885.md maas-requirements.md

$(DISC)/maas-tags.md: $(SRC)/maas-tags.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-deb-2-7-cli-2892.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-tags-deb-2-7-cli-2892.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-deb-2-7-ui-2893.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-tags-deb-2-7-ui-2893.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-deb-2-8-cli-2894.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-tags-deb-2-8-cli-2894.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-deb-2-8-ui-2895.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-tags-deb-2-8-ui-2895.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-deb-2-9-cli-2896.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-tags-deb-2-9-cli-2896.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-deb-2-9-ui-2897.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-tags-deb-2-9-ui-2897.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-snap-2-7-cli-2886.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-tags-snap-2-7-cli-2886.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-snap-2-7-ui-2887.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-tags-snap-2-7-ui-2887.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-snap-2-8-cli-2888.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-tags-snap-2-8-cli-2888.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-snap-2-8-ui-2889.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-tags-snap-2-8-ui-2889.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-snap-2-9-cli-2890.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-tags-snap-2-9-cli-2890.md
	cp $(SRC)/maas-tags.md $(MODWD)/maas-tags-snap-2-9-ui-2891.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-tags-snap-2-9-ui-2891.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2897 2897
	cd $(DISC) &&\
	cp -p maas-tags-deb-2-9-ui-2897.md maas-tags.md
 
# $(DISC)/machine-logs.md: $(SRC)/machine-logs.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-7-cli-3448.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-7-cli machine-logs-deb-2-7-cli-3448.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-7-ui-3449.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-7-ui machine-logs-deb-2-7-ui-3449.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-8-cli-3450.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-8-cli machine-logs-deb-2-8-cli-3450.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-8-ui-3451.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-8-ui machine-logs-deb-2-8-ui-3451.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-9-cli-3453.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-9-cli machine-logs-deb-2-9-cli-3453.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-9-ui-3452.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-9-ui machine-logs-deb-2-9-ui-3452.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-7-cli-3442.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-7-cli machine-logs-snap-2-7-cli-3442.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-7-ui-3443.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-7-ui machine-logs-snap-2-7-ui-3443.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-8-cli-3444.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-8-cli machine-logs-snap-2-8-cli-3444.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-8-ui-3445.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-8-ui machine-logs-snap-2-8-ui-3445.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-9-cli-3446.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-9-cli machine-logs-snap-2-9-cli-3446.md
# 	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-9-ui-3447.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-9-ui machine-logs-snap-2-9-ui-3447.md
# 	cd $(DISC) &&\
# 	xpub pull $(DISC) 3453 3453
# 	cd $(DISC) &&\
# 	cp -p machine-logs-deb-2-9-ui-3452.md machine-logs.md

$(DISC)/machines.md: $(SRC)/machines.md
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-7-cli-2736.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli machines-deb-2-7-cli-2736.md
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-7-ui-2737.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui machines-deb-2-7-ui-2737.md
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-8-cli-2738.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli machines-deb-2-8-cli-2738.md
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-8-ui-2739.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui machines-deb-2-8-ui-2739.md
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-9-cli-2740.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli machines-deb-2-9-cli-2740.md
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-9-ui-2741.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui machines-deb-2-9-ui-2741.md
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-7-cli-2730.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli machines-snap-2-7-cli-2730.md
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-7-ui-2731.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui machines-snap-2-7-ui-2731.md
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-8-cli-2732.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli machines-snap-2-8-cli-2732.md
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-8-ui-2733.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui machines-snap-2-8-ui-2733.md
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-9-cli-2734.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli machines-snap-2-9-cli-2734.md
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-9-ui-2735.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui machines-snap-2-9-ui-2735.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2741 2741
	cd $(DISC) &&\
	cp -p machines-deb-2-9-ui-2741.md machines.md
 
$(DISC)/managing-dhcp.md: $(SRC)/managing-dhcp.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-7-cli-2904.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli managing-dhcp-deb-2-7-cli-2904.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-7-ui-2905.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui managing-dhcp-deb-2-7-ui-2905.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-8-cli-2906.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli managing-dhcp-deb-2-8-cli-2906.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-8-ui-2907.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui managing-dhcp-deb-2-8-ui-2907.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-9-cli-2908.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli managing-dhcp-deb-2-9-cli-2908.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-9-ui-2909.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui managing-dhcp-deb-2-9-ui-2909.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-7-cli-2898.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli managing-dhcp-snap-2-7-cli-2898.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-7-ui-2899.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui managing-dhcp-snap-2-7-ui-2899.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-8-cli-2900.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli managing-dhcp-snap-2-8-cli-2900.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-8-ui-2901.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui managing-dhcp-snap-2-8-ui-2901.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-9-cli-2902.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli managing-dhcp-snap-2-9-cli-2902.md
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-9-ui-2903.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui managing-dhcp-snap-2-9-ui-2903.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2909 2909
	cd $(DISC) &&\
	cp -p managing-dhcp-deb-2-9-ui-2909.md managing-dhcp.md
 
$(DISC)/managing-stp.md: $(SRC)/managing-stp.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-7-cli-2916.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli managing-stp-deb-2-7-cli-2916.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-7-ui-2917.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui managing-stp-deb-2-7-ui-2917.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-8-cli-2918.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli managing-stp-deb-2-8-cli-2918.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-8-ui-2919.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui managing-stp-deb-2-8-ui-2919.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-9-cli-2920.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli managing-stp-deb-2-9-cli-2920.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-9-ui-2921.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui managing-stp-deb-2-9-ui-2921.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-7-cli-2910.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli managing-stp-snap-2-7-cli-2910.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-7-ui-2911.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui managing-stp-snap-2-7-ui-2911.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-8-cli-2912.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli managing-stp-snap-2-8-cli-2912.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-8-ui-2913.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui managing-stp-snap-2-8-ui-2913.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-9-cli-2914.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli managing-stp-snap-2-9-cli-2914.md
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-9-ui-2915.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui managing-stp-snap-2-9-ui-2915.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2921 2921
	cd $(DISC) &&\
	cp -p managing-stp-deb-2-9-ui-2921.md managing-stp.md

#n

$(DISC)/network-discovery.md: $(SRC)/network-discovery.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-7-cli-2928.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli network-discovery-deb-2-7-cli-2928.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-7-ui-2929.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui network-discovery-deb-2-7-ui-2929.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-8-cli-2930.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli network-discovery-deb-2-8-cli-2930.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-8-ui-2931.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui network-discovery-deb-2-8-ui-2931.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-9-cli-2932.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli network-discovery-deb-2-9-cli-2932.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-9-ui-2933.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui network-discovery-deb-2-9-ui-2933.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-7-cli-2922.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli network-discovery-snap-2-7-cli-2922.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-7-ui-2923.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui network-discovery-snap-2-7-ui-2923.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-8-cli-2924.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli network-discovery-snap-2-8-cli-2924.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-8-ui-2925.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui network-discovery-snap-2-8-ui-2925.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-9-cli-2926.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli network-discovery-snap-2-9-cli-2926.md
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-9-ui-2927.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui network-discovery-snap-2-9-ui-2927.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2933 2933
	cd $(DISC) &&\
	cp -p network-discovery-deb-2-9-ui-2933.md network-discovery.md
 
$(DISC)/networking.md: $(SRC)/networking.md
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-7-cli-2952.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli networking-deb-2-7-cli-2952.md
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-7-ui-2953.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui networking-deb-2-7-ui-2953.md
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-8-cli-2954.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli networking-deb-2-8-cli-2954.md
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-8-ui-2955.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui networking-deb-2-8-ui-2955.md
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-9-cli-2956.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli networking-deb-2-9-cli-2956.md
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-9-ui-2957.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui networking-deb-2-9-ui-2957.md
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-7-cli-2946.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli networking-snap-2-7-cli-2946.md
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-7-ui-2947.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui networking-snap-2-7-ui-2947.md
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-8-cli-2948.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli networking-snap-2-8-cli-2948.md
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-8-ui-2949.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui networking-snap-2-8-ui-2949.md
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-9-cli-2950.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli networking-snap-2-9-cli-2950.md
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-9-ui-2951.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui networking-snap-2-9-ui-2951.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2957 2957
	cd $(DISC) &&\
	cp -p networking-deb-2-9-ui-2957.md networking.md
 
$(DISC)/network-testing.md: $(SRC)/network-testing.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-7-cli-2940.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli network-testing-deb-2-7-cli-2940.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-7-ui-2941.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui network-testing-deb-2-7-ui-2941.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-8-cli-2942.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli network-testing-deb-2-8-cli-2942.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-8-ui-2943.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui network-testing-deb-2-8-ui-2943.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-9-cli-2944.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli network-testing-deb-2-9-cli-2944.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-9-ui-2945.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui network-testing-deb-2-9-ui-2945.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-7-cli-2934.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli network-testing-snap-2-7-cli-2934.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-7-ui-2935.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui network-testing-snap-2-7-ui-2935.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-8-cli-2936.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli network-testing-snap-2-8-cli-2936.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-8-ui-2937.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui network-testing-snap-2-8-ui-2937.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-9-cli-2938.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli network-testing-snap-2-9-cli-2938.md
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-9-ui-2939.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui network-testing-snap-2-9-ui-2939.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2945 2945
	cd $(DISC) &&\
	cp -p network-testing-deb-2-9-ui-2945.md network-testing.md
 
$(DISC)/ntp-services.md: $(SRC)/ntp-services.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-7-cli-2964.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli ntp-services-deb-2-7-cli-2964.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-7-ui-2965.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui ntp-services-deb-2-7-ui-2965.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-8-cli-2966.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli ntp-services-deb-2-8-cli-2966.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-8-ui-2967.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui ntp-services-deb-2-8-ui-2967.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-9-cli-2968.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli ntp-services-deb-2-9-cli-2968.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-9-ui-2969.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui ntp-services-deb-2-9-ui-2969.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-7-cli-2958.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli ntp-services-snap-2-7-cli-2958.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-7-ui-2959.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui ntp-services-snap-2-7-ui-2959.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-8-cli-2960.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli ntp-services-snap-2-8-cli-2960.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-8-ui-2961.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui ntp-services-snap-2-8-ui-2961.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-9-cli-2962.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli ntp-services-snap-2-9-cli-2962.md
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-9-ui-2963.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui ntp-services-snap-2-9-ui-2963.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2969 2969
	cd $(DISC) &&\
	cp -p ntp-services-deb-2-9-ui-2969.md ntp-services.md

#p

$(DISC)/package-repositories.md: $(SRC)/package-repositories.md
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-7-cli-2976.md
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-7-ui-2977.md
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-8-cli-2978.md
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-8-ui-2979.md
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-9-cli-2980.md
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-9-ui-2981.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli package-repositories-deb-2-7-cli-2976.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui package-repositories-deb-2-7-ui-2977.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli package-repositories-deb-2-8-cli-2978.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui package-repositories-deb-2-8-ui-2979.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli package-repositories-deb-2-9-cli-2980.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui package-repositories-deb-2-9-ui-2981.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2993 2993
	cd $(DISC) &&\
	cp -p package-repositories.md package-deb-2-9-ui-repositories.md

$(DISC)/partitions.md: $(SRC)/partitions.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-7-cli-2988.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli partitions-deb-2-7-cli-2988.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-7-ui-2989.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui partitions-deb-2-7-ui-2989.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-8-cli-2990.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli partitions-deb-2-8-cli-2990.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-8-ui-2991.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui partitions-deb-2-8-ui-2991.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-9-cli-2992.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli partitions-deb-2-9-cli-2992.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-9-ui-2993.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui partitions-deb-2-9-ui-2993.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-7-cli-2982.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli partitions-snap-2-7-cli-2982.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-7-ui-2983.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui partitions-snap-2-7-ui-2983.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-8-cli-2984.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli partitions-snap-2-8-cli-2984.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-8-ui-2985.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui partitions-snap-2-8-ui-2985.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-9-cli-2986.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli partitions-snap-2-9-cli-2986.md
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-9-ui-2987.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui partitions-snap-2-9-ui-2987.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2993 2993
	cd $(DISC) &&\
	cp -p partitions-deb-2-9-ui-2993.md partitions.md
 
$(DISC)/postgresql-ha-hot-standby.md: $(SRC)/postgresql-ha-hot-standby.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-7-cli-3000.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli postgresql-ha-hot-standby-deb-2-7-cli-3000.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-7-ui-3001.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui postgresql-ha-hot-standby-deb-2-7-ui-3001.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-8-cli-3002.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli postgresql-ha-hot-standby-deb-2-8-cli-3002.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-8-ui-3003.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui postgresql-ha-hot-standby-deb-2-8-ui-3003.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-9-cli-3004.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli postgresql-ha-hot-standby-deb-2-9-cli-3004.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-9-ui-3005.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui postgresql-ha-hot-standby-deb-2-9-ui-3005.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-7-cli-2994.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli postgresql-ha-hot-standby-snap-2-7-cli-2994.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-7-ui-2995.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui postgresql-ha-hot-standby-snap-2-7-ui-2995.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-8-cli-2996.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli postgresql-ha-hot-standby-snap-2-8-cli-2996.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-8-ui-2997.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui postgresql-ha-hot-standby-snap-2-8-ui-2997.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-9-cli-2998.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli postgresql-ha-hot-standby-snap-2-9-cli-2998.md
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-9-ui-2999.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui postgresql-ha-hot-standby-snap-2-9-ui-2999.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3005 3005
	cd $(DISC) &&\
	cp -p postgresql-ha-hot-standby-deb-2-9-ui-3005.md postgresql-ha-hot-standby.md
 
$(DISC)/power-management.md: $(SRC)/power-management.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-7-cli-3012.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli power-management-deb-2-7-cli-3012.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-7-ui-3013.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui power-management-deb-2-7-ui-3013.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-8-cli-3014.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli power-management-deb-2-8-cli-3014.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-8-ui-3015.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui power-management-deb-2-8-ui-3015.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-9-cli-3016.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli power-management-deb-2-9-cli-3016.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-9-ui-3017.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui power-management-deb-2-9-ui-3017.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-7-cli-3006.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli power-management-snap-2-7-cli-3006.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-7-ui-3007.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui power-management-snap-2-7-ui-3007.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-8-cli-3008.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli power-management-snap-2-8-cli-3008.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-8-ui-3009.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui power-management-snap-2-8-ui-3009.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-9-cli-3010.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli power-management-snap-2-9-cli-3010.md
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-9-ui-3011.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui power-management-snap-2-9-ui-3011.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3017 3017
	cd $(DISC) &&\
	cp -p power-management-deb-2-9-ui-3017.md power-management.md
 
$(DISC)/prometheus-metrics.md: $(SRC)/prometheus-metrics.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-7-cli-3024.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli prometheus-metrics-deb-2-7-cli-3024.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-7-ui-3025.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui prometheus-metrics-deb-2-7-ui-3025.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-8-cli-3026.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli prometheus-metrics-deb-2-8-cli-3026.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-8-ui-3027.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui prometheus-metrics-deb-2-8-ui-3027.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-9-cli-3028.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli prometheus-metrics-deb-2-9-cli-3028.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-9-ui-3029.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui prometheus-metrics-deb-2-9-ui-3029.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-7-cli-3018.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli prometheus-metrics-snap-2-7-cli-3018.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-7-ui-3019.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui prometheus-metrics-snap-2-7-ui-3019.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-8-cli-3020.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli prometheus-metrics-snap-2-8-cli-3020.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-8-ui-3021.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui prometheus-metrics-snap-2-8-ui-3021.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-9-cli-3022.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli prometheus-metrics-snap-2-9-cli-3022.md
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-9-ui-3023.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui prometheus-metrics-snap-2-9-ui-3023.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3029 3029
	cd $(DISC) &&\
	cp -p prometheus-metrics-deb-2-9-ui-3029.md prometheus-metrics.md
 
$(DISC)/proxy.md: $(SRC)/proxy.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-7-cli-3036.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli proxy-deb-2-7-cli-3036.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-7-ui-3037.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui proxy-deb-2-7-ui-3037.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-8-cli-3038.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli proxy-deb-2-8-cli-3038.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-8-ui-3039.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui proxy-deb-2-8-ui-3039.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-9-cli-3040.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli proxy-deb-2-9-cli-3040.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-9-ui-3041.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui proxy-deb-2-9-ui-3041.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-7-cli-3030.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli proxy-snap-2-7-cli-3030.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-7-ui-3031.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui proxy-snap-2-7-ui-3031.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-8-cli-3032.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli proxy-snap-2-8-cli-3032.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-8-ui-3033.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui proxy-snap-2-8-ui-3033.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-9-cli-3034.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli proxy-snap-2-9-cli-3034.md
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-9-ui-3035.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui proxy-snap-2-9-ui-3035.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3041 3041
	cd $(DISC) &&\
	cp -p proxy-deb-2-9-ui-3041.md proxy.md

$(DISC)/proxy-log.md: $(SRC)/proxy-log.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-7-cli-3460.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli proxy-log-deb-2-7-cli-3460.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-7-ui-3461.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui proxy-log-deb-2-7-ui-3461.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-8-cli-3462.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli proxy-log-deb-2-8-cli-3462.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-8-ui-3463.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui proxy-log-deb-2-8-ui-3463.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-9-cli-3465.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli proxy-log-deb-2-9-cli-3465.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-9-ui-3464.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui proxy-log-deb-2-9-ui-3464.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-7-cli-3454.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli proxy-log-snap-2-7-cli-3454.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-7-ui-3455.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui proxy-log-snap-2-7-ui-3455.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-8-cli-3456.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli proxy-log-snap-2-8-cli-3456.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-8-ui-3457.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui proxy-log-snap-2-8-ui-3457.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-9-cli-3458.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli proxy-log-snap-2-9-cli-3458.md
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-9-ui-3459.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui proxy-log-snap-2-9-ui-3459.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3465 3465
	cd $(DISC) &&\
	cp -p proxy-log-deb-2-9-ui-3465.md proxy-log.md

$(DISC)/python-api-client.md: $(SRC)/python-api-client.md
	cp $(SRC)/python-api-client.md $(MODWD)/python-api-client-810.md
	cd $(MODWD) &&\
	xpub push $(DISC) python-api-client-810.md
	cd $(DISC) &&\
	xpub pull $(DISC) 810 810
	cd $(DISC) &&\
	cp -p python-api-client-810.md python-api-client.md

#r

$(DISC)/rack-controllers.md: $(SRC)/rack-controllers.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-7-cli-3054.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli rack-controllers-snap-2-7-cli-3054.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-7-ui-3055.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui rack-controllers-snap-2-7-ui-3055.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-8-cli-3056.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli rack-controllers-snap-2-8-cli-3056.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-8-ui-3057.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui rack-controllers-snap-2-8-ui-3057.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-9-cli-3058.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli rack-controllers-snap-2-9-cli-3058.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-9-ui-3059.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui rack-controllers-snap-2-9-ui-3059.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-7-cli-3060.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli rack-controllers-deb-2-7-cli-3060.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-7-ui-3061.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui rack-controllers-deb-2-7-ui-3061.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-8-cli-3062.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli rack-controllers-deb-2-8-cli-3062.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-8-ui-3063.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui rack-controllers-deb-2-8-ui-3063.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-9-cli-3064.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli rack-controllers-deb-2-9-cli-3064.md
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-9-ui-3065.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui rack-controllers-deb-2-9-ui-3065.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3065 3065
	cd $(DISC) &&\
	cp -p rack-controllers-deb-2-9-ui-3065.md rack-controllers.md

$(DISC)/region-controllers.md: $(SRC)/region-controllers.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-7-cli-3072.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli region-controllers-deb-2-7-cli-3072.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-7-ui-3073.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui region-controllers-deb-2-7-ui-3073.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-8-cli-3074.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli region-controllers-deb-2-8-cli-3074.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-8-ui-3075.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui region-controllers-deb-2-8-ui-3075.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-9-cli-3076.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli region-controllers-deb-2-9-cli-3076.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-9-ui-3077.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui region-controllers-deb-2-9-ui-3077.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-7-cli-3066.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli region-controllers-snap-2-7-cli-3066.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-7-ui-3067.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui region-controllers-snap-2-7-ui-3067.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-8-cli-3068.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli region-controllers-snap-2-8-cli-3068.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-8-ui-3069.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui region-controllers-snap-2-8-ui-3069.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-9-cli-3070.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli region-controllers-snap-2-9-cli-3070.md
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-9-ui-3071.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui region-controllers-snap-2-9-ui-3071.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3077 3077
	cd $(DISC) &&\
	cp -p region-controllers-deb-2-9-ui-3077.md region-controllers.md
 
$(DISC)/resource-pools.md: $(SRC)/resource-pools.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-7-cli-3084.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli resource-pools-deb-2-7-cli-3084.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-7-ui-3085.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui resource-pools-deb-2-7-ui-3085.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-8-cli-3086.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli resource-pools-deb-2-8-cli-3086.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-8-ui-3087.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui resource-pools-deb-2-8-ui-3087.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-9-cli-3088.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli resource-pools-deb-2-9-cli-3088.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-9-ui-3089.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui resource-pools-deb-2-9-ui-3089.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-7-cli-3078.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli resource-pools-snap-2-7-cli-3078.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-7-ui-3079.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui resource-pools-snap-2-7-ui-3079.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-8-cli-3080.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli resource-pools-snap-2-8-cli-3080.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-8-ui-3081.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui resource-pools-snap-2-8-ui-3081.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-9-cli-3082.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli resource-pools-snap-2-9-cli-3082.md
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-9-ui-3083.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui resource-pools-snap-2-9-ui-3083.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3089 3089
	cd $(DISC) &&\
	cp -p resource-pools-deb-2-9-ui-3089.md resource-pools.md

#s

$(DISC)/select-and-import-images.md: $(SRC)/select-and-import-images.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-7-cli-3096.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli select-and-import-images-deb-2-7-cli-3096.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-7-ui-3097.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui select-and-import-images-deb-2-7-ui-3097.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-8-cli-3098.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli select-and-import-images-deb-2-8-cli-3098.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-8-ui-3099.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui select-and-import-images-deb-2-8-ui-3099.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-9-cli-3100.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli select-and-import-images-deb-2-9-cli-3100.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-9-ui-3101.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui select-and-import-images-deb-2-9-ui-3101.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-7-cli-3090.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli select-and-import-images-snap-2-7-cli-3090.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-7-ui-3091.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui select-and-import-images-snap-2-7-ui-3091.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-8-cli-3092.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli select-and-import-images-snap-2-8-cli-3092.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-8-ui-3093.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui select-and-import-images-snap-2-8-ui-3093.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-9-cli-3094.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli select-and-import-images-snap-2-9-cli-3094.md
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-9-ui-3095.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui select-and-import-images-snap-2-9-ui-3095.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3101 3101
	cd $(DISC) &&\
	cp -p select-and-import-images-deb-2-9-ui-3101.md select-and-import-images.md
 
$(DISC)/storage.md: $(SRC)/storage.md
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-7-cli-3108.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli storage-deb-2-7-cli-3108.md
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-7-ui-3109.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui storage-deb-2-7-ui-3109.md
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-8-cli-3110.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli storage-deb-2-8-cli-3110.md
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-8-ui-3111.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui storage-deb-2-8-ui-3111.md
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-9-cli-3112.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli storage-deb-2-9-cli-3112.md
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-9-ui-3113.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui storage-deb-2-9-ui-3113.md
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-7-cli-3102.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli storage-snap-2-7-cli-3102.md
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-7-ui-3103.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui storage-snap-2-7-ui-3103.md
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-8-cli-3104.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli storage-snap-2-8-cli-3104.md
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-8-ui-3105.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui storage-snap-2-8-ui-3105.md
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-9-cli-3106.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli storage-snap-2-9-cli-3106.md
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-9-ui-3107.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui storage-snap-2-9-ui-3107.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3113 3113
	cd $(DISC) &&\
	cp -p storage-deb-2-9-ui-3113.md storage.md

$(DISC)/subnet-management.md: $(SRC)/subnet-management.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-7-cli-3120.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli subnet-management-deb-2-7-cli-3120.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-7-ui-3121.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui subnet-management-deb-2-7-ui-3121.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-8-cli-3122.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli subnet-management-deb-2-8-cli-3122.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-8-ui-3123.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui subnet-management-deb-2-8-ui-3123.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-9-cli-3124.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli subnet-management-deb-2-9-cli-3124.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-9-ui-3125.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui subnet-management-deb-2-9-ui-3125.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-7-cli-3114.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli subnet-management-snap-2-7-cli-3114.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-7-ui-3115.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui subnet-management-snap-2-7-ui-3115.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-8-cli-3116.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli subnet-management-snap-2-8-cli-3116.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-8-ui-3117.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui subnet-management-snap-2-8-ui-3117.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-9-cli-3118.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli subnet-management-snap-2-9-cli-3118.md
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-9-ui-3119.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui subnet-management-snap-2-9-ui-3119.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3125 3125
	cd $(DISC) &&\
	cp -p subnet-management-deb-2-9-ui-3125.md subnet-management.md

# $(DISC)/supported-versions.md: $(SRC)/supported-versions.md
# 	cp $(SRC)/subnet-management.md $(MODWD)/supported-versions-3771.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) supported-versions-3771.md
# 	cd $(DISC) &&\
# 	xpub pull $(DISC) 3771 3771
# 	cd $(DISC) &&\
# 	cp -p supported-versions-3771.md supported-versions.md
  
#t

$(DISC)/test-logs.md: $(SRC)/test-logs.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-7-cli-3132.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli test-logs-deb-2-7-cli-3132.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-7-ui-3133.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui test-logs-deb-2-7-ui-3133.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-8-cli-3134.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli test-logs-deb-2-8-cli-3134.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-8-ui-3135.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui test-logs-deb-2-8-ui-3135.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-9-cli-3136.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli test-logs-deb-2-9-cli-3136.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-9-ui-3137.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui test-logs-deb-2-9-ui-3137.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-7-cli-3126.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli test-logs-snap-2-7-cli-3126.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-7-ui-3127.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui test-logs-snap-2-7-ui-3127.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-8-cli-3128.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli test-logs-snap-2-8-cli-3128.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-8-ui-3129.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui test-logs-snap-2-8-ui-3129.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-9-cli-3130.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli test-logs-snap-2-9-cli-3130.md
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-9-ui-3131.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui test-logs-snap-2-9-ui-3131.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3137 3137
	cd $(DISC) &&\
	cp -p test-logs-deb-2-9-ui-3137.md test-logs.md

$(DISC)/the-cli-cookbook.md: $(SRC)/the-cli-cookbook.md
	cp $(SRC)/the-cli-cookbook.md $(MODWD)/the-cli-cookbook-2218.md
	cd $(MODWD) &&\
	xpub push $(DISC) the-cli-cookbook-2218.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2218 2218
	cd $(DISC) &&\
	cp -p the-cli-cookbook-2218.md the-cli-cookbook.md
  
$(DISC)/tips-tricks-and-traps.md: $(SRC)/tips-tricks-and-traps.md
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-1506.md
	cd $(MODWD) &&\
	xpub push $(DISC) tips-tricks-and-traps-1506.md
	cd $(DISC) &&\
	xpub pull $(DISC) 1506 1506
	cd $(DISC) &&\
	cp -p tips-tricks-and-traps-1506.md tips-tricks-and-traps.md
 
$(DISC)/troubleshooting.md: $(SRC)/troubleshooting.md
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-837.md
	cd $(MODWD) &&\
	xpub push $(DISC) troubleshooting-837.md
	cd $(DISC) &&\
	xpub pull $(DISC) 837 837
	cd $(DISC) &&\
	cp -p troubleshooting-837.md troubleshooting.md
 
#u

$(DISC)/ubuntu-kernels.md: $(SRC)/ubuntu-kernels.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-7-cli-3180.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli ubuntu-kernels-deb-2-7-cli-3180.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-7-ui-3181.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui ubuntu-kernels-deb-2-7-ui-3181.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-8-cli-3182.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli ubuntu-kernels-deb-2-8-cli-3182.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-8-ui-3183.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui ubuntu-kernels-deb-2-8-ui-3183.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-9-cli-3184.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli ubuntu-kernels-deb-2-9-cli-3184.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-9-ui-3185.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui ubuntu-kernels-deb-2-9-ui-3185.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-7-cli-3174.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli ubuntu-kernels-snap-2-7-cli-3174.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-7-ui-3175.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui ubuntu-kernels-snap-2-7-ui-3175.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-8-cli-3176.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli ubuntu-kernels-snap-2-8-cli-3176.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-8-ui-3177.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui ubuntu-kernels-snap-2-8-ui-3177.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-9-cli-3178.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli ubuntu-kernels-snap-2-9-cli-3178.md
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-9-ui-3179.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui ubuntu-kernels-snap-2-9-ui-3179.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3185 3185
	cd $(DISC) &&\
	cp -p ubuntu-kernels-deb-2-9-ui-3185.md ubuntu-kernels.md
 
$(DISC)/upgrading-maas.md: $(SRC)/upgrading-maas.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-deb-2-7-cli-3192.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli upgrading-maas-deb-2-7-cli-3192.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-deb-2-7-ui-3193.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui upgrading-maas-deb-2-7-ui-3193.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-deb-2-8-cli-3194.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli upgrading-maas-deb-2-8-cli-3194.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-deb-2-8-ui-3195.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui upgrading-maas-deb-2-8-ui-3195.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-deb-2-9-cli-3196.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli upgrading-maas-deb-2-9-cli-3196.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-deb-2-9-ui-3197.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui upgrading-maas-deb-2-9-ui-3197.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-snap-2-7-cli-3186.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli upgrading-maas-snap-2-7-cli-3186.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-snap-2-7-ui-3187.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui upgrading-maas-snap-2-7-ui-3187.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-snap-2-8-cli-3188.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli upgrading-maas-snap-2-8-cli-3188.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-snap-2-8-ui-3189.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui upgrading-maas-snap-2-8-ui-3189.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-snap-2-9-cli-3190.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli upgrading-maas-snap-2-9-cli-3190.md
	cp $(SRC)/upgrading-maas.md $(MODWD)/upgrading-maas-snap-2-9-ui-3191.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui upgrading-maas-snap-2-9-ui-3191.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3197 3197
	cd $(DISC) &&\
	cp -p upgrading-maas-deb-2-9-ui-3197.md upgrading-maas.md

$(DISC)/user-accounts.md: $(SRC)/user-accounts.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-7-cli-3204.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli user-accounts-deb-2-7-cli-3204.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-7-ui-3205.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui user-accounts-deb-2-7-ui-3205.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-8-cli-3206.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli user-accounts-deb-2-8-cli-3206.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-8-ui-3207.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui user-accounts-deb-2-8-ui-3207.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-9-cli-3208.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli user-accounts-deb-2-9-cli-3208.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-9-ui-3209.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui user-accounts-deb-2-9-ui-3209.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-7-cli-3198.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli user-accounts-snap-2-7-cli-3198.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-7-ui-3199.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui user-accounts-snap-2-7-ui-3199.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-8-cli-3200.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli user-accounts-snap-2-8-cli-3200.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-8-ui-3201.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui user-accounts-snap-2-8-ui-3201.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-9-cli-3202.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli user-accounts-snap-2-9-cli-3202.md
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-9-ui-3203.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui user-accounts-snap-2-9-ui-3203.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3209 3209
	cd $(DISC) &&\
	cp -p user-accounts-deb-2-9-ui-3209.md user-accounts.md

$(DISC)/using-maas-in-an-air-gapped-environment.md: $(SRC)/using-maas-in-an-air-gapped-environment.md
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-3539.md
	cd $(MODWD) &&\
	xpub push $(DISC) using-maas-in-an-air-gapped-environment-3539.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3539 3539
	cd $(DISC) &&\
	cp -p using-maas-in-an-air-gapped-environment-3539.md using-maas-in-an-air-gapped-environment.md

$(DISC)/using-rbac-with-maas.md: $(SRC)/using-rbac-with-maas.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-7-cli-3592.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli using-rbac-with-maas-snap-2-7-cli-3592.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-7-ui-3593.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui using-rbac-with-maas-snap-2-7-ui-3593.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-8-cli-3594.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli using-rbac-with-maas-snap-2-8-cli-3594.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-8-ui-3595.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui using-rbac-with-maas-snap-2-8-ui-3595.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-9-cli-3596.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli using-rbac-with-maas-snap-2-9-cli-3596.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-9-ui-3597.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui using-rbac-with-maas-snap-2-9-ui-3597.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-7-cli-3598.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli using-rbac-with-maas-deb-2-7-cli-3598.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-7-ui-3599.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui using-rbac-with-maas-deb-2-7-ui-3599.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-8-cli-3600.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli using-rbac-with-maas-deb-2-8-cli-3600.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-8-ui-3601.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui using-rbac-with-maas-deb-2-8-ui-3601.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-9-cli-3602.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli using-rbac-with-maas-deb-2-9-cli-3602.md
	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-9-ui-3603.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui using-rbac-with-maas-deb-2-9-ui-3603.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3603 3603
	cd $(DISC) &&\
	cp -p using-rbac-with-maas-deb-2-9-ui-3603.md using-rbac-with-maas.md

#v

$(DISC)/vm-hosting.md: $(SRC)/vm-hosting.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-7-cli-2748.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli vm-hosting-deb-2-7-cli-2748.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-7-ui-2749.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui vm-hosting-deb-2-7-ui-2749.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-8-cli-2750.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli vm-hosting-deb-2-8-cli-2750.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-8-ui-2751.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui vm-hosting-deb-2-8-ui-2751.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-9-cli-2752.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli vm-hosting-deb-2-9-cli-2752.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-9-ui-2753.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui vm-hosting-deb-2-9-ui-2753.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-7-cli-2742.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli vm-hosting-snap-2-7-cli-2742.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-7-ui-2743.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui vm-hosting-snap-2-7-ui-2743.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-8-cli-2744.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli vm-hosting-snap-2-8-cli-2744.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-8-ui-2745.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui vm-hosting-snap-2-8-ui-2745.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-9-cli-2746.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli vm-hosting-snap-2-9-cli-2746.md
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-9-ui-2747.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui vm-hosting-snap-2-9-ui-2747.md
	cd $(DISC) &&\
	xpub pull $(DISC) 2753 2753
	cd $(DISC) &&\
	cp -p vm-hosting-deb-2-9-ui-2753.md vm-hosting.md
 
$(DISC)/vm-host-networking.md: $(SRC)/vm-host-networking.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-7-cli-3216.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli vm-host-networking-deb-2-7-cli-3216.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-7-ui-3217.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui vm-host-networking-deb-2-7-ui-3217.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-8-cli-3218.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli vm-host-networking-deb-2-8-cli-3218.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-8-ui-3219.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui vm-host-networking-deb-2-8-ui-3219.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-9-cli-3220.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli vm-host-networking-deb-2-9-cli-3220.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-9-ui-3221.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui vm-host-networking-deb-2-9-ui-3221.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-7-cli-3210.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli vm-host-networking-snap-2-7-cli-3210.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-7-ui-3211.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui vm-host-networking-snap-2-7-ui-3211.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-8-cli-3212.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli vm-host-networking-snap-2-8-cli-3212.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-8-ui-3213.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui vm-host-networking-snap-2-8-ui-3213.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-9-cli-3214.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli vm-host-networking-snap-2-9-cli-3214.md
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-9-ui-3215.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui vm-host-networking-snap-2-9-ui-3215.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3221 3221
	cd $(DISC) &&\
	cp -p vm-host-networking-deb-2-9-ui-3221.md vm-host-networking.md
 
$(DISC)/vm-host-storage-pools.md: $(SRC)/vm-host-storage-pools.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-7-cli-3228.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli vm-host-storage-pools-deb-2-7-cli-3228.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-7-ui-3229.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui vm-host-storage-pools-deb-2-7-ui-3229.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-8-cli-3230.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli vm-host-storage-pools-deb-2-8-cli-3230.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-8-ui-3231.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui vm-host-storage-pools-deb-2-8-ui-3231.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-9-cli-3232.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli vm-host-storage-pools-deb-2-9-cli-3232.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-9-ui-3233.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui vm-host-storage-pools-deb-2-9-ui-3233.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-7-cli-3222.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli vm-host-storage-pools-snap-2-7-cli-3222.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-7-ui-3223.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui vm-host-storage-pools-snap-2-7-ui-3223.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-8-cli-3224.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli vm-host-storage-pools-snap-2-8-cli-3224.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-8-ui-3225.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui vm-host-storage-pools-snap-2-8-ui-3225.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-9-cli-3226.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli vm-host-storage-pools-snap-2-9-cli-3226.md
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-9-ui-3227.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui vm-host-storage-pools-snap-2-9-ui-3227.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3233 3233
	cd $(DISC) &&\
	cp -p vm-host-storage-pools-deb-2-9-ui-3233.md vm-host-storage-pools.md
 
$(DISC)/vmware-images.md: $(SRC)/vmware-images.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-7-cli-3240.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli vmware-images-deb-2-7-cli-3240.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-7-ui-3241.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui vmware-images-deb-2-7-ui-3241.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-8-cli-3242.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli vmware-images-deb-2-8-cli-3242.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-8-ui-3243.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui vmware-images-deb-2-8-ui-3243.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-9-cli-3244.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli vmware-images-deb-2-9-cli-3244.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-9-ui-3245.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui vmware-images-deb-2-9-ui-3245.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-7-cli-3234.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli vmware-images-snap-2-7-cli-3234.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-7-ui-3235.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui vmware-images-snap-2-7-ui-3235.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-8-cli-3236.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli vmware-images-snap-2-8-cli-3236.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-8-ui-3237.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui vmware-images-snap-2-8-ui-3237.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-9-cli-3238.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli vmware-images-snap-2-9-cli-3238.md
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-9-ui-3239.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui vmware-images-snap-2-9-ui-3239.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3245 3245
	cd $(DISC) &&\
	cp -p vmware-images-deb-2-9-ui-3245.md vmware-images.md
 
$(DISC)/vmware-vmfs-datastores.md: $(SRC)/vmware-vmfs-datastores.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-7-cli-3252.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli vmware-vmfs-datastores-deb-2-7-cli-3252.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-7-ui-3253.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui vmware-vmfs-datastores-deb-2-7-ui-3253.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-8-cli-3254.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli vmware-vmfs-datastores-deb-2-8-cli-3254.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-8-ui-3255.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui vmware-vmfs-datastores-deb-2-8-ui-3255.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-9-cli-3256.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli vmware-vmfs-datastores-deb-2-9-cli-3256.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-9-ui-3257.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui vmware-vmfs-datastores-deb-2-9-ui-3257.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-7-cli-3246.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli vmware-vmfs-datastores-snap-2-7-cli-3246.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-7-ui-3247.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui vmware-vmfs-datastores-snap-2-7-ui-3247.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-8-cli-3248.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli vmware-vmfs-datastores-snap-2-8-cli-3248.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-8-ui-3249.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui vmware-vmfs-datastores-snap-2-8-ui-3249.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-9-cli-3250.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli vmware-vmfs-datastores-snap-2-9-cli-3250.md
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-9-ui-3251.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui vmware-vmfs-datastores-snap-2-9-ui-3251.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3257 3257
	cd $(DISC) &&\
	cp -p vmware-vmfs-datastores-deb-2-9-ui-3257.md vmware-vmfs-datastores.md


#w

$(DISC)/whats-new-in-maas.md: $(SRC)/whats-new-in-maas.md
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-2-7-3335.md
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-2-8-3334.md
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-2-9-3336.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui whats-new-in-maas-2-7-3335.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli whats-new-in-maas-2-8-3334.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli whats-new-in-maas-2-9-3336.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3336 3336
	cd $(DISC) &&\
	cp -p whats-new-in-maas-2-9-3336.md whats-new-in-maas.md

$(DISC)/writing-guide.md: $(SRC)/writing-guide.md
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-747.md
	cd $(MODWD) &&\
	xpub push $(DISC) writing-guide-747.md
	cd $(DISC) &&\
	xpub pull $(DISC) 747 747
	cd $(DISC) &&\
	cp -p writing-guide-747.md writing-guide.md
 
#z

$(DISC)/zone-examples.md: $(SRC)/zone-examples.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-7-cli-3276.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli zone-examples-deb-2-7-cli-3276.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-7-ui-3277.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui zone-examples-deb-2-7-ui-3277.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-8-cli-3278.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli zone-examples-deb-2-8-cli-3278.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-8-ui-3279.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui zone-examples-deb-2-8-ui-3279.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-9-cli-3280.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli zone-examples-deb-2-9-cli-3280.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-9-ui-3281.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui zone-examples-deb-2-9-ui-3281.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-7-cli-3270.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli zone-examples-snap-2-7-cli-3270.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-7-ui-3271.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui zone-examples-snap-2-7-ui-3271.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-8-cli-3272.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli zone-examples-snap-2-8-cli-3272.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-8-ui-3273.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui zone-examples-snap-2-8-ui-3273.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-9-cli-3274.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli zone-examples-snap-2-9-cli-3274.md
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-9-ui-3275.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui zone-examples-snap-2-9-ui-3275.md
	cd $(DISC) &&\
	xpub pull $(DISC) 3281 3281
	cd $(DISC) &&\
	cp -p zone-examples-deb-2-9-ui-3281.md zone-examples.md
 

# $(DISC)/supported-versions-3771.md: $(SRC)/supported-versions.md
#	chmod 644 originals/*
#	cp $(SRC)/supported-versions.md $(MODWD)/supported-versions-3771.md
#	xpub pull $(DISC) 3771 3771
#	cp $(SRC)/-p $(MODWD)/supported-versions-3771.md originals
#	rm supported-versions-3771.md
#	chmod 444 originals/*


