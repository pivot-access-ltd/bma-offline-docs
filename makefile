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
PROD_VSN := 3.0
PROD_TAG := 3-0
#
########################################################################
##     P A T H I N G   A N D   T A G G I N G   V A R I A B L E S      ##
########################################################################
#
# RAD versions
#
V29  := 2.9
V30 := 3.0
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
SRC := src
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
HTARG += $(HTML)/commissioning-and-hardware-testing-scripts.html
HTARG += $(HTML)/commissioning-logs.html
HTARG += $(HTML)/commission-machines.html
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
#HTARG += $(HTML)/maas-installation-technical-reference.html
#HTARG += $(HTML)/maas-installation-tutorial.html
HTARG += $(HTML)/maas-logging.html
HTARG += $(HTML)/maas-project-tutorial.html
HTARG += $(HTML)/maas-requirements.html
HTARG += $(HTML)/tags-and-annotations.html
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
HTARG += $(HTML)/report-a-bug.html
HTARG += $(HTML)/request-a-feature.html
HTARG += $(HTML)/resource-pools.html
HTARG += $(HTML)/select-and-import-images.html
HTARG += $(HTML)/storage.html
HTARG += $(HTML)/subnet-management.html
HTARG += $(HTML)/test-logs.html
HTARG += $(HTML)/tips-tricks-and-traps.html
HTARG += $(HTML)/troubleshooting.html
HTARG += $(HTML)/ubuntu-kernels.html
HTARG += $(HTML)/user-accounts.html
HTARG += $(HTML)/using-image-streams.html
HTARG += $(HTML)/maas-projects.html
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
#DTARG += $(HTML)/maas-installation-technical-reference.md
#DTARG += $(HTML)/maas-installation-tutorial.md
DTARG += $(DISC)/maas-logging.md
DTARG += $(DISC)/maas-project-tutorial.md
DTARG += $(DISC)/maas-requirements.md
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
DTARG += $(DISC)/report-a-bug.md
DTARG += $(DISC)/request-a-feature.md
DTARG += $(DISC)/resource-pools.md
DTARG += $(DISC)/select-and-import-images.md
DTARG += $(DISC)/storage.md
DTARG += $(DISC)/subnet-management.md
DTARG += $(DISC)/tags-and-annotations.md
DTARG += $(DISC)/test-logs.md
DTARG += $(DISC)/the-cli-cookbook.md
DTARG += $(DISC)/tips-tricks-and-traps.md
DTARG += $(DISC)/troubleshooting.md
DTARG += $(DISC)/ubuntu-kernels.md
DTARG += $(DISC)/user-accounts.md
DTARG += $(DISC)/using-image-streams.md
DTARG += $(DISC)/maas-projects.md
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
	mkdir -p $(STAGING)
	mkdir -p $(MODWD)
	# cp -p $(SRC)/maas-documentation.md $(SRC)/index.md
	cp $(SCRP)/strip-navigation.sh $(MODWD)
#
# pre-build-html
#
pre-build-html:
	@echo "\n******************************************"
	@echo "***          start HTML build          ***"
	@echo "******************************************"
	@echo "\n*** Running HTML pre-build recipe"
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
	cp $(STAGING)/$(SNAP)/$(PROD_VSN)/$(UI)/maas-documentation.html $(PROD_SNAP)/index.html
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
	cd $(MODWD) && sed -i "/|| 2.8/d" $(BASE)
	cd $(MODWD) && sed -i "/||2.8/d" $(BASE)
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
## deb 2.9 cli
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-9-cli-2272.md 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-9-cli about-maas-deb-2-9-cli-2272.md 
## deb 2.9 ui
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-9-ui-2273.md	 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-9-ui about-maas-deb-2-9-ui-2273.md  
## deb 3.0 cli
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-3-0-cli-3815.md 
	cd $(MODWD) &&\
	xpub push discourse -t deb-3-0-cli about-maas-deb-3-0-cli-3815.md 
## deb 3.0 ui
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-3-0-ui-3816.md	 
	cd $(MODWD) &&\
	xpub push discourse -t deb-3-0-ui about-maas-deb-3-0-ui-3816.md  
## snap 2.9 cli
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-9-cli-2266.md
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-9-cli about-maas-snap-2-9-cli-2266.md
## snap 2.9 ui
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-9-ui-2267.md 
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-9-ui about-maas-snap-2-9-ui-2267.md
## snap 3.0 cli
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-3-0-cli-3814.md
	cd $(MODWD) &&\
	xpub push discourse -t snap-3-0-cli about-maas-snap-3-0-cli-3814.md
## snap 3.0 ui
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-3-0-ui-3813.md 
	cd $(MODWD) &&\
	xpub push discourse -t snap-3-0-ui about-maas-snap-3-0-ui-3813.md 
## pull reference version
	cd $(DISC) &&\
	xpub pull discourse 3813 3813
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p about-maas-snap-3-0-ui-3813.md about-maas.md
## remove reference version
	cd $(DISC) && rm about-maas-snap-3-0-ui-3813.md 

$(DISC)/adding-a-vm-host.md: $(SRC)/adding-a-vm-host.md
## deb 2.9 cli
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-9-cli-2296.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-9-cli adding-a-vm-host-deb-2-9-cli-2296.md
## deb 2.9 ui
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-9-ui-2297.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-9-ui adding-a-vm-host-deb-2-9-ui-2297.md
## deb 3.0 cli
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-3-0-cli-3819.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-3-0-cli adding-a-vm-host-deb-3-0-cli-3819.md
## deb 3.0 ui
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-3-0-ui-3820.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-3-0-ui adding-a-vm-host-deb-3-0-ui-3820.md
## snap 2.9 cli
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-9-cli-2290.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli adding-a-vm-host-snap-2-9-cli-2290.md
## snap 2.9 ui
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-9-ui-2291.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui adding-a-vm-host-snap-2-9-ui-2291.md
## snap 3.0 cli
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-3-0-cli-3817.md
	cd $(MODWD) &&\
	xpub push discourse -t snap-3-0-cli adding-a-vm-host-snap-3-0-cli-3817.md
## snap 3.0 ui
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-3-0-ui-3818.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui adding-a-vm-host-snap-3-0-ui-3818.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3818 3818
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p adding-a-vm-host-snap-3-0-ui-3818.md adding-a-vm-host.md
## remove reference version
	cd $(DISC) && rm adding-a-vm-host-snap-3-0-ui-3818.md
 
$(DISC)/add-machines.md: $(SRC)/add-machines.md
## deb 2.9 cli
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-9-cli-2284.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli add-machines-deb-2-9-cli-2284.md
## deb 2.9 ui
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-9-ui-2285.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui add-machines-deb-2-9-ui-2285.md
## deb 3.0 cli
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-3-0-cli-3823.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli add-machines-deb-3-0-cli-3823.md
## deb 3.0 ui
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-3-0-ui-3824.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui add-machines-deb-3-0-ui-3824.md
## snap 2.9 cli
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-9-cli-2278.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli add-machines-snap-2-9-cli-2278.md
## snap 2.9 ui
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-9-ui-2279.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui add-machines-snap-2-9-ui-2279.md
## snap 3.0 cli
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-3-0-cli-3821.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli add-machines-snap-3-0-cli-3821.md
## snap 3.0 ui
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-3-0-ui-3822.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui add-machines-snap-3-0-ui-3822.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3822 3822
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p add-machines-snap-3-0-ui-3822.md add-machines.md
## remove reference version
	cd $(DISC) && rm add-machines-snap-3-0-ui-3822.md
 
$(DISC)/api-authentication.md: $(SRC)/api-authentication.md
## deb 2.9 cli
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-deb-2-9-cli-2308.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli api-authentication-deb-2-9-cli-2308.md
## deb 2.9 ui
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-deb-2-9-ui-2309.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui api-authentication-deb-2-9-ui-2309.md
## deb 3.0 cli
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-deb-3-0-cli-3827.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli api-authentication-deb-3-0-cli-3827.md
## deb 3.0 ui
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-deb-3-0-ui-3828.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui api-authentication-deb-3-0-ui-3828.md
## snap 2.9 cli
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-snap-2-9-cli-2302.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli api-authentication-snap-2-9-cli-2302.md
## snap 2.9 ui
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-snap-2-9-ui-2303.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui api-authentication-snap-2-9-ui-2303.md
## snap 3.0 cli
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-snap-3-0-cli-3825.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli api-authentication-snap-3-0-cli-3825.md
## snap 3.0 ui
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-snap-3-0-ui-3826.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui api-authentication-snap-3-0-ui-3826.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3826 3826
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p api-authentication-snap-3-0-ui-3826.md api-authentication.md
## remove reference version
	cd $(DISC) && rm api-authentication-snap-3-0-ui-3826.md

$(DISC)/audit-event-logs.md: $(SRC)/audit-event-logs.md
## deb 2.9 cli
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-deb-2-9-cli-2320.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli audit-event-logs-deb-2-9-cli-2320.md
## deb 2.9 ui
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-deb-2-9-ui-2321.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui audit-event-logs-deb-2-9-ui-2321.md
## deb 3.0 cli
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-deb-3-0-cli-3831.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli audit-event-logs-deb-3-0-cli-3831.md
## deb 3.0 ui
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-deb-3-0-ui-3832.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui audit-event-logs-deb-3-0-ui-3832.md
## snap 2.9 cli
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-snap-2-9-cli-2314.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli audit-event-logs-snap-2-9-cli-2314.md
## snap 2.9 ui
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-snap-2-9-ui-2315.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui audit-event-logs-snap-2-9-ui-2315.md
## snap 3.0 cli
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-snap-3-0-cli-3829.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli audit-event-logs-snap-3-0-cli-3829.md
## snap 3.0 ui
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-snap-3-0-ui-3830.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui audit-event-logs-snap-3-0-ui-3830.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3830 3830
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p audit-event-logs-snap-3-0-ui-3830.md audit-event-logs.md
## remove reference version
	cd $(DISC) && rm audit-event-logs-snap-3-0-ui-3830.md

$(DISC)/availability-zones.md: $(SRC)/availability-zones.md
## deb 2.9 cli
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-9-cli-2332.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli availability-zones-deb-2-9-cli-2332.md
## deb 2.9 ui
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-9-ui-2333.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui availability-zones-deb-2-9-ui-2333.md
## deb 3.0 cli
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-3-0-cli-3835.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli availability-zones-deb-3-0-cli-3835.md
## deb 3.0 ui
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-3-0-ui-3836.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui availability-zones-deb-3-0-ui-3836.md
## snap 2.9 cli
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-9-cli-2326.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli availability-zones-snap-2-9-cli-2326.md
## snap 2.9 ui
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-9-ui-2327.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui availability-zones-snap-2-9-ui-2327.md
## snap 3.0 cli
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-3-0-cli-3833.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli availability-zones-snap-3-0-cli-3833.md
## snap 3.0 ui
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-3-0-ui-3834.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui availability-zones-snap-3-0-ui-3834.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3834 3834
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p availability-zones-snap-3-0-ui-3834.md availability-zones.md
## remove reference version
	cd $(DISC) && rm availability-zones-snap-3-0-ui-3834.md

#b

$(DISC)/backup.md: $(SRC)/backup.md
## deb 2.9 cli
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-9-cli-2344.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli backup-deb-2-9-cli-2344.md
## deb 2.9 ui
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-9-ui-2345.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui backup-deb-2-9-ui-2345.md
## deb 3.0 cli
	cp $(SRC)/backup.md $(MODWD)/backup-deb-3-0-cli-3839.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli backup-deb-3-0-cli-3839.md
## deb 3.0 ui
	cp $(SRC)/backup.md $(MODWD)/backup-deb-3-0-ui-3840.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui backup-deb-3-0-ui-3840.md
## snap 2.9 cli
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-9-cli-2338.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli backup-snap-2-9-cli-2338.md
## snap 2.9 ui
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-9-ui-2339.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui backup-snap-2-9-ui-2339.md
## snap 3.0 cli
	cp $(SRC)/backup.md $(MODWD)/backup-snap-3-0-cli-3837.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli backup-snap-3-0-cli-3837.md
## snap 3.0 ui
	cp $(SRC)/backup.md $(MODWD)/backup-snap-3-0-ui-3838.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui backup-snap-3-0-ui-3838.md
