{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "vertical-pod-autoscaler.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vertical-pod-autoscaler.fullname" -}}
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
Create a default fully qualified app name (admission controller component).
*/}}
{{- define "vertical-pod-autoscaler.admissionController.fullname" -}}
{{- printf "%s-%s" (include "vertical-pod-autoscaler.fullname" .) "admission-controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (admission controller component).
*/}}
{{- define "vertical-pod-autoscaler.admissionController.metrics.fullname" -}}
{{- printf "%s-%s" (include "vertical-pod-autoscaler.admissionController.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name (recommender component).
*/}}
{{- define "vertical-pod-autoscaler.recommender.fullname" -}}
{{- printf "%s-%s" (include "vertical-pod-autoscaler.fullname" .) "recommender" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (recommender component).
*/}}
{{- define "vertical-pod-autoscaler.recommender.metrics.fullname" -}}
{{- printf "%s-%s" (include "vertical-pod-autoscaler.recommender.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name (updater component).
*/}}
{{- define "vertical-pod-autoscaler.updater.fullname" -}}
{{- printf "%s-%s" (include "vertical-pod-autoscaler.fullname" .) "updater" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name (updater component).
*/}}
{{- define "vertical-pod-autoscaler.updater.metrics.fullname" -}}
{{- printf "%s-%s" (include "vertical-pod-autoscaler.updater.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "vertical-pod-autoscaler.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels (admission controller component)
*/}}
{{- define "vertical-pod-autoscaler.admissionController.componentLabels" -}}
app.kubernetes.io/component: admission-controller
{{- end -}}

{{/*
Component labels (recommender component)
*/}}
{{- define "vertical-pod-autoscaler.recommender.componentLabels" -}}
app.kubernetes.io/component: recommender
{{- end -}}

{{/*
Component labels (updater component)
*/}}
{{- define "vertical-pod-autoscaler.updater.componentLabels" -}}
app.kubernetes.io/component: updater
{{- end -}}

{{/*
Common labels
*/}}
{{- define "vertical-pod-autoscaler.labels" -}}
helm.sh/chart: {{ include "vertical-pod-autoscaler.chart" . }}
{{ include "vertical-pod-autoscaler.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Common labels (admission controller component)
*/}}
{{- define "vertical-pod-autoscaler.admissionController.labels" -}}
{{ include "vertical-pod-autoscaler.labels" . }}
{{ include "vertical-pod-autoscaler.admissionController.componentLabels" . }}
{{- end -}}

{{/*
Common labels (recommender component)
*/}}
{{- define "vertical-pod-autoscaler.recommender.labels" -}}
{{ include "vertical-pod-autoscaler.labels" . }}
{{ include "vertical-pod-autoscaler.recommender.componentLabels" . }}
{{- end -}}

{{/*
Common labels (updater component)
*/}}
{{- define "vertical-pod-autoscaler.updater.labels" -}}
{{ include "vertical-pod-autoscaler.labels" . }}
{{ include "vertical-pod-autoscaler.updater.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "vertical-pod-autoscaler.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vertical-pod-autoscaler.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels (admission controller component)
*/}}
{{- define "vertical-pod-autoscaler.admissionController.selectorLabels" -}}
{{ include "vertical-pod-autoscaler.selectorLabels" . }}
{{ include "vertical-pod-autoscaler.admissionController.componentLabels" . }}
{{- end -}}

{{/*
Selector labels (recommender component)
*/}}
{{- define "vertical-pod-autoscaler.recommender.selectorLabels" -}}
{{ include "vertical-pod-autoscaler.selectorLabels" . }}
{{ include "vertical-pod-autoscaler.recommender.componentLabels" . }}
{{- end -}}

{{/*
Selector labels (updater component)
*/}}
{{- define "vertical-pod-autoscaler.updater.selectorLabels" -}}
{{ include "vertical-pod-autoscaler.selectorLabels" . }}
{{ include "vertical-pod-autoscaler.updater.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "vertical-pod-autoscaler.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "vertical-pod-autoscaler.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (admission controller component)
*/}}
{{- define "vertical-pod-autoscaler.admissionController.serviceAccountName" -}}
{{- if .Values.admissionController.serviceAccount.create -}}
    {{ default (include "vertical-pod-autoscaler.admissionController.fullname" .) .Values.admissionController.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.admissionController.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (recommender component)
*/}}
{{- define "vertical-pod-autoscaler.recommender.serviceAccountName" -}}
{{- if .Values.recommender.serviceAccount.create -}}
    {{ default (include "vertical-pod-autoscaler.recommender.fullname" .) .Values.recommender.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.recommender.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (updater component)
*/}}
{{- define "vertical-pod-autoscaler.updater.serviceAccountName" -}}
{{- if .Values.updater.serviceAccount.create -}}
    {{ default (include "vertical-pod-autoscaler.updater.fullname" .) .Values.updater.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.updater.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the tls secret to use (admission controller component)
*/}}
{{- define "vertical-pod-autoscaler.admissionController.tls.secretName" -}}
{{- if .Values.admissionController.tls.existingSecret -}}
    {{ .Values.admissionController.tls.existingSecret }}
{{- else -}}
    {{- printf "%s-%s" (include "vertical-pod-autoscaler.admissionController.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
