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
V27  := 2.7
V28  := 2.8
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
## deb 2.7 cli
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-7-cli-2268.md 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-7-cli about-maas-deb-2-7-cli-2268.md 
## deb 2.7 ui
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-7-ui-2269.md	 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-7-ui about-maas-deb-2-7-ui-2269.md  
## deb 2.8 cli
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-8-cli-2270.md 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-8-cli about-maas-deb-2-8-cli-2270.md 
## deb 2.8 ui
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-deb-2-8-ui-2271.md	 
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-8-ui about-maas-deb-2-8-ui-2271.md  
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
## snap 2.7 cli
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-7-cli-2262.md
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-7-cli about-maas-snap-2-7-cli-2262.md
## snap 2.7 ui
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-7-ui-2263.md 
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-7-ui about-maas-snap-2-7-ui-2263.md 
## snap 2.8 cli
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-8-cli-2264.md
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-8-cli about-maas-snap-2-8-cli-2264.md
## snap 2.8 ui
	cp $(SRC)/about-maas.md $(MODWD)/about-maas-snap-2-8-ui-2265.md 
	cd $(MODWD) &&\
	xpub push discourse -t snap-2-8-ui about-maas-snap-2-8-ui-2265.md 
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
## deb 2.7 cli
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-7-cli-2292.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-7-cli adding-a-vm-host-deb-2-7-cli-2292.md
## deb 2.7 ui
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-7-ui-2293.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-7-ui adding-a-vm-host-deb-2-7-ui-2293.md
## deb 2.8 cli
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-8-cli-2294.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-8-cli adding-a-vm-host-deb-2-8-cli-2294.md
## deb 2.8 ui
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-deb-2-8-ui-2295.md
	cd $(MODWD) &&\
	xpub push discourse -t deb-2-8-ui adding-a-vm-host-deb-2-8-ui-2295.md
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
## snap 2.7 cli
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-7-cli-2286.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli adding-a-vm-host-snap-2-7-cli-2286.md
## snap 2.7 ui
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-7-ui-2287.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui adding-a-vm-host-snap-2-7-ui-2287.md
## snap 2.8 cli
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-8-cli-2288.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli adding-a-vm-host-snap-2-8-cli-2288.md
## snap 2.8 ui
	cp $(SRC)/adding-a-vm-host.md $(MODWD)/adding-a-vm-host-snap-2-8-ui-2289.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui adding-a-vm-host-snap-2-8-ui-2289.md
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
## deb 2.7 cli
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-7-cli-2280.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli add-machines-deb-2-7-cli-2280.md
## deb 2.7 ui
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-7-ui-2281.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui add-machines-deb-2-7-ui-2281.md
## deb 2.8 cli
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-8-cli-2282.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli add-machines-deb-2-8-cli-2282.md
## deb 2.8 ui
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-deb-2-8-ui-2283.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui add-machines-deb-2-8-ui-2283.md
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
## snap 2.7 cli
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-7-cli-2274.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli add-machines-snap-2-7-cli-2274.md
## snap 2.7 ui
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-7-ui-2275.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui add-machines-snap-2-7-ui-2275.md
## snap 2.8 cli
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-8-cli-2276.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli add-machines-snap-2-8-cli-2276.md
## snap 2.8 ui
	cp $(SRC)/add-machines.md $(MODWD)/add-machines-snap-2-8-ui-2277.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui add-machines-snap-2-8-ui-2277.md
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
## deb 2.7 cli
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-deb-2-7-cli-2304.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli api-authentication-deb-2-7-cli-2304.md
## deb 2.7 ui
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-deb-2-7-ui-2305.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui api-authentication-deb-2-7-ui-2305.md
## deb 2.8 cli
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-deb-2-8-cli-2306.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli api-authentication-deb-2-8-cli-2306.md
## deb 2.8 ui
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-deb-2-8-ui-2307.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui api-authentication-deb-2-8-ui-2307.md
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
## snap 2.7 cli
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-snap-2-7-cli-2298.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli api-authentication-snap-2-7-cli-2298.md
## snap 2.7 ui
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-snap-2-7-ui-2299.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui api-authentication-snap-2-7-ui-2299.md
## snap 2.8 cli
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-snap-2-8-cli-2300.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli api-authentication-snap-2-8-cli-2300.md
## snap 2.8 ui
	cp $(SRC)/api-authentication.md $(MODWD)/api-authentication-snap-2-8-ui-2301.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui api-authentication-snap-2-8-ui-2301.md
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
## deb 2.7 cli
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-deb-2-7-cli-2316.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli audit-event-logs-deb-2-7-cli-2316.md
## deb 2.7 ui
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-deb-2-7-ui-2317.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui audit-event-logs-deb-2-7-ui-2317.md
## deb 2.8 cli
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-deb-2-8-cli-2318.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli audit-event-logs-deb-2-8-cli-2318.md
## deb 2.8 ui
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-deb-2-8-ui-2319.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui audit-event-logs-deb-2-8-ui-2319.md
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
## snap 2.7 cli
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-snap-2-7-cli-2310.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli audit-event-logs-snap-2-7-cli-2310.md
## snap 2.7 ui
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-snap-2-7-ui-2311.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui audit-event-logs-snap-2-7-ui-2311.md
## snap 2.8 cli
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-snap-2-8-cli-2312.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli audit-event-logs-snap-2-8-cli-2312.md
## snap 2.8 ui
	cp $(SRC)/audit-event-logs.md $(MODWD)/audit-event-logs-snap-2-8-ui-2313.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui audit-event-logs-snap-2-8-ui-2313.md
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
## deb 2.7 cli
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-7-cli-2328.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli availability-zones-deb-2-7-cli-2328.md
## deb 2.7 ui
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-7-ui-2329.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui availability-zones-deb-2-7-ui-2329.md
## deb 2.8 cli
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-8-cli-2330.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli availability-zones-deb-2-8-cli-2330.md
## deb 2.8 ui
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-deb-2-8-ui-2331.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui availability-zones-deb-2-8-ui-2331.md
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
## snap 2.7 cli
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-7-cli-2322.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli availability-zones-snap-2-7-cli-2322.md
## snap 2.7 ui
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-7-ui-2323.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui availability-zones-snap-2-7-ui-2323.md
## snap 2.8 cli
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-8-cli-2324.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli availability-zones-snap-2-8-cli-2324.md
## snap 2.8 ui
	cp $(SRC)/availability-zones.md $(MODWD)/availability-zones-snap-2-8-ui-2325.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui availability-zones-snap-2-8-ui-2325.md
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
## deb 2.7 cli
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-7-cli-2340.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli backup-deb-2-7-cli-2340.md
## deb 2.7 ui
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-7-ui-2341.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui backup-deb-2-7-ui-2341.md
## deb 2.8 cli
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-8-cli-2342.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli backup-deb-2-8-cli-2342.md
## deb 2.8 ui
	cp $(SRC)/backup.md $(MODWD)/backup-deb-2-8-ui-2343.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui backup-deb-2-8-ui-2343.md
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
## snap 2.7 cli
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-7-cli-2334.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli backup-snap-2-7-cli-2334.md
## snap 2.7 ui
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-7-ui-2335.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui backup-snap-2-7-ui-2335.md
## snap 2.8 cli
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-8-cli-2336.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli backup-snap-2-8-cli-2336.md
## snap 2.8 ui
	cp $(SRC)/backup.md $(MODWD)/backup-snap-2-8-ui-2337.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui backup-snap-2-8-ui-2337.md
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
## deb 2.7 cli
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-7-cli-2352.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli block-devices-deb-2-7-cli-2352.md
## deb 2.7 ui
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-7-ui-2353.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui block-devices-deb-2-7-ui-2353.md
## deb 2.8 cli
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-8-cli-2354.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli block-devices-deb-2-8-cli-2354.md
## deb 2.8 ui
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-deb-2-8-ui-2355.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui block-devices-deb-2-8-ui-2355.md
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
## snap 2.7 cli
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-7-cli-2346.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli block-devices-snap-2-7-cli-2346.md
## snap 2.7 ui
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-7-ui-2347.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui block-devices-snap-2-7-ui-2347.md
## snap 2.8 cli
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-8-cli-2348.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli block-devices-snap-2-8-cli-2348.md
## snap 2.8 ui
	cp $(SRC)/block-devices.md $(MODWD)/block-devices-snap-2-8-ui-2349.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui block-devices-snap-2-8-ui-2349.md
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
## deb 2.7 cli
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-7-cli-2484.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli commissioning-and-hardware-testing-scripts-deb-2-7-cli-2484.md
## deb 2.7 ui
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-7-ui-2485.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui commissioning-and-hardware-testing-scripts-deb-2-7-ui-2485.md
## deb 2.8 cli
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-8-cli-2486.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli commissioning-and-hardware-testing-scripts-deb-2-8-cli-2486.md
## deb 2.8 ui
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-deb-2-8-ui-2487.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui commissioning-and-hardware-testing-scripts-deb-2-8-ui-2487.md
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
## snap 2.7 cli
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-7-cli-2478.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli commissioning-and-hardware-testing-scripts-snap-2-7-cli-2478.md
## snap 2.7 ui
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-7-ui-2479.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui commissioning-and-hardware-testing-scripts-snap-2-7-ui-2479.md
## snap 2.8 cli
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-8-cli-2480.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli commissioning-and-hardware-testing-scripts-snap-2-8-cli-2480.md
## snap 2.8 ui
	cp $(SRC)/commissioning-and-hardware-testing-scripts.md $(MODWD)/commissioning-and-hardware-testing-scripts-snap-2-8-ui-2481.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui commissioning-and-hardware-testing-scripts-snap-2-8-ui-2481.md
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
## deb 2.7 cli
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-7-cli-2496.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli commissioning-logs-deb-2-7-cli-2496.md
## deb 2.7 ui
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-7-ui-2497.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui commissioning-logs-deb-2-7-ui-2497.md
## deb 2.8 cli
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-8-cli-2498.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli commissioning-logs-deb-2-8-cli-2498.md
## deb 2.8 ui
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-deb-2-8-ui-2499.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui commissioning-logs-deb-2-8-ui-2499.md
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
## snap 2.7 cli
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-7-cli-2490.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli commissioning-logs-snap-2-7-cli-2490.md
## snap 2.7 ui
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-7-ui-2491.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui commissioning-logs-snap-2-7-ui-2491.md
## snap 2.8 cli
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-8-cli-2492.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli commissioning-logs-snap-2-8-cli-2492.md
## snap 2.8 ui
	cp $(SRC)/commissioning-logs.md $(MODWD)/commissioning-logs-snap-2-8-ui-2493.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui commissioning-logs-snap-2-8-ui-2493.md
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
## deb 2.7 cli
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-7-cli-2472.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli commission-machines-deb-2-7-cli-2472.md
## deb 2.7 ui
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-7-ui-2473.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui commission-machines-deb-2-7-ui-2473.md
## deb 2.8 cli
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-8-cli-2474.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli commission-machines-deb-2-8-cli-2474.md
## deb 2.8 ui
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-deb-2-8-ui-2475.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui commission-machines-deb-2-8-ui-2475.md
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
	xpub push $(DISC) -t deb-3-0-ui commission-machines-deb-3-0-ui-3876.md