## pull an example doc for timestamp
	cd $(DISC) &&\
	xpub pull $(DISC) 3838 3838
## cp the example doc to the matching master file name in the discourse directory
	cd $(DISC) &&\
	cp -p backup-snap-3-0-ui-3838.md backup.md
## remove the RAD version, as it clutters the discourse directory
	cd $(DISC) && rm backup-snap-3-0-ui-3838.md
 
$(DISC)/block-devices.md: $(SRC)/block-devices.md
## deb 2.9 cli
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-9-cli-2356.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli block-devices-deb-2-9-cli-2356.md
## deb 2.9 ui
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-9-ui-2357.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui block-devices-deb-2-9-ui-2357.md
## deb 3.0 cli
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-3-0-cli-3843.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli block-devices-deb-3-0-cli-3843.md
## deb 3.0 ui
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-3-0-ui-3844.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui block-devices-deb-3-0-ui-3844.md
## snap 2.9 cli
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-9-cli-2350.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli block-devices-snap-2-9-cli-2350.md
## snap 2.9 ui
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-9-ui-2351.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui block-devices-snap-2-9-ui-2351.md
## snap 3.0 cli
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-3-0-cli-3841.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli block-devices-snap-3-0-cli-3841.md
## snap 3.0 ui
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-3-0-ui-3842.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui block-devices-snap-3-0-ui-3842.md
## pull comparison copy
	cd $(DISC) &&\
	xpub pull $(DISC) 3842 3842
## cp comparison copy to discourse master
	cd $(DISC) &&\
	cp -p block-devices-snap-3-0-ui-3842.md block-devices.md
## remove comparison copy
	cd $(DISC) && rm block-devices-snap-3-0-ui-3842.md

#c
 
$(DISC)/commissioning-and-hardware-testing-scripts.md: $(SRC)/commissioning-and-hardware-testing-scripts.md
## deb 2.9 cli
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-9-cli-2488.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli commissioning-and-hardware-testing-scripts-deb-2-9-cli-2488.md
## deb 2.9 ui
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-9-ui-2489.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui commissioning-and-hardware-testing-scripts-deb-2-9-ui-2489.md
## deb 3.0 cli
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-3-0-cli-3867.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli commissioning-and-hardware-testing-scripts-deb-3-0-cli-3867.md
## deb 3.0 ui
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-3-0-ui-3868.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui commissioning-and-hardware-testing-scripts-deb-3-0-ui-3868.md
## snap 2.9 cli
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-9-cli-2482.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli commissioning-and-hardware-testing-scripts-snap-2-9-cli-2482.md
## snap 2.9 ui
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-9-ui-2483.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui commissioning-and-hardware-testing-scripts-snap-2-9-ui-2483.md
## snap 3.0 cli
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-3-0-cli-3865.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli commissioning-and-hardware-testing-scripts-snap-3-0-cli-3865.md
## snap 3.0 ui
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-3-0-ui-3866.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui commissioning-and-hardware-testing-scripts-snap-3-0-ui-3866.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3866 3866
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p commissioning-and-hardware-testing-scripts-snap-3-0-ui-3866.md commissioning-and-hardware-testing-scripts.md
## remove reference version
	cd $(DISC) && rm commissioning-and-hardware-testing-scripts-snap-3-0-ui-3866.md
 
$(DISC)/commissioning-logs.md: $(SRC)/commissioning-logs.md
## deb 2.9 cli
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-9-cli-2500.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli commissioning-logs-deb-2-9-cli-2500.md
## deb 2.9 ui
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-9-ui-2501.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui commissioning-logs-deb-2-9-ui-2501.md
## deb 3.0 cli
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-3-0-cli-3871.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli commissioning-logs-deb-3-0-cli-3871.md
## deb 3.0 ui
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-3-0-ui-3872.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui commissioning-logs-deb-3-0-ui-3872.md
## snap 2.9 cli
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-9-cli-2494.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli commissioning-logs-snap-2-9-cli-2494.md
## snap 2.9 ui
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-9-ui-2495.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui commissioning-logs-snap-2-9-ui-2495.md
## snap 3.0 cli
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-3-0-cli-3869.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli commissioning-logs-snap-3-0-cli-3869.md
## snap 3.0 ui
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-3-0-ui-3870.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui commissioning-logs-snap-3-0-ui-3870.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3870 3870
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p commissioning-logs-snap-3-0-ui-3870.md commissioning-logs.md
## remove reference version
	cd $(DISC) && rm commissioning-logs-snap-3-0-ui-3870.md

$(DISC)/commission-machines.md: $(SRC)/commission-machines.md
## deb 2.9 cli
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-9-cli-2476.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli commission-machines-deb-2-9-cli-2476.md
## deb 2.9 ui
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-9-ui-2477.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui commission-machines-deb-2-9-ui-2477.md
## deb 3.0 cli
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-3-0-cli-3875.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli commission-machines-deb-3-0-cli-3875.md
## deb 3.0 ui
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-3-0-ui-3876.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui commission-machines-deb-3-0-ui-3876.mdU200
## snap 2.9 cli
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-9-cli-2470.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli commission-machines-snap-2-9-cli-2470.md
## snap 2.9 ui
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-9-ui-2471.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui commission-machines-snap-2-9-ui-2471.md
## snap 3.0 cli
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-3-0-cli-3873.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli commission-machines-snap-3-0-cli-3873.md
## snap 3.0 ui
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-3-0-ui-3874.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui commission-machines-snap-3-0-ui-3874.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3874 3874
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p commission-machines-snap-3-0-ui-3874.md commission-machines.md
## remove reference version
	cd $(DISC) && rm commission-machines-snap-3-0-ui-3874.md
 
$(DISC)/concepts-and-terms.md: $(SRC)/concepts-and-terms.md 
	cp $(SRC)/concepts-and-terms.md $(MODWD)/concepts-and-terms-785.md
	cd $(MODWD) &&\
	xpub push $(DISC) concepts-and-terms-785.md
	cd $(DISC) &&\
	xpub pull $(DISC) 785 785
	cd $(DISC) &&\
	cp -p concepts-and-terms-785.md concepts-and-terms.md
	cd $(DISC) && rm concepts-and-terms-785.md
 
$(DISC)/configuration-journey.md: $(SRC)/configuration-journey.md
## deb 2.9 cli
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-9-cli-2536.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli configuration-journey-deb-2-9-cli-2536.md
## deb 2.9 ui
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-9-ui-2537.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui configuration-journey-deb-2-9-ui-2537.md
## deb 3.0 cli
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-3-0-cli-3887.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli configuration-journey-deb-3-0-cli-3887.md
## deb 3.0 ui
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-3-0-ui-3888.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui configuration-journey-deb-3-0-ui-3888.md
## snap 2.9 cli
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-9-cli-2530.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli configuration-journey-snap-2-9-cli-2530.md
## snap 2.9 ui
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-9-ui-2531.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui configuration-journey-snap-2-9-ui-2531.md
## snap 3.0 cli
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-3-0-cli-3885.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli configuration-journey-snap-3-0-cli-3885.md
## snap 3.0 ui
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-3-0-ui-3886.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui configuration-journey-snap-3-0-ui-3886.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3886 3886
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p configuration-journey-snap-3-0-ui-3886.md configuration-journey.md
## remove reference version
	cd $(DISC) && rm configuration-journey-snap-3-0-ui-3886.md
 
$(DISC)/configuring-tls-encryption.md: $(SRC)/configuring-tls-encryption.md
## deb 2.9 cli
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-9-cli-2548.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli configuring-tls-encryption-deb-2-9-cli-2548.md
## deb 2.9 ui
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-9-ui-2549.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui configuring-tls-encryption-deb-2-9-ui-2549.md
## deb 3.0 cli
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-3-0-cli-3891.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli configuring-tls-encryption-deb-3-0-cli-3891.md
## deb 3.0 ui
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-3-0-ui-3892.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui configuring-tls-encryption-deb-3-0-ui-3892.md
## snap 2.9 cli
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-9-cli-2542.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli configuring-tls-encryption-snap-2-9-cli-2542.md
## snap 2.9 ui
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-9-ui-2543.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui configuring-tls-encryption-snap-2-9-ui-2543.md
## snap 3.0 cli
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-3-0-cli-3889.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli configuring-tls-encryption-snap-3-0-cli-3889.md
## snap 3.0 ui
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-3-0-ui-3890.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui configuring-tls-encryption-snap-3-0-ui-3890.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3890 3890
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p configuring-tls-encryption-snap-3-0-ui-3890.md configuring-tls-encryption.md
## remove reference version
	cd $(DISC) && rm configuring-tls-encryption-snap-3-0-ui-3890.md
 
$(DISC)/controllers.md: $(SRC)/controllers.md
## deb 2.9 cli
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-9-cli-2728.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli controllers-deb-2-9-cli-2728.md
## deb 2.9 ui
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-9-ui-2729.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui controllers-deb-2-9-ui-2729.md
## deb 3.0 cli
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-3-0-cli-3899.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli controllers-deb-3-0-cli-3899.md
## deb 3.0 ui
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-3-0-ui-3900.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui controllers-deb-3-0-ui-3900.md
## snap 2.9 cli
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-9-cli-2722.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli controllers-snap-2-9-cli-2722.md
## snap 2.9 ui
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-9-ui-2723.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui controllers-snap-2-9-ui-2723.md
## snap 3.0 cli
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-3-0-cli-3897.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli controllers-snap-3-0-cli-3897.md
## snap 3.0 ui
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-3-0-ui-3898.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui controllers-snap-3-0-ui-3898.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3898 3898
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p controllers-snap-3-0-ui-3898.md controllers.md
## remove reference version
	cd $(DISC) && rm controllers-snap-3-0-ui-3898.md
 
$(DISC)/creating-a-custom-ubuntu-image.md: $(SRC)/creating-a-custom-ubuntu-image.md
## deb 2.9 cli
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-9-cli-2572.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli creating-a-custom-ubuntu-image-deb-2-9-cli-2572.md
## deb 2.9 ui
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-9-ui-2573.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui creating-a-custom-ubuntu-image-deb-2-9-ui-2573.md
## deb 3.0 cli
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-3-0-cli-3903.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli creating-a-custom-ubuntu-image-deb-3-0-cli-3903.md
## deb 3.0 ui
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-3-0-ui-3904.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui creating-a-custom-ubuntu-image-deb-3-0-ui-3904.md
## snap 2.9 cli
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-9-cli-2566.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli creating-a-custom-ubuntu-image-snap-2-9-cli-2566.md
## snap 2.9 ui
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-9-ui-2567.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui creating-a-custom-ubuntu-image-snap-2-9-ui-2567.md
## snap 3.0 cli
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-3-0-cli-3901.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli creating-a-custom-ubuntu-image-snap-3-0-cli-3901.md
## snap 3.0 ui
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-3-0-ui-3902.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui creating-a-custom-ubuntu-image-snap-3-0-ui-3902.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3902 3902
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p creating-a-custom-ubuntu-image-snap-3-0-ui-3902.md creating-a-custom-ubuntu-image.md
## remove reference version
	cd $(DISC) && rm creating-a-custom-ubuntu-image-snap-3-0-ui-3902.md
 
$(DISC)/creating-and-deleting-vms.md: $(SRC)/creating-and-deleting-vms.md
## deb 2.9 cli
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-9-cli-2584.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli creating-and-deleting-vms-deb-2-9-cli-2584.md
## deb 2.9 ui
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-9-ui-2585.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui creating-and-deleting-vms-deb-2-9-ui-2585.md
## deb 3.0 cli
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-3-0-cli-3907.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli creating-and-deleting-vms-deb-3-0-cli-3907.md
## deb 3.0 ui
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-3-0-ui-3908.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui creating-and-deleting-vms-deb-3-0-ui-3908.md
## snap 2.9 cli
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-9-cli-2578.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli creating-and-deleting-vms-snap-2-9-cli-2578.md
## snap 2.9 ui
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-9-ui-2579.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui creating-and-deleting-vms-snap-2-9-ui-2579.md
## snap 3.0 cli
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-3-0-cli-3905.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli creating-and-deleting-vms-snap-3-0-cli-3905.md
## snap 3.0 ui
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-3-0-ui-3906.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui creating-and-deleting-vms-snap-3-0-ui-3906.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3906 3906
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p creating-and-deleting-vms-snap-3-0-ui-3906.md creating-and-deleting-vms.md
## remove reference version
	cd $(DISC) && rm creating-and-deleting-vms-snap-3-0-ui-3906.md
 
