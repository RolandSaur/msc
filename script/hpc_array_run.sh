#!/bin/bash
#absolut path where the script is located
script_folder=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

runname=$1
path_csv=$2
numberruns=$3
walltime=$4

#jump to home folder and create folder for the output of this specific configuration
cd $HOME
data_output="$HOME/main_node_folder"
if [ ! -d $data_output ]; then
	mkdir $data_output
fi
main_node_folder="$data_output/$runname"
if [ ! -d $main_node_folder ]; then 
	mkdir $main_node_folder
fi
stream_output="$main_node_folder/streamoutput"
if [ ! -d $stream_output ];then
	mkdir $stream_output
fi

TEMP="/var/tmp"
RAMDISK="/tmp/ramdisk"
echo $walltime
#qsub -t 1-$numberruns -N $runname -l nodes=1:ppn=1,mem=100mb,walltime=$walltime -o $stream_output -e $stream_output -v path_csv=$path_csv,runname=$runname,TEMP=$TEMP,RAMDISK=$RAMDISK,main_node_folder=$main_node_folder $script_folder/single_run_on_node.sh 
