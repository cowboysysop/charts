# Whoami

[Whoami](https://github.com/containous/whoami) is a tiny Go webserver that prints os information and HTTP request to output.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/whoami
```

## Introduction

This chart bootstraps a Whoami deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.16+ (should work with 1.12+)
- Helm 3.1+

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/whoami
```

These commands deploy Whoami on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/whoami
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

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

### Common parameters

| Name                | Description                                                                                 | Default |
|---------------------|---------------------------------------------------------------------------------------------|---------|
| `kubeVersion`       | Override Kubernetes version                                                                 | `""`    |
| `imagePullSecrets`  | Docker registry secret names as an array                                                    | `[]`    |
| `nameOverride`      | Partially override `whoami.fullname` template with a string (will prepend the release name) | `nil`   |
| `fullnameOverride`  | Fully override `whoami.fullname` template with a string                                     | `nil`   |
| `commonAnnotations` | Annotations to add to all deployed objects                                                  | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                       | `{}`    |

### Parameters

| Name                                 | Description                                                                                           | Default                                        |
|--------------------------------------|-------------------------------------------------------------------------------------------------------|------------------------------------------------|
| `replicaCount`                       | Number of replicas                                                                                    | `1`                                            |
| `image.repository`                   | Whoami image name                                                                                     | `containous/whoami`                            |
| `image.tag`                          | Whoami image tag                                                                                      | `v1.5.0`                                       |
| `image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                 |
| `pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                        |
| `pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                            |
| `pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                          |
| `serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                         |
| `serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                           |
| `serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `whoami.fullname` template |
| `podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                           |
| `podLabels`                          | Additional pod labels                                                                                 | `{}`                                           |
| `podSecurityContext`                 | Pod security context                                                                                  | `{}`                                           |
| `priorityClassName`                  | Priority class name                                                                                   | `nil`                                          |
| `securityContext`                    | Container security context                                                                            | `{}`                                           |
| `livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                         |
| `livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                            |
| `livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                           |
| `livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                            |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                            |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                            |
| `readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                         |
| `readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                            |
| `readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                           |
| `readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                            |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                            |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                            |
| `service.annotations`                | Service annotations                                                                                   | {}                                             |
| `service.type`                       | Service type                                                                                          | `ClusterIP`                                    |
| `service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                          |
| `service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                                          |
| `service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                                          |
| `service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                                      |
| `service.port`                       | Service port                                                                                          | `80`                                           |
| `service.nodePort`                   | Service node port when service type is LoadBalancer or NodePort                                       | `nil`                                          |
| `ingress.enabled`                    | Enable ingress controller resource                                                                    | `false`                                        |
| `ingress.ingressClassName`           | IngressClass that will be be used to implement the Ingress                                            | `""`                                           |
| `ingress.pathType`                   | Ingress path type                                                                                     | `ImplementationSpecific`                       |
| `ingress.annotations`                | Ingress annotations                                                                                   | `{}`                                           |
| `ingress.hosts[0].host`              | Hostname to your Whoami installation                                                                  | `whoami.local`                                 |
| `ingress.hosts[0].paths`             | Paths within the url structure                                                                        | `[]`                                           |
| `ingress.tls[0].secretName`          | TLS Secret (certificates)                                                                             | `nil`                                          |
| `ingress.tls[0].hosts[0]`            | TLS hosts                                                                                             | `nil`                                          |
| `resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                           |
| `nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                           |
| `tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                           |
| `affinity`                           | Map of node/pod affinities                                                                            | `{}`                                           |
| `extraArgs`                          | Additional container arguments                                                                        | `{}`                                           |
| `extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                           |
| `extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                          |
| `extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                          |

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set replicaCount=3 cowboysysop/whoami
```

The above command sets the `replicaCount` to `3`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/whoami
```

**Tip**: You can use the default [values.yaml](values.yaml).
