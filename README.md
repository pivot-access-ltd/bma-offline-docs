# repository structure and usage:

## development files:

* README.md   - this file.
* bin         - all scripts and programs needed to generate MAAS discourse and offline docs.
* discourse   - latest discourse versions, needed by `make discourse` command in makefile.
* html        - latest html versions, needed by `make html` command in makefile.
*  /css       - the css files for the offline docs, incorporating vanilla style.
*  /images    - the images for the offline docs.
*  /templates - the lhs menu templates for the offline docs.
* makefile    - the unified makefile.
* snippets    - various snippets for use when editing RAD docs.
* source-docs - the master docs from which all RAD and offline versions are generated.

## production files:

* production-html-deb  - offline doc for current package version of MAAS.
* production-html-snap - offline doc for current snap version of MAAS.

## SPECIAL NOTE:

the makefile contained in this push is *not* correct, needs to be adjusted to new directory structure.
