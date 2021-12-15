{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "quickchart.tests.fullname" -}}
{{- printf "%s-%s" (include "quickchart.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "quickchart.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "quickchart.tests.labels" -}}
{{ include "quickchart.labels" . }}
{{ include "quickchart.tests.componentLabels" . }}
{{- end -}}
