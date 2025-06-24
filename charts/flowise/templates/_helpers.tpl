{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "flowise.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "flowise.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "flowise.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "flowise.labels" -}}
helm.sh/chart: {{ include "flowise.chart" . }}
{{ include "flowise.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "flowise.selectorLabels" -}}
app.kubernetes.io/name: {{ include "flowise.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "flowise.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "flowise.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use
*/}}
{{- define "flowise.secretName" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecret }}
{{- else -}}
    {{ include "flowise.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains encryption key
*/}}
{{- define "flowise.secretKeyEncryptionKey" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecretKeyEncryptionKey }}
{{- else -}}
    encryption-key
{{- end -}}
{{- end -}}

{{/*
MariaDB fully qualified app name
*/}}
{{- define "flowise.mariadb.fullname" -}}
{{- if .Values.mariadb.fullnameOverride -}}
{{- .Values.mariadb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "mariadb" .Values.mariadb.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
MariaDB host
*/}}
{{- define "flowise.mariadb.host" -}}
{{- if .Values.mariadb.enabled -}}
{{- if eq .Values.mariadb.architecture "replication" -}}
    {{- if .Values.mariadb.fullnameOverride -}}
    {{- printf "%s-%s" .Values.mariadb.fullnameOverride "primary" | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
    {{- $name := default "mariadb" .Values.mariadb.nameOverride -}}
    {{- printf "%s-%s-%s" .Release.Name $name "primary" | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{ include "flowise.mariadb.fullname" . }}
{{- end -}}
{{- else -}}
    {{ .Values.externalMariadb.host }}
{{- end -}}
{{- end -}}

{{/*
MariaDB port
*/}}
{{- define "flowise.mariadb.port" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.primary.service.ports.mysql }}
{{- else -}}
    {{ .Values.externalMariadb.port }}
{{- end -}}
{{- end -}}

{{/*
MariaDB user
*/}}
{{- define "flowise.mariadb.username" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.auth.username }}
{{- else -}}
    {{ .Values.externalMariadb.username }}
{{- end -}}
{{- end -}}

{{/*
MariaDB secret name
*/}}
{{- define "flowise.mariadb.secretName" -}}
{{- if .Values.mariadb.auth.existingSecret -}}
    {{ .Values.mariadb.auth.existingSecret }}
{{- else if .Values.externalMariadb.existingSecret -}}
    {{ .Values.externalMariadb.existingSecret }}
{{- else -}}
    {{ include "flowise.mariadb.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains MariaDB password
*/}}
{{- define "flowise.mariadb.secretKeyPassword" -}}
{{- if .Values.externalMariadb.existingSecret -}}
    {{ .Values.externalMariadb.existingSecretKeyPassword }}
{{- else -}}
    mariadb-password
{{- end -}}
{{- end -}}

{{/*
MariaDB database
*/}}
{{- define "flowise.mariadb.database" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.auth.database }}
{{- else -}}
    {{ .Values.externalMariadb.database }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL fully qualified app name
*/}}
{{- define "flowise.postgresql.fullname" -}}
{{- if .Values.postgresql.fullnameOverride -}}
{{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL host
*/}}
{{- define "flowise.postgresql.host" -}}
{{- if .Values.postgresql.enabled -}}
{{- if eq .Values.postgresql.architecture "replication" -}}
    {{- if .Values.postgresql.fullnameOverride -}}
    {{- printf "%s-%s" .Values.postgresql.fullnameOverride "primary" | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
    {{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
    {{- printf "%s-%s-%s" .Release.Name $name "primary" | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{ include "flowise.postgresql.fullname" . }}
{{- end -}}
{{- else -}}
    {{ .Values.externalPostgresql.host }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL port
*/}}
{{- define "flowise.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.primary.service.ports.postgresql }}
{{- else -}}
    {{ .Values.externalPostgresql.port }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL user
*/}}
{{- define "flowise.postgresql.username" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.auth.username }}
{{- else -}}
    {{ .Values.externalPostgresql.username }}
{{- end -}}
{{- end -}}

{{/*
PostgreSQL secret name
*/}}
{{- define "flowise.postgresql.secretName" -}}
{{- if .Values.postgresql.auth.existingSecret -}}
    {{ .Values.postgresql.auth.existingSecret }}
{{- else if .Values.externalPostgresql.existingSecret -}}
    {{ .Values.externalPostgresql.existingSecret }}
{{- else -}}
    {{ include "flowise.postgresql.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains PostgreSQL password
*/}}
{{- define "flowise.postgresql.secretKeyPassword" -}}
{{- if .Values.externalPostgresql.existingSecret -}}
    {{ .Values.externalPostgresql.existingSecretKeyPassword }}
{{- else -}}
    password
{{- end -}}
{{- end -}}

{{/*
PostgreSQL database
*/}}
{{- define "flowise.postgresql.database" -}}
{{- if .Values.postgresql.enabled -}}
    {{ .Values.postgresql.auth.database }}
{{- else -}}
    {{ .Values.externalPostgresql.database }}
{{- end -}}
{{- end -}}

{{/*
Redis fully qualified app name
*/}}
{{- define "flowise.redis.fullname" -}}
{{- if .Values.redis.fullnameOverride -}}
{{- .Values.redis.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "redis" .Values.redis.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Redis host
*/}}
{{- define "flowise.redis.host" -}}
{{- if .Values.redis.enabled -}}
{{- if .Values.redis.fullnameOverride -}}
{{- printf "%s-%s" .Values.redis.fullnameOverride "master" | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "redis" .Values.redis.nameOverride -}}
{{- printf "%s-%s-%s" .Release.Name $name "master" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- else -}}
    {{ .Values.externalRedis.host }}
{{- end -}}
{{- end -}}

{{/*
Redis port
*/}}
{{- define "flowise.redis.port" -}}
{{- if .Values.redis.enabled -}}
    {{ .Values.redis.master.service.ports.redis }}
{{- else -}}
    {{ .Values.externalRedis.port }}
{{- end -}}
{{- end -}}

{{/*
Redis secret name
*/}}
{{- define "flowise.redis.secretName" -}}
{{- if .Values.redis.auth.existingSecret -}}
    {{ .Values.redis.auth.existingSecret }}
{{- else if .Values.externalRedis.existingSecret -}}
    {{ .Values.externalRedis.existingSecret }}
{{- else -}}
    {{ include "flowise.redis.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains Redis password
*/}}
{{- define "flowise.redis.secretKeyPassword" -}}
{{- if .Values.externalRedis.existingSecret -}}
    {{ .Values.externalRedis.existingSecretKeyPassword }}
{{- else -}}
    redis-password
{{- end -}}
{{- end -}}
