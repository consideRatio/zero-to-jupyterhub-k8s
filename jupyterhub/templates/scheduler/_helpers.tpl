{{- /*
Renders the kube-scheduler's image based on .Values.scheduling.jupyterhubScheduler.name and
optionally on .Values.scheduling.jupyterhubScheduler.tag. The default tag is set to the clusters
kubernetes version.
*/}}
{{- define "jupyterhub.scheduler.image" -}}
{{- $name := .Values.scheduling.jupyterhubScheduler.image.name -}}
{{- $valuesVersion := .Values.scheduling.jupyterhubScheduler.image.tag -}}
{{- $clusterVersion := (split "-" .Capabilities.KubeVersion.GitVersion)._0 -}}
{{- $tag := $valuesVersion | default $clusterVersion -}}
{{ $name }}:{{ $tag }}
{{- end }}
