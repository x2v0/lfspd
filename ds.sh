#!/usr/bin/bash

#set -x

buf="$(termux-clipboard-get)"
fil=$(history | tail -n 2 | head -n 1 | awk '{print  $3}' | sed "s/\.sh/\.ds.sh/g")

echo "$fil"

$(echo "$buf" > "$fil")
#echo $cmd