## snap 2.7 cli
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-7-cli-2466.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli commission-machines-snap-2-7-cli-2466.md
## snap 2.7 ui
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-7-ui-2467.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui commission-machines-snap-2-7-ui-2467.md
## snap 2.8 cli
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-8-cli-2468.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli commission-machines-snap-2-8-cli-2468.md
## snap 2.8 ui
	cp $(SRC)/commission-machines.md $(MODWD)/commission-machines-snap-2-8-ui-2469.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui commission-machines-snap-2-8-ui-2469.md
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
## deb 2.7 cli
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-7-cli-2532.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli configuration-journey-deb-2-7-cli-2532.md
## deb 2.7 ui
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-7-ui-2533.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui configuration-journey-deb-2-7-ui-2533.md
## deb 2.8 cli
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-8-cli-2534.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli configuration-journey-deb-2-8-cli-2534.md
## deb 2.8 ui
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-deb-2-8-ui-2535.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui configuration-journey-deb-2-8-ui-2535.md
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
## snap 2.7 cli
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-7-cli-2526.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli configuration-journey-snap-2-7-cli-2526.md
## snap 2.7 ui
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-7-ui-2527.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui configuration-journey-snap-2-7-ui-2527.md
## snap 2.8 cli
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-8-cli-2528.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli configuration-journey-snap-2-8-cli-2528.md
## snap 2.8 ui
	cp $(SRC)/configuration-journey.md $(MODWD)/configuration-journey-snap-2-8-ui-2529.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui configuration-journey-snap-2-8-ui-2529.md
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
## deb 2.7 cli
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-7-cli-2544.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli configuring-tls-encryption-deb-2-7-cli-2544.md
## deb 2.7 ui
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-7-ui-2545.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui configuring-tls-encryption-deb-2-7-ui-2545.md
## deb 2.8 cli
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-8-cli-2546.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli configuring-tls-encryption-deb-2-8-cli-2546.md
## deb 2.8 ui
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-deb-2-8-ui-2547.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui configuring-tls-encryption-deb-2-8-ui-2547.md
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
## snap 2.7 cli
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-7-cli-2538.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli configuring-tls-encryption-snap-2-7-cli-2538.md
## snap 2.7 ui
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-7-ui-2539.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui configuring-tls-encryption-snap-2-7-ui-2539.md
## snap 2.8 cli
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-8-cli-2540.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli configuring-tls-encryption-snap-2-8-cli-2540.md
## snap 2.8 ui
	cp $(SRC)/configuring-tls-encryption.md $(MODWD)/configuring-tls-encryption-snap-2-8-ui-2541.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui configuring-tls-encryption-snap-2-8-ui-2541.md
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
 
# $(DISC)/contact-us.md: $(SRC)/contact-us.md
# 	cp $(SRC)/contact-us.md $(MODWD)/contact-us-743.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) contact-us-743.md
# 	cd $(DISC) &&\
# 	xpub pull $(DISC) 743 743
# 	cd $(DISC) &&\
# 	cp -p contact-us-743.md contact-us.md
# 	cd $(DISC) && rm contact-us-743.md

$(DISC)/controllers.md: $(SRC)/controllers.md
## deb 2.7 cli
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-7-cli-2724.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli controllers-deb-2-7-cli-2724.md
## deb 2.7 ui
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-7-ui-2725.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui controllers-deb-2-7-ui-2725.md
## deb 2.8 cli
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-8-cli-2726.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli controllers-deb-2-8-cli-2726.md
## deb 2.8 ui
	cp $(SRC)/controllers.md $(MODWD)/controllers-deb-2-8-ui-2727.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui controllers-deb-2-8-ui-2727.md
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
## snap 2.7 cli
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-7-cli-2718.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli controllers-snap-2-7-cli-2718.md
## snap 2.7 ui
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-7-ui-2719.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui controllers-snap-2-7-ui-2719.md
## snap 2.8 cli
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-8-cli-2720.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli controllers-snap-2-8-cli-2720.md
## snap 2.8 ui
	cp $(SRC)/controllers.md $(MODWD)/controllers-snap-2-8-ui-2721.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui controllers-snap-2-8-ui-2721.md
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
## deb 2.7 cli
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-7-cli-2568.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli creating-a-custom-ubuntu-image-deb-2-7-cli-2568.md
## deb 2.7 ui
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-7-ui-2569.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui creating-a-custom-ubuntu-image-deb-2-7-ui-2569.md
## deb 2.8 cli
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-8-cli-2570.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli creating-a-custom-ubuntu-image-deb-2-8-cli-2570.md
## deb 2.8 ui
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-deb-2-8-ui-2571.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui creating-a-custom-ubuntu-image-deb-2-8-ui-2571.md
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
## snap 2.7 cli
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-7-cli-2562.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli creating-a-custom-ubuntu-image-snap-2-7-cli-2562.md
## snap 2.7 ui
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-7-ui-2563.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui creating-a-custom-ubuntu-image-snap-2-7-ui-2563.md
## snap 2.8 cli
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-8-cli-2564.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli creating-a-custom-ubuntu-image-snap-2-8-cli-2564.md
## snap 2.8 ui
	cp $(SRC)/creating-a-custom-ubuntu-image.md $(MODWD)/creating-a-custom-ubuntu-image-snap-2-8-ui-2565.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui creating-a-custom-ubuntu-image-snap-2-8-ui-2565.md
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
## deb 2.7 cli
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-7-cli-2580.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli creating-and-deleting-vms-deb-2-7-cli-2580.md
## deb 2.7 ui
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-7-ui-2581.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui creating-and-deleting-vms-deb-2-7-ui-2581.md
## deb 2.8 cli
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-8-cli-2582.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli creating-and-deleting-vms-deb-2-8-cli-2582.md
## deb 2.8 ui
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-deb-2-8-ui-2583.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui creating-and-deleting-vms-deb-2-8-ui-2583.md
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
## snap 2.7 cli
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-7-cli-2574.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli creating-and-deleting-vms-snap-2-7-cli-2574.md
## snap 2.7 ui
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-7-ui-2575.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui creating-and-deleting-vms-snap-2-7-ui-2575.md
## snap 2.8 cli
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-8-cli-2576.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli creating-and-deleting-vms-snap-2-8-cli-2576.md
## snap 2.8 ui
	cp $(SRC)/creating-and-deleting-vms.md $(MODWD)/creating-and-deleting-vms-snap-2-8-ui-2577.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui creating-and-deleting-vms-snap-2-8-ui-2577.md
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
## deb 2.7 cli
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-7-cli-2592.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli custom-machine-setup-deb-2-7-cli-2592.md
## deb 2.7 ui
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-7-ui-2593.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui custom-machine-setup-deb-2-7-ui-2593.md
## deb 2.8 cli
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-8-cli-2594.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli custom-machine-setup-deb-2-8-cli-2594.md
## deb 2.8 ui
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-deb-2-8-ui-2595.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui custom-machine-setup-deb-2-8-ui-2595.md
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
## snap 2.7 cli
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-7-cli-2586.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli custom-machine-setup-snap-2-7-cli-2586.md
## snap 2.7 ui
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-7-ui-2587.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui custom-machine-setup-snap-2-7-ui-2587.md
## snap 2.8 cli
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-8-cli-2588.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli custom-machine-setup-snap-2-8-cli-2588.md
## snap 2.8 ui
	cp $(SRC)/custom-machine-setup.md $(MODWD)/custom-machine-setup-snap-2-8-ui-2589.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui custom-machine-setup-snap-2-8-ui-2589.md
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
## deb 2.7 cli
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-7-cli-2604.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli deploy-machines-deb-2-7-cli-2604.md
## deb 2.7 ui
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-7-ui-2605.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui deploy-machines-deb-2-7-ui-2605.md
## deb 2.8 cli
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-8-cli-2606.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli deploy-machines-deb-2-8-cli-2606.md
## deb 2.8 ui
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-deb-2-8-ui-2607.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui deploy-machines-deb-2-8-ui-2607.md
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
## snap 2.7 cli
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-7-cli-2598.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli deploy-machines-snap-2-7-cli-2598.md
## snap 2.7 ui
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-7-ui-2599.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui deploy-machines-snap-2-7-ui-2599.md
## snap 2.8 cli
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-8-cli-2600.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli deploy-machines-snap-2-8-cli-2600.md
## snap 2.8 ui
	cp $(SRC)/deploy-machines.md $(MODWD)/deploy-machines-snap-2-8-ui-2601.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui deploy-machines-snap-2-8-ui-2601.md
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
## deb 2.7 cli
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-7-cli-2616.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli disk-erasure-deb-2-7-cli-2616.md
## deb 2.7 ui
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-7-ui-2617.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui disk-erasure-deb-2-7-ui-2617.md
## deb 2.8 cli
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-8-cli-2618.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli disk-erasure-deb-2-8-cli-2618.md
## deb 2.8 ui
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-deb-2-8-ui-2619.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui disk-erasure-deb-2-8-ui-2619.md
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
## snap 2.7 cli
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-7-cli-2610.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli disk-erasure-snap-2-7-cli-2610.md
## snap 2.7 ui
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-7-ui-2611.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui disk-erasure-snap-2-7-ui-2611.md
## snap 2.8 cli
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-8-cli-2612.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli disk-erasure-snap-2-8-cli-2612.md
## snap 2.8 ui
	cp $(SRC)/disk-erasure.md $(MODWD)/disk-erasure-snap-2-8-ui-2613.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui disk-erasure-snap-2-8-ui-2613.md
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
## deb 2.7 cli
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-7-cli-3388.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli event-logs-deb-2-7-cli-3388.md
## deb 2.7 ui
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-7-ui-3389.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui event-logs-deb-2-7-ui-3389.md
## deb 2.8 cli
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-8-cli-3390.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli event-logs-deb-2-8-cli-3390.md
## deb 2.8 ui
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-deb-2-8-ui-3391.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui event-logs-deb-2-8-ui-3391.md
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
## snap 2.7 cli
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-7-cli-3382.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli event-logs-snap-2-7-cli-3382.md
## snap 2.7 ui
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-7-ui-3383.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui event-logs-snap-2-7-ui-3383.md
## snap 2.8 cli
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-8-cli-3384.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli event-logs-snap-2-8-cli-3384.md
## snap 2.8 ui
	cp $(SRC)/event-logs.md $(MODWD)/event-logs-snap-2-8-ui-3385.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui event-logs-snap-2-8-ui-3385.md
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

# $(DISC)/getting-help.md: $(SRC)/getting-help.md
# 	cp $(SRC)/getting-help.md $(MODWD)/getting-help-838.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) getting-help-838.md
# 	cd $(DISC) &&\
# 	xpub pull $(DISC) 838 838
# 	cd $(DISC) &&\
# 	cp -p getting-help-838.md getting-help.md
# 	cd $(DISC) && rm getting-help-838.md

