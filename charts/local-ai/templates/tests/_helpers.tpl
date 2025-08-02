{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "local-ai.tests.fullname" -}}
{{- printf "%s-%s" (include "local-ai.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "local-ai.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Labels
*/}}
{{- define "local-ai.tests.labels" -}}
{{ include "local-ai.commonLabels" . }}
{{ include "local-ai.tests.componentLabels" . }}
{{- end -}}
