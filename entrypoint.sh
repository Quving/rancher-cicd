#!/bin/bash

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

# Check envs
logInfo "Check environment variables..."
to_track=( RANCHER_URL RANCHER_TOKEN KUBERNETES_DEPLOYMENT KUBERNETES_NAMESPACE STAMP )
for env in "${to_track[@]}"; do
    if [ "${!env}" = "" ]; then
       	logError "Please set a value for $env"
	exit -1
    fi
done

if [ "${RANCHER_CONTEXT}" = "" ]; then
    RANCHER_OPTIONS=""
else
    RANCHER_OPTIONS="--context $RANCHER_CONTEXT"
fi

# Rancher login
logInfo "Login to kubernetes cluster..."
if [ "${DEBUG}" = "true" ]; then
    rancher login $RANCHER_URL --token $RANCHER_TOKEN $RANCHER_OPTIONS
else
    rancher login $RANCHER_URL --token $RANCHER_TOKEN $RANCHER_OPTIONS > /dev/null 2>&1
fi

# If login failed.
if [ ! "$(echo $?)" == 0 ]; then
    logError "Wrong credentials provided. Check your 'RANCHER_URL' and 'RANCHER_TOKEN'"
    exit 1
fi
logInfo "Logged in successfully."

# Deploy service(s)
IFS=',' # hyphen (-) is set as delimiter
read -ra ADDR <<< "$KUBERNETES_DEPLOYMENT" # str is read into an array as tokens separated by IFS
for workload in "${ADDR[@]}"; do # access each element of array

    logInfo "Upgrade $workload..."
    rancher kubectl $KUBECTL_OPTIONS set env deployments/$workload -n $KUBERNETES_NAMESPACE GIT_HASH=$STAMP > error.log 2>&1

    logInfo "Rollout status:"
    rancher kubectl $KUBECTL_OPTIONS rollout status deployments/$workload -n $KUBERNETES_NAMESPACE -w

    # If upgrade failed.
    if [ ! "$(echo $?)" == 0 ]; then
        logError "Error occured while upgrading k8s deployment ($workload). Please check the logs below."
        printf "\n"
        cat error.log
        printf "\n"
        logError "Deployment failed."
        exit 1
    fi
done
logInfo "Upgrade succeeded."