$(DISC)/give-me-an-example-of-maas.md: $(SRC)/give-me-an-example-of-maas.md
## deb 2.7 cli
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-7-cli-2652.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli give-me-an-example-of-maas-deb-2-7-cli-2652.md
## deb 2.7 ui
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-7-ui-2653.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui give-me-an-example-of-maas-deb-2-7-ui-2653.md
## deb 2.8 cli
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-8-cli-2654.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli give-me-an-example-of-maas-deb-2-8-cli-2654.md
## deb 2.8 ui
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-deb-2-8-ui-2655.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui give-me-an-example-of-maas-deb-2-8-ui-2655.md
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
## snap 2.7 cli
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-7-cli-2646.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli give-me-an-example-of-maas-snap-2-7-cli-2646.md
## snap 2.7 ui
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-7-ui-2647.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui give-me-an-example-of-maas-snap-2-7-ui-2647.md
## snap 2.8 cli
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-8-cli-2648.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli give-me-an-example-of-maas-snap-2-8-cli-2648.md
## snap 2.8 ui
	cp $(SRC)/give-me-an-example-of-maas.md $(MODWD)/give-me-an-example-of-maas-snap-2-8-ui-2649.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui give-me-an-example-of-maas-snap-2-8-ui-2649.md
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
## deb 2.7 cli
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-7-cli-2664.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli hardening-your-maas-installation-deb-2-7-cli-2664.md
## deb 2.7 ui
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-7-ui-2665.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui hardening-your-maas-installation-deb-2-7-ui-2665.md
## deb 2.8 cli
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-8-cli-2666.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli hardening-your-maas-installation-deb-2-8-cli-2666.md
## deb 2.8 ui
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-deb-2-8-ui-2667.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui hardening-your-maas-installation-deb-2-8-ui-2667.md
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
## snap 2.7 cli
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-7-cli-2658.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli hardening-your-maas-installation-snap-2-7-cli-2658.md
## snap 2.7 ui
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-7-ui-2659.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui hardening-your-maas-installation-snap-2-7-ui-2659.md
## snap 2.8 cli
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-8-cli-2660.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli hardening-your-maas-installation-snap-2-8-cli-2660.md
## snap 2.8 ui
	cp $(SRC)/hardening-your-maas-installation.md $(MODWD)/hardening-your-maas-installation-snap-2-8-ui-2661.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui hardening-your-maas-installation-snap-2-8-ui-2661.md
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
## deb 2.7 cli
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-7-cli-2676.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli hardware-testing-deb-2-7-cli-2676.md
## deb 2.7 ui
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-7-ui-2677.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui hardware-testing-deb-2-7-ui-2677.md
## deb 2.8 cli
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-8-cli-2678.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli hardware-testing-deb-2-8-cli-2678.md
## deb 2.8 ui
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-deb-2-8-ui-2679.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui hardware-testing-deb-2-8-ui-2679.md
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
## snap 2.7 cli
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-7-cli-2670.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli hardware-testing-snap-2-7-cli-2670.md
## snap 2.7 ui
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-7-ui-2671.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui hardware-testing-snap-2-7-ui-2671.md
## snap 2.8 cli
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-8-cli-2672.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli hardware-testing-snap-2-8-cli-2672.md
## snap 2.8 ui
	cp $(SRC)/hardware-testing.md $(MODWD)/hardware-testing-snap-2-8-ui-2673.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui hardware-testing-snap-2-8-ui-2673.md
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
## deb 2.7 cli
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-7-cli-2688.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli high-availability-deb-2-7-cli-2688.md
## deb 2.7 ui
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-7-ui-2689.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui high-availability-deb-2-7-ui-2689.md
## deb 2.8 cli
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-8-cli-2690.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli high-availability-deb-2-8-cli-2690.md
## deb 2.8 ui
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-deb-2-8-ui-2691.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui high-availability-deb-2-8-ui-2691.md
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
## snap 2.7 cli
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-7-cli-2682.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli high-availability-snap-2-7-cli-2682.md
## snap 2.7 ui
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-7-ui-2683.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui high-availability-snap-2-7-ui-2683.md
## snap 2.8 cli
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-8-cli-2684.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli high-availability-snap-2-8-cli-2684.md
## snap 2.8 ui
	cp $(SRC)/high-availability.md $(MODWD)/high-availability-snap-2-8-ui-2685.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui high-availability-snap-2-8-ui-2685.md
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
## deb 2.7 cli
	cp $(SRC)/images.md $(MODWD)/images-deb-2-7-cli-2700.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli images-deb-2-7-cli-2700.md
## deb 2.7 ui
	cp $(SRC)/images.md $(MODWD)/images-deb-2-7-ui-2701.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui images-deb-2-7-ui-2701.md
## deb 2.8 cli
	cp $(SRC)/images.md $(MODWD)/images-deb-2-8-cli-2702.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli images-deb-2-8-cli-2702.md
## deb 2.8 ui
	cp $(SRC)/images.md $(MODWD)/images-deb-2-8-ui-2703.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui images-deb-2-8-ui-2703.md
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
## snap 2.7 cli
	cp $(SRC)/images.md $(MODWD)/images-snap-2-7-cli-2694.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli images-snap-2-7-cli-2694.md
## snap 2.7 ui
	cp $(SRC)/images.md $(MODWD)/images-snap-2-7-ui-2695.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui images-snap-2-7-ui-2695.md
## snap 2.8 cli
	cp $(SRC)/images.md $(MODWD)/images-snap-2-8-cli-2696.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli images-snap-2-8-cli-2696.md
## snap 2.8 ui
	cp $(SRC)/images.md $(MODWD)/images-snap-2-8-ui-2697.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui images-snap-2-8-ui-2697.md
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
## deb 2.7 cli
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-7-cli-2712.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli interactive-search-deb-2-7-cli-2712.md
## deb 2.7 ui
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-7-ui-2713.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui interactive-search-deb-2-7-ui-2713.md
## deb 2.8 cli
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-8-cli-2714.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli interactive-search-deb-2-8-cli-2714.md
## deb 2.8 ui
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-deb-2-8-ui-2715.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui interactive-search-deb-2-8-ui-2715.md
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
## snap 2.7 cli
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-7-cli-2706.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli interactive-search-snap-2-7-cli-2706.md
## snap 2.7 ui
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-7-ui-2707.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui interactive-search-snap-2-7-ui-2707.md
## snap 2.8 cli
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-8-cli-2708.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli interactive-search-snap-2-8-cli-2708.md
## snap 2.8 ui
	cp $(SRC)/interactive-search.md $(MODWD)/interactive-search-snap-2-8-ui-2709.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui interactive-search-snap-2-8-ui-2709.md
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
## deb 2.7 cli
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-7-cli-2760.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli ip-ranges-deb-2-7-cli-2760.md
## deb 2.7 ui
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-7-ui-2761.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui ip-ranges-deb-2-7-ui-2761.md
## deb 2.8 cli
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-8-cli-2762.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli ip-ranges-deb-2-8-cli-2762.md
## deb 2.8 ui
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-deb-2-8-ui-2763.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui ip-ranges-deb-2-8-ui-2763.md
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
## snap 2.7 cli
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-7-cli-2754.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli ip-ranges-snap-2-7-cli-2754.md
## snap 2.7 ui
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-7-ui-2755.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui ip-ranges-snap-2-7-ui-2755.md
## snap 2.8 cli
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-8-cli-2756.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli ip-ranges-snap-2-8-cli-2756.md
## snap 2.8 ui
	cp $(SRC)/ip-ranges.md $(MODWD)/ip-ranges-snap-2-8-ui-2757.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui ip-ranges-snap-2-8-ui-2757.md
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
## deb 2.7 cli
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-7-cli-2772.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli ipv6-addressing-deb-2-7-cli-2772.md
## deb 2.7 ui
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-7-ui-2773.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui ipv6-addressing-deb-2-7-ui-2773.md
## deb 2.8 cli
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-8-cli-2774.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli ipv6-addressing-deb-2-8-cli-2774.md
## deb 2.8 ui
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-deb-2-8-ui-2775.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui ipv6-addressing-deb-2-8-ui-2775.md
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
## snap 2.7 cli
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-7-cli-2766.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli ipv6-addressing-snap-2-7-cli-2766.md
## snap 2.7 ui
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-7-ui-2767.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui ipv6-addressing-snap-2-7-ui-2767.md
## snap 2.8 cli
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-8-cli-2768.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli ipv6-addressing-snap-2-8-cli-2768.md
## snap 2.8 ui
	cp $(SRC)/ipv6-addressing.md $(MODWD)/ipv6-addressing-snap-2-8-ui-2769.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui ipv6-addressing-snap-2-8-ui-2769.md
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
## deb 2.7 cli
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-7-cli-2784.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli kernel-boot-options-deb-2-7-cli-2784.md
## deb 2.7 ui
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-7-ui-2785.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui kernel-boot-options-deb-2-7-ui-2785.md
## deb 2.8 cli
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-8-cli-2786.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli kernel-boot-options-deb-2-8-cli-2786.md
## deb 2.8 ui
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-deb-2-8-ui-2787.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui kernel-boot-options-deb-2-8-ui-2787.md
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
## snap 2.7 cli
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-7-cli-2778.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli kernel-boot-options-snap-2-7-cli-2778.md
## snap 2.7 ui
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-7-ui-2779.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui kernel-boot-options-snap-2-7-ui-2779.md
## snap 2.8 cli
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-8-cli-2780.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli kernel-boot-options-snap-2-8-cli-2780.md
## snap 2.8 ui
	cp $(SRC)/kernel-boot-options.md $(MODWD)/kernel-boot-options-snap-2-8-ui-2781.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui kernel-boot-options-snap-2-8-ui-2781.md
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

# $(DISC)/language-details-contributing-to-maas-docs.md: $(SRC)/language-details-contributing-to-maas-docs.md
# 	cp $(SRC)/language-details-contributing-to-maas-docs.md $(MODWD)/language-details-contributing-to-maas-docs-745.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) language-details-contributing-to-maas-docs-745.md
# 	cd $(DISC) &&\
# 	xpub pull $(DISC) 745 745
# 	cd $(DISC) &&\
# 	cp -p language-details-contributing-to-maas-docs-745.md language-details-contributing-to-maas-docs.md
# 	cd $(DISC) && rm language-details-contributing-to-maas-docs-745.md

