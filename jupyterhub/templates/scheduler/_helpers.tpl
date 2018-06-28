{{- /*
Renders the kube-scheduler's image based on .Values.scheduler.name and
optionally on .Values.scheduler.tag. The default tag is set to the clusters
kubernetes version.
*/}}
{{- define "jupyterhub.scheduler.image" -}}
{{- $name := .Values.scheduler.image.name -}}
{{- $valuesVersion := .Values.scheduler.image.tag -}}
{{- $clusterVersion := (split "-" .Capabilities.KubeVersion.GitVersion)._0 -}}
{{- $tag := $valuesVersion | default $clusterVersion -}}
{{ $name }}:{{ $tag }}
{{- end }}
