{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "grafana-mcp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "grafana-mcp.fullname" -}}
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
{{- define "grafana-mcp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "grafana-mcp.commonLabels" -}}
helm.sh/chart: {{ include "grafana-mcp.chart" . }}
{{ include "grafana-mcp.commonSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Common selector labels
*/}}
{{- define "grafana-mcp.commonSelectorLabels" -}}
app.kubernetes.io/name: {{ include "grafana-mcp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "grafana-mcp.componentLabels" -}}
app.kubernetes.io/component: grafana-mcp
{{- end -}}

{{/*
Labels
*/}}
{{- define "grafana-mcp.labels" -}}
{{ include "grafana-mcp.commonLabels" . }}
{{ include "grafana-mcp.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "grafana-mcp.selectorLabels" -}}
{{ include "grafana-mcp.commonSelectorLabels" . }}
{{ include "grafana-mcp.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "grafana-mcp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "grafana-mcp.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use
*/}}
{{- define "grafana-mcp.secretName" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecret }}
{{- else -}}
    {{ include "grafana-mcp.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains Grafana API key
*/}}
{{- define "grafana-mcp.secretKeyGrafanaApiKey" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecretKeyGrafanaApiKey }}
{{- else -}}
    grafana-api-key
{{- end -}}
{{- end -}}