$(DISC)/custom-machine-setup.md: $(SRC)/custom-machine-setup.md
## deb 2.9 cli
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-9-cli-2596.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli custom-machine-setup-deb-2-9-cli-2596.md
## deb 2.9 ui
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-9-ui-2597.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui custom-machine-setup-deb-2-9-ui-2597.md
## deb 3.0 cli
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-3-0-cli-3911.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli custom-machine-setup-deb-3-0-cli-3911.md
## deb 3.0 ui
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-3-0-ui-3912.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui custom-machine-setup-deb-3-0-ui-3912.md
## snap 2.9 cli
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-9-cli-2590.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli custom-machine-setup-snap-2-9-cli-2590.md
## snap 2.9 ui
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-9-ui-2591.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui custom-machine-setup-snap-2-9-ui-2591.md
## snap 3.0 cli
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-3-0-cli-3909.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli custom-machine-setup-snap-3-0-cli-3909.md
## snap 3.0 ui
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-3-0-ui-3910.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui custom-machine-setup-snap-3-0-ui-3910.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3910 3910
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p custom-machine-setup-snap-3-0-ui-3910.md custom-machine-setup.md
## remove reference version
	cd $(DISC) && rm custom-machine-setup-snap-3-0-ui-3910.md

#d

$(DISC)/deploy-machines.md: $(SRC)/deploy-machines.md
## deb 2.9 cli
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-9-cli-2608.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli deploy-machines-deb-2-9-cli-2608.md
## deb 2.9 ui
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-9-ui-2609.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui deploy-machines-deb-2-9-ui-2609.md
## deb 3.0 cli
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-3-0-cli-3915.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli deploy-machines-deb-3-0-cli-3915.md
## deb 3.0 ui
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-3-0-ui-3916.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui deploy-machines-deb-3-0-ui-3916.md
## snap 2.9 cli
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-9-cli-2602.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli deploy-machines-snap-2-9-cli-2602.md
## snap 2.9 ui
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-9-ui-2603.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui deploy-machines-snap-2-9-ui-2603.md
## snap 3.0 cli
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-3-0-cli-3913.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli deploy-machines-snap-3-0-cli-3913.md
## snap 3.0 ui
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-3-0-ui-3914.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui deploy-machines-snap-3-0-ui-3914.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3914 3914
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p deploy-machines-snap-3-0-ui-3914.md deploy-machines.md
## remove reference version
	cd $(DISC) && rm deploy-machines-snap-3-0-ui-3914.md
 
$(DISC)/disk-erasure.md: $(SRC)/disk-erasure.md
## deb 2.9 cli
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-9-cli-2620.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli disk-erasure-deb-2-9-cli-2620.md
## deb 2.9 ui
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-9-ui-2621.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui disk-erasure-deb-2-9-ui-2621.md
## deb 3.0 cli
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-3-0-cli-3923.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli disk-erasure-deb-3-0-cli-3923.md
## deb 3.0 ui
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-3-0-ui-3924.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui disk-erasure-deb-3-0-ui-3924.md
## snap 2.9 cli
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-9-cli-2614.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli disk-erasure-snap-2-9-cli-2614.md
## snap 2.9 ui
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-9-ui-2615.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui disk-erasure-snap-2-9-ui-2615.md
## snap 3.0 cli
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-3-0-cli-3921.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli disk-erasure-snap-3-0-cli-3921.md
## snap 3.0 ui
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-3-0-ui-3922.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui disk-erasure-snap-3-0-ui-3922.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3922 3922
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p disk-erasure-snap-3-0-ui-3922.md disk-erasure.md
## remove reference version
	cd $(DISC) && rm disk-erasure-snap-3-0-ui-3922.md


#e

$(DISC)/event-logs.md: $(SRC)/event-logs.md
## deb 2.9 cli
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-9-cli-3993.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli event-logs-deb-2-9-cli-3993.md
## deb 2.9 ui
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-9-ui-3392.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui event-logs-deb-2-9-ui-3392.md
## deb 3.0 cli
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-3-0-cli-3927.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli event-logs-deb-3-0-cli-3927.md
## deb 3.0 ui
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-3-0-ui-3928.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui event-logs-deb-3-0-ui-3928.md
## snap 2.9 cli
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-9-cli-3386.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli event-logs-snap-2-9-cli-3386.md
## snap 29 ui
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-9-ui-3387.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui event-logs-snap-2-9-ui-3387.md
## snap 3.0 cli
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-3-0-cli-3925.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli event-logs-snap-3-0-cli-3925.md
## snap 3.0 ui
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-3-0-ui-3926.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui event-logs-snap-3-0-ui-3926.md
## pull comparison copy
	cd $(DISC) &&\
	xpub pull $(DISC) 3926 3926
## copy comparison copy w/timestamp to discourse master
	cd $(DISC) &&\
	cp -p event-logs-snap-3-0-ui-3926.md event-logs.md
## delete comparison copy
	cd $(DISC) && rm event-logs-snap-3-0-ui-3926.md

#g

$(DISC)/give-me-an-example-of-maas.md: $(SRC)/give-me-an-example-of-maas.md
## deb 2.9 cli
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-9-cli-2656.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli give-me-an-example-of-maas-deb-2-9-cli-2656.md
## deb 2.9 ui
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-9-ui-2657.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui give-me-an-example-of-maas-deb-2-9-ui-2657.md
## deb 3.0 cli
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-3-0-cli-3935.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli give-me-an-example-of-maas-deb-3-0-cli-3935.md
## deb 3.0 ui
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-3-0-ui-3936.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui give-me-an-example-of-maas-deb-3-0-ui-3936.md
## snap 2.9 cli
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-9-cli-2650.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli give-me-an-example-of-maas-snap-2-9-cli-2650.md
## snap 2.9 ui
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-9-ui-2651.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui give-me-an-example-of-maas-snap-2-9-ui-2651.md
## snap 3.0 cli
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-3-0-cli-3933.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli give-me-an-example-of-maas-snap-3-0-cli-3933.md
## snap 3.0 ui
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-3-0-ui-3934.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui give-me-an-example-of-maas-snap-3-0-ui-3934.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3934 3934
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p give-me-an-example-of-maas-snap-3-0-ui-3934.md give-me-an-example-of-maas.md
## remove reference version
	cd $(DISC) && rm give-me-an-example-of-maas-snap-3-0-ui-3934.md

#h

$(DISC)/hardening-your-maas-installation.md: $(SRC)/hardening-your-maas-installation.md
## deb 2.9 cli
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-9-cli-2668.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli hardening-your-maas-installation-deb-2-9-cli-2668.md
## deb 2.9 ui
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-9-ui-2669.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui hardening-your-maas-installation-deb-2-9-ui-2669.md
## deb 3.0 cli
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-3-0-cli-3939.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli hardening-your-maas-installation-deb-3-0-cli-3939.md
## deb 3.0 ui
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-3-0-ui-3940.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui hardening-your-maas-installation-deb-3-0-ui-3940.md
## snap 2.9 cli
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-9-cli-2662.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli hardening-your-maas-installation-snap-2-9-cli-2662.md
## snap 2.9 ui
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-9-ui-2663.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui hardening-your-maas-installation-snap-2-9-ui-2663.md
## snap 3.0 cli
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-3-0-cli-3937.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli hardening-your-maas-installation-snap-3-0-cli-3937.md
## snap 3.0 ui
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-3-0-ui-3938.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui hardening-your-maas-installation-snap-3-0-ui-3938.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3938 3938
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p hardening-your-maas-installation-snap-3-0-ui-3938.md hardening-your-maas-installation.md
## remove reference version
	cd $(DISC) && rm hardening-your-maas-installation-snap-3-0-ui-3938.md
 
$(DISC)/hardware-testing.md: $(SRC)/hardware-testing.md
## deb 2.9 cli
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-9-cli-2680.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli hardware-testing-deb-2-9-cli-2680.md
## deb 2.9 ui
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-9-ui-2681.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui hardware-testing-deb-2-9-ui-2681.md
## deb 3.0 cli
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-3-0-cli-3943.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli hardware-testing-deb-3-0-cli-3943.md
## deb 3.0 ui
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-3-0-ui-3944.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui hardware-testing-deb-3-0-ui-3944.md
## snap 2.9 cli
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-9-cli-2674.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli hardware-testing-snap-2-9-cli-2674.md
## snap 2.9 ui
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-9-ui-2675.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui hardware-testing-snap-2-9-ui-2675.md
## snap 3.0 cli
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-3-0-cli-3941.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli hardware-testing-snap-3-0-cli-3941.md
## snap 3.0 ui
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-3-0-ui-3942.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui hardware-testing-snap-3-0-ui-3942.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3942 3942
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p hardware-testing-snap-3-0-ui-3942.md hardware-testing.md
## remove reference version
	cd $(DISC) && rm hardware-testing-snap-3-0-ui-3942.md
 
$(DISC)/high-availability.md: $(SRC)/high-availability.md
## deb 2.9 cli
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-9-cli-2692.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli high-availability-deb-2-9-cli-2692.md
## deb 2.9 ui
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-9-ui-2693.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui high-availability-deb-2-9-ui-2693.md
## deb 3.0 cli
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-3-0-cli-3947.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli high-availability-deb-3-0-cli-3947.md
## deb 3.0 ui
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-3-0-ui-3948.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui high-availability-deb-3-0-ui-3948.md
## snap 2.9 cli
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-9-cli-2686.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli high-availability-snap-2-9-cli-2686.md
## snap 2.9 ui
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-9-ui-2687.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui high-availability-snap-2-9-ui-2687.md
## snap 3.0 cli
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-3-0-cli-3945.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli high-availability-snap-3-0-cli-3945.md
## snap 3.0 ui
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-3-0-ui-3946.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui high-availability-snap-3-0-ui-3946.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3946 3946
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p high-availability-snap-3-0-ui-3946.md high-availability.md
## remove reference version
	cd $(DISC) && rm high-availability-snap-3-0-ui-3946.md

#i

$(DISC)/images.md: $(SRC)/images.md
## deb 2.9 cli
	cp $(SRC)/images.md $(MODWD)/images-deb-2-9-cli-2704.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli images-deb-2-9-cli-2704.md
## deb 2.9 ui
	cp $(SRC)/images.md $(MODWD)/images-deb-2-9-ui-2705.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui images-deb-2-9-ui-2705.md
## deb 3.0 cli
	cp $(SRC)/images.md $(MODWD)/images-deb-3-0-cli-3959.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli images-deb-3-0-cli-3959.md
## deb 3.0 ui
	cp $(SRC)/images.md $(MODWD)/images-deb-3-0-ui-3960.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui images-deb-3-0-ui-3960.md
## snap 2.9 cli
	cp $(SRC)/images.md $(MODWD)/images-snap-2-9-cli-2698.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli images-snap-2-9-cli-2698.md
## snap 2.9 ui
	cp $(SRC)/images.md $(MODWD)/images-snap-2-9-ui-2699.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui images-snap-2-9-ui-2699.md
## snap 3.0 cli
	cp $(SRC)/images.md $(MODWD)/images-snap-3-0-cli-3957.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli images-snap-3-0-cli-3957.md
## snap 3.0 ui
	cp $(SRC)/images.md $(MODWD)/images-snap-3-0-ui-3958.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui images-snap-3-0-ui-3958.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3958 3958
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p images-snap-3-0-ui-3958.md images.md
## remove reference version
	cd $(DISC) && rm images-snap-3-0-ui-3958.md
 
