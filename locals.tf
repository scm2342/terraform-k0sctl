locals {
  k0sctl_yaml = templatefile("${path.module}/k0sctl.yaml.tmpl", {
    clustername = var.clustername
    controller_addrs = var.controller_addrs
    worker_addrs = var.worker_addrs
    controller_worker_addrs = var.controller_worker_addrs
    version = var.k0s_version
    kubeapiIp = var.kubeapiIp
    worker_install_flags = var.worker_install_flags
    extra_sans = var.extra_sans
    airgapped_images = var.airgapped_images
  })
}
