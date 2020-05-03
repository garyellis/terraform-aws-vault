provider "kubernetes" {
  host                   = var.api_server_url
  client_certificate     = var.client_cert
  client_key             = var.client_key
  cluster_ca_certificate = var.ca_crt
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = var.api_server_url
    client_certificate     = var.client_cert
    client_key             = var.client_key
    cluster_ca_certificate = var.ca_crt
    load_config_file       = false
  }
}

resource "kubernetes_namespace" "consul" {
  metadata {
    name = "consul"
  }
}

resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
}

resource "helm_release" "consul" {

  name = "consul"
  # chart needs to be parameterized
  # repo for private helm repo capability needs to be added
  chart     = "https://github.com/hashicorp/consul-helm/archive/v0.20.1.tar.gz"
  namespace = kubernetes_namespace.consul.metadata.0.name

  values = [
    templatefile("${path.module}/consul-values.tmpl", { replicas = var.initial_node_count })
  ]
}



## tls cert
resource "kubernetes_secret" "vault-tls" {
  metadata {
    name      = "tls"
    namespace = "vault"
  }

  data = {
    "tls.crt" = file(var.tls_cert)
    "tls.key" = file(var.tls_key)
  }

  type = "kubernetes.io/tls"
}

resource "helm_release" "vault" {
  depends_on = [helm_release.consul]

  name      = "vault"
  # chart needs to be parameterized
  # repo for private helm repo capability needs to be added
  chart     = "https://github.com/hashicorp/vault-helm/archive/v0.5.0.tar.gz"
  namespace = kubernetes_namespace.vault.metadata.0.name

  values = [
    # kms cmk and auto unseal config needs to be implemented
    templatefile("${path.module}/vault-values.tmpl", { 
      replicas         = var.initial_node_count 
      ingress_hostname = var.dns_name
      ingress_secret_name = kubernetes_secret.vault-tls.metadata.0.name
    })
  ]
}

data "kubernetes_service" "vault_svc" {
  depends_on = [
    helm_release.vault
  ]

  metadata {
    namespace = "vault"
    name      = "vault-ui"
  }
}

## route53 record
resource "aws_route53_record" "vault" {
  zone_id = var.dns_zone_id
  name    = var.dns_name
  type    = "A"

  alias {
    name     = var.ingress_lb_dns_name
    zone_id  = var.ingress_lb_zone_id
    evaluate_target_health = false
  }
}
