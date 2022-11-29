<!-- "How to find machines" -->
The Machines and Devices pages contain a powerful interactive search bar that lets you filter machines and devices.  This article is designed to help you understand how to use this resource. 

#### This article will explain:

- [How to do simple searches](#heading--simple-searches)
- [How to do filtered searches](#heading--filtered-searches)
- [How to create manual filters](#heading--manual-filters)
- [How to set up exact matching](#heading--exact-matching)
- [How to set up partial matching](#heading--partial-matching)
- [How to include multiple search terms](#heading--multiple-search-terms)

This article also includes a [filter properties reference](#heading--filter-properties)

<a href="#heading--simple-searches"><h2 id="heading--simple-searches">How to do simple searches</h2></a>

To begin searching, enter your search text. As you type, MAAS will update search results in real time. You can search across virtually every parameter, including domain, name, tag, power type, IP, status, zone, and so on.

<a href="https://assets.ubuntu.com/v1/ccb90c91-manage-search__2.5_searchbar.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/ccb90c91-manage-search__2.5_searchbar.png"></a>

<a href="#heading--filtered-searches"><h2 id="heading--filtered-searches">How to do filtered searches</h2></a>

Filter your searches to major categories by selecting one from the Filters drop-down menu next to the search bar.

<a href="https://assets.ubuntu.com/v1/6ac5b4ec-manage-search__2.5_filters.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/6ac5b4ec-manage-search__2.5_filters.png"></a>

For example, to find all "New" machines containing the name or tag 'quail', select Status/New from the drop-down Filters menu, and then type the word 'quail' next to it:

<a href="https://assets.ubuntu.com/v1/7b5d8e86-manage-search__2.5_filtered-search.png" target = "_blank"><img src="https://assets.ubuntu.com/v1/7b5d8e86-manage-search__2.5_filtered-search.png"></a>

<a href="#heading--manual-filters"><h3 id="heading--manual-filters">How to create manual filters</h3></a>

Enter filters manually in the search bar to more precisely control your searches:

``` no-highlight
filter-name:([=]val1,...,[=]val2)
```

**Note:** Surround search terms with parentheses when they must occur together, e.g., `status:(failed testing)`.

<a href="#heading--How-to-set-up-exact-matching"><h3 id="heading--How-to-set-up-exact-matching">How to set up exact matching</h3></a>

If you need an exact match, preface the search value with an equal sign. For example, to find machines belonging to a pod named `able-cattle`:

``` no-highlight
pod:=able-cattle
```

<a href="#heading--partial-matching"><h3 id="heading--partial-matching">How to set up partial matching</h3></a>

Without an equal sign, MAAS returns partial matches. For example, the following will display all machines belonging to pods with names containing `able` or `cattle`:

``` no-highlight
pod:able,cattle
```

<a href="#heading--multiple-search-terms"><h3 id="heading--multiple-search-terms">Multiple search terms</h3></a>

MAAS uses Boolean AND logic to evaluate multiple search terms. For example, when you type `pod:able,cattle cpu:=5`, MAAS displays machines that belong to pods with names containing `able` OR `cattle` AND having 5 CPU cores. Similarly, if you enter multiple words into the search tool, e.g., `steady able`, MAAS will display machines matching both terms (e.g., `steady` AND `able`).

<a href="#heading--filter-properties"><h2 id="heading--filter-properties">Filter properties reference</h2></a>

In addition to the major filtering categories available in the Filter drop-down menu, the following machine properties are available as filters:

```nohighlight
1.   architecture
2.   cores
3.   cpu
4.   distro_series
5.   fqdn
6.   ip_addresses
7.   mac
8.   pod
9.   pod-id
10.   pool
11.   power
12.   pxe_mac
13.   pxe_mac_vendor
14.   ram
15.   release
16.   spaces
17.   status
18.   storage
19.   storage_tags
20.   tags
21.   zone
```

For example, the following will search for a machine that has an interface with a specific MAC address marked for PXE booting:

``` no-highlight
pxe_mac:=9e:b0:e4:15:ae:1e
```