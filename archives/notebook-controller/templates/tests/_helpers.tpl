{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "notebook-controller.tests.fullname" -}}
{{- printf "%s-%s" (include "notebook-controller.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "notebook-controller.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "notebook-controller.tests.labels" -}}
{{ include "notebook-controller.labels" . }}
{{ include "notebook-controller.tests.componentLabels" . }}
{{- end -}}
