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
PROD_VSN := 2.9
TEMP := templates
MOL := maas-offline
PROD_DEB := production-html-deb
PROD_SNAP := production-html-snap


.PHONY: all clean

all: post-build

pre-build:
	mkdir -p backup
	mkdir -p maas-offline
	mkdir -p maas-offline/deb/2.7/ui
	mkdir -p maas-offline/snap/2.7/ui
	mkdir -p maas-offline/deb/2.8/ui
	mkdir -p maas-offline/snap/2.8/ui
	mkdir -p maas-offline/deb/2.9/ui
	mkdir -p maas-offline/snap/2.9/ui
	mkdir -p maas-offline/deb/2.7/cli
	mkdir -p maas-offline/snap/2.7/cli
	mkdir -p maas-offline/deb/2.8/cli
	mkdir -p maas-offline/snap/2.8/cli
	mkdir -p maas-offline/deb/2.9/cli
	mkdir -p maas-offline/snap/2.9/cli

post-build: main-build
	cp -R $(MOL)/deb/$(PROD_VSN)/ui $(PROD_DEB)
	cp -R $(MOL)/deb/$(PROD_VSN)/cli $(PROD_DEB)
	cp -R $(MOL)/snap/$(PROD_VSN)/ui $(PROD_SNAP)
	cp -R $(MOL)/snap/$(PROD_VSN)/cli $(PROD_SNAP)
	cp -R $(MOL)/snap/$(PROD_VSN)/* $(PROD_SNAP)
	cp -R $(MOL)/deb/$(PROD_VSN)/* $(PROD_DEB)
	cp -R images $(PROD_DEB)/ui
	cp -R images $(PROD_DEB)/cli
	cp -R images $(PROD_SNAP)/ui
	cp -R images $(PROD_SNAP)/cli
	cp -R css $(PROD_DEB)/ui
	cp -R css $(PROD_DEB)/cli
	cp -R css $(PROD_SNAP)/ui
	cp -R css $(PROD_SNAP)/cli
	rm template.html

main-build: pre-build
	@$(MAKE) --no-print-directory originals/*.md
	@$(MAKE) --no-print-directory originals/*.msd

originals/%.msd: %.msd
	$(eval BASE = $(notdir $@))
	cp $(BASE) backup/$(BASE)
	scripts/strip-navigation.sh $(BASE)
	sed -i "/|| 2.7/d" $(BASE)
	sed -i "/||2.7/d" $(BASE)
	sed -i "/|-----:|:-----:/d" $(BASE)
	sed -i "/\[CLI\]/d" $(BASE)
	sed -i 's/\[note.*\]/<strong>NOTE:<\/strong> /g' $(BASE)
	sed -i 's/\[\/note.*\]//g' $(BASE)
	$(eval HTML = $(basename $(notdir $@)).html)
	cp templates/$(D27U)/msd-template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(D27UT) $<
	sed -i "s/<li><a href=\"http/<li><a hruf=\"http/" $(HTML)
	sed -i "s/<li><a href=\"/<li><a href=\"ui\//" $(HTML)
	sed -i "s/<li><a hruf/<li><a href/" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(D27)
	cp templates/$(D28U)/msd-template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(D28UT) $<
	sed -i "s/<li><a href=\"http/<li><a hruf=\"http/" $(HTML)
	sed -i "s/<li><a href=\"/<li><a href=\"ui\//" $(HTML)
	sed -i "s/<li><a hruf/<li><a href/" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(D28)
	cp templates/$(D29U)/msd-template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(D29UT) $<
	sed -i "s/<li><a href=\"http/<li><a hruf=\"http/" $(HTML)
	sed -i "s/<li><a href=\"/<li><a href=\"ui\//" $(HTML)
	sed -i "s/<li><a hruf/<li><a href/" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(D29)
	cp templates/$(S27U)/msd-template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(S27UT) $<
	sed -i "s/<li><a href=\"http/<li><a hruf=\"http/" $(HTML)
	sed -i "s/<li><a href=\"/<li><a href=\"ui\//" $(HTML)
	sed -i "s/<li><a hruf/<li><a href/" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(S27)
	cp templates/$(S28U)/msd-template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(S28UT) $<
	sed -i "s/<li><a href=\"http/<li><a hruf=\"http/" $(HTML)
	sed -i "s/<li><a href=\"/<li><a href=\"ui\//" $(HTML)
	sed -i "s/<li><a hruf/<li><a href/" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(S28)
	cp templates/$(S29U)/msd-template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(S27UT) $<
	sed -i "s/<li><a href=\"http/<li><a hruf=\"http/" $(HTML)
	sed -i "s/<li><a href=\"/<li><a href=\"ui\//" $(HTML)
	sed -i "s/<li><a hruf/<li><a href/" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cp $(BASE) originals
	mv $(HTML) $(MOL)/$(S29)
	cp backup/$(BASE) $(BASE)

originals/%.md: %.md
	$(eval BASE = $(notdir $@))
	cp $(BASE) backup/$(BASE)
	sed -i "/|| 2.7/d" $(BASE)
	sed -i "/||2.7/d" $(BASE)
	sed -i "/|-----:|:-----:/d" $(BASE)
	sed -i "/\[CLI\]/d" $(BASE)
	sed -i 's/\[note.*\]/<strong>NOTE:<\/strong> /g' $(BASE)
	sed -i 's/\[\/note.*\]//g' $(BASE)
	$(eval HTML = $(basename $(notdir $@)).html)
	cp templates/$(D27C)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(D27CT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	sed -i 's/-deb-2-7-cli//g' $(BASE)
	mv $(HTML) $(MOL)/$(D27C)
	cp templates/$(D27U)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(D27UT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(D27U)
	cp templates/$(D28C)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(D28CT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(D28C)
	cp templates/$(D28U)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(D28UT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(D28U)
	cp templates/$(D29C)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(D29CT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(D29C)
	cp templates/$(D29U)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(D29UT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(D29U)
	cp templates/$(S27C)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(S27CT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(S27C)
	cp templates/$(S27U)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(S27UT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(S27U)
	cp templates/$(S28C)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(S28CT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(S28C)
	cp templates/$(S28U)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(S28UT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(S28U)
	cp templates/$(S29C)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(S29CT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	mv $(HTML) $(MOL)/$(S29C)
	cp templates/$(S29U)/template.html ./template.html
	sed -i "s|zork|$(HTML)|g" ./template.html
	xpub convert dc2html -t $(S29UT) $(BASE)
	sed -i "s/-[0-9]*.html/.html/g" $(HTML)
	cp $(BASE) originals
	mv $(HTML) $(MOL)/$(S29U)
	cp backup/$(BASE) $(BASE)
