{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "qdrant.tests.fullname" -}}
{{- printf "%s-%s" (include "qdrant.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "qdrant.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "qdrant.tests.labels" -}}
{{ include "qdrant.labels" . }}
{{ include "qdrant.tests.componentLabels" . }}
{{- end -}}
