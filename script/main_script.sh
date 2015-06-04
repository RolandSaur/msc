#!/bin/bash
script_folder=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
files_folder=$1
number_of_runs=$2
pause=$3
walltime=$4

files_csv_files="$files_folder/list_csv.txt"

for file in $(cat $files_csv_files)
	do
	runname=${file%.*}
	.$script_folder/hpc_array_run.sh $runname "$files_folder/$file" $number_of_runs $walltime
	sleep $pause
