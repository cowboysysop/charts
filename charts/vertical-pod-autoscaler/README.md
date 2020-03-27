# Vertical Pod Autoscaler

[Vertical Pod Autoscaler](https://github.com/kubernetes/autoscaler) is a set of components that automatically adjust the amount of CPU and memory requested by pods running in the Kubernetes Cluster.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install cowboysysop/vertical-pod-autoscaler
```

## Introduction

This chart bootstraps a Vertical Pod Autoscaler deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Metrics Server 0.2+ (you can use the [stable/metrics-server](https://hub.helm.sh/charts/stable/metrics-server) chart)
- Helm 2.11+

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install --name my-release cowboysysop/vertical-pod-autoscaler
```

These commands deploy Vertical Pod Autoscaler on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Replace the custom resource definitions created by the chart using:

```bash
kubectl replace -f crds/verticalpodautoscaler.yaml
kubectl replace -f crds/verticalpodautoscalercheckpoint.yaml
```

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/vertical-pod-autoscaler
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

## Uninstalling

Delete the `vpa-webhook-config` mutating webhook configuration automatically created by Vertical Pod Autoscaler admission controller component using:

```bash
$ kubectl delete mutatingwebhookconfiguration vpa-webhook-config
```

Uninstall the `my-release` deployment using:

```bash
$ helm delete my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

Optionally, delete the custom resource definitions created by the chart using:

```bash
$ kubectl delete crd verticalpodautoscalers.autoscaling.k8s.io
$ kubectl delete crd verticalpodautoscalercheckpoints.autoscaling.k8s.io
```

## Configuration

The following table lists all the configurable parameters expose by the Vertical Pod Autoscaler chart and their default values.

| Name                                             | Description                                                                                                  | Default                                                                             |
|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| `imagePullSecrets`                               | Docker registry secret names as an array                                                                     | `[]`                                                                                |
| `nameOverride`                                   | Partially override `vertical-pod-autoscaler.fullname` template with a string (will prepend the release name) | `nil`                                                                               |
| `fullnameOverride`                               | Fully override `vertical-pod-autoscaler.fullname` template with a string                                     | `nil`                                                                               |
| `admissionController.replicaCount`               | Number of replicas (admission controller component)                                                          | `1`                                                                                 |
| `admissionController.image.repository`           | Vertical Pod Autoscaler image name (admission controller component)                                          | `k8s.gcr.io/vpa-admission-controller`                                               |
| `admissionController.image.tag`                  | Vertical Pod Autoscaler image tag (admission controller component)                                           | `0.7.0`                                                                             |
| `admissionController.image.pullPolicy`           | Image pull policy (admission controller component)                                                           | `IfNotPresent`                                                                      |
| `admissionController.serviceAccount.create`      | Specify whether to create a ServiceAccount (admission controller component)                                  | `true`                                                                              |
| `admissionController.serviceAccount.annotations` | ServiceAccount annotations (admission controller component)                                                  | `{}`                                                                                |
| `admissionController.serviceAccount.name`        | The name of the ServiceAccount to create (admission controller component)                                    | Generated using the `vertical-pod-autoscaler.admissionController.fullname` template |
| `admissionController.podAnnotations`             | Additional pod annotations (admission controller component)                                                  | `{}`                                                                                |
| `admissionController.podLabels`                  | Additional pod labels (admission controller component)                                                       | `{}`                                                                                |
| `admissionController.podSecurityContext`         | Pod security context (admission controller component)                                                        | `{}`                                                                                |
| `admissionController.securityContext`            | Container security context (admission controller component)                                                  | `{}`                                                                                |
| `admissionController.service.type`               | Kubernetes Service type (admission controller component)                                                     | `ClusterIP`                                                                         |
| `admissionController.resources`                  | CPU/Memory resource requests/limits (admission controller component)                                         | `{}`                                                                                |
| `admissionController.nodeSelector`               | Node labels for pod assignment (admission controller component)                                              | `{}`                                                                                |
| `admissionController.tolerations`                | Tolerations for pod assignment (admission controller component)                                              | `[]`                                                                                |
| `admissionController.affinity`                   | Map of node/pod affinities (admission controller component)                                                  | `{}`                                                                                |
| `admissionController.extraArgs`                  | Additional container arguments (admission controller component)                                              | `{ v: 2 }`                                                                          |
| `admissionController.metrics.service.type`       | Metrics Kubernetes Service type (admission controller component)                                             | `ClusterIP`                                                                         |
| `admissionController.metrics.service.port`       | Metrics service port (admission controller component)                                                        | `8944`                                                                              |
| `admissionController.tls.caCert`                 | TLS CA certificate (admission controller component)                                                          | Generated using the `genCA` function                                                |
| `admissionController.tls.cert`                   | TLS certificate (admission controller component)                                                             | Generated using the `genSignedCert` function                                        |
| `admissionController.tls.key`                    | TLS private key (admission controller component)                                                             | Generated using the `genSignedCert` function                                        |
| `admissionController.tls.existingSecret`         | Name of existing TLS Secret to use (admission controller component)                                          | `nil`                                                                               |
| `recommender.replicaCount`                       | Number of replicas (recommender component)                                                                   | `1`                                                                                 |
| `recommender.image.repository`                   | Vertical Pod Autoscaler image name (recommender component)                                                   | `k8s.gcr.io/vpa-recommender`                                                        |
| `recommender.image.tag`                          | Vertical Pod Autoscaler image tag (recommender component)                                                    | `0.7.0`                                                                             |
| `recommender.image.pullPolicy`                   | Image pull policy (recommender component)                                                                    | `IfNotPresent`                                                                      |
| `recommender.serviceAccount.create`              | Specify whether to create a ServiceAccount (recommender component)                                           | `true`                                                                              |
| `recommender.serviceAccount.annotations`         | ServiceAccount annotations (recommender component)                                                           | `{}`                                                                                |
| `recommender.serviceAccount.name`                | The name of the ServiceAccount to create (recommender component)                                             | Generated using the `vertical-pod-autoscaler.recommender.fullname` template         |
| `recommender.podAnnotations`                     | Additional pod annotations (recommender component)                                                           | `{}`                                                                                |
| `recommender.podLabels`                          | Additional pod labels (recommender component)                                                                | `{}`                                                                                |
| `recommender.podSecurityContext`                 | Pod security context (recommender component)                                                                 | `{}`                                                                                |
| `recommender.securityContext`                    | Container security context (recommender component)                                                           | `{}`                                                                                |
| `recommender.resources`                          | CPU/Memory resource requests/limits (recommender component)                                                  | `{}`                                                                                |
| `recommender.nodeSelector`                       | Node labels for pod assignment (recommender component)                                                       | `{}`                                                                                |
| `recommender.tolerations`                        | Tolerations for pod assignment (recommender component)                                                       | `[]`                                                                                |
| `recommender.affinity`                           | Map of node/pod affinities (recommender component)                                                           | `{}`                                                                                |
| `recommender.extraArgs`                          | Additional container arguments (recommender component)                                                       | `{ v: 2 }`                                                                          |
| `recommender.metrics.service.type`               | Metrics Kubernetes Service type (recommender component)                                                      | `ClusterIP`                                                                         |
| `recommender.metrics.service.port`               | Metrics service port (recommender component)                                                                 | `8942`                                                                              |
| `updater.replicaCount`                           | Number of replicas (updater component)                                                                       | `1`                                                                                 |
| `updater.image.repository`                       | Vertical Pod Autoscaler image name (updater component)                                                       | `k8s.gcr.io/vpa-updater`                                                            |
| `updater.image.tag`                              | Vertical Pod Autoscaler image tag (updater component)                                                        | `0.7.0`                                                                             |
| `updater.image.pullPolicy`                       | Image pull policy (updater component)                                                                        | `IfNotPresent`                                                                      |
| `updater.serviceAccount.create`                  | Specify whether to create a ServiceAccount (updater component)                                               | `true`                                                                              |
| `updater.serviceAccount.annotations`             | ServiceAccount annotations (updater component)                                                               | `{}`                                                                                |
| `updater.serviceAccount.name`                    | The name of the ServiceAccount to create (updater component)                                                 | Generated using the `vertical-pod-autoscaler.updater.fullname` template             |
| `updater.podAnnotations`                         | Additional pod annotations (updater component)                                                               | `{}`                                                                                |
| `updater.podLabels`                              | Additional pod labels (updater component)                                                                    | `{}`                                                                                |
| `updater.podSecurityContext`                     | Pod security context (updater component)                                                                     | `{}`                                                                                |
| `updater.securityContext`                        | Container security context (updater component)                                                               | `{}`                                                                                |
| `updater.resources`                              | CPU/Memory resource requests/limits (updater component)                                                      | `{}`                                                                                |
| `updater.nodeSelector`                           | Node labels for pod assignment (updater component)                                                           | `{}`                                                                                |
| `updater.tolerations`                            | Tolerations for pod assignment (updater component)                                                           | `[]`                                                                                |
| `updater.affinity`                               | Map of node/pod affinities (updater component)                                                               | `{}`                                                                                |
| `updater.extraArgs`                              | Additional container arguments (updater component)                                                           | `{ v: 2 }`                                                                          |
| `updater.metrics.service.type`                   | Metrics Kubernetes Service type (updater component)                                                          | `ClusterIP`                                                                         |
| `updater.metrics.service.port`                   | Metrics service port (updater component)                                                                     | `8943`                                                                              |

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install --name my-release \
    --set nameOverride=my-name cowboysysop/vertical-pod-autoscaler
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release \
    --values values.yaml cowboysysop/vertical-pod-autoscaler
```

**Tip**: You can use the default [values.yaml](values.yaml).

## Limitations

Due to hard-coded values in Vertical Pod Autoscaler, the chart configuration has some limitations:

- Admission controller component service name is `vpa-webhook`
- Admission controller component service port is `443`
- Mutating webhook configuration name automatically created by admission controller component is `vpa-webhook-config`
