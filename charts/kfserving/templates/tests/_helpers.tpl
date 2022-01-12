{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kfserving.tests.fullname" -}}
{{- printf "%s-%s" (include "kfserving.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kfserving.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kfserving.tests.labels" -}}
{{ include "kfserving.labels" . }}
{{ include "kfserving.tests.componentLabels" . }}
{{- end -}}
