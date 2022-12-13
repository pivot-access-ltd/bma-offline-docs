<!-- "MAAS performance" -->
The MAAS engineering team actively works to improve the performance of MAAS.

<a href="#heading--performance-measurements"><h2 id="heading--performance-measurements">Recent performance measurements</h2></a>

Recently, we improved the API performance of MAAS, by testing it with simulated loads.  For this testing, we made the following assumptions:

- five rack controllers
- 48 machines per fabric
- five VMs per LXD host
- three different architectures
- six disks per machine, randomly defined as flat, RAID, LVM, and BCACHE disks
- five network interfaces per machine
- machines in a random status, but mostly Ready or Deployed (which best emulates a real-world scenario)

To measure performance, we use continuous performance monitoring, arranged like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/d/d8a0887dd9d6f01311966c10f5d9093feb76806f.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/d/d8a0887dd9d6f01311966c10f5d9093feb76806f.png"></a>

On a daily basis, we generate simulation data based on the assumptions above, for 10, 100, and 1000 machines.  These three datapoints help us get a sense of how our performance improvements scale.  A Jenkins tool exercises both the REST API and the WebSocket API, trapping the results in a database, from which we can build a dashboard.  The dashboard looks something like this:

<a href="https://discourse.maas.io/uploads/default/original/2X/f/f5f831164e70273e81b4120b442469f665e16b47.png" target = "_blank"><img src="https://discourse.maas.io/uploads/default/original/2X/f/f5f831164e70273e81b4120b442469f665e16b47.png"></a>

Note that we always compare the current stable release with the release in development, so that we can spot issues before they become harder to find and fix.  We also capture profiling data that allows us to find bottlenecks, generating a heatmap that shows which parts of the code are causing issues at the moment.

For example, comparing MAAS 3.2 to MAAS 3.1, machine listings load, on average, 32% faster for the datasets we're using.  

<a href="#heading--history-of-performance-efforts"><h3 id="heading--history-of-performance-efforts">Performance efforts to date</h3></a>

Here's a short history of our performance efforts to date:

- This [video show-and-tell](https://dicourse.maas.io/t/maas-show-and-tell-is-maas-fast-yet/6105)`↗` documents recent efforts to improve MAAS peformance, with quantitative results.
- Here's some [work done by the UI team](https://dicourse.maas.io/t/maas-ui-improving-the-performance-of-maas-ui/5820)`↗` to improve the performance of the UI.

Note that this list only captures the bigger, sustained efforts, although there is a constant focus on weeding out slowdowns when we come across them.

<a href="#heading--collecting-your-own-metrics"><h2 id="heading--collecting-your-own-metrics">Collecting your own metrics</h2></a>

It's possible to [collect your own MAAS metrics](/t/how-to-observe-a-live-maas/5204) -- and even share them with the MAAS engineering team.  We are keen to know everything we can about machine counts, network sizes, and MAAS performance in all areas.  Please use the [discourse performance forum](https://discourse.maas.io/c/maas-performance/26)`↗` to share your feedback and observations.

<a href="#headings--recent-developments"><h2 id="heading--recent-developments">Recent developments</h2></a>

As part of the MAAS 3.2 development effort, we have taken steps to improve the performance of machine listings. To date, we have measured the speed of listing a large number (100-1000) of machines via the REST API to be 32% faster, on average.

<a href="#headings--next-steps"><h2 id="heading--next-steps">Next steps</h2></a>

Currently, we are actively working to improve MAAS performance for other operations, such as search.
