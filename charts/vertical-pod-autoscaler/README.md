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

The following tables lists all the configurable parameters expose by the Vertical Pod Autoscaler chart and their default values.

### Common parameters

| Name               | Description                                                                                                  | Default |
|--------------------|--------------------------------------------------------------------------------------------------------------|---------|
| `imagePullSecrets` | Docker registry secret names as an array                                                                     | `[]`    |
| `nameOverride`     | Partially override `vertical-pod-autoscaler.fullname` template with a string (will prepend the release name) | `nil`   |
| `fullnameOverride` | Fully override `vertical-pod-autoscaler.fullname` template with a string                                     | `nil`   |

### Admission controller parameters

| Name                                             | Description                                | Default                                                                             |
|--------------------------------------------------|--------------------------------------------|-------------------------------------------------------------------------------------|
| `admissionController.replicaCount`               | Number of replicas                         | `1`                                                                                 |
| `admissionController.image.repository`           | Image name                                 | `us.gcr.io/k8s-artifacts-prod/autoscaling/vpa-admission-controller`                 |
| `admissionController.image.tag`                  | Image tag                                  | `0.8.0`                                                                             |
| `admissionController.image.pullPolicy`           | Image pull policy                          | `IfNotPresent`                                                                      |
| `admissionController.serviceAccount.create`      | Specify whether to create a ServiceAccount | `true`                                                                              |
| `admissionController.serviceAccount.annotations` | ServiceAccount annotations                 | `{}`                                                                                |
| `admissionController.serviceAccount.name`        | The name of the ServiceAccount to create   | Generated using the `vertical-pod-autoscaler.admissionController.fullname` template |
| `admissionController.podAnnotations`             | Additional pod annotations                 | `{}`                                                                                |
| `admissionController.podLabels`                  | Additional pod labels                      | `{}`                                                                                |
| `admissionController.podSecurityContext`         | Pod security context                       | `{}`                                                                                |
| `admissionController.securityContext`            | Container security context                 | `{}`                                                                                |
| `admissionController.service.type`               | Kubernetes Service type                    | `ClusterIP`                                                                         |
| `admissionController.resources`                  | CPU/Memory resource requests/limits        | `{}`                                                                                |
| `admissionController.nodeSelector`               | Node labels for pod assignment             | `{}`                                                                                |
| `admissionController.tolerations`                | Tolerations for pod assignment             | `[]`                                                                                |
| `admissionController.affinity`                   | Map of node/pod affinities                 | `{}`                                                                                |
| `admissionController.extraArgs`                  | Additional container arguments             | `{ v: 2 }`                                                                          |
| `admissionController.metrics.service.type`       | Metrics Kubernetes Service type            | `ClusterIP`                                                                         |
| `admissionController.metrics.service.port`       | Metrics service port                       | `8944`                                                                              |
| `admissionController.tls.caCert`                 | TLS CA certificate                         | Generated using the `genCA` function                                                |
| `admissionController.tls.cert`                   | TLS certificate                            | Generated using the `genSignedCert` function                                        |
| `admissionController.tls.key`                    | TLS private key                            | Generated using the `genSignedCert` function                                        |
| `admissionController.tls.existingSecret`         | Name of existing TLS Secret to use         | `nil`                                                                               |

### Recommender parameters

| Name                                     | Description                                | Default                                                                     |
|------------------------------------------|--------------------------------------------|-----------------------------------------------------------------------------|
| `recommender.replicaCount`               | Number of replicas                         | `1`                                                                         |
| `recommender.image.repository`           | Image name                                 | `us.gcr.io/k8s-artifacts-prod/autoscaling/vpa-recommender`                  |
| `recommender.image.tag`                  | Image tag                                  | `0.8.0`                                                                     |
| `recommender.image.pullPolicy`           | Image pull policy                          | `IfNotPresent`                                                              |
| `recommender.serviceAccount.create`      | Specify whether to create a ServiceAccount | `true`                                                                      |
| `recommender.serviceAccount.annotations` | ServiceAccount annotations                 | `{}`                                                                        |
| `recommender.serviceAccount.name`        | The name of the ServiceAccount to create   | Generated using the `vertical-pod-autoscaler.recommender.fullname` template |
| `recommender.podAnnotations`             | Additional pod annotations                 | `{}`                                                                        |
| `recommender.podLabels`                  | Additional pod labels                      | `{}`                                                                        |
| `recommender.podSecurityContext`         | Pod security context                       | `{}`                                                                        |
| `recommender.securityContext`            | Container security context                 | `{}`                                                                        |
| `recommender.resources`                  | CPU/Memory resource requests/limits        | `{}`                                                                        |
| `recommender.nodeSelector`               | Node labels for pod assignment             | `{}`                                                                        |
| `recommender.tolerations`                | Tolerations for pod assignment             | `[]`                                                                        |
| `recommender.affinity`                   | Map of node/pod affinities                 | `{}`                                                                        |
| `recommender.extraArgs`                  | Additional container arguments             | `{ v: 2 }`                                                                  |
| `recommender.metrics.service.type`       | Metrics Kubernetes Service type            | `ClusterIP`                                                                 |
| `recommender.metrics.service.port`       | Metrics service port                       | `8942`                                                                      |

### Updater parameters

| Name                                 | Description                                | Default                                                                 |
|--------------------------------------|--------------------------------------------|-------------------------------------------------------------------------|
| `updater.replicaCount`               | Number of replicas                         | `1`                                                                     |
| `updater.image.repository`           | Image name                                 | `us.gcr.io/k8s-artifacts-prod/autoscaling/vpa-updater`                  |
| `updater.image.tag`                  | Image tag                                  | `0.8.0`                                                                 |
| `updater.image.pullPolicy`           | Image pull policy                          | `IfNotPresent`                                                          |
| `updater.serviceAccount.create`      | Specify whether to create a ServiceAccount | `true`                                                                  |
| `updater.serviceAccount.annotations` | ServiceAccount annotations                 | `{}`                                                                    |
| `updater.serviceAccount.name`        | The name of the ServiceAccount to create   | Generated using the `vertical-pod-autoscaler.updater.fullname` template |
| `updater.podAnnotations`             | Additional pod annotations                 | `{}`                                                                    |
| `updater.podLabels`                  | Additional pod labels                      | `{}`                                                                    |
| `updater.podSecurityContext`         | Pod security context                       | `{}`                                                                    |
| `updater.securityContext`            | Container security context                 | `{}`                                                                    |
| `updater.resources`                  | CPU/Memory resource requests/limits        | `{}`                                                                    |
| `updater.nodeSelector`               | Node labels for pod assignment             | `{}`                                                                    |
| `updater.tolerations`                | Tolerations for pod assignment             | `[]`                                                                    |
| `updater.affinity`                   | Map of node/pod affinities                 | `{}`                                                                    |
| `updater.extraArgs`                  | Additional container arguments             | `{ v: 2 }`                                                              |
| `updater.metrics.service.type`       | Metrics Kubernetes Service type            | `ClusterIP`                                                             |
| `updater.metrics.service.port`       | Metrics service port                       | `8943`                                                                  |

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