$(DISC)/interactive-search.md: $(SRC)/interactive-search.md
## deb 2.9 cli
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-9-cli-2716.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli interactive-search-deb-2-9-cli-2716.md
## deb 2.9 ui
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-9-ui-2717.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui interactive-search-deb-2-9-ui-2717.md
## deb 3.0 cli
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-3-0-cli-3963.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli interactive-search-deb-3-0-cli-3963.md
## deb 3.0 ui
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-3-0-ui-3964.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui interactive-search-deb-3-0-ui-3964.md
## snap 2.9 cli
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-9-cli-2710.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli interactive-search-snap-2-9-cli-2710.md
## snap 2.9 ui
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-9-ui-2711.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui interactive-search-snap-2-9-ui-2711.md
## snap 3.0 cli
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-3-0-cli-3961.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli interactive-search-snap-3-0-cli-3961.md
## snap 3.0 ui
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-3-0-ui-3962.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui interactive-search-snap-3-0-ui-3962.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3962 3962
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p interactive-search-snap-3-0-ui-3962.md interactive-search.md
## delete reference version
	cd $(DISC) && rm interactive-search-snap-3-0-ui-3962.md
 
$(DISC)/ip-ranges.md: $(SRC)/ip-ranges.md
## deb 2.9 cli
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-9-cli-2764.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli ip-ranges-deb-2-9-cli-2764.md
## deb 2.9 ui
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-9-ui-2765.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui ip-ranges-deb-2-9-ui-2765.md
## deb 3.0 cli
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-3-0-cli-3967.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli ip-ranges-deb-3-0-cli-3967.md
## deb 3.0 ui
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-3-0-ui-3968.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui ip-ranges-deb-3-0-ui-3968.md
## snap 2.9 cli
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-9-cli-2758.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli ip-ranges-snap-2-9-cli-2758.md
## snap 2.9 ui
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-9-ui-2759.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui ip-ranges-snap-2-9-ui-2759.md
## snap 3.0 cli
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-3-0-cli-3965.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli ip-ranges-snap-3-0-cli-3965.md
## snap 3.0 ui
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-3-0-ui-3966.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui ip-ranges-snap-3-0-ui-3966.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3966 3966
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p ip-ranges-snap-3-0-ui-3966.md ip-ranges.md
## remove reference version
	cd $(DISC) && rm ip-ranges-snap-3-0-ui-3966.md
 
$(DISC)/ipv6-addressing.md: $(SRC)/ipv6-addressing.md
## deb 2.9 cli
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-9-cli-2776.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli ipv6-addressing-deb-2-9-cli-2776.md
## deb 2.9 ui
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-9-ui-2777.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui ipv6-addressing-deb-2-9-ui-2777.md
## deb 3.0 cli
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-3-0-cli-3971.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli ipv6-addressing-deb-3-0-cli-3971.md
## deb 3.0 ui
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-3-0-ui-3972.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui ipv6-addressing-deb-3-0-ui-3972.md
## snap 2.9 cli
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-9-cli-2770.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli ipv6-addressing-snap-2-9-cli-2770.md
## snap 2.9 ui
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-9-ui-2771.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui ipv6-addressing-snap-2-9-ui-2771.md
## snap 3.0 cli
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-3-0-cli-3969.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli ipv6-addressing-snap-3-0-cli-3969.md
## snap 3.0 ui
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-3-0-ui-3970.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui ipv6-addressing-snap-3-0-ui-3970.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3970 3970
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p ipv6-addressing-snap-3-0-ui-3970.md ipv6-addressing.md
## remove reference version
	cd $(DISC) && rm ipv6-addressing-snap-3-0-ui-3970.md

#k

$(DISC)/kernel-boot-options.md: $(SRC)/kernel-boot-options.md
## deb 2.9 cli
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-9-cli-2788.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli kernel-boot-options-deb-2-9-cli-2788.md
## deb 2.9 ui
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-9-ui-2789.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui kernel-boot-options-deb-2-9-ui-2789.md
## deb 3.0 cli
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-3-0-cli-3975.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli kernel-boot-options-deb-3-0-cli-3975.md
## deb 3.0 ui
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-3-0-ui-3976.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui kernel-boot-options-deb-3-0-ui-3976.md
## snap 2.9 cli
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-9-cli-2782.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli kernel-boot-options-snap-2-9-cli-2782.md
## snap 2.9 ui
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-9-ui-2783.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui kernel-boot-options-snap-2-9-ui-2783.md
## snap 3.0 cli
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-3-0-cli-3973.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli kernel-boot-options-snap-3-0-cli-3973.md
## snap 3.0 ui
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-3-0-ui-3974.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui kernel-boot-options-snap-3-0-ui-3974.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3974 3974
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p kernel-boot-options-snap-3-0-ui-3974.md kernel-boot-options.md
## remove reference version
	cd $(DISC) && rm kernel-boot-options-snap-3-0-ui-3974.md

#l

$(DISC)/local-image-mirror.md: $(SRC)/local-image-mirror.md
## deb 2.9 cli
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-9-cli-2812.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli local-image-mirror-deb-2-9-cli-2812.md
## deb 2.9 ui
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-9-ui-2813.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui local-image-mirror-deb-2-9-ui-2813.md
## deb 3.0 cli
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-3-0-cli-3983.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli local-image-mirror-deb-3-0-cli-3983.md
## deb 3.0 ui
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-3-0-ui-3984.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui local-image-mirror-deb-3-0-ui-3984.md
## snap 2.9 cli
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-9-cli-2806.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli local-image-mirror-snap-2-9-cli-2806.md
## snap 2.9 ui
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-9-ui-2807.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui local-image-mirror-snap-2-9-ui-2807.md
## snap 3.0 cli
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-3-0-cli-3981.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli local-image-mirror-snap-3-0-cli-3981.md
## snap 3.0 ui
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-3-0-ui-3982.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui local-image-mirror-snap-3-0-ui-3982.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3982 3982
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p local-image-mirror-snap-3-0-ui-3982.md local-image-mirror.md
## delete reference version
	cd $(DISC) && rm local-image-mirror-snap-3-0-ui-3982.md

#m

$(DISC)/maas-cli.md: $(SRC)/maas-cli.md
## deb 2.9 cli
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-deb-2-9-cli-2824.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-cli-deb-2-9-cli-2824.md
## deb 2.9 ui
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-deb-2-9-ui-2825.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-cli-deb-2-9-ui-2825.md
## deb 3.0 cli
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-deb-3-0-cli-3987.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli maas-cli-deb-3-0-cli-3987.md
## deb 3.0 ui
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-deb-3-0-ui-3988.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui maas-cli-deb-3-0-ui-3988.md
## snap 2.9 cli
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-snap-2-9-cli-2818.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-cli-snap-2-9-cli-2818.md
## snap 2.9 ui
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-snap-2-9-ui-2819.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-cli-snap-2-9-ui-2819.md
## snap 3.0 cli
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-snap-3-0-cli-3985.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli maas-cli-snap-3-0-cli-3985.md
## snap 3.0 ui
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-snap-3-0-ui-3986.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui maas-cli-snap-3-0-ui-3986.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3986 3986
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p maas-cli-snap-3-0-ui-3986.md maas-cli.md
## delete reference version
	cd $(DISC) && rm maas-cli-snap-3-0-ui-3986.md
 
$(DISC)/maas-communication.md: $(SRC)/maas-communication.md
## deb 2.9 cli
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-9-cli-2836.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-communication-deb-2-9-cli-2836.md
## deb 2.9 ui
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-9-ui-2837.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-communication-deb-2-9-ui-2837.md
## deb 3.0 cli
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-3-0-cli-3991.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli maas-communication-deb-3-0-cli-3991.md
## deb 3.0 ui
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-3-0-ui-3992.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui maas-communication-deb-3-0-ui-3992.md
## snap 2.9 cli
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-9-cli-2830.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-communication-snap-2-9-cli-2830.md
## snap 2.9 ui
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-9-ui-2831.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-communication-snap-2-9-ui-2831.md
## snap 3.0 cli
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-3-0-cli-3989.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli maas-communication-snap-3-0-cli-3989.md
## snap 3.0 ui
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-3-0-ui-3990.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui maas-communication-snap-3-0-ui-3990.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3990 3990
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p maas-communication-snap-3-0-ui-3990.md maas-communication.md
## remove reference version
	cd $(DISC) && rm maas-communication-snap-3-0-ui-3990.md
 
$(DISC)/maas-documentation.md: $(SRC)/maas-documentation.md
## deb 2.9 cli
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-9-cli-2848.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-9-cli-2848.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-documentation-deb-2-9-cli-2848.md
## deb 2.9 ui
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-9-ui-2849.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-9-ui-2849.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-documentation-deb-2-9-ui-2849.md
## deb 3.0 cli
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-3-0-cli-3995.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-3-0-cli-3995.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli maas-documentation-deb-3-0-cli-3995.md
## deb 3.0 ui
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-3-0-ui-4195.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-3-0-ui-4195.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui maas-documentation-deb-3-0-ui-4195.md
## snap 2.9 cli
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-9-cli-2842.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-9-cli-2842.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-documentation-snap-2-9-cli-2842.md
## snap 2.9 ui
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-9-ui-2843.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-9-ui-2843.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-documentation-snap-2-9-ui-2843.md
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-25.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-documentation-25.md
## snap 3.0 cli
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-3-0-cli-3993.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-3-0-cli-3993.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli maas-documentation-snap-3-0-cli-3993.md
## snap 3.0 ui
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-3-0-ui-3994.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-3-0-ui-3994.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui maas-documentation-snap-3-0-ui-3994.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 25 25
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p maas-documentation-25.md maas-documentation.md
## remove reference version
	cd $(DISC) && rm maas-documentation-25.md

$(DISC)/maas-image-builder.md: $(SRC)/maas-image-builder.md
## deb 2.9 cli
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-9-cli-2860.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-image-builder-deb-2-9-cli-2860.md
## deb 2.9 ui
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-9-ui-2861.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-image-builder-deb-2-9-ui-2861.md
## deb 3.0 cli
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-3-0-cli-3999.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli maas-image-builder-deb-3-0-cli-3999.md
## deb 3.0 ui
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-3-0-ui-4000.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui maas-image-builder-deb-3-0-ui-4000.md
## snap 2.9 cli
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-9-cli-2854.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-image-builder-snap-2-9-cli-2854.md
## snap 2.9 ui
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-9-ui-2855.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-image-builder-snap-2-9-ui-2855.md
## snap 3.0 cli
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-3-0-cli-3997.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli maas-image-builder-snap-3-0-cli-3997.md
## snap 3.0 ui
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-3-0-ui-3998.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui maas-image-builder-snap-3-0-ui-3998.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3998 3998
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p maas-image-builder-snap-3-0-ui-3998.md maas-image-builder.md
## remove reference version
	cd $(DISC) && rm maas-image-builder-snap-3-0-ui-3998.md
 
$(DISC)/maas-installation.md: $(SRC)/maas-installation.md
## deb 2.9 cli
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-9-cli-3328.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-installation-deb-2-9-cli-3328.md
## deb 2.9 ui
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-9-ui-3329.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-installation-deb-2-9-ui-3329.md
## deb 3.0 cli
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-3-0-cli-4003.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli maas-installation-deb-3-0-cli-4003.md
## deb 3.0 ui
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-3-0-ui-4004.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui maas-installation-deb-3-0-ui-4004.md
## snap 2.9 cli
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-9-cli-3322.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-installation-snap-2-9-cli-3322.md
## snap 2.9 ui
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-9-ui-3323.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-installation-snap-2-9-ui-3323.md
## snap 3.0 cli
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-3-0-cli-4001.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli maas-installation-snap-3-0-cli-4001.md
## snap 3.0 ui
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-3-0-ui-4002.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui maas-installation-snap-3-0-ui-4002.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4002 4002
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p maas-installation-snap-3-0-ui-4002.md maas-installation.md
## remove reference version
	cd $(DISC) && rm maas-installation-snap-3-0-ui-4002.md

$(DISC)/maas-logging.md: $(SRC)/maas-logging.md
## deb 2.9 cli
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-9-cli-2872.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-logging-deb-2-9-cli-2872.md
## deb 2.9 ui
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-9-ui-2873.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-logging-deb-2-9-ui-2873.md
## deb 3.0 cli
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-3-0-cli-4011.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli maas-logging-deb-3-0-cli-4011.md
## deb 3.0 ui
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-3-0-ui-4012.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui maas-logging-deb-3-0-ui-4012.md
## snap 2.9 cli
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-9-cli-2866.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-logging-snap-2-9-cli-2866.md
## snap 2.9 ui
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-9-ui-2867.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-logging-snap-2-9-ui-2867.md
## snap 3.0 cli
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-3-0-cli-4009.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli maas-logging-snap-3-0-cli-4009.md
## snap 3.0 ui
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-3-0-ui-4010.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui maas-logging-snap-3-0-ui-4010.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4010 4010
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p maas-logging-snap-3-0-ui-4010.md maas-logging.md
## remove reference version
	cd $(DISC) && rm maas-logging-snap-3-0-ui-4010.md
 
