# Katib

[Katib](https://github.com/kubeflow/katib) is a Kubernetes-native project for automated machine learning.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/katib
```

## Introduction

This chart bootstraps a Katib deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.16+
- cert-manager 1.3+ (you can use the [cert-manager/cert-manager](https://artifacthub.io/packages/helm/cert-manager/cert-manager) chart)
- Helm 3.1+

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/katib
```

These commands deploy Katib on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Replace the custom resource definitions created by the chart using:

```bash
kubectl replace -f crds/experiment.yaml
kubectl replace -f crds/suggestion.yaml
kubectl replace -f crds/trial.yaml
```

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/katib
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

## Uninstalling

Uninstall the `my-release` deployment using:

```bash
$ helm uninstall my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

Optionally, delete the custom resource definitions created by the chart using:

**WARNING**: It will also try to delete all instances of the custom resource definitions.

```bash
$ kubectl delete crd experiments.kubeflow.org
$ kubectl delete crd suggestions.kubeflow.org
$ kubectl delete crd trials.kubeflow.org
```

## Configuration

The following tables lists all the configurable parameters expose by the chart and their default values.

### Common parameters

| Name                   | Description                                                                                | Default    |
|------------------------|--------------------------------------------------------------------------------------------|------------|
| `kubeVersion`          | Override Kubernetes version                                                                | `""`       |
| `imagePullSecrets`     | Docker registry secret names as an array                                                   | `[]`       |
| `nameOverride`         | Partially override `katib.fullname` template with a string (will prepend the release name) | `nil`      |
| `fullnameOverride`     | Fully override `katib.fullname` template with a string                                     | `nil`      |
| `commonAnnotations`    | Annotations to add to all deployed objects                                                 | `{}`       |
| `commonLabels`         | Labels to add to all deployed objects                                                      | `{}`       |
| `kubeflow.enabled`     | Enable integration with Kubeflow                                                           | `false`    |
| `kubeflow.gatewayName` | Istio gateway name                                                                         | `kubeflow` |

### Controller parameters

| Name                                            | Description                                                                                           | Default                                                  |
|-------------------------------------------------|-------------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| `controller.replicaCount`                       | Number of replicas                                                                                    | `1`                                                      |
| `controller.image.repository`                   | Image name                                                                                            | `kubeflowkatib/katib-controller`                         |
| `controller.image.tag`                          | Image tag                                                                                             | `v0.12.0`                                                |
| `controller.image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                           |
| `controller.pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                                  |
| `controller.pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                      |
| `controller.pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                    |
| `controller.serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                                   |
| `controller.serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                                     |
| `controller.serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `katib.controller.fullname` template |
| `controller.podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                                     |
| `controller.podLabels`                          | Additional pod labels                                                                                 | `{}`                                                     |
| `controller.podSecurityContext`                 | Pod security context                                                                                  | `{}`                                                     |
| `controller.priorityClassName`                  | Priority class name                                                                                   | `nil`                                                    |
| `controller.securityContext`                    | Container security context                                                                            | `{}`                                                     |
| `controller.livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                                   |
| `controller.livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                                      |
| `controller.livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                                     |
| `controller.livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                                      |
| `controller.livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                      |
| `controller.livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                      |
| `controller.readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                                   |
| `controller.readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                                      |
| `controller.readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                                     |
| `controller.readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                                      |
| `controller.readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                      |
| `controller.readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                      |
| `controller.service.annotations`                | Service annotations                                                                                   | {}                                                       |
| `controller.service.type`                       | Service type                                                                                          | `ClusterIP`                                              |
| `controller.service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                                    |
| `controller.service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                                                    |
| `controller.service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                                                    |
| `controller.service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                                                |
| `controller.service.port`                       | Service port                                                                                          | `8443`                                                   |
| `controller.service.nodePort`                   | Service node port when service type is LoadBalancer or NodePort                                       | `nil`                                                    |
| `controller.resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                                     |
| `controller.nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                                     |
| `controller.tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                                     |
| `controller.affinity`                           | Map of node/pod affinities                                                                            | `{}`                                                     |
| `controller.extraArgs`                          | Additional container arguments                                                                        | `{}`                                                     |
| `controller.extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                                     |
| `controller.extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                    |
| `controller.extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                                    |
| `controller.metrics.service.annotations`        | Metrics service annotations                                                                           | {}                                                       |
| `controller.metrics.service.type`               | Metrics service type                                                                                  | `ClusterIP`                                              |
| `controller.metrics.service.clusterIP`          | Metrics static cluster IP address or None for headless service when service type is ClusterIP         | `nil`                                                    |
| `controller.metrics.service.port`               | Metrics service port                                                                                  | `8080`                                                   |

### DB manager parameters

| Name                                           | Description                                                                                           | Default                                                 |
|------------------------------------------------|-------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| `dbManager.replicaCount`                       | Number of replicas                                                                                    | `1`                                                     |
| `dbManager.image.repository`                   | Image name                                                                                            | `kubeflowkatib/katib-db-manager`                        |
| `dbManager.image.tag`                          | Image tag                                                                                             | `v0.12.0`                                               |
| `dbManager.image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                          |
| `dbManager.pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                                 |
| `dbManager.pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                     |
| `dbManager.pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                   |
| `dbManager.serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                                  |
| `dbManager.serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                                    |
| `dbManager.serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `katib.dbManager.fullname` template |
| `dbManager.podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                                    |
| `dbManager.podLabels`                          | Additional pod labels                                                                                 | `{}`                                                    |
| `dbManager.podSecurityContext`                 | Pod security context                                                                                  | `{}`                                                    |
| `dbManager.priorityClassName`                  | Priority class name                                                                                   | `nil`                                                   |
| `dbManager.securityContext`                    | Container security context                                                                            | `{}`                                                    |
| `dbManager.livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                                  |
| `dbManager.livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                                     |
| `dbManager.livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                                    |
| `dbManager.livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                                     |
| `dbManager.livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                     |
| `dbManager.livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                     |
| `dbManager.readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                                  |
| `dbManager.readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                                     |
| `dbManager.readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                                    |
| `dbManager.readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                                     |
| `dbManager.readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                     |
| `dbManager.readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                     |
| `dbManager.service.annotations`                | Service annotations                                                                                   | {}                                                      |
| `dbManager.service.type`                       | Service type                                                                                          | `ClusterIP`                                             |
| `dbManager.service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                                   |
| `dbManager.service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                                                   |
| `dbManager.service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                                                   |
| `dbManager.service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                                               |
| `dbManager.service.port`                       | Service port                                                                                          | `6789`                                                  |
| `dbManager.service.nodePort`                   | Service node port when service type is LoadBalancer or NodePort                                       | `nil`                                                   |
| `dbManager.resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                                    |
| `dbManager.nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                                    |
| `dbManager.tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                                    |
| `dbManager.affinity`                           | Map of node/pod affinities                                                                            | `{}`                                                    |
| `dbManager.extraArgs`                          | Additional container arguments                                                                        | `{}`                                                    |
| `dbManager.extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                                    |
| `dbManager.extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                   |
| `dbManager.extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                                   |

### UI parameters

| Name                                    | Description                                                                                           | Default                                          |
|-----------------------------------------|-------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| `ui.replicaCount`                       | Number of replicas                                                                                    | `1`                                              |
| `ui.image.repository`                   | Image name                                                                                            | `kubeflowkatib/katib-ui`                         |
| `ui.image.tag`                          | Image tag                                                                                             | `v0.12.0`                                        |
| `ui.image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                   |
| `ui.pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                          |
| `ui.pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                              |
| `ui.pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                            |
| `ui.serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                           |
| `ui.serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                             |
| `ui.serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `katib.ui.fullname` template |
| `ui.podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                             |
| `ui.podLabels`                          | Additional pod labels                                                                                 | `{}`                                             |
| `ui.podSecurityContext`                 | Pod security context                                                                                  | `{}`                                             |
| `ui.priorityClassName`                  | Priority class name                                                                                   | `nil`                                            |
| `ui.securityContext`                    | Container security context                                                                            | `{}`                                             |
| `ui.livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                           |
| `ui.livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                              |
| `ui.livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                             |
| `ui.livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                              |
| `ui.livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                              |
| `ui.livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                              |
| `ui.readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                           |
| `ui.readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                              |
| `ui.readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                             |
| `ui.readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                              |
| `ui.readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                              |
| `ui.readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                              |
| `ui.service.annotations`                | Service annotations                                                                                   | {}                                               |
| `ui.service.type`                       | Service type                                                                                          | `ClusterIP`                                      |
| `ui.service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                            |
| `ui.service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                                            |
| `ui.service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                                            |
| `ui.service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                                        |
| `ui.service.port`                       | Service port                                                                                          | `8080`                                           |
| `ui.service.nodePort`                   | Service node port when service type is LoadBalancer or NodePort                                       | `nil`                                            |
| `ui.ingress.enabled`                    | Enable ingress controller resource                                                                    | `false`                                          |
| `ui.ingress.ingressClassName`           | IngressClass that will be be used to implement the Ingress                                            | `""`                                             |
| `ui.ingress.pathType`                   | Ingress path type                                                                                     | `ImplementationSpecific`                         |
| `ui.ingress.annotations`                | Ingress annotations                                                                                   | `{}`                                             |
| `ui.ingress.hosts[0].host`              | Hostname to your Katib installation                                                                   | `katib.local`                                    |
| `ui.ingress.hosts[0].paths`             | Paths within the url structure                                                                        | `[/katib/]`                                      |
| `ui.ingress.tls[0].secretName`          | TLS Secret (certificates)                                                                             | `nil`                                            |
| `ui.ingress.tls[0].hosts[0]`            | TLS hosts                                                                                             | `nil`                                            |
| `ui.resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                             |
| `ui.nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                             |
| `ui.tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                             |
| `ui.affinity`                           | Map of node/pod affinities                                                                            | `{}`                                             |
| `ui.extraArgs`                          | Additional container arguments                                                                        | `{}`                                             |
| `ui.extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                             |
| `ui.extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                            |
| `ui.extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                            |

### MariaDB parameters

| Name                               | Description                                           | Default                                |
|------------------------------------|-------------------------------------------------------|----------------------------------------|
| `mariadb.enabled`                  | Whether to use the MariaDB chart                      | `true`                                 |
| `mariadb.architecture`             | MariaDB architecture                                  | `standalone`                           |
| `mariadb.auth.database`            | MariaDB database                                      | `katib`                                |
| `mariadb.auth.username`            | MariaDB user                                          | `katib`                                |
| `mariadb.auth.password`            | MariaDB password                                      | `katib`                                |
| `mariadb.auth.existingSecret`      | Name of existing Secret to use                        | `nil`                                  |
| `mariadb.primary.podAnnotations`   | Additional pod annotations for MariaDB primary pods   | `{ sidecar.istio.io/inject: "false" }` |
| `mariadb.primary.service.port`     | MariaDB port                                          | `3306`                                 |
| `mariadb.secondary.podAnnotations` | Additional pod annotations for MariaDB secondary pods | `{ sidecar.istio.io/inject: "false" }` |
| `externalMariadb.enabled`          | Whether to use an external MariaDB                    | `false`                                |
| `externalMariadb.host`             | External MariaDB host                                 | `mariadb`                              |
| `externalMariadb.port`             | External MariaDB port                                 | `3306`                                 |
| `externalMariadb.username`         | External MariaDB user                                 | `katib`                                |
| `externalMariadb.password`         | External MariaDB password                             | `katib`                                |
| `externalMariadb.existingSecret`   | Name of existing Secret to use                        | `nil`                                  |
| `externalMariadb.database`         | External MariaDB database                             | `katib`                                |

### Tests parameters

| Name                     | Description       | Default                      |
|--------------------------|-------------------|------------------------------|
| `tests.image.repository` | Image name        | `ghcr.io/cowboysysop/pytest` |
| `tests.image.tag`        | Image tag         | `1.0.0`                      |
| `tests.image.pullPolicy` | Image pull policy | `IfNotPresent`               |

### Setting parameters

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/katib
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/katib
```

**TIP**: You can use the default [values.yaml](values.yaml).
