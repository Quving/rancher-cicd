#!/bin/bash

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
    RANCHER_OPTIONS="--context $RANCHNER_CONTEXT"
fi

# Rancher login
logInfo "Login to kubernetes cluster..."
rancher login $RANCHER_URL --token $RANCHER_TOKEN $RANCHER_OPTIONS > /dev/null 2>&1

# If login failed.
if [ ! "$(echo $?)" == 0 ]; then
    logError "Wrong credentials provided. Check your 'RANCHER_URL' and 'RANCHER_TOKEN'"
    exit 1
fi
logInfo "Logged in successfully."

# Deploy service
KUBECTL_OPTIONS=${KUBECTL_OPTIONS:-''}
logInfo "Upgrade $KUBERNETES_DEPLOYMENT."
rancher kubectl $KUBECTL_OPTIONS set env deployments/$KUBERNETES_DEPLOYMENT -n $KUBERNETES_NAMESPACE GIT_HASH=$STAMP > /dev/null 2>&1
rancher kubectl $KUBECTL_OPTIONS rollout status deployments/$KUBERNETES_DEPLOYMENT -n $KUBERNETES_NAMESPACE -w
logInfo "Upgrade succeeded."
