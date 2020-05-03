variable "vault_auth_backend_path" {
  type    = string
  default = "aws"
}

variable "vault_auth_backend_description" {
  type    = string
  default = "aws auth backend"
}

variable "vault_server_dns_name" {
  description = "Configure the X-Vault-AWS-IAM-Server-ID value"
  type        = string
}

variable "aws_access_key" {
  description = "the vault aws auth method aws access key for on-premesis vault"
  type        = string
  default     = null
}

variable "aws_secret_key" {
  description = "the vault aws auth method aws secret key for on-premesis vault"
  type        = string
  default     = null
}


#### role configuration
variable "vault_role_name" {
  description = "the vault aws auth method role name"
  type        = string
}

variable "aws_region" {
  description = "the infered aws region"
  type        = string
  default     = "us-west-2"
}

variable "aws_iam_role_arns" {
  description = "a list of iam roles bound to the vault aws auth method role"
  type        = list(string)
  default     = []
}

variable "aws_iam_instance_profile_arns" {
  description = "a list of iam instance profiles bound to the vault aws auth method role"
  type        = list(string)
  default     = []
}

variable "vault_token_policies" {
  description = "A list of existing token polciies associated to the vault role"
  type        = list(string)
  default     = []
}
