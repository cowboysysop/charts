{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "metacontroller.tests.fullname" -}}
{{- printf "%s-%s" (include "metacontroller.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "metacontroller.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "metacontroller.tests.labels" -}}
{{ include "metacontroller.labels" . }}
{{ include "metacontroller.tests.componentLabels" . }}
{{- end -}}
