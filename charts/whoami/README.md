# Whoami

[Whoami](https://github.com/traefik/whoami) is a tiny Go webserver that prints os information and HTTP request to output.

**DISCLAIMER**: This is an unofficial chart not supported by Whoami authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/whoami
```

## Introduction

This chart bootstraps a Whoami deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes >= 1.24
- Helm >= 3.9

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

### Upgrading to version 5.0.0

The chart is now tested with Kubernetes >= 1.24 and Helm >= 3.9.

Future upgrades may introduce undetected breaking changes if you continue to use older versions.

### Upgrading to version 4.0.0

Some parameters related to port management have been modified:

- Parameter `service.port` has been renamed `service.ports.http`.
- Parameter `service.nodePort` has been renamed `service.nodePorts.http`.

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

### Global parameters

| Name                      | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Common parameters

| Name                | Description                                                                                 | Default |
| ------------------- | ------------------------------------------------------------------------------------------- | ------- |
| `kubeVersion`       | Override Kubernetes version                                                                 | `""`    |
| `nameOverride`      | Partially override `whoami.fullname` template with a string (will prepend the release name) | `""`    |
| `fullnameOverride`  | Fully override `whoami.fullname` template with a string                                     | `""`    |
| `commonAnnotations` | Annotations to add to all deployed objects                                                  | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                       | `{}`    |
| `extraDeploy`       | Array of extra objects to deploy with the release                                           | `[]`    |

### Parameters

| Name                                 | Description                                                                                           | Default                  |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------- | ------------------------ |
| `replicaCount`                       | Number of replicas                                                                                    | `1`                      |
| `image.registry`                     | Image registry                                                                                        | `docker.io`              |
| `image.repository`                   | Image repository                                                                                      | `traefik/whoami`         |
| `image.tag`                          | Image tag                                                                                             | `v1.10.3`                |
| `image.digest`                       | Image digest                                                                                          | `""`                     |
| `image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`           |
| `pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                  |
| `pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                      |
| `pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                    |
| `serviceAccount.create`              | Specifies whether a service account should be created                                                 | `true`                   |
| `serviceAccount.annotations`         | Service account annotations                                                                           | `{}`                     |
| `serviceAccount.name`                | The name of the service account to use (Generated using the `whoami.fullname` template if not set)    | `nil`                    |
| `hostAliases`                        | Pod host aliases                                                                                      | `[]`                     |
| `deploymentAnnotations`              | Additional deployment annotations                                                                     | `{}`                     |
| `podAnnotations`                     | Additional pod annotations                                                                            | `{}`                     |
| `podLabels`                          | Additional pod labels                                                                                 | `{}`                     |
| `podSecurityContext`                 | Pod security context                                                                                  | `{}`                     |
| `priorityClassName`                  | Priority class name                                                                                   | `nil`                    |
| `runtimeClassName`                   | Runtime class name                                                                                    | `""`                     |
| `topologySpreadConstraints`          | Topology Spread Constraints for pod assignment                                                        | `[]`                     |
| `securityContext`                    | Container security context                                                                            | `{}`                     |
| `containerPorts.http`                | Container port for HTTP                                                                               | `80`                     |
| `livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                   |
| `livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                      |
| `livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                     |
| `livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                      |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                      |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                      |
| `readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                   |
| `readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                      |
| `readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                     |
| `readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                      |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                      |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                      |
| `startupProbe.enabled`               | Enable startup probe                                                                                  | `false`                  |
| `startupProbe.initialDelaySeconds`   | Delay before the startup probe is initiated                                                           | `0`                      |
| `startupProbe.periodSeconds`         | How often to perform the startup probe                                                                | `10`                     |
| `startupProbe.timeoutSeconds`        | When the startup probe times out                                                                      | `1`                      |
| `startupProbe.failureThreshold`      | Minimum consecutive failures for the startup probe to be considered failed after having succeeded     | `3`                      |
| `startupProbe.successThreshold`      | Minimum consecutive successes for the startup probe to be considered successful after having failed   | `1`                      |
| `service.annotations`                | Service annotations                                                                                   | `{}`                     |
| `service.type`                       | Service type                                                                                          | `ClusterIP`              |
| `service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                    |
| `service.ipFamilyPolicy`             | Service IP family policy                                                                              | `""`                     |
| `service.ipFamilies`                 | Service IP families                                                                                   | `[]`                     |
| `service.sessionAffinity`            | Control where client requests go, to the same pod or round-robin                                      | `None`                   |
| `service.sessionAffinityConfig`      | Additional settings for the sessionAffinity                                                           | `{}`                     |
| `service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                    |
| `service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                    |
| `service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                |
| `service.ports.http`                 | Service port for HTTP                                                                                 | `80`                     |
| `service.nodePorts.http`             | Service node port for HTTP when service type is LoadBalancer or NodePort                              | `nil`                    |
| `ingress.enabled`                    | Enable ingress controller resource                                                                    | `false`                  |
| `ingress.ingressClassName`           | IngressClass that will be be used to implement the Ingress                                            | `""`                     |
| `ingress.pathType`                   | Ingress path type                                                                                     | `ImplementationSpecific` |
| `ingress.annotations`                | Ingress annotations                                                                                   | `{}`                     |
| `ingress.hosts[0].host`              | Hostname to your Whoami installation                                                                  | `whoami.local`           |
| `ingress.hosts[0].paths`             | Paths within the url structure                                                                        | `["/"]`                  |
| `ingress.tls`                        | TLS configuration                                                                                     | `[]`                     |
| `resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                     |
| `nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                     |
| `tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                     |
| `affinity`                           | Map of node/pod affinities                                                                            | `{}`                     |
| `extraArgs`                          | Additional container arguments                                                                        | `{}`                     |
| `extraEnvVars`                       | Additional container environment variables                                                            | `[]`                     |
| `extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                    |
| `extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                    |
| `extraVolumes`                       | Optionally specify extra list of additional volumes                                                   | `[]`                     |
| `extraVolumeMounts`                  | Optionally specify extra list of additional volumeMounts                                              | `[]`                     |

### Tests parameters

| Name                     | Description       | Default              |
| ------------------------ | ----------------- | -------------------- |
| `tests.image.registry`   | Image registry    | `ghcr.io`            |
| `tests.image.repository` | Image repository  | `cowboysysop/pytest` |
| `tests.image.tag`        | Image tag         | `1.0.41`             |
| `tests.image.digest`     | Image digest      | `""`                 |
| `tests.image.pullPolicy` | Image pull policy | `IfNotPresent`       |

## Setting parameters

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/whoami
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/whoami
```

**TIP**: You can use the default [values.yaml](values.yaml).

## License

The source code of this chart is under [MIT License](LICENSE).

It also uses source code under Apache 2.0 License from the [Bitnami repository](https://github.com/bitnami/charts).
