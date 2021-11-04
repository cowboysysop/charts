# Notebook Controller

[Notebook Controller](https://github.com/kubeflow/kubeflow/tree/master/components/notebook-controller) is a Kubernetes controller that spawns a notebook for a user.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/notebook-controller
```

## Introduction

This chart bootstraps a Notebook Controller deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.1+

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/notebook-controller
```

These commands deploy Notebook Controller on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Replace the custom resource definitions created by the chart using:

```bash
kubectl replace -f crds/notebook.yaml
```

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/notebook-controller
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

```bash
$ kubectl delete crd notebooks.kubeflow.org
```

## Configuration

The following tables lists all the configurable parameters expose by the chart and their default values.

### Common parameters

| Name                | Description                                                                                              | Default |
|---------------------|----------------------------------------------------------------------------------------------------------|---------|
| `kubeVersion`       | Override Kubernetes version                                                                              | `""`    |
| `imagePullSecrets`  | Docker registry secret names as an array                                                                 | `[]`    |
| `nameOverride`      | Partially override `notebook-controller.fullname` template with a string (will prepend the release name) | `nil`   |
| `fullnameOverride`  | Fully override `notebook-controller.fullname` template with a string                                     | `nil`   |
| `commonAnnotations` | Annotations to add to all deployed objects                                                               | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                                    | `{}`    |

### Parameters

| Name                                 | Description                                                                                           | Default                                                     |
|--------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| `replicaCount`                       | Number of replicas                                                                                    | `1`                                                         |
| `image.repository`                   | Image name                                                                                            | `public.ecr.aws/j1r0q0g6/notebooks/notebook-controller`     |
| `image.tag`                          | Image tag                                                                                             | `v1.4`                                                      |
| `image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                              |
| `pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                                     |
| `pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                         |
| `pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                       |
| `serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                                      |
| `serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                                        |
| `serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `notebook-controller.fullname` template |
| `podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                                        |
| `podLabels`                          | Additional pod labels                                                                                 | `{}`                                                        |
| `podSecurityContext`                 | Pod security context                                                                                  | `{}`                                                        |
| `priorityClassName`                  | Priority class name                                                                                   | `nil`                                                       |
| `securityContext`                    | Container security context                                                                            | `{}`                                                        |
| `livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                                      |
| `livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                                         |
| `livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                                        |
| `livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                                         |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                         |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                         |
| `readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                                      |
| `readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                                         |
| `readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                                        |
| `readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                                         |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                         |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                         |
| `resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                                        |
| `nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                                        |
| `tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                                        |
| `affinity`                           | Map of node/pod affinities                                                                            | `{}`                                                        |
| `extraArgs`                          | Additional container arguments                                                                        | `{}`                                                        |
| `extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                                        |
| `extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                       |
| `extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                                       |
| `metrics.service.annotations`        | Metrics service annotations                                                                           | {}                                                          |
| `metrics.service.type`               | Metrics service type                                                                                  | `ClusterIP`                                                 |
| `metrics.service.clusterIP`          | Metrics static cluster IP address or None for headless service when service type is ClusterIP         | `nil`                                                       |
| `metrics.service.port`               | Metrics service port                                                                                  | `8081`                                                      |
| `kubeflow.enabled`                   | Enable integration with Kubeflow                                                                      | `false`                                                     |
| `kubeflow.gatewayName`               | Istio gateway name                                                                                    | `kubeflow`                                                  |

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/notebook-controller
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/notebook-controller
```

**Tip**: You can use the default [values.yaml](values.yaml).
