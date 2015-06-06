#!/bin/bash
#absolut path where the script is located
script_folder=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#change into temp folder to write to
cd $TEMP
tempfolder=$TEMP"/"$runname"_"$PBS_ARRAYID
#create the tempfolder if it does not exist yet
if [ ! -d $tempfolder ]; then
        mkdir $tempfolder
fi
#copy the csv file so that the python script can work with it locally
cp $path_csv $tempfolder

#find new path to local csv file
csv_file_name=${path_csv##*/}
local_csv_file=$tempfolder"/"$csv_file_name

#run the python model
python /home/rsaur/master/msc/src/experiment_hpc.py $local_csv_file $PBS_ARRAYID

#copy all the output back to the main node
cp $tempfolder/* $main_node_folder

#delete all the data in the temp folder
rm -rf $tempfolder
