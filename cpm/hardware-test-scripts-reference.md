<a href="#heading--included-scripts"><h2 id="heading--included-scripts">Available test scripts reference</h2></a>

The following hardware testing scripts are available during machine commissioning:

<table style="width:100%;">
<thead>
<tr class="header">
<th align="center">Name</th>
<th align="center">Category Tags</th>
<th align="center">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>smartctl-short</strong></td>
<td align="center">storage</td>
<td align="center">Run the short SMART self-test and validate SMART health on all drives in parallel</td>
</tr>
<tr class="even">
<td align="center"><strong>smartctl-long</strong></td>
<td align="center">storage</td>
<td align="center">Run the long SMART self-test and validate SMART health on all drives in parallel</td>
</tr>
<tr class="odd">
<td align="center"><strong>smartctl-conveyance</strong></td>
<td align="center">storage</td>
<td align="center">Run the conveyance SMART self-test and validate SMART health on all drives in parallel</td>
</tr>
<tr class="even">
<td align="center"><strong>memtester</strong></td>
<td align="center">memory</td>
<td align="center">Run memtester against all available userspace memory.</td>
</tr>
<tr class="odd">
<td align="center"><strong>internet-connectivity</strong></td>
<td align="center">network, internet, node</td>
<td align="center">Check if the system has access to the internet.</td>
</tr>
<tr class="even">
<td align="center"><strong>stress-ng-cpu-long</strong></td>
<td align="center">cpu</td>
<td align="center">Run stress-ng memory tests for 12 hours.</td>
</tr>
<tr class="odd">
<td align="center"><strong>stress-ng-cpu-short</strong></td>
<td align="center">cpu</td>
<td align="center">Run stress-ng memory tests for 5 minutes.</td>
</tr>
<tr class="even">
<td align="center"><strong>stress-ng-memory-long</strong></td>
<td align="center">memory</td>
<td align="center">Run stress-ng memory tests for 12 hours.</td>
</tr>
<tr class="odd">
<td align="center"><strong>stress-ng-memory-short</strong></td>
<td align="center">memory</td>
<td align="center">Run stress-ng memory tests for 5 minutes.</td>
</tr>
<tr class="even">
<td align="center"><strong>ntp</strong></td>
<td align="center">network, ntp, node</td>
<td align="center">Run ntp clock set to verify NTP connectivity.</td>
</tr>
<tr class="odd">
<td align="center"><strong>badblocks</strong></td>
<td align="center">storage</td>
<td align="center">Run badblocks on disk in read-only mode.</td>
</tr>
<tr class="even">
<td align="center"><strong>badblocks-destructive</strong></td>
<td align="center">destructive, storage</td>
<td align="center">Run badblocks on a disk in read/write destructive mode.</td>
</tr>
<tr class="odd">
<td align="center"><strong>7z</strong></td>
<td align="center">cpu</td>
<td align="center">Run <em>7zip</em> CPU benchmarking.</td>
</tr>
<tr class="even">
<td align="center"><strong>fio</strong></td>
<td align="center">storage, destructive</td>
<td align="center">Run Fio benchmarking against selected storage devices.</td>
</tr>
</tbody>
</table>

After either commissioning, testing, or installation has started, MAAS reports in real-time which script is running.

You can access the verbatim output from any test by selecting a machine, selecting the 'Hardware tests' page and clicking on the 'Log view' link in the 'Results' column for the specific test.

<!-- comment -->
