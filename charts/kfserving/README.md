# KFServing

[KFServing](https://github.com/kserve/kserve) is a highly scalable and standards based Model Inference Platform on Kubernetes.

**DISCLAIMER**: This is an unofficial chart not supported by KFServing authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/kfserving
```

## Introduction

This chart bootstraps a KFServing deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes >= 1.16 and <= 1.21
- cert-manager >= 1.3 (you can use the [cert-manager/cert-manager](https://artifacthub.io/packages/helm/cert-manager/cert-manager) chart)
- Knative Serving >= 0.22 with Istio network layer
- Helm >= 3.1

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/kfserving
```

These commands deploy KFServing on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/kfserving
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
$ kubectl delete crd inferenceservices.serving.kubeflow.org
$ kubectl delete crd trainedmodels.serving.kubeflow.org
```

## Configuration

The following tables lists all the configurable parameters expose by the chart and their default values.

### Common parameters

| Name                | Description                                                                                    | Default |
|---------------------|------------------------------------------------------------------------------------------------|---------|
| `kubeVersion`       | Override Kubernetes version                                                                    | `""`    |
| `imagePullSecrets`  | Docker registry secret names as an array                                                       | `[]`    |
| `nameOverride`      | Partially override `kfserving.fullname` template with a string (will prepend the release name) | `nil`   |
| `fullnameOverride`  | Fully override `kfserving.fullname` template with a string                                     | `nil`   |
| `commonAnnotations` | Annotations to add to all deployed objects                                                     | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                          | `{}`    |

### Controller parameters

| Name                                            | Description                                                                                           | Default                                                      |
|-------------------------------------------------|-------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| `controller.replicaCount`                       | Number of replicas                                                                                    | `1`                                                          |
| `controller.image.repository`                   | Image name                                                                                            | `kfserving/kfserving-controller`                             |
| `controller.image.tag`                          | Image tag                                                                                             | `v0.6.1`                                                     |
| `controller.image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                               |
| `controller.pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                                      |
| `controller.pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                          |
| `controller.pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                        |
| `controller.serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                                       |
| `controller.serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                                         |
| `controller.serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `kfserving.controller.fullname` template |
| `controller.podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                                         |
| `controller.podLabels`                          | Additional pod labels                                                                                 | `{}`                                                         |
| `controller.podSecurityContext`                 | Pod security context                                                                                  | `{}`                                                         |
| `controller.priorityClassName`                  | Priority class name                                                                                   | `nil`                                                        |
| `controller.securityContext`                    | Container security context                                                                            | `{}`                                                         |
| `controller.livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                                       |
| `controller.livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                                          |
| `controller.livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                                         |
| `controller.livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                                          |
| `controller.livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                          |
| `controller.livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                          |
| `controller.readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                                       |
| `controller.readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                                          |
| `controller.readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                                         |
| `controller.readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                                          |
| `controller.readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                          |
| `controller.readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                          |
| `controller.service.annotations`                | Service annotations                                                                                   | `{}`                                                         |
| `controller.service.type`                       | Service type                                                                                          | `ClusterIP`                                                  |
| `controller.service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                                        |
| `controller.service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                                                        |
| `controller.service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                                                        |
| `controller.service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                                                    |
| `controller.service.port`                       | Service port                                                                                          | `9443`                                                       |
| `controller.service.nodePort`                   | Service node port when service type is LoadBalancer or NodePort                                       | `nil`                                                        |
| `controller.resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                                         |
| `controller.nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                                         |
| `controller.tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                                         |
| `controller.affinity`                           | Map of node/pod affinities                                                                            | `{}`                                                         |
| `controller.extraArgs`                          | Additional container arguments                                                                        | `{}`                                                         |
| `controller.extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                                         |
| `controller.extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                        |
| `controller.extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                                        |
| `controller.metrics.service.annotations`        | Metrics service annotations                                                                           | `{}`                                                         |
| `controller.metrics.service.type`               | Metrics service type                                                                                  | `ClusterIP`                                                  |
| `controller.metrics.service.clusterIP`          | Metrics static cluster IP address or None for headless service when service type is ClusterIP         | `nil`                                                        |
| `controller.metrics.service.port`               | Metrics service port                                                                                  | `8080`                                                       |

### Models web app parameters

| Name                                              | Description                                                                                           | Default                                                        |
|---------------------------------------------------|-------------------------------------------------------------------------------------------------------|----------------------------------------------------------------|
| `modelsWebApp.replicaCount`                       | Number of replicas                                                                                    | `1`                                                            |
| `modelsWebApp.image.repository`                   | Image name                                                                                            | `kfserving/models-web-app`                                     |
| `modelsWebApp.image.tag`                          | Image tag                                                                                             | `v0.6.1`                                                       |
| `modelsWebApp.image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                                 |
| `modelsWebApp.pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                                        |
| `modelsWebApp.pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                            |
| `modelsWebApp.pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                          |
| `modelsWebApp.serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                                         |
| `modelsWebApp.serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                                           |
| `modelsWebApp.serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `kfserving.modelsWebApp.fullname` template |
| `modelsWebApp.podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                                           |
| `modelsWebApp.podLabels`                          | Additional pod labels                                                                                 | `{}`                                                           |
| `modelsWebApp.podSecurityContext`                 | Pod security context                                                                                  | `{}`                                                           |
| `modelsWebApp.priorityClassName`                  | Priority class name                                                                                   | `nil`                                                          |
| `modelsWebApp.securityContext`                    | Container security context                                                                            | `{}`                                                           |
| `modelsWebApp.livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                                         |
| `modelsWebApp.livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                                            |
| `modelsWebApp.livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                                           |
| `modelsWebApp.livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                                            |
| `modelsWebApp.livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                            |
| `modelsWebApp.livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                            |
| `modelsWebApp.readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                                         |
| `modelsWebApp.readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                                            |
| `modelsWebApp.readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                                           |
| `modelsWebApp.readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                                            |
| `modelsWebApp.readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                            |
| `modelsWebApp.readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                            |
| `modelsWebApp.service.annotations`                | Service annotations                                                                                   | `{}`                                                           |
| `modelsWebApp.service.type`                       | Service type                                                                                          | `ClusterIP`                                                    |
| `modelsWebApp.service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                                          |
| `modelsWebApp.service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                                                          |
| `modelsWebApp.service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                                                          |
| `modelsWebApp.service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                                                      |
| `modelsWebApp.service.port`                       | Service port                                                                                          | `5000`                                                         |
| `modelsWebApp.service.nodePort`                   | Service node port when service type is LoadBalancer or NodePort                                       | `nil`                                                          |
| `modelsWebApp.ingress.enabled`                    | Enable ingress controller resource                                                                    | `false`                                                        |
| `modelsWebApp.ingress.ingressClassName`           | IngressClass that will be be used to implement the Ingress                                            | `""`                                                           |
| `modelsWebApp.ingress.pathType`                   | Ingress path type                                                                                     | `ImplementationSpecific`                                       |
| `modelsWebApp.ingress.annotations`                | Ingress annotations                                                                                   | `{}`                                                           |
| `modelsWebApp.ingress.hosts[0].host`              | Hostname to your KFServing installation                                                               | `kfserving.local`                                              |
| `modelsWebApp.ingress.hosts[0].paths`             | Paths within the url structure                                                                        | `[/]`                                                          |
| `modelsWebApp.ingress.tls[0].secretName`          | TLS Secret (certificates)                                                                             | `nil`                                                          |
| `modelsWebApp.ingress.tls[0].hosts[0]`            | TLS hosts                                                                                             | `nil`                                                          |
| `modelsWebApp.resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                                           |
| `modelsWebApp.nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                                           |
| `modelsWebApp.tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                                           |
| `modelsWebApp.affinity`                           | Map of node/pod affinities                                                                            | `{}`                                                           |
| `modelsWebApp.extraArgs`                          | Additional container arguments                                                                        | `{}`                                                           |
| `modelsWebApp.extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                                           |
| `modelsWebApp.extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                          |
| `modelsWebApp.extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                                          |

### Knative parameters

| Name                          | Description                            | Default                                                |
|-------------------------------|----------------------------------------|--------------------------------------------------------|
| `knative.ingressGateway`      | Istio gateway for external access      | `knative-serving/knative-ingress-gateway`              |
| `knative.ingressService`      | Service for external access            | `istio-ingressgateway.istio-system.svc.cluster.local`  |
| `knative.localGateway`        | Istio gateway for cluster local access | `knative-serving/knative-local-gateway`                |
| `knative.localGatewayService` | Service for cluster local access       | `knative-local-gateway.istio-system.svc.cluster.local` |

### Kubeflow parameters

| Name                    | Description                              | Default           |
|-------------------------|------------------------------------------|-------------------|
| `kubeflow.enabled`      | Enable integration with Kubeflow         | `false`           |
| `kubeflow.gatewayName`  | Istio gateway name                       | `kubeflow`        |
| `kubeflow.useridHeader` | Key of request header containing user id | `kubeflow-userid` |
| `kubeflow.useridPrefix` | Request header user id common prefix     | `""`              |

### CRDs parameters

| Name                    | Description                    | Default           |
|-------------------------|--------------------------------|-------------------|
| `crds.image.repository` | Image name                     | `bitnami/kubectl` |
| `crds.image.tag`        | Image tag                      | `1.23.1`          |
| `crds.image.pullPolicy` | Image pull policy              | `IfNotPresent`    |
| `crds.nodeSelector`     | Node labels for pod assignment | `{}`              |
| `crds.tolerations`      | Tolerations for pod assignment | `[]`              |
| `crds.affinity`         | Map of node/pod affinities     | `{}`              |

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
    --set nameOverride=my-name cowboysysop/kfserving
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/kfserving
```

**TIP**: You can use the default [values.yaml](values.yaml).
