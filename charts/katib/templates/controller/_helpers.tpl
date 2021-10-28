{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "katib.controller.fullname" -}}
{{- printf "%s-%s" (include "katib.fullname" .) "controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified metrics name.
*/}}
{{- define "katib.controller.metrics.fullname" -}}
{{- printf "%s-%s" (include "katib.controller.fullname" .) "metrics" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "katib.controller.componentLabels" -}}
app.kubernetes.io/component: controller
{{- end -}}

{{/*
Common labels
*/}}
{{- define "katib.controller.labels" -}}
{{ include "katib.labels" . }}
{{ include "katib.controller.componentLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "katib.controller.selectorLabels" -}}
{{ include "katib.selectorLabels" . }}
{{ include "katib.controller.componentLabels" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "katib.controller.serviceAccountName" -}}
{{- if .Values.controller.serviceAccount.create -}}
    {{ default (include "katib.controller.fullname" .) .Values.controller.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.controller.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the tls secret to use
*/}}
{{- define "katib.controller.tls.secretName" -}}
  {{- printf "%s-%s" (include "katib.controller.fullname" .) "tls" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
