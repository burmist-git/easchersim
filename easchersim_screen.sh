#!/bin/bash

# Wed 26 Mar 2022 13:31:06 CET
# Autor: Leonid Burmistrov

runpath="/home/dpncguest/home2/work/POEMMA/geant4/EASCherSim/"
n_jobs=16
nl=1708

function run_job_sh {
    #nl=$(more $in_csv_file | wc -l)
    #echo $nl
    for i in $(seq 0 $nl); do
        counter_is_ok=0
        while [ $counter_is_ok -eq 0 ]; do
            n_screen=$(screen -ls | grep Detached | wc -l)
            if [ $n_screen -le $n_jobs ]; then
                echo "$i/$nl $n_screen/$n_jobs"
                #screen -S gNEO -L -d -m python $wdir/run_job.py -f $wdir/$out_csv_file
		jobID=`printf "%05d" $i`
		screenName='eas'$jobID
		echo $screenName
		screen -S $screenName -L -d -m $runpath/easchersim.sh -d $jobID;
		#sleep 1
                counter_is_ok=1
            fi
            sleep 10
        done
    done
}

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -d       : default"
    echo " [0] -h       : print help"
}

if [ $# -eq 0 ] 
then    
    printHelp
else
    if [ "$1" = "-d" ]; then
	run_job_sh
    elif [ "$1" = "-h" ]; then
        printHelp
    else
        printHelp
    fi
fi
