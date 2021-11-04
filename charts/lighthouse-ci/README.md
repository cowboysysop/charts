# Lighthouse CI Server

[Lighthouse CI Server](https://github.com/GoogleChrome/lighthouse-ci) enables running a server to display Lighthouse CI results.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/lighthouse-ci
```

## Introduction

This chart bootstraps a Lighthouse CI Server deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.16+ (should work with 1.12+)
- Helm 3.1+

## Installing

Install the chart using:

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/lighthouse-ci
```

These commands deploy Lighthouse CI Server on the Kubernetes cluster in the default configuration and with the release name `my-release`. The deployment configuration can be customized by specifying the customization parameters with the `helm install` command using the `--values` or `--set` arguments. Find more information in the [configuration section](#configuration) of this document.

## Upgrading

Upgrade the chart deployment using:

```bash
$ helm upgrade my-release cowboysysop/lighthouse-ci
```

The command upgrades the existing `my-release` deployment with the most latest release of the chart.

**TIP**: Use `helm repo update` to update information on available charts in the chart repositories.

### Upgrading to version 2.0.0

The chart is no more compatible with Helm 2.

Refer to the [Helm documentation](https://helm.sh/docs/topics/v2_v3_migration/) for more information.

## Uninstalling

Uninstall the `my-release` deployment using:

```bash
$ helm uninstall my-release
```

The command deletes the release named `my-release` and frees all the kubernetes resources associated with the release.

**TIP**: Specify the `--purge` argument to the above command to remove the release from the store and make its name free for later use.

## Configuration

The following tables lists all the configurable parameters expose by the chart and their default values.

### Common parameters

| Name                | Description                                                                                        | Default |
|---------------------|----------------------------------------------------------------------------------------------------|---------|
| `kubeVersion`       | Override Kubernetes version                                                                        | `""`    |
| `imagePullSecrets`  | Docker registry secret names as an array                                                           | `[]`    |
| `nameOverride`      | Partially override `lighthouse-ci.fullname` template with a string (will prepend the release name) | `nil`   |
| `fullnameOverride`  | Fully override `lighthouse-ci.fullname` template with a string                                     | `nil`   |
| `commonAnnotations` | Annotations to add to all deployed objects                                                         | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                              | `{}`    |

### Parameters

| Name                                 | Description                                                                                           | Default                                               |
|--------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------|
| `replicaCount`                       | Number of replicas                                                                                    | `1`                                                   |
| `image.repository`                   | Image name                                                                                            | `patrickhulce/lhci-server`                            |
| `image.tag`                          | Image tag                                                                                             | `0.6.0`                                               |
| `image.pullPolicy`                   | Image pull policy                                                                                     | `IfNotPresent`                                        |
| `pdb.create`                         | Specifies whether a pod disruption budget should be created                                           | `false`                                               |
| `pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                        | `1`                                                   |
| `pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                        | `nil`                                                 |
| `serviceAccount.create`              | Specify whether to create a ServiceAccount                                                            | `true`                                                |
| `serviceAccount.annotations`         | ServiceAccount annotations                                                                            | `{}`                                                  |
| `serviceAccount.name`                | The name of the ServiceAccount to create                                                              | Generated using the `lighthouse-ci.fullname` template |
| `podAnnotations`                     | Additional pod annotations                                                                            | `{}`                                                  |
| `podLabels`                          | Additional pod labels                                                                                 | `{}`                                                  |
| `podSecurityContext`                 | Pod security context                                                                                  | `{}`                                                  |
| `priorityClassName`                  | Priority class name                                                                                   | `nil`                                                 |
| `securityContext`                    | Container security context                                                                            | `{}`                                                  |
| `livenessProbe.enabled`              | Enable liveness probe                                                                                 | `true`                                                |
| `livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                          | `0`                                                   |
| `livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                               | `10`                                                  |
| `livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                     | `1`                                                   |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded    | `3`                                                   |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed  | `1`                                                   |
| `readinessProbe.enabled`             | Enable readiness probe                                                                                | `true`                                                |
| `readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                         | `0`                                                   |
| `readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                              | `10`                                                  |
| `readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                    | `1`                                                   |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded   | `3`                                                   |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed | `1`                                                   |
| `service.annotations`                | Service annotations                                                                                   | {}                                                    |
| `service.type`                       | Service type                                                                                          | `ClusterIP`                                           |
| `service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                 | `nil`                                                 |
| `service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                     | `nil`                                                 |
| `service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                            | `nil`                                                 |
| `service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                         | `Cluster`                                             |
| `service.port`                       | Service port                                                                                          | `9001`                                                |
| `service.nodePort`                   | Service node port when service type is LoadBalancer or NodePort                                       | `nil`                                                 |
| `ingress.enabled`                    | Enable ingress controller resource                                                                    | `false`                                               |
| `ingress.ingressClassName`           | IngressClass that will be be used to implement the Ingress                                            | `""`                                                  |
| `ingress.pathType`                   | Ingress path type                                                                                     | `ImplementationSpecific`                              |
| `ingress.annotations`                | Ingress annotations                                                                                   | `{}`                                                  |
| `ingress.hosts[0].host`              | Hostname to your Lighthouse CI Server installation                                                    | `lighthouse-ci.local`                                 |
| `ingress.hosts[0].paths`             | Paths within the url structure                                                                        | `[]`                                                  |
| `ingress.tls[0].secretName`          | TLS Secret (certificates)                                                                             | `nil`                                                 |
| `ingress.tls[0].hosts[0]`            | TLS hosts                                                                                             | `nil`                                                 |
| `resources`                          | CPU/Memory resource requests/limits                                                                   | `{}`                                                  |
| `nodeSelector`                       | Node labels for pod assignment                                                                        | `{}`                                                  |
| `tolerations`                        | Tolerations for pod assignment                                                                        | `[]`                                                  |
| `affinity`                           | Map of node/pod affinities                                                                            | `{}`                                                  |
| `extraEnvVars`                       | Additional container environment variables                                                            | `[]`                                                  |
| `extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                      | `nil`                                                 |
| `extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                         | `nil`                                                 |
| `persistence.enabled`                | Enable persistence using PVC                                                                          | `false`                                               |
| `persistence.existingClaim`          | Name of an existing PVC to use                                                                        | `nil`                                                 |
| `persistence.accessMode`             | PVC access mode                                                                                       | `ReadWriteOnce`                                       |
| `persistence.annotations`            | PVC annotations                                                                                       | `{}`                                                  |
| `persistence.size`                   | PVC size                                                                                              | `1Gi`                                                 |
| `persistence.storageClass`           | PVC storage class                                                                                     | `nil`                                                 |
| `logLevel`                           | Log level                                                                                             | `verbose`                                             |
| `basicAuthUsername`                  | The username to protect the server with HTTP Basic Authentication                                     | `nil`                                                 |
| `basicAuthPassword`                  | The password to protect the server with HTTP Basic Authentication                                     | `nil`                                                 |
| `existingSecret`                     | Name of existing Secret to use                                                                        | `nil`                                                 |
| `psiCollectCron.psiApiKey`           | The API key to use with the PageSpeed Insights API                                                    | `nil`                                                 |
| `psiCollectCron.sites`               | The array of sites to collect results for                                                             | `[]`                                                  |
| `deleteOldBuildsCron`                | The configuration to automatically delete old records                                                 | `[]`                                                  |
| `mariadb.enabled`                    | Whether to use the MariaDB chart                                                                      | `false`                                               |
| `mariadb.architecture`               | MariaDB architecture                                                                                  | `standalone`                                          |
| `mariadb.auth.database`              | MariaDB database                                                                                      | `lighthouse-ci`                                       |
| `mariadb.auth.username`              | MariaDB user                                                                                          | `lighthouse-ci`                                       |
| `mariadb.auth.password`              | MariaDB password                                                                                      | `lighthouse-ci`                                       |
| `mariadb.auth.existingSecret`        | Name of existing Secret to use                                                                        | `nil`                                                 |
| `mariadb.primary.service.port`       | MariaDB port                                                                                          | `3306`                                                |
| `externalMariadb.enabled`            | Whether to use an external MariaDB                                                                    | `false`                                               |
| `externalMariadb.host`               | External MariaDB host                                                                                 | `mariadb`                                             |
| `externalMariadb.port`               | External MariaDB port                                                                                 | `3306`                                                |
| `externalMariadb.username`           | External MariaDB user                                                                                 | `lighthouse-ci`                                       |
| `externalMariadb.password`           | External MariaDB password                                                                             | `lighthouse-ci`                                       |
| `externalMariadb.existingSecret`     | Name of existing Secret to use                                                                        | `nil`                                                 |
| `externalMariadb.database`           | External MariaDB database                                                                             | `lighthouse-ci`                                       |
| `postgresql.enabled`                 | Whether to use the PostgreSQL chart                                                                   | `false`                                               |
| `postgresql.postgresqlUsername`      | PostgreSQL user                                                                                       | `lighthouse-ci`                                       |
| `postgresql.postgresqlPassword`      | PostgreSQL password                                                                                   | `lighthouse-ci`                                       |
| `postgresql.existingSecret`          | Name of existing Secret to use                                                                        | `nil`                                                 |
| `postgresql.postgresqlDatabase`      | PostgreSQL database                                                                                   | `lighthouse-ci`                                       |
| `postgresql.service.port`            | PostgreSQL port                                                                                       | `5432`                                                |
| `externalPostgresql.enabled`         | Whether to use an external PostgreSQL                                                                 | `false`                                               |
| `externalPostgresql.host`            | External PostgreSQL host                                                                              | `postgresql`                                          |
| `externalPostgresql.port`            | External PostgreSQL port                                                                              | `5432`                                                |
| `externalPostgresql.username`        | External PostgreSQL user                                                                              | `lighthouse-ci`                                       |
| `externalPostgresql.password`        | External PostgreSQL password                                                                          | `lighthouse-ci`                                       |
| `externalPostgresql.existingSecret`  | Name of existing Secret to use                                                                        | `nil`                                                 |
| `externalPostgresql.database`        | External PostgreSQL database                                                                          | `lighthouse-ci`                                       |

Specify the parameters you which to customize using the `--set` argument to the `helm install` command. For instance,

```bash
$ helm install my-release \
    --set nameOverride=my-name cowboysysop/lighthouse-ci
```

The above command sets the `nameOverride` to `my-name`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release \
    --values values.yaml cowboysysop/lighthouse-ci
```

**Tip**: You can use the default [values.yaml](values.yaml).
