{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubeview.tests.fullname" -}}
{{- printf "%s-%s" (include "kubeview.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubeview.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Labels
*/}}
{{- define "kubeview.tests.labels" -}}
{{ include "kubeview.commonLabels" . }}
{{ include "kubeview.tests.componentLabels" . }}
{{- end -}}
