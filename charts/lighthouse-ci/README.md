# Lighthouse CI Server

[Lighthouse CI Server](https://github.com/GoogleChrome/lighthouse-ci) enables running a server to display Lighthouse CI results.

**DISCLAIMER**: This is an unofficial chart not supported by Lighthouse CI Server authors.

## TL;DR;

```bash
$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/lighthouse-ci
```

## Introduction

This chart bootstraps a Lighthouse CI Server deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes >= 1.19
- Helm >= 3.1

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

### Upgrading to version 6.0.0

Some parameters related to port management have been modified:

- Parameter `service.port` has been renamed `service.ports.http`.
- Parameter `service.nodePort` has been renamed `service.nodePorts.http`.

### Upgrading to version 5.0.0

Some parameters related to image management have been modified:

- Registry prefix in `image.repository` parameters is now configured in `image.registry`.
- Parameter `imagePullSecrets` has been renamed `global.imagePullSecrets`.

### Upgrading to version 4.0.0

The PostgreSQL subchart has been updated to a major release, see these upgrade instructions:

- https://github.com/bitnami/charts/tree/main/bitnami/postgresql#to-1200
- https://docs.bitnami.com/kubernetes/infrastructure/postgresql/administration/upgrade/#to-1100

### Upgrading to version 3.0.0

The MariaDB subchart has been updated to a major release, see these upgrade instructions:

- https://github.com/bitnami/charts/tree/master/bitnami/mariadb#to-1100
- https://github.com/bitnami/charts/tree/master/bitnami/mariadb#to-1000

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

### Global parameters

| Name                      | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Common parameters

| Name                | Description                                                                                        | Default |
| ------------------- | -------------------------------------------------------------------------------------------------- | ------- |
| `kubeVersion`       | Override Kubernetes version                                                                        | `""`    |
| `nameOverride`      | Partially override `lighthouse-ci.fullname` template with a string (will prepend the release name) | `""`    |
| `fullnameOverride`  | Fully override `lighthouse-ci.fullname` template with a string                                     | `""`    |
| `commonAnnotations` | Annotations to add to all deployed objects                                                         | `{}`    |
| `commonLabels`      | Labels to add to all deployed objects                                                              | `{}`    |
| `extraDeploy`       | Array of extra objects to deploy with the release                                                  | `[]`    |

### Parameters

| Name                                 | Description                                                                                               | Default                    |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------- | -------------------------- |
| `replicaCount`                       | Number of replicas (do not change it)                                                                     | `1`                        |
| `updateStrategy.type`                | Update strategy type (do not change it)                                                                   | `Recreate`                 |
| `image.registry`                     | Image registry                                                                                            | `docker.io`                |
| `image.repository`                   | Image repository                                                                                          | `patrickhulce/lhci-server` |
| `image.tag`                          | Image tag                                                                                                 | `0.8.1`                    |
| `image.digest`                       | Image digest                                                                                              | `""`                       |
| `image.pullPolicy`                   | Image pull policy                                                                                         | `IfNotPresent`             |
| `pdb.create`                         | Specifies whether a pod disruption budget should be created                                               | `false`                    |
| `pdb.minAvailable`                   | Minimum number/percentage of pods that should remain scheduled                                            | `1`                        |
| `pdb.maxUnavailable`                 | Maximum number/percentage of pods that may be made unavailable                                            | `nil`                      |
| `serviceAccount.create`              | Specifies whether a service account should be created                                                     | `true`                     |
| `serviceAccount.annotations`         | Service account annotations                                                                               | `{}`                       |
| `serviceAccount.name`                | The name of the service account to use (Generated using the `lighthouse-ci.fullname` template if not set) | `nil`                      |
| `podAnnotations`                     | Additional pod annotations                                                                                | `{}`                       |
| `podLabels`                          | Additional pod labels                                                                                     | `{}`                       |
| `podSecurityContext`                 | Pod security context                                                                                      | `{}`                       |
| `priorityClassName`                  | Priority class name                                                                                       | `nil`                      |
| `securityContext`                    | Container security context                                                                                | `{}`                       |
| `containerPorts.http`                | Container port for HTTP                                                                                   | `9001`                     |
| `livenessProbe.enabled`              | Enable liveness probe                                                                                     | `true`                     |
| `livenessProbe.initialDelaySeconds`  | Delay before the liveness probe is initiated                                                              | `0`                        |
| `livenessProbe.periodSeconds`        | How often to perform the liveness probe                                                                   | `10`                       |
| `livenessProbe.timeoutSeconds`       | When the liveness probe times out                                                                         | `1`                        |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the liveness probe to be considered failed after having succeeded        | `3`                        |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the liveness probe to be considered successful after having failed      | `1`                        |
| `readinessProbe.enabled`             | Enable readiness probe                                                                                    | `true`                     |
| `readinessProbe.initialDelaySeconds` | Delay before the readiness probe is initiated                                                             | `0`                        |
| `readinessProbe.periodSeconds`       | How often to perform the readiness probe                                                                  | `10`                       |
| `readinessProbe.timeoutSeconds`      | When the readiness probe times out                                                                        | `1`                        |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the readiness probe to be considered failed after having succeeded       | `3`                        |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the readiness probe to be considered successful after having failed     | `1`                        |
| `startupProbe.enabled`               | Enable startup probe                                                                                      | `false`                    |
| `startupProbe.initialDelaySeconds`   | Delay before the startup probe is initiated                                                               | `0`                        |
| `startupProbe.periodSeconds`         | How often to perform the startup probe                                                                    | `10`                       |
| `startupProbe.timeoutSeconds`        | When the startup probe times out                                                                          | `1`                        |
| `startupProbe.failureThreshold`      | Minimum consecutive failures for the startup probe to be considered failed after having succeeded         | `3`                        |
| `startupProbe.successThreshold`      | Minimum consecutive successes for the startup probe to be considered successful after having failed       | `1`                        |
| `service.annotations`                | Service annotations                                                                                       | `{}`                       |
| `service.type`                       | Service type                                                                                              | `ClusterIP`                |
| `service.clusterIP`                  | Static cluster IP address or None for headless service when service type is ClusterIP                     | `nil`                      |
| `service.loadBalancerIP`             | Static load balancer IP address when service type is LoadBalancer                                         | `nil`                      |
| `service.loadBalancerSourceRanges`   | Source IP address ranges when service type is LoadBalancer                                                | `nil`                      |
| `service.externalTrafficPolicy`      | External traffic routing policy when service type is LoadBalancer or NodePort                             | `Cluster`                  |
| `service.ports.http`                 | Service port for HTTP                                                                                     | `9001`                     |
| `service.nodePorts.http`             | Service node port for HTTP when service type is LoadBalancer or NodePort                                  | `nil`                      |
| `ingress.enabled`                    | Enable ingress controller resource                                                                        | `false`                    |
| `ingress.ingressClassName`           | IngressClass that will be be used to implement the Ingress                                                | `""`                       |
| `ingress.pathType`                   | Ingress path type                                                                                         | `ImplementationSpecific`   |
| `ingress.annotations`                | Ingress annotations                                                                                       | `{}`                       |
| `ingress.hosts[0].host`              | Hostname to your Lighthouse CI Server installation                                                        | `lighthouse-ci.local`      |
| `ingress.hosts[0].paths`             | Paths within the url structure                                                                            | `["/"]`                    |
| `ingress.tls`                        | TLS configuration                                                                                         | `[]`                       |
| `resources`                          | CPU/Memory resource requests/limits                                                                       | `{}`                       |
| `nodeSelector`                       | Node labels for pod assignment                                                                            | `{}`                       |
| `tolerations`                        | Tolerations for pod assignment                                                                            | `[]`                       |
| `affinity`                           | Map of node/pod affinities                                                                                | `{}`                       |
| `extraArgs`                          | Additional container arguments                                                                            | `{}`                       |
| `extraEnvVars`                       | Additional container environment variables                                                                | `[]`                       |
| `extraEnvVarsCM`                     | Name of existing ConfigMap containing additional container environment variables                          | `nil`                      |
| `extraEnvVarsSecret`                 | Name of existing Secret containing additional container environment variables                             | `nil`                      |
| `persistence.enabled`                | Enable persistence using PVC                                                                              | `false`                    |
| `persistence.existingClaim`          | Name of an existing PVC to use                                                                            | `nil`                      |
| `persistence.accessMode`             | PVC access mode                                                                                           | `ReadWriteOnce`            |
| `persistence.annotations`            | PVC annotations                                                                                           | `{}`                       |
| `persistence.size`                   | PVC size                                                                                                  | `1Gi`                      |
| `persistence.storageClass`           | PVC storage class                                                                                         | `nil`                      |
| `logLevel`                           | Log level                                                                                                 | `verbose`                  |
| `basicAuthUsername`                  | The username to protect the server with HTTP Basic Authentication                                         | `""`                       |
| `basicAuthPassword`                  | The password to protect the server with HTTP Basic Authentication                                         | `""`                       |
| `psiCollectCron`                     | The configuration to automatically collect results using the PageSpeed Insights API                       |                            |
| `psiCollectCron.psiApiKey`           | The API key to use with the PageSpeed Insights API                                                        | `""`                       |
| `psiCollectCron.sites`               | The array of sites to collect results for                                                                 | `[]`                       |
| `deleteOldBuildsCron`                | The configuration to automatically delete old records                                                     | `[]`                       |
| `existingSecret`                     | Name of existing Secret to use                                                                            | `""`                       |
| `existingSecretKeyBasicAuthPassword` | Name of the key in existing Secret that contains HTTP Basic Authentication password                       | `basic-auth-password`      |

### MariaDB parameters

| Name                                        | Description                                                       | Default            |
| ------------------------------------------- | ----------------------------------------------------------------- | ------------------ |
| `mariadb.enabled`                           | Whether to use the MariaDB chart                                  | `false`            |
| `mariadb.architecture`                      | MariaDB architecture                                              | `standalone`       |
| `mariadb.auth.database`                     | MariaDB database                                                  | `lighthouse-ci`    |
| `mariadb.auth.username`                     | MariaDB user                                                      | `lighthouse-ci`    |
| `mariadb.auth.password`                     | MariaDB password                                                  | `lighthouse-ci`    |
| `mariadb.auth.existingSecret`               | Name of existing Secret to use                                    | `""`               |
| `mariadb.primary.service.ports.mysql`       | MariaDB port                                                      | `3306`             |
| `externalMariadb.enabled`                   | Whether to use an external MariaDB                                | `false`            |
| `externalMariadb.host`                      | External MariaDB host                                             | `mariadb`          |
| `externalMariadb.port`                      | External MariaDB port                                             | `3306`             |
| `externalMariadb.username`                  | External MariaDB user                                             | `lighthouse-ci`    |
| `externalMariadb.password`                  | External MariaDB password                                         | `lighthouse-ci`    |
| `externalMariadb.existingSecret`            | Name of existing Secret to use                                    | `""`               |
| `externalMariadb.existingSecretKeyPassword` | Name of the key in existing Secret that contains MariaDB password | `mariadb-password` |
| `externalMariadb.database`                  | External MariaDB database                                         | `lighthouse-ci`    |

### PostgreSQL parameters

| Name                                           | Description                                                          | Default         |
| ---------------------------------------------- | -------------------------------------------------------------------- | --------------- |
| `postgresql.enabled`                           | Whether to use the PostgreSQL chart                                  | `false`         |
| `postgresql.auth.username`                     | PostgreSQL user                                                      | `lighthouse-ci` |
| `postgresql.auth.password`                     | PostgreSQL password                                                  | `lighthouse-ci` |
| `postgresql.auth.database`                     | PostgreSQL database                                                  | `lighthouse-ci` |
| `postgresql.auth.existingSecret`               | Name of existing Secret to use                                       | `""`            |
| `postgresql.architecture`                      | PostgreSQL architecture                                              | `standalone`    |
| `postgresql.primary.service.ports.postgresql`  | PostgreSQL port                                                      | `5432`          |
| `externalPostgresql.enabled`                   | Whether to use an external PostgreSQL                                | `false`         |
| `externalPostgresql.host`                      | External PostgreSQL host                                             | `postgresql`    |
| `externalPostgresql.port`                      | External PostgreSQL port                                             | `5432`          |
| `externalPostgresql.username`                  | External PostgreSQL user                                             | `lighthouse-ci` |
| `externalPostgresql.password`                  | External PostgreSQL password                                         | `lighthouse-ci` |
| `externalPostgresql.existingSecret`            | Name of existing Secret to use                                       | `""`            |
| `externalPostgresql.existingSecretKeyPassword` | Name of the key in existing Secret that contains PostgreSQL password | `password`      |
| `externalPostgresql.database`                  | External PostgreSQL database                                         | `lighthouse-ci` |

### Tests parameters

| Name                     | Description       | Default              |
| ------------------------ | ----------------- | -------------------- |
| `tests.image.registry`   | Image registry    | `ghcr.io`            |
| `tests.image.repository` | Image repository  | `cowboysysop/pytest` |
| `tests.image.tag`        | Image tag         | `1.0.35`             |
| `tests.image.digest`     | Image digest      | `""`                 |
| `tests.image.pullPolicy` | Image pull policy | `IfNotPresent`       |

## Setting parameters

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

**TIP**: You can use the default [values.yaml](values.yaml).
