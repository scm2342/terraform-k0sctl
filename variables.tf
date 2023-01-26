variable "clustername" {
  type = string
  default = "k0s"
}
variable "k0s_version" {
  type = string
  default = "1.24.9+k0s.0"
}
variable "kubeapiIp" {
  type = string
}
variable "controller_addrs" {
  type = list(object({
    addr = string
    private_interface = string
  }))
  default = []
}
variable "worker_addrs" {
  type = list(object({
    addr = string
    private_interface = string
  }))
  default = []
}
variable "controller_worker_addrs" {
  type = list(object({
    addr = string
    private_interface = string
  }))
  default = []
}
variable "worker_install_flags" {
  type = list(string)
  default = []
}
variable "extra_sans" {
  type = list(string)
  default = []
}
variable "kubeapiIpPublicOverride" {
  default = null
}
variable "airgapped_images" {
  default = false
}