$(DISC)/maas-requirements.md: $(SRC)/maas-requirements.md
## deb 2.9 cli
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-9-cli-2884.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli maas-requirements-deb-2-9-cli-2884.md
## deb 2.9 ui
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-9-ui-2885.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui maas-requirements-deb-2-9-ui-2885.md
## deb 3.0 cli
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-3-0-cli-4015.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli maas-requirements-deb-3-0-cli-4015.md
## deb 3.0 ui
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-3-0-ui-4016.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui maas-requirements-deb-3-0-ui-4016.md
## snap 2.9 cli
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-9-cli-2878.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli maas-requirements-snap-2-9-cli-2878.md
## snap 2.9 ui
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-9-ui-2879.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui maas-requirements-snap-2-9-ui-2879.md
## snap 3.0 cli
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-3-0-cli-4013.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli maas-requirements-snap-3-0-cli-4013.md
## snap 3.0 ui
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-3-0-ui-4014.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui maas-requirements-snap-3-0-ui-4014.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4014 4014
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p maas-requirements-snap-3-0-ui-4014.md maas-requirements.md
## remove reference version
	cd $(DISC) && rm maas-requirements-snap-3-0-ui-4014.md

$(DISC)/tags-and-annotations.md: $(SRC)/tags-and-annotations.md
## deb 2.9 cli
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-deb-2-9-cli-2896.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli tags-and-annotations-deb-2-9-cli-2896.md
## deb 2.9 ui
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-deb-2-9-ui-2897.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui tags-and-annotations-deb-2-9-ui-2897.md
## deb 3.0 cli
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-deb-3-0-cli-4023.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli tags-and-annotations-deb-3-0-cli-4023.md
## deb 3.0 ui
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-deb-3-0-ui-4024.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui tags-and-annotations-deb-3-0-ui-4024.md
## snap 2.9 cli
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-snap-2-9-cli-2890.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli tags-and-annotations-snap-2-9-cli-2890.md
## snap 2.9 ui
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-snap-2-9-ui-2891.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui tags-and-annotations-snap-2-9-ui-2891.md
## snap 3.0 cli
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-snap-3-0-cli-4021.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli tags-and-annotations-snap-3-0-cli-4021.md
## snap 3.0 ui
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-snap-3-0-ui-4022.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui tags-and-annotations-snap-3-0-ui-4022.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4022 4022
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p tags-and-annotations-snap-3-0-ui-4022.md tags-and-annotations.md
## remove reference version
	cd $(DISC) && rm tags-and-annotations-snap-3-0-ui-4022.md
 
$(DISC)/machine-logs.md: $(SRC)/machine-logs.md
## deb 2.9 cli
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-9-cli-3453.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli machine-logs-deb-2-9-cli-3453.md
## deb 2.9 ui
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-9-ui-3452.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui machine-logs-deb-2-9-ui-3452.md
## deb 3.0 cli
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-3-0-cli-4027.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli machine-logs-deb-3-0-cli-4027.md
## deb 3.0 ui
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-3-0-ui-4028.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui machine-logs-deb-3-0-ui-4028.md
## snap 2.9 cli
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-9-cli-3446.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli machine-logs-snap-2-9-cli-3446.md
## snap 2.9 ui
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-9-ui-3447.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui machine-logs-snap-2-9-ui-3447.md
## snap 3.0 cli
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-3-0-cli-4025.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli machine-logs-snap-3-0-cli-4025.md
## snap 3.0 ui
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-3-0-ui-4026.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui machine-logs-snap-3-0-ui-4026.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 3447 3447
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p machine-logs-snap-2-9-ui-3447.md machine-logs.md
	cd $(DISC) && rm machine-logs-snap-2-9-ui-3447.md

$(DISC)/machines.md: $(SRC)/machines.md
## deb 2.9 cli
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-9-cli-2740.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli machines-deb-2-9-cli-2740.md
## deb 2.9 ui
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-9-ui-2741.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui machines-deb-2-9-ui-2741.md
## deb 3.0 cli
	cp $(SRC)/machines.md $(MODWD)/machines-deb-3-0-cli-4031.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli machines-deb-3-0-cli-4031.md
## deb 3.0 ui
	cp $(SRC)/machines.md $(MODWD)/machines-deb-3-0-ui-4032.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui machines-deb-3-0-ui-4032.md
## snap 2.9 cli
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-9-cli-2734.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli machines-snap-2-9-cli-2734.md
## snap 2.9 ui
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-9-ui-2735.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui machines-snap-2-9-ui-2735.md
## snap 3.0 cli
	cp $(SRC)/machines.md $(MODWD)/machines-snap-3-0-cli-4029.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli machines-snap-3-0-cli-4029.md
## snap 3.0 ui
	cp $(SRC)/machines.md $(MODWD)/machines-snap-3-0-ui-4030.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui machines-snap-3-0-ui-4030.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4030 4030
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p machines-snap-3-0-ui-4030.md machines.md
## remove reference version
	cd $(DISC) && rm machines-snap-3-0-ui-4030.md
 
$(DISC)/managing-dhcp.md: $(SRC)/managing-dhcp.md
## deb 2.9 cli
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-9-cli-2908.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli managing-dhcp-deb-2-9-cli-2908.md
## deb 2.9 ui
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-9-ui-2909.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui managing-dhcp-deb-2-9-ui-2909.md
## deb 3.0 cli
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-3-0-cli-4035.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli managing-dhcp-deb-3-0-cli-4035.md
## deb 3.0 ui
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-3-0-ui-4036.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui managing-dhcp-deb-3-0-ui-4036.md
## snap 2.9 cli
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-9-cli-2902.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli managing-dhcp-snap-2-9-cli-2902.md
## snap 2.9 ui
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-9-ui-2903.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui managing-dhcp-snap-2-9-ui-2903.md
## snap 3.0 cli
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-3-0-cli-4033.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli managing-dhcp-snap-3-0-cli-4033.md
## snap 3.0 ui
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-3-0-ui-4034.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui managing-dhcp-snap-3-0-ui-4034.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4034 4034
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p managing-dhcp-snap-3-0-ui-4034.md managing-dhcp.md
## remove reference version
	cd $(DISC) && rm managing-dhcp-snap-3-0-ui-4034.md
 
$(DISC)/managing-stp.md: $(SRC)/managing-stp.md
## deb 2.9 cli
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-9-cli-2920.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli managing-stp-deb-2-9-cli-2920.md
## deb 2.9 ui
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-9-ui-2921.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui managing-stp-deb-2-9-ui-2921.md
## deb 3.0 cli
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-3-0-cli-4039.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli managing-stp-deb-3-0-cli-4039.md
## deb 3.0 ui
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-3-0-ui-4040.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui managing-stp-deb-3-0-ui-4040.md
## snap 2.9 cli
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-9-cli-2914.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli managing-stp-snap-2-9-cli-2914.md
## snap 2.9 ui
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-9-ui-2915.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui managing-stp-snap-2-9-ui-2915.md
## snap 3.0 cli
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-3-0-cli-4037.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli managing-stp-snap-3-0-cli-4037.md
## snap 3.0 ui
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-3-0-ui-4038.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui managing-stp-snap-3-0-ui-4038.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4038 4038
## copy reference version to discourse
	cd $(DISC) &&\
	cp -p managing-stp-snap-3-0-ui-4038.md managing-stp.md
## remove reference version
	cd $(DISC) && rm managing-stp-snap-3-0-ui-4038.md

#n

$(DISC)/network-discovery.md: $(SRC)/network-discovery.md
## deb 2.9 cli
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-9-cli-2932.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli network-discovery-deb-2-9-cli-2932.md
## deb 2.9 ui
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-9-ui-2933.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui network-discovery-deb-2-9-ui-2933.md
## deb 3.0 cli
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-3-0-cli-4043.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli network-discovery-deb-3-0-cli-4043.md
## deb 3.0 ui
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-3-0-ui-4044.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui network-discovery-deb-3-0-ui-4044.md
## snap 2.9 cli
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-9-cli-2926.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli network-discovery-snap-2-9-cli-2926.md
## snap 2.9 ui
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-9-ui-2927.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui network-discovery-snap-2-9-ui-2927.md
## snap 3.0 cli
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-3-0-cli-4041.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli network-discovery-snap-3-0-cli-4041.md
## snap 3.0 ui
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-3-0-ui-4042.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui network-discovery-snap-3-0-ui-4042.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4042 4042
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p network-discovery-snap-3-0-ui-4042.md network-discovery.md
## remove reference version
	cd $(DISC) && rm network-discovery-snap-3-0-ui-4042.md
 
$(DISC)/networking.md: $(SRC)/networking.md
## deb 2.9 cli
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-9-cli-2956.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli networking-deb-2-9-cli-2956.md
## deb 2.9 ui
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-9-ui-2957.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui networking-deb-2-9-ui-2957.md
## deb 3.0 cli
	cp $(SRC)/networking.md $(MODWD)/networking-deb-3-0-cli-4047.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli networking-deb-3-0-cli-4047.md
## deb 3.0 ui
	cp $(SRC)/networking.md $(MODWD)/networking-deb-3-0-ui-4048.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui networking-deb-3-0-ui-4048.md
## snap 2.9 cli
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-9-cli-2950.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli networking-snap-2-9-cli-2950.md
## snap 2.9 ui
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-9-ui-2951.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui networking-snap-2-9-ui-2951.md
## snap 3.0 cli
	cp $(SRC)/networking.md $(MODWD)/networking-snap-3-0-cli-4045.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli networking-snap-3-0-cli-4045.md
## snap 3.0 ui
	cp $(SRC)/networking.md $(MODWD)/networking-snap-3-0-ui-4046.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui networking-snap-3-0-ui-4046.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4046 4046
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p networking-snap-3-0-ui-4046.md networking.md
## remove reference version
	cd $(DISC) && rm networking-snap-3-0-ui-4046.md
 
$(DISC)/network-testing.md: $(SRC)/network-testing.md
## deb 2.9 cli
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-9-cli-2944.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli network-testing-deb-2-9-cli-2944.md
## deb 2.9 ui
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-9-ui-2945.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui network-testing-deb-2-9-ui-2945.md
## deb 3.0 cli
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-3-0-cli-4051.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli network-testing-deb-3-0-cli-4051.md
## deb 3.0 ui
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-3-0-ui-4052.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui network-testing-deb-3-0-ui-4052.md
## snap 2.9 cli
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-9-cli-2938.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli network-testing-snap-2-9-cli-2938.md
## snap 2.9 ui
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-9-ui-2939.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui network-testing-snap-2-9-ui-2939.md
## snap 3.0 cli
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-3-0-cli-4049.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli network-testing-snap-3-0-cli-4049.md
## snap 3.0 ui
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-3-0-ui-4050.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui network-testing-snap-3-0-ui-4050.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4050 4050
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p network-testing-snap-3-0-ui-4050.md network-testing.md
## remove reference version
	cd $(DISC) && rm network-testing-snap-3-0-ui-4050.md
 
$(DISC)/ntp-services.md: $(SRC)/ntp-services.md
## deb 2.9 cli
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-9-cli-2968.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli ntp-services-deb-2-9-cli-2968.md
## deb 2.9 ui
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-9-ui-2969.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui ntp-services-deb-2-9-ui-2969.md
## deb 3.0 cli
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-3-0-cli-4055.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli ntp-services-deb-3-0-cli-4055.md
## deb 3.0 ui
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-3-0-ui-4056.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui ntp-services-deb-3-0-ui-4056.md
## snap 2.9 cli
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-9-cli-2962.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli ntp-services-snap-2-9-cli-2962.md
## snap 2.9 ui
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-9-ui-2963.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui ntp-services-snap-2-9-ui-2963.md
## snap 3.0 cli
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-3-0-cli-4053.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli ntp-services-snap-3-0-cli-4053.md
## snap 3.0 ui
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-3-0-ui-4054.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui ntp-services-snap-3-0-ui-4054.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4054 4054
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p ntp-services-snap-3-0-ui-4054.md ntp-services.md
## remove reference version
	cd $(DISC) && rm ntp-services-snap-3-0-ui-4054.md

