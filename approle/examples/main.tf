provider "vault" {}

locals {
  name = "vault-approle-example"
}

module "vault_approle" {
  source = "../"

  name                                = local.name
  vault_count_approle_wrapping_tokens = 5
  vault_kv_paths                      = ["/secrets/data/foo/bar"]
  vault_pki_role_allowed_domains      = ["foo.int", "foo.cloud", "foo.bar"]
  vault_approle_secret_metadata       = { "foo" = "bar", "foo2" = "bar2" }
}

output "role_id" {
  value = module.vault_approle.role_id
}

output "secret_id_response_wrapping_path" {
  value = module.vault_approle.secret_id_response_wrapping_path
}

output "wrapping_tokens" {
  value = module.vault_approle.wrapping_tokens
}

output "pki_secret_backend_role_name" {
  value = module.vault_approle.pki_secret_backend_role_name
}
