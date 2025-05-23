{{- define "gateway.name" -}}
{{- .Values.gateway.name | default "higress-gateway" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gateway.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "gateway.labels" -}}
helm.sh/chart: {{ include "gateway.chart" . }}
{{ include "gateway.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "gateway.name" . }}
{{- range $key, $val := .Values.gateway.labels }}
{{- if not (or (eq $key "app") (eq $key "higress")) }}
{{ $key | quote }}: {{ $val | quote }}
{{- end }}
{{- end }}
{{- end }}

{{- define "gateway.selectorLabels" -}}
{{- if hasKey .Values.gateway.labels "app" }}
{{- with .Values.gateway.labels.app }}app: {{.|quote}}
{{- end}}
{{- else }}app: {{ include "gateway.name" . }}
{{- end }}
{{- if hasKey .Values.gateway.labels "higress" }}
{{- with .Values.gateway.labels.higress }}
higress: {{.|quote}}
{{- end}}
{{- else }}
higress: {{ .Release.Namespace }}-{{ include "gateway.name" . }}
{{- end }}
{{- end }}

{{- define "gateway.serviceAccountName" -}}
{{- if .Values.gateway.serviceAccount.create }}
{{- .Values.gateway.serviceAccount.name | default (include "gateway.name" .)    }}
{{- else }}
{{- .Values.gateway.serviceAccount.name | default "default" }}
{{- end }}
{{- end }}

{{- define "controller.name" -}}
{{- .Values.controller.name | default "higress-controller" -}}
{{- end }}

{{- define "controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "controller.labels" -}}
helm.sh/chart: {{ include "controller.chart" . }}
{{ include "controller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "controller.name" . }}
{{- end }}

{{- define "controller.selectorLabels" -}}
{{- if hasKey .Values.controller.labels "app" }}
{{- with .Values.controller.labels.app }}app: {{.|quote}}
{{- end}}
{{- else }}app: {{ include "controller.name" . }}
{{- end }}
{{- if hasKey .Values.controller.labels "higress" }}
{{- with .Values.controller.labels.higress }}
higress: {{.|quote}}
{{- end}}
{{- else }}
higress: {{ include "controller.name" . }}
{{- end }}
{{- end }}

{{- define "controller.serviceAccountName" -}}
{{- if .Values.controller.serviceAccount.create }}
{{- .Values.controller.serviceAccount.name | default (include "controller.name" .)    }}
{{- else }}
{{- .Values.controller.serviceAccount.name | default "default" }}
{{- end }}
{{- end }}

{{- define "controller.jwtPolicy" -}}
{{- if semverCompare ">=1.21-0" .Capabilities.KubeVersion.GitVersion }}
{{- .Values.global.jwtPolicy | default "third-party-jwt" }}
{{- else }}
{{- print "first-party-jwt" }}
{{- end }}
{{- end }}

{{- define "skywalking.enabled" -}}
{{- if and (hasKey .Values "tracing") .Values.tracing.enable (hasKey .Values.tracing "skywalking") .Values.tracing.skywalking.service }}
true
{{- end }}
{{- end }}

{{- define "gateway.podMonitor.gvk" -}}
{{- if eq .Values.gateway.metrics.provider "monitoring.coreos.com" -}}
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
{{- else if eq .Values.gateway.metrics.provider "operator.victoriametrics.com" -}}
apiVersion: operator.victoriametrics.com/v1beta1
kind: VMPodScrape
{{- else -}}
{{- fail "unexpected gateway.metrics.provider" -}}
{{- end -}}
{{- end -}}


{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "gateway.namespace" -}}
{{- .Release.Namespace -}}
{{- end -}}

{{- define "gateway.affinities.pods" -}}
  {{- if eq .type "soft" }}
    {{- include "gateway.affinities.pods.soft" . -}}
  {{- else if eq .type "hard" }}
    {{- include "gateway.affinities.pods.hard" . -}}
  {{- end -}}
{{- end -}}

{{- define "gateway.affinities.pods.soft" -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - podAffinityTerm:
      labelSelector:
        matchLabels: {{- (include "gateway.selectorLabels" .context) | nindent 10 }}
      namespaces:
        - {{ include "gateway.namespace" .context | quote }}
      topologyKey: kubernetes.io/hostname
    weight: 60
{{- end -}}


{{- define "gateway.affinities.pods.hard" -}}
requiredDuringSchedulingIgnoredDuringExecution:
  - labelSelector:
      matchLabels: {{- (include "gateway.selectorLabels" .context) | nindent 8 }}
    namespaces:
      - {{ include "gateway.namespace" .context | quote }}
    topologyKey: kubernetes.io/hostname
{{- end -}}



{{/*
Return a soft nodeAffinity definition
{{ include "common.affinities.nodes.soft" (dict "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "gateway.affinities.nodes.soft" -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - preference:
      matchExpressions:
        - key: {{ .key }}
          operator: In
          values:
            {{- range .values }}
            - {{ . | quote }}
            {{- end }}
    weight: 60
{{- end -}}

{{/*
Return a hard nodeAffinity definition
{{ include "common.affinities.nodes.hard" (dict "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "gateway.affinities.nodes.hard" -}}
requiredDuringSchedulingIgnoredDuringExecution:
  nodeSelectorTerms:
    - matchExpressions:
        - key: {{ .key }}
          operator: In
          values:
            {{- range .values }}
            - {{ . | quote }}
            {{- end }}
{{- end -}}

{{/*
Return a nodeAffinity definition
{{ include "common.affinities.nodes" (dict "type" "soft" "key" "FOO" "values" (list "BAR" "BAZ")) -}}
*/}}
{{- define "gateway.affinities.nodes" -}}
  {{- if eq .type "soft" }}
    {{- include "gateway.affinities.nodes.soft" . -}}
  {{- else if eq .type "hard" }}
    {{- include "gateway.affinities.nodes.hard" . -}}
  {{- end -}}
{{- end -}}
