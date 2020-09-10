variable "name" {
  description = "A unique name applied to all resources"
  type        = string
}

variable "vault_create_approle_auth_role" {
  description = "Creates vault approle role"
  type        = bool
  default     = true
}

variable "vault_create_pki_secret_backend_role" {
  description = "Creates the pki secret back end role"
  type        = bool
  default     = true
}

variable "vault_create_ssh_secret_backend_role" {
  description = "Creates the pki secret back end role"
  type        = bool
  default     = false
}

variable "vault_count_approle_wrapping_tokens" {
  description = "The number of wrapping tokens to generate"
  type        = number
  default     = 1
}

variable "vault_kv_paths" {
  description = "A list of Vault KV allowed paths."
  type        = list(string)
  default     = []
}

variable "vault_pki_secret_backend_path" {
  description = "The PKI secret backend mount path"
  type        = string
  default     = "pki"
}

variable "vault_pki_role_key_bits" {
  description = "The PKI role key length"
  type        = number
  default     = 4096
}

variable "vault_pki_role_key_usage" {
  description = "The PKI role key usages"
  type        = list(string)
  default     = [
    "DigitalSignature",
    "KeyAgreement",
    "KeyEncipherment"
  ]
}

variable "vault_pki_role_allowed_domains" {
  description = "A list of allowed domains for certificates"
  type        = list(string)
  default     = ["foo.bar"]
}

variable "vault_pki_role_organization" {
  description = "The pki role organization name"
  type        = list(string)
  default     = ["my organization"]
}

variable "vault_ssh_secret_backend_path" {
  description = "The SSH secret backend mount path"
  type        = string
  default     = "ssh-client-signer"
}

variable "vault_approle_auth_backend_path" {
  description = "the approle backend mount path"
  type        = string
  default     = "approle"
}

variable "vault_approle_secret_metadata" {
  description = "A map of metadata key-value pairs set on tokens issued with the secret id"
  type        = map(string)
  default     = {}
}

variable "vault_token_policies" {
  description = "A list of existing token polciies associated to the vault role"
  type        = list(string)
  default     = []
}
