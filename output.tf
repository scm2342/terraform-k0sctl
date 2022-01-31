output "k0sctl_yaml" {
  value = local.k0sctl_yaml
}
output "kubeconfig" {
  value = data.external.k0sctl_apply.result.kubeconfig
}
output "kubeconfig_base64" {
  value = data.external.k0sctl_apply.result.kubeconfig_base64
}
output "cluster_ca_certificate" {
  value = data.external.k0sctl_apply.result.cluster_ca_certificate
}
output "client_certificate" {
  value = data.external.k0sctl_apply.result.client_certificate
}
output "client_key" {
  value = data.external.k0sctl_apply.result.client_key
}
