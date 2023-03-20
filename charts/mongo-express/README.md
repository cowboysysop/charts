# Mongo Express

[Mongo Express](https://github.com/mongo-express/mongo-express) is a web-based MongoDB admin interface, written with Node.js and express.

**DISCLAIMER**: This is an unofficial chart not supported by Mongo Express authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/mongo-express
```

## Introduction

This chart bootstraps a Mongo Express deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes >= 1.19
- Helm >= 3.1

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/mongo-express
```

These commands deploy Mongo Express on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/mongo-express
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

### Upgrading to version 3.0.0

Some parameters related to image management have been modified:

- Registry prefix in `image.repository` parameters is now configured in `image.registry`.
- Parameter `imagePullSecrets` has been renamed `global.imagePullSecrets`.

### Upgrading to version 2.0.0

The chart is no more compatible with Helm 2.

Refer to the [Helm documentation](https://helm.sh/docs/topics/v2_v3_migration/) for more information.

## Uninstalling

Uninstall the `my-release` deployment using:

```bash
$ helm uninstall my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

## Configuration

The following tables lists all the configurable parameters expose by the chart and their default values.

### Global parameters

| Name                      | Description                                     | Default |
|---------------------------|-------------------------------------------------|---------|
| `global.imageRegistry`    | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Common parameters

| Name                | Description                                                                                        | Default |
|---------------------|----------------------------------------------------------------------------------------------------|---------|
| `kubeVersion`       | Override Kubernetes version                                                                        | `""`    |
| `nameOverride`      | Partially override `mongo-express.fullname` template with a string (will prepend the release name) | `nil`   |
| `fullnameOverride`  | Fully override `mongo-express.fullname` template with a string                                     | `nil`   |
| `commonAnnotations` | Annotations to add to all deployed objects                                                         | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                              | `{}`    |
| `extraDeploy`       | Array of extra objects to deploy with the release                                                  | `[]`    |

### Parameters

| Name                                 | Description                                                                                           | Default                                               |
|--------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------|
| `replicaCount`                       | Number of replicas                                                                                    | `1`                                                   |
| `image.registry`                     | Image registry                                                                                        | `docker.io`                                           |
| `image.repository`                   | Image repository                                                                                      | `mongo-express`                                       |
| `image.tag`                          | Image tag                                                                                             | `0.54.0`                                              |
| `image.digest`                       | Image digest                                                                                          | `""`                                                  |
| `image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                        |
| `pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                               |
| `pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                   |
| `pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                 |
| `serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                                |
| `serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                                  |
| `serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `mongo-express.fullname` template |
| `podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                                  |
| `podLabels`                          | Additional pod labels                                                                                 | `{}`                                                  |
| `podSecurityContext`                 | Pod security context                                                                                  | `{}`                                                  |
| `priorityClassName`                  | Priority class name                                                                                   | `nil`                                                 |
| `securityContext`                    | Container security context                                                                            | `{}`                                                  |
| `livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                                |
| `livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                                   |
| `livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                                  |
| `livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                                   |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                   |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                   |
| `readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                                |
| `readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                                   |
| `readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                                  |
| `readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                                   |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                   |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                   |
| `service.annotations`                | Service annotations                                                                                   | `{}`                                                  |
| `service.type`                       | Service type                                                                                          | `ClusterIP`                                           |
| `service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                                 |
| `service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                                                 |
| `service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                                                 |
| `service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                                             |
| `service.port`                       | Service port                                                                                          | `8081`                                                |
| `service.nodePort`                   | Service node port when service type is LoadBalancer or NodePort                                       | `nil`                                                 |
| `ingress.enabled`                    | Enable ingress controller resource                                                                    | `false`                                               |
| `ingress.ingressClassName`           | IngressClass that will be be used to implement the Ingress                                            | `""`                                                  |
| `ingress.pathType`                   | Ingress path type                                                                                     | `ImplementationSpecific`                              |
| `ingress.annotations`                | Ingress annotations                                                                                   | `{}`                                                  |
| `ingress.hosts[0].host`              | Hostname to your Mongo Express installation                                                           | `mongo-express.local`                                 |
| `ingress.hosts[0].paths`             | Paths within the url structure                                                                        | `[/]`                                                 |
| `ingress.tls[0].secretName`          | TLS Secret (certificates)                                                                             | `nil`                                                 |
| `ingress.tls[0].hosts[0]`            | TLS hosts                                                                                             | `nil`                                                 |
| `resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                                  |
| `nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                                  |
| `tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                                  |
| `affinity`                           | Map of node/pod affinities                                                                            | `{}`                                                  |
| `extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                                  |
| `extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                 |
| `extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                                 |
| `mongodbServer`                      | MongoDB host name or IP address                                                                       | `mongodb`                                             |
| `mongodbPort`                        | MongoDB port                                                                                          | `27017`                                               |
| `mongodbEnableAdmin`                 | Enable administrator access                                                                           | `false`                                               |
| `mongodbAdminUsername`               | Administrator username                                                                                | `root`                                                |
| `mongodbAdminPassword`               | Administrator password                                                                                | `nil`                                                 |
| `mongodbAuthDatabase`                | Database name (only needed if `mongodbEnableAdmin` is `false`)                                        | `nil`                                                 |
| `mongodbAuthUsername`                | Database username (only needed if `mongodbEnableAdmin` is `false`)                                    | `nil`                                                 |
| `mongodbAuthPassword`                | Database password (only needed if `mongodbEnableAdmin` is `false`)                                    | `nil`                                                 |
| `siteBaseUrl`                        | Set the express baseUrl to ease mounting at a subdirectory                                            | `/`                                                   |
| `siteCookieSecret`                   | String used by cookie-parser middleware to sign cookies                                               | Random 32 character long alphanumeric string          |
| `siteSessionSecret`                  | String used to sign the session ID cookie by express-session middleware                               | Random 32 character long alphanumeric string          |
| `basicAuthUsername`                  | Mongo Express web login name                                                                          | `nil`                                                 |
| `basicAuthPassword`                  | Mongo Express Web login password                                                                      | `nil`                                                 |
| `existingSecret`                     | Name of existing Secret to use                                                                        | `nil`                                                 |
| `mongodb.enabled`                    | Whether to use the MongoDB chart (for testing purposes only)                                          | `false`                                               |

### Tests parameters

| Name                     | Description       | Default              |
|--------------------------|-------------------|----------------------|
| `tests.image.registry`   | Image registry    | `ghcr.io`            |
| `tests.image.repository` | Image repository  | `cowboysysop/pytest` |
| `tests.image.tag`        | Image tag         | `1.0.35`             |
| `tests.image.digest`     | Image digest      | `""`                 |
| `tests.image.pullPolicy` | Image pull policy | `IfNotPresent`       |

### Setting parameters

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/mongo-express
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/mongo-express
```

**TIP**: You can use the default [values.yaml](values.yaml).
