# Kubebox

[Kubebox](https://github.com/astefanutti/kubebox) is a Terminal and Web console for Kubernetes.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install cowboysysop/kubebox
```

## Introduction

This chart bootstraps a Kubebox deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- cAdvisor 0.36+ (you can use the [code-chris/cadvisor](https://hub.helm.sh/charts/code-chris/cadvisor) chart)
- Helm 2.11+

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install --name my-release cowboysysop/kubebox
```

These commands deploy Kubebox on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/kubebox
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

## Uninstalling

Uninstall the `my-release` deployment using:

```bash
$ helm delete my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

## Configuration

The following table lists all the configurable parameters expose by the Kubebox chart and their default values.

| Name                         | Description                                                                                  | Default                                         |
|------------------------------|----------------------------------------------------------------------------------------------|-------------------------------------------------|
| `replicaCount`               | Number of replicas                                                                           | `1`                                             |
| `image.repository`           | Kubebox image name                                                                           | `astefanutti/kubebox`                           |
| `image.tag`                  | Kubebox image tag                                                                            | `0.8.0-server`                                  |
| `image.pullPolicy`           | Image pull policy                                                                            | `IfNotPresent`                                  |
| `imagePullSecrets`           | Docker registry secret names as an array                                                     | `[]`                                            |
| `nameOverride`               | Partially override `kubebox.fullname` template with a string (will prepend the release name) | `nil`                                           |
| `fullnameOverride`           | Fully override `kubebox.fullname` template with a string                                     | `nil`                                           |
| `serviceAccount.create`      | Specify whether to create a ServiceAccount                                                   | `true`                                          |
| `serviceAccount.annotations` | ServiceAccount annotations                                                                   | `{}`                                            |
| `serviceAccount.name`        | The name of the ServiceAccount to create                                                     | Generated using the `kubebox.fullname` template |
| `podAnnotations`             | Additional pod annotations                                                                   | `{}`                                            |
| `podLabels`                  | Additional pod labels                                                                        | `{}`                                            |
| `podSecurityContext`         | Pod security context                                                                         | `{}`                                            |
| `securityContext`            | Container security context                                                                   | `{}`                                            |
| `service.type`               | Kubernetes Service type                                                                      | `ClusterIP`                                     |
| `service.port`               | Kubebox service port                                                                         | `8080`                                          |
| `ingress.enabled`            | Enable ingress controller resource                                                           | `false`                                         |
| `ingress.annotations`        | Ingress annotations                                                                          | `{}`                                            |
| `ingress.hosts[0].name`      | Hostname to your Kubebox installation                                                        | `kubebox.local`                                 |
| `ingress.hosts[0].paths`     | Paths within the url structure                                                               | `[]`                                            |
| `ingress.tls[0].secretName`  | TLS Secret (certificates)                                                                    | `nil`                                           |
| `ingress.tls[0].hosts[0]`    | TLS hosts                                                                                    | `nil`                                           |
| `resources`                  | CPU/Memory resource requests/limits                                                          | `{}`                                            |
| `nodeSelector`               | Node labels for pod assignment                                                               | `{}`                                            |
| `tolerations`                | Tolerations for pod assignment                                                               | `[]`                                            |
| `affinity`                   | Map of node/pod affinities                                                                   | `{}`                                            |

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install --name my-release \
    --set replicaCount=3 cowboysysop/kubebox
```

The above command sets the `replicaCount` to `3`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release \
    --values values.yaml cowboysysop/kubebox
```

**Tip**: You can use the default [values.yaml](values.yaml).