$(DISC)/local-image-mirror.md: $(SRC)/local-image-mirror.md
## deb 2.7 cli
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-7-cli-2808.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli local-image-mirror-deb-2-7-cli-2808.md
## deb 2.7 ui
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-7-ui-2809.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui local-image-mirror-deb-2-7-ui-2809.md
## deb 2.8 cli
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-8-cli-2810.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli local-image-mirror-deb-2-8-cli-2810.md
## deb 2.8 ui
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-deb-2-8-ui-2811.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui local-image-mirror-deb-2-8-ui-2811.md
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
## snap 2.7 cli
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-7-cli-2802.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli local-image-mirror-snap-2-7-cli-2802.md
## snap 2.7 ui
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-7-ui-2803.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui local-image-mirror-snap-2-7-ui-2803.md
## snap 2.8 cli
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-8-cli-2804.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli local-image-mirror-snap-2-8-cli-2804.md
## snap 2.8 ui
	cp $(SRC)/local-image-mirror.md $(MODWD)/local-image-mirror-snap-2-8-ui-2805.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui local-image-mirror-snap-2-8-ui-2805.md
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
## deb 2.7 cli
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-deb-2-7-cli-2820.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-cli-deb-2-7-cli-2820.md
## deb 2.7 ui
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-deb-2-7-ui-2821.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-cli-deb-2-7-ui-2821.md
## deb 2.8 cli
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-deb-2-8-cli-2822.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-cli-deb-2-8-cli-2822.md
## deb 2.8 ui
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-deb-2-8-ui-2823.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-cli-deb-2-8-ui-2823.md
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
## snap 2.7 cli
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-snap-2-7-cli-2814.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-cli-snap-2-7-cli-2814.md
## snap 2.7 ui
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-snap-2-7-ui-2815.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-cli-snap-2-7-ui-2815.md
## snap 2.8 cli
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-snap-2-8-cli-2816.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-cli-snap-2-8-cli-2816.md
## snap 2.8 ui
	cp $(SRC)/maas-cli.md $(MODWD)/maas-cli-snap-2-8-ui-2817.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-cli-snap-2-8-ui-2817.md
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
## deb 2.7 cli
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-7-cli-2832.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-communication-deb-2-7-cli-2832.md
## deb 2.7 ui
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-7-ui-2833.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-communication-deb-2-7-ui-2833.md
## deb 2.8 cli
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-8-cli-2834.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-communication-deb-2-8-cli-2834.md
## deb 2.8 ui
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-deb-2-8-ui-2835.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-communication-deb-2-8-ui-2835.md
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
## snap 2.7 cli
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-7-cli-2826.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-communication-snap-2-7-cli-2826.md
## snap 2.7 ui
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-7-ui-2827.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-communication-snap-2-7-ui-2827.md
## snap 2.8 cli
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-8-cli-2828.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-communication-snap-2-8-cli-2828.md
## snap 2.8 ui
	cp $(SRC)/maas-communication.md $(MODWD)/maas-communication-snap-2-8-ui-2829.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-communication-snap-2-8-ui-2829.md
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
## deb 2.7 cli
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-7-cli-2844.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-7-cli-2844.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-documentation-deb-2-7-cli-2844.md
## deb 2.7 ui
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-7-ui-2845.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-7-ui-2845.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-documentation-deb-2-7-ui-2845.md
## deb 2.8 cli
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-8-cli-2846.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-8-cli-2846.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-documentation-deb-2-8-cli-2846.md
## deb 2.8 ui
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-deb-2-8-ui-2847.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-deb-2-8-ui-2847.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-documentation-deb-2-8-ui-2847.md
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
## snap 2.7 cli
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-7-cli-2838.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-7-cli-2838.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-documentation-snap-2-7-cli-2838.md
## snap 2.7 ui
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-7-ui-2839.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-7-ui-2839.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-documentation-snap-2-7-ui-2839.md
## snap 2.8 cli
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-8-cli-2840.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-8-cli-2840.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-documentation-snap-2-8-cli-2840.md
## snap 2.8 ui
	cp $(SRC)/maas-documentation.md $(MODWD)/maas-documentation-snap-2-8-ui-2841.md
	cd $(MODWD) &&\
	./strip-navigation.sh maas-documentation-snap-2-8-ui-2841.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-documentation-snap-2-8-ui-2841.md
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
## deb 2.7 cli
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-7-cli-2856.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-image-builder-deb-2-7-cli-2856.md
## deb 2.7 ui
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-7-ui-2857.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-image-builder-deb-2-7-ui-2857.md
## deb 2.8 cli
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-8-cli-2858.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-image-builder-deb-2-8-cli-2858.md
## deb 2.8 ui
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-deb-2-8-ui-2859.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-image-builder-deb-2-8-ui-2859.md
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
## snap 2.7 cli
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-7-cli-2850.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-image-builder-snap-2-7-cli-2850.md
## snap 2.7 ui
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-7-ui-2851.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-image-builder-snap-2-7-ui-2851.md
## snap 2.8 cli
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-8-cli-2852.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-image-builder-snap-2-8-cli-2852.md
## snap 2.8 ui
	cp $(SRC)/maas-image-builder.md $(MODWD)/maas-image-builder-snap-2-8-ui-2853.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-image-builder-snap-2-8-ui-2853.md
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
## deb 2.7 cli
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-7-cli-3324.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-installation-deb-2-7-cli-3324.md
## deb 2.7 ui
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-7-ui-3325.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-installation-deb-2-7-ui-3325.md
## deb 2.8 cli
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-8-cli-3326.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-installation-deb-2-8-cli-3326.md
## deb 2.8 ui
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-deb-2-8-ui-3327.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-installation-deb-2-8-ui-3327.md
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
## snap 2.7 cli
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-7-cli-3318.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-installation-snap-2-7-cli-3318.md
## snap 2.7 ui
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-7-ui-3319.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-installation-snap-2-7-ui-3319.md
## snap 2.8 cli
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-8-cli-3320.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-installation-snap-2-8-cli-3320.md
## snap 2.8 ui
	cp $(SRC)/maas-installation.md $(MODWD)/maas-installation-snap-2-8-ui-3321.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-installation-snap-2-8-ui-3321.md
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

# $(DISC)/maas-installation-technical-reference.md: $(SRC)/maas-installation-technical-reference.md
# ## deb 2.7 cli
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-deb-2-7-cli-4530.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-7-cli maas-installation-technical-reference-deb-2-7-cli-4530.md
# ## deb 2.7 ui
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-deb-2-7-ui-4526.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-7-ui maas-installation-technical-reference-deb-2-7-ui-4526.md
# ## deb 2.8 cli
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-deb-2-8-cli-4531.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-8-cli maas-installation-technical-reference-deb-2-8-cli-4531.md
# ## deb 2.8 ui
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-deb-2-8-ui-4527.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-8-ui maas-installation-technical-reference-deb-2-8-ui-4527.md
# ## deb 2.9 cli
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-deb-2-9-cli-4532.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-9-cli maas-installation-technical-reference-deb-2-9-cli-4532.md
# ## deb 2.9 ui
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-deb-2-9-ui-4528.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-9-ui maas-installation-technical-reference-deb-2-9-ui-4528.md
# ## deb 3.0 cli
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-deb-3-0-cli-4533.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-3-0-cli maas-installation-technical-reference-deb-3-0-cli-4533.md
# ## deb 3.0 ui
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-deb-3-0-ui-4529.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-3-0-ui maas-installation-technical-reference-deb-3-0-ui-4529.md
# ## snap 2.7 cli
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-snap-2-7-cli-4522.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-7-cli maas-installation-technical-reference-snap-2-7-cli-4522.md
# ## snap 2.7 ui
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-snap-2-7-ui-4519.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-7-ui maas-installation-technical-reference-snap-2-7-ui-4519.md
# ## snap 2.8 cli
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-snap-2-8-cli-4523.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-8-cli maas-installation-technical-reference-snap-2-8-cli-4523.md
# ## snap 2.8 ui
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-snap-2-8-ui-4520.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-8-ui maas-installation-technical-reference-snap-2-8-ui-4520.md
# ## snap 2.9 cli
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-snap-2-9-cli-4524.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-9-cli maas-installation-technical-reference-snap-2-9-cli-4524.md
# ## snap 2.9 ui
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-snap-2-9-ui-4521.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-9-ui maas-installation-technical-reference-snap-2-9-ui-4521.md
# ## snap 3.0 cli
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-snap-3-0-cli-4525.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-3-0-cli maas-installation-technical-reference-snap-3-0-cli-4525.md
# ## snap 3.0 ui
# 	cp $(SRC)/maas-installation-technical-reference.md $(MODWD)/maas-installation-technical-reference-snap-3-0-ui-4516.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-3-0-ui maas-installation-technical-reference-snap-3-0-ui-4516.md
# ## pull reference version
# 	cd $(DISC) &&\
# 	xpub pull $(DISC) 4516 4516
# ## copy reference version to discourse master
# 	cd $(DISC) &&\
# 	cp -p maas-installation-technical-reference-snap-3-0-ui-4516.md maas-installation-technical-reference.md
# ## remove reference version
# 	cd $(DISC) && rm maas-installation-technical-reference-snap-3-0-ui-4516.md

# $(DISC)/maas-installation-tutorial.md: $(SRC)/maas-installation-tutorial.md
# ## deb 2.7 cli
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-deb-2-7-cli-4545.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-7-cli maas-installation-tutorial-deb-2-7-cli-4545.md
# ## deb 2.7 ui
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-deb-2-7-ui-4541.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-7-ui maas-installation-tutorial-deb-2-7-ui-4541.md
# ## deb 2.8 cli
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-deb-2-8-cli-4546.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-8-cli maas-installation-tutorial-deb-2-8-cli-4546.md
# ## deb 2.8 ui
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-deb-2-8-ui-4542.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-8-ui maas-installation-tutorial-deb-2-8-ui-4542.md
# ## deb 2.9 cli
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-deb-2-9-cli-4547.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-9-cli maas-installation-tutorial-deb-2-9-cli-4547.md
# ## deb 2.9 ui
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-deb-2-9-ui-4543.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-9-ui maas-installation-tutorial-deb-2-9-ui-4543.md
# ## deb 3.0 cli
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-deb-3-0-cli-4548.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-3-0-cli maas-installation-tutorial-deb-3-0-cli-4548.md
# ## deb 3.0 ui
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-deb-3-0-ui-4544.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-3-0-ui maas-installation-tutorial-deb-3-0-ui-4544.md
# ## snap 2.7 cli
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-snap-2-7-cli-4537.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-7-cli maas-installation-tutorial-snap-2-7-cli-4537.md
# ## snap 2.7 ui
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-snap-2-7-ui-4534.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-7-ui maas-installation-tutorial-snap-2-7-ui-4534.md
# ## snap 2.8 cli
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-snap-2-8-cli-4538.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-8-cli maas-installation-tutorial-snap-2-8-cli-4538.md
# ## snap 2.8 ui
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-snap-2-8-ui-4535.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-8-ui maas-installation-tutorial-snap-2-8-ui-4535.md
# ## snap 2.9 cli
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-snap-2-9-cli-4539.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-9-cli maas-installation-tutorial-snap-2-9-cli-4539.md
# ## snap 2.9 ui
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-snap-2-9-ui-4536.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-9-ui maas-installation-tutorial-snap-2-9-ui-4536.md
# ## snap 3.0 cli
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-snap-3-0-cli-4540.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-3-0-cli maas-installation-tutorial-snap-3-0-cli-4540.md
# ## snap 3.0 ui
# 	cp $(SRC)/maas-installation-tutorial.md $(MODWD)/maas-installation-tutorial-snap-3-0-ui-4517.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-3-0-ui maas-installation-tutorial-snap-3-0-ui-4517.md
# ## pull reference version
# 	cd $(DISC) &&\
# 	xpub pull $(DISC) 4517 4517
# ## copy reference version to discourse master
# 	cd $(DISC) &&\
# 	cp -p maas-installation-tutorial-snap-3-0-ui-4517.md maas-installation-tutorial.md
# ## remove reference version
# 	cd $(DISC) && rm maas-installation-tutorial-snap-3-0-ui-4517.md

