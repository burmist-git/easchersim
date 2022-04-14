#!/bin/sh

genHomeDir="/home/users/b/burmistr/easchersim/"
n_jobs=544

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -d    : default"
    echo " [0] -info : print info"
    echo " [0] -kill : kill all jobs"
    echo " [0] -h    : print help"
}

if [ $# -eq 0 ] 
then    
    printHelp
else
    if [ "$1" = "-d" ]; then
	for i in $(seq 0 $n_jobs); do
            jobID=`printf "%05d" $i`
	    sbatch $genHomeDir/easchersim_job.sh -d $jobID
	    #echo "sbatch $genHomeDir/easchersim_job.sh -d $jobID"
	done
    elif [ "$1" = "-info" ]; then
	squeue | head -n 1
	squeue | grep burmistr
    elif [ "$1" = "-kill" ]; then
	scancel --user=burmistr --state=pending
	scancel --user=burmistr --state=CG
	scancel --user=burmistr --state=R
    elif [ "$1" = "-h" ]; then
	printHelp
    else
        printHelp
    fi
fi

#espeak "I have done"
