#!/bin/bash*

set -e

function  logInfo() {
    color=`tput setaf 2`
    echo -e $2 "[ ${color}Info$(tput sgr0) ]    $(date "+%D-%T")\t $(tput bold)$1$(tput sgr0)"
}

function  logError() {
    color=`tput setaf 1`
    echo -e $2 "[ ${color}Error$(tput sgr0) ]   $(date "+%D-%T")\t $(tput bold)$1$(tput sgr0)"
}

function  logWarn() {
    color=`tput setaf 3`
    echo -e $2 "[ ${color}Warning$(tput sgr0) ] $(date "+%D-%T")\t $(tput bold)$1$(tput sgr0)"
}


# ==  Rancher login == 
# Check envs
logInfo "Check environment variables."
to_track=( RANCHER_URL RANCHER_TOKEN )
for env in "${to_track[@]}"; do 
    if [ -z "$env" ]; then
       logError "Please set a value for $env"
    fi
done

rancher login $RANCHER_URL --token $RANCHER_TOKEN

