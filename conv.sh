#!/bin/sh
#SBATCH --job-name easc%j
#SBATCH --error /home/users/b/burmistr/easchersim/job_error/conv_%j.error
#SBATCH --output /home/users/b/burmistr/easchersim/job_output/conv_%j.output
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --partition public-cpu
#SBATCH --time 0-04:00:00

module load GCC/8.3.0 OpenMPI/3.1.4 ROOT/6.20.04-Python-3.7.4

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -d    : convert npz to root"
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
	    rootHomeDir="/home/users/b/burmistr/easchersim/root/"
	    jobID=$2
	    mkdir -p $rootHomeDir/$jobID
	    for npzFile in $npzHomeDir/$jobID/* ; do
		rootFile=$rootHomeDir/$jobID/`basename "$npzFile"`'.root'
		echo "$npzFile"
		#echo "$rootFile"
		#echo "srun python3 conv.py $npzFile $rootFile"
		srun python3 conv.py $npzFile $rootFile
		#python3 conv.py $npzFile $rootFile
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
