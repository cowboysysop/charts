{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kfserving.crds.fullname" -}}
{{- printf "%s-%s" (include "kfserving.fullname" .) "crds" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kfserving.crds.componentLabels" -}}
app.kubernetes.io/component: crds
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kfserving.crds.labels" -}}
{{ include "kfserving.labels" . }}
{{ include "kfserving.crds.componentLabels" . }}
{{- end -}}
