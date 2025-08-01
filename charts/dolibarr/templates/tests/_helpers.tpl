{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "dolibarr.tests.fullname" -}}
{{- printf "%s-%s" (include "dolibarr.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "dolibarr.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Labels
*/}}
{{- define "dolibarr.tests.labels" -}}
{{ include "dolibarr.commonLabels" . }}
{{ include "dolibarr.tests.componentLabels" . }}
{{- end -}}
