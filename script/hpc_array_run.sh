#!/bin/bash
#absolut path where the script is located
script_folder=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

runname=$1
path_csv=$2
numberruns=$3
walltime=$4

#jump to home folder and create folder for the output of this specific configuration
cd $HOME
main_node_folder=$HOME/$runname
mkdir main_node_folder
stream_output=$runname/streamoutput
mkdir $stream_output

TEMP="/var/tmp"
RAMDISK="/tmp/ramdisk"

qsub -t 1-$numberruns -N $runname -l nodes=1:ppn=2,mem=3000mb,walltime=$walltime -o $stream_output -e $stream_output -v path_csv=$path_csv,TEMP=$TEMP,RAMDISK=$RAMDISK,main_node_folder=$main_node_folder .$script_folder/single_run_on_node.sh 
