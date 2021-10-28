{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "katib.ui.fullname" -}}
{{- printf "%s-%s" (include "katib.fullname" .) "ui" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "katib.ui.componentLabels" -}}
app.kubernetes.io/component: ui
{{- end -}}

{{/*
Common labels
*/}}
{{- define "katib.ui.labels" -}}
{{ include "katib.labels" . }}
{{ include "katib.ui.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "katib.ui.selectorLabels" -}}
{{ include "katib.selectorLabels" . }}
{{ include "katib.ui.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "katib.ui.serviceAccountName" -}}
{{- if .Values.ui.serviceAccount.create -}}
    {{ default (include "katib.ui.fullname" .) .Values.ui.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.ui.serviceAccount.name }}
{{- end -}}
{{- end -}}
