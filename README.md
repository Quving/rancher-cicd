<img src="https://i.imgur.com/Sv1Oqiu.png" width="500"/>

# Rancher-CICD-Deployment
[![Build Status](https://drone.quving.com/api/badges/Quving/rancher-cicd/status.svg)](https://drone.quving.com/Quving/rancher-cicd)

This container upgrades a desired deployment on your k8s cluster.

## Available Environment-Variables
| Environment Variable  | Required | Description | Example |
|---------------------- |----------|-------------|---|
| RANCHER_URL           |  :heavy_check_mark:        | [More](https://rancher.com/docs/rancher/v2.x/en/cli/#cli-authentication)          | https://rancher.example.com/v3 |
| RANCHER_TOKEN         |  :heavy_check_mark:        | [More](https://rancher.com/docs/rancher/v2.x/en/cli/#cli-authentication)          |  token-8rhz5:jnpc...l74d |
| KUBERNETES_NAMESPACE  |  :heavy_check_mark:        |  Namespace of your kubernetes Cluster                                             |  testing |   |
| KUBERNETES_DEPLOYMENT |  :heavy_check_mark:        | The deployment Ressource you want to upgrade. Pass multiple deployments by using comma seperated list. (e.g. "foo,bar,baz") | backend-api, nginx-web  |   |
| RANCHER_CONTEXT       |  :heavy_multiplication_x:  | In case you've got multiple kubernetes cluster you have to specify a cluster by the context.  |  c-hg9ng:p-49nnp |   |
| STAMP                 |  :heavy_check_mark:        | The value, you want to inject into your container. For instance the commit_sha.   | $(date) |   |

## Usage
### Example: Run a docker-container simply.
```
docker run --rm \
    -e RANCHER_URL=${RANCHER_URL}} \
    -e RANCHER_TOKEN=${RANCHER_BEARER} \
    -e KUBERNETES_NAMESPACE=${KUBERNETES_NAMESPACE} \
    -e KUBERNETES_DEPLOYMENT=${KUBERNETES_DEPLOYMENT} \
    -e STAMP="ba1351s12..." \
    quving/rancher-cicd:latest
```


### Example: Update your workload in your .gitlab-ci.yml.

```
...

deploy:
  stage: deploy
  before_script:
    # - Make sure, your docker-image is up-to-date.
  script:
    - docker run --rm
      -e RANCHER_URL=[...]
      -e RANCHER_TOKEN=[...]
      -e RANCHER_CONTEXT=[...]
      -e KUBERNETES_NAMESPACE=[...]
      -e KUBERNETES_DEPLOYMENT=[...]
      -e STAMP=$CI_COMMIT_SHORT_SHA
    quving/rancher-cicd:latest

...
```