#p

$(DISC)/package-repositories.md: $(SRC)/package-repositories.md
## deb 3.0 cli
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-3-0-cli-4059.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli package-repositories-deb-3-0-cli-4059.md
## deb 3.0 ui
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-3-0-ui-4060.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui package-repositories-deb-3-0-ui-4060.md
## deb 2.9 cli
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-9-cli-2992.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli partitions-deb-2-9-cli-2992.md
## deb 2.9 ui
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-9-ui-2993.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui partitions-deb-2-9-ui-2993.md
## deb 3.0 cli
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-3-0-cli-4063.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli partitions-deb-3-0-cli-4063.md
## deb 3.0 ui
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-3-0-ui-4064.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui partitions-deb-3-0-ui-4064.md
## snap 2.9 cli
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-9-cli-2986.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli partitions-snap-2-9-cli-2986.md
## snap 2.9 ui
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-9-ui-2987.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui partitions-snap-2-9-ui-2987.md
## snap 3.0 cli
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-3-0-cli-4061.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli partitions-snap-3-0-cli-4061.md
## snap 3.0 ui
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-3-0-ui-4062.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui partitions-snap-3-0-ui-4062.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4062 4062
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p partitions-snap-3-0-ui-4062.md partitions.md
## remove reference version
	cd $(DISC) && rm partitions-snap-3-0-ui-4062.md
 
$(DISC)/postgresql-ha-hot-standby.md: $(SRC)/postgresql-ha-hot-standby.md
## deb 2.9 cli
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-9-cli-3004.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli postgresql-ha-hot-standby-deb-2-9-cli-3004.md
## deb 2.9 ui
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-9-ui-3005.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui postgresql-ha-hot-standby-deb-2-9-ui-3005.md
## deb 3.0 cli
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-3-0-cli-4067.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli postgresql-ha-hot-standby-deb-3-0-cli-4067.md
## deb 3.0 ui
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-3-0-ui-4068.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui postgresql-ha-hot-standby-deb-3-0-ui-4068.md
## snap 2.9 cli
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-9-cli-2998.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli postgresql-ha-hot-standby-snap-2-9-cli-2998.md
## snap 2.9 ui
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-9-ui-2999.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui postgresql-ha-hot-standby-snap-2-9-ui-2999.md
## snap 3.0 cli
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-3-0-cli-4065.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli postgresql-ha-hot-standby-snap-3-0-cli-4065.md
## snap 3.0 ui
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-3-0-ui-4066.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui postgresql-ha-hot-standby-snap-3-0-ui-4066.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4066 4066
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p postgresql-ha-hot-standby-snap-3-0-ui-4066.md postgresql-ha-hot-standby.md
## remove reference version
	cd $(DISC) && rm postgresql-ha-hot-standby-snap-3-0-ui-4066.md
 
$(DISC)/power-management.md: $(SRC)/power-management.md
## deb 2.9 cli
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-9-cli-3016.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli power-management-deb-2-9-cli-3016.md
## deb 2.9 ui
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-9-ui-3017.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui power-management-deb-2-9-ui-3017.md
## deb 3.0 cli
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-3-0-cli-4071.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli power-management-deb-3-0-cli-4071.md
## deb 3.0 ui
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-3-0-ui-4072.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui power-management-deb-3-0-ui-4072.md
## snap 2.9 cli
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-9-cli-3010.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli power-management-snap-2-9-cli-3010.md
## snap 2.9 ui
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-9-ui-3011.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui power-management-snap-2-9-ui-3011.md
## snap 3.0 cli
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-3-0-cli-4069.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli power-management-snap-3-0-cli-4069.md
## snap 3.0 ui
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-3-0-ui-4070.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui power-management-snap-3-0-ui-4070.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4070 4070
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p power-management-snap-3-0-ui-4070.md power-management.md
## remove reference version
	cd $(DISC) && rm power-management-snap-3-0-ui-4070.md
 
$(DISC)/prometheus-metrics.md: $(SRC)/prometheus-metrics.md
## deb 2.9 cli 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-9-cli-3028.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli prometheus-metrics-deb-2-9-cli-3028.md
## deb 2.9 ui 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-9-ui-3029.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui prometheus-metrics-deb-2-9-ui-3029.md
## deb 3.0 cli
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-3-0-cli-4075.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli prometheus-metrics-deb-3-0-cli-4075.md
## deb 3.0 ui
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-3-0-ui-4076.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui prometheus-metrics-deb-3-0-ui-4076.md
## snap 2.9 cli 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-9-cli-3022.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli prometheus-metrics-snap-2-9-cli-3022.md
## snap 2.9 ui 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-9-ui-3023.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui prometheus-metrics-snap-2-9-ui-3023.md
## snap 3.0 cli 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-3-0-cli-4073.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli prometheus-metrics-snap-3-0-cli-4073.md
## snap 3.0 ui 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-3-0-ui-4074.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui prometheus-metrics-snap-3-0-ui-4074.md
## pull reference version 
	cd $(DISC) &&\
	xpub pull $(DISC) 4074 4074
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p prometheus-metrics-snap-3-0-ui-4074.md prometheus-metrics.md
## remove reference version
	cd $(DISC) && rm prometheus-metrics-snap-3-0-ui-4074.md
 
$(DISC)/proxy.md: $(SRC)/proxy.md
## deb 2.9 cli 
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-9-cli-3040.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli proxy-deb-2-9-cli-3040.md
## deb 2.9 ui 
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-9-ui-3041.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui proxy-deb-2-9-ui-3041.md
## deb 3.0 cli
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-3-0-cli-4083.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli proxy-deb-3-0-cli-4083.md
## deb 3.0 ui
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-3-0-ui-4084.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui proxy-deb-3-0-ui-4084.md
## snap 2.9 cli
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-9-cli-3034.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli proxy-snap-2-9-cli-3034.md
## snap 2.9 ui
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-9-ui-3035.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui proxy-snap-2-9-ui-3035.md
## snap 3.0 cli
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-3-0-cli-4081.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli proxy-snap-3-0-cli-4081.md
## snap 3.0 ui
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-3-0-ui-4082.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui proxy-snap-3-0-ui-4082.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4082 4082
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p proxy-snap-3-0-ui-4082.md proxy.md
## remove reference version
	cd $(DISC) && rm proxy-snap-3-0-ui-4082.md

$(DISC)/proxy-log.md: $(SRC)/proxy-log.md
## deb 2.9 cli
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-9-cli-3465.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli proxy-log-deb-2-9-cli-3465.md
## deb 2.9 ui
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-9-ui-3464.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui proxy-log-deb-2-9-ui-3464.md
## deb 3.0 cli
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-3-0-cli-4079.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli proxy-log-deb-3-0-cli-4079.md
## deb 3.0 ui
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-3-0-ui-4080.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui proxy-log-deb-3-0-ui-4080.md
## snap 2.9 cli
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-9-cli-3458.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli proxy-log-snap-2-9-cli-3458.md
## snap 2.9 ui
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-9-ui-3459.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui proxy-log-snap-2-9-ui-3459.md
## snap 3.0 cli
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-3-0-cli-4077.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli proxy-log-snap-3-0-cli-4077.md
## snap 3.0 ui
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-3-0-ui-4078.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui proxy-log-snap-3-0-ui-4078.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4078 4078
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p proxy-log-snap-3-0-ui-4078.md proxy-log.md
## remove reference version
	cd $(DISC) && rm proxy-log-snap-3-0-ui-4078.md

$(DISC)/python-api-client.md: $(SRC)/python-api-client.md
	cp $(SRC)/python-api-client.md $(MODWD)/python-api-client-810.md
	cd $(MODWD) &&\
	xpub push $(DISC) python-api-client-810.md
	cd $(DISC) &&\
	xpub pull $(DISC) 810 810
	cd $(DISC) &&\
	cp -p python-api-client-810.md python-api-client.md
	cd $(DISC) && rm python-api-client-810.md

#r

$(DISC)/rack-controllers.md: $(SRC)/rack-controllers.md
## deb 2.9 cli
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-9-cli-3058.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli rack-controllers-snap-2-9-cli-3058.md
## deb 2.9 ui
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-9-ui-3059.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui rack-controllers-snap-2-9-ui-3059.md
## deb 3.0 cli
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-3-0-cli-4089.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli rack-controllers-snap-3-0-cli-4089.md
## deb 3.0 ui
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-3-0-ui-4090.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui rack-controllers-snap-3-0-ui-4090.md
## snap 2.9 cli
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-9-cli-3064.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli rack-controllers-deb-2-9-cli-3064.md
## snap 2.9 ui
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-9-ui-3065.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui rack-controllers-deb-2-9-ui-3065.md
## snap 3.0 cli
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-3-0-cli-4091.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli rack-controllers-deb-3-0-cli-4091.md
## snap 3.0 ui
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-3-0-ui-4092.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui rack-controllers-deb-3-0-ui-4092.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4090 4090
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p rack-controllers-snap-3-0-ui-4090.md rack-controllers.md
## remove reference version
	cd $(DISC) && rm rack-controllers-snap-3-0-ui-4090.md

$(DISC)/region-controllers.md: $(SRC)/region-controllers.md
## deb 2.9 cli
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-9-cli-3076.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli region-controllers-deb-2-9-cli-3076.md
## deb 2.9 ui
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-9-ui-3077.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui region-controllers-deb-2-9-ui-3077.md
## deb 3.0 cli
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-3-0-cli-4095.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli region-controllers-deb-3-0-cli-4095.md
## deb 3.0 ui
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-3-0-ui-4096.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui region-controllers-deb-3-0-ui-4096.md
## snap 2.9 cli
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-9-cli-3070.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli region-controllers-snap-2-9-cli-3070.md
## snap 2.9 ui
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-9-ui-3071.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui region-controllers-snap-2-9-ui-3071.md
## snap 3.0 cli
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-3-0-cli-4093.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli region-controllers-snap-3-0-cli-4093.md
## snap 3.0 ui
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-3-0-ui-4094.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui region-controllers-snap-3-0-ui-4094.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4094 4094
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p region-controllers-snap-3-0-ui-4094.md region-controllers.md
## remove reference version
	cd $(DISC) && rm region-controllers-snap-3-0-ui-4094.md

$(DISC)/report-a-bug.md: $(SRC)/report-a-bug.md 
	cp $(SRC)/report-a-bug.md $(MODWD)/report-a-bug-4446.md
	cd $(MODWD) &&\
	xpub push $(DISC) report-a-bug-4446.md
	cd $(DISC) &&\
	xpub pull $(DISC) 4446 4446
	cd $(DISC) &&\
	cp -p report-a-bug-4446.md report-a-bug.md
	cd $(DISC) && rm report-a-bug-4446.md

$(DISC)/request-a-feature.md: $(SRC)/request-a-feature.md 
	cp $(SRC)/request-a-feature.md $(MODWD)/request-a-feature-4447.md
	cd $(MODWD) &&\
	xpub push $(DISC) request-a-feature-4447.md
	cd $(DISC) &&\
	xpub pull $(DISC) 4447 4447
	cd $(DISC) &&\
	cp -p request-a-feature-4447.md request-a-feature.md
	cd $(DISC) && rm request-a-feature-4447.md

$(DISC)/resource-pools.md: $(SRC)/resource-pools.md
## deb 2.9 cli
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-9-cli-3088.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli resource-pools-deb-2-9-cli-3088.md
## deb 2.9 ui
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-9-ui-3089.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui resource-pools-deb-2-9-ui-3089.md
## deb 3.0 cli
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-3-0-cli-4099.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli resource-pools-deb-3-0-cli-4099.md
## deb 3.0 ui
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-3-0-ui-4100.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui resource-pools-deb-3-0-ui-4100.md
## snap 2.9 cli
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-9-cli-3082.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli resource-pools-snap-2-9-cli-3082.md
## snap 2.9 ui
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-9-ui-3083.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui resource-pools-snap-2-9-ui-3083.md
## snap 3.0 cli
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-3-0-cli-4097.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli resource-pools-snap-3-0-cli-4097.md
## snap 3.0 ui
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-3-0-ui-4098.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui resource-pools-snap-3-0-ui-4098.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4098 4098
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p resource-pools-snap-3-0-ui-4098.md resource-pools.md
## remove reference version
	cd $(DISC) && rm resource-pools-snap-3-0-ui-4098.md