$(DISC)/maas-logging.md: $(SRC)/maas-logging.md
## deb 2.7 cli
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-7-cli-2868.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-logging-deb-2-7-cli-2868.md
## deb 2.7 ui
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-7-ui-2869.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-logging-deb-2-7-ui-2869.md
## deb 2.8 cli
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-8-cli-2870.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-logging-deb-2-8-cli-2870.md
## deb 2.8 ui
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-deb-2-8-ui-2871.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-logging-deb-2-8-ui-2871.md
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
## snap 2.7 cli
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-7-cli-2862.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-logging-snap-2-7-cli-2862.md
## snap 2.7 ui
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-7-ui-2863.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-logging-snap-2-7-ui-2863.md
## snap 2.8 cli
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-8-cli-2864.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-logging-snap-2-8-cli-2864.md
## snap 2.8 ui
	cp $(SRC)/maas-logging.md $(MODWD)/maas-logging-snap-2-8-ui-2865.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-logging-snap-2-8-ui-2865.md
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
## deb 2.7 cli
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-7-cli-2880.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli maas-requirements-deb-2-7-cli-2880.md
## deb 2.7 ui
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-7-ui-2881.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui maas-requirements-deb-2-7-ui-2881.md
## deb 2.8 cli
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-8-cli-2882.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli maas-requirements-deb-2-8-cli-2882.md
## deb 2.8 ui
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-deb-2-8-ui-2883.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui maas-requirements-deb-2-8-ui-2883.md
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
## snap 2.7 cli
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-7-cli-2874.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli maas-requirements-snap-2-7-cli-2874.md
## snap 2.7 ui
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-7-ui-2875.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui maas-requirements-snap-2-7-ui-2875.md
## snap 2.8 cli
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-8-cli-2876.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli maas-requirements-snap-2-8-cli-2876.md
## snap 2.8 ui
	cp $(SRC)/maas-requirements.md $(MODWD)/maas-requirements-snap-2-8-ui-2877.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui maas-requirements-snap-2-8-ui-2877.md
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
## deb 2.7 cli
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-deb-2-7-cli-2892.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli tags-and-annotations-deb-2-7-cli-2892.md
## deb 2.7 ui
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-deb-2-7-ui-2893.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui tags-and-annotations-deb-2-7-ui-2893.md
## deb 2.8 cli
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-deb-2-8-cli-2894.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli tags-and-annotations-deb-2-8-cli-2894.md
## deb 2.8 ui
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-deb-2-8-ui-2895.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui tags-and-annotations-deb-2-8-ui-2895.md
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
## snap 2.7 cli
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-snap-2-7-cli-2886.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli tags-and-annotations-snap-2-7-cli-2886.md
## snap 2.7 ui
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-snap-2-7-ui-2887.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui tags-and-annotations-snap-2-7-ui-2887.md
## snap 2.8 cli
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-snap-2-8-cli-2888.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli tags-and-annotations-snap-2-8-cli-2888.md
## snap 2.8 ui
	cp $(SRC)/tags-and-annotations.md $(MODWD)/tags-and-annotations-snap-2-8-ui-2889.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui tags-and-annotations-snap-2-8-ui-2889.md
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
## deb 2.7 cli
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-7-cli-3448.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli machine-logs-deb-2-7-cli-3448.md
## deb 2.7 ui
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-7-ui-3449.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui machine-logs-deb-2-7-ui-3449.md
## deb 2.8 cli
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-8-cli-3450.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli machine-logs-deb-2-8-cli-3450.md
## deb 2.8 ui
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-deb-2-8-ui-3451.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui machine-logs-deb-2-8-ui-3451.md
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
## snap 2.7 cli
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-7-cli-3442.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli machine-logs-snap-2-7-cli-3442.md
## snap 2.7 ui
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-7-ui-3443.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui machine-logs-snap-2-7-ui-3443.md
## snap 2.8 cli
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-8-cli-3444.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli machine-logs-snap-2-8-cli-3444.md
## snap 2.8 ui
	cp $(SRC)/machine-logs.md $(MODWD)/machine-logs-snap-2-8-ui-3445.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui machine-logs-snap-2-8-ui-3445.md
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
## deb 2.7 cli
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-7-cli-2736.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli machines-deb-2-7-cli-2736.md
## deb 2.7 ui
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-7-ui-2737.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui machines-deb-2-7-ui-2737.md
## deb 2.8 cli
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-8-cli-2738.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli machines-deb-2-8-cli-2738.md
## deb 2.8 ui
	cp $(SRC)/machines.md $(MODWD)/machines-deb-2-8-ui-2739.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui machines-deb-2-8-ui-2739.md
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
## snap 2.7 cli
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-7-cli-2730.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli machines-snap-2-7-cli-2730.md
## snap 2.7 ui
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-7-ui-2731.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui machines-snap-2-7-ui-2731.md
## snap 2.8 cli
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-8-cli-2732.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli machines-snap-2-8-cli-2732.md
## snap 2.8 ui
	cp $(SRC)/machines.md $(MODWD)/machines-snap-2-8-ui-2733.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui machines-snap-2-8-ui-2733.md
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
## deb 2.7 cli
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-7-cli-2904.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli managing-dhcp-deb-2-7-cli-2904.md
## deb 2.7 ui
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-7-ui-2905.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui managing-dhcp-deb-2-7-ui-2905.md
## deb 2.8 cli
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-8-cli-2906.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli managing-dhcp-deb-2-8-cli-2906.md
## deb 2.8 ui
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-deb-2-8-ui-2907.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui managing-dhcp-deb-2-8-ui-2907.md
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
## snap 2.7 cli
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-7-cli-2898.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli managing-dhcp-snap-2-7-cli-2898.md
## snap 2.7 ui
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-7-ui-2899.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui managing-dhcp-snap-2-7-ui-2899.md
## snap 2.8 cli
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-8-cli-2900.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli managing-dhcp-snap-2-8-cli-2900.md
## snap 2.8 ui
	cp $(SRC)/managing-dhcp.md $(MODWD)/managing-dhcp-snap-2-8-ui-2901.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui managing-dhcp-snap-2-8-ui-2901.md
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
## deb 2.7 cli
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-7-cli-2916.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli managing-stp-deb-2-7-cli-2916.md
## deb 2.7 ui
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-7-ui-2917.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui managing-stp-deb-2-7-ui-2917.md
## deb 2.8 cli
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-8-cli-2918.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli managing-stp-deb-2-8-cli-2918.md
## deb 2.8 ui
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-deb-2-8-ui-2919.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui managing-stp-deb-2-8-ui-2919.md
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
## snap 2.7 cli
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-7-cli-2910.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli managing-stp-snap-2-7-cli-2910.md
## snap 2.7 ui
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-7-ui-2911.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui managing-stp-snap-2-7-ui-2911.md
## snap 2.8 cli
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-8-cli-2912.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli managing-stp-snap-2-8-cli-2912.md
## snap 2.8 ui
	cp $(SRC)/managing-stp.md $(MODWD)/managing-stp-snap-2-8-ui-2913.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui managing-stp-snap-2-8-ui-2913.md
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
## deb 2.7 cli
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-7-cli-2928.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli network-discovery-deb-2-7-cli-2928.md
## deb 2.7 ui
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-7-ui-2929.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui network-discovery-deb-2-7-ui-2929.md
## deb 2.8 cli
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-8-cli-2930.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli network-discovery-deb-2-8-cli-2930.md
## deb 2.8 ui
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-deb-2-8-ui-2931.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui network-discovery-deb-2-8-ui-2931.md
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
## snap 2.7 cli
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-7-cli-2922.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli network-discovery-snap-2-7-cli-2922.md
## snap 2.7 ui
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-7-ui-2923.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui network-discovery-snap-2-7-ui-2923.md
## snap 2.8 cli
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-8-cli-2924.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli network-discovery-snap-2-8-cli-2924.md
## snap 2.8 ui
	cp $(SRC)/network-discovery.md $(MODWD)/network-discovery-snap-2-8-ui-2925.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui network-discovery-snap-2-8-ui-2925.md
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
## deb 2.7 cli
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-7-cli-2952.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli networking-deb-2-7-cli-2952.md
## deb 2.7 ui
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-7-ui-2953.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui networking-deb-2-7-ui-2953.md
## deb 2.8 cli
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-8-cli-2954.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli networking-deb-2-8-cli-2954.md
## deb 2.8 ui
	cp $(SRC)/networking.md $(MODWD)/networking-deb-2-8-ui-2955.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui networking-deb-2-8-ui-2955.md
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
## snap 2.7 cli
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-7-cli-2946.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli networking-snap-2-7-cli-2946.md
## snap 2.7 ui
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-7-ui-2947.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui networking-snap-2-7-ui-2947.md
## snap 2.8 cli
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-8-cli-2948.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli networking-snap-2-8-cli-2948.md
## snap 2.8 ui
	cp $(SRC)/networking.md $(MODWD)/networking-snap-2-8-ui-2949.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui networking-snap-2-8-ui-2949.md
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
## deb 2.7 cli
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-7-cli-2940.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli network-testing-deb-2-7-cli-2940.md
## deb 2.7 ui
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-7-ui-2941.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui network-testing-deb-2-7-ui-2941.md
## deb 2.8 cli
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-8-cli-2942.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli network-testing-deb-2-8-cli-2942.md
## deb 2.8 ui
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-deb-2-8-ui-2943.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui network-testing-deb-2-8-ui-2943.md
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
## snap 2.7 cli
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-7-cli-2934.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli network-testing-snap-2-7-cli-2934.md
## snap 2.7 ui
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-7-ui-2935.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui network-testing-snap-2-7-ui-2935.md
## snap 2.8 cli
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-8-cli-2936.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli network-testing-snap-2-8-cli-2936.md
## snap 2.8 ui
	cp $(SRC)/network-testing.md $(MODWD)/network-testing-snap-2-8-ui-2937.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui network-testing-snap-2-8-ui-2937.md
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
## deb 2.7 cli
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-7-cli-2964.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli ntp-services-deb-2-7-cli-2964.md
## deb 2.7 ui
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-7-ui-2965.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui ntp-services-deb-2-7-ui-2965.md
## deb 2.8 cli
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-8-cli-2966.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli ntp-services-deb-2-8-cli-2966.md
## deb 2.8 ui
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-deb-2-8-ui-2967.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui ntp-services-deb-2-8-ui-2967.md
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
## snap 2.7 cli
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-7-cli-2958.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli ntp-services-snap-2-7-cli-2958.md
## snap 2.7 ui
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-7-ui-2959.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui ntp-services-snap-2-7-ui-2959.md
## snap 2.8 cli
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-8-cli-2960.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli ntp-services-snap-2-8-cli-2960.md
## snap 2.8 ui
	cp $(SRC)/ntp-services.md $(MODWD)/ntp-services-snap-2-8-ui-2961.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui ntp-services-snap-2-8-ui-2961.md
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
## deb 2.7 cli
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-7-cli-2976.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli package-repositories-deb-2-7-cli-2976.md
## deb 2.7 ui
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-7-ui-2977.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui package-repositories-deb-2-7-ui-2977.md
## deb 2.8 cli
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-8-cli-2978.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli package-repositories-deb-2-8-cli-2978.md
## deb 2.8 ui
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-8-ui-2979.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui package-repositories-deb-2-8-ui-2979.md
## deb 2.9 ui
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-9-cli-2980.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-cli package-repositories-deb-2-9-cli-2980.md
## deb 2.9 ui
	cp $(SRC)/package-repositories.md $(MODWD)/package-repositories-deb-2-9-ui-2981.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-9-ui package-repositories-deb-2-9-ui-2981.md
