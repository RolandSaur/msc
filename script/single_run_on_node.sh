#!/bin/bash
#absolut path where the script is located
script_folder=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#change into temp folder to write to
cd $TEMP

#copy the csv file so that the python script can work with it locally
cp $path_csv $TEMP

#find new path to local csv file
csv_file_name=${path_csv##*/}
local_csv_file="$TEMP/$csv_file_name"

#run the python model
python /home/rsaur/master/msc/src/experiment_hpc.py $local_csv_file $PBS_ARRAYID

#copy all the output back to the main node
cp $TEMP/* $main_node_folder

#delete all the data in the temp folder
rm -f $TEMP/*
