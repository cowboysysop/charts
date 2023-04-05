# Kroki

[Kroki](https://kroki.io/) creates diagrams from textual descriptions.

**DISCLAIMER**: This is an unofficial chart not supported by Kroki authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/kroki
```

## Introduction

This chart bootstraps a Kroki deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes >= 1.19
- Helm >= 3.1

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/kroki
```

These commands deploy Kroki on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/kroki
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

### Upgrading to version 2.0.0

Some parameters related to image management have been modified:

- Registry prefix in `image.repository` parameters is now configured in `image.registry`.
- Parameter `imagePullSecrets` has been renamed `global.imagePullSecrets`.

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

| Name                | Description                                                                                | Default |
|---------------------|--------------------------------------------------------------------------------------------|---------|
| `kubeVersion`       | Override Kubernetes version                                                                | `""`    |
| `nameOverride`      | Partially override `kroki.fullname` template with a string (will prepend the release name) | `nil`   |
| `fullnameOverride`  | Fully override `kroki.fullname` template with a string                                     | `nil`   |
| `commonAnnotations` | Annotations to add to all deployed objects                                                 | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                      | `{}`    |
| `extraDeploy`       | Array of extra objects to deploy with the release                                          | `[]`    |

### Parameters

| Name                                 | Description                                                                                           | Default                                       |
|--------------------------------------|-------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| `replicaCount`                       | Number of replicas                                                                                    | `1`                                           |
| `image.registry`                     | Image registry                                                                                        | `docker.io`                                   |
| `image.repository`                   | Image repository                                                                                      | `yuzutech/kroki`                              |
| `image.tag`                          | Image tag                                                                                             | `0.20.0`                                      |
| `image.digest`                       | Image digest                                                                                          | `""`                                          |
| `image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                |
| `pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                       |
| `pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                           |
| `pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                         |
| `serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                        |
| `serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                          |
| `serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `kroki.fullname` template |
| `podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                          |
| `podLabels`                          | Additional pod labels                                                                                 | `{}`                                          |
| `podSecurityContext`                 | Pod security context                                                                                  | `{}`                                          |
| `priorityClassName`                  | Priority class name                                                                                   | `nil`                                         |
| `securityContext`                    | Container security context                                                                            | `{}`                                          |
| `livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                        |
| `livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                           |
| `livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                          |
| `livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                           |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                           |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                           |
| `readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                        |
| `readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                           |
| `readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                          |
| `readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                           |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                           |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                           |
| `service.annotations`                | Service annotations                                                                                   | `{}`                                          |
| `service.type`                       | Service type                                                                                          | `ClusterIP`                                   |
| `service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                         |
| `service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                                         |
| `service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                                         |
| `service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                                     |
| `service.port`                       | Service port                                                                                          | `8000`                                        |
| `service.nodePort`                   | Service node port when service type is LoadBalancer or NodePort                                       | `nil`                                         |
| `ingress.enabled`                    | Enable ingress controller resource                                                                    | `false`                                       |
| `ingress.ingressClassName`           | IngressClass that will be be used to implement the Ingress                                            | `""`                                          |
| `ingress.pathType`                   | Ingress path type                                                                                     | `ImplementationSpecific`                      |
| `ingress.annotations`                | Ingress annotations                                                                                   | `{}`                                          |
| `ingress.hosts[0].host`              | Hostname to your Kroki installation                                                                   | `kroki.local`                                 |
| `ingress.hosts[0].paths`             | Paths within the url structure                                                                        | `[/]`                                         |
| `ingress.tls[0].secretName`          | TLS Secret (certificates)                                                                             | `nil`                                         |
| `ingress.tls[0].hosts[0]`            | TLS hosts                                                                                             | `nil`                                         |
| `resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                          |
| `nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                          |
| `tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                          |
| `affinity`                           | Map of node/pod affinities                                                                            | `{}`                                          |
| `extraArgs`                          | Additional container arguments                                                                        | `{}`                                          |
| `extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                          |
| `extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                         |
| `extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                         |

### BlockDiag parameters

| Name                           | Description                                                                      | Default                    |
|--------------------------------|----------------------------------------------------------------------------------|----------------------------|
| `blockdiag.enabled`            | Enable BlockDiag diagrams                                                        | `true`                     |
| `blockdiag.image.registry`     | Image registry                                                                   | `docker.io`                |
| `blockdiag.image.repository`   | Image repository                                                                 | `yuzutech/kroki-blockdiag` |
| `blockdiag.image.tag`          | Image tag                                                                        | `0.20.0`                   |
| `blockdiag.image.digest`       | Image digest                                                                     | `""`                       |
| `blockdiag.image.pullPolicy`   | Image pull policy                                                                | `IfNotPresent`             |
| `blockdiag.securityContext`    | Container security context                                                       | `{}`                       |
| `blockdiag.resources`          | CPU/Memory resource requests/limits                                              | `{}`                       |
| `blockdiag.extraArgs`          | Additional container arguments                                                   | `{}`                       |
| `blockdiag.extraEnvVars`       | Additional container environment variables                                       | `[]`                       |
| `blockdiag.extraEnvVarsCM`     | Name of existing ConfigMap containing additional container environment variables | `nil`                      |
| `blockdiag.extraEnvVarsSecret` | Name of existing Secret containing additional container environment variables    | `nil`                      |

### BPMN parameters

| Name                      | Description                                                                      | Default               |
|---------------------------|----------------------------------------------------------------------------------|-----------------------|
| `bpmn.enabled`            | Enable BPMN diagrams                                                             | `true`                |
| `bpmn.image.registry`     | Image registry                                                                   | `docker.io`           |
| `bpmn.image.repository`   | Image repository                                                                 | `yuzutech/kroki-bpmn` |
| `bpmn.image.tag`          | Image tag                                                                        | `0.20.0`              |
| `bpmn.image.digest`       | Image digest                                                                     | `""`                  |
| `bpmn.image.pullPolicy`   | Image pull policy                                                                | `IfNotPresent`        |
| `bpmn.securityContext`    | Container security context                                                       | `{}`                  |
| `bpmn.resources`          | CPU/Memory resource requests/limits                                              | `{}`                  |
| `bpmn.extraArgs`          | Additional container arguments                                                   | `{}`                  |
| `bpmn.extraEnvVars`       | Additional container environment variables                                       | `[]`                  |
| `bpmn.extraEnvVarsCM`     | Name of existing ConfigMap containing additional container environment variables | `nil`                 |
| `bpmn.extraEnvVarsSecret` | Name of existing Secret containing additional container environment variables    | `nil`                 |

### Diagrams.net parameters

| Name                             | Description                                                                      | Default                      |
|----------------------------------|----------------------------------------------------------------------------------|------------------------------|
| `diagramsnet.enabled`            | Enable Diagrams.net diagrams                                                     | `true`                       |
| `diagramsnet.image.registry`     | Image registry                                                                   | `docker.io`                  |
| `diagramsnet.image.repository`   | Image repository                                                                 | `yuzutech/kroki-diagramsnet` |
| `diagramsnet.image.tag`          | Image tag                                                                        | `0.20.0`                     |
| `diagramsnet.image.digest`       | Image digest                                                                     | `""`                         |
| `diagramsnet.image.pullPolicy`   | Image pull policy                                                                | `IfNotPresent`               |
| `diagramsnet.securityContext`    | Container security context                                                       | `{}`                         |
| `diagramsnet.resources`          | CPU/Memory resource requests/limits                                              | `{}`                         |
| `diagramsnet.extraArgs`          | Additional container arguments                                                   | `{}`                         |
| `diagramsnet.extraEnvVars`       | Additional container environment variables                                       | `[]`                         |
| `diagramsnet.extraEnvVarsCM`     | Name of existing ConfigMap containing additional container environment variables | `nil`                        |
| `diagramsnet.extraEnvVarsSecret` | Name of existing Secret containing additional container environment variables    | `nil`                        |

### Excalidraw parameters

| Name                            | Description                                                                      | Default                     |
|---------------------------------|----------------------------------------------------------------------------------|-----------------------------|
| `excalidraw.enabled`            | Enable Excalidraw diagrams                                                       | `true`                      |
| `excalidraw.image.registry`     | Image registry                                                                   | `docker.io`                 |
| `excalidraw.image.repository`   | Image repository                                                                 | `yuzutech/kroki-excalidraw` |
| `excalidraw.image.tag`          | Image tag                                                                        | `0.20.0`                    |
| `excalidraw.image.digest`       | Image digest                                                                     | `""`                        |
| `excalidraw.image.pullPolicy`   | Image pull policy                                                                | `IfNotPresent`              |
| `excalidraw.securityContext`    | Container security context                                                       | `{}`                        |
| `excalidraw.resources`          | CPU/Memory resource requests/limits                                              | `{}`                        |
| `excalidraw.extraArgs`          | Additional container arguments                                                   | `{}`                        |
| `excalidraw.extraEnvVars`       | Additional container environment variables                                       | `[]`                        |
| `excalidraw.extraEnvVarsCM`     | Name of existing ConfigMap containing additional container environment variables | `nil`                       |
| `excalidraw.extraEnvVarsSecret` | Name of existing Secret containing additional container environment variables    | `nil`                       |

### Mermaid parameters

| Name                         | Description                                                                      | Default                  |
|------------------------------|----------------------------------------------------------------------------------|--------------------------|
| `mermaid.enabled`            | Enable Mermaid diagrams                                                          | `true`                   |
| `mermaid.image.registry`     | Image registry                                                                   | `docker.io`              |
| `mermaid.image.repository`   | Image repository                                                                 | `yuzutech/kroki-mermaid` |
| `mermaid.image.tag`          | Image tag                                                                        | `0.20.0`                 |
| `mermaid.image.digest`       | Image digest                                                                     | `""`                     |
| `mermaid.image.pullPolicy`   | Image pull policy                                                                | `IfNotPresent`           |
| `mermaid.securityContext`    | Container security context                                                       | `{}`                     |
| `mermaid.resources`          | CPU/Memory resource requests/limits                                              | `{}`                     |
| `mermaid.extraArgs`          | Additional container arguments                                                   | `{}`                     |
| `mermaid.extraEnvVars`       | Additional container environment variables                                       | `[]`                     |
| `mermaid.extraEnvVarsCM`     | Name of existing ConfigMap containing additional container environment variables | `nil`                    |
| `mermaid.extraEnvVarsSecret` | Name of existing Secret containing additional container environment variables    | `nil`                    |

### WireViz parameters

| Name                         | Description                                                                      | Default                  |
|------------------------------|----------------------------------------------------------------------------------|--------------------------|
| `wireviz.enabled`            | Enable WireViz diagrams                                                          | `true`                   |
| `wireviz.image.registry`     | Image registry                                                                   | `docker.io`              |
| `wireviz.image.repository`   | Image repository                                                                 | `yuzutech/kroki-wireviz` |
| `wireviz.image.tag`          | Image tag                                                                        | `0.20.0`                 |
| `wireviz.image.digest`       | Image digest                                                                     | `""`                     |
| `wireviz.image.pullPolicy`   | Image pull policy                                                                | `IfNotPresent`           |
| `wireviz.securityContext`    | Container security context                                                       | `{}`                     |
| `wireviz.resources`          | CPU/Memory resource requests/limits                                              | `{}`                     |
| `wireviz.extraArgs`          | Additional container arguments                                                   | `{}`                     |
| `wireviz.extraEnvVars`       | Additional container environment variables                                       | `[]`                     |
| `wireviz.extraEnvVarsCM`     | Name of existing ConfigMap containing additional container environment variables | `nil`                    |
| `wireviz.extraEnvVarsSecret` | Name of existing Secret containing additional container environment variables    | `nil`                    |

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
    --set nameOverride=my-name cowboysysop/kroki
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/kroki
```

**TIP**: You can use the default [values.yaml](values.yaml).