## pull reference version
	cd $(DISC) &&\
	xpub pull $(DISC) 4059 4059
## copy reference version to discourse master
	cd $(DISC) &&\
	cp -p package-repositories-deb-3-0-cli-4059.md package-respositories.md 
## remove reference version
	cd $(DISC) && rm package-repositories-deb-3-0-cli-4059.md

$(DISC)/partitions.md: $(SRC)/partitions.md
## deb 2.7 cli
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-7-cli-2988.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli partitions-deb-2-7-cli-2988.md
## deb 2.7 ui
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-7-ui-2989.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui partitions-deb-2-7-ui-2989.md
## deb 2.8 cli
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-8-cli-2990.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli partitions-deb-2-8-cli-2990.md
## deb 2.8 ui
	cp $(SRC)/partitions.md $(MODWD)/partitions-deb-2-8-ui-2991.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui partitions-deb-2-8-ui-2991.md
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
## snap 2.7 cli
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-7-cli-2982.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli partitions-snap-2-7-cli-2982.md
## snap 2.7 ui
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-7-ui-2983.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui partitions-snap-2-7-ui-2983.md
## snap 2.8 cli
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-8-cli-2984.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli partitions-snap-2-8-cli-2984.md
## snap 2.8 ui
	cp $(SRC)/partitions.md $(MODWD)/partitions-snap-2-8-ui-2985.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui partitions-snap-2-8-ui-2985.md
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
## deb 2.7 cli
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-7-cli-3000.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli postgresql-ha-hot-standby-deb-2-7-cli-3000.md
## deb 2.7 ui
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-7-ui-3001.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui postgresql-ha-hot-standby-deb-2-7-ui-3001.md
## deb 2.8 cli
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-8-cli-3002.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli postgresql-ha-hot-standby-deb-2-8-cli-3002.md
## deb 2.8 ui
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-deb-2-8-ui-3003.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui postgresql-ha-hot-standby-deb-2-8-ui-3003.md
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
## snap 2.7 cli
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-7-cli-2994.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli postgresql-ha-hot-standby-snap-2-7-cli-2994.md
## snap 2.7 ui
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-7-ui-2995.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui postgresql-ha-hot-standby-snap-2-7-ui-2995.md
## snap 2.8 cli
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-8-cli-2996.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli postgresql-ha-hot-standby-snap-2-8-cli-2996.md
## snap 2.8 ui
	cp $(SRC)/postgresql-ha-hot-standby.md $(MODWD)/postgresql-ha-hot-standby-snap-2-8-ui-2997.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui postgresql-ha-hot-standby-snap-2-8-ui-2997.md
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
## deb 2.7 cli
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-7-cli-3012.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli power-management-deb-2-7-cli-3012.md
## deb 2.7 ui
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-7-ui-3013.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui power-management-deb-2-7-ui-3013.md
## deb 2.8 cli
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-8-cli-3014.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli power-management-deb-2-8-cli-3014.md
## deb 2.8 ui
	cp $(SRC)/power-management.md $(MODWD)/power-management-deb-2-8-ui-3015.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui power-management-deb-2-8-ui-3015.md
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
## snap 2.7 cli
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-7-cli-3006.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli power-management-snap-2-7-cli-3006.md
## snap 2.7 ui
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-7-ui-3007.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui power-management-snap-2-7-ui-3007.md
## snap 2.8 cli
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-8-cli-3008.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli power-management-snap-2-8-cli-3008.md
## snap 2.8 ui
	cp $(SRC)/power-management.md $(MODWD)/power-management-snap-2-8-ui-3009.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui power-management-snap-2-8-ui-3009.md
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
## deb 2.7 cli
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-7-cli-3024.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli prometheus-metrics-deb-2-7-cli-3024.md
## deb 2.7 ui 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-7-ui-3025.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui prometheus-metrics-deb-2-7-ui-3025.md
## deb 2.8 cli
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-8-cli-3026.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli prometheus-metrics-deb-2-8-cli-3026.md
## deb 2.8 ui 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-deb-2-8-ui-3027.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui prometheus-metrics-deb-2-8-ui-3027.md
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
## snap 2.7 cli 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-7-cli-3018.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli prometheus-metrics-snap-2-7-cli-3018.md
## snap 2.7 ui 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-7-ui-3019.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui prometheus-metrics-snap-2-7-ui-3019.md
## snap 2.8 cli 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-8-cli-3020.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli prometheus-metrics-snap-2-8-cli-3020.md
## snap 2.8 ui 
	cp $(SRC)/prometheus-metrics.md $(MODWD)/prometheus-metrics-snap-2-8-ui-3021.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui prometheus-metrics-snap-2-8-ui-3021.md
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
## deb 2.7 cli
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-7-cli-3036.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli proxy-deb-2-7-cli-3036.md
## deb 2.7 ui 
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-7-ui-3037.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui proxy-deb-2-7-ui-3037.md
## deb 2.8 cli
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-8-cli-3038.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli proxy-deb-2-8-cli-3038.md
## deb 2.8 ui 
	cp $(SRC)/proxy.md $(MODWD)/proxy-deb-2-8-ui-3039.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui proxy-deb-2-8-ui-3039.md
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
## snap 2.7 cli 
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-7-cli-3030.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli proxy-snap-2-7-cli-3030.md
## snap 2.7 ui
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-7-ui-3031.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui proxy-snap-2-7-ui-3031.md
## snap 2.8 cli
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-8-cli-3032.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli proxy-snap-2-8-cli-3032.md
## snap 2.8 ui 
	cp $(SRC)/proxy.md $(MODWD)/proxy-snap-2-8-ui-3033.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui proxy-snap-2-8-ui-3033.md
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
## deb 2.7 cli
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-7-cli-3460.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli proxy-log-deb-2-7-cli-3460.md
## deb 2.7 ui
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-7-ui-3461.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui proxy-log-deb-2-7-ui-3461.md
## deb 2.8 cli
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-8-cli-3462.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli proxy-log-deb-2-8-cli-3462.md
## deb 2.8 ui
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-deb-2-8-ui-3463.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui proxy-log-deb-2-8-ui-3463.md
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
## snap 2.7 cli
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-7-cli-3454.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli proxy-log-snap-2-7-cli-3454.md
## snap 2.7 ui
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-7-ui-3455.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui proxy-log-snap-2-7-ui-3455.md
## snap 2.8 cli
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-8-cli-3456.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli proxy-log-snap-2-8-cli-3456.md
## snap 2.8 ui
	cp $(SRC)/proxy-log.md $(MODWD)/proxy-log-snap-2-8-ui-3457.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui proxy-log-snap-2-8-ui-3457.md
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
## deb 2.7 cli
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-7-cli-3054.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli rack-controllers-snap-2-7-cli-3054.md
## deb 2.7 ui
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-7-ui-3055.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui rack-controllers-snap-2-7-ui-3055.md
## deb 2.8 cli
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-8-cli-3056.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli rack-controllers-snap-2-8-cli-3056.md
## deb 2.8 ui
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-snap-2-8-ui-3057.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui rack-controllers-snap-2-8-ui-3057.md
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
## snap 2.7 cli
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-7-cli-3060.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli rack-controllers-deb-2-7-cli-3060.md
## snap 2.7 ui
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-7-ui-3061.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui rack-controllers-deb-2-7-ui-3061.md
## snap 2.8 cli
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-8-cli-3062.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli rack-controllers-deb-2-8-cli-3062.md
## snap 2.8 ui
	cp $(SRC)/rack-controllers.md $(MODWD)/rack-controllers-deb-2-8-ui-3063.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui rack-controllers-deb-2-8-ui-3063.md
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
## deb 2.7 cli
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-7-cli-3072.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli region-controllers-deb-2-7-cli-3072.md
## deb 2.7 ui
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-7-ui-3073.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui region-controllers-deb-2-7-ui-3073.md
## deb 2.8 cli
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-8-cli-3074.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli region-controllers-deb-2-8-cli-3074.md
## deb 2.8 ui
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-deb-2-8-ui-3075.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui region-controllers-deb-2-8-ui-3075.md
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
## snap 2.7 cli
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-7-cli-3066.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli region-controllers-snap-2-7-cli-3066.md
## snap 2.7 ui
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-7-ui-3067.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui region-controllers-snap-2-7-ui-3067.md
## snap 2.8 cli
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-8-cli-3068.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli region-controllers-snap-2-8-cli-3068.md
## snap 2.8 ui
	cp $(SRC)/region-controllers.md $(MODWD)/region-controllers-snap-2-8-ui-3069.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui region-controllers-snap-2-8-ui-3069.md
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
## deb 2.7 cli
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-7-cli-3084.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli resource-pools-deb-2-7-cli-3084.md
## deb 2.7 ui
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-7-ui-3085.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui resource-pools-deb-2-7-ui-3085.md
## deb 2.8 cli
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-8-cli-3086.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli resource-pools-deb-2-8-cli-3086.md
## deb 2.8 ui
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-deb-2-8-ui-3087.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui resource-pools-deb-2-8-ui-3087.md
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
## snap 2.7 cli
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-7-cli-3078.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli resource-pools-snap-2-7-cli-3078.md
## snap 2.7 ui
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-7-ui-3079.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui resource-pools-snap-2-7-ui-3079.md
## snap 2.8 cli
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-8-cli-3080.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli resource-pools-snap-2-8-cli-3080.md
## snap 2.8 ui
	cp $(SRC)/resource-pools.md $(MODWD)/resource-pools-snap-2-8-ui-3081.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui resource-pools-snap-2-8-ui-3081.md
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
## deb 2.7 cli
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-7-cli-3096.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli select-and-import-images-deb-2-7-cli-3096.md
## deb 2.7 ui
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-7-ui-3097.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui select-and-import-images-deb-2-7-ui-3097.md
## deb 2.8 cli
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-8-cli-3098.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli select-and-import-images-deb-2-8-cli-3098.md
## deb 2.8 ui
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-deb-2-8-ui-3099.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui select-and-import-images-deb-2-8-ui-3099.md
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
## snap 2.7 cli
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-7-cli-3090.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli select-and-import-images-snap-2-7-cli-3090.md
## snap 2.7 ui
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-7-ui-3091.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui select-and-import-images-snap-2-7-ui-3091.md
## snap 2.8 cli
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-8-cli-3092.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli select-and-import-images-snap-2-8-cli-3092.md
## snap 2.8 ui
	cp $(SRC)/select-and-import-images.md $(MODWD)/select-and-import-images-snap-2-8-ui-3093.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui select-and-import-images-snap-2-8-ui-3093.md
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
## deb 2.7 cli
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-7-cli-3108.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli storage-deb-2-7-cli-3108.md
## deb 2.7 ui
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-7-ui-3109.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui storage-deb-2-7-ui-3109.md
## deb 2.8 cli
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-8-cli-3110.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli storage-deb-2-8-cli-3110.md
## deb 2.8 ui
	cp $(SRC)/storage.md $(MODWD)/storage-deb-2-8-ui-3111.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui storage-deb-2-8-ui-3111.md
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
## snap 2.7 cli
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-7-cli-3102.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli storage-snap-2-7-cli-3102.md
## snap 2.7 ui
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-7-ui-3103.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui storage-snap-2-7-ui-3103.md
## snap 2.8 cli
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-8-cli-3104.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli storage-snap-2-8-cli-3104.md
## snap 2.8 ui
	cp $(SRC)/storage.md $(MODWD)/storage-snap-2-8-ui-3105.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui storage-snap-2-8-ui-3105.md
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
## deb 2.7 cli
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-7-cli-3120.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli subnet-management-deb-2-7-cli-3120.md
## deb 2.7 ui
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-7-ui-3121.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui subnet-management-deb-2-7-ui-3121.md
## deb 2.8 cli
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-8-cli-3122.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli subnet-management-deb-2-8-cli-3122.md
## deb 2.8 ui
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-deb-2-8-ui-3123.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui subnet-management-deb-2-8-ui-3123.md
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
## snap 2.7 cli
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-7-cli-3114.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli subnet-management-snap-2-7-cli-3114.md
## snap 2.7 ui
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-7-ui-3115.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui subnet-management-snap-2-7-ui-3115.md
## snap 2.8 cli
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-8-cli-3116.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli subnet-management-snap-2-8-cli-3116.md
## snap 2.8 ui
	cp $(SRC)/subnet-management.md $(MODWD)/subnet-management-snap-2-8-ui-3117.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui subnet-management-snap-2-8-ui-3117.md
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

