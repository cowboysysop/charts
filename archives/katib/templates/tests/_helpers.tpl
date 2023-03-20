{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "katib.tests.fullname" -}}
{{- printf "%s-%s" (include "katib.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "katib.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "katib.tests.labels" -}}
{{ include "katib.labels" . }}
{{ include "katib.tests.componentLabels" . }}
{{- end -}}
