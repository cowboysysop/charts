{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "dolibarr.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dolibarr.fullname" -}}
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
{{- define "dolibarr.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "dolibarr.labels" -}}
helm.sh/chart: {{ include "dolibarr.chart" . }}
{{ include "dolibarr.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "dolibarr.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dolibarr.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "dolibarr.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "dolibarr.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use
*/}}
{{- define "dolibarr.secretName" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecret }}
{{- else -}}
    {{ include "dolibarr.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains administrator password
*/}}
{{- define "dolibarr.secretKeyAdminPassword" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecretKeyAdminPassword }}
{{- else -}}
    dolibarr-admin-password
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains cron security key
*/}}
{{- define "dolibarr.secretKeyCronSecurityKey" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecretKeyCronSecurityKey }}
{{- else -}}
    dolibarr-cron-security-key
{{- end -}}
{{- end -}}

{{/*
Database fully qualified app name
*/}}
{{- define "dolibarr.database.fullname" -}}
{{- if .Values.mariadb.fullnameOverride -}}
{{- .Values.mariadb.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "mariadb" .Values.mariadb.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{/*
Database host
*/}}
{{- define "dolibarr.database.host" -}}
{{- if .Values.mariadb.enabled -}}
{{- if eq .Values.mariadb.architecture "replication" -}}
    {{- if .Values.mariadb.fullnameOverride -}}
    {{- printf "%s-%s" .Values.mariadb.fullnameOverride "primary" | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
    {{- $name := default "mariadb" .Values.mariadb.nameOverride -}}
    {{- printf "%s-%s-%s" .Release.Name $name "primary" | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
{{- else -}}
    {{ include "dolibarr.database.fullname" . }}
{{- end -}}
{{- else -}}
    {{ .Values.externalDatabase.host }}
{{- end -}}
{{- end -}}


{{/*
Database port
*/}}
{{- define "dolibarr.database.port" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.primary.service.ports.mysql }}
{{- else -}}
    {{ .Values.externalDatabase.port }}
{{- end -}}
{{- end -}}

{{/*
Database user
*/}}
{{- define "dolibarr.database.username" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.auth.username }}
{{- else -}}
    {{ .Values.externalDatabase.username }}
{{- end -}}
{{- end -}}

{{/*
Database secret name
*/}}
{{- define "dolibarr.database.secretName" -}}
{{- if .Values.mariadb.enabled -}}
{{- if .Values.mariadb.auth.existingSecret -}}
    {{ .Values.mariadb.auth.existingSecret }}
{{- else -}}
    {{ include "dolibarr.database.fullname" . }}
{{- end -}}
{{- else -}}
    {{ .Values.externalDatabase.existingSecret }}
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains MariaDB password
*/}}
{{- define "dolibarr.database.secretKeyPassword" -}}
{{- if .Values.externalDatabase.existingSecret -}}
    {{ .Values.externalDatabase.existingSecretKeyPassword }}
{{- else -}}
    mariadb-password
{{- end -}}
{{- end -}}

{{/*
MariaDB database
*/}}
{{- define "dolibarr.database.name" -}}
{{- if .Values.mariadb.enabled -}}
    {{ .Values.mariadb.auth.database }}
{{- else -}}
    {{ .Values.externalDatabase.name }}
{{- end -}}
{{- end -}}

{{/*
External DB type
*/}}
{{- define "dolibarr.database.type" -}}
{{- if .Values.mariadb.enabled -}}
  mysqli
{{- else -}}
  {{ .Values.externalDatabase.type }}
{{- end -}}
{{- end -}}

