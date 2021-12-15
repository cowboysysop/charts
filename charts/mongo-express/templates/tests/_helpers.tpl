{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "mongo-express.tests.fullname" -}}
{{- printf "%s-%s" (include "mongo-express.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "mongo-express.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "mongo-express.tests.labels" -}}
{{ include "mongo-express.labels" . }}
{{ include "mongo-express.tests.componentLabels" . }}
{{- end -}}
