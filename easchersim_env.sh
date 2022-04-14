#!/bin/sh

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -a : activate conda easchersim"
    echo " [0] -d : deactivate conda easchersim"
}

if [ $# -eq 0 ] 
then    
    printHelp
else
    if [ "$1" = "-d" ]; then
	conda deactivate
    elif [ "$1" = "-a" ]; then
	conda activate easchersim
    elif [ "$1" = "-h" ]; then
        printHelp
    else
        printHelp
    fi
fi

