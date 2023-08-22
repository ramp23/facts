{{- define "helpers.capabilities.helmVersion" -}}
{{- if typeIs "string" .Capabilities.KubeVersion -}}
{{- "v2" -}}
{{- else -}}
{{- "v3" -}}
{{- end -}}
{{- end -}}

{{- define "helpers.capabilities.kubeVersion" -}}
{{- if .Values.global }}
{{- if .Values.global.kubeVersion }}
{{- .Values.global.kubeVersion -}}
{{- else }}
{{- if semverCompare "<3" (include "helpers.capabilities.helmVersion" $) -}}
{{- default .Capabilities.KubeVersion .Values.kubeVersion -}}
{{- else -}}
{{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
{{- end -}}
{{- end -}}
{{- else }}
{{- if .Capabilities.KubeVersion.Version -}}
{{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
{{- else -}}
{{- default .Capabilities.KubeVersion .Values.kubeVersion -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "helpers.capabilities.cronJob.apiVersion" -}}
{{- if semverCompare "<1.21-0" (include "helpers.capabilities.kubeVersion" $) -}}
{{- print "batch/v1beta1" -}}
{{- else -}}
{{- print "batch/v1" -}}
{{- end -}}
{{- end -}}

{{- define "helpers.capabilities.deployment.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "helpers.capabilities.kubeVersion" $) -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{- define "helpers.capabilities.statefulset.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "helpers.capabilities.kubeVersion" $) -}}
{{- print "apps/v1beta1" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{- define "helpers.capabilities.ingress.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "helpers.capabilities.kubeVersion" $) -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19-0" (include "helpers.capabilities.kubeVersion" $) -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end }}
{{- end -}}

{{- define "helpers.capabilities.pdb.apiVersion" -}}
{{- if semverCompare "<1.21-0" (include "helpers.capabilities.kubeVersion" $) -}}
{{- print "policy/v1beta1" -}}
{{- else -}}
{{- print "policy/v1" -}}
{{- end -}}
{{- end -}}

{{- define "helpers.capabilities.istio.apiVersion" -}}
{{- if semverCompare "<1.21-0" (include "helpers.capabilities.kubeVersion" $) -}}
{{- print "install.istio.io/v1alpha1" -}}
{{- else -}}
{{- print "networking.istio.io/v1alpha3" -}}
{{- end }}
{{- end -}}

{{- define "helpers.capabilities.keda.apiVersion" -}}
{{- if semverCompare "<1.16-0" (include "helpers.capabilities.kubeVersion" $) -}}
{{- print "keda.sh/v1alpha1" -}}
{{- else -}}
{{- print "keda.sh/v1alpha1" -}}
{{- end }}
{{- end -}}