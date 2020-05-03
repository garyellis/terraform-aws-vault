resource "vault_auth_backend" "aws" {
  path        = var.vault_auth_backend_path
  description = var.vault_auth_backend_description
  type        = "aws"

  tune {
    default_lease_ttl            = "1h"
    max_lease_ttl               = "12h"
  }
}

resource "vault_aws_auth_backend_client" "aws_client" {
  backend    = var.vault_auth_backend_path
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  iam_server_id_header_value = var.vault_server_dns_name
}

resource "vault_aws_auth_backend_role" "role" {
  backend                         = vault_auth_backend.aws.path
  role                            = var.vault_role_name
  auth_type                       = "iam"
  inferred_aws_region             = var.aws_region
  inferred_entity_type            = "ec2_instance"
  bound_iam_role_arns             = var.aws_iam_role_arns
  bound_iam_instance_profile_arns = var.aws_iam_instance_profile_arns
  token_policies                  = var.vault_token_policies
}
