{{- define "helpers.version.version" -}}
{{- $cmver := "" -}}
{{- range $index, $cm := (lookup "v1" "ConfigMap" $.Release.Namespace "").items -}}
{{- if regexMatch "api-versions-([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})" $cm.metadata.name -}}
{{- if or $cmver (lt $cmver $cm.metadata.name) -}}
{{- $cmver = $cm.metadata.name -}} 
{{- end -}}
{{- end -}}
{{- end -}} 
{{- if $cmver -}}
{{- $prev_cm := (lookup "v1" "ConfigMap" $.Release.Namespace $cmver) -}}
{{- print (get $prev_cm.data "CURRENT_VERSION") -}}
{{- end -}}
{{- end -}}