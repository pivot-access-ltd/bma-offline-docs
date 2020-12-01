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
	scripts/strip-navigation.sh $(BASE)
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
# originals/using-image-streams-3523.md: image-streams.md
#	chmod 644 originals/*
#	cp image-streams.md using-image-streams-3523.md
#	xpub pull discourse 3523 3523
#	cp -p using-image-streams-3523.md originals
#	rm using-image-streams-3523.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-snap-2-7-cli-3592.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-snap-2-7-cli-3592.md
#	xpub push discourse -t snap-2-7-cli using-rbac-with-maas-snap-2-7-cli-3592.md
#	xpub pull discourse 3592 3592
#	cp -p using-rbac-with-maas-snap-2-7-cli-3592.md originals
#	rm using-rbac-with-maas-snap-2-7-cli-3592.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-snap-2-7-ui-3593.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-snap-2-7-ui-3593.md
#	xpub push discourse -t snap-2-7-ui using-rbac-with-maas-snap-2-7-ui-3593.md
#	xpub pull discourse 3593 3593
#	cp -p using-rbac-with-maas-snap-2-7-ui-3593.md originals
#	rm using-rbac-with-maas-snap-2-7-ui-3593.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-snap-2-8-cli-3594.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-snap-2-8-cli-3594.md
#	xpub push discourse -t snap-2-8-cli using-rbac-with-maas-snap-2-8-cli-3594.md
#	xpub pull discourse 3594 3594
#	cp -p using-rbac-with-maas-snap-2-8-cli-3594.md originals
#	rm using-rbac-with-maas-snap-2-8-cli-3594.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-snap-2-8-ui-3595.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-snap-2-8-ui-3595.md
#	xpub push discourse -t snap-2-8-ui using-rbac-with-maas-snap-2-8-ui-3595.md
#	xpub pull discourse 3595 3595
#	cp -p using-rbac-with-maas-snap-2-8-ui-3595.md originals
#	rm using-rbac-with-maas-snap-2-8-ui-3595.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-snap-2-9-cli-3596.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-snap-2-9-cli-3596.md
#	xpub push discourse -t snap-2-9-cli using-rbac-with-maas-snap-2-9-cli-3596.md
#	xpub pull discourse 3596 3596
#	cp -p using-rbac-with-maas-snap-2-9-cli-3596.md originals
#	rm using-rbac-with-maas-snap-2-9-cli-3596.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-snap-2-9-ui-3597.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-snap-2-9-ui-3597.md
#	xpub push discourse -t snap-2-9-ui using-rbac-with-maas-snap-2-9-ui-3597.md
#	xpub pull discourse 3597 3597
#	cp -p using-rbac-with-maas-snap-2-9-ui-3597.md originals
#	rm using-rbac-with-maas-snap-2-9-ui-3597.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-deb-2-7-cli-3598.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-deb-2-7-cli-3598.md
#	xpub push discourse -t deb-2-7-cli using-rbac-with-maas-deb-2-7-cli-3598.md
#	xpub pull discourse 3598 3598
#	cp -p using-rbac-with-maas-deb-2-7-cli-3598.md originals
#	rm using-rbac-with-maas-deb-2-7-cli-3598.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-deb-2-7-ui-3599.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-deb-2-7-ui-3599.md
#	xpub push discourse -t deb-2-7-ui using-rbac-with-maas-deb-2-7-ui-3599.md
#	xpub pull discourse 3599 3599
#	cp -p using-rbac-with-maas-deb-2-7-ui-3599.md originals
#	rm using-rbac-with-maas-deb-2-7-ui-3599.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-deb-2-8-cli-3600.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-deb-2-8-cli-3600.md
#	xpub push discourse -t deb-2-8-cli using-rbac-with-maas-deb-2-8-cli-3600.md
#	xpub pull discourse 3600 3600
#	cp -p using-rbac-with-maas-deb-2-8-cli-3600.md originals
#	rm using-rbac-with-maas-deb-2-8-cli-3600.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-deb-2-8-ui-3601.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-deb-2-8-ui-3601.md
#	xpub push discourse -t deb-2-8-ui using-rbac-with-maas-deb-2-8-ui-3601.md
#	xpub pull discourse 3601 3601
#	cp -p using-rbac-with-maas-deb-2-8-ui-3601.md originals
#	rm using-rbac-with-maas-deb-2-8-ui-3601.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-deb-2-9-cli-3602.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-deb-2-9-cli-3602.md
#	xpub push discourse -t deb-2-9-cli using-rbac-with-maas-deb-2-9-cli-3602.md
#	xpub pull discourse 3602 3602
#	cp -p using-rbac-with-maas-deb-2-9-cli-3602.md originals
#	rm using-rbac-with-maas-deb-2-9-cli-3602.md
#	chmod 444 originals/*

# originals/using-rbac-with-maas-deb-2-9-ui-3603.md: using-rbac-with-maas.md
#	chmod 644 originals/*
#	cp using-rbac-with-maas.md using-rbac-with-maas-deb-2-9-ui-3603.md
#	xpub push discourse -t deb-2-9-ui using-rbac-with-maas-deb-2-9-ui-3603.md
#	xpub pull discourse 3603 3603
#	cp -p using-rbac-with-maas-deb-2-9-ui-3603.md originals
#	rm using-rbac-with-maas-deb-2-9-ui-3603.md
#	chmod 444 originals/*

# originals/test-file-3609.md: maas-log-file.md
#	chmod 644 originals/*
#	cp maas-log-file.md test-file-3609.md
#	xpub pull discourse 3609 3609
#	cp -p test-file-3609.md originals
#	rm test-file-3609.md
#	chmod 444 originals/*

# originals/candid-tutorial-3610.md: candid-tutorial.md
#	chmod 644 originals/*
#	cp candid-tutorial.md candid-tutorial-3610.md
#	xpub pull discourse 3610 3610
#	cp -p candid-tutorial-3610.md originals
#	rm candid-tutorial-3610.md
#	chmod 444 originals/*

