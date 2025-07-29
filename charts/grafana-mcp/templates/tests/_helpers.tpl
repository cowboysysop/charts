{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
*/}}
{{- define "grafana-mcp.tests.fullname" -}}
{{- printf "%s-%s" (include "grafana-mcp.fullname" .) "tests" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component labels
*/}}
{{- define "grafana-mcp.tests.componentLabels" -}}
app.kubernetes.io/component: tests
{{- end -}}

{{/*
Labels
*/}}
{{- define "grafana-mcp.tests.labels" -}}
{{ include "grafana-mcp.commonLabels" . }}
{{ include "grafana-mcp.tests.componentLabels" . }}
{{- end -}}
