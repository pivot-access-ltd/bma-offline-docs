<!-- Search and filter -->
<a href="#heading--About-the-MAAS-search-parameter"><h2 id="heading--About-the-MAAS-search-parameter">About the MAAS search parameter</h2></a>

A valid MAAS search parameter looks like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/dcf5037cdd886eb85a2d305fd3df111b38865cea.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/dcf5037cdd886eb85a2d305fd3df111b38865cea.png"></a>

Each search attribute is placed in the Search box, separated by spaces (if it's an "AND" search operation), or by parentheses and commas (if's it's an "OR" operation).  Specific search parameters use the notation "parameter-name" followed by a colon (":").  For example, here we're searching for "pod:", which equates to the pod name (VM name).  

You can match exactly by using the equals sign ("=") with a filter fragment, or make a partial match by excluding the "=".  You can get an idea how these parameters work by using the filter dropdowns in the UI, which generate a valid search expression in the "Search" box.  There is also a "not" operator ("!") which can be applied to partial or exact matches.

<a href="#heading--multiple-search-terms"><h3 id="heading--multiple-search-terms">Multiple search terms</h3></a>

MAAS uses Boolean AND logic to evaluate multiple search terms. For example, when you type `pod:able,cattle cpu:=5`, MAAS displays machines that belong to pods with names containing `able` OR `cattle` AND having 5 CPU cores. Similarly, if you enter multiple words into the search tool, e.g., `steady able`, MAAS will display machines matching both terms (e.g., `steady` AND `able`).