# $(DISC)/supported-versions.md: $(SRC)/supported-versions.md
# 	cp $(SRC)/subnet-management.md $(MODWD)/supported-versions-3771.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) supported-versions-3771.md
# 	cd $(DISC) &&\
# 	xpub pull $(DISC) 3771 3771
# 	cd $(DISC) &&\
# 	cp -p supported-versions-3771.md supported-versions.md
# 	cd $(DISC) && rm supported-versions-3771.md
 
#t

$(DISC)/test-logs.md: $(SRC)/test-logs.md
## deb 2.7 cli
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-7-cli-3132.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli test-logs-deb-2-7-cli-3132.md
## deb 2.7 ui
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-7-ui-3133.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui test-logs-deb-2-7-ui-3133.md
## deb 2.8 cli
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-8-cli-3134.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli test-logs-deb-2-8-cli-3134.md
## deb 2.8 ui
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-deb-2-8-ui-3135.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui test-logs-deb-2-8-ui-3135.md
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
## snap 2.7 cli
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-7-cli-3126.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli test-logs-snap-2-7-cli-3126.md
## snap 2.7 ui
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-7-ui-3127.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui test-logs-snap-2-7-ui-3127.md
## snap 2.8 cli
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-8-cli-3128.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli test-logs-snap-2-8-cli-3128.md
## snap 2.8 ui
	cp $(SRC)/test-logs.md $(MODWD)/test-logs-snap-2-8-ui-3129.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui test-logs-snap-2-8-ui-3129.md
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
## deb 2.7 cli
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-deb-2-7-cli-3156.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli tips-tricks-and-traps-deb-2-7-cli-3156.md
## deb 2.7 ui
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-deb-2-7-ui-3157.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui tips-tricks-and-traps-deb-2-7-ui-3157.md
## deb 2.8 cli
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-deb-2-8-cli-3158.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli tips-tricks-and-traps-deb-2-8-cli-3158.md
## deb 2.8 ui
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-deb-2-8-ui-3159.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui tips-tricks-and-traps-deb-2-8-ui-3159.md
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
## snap 2.7 cli
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-snap-2-7-cli-3150.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli tips-tricks-and-traps-snap-2-7-cli-3150.md
## snap 2.7 ui
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-snap-2-7-ui-3151.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui tips-tricks-and-traps-snap-2-7-ui-3151.md
## snap 2.8 cli
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-snap-2-8-cli-3152.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli tips-tricks-and-traps-snap-2-8-cli-3152.md
## snap 2.8 ui
	cp $(SRC)/tips-tricks-and-traps.md $(MODWD)/tips-tricks-and-traps-snap-2-8-ui-3153.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui tips-tricks-and-traps-snap-2-8-ui-3153.md
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
## deb 2.7 cli
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-deb-2-7-cli-3168.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli troubleshooting-deb-2-7-cli-3168.md
## deb 2.7 ui
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-deb-2-7-ui-3169.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui troubleshooting-deb-2-7-ui-3169.md
## deb 2.8 cli
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-deb-2-8-cli-3170.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli troubleshooting-deb-2-8-cli-3170.md
## deb 2.8 ui
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-deb-2-8-ui-3171.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui troubleshooting-deb-2-8-ui-3171.md
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
## snap 2.7 cli
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-snap-2-7-cli-3162.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli troubleshooting-snap-2-7-cli-3162.md
## snap 2.7 ui
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-snap-2-7-ui-3163.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui troubleshooting-snap-2-7-ui-3163.md
## snap 2.8 cli
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-snap-2-8-cli-3164.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli troubleshooting-snap-2-8-cli-3164.md
## snap 2.8 ui
	cp $(SRC)/troubleshooting.md $(MODWD)/troubleshooting-snap-2-8-ui-3165.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui troubleshooting-snap-2-8-ui-3165.md
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
## deb 2.7 cli
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-7-cli-3180.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli ubuntu-kernels-deb-2-7-cli-3180.md
## deb 2.7 ui
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-7-ui-3181.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui ubuntu-kernels-deb-2-7-ui-3181.md
## deb 2.8 cli
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-8-cli-3182.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli ubuntu-kernels-deb-2-8-cli-3182.md
## deb 2.8 ui
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-deb-2-8-ui-3183.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui ubuntu-kernels-deb-2-8-ui-3183.md
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
## snap 2.7 cli
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-7-cli-3174.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli ubuntu-kernels-snap-2-7-cli-3174.md
## snap 2.7 ui
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-7-ui-3175.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui ubuntu-kernels-snap-2-7-ui-3175.md
## snap 2.8 cli
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-8-cli-3176.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli ubuntu-kernels-snap-2-8-cli-3176.md
## snap 2.8 ui
	cp $(SRC)/ubuntu-kernels.md $(MODWD)/ubuntu-kernels-snap-2-8-ui-3177.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui ubuntu-kernels-snap-2-8-ui-3177.md
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
## deb 2.7 cli
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-7-cli-3204.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli user-accounts-deb-2-7-cli-3204.md
## deb 2.7 ui
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-7-ui-3205.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui user-accounts-deb-2-7-ui-3205.md
## deb 2.8 cli
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-8-cli-3206.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli user-accounts-deb-2-8-cli-3206.md
## deb 2.8 ui
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-deb-2-8-ui-3207.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui user-accounts-deb-2-8-ui-3207.md
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
## snap 2.7 cli
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-7-cli-3198.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli user-accounts-snap-2-7-cli-3198.md
## snap 2.7 ui
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-7-ui-3199.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui user-accounts-snap-2-7-ui-3199.md
## snap 2.8 cli
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-8-cli-3200.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli user-accounts-snap-2-8-cli-3200.md
## snap 2.8 ui
	cp $(SRC)/user-accounts.md $(MODWD)/user-accounts-snap-2-8-ui-3201.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui user-accounts-snap-2-8-ui-3201.md
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
## deb 2.7 cli
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-deb-2-7-cli-4287.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli using-maas-in-an-air-gapped-environment-deb-2-7-cli-4287.md
## deb 2.7 ui
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-deb-2-7-ui-4288.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui using-maas-in-an-air-gapped-environment-deb-2-7-ui-4288.md
## deb 2.8 cli
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-deb-2-8-cli-4269.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli using-maas-in-an-air-gapped-environment-deb-2-8-cli-4269.md
## deb 2.8 ui
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-deb-2-8-ui-4268.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui using-maas-in-an-air-gapped-environment-deb-2-8-ui-4268.md
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
## snap 2.7 cli
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-snap-2-7-cli-4286.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli using-maas-in-an-air-gapped-environment-snap-2-7-cli-4286.md
## snap 2.7 ui
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-snap-2-7-ui-4285.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui using-maas-in-an-air-gapped-environment-snap-2-7-ui-4285.md
## snap 2.8 cli
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-snap-2-8-cli-4272.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli using-maas-in-an-air-gapped-environment-snap-2-8-cli-4272.md
## snap 2.8 ui
	cp $(SRC)/using-maas-in-an-air-gapped-environment.md $(MODWD)/using-maas-in-an-air-gapped-environment-snap-2-8-ui-4271.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui using-maas-in-an-air-gapped-environment-snap-2-8-ui-4271.md
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
## deb 2.7 cli
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-deb-2-7-cli-4330.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli using-image-streams-deb-2-7-cli-4330.md
## deb 2.7 ui
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-deb-2-7-ui-4331.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui using-image-streams-deb-2-7-ui-4331.md
## deb 2.8 cli
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-deb-2-8-cli-4332.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli using-image-streams-deb-2-8-cli-4332.md
## deb 2.8 ui
	cp $(SRC)/using-image-streams.md $(MODWD)/using-image-streams-deb-2-8-ui-4333.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui using-image-streams-deb-2-8-ui-4333.md
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

