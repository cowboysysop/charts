# Redis Extra

[Redis Extra](https://github.com/cowboysysop/charts/tree/master/charts/redis-extra) are a collection of extra Kubernetes objects for a Redis instance.

**DISCLAIMER**: This is an unofficial chart not supported by Redis authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/redis-extra
```

## Introduction

This chart bootstraps a Redis Extra deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes >= 1.24
- Helm >= 3.9

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/redis-extra
```

These commands deploy Redis Extra on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/redis-extra
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

## Configuration

### Common parameters

| Name                | Description                                                                                      | Default |
| ------------------- | ------------------------------------------------------------------------------------------------ | ------- |
| `kubeVersion`       | Override Kubernetes version                                                                      | `""`    |
| `nameOverride`      | Partially override `redis-extra.fullname` template with a string (will prepend the release name) | `""`    |
| `fullnameOverride`  | Fully override `redis-extra.fullname` template with a string                                     | `""`    |
| `commonAnnotations` | Annotations to add to all deployed objects                                                       | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                            | `{}`    |
| `extraDeploy`       | Array of extra objects to deploy with the release                                                | `[]`    |

### Velero backups parameters

| Name                              | Description                                         | Default  |
| --------------------------------- | --------------------------------------------------- | -------- |
| `veleroBackups.enabled`           | Specifies whether Velero backups should be created  | `false`  |
| `veleroBackups.namespace`         | Namespace in which to create the Velero backups     | `velero` |
| `veleroBackups.annotations`       | Velero backup annotations                           | `{}`     |
| `veleroBackups.backupLocation`    | Backup storage location                             | `""`     |
| `veleroBackups.snapshotLocation`  | Volume snapshot location                            | `""`     |
| `veleroBackups.hourly.enabled`    | Enable hourly backups                               | `false`  |
| `veleroBackups.hourly.minute`     | Minute for hourly backups                           | `0`      |
| `veleroBackups.hourly.retention`  | Number of hours after which hourly backups expire   | `24`     |
| `veleroBackups.daily.enabled`     | Enable daily backups                                | `true`   |
| `veleroBackups.daily.hour`        | Hour for daily backups                              | `0`      |
| `veleroBackups.daily.minute`      | Minute for daily backups                            | `0`      |
| `veleroBackups.daily.retention`   | Number of days after which daily backups expire     | `7`      |
| `veleroBackups.weekly.enabled`    | Enable weekly backups                               | `true`   |
| `veleroBackups.weekly.day`        | Day of week for weekly backups                      | `0`      |
| `veleroBackups.weekly.hour`       | Hour for weekly backups                             | `0`      |
| `veleroBackups.weekly.minute`     | Minute for weekly backups                           | `0`      |
| `veleroBackups.weekly.retention`  | Number of weeks after which weekly backups expire   | `5`      |
| `veleroBackups.monthly.enabled`   | Enable monthly backups                              | `true`   |
| `veleroBackups.monthly.day`       | Day of month for monthly backups                    | `1`      |
| `veleroBackups.monthly.hour`      | Hour for monthly backups                            | `0`      |
| `veleroBackups.monthly.minute`    | Minute for monthly backups                          | `0`      |
| `veleroBackups.monthly.retention` | Number of months after which monthly backups expire | `12`     |
| `veleroBackups.yearly.enabled`    | Enable yearly backups                               | `false`  |
| `veleroBackups.yearly.month`      | Month for yearly backups                            | `1`      |
| `veleroBackups.yearly.day`        | Day of month for yearly backups                     | `1`      |
| `veleroBackups.yearly.hour`       | Hour for yearly backups                             | `0`      |
| `veleroBackups.yearly.minute`     | Minute for yearly backups                           | `0`      |
| `veleroBackups.yearly.retention`  | Number of years after which yearly backups expire   | `10`     |

## Setting parameters

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/redis-extra
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/redis-extra
```

**TIP**: You can use the default [values.yaml](values.yaml).

## License

The source code of this chart is under [MIT License](LICENSE).

It also uses source code under Apache 2.0 License from the [Bitnami repository](https://github.com/bitnami/charts).
