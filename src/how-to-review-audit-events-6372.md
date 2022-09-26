```nohighlight
$ maas admin events query level=AUDIT after=9 limit=5 | jq -r '(["USERNAME","HOSTNAME","DATE","EVENT"] | (., map(length*"-"))),(.events[] | [.username,.hostname,.created,.description]) | @tsv' | column -t -s$'\t'
```