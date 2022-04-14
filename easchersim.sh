#!/bin/bash

# Wed 23 Mar 2022 18:10:24 CET
# Autor: Leonid Burmistrov

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -d             : run easchersim"
    echo "     showerID       : shower ID"
    echo " [0] -setdef        : set by default easchersim in terminal"
    echo " [0] -test          : run test (with root output)"
    echo " [0] -testnpz       : run test (with npz output)"
    echo " [0] -i             : install"
    echo " [0] -setCluster    : set up cluster conda on yggdrasil"
    echo " [0] -pyroot        : setup ROOT and Python"
    echo " [0] -mk_ini_Dir    : make ini dirrectories"
    echo "      number of dir : number of dirrectories to make"
    echo " [0] -h             : print help"
}

function run_easchersim {
    runDir='/home/dpncguest/home2/work/POEMMA/geant4/EASCherSim/'
    easchersim run $runDir/ini/EASCherSim_$1.ini --output $runDir/root/EASCherSim_$1.ini.root
    echo 
}

function mk_ini_Dir_sh {
    for i in $(seq 0 $1); do
        dirname=`printf "%05d" $i`
	mkdir -p "./ini/"$dirname
    done
}

if [ $# -eq 0 ] 
then    
    printHelp
else
    if [ "$1" = "-setdef" ]; then
	conda env list
	conda config --set auto_activate_base true
	conda config --set env_prompt '(easchersim)'
    elif [ "$1" = "-i" ]; then
	conda install python -y
	python --version
	which python
	python -m pip install EASCherSim
	conda install -c conda-forge root -y
    elif [ "$1" = "-test" ]; then
	easchersim run test.ini --output test.ini.root
    elif [ "$1" = "-testnpz" ]; then
	easchersim run test.ini --output test.ini.npz
    elif [ "$1" = "-d" ]; then
        if [ $# -eq 2 ]; then
            run_easchersim $2
        else
            printHelp
        fi
    elif [ "$1" = "-mk_ini_Dir" ]; then
        if [ $# -eq 2 ]; then
            mk_ini_Dir_sh $2
        else
            printHelp
        fi
    elif [ "$1" = "-setCluster" ]; then
	module load Anaconda3
	conda activate easchersim
	module list
    elif [ "$1" = "-h" ]; then
	easchersim --help 
	easchersim make-config --help
	easchersim run --help 
        printHelp
    elif [ "$1" = "-pyroot" ]; then
	module load GCC/8.3.0 OpenMPI/3.1.4 ROOT/6.20.04-Python-3.7.4
    else
        printHelp
    fi
fi

#espeak "I have done"
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
#easchersim make-config --det-alt 525 --energy 1e+17 -a 68.15 viewing -s yes -p none dummy_test.ini 
