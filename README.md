# RANCHER-CICD

[![Build Status](https://drone.quving.com/api/badges/Quving/rancher-cicd/status.svg)](https://drone.quving.com/Quving/rancher-cicd)

## Description
This container upgrades a desired deployment on your k8s cluster.

## Available Environment-Variables
| Environment Variable  | Required | Description | Example |
|---------------------- |----------|-------------|---|
| RANCHER_URL           |  :heavy_check_mark:        | [More](https://rancher.com/docs/rancher/v2.x/en/cli/#cli-authentication)          | https://rancher.example.com/v3 |
| RANCHER_TOKEN         |  :heavy_check_mark:        | [More](https://rancher.com/docs/rancher/v2.x/en/cli/#cli-authentication)          |  token-8rhz5:jnpc...l74d |
| KUBERNETES_NAMESPACE  |  :heavy_check_mark:        |  Namespace of your kubernetes Cluster                                             |  testing |   |
| KUBERNETES_DEPLOYMENT |  :heavy_check_mark:        | The deployment Ressource you want to upgrade. Pass multiple deployments by using comma seperated list. (e.g. "foo,bar,baz") | backend-api, nginx-web  |   |
| KUBECTL_OPTIONS       |  :heavy_multiplication_x:  | Arguments passing to kubectl accordingly named to official docs.                  |  '--insecure-skip-tls-verify -...'|   |
| RANCHER_CONTEXT       |  :heavy_multiplication_x:  | In case you've got multiple kubernetes cluster you have to specify a cluster by the context.  |  c-hg9ng:p-49nnp |   |
| STAMP                 |  :heavy_check_mark:        | The value, you want to inject into your container. For instance the commit_sha.   | $(date) |   |

## Usage
### Example: Run a docker-container simply.
```
docker run --rm \
    -e RANCHER_URL='<rancher-url> \
    -e RANCHER_TOKEN='<bearer-token> \
    -e KUBECTL_OPTIONS='--insecure-skip-tls-verify' \
    -e KUBERNETES_NAMESPACE='<namespace>' \
    -e KUBERNETES_DEPLOYMENT='<deployment-name>' \
    -e STAMP="ba1351s12" \
    quving/rancher-cicd:latest
```

## FAQ
### What Rancher-API-Key?
More information can be found here. https://rancher.com/docs/rancher/v2.5/en/user-settings/api-keys/

**Important**
It's important to select 'No scope'. Otherwise the rancher-authorization will not work!
- https://github.com/rancher/rancher/issues/18639



## Useful Resources
- Rancher API-KEYS
   - https://rancher.com/docs/rancher/v2.5/en/user-settings/api-keys/
