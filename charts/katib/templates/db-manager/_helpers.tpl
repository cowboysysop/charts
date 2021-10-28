{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "katib.dbManager.fullname" -}}
{{- printf "%s-%s" (include "katib.fullname" .) "db-manager" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "katib.dbManager.componentLabels" -}}
app.kubernetes.io/component: db-manager
{{- end -}}

{{/*
Common labels
*/}}
{{- define "katib.dbManager.labels" -}}
{{ include "katib.labels" . }}
{{ include "katib.dbManager.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "katib.dbManager.selectorLabels" -}}
{{ include "katib.selectorLabels" . }}
{{ include "katib.dbManager.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "katib.dbManager.serviceAccountName" -}}
{{- if .Values.dbManager.serviceAccount.create -}}
    {{ default (include "katib.dbManager.fullname" .) .Values.dbManager.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.dbManager.serviceAccount.name }}
{{- end -}}
{{- end -}}
