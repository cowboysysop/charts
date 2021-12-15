{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "whoami.tests.fullname" -}}
{{- printf "%s-%s" (include "whoami.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "whoami.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "whoami.tests.labels" -}}
{{ include "whoami.labels" . }}
{{ include "whoami.tests.componentLabels" . }}
{{- end -}}
