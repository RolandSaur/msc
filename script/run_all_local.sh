#!/bin/bash
echo $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
IFS=','
names="$2/list_csv.txt"
counter=1
for files in $(cat $names)
	do
	echo $files 
	./run_individual_local.sh $1 "$2/$files" $counter
	counter=$counter + 1
	done
