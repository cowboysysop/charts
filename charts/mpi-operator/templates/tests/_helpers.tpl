{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "mpi-operator.tests.fullname" -}}
{{- printf "%s-%s" (include "mpi-operator.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "mpi-operator.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "mpi-operator.tests.labels" -}}
{{ include "mpi-operator.labels" . }}
{{ include "mpi-operator.tests.componentLabels" . }}
{{- end -}}
