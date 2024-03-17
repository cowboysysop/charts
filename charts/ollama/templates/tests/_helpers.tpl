{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "ollama.tests.fullname" -}}
{{- printf "%s-%s" (include "ollama.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "ollama.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "ollama.tests.labels" -}}
{{ include "ollama.labels" . }}
{{ include "ollama.tests.componentLabels" . }}
{{- end -}}