# $(DISC)/using-rbac-with-maas.md: $(SRC)/using-rbac-with-maas.md
# ## deb 2.7 cli
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-7-cli-3592.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-7-cli using-rbac-with-maas-snap-2-7-cli-3592.md
# ## deb 2.7 ui
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-7-ui-3593.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-7-ui using-rbac-with-maas-snap-2-7-ui-3593.md
# ## deb 2.8 cli
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-8-cli-3594.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-8-cli using-rbac-with-maas-snap-2-8-cli-3594.md
# ## deb 2.8 ui
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-8-ui-3595.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-8-ui using-rbac-with-maas-snap-2-8-ui-3595.md
# ## deb 2.9 cli
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-9-cli-3596.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-9-cli using-rbac-with-maas-snap-2-9-cli-3596.md
# ## deb 2.9 ui
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-2-9-ui-3597.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-2-9-ui using-rbac-with-maas-snap-2-9-ui-3597.md
# ## deb 3.0 cli
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-3-0-cli-4157.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-3-0-cli using-rbac-with-maas-snap-3-0-cli-4157.md
# ## deb 3.0 ui
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-snap-3-0-ui-4158.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t snap-3-0-ui using-rbac-with-maas-snap-3-0-ui-4158.md
# ## snap 2.7 cli
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-7-cli-3598.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-7-cli using-rbac-with-maas-deb-2-7-cli-3598.md
# ## snap 2.7 ui
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-7-ui-3599.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-7-ui using-rbac-with-maas-deb-2-7-ui-3599.md
# ## snap 2.8 cli
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-8-cli-3600.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-8-cli using-rbac-with-maas-deb-2-8-cli-3600.md
# ## snap 2.8 ui
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-8-ui-3601.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-8-ui using-rbac-with-maas-deb-2-8-ui-3601.md
# ## snap 2.9 cli
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-9-cli-3602.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-9-cli using-rbac-with-maas-deb-2-9-cli-3602.md
# ## snap 2.9 ui
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-2-9-ui-3603.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-2-9-ui using-rbac-with-maas-deb-2-9-ui-3603.md
# ## snap 3.0 cli
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-3-0-cli-4159.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-3-0-cli using-rbac-with-maas-deb-3-0-cli-4159.md
# ## snap 3.0 ui
# 	cp $(SRC)/using-rbac-with-maas.md $(MODWD)/using-rbac-with-maas-deb-3-0-ui-4160.md
# 	cd $(MODWD) &&\
# 	xpub push $(DISC) -t deb-3-0-ui using-rbac-with-maas-deb-3-0-ui-4160.md
# ## pull reference version
# 	cd $(DISC) &&\
# 	xpub pull $(DISC) 4160 4160
# ## copy reference version to discourse master
# 	cd $(DISC) &&\
# 	cp -p using-rbac-with-maas-snap-3-0-ui-4160.md using-rbac-with-maas.md
# ## remove reference version
# 	cd $(DISC) && rm using-rbac-with-maas-snap-3-0-ui-4160.md

#v

$(DISC)/vm-hosting.md: $(SRC)/vm-hosting.md
## deb 2.7 cli
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-7-cli-2748.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli vm-hosting-deb-2-7-cli-2748.md
## deb 2.7 ui
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-7-ui-2749.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui vm-hosting-deb-2-7-ui-2749.md
## deb 2.8 cli
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-8-cli-2750.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli vm-hosting-deb-2-8-cli-2750.md
## deb 2.8 ui
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-deb-2-8-ui-2751.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui vm-hosting-deb-2-8-ui-2751.md
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
## snap 2.7 cli
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-7-cli-2742.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli vm-hosting-snap-2-7-cli-2742.md
## snap 2.7 ui
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-7-ui-2743.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui vm-hosting-snap-2-7-ui-2743.md
## snap 2.8 cli
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-8-cli-2744.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli vm-hosting-snap-2-8-cli-2744.md
## snap 2.8 ui
	cp $(SRC)/vm-hosting.md $(MODWD)/vm-hosting-snap-2-8-ui-2745.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui vm-hosting-snap-2-8-ui-2745.md
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
## deb 2.7 cli
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-7-cli-3216.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli vm-host-networking-deb-2-7-cli-3216.md
## deb 2.7 ui
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-7-ui-3217.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui vm-host-networking-deb-2-7-ui-3217.md
## deb 2.8 cli
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-8-cli-3218.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli vm-host-networking-deb-2-8-cli-3218.md
## deb 2.8 ui
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-deb-2-8-ui-3219.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui vm-host-networking-deb-2-8-ui-3219.md
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
## snap 2.7 cli
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-7-cli-3210.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli vm-host-networking-snap-2-7-cli-3210.md
## snap 2.7 ui
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-7-ui-3211.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui vm-host-networking-snap-2-7-ui-3211.md
## snap 2.8 cli
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-8-cli-3212.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli vm-host-networking-snap-2-8-cli-3212.md
## snap 2.8 ui
	cp $(SRC)/vm-host-networking.md $(MODWD)/vm-host-networking-snap-2-8-ui-3213.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui vm-host-networking-snap-2-8-ui-3213.md
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
## deb 2.7 cli
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-7-cli-3228.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli vm-host-storage-pools-deb-2-7-cli-3228.md
## deb 2.7 ui
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-7-ui-3229.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui vm-host-storage-pools-deb-2-7-ui-3229.md
## deb 2.8 cli
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-8-cli-3230.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli vm-host-storage-pools-deb-2-8-cli-3230.md
## deb 2.8 ui
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-deb-2-8-ui-3231.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui vm-host-storage-pools-deb-2-8-ui-3231.md
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
## snap 2.7 cli
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-7-cli-3222.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli vm-host-storage-pools-snap-2-7-cli-3222.md
## snap 2.7 ui
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-7-ui-3223.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui vm-host-storage-pools-snap-2-7-ui-3223.md
## snap 2.8 cli
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-8-cli-3224.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli vm-host-storage-pools-snap-2-8-cli-3224.md
## snap 2.8 ui
	cp $(SRC)/vm-host-storage-pools.md $(MODWD)/vm-host-storage-pools-snap-2-8-ui-3225.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui vm-host-storage-pools-snap-2-8-ui-3225.md
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
## deb 2.7 cli
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-7-cli-3240.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli vmware-images-deb-2-7-cli-3240.md
## deb 2.7 ui
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-7-ui-3241.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui vmware-images-deb-2-7-ui-3241.md
## deb 2.8 cli
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-8-cli-3242.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli vmware-images-deb-2-8-cli-3242.md
## deb 2.8 ui
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-deb-2-8-ui-3243.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui vmware-images-deb-2-8-ui-3243.md
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
## snap 2.7 cli
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-7-cli-3234.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli vmware-images-snap-2-7-cli-3234.md
## snap 2.7 ui
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-7-ui-3235.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui vmware-images-snap-2-7-ui-3235.md
## snap 2.8 cli
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-8-cli-3236.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli vmware-images-snap-2-8-cli-3236.md
## snap 2.8 ui
	cp $(SRC)/vmware-images.md $(MODWD)/vmware-images-snap-2-8-ui-3237.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui vmware-images-snap-2-8-ui-3237.md
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
## deb 2.7 cli
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-7-cli-3252.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli vmware-vmfs-datastores-deb-2-7-cli-3252.md
## deb 2.7 ui
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-7-ui-3253.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui vmware-vmfs-datastores-deb-2-7-ui-3253.md
## deb 2.8 cli
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-8-cli-3254.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli vmware-vmfs-datastores-deb-2-8-cli-3254.md
## deb 2.8 ui
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-deb-2-8-ui-3255.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui vmware-vmfs-datastores-deb-2-8-ui-3255.md
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
## snap 2.7 cli
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-7-cli-3246.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli vmware-vmfs-datastores-snap-2-7-cli-3246.md
## snap 2.7 ui
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-7-ui-3247.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui vmware-vmfs-datastores-snap-2-7-ui-3247.md
## snap 2.8 cli
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-8-cli-3248.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli vmware-vmfs-datastores-snap-2-8-cli-3248.md
## snap 2.8 ui
	cp $(SRC)/vmware-vmfs-datastores.md $(MODWD)/vmware-vmfs-datastores-snap-2-8-ui-3249.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui vmware-vmfs-datastores-snap-2-8-ui-3249.md
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
## deb 2.7 cli
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-deb-2-7-cli-4294.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli whats-new-in-maas-deb-2-7-cli-4294.md
## deb 2.7 ui
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-deb-2-7-ui-4295.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui whats-new-in-maas-deb-2-7-ui-4295.md
## deb 2.8 cli
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-deb-2-8-cli-4292.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli whats-new-in-maas-deb-2-8-cli-4292.md
## deb 2.8 ui
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-deb-2-8-ui-4293.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui whats-new-in-maas-deb-2-8-ui-4293.md
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
## snap 2.7 cli
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-snap-2-7-cli-4300.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli whats-new-in-maas-snap-2-7-cli-4300.md
## snap 2.7 ui
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-snap-2-7-ui-4301.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui whats-new-in-maas-snap-2-7-ui-4301.md
## snap 2.8 cli
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-snap-2-8-cli-4298.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli whats-new-in-maas-snap-2-8-cli-4298.md
## snap 2.8 ui
	cp $(SRC)/whats-new-in-maas.md $(MODWD)/whats-new-in-maas-snap-2-8-ui-4299.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui whats-new-in-maas-snap-2-8-ui-4299.md
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
## deb 2.7 cli
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-deb-2-7-cli-3264.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli writing-guide-deb-2-7-cli-3264.md
## deb 2.7 ui
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-deb-2-7-ui-3265.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui writing-guide-deb-2-7-ui-3265.md
## deb 2.8 cli
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-deb-2-8-cli-3266.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli writing-guide-deb-2-8-cli-3266.md
## deb 2.8 ui
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-deb-2-8-ui-3267.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui writing-guide-deb-2-8-ui-3267.md
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
## snap 2.7 cli
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-snap-2-7-cli-3258.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli writing-guide-snap-2-7-cli-3258.md
## snap 2.7 ui
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-snap-2-7-ui-3259.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui writing-guide-snap-2-7-ui-3259.md
## snap 2.8 cli
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-snap-2-8-cli-3260.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli writing-guide-snap-2-8-cli-3260.md
## snap 2.8 ui
	cp $(SRC)/writing-guide.md $(MODWD)/writing-guide-snap-2-8-ui-3261.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui writing-guide-snap-2-8-ui-3261.md
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
## deb 2.7 cli
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-7-cli-3276.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-cli zone-examples-deb-2-7-cli-3276.md
## deb 2.7 ui
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-7-ui-3277.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-7-ui zone-examples-deb-2-7-ui-3277.md
## deb 2.8 cli
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-8-cli-3278.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-cli zone-examples-deb-2-8-cli-3278.md
## deb 2.8 ui
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-deb-2-8-ui-3279.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t deb-2-8-ui zone-examples-deb-2-8-ui-3279.md
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
## snap 2.7 cli
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-7-cli-3270.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-cli zone-examples-snap-2-7-cli-3270.md
## snap 2.7 ui
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-7-ui-3271.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-7-ui zone-examples-snap-2-7-ui-3271.md
## snap 2.8 cli
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-8-cli-3272.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-cli zone-examples-snap-2-8-cli-3272.md
## snap 2.8 ui
	cp $(SRC)/zone-examples.md $(MODWD)/zone-examples-snap-2-8-ui-3273.md
	cd $(MODWD) &&\
	xpub push $(DISC) -t snap-2-8-ui zone-examples-snap-2-8-ui-3273.md
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
 
# originals/using-lxd-projects-with-maas-4460.md: src/using-lxd-projects-with-maas.md
#	chmod 644 originals/*
#	cp src/using-lxd-projects-with-maas.md using-lxd-projects-with-maas-4460.md
#	xpub pull discourse 4460 4460
#	cp -p using-lxd-projects-with-maas-4460.md originals
#	rm using-lxd-projects-with-maas-4460.md
#	chmod 444 originals/*

# originals/src-maas-project-tutorial-md-4478.md: src/maas-project-tutorial.md
#	chmod 644 originals/*
#	cp src/maas-project-tutorial.md src-maas-project-tutorial-md-4478.md
#	xpub pull discourse 4478 4478
#	cp -p src-maas-project-tutorial-md-4478.md originals
#	rm src-maas-project-tutorial-md-4478.md
#	chmod 444 originals/*

