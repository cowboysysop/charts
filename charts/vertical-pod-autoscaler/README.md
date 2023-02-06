# Vertical Pod Autoscaler

[Vertical Pod Autoscaler](https://github.com/kubernetes/autoscaler) is a set of components that automatically adjust the amount of CPU and memory requested by pods running in the Kubernetes Cluster.

**DISCLAIMER**: This is an unofficial chart not supported by Vertical Pod Autoscaler authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/vertical-pod-autoscaler
```

## Introduction

This chart bootstraps a Vertical Pod Autoscaler deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes >= 1.22
- Metrics Server >= 0.2 (you can use the [bitnami/metrics-server](https://artifacthub.io/packages/helm/bitnami/metrics-server) chart)
- Helm >= 3.1

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/vertical-pod-autoscaler
```

These commands deploy Vertical Pod Autoscaler on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/vertical-pod-autoscaler
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

### Upgrading to version 6.0.0

The application version is no more compatible with Kubernetes 1.19, 1.20 and 1.21.

### Upgrading to version 5.0.0

The application validates that all fields that specify CPU and memory have supported resolution:

- CPU is a whole number of milli CPUs
- Memory is a whole number of bytes

### Upgrading to version 4.0.0

The application version is no more compatible with Kubernetes 1.16.

Custom resource definitions are now created and upgraded with a pre-install/pre-upgrade job.

### Upgrading to version 3.0.0

The chart is no more compatible with Helm 2.

Refer to the [Helm documentation](https://helm.sh/docs/topics/v2_v3_migration/) for more information.

### Upgrading to version 2.0.0

The port names have been changed to be compatible with Istio service mesh.

## Uninstalling

Delete the `vpa-webhook-config` mutating webhook configuration automatically created by Vertical Pod Autoscaler admission controller component using:

```bash
$ kubectl delete mutatingwebhookconfiguration vpa-webhook-config
```

Uninstall the `my-release` deployment using:

```bash
$ helm uninstall my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

Optionally, delete the custom resource definitions created by the chart using:

**WARNING**: It will also try to delete all instances of the custom resource definitions.

```bash
$ kubectl delete crd verticalpodautoscalers.autoscaling.k8s.io
$ kubectl delete crd verticalpodautoscalercheckpoints.autoscaling.k8s.io
```

## Configuration

The following tables lists all the configurable parameters expose by the chart and their default values.

### Common parameters

| Name                | Description                                                                                                  | Default |
|---------------------|--------------------------------------------------------------------------------------------------------------|---------|
| `kubeVersion`       | Override Kubernetes version                                                                                  | `""`    |
| `imagePullSecrets`  | Docker registry secret names as an array                                                                     | `[]`    |
| `nameOverride`      | Partially override `vertical-pod-autoscaler.fullname` template with a string (will prepend the release name) | `nil`   |
| `fullnameOverride`  | Fully override `vertical-pod-autoscaler.fullname` template with a string                                     | `nil`   |
| `commonAnnotations` | Annotations to add to all deployed objects                                                                   | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                                        | `{}`    |
| `extraDeploy`       | Array of extra objects to deploy with the release                                                            | `[]`    |

### Admission controller parameters

| Name                                                           | Description                                                                                           | Default                                                                             |
|----------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| `admissionController.enabled`                                  | Enable the component                                                                                  | `true`                                                                              |
| `admissionController.replicaCount`                             | Number of replicas                                                                                    | `1`                                                                                 |
| `admissionController.image.repository`                         | Image name                                                                                            | `k8s.gcr.io/autoscaling/vpa-admission-controller`                                   |
| `admissionController.image.tag`                                | Image tag                                                                                             | `0.13.0`                                                                            |
| `admissionController.image.pullPolicy`                         | Image pull policy                                                                                     | `IfNotPresent`                                                                      |
| `admissionController.pdb.create`                               | Specifies whether a pod disruption budget should be created                                           | `false`                                                                             |
| `admissionController.pdb.minAvailable`                         | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                                                 |
| `admissionController.pdb.maxUnavailable`                       | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                                               |
| `admissionController.serviceAccount.create`                    | Specify whether to create a ServiceAccount                                                            | `true`                                                                              |
| `admissionController.serviceAccount.annotations`               | ServiceAccount annotations                                                                            | `{}`                                                                                |
| `admissionController.serviceAccount.name`                      | The name of the ServiceAccount to create                                                              | Generated using the `vertical-pod-autoscaler.admissionController.fullname` template |
| `admissionController.podAnnotations`                           | Additional pod annotations                                                                            | `{}`                                                                                |
| `admissionController.podLabels`                                | Additional pod labels                                                                                 | `{}`                                                                                |
| `admissionController.podSecurityContext`                       | Pod security context                                                                                  | `{ runAsNonRoot: true, runAsUser: 65534 }`                                          |
| `admissionController.priorityClassName`                        | Priority class name                                                                                   | `nil`                                                                               |
| `admissionController.securityContext`                          | Container security context                                                                            | `{}`                                                                                |
| `admissionController.livenessProbe.enabled`                    | Enable liveness probe                                                                                 | `true`                                                                              |
| `admissionController.livenessProbe.initialDelaySeconds`        | Delay before the liveness probe is initiated                                                          | `0`                                                                                 |
| `admissionController.livenessProbe.periodSeconds`              | How often to perform the liveness probe                                                               | `10`                                                                                |
| `admissionController.livenessProbe.timeoutSeconds`             | When the liveness probe times out                                                                     | `1`                                                                                 |
| `admissionController.livenessProbe.failureThreshold`           | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                                                 |
| `admissionController.livenessProbe.successThreshold`           | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                                                 |
| `admissionController.readinessProbe.enabled`                   | Enable readiness probe                                                                                | `true`                                                                              |
| `admissionController.readinessProbe.initialDelaySeconds`       | Delay before the readiness probe is initiated                                                         | `0`                                                                                 |
| `admissionController.readinessProbe.periodSeconds`             | How often to perform the readiness probe                                                              | `10`                                                                                |
| `admissionController.readinessProbe.timeoutSeconds`            | When the readiness probe times out                                                                    | `1`                                                                                 |
| `admissionController.readinessProbe.failureThreshold`          | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                                                 |
| `admissionController.readinessProbe.successThreshold`          | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                                                 |
| `admissionController.service.annotations`                      | Service annotations                                                                                   | `{}`                                                                                |
| `admissionController.service.type`                             | Service type                                                                                          | `ClusterIP`                                                                         |
| `admissionController.service.clusterIP`                        | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                                                               |
| `admissionController.resources`                                | CPU/Memory resource requests/limits                                                                   | `{}`                                                                                |
| `admissionController.nodeSelector`                             | Node labels for pod assignment                                                                        | `{}`                                                                                |
| `admissionController.tolerations`                              | Tolerations for pod assignment                                                                        | `[]`                                                                                |
| `admissionController.affinity`                                 | Map of node/pod affinities                                                                            | `{}`                                                                                |
| `admissionController.extraArgs`                                | Additional container arguments                                                                        | `{ v: 2 }`                                                                          |
| `admissionController.extraEnvVars`                             | Additional container environment variables                                                            | `[]`                                                                                |
| `admissionController.extraEnvVarsCM`                           | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                                               |
| `admissionController.extraEnvVarsSecret`                       | Name of existing Secret containing additional container environment variables                         | `nil`                                                                               |
| `admissionController.metrics.service.annotations`              | Metrics service annotations                                                                           | `{}`                                                                                |
| `admissionController.metrics.service.type`                     | Metrics service type                                                                                  | `ClusterIP`                                                                         |
| `admissionController.metrics.service.clusterIP`                | Metrics static cluster IP address or None for headless service when service type is ClusterIP         | `nil`                                                                               |
| `admissionController.metrics.service.port`                     | Metrics service port                                                                                  | `8944`                                                                              |
| `admissionController.metrics.serviceMonitor.enabled`           | Specifies whether a service monitor should be created                                                 | `false`                                                                             |
| `admissionController.metrics.serviceMonitor.annotations`       | Extra annotations for the ServiceMonitor                                                              | `{}`                                                                                |
| `admissionController.metrics.serviceMonitor.labels`            | Extra labels for the ServiceMonitor                                                                   | `{}`                                                                                |
| `admissionController.metrics.serviceMonitor.jobLabel`          | The name of the label on the target service to use as the job name in Prometheus                      | `""`                                                                                |
| `admissionController.metrics.serviceMonitor.interval`          | How frequently to scrape metrics                                                                      | `""`                                                                                |
| `admissionController.metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                                               | `""`                                                                                |
| `admissionController.metrics.serviceMonitor.metricRelabelings` | Specify additional relabeling of metrics                                                              | `[]`                                                                                |
| `admissionController.metrics.serviceMonitor.relabelings`       | Specify general relabeling                                                                            | `[]`                                                                                |
| `admissionController.tls.caCert`                               | TLS CA certificate                                                                                    | Generated using the `genCA` function                                                |
| `admissionController.tls.cert`                                 | TLS certificate                                                                                       | Generated using the `genSignedCert` function                                        |
| `admissionController.tls.key`                                  | TLS private key                                                                                       | Generated using the `genSignedCert` function                                        |
| `admissionController.tls.existingSecret`                       | Name of existing TLS Secret to use                                                                    | `nil`                                                                               |

### Recommender parameters

| Name                                                           | Description                                                                                           | Default                                                                     |
|----------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| `recommender.replicaCount`                                     | Number of replicas                                                                                    | `1`                                                                         |
| `recommender.image.repository`                                 | Image name                                                                                            | `k8s.gcr.io/autoscaling/vpa-recommender`                                    |
| `recommender.image.tag`                                        | Image tag                                                                                             | `0.13.0`                                                                    |
| `recommender.image.pullPolicy`                                 | Image pull policy                                                                                     | `IfNotPresent`                                                              |
| `recommender.pdb.create`                                       | Specifies whether a pod disruption budget should be created                                           | `false`                                                                     |
| `recommender.pdb.minAvailable`                                 | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                                         |
| `recommender.pdb.maxUnavailable`                               | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                                       |
| `recommender.serviceAccount.create`                            | Specify whether to create a ServiceAccount                                                            | `true`                                                                      |
| `recommender.serviceAccount.annotations`                       | ServiceAccount annotations                                                                            | `{}`                                                                        |
| `recommender.serviceAccount.name`                              | The name of the ServiceAccount to create                                                              | Generated using the `vertical-pod-autoscaler.recommender.fullname` template |
| `recommender.podAnnotations`                                   | Additional pod annotations                                                                            | `{}`                                                                        |
| `recommender.podLabels`                                        | Additional pod labels                                                                                 | `{}`                                                                        |
| `recommender.podSecurityContext`                               | Pod security context                                                                                  | `{ runAsNonRoot: true, runAsUser: 65534 }`                                  |
| `recommender.priorityClassName`                                | Priority class name                                                                                   | `nil`                                                                       |
| `recommender.securityContext`                                  | Container security context                                                                            | `{}`                                                                        |
| `recommender.livenessProbe.enabled`                            | Enable liveness probe                                                                                 | `true`                                                                      |
| `recommender.livenessProbe.initialDelaySeconds`                | Delay before the liveness probe is initiated                                                          | `0`                                                                         |
| `recommender.livenessProbe.periodSeconds`                      | How often to perform the liveness probe                                                               | `10`                                                                        |
| `recommender.livenessProbe.timeoutSeconds`                     | When the liveness probe times out                                                                     | `1`                                                                         |
| `recommender.livenessProbe.failureThreshold`                   | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                                         |
| `recommender.livenessProbe.successThreshold`                   | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                                         |
| `recommender.readinessProbe.enabled`                           | Enable readiness probe                                                                                | `true`                                                                      |
| `recommender.readinessProbe.initialDelaySeconds`               | Delay before the readiness probe is initiated                                                         | `0`                                                                         |
| `recommender.readinessProbe.periodSeconds`                     | How often to perform the readiness probe                                                              | `10`                                                                        |
| `recommender.readinessProbe.timeoutSeconds`                    | When the readiness probe times out                                                                    | `1`                                                                         |
| `recommender.readinessProbe.failureThreshold`                  | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                                         |
| `recommender.readinessProbe.successThreshold`                  | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                                         |
| `recommender.resources`                                        | CPU/Memory resource requests/limits                                                                   | `{}`                                                                        |
| `recommender.nodeSelector`                                     | Node labels for pod assignment                                                                        | `{}`                                                                        |
| `recommender.tolerations`                                      | Tolerations for pod assignment                                                                        | `[]`                                                                        |
| `recommender.affinity`                                         | Map of node/pod affinities                                                                            | `{}`                                                                        |
| `recommender.extraArgs`                                        | Additional container arguments                                                                        | `{ v: 2 }`                                                                  |
| `recommender.extraEnvVars`                                     | Additional container environment variables                                                            | `[]`                                                                        |
| `recommender.extraEnvVarsCM`                                   | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                                       |
| `recommender.extraEnvVarsSecret`                               | Name of existing Secret containing additional container environment variables                         | `nil`                                                                       |
| `recommender.metrics.service.annotations`                      | Metrics service annotations                                                                           | `{}`                                                                        |
| `recommender.metrics.service.type`                             | Metrics service type                                                                                  | `ClusterIP`                                                                 |
| `recommender.metrics.service.clusterIP`                        | Metrics static cluster IP address or None for headless service when service type is ClusterIP         | `nil`                                                                       |
| `recommender.metrics.service.port`                             | Metrics service port                                                                                  | `8942`                                                                      |
| `admissionController.metrics.serviceMonitor.enabled`           | Specifies whether a service monitor should be created                                                 | `false`                                                                     |
| `admissionController.metrics.serviceMonitor.annotations`       | Extra annotations for the ServiceMonitor                                                              | `{}`                                                                        |
| `admissionController.metrics.serviceMonitor.labels`            | Extra labels for the ServiceMonitor                                                                   | `{}`                                                                        |
| `admissionController.metrics.serviceMonitor.jobLabel`          | The name of the label on the target service to use as the job name in Prometheus                      | `""`                                                                        |
| `admissionController.metrics.serviceMonitor.interval`          | How frequently to scrape metrics                                                                      | `""`                                                                        |
| `admissionController.metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                                               | `""`                                                                        |
| `admissionController.metrics.serviceMonitor.metricRelabelings` | Specify additional relabeling of metrics                                                              | `[]`                                                                        |
| `admissionController.metrics.serviceMonitor.relabelings`       | Specify general relabeling                                                                            | `[]`                                                                        |

### Updater parameters

| Name                                                           | Description                                                                                           | Default                                                                 |
|----------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| `updater.enabled`                                              | Enable the component                                                                                  | `true`                                                                  |
| `updater.replicaCount`                                         | Number of replicas                                                                                    | `1`                                                                     |
| `updater.image.repository`                                     | Image name                                                                                            | `k8s.gcr.io/autoscaling/vpa-updater`                                    |
| `updater.image.tag`                                            | Image tag                                                                                             | `0.13.0`                                                                |
| `updater.image.pullPolicy`                                     | Image pull policy                                                                                     | `IfNotPresent`                                                          |
| `updater.pdb.create`                                           | Specifies whether a pod disruption budget should be created                                           | `false`                                                                 |
| `updater.pdb.minAvailable`                                     | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                                     |
| `updater.pdb.maxUnavailable`                                   | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                                   |
| `updater.serviceAccount.create`                                | Specify whether to create a ServiceAccount                                                            | `true`                                                                  |
| `updater.serviceAccount.annotations`                           | ServiceAccount annotations                                                                            | `{}`                                                                    |
| `updater.serviceAccount.name`                                  | The name of the ServiceAccount to create                                                              | Generated using the `vertical-pod-autoscaler.updater.fullname` template |
| `updater.podAnnotations`                                       | Additional pod annotations                                                                            | `{}`                                                                    |
| `updater.podLabels`                                            | Additional pod labels                                                                                 | `{}`                                                                    |
| `updater.podSecurityContext`                                   | Pod security context                                                                                  | `{ runAsNonRoot: true, runAsUser: 65534 }`                              |
| `updater.priorityClassName`                                    | Priority class name                                                                                   | `nil`                                                                   |
| `updater.securityContext`                                      | Container security context                                                                            | `{}`                                                                    |
| `updater.livenessProbe.enabled`                                | Enable liveness probe                                                                                 | `true`                                                                  |
| `updater.livenessProbe.initialDelaySeconds`                    | Delay before the liveness probe is initiated                                                          | `0`                                                                     |
| `updater.livenessProbe.periodSeconds`                          | How often to perform the liveness probe                                                               | `10`                                                                    |
| `updater.livenessProbe.timeoutSeconds`                         | When the liveness probe times out                                                                     | `1`                                                                     |
| `updater.livenessProbe.failureThreshold`                       | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                                     |
| `updater.livenessProbe.successThreshold`                       | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                                     |
| `updater.readinessProbe.enabled`                               | Enable readiness probe                                                                                | `true`                                                                  |
| `updater.readinessProbe.initialDelaySeconds`                   | Delay before the readiness probe is initiated                                                         | `0`                                                                     |
| `updater.readinessProbe.periodSeconds`                         | How often to perform the readiness probe                                                              | `10`                                                                    |
| `updater.readinessProbe.timeoutSeconds`                        | When the readiness probe times out                                                                    | `1`                                                                     |
| `updater.readinessProbe.failureThreshold`                      | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                                     |
| `updater.readinessProbe.successThreshold`                      | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                                     |
| `updater.resources`                                            | CPU/Memory resource requests/limits                                                                   | `{}`                                                                    |
| `updater.nodeSelector`                                         | Node labels for pod assignment                                                                        | `{}`                                                                    |
| `updater.tolerations`                                          | Tolerations for pod assignment                                                                        | `[]`                                                                    |
| `updater.affinity`                                             | Map of node/pod affinities                                                                            | `{}`                                                                    |
| `updater.extraArgs`                                            | Additional container arguments                                                                        | `{ v: 2 }`                                                              |
| `updater.extraEnvVars`                                         | Additional container environment variables                                                            | `[]`                                                                    |
| `updater.extraEnvVarsCM`                                       | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                                   |
| `updater.extraEnvVarsSecret`                                   | Name of existing Secret containing additional container environment variables                         | `nil`                                                                   |
| `updater.metrics.service.annotations`                          | Metrics service annotations                                                                           | `{}`                                                                    |
| `updater.metrics.service.type`                                 | Metrics service type                                                                                  | `ClusterIP`                                                             |
| `updater.metrics.service.clusterIP`                            | Metrics static cluster IP address or None for headless service when service type is ClusterIP         | `nil`                                                                   |
| `updater.metrics.service.port`                                 | Metrics service port                                                                                  | `8943`                                                                  |
| `admissionController.metrics.serviceMonitor.enabled`           | Specifies whether a service monitor should be created                                                 | `false`                                                                 |
| `admissionController.metrics.serviceMonitor.annotations`       | Extra annotations for the ServiceMonitor                                                              | `{}`                                                                    |
| `admissionController.metrics.serviceMonitor.labels`            | Extra labels for the ServiceMonitor                                                                   | `{}`                                                                    |
| `admissionController.metrics.serviceMonitor.jobLabel`          | The name of the label on the target service to use as the job name in Prometheus                      | `""`                                                                    |
| `admissionController.metrics.serviceMonitor.interval`          | How frequently to scrape metrics                                                                      | `""`                                                                    |
| `admissionController.metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                                               | `""`                                                                    |
| `admissionController.metrics.serviceMonitor.metricRelabelings` | Specify additional relabeling of metrics                                                              | `[]`                                                                    |
| `admissionController.metrics.serviceMonitor.relabelings`       | Specify general relabeling                                                                            | `[]`                                                                    |

### CRDs parameters

| Name                    | Description                    | Default           |
|-------------------------|--------------------------------|-------------------|
| `crds.image.repository` | Image name                     | `bitnami/kubectl` |
| `crds.image.tag`        | Image tag                      | `1.23.1`          |
| `crds.image.pullPolicy` | Image pull policy              | `IfNotPresent`    |
| `crds.podAnnotations`   | Additional pod annotations     | `{}`              |
| `crds.nodeSelector`     | Node labels for pod assignment | `{}`              |
| `crds.tolerations`      | Tolerations for pod assignment | `[]`              |
| `crds.affinity`         | Map of node/pod affinities     | `{}`              |

### Tests parameters

| Name                     | Description       | Default                      |
|--------------------------|-------------------|------------------------------|
| `tests.image.repository` | Image name        | `ghcr.io/cowboysysop/pytest` |
| `tests.image.tag`        | Image tag         | `1.0.35`                    |
| `tests.image.pullPolicy` | Image pull policy | `IfNotPresent`               |

### Setting parameters

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/vertical-pod-autoscaler
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/vertical-pod-autoscaler
```

**TIP**: You can use the default [values.yaml](values.yaml).

## Limitations

Due to hard-coded values in Vertical Pod Autoscaler, the chart configuration has some limitations:

- Admission controller component service name is `vpa-webhook`
- Admission controller component service port is `443`
- Mutating webhook configuration name automatically created by admission controller component is `vpa-webhook-config`
