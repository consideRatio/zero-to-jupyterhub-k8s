{{- /*
  jupyterhub.userTolerations
    Lists the tolerations for node taints that the user pods should have
*/}}
{{- define "jupyterhub.userTolerations" -}}
- key: hub.jupyter.org_dedicated
  operator: Equal
  value: user
  effect: NoSchedule
- key: hub.jupyter.org/dedicated
  operator: Equal
  value: user
  effect: NoSchedule
{{- if .Values.singleuser.extraTolerations -}}
{{- .Values.singleuser.extraTolerations | toYaml | trimSuffix "\n" | nindent 0 }}
{{- end }}
{{- end }}



{{- define "jupyterhub.prepareScope" -}}
{{- $dummy := set . "nodeAffinityRequired" (include "jupyterhub.nodeAffinityRequired" .) }}
{{- $dummy := set . "podAffinityRequired" (include "jupyterhub.podAffinityRequired" .) }}
{{- $dummy := set . "podAntiAffinityRequired" (include "jupyterhub.podAntiAffinityRequired" .) }}
{{- $dummy := set . "nodeAffinityPreferred" (include "jupyterhub.nodeAffinityPreferred" .) }}
{{- $dummy := set . "podAffinityPreferred" (include "jupyterhub.podAffinityPreferred" .) }}
{{- $dummy := set . "podAntiAffinityPreferred" (include "jupyterhub.podAntiAffinityPreferred" .) }}
{{- $dummy := set . "hasNodeAffinity" (or .nodeAffinityRequired .nodeAffinityPreferred) }}
{{- $dummy := set . "hasPodAffinity" (or .podAffinityRequired .podAffinityPreferred) }}
{{- $dummy := set . "hasPodAntiAffinity" (or .podAntiAffinityRequired .podAntiAffinityPreferred) }}
{{- $dummy := set . "hasAffinity" (or .hasNodeAffinity .hasPodAffinity .hasPodAntiAffinity) }}
{{- end }}



{{- define "jupyterhub.nodeAffinityRequired" -}}
{{- if .Values.singleuser.extraNodeAffinity.required -}}
{{- .Values.singleuser.extraNodeAffinity.required | toYaml | trimSuffix "\n" | nindent 0 }}
{{- end }}
{{- end }}

{{- define "jupyterhub.nodeAffinityPreferred" -}}
{{- if .Values.singleuser.extraNodeAffinity.preferred -}}
{{- .Values.singleuser.extraNodeAffinity.preferred | toYaml | trimSuffix "\n" | nindent 0 }}
{{- end }}
{{- end }}

{{- define "jupyterhub.podAffinityRequired" -}}
{{- if eq .podKind "core" -}}
{{- else if eq .podKind "user" -}}
{{- if .Values.singleuser.extraPodAffinity.required }}
{{- .Values.singleuser.extraPodAffinity.required | toYaml | trimSuffix "\n" | nindent 0 }}
{{- end }}
{{- end }}
{{- end }}

{{- define "jupyterhub.podAffinityPreferred" -}}
{{- if eq .podKind "core" -}}
{{- else if eq .podKind "user" -}}
{{- if .Values.singleuser.extraPodAffinity.preferred -}}
{{- .Values.singleuser.extraPodAffinity.preferred | toYaml | trimSuffix "\n" | nindent 0 }}
{{- end }}
{{- end }}
{{- end }}

{{- define "jupyterhub.podAntiAffinityRequired" -}}
{{- if eq .podKind "core" -}}
{{- else if eq .podKind "user" -}}
{{- if .Values.singleuser.extraPodAntiAffinity.required -}}
{{- .Values.singleuser.extraPodAntiAffinity.required | toYaml | trimSuffix "\n" | nindent 0 }}
{{- end }}
{{- end }}
{{- end }}

{{- define "jupyterhub.podAntiAffinityPreferred" -}}
{{- if eq .podKind "core" -}}
{{- else if eq .podKind "user" -}}
{{- if .Values.singleuser.extraPodAntiAffinity.preferred -}}
{{- .Values.singleuser.extraPodAntiAffinity.preferred | toYaml | trimSuffix "\n" | nindent 0 }}
{{- end }}
{{- end }}
{{- end }}



{{- /*
  input: podKind
*/}}
{{- define "jupyterhub.affinity" -}}
{{- if .hasAffinity -}}
affinity:
  {{- if .hasNodeAffinity }}
  nodeAffinity:
    {{- if .nodeAffinityRequired }}
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
        {{- .nodeAffinityRequired | nindent 8 }}
    {{- end }}

    {{- if .nodeAffinityPreferred }}
    preferredDuringSchedulingIgnoredDuringExecution:
      {{- .nodeAffinityPreferred | nindent 6 }}
    {{- end }}
  {{- end }}

  {{- if .hasPodAffinity }}
  podAffinity:
    {{- if .podAffinityRequired }}
    requiredDuringSchedulingIgnoredDuringExecution:
      {{- .podAffinityRequired | nindent 6 }}
    {{- end }}

    {{- if .podAffinityPreferred }}
    preferredDuringSchedulingIgnoredDuringExecution:
      {{- .podAffinityPreferred | nindent 6 }}
    {{- end }}
  {{- end }}

  {{- if .hasPodAntiAffinity }}
  podAntiAffinity:
    {{- if .podAntiAffinityRequired }}
    requiredDuringSchedulingIgnoredDuringExecution:
      {{- .podAntiAffinityRequired | nindent 6 }}
    {{- end }}

    {{- if .podAntiAffinityPreferred }}
    preferredDuringSchedulingIgnoredDuringExecution:
      {{- .podAntiAffinityPreferred | nindent 6 }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
