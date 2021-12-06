{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "lighthouse-ci.tests.fullname" -}}
{{- printf "%s-%s" (include "lighthouse-ci.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "lighthouse-ci.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "lighthouse-ci.tests.labels" -}}
{{ include "lighthouse-ci.labels" . }}
{{ include "lighthouse-ci.tests.componentLabels" . }}
{{- end -}}
