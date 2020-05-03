variable "api_server_url" {
  description = "the kube apiserver url"
  type        = string
}

variable "client_cert" {
  description = "the apiserver client certificate"
  type        = string
}

variable "client_key" {
  description = "the apiserver client key"
  type        = string
}

variable "ca_crt" {
  description = "the apiserver cacert"
  type        = string
}

variable "service_account_name" {
  description = "run kubernetes jobs as this service account"
  type        = string
  default     = ""
}

variable "hyperkube_image" {
  type    = string
  default = "rancher/hyperkube"
}

variable "hyperkube_image_tag" {
  type    = string
  default = "v1.17.4-rancher1"
}

variable "vault_helm_repo" {
  default = "https://charts.jetstack.io"
}

variable "vault_version" {
  default = "0.12.0"
}

variable "initial_node_count" {
  default = 1
}

variable "tls_cert" {
  type = string
}

variable "tls_key" {
  type = string
}

variable "dns_zone_id" {
  type = string
}

variable "dns_domain_name" {
  type = string
}

variable "dns_name" {
  type = string
}

variable "ingress_lb_dns_name" {
  description = "The load balancer dns name"
  type        = string
}

variable "ingress_lb_zone_id" {
  description = "The ingress load balancer zone id"
  type        = string
}
