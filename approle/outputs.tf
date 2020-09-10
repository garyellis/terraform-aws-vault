output "role_id" {
  value = join("", vault_approle_auth_backend_role.app.*.role_id)
}

output "secret_id_response_wrapping_path" {
  value = format("%s/secret-id", join("", vault_approle_auth_backend_role.app.*.id))
}

output "wrapping_tokens" {
  value = compact(split(",", join(",", vault_approle_auth_backend_role_secret_id.app.*.wrapping_token)))
}

output "wrapping_accessor" {
  value = join("", vault_approle_auth_backend_role_secret_id.app.*.wrapping_accessor)
}

output "pki_secret_backend_role_name" {
  value = join("", vault_pki_secret_backend_role.app.*.name)
}

output "ssh_secret_backend_role_name" {
  value = join("", vault_ssh_secret_backend_role.app.*.name)
}
