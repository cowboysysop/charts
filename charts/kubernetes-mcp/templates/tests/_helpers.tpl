{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "kubernetes-mcp.tests.fullname" -}}
{{- printf "%s-%s" (include "kubernetes-mcp.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "kubernetes-mcp.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Labels
*/}}
{{- define "kubernetes-mcp.tests.labels" -}}
{{ include "kubernetes-mcp.commonLabels" . }}
{{ include "kubernetes-mcp.tests.componentLabels" . }}
{{- end -}}