#s

$(DISC)/select-and-import-images.md: $(SRC)/select-and-import-images.md
## deb 2.9 cli
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-9-cli-3100.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli select-and-import-images-deb-2-9-cli-3100.md
## deb 2.9 ui
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-9-ui-3101.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui select-and-import-images-deb-2-9-ui-3101.md
## deb 3.0 cli
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-3-0-cli-4103.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli select-and-import-images-deb-3-0-cli-4103.md
## deb 3.0 ui
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-3-0-ui-4104.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui select-and-import-images-deb-3-0-ui-4104.md
## snap 2.9 cli
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-9-cli-3094.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli select-and-import-images-snap-2-9-cli-3094.md
## snap 2.9 ui
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-9-ui-3095.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui select-and-import-images-snap-2-9-ui-3095.md
## snap 3.0 cli
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-3-0-cli-4101.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli select-and-import-images-snap-3-0-cli-4101.md
## snap 3.0 ui
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-3-0-ui-4102.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui select-and-import-images-snap-3-0-ui-4102.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4102 4102
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p select-and-import-images-snap-3-0-ui-4102.md select-and-import-images.md
## remove reference version
	cd $(DISC) && rm select-and-import-images-snap-3-0-ui-4102.md
 
$(DISC)/storage.md: $(SRC)/storage.md
## deb 2.9 cli
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-9-cli-3112.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli storage-deb-2-9-cli-3112.md
## deb 2.9 ui
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-9-ui-3113.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui storage-deb-2-9-ui-3113.md
## deb 3.0 cli
	cp $(SRC)/storage.md $(MODWD)/storage-deb-3-0-cli-4107.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli storage-deb-3-0-cli-4107.md
## deb 3.0 ui
	cp $(SRC)/storage.md $(MODWD)/storage-deb-3-0-ui-4108.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui storage-deb-3-0-ui-4108.md
## snap 2.9 cli
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-9-cli-3106.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli storage-snap-2-9-cli-3106.md
## snap 2.9 ui
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-9-ui-3107.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui storage-snap-2-9-ui-3107.md
## snap 3.0 cli
	cp $(SRC)/storage.md $(MODWD)/storage-snap-3-0-cli-4105.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli storage-snap-3-0-cli-4105.md
## snap 3.0 ui
	cp $(SRC)/storage.md $(MODWD)/storage-snap-3-0-ui-4106.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui storage-snap-3-0-ui-4106.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4106 4106
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p storage-snap-3-0-ui-4106.md storage.md
## remove reference version
	cd $(DISC) && rm storage-snap-3-0-ui-4106.md

$(DISC)/subnet-management.md: $(SRC)/subnet-management.md
## deb 2.9 cli
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-9-cli-3124.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli subnet-management-deb-2-9-cli-3124.md
## deb 2.9 ui
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-9-ui-3125.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui subnet-management-deb-2-9-ui-3125.md
## deb 3.0 cli
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-3-0-cli-4111.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli subnet-management-deb-3-0-cli-4111.md
## deb 3.0 ui
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-3-0-ui-4112.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui subnet-management-deb-3-0-ui-4112.md
## snap 2.9 cli
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-9-cli-3118.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli subnet-management-snap-2-9-cli-3118.md
## snap 2.9 ui
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-9-ui-3119.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui subnet-management-snap-2-9-ui-3119.md
## snap 3.0 cli
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-3-0-cli-4109.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli subnet-management-snap-3-0-cli-4109.md
## snap 3.0 ui
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-3-0-ui-4110.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui subnet-management-snap-3-0-ui-4110.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4110 4110
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p subnet-management-snap-3-0-ui-4110.md subnet-management.md
## remove reference version
	cd $(DISC) && rm subnet-management-snap-3-0-ui-4110.md

#t

$(DISC)/test-logs.md: $(SRC)/test-logs.md
## deb 2.9 cli
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-9-cli-3136.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli test-logs-deb-2-9-cli-3136.md
## deb 2.9 ui
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-9-ui-3137.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui test-logs-deb-2-9-ui-3137.md
## deb 3.0 cli
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-3-0-cli-4119.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli test-logs-deb-3-0-cli-4119.md
## deb 3.0 ui
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-3-0-ui-4120.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui test-logs-deb-3-0-ui-4120.md
## snap 2.9 cli
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-9-cli-3130.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli test-logs-snap-2-9-cli-3130.md
## snap 2.9 ui
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-9-ui-3131.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui test-logs-snap-2-9-ui-3131.md
## snap 3.0 cli
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-3-0-cli-4117.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli test-logs-snap-3-0-cli-4117.md
## snap 3.0 ui
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-3-0-ui-4118.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui test-logs-snap-3-0-ui-4118.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4118 4118
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p test-logs-snap-3-0-ui-4118.md test-logs.md
## remove reference version
	cd $(DISC) && rm test-logs-snap-3-0-ui-4118.md

$(DISC)/tips-tricks-and-traps.md: $(SRC)/tips-tricks-and-traps.md
## deb 2.9 cli
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-deb-2-9-cli-3160.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli tips-tricks-and-traps-deb-2-9-cli-3160.md
## deb 2.9 ui
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-deb-2-9-ui-3161.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui tips-tricks-and-traps-deb-2-9-ui-3161.md
## deb 3.0 cli
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-deb-3-0-cli-4131.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli tips-tricks-and-traps-deb-3-0-cli-4131.md
## deb 3.0 ui
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-deb-3-0-ui-4132.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui tips-tricks-and-traps-deb-3-0-ui-4132.md
## snap 2.9 cli
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-snap-2-9-cli-3154.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli tips-tricks-and-traps-snap-2-9-cli-3154.md
## snap 2.9 ui
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-snap-2-9-ui-3155.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui tips-tricks-and-traps-snap-2-9-ui-3155.md
## snap 3.0 cli
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-snap-3-0-cli-4129.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli tips-tricks-and-traps-snap-3-0-cli-4129.md
## snap 3.0 ui
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-snap-3-0-ui-4130.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui tips-tricks-and-traps-snap-3-0-ui-4130.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4130 4130
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p tips-tricks-and-traps-snap-3-0-ui-4130.md tips-tricks-and-traps.md
## remove reference version
	cd $(DISC) && rm tips-tricks-and-traps-snap-3-0-ui-4130.md

$(DISC)/troubleshooting.md: $(SRC)/troubleshooting.md
## deb 2.9 cli
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-deb-2-9-cli-3172.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli troubleshooting-deb-2-9-cli-3172.md
## deb 2.9 ui
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-deb-2-9-ui-3173.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui troubleshooting-deb-2-9-ui-3173.md
## deb 3.0 cli
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-deb-3-0-cli-4135.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli troubleshooting-deb-3-0-cli-4135.md
## deb 3.0 ui
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-deb-3-0-ui-4136.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui troubleshooting-deb-3-0-ui-4136.md
## snap 2.9 cli
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-snap-2-9-cli-3166.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli troubleshooting-snap-2-9-cli-3166.md
## snap 2.9 ui
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-snap-2-9-ui-3167.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui troubleshooting-snap-2-9-ui-3167.md
## snap 3.0 cli
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-snap-3-0-cli-4133.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli troubleshooting-snap-3-0-cli-4133.md
## snap 3.0 ui
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-snap-3-0-ui-4134.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui troubleshooting-snap-3-0-ui-4134.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4134 4134
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p troubleshooting-snap-3-0-ui-4134.md troubleshooting.md
## remove reference version
	cd $(DISC) && rm troubleshooting-snap-3-0-ui-4134.md
 
#u

$(DISC)/ubuntu-kernels.md: $(SRC)/ubuntu-kernels.md
## deb 2.9 cli
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-9-cli-3184.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli ubuntu-kernels-deb-2-9-cli-3184.md
## deb 2.9 ui
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-9-ui-3185.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui ubuntu-kernels-deb-2-9-ui-3185.md
## deb 3.0 cli
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-3-0-cli-4139.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli ubuntu-kernels-deb-3-0-cli-4139.md
## deb 3.0 ui
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-3-0-ui-4140.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui ubuntu-kernels-deb-3-0-ui-4140.md
## snap 2.9 cli
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-9-cli-3178.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli ubuntu-kernels-snap-2-9-cli-3178.md
## snap 2.9 ui
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-9-ui-3179.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui ubuntu-kernels-snap-2-9-ui-3179.md
## snap 3.0 cli
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-3-0-cli-4137.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli ubuntu-kernels-snap-3-0-cli-4137.md
## snap 3.0 ui
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-3-0-ui-4138.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui ubuntu-kernels-snap-3-0-ui-4138.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4138 4138
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p ubuntu-kernels-snap-3-0-ui-4138.md ubuntu-kernels.md
## remove reference version
	cd $(DISC) && rm ubuntu-kernels-snap-3-0-ui-4138.md
 
$(DISC)/user-accounts.md: $(SRC)/user-accounts.md
## deb 2.9 cli
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-9-cli-3208.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli user-accounts-deb-2-9-cli-3208.md
## deb 2.9 ui
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-9-ui-3209.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui user-accounts-deb-2-9-ui-3209.md
## deb 3.0 cli
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-3-0-cli-4147.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli user-accounts-deb-3-0-cli-4147.md
## deb 3.0 ui
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-3-0-ui-4148.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui user-accounts-deb-3-0-ui-4148.md
## snap 2.9 cli
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-9-cli-3202.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli user-accounts-snap-2-9-cli-3202.md
## snap 2.9 ui
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-9-ui-3203.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui user-accounts-snap-2-9-ui-3203.md
## snap 3.0 cli
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-3-0-cli-4145.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli user-accounts-snap-3-0-cli-4145.md
## snap 3.0 ui
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-3-0-ui-4146.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui user-accounts-snap-3-0-ui-4146.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4146 4146
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p user-accounts-snap-3-0-ui-4146.md user-accounts.md
## remove reference version
	cd $(DISC) && rm user-accounts-snap-3-0-ui-4146.md

$(DISC)/maas-projects.md: $(SRC)/maas-projects.md
## copy master to discourse topic-named file
	cp $(SRC)/maas-projects.md $(MODWD)/maas-projects-4460.md
## push updated master to discourse
	cd $(MODWD) &&\
	xpub push $(DISC) maas-projects-4460.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4460 4460
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p maas-projects-4460.md maas-projects.md
## remove reference version
	cd $(DISC) && rm maas-projects-4460.md

$(DISC)/maas-project-tutorial.md: $(SRC)/maas-project-tutorial.md
## copy master to discourse topic-named file
	cp $(SRC)/maas-project-tutorial.md $(MODWD)/maas-project-tutorial-4478.md
## push updated master to discourse
	cd $(MODWD) &&\
	xpub push $(DISC) maas-project-tutorial-4478.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4478 4478
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p maas-project-tutorial-4478.md maas-project-tutorial.md
## remove reference version
	cd $(DISC) && rm maas-project-tutorial-4478.md

$(DISC)/using-maas-in-an-air-gapped-environment.md: $(SRC)/using-maas-in-an-air-gapped-environment.md
## deb 2.9 cli
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-deb-2-9-cli-4270.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli using-maas-in-an-air-gapped-environment-deb-2-9-cli-4270.md
## deb 2.9 ui
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-deb-2-9-ui-4275.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui using-maas-in-an-air-gapped-environment-deb-2-9-ui-4275.md
## deb 3.0 cli
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-deb-3-0-cli-4155.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli using-maas-in-an-air-gapped-environment-deb-3-0-cli-4155.md
## deb 3.0 ui
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-deb-3-0-ui-4156.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui using-maas-in-an-air-gapped-environment-deb-3-0-ui-4156.md
## snap 2.9 cli
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-snap-2-9-cli-4274.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli using-maas-in-an-air-gapped-environment-snap-2-9-cli-4274.md
## snap 2.9 ui
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-snap-2-9-ui-4273.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui using-maas-in-an-air-gapped-environment-snap-2-9-ui-4273.md
## snap 3.0 cli
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-snap-3-0-cli-4153.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli using-maas-in-an-air-gapped-environment-snap-3-0-cli-4153.md
## snap 3.0 ui
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-snap-3-0-ui-4154.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui using-maas-in-an-air-gapped-environment-snap-3-0-ui-4154.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4154 4154
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p using-maas-in-an-air-gapped-environment-snap-3-0-ui-4154.md using-maas-in-an-air-gapped-environment.md
## remove reference version
	cd $(DISC) && rm using-maas-in-an-air-gapped-environment-snap-3-0-ui-4154.md

