#!/bin/sh
#SBATCH --job-name easc%j
#SBATCH --error /home/users/b/burmistr/easchersim/job_error/crgen_%j.error
#SBATCH --output /home/users/b/burmistr/easchersim/job_output/output_%j.output
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --partition public-cpu
#SBATCH --time 2-00:00:00

#source /home/users/b/burmistr/easchersim/easchersim_env.sh -a

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -d    : single job"
    echo " [1]       : jobID"
    echo " [0] -h    : print help"
}

if [ $# -eq 0 ] 
then
    printHelp
else
    if [ "$1" = "-d" ]; then
        if [ $# -eq 2 ]; then
	    genHomeDir="/home/users/b/burmistr/easchersim/"
	    npzHomeDir="/home/users/b/burmistr/easchersim/npz/"
	    jobID=$2
	    mkdir -p $npzHomeDir/$jobID
	    for iniFile in $genHomeDir/ini/$jobID/* ; do
		npzFile=$npzHomeDir/$jobID/`basename "$iniFile"`'.npz'
		#echo "$iniFile"
		#echo "$npzFile"
		echo "srun easchersim run $iniFile --output $npzFile"
		srun easchersim run $iniFile --output $npzFile
	    done
	else
            printHelp
	fi
    elif [ "$1" = "-h" ]; then
        printHelp
    else
        printHelp
    fi
fi

#espeak "I have done"
