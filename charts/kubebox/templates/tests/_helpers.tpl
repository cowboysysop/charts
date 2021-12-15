{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubebox.tests.fullname" -}}
{{- printf "%s-%s" (include "kubebox.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubebox.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kubebox.tests.labels" -}}
{{ include "kubebox.labels" . }}
{{ include "kubebox.tests.componentLabels" . }}
{{- end -}}
