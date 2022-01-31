resource "local_file" "k0sctl_yaml" {
  content = local.k0sctl_yaml
  filename = "/tmp/k0sctl.yaml"
}
resource "null_resource" "k0sctl_apply" {
  provisioner "local-exec" {
    command = "k0sctl apply -c /tmp/k0sctl.yaml"
  }
  depends_on = [local_file.k0sctl_yaml]
}
data "external" "k0sctl_apply" {
  program = ["${path.module}/k0sctl_kubeconfig.sh"]
  query = {
    public_ip = var.kubeapiIp
  }

  depends_on = [null_resource.k0sctl_apply, local_file.k0sctl_yaml]
}