$(DISC)/using-image-streams.md: $(SRC)/using-image-streams.md
## snap 2.7 cli
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-snap-2-7-cli-4324.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli using-image-streams-snap-2-7-cli-4324.md
## snap 2.7 ui
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-snap-2-7-ui-4325.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui using-image-streams-snap-2-7-ui-4325.md
## snap 2.8 cli
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-snap-2-8-cli-4326.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli using-image-streams-snap-2-8-cli-4326.md
## snap 2.8 ui
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-snap-2-8-ui-4327.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui using-image-streams-snap-2-8-ui-4327.md
## snap 2.9 cli
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-snap-2-9-cli-4328.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli using-image-streams-snap-2-9-cli-4328.md
## snap 2.9 ui
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-snap-2-9-ui-4329.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui using-image-streams-snap-2-9-ui-4329.md
## snap 3.0 cli
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-snap-3-0-cli-4149.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli using-image-streams-snap-3-0-cli-4149.md
## snap 3.0 ui
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-snap-3-0-ui-4150.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui using-image-streams-snap-3-0-ui-4150.md
## deb 2.9 cli
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-deb-2-9-cli-4334.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli using-image-streams-deb-2-9-cli-4334.md
## deb 2.9 ui
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-deb-2-9-ui-4335.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui using-image-streams-deb-2-9-ui-4335.md
## deb 3.0 cli
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-deb-3-0-cli-4151.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli using-image-streams-deb-3-0-cli-4151.md
## deb 3.0 ui
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-deb-3-0-ui-4152.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui using-image-streams-deb-3-0-ui-4152.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4150 4150
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p using-image-streams-snap-3-0-ui-4150.md using-image-streams.md
## remove reference version
	cd $(DISC) && rm using-image-streams-snap-3-0-ui-4150.md

#v

$(DISC)/vm-hosting.md: $(SRC)/vm-hosting.md
## deb 2.9 cli
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-9-cli-2752.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli vm-hosting-deb-2-9-cli-2752.md
## deb 2.9 ui
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-9-ui-2753.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui vm-hosting-deb-2-9-ui-2753.md
## deb 3.0 cli
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-3-0-cli-4163.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli vm-hosting-deb-3-0-cli-4163.md
## deb 3.0 ui
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-3-0-ui-4164.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui vm-hosting-deb-3-0-ui-4164.md
## snap 2.9 cli
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-9-cli-2746.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli vm-hosting-snap-2-9-cli-2746.md
## snap 2.9 ui
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-9-ui-2747.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui vm-hosting-snap-2-9-ui-2747.md
## snap 3.0 cli
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-3-0-cli-4161.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli vm-hosting-snap-3-0-cli-4161.md
## snap 3.0 ui
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-3-0-ui-4162.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui vm-hosting-snap-3-0-ui-4162.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4162 4162
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p vm-hosting-snap-3-0-ui-4162.md vm-hosting.md
## remove reference version
	cd $(DISC) && rm vm-hosting-snap-3-0-ui-4162.md
 
$(DISC)/vm-host-networking.md: $(SRC)/vm-host-networking.md
## deb 2.9 cli
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-9-cli-3220.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli vm-host-networking-deb-2-9-cli-3220.md
## deb 2.9 ui
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-9-ui-3221.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui vm-host-networking-deb-2-9-ui-3221.md
## deb 3.0 cli
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-3-0-cli-4167.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli vm-host-networking-deb-3-0-cli-4167.md
## deb 3.0 ui
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-3-0-ui-4168.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui vm-host-networking-deb-3-0-ui-4168.md
## snap 2.9 cli
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-9-cli-3214.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli vm-host-networking-snap-2-9-cli-3214.md
## snap 2.9 ui
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-9-ui-3215.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui vm-host-networking-snap-2-9-ui-3215.md
## snap 3.0 cli
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-3-0-cli-4165.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli vm-host-networking-snap-3-0-cli-4165.md
## snap 3.0 ui
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-3-0-ui-4166.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui vm-host-networking-snap-3-0-ui-4166.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4166 4166
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p vm-host-networking-snap-3-0-ui-4166.md vm-host-networking.md
## remove reference version
	cd $(DISC) && rm vm-host-networking-snap-3-0-ui-4166.md
 
$(DISC)/vm-host-storage-pools.md: $(SRC)/vm-host-storage-pools.md
## deb 2.9 cli
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-9-cli-3232.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli vm-host-storage-pools-deb-2-9-cli-3232.md
## deb 2.9 ui
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-9-ui-3233.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui vm-host-storage-pools-deb-2-9-ui-3233.md
## deb 3.0 cli
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-3-0-cli-4171.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli vm-host-storage-pools-deb-3-0-cli-4171.md
## deb 3.0 ui
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-3-0-ui-4172.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui vm-host-storage-pools-deb-3-0-ui-4172.md
## snap 2.9 cli
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-9-cli-3226.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli vm-host-storage-pools-snap-2-9-cli-3226.md
## snap 2.9 ui
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-9-ui-3227.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui vm-host-storage-pools-snap-2-9-ui-3227.md
## snap 3.0 cli
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-3-0-cli-4169.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli vm-host-storage-pools-snap-3-0-cli-4169.md
## snap 3.0 ui
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-3-0-ui-4170.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui vm-host-storage-pools-snap-3-0-ui-4170.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4170 4170
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p vm-host-storage-pools-snap-3-0-ui-4170.md vm-host-storage-pools.md
## remove reference version
	cd $(DISC) && rm vm-host-storage-pools-snap-3-0-ui-4170.md
 
$(DISC)/vmware-images.md: $(SRC)/vmware-images.md
## deb 2.9 cli
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-9-cli-3244.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli vmware-images-deb-2-9-cli-3244.md
## deb 2.9 ui
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-9-ui-3245.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui vmware-images-deb-2-9-ui-3245.md
## deb 3.0 cli
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-3-0-cli-4175.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli vmware-images-deb-3-0-cli-4175.md
## deb 3.0 ui
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-3-0-ui-4176.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui vmware-images-deb-3-0-ui-4176.md
## snap 2.9 cli
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-9-cli-3238.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli vmware-images-snap-2-9-cli-3238.md
## snap 2.9 ui
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-9-ui-3239.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui vmware-images-snap-2-9-ui-3239.md
## snap 3.0 cli
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-3-0-cli-4173.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli vmware-images-snap-3-0-cli-4173.md
## snap 3.0 ui
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-3-0-ui-4174.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui vmware-images-snap-3-0-ui-4174.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4174 4174
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p vmware-images-snap-3-0-ui-4174.md vmware-images.md
## remove reference version
	cd $(DISC) && rm vmware-images-snap-3-0-ui-4174.md
 
$(DISC)/vmware-vmfs-datastores.md: $(SRC)/vmware-vmfs-datastores.md
## deb 2.9 cli
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-9-cli-3256.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli vmware-vmfs-datastores-deb-2-9-cli-3256.md
## deb 2.9 ui
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-9-ui-3257.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui vmware-vmfs-datastores-deb-2-9-ui-3257.md
## deb 3.0 cli
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-3-0-cli-4179.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli vmware-vmfs-datastores-deb-3-0-cli-4179.md
## deb 3.0 ui
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-3-0-ui-4180.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui vmware-vmfs-datastores-deb-3-0-ui-4180.md
## snap 2.9 cli
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-9-cli-3250.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli vmware-vmfs-datastores-snap-2-9-cli-3250.md
## snap 2.9 ui
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-9-ui-3251.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui vmware-vmfs-datastores-snap-2-9-ui-3251.md
## snap 3.0 cli
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-3-0-cli-4177.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli vmware-vmfs-datastores-snap-3-0-cli-4177.md
## snap 3.0 ui
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-3-0-ui-4178.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui vmware-vmfs-datastores-snap-3-0-ui-4178.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4178 4178
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p vmware-vmfs-datastores-snap-3-0-ui-4178.md vmware-vmfs-datastores.md
## remove reference version
	cd $(DISC) && rm vmware-vmfs-datastores-snap-3-0-ui-4178.md

#w

$(DISC)/whats-new-in-maas.md: $(SRC)/whats-new-in-maas.md
## deb 2.9 cli
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-deb-2-9-cli-4290.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli whats-new-in-maas-deb-2-9-cli-4290.md
## deb 2.9 ui
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-deb-2-9-ui-4291.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui whats-new-in-maas-deb-2-9-ui-4291.md
## deb 3.0 cli
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-deb-3-0-cli-4289.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli whats-new-in-maas-deb-3-0-cli-4289.md
## deb 3.0 ui
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-deb-3-0-ui-4184.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui whats-new-in-maas-deb-3-0-ui-4184.md
## snap 2.9 cli
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-snap-2-9-cli-4296.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli whats-new-in-maas-snap-2-9-cli-4296.md
## snap 2.9 ui
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-snap-2-9-ui-4297.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui whats-new-in-maas-snap-2-9-ui-4297.md
## snap 3.0 cli
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-snap-3-0-cli-4181.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli whats-new-in-maas-snap-3-0-cli-4181.md
## snap 3.0 ui
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-snap-3-0-ui-4182.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui whats-new-in-maas-snap-3-0-ui-4182.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4182 4182
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p whats-new-in-maas-snap-3-0-ui-4182.md whats-new-in-maas.md
## remove reference version
	cd $(DISC) && rm whats-new-in-maas-snap-3-0-ui-4182.md

$(DISC)/writing-guide.md: $(SRC)/writing-guide.md
## deb 2.9 cli
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-deb-2-9-cli-3268.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli writing-guide-deb-2-9-cli-3268.md
## deb 2.9 ui
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-deb-2-9-ui-3269.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui writing-guide-deb-2-9-ui-3269.md
## deb 3.0 cli
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-deb-3-0-cli-4187.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli writing-guide-deb-3-0-cli-4187.md
## deb 3.0 ui
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-deb-3-0-ui-4188.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui writing-guide-deb-3-0-ui-4188.md
## snap 2.9 cli
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-snap-2-9-cli-3262.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli writing-guide-snap-2-9-cli-3262.md
## snap 2.9 ui
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-snap-2-9-ui-3263.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui writing-guide-snap-2-9-ui-3263.md
## snap 3.0 cli
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-snap-3-0-cli-4185.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli writing-guide-snap-3-0-cli-4185.md
## snap 3.0 ui
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-snap-3-0-ui-4186.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui writing-guide-snap-3-0-ui-4186.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4186 4186
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p writing-guide-snap-3-0-ui-4186.md writing-guide.md
## remove reference version
	cd $(DISC) && rm writing-guide-snap-3-0-ui-4186.md

#z

$(DISC)/zone-examples.md: $(SRC)/zone-examples.md
## deb 2.9 cli
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-9-cli-3280.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli zone-examples-deb-2-9-cli-3280.md
## deb 2.9 ui
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-9-ui-3281.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui zone-examples-deb-2-9-ui-3281.md
## deb 3.0 cli
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-3-0-cli-4191.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-cli zone-examples-deb-3-0-cli-4191.md
## deb 3.0 ui
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-3-0-ui-4192.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-3-0-ui zone-examples-deb-3-0-ui-4192.md
## snap 2.9 cli
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-9-cli-3274.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-cli zone-examples-snap-2-9-cli-3274.md
## snap 2.9 ui
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-9-ui-3275.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-9-ui zone-examples-snap-2-9-ui-3275.md
## snap 3.0 cli
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-3-0-cli-4189.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-cli zone-examples-snap-3-0-cli-4189.md
## snap 3.0 ui
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-3-0-ui-4190.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-3-0-ui zone-examples-snap-3-0-ui-4190.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4190 4190
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p zone-examples-snap-3-0-ui-4190.md zone-examples.md
## remove reference version
	cd $(DISC) && rm zone-examples-snap-3-0-ui-4190.md
 
