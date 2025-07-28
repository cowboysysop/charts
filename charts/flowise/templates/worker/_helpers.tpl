{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "flowise.worker.fullname" -}}
{{- printf "%s-%s" (include "flowise.fullname" .) "worker" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "flowise.worker.componentLabels" -}}
app.kubernetes.io/component: worker
{{- end -}}

{{/*
Labels
*/}}
{{- define "flowise.worker.labels" -}}
{{ include "flowise.commonLabels" . }}
{{ include "flowise.worker.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "flowise.worker.selectorLabels" -}}
{{ include "flowise.commonSelectorLabels" . }}
{{ include "flowise.worker.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "flowise.worker.serviceAccountName" -}}
{{- if .Values.worker.serviceAccount.create -}}
    {{ default (include "flowise.worker.fullname" .) .Values.worker.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.worker.serviceAccount.name }}
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
