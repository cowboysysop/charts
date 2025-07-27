# Cert-Manager Common

[Cert-Manager Common](https://github.com/cowboysysop/charts/tree/master/charts/cert-manager-common) are a collection of Kubernetes objects common to all Cert-Manager instances.

**DISCLAIMER**: This is an unofficial chart not supported by Cert-Manager authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/cert-manager-common
```

or for an OCI-based registry:

```bash
$ helm install my-release oci://ghcr.io/cowboysysop/charts/cert-manager-common
```

## Introduction

This chart bootstraps a Cert-Manager Common deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes >= 1.24
- Helm >= 3.9

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/cert-manager-common
```

or for an OCI-based registry:

```bash
$ helm install my-release oci://ghcr.io/cowboysysop/charts/cert-manager-common
```

These commands deploy Cert-Manager Common on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/cert-manager-common
```

or for an OCI-based registry:

```bash
$ helm upgrade my-release oci://ghcr.io/cowboysysop/charts/cert-manager-common
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

### Upgrading to version 2.0.0
The chart now uses forked versions of the Bitnami charts to reference the Bitnami Legacy repository:

- https://github.com/bitnami/containers/issues/83267

## Uninstalling

Uninstall the `my-release` deployment using:

```bash
$ helm uninstall my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

## Configuration

### Common parameters

| Name                | Description                                                                                              | Default |
| ------------------- | -------------------------------------------------------------------------------------------------------- | ------- |
| `kubeVersion`       | Override Kubernetes version                                                                              | `""`    |
| `nameOverride`      | Partially override `cert-manager-common.fullname` template with a string (will prepend the release name) | `""`    |
| `fullnameOverride`  | Fully override `cert-manager-common.fullname` template with a string                                     | `""`    |
| `namespaceOverride` | Fully override `common.names.namespace` template with a string                                           | `""`    |
| `commonAnnotations` | Annotations to add to all deployed objects                                                               | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                                    | `{}`    |
| `extraDeploy`       | Array of extra objects to deploy with the release                                                        | `[]`    |

### Grafana dashboards parameters

| Name                                         | Description                                            | Default |
| -------------------------------------------- | ------------------------------------------------------ | ------- |
| `grafanaDashboards.enabled`                  | Specifies whether Grafana dashboards should be created | `false` |
| `grafanaDashboards.namespace`                | Namespace in which to create the Grafana dashboards    | `""`    |
| `grafanaDashboards.labels`                   | Additional Grafana dashboards labels                   |         |
| `grafanaDashboards.labels.grafana_dashboard` | Label used by Grafana dashboards selector              | `1`     |

### Prometheus rules parameters

| Name                             | Description                                          | Default                 |
| -------------------------------- | ---------------------------------------------------- | ----------------------- |
| `prometheusRules.enabled`        | Specifies whether Prometheus rules should be created | `false`                 |
| `prometheusRules.namespace`      | Namespace in which to create the Prometheus rules    | `""`                    |
| `prometheusRules.labels`         | Additional Prometheus rules labels                   |                         |
| `prometheusRules.labels.release` | Label used by Prometheus rules selector              | `kube-prometheus-stack` |

## Setting parameters

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/cert-manager-common
```

or for an OCI-based registry:

```bash
$ helm install my-release \
    --set nameOverride=my-name oci://ghcr.io/cowboysysop/charts/cert-manager-common
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/cert-manager-common
```

or for an OCI-based registry:

```bash
$ helm install my-release \
    --values values.yaml oci://ghcr.io/cowboysysop/charts/cert-manager-common
```

**TIP**: You can use the default [values.yaml](values.yaml).

## License

The source code of this chart is under [MIT License](LICENSE).

It also uses source code under Apache 2.0 License from the [Bitnami repository](https://github.com/bitnami/charts).
