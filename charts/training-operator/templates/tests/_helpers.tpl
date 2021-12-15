{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "training-operator.tests.fullname" -}}
{{- printf "%s-%s" (include "training-operator.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "training-operator.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "training-operator.tests.labels" -}}
{{ include "training-operator.labels" . }}
{{ include "training-operator.tests.componentLabels" . }}
{{- end -}}
