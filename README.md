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
* src 	      - the master docs from which all RAD and offline versions are generated.

## production files:

* production-html-deb  - offline doc for current package version of MAAS.
* production-html-snap - offline doc for current snap version of MAAS.

# how docs are maintained

Edits are made to the markdown files in the `/src` directory.  These files are in RAD format, which means that they have comments specific to version, interface, and packaging method, like this:

<pre>
<!-- snap-2-9-cli
   some text in between comments
 snap-2-9-cli -->
</pre>

The text between the comments only appears for the RAD version(s) listed in the comments.  If there is more than one RAD version that applies, all applicable versions are included in the same comment, like this:

<pre>
<!-- snap-2-9-cli snap-3-0-cli
   some text in between comments
 snap-2-9-cli snap-3-0-cli -->

You need to check carefully to see if text is repeated in different comments.  Sometimes this is necessary because it's impossible to make a contiguous paragraph work well with different comments, due to the fact that markdown honors all linefeeds.  Hence you may have to change the same text in more than one place.  My plan for the next RAD update should completely eliminate this problem, but I haven't gotten there yet.

# how docs are generated

The makefile compares timestamps from `/discourse/filename.md` and `/src/filename.md`, in the usual way.  Note that the timestamps in `/discourse/...` are taken from the article in discourse to ensure there are no issues with overwriting local changes to the files on discourse (via the discourse editing window).

The `xpub` tool should refuse to update a file (and give a command line warning) when the timestamp of a discourse file is later than the timestamp of the source markdown.  This can lead to situations where make won't run right, which is intentional.  When this happens, you have to either go to discourse and manually view the changes (which is usually easier), or pull down a separate copy of the discourse file with `xpub` and do a `diff` to find the changes.

Since the discourse window highlights changes between versions, the most efficient way is to use the relative timestamps to identify the last version of a source markdown you pushed, and then compare that to the online changes made in the next version.  They may be as subtle as changing a source-block from just three backticks:

```

to three backticks with a qualifier:

```text

so you'll need to look carefully.  
