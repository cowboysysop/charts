# Kubernetes MCP Server

[Kubernetes MCP Server](https://github.com/manusa/kubernetes-mcp-server) is a Model Context Protocol server for Kubernetes.

**DISCLAIMER**: This is an unofficial chart not supported by Kubernetes MCP Server authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/kubernetes-mcp
```

or for an OCI-based registry:

```bash
$ helm install my-release oci://ghcr.io/cowboysysop/charts/kubernetes-mcp
```

## Introduction

This chart bootstraps a Kubernetes MCP Server deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes >= 1.24
- Helm >= 3.9

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/kubernetes-mcp
```

or for an OCI-based registry:

```bash
$ helm install my-release oci://ghcr.io/cowboysysop/charts/kubernetes-mcp
```

These commands deploy Kubernetes MCP Server on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/kubernetes-mcp
```

or for an OCI-based registry:

```bash
$ helm upgrade my-release oci://ghcr.io/cowboysysop/charts/kubernetes-mcp
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

### Upgrading to version 2.0.0

The chart now uses forked versions of the Bitnami charts to reference the Bitnami Legacy repository:

- https://github.com/bitnami/containers/issues/83267

A label `app.kubernetes.io/component` will be added to the Deployment. Run this command before upgrading to prevent an immutable field error:

```bash
$ kubectl delete deployment/my-kubernetes-mcp-deployment
```

Pod and container security contexts are now configured with default values.

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

| Name                | Description                                                                                         | Default |
| ------------------- | --------------------------------------------------------------------------------------------------- | ------- |
| `kubeVersion`       | Override Kubernetes version                                                                         | `""`    |
| `nameOverride`      | Partially override `kubernetes-mcp.fullname` template with a string (will prepend the release name) | `""`    |
| `fullnameOverride`  | Fully override `kubernetes-mcp.fullname` template with a string                                     | `""`    |
| `namespaceOverride` | Fully override `common.names.namespace` template with a string                                      | `""`    |
| `commonAnnotations` | Annotations to add to all deployed objects                                                          | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                               | `{}`    |
| `extraDeploy`       | Array of extra objects to deploy with the release                                                   | `[]`    |

### Parameters

| Name                                       | Description                                                                                                | Default                        |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------------------- | ------------------------------ |
| `replicaCount`                             | Number of replicas                                                                                         | `1`                            |
| `revisionHistoryLimit`                     | Number of old history to retain to allow rollback                                                          | `10`                           |
| `image.registry`                           | Image registry                                                                                             | `quay.io`                      |
| `image.repository`                         | Image repository                                                                                           | `manusa/kubernetes_mcp_server` |
| `image.tag`                                | Image tag                                                                                                  | `v0.0.47`                      |
| `image.digest`                             | Image digest                                                                                               | `""`                           |
| `image.pullPolicy`                         | Image pull policy                                                                                          | `IfNotPresent`                 |
| `pdb.create`                               | Specifies whether a pod disruption budget should be created                                                | `false`                        |
| `pdb.minAvailable`                         | Minimum number/percentage of pods that should remain scheduled                                             | `1`                            |
| `pdb.maxUnavailable`                       | Maximum number/percentage of pods that may be made unavailable                                             | `nil`                          |
| `rbac.rules`                               | Custom RBAC rules to set                                                                                   | `[]`                           |
| `serviceAccount.create`                    | Specifies whether a service account should be created                                                      | `true`                         |
| `serviceAccount.annotations`               | Service account annotations                                                                                | `{}`                           |
| `serviceAccount.name`                      | The name of the service account to use (Generated using the `kubernetes-mcp.fullname` template if not set) | `nil`                          |
| `enableServiceLinks`                       | Whether information about services should be injected into pod's environment variable                      | `false`                        |
| `hostAliases`                              | Pod host aliases                                                                                           | `[]`                           |
| `deploymentAnnotations`                    | Additional deployment annotations                                                                          | `{}`                           |
| `podAnnotations`                           | Additional pod annotations                                                                                 | `{}`                           |
| `podLabels`                                | Additional pod labels                                                                                      | `{}`                           |
| `podSecurityContext`                       | Pod security context                                                                                       |                                |
| `podSecurityContext.seccompProfile.type`   | Set pod's Security Context seccomp profile                                                                 | `RuntimeDefault`               |
| `priorityClassName`                        | Priority class name                                                                                        | `nil`                          |
| `runtimeClassName`                         | Runtime class name                                                                                         | `""`                           |
| `topologySpreadConstraints`                | Topology Spread Constraints for pod assignment                                                             | `[]`                           |
| `securityContext`                          | Container security context                                                                                 |                                |
| `securityContext.allowPrivilegeEscalation` | Set container's Security Context allowPrivilegeEscalation                                                  | `false`                        |
| `securityContext.capabilities.drop`        | List of capabilities to be dropped                                                                         | `["ALL"]`                      |
| `securityContext.readOnlyRootFilesystem`   | Set container's Security Context readOnlyRootFilesystem                                                    | `true`                         |
| `securityContext.runAsNonRoot`             | Whether the container must run as a non-root user                                                          | `true`                         |
| `securityContext.runAsUser`                | The UID to run the entrypoint of the container process                                                     | `65534`                        |
| `securityContext.runAsGroup`               | The GID to run the entrypoint of the container process                                                     | `65534`                        |
| `containerPorts.http`                      | Container port for HTTP                                                                                    | `8080`                         |
| `service.annotations`                      | Service annotations                                                                                        | `{}`                           |
| `service.type`                             | Service type                                                                                               | `ClusterIP`                    |
| `service.clusterIP`                        | Static cluster IP address or None for headless service when service type is ClusterIP                      | `nil`                          |
| `service.ipFamilyPolicy`                   | Service IP family policy                                                                                   | `""`                           |
| `service.ipFamilies`                       | Service IP families                                                                                        | `[]`                           |
| `service.sessionAffinity`                  | Control where client requests go, to the same pod or round-robin                                           | `None`                         |
| `service.sessionAffinityConfig`            | Additional settings for the sessionAffinity                                                                | `{}`                           |
| `service.loadBalancerIP`                   | Static load balancer IP address when service type is LoadBalancer                                          | `nil`                          |
| `service.loadBalancerSourceRanges`         | Source IP address ranges when service type is LoadBalancer                                                 | `nil`                          |
| `service.externalTrafficPolicy`            | External traffic routing policy when service type is LoadBalancer or NodePort                              | `Cluster`                      |
| `service.ports.http`                       | Service port for HTTP                                                                                      | `8080`                         |
| `service.nodePorts.http`                   | Service node port for HTTP when service type is LoadBalancer or NodePort                                   | `nil`                          |
| `ingress.enabled`                          | Enable ingress controller resource                                                                         | `false`                        |
| `ingress.ingressClassName`                 | IngressClass that will be be used to implement the Ingress                                                 | `""`                           |
| `ingress.pathType`                         | Ingress path type                                                                                          | `ImplementationSpecific`       |
| `ingress.annotations`                      | Ingress annotations                                                                                        | `{}`                           |
| `ingress.hosts[0].host`                    | Hostname to your Kubernetes MCP Server installation                                                        | `kubernetes-mcp.local`         |
| `ingress.hosts[0].paths`                   | Paths within the url structure                                                                             | `["/"]`                        |
| `ingress.tls`                              | TLS configuration                                                                                          | `[]`                           |
| `resources`                                | CPU/Memory resource requests/limits                                                                        | `{}`                           |
| `nodeSelector`                             | Node labels for pod assignment                                                                             | `{}`                           |
| `tolerations`                              | Tolerations for pod assignment                                                                             | `[]`                           |
| `affinity`                                 | Map of node/pod affinities                                                                                 | `{}`                           |
| `extraArgs`                                | Additional container arguments                                                                             | `{}`                           |
| `extraEnvVars`                             | Additional container environment variables                                                                 | `[]`                           |
| `extraEnvVarsCM`                           | Name of existing ConfigMap containing additional container environment variables                           | `nil`                          |
| `extraEnvVarsSecret`                       | Name of existing Secret containing additional container environment variables                              | `nil`                          |
| `extraVolumes`                             | Optionally specify extra list of additional volumes                                                        | `[]`                           |
| `extraVolumeMounts`                        | Optionally specify extra list of additional volumeMounts                                                   | `[]`                           |

### Tests parameters

| Name                     | Description       | Default              |
| ------------------------ | ----------------- | -------------------- |
| `tests.image.registry`   | Image registry    | `ghcr.io`            |
| `tests.image.repository` | Image repository  | `cowboysysop/pytest` |
| `tests.image.tag`        | Image tag         | `1.2.0`              |
| `tests.image.digest`     | Image digest      | `""`                 |
| `tests.image.pullPolicy` | Image pull policy | `IfNotPresent`       |

## Setting parameters

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/kubernetes-mcp
```

or for an OCI-based registry:

```bash
$ helm install my-release \
    --set nameOverride=my-name oci://ghcr.io/cowboysysop/charts/kubernetes-mcp
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/kubernetes-mcp
```

or for an OCI-based registry:

```bash
$ helm install my-release \
    --values values.yaml oci://ghcr.io/cowboysysop/charts/kubernetes-mcp
```

**TIP**: You can use the default [values.yaml](values.yaml).

## License

The source code of this chart is under [MIT License](LICENSE).

It also uses source code under Apache 2.0 License from the [Bitnami repository](https://github.com/bitnami/charts).
