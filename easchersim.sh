#!/bin/bash

# Wed 23 Mar 2022 18:10:24 CET
# Autor: Leonid Burmistrov

#conda env list
#easchersim run test2.ini --output test.root
#easchersim make-config --det-alt 525 --energy 1e+17 -a 68.15 viewing -s yes -p none dummy_test.ini 
#easchersim run test2.ini --output test.root
#easchersim make-config --help
#easchersim make-config --det-alt 525 --energy 1e+17 -a 68.15 viewing -s yes -p none --plots none test2.ini 
#easchersim make-config --det-alt 525 --energy 1e+17 -a 68.15 viewing -s yes test2.ini 
#easchersim make-config test3.ini
#conda env list
#conda activate easchersim
#conda config --set auto_activate_base true
#conda config --set env_prompt '(easchersim)'

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -d      : default"
    echo " [0] -p2     : p2"
    echo " [0] -h      : print help"
}

if [ $# -eq 0 ] 
then    
    printHelp
else
    if [ "$1" = "-d" ]; then
	conda env list
	#conda activate easchersim
	conda config --set auto_activate_base true
	conda config --set env_prompt '(easchersim)'
    elif [ "$1" = "-p2" ]; then
	easchersim make-config --det-alt 525 --energy 1e+17 -a 68.15 viewing -s yes -p none dummy_test.ini 
    elif [ "$1" = "-h" ]; then
	easchersim --help 
	easchersim make-config --help
	easchersim run --help 
        printHelp
    else
        printHelp
    fi
fi

#espeak "I have done"
