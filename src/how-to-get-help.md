The best place to get help with your MAAS issue is on the [MAAS Discourse forum ](https://discourse.maas.io/) ![external-link-icon|15x15](upload://AsoQHBzEFT6NuSK3ZYyhp7S6BMi.png). There, you can interact with the MAAS team as well as search for issues similar to your own.

You might also try the [Ask Ubuntu ](http://askubuntu.com/questions/ask?tags=maas) ![external-link-icon|15x15](upload://AsoQHBzEFT6NuSK3ZYyhp7S6BMi.png) web site.

<h2 id="heading--gathering-debugging-information">Gathering debugging information</h2>

If your question is related to a problem related to a specific MAAS installation, we encourage you to gather debugging information and make it available while asking for help. This will make it much easier for people to assist.

A big step on the way to doing this is by using [sosreport ](https://github.com/sosreport/sosreport) ![external-link-icon|15x15](upload://AsoQHBzEFT6NuSK3ZYyhp7S6BMi.png), an automated information-gathering utility. It is available in the Ubuntu archives:

``` bash
sudo apt install -y sosreport
sudo sosreport -o maas
```

This will create a tarball containing MAAS log files, MAAS configuration files and a dump of the MAAS database. By default, the tarball will end up in /tmp but you can change the location. See the [sosreport man page ](http://manpages.ubuntu.com/cgi-bin/search.py?q=sosreport) for details. If there are things you do not wish to share publicly, feel free to edit the tarball.

The last step is to make this file available by any means at your disposal (openly accessible FTP server, Dropbox, etc.) in order for helpers to be able to get their hands on it.



