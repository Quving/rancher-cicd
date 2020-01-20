<img src="https://i.imgur.com/Sv1Oqiu.png" width="500"/>

# Rancher-CICD-Deployment
[![Build Status](https://drone.quving.com/api/badges/Quving/rancher-cicd-deployment/status.svg)](https://drone.quving.com/Quving/rancher-cicd-deployment)


This container upgrades a desired deployment on your k8s cluster.


## Available Environment-Variables
| Environment Variable | Required | Description |   |
|----------------------|----------|-------------|---|
| RANCHER_URL          |  :heavy_check_mark:        | [More](https://rancher.com/docs/rancher/v2.x/en/cli/#cli-authentication)           |   |
| RANCHER_TOKEN        |  :heavy_check_mark:        | [More](https://rancher.com/docs/rancher/v2.x/en/cli/#cli-authentication)           |   |
| KUBERNETES_NAMESPACE |  :heavy_check_mark:        |  Namespace of your kubernetes Cluster                                              |   |   |
| KUBERNETES_DEPLOYMENT |  :heavy_check_mark:        | The deployment Ressource you want to upgrade.                                     |   |   |
| KUBERNETES_OPTIONS    |  :heavy_multiplication_x:  | Some options you would like to pass to kubectl.                                   |   |   |
| STAMP                 |  :heavy_check_mark:        | The value, you want to inject into your container. For instance the commit_sha.   |   |   |



## Usage
### Example
```
docker run --rm \
    -e RANCHER_URL=${RANCHER_URL}} \
    -e RANCHER_TOKEN=${RANCHER_BEARER} \
    -e KUBERNETES_NAMESPACE=${KUBERNETES_NAMESPACE} \
    -e KUBERNETES_DEPLOYMENT=${KUBERNETES_DEPLOYMENT} \
    -e STAMP="ba1351s12..." \
    pingu/rancher-cicd-deployment:latest
```
