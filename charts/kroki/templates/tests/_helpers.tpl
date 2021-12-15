{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kroki.tests.fullname" -}}
{{- printf "%s-%s" (include "kroki.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kroki.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kroki.tests.labels" -}}
{{ include "kroki.labels" . }}
{{ include "kroki.tests.componentLabels" . }}
{{- end -}}
