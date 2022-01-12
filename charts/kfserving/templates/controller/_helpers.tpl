{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kfserving.controller.fullname" -}}
{{- printf "%s-%s" (include "kfserving.fullname" .) "controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name.
*/}}
{{- define "kfserving.controller.metrics.fullname" -}}
{{- printf "%s-%s" (include "kfserving.controller.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kfserving.controller.componentLabels" -}}
app.kubernetes.io/component: controller
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kfserving.controller.labels" -}}
{{ include "kfserving.labels" . }}
{{ include "kfserving.controller.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "kfserving.controller.selectorLabels" -}}
{{ include "kfserving.selectorLabels" . }}
{{ include "kfserving.controller.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "kfserving.controller.serviceAccountName" -}}
{{- if .Values.controller.serviceAccount.create -}}
    {{ default (include "kfserving.controller.fullname" .) .Values.controller.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.controller.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the tls secret to use
*/}}
{{- define "kfserving.controller.tls.secretName" -}}
  {{- printf "%s-%s" (include "kfserving.controller.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
