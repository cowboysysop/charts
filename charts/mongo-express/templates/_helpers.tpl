{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "mongo-express.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mongo-express.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mongo-express.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "mongo-express.labels" -}}
helm.sh/chart: {{ include "mongo-express.chart" . }}
{{ include "mongo-express.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "mongo-express.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mongo-express.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "mongo-express.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "mongo-express.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the secret to use
*/}}
{{- define "mongo-express.secretName" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecret }}
{{- else -}}
    {{ include "mongo-express.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains administrator password
*/}}
{{- define "mongo-express.secretKeyMongodbAdminPassword" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecretKeyMongodbAdminPassword }}
{{- else -}}
    mongodb-admin-password
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains database password
*/}}
{{- define "mongo-express.secretKeyMongodbAuthPassword" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecretKeyMongodbAuthPassword }}
{{- else -}}
    mongodb-auth-password
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains string used by cookie-parser middleware to sign cookies
*/}}
{{- define "mongo-express.secretKeySiteCookieSecret" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecretKeySiteCookieSecret }}
{{- else -}}
    site-cookie-secret
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains string used to sign the session ID cookie by express-session middleware
*/}}
{{- define "mongo-express.secretKeySiteSessionSecret" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecretKeySiteSessionSecret }}
{{- else -}}
    site-session-secret
{{- end -}}
{{- end -}}

{{/*
Key in Secret that contains Mongo Express web login password
*/}}
{{- define "mongo-express.secretKeyBasicAuthPassword" -}}
{{- if .Values.existingSecret -}}
    {{ .Values.existingSecretKeyBasicAuthPassword }}
{{- else -}}
    basic-auth-password
{{- end -}}
{{- end -}}

{{/*
Create the basic authentification HTTP header
*/}}
{{- define "mongo-express.basicAuthHttpHeader" -}}
Basic {{ printf "%s:%s" .Values.basicAuthUsername .Values.basicAuthPassword | b64enc }}
{{- end -}}
