data "vault_policy_document" "app" {
  dynamic "rule" {
    for_each = var.vault_kv_paths
    content {
      description  = format("%s kv read", var.name)
      path         = rule.value
      capabilities = ["read", "list"]
    }
  }

  rule {
    path         = format("%s/issue/%s", var.vault_pki_secret_backend_path, var.name)
    capabilities = ["create", "read", "update"]
    description  = format("%s issue certificates", var.name)
  }

  rule {
    path         = format("%s/sign/%s", var.vault_ssh_secret_backend_path, var.name)
    capabilities = ["create", "read", "update"]
    description  = format("%s sign ssh public ssh keys", var.name)
  }
}

resource "vault_policy" "app" {
  name   = var.name
  policy = data.vault_policy_document.app.hcl
}

resource "vault_pki_secret_backend_role" "app" {
  count = var.vault_create_pki_secret_backend_role ? 1 : 0

  backend           = var.vault_pki_secret_backend_path
  name              = var.name
  key_bits          = var.vault_pki_role_key_bits
  key_usage         = var.vault_pki_role_key_usage
  organization      = var.vault_pki_role_organization
  allow_any_name    = true
  allowed_domains   = var.vault_pki_role_allowed_domains
  allow_ip_sans     = true
  require_cn        = true
  enforce_hostnames = false
}


resource "vault_ssh_secret_backend_role" "app" {
  count = var.vault_create_ssh_secret_backend_role ? 1 : 0

  name                    = var.name
  backend                 = var.vault_ssh_secret_backend_path
  key_type                = "ca"
  allow_user_certificates = true
  default_extensions = {
    "permit-pty" = ""
  }
}

#### approle auth method
resource "vault_approle_auth_backend_role" "app" {
  count = var.vault_create_approle_auth_role ? 1 : 0

  backend   = var.vault_approle_auth_backend_path
  role_name = var.name
  token_policies = compact(concat(
    list("default", vault_policy.app.name),
    var.vault_token_policies
  ))
  token_type = "default"
}


resource "vault_approle_auth_backend_role_secret_id" "app" {
  count = var.vault_create_approle_auth_role ? var.vault_count_approle_wrapping_tokens : 0

  backend      = var.vault_approle_auth_backend_path
  role_name    = join("", vault_approle_auth_backend_role.app.*.role_name)
  wrapping_ttl = "30m"
  metadata     = <<EOT
${jsonencode(var.vault_approle_secret_metadata)}
EOT

  lifecycle {
    create_before_destroy = true
  }
}
