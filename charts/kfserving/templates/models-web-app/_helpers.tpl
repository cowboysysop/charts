{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kfserving.modelsWebApp.fullname" -}}
{{- printf "%s-%s" (include "kfserving.fullname" .) "models-web-app" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kfserving.modelsWebApp.componentLabels" -}}
app.kubernetes.io/component: models-web-app
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kfserving.modelsWebApp.labels" -}}
{{ include "kfserving.labels" . }}
{{ include "kfserving.modelsWebApp.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kfserving.modelsWebApp.selectorLabels" -}}
{{ include "kfserving.selectorLabels" . }}
{{ include "kfserving.modelsWebApp.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kfserving.modelsWebApp.serviceAccountName" -}}
{{- if .Values.modelsWebApp.serviceAccount.create -}}
    {{ default (include "kfserving.modelsWebApp.fullname" .) .Values.modelsWebApp.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.modelsWebApp.serviceAccount.name }}
{{- end -}}
{{- end -}}
